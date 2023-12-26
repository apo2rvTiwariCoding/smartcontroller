/*! \file zigbee.h
    	\brief Header file for interface handler. Provide APIs related to access ZigBee stack.
    	 
    	Provide APIs related to accessing various features of ZigBee like network formation, joining, resetting the network etc.
*/

#ifndef _ZIGBEE_H_
#define _ZIGBEE_H_

#include "zigbee/types.h"

#define ASE

#define SEND_OFF_REQ			0		/*!< Flag used to send off request to device. */
#define SEND_ON_REQ			1		/*!< Flag used to send on request to device. */

#define SYSTEM_RESET_TYPE_HARD		0	 	/*!< Flag to destroy the network and clear network information. */
#define SYSTEM_RESET_TYPE_SOFT		1 	 	/*!< Flag used for soft reset. Network information wiil not be clear. */

#define SEND_GEN_RESP_PKT		0		/*!< Flag to indicate that request packet to be send through custom cluster i.e. FC01 to ASE devices. */
#define SEND_GEN_REQ_PKT		1		/*!< Flag to indicate that request packet to be send through custom cluster i.e. FC01 to ASE devices. */

/*! brief Function pointe used for displaying the device list associated with network manager. It contains device information e.g. ieee address, end points, network address, cluster id.

	\param DevCnt Number of devices associated with netwrok manager.
	\param DevInfo It conatins device information like eee address, end points, network address, cluster id.
	\return Returns NOTHING.
*/
typedef void (*NetworkZigBeeDeviceListCB)(const int DevCnt, const device_info_t *DevInfo); 	

/*! brief Function pointer used for giving response details that got from Device. It gives data response got from device through custom cluster. Also in respect to device request through custom cluster it gives response to it.

 	\param NwkAddr Specifies short address/network address of device from which request/response got.
 	\param EndPoint Specifies endpoint of device from which request/response got.
 	\param DeviceId Specifies device id of device from which request/response got.
 	\param ClusterId Specifies cluster id associted with device from which request/response got.
 	\param IsReqFlag is used to distinguish between the request and response command.
 	\param Message It is used tio fill dummy data.
 	\param MessageLen Specifies message lenght.
 	\param IEEEAddr Specifies IEEE of device from which request/response got.

	\return Returns zero always as success.
*/
typedef int (*CustomDataReceivedCB)(const unsigned short, const unsigned short, const unsigned short, const unsigned short, const unsigned char, const char *, const unsigned char, const unsigned long long);  	

/*! brief Function pointer used for informing the device indication. Device indications when device join network or leave network.

	\param DeviceEntry It conatins device information like eee address, end points, network address, cluster id and device status.
	\return Returns NOTHING.
*/
typedef void (*NetworkZigBeeDeviceIndCB)(const device_info_t *devinfo); 			


/*! brief Function pointer used for giving response details of read attribute. It gives information of basic cluster.
 
 	\param AttrInfo Specifies details of attribute details of basic cluster. e.g. Hardware version, application version, stack version and zcl version etc.
	\return Returns NOTHING.
*/
typedef void (*ReadAttribCB)(const attribute_info_t *AttribInfo);

/*! brief Function pointer used for getting network address of the router in the metwork. We can identify that particular router is alive or not in the network.
 
 	\param NetworkInfo Specifies network address information.
	\return Returns NOTHING.
*/
typedef void (*NetworkInfoCB)(const NWK_ADDR_RESOLUTION *NetworkInfo);

/*! brief Function pointer used for giving response of network topology. Topology response contains details of neighbor nodes like ieee address, lqi, depth.
 
 	\param TopologyInfo Specifies details of attribute details of network topology like lqi, depth, ieee address.
 	\param MaxRecorCnt Specifies maximum node entries in topology information table.
	\return Returns NOTHING.
*/
typedef void (*NetworkTopologyCB)(const TOPOLOGY_INFO *TopologyInfo, const unsigned char MaxRecorCnt);



/*! \brief Defines various error notification to application for network start. */
typedef enum
{
	API_RETVAL_INVALID_PARAM = -8,
	
	API_RETVAL_FAIL_TO_CREATE_THREAD,
	API_RETVAL_FAIL_TO_OPEN_CONFIG_FILE,

	API_RETVAL_FAIL_TO_MEM_ALLOC,
	API_RETVAL_STACK_LAYER_FAILURE,
	API_NWK_TOPOLOGY_ALREADY_STARTED,

	API_RETVAL_SERVERS_NOT_RUNNING,
	API_RETVAL_SERVERS_NOT_RESPONDING,
	API_RETVAL_NWK_NOT_FORMED,
	API_RETVAL_NWK_READY,

	API_RETVAL_FAIL_TO_START_NWK,
	API_RETVAL_NWK_ALREADY_STARTED,
	API_RETVAL_NWK_PARAM_MISMATCH,
	
	API_RETVAL_ALREAY_INITIALIZED,
	
	API_RETVAL_SUCCESS
}API_RETVAL_STATUS;  

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
		d. Intialization of ZigBee module is successful (API_RETVAL_SUCCESS)
*/
signed char InitializeZigBee(void);

