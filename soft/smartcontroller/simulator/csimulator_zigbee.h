#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>
#include <pthread.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include<inttypes.h>
#include "util/ini.h" 
#include "inc/ASEMPImpl.h"

#define CLIENT_PORT 12345
#define BUFFER_SIZE 1000


#ifndef DEBUG
#define DEBUG
#endif

//-------------------------------Socket Functions--------------------------
int Create ();
int Connect (const char *ipAddr, u_short port);
int IsConnected ();
int Receive (char *buffer, int length);
int Send(char* buffer ,int len);
void ShutDown ();
void *ReceiveThreadProc (void *lpdwThreadParam);
void CreateReceiveThread (int thisSocket);

//-----------------------Inititalizer functions----------------------
int initClient(const char* ip, int port);
void* LedDisplayer(void* arg);
int initializer(char* device_file ,char* Unsoli_file);
int SimulatorThread(RegistrationRequest *);

//-----------------------Read Ini Function---------------------
void* retrieveFromDatabaseFile(char* filename,int type,void* pDevice);

//-----------------------Registration Functions-------------------------
int RegistrationRequest1 (DeviceType deviceType,  int zigbee_hw, int zigbee_fw, int device_hw, int  device_fw, int rssi) ;

//-----------------------unsolicited Functions-------------------------
int UnsolicitedSensorInfoRequest1(UnsolicitedSensorInfoRequest *infoRequest);
void* UnsolicitedReqThreadProc (void* lpdwThreadParam );
void UnsolicitedReqThreadFunc (RegistrationResponse *fregResponse);

//-----------------------Central Command Functions-------------------------
int OnCentralCommandRequest(CentralCommandRequest *commandRequest);

//-----------------------Update Profile Functions-------------------------
int OnUpdateProfileRequest(UpdateProfileRequest *profileRequest);

//-----------------------Remote Status Functions-------------------------
int OnRemoteStatusRequest(RemoteStatusRequest* zedRequest);


void OnMessageReceivedClient(char* buffer ,int len);
