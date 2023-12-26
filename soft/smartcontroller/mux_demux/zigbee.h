#ifndef FILE_MUX_DEMUX_ZIGBEE_H
#define FILE_MUX_DEMUX_ZIGBEE_H

// SYSTEM INCLUDES
#include "zstack/zc/Z-Stack_Linux_Gateway-1.0.1-src/Source/Projects/zstack/linux/demo/ase/zigbee.h"
#include "zstack/zc/Z-Stack_Linux_Gateway-1.0.1-src/Source/Projects/zstack/linux/demo/ase/zigbee_ha.h"
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
#include "zigbee/types.h"
#include "inc/ASEMPImpl.h"
#include "db/Commands.h"

//ASE Device Types
#define ASE_DEVICE_LIGHT 1
#define ASE_DEVICE_FLAP  2 

typedef struct {
	int zigbeeHwVersion;
	int aseFirmwareVersion;
	int zigbeeFirmwareVersion;
	int deviceType;   // ASE device type listed above.
}ASEDevice;

/*
@brief: The function resets the SC radio module
@param: address of the SC device module
@return: NONE
*/
void ZigbeeResetRadioModule(unsigned long long int addr64);		//Need to take care of the address inside this function as this address may be either 64bit or 16 bit

/*
@brief: The function creates the Zigbee network for communication
@param: unique zigbee network ID
@return: NONE
*/
void ZigbeeCreateNetwork(int zigbeeId);

/*
@brief: The function resets the panid for previously created Zigbee network, can also change the panid select mode
@param: unique zigbee network ID
@return: NONE
*/
void ZigbeeSetPanId(int zigbeeId);

/*
@brief: The function changes the channel for previously created Zigbee network
@param: unique zigbee network ID
@return: NONE
*/
void ZigbeeSetRFChannel(int zigbeeId);

/*
@brief: The function used to enable or disable data encryption and change security for previously created Zigbee network
@param: unique zigbee network ID
@return: NONE
*/
void ZigbeeSetSecurity(int zigbeeId);

/*
@brief: The function used to allow/disallow new devices to join the network
@param: 1. binary value to Disallow (=0) or Allow (=1) new device to join the network
		2. time interval until a device can join, 0=until disallow is sent, default=120
@return: NONE
*/
void ZigbeeAllowNewDevice(bool allow, int inerval);

/*
@brief It adds a new HA device into the database.
@param device information
@return NONE
*/
void ZigbeeAddHaDevice(const device_info_t& device_info);

/*
@brief: It adds a new HA device into the database.
@param: device information
@return: 0 - success, -1 - error
*/
int ZigbeeAddAseDevice(const device_info_t& device_info);

/*
@brief: The function used to remove previously regitered device from the network
@param: unique zigbee network ID
@return: NONE
*/
void ZigbeeRemoveDevice(int zigbeeId);

/*
@brief: The function used to remove previously regitered device from the network
@param: unique zigbee network ID
@return: NONE
*/
void ZigbeeRemoveDevice(int zigbeeId);

/*
@brief: The function finds the route for all zigbee devices and stores them into DB
@param: NONE
@return: NONE
*/
void ZigbeeDiscoverRoute();

/**
 * @brief It gets corresponding device id.
 * @return -1 if the device id could not be found.
 */
int ZigbeeIeeeAddressToDeviceId(unsigned long long ieee_addr, int& device_id);
/*
@brief: The function pings a remote device
@param: unique device_id
@return: NONE
*/
void ZigbeePingRemoteDev(int deviceId);

/*
@brief: The function is used to enable/disable a remote ZED device
@param: unique device_id
@return: NONE
*/
void ZigbeeEnableZedDev(int deviceId);

/*
@brief: The function is used to swith ON/OFF electrical device connected to outlet
@param: unique device_id
@return: NONE
*/
void ZigbeeEnableDigiAC(int deviceId);

/*
@brief: The function is used to read AC current value from electrical device connected to outlet
@param: unique device_id
@return: NONE
*/
void ZigbeeReadCurrent(int deviceId);

