#include <string.h>
#include "Database.h"
#include "ASEMP.h"
#include "inc/ZigbeeTypes.h"
#include "util/log/log.h"

CASEMP* CASEMP::mInstance = NULL;
CASEMP::CASEMP()
{
}

CASEMP::~CASEMP()
{
}

int CASEMP::retrieve(int asemp, CASEMP& casemp)
{
	int recCount =0;
	char query[1000];

	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT parameter, value FROM asemp WHERE type_ BETWEEN 0 AND 1 AND profile_id = \'%d\'", asemp);
 		int result = pdb->query(query, record);
		if(result == DB_FAIL) 
		{
			LOG_ERROR("database", "Query not executed");
		}
		else
		{
			recCount = record.size();
			for(unsigned int i=0;i<record.size();i++)
			{
				VROW row = record[i];
                     				
				std::string parameter = row[0];
				int value=atoi(row[1].c_str());

				if(!strcmp(parameter.c_str(), "occu_rep"))
				{
					casemp.mValues[PROFILE_OCCUPIED_REPORTING_PERIOD] = value;
				}
				else if(!strcmp(parameter.c_str(), "unoccu_rep"))
				{
					casemp.mValues[PROFILE_UNOCCUPIED_REPORTING_PERIOD] = value;
				}
				else if(!strcmp(parameter.c_str(), "occu_pir"))
				{
					casemp.mValues[PROFILE_OCCUPIED_PIR_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "unoccu_pir"))
				{
					casemp.mValues[PROFILE_UNOCCUPIED_PIR_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "max_retry"))
				{
					casemp.mValues[PROFILE_MAX_RETRY_COUNT_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "max_wait"))
				{
					casemp.mValues[PROFILE_MAX_WAIT_TIMER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "min_rep_int"))
				{
					casemp.mValues[PROFILE_MIN_REPORT_INTERVAL_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "bat_stat_thr"))
				{
					casemp.mValues[PROFILE_BATTERY_THRESHOLD_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "up_temp_tr"))
				{
					casemp.mValues[PROFILE_TEMP_UPTHRESHOLD_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "up_hum_tr"))
				{
					casemp.mValues[PROFILE_HUMIDITY_UPTHRESHOLD_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "lo_hum_tr"))
				{
					casemp.mValues[PROFILE_HUMIDITY_DNTHRESHOLD_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "lux_sl_tr"))
				{
					casemp.mValues[PROFILE_LUX_SLOPE_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "up_co_tr"))
				{
					casemp.mValues[PROFILE_CO_UPTHRESHOLD_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "up_co2_tr"))
				{
					casemp.mValues[PROFILE_CO2_UPTHRESHOLD_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "aud_alarm"))
				{
					casemp.mValues[PROFILE_AUDIBLE_ALARM_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "led_alarm"))
				{
					casemp.mValues[PROFILE_LED_ALARM_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "temp_sl_tr"))
				{
					casemp.mValues[PROFILE_TEMP_SLOPE_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "mcu_sleep"))
				{
					casemp.mValues[PROFILE_MCU_SLEEP_TIMER] = value;
				}
				else if(!strcmp(parameter.c_str(), "ac_curr_thr"))
				{
					casemp.mValues[PROFILE_AC_UPTHRESHOLD_TRIGGER_ENABLE] = value;
				}
				else if(!strcmp(parameter.c_str(), "lo_temp_tr"))
				{
					casemp.mValues[PROFILE_TEMP_DNTHRESHOLD_TRIGGER_ENABLE] = value;
				}
			}
		}
	}
	else
	{
		LOG_ERROR("server", "CDatabase returned a NULL pointer");
	}
return recCount;
}


