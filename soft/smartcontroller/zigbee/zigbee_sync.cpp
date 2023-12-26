// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <mutex>
#include <vector>
#include <thread>
#include <cassert>
#include <iostream>
#include <condition_variable>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "zigbee/zigbee_sync.h"
#include "util/log/log.h"
extern "C"
{
#include "zigbee/zigbee_ha.h"
}


//=============================================================================
// Private stuff
//=============================================================================


static const char *const s_log_section = "zigbee";
static ::std::mutex s_mutex;
typedef ::std::unique_lock< ::std::mutex > TUniqueLock;

/// List of currently discovered devices
static TZigbeeDevices s_devices; // TODO: do we need it?

static TOnJoinDisallowedCB s_join_disallowed_cb;


//=============================================================================
// ZigBee servers handlers related code
//=============================================================================


/// Common stuff that does not depend on template arguments
class TAsyncFunctionCompleteBase
{
protected:
    /// Calback timeout
    static const ::std::chrono::seconds TIMEOUT;
    static ::std::condition_variable s_callback;
};
const ::std::chrono::seconds TAsyncFunctionCompleteBase::TIMEOUT(10);
::std::condition_variable TAsyncFunctionCompleteBase::s_callback;


/**
 * @brief It waits for asynchronous functions completion.
 */
template< typename R >
class TAsyncFunctionComplete : public TAsyncFunctionCompleteBase
{
public:
    typedef R TResult;

    TAsyncFunctionComplete() : m_notified(false) {}


    void Notify(::std::mutex& mutex, TResult&& result)
      {
          ::std::lock_guard< ::std::mutex > lock(mutex);
          m_result = ::std::move(result);
          m_valid = true;
          m_notified = true;
          s_callback.notify_all();
      }

    void Notify(::std::mutex& mutex, const TResult& result)
      {
          ::std::lock_guard< ::std::mutex > lock(mutex);
          m_result = result;
          m_valid = true;
          m_notified = true;
          s_callback.notify_all();
      }

    void NotifyInvalid(::std::mutex& mutex)
      {
          ::std::lock_guard< ::std::mutex > lock(mutex);
          m_valid = false;
          m_notified = true;
          s_callback.notify_all();
      }

    inline bool Wait(TUniqueLock& lock)
      {
          return s_callback.wait_for(lock, TIMEOUT,
                  [this]()->bool { return m_notified; });
      }


    inline bool IsNotified() const noexcept { return m_notified; }
    inline bool IsValid() const noexcept { return m_valid; }

    void ClearNotification(const TUniqueLock&) { m_notified = false; }

    TResult Get(const TUniqueLock&)
      {
          m_valid = false;
          m_notified = false;
          return ::std::move(m_result);
      }

private:
    bool m_notified;
    bool m_valid;
    TResult m_result;
}; // struct TAsyncFunctionComplete


/// It holds devices list.
struct TOnDevicesList
{
    TOnDevicesList() = default;
    TOnDevicesList(int devices_count, const device_info_t* devices_info)
      {
          m_devices.reserve(devices_count);
          for(int i = 0; i < devices_count; i++)
          {
              m_devices.push_back(devices_info[i]);
          }
      }

    TZigbeeDevices m_devices;
}; // struct TOnDevicesList

static TAsyncFunctionComplete< TOnDevicesList > s_on_device_list;

//-----------------------------------------------------------------------------
static void OnDevicesList(int devices_count, const device_info_t* devices_info)
{
    if (devices_info)
    {
        s_on_device_list.Notify(s_mutex,
                TOnDevicesList(devices_count, devices_info));
    }
    else
    {
        s_on_device_list.NotifyInvalid(s_mutex);
    }
}


static TAsyncFunctionComplete< TZigbeeAttributes > s_on_device_attributes;

//-----------------------------------------------------------------------------
static void OnDeviceAttributes(const attribute_info_t* attributes)
{
    if (attributes)
    {
        TZigbeeAttributes list;
        for(unsigned i = 0; i < MAX_ATTRIBUTES; i++)
        {
            if (attributes[i].valid)
            {
                list.push_back(attributes[i]);
            }
        }

        s_on_device_attributes.Notify(s_mutex, ::std::move(list));
    }
    else
    {
        s_on_device_attributes.NotifyInvalid(s_mutex);
    }
}


static TAsyncFunctionComplete< bool > s_on_ha_data_sent;

//-----------------------------------------------------------------------------
static void OnHaDataSend(unsigned long long ieee_addr,
        unsigned char endpoint, unsigned char status, unsigned int result)
{
    s_on_ha_data_sent.Notify(s_mutex, status);
}


