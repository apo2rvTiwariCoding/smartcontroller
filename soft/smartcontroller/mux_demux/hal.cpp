/*
 * hal.cpp
 *
 *  Created on: Dec 4, 2014
 *      Author: user
 */

#include <time.h>
#include <sstream>
#include <iostream>
#include <iterator>
#include <cstring>
#include "mux_demux/hal.h"
#include "db/MuxDemuxDb.h"
#include "util/log/log.h"


//------------------------HAL - MUXDEMUX ---------------------------------------

using namespace Hal;

volatile int hal_init_err;
volatile static int error_code;


//-----------------------------------------------------------------------------
static void OnHumidity(float value, int error)   //check out sensorraw or sensor table to be used ??
{
    fprintf (stderr, "In %s\n",__func__);
    //int ret;
    CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
    if (pSmartSen == NULL)
    {
        LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
        fprintf (stderr, "CSmartSensor Can not be created");
        //return -1;
    }
    else
    {
        pSmartSen->insertHum(0,value);
    }
    ::std::cout << "On humidity (error = "
                << error << "): " << value << '\n';
}
//INSERT INTO smartsensors (id, updated, type_, t_supply_duct, h_supply_duct, air_vel) VALUES (NULL, NOW(), 0, @temperature, @humidity, @velocity);
//-----------------------------------------------------------------------------
static void OnTemperature(float value, int error)//check out sensorraw or sensor table to be used ??
{
    fprintf (stderr, "In %s\n",__func__);
    //int ret;
    CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
    if (pSmartSen == NULL)
    {
        LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
        fprintf (stderr, "CSmartSensor Can not be created");
        //return -1;
    }
    else
    {
        pSmartSen->insert(0,value);
    }
    ::std::cout << "On temperature (error = "
                << error << "): " << value << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}
//-----------------------------------------------------------------------------
static void OnCo2(float value, int error)
{
    fprintf (stderr, "In %s\n",__func__);
    //int ret;
    CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
    if (pSmartSen == NULL)
    {
        LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
        fprintf (stderr, "CSmartSensor Can not be created");
        //return -1;
    }
    else
    {
        pSmartSen->insertCO2(0,(int)value);
    }
    ::std::cout << "On CO2 (error = " << error << "): " << value << '\n';


}
//-----------------------------------------------------------------------------
static void OnCo(unsigned value, int error)       ///////////////needs verification
{
    //int ret;
    CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
    if (pSmartSen == NULL)
    {
        LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
        fprintf (stderr, "CSmartSensor Can not be created");
        //return -1;
    }
    else
    {
        pSmartSen->insert(0,value);
    }
    ::std::cout << "On CO (error = " << error << "): " << value << '\n';
}
//-----------------------------------------------------------------------------
static void OnAdc(TAdcChannelId channel_id, float value, int error)
{
    fprintf (stderr, "In %s channel_id=%i\n",__func__, channel_id);
    //int ret;
    char val[10];
    char add[10];
    CSmartSensorRaw *pSmartSenRaw = CSmartSensorRaw::getInstance ();
    if (pSmartSenRaw == NULL)
    {
        LOG_ERROR("server", "CSmartSensorRaw returned a NULL pointer");
        fprintf (stderr, "CSmartSensorRaw Can not be created");
        //return -1;
    }
    else
    {
        ::std::snprintf(val, sizeof(val), "%f",value);
        switch(channel_id)
        {
        case ::Hal::ADC_CH1: ::std::strncpy(add, "1", sizeof(add)); break;
        case ::Hal::ADC_CH2: ::std::strncpy(add, "2", sizeof(add)); break;
        case ::Hal::ADC_CH3: ::std::strncpy(add, "3", sizeof(add)); break;
        case ::Hal::ADC_CH4: ::std::strncpy(add, "4", sizeof(add)); break;
        }
        pSmartSenRaw->insert(0,0,add,val);          //Null should be replace with channelid as std::string
    }
    fprintf (stderr, "Out %s\n",__func__);
}
//-----------------------------------------------------------------------------