/*! brief To create the network by passing parameters which can be set from application.
	
  	\param 	NwkChannel 	Bit mask to specify which all channel to be used for network formation
	\param	PanId		Network PAN id which is to be given to the newly created network

	\return It will return
		a. Network already created (API_RETVAL_NWK_ALREADY_STARTED)
		b. Parameter mismatch with existing network (API_RETVAL_NWK_PARAM_MISMATCH)
		c. Servers are not running (API_RETVAL_SERVERS_NOT_RUNNING)		
		d. Servers not responding (API_RETVAL_SERVERS_NOT_RESPONDING)
		e. Invalid parameter for creating network e.g. RF channel (API_RETVAL_INVALID_PARAM)
		g. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC).	
		h. Fail to inform stack layer to create network (API_RETVAL_STACK_LAYER_FAILURE)
		i. Successfully informed stack layer to create network (API_RETVAL_SUCCESS)
*/
signed char CreateZigBeeNetwork(unsigned int *NwkChannel, unsigned int *PanId); 

/*! brief To allow / disallow another devices to join network.
	
  	\param 	ToAllowJoin 	Flag to set whether to allow or to disallow. 1 to allow and 0 to disallow
	\param	TimeLimit	Specify the time in seconds to allow other device to join
	
	\return It will return
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid join allow join flag or Invalid time limit. Valid range is 0 to 255 (API_RETVAL_INVALID_PARAM)
		c. Servers are not running (API_RETVAL_SERVERS_NOT_RUNNING)
		d. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC).	
		e. Fail to inform stack layer of allow device join (API_RETVAL_STACK_LAYER_FAILURE)
		f. Successfully informed stack layer allow device join (API_RETVAL_SUCCESS)	
*/
signed char AllowDeviceJoin(const unsigned char AllowJoin, unsigned char Time); 

/*! brief Send request to remove the device from network.
	
  	\param 	IEEEAddr 	IEEE address of the device to be removed

	\return It will return
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid IEEE address (API_RETVAL_INVALID_PARAM)
		c. Fail to inform stack layer to remove device (API_RETVAL_STACK_LAYER_FAILURE)
		d. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC)
		e. Successfully informed stack layer to remove device (API_RETVAL_SUCCESS)
*/
signed char RemoveDevice(const unsigned long long IEEEAddr);

/*! brief Reset the ZigBee network. This is to be invoked after removing all devices from the network. 
 * Application layer will call this if CreateZigBeeNetwork returns "Parameter mismatch with existing network".
	
  	\param 	ResetType 	Whether to do soft reset or hard reset soft reset 0, hard reset 1

	\return It will return
		a. Invalid reset type (API_RETVAL_INVALID_PARAM)
		b. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC)
		c. Fail to destroyed the network (API_RETVAL_STACK_LAYER_FAILURE)
		d. Successfully destroyed the network (API_RETVAL_SUCCESS)
*/
signed char ResetZigBeeNetwork(const unsigned char ResetType); 

/*! brief Request to get list of devices connected to the network.

	\return It will return 
		a. Error is asking stack layer for device list 
		b. Sucess in asking stack layer for deivce list
*/
//signed char NetworkZigbeeGetDeviceList(void);

/*! brief Allow to register API for getting network device status.
	
  	\param 	DeviceInd 	Function pointer for the callback to be invoked in case a new device is joined or left the network.

	\return Returns nothing
*/
void RegisterNetworkZigBeeDeviceIndCB(const NetworkZigBeeDeviceIndCB NewDeviceInd);

/*! brief Allow to register API for getting network device list.
	
  	\param 	DeviceList 	Function pointer for the callback to be invoked to share the list of network devices.

	\return Returns nothing
*/
void RegisterNetworkZigBeeGetDeviceListCB(const NetworkZigBeeDeviceListCB DeviceList);


/*! brief Allow to register API for getting the data (request / response) received from the ASE ZED devices.
	
  	\param 	DataReceived 	Function pointer for the callback to be invoked in case a stack receives any packet from ASE ZED device.

	\return Returns nothing
*/
void RegisterCustomDataReceivedCB(const CustomDataReceivedCB ASEDataReceived);

/*! brief Allow to register API for getting attribute details of basic cluster..
	
  	\param 	ReadAttribResp 	Function pointer for the callback to be invoked in case a stack receives any packet from device.

	\return Returns nothing
*/
void RegisterReadAttribCB(const ReadAttribCB ReadAttribResp);

/*! brief Allow to register API for getting the network address of the router in the network.
	
  	\param 	NetworkInfoResp  Function pointer for the callback to be invoked in case a stack receives any packet from device.

	\return Returns nothing
*/
void RegisterNetworkInfoCB(const NetworkInfoCB NetworkInfoResp);


/*! brief API is used for getting device list from network manager. It gives device details like IEEE, endpoint associated with ZigBee network.
	
	\return It will return
		a. Successfully sent response to stack layer (API_RETVAL_SUCCESS).
		b. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE).
		c. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC).
*/
signed char GetZigBeeNetworkDeviceList(void); 


signed char GetNwkAddrOfRouter(const unsigned long long IEEEAddr);

/*! brief API used for getting network topology. It gives list of neighbor of each node present in network.

	\return It will return 
		a. Network not formed (API_RETVAL_NWK_NOT_FORMED)
		b. Fail to create socket thread (API_RETVAL_FAIL_TO_CREATE_THREAD)
		c. Application already requested for network topology and it is in progress (API_NWK_TOPOLOGY_ALREADY_STARTED)
		d. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC)
		e. Fail to destroyed the network (API_RETVAL_STACK_LAYER_FAILURE)
		f. Successfully destroyed the network (API_RETVAL_SUCCESS)
		g. Successfully sent get topology request (API_RETVAL_SUCCESS)
*/
signed char GetNwkTopology(void);


/*! brief Allow to register API for getting network topology.
	
  	\param 	TopologyInfoResp  Function pointer for the callback to be invoked in case a stack receives any packet from device.

	\return Returns nothing
*/
void RegisterNetworkTopologyCB(const NetworkTopologyCB TopologyInfoResp);

#endif
