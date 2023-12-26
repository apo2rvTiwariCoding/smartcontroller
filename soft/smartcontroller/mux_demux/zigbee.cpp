// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <cassert>
#include <sstream>
#include <iostream>
//#include <string.h>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "db/MuxDemuxDb.h"
#include "mux_demux/zigbee.h"
#include "util/log/log.h"
#include "inc/SensorTypes.h"
#include "inc/ZigbeeTypes.h"
#include "mux_demux/asemp.h"
#include "mux_demux/zigbee.h"
#include "zigbee/zigbee_sync.h"
#include "inc/ASEMPImpl.h"
//#include "mux_demux/test/testZC.h"

volatile int zigbee_error;

#if 0 // Reserved for future use

void ZigbeeResetRadioModule(unsigned long long int addr64)
{
	fprintf(stderr, "This is %s function\n", __func__);
	
	CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance ();
	if(cZigbeeAlarm == NULL)
	{
		LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
	}
	else
	{
		::std::ostringstream out;
		out << std::hex << addr64;
		string addr = out.str();
		zigbee_error = 0; //ResetZigBeeNetwork(0);
		if(!zigbee_error)
		{
			cZigbeeAlarm->insert(0,addr, 7, 1, 0x30, "ok");
		}
		else
		{
			cZigbeeAlarm->insert(0,addr, 6, 2, 0x30, "error");
		}
	}
}
#endif

// **************************************************************************************

void ZigbeeCreateNetwork(int zigbeeId)
{
	fprintf(stderr, "This is %s function\n", __func__);
	
	CZigbee * cZigbee = new CZigbee(); 
	if(cZigbee == NULL)
	{
		LOG_ERROR("server","CZigbee returned a NULL pointer");
	}
	else
	{
		CZigbee cZigbeeObj;
		cZigbee->retrieve(zigbeeId, cZigbeeObj);
	
	    unsigned channels = cZigbeeObj.getChannel();
	    unsigned pan_id = cZigbeeObj.getPanId();
	    TGwDeviceInfo device_info;
		if (ZigbeeSyncCreateNetwork(channels, pan_id, device_info))
		{
            CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
            if(cZigbeeAlarm == NULL)
            {
                LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
            }
            else
            {
                cZigbeeAlarm->insert(zigbeeId, 8, 2, 0x31, "error");
            }
		}
		else
		{
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else
			{
				cZigbeeAlarm->insertAll(zigbeeId, device_info.m_network_address,
				        std::to_string(device_info.m_ieee_address), 9, 2, cZigbeeObj.getPanId(),
				        cZigbeeObj.getChannel(), 0x31, "ok");
			}
			cZigbee->update(zigbeeId, channels, pan_id,
					std::to_string(device_info.m_ieee_address),
					std::to_string(device_info.m_network_address),
					std::to_string(device_info.m_mfc_id), 
					std::to_string(device_info.m_hw_ver),
					std::to_string(device_info.m_fw_ver));

		}
	}
	delete cZigbee;
}

// *****************************************************************************************

