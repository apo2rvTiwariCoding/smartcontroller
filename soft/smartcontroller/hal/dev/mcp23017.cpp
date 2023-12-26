// SYSTEM INCLUDES
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/mcp23017.h"
#include "hal/errors.h"


namespace Hal
{
namespace Dev
{

//-----------------------------------------------------------------------------
TMcp23017::TMcp23017(unsigned address)
    : m_bus(TBus::Instance()),
      m_address(address)
{
}

//-----------------------------------------------------------------------------
TMcp23017::~TMcp23017()
{
}

//-----------------------------------------------------------------------------
unsigned TMcp23017::ReadRegister(TRegister reg)
{
#ifndef SIM
    TBus::THandle bus_handle(m_bus->TakeControl(m_address));

    ::std::uint8_t tmp = reg;
    bus_handle.WriteRead(&tmp, sizeof(tmp), &tmp, sizeof(tmp));
    return tmp;
#else
    return 0;
#endif
}

//-----------------------------------------------------------------------------
void TMcp23017::WriteRegister(TRegister reg, unsigned value)
{
#ifndef SIM
    TBus::THandle bus_handle(m_bus->TakeControl(m_address));

    const ::std::uint8_t buffer[] =
    {
        static_cast< ::std::uint8_t >(reg),
        static_cast< ::std::uint8_t >(value)
    };
    if (-1 == ::write(bus_handle.Get(), buffer, sizeof(buffer)))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
#endif
}

//-----------------------------------------------------------------------------
void TMcp23017::SetInterruptOnChange(TPort port, unsigned mask)
{
    {
        TRegister reg = TRegister::INVALID;
        switch(port)
        {
        case TPort::A: reg = TRegister::INTCONA; break;
        case TPort::B: reg = TRegister::INTCONB; break;
        }
        assert(TRegister::INVALID != reg);

        unsigned intcon = ReadRegister(reg);
        intcon &= ~mask;
        WriteRegister(reg, intcon);
    }

    {
        TRegister reg = TRegister::INVALID;
        switch(port)
        {
        case TPort::A: reg = TRegister::GPINTENA; break;
        case TPort::B: reg = TRegister::GPINTENB; break;
        }
        assert(TRegister::INVALID != reg);

        unsigned gpinten = ReadRegister(reg);
        gpinten |= mask;
        gpinten = mask;
        WriteRegister(reg, gpinten);
    }
}

//-----------------------------------------------------------------------------
unsigned TMcp23017::ReadInterruptFlags(TPort port)
{
    TRegister reg = TRegister::INVALID;
    switch(port)
    {
    case TPort::A: reg = TRegister::INTFA; break;
    case TPort::B: reg = TRegister::INTFB; break;
    }
    assert(TRegister::INVALID != reg);

    return ReadRegister(reg);
}

//-----------------------------------------------------------------------------
unsigned TMcp23017::ReadInterruptCapturedValue(TPort port)
{
    TRegister reg = TRegister::INVALID;
    switch(port)
    {
    case TPort::A: reg = TRegister::INTCAPA; break;
    case TPort::B: reg = TRegister::INTCAPB; break;
    }
    assert(TRegister::INVALID != reg);

    return ReadRegister(reg);
}

//-----------------------------------------------------------------------------
void TMcp23017::SetDirection(TPort port, unsigned inputs_mask,
                             unsigned outputs_mask)
{
    TRegister reg = TRegister::INVALID;
    switch(port)
    {
    case TPort::A: reg = TRegister::IODIRA; break;
    case TPort::B: reg = TRegister::IODIRB; break;
    }
    assert(TRegister::INVALID != reg);

    unsigned mask = ReadRegister(reg);
    mask |= inputs_mask;
    mask &= ~outputs_mask;
    WriteRegister(reg, mask);
}

//-----------------------------------------------------------------------------
unsigned TMcp23017::ReadInputs(TPort port)
{
    TRegister reg = TRegister::INVALID;
    switch(port)
    {
    case TPort::A: reg = TRegister::GPIOA; break;
    case TPort::B: reg = TRegister::GPIOB; break;
    }
    assert(TRegister::INVALID != reg);

    return ReadRegister(reg);
}

//-----------------------------------------------------------------------------
unsigned TMcp23017::ReadOutputs(TPort port)
{
    TRegister reg = TRegister::INVALID;
    switch(port)
    {
    case TPort::A: reg = TRegister::OLATA; break;
    case TPort::B: reg = TRegister::OLATB; break;
    }
    assert(TRegister::INVALID != reg);

    m_outputs_cache[port] = ReadRegister(reg);
    return m_outputs_cache[port];
}

//-----------------------------------------------------------------------------
void TMcp23017::WriteOutputs(TPort port, unsigned mask)
{
    TRegister reg = TRegister::INVALID;
    switch(port)
    {
    case TPort::A: reg = TRegister::GPIOA; break;
    case TPort::B: reg = TRegister::GPIOB; break;
    }
    assert(TRegister::INVALID != reg);
    
    WriteRegister(reg, mask);
    m_outputs_cache[port] = mask;
}

//-----------------------------------------------------------------------------
void TMcp23017::WriteOutputs(TPort port, unsigned clear_mask,
                             unsigned set_mask)
{
    unsigned outputs = m_outputs_cache[port];
    outputs &= ~clear_mask;
    outputs |= set_mask;
    WriteOutputs(port, outputs);
}

//-----------------------------------------------------------------------------
void TMcp23017::OnConfigure()
{
    // To update m_outputs_cache
    ReadOutputs(TPort::A);
    ReadOutputs(TPort::B);
}

} // namespace Dev
} // namespace Hal
