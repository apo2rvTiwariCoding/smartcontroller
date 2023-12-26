#ifndef FILE_HAL_DEV_HTU21D_H
#define FILE_HAL_DEV_HTU21D_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/bus.h"
#include "hal/dev/device.h"


namespace Hal
{
namespace Dev
{

/**
 * @brief HTU21D (temperature and humidity) sensor.
 */
class THtu21D : public TDevice
{
public:
    typedef ::std::shared_ptr< THtu21D > TPtr;

    /**
     * @throw ::std::system_error
     */
    static TPtr Instance();

private:
    THtu21D();

    typedef ::std::weak_ptr< THtu21D > TWPtr;
    static TWPtr s_instance;

public:
    virtual ~THtu21D() noexcept;


public:
    /// Default sensor address
    static const unsigned DEFAULT_ADDRESS = 0x40;
    /// Default measurement acquisition timeout
    static const unsigned DEFAULT_TIMEOUT = 100; // ms

    /**
     * @brief It synchronically obtains the current temperature.
     * @throw TException
     */
    float ReadTemperature();

    /**
     * @brief It synchronically obtains the current humidity.
     * @throw TException
     */
    float ReadHumidity();

private:
    const TBus::TPtr m_bus;

    /// @throw TException
    static void SendCommand(TBus::THandle& bus_handle, unsigned command);

    enum TMeasurement : unsigned
    {
        HUMIDITY = 0x0002
    };

    /// @throw TException
    unsigned GetMeasurement(unsigned command);

    static bool CheckCrc(const void* data, ::std::size_t size, 
        unsigned expected_crc) noexcept;

private: // TDevice
    virtual void OnConfigure();
}; // class THtu21D

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_HTU21D_H