/*
@brief: The function is used respond to a registration request from a ZED
@param: 1. unique device_id
		2. pointer to a RegistrationResponse struct declared in ASEMPImpl.h
@return: NONE
*/
void ZigbeeRegistrationResponse(int deviceId, ASEMProfile* asempProfile);

/*
@brief: The function is used to obtain a default profile for a particular ZED
@param: 1. unique profile_id
        2. pointer to a profile struct declared in ASEMPImpl.h
@return: 0 - success, -1 - error
*/
int ZigbeeGetRegistrationResponse(int profile_id, ASEMProfile& asemp_profile);

#if 0 // testing
/**
 * @brief It confirms the registration response.
 * @param daviceId
 * unique device id
 * @param error
 * True if sending registration request failed.
 */
void ZigbeeConfirmRegistrationResponse(int deviceId, bool error);
#endif
/*
@brief: The function is used send a central request to a ZED
@param: 1. unique device_id
		2. pointer to a CentralCommandRequest struct declared in ASEMPImpl.h 
@return: NONE
*/

void ZigbeeCentralCommandRequest(int deviceId, CentralCommandRequest *centralCommandRequest);

/*
@brief: The function is used update profile of a ZED
@param: 1. unique device_id
		2. pointer to a UpdateProfileRequest struct declared in ASEMPImpl.h 
@return: NONE
*/
void ZigbeeUpdateProfile(int deviceId, UpdateProfileRequest* asempProfile);

/*
@brief: The function obtains a ZED profile
@param: 1. unique device_id
		2. pointer to a UpdateProfileRequest struct declared in ASEMPImpl.h
@return: In case of error it returns -1
*/
int ZigbeeGetProfile(int deviceId, ASEMProfile& asempProfile);

/*
@brief: The function is called when a Central command response is received from ZED
@param: payload received as the response to central command request
@return: NONE
*/
void ZigbeeCentralCommandResponse(CentralCommandResponse* response);

/**
 * @brief It stores unsolicited information from a particular sensor.
 */
void ZigbeeStoreUnsolicitedInfo(int device_id,
        const UnsolicitedSensorInfoRequest& info);
/**
 * @brief It obtains a pending RESPONSE_USENSOR_MSG command and returns true
 *        if there is any.
 */
bool ZigbeeGetPendingCommand(int device_id, CCommands& cmd);

/*
@brief: The function is called when a Update profile response is received from ZED
@param: payload received as the response to update profile response
@return: NONE
*/
void ZigbeeUpdateProfileResponse(UpdateProfileResponse *response);

/**
 * @brief It confirms a pending RESPONSE_USENSOR_MSG command.
 */
void ZigbeeConfirmPendingCommand(int device_id, bool error, int ack);


/*
@brief: The function is called when a new ZED device has joined the network. It stores different 
		values related to ZED into database
@param: payload received as the ZED info in device_info_t 
@return: NONE
*/
void ZigbeeNewDeviceJoin(std::string addr64, int addr16, ASEDevice *aseDevice);

/*
@brief: The function checks if a previous Zigbee Network is already present or not
@param: 1. pointer to store already present zigbee network's Pan Id
		2. pointer to store already present zigbee network's channel Id
		3. IEEE address for the zigbee device. 
@return: false(bool), if No network is present and true(bool), if a network is already present
*/
bool ZigbeeNetworkIsPresent(int *panId, int *channelId, uint64_t ieee_addr );

/*
@brief: Function removes the commands generated before ASE_ZC_STALE_TIME for zigbee_commands table
@param: NONE
@return: NONE
*/
void RemoveStaleCommands();

/*
@brief: Function stores the returned values as a result to Cluster Commands
@param: unique device id
@return: NONE
*/
void ZigbeeClusterCommandProcess(int deviceId);

/*
@brief: Function stores the returned values as a result to Cluster Commands
@param: 1. Returned Code
		2. Returned std::string
		3. Returned Value
@return: NONE
*/
void ZigbeeClusterCommandResponse(int returnCode, std::string returnString, int returnValue);
//-----------------------------------------------------------------------------


#endif 	//* FILE_MUX_DEMUX_ZIGBEE_H */
