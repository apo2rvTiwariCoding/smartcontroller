/*! \file ZigBee.c
	\brief File provides API's for providing the interface between application and ZigBee gateway. It contains API which registeres the call back function which informs event/data to application layer. It creats the zigbee thread which connect to all the servers and poll the connection if any data comes from server ti inform to application.
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <pthread.h>
#include <signal.h>
#include <execinfo.h>
#include <unistd.h>
#include "zigbee.h"
#include "zigbee_internal.h"
#include "device_list_engine.h"
#include "attribute_engine.h"
#include "commissioning_engine.h"
#include "polling.h"
#include "socket_interface.h"
#include "data_structures.h"
#include "actions_engine.h"
#include "attribute_engine.h"
#include "system_engine.h"
#include "gateway.pb-c.h"
#include "sensor_engine.h"
#include "nwkmgr.pb-c.h"


#define APP_ATTRID_BASIC_ZCL_VERSION                          0x0000
#define APP_ATTRID_BASIC_APPL_VERSION                         0x0001
#define APP_ATTRID_BASIC_STACK_VERSION                        0x0002
#define APP_ATTRID_BASIC_HW_VERSION                           0x0003
#define APP_ATTRID_BASIC_MODEL_ID                             0x0005


#define CALL_STACK_TRACE_DEPTH 		10	/*!< Segmentation fault handler call back stack size. */

#define SERVER_DETAILS_FILE_NAME 		"server_details.txt"				/*!< File name to store the IP address and ports of servers. */
#define GET_SERVER_DETAILS_FILE(x)		{sprintf(x, "./%s", SERVER_DETAILS_FILE_NAME);}  /*!< Get fule which stores server ip address aand ports. */

pthread_t PZigBeeThread;			/*!< Stores handle of the thread for ZigBee which connect to all the servers. */
RegisterCB CBPtr;				/*!< Pointer which registers all the call back function. */

static char InitStatus = 0;			/*!< Flag to indicate that initilaization status of ZigBee module. */

/*! brief API used for connecting to network manager server, OTA server and gateway server. It continuously polls all connection so that if any event/data comes from server.

	\param Params Not used now if want to use in futute then it will be useful.

	\return Returns NOTHING.
*/
static void * ZigBeeThread(void *Params) 
{
	/* Poll the servers to inform events to application layer. */
	while (polling_process_activity());

	/* API call only. */
	si_deinit();

	return NULL; 
}

/*! brief API used for unregister the segmentation fault handler.

	\return Returns NOTHING.
*/
static void unregister_segmentation_fault_handler(void)
{
	struct sigaction action;

	action.sa_flags = 0;
	action.sa_handler = SIG_DFL;
	memset(&action.sa_mask, 0, sizeof(action.sa_mask));
	action.sa_restorer = NULL;

	sigaction(SIGSEGV, &action, NULL);
}

/*! brief API used for handling the segmentation fault that occurs while running the application. It informs which segmentation fault occurs.

	\param signum It is number which uniqurely identifies which type of segmenation fault occurs.
	\param info It stores segmentation fault information .
	\param context Additional information.

	\return Returns NOTHING.
*/
static void segmentation_fault_handler(int signum, siginfo_t *info, void *context)
{
	void *array[CALL_STACK_TRACE_DEPTH];
	size_t size;

	fprintf(stderr, "ERROR: signal %d was trigerred:\n", signum);

	fprintf(stderr, "  Fault address: %p\n", info->si_addr);
	
	switch (info->si_code)
	{
		case SEGV_MAPERR:
			fprintf(stderr, "  Fault reason: address not mapped to object\n");
			break;
		case SEGV_ACCERR:
			fprintf(stderr, "  Fault reason: invalid permissions for mapped object\n");
			break;
		default:
			fprintf(stderr, "  Fault reason: %d (this value is unexpected).\n", info->si_code);
			break;
	}

	// get pointers for the stack entries
	size = backtrace(array, CALL_STACK_TRACE_DEPTH);

	if (size == 0)
	{
		fprintf(stderr, "Stack trace unavailable\n");
	}
	else
	{
		fprintf(stderr, "Stack trace folows%s:\n", (size < CALL_STACK_TRACE_DEPTH) ? "" : " (partial)");
		
		// print out the stack frames symbols to stderr
		backtrace_symbols_fd(array, size, STDERR_FILENO);
	}


	/* unregister this handler and let the default action execute */
	fprintf(stderr, "Executing original handler...\n");
	unregister_segmentation_fault_handler();
}

/*! brief API used for registering the segmentation fault handler which will informs and handled segmentation fault occurs while running the application.

	\return Returns NOTHING.
*/
static void register_segmentation_fault_handler(void)
{
	struct sigaction action;

	action.sa_flags = SA_SIGINFO;
	action.sa_sigaction = segmentation_fault_handler;
	memset(&action.sa_mask, 0, sizeof(action.sa_mask));
	action.sa_restorer = NULL;

	if (sigaction(SIGSEGV, &action, NULL) < 0)
	{
		perror("sigaction");
	}
}

