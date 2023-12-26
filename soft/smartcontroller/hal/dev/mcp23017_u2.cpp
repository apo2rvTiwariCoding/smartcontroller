// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <chrono>
#include <thread>
#include <cstdint>
#include <iostream>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/mcp23017_u2.h"


//#define RESET_AS_INPUTS // TODO: remove me

namespace Hal
{
namespace Dev
{

/// MAX4821 abstraction.
struct TMcp23017_U2::TMax4821 : TDevice
{
    TMax4821(TMcp23017& mcp23017, TMcp23017::TPin reset_pin,
        TMcp23017::TPin cs_pin, TMcp23017::TPin lvl_pin)
        : m_mcp23017(mcp23017),
          m_reset_pin(reset_pin),
          m_cs_pin(cs_pin),
          m_lvl_pin(lvl_pin)
      {}

    enum TOutput
    {
        OUT1 = 0,
        OUT2,
        OUT3,
        OUT4,
        OUT5,
        OUT6,
        OUT7,
        OUT8
    };

    void Reset();

    void WriteOutput(TOutput out, bool high);

    TMcp23017& m_mcp23017;

    const TMcp23017::TPin m_reset_pin;
    const TMcp23017::TPin m_cs_pin;
    const TMcp23017::TPin m_lvl_pin;

