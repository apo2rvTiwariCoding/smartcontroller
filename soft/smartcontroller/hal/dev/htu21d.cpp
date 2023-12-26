// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <chrono>
#include <thread>
#include <cstdlib>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/htu21d.h"
#include "hal/errors.h"
#include "util/comm/buffer.h"


namespace Hal
{
namespace Dev
{

using ::Util::Comm::TBuffer;
using ::Util::Comm::TEndian;


THtu21D::TWPtr THtu21D::s_instance;

//-----------------------------------------------------------------------------
THtu21D::TPtr THtu21D::Instance()
{
    TPtr instance;
    if (!(instance = s_instance.lock()))
    {
        instance.reset(new THtu21D());
        s_instance = instance;
    }
    return instance;
}

//-----------------------------------------------------------------------------
THtu21D::THtu21D()
    : m_bus(TBus::Instance())
{
}

//-----------------------------------------------------------------------------
THtu21D::~THtu21D() noexcept
{
}

//-----------------------------------------------------------------------------
float THtu21D::ReadTemperature()
{
#ifndef SIM
    unsigned raw_value = GetMeasurement(0xF3);
    if (raw_value & TMeasurement::HUMIDITY)
    {
        // Unexpected measurement type
        THROW_EXCEPTION(TInvalidResponseError());
    }
    raw_value &= 0xFFFC;

    // See HTU21D datasheet
    const float value =
        (static_cast< float >(175.72 * raw_value) / 0xFFFF) - 46.85;
    return value;
#else
    return (::std::rand() % 5) + 20;
#endif
}

//-----------------------------------------------------------------------------
float THtu21D::ReadHumidity()
{
#ifndef SIM
    unsigned raw_value = GetMeasurement(0xF5);
    if (!(raw_value & TMeasurement::HUMIDITY))
    {
        // Unexpected measurement type
        THROW_EXCEPTION(TInvalidResponseError());
    }
    raw_value &= 0xFFFC;

    // See HTU21D datasheet
    const float value = (static_cast< float >(125 * raw_value) / 0xFFFF) - 6;
    return value;
#else
    return (::std::rand() % 5) + 50;
#endif
}

//-----------------------------------------------------------------------------
void THtu21D::SendCommand(TBus::THandle& bus_handle, unsigned command)
{
    const ::std::uint8_t tmp = command;
    if (-1 == ::write(bus_handle.Get(), &tmp, sizeof(tmp)))
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
}

//-----------------------------------------------------------------------------
unsigned THtu21D::GetMeasurement(unsigned command)
{
    TBus::THandle bus_handle(m_bus->TakeControl(DEFAULT_ADDRESS));

    // Start the measurement
    SendCommand(bus_handle, command);

    // measuring...
    static const unsigned DATA_LEN = 2;
    static const unsigned FOOTER_LEN = 1;

    TBuffer< DATA_LEN + FOOTER_LEN > res;
    unsigned time = 0;
    for(;;)
    {
        static const unsigned T = 10; // ms
        ::std::this_thread::sleep_for(::std::chrono::milliseconds(T));
        time += T;
        if (-1 == ::read(bus_handle.Get(), res.Data(), res.Capacity()))
        {
            if (EIO == errno)
            {
                // Measuring process has not completed yet
            }
            else
            {
                THROW_EXCEPTION(TSystemError(errno));
            }
        }
        else
        {
            // Done
            break;
        }
        if (time >= DEFAULT_TIMEOUT)
        {
            THROW_EXCEPTION(TSystemError(EIO));
        }
    }

    const unsigned value = res.PopAs< ::std::uint16_t >();
    const unsigned crc = res.PopAs< ::std::uint8_t >();

    if (!CheckCrc(res.Data(), DATA_LEN, crc))
    {
        // Bad CRC
        THROW_EXCEPTION(TCorruptDataError());
    }
    return value;
}

//-----------------------------------------------------------------------------
bool THtu21D::CheckCrc(const void* data, ::std::size_t size,
                       unsigned expected_crc) noexcept
{
    static const unsigned POLYNOME = 0x31;  // P(x)=x^8+x^5+x^4+1 = 100110001

	unsigned crc = 0;
    const ::std::uint8_t *p = static_cast< const ::std::uint8_t * >(data);
	for (unsigned i = 0; i < size; ++i)
	{
		crc ^= p[i];
		for (unsigned bit = 8; bit > 0; --bit)
		{
			if (crc & 0x80)
            {
				crc = (crc << 1) ^ POLYNOME;
            }
			else
            {
				crc = (crc << 1);
            }
		}
	}
    crc &= 0xFF;

	return crc == expected_crc;
}

//-----------------------------------------------------------------------------
void THtu21D::OnConfigure()
{
}

} // namespace Dev
} // namespace Hal
