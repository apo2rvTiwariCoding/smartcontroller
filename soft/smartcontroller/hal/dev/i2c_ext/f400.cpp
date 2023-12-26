// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <cstdint>
#include <cstdlib>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/i2c_ext/f400.h"
#include "util/comm/buffer.h"


namespace Hal
{
namespace Dev
{
namespace I2cExt
{

using ::Util::Comm::TBuffer;
using ::Util::Comm::TEndian;


//-----------------------------------------------------------------------------
TF400::TF400(TI2cDeviceType type)
    : TSensor(type, DEFAULT_ADDRESS)
{
}

//-----------------------------------------------------------------------------
float TF400::ReadTemperature()
{
#ifndef SIM
    static const unsigned INDEX = 0x47;
    ::std::uint8_t cmd[] = { INDEX };

    TBuffer< sizeof(::std::uint16_t) > res;

    TBus::THandle bus_handle(m_bus->TakeControl(m_address));
    bus_handle.WriteRead(cmd, sizeof(cmd), res.Data(), res.Capacity());

    const float value = static_cast< float >(
        res.PopAs< ::std::uint16_t, TEndian::LITTLE >()) / 100;
    assert(res.Index() == res.Capacity());
    return value;
#else
    return (::std::rand() % 5) + 20;
#endif
}

//-----------------------------------------------------------------------------
float TF400::ReadVelocity()
{    
#ifndef SIM
    static const unsigned INDEX = 0x43;
    ::std::uint8_t cmd[] = { INDEX };

    TBuffer< sizeof(::std::uint16_t) > res;

    TBus::THandle bus_handle(m_bus->TakeControl(m_address));
    bus_handle.WriteRead(cmd, sizeof(cmd), res.Data(), res.Capacity());

    const float value = res.PopAs< ::std::uint16_t, TEndian::LITTLE >();
    assert(res.Index() == res.Capacity());
    return value;
#else
    return (::std::rand() % 10) + 200;
#endif
}

} // namespace I2cExt
} // namespace Dev
} // namespace Hal
