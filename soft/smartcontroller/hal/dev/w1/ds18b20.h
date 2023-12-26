#ifndef FILE_HAL_DEV_W1_DS18B20_H
#define FILE_HAL_DEV_W1_DS18B20_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/w1/sensor.h"
#include "hal/dev/keys.h"
#include "hal/hal.h"


namespace Hal
{
namespace Dev
{
namespace W1
{

/**
 * @brief 1-Wire temperature sensor (DS18B20).
 */
class TDs18B20 : public TSensor
{
public:
    typedef ::std::shared_ptr< TDs18B20 > TPtr;

    TDs18B20(const TSensorKey&, TBus& bus, const TW1DeviceAddress& address);
    virtual ~TDs18B20() noexcept;

public:
    static const unsigned FAMILY_CODE = 0x28;

private:
    enum TCommand
    {
        CONVERT = 0x44,
        WRITE_SCRATCHPAD = 0x4E,
        READ_SCRATCHPAD = 0xBE,
        COPY_SCRATCHPAD = 0x48,
        RECALL_E = 0xB8,
        READ_POWER_SUPPLY = 0xB4
    };

private: // TDevice
    static const unsigned DEFAULT_RESOLUTION = 9; // bits
    virtual void OnConfigure();

private: // TW1Sensor
    virtual float OnReadValue();

private:
    template< unsigned N > struct TResolutionTraits {};
    typedef TResolutionTraits< DEFAULT_RESOLUTION > TResolution;
    template< typename T > static float Convert(unsigned raw);
}; // class TDs18B20

} // namespace W1
} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_W1_DS18B20_H
