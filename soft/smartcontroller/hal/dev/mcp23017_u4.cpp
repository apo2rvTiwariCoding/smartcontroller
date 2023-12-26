// SYSTEM INCLUDES
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/mcp23017_u4.h"
#include "hal/errors.h"


namespace Hal
{
namespace Dev
{

TMcp23017_U4::TWPtr TMcp23017_U4::s_instance;

//-----------------------------------------------------------------------------
TMcp23017_U4::TPtr TMcp23017_U4::Instance()
{
    TPtr instance;
    if (!(instance = s_instance.lock()))
    {
        instance.reset(new TMcp23017_U4());
        s_instance = instance;
    }
    return instance;
}

//-----------------------------------------------------------------------------
TMcp23017_U4::TMcp23017_U4()
    : m_mcp23017(new TMcp23017(DEFAULT_ADDRESS)),
      m_gpios({{
          TGpio::TUPtr(new TGpio(27, TGpio::TEdge::FALLING)),
          TGpio::TUPtr(new TGpio(22, TGpio::TEdge::FALLING)) }})
{
}

//-----------------------------------------------------------------------------
TMcp23017_U4::~TMcp23017_U4() noexcept
{
}

//-----------------------------------------------------------------------------
bool TMcp23017_U4::WaitForInterrupt(int timeout)
{
    const int res = ::poll(m_fds.data(), m_fds.size(), timeout);
    if (0 == res)
    {
        // timed out
    }
    else if (res > 0)
    {
        for(unsigned i = 0; i < m_fds.size(); i++)
        {
            if (m_fds[i].revents & POLLPRI)
            {
                char ch;
                ::read(m_fds[i].fd, &ch, 1);

                //port = static_cast< TPort >(i);
                return true;
            }
        }
    }
    else
    {
        // error
        THROW_EXCEPTION(TSystemError(errno));
    }

    return false;
}

//-----------------------------------------------------------------------------
unsigned TMcp23017_U4::ReadCapturedInterrupts()
{
    unsigned mask;
    mask = m_mcp23017->ReadInterruptCapturedValue(TPort::B);
    mask |= m_mcp23017->ReadInterruptCapturedValue(TPort::A) << 8;
    return PreProcessInterruptStatuses(mask);
}

//-----------------------------------------------------------------------------
unsigned TMcp23017_U4::ReadInterrupts()
{
    unsigned mask;
    mask = m_mcp23017->ReadInputs(TPort::B);
    mask |= m_mcp23017->ReadInputs(TPort::A) << 8;
    return PreProcessInterruptStatuses(mask);
}

//-----------------------------------------------------------------------------
unsigned TMcp23017_U4::PreProcessInterruptStatuses(unsigned statuses)
{
    static const unsigned invert_mask = 0xBF1F;
    statuses ^= invert_mask;
    // filter out the bits ZIGBEE_INT, ZIGBEE_CS, ZIGBEE_WAKE
    statuses = ((statuses & 0xFF00) >> 3) | (statuses & 0x001F);
    return statuses;
}

//-----------------------------------------------------------------------------
bool TMcp23017_U4::ReadCoState()
{
    const unsigned mask = m_mcp23017->ReadInputs(TPort::A);
    return mask & 0x40;
}

//-----------------------------------------------------------------------------
void TMcp23017_U4::OnConfigure()
{
    m_mcp23017->Configure();

    m_mcp23017->SetDirection(TPort::A, 0xFF, 0x00);
    m_mcp23017->SetDirection(TPort::B, 0xFF, 0x00);

    m_mcp23017->SetInterruptOnChange(TPort::A, 0xFF);
    // Note: the bits ZIGBEE_INT, ZIGBEE_CS, ZIGBEE_WAKE are ignored
    m_mcp23017->SetInterruptOnChange(TPort::B, 0x1F);


    // Remove stale interrupts
    m_mcp23017->ReadInterruptCapturedValue(TPort::A);
    m_mcp23017->ReadInterruptCapturedValue(TPort::B);

    for(unsigned i = 0; i < TMcp23017::PORTS_COUNT; i++)
    {
        const int fd = m_gpios[i]->Get();

        m_fds[i].fd = fd;
        m_fds[i].events = POLLPRI;

        // Remove stale interrupts
        char ch;
        ::read(fd, &ch, 1);
    }
}

} // namespace Dev
} // namespace Hal
