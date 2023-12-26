/*! \file main.c
	\brief Application execution starts from this point. It calls api which initializes ZigBee paramters and resgiters all the call back that can be used to inform the events to application layer. It is menu driven application which takes input from user and perfrom related operation based on it.
*/

#include <stdio.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include "zigbee.h"
#include "zigbee_ha.h"

#define SAMPLE_APP_VERSION	3

int AppDevCnt = 0;
device_info_t AppDevInfo[50];

/*! brief API used for connecting to network manager server, OTA server and gateway server. It continuously polls all connection so that if any event/data comes from server.

	\param Params Not used now if want to use in futute then it will be useful.

	\return Returns NULL.
*/
void DeviceJoinReq(void)
{
	int AllowJoinFlag = 0;
	int Time = 0;
	signed char RetVal = -1;

	/*Take allow flag from user which deciced so allow/disallow device join. */
	printf("Allow/Disallow device join\r\n0.DisAllowJoin\r\n1.Allowjoin\r\n");
	scanf("%d", &AllowJoinFlag);

	/* Join is not allowed. */
	if(AllowJoinFlag == 0)
	{
		printf("Permit join disallowed..\r\n");
		return;
	}

	/* Take time from user upto whcih device join allowed. */
	printf("Enter the time to allow device to join (0 to 255)\r\n");
	scanf("%d", &Time);	

	/* Send request for permit join. */
	RetVal = AllowDeviceJoin(AllowJoinFlag, Time);

	if(RetVal == API_RETVAL_STACK_LAYER_FAILURE)
	{
		printf("ERROR:Device join fails, request can not send..\r\n");	\
	}
	/* Stops timer of infinite time device join request. */
	else if(RetVal == API_RETVAL_FAIL_TO_MEM_ALLOC)
	{
		printf("ERROR: Device join fails..\r\n");
	}	
	/* Invalid join flag. */
	else if(RetVal == API_RETVAL_INVALID_PARAM)
	{
		printf("Invalid join flag, %d\r\n", AllowJoinFlag);
	}	
	else if(RetVal == API_RETVAL_NWK_NOT_FORMED)
	{
		printf("Join not allowed as nwk state not valid..\r\n");
	}
	/* Device join success. */
	else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
	{
		printf("join req send successful..\r\n");
	}

	return;
}

/*! brief API used for displaying the device list associated with network manager. It contains device information e.g. ieee address, end points, network address, cluster id.

	\param DevCnt Number of devices associated with netwrok manager.
	\param DevInfo It conatins device information like eee address, end points, network address, cluster id.
	\return Returns NOTHING.
*/
void ZigbeeDeviceList(int DevCnt, device_info_t *DevInfo)
{
	int Iterator = 0;

	/* Copy the details in global variable */
	AppDevCnt = DevCnt;

	/* Error occured while device list request and so list given by network manager is empty. */
	if(DevInfo == NULL && DevCnt == 0)
	{
		printf("ERROR: IN GETTING DEVICE LIST\r\n");
		return;
	}

	/* Copy the details in global variable */
	memcpy(AppDevInfo, DevInfo, AppDevCnt * sizeof(device_info_t));

	printf("IN DEV LST CB, DEV CNT, %d\r\n", DevCnt);

	printf("========================================================  DEVICES ========================================================\r\n");
	/* Display the device information. */
	for (Iterator = 0; Iterator < AppDevCnt; Iterator++)
	{
		printf("(%d) IEEE ADDR, 0x%016llX, NWK ADDR, 0x%04X, STATUS, %u, MANUFID, 0x%04X, EP, %X, PROFILE, %04X, DEVID, %04X\r\n", Iterator + 1, AppDevInfo[Iterator].ieee_addr, AppDevInfo[Iterator].nwk_addr, AppDevInfo[Iterator].device_status, AppDevInfo[Iterator].manufacturer_id, AppDevInfo[Iterator].ep_list[0].endpoint_id, AppDevInfo[Iterator].ep_list[0].profile_id, AppDevInfo[Iterator].ep_list[0].device_id);
	}
	printf("==========================================================================================================================\r\n");

}

