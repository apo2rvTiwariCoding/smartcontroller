// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <mutex>
#include <cassert>
#include <iostream>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/hal.h"
#include "hal/driver.h"
#include "hal/errors.h"
#include "hal/log.h"


namespace Hal
{

/// It holds exclusive ownership of the driver and all devices.
static TDriver::TUPtr s_driver;


//-----------------------------------------------------------------------------
int Init() noexcept
{
    TErrorCode error = EC_NO_ERROR;

    try
    {
        s_driver.reset();

        TDriver::TUPtr driver(new TDriver());
        driver->Configure();

        s_driver = ::std::move(driver);
    }
    catch(const TException& e)
    {
        LOG_ERROR(g_log_section, e.ToString());
        error = e.m_error;
    }
    catch(...)
    {
        LOG_ERROR("HAL", "unknown error");
        error = EC_UNKNOWN;
    }

    return error;
}

//-----------------------------------------------------------------------------
bool IsInitialized() noexcept
{
    return static_cast< bool >(s_driver);
}

//-----------------------------------------------------------------------------
template < typename P, typename ...Args >
static int WrapCall(const P& p, Args&& ...args) noexcept
{
    TErrorCode error = EC_NO_ERROR;

    try
    {
        assert(static_cast< bool >(s_driver));
        ((*s_driver).*p)(args...);
    }
    catch(const TException& e)
    {
        LOG_ERROR(g_log_section, e.ToString());
        error = e.m_error;
    }
    catch(...)
    {
        LOG_ERROR(g_log_section, "unknown error");
        error = EC_UNKNOWN;
    }

    return error;
}

//-----------------------------------------------------------------------------
template< typename R, typename P, typename ...Args >
static int WrapCallR(R& ret, const P& p, Args&& ...args) noexcept
{
    TErrorCode error = EC_NO_ERROR;

    try
    {
        assert(static_cast< bool >(s_driver));
        ret = ((*s_driver).*p)(args...);
    }
    catch(const TException& e)
    {
        LOG_ERROR(g_log_section, e.ToString());
        error = e.m_error;
    }
    catch(...)
    {
        LOG_ERROR(g_log_section, "unknown error");
        error = EC_UNKNOWN;
    }

    return error;
}

//-----------------------------------------------------------------------------
int RelaySetPosition(TRelayId id, bool position) noexcept
{
    return WrapCall(&TDriver::RelaySetPosition, id, position);
}

//-----------------------------------------------------------------------------
int RelaysReset() noexcept
{
    return WrapCall(&TDriver::RelaysReset);
}

//-----------------------------------------------------------------------------
int LedSetState(TLedId id, bool on) noexcept
{
    return WrapCall(&TDriver::LedSetState, id, on);
}

//-----------------------------------------------------------------------------
int HumidityGetValue(float& value) noexcept
{
    return WrapCallR(value, &TDriver::HumidityGetValue);
}

//-----------------------------------------------------------------------------
int HumidityPeriodicUpdateStart(int interval,
                                const THumidityCallback& callback) noexcept
{
    return WrapCall(&TDriver::HumidityPeriodicUpdateStart, interval, callback);
}

//-----------------------------------------------------------------------------
int HumidityPeriodicUpdateStop() noexcept
{
    s_driver->HumidityPeriodicUpdateStop();
    return 0;
}

//-----------------------------------------------------------------------------
int TemperatureGetValue(float& value) noexcept
{
    return WrapCallR(value, &TDriver::TemperatureGetValue);
}

//-----------------------------------------------------------------------------
int TemperaturePeriodicUpdateStart(int interval,
                                   const TTemperatureCallback& callback) noexcept
{
    return WrapCall(&TDriver::TemperaturePeriodicUpdateStart, interval,
        callback);
}

//-----------------------------------------------------------------------------
int TemperaturePeriodicUpdateStop() noexcept
{
    s_driver->TemperaturePeriodicUpdateStop();
    return 0;
}

//-----------------------------------------------------------------------------
int AdcGetRawValue(TAdcChannelId channel_id, unsigned& value) noexcept
{
    return WrapCallR(value, &TDriver::AdcGetRawValue, channel_id);
}

//-----------------------------------------------------------------------------
int AdcSetLowLimit(TAdcChannelId channel_id, unsigned threshold) noexcept
{
    return WrapCall(&TDriver::AdcSetLowLimit, channel_id, threshold);
}

//-----------------------------------------------------------------------------
int AdcSetHighLimit(TAdcChannelId channel_id, unsigned threshold) noexcept
{
    return WrapCall(&TDriver::AdcSetHighLimit, channel_id, threshold);
}

//-----------------------------------------------------------------------------
int AdcGetAlerts(TAdcChannelId channel_id, bool& low, bool& high) noexcept
{
    return WrapCall(&TDriver::AdcGetAlerts, channel_id, low, high);
}

//-----------------------------------------------------------------------------
int AdcPeriodicUpdateStart(TAdcChannelId channel_id, int interval,
                           const TAdcCallback& callback) noexcept
{
    return WrapCall(&TDriver::AdcPeriodicUpdateStart, channel_id,
        interval, callback);
}

//-----------------------------------------------------------------------------
int AdcPeriodicUpdateStop(TAdcChannelId channel_id) noexcept
{
    s_driver->AdcPeriodicUpdateStop(channel_id);
    return 0;
}

//-----------------------------------------------------------------------------
int CoGetValue(unsigned& value) noexcept
{
    return WrapCallR(value, &TDriver::CoGetValue);
}

//-----------------------------------------------------------------------------
int CoGetState(bool& state) noexcept
{
    return WrapCallR(state, &TDriver::CoGetState);
}

//-----------------------------------------------------------------------------
int CoSetThreshold(unsigned threshold) noexcept
{
    return WrapCall(&TDriver::CoSetThreshold, threshold);
}

//-----------------------------------------------------------------------------
int CoPeriodicUpdateStart(int interval, const TCoCallback& callback) noexcept
{
    return WrapCall(&TDriver::CoPeriodicUpdateStart, interval, callback);
}

//-----------------------------------------------------------------------------
int CoPeriodicUpdateStop() noexcept
{
    return WrapCall(&TDriver::CoPeriodicUpdateStop);
}

//-----------------------------------------------------------------------------
int Co2GetValue(float& value) noexcept
{
    return WrapCallR(value, &TDriver::Co2GetValue);
}

//-----------------------------------------------------------------------------
int Co2PeriodicUpdateStart(int interval, const TCo2Callback& callback) noexcept
{
    return WrapCall(&TDriver::Co2PeriodicUpdateStart, interval, callback);
}

//-----------------------------------------------------------------------------
int Co2PeriodicUpdateStop() noexcept
{
    return WrapCall(&TDriver::Co2PeriodicUpdateStop);
}

//-----------------------------------------------------------------------------
int RtcSet(const TRtcTime& time) noexcept
{
    return WrapCall(&TDriver::RtcSet, time);
}

//-----------------------------------------------------------------------------
int RtcGet(TRtcTime& time, bool& running) noexcept
{
    return WrapCallR(running, &TDriver::RtcGet, time);
}

//-----------------------------------------------------------------------------
int InterruptsGetStatuses(unsigned& mask) noexcept
{
    return WrapCallR(mask, &TDriver::InterruptsGetStatuses);
}

//-----------------------------------------------------------------------------
int InterruptsRegisterHandler(const TInterruptsHandler& handler) noexcept
{
    return WrapCall(&TDriver::InterruptsRegisterHandler, handler);
}

//-----------------------------------------------------------------------------
int W1Enumerate(TW1DevicesInfo& devices_info) noexcept
{
    return WrapCall(&TDriver::W1Enumerate, devices_info);
}

//-----------------------------------------------------------------------------
int W1GetValue(const TW1DeviceAddress& address, TW1DeviceType& type,
        float& value) noexcept
{
    typedef float (TDriver::*TMethod)(const TW1DeviceAddress&, TW1DeviceType&);
    return WrapCallR(value, static_cast< TMethod >(&TDriver::W1GetValue),
            address, type);
}

//-----------------------------------------------------------------------------
int W1PeriodicUpdateStart(const TW1DeviceAddress& address, int interval,
                          const TW1Callback& callback) noexcept
{
    return WrapCall(&TDriver::W1PeriodicUpdateStart,
        address, interval, callback);
}

//-----------------------------------------------------------------------------
int W1PeriodicUpdateStop(const TW1DeviceAddress& address) noexcept
{
    return WrapCall(&TDriver::W1PeriodicUpdateStop, address);
}

//-----------------------------------------------------------------------------
int I2cDeviceEnable(TI2cDeviceType type) noexcept
{
    return WrapCall(&TDriver::I2cDeviceEnable, type);
}

//-----------------------------------------------------------------------------
int I2cDeviceDisable(TI2cDeviceType type) noexcept
{
    return WrapCall(&TDriver::I2cDeviceDisable, type);
}

//-----------------------------------------------------------------------------
int I2cGetValue(TI2cDeviceType type, float& value) noexcept
{
    typedef float (TDriver::*TMethod)(TI2cDeviceType);
    return WrapCallR(value, static_cast< TMethod >(&TDriver::I2cGetValue), type);
}

//-----------------------------------------------------------------------------
int I2cPeriodicUpdateStart(TI2cDeviceType type, int interval,
                           const TI2cCallback& callback) noexcept
{
    return WrapCall(&TDriver::I2cPeriodicUpdateStart, type, interval, callback);
}

//-----------------------------------------------------------------------------
int I2cPeriodicUpdateStop(TI2cDeviceType type) noexcept
{
    return WrapCall(&TDriver::I2cPeriodicUpdateStop, type);
}

} // namespace Hal