void OnInterrupt(unsigned activated, unsigned status, int error)
{
    ::std::cout << "On interrupt (error = " << error
                << "): 0x" << ::std::hex << activated << ::std::dec
                << ", 0x" << ::std::hex << status << ::std::dec << '\n';

    if(activated & (1 << INT_THERM_Y1))     //Y1 thermostat line
    {
        fprintf (stderr, "Y1 thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_THERM_Y1)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_INFO("server", "Y1 Thermostat interrupt generated");
            pThermostate->insertY1((bool)(status & (1 << INT_THERM_Y1)));
        }
    }

    if(activated & (1 << INT_THERM_Y2))     //Y2 thermostat line
    {
        fprintf (stderr, "Y2 thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_THERM_Y2)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "Y2 Thermostat interrupt generated");
            pThermostate->insertY2((bool)(status & (1 << INT_THERM_Y2)));
        }
    }

    if(activated & (1 << INT_THERM_G))      //G thermostat line
    {
        fprintf (stderr, "G thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_THERM_G)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "G Thermostat line interrupt generated");
            pThermostate->insertG((bool)(status & (1 << INT_THERM_G)));
        }
    }

    if(activated & (1 << INT_THERM_O_B))        //O/B thermostat line
    {
        fprintf (stderr, "O/B thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_THERM_O_B)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "O/B Thermostat line interrupt generated");
            pThermostate->insertOB((bool)(status & (1 << INT_THERM_O_B)));
        }
    }

    if(activated & (1 << INT_THERM_AUX))        //Aux thermostat line
    {
        fprintf (stderr, "Aux thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_THERM_AUX)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "Aux Thermostat line interrupt generated");
            pThermostate->insertAux((bool)(status & (1 << INT_THERM_AUX)));
        }
    }

    if(activated & (1 << INT_THERM_W1))     //W1 thermostat line
    {
        fprintf (stderr, "W1 thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_THERM_W1)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "W1 Thermostat line interrupt generated");
            pThermostate->insertW1((bool)(status & (1 << INT_THERM_W1)));
        }
    }

    if(activated & (1 << INT_THERM_W2))     //W2 thermostat line
    {
        fprintf (stderr, "W2 thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_THERM_W2)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "W2 Thermostat line interrupt generated");
            pThermostate->insertW2((bool)(status & (1 << INT_THERM_W2)));
        }
    }

    if(activated & (1 << INT_HUMIDIFIER))       //Hum thermostat line
    {
        fprintf (stderr, "Hum thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_HUMIDIFIER)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "Hum Thermostat line interrupt generated");
            pThermostate->insertHum((bool)(status & (1 << INT_HUMIDIFIER)));
        }
    }

    if(activated & (1 << INT_HVAC_RH))      //Rh thermostat line
    {
        fprintf (stderr, "Rh thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_HVAC_RH)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "Rh Thermostat line interrupt generated");
            pThermostate->insertRh((bool)(status & (1 << INT_HVAC_RH)));
        }
    }

    if(activated & (1 << INT_HVAC_RC))      //Rc thermostat line
    {
        fprintf (stderr, "Rc thermostat line interrupt reported: %d\n", (bool)(activated & (1 << INT_HVAC_RC)));
        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "Rc Thermostat line interrupt generated");
            pThermostate->insertRc((bool)(status & (1 << INT_HVAC_RC)));
        }
    }

    if(activated & (1 << INT_CO))       //CO Threshold Alarm
    {
        fprintf (stderr, "CO Threshold Alarm interrupt reported: %d\n", (bool)(activated & (1 << INT_CO)));
        LOG_ERROR("server", "CO Threshold interrupt generated");
        CSmartDevices* pDevSmart = new CSmartDevices();//::getInstance();
        if(pDevSmart == NULL)
        {
            LOG_ERROR("server", "CCommands returned a NULL pointer");
        }
        else
        {
			CSmartDevices pDevSmartObj;
            pDevSmart->retrieveStatus(1, pDevSmartObj);
            if(pDevSmartObj.getStatus())
            {
                GetCOValue();
            }
        }
		delete pDevSmart;
    }

    if(activated & (1 << INT_ADC_ALR))      //ADC Threshold Alarm
    {
        fprintf (stderr, "ADC Threshold Alarm interrupt reported: %d\n", (bool)(activated & (1 << INT_ADC_ALR)));
        CAlarmsRetrosave *pAR = CAlarmsRetrosave::getInstance();
        if (pAR == NULL)
        {
            LOG_ERROR("server", "CAlarmsRetrosave returned a NULL pointer");
            fprintf (stderr, "CAlarmsRetrosave instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "ADC Threshold interrupt generated");
            bool lo = false, hi=false;
            AdcGetAlerts(ADC_CH1, lo, hi);
            if(lo || hi)
            {
                pAR->insert(15, 2);
            }
            lo=false;
            hi=false;
            AdcGetAlerts(ADC_CH2, lo, hi);
            if(lo || hi)
            {
                pAR->insert(12, 1);
            }
            lo=false;
            hi=false;
            AdcGetAlerts(ADC_CH3, lo, hi);
            if(lo || hi)
            {
                pAR->insert(13, 1);
            }
            lo=false;
            hi=false;
            AdcGetAlerts(ADC_CH4, lo, hi);
            if(lo || hi)
            {
                pAR->insert(14, 1);
            }
            lo=false;
            hi=false;
        }
    }

    if(activated & (1 << INT_BYPASS_SWITCH))    //Bypass mode
    {
        fprintf (stderr, "Bypass interrupt reported: %d\n", (bool)(activated & (1 << INT_BYPASS_SWITCH)));
        CBypass *pBypass = CBypass::getInstance();
        if (pBypass == NULL)
        {
            LOG_ERROR("server", "CBypass returned a NULL pointer");
            fprintf (stderr, "CBypass instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "Bypass interrupt generated");
            pBypass->insert(0, (bool)(status & (1 << INT_BYPASS_SWITCH)));
        }
    }
}

void GetInterruptsStatus()
{
    unsigned status;
    error_code = InterruptsGetStatuses(status);
    if(error_code)
    {
        LOG_ERROR_FMT("server", "InterruptsGetStatuses() failed woth error_code: %d", error_code);
        fprintf(stderr, "InterruptsGetStatuses failed with error_code ; %d", error_code);
    }
    else
    {
        ::std::cout << "Interrupt status " << ::std::hex << status << ::std::dec << '\n';

        CThermostat *pThermostate = CThermostat::getInstance();
        if (pThermostate == NULL)
        {
            LOG_ERROR("server", "CThermostat returned a NULL pointer");
            fprintf (stderr, "CThermostat instance can not be created");
        }
        else
        {
            pThermostate->insertY1((bool)(status & (1 << INT_THERM_Y1)));
            pThermostate->insertY2((bool)(status & (1 << INT_THERM_Y2)));
            pThermostate->insertG((bool)(status & (1 << INT_THERM_G)));
            pThermostate->insertOB((bool)(status & (1 << INT_THERM_O_B)));
            pThermostate->insertAux((bool)(status & (1 << INT_THERM_AUX)));
            pThermostate->insertW1((bool)(status & (1 << INT_THERM_W1)));
            pThermostate->insertW2((bool)(status & (1 << INT_THERM_W2)));
            pThermostate->insertHum((bool)(status & (1 << INT_HUMIDIFIER)));
            pThermostate->insertRh((bool)(status & (1 << INT_HVAC_RH)));
            pThermostate->insertRc((bool)(status & (1 << INT_HVAC_RC)));
        }

        CSmartDevices* pDevSmart = new CSmartDevices();//::getInstance();
        if(pDevSmart == NULL)
        {
            LOG_ERROR("server", "CCommands returned a NULL pointer");
        }
        else
        {
			CSmartDevices pDevSmartObj;
            pDevSmart->retrieveStatus(1, pDevSmartObj);
            if(pDevSmartObj.getStatus())
            {
                GetCOValue();
            }
        }
		delete pDevSmart;

        CSmartSensor *pSS = CSmartSensor::getInstance();
        if (pSS == NULL)
        {
            LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
            fprintf (stderr, "CSmartSensor instance can not be created");
        }
        else
        {
            pSS->insert(1, status);
        }

        CAlarmsRetrosave *pAR = CAlarmsRetrosave::getInstance();
        if (pAR == NULL)
        {
            LOG_ERROR("server", "CAlarmsRetrosave returned a NULL pointer");
            fprintf (stderr, "CAlarmsRetrosave instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "ADC Threshold interrupt generated");
            bool lo = false, hi=false;
            AdcGetAlerts(ADC_CH1, lo, hi);
            if(lo || hi)
            {
                pAR->insert(15, 2);
            }
            lo=false;
            hi=false;
            AdcGetAlerts(ADC_CH2, lo, hi);
            if(lo || hi)
            {
                pAR->insert(12, 1);
            }
            lo=false;
            hi=false;
            AdcGetAlerts(ADC_CH3, lo, hi);
            if(lo || hi)
            {
                pAR->insert(13, 1);
            }
            lo=false;
            hi=false;
            AdcGetAlerts(ADC_CH4, lo, hi);
            if(lo || hi)
            {
                pAR->insert(14, 1);
            }
            lo=false;
            hi=false;
        }

        CBypass *pBypass = CBypass::getInstance();
        if (pBypass == NULL)
        {
            LOG_ERROR("server", "CBypass returned a NULL pointer");
            fprintf (stderr, "CBypass instance can not be created");
        }
        else
        {
            LOG_ERROR("server", "Bypass interrupt generated");
            pBypass->insert(0, (bool)(status & (1 << INT_BYPASS_SWITCH)));
        }
    }
}
//-----------------------------------------------------------------------------

static void OnW1Measurement(const TW1DeviceInfo& deviceInfo, float value, int error) //device id should be a address
{
    fprintf(stderr,"In : %s \n",__func__);
    char val[10];

    CSmartSensorRaw *pSmartSenRaw = CSmartSensorRaw::getInstance ();
    if (pSmartSenRaw == NULL)
    {
        LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
        fprintf (stderr, "CSmartSensorRaw Can not be created");
    }
    else
    {
        ::std::ostringstream out;
        out << std::hex << deviceInfo.m_address;
        std::string str = out.str();
        sprintf(val,"%f",value);

        pSmartSenRaw->insert(2,deviceInfo.m_type,str,val);
    }
    ::std::cout << "On W1 device " << deviceInfo.m_address
                << " Type " << deviceInfo.m_type
                << " (error = " << error << "): " << value << '\n';
}

//-------------------CO functions--------------------------------

void GetCOValue()      ///verify table insertion
{
    fprintf (stderr, "In %s\n",__func__);
    unsigned val;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        error_code = CoGetValue(val);
        if(error_code)
        {
            LOG_ERROR_FMT("server", "CoGetValue() failed with error_code: %d", error_code);
            fprintf(stderr, "CoGetValue failed with error_code ; %d", error_code);

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned a NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(5, 1,0x75, "error");
            }
        }
        else
        {
            CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
            if (pSmartSen == NULL)
            {
                LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
                fprintf (stderr, "CSmartSensor Can not be created");
            }
            else
            {
                pSmartSen->insert(0, val);
            }
        }

    }
    ::std::cout << "CO value: " << val << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}

