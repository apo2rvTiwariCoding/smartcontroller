#ifndef FILE_HAL_DEV_I2C_EXT_SENSOR_H
#define FILE_HAL_DEV_I2C_EXT_SENSOR_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/hal.h"
#include "hal/dev/fwd.h"
#include "hal/dev/bus.h"
#include "hal/dev/device.h"


namespace Hal
{
namespace Dev
{
namespace I2cExt
{

/**
 * @brief An external I2C sensor device base class.
 */
class TSensor : public TDevice
{
public:
    typedef ::std::unique_ptr< TSensor > TUPtr;

protected:
    TSensor(TI2cDeviceType type, int address);

public:
    inline TI2cDeviceType Type() const noexcept { return m_type; }

    /**
     * @throw TException
     */
    inline void Probe() { OnProbe(); }

    /**
     * @throw TException
     */
    inline float ReadValue() { return OnReadValue(); }

private:
    const TI2cDeviceType m_type;

protected:
    const int m_address; ///< I2C address
    const TBus::TPtr m_bus;

private:
    virtual void OnProbe() = 0;
    virtual float OnReadValue() = 0;
}; // class TSensor

} // namespace I2cExt
} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_I2C_EXT_SENSOR_H