/*! brief API used for displaying device table which stores device information like IEEE address, endpoint. Device table contains entry of that device those are part of ZigBee network.

	\return Returns NOTHING.
*/
void DisplayDeviceTable(void)
{
	int Iterator = 1;

	printf("Select the device..\r\n");	
	printf("==============================================\r\n");

	/* Display available device list. */
	for(Iterator = 1; Iterator <  AppDevCnt; Iterator++)
	{
		printf("%d:0x%016llx\r\n", Iterator, AppDevInfo[Iterator].ieee_addr);
	}
	printf("==============================================\r\n");
}

/*! brief API used for informing the device indication. Device indications when device join network or leave network.

	\param DeviceEntry It conatins device information like eee address, end points, network address, cluster id and device status.
	\return Returns NOTHING.
*/
void NewDeviceInd(device_info_t *DeviceEntry)
{
	printf("New device join/leave indication..\r\n");

	/* Display device information which joins or leave the network. */
	printf("NET ADDR, %04x, IEEE, %016llx, ManId, %u, STATUS, %u\n", DeviceEntry->nwk_addr, DeviceEntry->ieee_addr , DeviceEntry->manufacturer_id, 	DeviceEntry->device_status);

	/* Get the device list from network manager as device entry is added/deleted from it. */
	GetZigBeeNetworkDeviceList();

}

/*! brief API used for removing the device from the network. It removes entry from device table and also device leave the network.

	\return Returns NOTHING.
*/
static void RemoveDeviceReq(void)
{
	int DevIndx = 0;
	signed char RetVal = -1;
	
	if(AppDevCnt <= 1)
	{
		printf("ERROR: No router entry in list..\r\n");
		return;
	}

	/* Display device table. */
	DisplayDeviceTable();	

	/* Take user input to remove device present in device list. */
	scanf("%d", &DevIndx);

	/* Validate the device index. */
	if(DevIndx > 0 && DevIndx < AppDevCnt)
	{
		/* Send remove device request. */
		RetVal = RemoveDevice(AppDevInfo[DevIndx].ieee_addr);
	}
	/* Invalid device index. */
	else
	{
		printf("Selected device index invalid\r\n");
		return;
	}
	/* Failure cases based on the return value. */
	if(RetVal == API_RETVAL_STACK_LAYER_FAILURE)
	{
		printf("ERROR: Remove device fails, Req send fail..\r\n");
	}
	else if(RetVal == API_RETVAL_FAIL_TO_MEM_ALLOC)
	{
		printf("ERROR: Remove device fails..\r\n");
	}
	else if(RetVal == API_RETVAL_INVALID_PARAM)
	{
		printf("ERROR: Remove device fails, End point not found..\r\n");
	}
	else if(RetVal == API_RETVAL_NWK_NOT_FORMED)
	{
		printf("ERROR: Network state not valid..\r\n");

	}
	/* Request sent successfully. */
	else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
	{
		printf("Remove device successful..\r\n");

		/* Get device list as device entry is deleted from netwrok manager. */
		GetZigBeeNetworkDeviceList();
	}

	return;
}

/*! brief API used for dispalying the status of request whether request is served by device properly. It gives response details got from device for On/Off request or get smart meter reading of power consumption.

	\param IEEE Specifies IEEE address of the device.
	\param EndPoint Specifies endpoint address of the device.
	\param Status It specifies repsponse got from the device. If request successfully served by device then status is success else failure.
	\param Result It specifies power consumption of smart meter.

	\return Returns NULL.
*/
void SpecificResponse(unsigned long long IEEE, unsigned char EndPoint, unsigned char Status, unsigned int Result)
{
	printf("Specific response, IEEE, 0x%llx, EndPoint, 0x%x, Status, %d, Result, %u\r\n", IEEE, EndPoint, Status, Result);
}

