// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <cassert>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/i2c_ext/factory.h"
#include "hal/dev/i2c_ext/f400.h"


namespace Hal
{
namespace Dev
{
namespace I2cExt
{

//-----------------------------------------------------------------------------
TSensor::TUPtr TFactory::Create(TI2cDeviceType type)
{
    TSensor::TUPtr sensor;
    switch(type)
    {
    case TF400Velocity::TYPE:
        sensor.reset(new TF400Velocity());
        break;

    case TF400Temperature::TYPE:
        sensor.reset(new TF400Temperature());
        break;

    // default: compiler should generate warning if not all of the types are handled.
    }

    assert(sensor);
    return ::std::move(sensor);
}

} // namespace I2cExt
} // namespace Dev
} // namespace Hal
