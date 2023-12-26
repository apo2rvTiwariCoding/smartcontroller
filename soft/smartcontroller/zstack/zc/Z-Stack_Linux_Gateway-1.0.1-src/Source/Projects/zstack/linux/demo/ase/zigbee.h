/*! \file zigbee.h
    	\brief Header file for interface handler. Provide APIs related to access ZigBee stack.
    	 
    	Provide APIs related to accessing various features of ZigBee like network formation, joining, resetting the network etc.
*/

#ifndef _ZIGBEE_H_
#define _ZIGBEE_H_

#include "types.h"

#define ASE

#define SEND_OFF_REQ			0		/*!< Flag used to send off request to device. */
#define SEND_ON_REQ			1		/*!< Flag used to send on request to device. */

#define SYSTEM_RESET_TYPE_HARD		0	 	/*!< Flag to destroy the network and clear network information. */
#define SYSTEM_RESET_TYPE_SOFT		1 	 	/*!< Flag used for soft reset. Network information wiil not be clear. */

#define SEND_GEN_RESP_PKT		0		/*!< Flag to indicate that request packet to be send through custom cluster i.e. FC01 to ASE devices. */
#define SEND_GEN_REQ_PKT		1		/*!< Flag to indicate that request packet to be send through custom cluster i.e. FC01 to ASE devices. */


typedef void (*NetworkZigBeeDeviceListCB)(int DevCnt, device_info_t *DevInfo); 		/*!< Function pointer used to give device list to application layer. */
/* Shortid, endpoint, deviceid, clusterid, message, message len */
typedef int (*CustomDataReceivedCB)(unsigned short, unsigned short, unsigned short, unsigned short, unsigned char, char *, unsigned char, unsigned long long);  	/*!< Function pointer used to give custom cluster data to application layer. */
typedef void (*NetworkZigBeeDeviceIndCB)(device_info_t *devinfo); 			/*!< Function pointer used to give status of any device which joins the network or when a device leaves the network. */


/*! \brief Defines various error notification to application for network start. */
typedef enum
{
	API_RETVAL_INVALID_PARAM = -8,
	
	API_RETVAL_FAIL_TO_CREATE_THREAD,
	API_RETVAL_FAIL_TO_OPEN_CONFIG_FILE,

	API_RETVAL_FAIL_TO_MEM_ALLOC,
	API_RETVAL_STACK_LAYER_FAILURE,
	API_RETVAL_STACK_LAYER_SUCCESS,

	API_RETVAL_SERVERS_NOT_RUNNING,
	API_RETVAL_SERVERS_NOT_RESPONDING,
	API_RETVAL_NWK_NOT_FORMED,
	API_RETVAL_NWK_READY,

	API_RETVAL_FAIL_TO_START_NWK,
	API_RETVAL_NWK_ALREADY_STARTED,
	API_RETVAL_NWK_PARAM_MISMATCH,
	
	API_RETVAL_ALREAY_INITIALIZED,
	API_RETVAL_INITIALIZATION_SUCCESS,
	
	API_RETVAL_SUCCESS,
}API_RETVAL_STATUS;  

/* External variables */

/* External functions */
/*! brief Returns the current status of the ZigBee network.

	\return It will return 
		a. Servers are not running (API_RETVAL_SERVERS_NOT_RUNNING)
		b. Network not formed (API_RETVAL_NWK_NOT_FORMED)
		c. Network ready (API_RETVAL_NWK_READY)
*/
signed char GetZigBeeNetworkStatus(void);

/*! brief To initialize the communication with servers, i.e. create sockets.

	\return It will return 
		a. Already initialized (API_RETVAL_ALREAY_INITIALIZED)
		b. Fail to create socket thread (API_RETVAL_FAIL_TO_CREATE_THREAD)
		c. Fail to open configuration file to read configuration of socket (API_RETVAL_FAIL_TO_OPEN_CONFIG_FILE)
*/
signed char InitializeZigBee(void);

