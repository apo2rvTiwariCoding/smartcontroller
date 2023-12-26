/*
 * zed_emulation.h
 *
 *  Created on: Dec 4, 2014
 *      Author: user
 */

#ifndef FILE_MUX_DEMUX_ZED_EMULATION_H
#define FILE_MUX_DEMUX_ZED_EMULATION_H

#include "inc/ASEMPImpl.h"
#include "net/tcp_socket_mux.h"
#include "db/MuxDemuxDb.h"


//#define EMULATOR
#ifdef EMULATOR

int init_serverMux(int port);
//--------------------------Muxdemux  - Zed functions -------------------------------------


//------------------------Registration Functions------------------------------------------
int RegistrationResponse1(CTcpClientMux* Client,int deviceID,RegistrationResponse *regResponse);
int OnRegistrationRequest (CTcpClientMux* pClient,DeviceType deviceID,int zigbeeHardwareVersion,
                                   int zigbeeFirmwareVersion,int ASEHardwareVersion,
                                   int ASEFirmwareVersion, int Remote_RSSI);

//------------------------Unsolicited Message Functions--------------------------------------
int OnUnsolicitedSensorInfoRequest (CTcpClientMux* pClient,int deviceID,UnsolicitedSensorInfoRequest* infoRequest);
int UnsolicitedSensorInfoResponse1(CTcpClientMux* pClient,string srcAddr,int deviceID, UnsolicitedSensorInfoResponse *infoResponse);

//------------------------Central Command Functions ------------------------------------------
int CentralCommandRequest1(CTcpClientMux* pClient,int deviceID,CentralCommandRequest *commandRequest);
int OnCentralCommandResponse(CentralCommandResponse *pCommandResponse);

//------------------------Update Profile Functions--------------------------------------------
int UpdateProfileRequest1(CTcpClientMux* pClient,int deviceID,UpdateProfileRequest *UprofileReq);
int OnUpdateProfileResponse(UpdateProfileResponse *pProfileResponse);

//------------------------Remote Status Functions --------------------------------------------
int RemoteStatusRequest1(int deviceID);
int OnRemoteStatusResponse(CTcpClientMux* pClient,RemoteStatusResponse* ZedResponse);


int profile_fetcher(int deviceID,ASEMProfile *pdata);

#endif

#endif /* FILE_MUX_DEMUX_ZED_EMULATION_H */
