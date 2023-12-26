#ifndef _SENSORTYPES_H
#define _SENSORTYPES_H

/*   Command	 & their Description 	*/

#define RESET_SMART_CONTROLLER		0x00	//Smart controller board restart
#define START_INTERNAL_DIAGNOSTICS	0x01	//Smart controller internal diagnostics
#define SET_RELAY_HVAC				0x10	//Set HVAC relays
#define SET_RELAY_AUXILIARY			0x11	//Set auxiliary relays (user defined)
#define SET_RELAY_HUMIDIFIER		0x12	//Set humidifier relay
#define SET_RELAY_RANDOM			0x13	//Set relay to ON state by unique relay ID.
#define RESET_RELAY_RANDOM			0x14	//Reset relay to ON state by unique relay ID.
#define READ_CO_SENSOR				0x21	//Gas sensor reading (CO sensor)
#define READ_THERMOSTAT_LINE_STATUS	0x22	//Thermostat line status reading
#define READ_ADC_PROBES				0x23	//ADC connected probes reading
#define READ_I2C_SENSORS			0x24	//I2C connected sensors reading
#define READ_ONE_WIRE				0x25	//1-wire reading
#define ENUMERATE_ONE_WIRE			0x26	//1-wire enumerate
#define ZIGBEE_RESET_RADIO_MODULE	0x30	//Reset radio module
#define ZIGBEE_CREATE_NETWORK_CMD	0x31	//Create a new zigbee network
#define ZIGBEE_SET_PANID_CMD		0x32	//Set or change PANID and/or PANID selection mode for existing network
#define ZIGBEE_SET_RFCHANNEL_CMD	0x33	//Set or change RF channel for existing network in case of channel interference or for security reason.
#define ZIGBEE_SET_SECURITY_CMD		0x34	//Set or change data encryption mode and security key for existing network
#define ZIGBEE_ALLOW_NEWDEV_CMD		0x35	//Command used to put RetroSAVE controller into configuration mode to allow or disallow the registration of a new device in the network 
#define ZIGBEE_REMOVE_DEV_CMD		0x36	//Remove previously registered Zigbee device
#define ZIGBEE_ROUTE_DISCOVERY_CMD	0x37	//Route discovery command to find out how active registered devices are interconnected to the smart controller
#define ZIGBEE_PING_DEVICE_CMD		0x38	//Ping remote device command to check if a remote device is available inside network and is able to receive and respond to the command
#define ZIGBEE_ENABLE_ZED			0x39	//Enable/Disable ZED devices
#define SET_AC_ONOFF_DIGI			0x41	//AC on/off command to switch power On and Off of electrical devices connected to outlet via Digi Smart plug
#define READ_AC_CURRENT				0x42	//Command used to measure AC current consumption of electrical devices currently connected to outlet via Digi Smart plug.
#define RESPONSE_REGISTERATION		0x50	//Registration response sent by smart controller
#define RESPONSE_USENSOR_MSG		0x51	//Unsolicited sensor message response 
#define CENTRAL_COMMAND_REQUEST		0x52	//Command sent by smart controller to the ASE smart diffuser device to set the louver position of the diffuser
#define SET_AC_ONOFF				0x53	//Command sent by smart controller to the remote electrical devices like ASE bathroom fan controller or ASE booster fan controller to set them ON or OFF
#define SET_DIMMER_VALUE			0x54	//Command sent by smart controller to the remote electrical devices which support dimming to set the dimmer level
#define SET_ENABLE_TIME				0x55	//Enable time command sent by smart controller to the remote electrical devices that supports turning load ON after some TIME
#define ASEMP_PROFILE_UPDATE		0x56	//Set new ASEMP profile to device and sent by smart controller in response to a change in ASEMP profile in ASE remote device
#define SENSOR_LOCAL_ENABLE			0x73	//Enable local sensor used to enable previously disabled local sensor and restore its normal operation like interrupts by thresholds, etc.
#define SENSOR_LOCAL_DISABLE		0x74	//Disable local sensor used to disable all activity for local sensor and stop reading its values, disable interrupts if applicable
#define SENSOR_LOCAL_READ_CURR		0x75	//Read current value command used to retrieve current sensor value immediately, instead of waiting for periodical read. 
#define SENSOR_LOCAL_SET_UPDATE		0x76	//Set update interval for sensor command used to configure muxdemux for reading sensor value periodically by given intervals.
#define SENSOR_LOCAL_SET_HIGH		0x77	//Set high threshold for local sensor command used to set ADC raw value threshold for selected port
#define SENSOR_LOCAL_SET_LOW		0x78	//Set low threshold for local sensor command used to set ADC raw value threshold for selected port.
#define RTC_SET						0x7E	//Set real time clock using unix timestamp value.
#define RTC_GET						0x7F	//Get real time clock using unix timestamp value and place into database