/*! brief API used to get server details like ip address and port which will be used for connecting to the servers. It read server details present in text file and store it in ram varibales.

	\param ZigBeeParams It stores server details i.e. ip address and port number.

	\return Returns 1 on successful gettting of server detials. On error return -1 if fail to open text file which contains server details.
*/
static char GetNetWorkAddr(ZigBeeParam *ZigBeeParams)
{
	char FileName[20]= {0};
	FILE *Fptr;
        char *Line = NULL;
        size_t Len = 0;
        ssize_t BytesRead;
	unsigned char LineCnt = 0;

	/* Get file name which stores ip address and port of servers. */
	GET_SERVER_DETAILS_FILE(FileName);
 
	/* Open file in read mode. */	
        Fptr = fopen(FileName, "r");

	/* Error in opening in file. */
        if(Fptr == NULL)
	{
		printf("ERROR:Get net addr, open file fail, %s\r\n", FileName);
		return -1;
	}

	/* Read file line by linw to get ip address and port of network manager, gateway server and ota server. */
        while ((BytesRead = getline(&Line, &Len, Fptr)) != -1) 
	{
	
		/* Remove new line charcter. */
		Line[BytesRead -1] = '\0';

		if(LineCnt == 0)
		{
			/* Fill IP address for network manager server. */
			memcpy(ZigBeeParams->netHost, Line, BytesRead);

		}
		else if(LineCnt == 1)
		{
			/* Fill port number for network manager server. */
			ZigBeeParams->netPort = htons(atoi(Line));
		}
		else if(LineCnt == 2)
		{
			/* Fill IP address for gateway server. */
			memcpy(ZigBeeParams->gatewayHost, Line, BytesRead);
		}
		else if(LineCnt == 3)
		{
			/* Fill port number for gateway server. */
			ZigBeeParams->gatewayPort=htons(atoi(Line));
		}
		
		else if(LineCnt == 4)
		{
			/* Fill IP address for ota server. */
			memcpy(ZigBeeParams->otaHost, Line, BytesRead);
		}
		
		else if(LineCnt == 5)
		{
			/* Fill port number for ota server. */
			ZigBeeParams->otaPort= htons(atoi(Line));

		}
		LineCnt++;	

     //          printf("Retrieved line of length %u :\n", BytesRead);
     //          printf("%s", Line);
        }

	printf("NM, %s,P, %d, GS, %s, P, %d, OTAS, %s, P, %d\r\n", ZigBeeParams->netHost, ZigBeeParams->netPort, ZigBeeParams->gatewayHost, ZigBeeParams->gatewayPort, ZigBeeParams->otaHost, ZigBeeParams->otaPort);
        return 1;
}

/*! brief To initialize the communication with servers, i.e. create sockets.

	\return It will return 
		a. Already initialized (API_RETVAL_ALREAY_INITIALIZED)
		b. Fail to create socket thread (API_RETVAL_FAIL_TO_CREATE_THREAD)
		c. Fail to open configuration file to read configuration of socket (API_RETVAL_FAIL_TO_OPEN_CONFIG_FILE)
*/
signed char InitializeZigBee(void)
{
	ZigBeeParam ZigBeeParams;

	/* Check initialization is done already. */
	/* Init the ZigBee module. */
	if(InitStatus == 0)
	{
		/* Initilase the device table. */
		ds_init();

		/* Register segmentation fault handler. */
		register_segmentation_fault_handler();

		/* Get IP address and port of network, gateway and ota server. */
		if(GetNetWorkAddr(&ZigBeeParams) == -1)
		{
			printf("ERROR: IP Addr and port info file missing\r\n");
			return API_RETVAL_FAIL_TO_OPEN_CONFIG_FILE;
		}

		/* Connect to all the servers and poll them continuously for data on them. */
		if (si_init(ZigBeeParams.netHost, ZigBeeParams.netPort, ZigBeeParams.gatewayHost, ZigBeeParams.gatewayPort, ZigBeeParams.otaHost, ZigBeeParams.otaPort) == 0)
		{
			/* Create the ZigBee thread. */
			if (pthread_create(&PZigBeeThread, NULL, ZigBeeThread, NULL) != 0) 
			{  
				printf("ERROR:ZigBee thread\n");
				si_deinit();
				return API_RETVAL_FAIL_TO_CREATE_THREAD;
			}		

		}

		/* Update the variable which wil indicates initialization is done. */
		InitStatus = 1;

		return API_RETVAL_INITIALIZATION_SUCCESS; 
	}
	/* Initialization done already. */
	else
	{
		printf("ERROR: Already intialize ZigBee modules..\r\n");
		return API_RETVAL_ALREAY_INITIALIZED;
	}
}

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
signed char CreateZigBeeNetwork(unsigned int *RfChannel, unsigned int *PanID)
{
	unsigned char DeviceType;
	signed char RetVal = -1;
	unsigned long Timer = time(NULL) + 30;

	/* Remove incorrect bits */
	*RfChannel &= 0x07FFF800;

	/* Device type router is not supported. */
	DeviceType = DEVICE_TYPE_COORDINATOR;

	//printf("NWk, channel no, %04lx, pan id, %04lx, status, %d, app, channel no, %04lx, pan id, %04lx, %04lx\r\n", ds_network_status.nwk_channel, ds_network_status.pan_id, ds_network_status.state, *RfChannel, (1 << (ds_network_status.nwk_channel)), *PanID);

	/* Check the network status. */
	if(ds_network_status.state == ZIGBEE_NETWORK_STATE_READY)
	{		
		/* Check channel and pan id. Network is already formed on this channel and pan id. */
		if(((1 << (ds_network_status.nwk_channel)) & *RfChannel) && ds_network_status.pan_id == *PanID) //ds_network_status.ext_pan_id
		{
			printf("Network is already formed..\r\n");
			return API_RETVAL_NWK_ALREADY_STARTED;
		}
		
		return API_RETVAL_NWK_PARAM_MISMATCH;		
	}
	/* Verify the channel number */
	if(*RfChannel == 0)
	{
		printf("Invalid channel number..\r\n");
		return API_RETVAL_INVALID_PARAM;
	}
	/* Check network state is init for creating the network.*/
	else if(ds_network_status.state == ZIGBEE_NETWORK_STATE_INITIALIZING)
	{	
		printf("ZigBee, all servres up, Sending network form req..\r\n");

		/* Request for start network to network manager. */
		RetVal = comm_send_nwk_start(RfChannel, PanID, DeviceType);  

		if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
		{
			while(time(NULL) < Timer)
			{
				if(ds_network_status.state == ZIGBEE_NETWORK_STATE_READY)
				{
					/* Update the the pan id. */
					*PanID = ds_network_status.pan_id;

					/* Update the channel. */
					*RfChannel = (1 << ds_network_status.nwk_channel);

					printf("Create network, PAN id, %04x, Channel, %d, %04x\r\n", *PanID, ds_network_status.nwk_channel, *RfChannel);

					break;
				}
			}

			/* In case we are out of the loop and the state is still not ready then it means servers are not responding */
			if(ds_network_status.state != ZIGBEE_NETWORK_STATE_READY)
			{
				printf("Server not responding, %d\r\n", ds_network_status.state);
				return API_RETVAL_SERVERS_NOT_RESPONDING;
			}
		}

		return RetVal;
	}
	
	/* Network state is not init to form network. */
	printf("Server state not init/ready, %d\r\n", ds_network_status.state);
	return API_RETVAL_SERVERS_NOT_RUNNING;
}