static TAsyncFunctionComplete< unsigned > s_on_ha_data_received;

//-----------------------------------------------------------------------------
static void OnHaDataReceived(unsigned long long ieee_addr,
        unsigned char endpoint, unsigned char status, unsigned int result)
{
    s_on_ha_data_received.Notify(s_mutex, result);
}


//=============================================================================
// Private functions
//=============================================================================


//-----------------------------------------------------------------------------
static int SyncReadBasicCluster(TUniqueLock& lock,
        unsigned long long ieee_address, TZigbeeAttributes& attributes)
{
    s_on_device_attributes.ClearNotification(lock); // just in case
    const int ret = ReadBasicCluster(ieee_address);
    switch(ret)
    {
    case API_RETVAL_SUCCESS:
        break;

    case API_RETVAL_NWK_NOT_FORMED:
    case API_RETVAL_INVALID_PARAM:
    default:
        LOG_ERROR_FMT(s_log_section, "Failed to read device "
                "(ieee address = %llX) basic cluster (err = %i).",
                ieee_address, ret);
        return -1;
    }

    if (!s_on_device_attributes.Wait(lock))
    {
        LOG_ERROR_FMT(s_log_section, "Failed to read device "
                "(ieee address = %llX) basic cluster (timed out - no callback).",
                ieee_address, ret);
        return -1;
    }

    if (s_on_device_attributes.IsValid())
    {
        attributes = s_on_device_attributes.Get(lock);
#if 0 // TODO
        ::std::cout << attributes.attr_id << '\n'
                    << static_cast< int >(attributes.attr_type) << '\n'
                    //<< static_cast< int >(attributes.attr_val) << '\n'
                    << static_cast< int >(attributes.valid) << '\n';
#endif
    }
    else
    {
        LOG_ERROR_FMT(s_log_section, "Failed to read device "
                "(ieee address = %llX) basic cluster (attributes are missing).",
                ieee_address, ret);

        return -1;
    }

    return 0;
}


//=============================================================================
// Public functions
//=============================================================================


//-----------------------------------------------------------------------------
int ZigbeeSyncInitialize(NetworkZigBeeDeviceIndCB join_leave_device_ind,
        CustomDataReceivedCB device_attributes,
        TOnJoinDisallowedCB join_disallowed)
{
    TUniqueLock lock(s_mutex);


    RegisterNetworkZigBeeDeviceIndCB(join_leave_device_ind);
    RegisterNetworkZigBeeGetDeviceListCB(OnDevicesList);
    RegisterCustomDataReceivedCB(device_attributes);
    RegisterReadAttribCB(OnDeviceAttributes);
    s_join_disallowed_cb = join_disallowed;


    s_on_device_list.ClearNotification(lock); // just in case

    const int ret = InitializeZigBee();
    switch(ret)
    {
    case API_RETVAL_SUCCESS:
        break;

    case API_RETVAL_ALREAY_INITIALIZED:
        assert(!"already initialized");
        return -1;

    default:
    case API_RETVAL_FAIL_TO_OPEN_CONFIG_FILE:
    case API_RETVAL_FAIL_TO_CREATE_THREAD:
        LOG_ERROR_FMT(s_log_section, "Failed to initialize Zigbee (err = %i).",
                ret);
        return -1;
    }

    if (!s_on_device_list.Wait(lock))
    {
        LOG_ERROR(s_log_section, "Failed to initialize Zigbee "
                "(timed out - no callback).");
        return -1;
    }

    if (s_on_device_list.IsValid())
    {
        s_devices = ::std::move(s_on_device_list.Get(lock).m_devices);
    }
    else
    {
        LOG_ERROR(s_log_section, "Failed to initialize Zigbee "
                "(could not find GW device).");
        return -1;
    }
    assert(s_devices.size());

#if 0
    for(const device_info_t& device : s_devices)
    {
        ::std::cout << "==\n"
                    << static_cast< int>(device.device_status) << '\n'
                    << device.nwk_addr << '\n'
                    << device.ieee_addr << '\n'
                    << device.manufacturer_id << '\n';
    }
#endif

    return 0;
}

