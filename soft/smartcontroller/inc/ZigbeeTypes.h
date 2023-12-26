#ifndef _ZIGBEETYPES_H
#define _ZIGBEETYPES_H

/* ZigbeeAlarmType */

#define ZIGBEE_CONNECTED				0	//zigbee device connected to smart controller network
#define ZIGBEE_LOSS_COMMUNICATION		1	//loss of communication with remote device
#define ZIGBEE_PANID_CONFLICT			2	//PAN ID conflict. A new PAN ID is needed. PAN ID are automatically generated by the smart controller coordinator by scanning adjacent PAN IDs
#define ZIGBEE_PANID_RESOLVED			3	//PAN ID resolution. A new PAN ID has been generated by the smart controller coordinator
#define ZIGBEE_RF_INTERFERENCE			4	//RF interference. A new RF channel needed. The Smart Controller will scan for the least noisy RF channel available
#define ZIGBEE_NEW_CHANNEL				5	//RF interference resolution. A new RF channel has been selected by the smart controller coordinator
#define ZIGBEE_RESTART_FAIL				6	//Radio module unsuccessful restart
#define ZIGBEE_RESTART_SUCCESS			7	//Radio module successful restart
#define ZIGBEE_NWCREATE_FAIL			8	//Unable to create new zigbee network with passed parameters
#define ZIGBEE_NWCREATE_ SUCCESS		9	//New Zigbee network successfully created
#define ZIGBEE_PARACHANGE_FAIL			10	//Existing Zigbee network parameters change error
#define ZIGBEE_PARACHANGE_SUCCESS		11	//Zigbee network parameters successful change
#define ZIGBEE_CONFIGMODECHANGE_FAIL	12	//Unable to change configuration mode
#define ZIGBEE_CONFIGMODE_ENABLED		13	//Configuration mode successfully enabled (new devices allowed to join)
#define ZIGBEE_CONFIGMODE_DISABLED		14	//Configuration mode successfully disabled (new devices disallowed to join)
#define ZIGBEE_NWDISCOVERY_RESULT		15	//Network discovery result
#define ZIGBEE_PING_RESULT				16	//Ping remote device result
#define ZIGBEE_ROUTE_DISCOVERY			17	//Route discovery result
#define ZIGBEE_NONASE_STATUS			18	//non-ASE device command status
#define ZIGBEE_ASE_STATUS				19	//ASE device (ASEMP capable) command status

/* ZCL Cluster Commands */
#define ZCL_CLUSTER_ID_GEN_ON_OFF_CMD           0x0006
#define ZCL_CLUSTER_ID_SE_SIMPLE_METERING_CMD   0x0702

/* SmartentITconstants */
#define SMARTENIT_MANUFACTURERID 		0x1075
#define ZBMPLUG15_DEVICEID				0x0009

/* Cluster Commands Return Code */
#define ASE_COMMAND_WAIT_TO_PROCESS  	0x00
#define ASE_COMMAND_PENDING			  	0x01
#define ASE_COMMAND_OK				  	0x02
#define ASE_COMMAND_FAILURE 		  	0x03
#define ASE_COMMAND_ERROR 			  	0x04

/* AlarmSeverity: */

#define ZIGBEE_ALARM_LOW		0	//Green (Lowest) 
#define ZIGBEE_ALARM_MEDIUM		1	//Yellow
#define ZIGBEE_ALARM_HIGH		2	//Red (Highest)

/* DeviceStatus */

#define ZIGBEE_DEVICE_ACTIVE		0	//Active, waiting for  registration 
#define ZIGBEE_DEVICE_INACTIVE		1	//Inactive
#define ZIGBEE_DEVICE_REGISTERED	2	//Registration Accepted (for event type 1)
#define ZIGBEE_DEVICE_REJECTED		3	//Registration Rejected (for event type 1)
#define ZIGBEE_DEVICE_DEREGISTERED	4	//Device successfully de-registered from network


/* RegistrationEventType */