/*! brief API used for getting the power consumption of smart meter.

	\return Returns NOTHING.
*/
void ReadSmartMeterPowerConsumption(void)
{
	int DevIndx = 0;
	signed char RetVal = -1;

	if(AppDevCnt <= 1)
	{
		printf("ERROR: No router entry in list..\r\n");
		return;
	}

	/* Display device table. */
	DisplayDeviceTable();	

	/* Take user input to on/off device present in device list. */
	scanf("%d", &DevIndx);

	/* Validate the device index. */
	if(DevIndx > 0 && DevIndx < AppDevCnt)
	{
		RetVal = ReadSmartMeter(AppDevInfo[DevIndx].ieee_addr, SpecificResponse);
	}

	/* Invalid device index. */
	else
	{
		printf("Selected device index invalid\r\n");
		return;
	}

	/* Failure conditons based on return value. */
	if(RetVal == API_RETVAL_STACK_LAYER_FAILURE)
	{
		printf("ERROR:Req read smart meter fail..\r\n");	
	}
	else if(RetVal == API_RETVAL_FAIL_TO_MEM_ALLOC)
	{
		printf("ERROR: Req read smart meter fail..\r\n");
	}
	else if(RetVal == API_RETVAL_INVALID_PARAM)
	{
		printf("ERROR: Invalid parameters, IEEE, %016llu\r\n", AppDevInfo[DevIndx].ieee_addr);
	}
	else if(RetVal == API_RETVAL_NWK_NOT_FORMED)
	{
		printf("Network state invalid..\r\n");
	}
	/* Request sent successfully. */
	else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
	{
		printf("Req read smart meter successful..\r\n");			
	}

	return;
}


/*! brief API used for getting the attributes of basic cluster.

	\return Returns NOTHING.
*/
void ReadAttrOfBasicCluster(void)
{
	int DevIndx = 0;
	signed char RetVal = -1;

	if(AppDevCnt <= 1)
	{
		printf("ERROR: No router entry in list..\r\n");
		return;
	}

	/* Display device table. */
	DisplayDeviceTable();	

	/* Take user input to on/off device present in device list. */
	scanf("%d", &DevIndx);

	/* Validate the device index. */
	if(DevIndx > 0 && DevIndx < AppDevCnt)
	{
		RetVal = ReadBasicCluster(AppDevInfo[DevIndx].ieee_addr);
	}
	/* Invalid device index. */
	else
	{
		printf("Selected device index invalid\r\n");
		return;
	}

	/* Failure conditons based on return value. */
	if(RetVal == API_RETVAL_STACK_LAYER_FAILURE)
	{
		printf("ERROR:Req read basic cluster attribute fail..\r\n");	
	}
	else if(RetVal == API_RETVAL_FAIL_TO_MEM_ALLOC)
	{
		printf("ERROR: Req read basic cluster attribute fail..\r\n");
	}
	else if(RetVal == API_RETVAL_INVALID_PARAM)
	{
		printf("ERROR: Basic cluster attribute. Invalid parameters, IEEE, %016llu\r\n", AppDevInfo[DevIndx].ieee_addr);
	}
	else if(RetVal == API_RETVAL_NWK_NOT_FORMED)
	{
		printf("Network state invalid. Basic cluster attribute. ..\r\n");
	}
	/* Request sent successfully. */
	else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
	{
		printf("Req read basic cluster attribute successful..\r\n");			
	}

	return;
}