/*! brief To allow / disallow another devices to join network.
	
  	\param 	AllowJoin 	Flag to set whether to allow or to disallow. 1 to allow and 0 to disallow
	\param	Time		Specify the time in seconds to allow other device to join
	
	\return It will return
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid join allow join flag or Invalid time limit. Valid range is 0 to 255 (API_RETVAL_INVALID_PARAM)
		d. Servers are not running (API_RETVAL_SERVERS_NOT_RUNNING)
*/
signed char AllowDeviceJoin(unsigned char AllowJoin, unsigned char Time)
{
	/* Validate the flag. */
	if(AllowJoin != DEVICE_JOIN_ALLOWED && AllowJoin != DEVICE_JOIN_DISALLOWED)
	{
		return API_RETVAL_INVALID_PARAM;
	}

	/* Validate the network state. */
	if(ds_network_status.state != ZIGBEE_NETWORK_STATE_READY)
	{
		return API_RETVAL_NWK_NOT_FORMED;
	}

	/* Validate the time. */
	if(Time >=0 && Time <= 255)
	{
		/* Check join flag to allow device to be join in netwrok. */	
		/* Device join not allowed. */
		if(AllowJoin == DEVICE_JOIN_DISALLOWED)
		{
			printf(" Device join not allowed, Flag, %d\r\n", AllowJoin);
			return API_RETVAL_INVALID_PARAM;
		}

		/* Send permit join request to network manager server. */
		return comm_send_permit_join(Time);
	}

	return API_RETVAL_INVALID_PARAM;
}

/*! brief Send request to remove the device from network.
	
  	\param 	IEEEAddr 	IEEE address of the device to be removed

	\return It will return
		a. Invalid IEEE address (API_RETVAL_INVALID_PARAM)
		b. Successfully informed stack layer to remove device (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to inform stack layer to remove device (API_RETVAL_STACK_LAYER_FAILURE)
		d. Servers are not running (API_RETVAL_SERVERS_NOT_RUNNING)
*/
signed char RemoveDevice(unsigned long long IEEEAddr)
{
	zb_addr_t DestAddr;

	/* Check the network status. */
	if(ds_network_status.state != ZIGBEE_NETWORK_STATE_READY)
	{
		printf("Error: Invalid netwrok state, Rcvd, %d, Expcted, %d\r\n", ds_network_status.state, ZIGBEE_NETWORK_STATE_READY);
		return API_RETVAL_NWK_NOT_FORMED;
	}		
	
	/* Validate the parameters. */
	if(IEEEAddr != 0)
	{
		/* Fill IEEE address. */
		DestAddr.ieee_addr = IEEEAddr;

		/* Fill Endpoint. */
		DestAddr.endpoint = 0; //EndPoint;

		printf("ZigBee, Remove dev, IEEE Addr, %016llx\r\n", IEEEAddr);

		/* Send remove device request to network manager. */
		return comm_remove_device_request(&DestAddr); 

	}

	printf("ZigBee, Invld endpt, IEEE Addr, %016llx\r\n", IEEEAddr);

	/* Invalid parameters. */
	return API_RETVAL_INVALID_PARAM;
}

/*! brief Allow to register API for getting network device status.
	
  	\param 	NewDeviceInd 	Function pointer for the callback to be invoked in case a new device is joined or left the network.

	\return Returns nothing
*/
void RegisterNetworkZigBeeDeviceIndCB(NetworkZigBeeDeviceIndCB NewDeviceInd)
{
	CBPtr.CBDeviceInd = NULL;

	if(NewDeviceInd != NULL)
	{
		/* Register call back for device indication. */
		CBPtr.CBDeviceInd = NewDeviceInd;
	}
}