void GetCOState()
{
    fprintf (stderr, "In %s\n",__func__);
    bool state;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
        fprintf (stderr, "Out %s\n",__func__);
    }
    else
    {
        error_code = CoGetState(state);
        if(error_code)
        {
            LOG_ERROR_FMT("server", "CoGetState() failed with error_code: %d", error_code);
            fprintf (stderr, "CoGetState() failed with error_code: %d", error_code);

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned a NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(5, 1,0x75, "error");
            }
        }
        else
        {
            CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
            if (pSmartSen == NULL)
            {
                LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
                fprintf (stderr, "CSmartSensor Can not be created");
            }
            else
            {
                pSmartSen->insert(0, (unsigned int)state);
            }
        }
    }
    ::std::cout << "CO state: " << state << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}

int CoPeriodicUpdate(int interval )
{
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
        fprintf (stderr, "Out %s\n",__func__);
        return -1;
    }

    fprintf (stderr, "In %s\n",__func__);
    if(interval <0)
    {
        LOG_INFO("server", "Stopping CO periodic update");
        fprintf (stderr, "Stopping %s\n",__func__);
        CoPeriodicUpdateStop();
    }
    else
    {
        LOG_INFO("server", "Starting CO periodic update");
        fprintf (stderr, "Starting %s\n",__func__);
        if (CoPeriodicUpdateStart(interval*1000, OnCo))
        {
            fprintf (stderr, "Out %s\n",__func__);
            return -1;
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
    return 0;
}

/*------------------CO functions ends ----------------------------*/
/*------------------CO2 functions starts ----------------------------*/
void Co2PeriodicUpdate(int interval )
{
    fprintf (stderr, "In %s\n",__func__);
    if(interval <0)
    {
        if (hal_init_err)
        {
            LOG_ERROR("server", "HAL is not initialized");
        }
        else
        {
            LOG_INFO("server", "Stopping CO2 periodic update");
            Co2PeriodicUpdateStop();
        }
    }
    else
    {
        fprintf (stderr, "Starting %s\n",__func__);
        if (hal_init_err)
        {
            #ifdef LOG
            CLog::getInstance()->error("server",__LINE__,__FILE__,"HAL layer is not initialized");
            #endif
        }
        else
        {
            LOG_INFO("server", "Starting CO2 periodic update");
            Co2PeriodicUpdateStart(interval*1000, OnCo2);
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
}

void GetCO2Value()      ///verify table insertion just copied function from a copied function
{
    fprintf (stderr, "In %s\n",__func__);
    float val;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        error_code = Co2GetValue(val);
        if(error_code)
        {
            LOG_ERROR_FMT("server", "Co2GetValue() failed with error_code: %d", error_code);
            fprintf (stderr, "Co2GetValue() failed with error_code: %d", error_code);

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(5, 1,0x75, "error");
            }
        }
        else
        {
            CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
            if (pSmartSen == NULL)
            {
                LOG_ERROR("server", "CSmartSensor returned NULL pointer");
                fprintf (stderr, "CSmartSensor Can not be created");
            }
            else
            {
                pSmartSen->insertCO2(0, val);
            }
        }
    }
    ::std::cout << "CO value: " << val << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}


/*------------------CO2 functions ends ----------------------------*/
/*------------------RTC Functions -------------------------------*/
time_t getTimes(std::string str)
{
    struct tm tmlol;
    strptime(str.c_str(), "%Y%m%d%H%M%S", &tmlol);
    time_t t = mktime(&tmlol);
    return t;
}

TRtcTime getTime(std::string t)
{
    char str1[28];
    TRtcTime tRtcTime;

    time_t timestamp;
    ::std::stringstream ss;
    ss << t;
    ss >> timestamp;

    strftime(str1, sizeof(str1), "%Y %m %d %w %H %M %S", localtime(&timestamp));

    std::string str = str1;
    std::istringstream buf(str);
    std::istream_iterator<std::string> beg(buf), end;
    std::vector<std::string> tokens(beg, end); // done!

    tRtcTime.m_years = (atoi(tokens[0].c_str()) - 2000);
    tRtcTime.m_months = atoi(tokens[1].c_str());
    tRtcTime.m_day_of_month = atoi(tokens[2].c_str());
    tRtcTime.m_day_of_week = atoi(tokens[3].c_str());
    tRtcTime.m_hours = atoi(tokens[4].c_str());
    tRtcTime.m_minutes = atoi(tokens[5].c_str());
    tRtcTime.m_seconds = atoi(tokens[6].c_str());

    return tRtcTime;
}

void SetRtc(std::string time_str)
{
    fprintf (stderr, "In %s\n",__func__);
    int ret =0 ;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        TRtcTime time;

        time = getTime(time_str);
        ret = RtcSet(time);
        if(ret <0)
        {
            LOG_ERROR_FMT("server", "RtcSet() failed with error_code: %d", error_code);
            fprintf (stderr, "Setting RTC failed \n");
            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(7, 1,0x7E, "error");
            }
        }
        else
        {
            LOG_INFO("server", "RTC set successfully");
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
}

void GetRtc()
{
    fprintf (stderr, "In %s\n",__func__);
    int ret =0 ;
    TRtcTime time ;
    bool running;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        ret = RtcGet(time, running);
        if(ret < 0)
        {
            LOG_ERROR_FMT("server", "RtcGet() failed with error_code: %d", error_code);
            fprintf (stderr, "Get RTC failed \n");

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(9, 1,0x7F, "error");
            }
        }
        else
        {
            if(running)
            {
                unsigned long long int x;
                x = (time.m_years + 2000);
                x *= 100;
                x += (time.m_months);
                x *= 100;
                x += (time.m_day_of_month);
                x *= 100;
                x += (time.m_hours);
                x *= 100;
                x += (time.m_minutes);
                x *= 100;
                x += (time.m_seconds);

                CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
                if (pAlarm == NULL)
                {
                    LOG_ERROR("server", "CAlarmSystem returned NULL pointer");
                    fprintf (stderr, "CAlarmSystem Can not be created");
                }
                else
                {
                    std::cout << "GetRtc: " << std::to_string(getTimes(std::to_string(x))) << '\n';
                    pAlarm->insert(8, 0, std::to_string(getTimes(std::to_string(x))));
                }
            }
            else
            {
                LOG_WARN("server", "RTC is not running");
            }
        }
    }
    ::std::cout << "Running : " << running << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}