#if 0 // Reserved for future use
void ZigbeeSetPanId(int zigbeeId)
{
	CZigbee * cZigbee = new CZigbee(); 
	if(cZigbee == NULL)
	{
		LOG_ERROR("server", "CZigbee returned a NULL pointer");
	}
	else
	{
		CZigbee cZigbeeObj;
		cZigbee->retrievePanId(zigbeeId, cZigbeeObj);
		if(!cZigbeeObj.getPanIdSel())
		{
			zigbee_error = 0; //some api from zigbee.h to change the Panid of zigbee network with panid = cZigbeeObj.mPanId
			if(!zigbee_error)
			{
				CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
				if(cZigbeeAlarm == NULL)
				{
					LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
				}
				else
				{
					cZigbeeAlarm->insert(zigbeeId, 11, 1, 0x32, "ok", cZigbeeObj.getPanId());
				}
			}
			else
			{
				CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
				if(cZigbeeAlarm == NULL)
				{
					LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
				}
				else
				{
					cZigbeeAlarm->insert(zigbeeId, 10, 2, 0x32, "error");
				}
			}
		}
		else
		{
			zigbee_error = 0; //some api from zigbee.h to change the Panid of zigbee network with panid generated automatically
			if(!zigbee_error)
			{
				CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
				if(cZigbeeAlarm == NULL)
				{
					LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
				}
				else
				{
					//replace cZigbeeObj.mPanId with the automatically generated panid
					cZigbeeAlarm->insert(zigbeeId, 11, 1, 0x32, "ok", cZigbeeObj.getPanId());
					cZigbeeObj.updatePanId(zigbeeId, cZigbeeObj.getPanId());
				}
			}
			else
			{
				CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
				if(cZigbeeAlarm == NULL)
				{
					LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
				}
				else
				{
					cZigbeeAlarm->insert(zigbeeId, 10, 2, 0x32, "error");
				}
			}
		}
	}
	delete cZigbee;
}
#endif

// ***************************************************************************************

#if 0 // Reserved for future use
void ZigbeeSetRFChannel(int zigbeeId)
{
	CZigbee * cZigbee = new CZigbee(); 
	if(cZigbee == NULL)
	{
		LOG_ERROR("server", "CZigbee returned a NULL pointer");
	}
	else
	{
		CZigbee cZigbeeObj;
		cZigbee->retrieveChannel(zigbeeId, cZigbeeObj);
		zigbee_error = 0; //Some API from zigbee.h to change the previously existing communication channel
		if(!zigbee_error)
		{
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else
			{
				cZigbeeAlarm->insertChannel(zigbeeId, 11, 1, 0x33, "ok", cZigbeeObj.getChannel());
				cZigbeeObj.updateChannel(zigbeeId, cZigbeeObj.getChannel());
			}
		}
		else
		{
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else
			{
				cZigbeeAlarm->insert(zigbeeId, 10, 2, 0x33, "error");
			}
		}
	}
	delete cZigbee;
}
#endif

// ***************************************************************************************

#if 0 // Reserved for future use
void ZigbeeSetSecurity(int zigbeeId)
{
	CZigbee * cZigbee = new CZigbee(); 
	if(cZigbee == NULL)
	{
		LOG_ERROR("server", "CZigbee returned a NULL pointer");
	}
	else
	{
		CZigbee cZigbeeObj;
		cZigbee->retrieveEncryption(zigbeeId, cZigbeeObj);
		if(cZigbeeObj.getEncryption())
		{
			zigbee_error = 0; //Some API from zigbee.h to enable the security of a network with @sec_key = mSecKey
			if(!zigbee_error)
			{
				CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
				if(cZigbeeAlarm == NULL)
				{
					LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
				}
				else
				{
					cZigbeeAlarm->insert(zigbeeId, 11, 1, 0x34, "ok");
				}
			}
			else
			{
				CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
				if(cZigbeeAlarm == NULL)
				{
					LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
				}
				else
				{
					cZigbeeAlarm->insert(zigbeeId, 10, 2, 0x34, "error");
				}
			}
		}
		else
		{
			zigbee_error = 0; //Some API from zigbee.h to disable the security of a network
			if(!zigbee_error)
			{
				CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
				if(cZigbeeAlarm == NULL)
				{
					LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
				}
				else
				{
					cZigbeeAlarm->insert(zigbeeId, 11, 1, 0x34, "ok");
				}
			}
			else
			{
				CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
				if(cZigbeeAlarm == NULL)
				{
					LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
				}
				else
				{
					cZigbeeAlarm->insert(zigbeeId, 10, 2, 0x34, "error");
				}
			}
		}
	}
	delete cZigbee;
}
#endif

// ******************************************************************************************

