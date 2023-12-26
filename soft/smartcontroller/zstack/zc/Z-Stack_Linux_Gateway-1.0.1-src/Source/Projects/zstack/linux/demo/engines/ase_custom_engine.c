/*******************************************************************************
 * Includes
 ******************************************************************************/
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "data_structures.h"
#include "socket_interface.h"
#include "actions_engine.h"
#include "gateway.pb-c.h"
#include "user_interface.h"
#include "ase_custom_engine.h"
#include "zigbee_internal.h"

/*******************************************************************************
 * Globals
 ******************************************************************************/

/*******************************************************************************
 * Functions
 ******************************************************************************/
void ase_custom_pkt_process(pkt_buf_t *pkt)
{
	printf("LEN, %d, CMDID, %d\r\n", pkt->header.len, pkt->header.cmd_id);
	switch(pkt->header.cmd_id)
	{
		case GW_CMD_ID_T__DEV_SEND_ASE_GEN_REQ:
			{
				void *reqPtr;
				DevSendASEGenReq *reqPkt;
				uint8_t Data[100] = {0};
				//zb_addr_t destAddr;

				//printf("GW_CMD_ID_T__DEV_SEND_ASE_GEN_REQ\r\n");
				reqPtr = dev_send_asegen_req__unpack(NULL, pkt->header.len, pkt->packed_protobuf_packet);

				if ( reqPtr )
				{
					reqPkt = (DevSendASEGenReq *)reqPtr;
					//printf("ase req..\r\n");

					memcpy(Data, reqPkt->apppkt.data, reqPkt->apppkt.len);
					if(reqPkt->dstaddress != NULL)
					//printf("REQ, PKT, ADDR, %x, EP, %u", reqPkt->dstaddress->ieeeaddr, reqPkt->dstaddress->endpointid);
					
					//printf("DATA, %s\r\n", Data);

					/*  Inform to ASE's custom library */
					InformEventToApp(CB_FLAG_ASE_CUSTOM_REQ, pkt, reqPkt);
					dev_send_asegen_req__free_unpacked( reqPtr, NULL ); 


#if 0
					/* Send response temperory */
					{
						unsigned int Length = 0;
						char CmdBuffer[120] = {"Gateway->Device timer response through ASE custom cluster."};

						sprintf(&CmdBuffer[strlen(CmdBuffer)], "%lu", (unsigned long)time(NULL));

						/* Filling default command to send response packet to ASE device through custom cluster. */
						Length = strlen(CmdBuffer);

						destAddr.ieee_addr = reqPkt->dstaddress->ieeeaddr;
						destAddr.endpoint = reqPkt->dstaddress->endpointid;
						destAddr.groupaddr = reqPkt->dstaddress->groupaddr;

						
						/* Sending the packet */
						act_send_ase_gen_resp_pkt(&destAddr, Length, CmdBuffer);
					}
#endif

				}
			}
			break;

		case GW_CMD_ID_T__DEV_SEND_ASE_GEN_RESP:
			{
				void *respPtr;
				DevSendASEGenResp *respPkt;
				uint8_t Data[100] = {0};

				//printf("GW_CMD_ID_T__DEV_SEND_ASE_GEN_RESP\r\n");
				respPtr = dev_send_asegen_resp__unpack(NULL, pkt->header.len, pkt->packed_protobuf_packet);

				if ( respPtr )
				{
					respPkt = (DevSendASEGenResp *)respPtr;
					memcpy(Data, respPkt->apppkt.data, respPkt->apppkt.len);
					if(respPkt->dstaddress != NULL)
					//printf("RESP, PKT, ADDR, %x, EP, %u", respPkt->dstaddress->ieeeaddr, respPkt->dstaddress->endpointid);

					//printf("DATA, %s\r\n", Data);
					
					/*  Inform to ASE's custom library */
					InformEventToApp(CB_FLAG_ASE_CUSTOM_RESP, pkt, respPkt);

					dev_send_asegen_resp__free_unpacked( respPtr, NULL ); 
					
				}
			}
			break;
	}
}