/*! brief Allow to register API for getting network device list.
	
  	\param 	ZigBeeDeviceListCB 	Function pointer for the callback to be invoked to share the list of network devices.

	\return Returns nothing
*/
void RegisterNetworkZigBeeGetDeviceListCB(NetworkZigBeeDeviceListCB ZigBeeDeviceListCB)
{
	CBPtr.CBDeviceList = NULL;

	if(ZigBeeDeviceListCB != NULL)
	{
		/* Register call back for device list. */
		CBPtr.CBDeviceList = ZigBeeDeviceListCB;

	}	
}

/*! brief Allow to register API for getting the data (request / response) received from the ASE ZED devices.
	
  	\param 	DataReceived 	Function pointer for the callback to be invoked in case a stack receives any packet from ASE ZED device.

	\return Returns nothing
*/
void RegisterCustomDataReceivedCB(CustomDataReceivedCB DataReceived)
{	
	CBPtr.CBDataReceive = NULL;

	if(DataReceived != NULL)
	{
		/* Register call back for device list. */
		CBPtr.CBDataReceive = DataReceived;

		return;
	}
}

/*! brief API is used for getting device list from network manager. It gives device details like IEEE, endpoint associated with ZigBee network.
	
	\return It will return
		a. Successfully sent response to stack layer (API_RETVAL_STACK_LAYER_SUCCESS).
		b. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE).
		c. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC).
*/
signed char GetZigBeeNetworkDeviceList(void)
{
	/* Get the device list from network manager. */
	return device_send_list_request();

}

/*! brief API used to fill endpoint deatails of device. It stores end point, number of input clusters, number of output cluster associated with device.

	\param EPInfo It stores end point details of device.
	\param PBuf It conatains end point deatails that gpt from zstack.

	\return Returns 1 as success or 0 as fail if number of clusters exceed maximum configured value.
*/
static inline bool FillEndPoint(endpoint_info_t * EPInfo, NwkSimpleDescriptorT *PBuf)
{
	int Iterator1 = 0;
	int Iterator2 = 0;

	EPInfo->endpoint_id = PBuf->endpointid;
	EPInfo->profile_id = PBuf->profileid;
	EPInfo->device_id = PBuf->deviceid;
	EPInfo->num_ip_clusters = PBuf->n_inputclusters;
	EPInfo->num_op_clusters = PBuf->n_outputclusters;

	/* Validate the number of inout and output clusters. */
	if ((EPInfo->num_ip_clusters > MAX_CLUSTERS_ON_EP) || 	(EPInfo->num_op_clusters > MAX_CLUSTERS_ON_EP))
	{
		printf("update_endpoint_entry: Error: Number of clusters exceed MAX value configured (types.h: MAX_CLUSTERS_ON_EP)."); 
		
		return 0; 
	}

	/* Fill input cluster deatils. */
	for (Iterator1 = 0; Iterator1 < EPInfo->num_ip_clusters; Iterator1++)
	{
		EPInfo->ip_cluster_list[Iterator1].cluster_id = PBuf->inputclusters[Iterator1];

		EPInfo->ip_cluster_list[Iterator1].num_attributes = 0;

		for (Iterator2 = 0; Iterator2 < MAX_ATTRIBUTES; Iterator2++)
		{
			EPInfo->ip_cluster_list[Iterator1].attribute_list[Iterator2].valid = false; 
		}
	}

	/* Fill output cluster details. */
	for (Iterator1 = 0; Iterator1 < EPInfo->num_op_clusters; Iterator1++)
	{
		EPInfo->op_cluster_list[Iterator1].cluster_id = PBuf->outputclusters[Iterator1];
		EPInfo->op_cluster_list[Iterator1].num_attributes = 0;

		for (Iterator2 = 0; Iterator2 < MAX_ATTRIBUTES; Iterator2++)
		{
			EPInfo->op_cluster_list[Iterator1].attribute_list[Iterator2].valid = false; 
		}
	}
	
	return 1;
}

