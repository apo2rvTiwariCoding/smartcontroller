// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <cassert>
#include <cstdint>
#include <iostream>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/w1/bus.h"
#include "hal/dev/w1/ds18b20.h"
#include "hal/errors.h"
#include "hal/log.h"
#include "util/comm/buffer.h"


namespace Hal
{
namespace Dev
{
namespace W1
{

using ::Util::Comm::TBuffer;
using ::Util::Comm::TEndian;


//=============================================================================
// TDs2482::TEnumerator
//=============================================================================


/**
 * @brief It implements the device enumeration procedure.
 */
class TBus::TEnumerator
{
public:
    TEnumerator(TDs2482& ds2482)
        : m_ds2482(ds2482)
      {}

    template< class F >
    void ForEach(const F& f);

private:
    TDs2482& m_ds2482;

    bool Search();
    bool FindFirst();
    bool FindNext();


    static const int ROM_CODE_LEN = 8; // bytes
    TBuffer< ROM_CODE_LEN > m_rom_code;

    inline unsigned GetCrc() const noexcept
      {
          return m_rom_code.Underlying()[ROM_CODE_LEN - 1];
      }
    bool CheckCrc() const;

    int m_last_discrepancy; ///< Last discrepancy bit position
    bool m_last_device;    
}; // class TW1Bus::TEnumerator

//-----------------------------------------------------------------------------
template< class F >
void TBus::TEnumerator::ForEach(const F& f)
{
    int restore_discrepancy = m_last_discrepancy;
    bool found = FindFirst();
    while(found)
    {
        if (CheckCrc())
        {
            m_rom_code.Reset();
            const TW1DeviceAddress address =
                m_rom_code.PopAs< ::std::uint64_t, ENDIAN >();
            assert(!m_rom_code.Overflow());
            f(address); 
        }
        else
        {
            if (m_last_discrepancy == restore_discrepancy)
            {
                // Two subsequent fails
                THROW_EXCEPTION(TSystemError(EIO));
            }
            m_last_discrepancy = restore_discrepancy;
        }        

        restore_discrepancy = m_last_discrepancy;
        found = FindNext();
    }
}

//-----------------------------------------------------------------------------
bool TBus::TEnumerator::Search()
{
    unsigned status = m_ds2482.W1Reset();
    if (!(status & TDs2482::TStatus::PPD))
    {
        // Presence pulse was not detected.
        return false;
    }

    m_ds2482.W1WriteByte(TRomCode::SEARCH);


    int byte_index = 0;
    int byte_mask = 0x01;

    int last_zero_direction = -1;
    for(int i = 0; i < ROM_CODE_LEN * 8; i++)
    {
        bool suggested_direction;
        if (i < m_last_discrepancy)
        {
            // Take the same direction since we have already traversed
            // through this part of the tree.
            suggested_direction = m_rom_code.Underlying()[byte_index] & byte_mask;
        }
        else
        {
            // This is the most distand point we have traversed to so far
            // therefore, we need to take different direction this time.
            suggested_direction = (m_last_discrepancy == i);
        }

        const unsigned status =
            m_ds2482.W1GenerateSearchRomSequence(suggested_direction);        

        const bool actual_direction = status & TDs2482::TStatus::DIR;
        if (!(status & TDs2482::TStatus::SBR) &&
            !(status & TDs2482::TStatus::TSB))
        {
            // Discrepancy
            if (false == actual_direction)
            {
                last_zero_direction = i;
            }
        }
        else if ((status & TDs2482::TStatus::SBR) &&
                 (status & TDs2482::TStatus::TSB))
        {
            // Error
            THROW_EXCEPTION(TSystemError(EIO));
        }

        if (actual_direction)
        {
            m_rom_code.Underlying()[byte_index] |= byte_mask;
        }
        else
        {
            m_rom_code.Underlying()[byte_index] &= ~byte_mask;
        }


        byte_mask <<= 1;
        if (byte_mask > 0x80)
        {
            byte_mask = 0x01;
            byte_index++;
        }
    } // for...
    m_last_discrepancy = last_zero_direction;
    m_last_device = (-1 == m_last_discrepancy);

    return 0 != GetCrc();
}

//-----------------------------------------------------------------------------
bool TBus::TEnumerator::FindFirst()
{
    m_rom_code.Underlying().fill(0);
    m_last_discrepancy = -1;
    m_last_device = false;
    return Search();
}

//-----------------------------------------------------------------------------
bool TBus::TEnumerator::FindNext()
{
    if (m_last_device)
    {
        return false;
    }

    return Search();
}

//-----------------------------------------------------------------------------
bool TBus::TEnumerator::CheckCrc() const
{
    const unsigned calculated_crc = TBus::CalculateCrc(
        m_rom_code.Data(), ROM_CODE_LEN - 1);
    return calculated_crc == GetCrc();
}  


//=============================================================================
// TW1Bus
//=============================================================================


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
    : m_ds2482(TDs2482::Instance()),
      m_busy(false)
{
}

//-----------------------------------------------------------------------------
TBus::~TBus() noexcept
{
}

//-----------------------------------------------------------------------------
void TBus::Enumerate()
{
    m_sensors.clear();

#ifdef SIM
    {
        TSensor::TUPtr sensor(
            new TDs18B20(TSensorKey(), *this, 0x000005d3fe5e28));
        m_sensors.push_back(::std::move(sensor));
    }
#else
    TEnumerator enumerator(*m_ds2482);
    enumerator.ForEach([this](const TW1DeviceAddress& address)->void
        {
            TSensor::TUPtr sensor;

            const unsigned family_code = (address & 0xFF);
            switch(family_code)
            {
            case TDs18B20::FAMILY_CODE:
                sensor.reset(new TDs18B20(TSensorKey(), *this, address));
                break;

            default:
                // Not supported
                LOG_WARN_FMT(g_log_section,
                        "the W1 device (family code = %u) is not supported",
                        family_code);
                break;
            }

            if (sensor)
            {
                m_sensors.push_back(::std::move(sensor));
            }
        });
#endif

    for(auto itr = m_sensors.cbegin(); m_sensors.cend() != itr; ++itr)
    {
        (*itr)->Configure();
    }
}

//-----------------------------------------------------------------------------
TBus::THandle TBus::SelectDevice(const TW1DeviceAddress& address)
{
    assert(!IsBusy());

    {
        m_ds2482->W1Reset();
        
        TBuffer< 9 > req;
        req.PushAs< ::std::uint8_t >(TRomCode::MATCH);
        req.PushAs< ::std::uint64_t, ENDIAN >(address);
        assert(req.Index() == req.Capacity());

        m_ds2482->W1WriteData(req.Data(), req.Capacity());
    }

    m_busy = true;
    return THandle(this);
}

//-----------------------------------------------------------------------------
unsigned TBus::CalculateCrc(const void* data, ::std::size_t size)
{
    static const ::std::array< ::std::uint8_t, 256 > table =
    {{
        0, 94, 188, 226, 97, 63, 221, 131, 194, 156, 126, 32, 163, 253, 31, 65,
        157, 195, 33, 127, 252, 162, 64, 30, 95, 1, 227, 189, 62, 96, 130, 220,
        35, 125, 159, 193, 66, 28, 254, 160, 225, 191, 93, 3, 128, 222, 60, 98,
        190, 224, 2, 92, 223, 129, 99, 61, 124, 34, 192, 158, 29, 67, 161, 255,
        70, 24, 250, 164, 39, 121, 155, 197, 132, 218, 56, 102, 229, 187, 89, 7,
        219, 133, 103, 57, 186, 228, 6, 88, 25, 71, 165, 251, 120, 38, 196, 154,
        101, 59, 217, 135, 4, 90, 184, 230, 167, 249, 27, 69, 198, 152, 122, 36,
        248, 166, 68, 26, 153, 199, 37, 123, 58, 100, 134, 216, 91, 5, 231, 185,
        140, 210, 48, 110, 237, 179, 81, 15, 78, 16, 242, 172, 47, 113, 147, 205,
        17, 79, 173, 243, 112, 46, 204, 146, 211, 141, 111, 49, 178, 236, 14, 80,
        175, 241, 19, 77, 206, 144, 114, 44, 109, 51, 209, 143, 12, 82, 176, 238,
        50, 108, 142, 208, 83, 13, 239, 177, 240, 174, 76, 18, 145, 207, 45, 115,
        202, 148, 118, 40, 171, 245, 23, 73, 8, 86, 180, 234, 105, 55, 213, 139,
        87, 9, 235, 181, 54, 104, 138, 212, 149, 203, 41, 119, 244, 170, 72, 22,
        233, 183, 85, 11, 136, 214, 52, 106, 43, 117, 151, 201, 74, 20, 246, 168,
        116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
    }};

    unsigned calculated_crc = 0;
    const ::std::uint8_t* p = static_cast< const ::std::uint8_t* >(data);
    while(size--)
    {
        calculated_crc = table[calculated_crc ^ *p++];
    }
    return calculated_crc;
}

//-----------------------------------------------------------------------------
TBus::THandle::THandle(THandle&& handle) noexcept
    : m_bus(nullptr)
{
    ::std::swap(m_bus, handle.m_bus);
}

//-----------------------------------------------------------------------------
TBus::THandle::~THandle() noexcept
{
    m_bus->ReleaseControl();
}

//-----------------------------------------------------------------------------
void TBus::OnConfigure()
{
    m_ds2482->Configure();
}

} // namespace W1
} // namespace Dev
} // namespace Hal
