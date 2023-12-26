#ifndef _ASEMP_H_
#define _ASEMP_H_
#include<stdint.h>
#include<stddef.h>

/********************************************************************************
 * ASEMP.h is on purpose a C style header file, so it can be shared between the
 * SmartController and the CC2530 side which only supports C. 
 *
 ********************************************************************************/

static const size_t ASEMP_MAX_LENGTH = 256;

typedef int DeviceType; 
typedef struct ASEMPMessage_ {
	uint8_t protocolID;
	uint8_t msgCount;
} ASEMPMessage;


typedef struct ASEMProfile_ {
	ASEMPMessage ASEMPMobj;
	uint8_t zone_occu;			//Zone_Occupancy_State;
	uint8_t occu_rep;			//occupied_Reporting_Period; 
	uint8_t unoccu_rep;			//Unoccupied_Reporting_Period; 
	uint8_t occu_pir;			//Occupied_PIR_Trigger_Enable;
	uint8_t unoccu_pir; 		//Unoccupied_PIR_Trigger_Enable;
	uint8_t max_retry;			//ASEMP_MAX_Retry_Count ;
	uint8_t max_wait;			//ASEMP_MAX_WAIT_Timer ;
	uint8_t min_rep_wait;		//Minimum_Time_Interval_Between_Consecutive_Unsolicited_Reports;
	uint8_t bat_stat_thr;		//Battery_Status_Value_Trigger_Threshold;
	uint8_t mcu_sleep;     		// MCU sleep timer. CC2530 wakeup sleep timer/////////NEWLY ADDED
	uint8_t up_temp_tr;			//Upper_temp_Value_Report_Trigger;
	uint8_t lo_temp_tr;			//Lower_temp_Value_Report_Trigger;
	uint8_t up_hum_tr;			//Upper_Humidity_Value_Report_Trigger; 
	uint8_t lo_hum_tr;			//Lower_Humidity_Value_Report_Trigger;
	uint8_t lux_sl_tr;			//LUX_Slope_Value_Report_Trigger ;//////OBSOLETE
	uint8_t up_co_tr;			//Upper_CO_Value_Trigger_Report;
	uint8_t up_co2_tr;			//Upper_CO2_Value_Trigger_Report;
	uint8_t aud_alarm;			//Audible_Alarm_Enable;
	uint8_t led_alarm;			//Led_Alarm_Enable;
	float temp_sl_alarm;		//Temp_Slope_Value_Report_Trigger; ////OBSOLETE
	float ac_curr_thr ;   		// AC current upper threshold trigger ////////NEWLY ADDED
} ASEMProfile;


#ifdef EMULATOR
//typedef struct RegistrationRequest_ : ASEMPMessage { //inheritence in c can be done by taking anobject of struct in the deriver struct
typedef struct RegistrationRequest_ {
	ASEMPMessage ASEMPMobj;
	DeviceType deviceType;
	int zigbeeHardwareVersion;
	int zigbeeFirmwareVersion;
	int ASEFirmwareVersion;
	int ASEHardwareVersion;
	int Remote_RSSI;
 
} RegistrationRequest;
#endif
//typedef struct RegistrationResponse_ : ASEMProfile {   
typedef struct RegistrationResponse_  {   
    ASEMPMessage ASEMPMobj;
	ASEMProfile ASEMProObj;
 } RegistrationResponse;

static const int REGISTRATION_RESPONSE_ID = 0x01;
//typedef struct UnsolicitedSensorInfoRequest_ : ASEMPMessage {
typedef struct UnsolicitedSensorInfoRequest_  {
	ASEMPMessage ASEMPMobj;
	uint8_t pir; // count from the last SOLICITED or UNSOLICTED REPORT
    float min_temp;
    float avg_temp;
    float max_temp;
    float min_hum;
    float avg_hum;
    float max_hum;
    float min_lux;
    float max_lux;
    int32_t parent_lqi;
    float co2;
    float co;
    float ac_current;
    int32_t louver_pos;
    float min_battery_status;
    uint8_t cause;
}UnsolicitedSensorInfoRequest;

static const int UNSOLICITED_SENSOR_INFO_REQUEST_ID = 0x02;

//typedef struct UnsolicitedSensorInfoResponse_:  ASEMProfile {
typedef struct UnsolicitedSensorInfoResponse_ {
    ASEMPMessage ASEMPMobj;

    uint8_t short_payload;
    uint8_t zone_occupancy_state;
    uint8_t command_type;
}UnsolicitedSensorInfoResponse;

static const int UNSOLICITED_SENSOR_INFO_RESPONSE_ID = 0x03;
//typedef struct CentralCommandRequest_ : ASEMPMessage {
typedef struct CentralCommandRequest_  {
	ASEMPMessage ASEMPMobj;
	uint8_t command_type;
	uint8_t command_data;
	
	#ifdef EMULATOR
	uint8_t louver_pos;
	uint8_t ac_dev_time;
	uint8_t dimmer_val;
	uint8_t unsoli_reporting_int;
	//uint8_t* ir_data_seq;
	uint8_t req_unsoli_info;
	uint8_t aud_alarm;
	uint8_t led_alarm;
	uint8_t relay;
	uint16_t relay_id;
	uint8_t ack_requester;
	#endif
	DeviceType deviceID;			
}CentralCommandRequest;