/*! brief API used to call appropiate call back function which inform event/data to application. Based on the call back flag respective registered call back function is called.  

	\param CBFlag Specifies which call back function to be called which are already registered.
	\param Info Specifies reference to the device info list or device info.

	\return Returns 1 on successful calling of call back function else return -1 as error.
*/
unsigned int InformEventToApp(unsigned char CBFlag, void *Info, void *ExtraData) 
{
	printf("Inform event, CB flag, %d\r\n", CBFlag);

	/* Check call back flag. */
	/* Inform device list through call back to application. */
	if(CBFlag == CB_FLAG_DEVICE_LIST)
	{
		/* Check call back is register or not. */
		/* Call back is register. */
		if(CBPtr.CBDeviceList != NULL)
		{	

			printf("Inform Event to upper layer, Device list..\r\n");
			/* Error in getting the device list. */
			if(Info == NULL)
			{
				/* Give device list to application. */
				CBPtr.CBDeviceList(0, NULL);	

			}
			/* Got the device list. */
			else if(Info != NULL)
			{
				/* Give device list to application. */
				CBPtr.CBDeviceList(ds_devices_total, ds_device_table);
			}

			return 0;
		}
		/* Call back is not register. */
		else
		{
			printf("ERROR: Call back function is not registered..\r\n");
			return -2;

		}
	}
	/* Inform device information through call back to application. */
	else if(CBFlag == CB_FLAG_DEVICE_INDICATION)
	{
		/* Check call back is register or not. */
		/* Call back is register. */
		if(CBPtr.CBDeviceInd != NULL)
		{
			int Iterator = 0;

			printf("Inform Event to upper layer, Device leave/join indication..\r\n");
			NwkDeviceInfoT DeviceInfo = *(NwkDeviceInfoT *)Info;
			device_info_t DeviceEntry;

			/* Fill device information. */
			DeviceEntry.valid = true;
			DeviceEntry.nwk_addr = DeviceInfo.networkaddress;
			DeviceEntry.ieee_addr = DeviceInfo.ieeeaddress;
			DeviceEntry.manufacturer_id = DeviceInfo.manufacturerid;
			DeviceEntry.device_status = DeviceInfo.devicestatus;
			DeviceEntry.num_endpoints = DeviceInfo.n_simpledesclist;

			/* Fill end point details. */
			for (Iterator = 0; Iterator < DeviceEntry.num_endpoints; Iterator++)
			{
				FillEndPoint(&DeviceEntry.ep_list[Iterator], DeviceInfo.simpledesclist[Iterator]);
			}
			
			/* Give device information to application. */
			CBPtr.CBDeviceInd(&DeviceEntry);			

			return 0;
		}
		/* Call back is not register. */
		else
		{
			printf("ERROR: Call back function is not registered..\r\n");
			return -2;
		}
	}
	/* Inform device information through call back to application. */
	else if(CBFlag == CB_FLAG_ON_OFF_STATUS)
	{
		/* Check call back is register or not. */
		/* Call back is register. */
		if(CBPtr.CBOnOffStatusInd != NULL)
		{
			GwZigbeeGenericRspInd Device = *(GwZigbeeGenericRspInd *)Info;

			pending_attribute_info_t AttribInfo = *(pending_attribute_info_t*)ExtraData;
			
			printf("On/Off CB, IEEE, 0x%16llx, Endpoint, 0x%x\r\n", AttribInfo.ieee_addr, AttribInfo.endpoint_id);
			/* Give device information to application. */
			CBPtr.CBOnOffStatusInd(AttribInfo.ieee_addr, AttribInfo.endpoint_id, Device.status, 0);			

			return 0;
		}
		/* Call back is not register. */
		else
		{
			printf("ERROR: Call back function is not registered..\r\n");
			return -2;
		}
	}
	/* Inform device information through call back to application. */
	else if(CBFlag == CB_FLAG_READ_SMART_METER_STATUS)
	{
		/* Check call back is register or not. */
		/* Call back is register. */
		if(CBPtr.CBOnOffStatusInd != NULL)
		{
			DevGetPowerRspInd SmartDevice = *(DevGetPowerRspInd *)Info;
			
			printf("On/Off CB, IEEE, 0x%16llx, Endpoint, 0x%x\r\n", SmartDevice.srcaddress->ieeeaddr, SmartDevice.srcaddress->endpointid);
			/* Give device information to application. */
			CBPtr.CBOnOffStatusInd(SmartDevice.srcaddress->ieeeaddr, SmartDevice.srcaddress->endpointid, SmartDevice.status, SmartDevice.powervalue);			

			return 0;
		}
		/* Call back is not register. */
		else
		{
			printf("ERROR: Call back function is not registered..\r\n");
			return -2;
		}
	}
	/* Inform device information through call back to application. */
	else if(CBFlag == CB_FLAG_ASE_CUSTOM_REQ)
	{
		/* Check call back is register or not. */
		/* Call back is register. */
		if(CBPtr.CBDataReceive != NULL)
		{
			DevSendASEGenReq *reqPkt = (DevSendASEGenReq *)ExtraData;
			int Iterator;
			int Iterator1;
			device_info_t *DevInfoPtr;
			endpoint_info_t *EpInfoPtr;
			char TempBuf[200];
			memset(TempBuf, 0, sizeof(TempBuf));

			/* Search endpoint of the device based on the IEEE address entry in device table. */
			for (Iterator = 0; Iterator < MAX_DEVICE_LIST; Iterator++)
			{
				DevInfoPtr = &ds_device_table[Iterator];

				/* Search for endpoint based on IEEE address. Search in device table entry for endpoint. */
				if ((DevInfoPtr->valid) && (DevInfoPtr->device_status != GW_DEVICE_STATUS_T__DEVICE_REMOVED) && (DevInfoPtr->ieee_addr == reqPkt->dstaddress->ieeeaddr))
				{
					for(Iterator1 = 0 ; Iterator1 < ds_device_table[Iterator].num_endpoints ; Iterator1++)
					{
						EpInfoPtr = &DevInfoPtr->ep_list[Iterator1];

						if(EpInfoPtr->endpoint_id == reqPkt->dstaddress->endpointid)
						{
							memcpy(TempBuf, reqPkt->apppkt.data, reqPkt->apppkt.len);
						
							/* Give device information to application. */
							/* Shortid, endpoint, deviceid, clusterid, message, message len */
							CBPtr.CBDataReceive(DevInfoPtr->nwk_addr, reqPkt->dstaddress->endpointid, EpInfoPtr->device_id, 0xFC01, SEND_GEN_REQ_PKT, TempBuf, reqPkt->apppkt.len, reqPkt->dstaddress->ieeeaddr);


							break;
						}

					}
					if(Iterator1 < ds_device_table[Iterator].num_endpoints)
					{
						break;
					}
				}
			}
			return 0;
		}
		/* Call back is not register. */
		else
		{
			printf("ERROR: Call back function is not registered..\r\n");
			return -2;
		}
	}
	/* Inform device information through call back to application. */
	else if(CBFlag == CB_FLAG_ASE_CUSTOM_RESP)
	{
		/* Check call back is register or not. */
		/* Call back is register. */
		if(CBPtr.CBDataReceive != NULL)
		{
			DevSendASEGenResp *respPkt = (DevSendASEGenResp *)ExtraData;
			int Iterator;
			int Iterator1;

			device_info_t *DevInfoPtr;
			endpoint_info_t *EpInfoPtr;
			char TempBuf[200];
			memset(TempBuf, 0, sizeof(TempBuf));


			/* Search endpoint of the device based on the IEEE address entry in device table. */
			for (Iterator = 0; Iterator < MAX_DEVICE_LIST; Iterator++)
			{
				DevInfoPtr = &ds_device_table[Iterator];


				/* Search for endpoint based on IEEE address. Search in device table entry for endpoint. */
				if ((DevInfoPtr->valid) && (DevInfoPtr->device_status != GW_DEVICE_STATUS_T__DEVICE_REMOVED) && (DevInfoPtr->ieee_addr == respPkt->dstaddress->ieeeaddr))
				{
					for(Iterator1 = 0 ; Iterator1 < ds_device_table[Iterator].num_endpoints ; Iterator1++)
					{
						EpInfoPtr = &DevInfoPtr->ep_list[Iterator1];

						if(EpInfoPtr->endpoint_id == respPkt->dstaddress->endpointid)
						{
							memcpy(TempBuf, respPkt->apppkt.data, respPkt->apppkt.len);
						
							/* Give device information to application. */
							/* Shortid, endpoint, deviceid, clusterid, message, message len */
							CBPtr.CBDataReceive(DevInfoPtr->nwk_addr, respPkt->dstaddress->endpointid, EpInfoPtr->device_id, 0xFC01, SEND_GEN_RESP_PKT, TempBuf, respPkt->apppkt.len,  respPkt->dstaddress->ieeeaddr);


							break;
						}

					}
					if(Iterator1 < ds_device_table[Iterator].num_endpoints)
					{
						break;
					}
				}
			}
			return 0;
		}
		/* Call back is not register. */
		else
		{
			printf("ERROR: Call back function is not registered..\r\n");
			return -2;
		}
	}
	/* Inform read attribute response through call back to application. */
	else if(CBFlag == CB_FLAG_ATTRIB_READ_RESP)
	{
		int Iterator;
		attribute_info_t *AttrInfo;

		/* If failure in reading attribute */
		if(Info == NULL)
		{
			printf("ERROR: Error in parsing READ attribute response..\r\n");
		}
		else
		{
			/* If success, then read all the attribute details */
			AttrInfo = (attribute_info_t *) Info;

			printf("ATTRIBUTE DETAILS:\r\n");
			for(Iterator = 0; Iterator < MAX_ATTRIBUTES; Iterator++)
			{
				if(AttrInfo[Iterator].valid == false)
				{
					break;
				}

				printf("ATTRIB, %04X, TYPE, %d, VAL, ", AttrInfo[Iterator].attr_id, AttrInfo[Iterator].attr_type);

				/* If UINT8 */
				if(AttrInfo[Iterator].attr_type == 0x20)
				{
					printf("%d", AttrInfo[Iterator].attr_val[0]);
				}
				/* If string */
				else if(AttrInfo[Iterator].attr_type == 0x42)
				{
					int Iterator2;

					for(Iterator2 = 0; Iterator2 < AttrInfo[Iterator].attr_val[0]; Iterator2++)
					{
						printf("%c", AttrInfo[Iterator].attr_val[1 + Iterator2]);
					}
				}
				printf("\r\n");
			}
		}
	}

	return -1;
}

