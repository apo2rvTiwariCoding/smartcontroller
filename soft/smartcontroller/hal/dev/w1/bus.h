#ifndef FILE_HAL_DEV_W1_BUS_H
#define FILE_HAL_DEV_W1_BUS_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>
#include <vector>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/w1/ds2482.h"
#include "hal/dev/device.h"
#include "hal/dev/w1/sensor.h"
#include "util/comm/endian.h"
#include "hal/hal.h"


namespace Hal
{
namespace Dev
{
namespace W1
{

/**
 * @brief 1-Wire bus.
 */
class TBus : public TDevice
{
public:
    typedef ::std::shared_ptr< TBus > TPtr;

    /**
     * @throw TException
     */
    static TPtr Instance();

private:
    TBus();

    typedef ::std::weak_ptr< TBus > TWPtr;
    static TWPtr s_instance;

public:
    virtual ~TBus() noexcept;

    static const ::Util::Comm::TEndian ENDIAN = ::Util::Comm::TEndian::LITTLE;


public:
    inline bool IsBusy() const noexcept { return m_busy; }


    /**
     * @brief It enumerates the devices on the bus and configures them.
     * @throw TException
     */
    void Enumerate();

    /// 1W sensors list.
    typedef ::std::vector< TSensor::TUPtr > TSensors;
    /// The list of detected devices on the bus.
    inline const TSensors& Sensors() const noexcept { return m_sensors; }


    /// It automatically relinquishes the control.
    class THandle
    {
    public:
        THandle(const THandle& ) = delete;
        THandle(THandle&& handle) noexcept;
        ~THandle() noexcept;

        inline void W1WriteByte(unsigned data)
          {
              m_bus->m_ds2482->W1WriteByte(data);
          }

        inline void W1WriteData(const void* data, ::std::size_t size)
          {
              m_bus->m_ds2482->W1WriteData(data, size);
          }

        inline unsigned W1ReadByte()
          {
              return m_bus->m_ds2482->W1ReadByte();
          }

        inline void W1ReadData(void* data, ::std::size_t size)
          {
              m_bus->m_ds2482->W1ReadData(data, size);
          }

    private:
        friend class TBus;
        THandle(TBus *const bus) : m_bus(bus) { assert(bus); }
        TBus* m_bus;
    }; // class THandle

    /**
     * @brief It selects the specified device and takes the control over the bus.
     * @note The bus gets reset beforehand.
     * @throw TException
     */
    THandle SelectDevice(const TW1DeviceAddress& address);


    static unsigned CalculateCrc(const void* data, ::std::size_t size);

private:
    /// 1-Wire translator (exclusive ownership)
    const TDs2482::TPtr m_ds2482;

    bool m_busy;
    inline void ReleaseControl() noexcept { m_busy = false; }


    /// Standard ROM codes
    enum TRomCode
    {
        SEARCH = 0xF0,
        READ = 0x33,
        MATCH = 0x55,
        SKIP = 0xCC,
        ALARM_SEARCH = 0xEC
    };

    class TEnumerator;
    TSensors m_sensors;

private: // TDevice
    virtual void OnConfigure();
}; // class TBus

} // namespace W1
} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_W1_BUS_H
