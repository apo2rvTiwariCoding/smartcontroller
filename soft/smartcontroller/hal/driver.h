#ifndef FILE_HAL_DRIVER_H
#define FILE_HAL_DRIVER_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>
#include <array>
#include <mutex>
#include <thread>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/ad5245.h"
#include "hal/dev/ad7993.h"
#include "hal/dev/ds1338.h"
#include "hal/dev/htu21d.h"
#include "hal/dev/mcp23017_u2.h"
#include "hal/dev/mcp23017_u4.h"
#include "hal/dev/w1/bus.h"
#include "hal/dev/i2c_ext/sensor.h"


namespace Hal
{

/**
 * @brief It provides all the necessary functionality required by the HAL
 *        interface in a thread-safe manner.
 */
class TDriver
{
public:
    typedef ::std::unique_ptr< TDriver > TUPtr;

    /**
     * @brief It initializes all the devices.
     * @throw TException
     */
    TDriver();
    virtual ~TDriver();


    /**
     * @brief It configures the devices.
     * @throw TException
     */
    void Configure();

private:
    /// The mutex guards only the driver layer (accesses to agregated
    /// devices)
    mutable ::std::mutex m_mutex;

    typedef ::std::lock_guard< ::std::mutex > TLockGuard;

    class TTimer;
    typedef ::std::shared_ptr< TTimer > TTimerPtr;
    class TTimersManager;
    const ::std::shared_ptr< TTimersManager > m_timers_manager;


    /// Relays, LEDs, ... (exclusive ownership)
    const Dev::TMcp23017_U2::TPtr m_mcp23017_u2;
    /// Interrupts (exclusive ownership)
    const Dev::TMcp23017_U4::TPtr m_mcp23017_u4;
    /// Digital potentiometer (exclusive ownership)
    const Dev::TAd5245::TPtr m_ad5245;
    /// Temperature & humidity sensor (exclusive ownership)
    const Dev::THtu21D::TPtr m_htu21d;
    /// RTC (exclusive ownership)
    const Dev::TDs1338::TPtr m_ds1338;
    /// ADC (exclusive ownership)
    const Dev::TAd7993::TPtr m_ad7993;
    /// 1-Wire bus (exclusive ownership)
    const Dev::W1::TBus::TPtr m_w1_bus;

    static const unsigned DEVICES_COUNT = 7;
    const ::std::array< Dev::TDevice*, DEVICES_COUNT > m_devices;


public: // Relays
    void RelaySetPosition(TRelayId id, bool position);
    void RelaysReset();


public: // Leds
    void LedSetState(TLedId id, bool on);


public: // RTC
    void RtcSet(const TRtcTime& time);
    bool RtcGet(TRtcTime& time);


public: // Humidity
    float HumidityGetValue();
    void HumidityPeriodicUpdateStart(int interval,
        const THumidityCallback& callback);
    void HumidityPeriodicUpdateStop() noexcept;

private:
    const TTimerPtr m_humidity_timer;
    void OnReadHumidity() noexcept;
    THumidityCallback m_humidity_callback;


public: // Temperature
    float TemperatureGetValue();
    void TemperaturePeriodicUpdateStart(int interval,
        const TTemperatureCallback& callback);
    void TemperaturePeriodicUpdateStop() noexcept;

private:
    const TTimerPtr m_temperature_timer;
    void OnReadTemperature() noexcept;
    TTemperatureCallback m_temperature_callback;


public: // ADC
    unsigned AdcGetRawValue(TAdcChannelId channel_id);
    void AdcSetLowLimit(TAdcChannelId channel_id, unsigned threshold);
    void AdcSetHighLimit(TAdcChannelId channel_id, unsigned threshold);
    void AdcGetAlerts(TAdcChannelId channel_id, bool& low, bool& high);
    void AdcPeriodicUpdateStart(TAdcChannelId channel_id, int interval,
                           const TAdcCallback& callback);
    void AdcPeriodicUpdateStop(TAdcChannelId channel_id) noexcept;

private:
    static Dev::TAd7993::TInputId AdcChannelToInputId(TAdcChannelId channel_id);
    struct TAdcChannelPeriodicUpdate
    {
        TAdcChannelPeriodicUpdate(TDriver& parent, TTimersManager& timers_manager,
            TAdcChannelId channel_id);

        TDriver& m_parent;
        const TAdcChannelId m_channel_id;
        const TTimerPtr m_timer;
        TAdcCallback m_callback;