/*! brief API used for sending on/off request to ASE or third party devices. User has to select device to which he wants to send on/off request.

	\param ActionToPerform It represents action to be perform on device e.g. on, off etc .
	\return Returns NOTHONG.
*/
static void OnOffReq(unsigned char ActionToPerform)
{
	int DevIndx = 0;
	signed char RetVal = -1;

	if(AppDevCnt <= 1)
	{
		printf("ERROR: No router entry in list..\r\n");
		return;
	}

	if(ActionToPerform != SEND_ON_REQ && ActionToPerform != SEND_OFF_REQ)
	{
		printf("Action inavlid, %d, valid, %d, %d\r\n", ActionToPerform, SEND_ON_REQ, SEND_OFF_REQ);
		return;
	}

	/* Display device table. */
	DisplayDeviceTable();	

	/* Take user input to on/off device present in device list. */
	scanf("%d", &DevIndx);

	/* Validate the device index. */
	if(DevIndx > 0 && DevIndx < AppDevCnt)
	{
		RetVal = SendOnOffReq(AppDevInfo[DevIndx].ieee_addr, ActionToPerform, SpecificResponse);
	}

	/* Invalid device index. */
	else
	{
		printf("Selected device index invalid\r\n");
		return;
	}
	
	/* Failure conditons based on return value. */
	if(RetVal == API_RETVAL_STACK_LAYER_FAILURE)
	{
		printf("ERROR: send on/off fails, Req send fail..\r\n");	
	}
	else if(RetVal == API_RETVAL_FAIL_TO_MEM_ALLOC)
	{
		printf("ERROR: send on/off fails..\r\n");
	}
	else if(RetVal == API_RETVAL_INVALID_PARAM)
	{
		printf("ERROR: Invalid parameters, IEEE, %016llu\r\n", AppDevInfo[DevIndx].ieee_addr);
	}
	else if(RetVal == API_RETVAL_NWK_NOT_FORMED)
	{
		printf("Network state invalid..\r\n");
	}
	/* Request sent successfully. */
	else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
	{
		printf("on/off device successful..\r\n");			
	}
	
	return;
}

/*! brief API used to fill the command packet that to send to ASE device through custom cluster i.e. FC01.
This is used to fill dummy data in request / response packet that to be send to ASE device.

 	\param CmdBuffer is used to fill dummy data.
 	\param IsReqFlag is used to distinguish between the request and response command.
 	\return Returns the length of string which is filled in the CmdBuffer.
*/
static unsigned int FillDefaultCommand(char *CmdBuffer, unsigned char IsReqFlag)
{
	time_t Time;
	struct tm *Tm;

	/* Getting the current time */
	time(&Time);

	/* Getting the time in user readable format */
	Tm = localtime(&Time);

	/* If req flag is 1 that means req is to be sent */
	if(IsReqFlag == 1)
	{
		sprintf(CmdBuffer, "%s....Time: %d:%d:%d....Date: %d/%d/%d", "Request for test Custom cluster for ASE ", Tm->tm_hour, Tm->tm_min, Tm->tm_sec, Tm->tm_mday, Tm->tm_mon, (Tm->tm_year + 1900));
	}
	/* Else response is to be sent */
	else if(IsReqFlag == 0)
	{
		sprintf(CmdBuffer, "%s....Time: %d:%d:%d....Data: %d/%d/%d", "Response for test Custom cluster for ASE ", Tm->tm_hour, Tm->tm_min, Tm->tm_sec, Tm->tm_mday, Tm->tm_mon, (Tm->tm_year + 1900));
	}

	/* Returning the length filled */
	return strlen(CmdBuffer);
}

