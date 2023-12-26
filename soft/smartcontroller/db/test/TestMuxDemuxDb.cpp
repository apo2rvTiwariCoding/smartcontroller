#include<stdio.h>
//#include "global.h"
#include<stdlib.h>
#include<unistd.h>
#include<stdio.h>
#include<string.h>
#include "db/Database.h"
#include "db/SmartSensor.h"
#include "db/SmartSensorRaw.h"
#include "db/Thermostat.h"
#include "db/Relays.h"
#include "db/HVAC.h"
#include "db/Humidifier.h"
#include "db/AlarmSystem.h"
#include "db/Diagnostics.h"
#include "db/Zigbee.h"
#include "db/Bypass.h"
#include "db/ZigbeeAlarm.h"
#include "db/DeviceRegistration.h"
#include "db/ZigbeeDevice.h"
#include "db/ZigbeeAlarm.h"
#include "db/ASEMP.h"
#include "db/Commands.h"
#include "db/Zone.h"
#include "db/RemoteControl.h"
#include "db/PendingAction.h"
#include "db/SmartDevices.h"
#include "inc/ZigbeeTypes.h"
//#include "hal/hal.h"
#include <pthread.h>
#include "util/log/log.h"

pthread_t tid[500];
volatile unsigned ij = 0;

void* test_thread_proc(void *arg)
{
	unsigned int x = ++ij;
	//if(x%200)
	{
		CDeviceRegistration* asemp = new CDeviceRegistration();//::getInstance();//new CBypass(); //
		//CASEMP cCmnd;
		//asemp->insert(x, x, x, x, x, x, x, x, "CHUTIYAPA");
		CDeviceRegistration registration;
		//asemp->retrieveStatus(x, registration);
		printf("Thread no. %d @ Command = %d\n", x, registration.getStatus());
		delete asemp;
	}
	return NULL;
}