void ZigbeeAllowNewDevice(bool allow, int interval)
{
	if (ZigbeeSyncAllowDeviceJoin(allow, interval))
	{
        CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
        if(cZigbeeAlarm == NULL)
        {
            LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
        }
        else
        {
            cZigbeeAlarm->insert(0, 12, 2, 0x35, "error");
        }
	}
	else
	{
		CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
		if(cZigbeeAlarm == NULL)
		{
			LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
		}
		else
		{
			if(allow)
			{
				cZigbeeAlarm->insert(0, 13, 1, 0x35, "ok");
			}
			else
			{
				cZigbeeAlarm->insert(0, 14, 1, 0x35, "ok");
			}
		}
	}
}

//**************************************************************************************

void ZigbeeAddHaDevice(const device_info_t& device_info)
{
    CZigbeeHA *const zigbee_ha = CZigbeeHA::getInstance();
    if(!zigbee_ha)
    {
        LOG_ERROR("server", "CZigbeeHA returned a NULL pointer");
    }
    else
    {
        // Note: These devices support many clusters. So the question is
        // which one to insert?
        zigbee_ha->insert(0, std::to_string(device_info.ieee_addr), device_info.nwk_addr);
    }
}

//**************************************************************************************

int ZigbeeAddAseDevice(const device_info_t& device_info)
{
    CZigbeeASE *const zigbee_ase = CZigbeeASE::getInstance();
    if(!zigbee_ase)
    {
        LOG_ERROR("server", "CZigbeeASE returned a NULL pointer");
        return -1;
    }

    return zigbee_ase->insert(0/* TODO */, std::to_string(device_info.ieee_addr),
            device_info.nwk_addr, 0/* TODO */, 0/* TODO */,
            0/* TODO */);

}

// **************************************************************************************

void ZigbeeRemoveDevice(int zigbeeId)
{
	CDeviceRegistration * cDevReg = new CDeviceRegistration(); 
	if(cDevReg == NULL)
	{
		LOG_ERROR("server", "CZigbee returned a NULL pointer");
	}
	else
	{
		CDeviceRegistration cDevRegObj;
		cDevReg->retrieve(zigbeeId, cDevRegObj);
		unsigned long long addr;
		::std::stringstream ss_addr;
		ss_addr << std::hex << cDevRegObj.getZigbeeAddr64();;
		ss_addr >> addr;
		if (ZigbeeSyncRemoveDevice(addr))
		{
		    // The log is already produced by the function itself.
		}
		else
		{
			int type = cDevRegObj.getType();
			std::string addr = cDevRegObj.getZigbeeAddr64();
			if(type == 0)
			{
				CZigbeeASE * cZigbeeASE = CZigbeeASE::getInstance();
				if(cZigbeeASE == NULL)
				{
					LOG_ERROR("server", "CZigbeeASE returned a NULL pointer");
				}
				else
				{
					cZigbeeASE->removeASE(addr);
				}
			}
			else if(type == 80)
			{
				CZigbeeHA * cZigbeeHA = CZigbeeHA::getInstance();
				if(cZigbeeHA == NULL)
				{
					LOG_ERROR("server", "CZigbeeASE returned a NULL pointer");
				}
				else
				{
					cZigbeeHA->removeHA(addr);
				}
			}
		}
	}
}

// **************************************************************************************

void ZigbeeDiscoverRoute()
{
#if 0 // Reserved for future use
	zigbee_error = 0; //Some API from zigbee.h to generate the list of devices with route and other info
	if(!zigbee_error)
	{
		CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
		if(cZigbeeAlarm == NULL)
		{
			LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
		}
		else
		{
			//for(some loop according to the size of the list of devices)
			{
				cZigbeeAlarm->insertRoute("64BitAddr", 16, 2, 17, 1, 0x37, "ok", "1");
			}
		}
	}
	else
	{
		CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
		if(cZigbeeAlarm == NULL)
		{
			LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
		}
		else
		{
			//log error
			//cZigbeeAlarm->insert(0, 17, 1, 0x39, "error");
		}
	}
#endif
}

//**************************************************************************************

