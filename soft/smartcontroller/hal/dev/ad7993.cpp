// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <cerrno>
#include <chrono>
#include <thread>
#include <cassert>
#include <cstdint>
#include <cstdlib>
#include <iostream>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/ad7993.h"
#include "hal/dev/mcp23017_u2.h"
#include "hal/dev/keys.h"
#include "hal/errors.h"
#include "util/comm/buffer.h"


namespace Hal
{
namespace Dev
{

using ::Util::Comm::TBuffer;
using ::Util::Comm::TEndian;


const float TAd7993::REFERENCE = 3.3; // Voltage [V]
const float TAd7993::QUANT = static_cast< float >(TAd7993::REFERENCE) /
    static_cast< float >(TAd7993::RANGE);


TAd7993::TWPtr TAd7993::s_instance;
const unsigned TAd7993::DEFAULT_CONFIGURATION_REG =
    TAd7993::TConfigurationRegister::ALERT_EN |
    TAd7993::TConfigurationRegister::FLTR;

//-----------------------------------------------------------------------------
TAd7993::TPtr TAd7993::Instance()
{
    TPtr instance;
    if (!(instance = s_instance.lock()))
    {
        instance.reset(new TAd7993());
        s_instance = instance;
    }
    return instance;
}

//-----------------------------------------------------------------------------
TAd7993::TAd7993()
    : m_bus(TBus::Instance()),
      m_u2(TMcp23017_U2::Instance()),
      m_configuration_reg(DEFAULT_CONFIGURATION_REG)
{
}

//-----------------------------------------------------------------------------
TAd7993::~TAd7993() noexcept
{
}

//-----------------------------------------------------------------------------
void TAd7993::WriteLowLimit(TInputId input_id, unsigned threshold)
{
    assert(input_id < INPUTS_COUNT);

    threshold <<= 2;

    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    switch(input_id)
    {
    case TInputId::VIN1:
        WriteRegister16(bus_handle, TRegister::DATA_LOW_CH1, threshold); 
        break;

    case TInputId::VIN2:
        WriteRegister16(bus_handle, TRegister::DATA_LOW_CH2, threshold);
        break;

    case TInputId::VIN3:
        WriteRegister16(bus_handle, TRegister::DATA_LOW_CH3, threshold);
        break;

    case TInputId::VIN4:
        WriteRegister16(bus_handle, TRegister::DATA_LOW_CH4, threshold);
        break;
    }
}

//-----------------------------------------------------------------------------
void TAd7993::WriteHighLimit(TInputId input_id, unsigned threshold)
{
    assert(input_id < INPUTS_COUNT);

    threshold <<= 2;

    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    switch(input_id)
    {
    case TInputId::VIN1:
        WriteRegister16(bus_handle, TRegister::DATA_HIGH_CH1, threshold); 
        break;

    case TInputId::VIN2:
        WriteRegister16(bus_handle, TRegister::DATA_HIGH_CH2, threshold);
        break;

    case TInputId::VIN3:
        WriteRegister16(bus_handle, TRegister::DATA_HIGH_CH3, threshold);
        break;

    case TInputId::VIN4:
        WriteRegister16(bus_handle, TRegister::DATA_HIGH_CH4, threshold);
        break;
    }
}

//-----------------------------------------------------------------------------
unsigned TAd7993::Convert(TInputId input_id)
{
    assert(input_id < INPUTS_COUNT);

#ifndef SIM
    // Stop periodic sampling and set the channel
    {
        TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));

        StopPeriodicSampling(bus_handle);
        SelectChannel(bus_handle, input_id);
    }

    // Start conversion by toggling the pin
    // Note: the I2C bus handle needs to be released prior to calling this
    // function on account of communication with other IC.
    TriggerConversion();

    // Read the result
    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    bool alert;
    TInputId actual_input_id;
    const unsigned result = ReadConversionResult(
        bus_handle, actual_input_id, alert);
    if (input_id != actual_input_id)
    {
        StartPeriodicSampling(bus_handle);

        // Unexpected channel
        THROW_EXCEPTION(TInvalidResponseError());
    }

    StartPeriodicSampling(bus_handle);

    return result;
#else
    return (::std::rand() % 1000) + 10000;
#endif // #ifndef SIM
}

//-----------------------------------------------------------------------------
void TAd7993::ReadAlerts(TInputId input_id, bool& low, bool& high)
{
    assert(input_id < INPUTS_COUNT);

#ifndef SIM
    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    const unsigned tmp = ReadRegister8(bus_handle, TRegister::ALERT_STATUS);
    low = tmp & (1 << (input_id * 2));
    high = tmp & (1 << ((input_id * 2) + 1));
#else
    low = false;
    high = false;
#endif
}

//-----------------------------------------------------------------------------
void TAd7993::ClearAlert()
{
#ifndef SIM
    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));

    // Clear alert statuses
    m_configuration_reg |= TConfigurationRegister::BUSY;
    WriteRegister8(bus_handle, TRegister::CONFIGURATION, m_configuration_reg);

    // NOTE: If the following fails, we are in trouble
    m_configuration_reg &= ~TConfigurationRegister::BUSY;
    try
    {
        WriteRegister8(bus_handle, TRegister::CONFIGURATION, m_configuration_reg);
    }
    catch(...)
    {
        // Try it one more time
        WriteRegister8(bus_handle, TRegister::CONFIGURATION, m_configuration_reg);
    }