/*---------------------------------------------------------------*/
/*----------------------I2C Function ----------------------------*/
/*void I2CPeriodicUpdate(int interval ,std::string address)
{
    fprintf (stderr, "In %s\n",__func__);
    if(interval <0)
    {
        fprintf (stderr, "Stopping %s\n",__func__);
        HumidityPeriodicUpdateStop();
        TemperaturePeriodicUpdateStop();
        Co2PeriodicUpdateStop();

    }
    else
    {
        TemperaturePeriodicUpdateStart(interval, OnTemperature);
        HumidityPeriodicUpdateStart(interval, OnHumidity);
        Co2PeriodicUpdateStart(interval, OnCo2);
    }
    fprintf (stderr, "Out %s\n",__func__);
}

void GetTempHumCo2()
{
    int ret;
    float temp,humidity,co2;
    TemperatureGetValue(temp);
    HumidityGetValue(humidity);
    Co2GetValue(co2);
    CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
    if (pSmartSen == NULL)
    {
        fprintf (stderr, "CSmartSensor Can not be created");
        //return -1;
    }

    ret = pSmartSen->insertTHC(0, temp,int(humidity),int(co2)); //instead it should be velocity over here// these are wrong values
    if(ret<0)
    {
        fprintf (stderr, "insertion into smartsensor table failed \n");

        CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
        if (pAlarm == NULL)
        {
            fprintf (stderr, "CAlarmSystem Can not be created");
            //return -1;
        }

        printf("Inserting into CAlarmSystem Table for smartsensor TempHumCo2 failed\n");

        pAlarm->insert(5, 1,0x24, "error");
    }
    //INSERT INTO smartsensors (id, updated, type_, t_supply_duct, h_supply_duct,
    //air_vel) VALUES (NULL, NOW(), 0, @temperature, @humidity, @velocity);
}*/
/*-------------------I2C ends-------------------------------------*/
/*---------------ADC functions -----------------------------------*/