/*! brief API used for getting power consumption of smart meter.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with 
	\param  SpecificResponse It is callback to be invoked once the operation is completed.

	\return It will return
		a. Invalid parameter. Either IEEE address or specific response (API_RETVAL_INVALID_PARAM).
		b. Successfully sent response to stack layer (API_RETVAL_STACK_LAYER_SUCCESS).
		c. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE).
*/
signed char ReadSmartMeter(unsigned long long IEEEAddr, ActionSpecificResponse SpecificResponse)
{

	zb_addr_t DestAddr;
	unsigned char EndPoint;
	
	/* Check the network status. */
	if(ds_network_status.state != ZIGBEE_NETWORK_STATE_READY)
	{
		printf("Error: Invalid netwrok state, Rcvd, %d, Expcted, %d\r\n", ds_network_status.state, ZIGBEE_NETWORK_STATE_READY);
		return API_RETVAL_NWK_NOT_FORMED;
	}

	/* Validate IEEE address. If it is invalid return error status. */
	if(IEEEAddr != 0)
	{
		/* Get endpoint from IEEE address. */
		EndPoint= GetEndPointFromDevTable(IEEEAddr);
	}
	/* Error as invalid parameter. */
	else
	{
		return API_RETVAL_INVALID_PARAM;;
	}

	/* Validate the IEEE address and endpoint. */
	if(EndPoint != 0)
	{
		/* Fill IEEE address. */
		DestAddr.ieee_addr = IEEEAddr;

		/* Fill end point. */
		DestAddr.endpoint = 0x02;

		CBPtr.CBOnOffStatusInd = NULL;

		if(SpecificResponse != NULL)
		{
			/* Register call back for device list. */
			CBPtr.CBOnOffStatusInd = SpecificResponse;
		}

		/* Send On/Off request based on the state. */
		return snsr_get_power(DestAddr);
	}

	/* Error as invalid parameter. */
	return API_RETVAL_INVALID_PARAM;	
}


