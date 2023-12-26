// SYSTEM INCLUDES
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/ad5245.h"
#include "hal/errors.h"
#include "util/comm/buffer.h"


namespace Hal
{
namespace Dev
{

using ::Util::Comm::TBuffer;
using ::Util::Comm::TEndian;


TAd5245::TWPtr TAd5245::s_instance;

//-----------------------------------------------------------------------------
TAd5245::TPtr TAd5245::Instance()
{
    TPtr instance;
    if (!(instance = s_instance.lock()))
    {
        instance.reset(new TAd5245());
        s_instance = instance;
    }
    return instance;
}

//-----------------------------------------------------------------------------
TAd5245::TAd5245()
    : m_bus(TBus::Instance())
{
}

//-----------------------------------------------------------------------------
TAd5245::~TAd5245() noexcept
{
}

//-----------------------------------------------------------------------------
void TAd5245::Position(unsigned pos)
{
#ifndef SIM
    TBuffer< 2 > req;
    req.PushAs< ::std::uint8_t >(0x00); // The instruction byte
    req.PushAs< ::std::uint8_t >(pos);
    assert(req.Index() == req.Capacity());

    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    if (-1 == ::write(bus_handle.Get(), req.Data(), req.Capacity()))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
#endif
}

//-----------------------------------------------------------------------------
void TAd5245::OnConfigure()
{
}

} // namespace Dev
} // namespace Hal