bool AdcDbToHalChannel(int db_channel_id, ::Hal::TAdcChannelId& hal_channel_id)
{
    switch(db_channel_id)
    {
    case 1: hal_channel_id = ::Hal::ADC_CH1; return true;
    case 2: hal_channel_id = ::Hal::ADC_CH2; return true;
    case 3: hal_channel_id = ::Hal::ADC_CH3; return true;
    case 4: hal_channel_id = ::Hal::ADC_CH4; return true;
    default:
        LOG_ERROR_FMT("server", "Invalid channel: %d", db_channel_id);
        return false;
    }
}

void AdcPeriodicUpdate(int db_channel_id, int interval )
{
    fprintf (stderr, "In %s\n",__func__);

    ::Hal::TAdcChannelId hal_channel_id;
    if (!AdcDbToHalChannel(db_channel_id, hal_channel_id))
    {
        return;
    }

    if(interval >0)
    {
        if (hal_init_err)
        {
            LOG_ERROR("server", "HAL is not initialized");
        }
        else
        {
            LOG_INFO("server", "Starting ADC periodic update");
            fprintf (stderr, "Starting %s\n",__func__);
            AdcPeriodicUpdateStart(hal_channel_id, interval*1000, OnAdc);
        }
    }
    else
    {
        if (hal_init_err)
        {
            LOG_ERROR("server", "HAL is not initialized");
        }
        else
        {
            LOG_INFO("server", "Stopping ADC Periodic Update");
            fprintf (stderr, "Stoppping %s\n",__func__);
            AdcPeriodicUpdateStop(hal_channel_id);
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
}

void GetAdcValue(int db_channel_id)
{
    fprintf (stderr, "In %s\n",__func__);
    unsigned value;
    char val[10];
    char address[10];
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        ::Hal::TAdcChannelId hal_channel_id;
        if (!AdcDbToHalChannel(db_channel_id, hal_channel_id))
        {
            return;
        }

        error_code = AdcGetRawValue(hal_channel_id, value);
        if(error_code)
        {
            LOG_ERROR_FMT("server", "AdcGetRawValue() failed with error_code: %d", error_code);
            fprintf (stderr, "AdcGetRawValue() failed with error_code: %d", error_code);

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned NUL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(10, 1,0x23, "error");
            }
        }
        else
        {
            sprintf(address,"%d",db_channel_id);
            sprintf(val,"%u",value);
            CSmartSensorRaw *pSmartSenRaw = CSmartSensorRaw::getInstance ();
            if (pSmartSenRaw == NULL)
            {
                LOG_ERROR("server", "CSmartSensorRaw retuned NULL pointer");
                fprintf (stderr, "CSmartSensorRaw Can not be created");
                //return -1;
            }
            else
            {
                pSmartSenRaw->insert(0,0,address,val);
            }
        }
    }
    ::std::cout << "Adc : " << value << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}

