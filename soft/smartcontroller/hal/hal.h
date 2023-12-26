/**
 * @brief HAL public header.
 */

#ifndef FILE_HAL_HAL_H
#define FILE_HAL_HAL_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <vector>
#include <cstdint>
#include <functional>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------


/**
 * @note All the function are thread-safe unless otherwise specified.
 * @note Callbacks should return as soon as possible since they are not
 * decoupled from the HAL internal logic! This does not apply to the
 * interrupt callback.
 */
namespace Hal
{

    // HAL error codes
    enum TErrorCode
    {
        EC_NO_ERROR = 0,
        EC_SYSTEM,
        EC_INVALID_RESPONSE,
        EC_CORRUPT_DATA,
        EC_INVALID_ARGUMENT,
        EC_RESOURCE_NOT_AVAILABLE,
        EC_UNKNOWN
    };

    /**
     * @brief It (re)initializes the HAL.
     * @note This method is not thread-safe!!!
     *
     * If this fails, either some of the ICs were unable to be initialized or
     * a critical system (unrecoverable) error occurred.
     */
    int Init() noexcept;

    /**
     * @brief It returns true if HAL has been successfully initialized.
     */
    bool IsInitialized() noexcept;


    //=============================================================================
    // Relays
    //=============================================================================


    /// Relays identifiers
    enum TRelayId
    {
        RELAY_K1,  // Y1 bypass relay (HVAC)
        RELAY_K2,  // Y1 main relay (HVAC)
        RELAY_K3,  // RcRh bridge relay (HVAC)
        RELAY_K4,  // Y2 bypass relay (HVAC)
        RELAY_K5,  // Y2 main relay (HVAC)
        RELAY_K6,  // Humidifier relay
        RELAY_K7,  // G bypass relay (HVAC)
        RELAY_K8,  // G main relay (HVAC)
        RELAY_K9,  // OB bypass relay (HVAC)
        RELAY_K10, // OB main relay (HVAC)
        RELAY_K11, // R1 relay (User defined)
        RELAY_K12, // R4 relay (User defined)
        RELAY_K13, // Aux bypass relay (HVAC)
        RELAY_K14, // Aux main relay (HVAC)
        RELAY_K15, // R2 relay (User defined)
        RELAY_K16, // R5 relay (User defined)
        RELAY_K17, // W1 bypass relay (HVAC)
        RELAY_K18, // W1 main relay (HVAC)
        RELAY_K19, // R3 relay (User defined)
        RELAY_K20, // R6 relay (User defined)
        RELAY_K21, // W2 bypass relay (HVAC)
        RELAY_K22  // W2 main relay (HVAC)
    };
    static const unsigned RELAYS_COUNT = RELAY_K22 + 1;

    /**
     * @brief It sets the relay position.
     * @param position
     * false = low, true = high
     */
    int RelaySetPosition(TRelayId id, bool position) noexcept;

    /**
     * @brief It switches off all the relays. This is much faster than 
     *        switching them individually.
     */
    int RelaysReset() noexcept;


    //=============================================================================
    // LEDs
    //=============================================================================


    /// LEDs identifiers
    enum TLedId
    {
        LED_GREEN = 0,
        LED_RED
    };
    static const unsigned LEDS_COUNT = LED_RED + 1;

    /**
     * @brief It sets the LED state.
     * @param position
     * false = switched off, true = switched on
     */
    int LedSetState(TLedId id, bool on) noexcept;


    //=============================================================================
    // Humidity sensor
    //=============================================================================


    /**
     * @brief It reads humidity.
     * @param value
     * Relative humidity in %
     */
    int HumidityGetValue(float& value) noexcept;

    /// A callback function called by HAL layer on a periodic basis.
    typedef ::std::function< void(float value, int error) > THumidityCallback;

    /**
     * @brief It (re)starts periodic reading of humidity.
     * @param interval
     * Milliseconds 
     */
    int HumidityPeriodicUpdateStart(int interval,
                                    const THumidityCallback& callback) noexcept;

    /**
     * @brief It stops periodic reading of humidity.
     */
    int HumidityPeriodicUpdateStop() noexcept;


    //=============================================================================
    // Temperature sensor
    //=============================================================================


    /**
     * @brief It reads temperature.
     * @param value
     * Temperature in st. C.
     */
    int TemperatureGetValue(float& value) noexcept;

    /// A callback function called by HAL layer on a periodic basis.
    typedef ::std::function< void(float value, int error) > TTemperatureCallback;

    /**
     * @brief It (re)starts periodic reading of temperature.
     * @param interval
     * Milliseconds 
     */
    int TemperaturePeriodicUpdateStart(int interval,
                                    const TTemperatureCallback& callback) noexcept;