//-----------------------------------------------------------------------------
int ZigbeeSyncCreateNetwork(unsigned& channels, unsigned& pan_id,
        TGwDeviceInfo& device_info)
{
    TUniqueLock lock(s_mutex);


    // NOTE: it returns actual channel and PAN
    int ret = CreateZigBeeNetwork(&channels, &pan_id);
    switch(ret)
    {
    case API_RETVAL_SUCCESS:
        break;

    case API_RETVAL_NWK_ALREADY_STARTED:
        LOG_INFO(s_log_section, "The network is already created.");
        break;

    case API_RETVAL_NWK_PARAM_MISMATCH:
        LOG_INFO(s_log_section, "The network is already formed with different "
                "configuration.");
        return -1;

    case API_RETVAL_SERVERS_NOT_RESPONDING:
    case API_RETVAL_SERVERS_NOT_RUNNING:
    case API_RETVAL_FAIL_TO_START_NWK:
    default:
        LOG_ERROR_FMT(s_log_section, "Failed to create network (err = %i).",
                ret);
        return -1;
    }


    assert(s_devices.size());

    device_info.m_ieee_address = s_devices[0].ieee_addr;
    device_info.m_network_address = s_devices[0].nwk_addr;
    device_info.m_mfc_id = s_devices[0].manufacturer_id;

#if 0 // skip it for now
    attribute_info_t attributes;
    if (0 == SyncReadBasicCluster(lock, s_devices[0].ieee_addr, attributes))
    {
        device_info.m_hw_ver = 0; // TODO
        device_info.m_fw_ver = 0; // TODO
    }
    else
    {
        LOG_WARN(s_log_section, "Failed to read GW device basic cluster.");
    }
#else
    device_info.m_hw_ver = 0;
    device_info.m_fw_ver = 0;
#endif

    return 0;
}

//-----------------------------------------------------------------------------
int ZigbeeSyncResetNetwork(bool hard)
{
    TUniqueLock lock(s_mutex);

    const int ret = ResetZigBeeNetwork(hard);
    switch(ret)
    {
    case API_RETVAL_SUCCESS:
        break;

    case API_RETVAL_INVALID_PARAM:
    case API_RETVAL_FAIL_TO_MEM_ALLOC:
    case API_RETVAL_STACK_LAYER_FAILURE:
    default:
        LOG_ERROR_FMT(s_log_section, "Failed to reset network "
                "(err = %i).", ret);
        return -1;
    }

    return 0;
}

//-----------------------------------------------------------------------------
int ZigbeeSyncGetDevicesList(TZigbeeDevices& devices)
{
    TUniqueLock lock(s_mutex);

    devices.clear();
    s_on_device_list.ClearNotification(lock); // just in case

    const int ret = GetZigBeeNetworkDeviceList();
    switch(ret)
    {
    case API_RETVAL_SUCCESS:
        break;

    case API_RETVAL_STACK_LAYER_FAILURE:
    case API_RETVAL_FAIL_TO_MEM_ALLOC:
    default:
        LOG_ERROR_FMT(s_log_section, "Failed to get devices list "
                "(err = %i).", ret);
        return -1;
    }

    if (!s_on_device_list.Wait(lock))
    {
        LOG_ERROR(s_log_section, "Failed to get devices list "
                "(timed out - no callback).");
        return -1;
    }

    if (s_on_device_list.IsValid())
    {
        devices = ::std::move(s_on_device_list.Get(lock).m_devices);
    }
    else
    {
        LOG_ERROR(s_log_section, "Failed to get devices list "
                "(obtained device list is invalid).");
        return -1;
    }

    return 0;
}

//-----------------------------------------------------------------------------
int ZigbeeSyncAllowDeviceJoin(bool allow, unsigned time)
{
    {
        TUniqueLock lock(s_mutex);

        const int ret = AllowDeviceJoin(allow, time);
        switch(ret)
        {
        case API_RETVAL_SUCCESS:
            break;

        case API_RETVAL_NWK_NOT_FORMED:
        case API_RETVAL_INVALID_PARAM:
        case API_RETVAL_SERVERS_NOT_RUNNING:
        case API_RETVAL_FAIL_TO_MEM_ALLOC:
        case API_RETVAL_STACK_LAYER_FAILURE:
        default:
            LOG_ERROR_FMT(s_log_section, "Failed to allow/disallow joining device "
                    "(err = %i).", ret);
            return -1;
        }
    }
    if (!allow && s_join_disallowed_cb)
    {
        s_join_disallowed_cb();
    }

    return 0;
}

//-----------------------------------------------------------------------------
int ZigbeeSyncRemoveDevice(unsigned long long ieee_address)
{
    TUniqueLock lock(s_mutex);

    const int ret = RemoveDevice(ieee_address);
    switch(ret)
    {
    case API_RETVAL_SUCCESS:
        return 0;

    case API_RETVAL_NWK_NOT_FORMED:
    case API_RETVAL_INVALID_PARAM:
    case API_RETVAL_STACK_LAYER_FAILURE:
    case API_RETVAL_FAIL_TO_MEM_ALLOC:
    default:
        LOG_ERROR_FMT(s_log_section, "Failed to remove the device "
                "(ieee address = %llX, err = %i).", ieee_address, ret);
        return -1;
    }
}