void SetAdcLow(int db_channel_id, unsigned low )
{
    fprintf (stderr, "In %s\n",__func__);
    int ret;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        ::Hal::TAdcChannelId hal_channel_id;
        if (!AdcDbToHalChannel(db_channel_id, hal_channel_id))
        {
            return;
        }

        ret = AdcSetLowLimit(hal_channel_id, low);
        if(ret<0)
        {
            LOG_ERROR_FMT("server", "AdcSetLowLimit() failed with error_code: %d", error_code);
            fprintf (stderr, "Inserting into CAlarmSystem Table for setting adc limits failed \n");

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem retuned NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(10, 1,0x78, "error");
            }
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
}

void SetAdcHigh(int db_channel_id, unsigned high )
{
    fprintf (stderr, "In %s\n",__func__);

    int ret;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        ::Hal::TAdcChannelId hal_channel_id;
        if (!AdcDbToHalChannel(db_channel_id, hal_channel_id))
        {
            return;
        }

        if (0 == high)
        {
            high = 1023; // Max value of the ADC output range.
        }
        ret = AdcSetHighLimit(hal_channel_id, high);
    }
    if(ret<0)
    {
        LOG_ERROR_FMT("server", "AdcSetHighLimit() failed with error_code: %d", error_code);
        fprintf (stderr, "Inserting into CAlarmSystem Table for setting adc limits failed \n");

        CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
        if (pAlarm == NULL)
        {
            LOG_ERROR("server", "CAlarmSystem returned a NULL pointer");
            fprintf (stderr, "CAlarmSystem Can not be created");
        }
        pAlarm->insert(10, 1,0x77, "error");
    }
    fprintf (stderr, "Out %s\n",__func__);
}
/*---------------------------------------------------------------*/

/*--------------------W1 Functions-------------------------------*/