#endif // #ifndef SIM
}

//-----------------------------------------------------------------------------
void TAd7993::WriteRegister8(TBus::THandle& bus_handle, TRegister reg,
                             unsigned value)
{
    TBuffer< 2 > req;
    req.PushAs< ::std::uint8_t >(reg);
    req.PushAs< ::std::uint8_t >(value);
    assert(req.Index() == req.Capacity());

    if (-1 == ::write(bus_handle.Get(), req.Data(), req.Capacity()))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
}

//-----------------------------------------------------------------------------
unsigned TAd7993::ReadRegister8(TBus::THandle& bus_handle, TRegister reg)
{
    TBuffer< 1 > req;
    req.PushAs< ::std::uint8_t >(reg);
    assert(req.Index() == req.Capacity());
    TBuffer< sizeof(::std::uint8_t) > res;
    
    bus_handle.WriteRead(req.Data(), req.Capacity(), res.Data(), res.Capacity());

    return res.PopAs< ::std::uint8_t >();
}

//-----------------------------------------------------------------------------
void TAd7993::WriteRegister16(TBus::THandle& bus_handle, TRegister reg,
                              unsigned value)
{
    TBuffer< 3 > req;
    req.PushAs< ::std::uint8_t >(reg);
    req.PushAs< ::std::uint16_t >(value);
    assert(req.Index() == req.Capacity());

    if (-1 == ::write(bus_handle.Get(), req.Data(), req.Capacity()))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
}

//-----------------------------------------------------------------------------
void TAd7993::SelectChannel(TBus::THandle& bus_handle, TInputId input_id)
{
    m_configuration_reg &= ~(CH_MASK);
    m_configuration_reg |= 1 << (input_id + 4);
    WriteRegister8(bus_handle, TRegister::CONFIGURATION, m_configuration_reg);
}

//-----------------------------------------------------------------------------
void TAd7993::TriggerConversion()
{
    // It toggles the CONV pin

    m_u2->AdcConv(TAd7993Key(), true);
    ::std::this_thread::sleep_for(::std::chrono::microseconds(1)); // not less than this
    m_u2->AdcConv(TAd7993Key(), false);
    ::std::this_thread::sleep_for(::std::chrono::microseconds(5)); // not less than this
}

//-----------------------------------------------------------------------------
unsigned TAd7993::ReadConversionResult(TBus::THandle& bus_handle,
        TInputId& input_id, bool& alert)
{
    TBuffer< 1 > req;
    req.PushAs< ::std::uint8_t >(TRegister::CONVERSION_RESULT);
    assert(req.Index() == req.Capacity());
    TBuffer< sizeof(::std::uint16_t) > res;
    
    bus_handle.WriteRead(req.Data(), req.Capacity(), res.Data(), res.Capacity());
        
    const unsigned result = res.PopAs< ::std::uint16_t >();
    input_id = static_cast< TInputId >((result & 0x3000) >> 12);
    alert = result & 0x8000;
    return (result >> 2) & 0x03FF;
}

//-----------------------------------------------------------------------------
void TAd7993::StartPeriodicSampling(TBus::THandle& bus_handle)
{
    // Select all the channel
    m_configuration_reg |= CH_MASK;
    WriteRegister8(bus_handle, TRegister::CONFIGURATION, m_configuration_reg);

    // sampling rate is 1 ms per channel
    WriteRegister8(bus_handle, TRegister::CYCLE_TIMER, 0x06);
}

//-----------------------------------------------------------------------------
void TAd7993::StopPeriodicSampling(TBus::THandle& bus_handle)
{
    WriteRegister8(bus_handle, TRegister::CYCLE_TIMER, 0x00);
}

//-----------------------------------------------------------------------------
void TAd7993::OnConfigure()
{
#ifndef SIM
    m_u2->AdcConv(TAd7993Key(), false);

    TBuffer< 16 > req;
    // Clear alerts
    req.PushAs< ::std::uint8_t >(TRegister::ALERT_STATUS);
    req.PushAs< ::std::uint8_t >(0xFF);
    // Write configuration
    req.PushAs< ::std::uint8_t >(TRegister::CONFIGURATION);
    req.PushAs< ::std::uint8_t >(m_configuration_reg);
    // Set the hysteresis
    static const unsigned HYSTERESIS = 20;
    req.PushAs< ::std::uint8_t >(HYSTERESIS_CH1);
    req.PushAs< ::std::uint16_t >(HYSTERESIS << 2);
    req.PushAs< ::std::uint8_t >(HYSTERESIS_CH2);
    req.PushAs< ::std::uint16_t >(HYSTERESIS << 2);
    req.PushAs< ::std::uint8_t >(HYSTERESIS_CH3);
    req.PushAs< ::std::uint16_t >(HYSTERESIS << 2);
    req.PushAs< ::std::uint8_t >(HYSTERESIS_CH4);
    req.PushAs< ::std::uint16_t >(HYSTERESIS << 2);
    assert(req.Index() == req.Capacity());

    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    if (-1 == ::write(bus_handle.Get(), req.Data(), req.Capacity()))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }

    StartPeriodicSampling(bus_handle);
#endif
}

} // namespace Dev
} // namespace Hal
