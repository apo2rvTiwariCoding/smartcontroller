#ifndef FILE_HAL_DEV_DS1338_H
#define FILE_HAL_DEV_DS1338_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/bus.h"
#include "hal/dev/device.h"
#include "hal/hal.h"


namespace Hal
{
namespace Dev
{

/**
 * @brief RTC IC (DS1338).
 */
class TDs1338 : public TDevice
{
public:
    typedef ::std::shared_ptr< TDs1338 > TPtr;

    /**
     * @throw TException
     */
    static TPtr Instance();

private:
    TDs1338();

    typedef ::std::weak_ptr< TDs1338 > TWPtr;
    static TWPtr s_instance;

public:
    virtual ~TDs1338() noexcept;


public:
    /// The IC default address.
    static const int DEFAULT_ADDRESS = 0x68;

    /**
     * @brief It reads the current time from the IC.
     * @throw TException
     * @return If false, the RTC osillator has been stopped due to the
     * following reasons:
     * - The first time power is applied.
     * - The voltage present on VCC and VBAT are insufficient to support
     *   oscillation.
     * - The CH bit is set to 1, disabling the oscillator.
     * - External influences on the crystal (i.e., noise, leakage, etc.).
     */
    bool ReadTime(TRtcTime& time);

    /**
     * @brief It writes the given time to the IC.
     * @throw TException
     */
    void WriteTime(const TRtcTime& time);

private:
    enum TRegister
    {
        SECONDS = 0x00,
        MINUTES = 0x01,
        HOURS = 0x02,
        DAY = 0x03,
        DATE = 0x04,
        MONTH = 0x05,
        YEAR = 0x06,
        CONTROL = 0x07
    };

    enum TControlRegister
    {
        RS0 = 0x01,
        RS1 = 0x02,
        SQWE = 0x10,
        OSF = 0x20,
        OUT = 0x80
    };

    static const TControlRegister DEFAULT_CONTROL = TControlRegister::OUT;

private:
    const TBus::TPtr m_bus;

private: // TDevice
    virtual void OnConfigure();
}; // class TDs1338

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_DS1338_H
