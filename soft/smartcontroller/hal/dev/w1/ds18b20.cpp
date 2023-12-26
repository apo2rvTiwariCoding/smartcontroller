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
#include "hal/dev/w1/ds18b20.h"
#include "hal/dev/w1/bus.h"
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


// 9 bits resolution traits.
template<>
struct TDs18B20::TResolutionTraits< 9 >
{
    /// Configuration register
    static const unsigned CONFIGURATION = 0x1F;

    static const float K;
    static const unsigned SHIFT = 3;
};
const float TDs18B20::TResolutionTraits< 9 >::K = 0.5;

// 10 bits resolution traits.
template<>
struct TDs18B20::TResolutionTraits< 10 >
{
    /// Configuration register
    static const unsigned CONFIGURATION = 0x3F;

    static const float K;
    static const unsigned SHIFT = 2;
};
const float TDs18B20::TResolutionTraits< 10 >::K = 0.25;

// 11 bits resolution traits.
template<>
struct TDs18B20::TResolutionTraits< 11 >
{
    /// Configuration register
    static const unsigned CONFIGURATION = 0x5F;

    static const float K;
    static const unsigned SHIFT = 1;
};
const float TDs18B20::TResolutionTraits< 11 >::K = 0.125;

// 12 bits resolution traits.
template<>
struct TDs18B20::TResolutionTraits< 12 >
{
    /// Configuration register
    static const unsigned CONFIGURATION = 0x7F;

    static const float K;
    static const unsigned SHIFT = 0;
};
const float TDs18B20::TResolutionTraits< 12 >::K = 0.0625;

//-----------------------------------------------------------------------------
TDs18B20::TDs18B20(const TSensorKey&, TBus& bus, 
                   const TW1DeviceAddress& address)
    : TSensor(bus, TW1DeviceInfo(W1_DT_TEMPERATURE, address))
{
}

//-----------------------------------------------------------------------------
TDs18B20::~TDs18B20() noexcept
{
}

//-----------------------------------------------------------------------------
void TDs18B20::OnConfigure()
{
#ifndef SIM
    {
        TBus::THandle handle = m_bus.SelectDevice(m_info.m_address);

        handle.W1WriteByte(TCommand::WRITE_SCRATCHPAD);
    
        static const ::std::size_t SCRATCHPAD_LEN = 3;
        TBuffer< SCRATCHPAD_LEN > req;
        req.PushAs< uint8_t >(0); // Th register
        req.PushAs< uint8_t >(0); // Tl register
        req.PushAs< uint8_t >(TResolution::CONFIGURATION); // Configuraion register
        assert(req.Index() == req.Capacity());

        handle.W1WriteData(req.Data(), req.Capacity());
    }

    {
        TBus::THandle handle = m_bus.SelectDevice(m_info.m_address);

        handle.W1WriteByte(TCommand::READ_SCRATCHPAD);
        static const ::std::size_t SCRATCHPAD_LEN = 9;
        TBuffer< SCRATCHPAD_LEN > res;
        handle.W1ReadData(res.Data(), res.Capacity());

        const unsigned calculated_crc =
            TBus::CalculateCrc(res.Data(), SCRATCHPAD_LEN - 1);
        const unsigned received_crc = res.Data()[SCRATCHPAD_LEN - 1];
        if (calculated_crc != received_crc)
        {
            // bad CRC
            THROW_EXCEPTION(TCorruptDataError());
        }
    }
#endif // #ifndef SIM
}

//-----------------------------------------------------------------------------
float TDs18B20::OnReadValue()
{
#ifndef SIM
    static const unsigned MAX_CONVERSION_TIME = 750;
    {
        TBus::THandle handle = m_bus.SelectDevice(m_info.m_address);

        handle.W1WriteByte(TCommand::CONVERT);

        unsigned time = 0;
        unsigned status;
        do
        {
            if (time > MAX_CONVERSION_TIME)
            {
                THROW_EXCEPTION(TSystemError(EIO));
            }
            ::std::this_thread::sleep_for(::std::chrono::milliseconds(50));
            time += 50;

            status = handle.W1ReadByte();
        } while(0 == status);
    }

    float value;
    {
        TBus::THandle handle = m_bus.SelectDevice(m_info.m_address);

        handle.W1WriteByte(TCommand::READ_SCRATCHPAD);
        static const ::std::size_t SCRATCHPAD_LEN = 9;
        TBuffer< SCRATCHPAD_LEN > res;
        handle.W1ReadData(res.Data(), res.Capacity());

        const unsigned calculated_crc =
            TBus::CalculateCrc(res.Data(), SCRATCHPAD_LEN - 1);
        const unsigned received_crc = res.Data()[SCRATCHPAD_LEN - 1];
        if (calculated_crc != received_crc)
        {
            // bad CRC
            THROW_EXCEPTION(TCorruptDataError());
        }

        value = Convert< TResolution >(res.PopAs< ::std::uint16_t, TBus::ENDIAN >());
    }
    return value;
#else
    return (::std::rand() % 5) + 20;
#endif // #ifndef SIM
}

//-----------------------------------------------------------------------------
template< typename T >
float TDs18B20::Convert(unsigned raw)
{
    raw >>= T::SHIFT;
    if (raw & (0xF800 >> T::SHIFT))
    {
        return static_cast< float >(raw) * -T::K;
    }
    else
    {
        return static_cast< float >(raw) * T::K;
    }
}

} // namespace W1
} // namespace Dev
} // namespace Hal