//-----------------------------------------------------------------------------
int ZigbeeSyncReadBasicCluster(unsigned long long ieee_address,
        TZigbeeAttributes& attributes)
{
    TUniqueLock lock(s_mutex);
    return SyncReadBasicCluster(lock, ieee_address, attributes);
}

//-----------------------------------------------------------------------------
int ZigbeeSyncSendOnOffReq(unsigned long long ieee_address, bool on)
{
    TUniqueLock lock(s_mutex);

    s_on_ha_data_sent.ClearNotification(lock); // just in case
    SendOnOffReq(ieee_address, on, OnHaDataSend);
    if (!s_on_ha_data_sent.Wait(lock))
    {
        LOG_ERROR(s_log_section, "Failed to send on/off request "
                "(timed out - no callback).");
        return -1;
    }

    if (!s_on_ha_data_sent.IsValid() || s_on_ha_data_sent.Get(lock))
    {
        LOG_ERROR(s_log_section, "Failed to send on/off request "
                "(NACK received).");
        return -1;
    }

    return 0;
}

//-----------------------------------------------------------------------------
int ZigbeeSyncReadOnOffAttrib(unsigned long long ieee_address, bool& on)
{
    TUniqueLock lock(s_mutex);

    s_on_device_attributes.ClearNotification(lock); // just in case
    const int ret = ReadOnOffAttrib(ieee_address);
    switch(ret)
    {
    case API_RETVAL_SUCCESS:
        break;

    case API_RETVAL_NWK_NOT_FORMED:
    case API_RETVAL_FAIL_TO_MEM_ALLOC:
    case API_RETVAL_STACK_LAYER_FAILURE:
    default:
        LOG_ERROR_FMT(s_log_section, "Failed to remove the device "
                "(ieee address = %llX, err = %i).", ieee_address, ret);
        return -1;
    }


    if (!s_on_device_attributes.Wait(lock))
    {
        LOG_ERROR_FMT(s_log_section, "Failed to read device "
                "(ieee address = %llX) on/off cluster (timed out - no callback).",
                ieee_address, ret);
        return -1;
    }

    TZigbeeAttributes attributes;
    if (s_on_device_attributes.IsValid())
    {
        attributes = s_on_device_attributes.Get(lock);
    }
    else
    {
        LOG_ERROR_FMT(s_log_section, "Failed to read device "
                "(ieee address = %llX) on/off cluster (attributes are missing).",
                ieee_address, ret);

        return -1;
    }

    for(const auto& attribute : attributes)
    {
        if (0x0000 == attribute.attr_id && 16 == attribute.attr_type)
        {
            on = attribute.attr_val[0];
            return 0;
        }
    }
    LOG_ERROR_FMT(s_log_section, "Failed to read device "
            "(ieee address = %llX) on/off cluster (failed to "
            "find the attribute).", ieee_address, ret);
    return -1;
}

//-----------------------------------------------------------------------------
int ZigbeeSyncReadSmartMeter(unsigned long long ieee_address, unsigned& value)
{
    TUniqueLock lock(s_mutex);

    s_on_ha_data_received.ClearNotification(lock); // just in case
    ReadSmartMeter(ieee_address, OnHaDataReceived);
    if (!s_on_ha_data_received.Wait(lock))
    {
        LOG_ERROR(s_log_section, "Failed to send read meter request "
                "(timed out - no callback).");
        return -1;
    }

    if (!s_on_ha_data_received.IsValid())
    {
        LOG_ERROR(s_log_section, "Failed to send read meter request "
                "(NACK received).");
        return -1;
    }

    value = s_on_ha_data_received.Get(lock);
    return 0;
}

//-----------------------------------------------------------------------------
int ZigbeeSyncSendGenericResp(unsigned long long ieee_address,
        unsigned message_len, const void* message)
{
    TUniqueLock lock(s_mutex);

    const int ret = SendGenRespPkt(ieee_address, message_len,
            static_cast< const char* >(message));
    switch(ret)
    {
    case API_RETVAL_SUCCESS:
        break;

    case API_RETVAL_NWK_NOT_FORMED:
    case API_RETVAL_INVALID_PARAM:
    case API_RETVAL_FAIL_TO_MEM_ALLOC:
    case API_RETVAL_STACK_LAYER_FAILURE:
    default:
        LOG_ERROR_FMT(s_log_section, "Failed to send a generic response to "
                "the device (ieee address = %llX, err = %i).",
                ieee_address, ret);
        return -1;
    }

    return 0;
}
