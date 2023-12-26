/**
 * @brief ZigBee synchronous thread safe interface header.
 */

#ifndef FILE_ZIGBEE_ZIGBEE_SYNC_H
#define FILE_ZIGBEE_ZIGBEE_SYNC_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <vector>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
extern "C"
{
#include "zigbee/types.h"
#include "zigbee/zigbee.h"
#include "zigbee/zigbee_ha.h"
}


/// List of ZegBee devices.
typedef ::std::vector< device_info_t > TZigbeeDevices;
typedef ::std::vector< attribute_info_t > TZigbeeAttributes;
/// It gets invoked as join has been disallowed.
typedef void (*TOnJoinDisallowedCB)();


/**
 * @see InitializeZigBee
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncInitialize(NetworkZigBeeDeviceIndCB join_leave_device_ind,
        CustomDataReceivedCB device_attributes,
        TOnJoinDisallowedCB join_disallowed);


/// Gateway device info
struct TGwDeviceInfo
{
    static const unsigned long long INVALID_ADDRESS = -1;

    TGwDeviceInfo() noexcept
        : m_ieee_address(INVALID_ADDRESS)
      {}

    inline bool IsValid() const noexcept
      {
          return INVALID_ADDRESS != m_ieee_address;
      }

    unsigned long long m_ieee_address; ///< Zigbee radio MAC address (64-bit)
    unsigned m_network_address;   ///< Zigbee radio address (16-bit)
    unsigned m_mfc_id; ///< Zigbee radio manufacturer ID
    unsigned m_hw_ver; ///< Zigbee radio hardware version
    unsigned m_fw_ver; ///< Zigbee radio firmware version
}; // struct TGwDeviceInfo


/**
 * @see CreateZigBeeNetwork
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncCreateNetwork(unsigned& channels, unsigned& pan_id,
        TGwDeviceInfo& device_info);

/**
 * @see ResetZigBeeNetwork
 * @param hard
 * false = hard reset, true = soft reset
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncResetNetwork(bool hard);

/**
 * @see GetZigBeeNetworkDeviceList
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncGetDevicesList(TZigbeeDevices& devices);

/**
 * @see AllowDeviceJoin
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncAllowDeviceJoin(bool allow, unsigned time);

/**
 * @see RemoveDevice
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncRemoveDevice(unsigned long long ieee_address);

/**
 * @see ReadBasicCluster
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncReadBasicCluster(unsigned long long ieee_address,
        TZigbeeAttributes& attributes);


/**
 * @see SendOnOffReq
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncSendOnOffReq(unsigned long long ieee_address, bool on);

/**
 * @see ReadOnOffAttrib
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncReadOnOffAttrib(unsigned long long ieee_address, bool& on);

/**
 * @see ReadSmartMeter
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncReadSmartMeter(unsigned long long ieee_address, unsigned& value);

/**
 * @see SendGenRespPkt
 * @return 0 on success otherwise -1.
 */
int ZigbeeSyncSendGenericResp(unsigned long long ieee_address,
        unsigned message_len, const void* message);

#endif // #ifndef FILE_ZIGBEE_ZIGBEE_SYNC_H