int ZigbeeIeeeAddressToDeviceId(unsigned long long ieee_addr, int& device_id)
{
    CZigbeeASE *const zigbee_ase = CZigbeeASE::getInstance();
    if(!zigbee_ase)
    {
        LOG_ERROR("server", "CZigbeeASE returned a NULL pointer");
        return -1;
    }
	CZigbeeASE zigbee_ase_obj;
    if (zigbee_ase->retrieveDevId(std::to_string(ieee_addr), zigbee_ase_obj) > 0)
    {
        device_id = zigbee_ase_obj.getDeviceId();
        return 0;
    }
    return -1;
}
// **************************************************************************************

#if 0 // It will be removed
void ZigbeePingRemoteDev(int deviceId)
{
	CZigbeeDevice * cZigbeeDevice = new CZigbeeDevice(); 
	if(cZigbeeDevice == NULL)
	{
		LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
	}
	else
	{
		CZigbeeDevice cZigbeeDeviceObj;
		cZigbeeDevice->retrieveAddr64(deviceId, cZigbeeDeviceObj);
		zigbee_error = 0; //Some API from zigbee.h to ping the remote device
		if(!zigbee_error)
		{
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else
			{
				cZigbeeAlarm->insert(deviceId, cZigbeeDeviceObj.getXbeeAddr64(), 16, 0, 0x38, "ok");
			}
		}
		else
		{
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else
			{
				cZigbeeAlarm->insert(deviceId, cZigbeeDeviceObj.getXbeeAddr64(), 16, 1, 0x38, "error");
			}
		}
	}
	delete cZigbeeDevice;
}
#endif

// **************************************************************************************

void ZigbeeEnableZedDev(int deviceId)
{
	CZigbeeASE * cZigbeeASE = new CZigbeeASE();
	if(cZigbeeASE == NULL)
	{
		LOG_ERROR("server", "CZigbeeASE returned a NULL pointer");
	}
	else
	{
		CZigbeeASE cZigbeeASEObj;
		cZigbeeASE->retrieveState(deviceId, cZigbeeASEObj);
		zigbee_error = 0;	//Some API from zigbee.h to Enable ZED device with @addr64 and @state as parameter
		if(!zigbee_error)
		{
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else
			{
				cZigbeeAlarm->insert(deviceId, 20, 1, 0x39, "ok");
			}
		}
		else
		{
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else
			{
				cZigbeeAlarm->insert(deviceId, 20, 1, 0x39, "error");
			}
		}
	}
	delete cZigbeeASE;
}

// **************************************************************************************

void ZigbeeEnableDigiAC(int deviceId)
{
	CZigbeeHA * cZigbeeHA = new CZigbeeHA(); 
	if (!cZigbeeHA)
	{
		LOG_ERROR("server", "CZigbeeHA returned a NULL pointer");
		return;
	}

	CSmartPlugdyn * cSmartPlugdyn = new CSmartPlugdyn(); 
	if (!cSmartPlugdyn)

	{
		LOG_ERROR("server", "CSmartPlugdyn returned a NULL pointer");
		return;
	}

	CZigbeeAlarm *const cZigbeeAlarm = CZigbeeAlarm::getInstance();
	if (!cZigbeeAlarm)
	{
	    LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
	    return;
	}


	CZigbeeHA cZigbeeHAObj;
	CSmartPlugdyn cSmartPlugdynObj;
	cZigbeeHA->retrieveAddr(deviceId, cZigbeeHAObj);
	cSmartPlugdyn->retrieve(deviceId, cSmartPlugdynObj);

    const bool desired_state = cSmartPlugdynObj.getState();
	
	unsigned long long addr;
	::std::stringstream ss_addr64;
	ss_addr64 << std::hex << cZigbeeHAObj.getZigbeeAddr64();
	ss_addr64 >> addr;
	
	if (ZigbeeSyncSendOnOffReq(addr, desired_state))
    {
        cZigbeeAlarm->insert(deviceId, 18, 1, SET_AC_ONOFF_DIGI, "error");
        return;
    }

    bool actual_state;
	::std::stringstream ss_addr_ha;
	ss_addr_ha << std::hex << cZigbeeHAObj.getZigbeeAddr64();
	ss_addr_ha >> addr;
	
    if (ZigbeeSyncReadOnOffAttrib(addr, actual_state))
    {
        cZigbeeAlarm->insert(deviceId, 18, 1, SET_AC_ONOFF_DIGI, "error");
        return;
    }

    if (desired_state != actual_state)
    {
        cZigbeeAlarm->insert(deviceId, 18, 1, SET_AC_ONOFF_DIGI, "error");
        return;
    }

    cZigbeeAlarm->insert(deviceId, 18, 0, SET_AC_ONOFF_DIGI, "ok");
	delete cSmartPlugdyn;
	delete cZigbeeHA;
}

