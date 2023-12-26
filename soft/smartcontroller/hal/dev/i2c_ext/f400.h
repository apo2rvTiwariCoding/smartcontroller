#ifndef FILE_HAL_DEV_I2C_EXT_F400_H
#define FILE_HAL_DEV_I2C_EXT_F400_H

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
 * @brief F400 (airflow) sensor.
 */
class TF400 : public TSensor
{
public:
    /// Default sensor address
    static const int DEFAULT_ADDRESS = 0x60;

    TF400(TI2cDeviceType type);

    /**
     * @throw TException
     */
    float ReadTemperature();

    /**
     * @throw TException
     */
    float ReadVelocity();

private:
    virtual void OnConfigure() {}
}; // class TF400


/**
 * @brief F400 sensor temperature.
 */
class TF400Temperature : public TF400
{
public:
    static const TI2cDeviceType TYPE = I2C_DEV_F400_TEMPERATURE;

    TF400Temperature()
        : TF400(TYPE)
      {}

private:
    virtual void OnProbe() {}
    virtual float OnReadValue() { return ReadTemperature(); }
}; // class TF400Temperature


/**
 * @brief F400 sensor velocity.
 */
class TF400Velocity : public TF400
{
public:
    static const TI2cDeviceType TYPE = I2C_DEV_F400_VELOCITY;

    TF400Velocity()
        : TF400(TYPE)
      {}

private:
    virtual void OnProbe() {}
    virtual float OnReadValue() { return ReadVelocity(); }
}; // class TF400Velocity

} // namespace I2cExt
} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_I2C_EXT_F400_H
