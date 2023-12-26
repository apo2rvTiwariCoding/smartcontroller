// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <queue>
#include <mutex>
#include <chrono>
#include <thread>
#include <cassert>
#include <iostream>
#include <condition_variable>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/hal.h"
#include "hal/dev/ad7993.h"
#ifdef TEST
#include "hal/errors.h"
#include "hal/dev/w1/bus.h"
#include "hal/dev/w1/ds2482.h"
#endif


using namespace Hal;

//-----------------------------------------------------------------------------
::std::ostream& operator<<(::std::ostream& out, const TRtcTime& time)
{
    out << time.m_years << '/'
        << time.m_months << '/'
        << time.m_day_of_month << " ("
        << time.m_day_of_week << ") "
        << time.m_hours << ':'
        << time.m_minutes << ':'
        << time.m_seconds << ' ';
    return out;
}

//-----------------------------------------------------------------------------
static void OnInterrupt(unsigned activated, unsigned status, int error)
{
    ::std::cout << "On interrupt (error = " << error
                << "): 0x" << ::std::hex << activated << ::std::dec
                << ", 0x" << ::std::hex << status << ::std::dec << '\n';
}

//-----------------------------------------------------------------------------
static void OnHumidity(float value, int error)
{
    ::std::cout << "On humidity (error = "
                << error << "): " << value << '\n';
}

//-----------------------------------------------------------------------------
static void OnTemperature(float value, int error)
{
    ::std::cout << "On temperature (error = "
                << error << "): " << value << '\n';
}

//-----------------------------------------------------------------------------
static void OnAdc(TAdcChannelId channel_id, float value, int error)
{
    ::std::cout << "On ADC channel " << channel_id << " (error = "
                << error << "): " << value << '\n';
}

//-----------------------------------------------------------------------------
static void OnW1Measurement(const TW1DeviceInfo& device_info, float value,
                            int error)
{
    ::std::cout << "On W1 device "
                << ::std::hex << device_info.m_address << ::std::dec
                << ", " << device_info.m_type << " (error = " << error << "): "
                << value << '\n';
}

//-----------------------------------------------------------------------------
static void OnCo(bool state, int error)
{
    ::std::cout << "On CO (error = " << error << "): " << state << '\n';
}

static void OnI2cPeriodicUpdateStart(TI2cDeviceType type, float value, int error);

//-----------------------------------------------------------------------------
static void OnCo2(float value, int error)
{
    ::std::cout << "On CO2 (error = " << error << "): " << value << '\n';

#if 0
    static int i = 0;
    switch(i)
    {
    case 0:
        i = 1;
        {
            HumidityPeriodicUpdateStop();
            TemperaturePeriodicUpdateStop();
            AdcPeriodicUpdateStop(ADC_CH1);
            AdcPeriodicUpdateStop(ADC_CH2);
            AdcPeriodicUpdateStop(ADC_CH3);
            AdcPeriodicUpdateStop(ADC_CH4);
            CoPeriodicUpdateStop();
            I2cPeriodicUpdateStop(I2C_DEV_F400_VELOCITY);
            I2cPeriodicUpdateStop(I2C_DEV_F400_TEMPERATURE);
            I2cDeviceDisable(I2C_DEV_F400_VELOCITY);
            I2cDeviceDisable(I2C_DEV_F400_TEMPERATURE);
        }
        break;

    case 1:
        i = 0;
        {
            HumidityPeriodicUpdateStart(1000, OnHumidity);
            TemperaturePeriodicUpdateStart(1000, OnTemperature);
            AdcPeriodicUpdateStart(ADC_CH1, 1000, OnAdc);
            AdcPeriodicUpdateStart(ADC_CH2, 1000, OnAdc);
            AdcPeriodicUpdateStart(ADC_CH3, 1000, OnAdc);
            AdcPeriodicUpdateStart(ADC_CH4, 1000, OnAdc);
            CoPeriodicUpdateStart(2000, OnCo);
            I2cDeviceEnable(I2C_DEV_F400_VELOCITY);
            I2cDeviceEnable(I2C_DEV_F400_TEMPERATURE);
            I2cPeriodicUpdateStart(I2C_DEV_F400_VELOCITY, 1000, OnI2cPeriodicUpdateStart);
            I2cPeriodicUpdateStart(I2C_DEV_F400_TEMPERATURE, 1000, OnI2cPeriodicUpdateStart);
        }
        break;
    }
#endif
}

//-----------------------------------------------------------------------------
static void OnI2cPeriodicUpdateStart(TI2cDeviceType type, float value, int error)
{
    ::std::cout << "On I2C device " << type << " (error = " << error << "): "
                << value << '\n';
}