int main(int argc, char *argv[])
{
	CDatabase* pdb = CDatabase::getInstance("127.0.0.1", argv[1], argv[2], argv[3]);
	if(pdb == NULL)
	{
		fprintf(stderr,"Database instance is not created\n");
		return 1;
	}

	int i = 0;
	int err;

	while(i < 200)
	{
		err = pthread_create(&(tid[i]), NULL, &test_thread_proc, NULL);
		if (err != 0)
			printf("\ncan't create thread :[%s]", strerror(err));
		else
			printf("\n Thread created successfully\n");
		
		if(pthread_detach(tid[i]));
		i++;
	}
	while(1);
//	int pthread_create(pthread_t *restrict tidp, const pthread_attr_t *restrict attr, test_thread_proc, void *restrict arg)


/*
	CASEMP* asemp = CASEMP::getInstance();
	if(asemp == NULL)
	{
		pLog->error("database",__LINE__,__FILE__,"Can not initialize asemp");
		fprintf(stderr,"Can not initialize asemp\n");
		return 1;
	}
	printf("Getting data from ASEMP Table\n");
	asemp->retrieve(0);
	printf("Value @ PROFILE_OCCUPIED_REPORTING_PERIOD.......... = %d \n", asemp->getProfileValues(PROFILE_OCCUPIED_REPORTING_PERIOD));
	printf("Value @ PROFILE_UNOCCUPIED_REPORTING_PERIOD........ = %d \n", asemp->getProfileValues(PROFILE_UNOCCUPIED_REPORTING_PERIOD));
	printf("Value @ PROFILE_OCCUPIED_PIR_TRIGGER_ENABLE........ = %d \n", asemp->getProfileValues(PROFILE_OCCUPIED_PIR_TRIGGER_ENABLE));
	printf("Value @ PROFILE_UNOCCUPIED_PIR_TRIGGER_ENABLE...... = %d \n", asemp->getProfileValues(PROFILE_UNOCCUPIED_PIR_TRIGGER_ENABLE));
	printf("Value @ PROFILE_MAX_RETRY_COUNT_ENABLE............. = %d \n", asemp->getProfileValues(PROFILE_MAX_RETRY_COUNT_ENABLE));
	printf("Value @ PROFILE_MAX_WAIT_TIMER_ENABLE.............. = %d \n", asemp->getProfileValues(PROFILE_MAX_WAIT_TIMER_ENABLE));
	printf("Value @ PROFILE_MIN_REPORT_INTERVAL_ENABLE......... = %d \n", asemp->getProfileValues(PROFILE_MIN_REPORT_INTERVAL_ENABLE));
	printf("Value @ PROFILE_BATTERY_THRESHOLD_TRIGGER_ENABLE... = %d \n", asemp->getProfileValues(PROFILE_BATTERY_THRESHOLD_TRIGGER_ENABLE));
	printf("Value @ PROFILE_TEMP_UPTHRESHOLD_TRIGGER_ENABLE.... = %d \n", asemp->getProfileValues(PROFILE_TEMP_UPTHRESHOLD_TRIGGER_ENABLE));
	printf("Value @ PROFILE_HUMIDITY_UPTHRESHOLD_TRIGGER_ENABLE = %d \n", asemp->getProfileValues(PROFILE_HUMIDITY_UPTHRESHOLD_TRIGGER_ENABLE));
	printf("Value @ PROFILE_HUMIDITY_DNTHRESHOLD_TRIGGER_ENABLE = %d \n", asemp->getProfileValues(PROFILE_HUMIDITY_DNTHRESHOLD_TRIGGER_ENABLE));
	printf("Value @ PROFILE_LUX_SLOPE_TRIGGER_ENABLE........... = %d \n", asemp->getProfileValues(PROFILE_LUX_SLOPE_TRIGGER_ENABLE));
	printf("Value @ PROFILE_CO_UPTHRESHOLD_TRIGGER_ENABLE...... = %d \n", asemp->getProfileValues(PROFILE_CO_UPTHRESHOLD_TRIGGER_ENABLE));
	printf("Value @ PROFILE_CO2_UPTHRESHOLD_TRIGGER_ENABLE..... = %d \n", asemp->getProfileValues(PROFILE_CO2_UPTHRESHOLD_TRIGGER_ENABLE));
	printf("Value @ PROFILE_AUDIBLE_ALARM_ENABLE............... = %d \n", asemp->getProfileValues(PROFILE_AUDIBLE_ALARM_ENABLE));
	printf("Value @ PROFILE_LED_ALARM_ENABLE................... = %d \n", asemp->getProfileValues(PROFILE_LED_ALARM_ENABLE));
	printf("Value @ PROFILE_TEMP_SLOPE_TRIGGER_ENABLE.......... = %d \n", asemp->getProfileValues(PROFILE_TEMP_SLOPE_TRIGGER_ENABLE));
	printf("Value @ PROFILE_MCU_SLEEP_TIMER.................... = %d \n", asemp->getProfileValues(PROFILE_MCU_SLEEP_TIMER));
	printf("Value @ PROFILE_AC_UPTHRESHOLD_TRIGGER_ENABLE...... = %d \n", asemp->getProfileValues(PROFILE_AC_UPTHRESHOLD_TRIGGER_ENABLE));
	printf("Value @ PROFILE_TEMP_DNTHRESHOLD_TRIGGER_ENABLE.... = %d \n", asemp->getProfileValues(PROFILE_TEMP_DNTHRESHOLD_TRIGGER_ENABLE));

	printf("Getting data from Relays Table\n");
	CRelays *cr = CRelays::getInstance();
	if(cr == NULL)
	{
		fprintf(stderr,"Can not initialize CRelays\n");
		return 0;
	}

	cr->retrieve();
	printf("R1 = %d \n", cr->getR1());
	printf("R2 = %d \n", cr->getR2());
	printf("R3 = %d \n", cr->getR3());
	printf("R4 = %d \n", cr->getR4());
	printf("R5 = %d \n", cr->getR5());
	printf("R6 = %d \n", cr->getR6());

	vector<CPendingAction::Action*> actionList;

	CPendingAction* pAction = CPendingAction::getInstance();
	if(pAction == NULL)
	{
		fprintf(stderr,"Can not initialize asemp\n");
		return 0;
	}
	printf("\nGetting data from actions Table\n");
	pAction->retrieve(actionList);
	printf("Actionlist Size = %d\n", actionList.size());
	for(int i=0;i<actionList.size();i++)
	{
		if(actionList[i]!=NULL)
		{
			printf("Ref Table Name= %s\t", (actionList[i]->table).c_str());
			printf("Ref ID = %d\t", actionList[i]->refId);
			printf("Type= %d\t", actionList[i]->recordType);
			printf("Priority= %d\n", actionList[i]->priority);
		}
	}

	CAlarmSystem* alarmsSystem;
	alarmsSystem = CAlarmSystem::getInstance();
	printf("Inserting into Alarms System Table\n");
	alarmsSystem->insert(1, 2, 3, "Alarm System");

	printf("Inserting into Device Registration Table\n");
	CDeviceRegistration::getInstance()->insert(1,2,3,4,5,6,7,8, "Registration");
	printf("Inserting into Device Registration Table\n");
	CDeviceRegistration::getInstance()->insert(1,2,3,4,5,6);

	printf("Getting data from Device Registration Table\n");
	CDeviceRegistration::getInstance()->retrieve(1);
	printf("Addr64 = %s \n", CDeviceRegistration::getInstance()->getZigbeeAddr64().c_str());
	printf("Addr16 = %d \n", CDeviceRegistration::getInstance()->getZigbeeShort());

	printf("Inserting into Diagnostics Table\n");
	CDiagnostics::getInstance()->insert(1, "Diagnostics Table");

	printf("Getting data from Humidifier Table\n");
	CHumidifier::getInstance()->retrieve();
	printf("Humidifier = %d \n", CHumidifier::getInstance()->getHumidifier());

	printf("Getting data from HVAC Table\n");
	CHVAC::getInstance()->retrieve();
	printf("W1 = %d \n", CHVAC::getInstance()->getW1());
	printf("W2 = %d \n", CHVAC::getInstance()->getW2());
	printf("Y1 = %d \n", CHVAC::getInstance()->getY1());
	printf("Y2 = %d \n", CHVAC::getInstance()->getY2());
	printf("G= %d\n \n", CHVAC::getInstance()->getG());
	printf("OB %d\n \n", CHVAC::getInstance()->getOB());

	printf("Getting data from Relays Table\n");
	CRelays::getInstance()->retrieve();
	printf("R1 = %d \n", CRelays::getInstance()->getR1());
	printf("R2 = %d \n", CRelays::getInstance()->getR2());
	printf("R3 = %d \n", CRelays::getInstance()->getR3());
	printf("R4 = %d \n", CRelays::getInstance()->getR4());
	printf("R5 = %d \n", CRelays::getInstance()->getR5());
	printf("R6 = %d \n", CRelays::getInstance()->getR6());

	printf("Getting EnableTime from RemoteControl Table\n");
	CRemoteControl::getInstance()->retrieveEnableTime(2);
	printf("EnableTime = %d \n", CRemoteControl::getInstance()->getEnableTime());

	printf("Getting Louver from RemoteControl Table\n");
	CRemoteControl::getInstance()->retrieveLouver(2);
	printf("LouverPos = %d \n", CRemoteControl::getInstance()->getLouverPos());

	printf("Getting Dimmer from RemoteControl Table\n");
	CRemoteControl::getInstance()->retrieveDimmer(2);
	printf("Dimmer = %d \n", CRemoteControl::getInstance()->getDimmer());

	printf("Getting AC Enable from RemoteControl Table\n");
	CRemoteControl::getInstance()->retrieveACEnable(2);
	printf("AC Enable = %d \n", CRemoteControl::getInstance()->getAcEnable());

	printf("Inserting into SmartSensor Table\n");
	CSmartSensor::getInstance()->insert(1, 2);

	printf("Inserting into SmartSensor Table\n");
	CSmartSensor::getInstance()->insertTHV(1, 32.5, 3, 4);

	printf("Inserting into SmartSensor Table\n");
	CSmartSensor::getInstance()->insertTHC(3,40.3,5,6);

	printf("Inserting into SmartSensorRaw Table\n");
	CSmartSensorRaw::getInstance()->insert(3,4,"Smart Sensor Raw","S5 Systems");

	printf("Inserting into Thermostat Table\n");
	CThermostat::getInstance()->insert(3,4,5,6,7,8);

	printf("Getting data from Zigbee Table\n");
	CZigbee::getInstance()->retrieve(1);
	printf("Encryption = %d \n", CZigbee::getInstance()->getEncryption());
	printf("Channel = %d \n", CZigbee::getInstance()->getChannel());
	printf("PanId = %d \n", CZigbee::getInstance()->getPanId());
	printf("PanIdSel = %d \n", CZigbee::getInstance()->getPanIdSel());
	printf("SecKey= %s \n", CZigbee::getInstance()->getSecKey().c_str());

	printf("Getting Encryption from Zigbee Table\n");
	CZigbee::getInstance()->retrieve(1);
	printf("Encryption = %d \n", CZigbee::getInstance()->getEncryption());

	printf("Updating data in Zigbee Table\n");
	CZigbee::getInstance()->update(1, 2,3, "Zigbee", "S5 Systems", "Third", "Fourth", "Fifth");

	printf("Updating PanId in Zigbee Table\n");
	CZigbee::getInstance()->updatePanId(1, 2);

	printf("Updating Channel in Zigbee Table\n");
	CZigbee::getInstance()->updateChannel(1, 2);

	printf("Inserting into ZigbeeAlarm Table\n");
	CZigbeeAlarm::getInstance()->insert(1, "Zigbee", 2, 3, 4, 5, "S5 Systems");

	printf("Inserting PanId into ZigbeeAlarm Table\n");
	CZigbeeAlarm::getInstance()->insertPanId(1, "PanId", 2, 3, 4, 5, "S5 Systems", 6);

	printf("Inserting Channelinto ZigbeeAlarm Table\n");
	CZigbeeAlarm::getInstance()->insertChannel(1, "Channel", 2, 3, 4, 5, "S5 Systems", 6);

	printf("Inserting Route into ZigbeeAlarm Table\n");
	CZigbeeAlarm::getInstance()->insertRoute(1, "Route", 2, 3, 4, 5, 6,"S5 Systems", "Zigbee");

	printf("Getting data from ZigbeeDevice Table\n");
	CZigbeeDevice::getInstance()->retrieve(24);
	printf("Xbee 64 BitAddr= %s\n", CZigbeeDevice::getInstance()->getXbeeAddr64().c_str());
	printf("Zone Id = %d \n", CZigbeeDevice::getInstance()->getZoneId());
	printf("Device Type = %d\n", CZigbeeDevice::getInstance()->getDeviceType());
	printf("ASEMP = %d \n", CZigbeeDevice::getInstance()->getASEMP());

	printf("Getting Addr64 from ZigbeeDevice Table\n");
	CZigbeeDevice::getInstance()->retrieveAddr64(25);
	printf("Xbee 64 BitAddr= %s \n", CZigbeeDevice::getInstance()->getXbeeAddr64().c_str());

	printf("Getting occupation from Zone Table\n");
	CZone::getInstance()->retrieve(1);
	printf("Occupation = %d \n", CZone::getInstance()->getOcupation());

	Hal::TW1Devices devicesDB;
	Hal::TW1Devices devicesHAL;
	//devicesHAL = {22334455, 33445566, 44556677, 55667788};
	//devicesHAL = {33445566, 44556677, 22334455, 55667788};
	//devicesHAL = {66778899, 33445566, 77889900, 22334455, 44556677, 55667788};
	devicesHAL = {22445566, 11556677};
	//devicesHAL = {};
	printf("Checking Enumerate 1-wire devices\n");
	CSmartDevices::getInstance()->retrieve1WDev(devicesDB);
	//printf("Occupation = %d \n", CZone::getInstance()->getOcupation());
	CSmartDevices::getInstance()->enumerateOneWireDev(devicesHAL);
*/
}