/*! brief API used for sending request packet to ASE deviecs or third party devices through the custom cluster i.e. FC01. It sends dummy data that to be send to ASE devices.

 	\param IsReqFlag is used to distinguish between the request and response command.
	\return Returns NOTHING.
*/
static void SendGenReqResp(unsigned char IsReqFlag)
{
	int DevIndx = 0;
	unsigned int Length = 0;
	char CmdBuffer[120] = {0};
	signed char RetVal = -1;

	if(AppDevCnt <= 1)
	{
		printf("ERROR: No router entry in list..\r\n");
		return;
	}

	/* Display device table. */
	DisplayDeviceTable();	

	scanf("%d", &DevIndx);

	/* Filling default command to send request packet to ASE deviec througth custom cluster.*/
	Length = FillDefaultCommand(CmdBuffer, IsReqFlag);

	/* Send request packet through custom cluster. */
	if(IsReqFlag == SEND_GEN_REQ_PKT)
	{
		/* Validate the device index. */
		if(DevIndx > 0 && DevIndx < AppDevCnt)
		{
			RetVal = SendGenReqPkt(AppDevInfo[DevIndx].ieee_addr, Length, CmdBuffer);
		}

		/* Invalid device index. */
		else
		{
			printf("Selected device index invalid\r\n");
			return;
		}

		/* Error on sending the generic request packet. */
		if(RetVal == API_RETVAL_FAIL_TO_MEM_ALLOC)
		{
			printf("ERROR: Send gen req fails, Can not allocate memory..\r\n");
		}
		/* Error on sending the generic request packet. */
		else if(RetVal == API_RETVAL_STACK_LAYER_FAILURE)
		{
			printf("ERROR: Send gen req fails, can not send req on socket..\r\n");
		}
		else if(RetVal == API_RETVAL_INVALID_PARAM)
		{
			printf("ERROR: Send gen resp fails, Invalid param , IEEE addr, %16llu, Endpoint, %02x\r\n", AppDevInfo[DevIndx ].ieee_addr,  AppDevInfo[DevIndx ].ep_list[AppDevInfo[DevIndx ].selected_endpoint_index].endpoint_id);

		}
		else if(RetVal == API_RETVAL_NWK_NOT_FORMED)
		{
			printf("Network state invalid..\r\n");
		}	
		/* Send generic request is successful. */
		else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
		{
			printf("Send generic request successful..\r\n");
		}

	}

	/* Send response packet through custom cluster. */
	else if(IsReqFlag == SEND_GEN_RESP_PKT)
	{
		/* Validate the device index. */
		if(DevIndx > 0 && DevIndx < AppDevCnt)
		{
			RetVal = SendGenRespPkt(AppDevInfo[DevIndx].ieee_addr, Length, CmdBuffer);
		}
		/* Invalid device index. */
		else
		{
			printf("Selected device index invalid\r\n");
			return;
		}

		/* Failure conditons based on return value. */	
		if(RetVal == API_RETVAL_FAIL_TO_MEM_ALLOC)
		{
			printf("ERROR: Send gen resp fails, Can not allocate memory..\r\n");
		}
		else if(RetVal == API_RETVAL_STACK_LAYER_FAILURE)
		{
			printf("ERROR: Send gen resp fails, can not send req on socket..\r\n");
		}
		else if(RetVal == API_RETVAL_INVALID_PARAM)
		{
			printf("ERROR: Send gen resp fails, Invalid param , IEEE addr, %16llu, Endpoint, %02x\r\n", AppDevInfo[DevIndx ].ieee_addr,  AppDevInfo[DevIndx ].ep_list[AppDevInfo[DevIndx ].selected_endpoint_index].endpoint_id);
		}

		else if(RetVal == API_RETVAL_NWK_NOT_FORMED)
		{
			printf("Network state invalid..\r\n");
		}
		/* Request sent successfully. */
		else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
		{
			printf("Remove device successful..\r\n");
		}
	}

	return;
}

/*! brief API used to distroy the network and clear network information if reset type is hardware reset. Distroy network is used if user want to create network on other network.

	\return Returns NOTHING.
*/
static void ResetNetwork(void)
{
	signed char RetVal = -1;

	/* Distroy the network. */
	RetVal = ResetZigBeeNetwork(SYSTEM_RESET_TYPE_HARD);

	/* Failure conditons based on return value. */	
	if(RetVal == API_RETVAL_STACK_LAYER_FAILURE)
	{
		printf("ERROR: Could not send msg..\r\n");
	}
	else if(RetVal == API_RETVAL_INVALID_PARAM)
	{
		printf("ERROR: Could not pack msg..\r\n");
	}
	else if(RetVal == API_RETVAL_NWK_NOT_FORMED)
	{
		printf("ERROR: Network not formed..\r\n");
	}
	else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
	{

	}
	/* Request sent successfully. */	
	else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
	{
		printf("Reset network successful..\r\n");
	}

	return;
}