//-----------------------------------------------------------------------------
int main(int argc, char* argv[])
{
    if (Init())
	{
		::std::cerr << "error: The board is kaput.\n";
	}

#if defined(TEST) && 0
    try
    {
        Dev::W1::TBus::TPtr w1(Dev::W1::TBus::Instance());    
        w1->Configure();
        w1->Enumerate();
        
        for(auto itr = w1->Sensors().cbegin(); w1->Sensors().cend() != itr; ++itr)
        {
            ::std::cout << ::std::hex << (*itr)->Address() << ::std::dec << '\n';
        }
        
        for(;;)
        {
            for(unsigned i = 0; i < w1->Sensors().size(); i++)
            {
                Dev::W1::TSensor& s = *(w1->Sensors()[i]);
                float value = s.ReadValue();
                ::std::cout << value << '\n';
            }
            ::sleep(1);
        }
    }
    catch(const TException& e)
    {
        ::std::cerr << e.ToString() << '\n';
    }
#endif

    InterruptsRegisterHandler(OnInterrupt);
    HumidityPeriodicUpdateStart(1000, OnHumidity);
    TemperaturePeriodicUpdateStart(1000, OnTemperature);
    /*AdcPeriodicUpdateStart(ADC_CH1, 1000, OnAdc);
    AdcPeriodicUpdateStart(ADC_CH2, 1000, OnAdc);
    AdcPeriodicUpdateStart(ADC_CH3, 1000, OnAdc);
    AdcPeriodicUpdateStart(ADC_CH4, 1000, OnAdc);
    CoPeriodicUpdateStart(1000, OnCo);
    Co2PeriodicUpdateStart(2000, OnCo2);
    I2cDeviceEnable(I2C_DEV_F400_VELOCITY);
    I2cDeviceEnable(I2C_DEV_F400_TEMPERATURE);
    I2cPeriodicUpdateStart(I2C_DEV_F400_VELOCITY, 1000, OnI2cPeriodicUpdateStart);
    I2cPeriodicUpdateStart(I2C_DEV_F400_TEMPERATURE, 1000, OnI2cPeriodicUpdateStart);*/

    TW1DevicesInfo w1_devices_info;
    W1Enumerate(w1_devices_info);
    for(unsigned i = 0; i < w1_devices_info.size(); i++)
    {
        ::std::cout << ::std::hex << w1_devices_info[i].m_address << ::std::dec << '\n';
        W1PeriodicUpdateStart(w1_devices_info[i].m_address, 1000, OnW1Measurement);
        //TW1DeviceType type;
        //float value;
        //W1GetValue(w1_devices_info[i].m_address, type, value);
        //::std::cout << value << '\n';
    }

#if 0 // Set RTC
    {
        TRtcTime time = {0};
        time.m_years = 80;
        time.m_months = 12;
        time.m_day_of_month = 31;
        time.m_day_of_week = 7;
        time.m_hours = 23;
        time.m_minutes = 59;
        time.m_seconds = 50;

        RtcSet(time);
    }
#endif

    AdcSetLowLimit(ADC_CH1, 0);
    AdcSetHighLimit(ADC_CH1, 1023);

    AdcSetLowLimit(ADC_CH2, 100);
    AdcSetHighLimit(ADC_CH2, 200);

    AdcSetLowLimit(ADC_CH3, 100);
    AdcSetHighLimit(ADC_CH3, 200);

    AdcSetLowLimit(ADC_CH4, 0);
    AdcSetHighLimit(ADC_CH4, 1023);

    RelaysReset();
    //RelaySetPosition(RELAY_K3, true);
    bool led = false;
	for(;;)
    {
        LedSetState(LED_GREEN, led);
        LedSetState(LED_RED, !led);

#if 0 // Relays
        for(unsigned i = 0; i < RELAYS_COUNT; i++)
        {
            if (led)
            {
                RelaySetPosition(static_cast< TRelayId >(i), true);
            }
            else
            {
                RelaysReset();
            }
        }
#endif

#if 1 // ADC
        {
            unsigned raw_value;
            float value;
            bool low, high;

            AdcGetRawValue(ADC_CH1, raw_value);
            AdcGetAlerts(ADC_CH1, low, high);
            value = static_cast< float >(raw_value) * Dev::TAd7993::QUANT;
            ::std::cout << "ch1: raw = " << raw_value
                        << ", U = " << value
                        << ", alerts = {" << low << ", " << high << "}"
                        << '\n';

            AdcGetRawValue(ADC_CH2, raw_value);
            AdcGetAlerts(ADC_CH2, low, high);
            value = static_cast< float >(raw_value) * Dev::TAd7993::QUANT;
            ::std::cout << "ch2: raw = " << raw_value
                        << ", U = " << value
                        << ", alerts = {" << low << ", " << high << "}"
                        << '\n';
        
            AdcGetRawValue(ADC_CH3, raw_value);
            AdcGetAlerts(ADC_CH3, low, high);
            value = static_cast< float >(raw_value) * Dev::TAd7993::QUANT;
            ::std::cout << "ch3: raw = " << raw_value
                        << ", U = " << value
                        << ", alerts = {" << low << ", " << high << "}"
                        << '\n';
                
            AdcGetRawValue(ADC_CH4, raw_value);
            AdcGetAlerts(ADC_CH4, low, high);
            value = static_cast< float >(raw_value) * Dev::TAd7993::QUANT;
            ::std::cout << "ch4: raw = " << raw_value
                        << ", U = " << value
                        << ", alerts = {" << low << ", " << high << "}"
                        << '\n';
        }
#endif

#if 0 // CO
        {
            static unsigned level = 0;
            CoSetThreshold(255);
            unsigned value;
            CoGetValue(value);
            ::std::cout << value << '\n';
        }
#endif

#if 0 // RTC
        {
            bool running;
            TRtcTime time;
            RtcGet(time, running);
            ::std::cout << "RTC: running = " << running
                        << ", time = " << time << '\n';
        }
#endif

#if 0 // Interrupts
        {
            unsigned mask;
            InterruptsGetStatuses(mask);
            ::std::cout << ::std::hex << mask << ::std::dec << '\n';
        }
#endif

        led = !led;

        ::std::cout.flush();
        ::std::this_thread::sleep_for(::std::chrono::milliseconds(1000));
    }

    return 0;
}