/*! brief API used for getting attribute values of basic cluster of a device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with.

	\return It will returns
		a. Invalid parameter. (API_RETVAL_INVALID_PARAM).
		b. Successfully sent response to stack layer (API_RETVAL_STACK_LAYER_SUCCESS).
		c. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE).
*/
signed char ReadBasicCluster(unsigned long long IEEEAddr)
{
	zb_addr_t DestAddr;
	uint32_t attr_id[5];
	unsigned char EndPoint;


	/* Check the network status. */
	if(ds_network_status.state != ZIGBEE_NETWORK_STATE_READY)
	{
		printf("Error: Invalid netwrok state, Rcvd, %d, Expcted, %d\r\n", ds_network_status.state, ZIGBEE_NETWORK_STATE_READY);
		return API_RETVAL_NWK_NOT_FORMED;
	}

	/* Validate IEEE address. If it is invalid return error status. */
	if(IEEEAddr != 0)
	{
		/* Get endpoint from IEEE address. */
		EndPoint= GetEndPointFromDevTable(IEEEAddr);
	}
	/* Error as invalid parameter. */
	else
	{
		return API_RETVAL_INVALID_PARAM;;
	}

	/* Validate the IEEE address and endpoint. */
	if(EndPoint != 0)
	{
		/* Fill IEEE address. */
		DestAddr.ieee_addr = IEEEAddr;

		/* Fill end point. */
		DestAddr.endpoint = EndPoint;

		/* Fill attributes */
		attr_id[0] = APP_ATTRID_BASIC_ZCL_VERSION;
		attr_id[1] = APP_ATTRID_BASIC_APPL_VERSION;
		attr_id[2] = APP_ATTRID_BASIC_STACK_VERSION;
		attr_id[3] = APP_ATTRID_BASIC_HW_VERSION;
		attr_id[4] = APP_ATTRID_BASIC_MODEL_ID;

		/* Send request to lower layer. */
		attr_send_read_attribute_request(&DestAddr, 0x0000, 5, attr_id);

		return API_RETVAL_SUCCESS;
	}

	/* Error as invalid parameter. */
	return API_RETVAL_INVALID_PARAM;	
}



/*! brief Send ON / OFF request to HA device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with
  	\param 	ActionToPerform	Either On or Off. 1 for ON and 0 for OFF.
	\param  SpecificResponse It is callback to be invoked once the operation is completed.

	\return It will return
		a. Invalid parameter. Either IEEE address or callback or action to be performed (API_RETVAL_INVALID_PARAM)
		b. Successfully sent request to stack layer (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to send request to stack layer (API_RETVAL_STACK_LAYER_FAILURE)
*/
signed char SendOnOffReq(unsigned long long IEEEAddr, unsigned char ActionToPerform, ActionSpecificResponse SpecificResponse)
{
	zb_addr_t DestAddr;
	unsigned char EndPoint;

	/* Check the network status. */
	if(ds_network_status.state != ZIGBEE_NETWORK_STATE_READY)
	{
		printf("Error: Invalid netwrok state, Rcvd, %d, Expcted, %d\r\n", ds_network_status.state, ZIGBEE_NETWORK_STATE_READY);
		//TODO:
		return API_RETVAL_NWK_NOT_FORMED;
	}		

	if(IEEEAddr != 0 && (ActionToPerform == SEND_ON_REQ || ActionToPerform == SEND_OFF_REQ))
	{
		EndPoint= GetEndPointFromDevTable(IEEEAddr);
	}
	else
	{
		return API_RETVAL_INVALID_PARAM;;
	}
	/* Validate the IEEE address and endpoint. */
	if(EndPoint != 0)
	{
		/* Fill IEEE address. */
		DestAddr.ieee_addr = IEEEAddr;

		/* Fill end point. */
		DestAddr.endpoint = EndPoint;

		CBPtr.CBOnOffStatusInd = NULL;

		if(SpecificResponse != NULL)
		{
			/* Register call back for device list. */
			CBPtr.CBOnOffStatusInd = SpecificResponse;
		}

		/* Send On/Off request based on the state. */
		return act_set_onoff(&DestAddr, ActionToPerform);
	}

	/* Error as invalid parameter. */
	return API_RETVAL_INVALID_PARAM;
}