// **************************************************************************************

void ZigbeeReadCurrent(int deviceId)
{
	CZigbeeHA * cZigbeeHA = new CZigbeeHA(); 
	if (cZigbeeHA == NULL)
	{
		LOG_ERROR("server", "CZigbeeHA returned a NULL pointer");
	}
	else
	{
		CZigbeeHA cZigbeeHAObj;
		cZigbeeHA->retrieveAddr(deviceId, cZigbeeHAObj);
		unsigned value;

		unsigned long long addr;
		::std::stringstream ss_addr;
		ss_addr << std::hex << cZigbeeHAObj.getZigbeeAddr64();
		ss_addr >> addr;

		if (ZigbeeSyncReadSmartMeter(addr, value))
		{
            //Log Error
            CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
            if(cZigbeeAlarm == NULL)
            {
                LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
            }
            else
            {
                cZigbeeAlarm->insert(deviceId, 18, 1, READ_AC_CURRENT, "error");
            }
		}
		else
		{
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			CSmartPlugdyn * cSmartPlugdyn = CSmartPlugdyn::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else if (cSmartPlugdyn == NULL)
			{
				LOG_ERROR("server", "CSmartPlugdyn returned a NULL pointer");
			}
			else
			{
				cSmartPlugdyn->update(deviceId, 0); // 0 MUST BE REPLACED WITH THE CURRENT PROVIDED
				cZigbeeAlarm->insert(deviceId, 18, 0, READ_AC_CURRENT, "ok");
			}
		}
	}
	delete cZigbeeHA;
}

// **************************************************************************************

