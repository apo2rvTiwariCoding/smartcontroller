// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <cerrno>
#include <cstdint>
#include <iostream>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/ds1338.h"
#include "hal/errors.h"
#include "util/comm/buffer.h"


namespace Hal
{
namespace Dev
{

using ::Util::Comm::TBuffer;
using ::Util::Comm::TEndian;


TDs1338::TWPtr TDs1338::s_instance;

//-----------------------------------------------------------------------------
TDs1338::TPtr TDs1338::Instance()
{
    TPtr instance;
    if (!(instance = s_instance.lock()))
    {
        instance.reset(new TDs1338());
        s_instance = instance;
    }
    return instance;
}

//-----------------------------------------------------------------------------
TDs1338::TDs1338()
    : m_bus(TBus::Instance())
{
}

//-----------------------------------------------------------------------------
TDs1338::~TDs1338() noexcept
{
}

//-----------------------------------------------------------------------------
bool TDs1338::ReadTime(TRtcTime& time)
{
#ifndef SIM
    static const TRegister FIRST_REG = TRegister::SECONDS;
    static const TRegister LAST_REG = TRegister::CONTROL;
    
    TBuffer< 1 > req;
    req.PushAs< ::std::uint8_t >(FIRST_REG);
    assert(req.Index() == req.Capacity());

    TBuffer< LAST_REG - FIRST_REG + 1 > res;

    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    bus_handle.WriteRead(req.Data(), req.Capacity(), res.Data(), res.Capacity());


    unsigned tmp;
    tmp = res.PopAs< ::std::uint8_t >();
    const unsigned seconds10 = (tmp & 0x70) >> 4;
    const unsigned seconds = tmp & 0x0F;
    time.m_seconds = (seconds10 * 10) + seconds;

    tmp = res.PopAs< ::std::uint8_t >();
    const unsigned minutes10 = (tmp & 0x70) >> 4;
    const unsigned minutes = tmp & 0x0F;
    time.m_minutes = (minutes10 * 10) + minutes;

    tmp = res.PopAs< ::std::uint8_t >();
    const unsigned hours10 = (tmp & 0x30) >> 4;
    const unsigned hours = tmp & 0x0F;
    time.m_hours = (hours10 * 10) + hours;
    if (tmp & 0x40)
    {
        // 24-hour mode should be set and not 12-hour mode.
        return false;
    }

    tmp = res.PopAs< ::std::uint8_t >();
    time.m_day_of_week = tmp & 0x07;

    tmp = res.PopAs< ::std::uint8_t >();
    const unsigned day_of_month10 = (tmp & 0x30) >> 4;
    const unsigned day_of_month = tmp & 0x0F;
    time.m_day_of_month = (day_of_month10 * 10) + day_of_month;

    tmp = res.PopAs< ::std::uint8_t >();
    const unsigned months10 = (tmp & 0x10) >> 4;
    const unsigned months = tmp & 0x0F;
    time.m_months = (months10 * 10) + months;

    tmp = res.PopAs< ::std::uint8_t >();
    const unsigned years10 = (tmp & 0xF0) >> 4;
    const unsigned years = tmp & 0x0F;
    time.m_years = (years10 * 10) + years;
    
    tmp = res.PopAs< ::std::uint8_t >(); // control

    assert(res.Index() == res.Capacity());

    if (tmp & TControlRegister::OSF)
    {
        return false;
    }

    return true;
#else
    time = {0};
    return true;
#endif // #ifndef SIM
}

//-----------------------------------------------------------------------------
void TDs1338::WriteTime(const TRtcTime& time)
{
#ifndef SIM
    static const TRegister FIRST_REG = TRegister::SECONDS;
    static const TRegister LAST_REG = TRegister::CONTROL;

    TBuffer< 1 + LAST_REG - FIRST_REG + 1 > buffer;

    buffer.PushAs< ::std::uint8_t >(FIRST_REG); // address

    unsigned tmp;
    tmp = 0x7F & (((time.m_seconds / 10) << 4) | (time.m_seconds % 10));
    buffer.PushAs< ::std::uint8_t >(tmp);

    tmp = ((time.m_minutes / 10) << 4) | (time.m_minutes % 10);
    buffer.PushAs< ::std::uint8_t >(tmp);

    tmp = (((time.m_hours / 10) << 4) & 0x30) | (time.m_hours % 10);
    buffer.PushAs< ::std::uint8_t >(tmp);

    tmp = time.m_day_of_week & 0x07;
    buffer.PushAs< ::std::uint8_t >(tmp);

    tmp = ((time.m_day_of_month / 10) << 4) | (time.m_day_of_month % 10);
    buffer.PushAs< ::std::uint8_t >(tmp);

    tmp = (((time.m_months / 10) << 4) & 0x10) | (time.m_months % 10);
    buffer.PushAs< ::std::uint8_t >(tmp);

    tmp = ((time.m_years / 10) << 4) | (time.m_years % 10);
    buffer.PushAs< ::std::uint8_t >(tmp);

    tmp = DEFAULT_CONTROL;
    buffer.PushAs< ::std::uint8_t >(tmp);

    assert(buffer.Index() == buffer.Capacity());


    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    if (-1 == ::write(bus_handle.Get(), buffer.Data(), buffer.Capacity()))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
#endif
}

//-----------------------------------------------------------------------------
void TDs1338::OnConfigure()
{
#ifndef SIM
    TBuffer< 2 > buffer;
    buffer.PushAs< ::std::uint8_t >(TRegister::CONTROL); // address
    buffer.PushAs< ::std::uint8_t >(DEFAULT_CONTROL);
    assert(buffer.Index() == buffer.Capacity());

    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    if (-1 == ::write(bus_handle.Get(), buffer.Data(), buffer.Capacity()))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
#endif
}

} // namespace Dev
} // namespace Hal