    /**
     * @brief It stops periodic reading of temperature.
     */
    int TemperaturePeriodicUpdateStop() noexcept;


    //=============================================================================
    // ADC
    //=============================================================================


    /// The channels
    enum TAdcChannelId
    {
        ADC_CH1, // Reserved for CO (not physically exposed on SB)
        ADC_CH2, // P17
        ADC_CH3, // P18
        ADC_CH4  // P20
    };
    static const unsigned ADC_CHANNELS_COUNT = TAdcChannelId::ADC_CH4 + 1;

    /**
     * @brief It performs sampling and returns the sample raw value.
     * @param value
     * Raw value within the range from 0 to 1023.
     */
    int AdcGetRawValue(TAdcChannelId channel_id, unsigned& value) noexcept;

    /**
     * @brief It sets the low input value limit on a particular channel.
     * @param threshold
     * A value within the range from 0 to 1023.
     */
    int AdcSetLowLimit(TAdcChannelId channel_id, unsigned threshold) noexcept;

    /**
     * @brief It sets the high input value limit on a particular channel.
     * @param threshold
     * A value within the range from 0 to 1023.
     */
    int AdcSetHighLimit(TAdcChannelId channel_id, unsigned threshold) noexcept;

    /**
     * @brief It gets active alerts for the particular channel.
     */
    int AdcGetAlerts(TAdcChannelId channel_id, bool& low, bool& high) noexcept;

    /// A callback function called by HAL layer on a periodic basis.
    typedef ::std::function< void(TAdcChannelId channel_id, unsigned value,
        int error) > TAdcCallback;

    /**
     * @brief It (re)starts periodic reading of samples.
     * @param interval
     * Milliseconds 
     */
    int AdcPeriodicUpdateStart(TAdcChannelId channel_id, int interval,
                            const TAdcCallback& callback) noexcept;

    /**
     * @brief It stops periodic reading of samples.
     */
    int AdcPeriodicUpdateStop(TAdcChannelId channel_id) noexcept;


    //=============================================================================
    // CO sensor
    //=============================================================================


    /**
     * @brief It reads CO value.
     * @param value
     * CO concentration in ppm (range 0 to aprox. 10000).
     */
    int CoGetValue(unsigned& value) noexcept;

    /**
     * @brief It sets the CO threshold. If CO level rises above the threshold,
     *        CO interrupt will occur.
     * @param threshold
     * Valid range is 0 - 10000
     */
    int CoSetThreshold(unsigned threshold) noexcept;

    /**
     * @brief It gets the CO state.
     * If CO level is above the threshold, the state is true. 
     */
    int CoGetState(bool& state) noexcept;


    /// A callback function called by HAL layer on a periodic basis.
    typedef ::std::function< void(unsigned value, int error) > TCoCallback;

    /**
     * @brief It (re)starts periodic reading of CO state.
     * @param interval
     * Milliseconds 
     */
    int CoPeriodicUpdateStart(int interval, const TCoCallback& callback) noexcept;

    /**
     * @brief It stops periodic reading of CO state.
     */
    int CoPeriodicUpdateStop() noexcept;


    //=============================================================================
    // CO2 sensor
    //=============================================================================


    /**
     * @brief It gets the C02 level.
     */
    int Co2GetValue(float& value) noexcept;


    /// A callback function called by HAL layer on a periodic basis.
    typedef ::std::function< void(float value, int error) > TCo2Callback;

    /**
     * @brief It (re)starts periodic reading of CO2 level.
     * @param interval
     * Milliseconds 
     */
    int Co2PeriodicUpdateStart(int interval, const TCo2Callback& callback) noexcept;

    /**
     * @brief It stops periodic reading of CO2 state.
     */
    int Co2PeriodicUpdateStop() noexcept;


    //=============================================================================
    // RTC
    //=============================================================================


    /// It holds time information.
    struct TRtcTime
    {
        int m_years; //!< Range 0-99
        int m_months; //!< Range 1-12
        int m_day_of_month; //!< Range 1-31
        int m_day_of_week; //!< Range 1-7
        int m_hours; //!< Range 0-23
        int m_minutes; //!< Range 0-59
        int m_seconds; //!< Range 0-59
    }; // struct TTime

    /**
     * @brief It writes the given time to the RTC
     */
    int RtcSet(const TRtcTime& time) noexcept;

    /**
     * @brief It reads time from the RTC.
     * @param running
     * If true, the RTC is running. Otherwise, the RTC oscillator is stopped for
     * some reason.
     */
    int RtcGet(TRtcTime& time, bool& running) noexcept;


    //=============================================================================
    // Interrupts
    //=============================================================================


