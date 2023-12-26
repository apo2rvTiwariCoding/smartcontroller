/*
 * hal.h
 *
 *  Created on: Dec 4, 2014
 *      Author: user
 */

#ifndef FILE_MUX_DEMUX_HAL_H
#define FILE_MUX_DEMUX_HAL_H

#include <string>
#include "hal/hal.h"


//----------------------------------Muxdemux - Hal Functions--------------------


//-------------------------------------------------------------------------------
void interrupt_handler();
void GetInterruptsStatus();

//------------RTC functions---------------------------
time_t getTimes(std::string t);
::Hal::TRtcTime getTime(std::string t);
void SetRtc(::std::string time);
void GetRtc();

//-------------I2Cfunctions-----------------------------
void I2CPeriodicUpdate(int interval, ::std::string address);
void GetTempHumCo2();

//------------Adc functions---------------------------
bool AdcDbToHalChannel(int db_channel_id, ::Hal::TAdcChannelId& hal_channel_id);
void AdcPeriodicUpdate(int db_channel_id ,int interval);
void GetAdcValue(int db_channel_id);
void SetAdcLow(int db_channel_id, unsigned low);
void SetAdcHigh(int db_channel_id, unsigned high );

//--------------W1 Functions ---------------------------
void W1EnumerateDevice();
void W1PeriodicUpdate(::Hal::TW1DeviceAddress address,int interval);
void GetW1Value(::Hal::TW1DeviceAddress device_id );

//------------Temperature functions---------------------------
void TemperaturePeriodicUpdate(int interval);
void GetTemperatureValue(int address);

//------------Humidity functions---------------------------
void HumidityPeriodicUpdate(int interval);
void GetHumidityValue(int address);

//------------Relay functions---------------------------
void SetRelayPosition(::Hal::TRelayId id, bool position);
void GetRelayPosition(::Hal::TRelayId id, bool position);

//------------Led functions---------------------------
void SetLedPosition(::Hal::TLedId id, bool on);
void GetLedPosition(::Hal::TLedId id, bool on);
//--------------CO functions --------------------------
void SetCOThreshold(unsigned threshold);
void GetCOState();
void GetCOValue();
int CoPeriodicUpdate(int interval );
//--------------CO2 functions --------------------------
void GetCO2Value();
void Co2PeriodicUpdate(int interval );



void* hal_muxdemux(void* arg);
void OnInterrupt(unsigned activated, unsigned status, int error);


#endif /* FILE_MUX_DEMUX_HAL_H */