void W1EnumerateDevice()
{
    fprintf (stderr, "In %s\n",__func__);
    TW1DevicesInfo devices_hal ,devices_db;
    fprintf (stderr, "%s, %d - We are good\n", __func__, __LINE__);
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        error_code = W1Enumerate(devices_hal);
        if(error_code)
        {
            LOG_ERROR_FMT("server", "W1Enumerate() failed with error_code: %d", error_code);

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem retuned a NULL pointer");
            }
            else
            {
                pAlarm->insert(5, 1,0x26, "error");
            }
        }
        else
        {
            CSmartDevices *pSmartDev = new CSmartDevices();//::getInstance ();
            if (pSmartDev == NULL)
            {
                LOG_ERROR("server", "CSmartDevices returned a NULL pointer");
            }
            else
            {
                pSmartDev->enumerateOneWireDev(devices_hal);
                pSmartDev->retrieve1WDev(devices_db);
                for(unsigned int device_list_index = 0; device_list_index < devices_db.size(); device_list_index++)
                {
                    TW1DeviceAddress device_address = devices_db[device_list_index].m_address;
                    std::string device_addr;
                    ::std::ostringstream out;
                    out <<  std::hex << device_address;
                    device_addr = out.str();
					
					CSmartDevices pSmartDevObj;
                    pSmartDev->retrieve1WDevStatus(device_addr, pSmartDevObj);
                    if(pSmartDevObj.getStatus())
                    {
                        pSmartDev->retrieveIntAddr(device_addr, pSmartDevObj);
                        W1PeriodicUpdate(device_address, pSmartDevObj.getInterval());
                    }
                    else
                    {
                        W1PeriodicUpdate(device_address,0);
                    }
                }
            }
			delete pSmartDev;
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
}

void W1PeriodicUpdate(TW1DeviceAddress address,int interval)  
{
    fprintf (stderr, "In %s\n",__func__);
    std::cout<<"address is "<< std::hex << address <<'\n';
    if (interval>0)
    {
        if (hal_init_err)
        {
            LOG_ERROR("server", "HAL is not initialized");
        }
        else
        {
            LOG_INFO_FMT("server", "Starting W1 Periodic Update with Interval: %d sec", interval);
            W1PeriodicUpdateStart(address, interval*1000, OnW1Measurement); 
        }
    }
    else
    {
        if (hal_init_err)
        {
            LOG_ERROR("server", "HAL is not initialized");
        }
        else
        {
            LOG_INFO("server", "Stopping W1 Periodic Update");
            fprintf (stderr, "Stopping %s\n",__func__);
            std::cout << "Address is: " << std::hex << address << '\n';
            W1PeriodicUpdateStop(address);
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
}

void GetW1Value(TW1DeviceAddress device_id )
{
    fprintf (stderr, "In %s\n",__func__);
    char vall[10];
    TW1DeviceType type;
    float value;

    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        error_code = W1GetValue(device_id, type, value);                    //device address should be passed
        if(error_code)
        {
            LOG_ERROR_FMT("server", "W1GetValue() failed with error_code: %d", error_code);

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned a NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(5, 1,0x25, "error");
            }
        }
        else
        {
            CSmartSensorRaw *pSmartSenRaw = CSmartSensorRaw::getInstance ();
            if (pSmartSenRaw == NULL)
            {
                LOG_ERROR("server", "CSmartSensorRaw returned a NULL pointer");
                fprintf (stderr, "CSmartSensorRaw Can not be created");
            }
            else
            {
                ::std::ostringstream out;
                out << std::hex << device_id;
                std::string str = out.str();
                sprintf(vall,"%f",value);
                pSmartSenRaw->insert( 2,(int)type,str,vall);
            }
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
}
/*---------------------------------------------------------------*/
/*------------------Temperature Functions -----------------------*/
void GetTemperatureValue(int address)  //void GetTemperatureValue(int addrs)
{
    fprintf (stderr, "In %s\n",__func__);
    float temp ;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        error_code = TemperatureGetValue(temp);
        if(error_code)
        {
            LOG_ERROR_FMT("server", "TemperatureGetValue() failed with error_code: %d", error_code);
            fprintf (stderr, "insertion into smartsensor table failed \n");

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned a NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(5, 1,0x75, "error");
            }
        }
        else
        {
            CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
            if (pSmartSen == NULL)
            {
                LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
                fprintf (stderr, "CSmartSensor Can not be created");
            }
            else
            {
                pSmartSen->insert(0, temp);
            }
        }
    }
    ::std::cout << "Temperature : " << temp << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}


