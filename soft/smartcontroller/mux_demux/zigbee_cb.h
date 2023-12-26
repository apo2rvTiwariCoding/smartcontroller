/**
 * @brief ZigBee servers asynchronous callback handlers.
 */

#ifndef FILE_MUX_DEMUX_ZIGBEE_CB_H
#define FILE_MUX_DEMUX_ZIGBEE_CB_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "zigbee/types.h"


/**
 * @see NetworkZigBeeDeviceIndCB
 */
void OnJoinLeaveDeviceInd(const device_info_t* device_info);

/**
 * @see CustomDataReceivedCB
 */
int OnAseDataReceived(unsigned short nwk_addr,
        unsigned short end_point, unsigned short device_id,
        unsigned short cluster_id, unsigned char is_req_flag,
        const char *message, unsigned char message_len,
        unsigned long long ieee_addr);

/**
 * @brief Called by zigbee sync. as the join has been disallowed.
 */
void OnDisallowJoin();

#endif // #ifndef FILE_MUX_DEMUX_ZIGBEE_CB_H