/*! brief To create the network by passing parameters which can be set from application.
	
  	\param 	NwkChannel 	Bit mask to specify which all channel to be used for network formation
	\param	PanId		Network PAN id which is to be given to the newly created network

	\return It will return
		a. Fail to create network (API_RETVAL_FAIL_TO_START_NWK)
		b. Network already created (API_RETVAL_NWK_ALREADY_STARTED)
		c. Parameter mismatch with existing network (API_RETVAL_NWK_PARAM_MISMATCH)
		d. Servers are not running (API_RETVAL_SERVERS_NOT_RUNNING)		
		e. Servers not responding (API_RETVAL_SERVERS_NOT_RESPONDING)
*/
signed char CreateZigBeeNetwork(unsigned int *NwkChannel, unsigned int *PanId);

/*! brief To allow / disallow another devices to join network.
	
  	\param 	ToAllowJoin 	Flag to set whether to allow or to disallow. 1 to allow and 0 to disallow
	\param	TimeLimit	Specify the time in seconds to allow other device to join
	
	\return It will return
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid join allow join flag or Invalid time limit. Valid range is 0 to 255 (API_RETVAL_INVALID_PARAM)
		d. Servers are not running (API_RETVAL_SERVERS_NOT_RUNNING)
*/
signed char AllowDeviceJoin(unsigned char ToAllowJoin, unsigned char TimeLimit);

/*! brief Send request to remove the device from network.
	
  	\param 	IEEEAddr 	IEEE address of the device to be removed

	\return It will return
		a. Invalid IEEE address (API_RETVAL_INVALID_PARAM)
		b. Successfully informed stack layer to remove device (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to inform stack layer to remove device (API_RETVAL_STACK_LAYER_FAILURE)
		d. Servers are not running (API_RETVAL_SERVERS_NOT_RUNNING)
*/
signed char RemoveDevice(unsigned long long IEEEAddr);

/*! brief Reset the ZigBee network. This is to be invoked after removing all devices from the network. 
 * Application layer will call this if CreateZigBeeNetwork returns "Parameter mismatch with existing network".
	
  	\param 	ResetType 	Whether to do soft reset or hard reset soft reset 0, hard reset 1

	\return It will return
		a. Invalid reset type (API_RETVAL_INVALID_PARAM)
		b. Successfully destroyed the network (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to destroyed the network (API_RETVAL_STACK_LAYER_FAILURE)
*/
signed char ResetZigBeeNetwork(unsigned char ResetType);


/*! brief Request to get list of devices connected to the network.

	\return It will return 
		a. Error is asking stack layer for device list 
		b. Sucess in asking stack layer for deivce list
*/
signed char NetworkZigbeeGetDeviceList(void);

/*! brief Allow to register API for getting network device status.
	
  	\param 	DeviceInd 	Function pointer for the callback to be invoked in case a new device is joined or left the network.

	\return Returns nothing
*/
void RegisterNetworkZigBeeDeviceIndCB(NetworkZigBeeDeviceIndCB DeviceInd);


/*! brief Allow to register API for getting network device list.
	
  	\param 	DeviceList 	Function pointer for the callback to be invoked to share the list of network devices.

	\return Returns nothing
*/
void RegisterNetworkZigBeeGetDeviceListCB(NetworkZigBeeDeviceListCB DeviceList);


/*! brief Allow to register API for getting the data (request / response) received from the ASE ZED devices.
	
  	\param 	DataReceived 	Function pointer for the callback to be invoked in case a stack receives any packet from ASE ZED device.

	\return Returns nothing
*/
void RegisterCustomDataReceivedCB(CustomDataReceivedCB ASEDataReceived);


/*! brief API is used for getting device list from network manager. It gives device details like IEEE, endpoint associated with ZigBee network.
	
	\return It will return
		a. Successfully sent response to stack layer (API_RETVAL_STACK_LAYER_SUCCESS).
		b. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE).
		c. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC).
*/
signed char GetZigBeeNetworkDeviceList(void);

#endif