        void Start(int interval, const TAdcCallback& callback);
        inline void Stop();
        void OnRead() noexcept;
    };
    typedef ::std::array< TAdcChannelPeriodicUpdate,
        ADC_CHANNELS_COUNT > TAdcChannelsPeriodicUpdate;
    TAdcChannelsPeriodicUpdate m_adc_channels_periodic_update;


public: // CO
    unsigned CoGetValue();
    bool CoGetState();
    void CoSetThreshold(unsigned threshold);
    void CoPeriodicUpdateStart(int interval, const TCoCallback& callback);
    void CoPeriodicUpdateStop();
private:
    static unsigned CoScaleValue(unsigned raw_value);
    const TTimerPtr m_co_timer;
    void OnReadCo() noexcept;
    TCoCallback m_co_callback;


public: // CO2
    float Co2GetValue();
    void Co2PeriodicUpdateStart(int interval, const TCo2Callback& callback);
    void Co2PeriodicUpdateStop();

private:
    const TTimerPtr m_co2_timer;
    void OnReadCo2() noexcept;
    TCo2Callback m_co2_callback;


public: // W1
    void W1Enumerate(TW1DevicesInfo& devices_info);
    float W1GetValue(const TW1DeviceAddress& address, TW1DeviceType& type);
    void W1PeriodicUpdateStart(const TW1DeviceAddress& address, int interval,
        const TW1Callback& callback);
    void W1PeriodicUpdateStop(const TW1DeviceAddress& address);

private:
    float W1GetValue(const TW1DeviceAddress& address, const TLockGuard&);
    // @pre Lock the hal
    unsigned W1AddressToDeviceId(const TW1DeviceAddress& address) const;

    struct TW1DevicePeriodicUpdate :
            ::std::enable_shared_from_this< TW1DevicePeriodicUpdate >
    {
        typedef ::std::shared_ptr< TW1DevicePeriodicUpdate > TPtr;

        TW1DevicePeriodicUpdate(TDriver& parent, TTimersManager& timers_manager,
             const TW1DeviceInfo& device_info);

        TDriver& m_parent;
        const TW1DeviceInfo m_device_info;
        TW1Callback m_callback;
        const TTimerPtr m_timer;

        void Start(int interval, const TW1Callback& callback);
        inline void Stop();
        void OnRead() noexcept;
    };
    typedef ::std::vector< TW1DevicePeriodicUpdate::TPtr > TW1DevicesPeriodicUpdate;
    TW1DevicesPeriodicUpdate m_w1_devices_periodic_update;


public: // I2C
    void I2cDeviceEnable(TI2cDeviceType type);
    void I2cDeviceDisable(TI2cDeviceType type);
    float I2cGetValue(TI2cDeviceType type);
    void I2cPeriodicUpdateStart(TI2cDeviceType type, int interval,
        const TI2cCallback& callback);
    void I2cPeriodicUpdateStop(TI2cDeviceType type) noexcept;

private:
    struct TI2cDevicePeriodicUpdate :
            ::std::enable_shared_from_this< TI2cDevicePeriodicUpdate >
    {
        typedef ::std::shared_ptr< TI2cDevicePeriodicUpdate > TPtr;

        TI2cDevicePeriodicUpdate(TDriver& parent, Dev::I2cExt::TSensor::TUPtr device);

        TDriver& m_parent;
        const Dev::I2cExt::TSensor::TUPtr m_device;
        const TTimerPtr m_timer;
        TI2cCallback m_callback;

        void OnRead() noexcept;
    };
    typedef ::std::array< TI2cDevicePeriodicUpdate::TPtr,
            I2C_DEVICE_TYPES_COUNT > TI2cDevicesPeriodicUpdate;
    TI2cDevicesPeriodicUpdate m_i2c_devices_periodic_update;


public: // Interrupts
    unsigned InterruptsGetStatuses();
    void InterruptsRegisterHandler(const TInterruptsHandler& handler);

private:
    class TInterruptDebouncer;
    class TInterruptsListener;
    class TInterruptsDispatcher;
    ::std::unique_ptr< TInterruptsListener > m_interrupts_listener;
    inline bool WaitForInterrupt(int timeout);
    void OnInterrupt(unsigned changed, unsigned statuses, int error);
    TInterruptsHandler m_interrupts_handler;
}; // class TDriver

} // namespace Hal

#endif // #ifndef FILE_HAL_DRIVER_H