/*! brief API used for giving response details that got from Device. It gives data response got from device through custom cluster. Also in respect to device request through custom cluster it gives response to it.

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
int ASEDataReceived(unsigned short NwkAddr, unsigned short EndPoint, unsigned short DeviceId, unsigned short ClusterId, unsigned char IsReqFlag, char *Message, unsigned char MessageLen, unsigned long long IEEEAddr)
{
	if(IsReqFlag == SEND_GEN_REQ_PKT)
	{
		char CmdBuffer[120] = {0};
		time_t Time;
		struct tm *Tm;

		/* Getting the current time */
		time(&Time);

		/* Getting the time in user readable format */
		Tm = localtime(&Time);

		printf("Nwk Addr, %u, EndPoint, %x, Dev Id, %u, ClusterId, %u, Msg Len, %d\r\n", NwkAddr, EndPoint, DeviceId, ClusterId, MessageLen);

		printf("=============== Req data ===============\r\n");
		printf("%s\r\n", Message);
		printf("========================================\r\n");

		sprintf(CmdBuffer, "%s....Time: %d:%d:%d....Data: %d/%d/%d", "Response for test Custom cluster for ASE ", Tm->tm_hour, Tm->tm_min, Tm->tm_sec, Tm->tm_mday, Tm->tm_mon, (Tm->tm_year + 1900));

		SendGenRespPkt(IEEEAddr, strlen(CmdBuffer), CmdBuffer);

		printf("Req sent, Message len, %d\r\n", strlen(CmdBuffer));

	}

	else if(IsReqFlag == SEND_GEN_RESP_PKT)
	{
		printf("Resp pkt, Nwk Addr, %u, EndPoint, %x, Dev Id, %u, ClusterId, %u, Msg Len, %d\r\n", NwkAddr, EndPoint, DeviceId, ClusterId, MessageLen);
		printf("================ Resp Data ======================\r\n");
		printf("%s\r\n", Message);
		printf("==================================================\r\n");
	}

	return 0;

}

/*! brief API used for displaying the menu. Menu displays various operations that user can perform.

	\return Returns NOTHING.
*/
void DisplayMenu(void)
{
	printf("\r\n============================= MENU [VER: %d]=================================\r\n", SAMPLE_APP_VERSION);
	printf("1. Form network\r\n2. Allow device join\r\n3. Get device list\r\n4. Remove device\r\n5. Send on req\r\n6. Send off req\r\n7. Send generic req			\r\n8. Send generic resp\r\n9. Get network state\r\n10. Read smart meter\r\n11. Reset network\r\n12. Read basic cluster\r\n0. Exit application\r\n");
	printf("=====================================================================\r\n");
}