void TemperaturePeriodicUpdate(int interval)
{
    fprintf (stderr, "In %s\n",__func__);

    if(interval >0)
    {
        if (hal_init_err)
        {
            LOG_ERROR("server", "HAL is not initialized");      }
        else
        {
            LOG_INFO("server", "Starting Temperature Periodic Update");
            fprintf (stderr, "Starting %s\n",__func__);
            TemperaturePeriodicUpdateStart(interval*1000, OnTemperature);
        }
    }
    else
    {
        if (hal_init_err)
        {
            LOG_ERROR("server", "HAL is not initialized");
        }
        else
        {
            LOG_ERROR("server", "Stopping Temperature Periodic Update");
            fprintf (stderr, "Stoppping %s\n",__func__);
            TemperaturePeriodicUpdateStop();
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
}
/*-----------------------------------------------------------*/
/*-----------------Humidity Functions ---------------------------*/

void HumidityPeriodicUpdate(int interval) //if addrs and interval
{
    fprintf (stderr, "In %s\n",__func__);
    if(interval >0)
    {
        if (hal_init_err)
        {
            LOG_ERROR("server", "HAL is not initialized");
        }
        else
        {
            LOG_ERROR("server", "Starting Humidity Periodic Update");
            fprintf (stderr, "Starting %s\n",__func__);
            HumidityPeriodicUpdateStart(interval*1000, OnHumidity);
        }
    }
    else
    {
        if (hal_init_err)
        {
            LOG_ERROR("server", "HAL is not initialized");      }
        else
        {
            LOG_ERROR("server", "Stopping Humidity Periodic Update");
            fprintf (stderr, "Stoppping %s\n",__func__);
            HumidityPeriodicUpdateStop();
        }
    }
    fprintf (stderr, "Out %s\n",__func__);
}

void GetHumidityValue(int address)
{
    fprintf (stderr, "In %s\n",__func__);
    float humidity ;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        error_code = HumidityGetValue(humidity);
        if(error_code)
        {
            LOG_ERROR_FMT("server", "HumidityGetValue() failed with error_code: %d",error_code);
            fprintf (stderr, "HumidityGetValue() failed \n");

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned a NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
            }
            else
            {
                pAlarm->insert(5, 1,0x75, "error");
            }
        }
        else
        {
            CSmartSensor *pSmartSen = CSmartSensor::getInstance ();
            if (pSmartSen == NULL)
            {
                LOG_ERROR("server", "CSmartSensor returned a NULL pointer");
                fprintf (stderr, "CSmartSensor Can not be created");
            }
            else
            {
                pSmartSen->insertHum(0, (int)humidity);
            }
        }
    }
    ::std::cout << "Humidity: " << humidity << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}

/*----------------------------------------------------------------*/
/*-----------------Relay Hal Functions----------------------------*/
void SetRelayPosition(TRelayId id, bool position)
{
    fprintf (stderr, "In %s\n",__func__);
    //int ret;
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        error_code = RelaySetPosition(id, position);
        if(error_code)
        {
            LOG_ERROR_FMT("server", "RelaySetPosition() failed with error_code: %d", error_code);
            fprintf (stderr, "Inserting into CAlarmSystem Table for smartsensor Temp failed \n");

            CAlarmSystem *pAlarm = CAlarmSystem::getInstance();
            if (pAlarm == NULL)
            {
                LOG_ERROR("server", "CAlarmSystem returned a NULL pointer");
                fprintf (stderr, "CAlarmSystem Can not be created");
                //return -1;
            }
            else
            {
                pAlarm->insert(4, 1,0x13, "error");
            }
        }
    }
    ::std::cout << "Position: " << position << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}

/*-----------------------------------------------------------------*/
/*--------------------Led Hal Functions----------------------------*/
void SetLedPosition(TLedId id, bool on)
{
    fprintf (stderr, "In %s\n",__func__);
    if (hal_init_err)
    {
        LOG_ERROR("server", "HAL is not initialized");
    }
    else
    {
        LedSetState(id, on);
    }
    ::std::cout << "Status: " << on << '\n';
    fprintf (stderr, "Out %s\n",__func__);
}

#ifdef EMULATOR
void *hal_muxdemux(void* arg)
{
    ::sleep(1);
}
#endif

#ifdef EMULATOR
int
init_serverMux (int port)
{
    int err;
    pthread_t tid;
    CTcpClientMux::RegisterCallback (OnMessageReceivedServerMux);
    err=pthread_create(&tid,NULL,hal_muxdemux,NULL);
    if (err != 0)
    {
        LOG_ERROR("server", "Error in creation of thread HAL-MuxDemux");
        fprintf(stderr, "Error Creating Thread for hal_muxdemux\n");
    }
    else
    {
        LOG_ERROR("server", "Thread created successfully for HAL-MuxDemux");
        fprintf(stderr, "Thread created for  hal_muxdemux\n");
    }
    serverSocket1 = new CTcpSocketMux ();
    if (serverSocket1 != NULL)
    {
       if (serverSocket1->Bind (port))
        {
          if (serverSocket1->Listen ())
            {
              serverSocket1->Accept ();
            }
        }
    }

  return 0 ;
}
#endif



