/*! \file zigbee_ha.h
    	\brief Header file for interface handler. Provide APIs related to access ZigBee stack.
    	 
    	Provide APIs related to sending request related to HA like On/Off request, getting meter power consumption from device.
*/

#ifndef _ZIGBEE_HA_H_
#define _ZIGBEE_HA_H_


/*! brief Function pointer used for dispalying the status of request whether request is served by device properly. It gives response details got from device for On/Off request or get smart meter reading of power consumption.

	\param IEEE Specifies IEEE address of the device.
	\param EndPoint Specifies endpoint address of the device.
	\param Status It specifies repsponse got from the device. If request successfully served by device then status is success else failure.
	\param Result It specifies power consumption of smart meter.

	\return Returns NULL.
*/
typedef void (*ActionSpecificResponse)(const unsigned long long ieee_addr, const unsigned char endpoint, const unsigned char status, const unsigned int Result); 

/*! brief Send ON / OFF request to HA device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with
  	\param 	ActionToPerform	Either On or Off. 1 for ON and 0 for OFF.
	\param  SpecificResponse It is callback to be invoked once the operation is completed.

	\return It will return
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid parameter. Either IEEE address or callback or action to be performed (API_RETVAL_INVALID_PARAM)
		c. Fail to send request to stack layer (API_RETVAL_STACK_LAYER_FAILURE)
		d. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC).
		e. Successfully sent request to stack layer (API_RETVAL_SUCCESS)
*/
signed char SendOnOffReq(const unsigned long long IEEEAddr, const unsigned char ActionToPerform, const ActionSpecificResponse SpecificResponse); 

/*! brief Send generic custom request packet to device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with
  	\param 	MessageLen	Length of the message to send
  	\param 	Message		Message to send

	\return It will return
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid parameter. Either IEEE address or message length or message (API_RETVAL_INVALID_PARAM)
		c. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC)
		d. Fail to send request to stack layer (API_RETVAL_STACK_LAYER_FAILURE)
		e. Successfully sent request to stack layer (API_RETVAL_SUCCESS)
*/
signed char SendGenReqPkt(const unsigned long long IEEEAddr, const unsigned char MessageLen, const char *Message); 

/*! brief Send generic custom response packet to device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with 
  	\param 	MessageLen	Length of the message to send
  	\param 	Message		Message to send

	\return It will return
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid parameter. Either IEEE address or message length or message (API_RETVAL_INVALID_PARAM)
		c. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC)
		d. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE)
		e. Successfully sent response to stack layer (API_RETVAL_SUCCESS)
*/
signed char SendGenRespPkt(const unsigned long long IEEEAddr, const unsigned char MessageLen, const char *Message); 

/*! brief API used for getting power consumption of smart meter.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with 
	\param  SpecificResponse It is callback to be invoked once the operation is completed.

	\return It will return
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid parameter. Either IEEE address or specific response (API_RETVAL_INVALID_PARAM).
		c. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE).
		d. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC).
		e. Successfully sent response to stack layer (API_RETVAL_SUCCESS).
*/
signed char ReadSmartMeter(const unsigned long long IEEEAddr, const ActionSpecificResponse SpecificResponse); 

/*! brief API used for getting attribute values of basic cluster of a device.
	
  	\param 	IEEEAddr  IEEE address of the device to communicate with.

	\return It will returns
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid parameter (API_RETVAL_INVALID_PARAM).
		c. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC)
		d. Fail to destroyed the network (API_RETVAL_STACK_LAYER_FAILURE)
		e. Successfully sent read basic cluster request (API_RETVAL_SUCCESS)
*/
signed char ReadBasicCluster(const unsigned long long IEEEAddr); 


/*! brief API used for getting attribute values of basic cluster of a device.
	
  	\param 	IEEEAddr  IEEE address of the device to communicate with.

	\return It will returns
		a. Network not created (API_RETVAL_NWK_NOT_FORMED)
		b. Invalid parameter (API_RETVAL_INVALID_PARAM).
		c. Fail to allocate memory to pack message (API_RETVAL_FAIL_TO_MEM_ALLOC)
		d. Fail to destroyed the network (API_RETVAL_STACK_LAYER_FAILURE)
		e. Successfully sent read basic cluster request (API_RETVAL_SUCCESS)
*/
signed char ReadOnOffAttrib(const unsigned long long IEEEAddr);

#endif
