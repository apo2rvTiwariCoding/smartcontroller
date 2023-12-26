// SYSTEM INCLUDES
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/i2c_ext/sensor.h"
#include "hal/errors.h"


namespace Hal
{
namespace Dev
{
namespace I2cExt
{

//-----------------------------------------------------------------------------
TSensor::TSensor(TI2cDeviceType type, int address)
    : m_type(type),
      m_address(address),
      m_bus(TBus::Instance())
{
}

} // namespace I2cExt
} // namespace Dev
} // namespace Hal