/*! brief Send generic custom request packet to device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with
  	\param 	MessageLen	Length of the message to send
  	\param 	Message		Message to send

	\return It will return
		a. Invalid parameter. Either IEEE address or message length or message (API_RETVAL_INVALID_PARAM)
		b. Successfully sent request to stack layer (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to send request to stack layer (API_RETVAL_STACK_LAYER_FAILURE)
*/
signed char SendGenReqPkt(unsigned long long IEEEAddr, unsigned char MessageLen, char *Message)
{
	zb_addr_t DestAddr;
	unsigned char EndPoint;

	/* Check the network status. */
	if(ds_network_status.state != ZIGBEE_NETWORK_STATE_READY)
	{
		printf("Error: Invalid netwrok state, Rcvd, %d, Expcted, %d\r\n", ds_network_status.state, ZIGBEE_NETWORK_STATE_READY);
		return API_RETVAL_NWK_NOT_FORMED;
	}		

	/* Invalid IEEE address. */
	if(IEEEAddr != 0)
	{
		EndPoint= GetEndPointFromDevTable(IEEEAddr);
	}
	else
	{
		return API_RETVAL_INVALID_PARAM;;
	}

	/* Validate the IEEE address and endpoint. */
	if(EndPoint != 0)
	{
		/* Fill IEEE address. */
		DestAddr.ieee_addr = IEEEAddr;

		/* Fill end point. */
		DestAddr.endpoint = EndPoint;

		/* Send request packet through custom cluster to the devices. */
		return act_send_ase_gen_req_pkt(&DestAddr, MessageLen, Message);
	}
	
	/* Error as invalid parameter. */
	return API_RETVAL_INVALID_PARAM;
}

/*! brief Send generic custom response packet to device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with 
  	\param 	MessageLen	Length of the message to send
  	\param 	Message		Message to send

	\return It will return
		a. Invalid parameter. Either IEEE address or message length or message (API_RETVAL_INVALID_PARAM)
		b. Successfully sent response to stack layer (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE)
*/
signed char SendGenRespPkt(unsigned long long IEEEAddr, unsigned char MessageLen, char *Message)
{
	zb_addr_t DestAddr;
	unsigned char EndPoint;

	/* Check the network status. */
	if(ds_network_status.state != ZIGBEE_NETWORK_STATE_READY)
	{
		//TODO:
		printf("Error: Invalid netwrok state, Rcvd, %d, Expcted, %d\r\n", ds_network_status.state, ZIGBEE_NETWORK_STATE_READY);
		return API_RETVAL_NWK_NOT_FORMED;
	}		

	if(IEEEAddr != 0)
	{
		EndPoint= GetEndPointFromDevTable(IEEEAddr);
	}
	else
	{
		return API_RETVAL_INVALID_PARAM;;
	}
	/* Validate the IEEE address and endpoint. */
	if(EndPoint != 0)
	{
		/* Fill IEEE address. */
		DestAddr.ieee_addr = IEEEAddr;

		/* Fill end point. */
		DestAddr.endpoint = EndPoint;

		/* Send response packet through custom cluster to the devices. */
		return act_send_ase_gen_resp_pkt(&DestAddr, MessageLen, Message);
	}

	/* Error as invalid parameter. */
	return API_RETVAL_INVALID_PARAM;
}


/*! brief Reset the ZigBee network. This is to be invoked after removing all devices from the network. 
 * Application layer will call this if CreateZigBeeNetwork returns "Parameter mismatch with existing network".
	
  	\param 	ResetType 	Whether to do soft reset or hard reset soft reset 0, hard reset 1

	\return It will return
		a. Invalid reset type (API_RETVAL_INVALID_PARAM)
		b. Successfully destroyed the network (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to destroyed the network (API_RETVAL_STACK_LAYER_FAILURE)
*/
signed char ResetZigBeeNetwork(unsigned char ResetType)
{
	/* Validate the reset type. */
	/* Software and Hardware reset is valid reset type only. */
	if(ResetType != SYSTEM_RESET_TYPE_HARD && ResetType != SYSTEM_RESET_TYPE_SOFT)
	{
		printf("Reset type invalid..\r\n");
		return API_RETVAL_INVALID_PARAM;
	}

	/* Validate the network state. */
	/* If network state is ready then only destroy the network. */
	if(ds_network_status.state != ZIGBEE_NETWORK_STATE_READY)
	{
		printf("Network state not matched, current, %d, expected, %d. Still resetting\r\n", ds_network_status.state, ZIGBEE_NETWORK_STATE_READY);
	}	

	/* Send reset request to destroy the network and clear network information. */
	return system_send_reset_request(ResetType);
}


/*! brief Returns the current status of the ZigBee network.

	\return It will return 
		a. Servers are not running (API_RETVAL_SERVERS_NOT_RUNNING)
		b. Network not formed (API_RETVAL_NWK_NOT_FORMED)
		c. Network ready (API_RETVAL_NWK_READY)
*/
signed char GetZigBeeNetworkStatus(void)
{
	/*Servers are running and network is initialize. */
	if(ds_network_status.state == ZIGBEE_NETWORK_STATE_INITIALIZING)
	{
		printf("Network state is initilaize\r\n");
		return API_RETVAL_NWK_NOT_FORMED;

	}
	/* ZigBee network is formed. */
	else if(ds_network_status.state == ZIGBEE_NETWORK_STATE_READY)
	{
		printf("Network state is ready\r\n");
		return API_RETVAL_NWK_READY;
	}

	/* Servers are not running. */
	printf("Network state is unavailable, Servers are not running\r\n");
	return API_RETVAL_SERVERS_NOT_RUNNING;
}