/*! brief Application execution starts from this point. It calls api which initializes ZigBee paramters and resgiters all the call back that can be used to inform the events to application layer. It is menu driven application which takes input from user and perfrom related operation based on it.

	\return Returns 0 on success and -1 as ERROR if error in getting server details and -2 as ERROR when fail to create ZigBee thread.
*/
int main()
{
	int Choice;
	signed char RetVal = -1;
	unsigned int RfChannel;
	unsigned int PanID;

	/* Create and initialize the ZigBee stack. */
	RetVal = InitializeZigBee();

	/* Error in opening file which contains all server's port and ip address. */
	if(RetVal == API_RETVAL_FAIL_TO_OPEN_CONFIG_FILE)
	{
		printf("ERROR: In openijng the ip/port info file..\r\n");
		return -1;
	}
	/* Error in creating the ZigBee thread. */
	else if(RetVal == API_RETVAL_FAIL_TO_CREATE_THREAD)
	{
		printf("ERROR: Unable to create ZigBee therad..\r\n");
		return -2;
	}
	/* Init of ZigBee module is done already. */
	else if(RetVal == API_RETVAL_ALREAY_INITIALIZED)
	{
		printf("ERROR: Initialization already done..\r\n");
		return -2;
	}

	/* Register all the call backs. */
	/* Register call back for ZigBee device indication. */
	RegisterNetworkZigBeeDeviceIndCB(NewDeviceInd);

	/* Register call back for device list associated with network manager. */
	RegisterNetworkZigBeeGetDeviceListCB(ZigbeeDeviceList);

	/* Register call back for data received. */
	RegisterCustomDataReceivedCB(ASEDataReceived);

	while(1)
	{
		/* Display the main menu. */
		DisplayMenu();

		printf("Select operation to be perform ->\r\n");
		scanf("%d", &Choice);

		/* Perform user selected operations. */
		switch(Choice)
		{
			/* Form the network. */
			case 1: 
				printf("CREATING NETWORK.. \r\n");

				/* Network is successfully formed. */
				RfChannel = 0x00618800;
				PanID = 0xFEED;
				RetVal = CreateZigBeeNetwork(&RfChannel, &PanID);

				/* Servers are not running. */
				if(RetVal == API_RETVAL_SERVERS_NOT_RUNNING)
				{
					printf("ERROR: Create network fail..\r\n");
				}
				/* Network state is ready. */
				else if(RetVal == API_RETVAL_NWK_ALREADY_STARTED)
				{
					printf("ERROR: Network already formed with this channel..\r\n");
				}
				/* Network is formed on another channel. So reset that network first to form network on another channel. */
				else if(RetVal == API_RETVAL_NWK_PARAM_MISMATCH)
				{
					printf("ERROR: Remove the device and reset the current network..\r\n");
				}
				/* Request does not send. */
				else if(RetVal == API_RETVAL_STACK_LAYER_FAILURE )
				{
					printf("ERROR: Start network request could not send to network manager..\r\n");
				}
				/* Fail to allocate memory. */
				else if(RetVal == API_RETVAL_FAIL_TO_MEM_ALLOC)
				{
					printf("ERROR: Memory allocation failed..\r\n");
				}
				/* Request to start network sent successfully. */
				else
				{
					printf("Send network form request.., CH %04x, PANID, %04x\r\n", RfChannel, PanID);
				}

				break;

			/* Send devicve join request. */
			case 2:
				printf("DEV JOIN REQ..\r\n");
				DeviceJoinReq();
				break;

			/* Get device lyst from network manager. */
			case 3:
				printf("DEVICE LST REQ..\r\n");

				RetVal = GetZigBeeNetworkDeviceList();

				/* Error in sending request for device list to network manager. */
				if(RetVal == API_RETVAL_STACK_LAYER_FAILURE)
				{
					printf("ERROR:Fail to send request to network manager..\r\n");
				}
				/* Memory allocation fail. */
				else if(RetVal == API_RETVAL_FAIL_TO_MEM_ALLOC)
				{
					printf("ERROR:Memory allocation fail..\r\n");

				}
				/* Request for device list send successfully. */
				else if(RetVal == API_RETVAL_STACK_LAYER_SUCCESS)
				{
					printf("Request for device list send successfully\r\n");
				}

				break;

			/* Remove the device from the network. */
			case 4:
				printf("REMOVE DEV REQ..\r\n");
				RemoveDeviceReq();
				break;

			/* Send on request to ZED. */
			case 5:
				printf("ON REQ..\r\n");
				OnOffReq(SEND_ON_REQ);
				break;

			/* Send off request to ZED. */
			case 6:
				printf("OFF REQ..\r\n");
				OnOffReq(SEND_OFF_REQ);
				break;

			/* Send request data thorugh the custom cluster. */
			case 7:
				SendGenReqResp(SEND_GEN_REQ_PKT);
				break;

			/* Send response data thorugh the custom cluster. */
			case 8:
				SendGenReqResp(SEND_GEN_RESP_PKT);
				break;

			/* Get ZigBee network state. */
			case 9:
				printf("Get ZigBee network status..\r\n");
				RetVal = GetZigBeeNetworkStatus();

				/* Netwoek state is down. */
				if(RetVal == API_RETVAL_SERVERS_NOT_RUNNING)
				{
					printf("Network state is down. Servers are not up..\r\n");
				}
				/* Network state is initilaize. */
				else if(RetVal == API_RETVAL_NWK_NOT_FORMED)
				{
					printf("Network state is initialize, Servers are up..\r\n");
				}
				/* Network state is ready. */
				else if(RetVal == API_RETVAL_NWK_READY)
				{
					printf("Network state is ready..\r\n");
				}

				break;

			/* Read smart meter power consumption. */
			case 10:
				ReadSmartMeterPowerConsumption();
				break;

			/* Reset the network. */
			case 11:
				printf("Reset the network..\r\n");
				ResetNetwork();
				break;

			/* Read attributes of basic cluster. */
			case 12:
				ReadAttrOfBasicCluster();
				break;

			/* Exit the application. */
			case 0:
				printf("Exit application..\r\n");
				exit(0);
				break;

			/* Invalid choice. */
			default:
				printf("Invalid choice..\r\n");
				break;
		}
	}

	return 0;
}