#define ZIGBEE_DEVICE_DELETE			0	//Deletion of Zigbee device previously connected to the smart controller database 
#define ZIGBEE_DEVICE_ADD_NEW			1	//Addition of new Zigbee device to the smart controller databse
#define ZIGBEE_DEVICE_ASEMP_UPDATE		2	//Update the ASEMP profile of the remote device
#define ZIGBEE_DEVICE_STATUS_UPDATE	3	//Update the status of the remote device
#define ZIGBEE_DEVICE_ADD16_UPDATE		4	//Update the zigbee short address of the remote device
#define ZIGBEE_DEVICE_REG_REQ			5	//Registration request from new device


/* DeviceTypes */

#define ZIGBEE_DEVICETYPE_OUTDOOR		0		//ASE outdoor sensor 
#define ZIGBEE_DEVICETYPE_INDOOR		1		//ASE indoor sensor
#define ZIGBEE_DEVICETYPE_LOUVERCOMP	2		//Louver complete
#define ZIGBEE_DEVICETYPE_LOUVERINSERT	3		//Louver  insert
#define ZIGBEE_DEVICETYPE_BATHROOM		4		//ASE bathroom fan controller
#define ZIGBEE_DEVICETYPE_BOOSTER		5		//ASE booster fan controller
#define ZIGBEE_DEVICETYPE_DIGISMART		80		//Digi smart plug
#define ZIGBEE_DEVICETYPE_OTHER			80-90	//3rd party Zigbee devices
#define ZIGBEE_DEVICETYPE_ADHOC			999		//Adhoc_mode_remote_device_type_delimiter � virtual device used in adhoc

/* ASEMP Device Profile */

#define PROFILE_OCCUPIED_REPORTING_PERIOD				0		//Occupied reporting period
#define PROFILE_UNOCCUPIED_REPORTING_PERIOD				1		//Unoccupied reporting period
#define PROFILE_OCCUPIED_PIR_TRIGGER_ENABLE				2		//Occupied PIR trigger enable
#define PROFILE_UNOCCUPIED_PIR_TRIGGER_ENABLE			3		//Unoccupied PIR trigger enable
#define PROFILE_MAX_RETRY_COUNT_ENABLE					4		//ASEMP max retry count enable
#define PROFILE_MAX_WAIT_TIMER_ENABLE					5		//ASEMP max wait timer enable
#define PROFILE_MIN_REPORT_INTERVAL_ENABLE				6		//Minimum time interval between consecutive  unsolicited reports enable
#define PROFILE_BATTERY_THRESHOLD_TRIGGER_ENABLE		7		//Battery status trigger value threshold enable
#define PROFILE_TEMP_UPTHRESHOLD_TRIGGER_ENABLE			8		//Upper temperature value report trigger enable 
#define PROFILE_HUMIDITY_UPTHRESHOLD_TRIGGER_ENABLE		9		//Upper humidity value report trigger
#define PROFILE_HUMIDITY_DNTHRESHOLD_TRIGGER_ENABLE		10		//Lower humidity value report trigger
#define PROFILE_LUX_SLOPE_TRIGGER_ENABLE				11		//Luminosity lope value report trigger 
#define PROFILE_CO_UPTHRESHOLD_TRIGGER_ENABLE			12		//Upper Co level value trigger enable
#define PROFILE_CO2_UPTHRESHOLD_TRIGGER_ENABLE			13		//Upper Co2 level value trigger enable
#define PROFILE_AUDIBLE_ALARM_ENABLE					14		//Audible alarm enable
#define PROFILE_LED_ALARM_ENABLE						15		//LED alarm enable
#define PROFILE_TEMP_SLOPE_TRIGGER_ENABLE				16		//Temperature slope value report trigger enable 
#define PROFILE_MCU_SLEEP_TIMER							17		//MCU sleep timer. CC2530 wakeup sleep timer
#define PROFILE_AC_UPTHRESHOLD_TRIGGER_ENABLE			18		//AC current upper threshold trigger
#define PROFILE_TEMP_DNTHRESHOLD_TRIGGER_ENABLE			19		//Lower temperature value report trigger enable

#endif