/* STALE COMMAND TIMEOUT */
#define ASE_ZC_STALE_TIME 			60		//(seconds)  	 

/* Event Type */

#define EVENT_TEST_PASSED			0		//Event – Test Failed
#define EVENT_TEST_FAILED			1		//Event – Test Passed

/* Trigger Type */

#define TRIGGER_PIR_OCCUPIED		0	//Occupied PIR trigger enable
#define TRIGGER_PIR_UNOCCUPIED		1	//Unoccupied PIR trigger enable
#define TRIGGER_BATTERY_STATUS		2	//Battery status trigger
#define TRIGGER_TEMPERATURE_UP		3	//Upper temperature threshold level trigger
#define TRIGGER_TEMPERATURE_DOWN	4	//Lower temperature threshold level trigger
#define TRIGGER_HUMIDITY_UP			5	//Upper humidity threshold level trigger
#define TRIGGER_HUMIDITY_DOWN		6	//Lower humidity threshold level trigger
#define TRIGGER_LUX_SLOPE			7	//Luminosity slope value trigger
#define TRIGGER_TEMPERATURE_SLOPE	8	//Temperature slope value trigger
#define TRIGGER_CO_UP				9	//CO level threshold trigger
#define TRIGGER_CO2_UP				10	//CO2 level threshold trigger


/* AlarmEventType */

#define ALARM_TYPE_RETROSAVE		0	//Retrosave alarm
#define ALARM_TYPE_ZIGBEE			1	//Zigbee alarm
#define ALARM_TYPE_SYSTEM			2	//System alarm
#define ALARM_TYPE_NETWORK			3	//Network alarm
#define ALARM_TYPE_PRESSURE			4	//Pressure alarm
#define ALARM_TYPE_REGISTERATION	5	//New device registration alarm


/* ConnectStatusType */

#define CONNECT_SUCCESS				0	//Connection was successful
#define CONNECT_FAILED_FIRST		1	//First failed attempt to connect to ISP name server
#define CONNECT_FAILED_CONSEC		2	//Consecutive failed attempt to connect to ISP name server


/* ReportType: (For ‘smartsnsor’ table) */

#define REPORT_TYPE_PERIODIC	0	//Periodic request by command
#define REPORT_CO_UP			1	//CO threshold level exceeded
#define REPORT_CO2_UP			2	//CO2 threshold level exceeded
#define REPORT_TSUP_UP			3	//t_supply_duct upper threshold level exceeded
#define REPORT_TSUP_DOWN		4	//t_supply_duct lower threshold level exceeded
#define REPORT_TRET_UP			5	//t_return_duct upper threshold level exceeded
#define REPORT_TRET_DOWN		6	//t_ return_duct lower threshold level exceeded





/* RawDataType(For ‘smartsensorsraw’ table)*/

#define RDT_SENSOR_UNKNOWN		0	//Unknown sensor
#define RDT_SENSOR_TEMPERATURE	1	//Temperature sensor
#define RDT_SENSOR_HUMIDITY		2	//Humidity sensor
#define RDT_SENSOR_CO			3	//CO Sensor
#define RDT_SENSOR_CO2			4	//CO2 Sensor
#define RDT_SENSOR_AIRSPEED		5	//Air velocity sensor
#define RDT_SENSOR_LIGHT		6	//Light/Illumination sensor


#endif
