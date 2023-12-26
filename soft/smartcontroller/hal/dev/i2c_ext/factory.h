#ifndef FILE_HAL_DEV_I2C_FACTORY_H
#define FILE_HAL_DEV_I2C_FACTORY_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/i2c_ext/sensor.h"


namespace Hal
{
namespace Dev
{
namespace I2cExt
{

/**
 * @brief Sensors factory.
 */
class TFactory
{
public:
    /**
     * @brief It constructs appropriate sensor object.
     */
    TSensor::TUPtr Create(TI2cDeviceType type);
}; // class TFactory

} // namespace I2cExt
} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_I2C_FACTORY_H
