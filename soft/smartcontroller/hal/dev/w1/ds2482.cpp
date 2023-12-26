// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <chrono>
#include <thread>
#include <iostream>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/w1/ds2482.h"
#include "hal/errors.h"
#include "util/comm/buffer.h"


namespace Hal
{
namespace Dev
{
namespace W1
{

using ::Util::Comm::TBuffer;
using ::Util::Comm::TEndian;


TDs2482::TWPtr TDs2482::s_instance;

//-----------------------------------------------------------------------------
TDs2482::TPtr TDs2482::Instance()
{
    TPtr instance;
    if (!(instance = s_instance.lock()))
    {
        instance.reset(new TDs2482());
        s_instance = instance;
    }
    return instance;
}

//-----------------------------------------------------------------------------
TDs2482::TDs2482()
    : m_bus(TI2cBus::Instance())
{
}

//-----------------------------------------------------------------------------
TDs2482::~TDs2482() noexcept
{
}

//-----------------------------------------------------------------------------
unsigned TDs2482::Reset()
{
    static const int TIMEOUT = 1;

    TI2cBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    return ExecCommand(bus_handle, TCommand::DEVICE_RESET, TIMEOUT);
}

//-----------------------------------------------------------------------------
unsigned TDs2482::ReadConfiguration()
{
    TI2cBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    const unsigned configuration =
        ReadRegister(bus_handle, TRegister::CONFIGURATION) & 0x0F;
    return configuration;
}

//-----------------------------------------------------------------------------
void TDs2482::WriteConfiguration(unsigned configuration)
{
    configuration &= 0x0F;
    configuration |= ~(configuration << 4) & 0xF0;

    TI2cBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    ExecCommand(bus_handle, TCommand::WRITE_CONFIGURATION, configuration);
}

//-----------------------------------------------------------------------------
unsigned TDs2482::ReadStatus()
{
    TI2cBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    return ReadRegister(bus_handle, TRegister::STATUS);
}

//-----------------------------------------------------------------------------
unsigned TDs2482::W1Reset()
{
    static const int TIMEOUT = 2;

    TI2cBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    return ExecCommand(bus_handle, TCommand::W1_RESET, TIMEOUT);
}

//-----------------------------------------------------------------------------
unsigned TDs2482::W1GenerateSearchRomSequence(bool direction)
{
    static const int TIMEOUT = 1;

    TI2cBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));    
    return ExecCommand(bus_handle, TCommand::W1_TRIPLET,
        direction ? 0x80 : 0x00, TIMEOUT);
}

//-----------------------------------------------------------------------------
void TDs2482::W1WriteByte(unsigned data)
{   
    static const unsigned TIMEOUT = 2;

    TI2cBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    ExecCommand(bus_handle, TCommand::W1_WRITE_BYTE, data, TIMEOUT);
}

//-----------------------------------------------------------------------------
void TDs2482::W1WriteData(const void* data, ::std::size_t size)
{
    const ::std::uint8_t* p = static_cast< const ::std::uint8_t* >(data);
    while(size--)
    {
        W1WriteByte(*p++);
    }
}

//-----------------------------------------------------------------------------
unsigned TDs2482::W1ReadByte()
{
    static const unsigned TIMEOUT = 10;

    TI2cBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));
    ExecCommand(bus_handle, TCommand::W1_READ_BYTE, TIMEOUT);
    return ReadRegister(bus_handle, TRegister::DATA);
}

//-----------------------------------------------------------------------------
void TDs2482::W1ReadData(void* data, ::std::size_t size)
{
    ::std::uint8_t* p = static_cast< ::std::uint8_t* >(data);
    while(size--)
    {
        *p++ = W1ReadByte();
    }
}

//-----------------------------------------------------------------------------
unsigned TDs2482::ReadRegister(TI2cBus::THandle& bus_handle, TRegister reg)
{
    TBuffer< 2 > req;
    req.PushAs< ::std::uint8_t >(TCommand::SET_READ_POINTER);
    req.PushAs< ::std::uint8_t >(reg);
    assert(req.Index() == req.Capacity());
    TBuffer< sizeof(::std::uint8_t) > res;
    
    bus_handle.WriteRead(req.Data(), req.Capacity(), res.Data(), res.Capacity());

    return res.PopAs< ::std::uint8_t >();
}

//-----------------------------------------------------------------------------
unsigned TDs2482::ExecCommand(TI2cBus::THandle& bus_handle, TCommand command,
                              int timeout)
{
    TBuffer< 1 > req;
    req.PushAs< ::std::uint8_t >(command);
    assert(req.Index() == req.Capacity());
    
    if (-1 == ::write(bus_handle.Get(), req.Data(), req.Capacity()))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }

    return WaitCommandToComplete(bus_handle, timeout);
}

//-----------------------------------------------------------------------------
unsigned TDs2482::ExecCommand(TI2cBus::THandle& bus_handle, TCommand command,
                              unsigned arg, int timeout)
{
    TBuffer< 2 > req;
    req.PushAs< ::std::uint8_t >(command);
    req.PushAs< ::std::uint8_t >(arg);
    assert(req.Index() == req.Capacity());
    
    if (-1 == ::write(bus_handle.Get(), req.Data(), req.Capacity()))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }

    return WaitCommandToComplete(bus_handle, timeout);
}

//-----------------------------------------------------------------------------
unsigned TDs2482::WaitCommandToComplete(TI2cBus::THandle& bus_handle,
                                        int timeout)
{
    int time = 0;
    unsigned status;

    do
    {
        if (time > timeout)
        {
            THROW_EXCEPTION(TSystemError(EIO));
        }
        ::std::this_thread::sleep_for(::std::chrono::milliseconds(1));
        time++;

        status = ReadRegister(bus_handle, TRegister::STATUS);
    } while(status & TStatus::W1B);

    return status;
}

//-----------------------------------------------------------------------------
void TDs2482::OnConfigure()
{
    WriteConfiguration(TConfiguration::APU);
}

} // namespace W1
} // namespace Dev
} // namespace Hal