void ZigbeeRegistrationResponse(int deviceId, ASEMProfile* asempProfile)
{
	CZigbeeASE * cZigbeeASE = new CZigbeeASE(); 
	if(cZigbeeASE == NULL)
	{
		LOG_ERROR("server", "CZigbeeASE returned a NULL pointer");
	}
	else
	{
		CZigbeeASE cZigbeeASEObj;
		cZigbeeASE->retrieve(deviceId, cZigbeeASEObj);
		CASEMP * cASEMP = new CASEMP();
		if(cASEMP == NULL)
		{
			LOG_ERROR("server", "CASEMP returned a NULL pointer");
		}
		else
		{
			CASEMP cASEMPObj;
			cASEMP->retrieve(cZigbeeASEObj.getProfileId(), cASEMPObj);
			CZone * cZone = new CZone();
			if(cZone == NULL)
			{
				LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
			}
			else
			{
				CZone cZoneObj;
				cZone->retrieve(deviceId, cZoneObj);
				//HERE WE NEED TO ASEMBLE ASEMP MESSAGE ACCORDING TO DATA FETCHED ABOVE
				asempProfile->ASEMPMobj.protocolID = 0XF1;
				asempProfile->zone_occu = cZoneObj.getOcupation();
				asempProfile->occu_rep = cASEMPObj.getProfileValues(PROFILE_OCCUPIED_REPORTING_PERIOD);
				asempProfile->unoccu_rep = cASEMPObj.getProfileValues(PROFILE_UNOCCUPIED_REPORTING_PERIOD);
				asempProfile->occu_pir = cASEMPObj.getProfileValues(PROFILE_OCCUPIED_PIR_TRIGGER_ENABLE);
				asempProfile->unoccu_pir = cASEMPObj.getProfileValues(PROFILE_UNOCCUPIED_PIR_TRIGGER_ENABLE);
				asempProfile->max_retry = cASEMPObj.getProfileValues(PROFILE_MAX_RETRY_COUNT_ENABLE);
				asempProfile->max_wait = cASEMPObj.getProfileValues(PROFILE_MAX_WAIT_TIMER_ENABLE);
				asempProfile->min_rep_wait = cASEMPObj.getProfileValues(PROFILE_MIN_REPORT_INTERVAL_ENABLE);
				asempProfile->bat_stat_thr = cASEMPObj.getProfileValues(PROFILE_BATTERY_THRESHOLD_TRIGGER_ENABLE);
				asempProfile->up_temp_tr = cASEMPObj.getProfileValues(PROFILE_TEMP_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->up_hum_tr = cASEMPObj.getProfileValues(PROFILE_HUMIDITY_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->lo_hum_tr = cASEMPObj.getProfileValues(PROFILE_HUMIDITY_DNTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->lux_sl_tr = cASEMPObj.getProfileValues(PROFILE_LUX_SLOPE_TRIGGER_ENABLE);
				asempProfile->up_co_tr = cASEMPObj.getProfileValues(PROFILE_CO_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->up_co2_tr = cASEMPObj.getProfileValues(PROFILE_CO2_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->aud_alarm = cASEMPObj.getProfileValues(PROFILE_AUDIBLE_ALARM_ENABLE);
				asempProfile->led_alarm = cASEMPObj.getProfileValues(PROFILE_LED_ALARM_ENABLE);
				asempProfile->temp_sl_alarm = cASEMPObj.getProfileValues(PROFILE_TEMP_SLOPE_TRIGGER_ENABLE);
				asempProfile->mcu_sleep = cASEMPObj.getProfileValues(PROFILE_MCU_SLEEP_TIMER);
				asempProfile->ac_curr_thr = cASEMPObj.getProfileValues(PROFILE_AC_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->lo_temp_tr = cASEMPObj.getProfileValues(PROFILE_TEMP_DNTHRESHOLD_TRIGGER_ENABLE);
				
				zigbee_error = 0; //Some API from zigbee.h to send the registration response to ZED with assembled ASEMP profile
				if(!zigbee_error)
				{
					CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
					if(cZigbeeAlarm == NULL)
					{
						LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
					}
					else
					{
						cZigbeeAlarm->insertAck(deviceId, 19, 1, RESPONSE_REGISTERATION, "ok", 1);
					}
				}
				else
				{
					//Log Error
					CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
					if(cZigbeeAlarm == NULL)
					{
						LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
					}
					else
					{
						cZigbeeAlarm->insert(deviceId, 19, 2, RESPONSE_REGISTERATION, "error");
					}
				}
			}
			delete cZone;
		}
		delete cASEMP;
	}
	delete cZigbeeASE;
}

// **************************************************************************************

void ZigbeeCentralCommandRequest(int deviceId, CentralCommandRequest *centralCommandRequest)
{
	//int pos = 0;
	CZigbeeASE * cZigbeeASE = new CZigbeeASE(); 
	if(cZigbeeASE == NULL)
	{
		LOG_ERROR("server", "CZigbeeASE returned a NULL pointer");
	}
	else
	{
		CZigbeeASE cZigbeeASEObj;
		cZigbeeASE->retrieve(deviceId, cZigbeeASEObj);
		
		//
		//	addr64(std::string) = cZigbeeASEObj.getZigbeeAddr64() and 
		//	device_type(int) = cZigbeeASEObj.getDeviceType() 
		//
		
		zigbee_error = 0; 		//Some API from zigbee.h sending central command request to ZED.
		if (!zigbee_error)
		{
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else
			{
				cZigbeeAlarm->insert(deviceId, 19, 0, CENTRAL_COMMAND_REQUEST, "ok");
			}
		}
		else
		{
			//Log Error
			CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
			if(cZigbeeAlarm == NULL)
			{
				LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
			}
			else
			{
				cZigbeeAlarm->insert(deviceId, 19, 1, CENTRAL_COMMAND_REQUEST, "error");
			}
		}
	}
	delete cZigbeeASE;
}

// **************************************************************************************

void ZigbeeUpdateProfile(int deviceId, UpdateProfileRequest* asempProfile)
{
	CZigbeeASE * cZigbeeASE = new CZigbeeASE(); 
	if(cZigbeeASE == NULL)
	{
		LOG_ERROR("server", "CZigbeeASE returned a NULL pointer");
	}
	else
	{
		CZigbeeASE cZigbeeASEObj;
		cZigbeeASE->retrieve(deviceId, cZigbeeASEObj);
		CASEMP * cASEMP = new CASEMP();
		if(cASEMP == NULL)
		{
			LOG_ERROR("server", "CASEMP returned a NULL pointer");
		}
		else
		{
			CASEMP cASEMPObj;
			cASEMP->retrieve(cZigbeeASEObj.getProfileId(), cASEMPObj);
			CZone * cZone = new CZone();
			if(cZone == NULL)
			{
				LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
			}
			else
			{
				CZone cZoneObj;
				cZone->retrieve(deviceId, cZoneObj);
				//HERE WE NEED TO ASEMBLE ASEMP MESSAGE ACCORDING TO DATA FETCHED ABOVE
				asempProfile->ASEMProObj.ASEMPMobj.protocolID = 0XF4;
				asempProfile->ASEMProObj.zone_occu = cZoneObj.getOcupation();
				asempProfile->ASEMProObj.occu_rep = cASEMPObj.getProfileValues(PROFILE_OCCUPIED_REPORTING_PERIOD);
				asempProfile->ASEMProObj.unoccu_rep = cASEMPObj.getProfileValues(PROFILE_UNOCCUPIED_REPORTING_PERIOD);
				asempProfile->ASEMProObj.occu_pir = cASEMPObj.getProfileValues(PROFILE_OCCUPIED_PIR_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.unoccu_pir = cASEMPObj.getProfileValues(PROFILE_UNOCCUPIED_PIR_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.max_retry = cASEMPObj.getProfileValues(PROFILE_MAX_RETRY_COUNT_ENABLE);
				asempProfile->ASEMProObj.max_wait = cASEMPObj.getProfileValues(PROFILE_MAX_WAIT_TIMER_ENABLE);
				asempProfile->ASEMProObj.min_rep_wait = cASEMPObj.getProfileValues(PROFILE_MIN_REPORT_INTERVAL_ENABLE);
				asempProfile->ASEMProObj.bat_stat_thr = cASEMPObj.getProfileValues(PROFILE_BATTERY_THRESHOLD_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.up_temp_tr = cASEMPObj.getProfileValues(PROFILE_TEMP_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.up_hum_tr = cASEMPObj.getProfileValues(PROFILE_HUMIDITY_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.lo_hum_tr = cASEMPObj.getProfileValues(PROFILE_HUMIDITY_DNTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.lux_sl_tr = cASEMPObj.getProfileValues(PROFILE_LUX_SLOPE_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.up_co_tr = cASEMPObj.getProfileValues(PROFILE_CO_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.up_co2_tr = cASEMPObj.getProfileValues(PROFILE_CO2_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.aud_alarm = cASEMPObj.getProfileValues(PROFILE_AUDIBLE_ALARM_ENABLE);
				asempProfile->ASEMProObj.led_alarm = cASEMPObj.getProfileValues(PROFILE_LED_ALARM_ENABLE);
				asempProfile->ASEMProObj.temp_sl_alarm = cASEMPObj.getProfileValues(PROFILE_TEMP_SLOPE_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.mcu_sleep = cASEMPObj.getProfileValues(PROFILE_MCU_SLEEP_TIMER);
				asempProfile->ASEMProObj.ac_curr_thr = cASEMPObj.getProfileValues(PROFILE_AC_UPTHRESHOLD_TRIGGER_ENABLE);
				asempProfile->ASEMProObj.lo_temp_tr = cASEMPObj.getProfileValues(PROFILE_TEMP_DNTHRESHOLD_TRIGGER_ENABLE);
				
				zigbee_error = 0; //Some API from zigbee.h to send the registration response to ZED with assembled ASEMP profile
				if(!zigbee_error)
				{
					CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
					if(cZigbeeAlarm == NULL)
					{
						LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
					}
					else
					{
						cZigbeeAlarm->insertAck(deviceId, 19, 1, ASEMP_PROFILE_UPDATE, "ok", 1);
					}
				}
				else
				{
					//Log Error
					CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
					if(cZigbeeAlarm == NULL)
					{
						LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
					}
					else
					{
						cZigbeeAlarm->insert(deviceId, 19, 0, ASEMP_PROFILE_UPDATE, "error");
					}
				}
			}
			delete cZone;
		}
		delete cASEMP;
	}
	delete cZigbeeASE;
}

// **************************************************************************************

void ZigbeeCentralCommandResponse(CentralCommandResponse *response)
{
	CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
	if(cZigbeeAlarm == NULL)
	{
		LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
	}
	else
	{
		cZigbeeAlarm->insertAck(response->deviceID, 19, 0, CENTRAL_COMMAND_REQUEST, "ok", response->ack);
	}
}

// **************************************************************************************

void ZigbeeUpdateProfileResponse(UpdateProfileResponse *response)
{
	CZigbeeAlarm * cZigbeeAlarm = CZigbeeAlarm::getInstance();
	if(cZigbeeAlarm == NULL)
	{
		LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
	}
	else
	{
		cZigbeeAlarm->insertAck(response->deviceID, 19, 0, CENTRAL_COMMAND_REQUEST, "ok", response->ack);
	}
}

// **************************************************************************************

void ZigbeeNewDeviceJoin(std::string addr64, int addr16, ASEDevice *aseDevice)
{
	CZigbeeASE * cZigbeeASE= CZigbeeASE::getInstance();
	cZigbeeASE->insert(aseDevice->deviceType, addr64, addr16, aseDevice->zigbeeHwVersion, aseDevice->zigbeeFirmwareVersion, aseDevice->aseFirmwareVersion);
}

// **************************************************************************************

void RemoveStaleCommands()
{
	CZigbeeCommands* cZigbeeCommands = CZigbeeCommands::getInstance();
	cZigbeeCommands->remove();
}

// **************************************************************************************

void ZigbeeClusterCommandProcess(int deviceId)
{
	CZigbeeCommands* cZigbeeCommands = new CZigbeeCommands();
	CZigbeeCommands cZigbeeCommandsObj;
	cZigbeeCommands->retrieve(deviceId, cZigbeeCommandsObj);
	if(cZigbeeCommandsObj.getReturnedCode() == ASE_COMMAND_WAIT_TO_PROCESS)
	{
		if(cZigbeeCommandsObj.getCommand() == ZCL_CLUSTER_ID_GEN_ON_OFF_CMD)
		{
			//Function to send ZCL_CLUSTER_ID_GEN_ON_OFF_CMD command to ZED should be called here
		}
		else if(cZigbeeCommandsObj.getCommand() == ZCL_CLUSTER_ID_SE_SIMPLE_METERING_CMD)
		{
			//Function to send ZCL_CLUSTER_ID_SE_SIMPLE_METERING_CMD command to ZED should be called here
		}
		cZigbeeCommandsObj.insert(ASE_COMMAND_PENDING);
		RemoveStaleCommands();
	}
	delete cZigbeeCommands;
}

// **************************************************************************************

void onZigbeeClusterCommandResponse(int returnCode, std::string returnString, int returnValue)
{
	CZigbeeCommands* cZigbeeCommands = CZigbeeCommands::getInstance();
	cZigbeeCommands->insert(returnCode, returnString, returnValue);
}
