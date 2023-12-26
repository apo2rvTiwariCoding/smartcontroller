/*! \file zigbee_internal.h
    	\brief It provides API used for informing the events that comes from ZigBee layer to application layer.    	 
*/

#ifndef _ZIGBEE_INTERNAL_H_
#define _ZIGBEE_INTERNAL_H_

#include "types.h"
#include "zigbee_ha.h"
#include "zigbee.h"

#define DEVICE_JOIN_DISALLOWED		0
#define DEVICE_JOIN_ALLOWED		1

#define DEVICE_TYPE_COORDINATOR		0		/*!< Flag to indicate that device type that can used for creating the network. It can be coordinatior which forms netwrok or router which joins the network. */

#define DEVICE_TYPE_ROUTER		1		/*!< Flag to indicate that device type that can used for creating the network. It can be coordinatior which forms netwrok or router which joins the network. */

/*! \brief Defines various call back flags used for idebtifying and invoking call back function. */
typedef enum
{
	CB_FLAG_DEVICE_LIST =  1,
	CB_FLAG_DEVICE_INDICATION,
	CB_FLAG_ON_OFF_STATUS,
	CB_FLAG_READ_SMART_METER_STATUS,
	CB_FLAG_ASE_CUSTOM_REQ,
	CB_FLAG_ASE_CUSTOM_RESP,
	CB_FLAG_ATTRIB_READ_RESP,
}CB_FLAGS;

/*! \brief Stores ip address and port of all the servers i.e. network manager server, gateway server and ota server. */
typedef struct ZigBeeParams_ 
{
	char netHost[20];
	int netPort;
	char gatewayHost[20];
	int gatewayPort;
	char otaHost[20];
	int otaPort;
}ZigBeeParam;

/*! \brief Stores call back function to be called to inform event/data to the application. */
typedef struct
{
	NetworkZigBeeDeviceIndCB  CBDeviceInd;
	NetworkZigBeeDeviceListCB CBDeviceList;
	CustomDataReceivedCB CBDataReceive;	
	ActionSpecificResponse CBOnOffStatusInd;
}RegisterCB; 

/*! brief To inform event that comes from ZStack to application layer..

  	\param 	CBFlag 	Flag to identify and invoke registered call back function.
	\param	Info	Specify the information/ event details that to be inform to application layer.
	\param	ExtraData Specify the data that to be inform to application layer.

	\return It will return 
		a. Already initialized
		b. Fail to create socket thread 
		c. Fail to open configuration file to read configuration of socket
		d. Network ready
*/
extern unsigned int InformEventToApp(unsigned char CBFlag, void *Info, void *ExtraData);

#endif