    void OnConfigure();
}; // struct TMcp23017_U2::TMax4821

//-----------------------------------------------------------------------------
void TMcp23017_U2::TMax4821::Reset()
{
    m_mcp23017.WriteOutputs(m_reset_pin.m_port, m_reset_pin.m_mask, 0x00);
    m_mcp23017.WriteOutputs(m_reset_pin.m_port, 0x00, m_reset_pin.m_mask);
}

//-----------------------------------------------------------------------------
void TMcp23017_U2::TMax4821::WriteOutput(TOutput out, bool high)
{
#if 1
    //
    // Set address
    //

    static const unsigned A0 = 0x01;
    static const unsigned A1 = 0x02;
    static const unsigned A2 = 0x04;
    static const ::std::uint8_t address_map[] =
    {
        /* OUT1 */ 0x00,
        /* OUT2 */ A0,
        /* OUT3 */ A1,
        /* OUT4 */ A1 | A0,
        /* OUT5 */ A2,
        /* OUT6 */ A2 | A0,
        /* OUT7 */ A2 | A1,
        /* OUT8 */ A2 | A1 | A0,
    };
    m_mcp23017.WriteOutputs(TMcp23017::TPort::B, 0x07, address_map[out]);

    //
    // Latch address
    //

    m_mcp23017.WriteOutputs(m_cs_pin.m_port, m_cs_pin.m_mask, 0x00);

    //
    // Set level
    //

    if (high)
    {
        m_mcp23017.WriteOutputs(m_lvl_pin.m_port, 0x00, m_lvl_pin.m_mask);
    }
    else
    {
        m_mcp23017.WriteOutputs(m_lvl_pin.m_port, m_lvl_pin.m_mask, 0x00);
    }
    //::std::this_thread::sleep_for(::std::chrono::milliseconds(1)); // > 100 ns

    //
    // Release the latch
    //

    m_mcp23017.WriteOutputs(m_cs_pin.m_port, 0x00, m_cs_pin.m_mask);
    //::std::this_thread::sleep_for(::std::chrono::milliseconds(1));

#else
    // FIXME: the ports don't need to be read beforehand.
    ::std::array< unsigned, TMcp23017::PORTS_COUNT > ports;
    ports[TMcp23017::TPort::A] = m_mcp23017.ReadOutputs(TMcp23017::TPort::A);
    ports[TMcp23017::TPort::B] = m_mcp23017.ReadOutputs(TMcp23017::TPort::B);

    // Just in case
    ports[m_reset_pin.m_port] |= m_reset_pin.m_mask;

    //
    // Set address
    //

    static const unsigned A0 = 0x01;
    static const unsigned A1 = 0x02;
    static const unsigned A2 = 0x04;

    ports[TMcp23017::TPort::B] &= ~(A2 | A1 | A0);
    static const uint8_t address_map[] =
    {
        /* OUT1 */ 0x00,
        /* OUT2 */ A0,
        /* OUT3 */ A1,
        /* OUT4 */ A1 | A0,
        /* OUT5 */ A2,
        /* OUT6 */ A2 | A0,
        /* OUT7 */ A2 | A1,
        /* OUT8 */ A2 | A1 | A0,
    };
    ports[TMcp23017::TPort::B] |= address_map[out];
    m_mcp23017.WriteOutputs(TMcp23017::TPort::B, ports[TMcp23017::TPort::B]);

    //
    // Latch address
    //

    ports[m_cs_pin.m_port] &= ~m_cs_pin.m_mask;
    m_mcp23017.WriteOutputs(m_cs_pin.m_port, ports[m_cs_pin.m_port]);

    //
    // Set level
    //

    if (high)
    {
        ports[m_lvl_pin.m_port] |= m_lvl_pin.m_mask;
    }
    else
    {
        ports[m_lvl_pin.m_port] &= ~m_lvl_pin.m_mask;
    }
    //::std::this_thread::sleep_for(::std::chrono::milliseconds(1)); // > 100 ns
    m_mcp23017.WriteOutputs(m_lvl_pin.m_port, ports[m_lvl_pin.m_port]);

    //
    // Release the latch
    //

    ports[m_cs_pin.m_port] |= m_cs_pin.m_mask;
    m_mcp23017.WriteOutputs(m_cs_pin.m_port, ports[m_cs_pin.m_port]);
    //::std::this_thread::sleep_for(::std::chrono::milliseconds(1));
#endif
}

//-----------------------------------------------------------------------------
void TMcp23017_U2::TMax4821::OnConfigure()
{
    m_mcp23017.WriteOutputs(m_reset_pin.m_port, 0x00, m_reset_pin.m_mask);
    m_mcp23017.WriteOutputs(m_cs_pin.m_port, 0x00, m_cs_pin.m_mask);
}


TMcp23017_U2::TWPtr TMcp23017_U2::s_instance;

//-----------------------------------------------------------------------------
TMcp23017_U2::TPtr TMcp23017_U2::Instance()
{
    TPtr instance;
    if (!(instance = s_instance.lock()))
    {
        instance.reset(new TMcp23017_U2());
        s_instance = instance;
    }
    return instance;
}

//-----------------------------------------------------------------------------
TMcp23017_U2::TMcp23017_U2()
    : m_mcp23017(new TMcp23017(DEFAULT_ADDRESS)),
      m_u1(new TMax4821(*m_mcp23017,
        TPin(TPort::B, 3), TPin(TPort::B, 4), TPin(TPort::B, 5))),
      m_u3(new TMax4821(*m_mcp23017,
        TPin(TPort::B, 6), TPin(TPort::B, 7), TPin(TPort::A, 0))),
      m_u5(new TMax4821(*m_mcp23017,
        TPin(TPort::A, 1), TPin(TPort::A, 2), TPin(TPort::A, 3)))
{
}

//-----------------------------------------------------------------------------
TMcp23017_U2::~TMcp23017_U2() noexcept
{
}

//-----------------------------------------------------------------------------
void TMcp23017_U2::OnConfigure()
{
    m_mcp23017->Configure();

#ifdef RESET_AS_INPUTS // TODO: remove me
    m_mcp23017->SetDirection(TPort::A, 0x02, 0xFD);
    m_mcp23017->SetDirection(TPort::B, 0x48, 0xB7);
#else
    m_mcp23017->SetDirection(TPort::A, 0x00, 0xFF);
    m_mcp23017->SetDirection(TPort::B, 0x00, 0xFF);
#endif

    m_u1->OnConfigure();
    m_u3->OnConfigure();
    m_u5->OnConfigure();

    AudioShdn(false);
}

//-----------------------------------------------------------------------------
void TMcp23017_U2::Relay(TRelayId id, bool on)
{
    assert(id < RELAYS_COUNT);
    switch(id)
    {
    case RELAY_K3:  m_u1->WriteOutput(TMax4821::OUT1, on); break;
    case RELAY_K9:  m_u1->WriteOutput(TMax4821::OUT2, on); break;
    case RELAY_K1:  m_u1->WriteOutput(TMax4821::OUT3, on); break;
    case RELAY_K2:  m_u1->WriteOutput(TMax4821::OUT4, on); break;    
    case RELAY_K4:  m_u1->WriteOutput(TMax4821::OUT5, on); break;
    case RELAY_K10: m_u1->WriteOutput(TMax4821::OUT6, on); break;
    case RELAY_K5:  m_u1->WriteOutput(TMax4821::OUT7, on); break;
    
    case RELAY_K21: m_u3->WriteOutput(TMax4821::OUT1, on); break;
    case RELAY_K14: m_u3->WriteOutput(TMax4821::OUT2, on); break;
    case RELAY_K13: m_u3->WriteOutput(TMax4821::OUT3, on); break;
    case RELAY_K8:  m_u3->WriteOutput(TMax4821::OUT4, on); break;
    case RELAY_K7:  m_u3->WriteOutput(TMax4821::OUT5, on); break;
    case RELAY_K17: m_u3->WriteOutput(TMax4821::OUT6, on); break;
    case RELAY_K18: m_u3->WriteOutput(TMax4821::OUT7, on); break;
    case RELAY_K22: m_u3->WriteOutput(TMax4821::OUT8, on); break;

    case RELAY_K6:  m_u5->WriteOutput(TMax4821::OUT1, on); break;    
    case RELAY_K20: m_u5->WriteOutput(TMax4821::OUT3, on); break;
    case RELAY_K16: m_u5->WriteOutput(TMax4821::OUT4, on); break;
    case RELAY_K12: m_u5->WriteOutput(TMax4821::OUT5, on); break;
    case RELAY_K19: m_u5->WriteOutput(TMax4821::OUT6, on); break;
    case RELAY_K15: m_u5->WriteOutput(TMax4821::OUT7, on); break;
    case RELAY_K11: m_u5->WriteOutput(TMax4821::OUT8, on); break;
    }
}

//-----------------------------------------------------------------------------
void TMcp23017_U2::RelaysReset()
{
#ifdef RESET_AS_INPUTS // TODO: remove me
    m_mcp23017->SetDirection(TPort::A, 0x00, 0xFF);
    m_mcp23017->SetDirection(TPort::B, 0x00, 0xFF);
#endif

    m_u1->Reset();
    m_u3->Reset();
    m_u5->Reset();

#ifdef RESET_AS_INPUTS // TODO: remove me
    m_mcp23017->SetDirection(TPort::A, 0x02, 0xFD);
    m_mcp23017->SetDirection(TPort::B, 0x48, 0xB7);
#endif
}

//-----------------------------------------------------------------------------
void TMcp23017_U2::Led(TLedId id, bool on)
{
    assert(id < LEDS_COUNT);
    static const ::std::array< TPin, LEDS_COUNT > leds =
    {{
        TPin(TPort::A, 4), TPin(TPort::A, 5)
    }};    

    m_mcp23017->WriteOutputs(leds[id].m_port,
        leds[id].m_mask, on ? leds[id].m_mask : 0x00);
}

//-----------------------------------------------------------------------------
void TMcp23017_U2::AdcConv(const TAd7993Key&, bool on)
{
    const TPin pin(TPort::A, 6);
    m_mcp23017->WriteOutputs(pin.m_port, pin.m_mask, on ? pin.m_mask : 0x00);
}

//-----------------------------------------------------------------------------
void TMcp23017_U2::AudioShdn(bool on)
{
    const TPin pin(TPort::A, 7);
    m_mcp23017->WriteOutputs(pin.m_port, pin.m_mask, on ? 0x00 : pin.m_mask);
}

} // namespace Dev
} // namespace Hal
