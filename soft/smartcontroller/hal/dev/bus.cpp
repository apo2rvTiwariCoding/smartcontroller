// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <iostream>
#include <cerrno>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include <linux/i2c.h>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/bus.h"
#include "hal/errors.h"


namespace Hal
{
namespace Dev
{

//-----------------------------------------------------------------------------
TBus::THandle::THandle(THandle&& handle) noexcept
    : m_bus(nullptr)
{
    ::std::swap(m_bus, handle.m_bus);
}

//-----------------------------------------------------------------------------
TBus::THandle::~THandle() noexcept
{
    if (m_bus)
    {
        m_bus->ReleaseControl();
    }
}

//-----------------------------------------------------------------------------
TBus::THandle TBus::TakeControl(int device_address)
{
    assert(IsOpen());
    assert(!IsBusy());
    
    if (m_address != device_address)
    {
        if (-1 == ::ioctl(m_fd, I2C_SLAVE, device_address))
        {
            THROW_EXCEPTION(TSystemError(errno));
        }

        m_address = device_address;
    }

    m_busy = true;
    return THandle(this);
}


TBus::TWPtr TBus::s_instance;

//-----------------------------------------------------------------------------
TBus::TPtr TBus::Instance()
{
    TPtr instance;
    if (!(instance = s_instance.lock()))
    {
        instance.reset(new TBus());
        s_instance = instance;
    }
    return instance;
}

//-----------------------------------------------------------------------------
TBus::TBus()
    : m_fd(INVALID_FD),
      m_address(INVALID_ADDRESS),
      m_busy(false)
{
    const int fd = ::open("/dev/i2c-1", O_RDWR);
    if (INVALID_FD == fd)
    {
        THROW_EXCEPTION(TSystemError(errno));
    }

    if (-1 == ::ioctl(fd, I2C_RETRIES, 3))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
    if (-1 == ::ioctl(fd, I2C_TIMEOUT, DEFAULT_TIMEOUT / 10))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }

    m_fd = fd;
}

//-----------------------------------------------------------------------------
TBus::~TBus() noexcept
{
    Close();
}

//-----------------------------------------------------------------------------
void TBus::Close() noexcept
{
    if (INVALID_FD != m_fd)
    {
        ::close(m_fd);
        m_fd = INVALID_FD;
        ReleaseControl();
    }
}

//-----------------------------------------------------------------------------
void TBus::WriteRead(const void* tx, ::std::size_t tx_len,
                     void* rx, ::std::size_t rx_len)
{
    assert(IsOpen());

    static const int MESSAGE_COUNT = 2;
    i2c_msg messages[MESSAGE_COUNT];

    i2c_rdwr_ioctl_data data;
    data.msgs = messages;
    data.nmsgs = MESSAGE_COUNT;

    i2c_msg& tx_msg = messages[0];
    tx_msg.addr = m_address;
    tx_msg.flags = 0x0000;
    tx_msg.len = tx_len;
    tx_msg.buf = static_cast< uint8_t* >(const_cast< void* >(tx));

    i2c_msg& rx_msg = messages[1];
    rx_msg.addr = m_address;
    rx_msg.flags = I2C_M_RD;
    rx_msg.len = rx_len;
    rx_msg.buf = static_cast< uint8_t* >(rx);

    if (-1 == ::ioctl(m_fd, I2C_RDWR, &data))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
}

} // namespace Dev
} // namespace Hal