    // Interrupts identifiers
    enum TInterruptId
    {
        INT_THERM_Y1 = 0,
        INT_THERM_Y2,
        INT_THERM_G,
        INT_THERM_O_B,
        INT_BYPASS_SWITCH,
        INT_THERM_AUX,
        INT_THERM_W1,
        INT_THERM_W2,
        INT_HUMIDIFIER,
        INT_HVAC_RH,
        INT_HVAC_RC,
        INT_CO,
        INT_ADC_ALR
    };
    static const unsigned INTERRUPTS_COUNT = INT_ADC_ALR + 1;

    /**
     * @brief It returns a bit mask of currently active interrupts.
     */
    int InterruptsGetStatuses(unsigned& mask) noexcept;

    /// A handler function called by HAL layer when an interrupt is detected.
    typedef ::std::function< void(unsigned changed,
        unsigned statuses, int error) > TInterruptsHandler;

    /**
     * @brief It registers the given interrupt handler.
     */
    int InterruptsRegisterHandler(const TInterruptsHandler& handler) noexcept;


    //*****************************************************************************
    //*****************************************************************************
    // External devices
    //*****************************************************************************
    //*****************************************************************************


    //=============================================================================
    // 1-Wire devices
    //=============================================================================


    // W1 device types
    enum TW1DeviceType
    {
        W1_DT_UNKNOWN,
        W1_DT_TEMPERATURE,
        W1_DT_HUMIDITY,
        W1_DT_VELOCITY,
        W1_DT_ILLUMINATION,
        W1_DT_PRESSURE,
        W1_DT_CO,
        W1_DT_CO2
    };

    /// 1-Wire device address.
    typedef ::std::uint64_t TW1DeviceAddress;

    // It holds W1 device info.
    struct TW1DeviceInfo
    {
        TW1DeviceInfo() : m_type(W1_DT_UNKNOWN) {};
        TW1DeviceInfo(TW1DeviceType type, const TW1DeviceAddress& address)
            : m_type(type),
            m_address(address)
        {}

        TW1DeviceType m_type;
        TW1DeviceAddress m_address;
    };
    typedef ::std::vector< TW1DeviceInfo > TW1DevicesInfo;

    /**
     * @brief It enumerates the devices connected to the 1-Wire bus.
     * @param [out] devices_info
     * List of devices that have been found.
     */
    int W1Enumerate(TW1DevicesInfo& devices_info) noexcept;

    /**
     * @brief It reads the sensor value.
     */
    int W1GetValue(const TW1DeviceAddress& address, TW1DeviceType& type, float& value) noexcept;

    /// A callback function called by HAL layer on a periodic basis.
    typedef ::std::function< void(const TW1DeviceInfo& device_info, float data,
        int error) > TW1Callback;

    /**
     * @brief It (re)starts periodic reading of data on a particular device.
     * @param interval
     * Milliseconds 
     */
    int W1PeriodicUpdateStart(const TW1DeviceAddress& address, int interval,
                            const TW1Callback& callback) noexcept;

    /**
     * @brief It stops periodic reading of data on a particular device.
     */
    int W1PeriodicUpdateStop(const TW1DeviceAddress& address) noexcept;


    //=============================================================================
    // I2C devices
    //=============================================================================


    /// I2C device types
    enum TI2cDeviceType
    {
        I2C_DEV_F400_VELOCITY,
        I2C_DEV_F400_TEMPERATURE
    };
    static const unsigned I2C_DEVICE_TYPES_COUNT = I2C_DEV_F400_TEMPERATURE + 1;

    /**
     * @brief It checks if device is present on the bus and enables it.
     * The function should be called prior calling other functions associated
     * with the particular device.
     */
    int I2cDeviceEnable(TI2cDeviceType type) noexcept;

    /**
     * @brief Nothing but disables the device.
     */
    int I2cDeviceDisable(TI2cDeviceType type) noexcept;

    /**
     * @brief It reads the device value.
     */
    int I2cGetValue(TI2cDeviceType type, float& value) noexcept;

    /// A callback function called by HAL layer on a periodic basis.
    typedef ::std::function< void(TI2cDeviceType type, float data,
        int error) > TI2cCallback;

    /**
     * @brief It (re)starts periodic reading of data on a particular device.
     * @param interval
     * Milliseconds
     */
    int I2cPeriodicUpdateStart(TI2cDeviceType type, int interval,
                            const TI2cCallback& callback) noexcept;

    /**
     * @brief It stops periodic reading of data on a particular device.
     */
    int I2cPeriodicUpdateStop(TI2cDeviceType type) noexcept;

} // namespace Hal

#endif // #ifndef FILE_HAL_HAL_H