//typedef struct CentralCommandResponse_ : ASEMPMessage {
typedef struct CentralCommandResponse_  {
	ASEMPMessage ASEMPMobj;
	uint8_t ack;
	uint8_t Remote_RSSI;
	DeviceType deviceID;	//EXTRA
}CentralCommandResponse;



//typedef struct  UpdateProfileRequest_ : ASEMProfile {
typedef struct  UpdateProfileRequest_ {
	ASEMProfile ASEMProObj;
	DeviceType deviceID;	//EXTRA
	}UpdateProfileRequest;


//typedef struct UpdateProfileResponse : ASEMPMessage {
typedef struct UpdateProfileResponse_ {
	ASEMPMessage ASEMPMobj;
	uint8_t ack;
	uint8_t Remote_RSSI;
	DeviceType deviceID;	//EXTRA
}UpdateProfileResponse;

typedef struct RemoteStatusRequest_ {
	ASEMPMessage ASEMPMobj;
	uint8_t Status;
}RemoteStatusRequest;

typedef struct RemoteStatusResponse_ {
	ASEMPMessage ASEMPMobj;
	uint8_t ack;
}RemoteStatusResponse;

#ifdef EMULATOR
int RegistrationRequest1 (DeviceType deviceType,  int zigbee_hw, int zigbee_fw, int device_hw, int  device_fw, int rssi) ;
int OnCentralCommandRequest(CentralCommandRequest *commandRequest);
int UnsolicitedSensorInfoRequest1(UnsolicitedSensorInfoRequest *infoRequest);
int OnUpdateProfileRequest(UpdateProfileRequest *profileRequest);
int OnRemoteStatusRequest(RemoteStatusRequest* zedRequest);

int ping_remote_device(int deviceID);
int RemoteStatusRequest1(int deviceID);
#endif
//typedef void (*TOnMessageCallback)(char *buffer ,int size);
//typedef void (*TOnMessageCallback)(char* buffer ,int len);

 
/*int OnRegistrationRequest (DeviceType deviceType,  int zigbee_hw, int zigbee_fw, int device_hw, int  device_fw, int rssi) ;
int OnUnsolicitedSensorInfoResponse(UnsolicitedSensorInfoResponse *infoResponse);
int OnUpdateProfileResonse(UpdateProfileResponse *profileResponse);
int OnCentralCommandResponse(CentralCommandResponse *cmdResponse);
int OnUnsolicitedSensorMessageINFORequest (OUnsolicitedSensorMessageINFORequest &infoRequest);
*/
/********************************************************************************
*
*  Protocol independent Callback functions called by the protocol dependant layer (
*  Zigbee/Socket) when an ASEMP message is received. srcAddr is dependant on the
*  the protocol layer and is stored and used by the upper layer.
*
*********************************************************************************/
// int OnRegistrationRequest (uint32_t, DeviceType ,  float, float, float , float  , int ) ;
 //int RegistrationRequest1 (DeviceType deviceType,  float zigbee_hw, float zigbee_fw, float device_hw, float  device_fw, int rssi) ;
 //int OnUnsolicitedSensorInfoResponse(uint32_t srcAddr, UnsolicitedSensorInfoResponse *infoResponse);
 //int OnUpdateProfileResonse(uint32_t srcAddr, UpdateProfileResponse *profileResponse);
 //int OnCentralCommandResponse(uint32_t srcAddr, CentralCommandResponse *cmdResponse);
 //int OnUnsolicitedSensorMessageInfoResponse(uint32_t srcAddr UnsolicitedSensorMessageINFOResponse &infoResponse);


/********************************************************************************
*
*  Protocol independent methods to send an ASEMP message. The destination entity
*  at this layer is identified by a uint32_t value. This value is converted into
*  a Zigbee address (ShortAddress, EndPoint etc) for the message to be sent to
*  a Zigbee endpoint. For socket, this is a socket id. Upper layers care less
*  and just store this uint32_t values as an identifier.
*
*********************************************************************************/

/********************************************************************************
* Registration response is sent by Smart controller in response to a registration 
* request from a ASE device. This is called after the new device was added to 
* database or was rejected by the higher layer. 
*********************************************************************************/
//int RegistrationResponse(uint32_t destAddr, RegistrationResponse *regResponse);
//int RegistrationResponse1(RegistrationResponse *regResponse);
/********************************************************************************
*
* Central command request sent by the Smart controller to any ASE control device 
* such as the Smart diffuser, bathroom fan controller, booster fan controller, 
* etc. Message payload consists of device status that must be set.
*
*********************************************************************************/
//int CentralCommandRequest(uint32_t destAddr, CentralCommandRequest *commandRequest);

/********************************************************************************
*********************************************************************************/
//int UpdateProfileRequest(uint32_t destAddr, ASEMPProfile *profile);

/********************************************************************************
*********************************************************************************/
//int UnsolicitedSensorInfoRequest(UnsolicitedSensorInfoRequest *infoRequest);


#endif
