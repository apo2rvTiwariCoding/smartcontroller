/*! \file zigbee_ha.h
    	\brief Header file for interface handler. Provide APIs related to access ZigBee stack.
    	 
    	Provide APIs related to sending request related to HA like On/Off request, getting meter power consumption from device.
*/

#ifndef _ZIGBEE_HA_H_
#define _ZIGBEE_HA_H_


typedef void (*ActionSpecificResponse)(unsigned long long ieee_addr, unsigned char endpoint, unsigned char status, unsigned int Result); /*!< Function pointer used to give status On / Off request sent to HA devices. */

/*! brief Send ON / OFF request to HA device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with
  	\param 	ActionToPerform	Either On or Off. 1 for ON and 0 for OFF.
	\param  SpecificResponse It is callback to be invoked once the operation is completed.

	\return It will return
		a. Invalid parameter. Either IEEE address or end point or action to be performed (API_RETVAL_INVALID_PARAM)
		b. Successfully sent request to stack layer (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to send request to stack layer (API_RETVAL_STACK_LAYER_FAILURE)
*/
signed char SendOnOffReq(unsigned long long IEEEAddr, unsigned char ActionToPerform, ActionSpecificResponse SpecificResponse);

/*! brief Send generic custom request packet to device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with
  	\param 	MessageLen	Length of the message to send
  	\param 	Message		Message to send

	\return It will return
		a. Invalid parameter. Either IEEE address or end point or action to be performed (API_RETVAL_INVALID_PARAM)
		b. Successfully sent request to stack layer (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to send request to stack layer (API_RETVAL_STACK_LAYER_FAILURE)
*/
signed char SendGenReqPkt(unsigned long long IEEEAddr, unsigned char MessageLen, char *Message);

/*! brief Send generic custom response packet to device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with 
  	\param 	MessageLen	Length of the message to send
  	\param 	Message		Message to send

	\return It will return
		a. Invalid parameter. Either IEEE address or end point or action to be performed (API_RETVAL_INVALID_PARAM)
		b. Successfully sent response to stack layer (API_RETVAL_STACK_LAYER_SUCCESS)
		c. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE)
*/
signed char SendGenRespPkt(unsigned long long IEEEAddr, unsigned char MessageLen, char *Message);

/*! brief API used for getting power consumption of smart meter.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with 
	\param  SpecificResponse It is callback to be invoked once the operation is completed.

	\return It will return
		a. Invalid parameter. Either IEEE address or end point (API_RETVAL_INVALID_PARAM).
		b. Successfully sent response to stack layer (API_RETVAL_STACK_LAYER_SUCCESS).
		c. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE).
*/
signed char ReadSmartMeter(unsigned long long IEEEAddr, ActionSpecificResponse SpecificResponse);

/*! brief API used for getting attribute values of basic cluster of a device.
	
  	\param 	IEEEAddr 	IEEE address of the device to communicate with.

	\return It will returns
		a. Invalid parameter. (API_RETVAL_INVALID_PARAM).
		b. Successfully sent response to stack layer (API_RETVAL_STACK_LAYER_SUCCESS).
		c. Fail to send response to stack layer (API_RETVAL_STACK_LAYER_FAILURE).
*/
signed char ReadBasicCluster(unsigned long long IEEEAddr);

#endif
