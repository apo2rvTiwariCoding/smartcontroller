/*
 * zed_emulation.cpp
 *
 *  Created on: Dec 4, 2014
 *      Author: user
 */

#include <iostream>
#include "mux_demux/zed_emulation.h"
#include "net/tcp_client_mux.h"
#include "inc/ZigbeeTypes.h"
#include "util/log/log.h"


CTcpSocketMux *serverSocket1;

#ifdef EMULATOR
void
OnMessageReceivedServerMux (void* pClient,char *data, int size)
{

    if(strncmp(data,"NOTIFY",6)==0)
    {
        fprintf(stderr,"\n");
    }
    else
    {
        CTcpClientMux *Client = (CTcpClientMux*) pClient;
        fprintf (stderr,"\nBytes of data Recieved=%d  \n", size);
        if (size != 0 && size != -1)
        {
            ASEMPMessage *ASEMPmsg = (ASEMPMessage *) data;
            fprintf (stderr, "Protocol id ----:%d\n", ASEMPmsg->protocolID);
            if (ASEMPmsg->protocolID == 0X01)
            {

                RegistrationRequest *regRequest =(RegistrationRequest *) data;
                std::cout<<regRequest->deviceType<<regRequest->zigbeeHardwareVersion<<regRequest->zigbeeFirmwareVersion<<regRequest->ASEHardwareVersion<<regRequest->ASEFirmwareVersion<<regRequest->Remote_RSSI<<"\n";
                OnRegistrationRequest(Client,regRequest->deviceType,
                regRequest->zigbeeHardwareVersion,
                regRequest->zigbeeFirmwareVersion,
                regRequest->ASEHardwareVersion,
                regRequest->ASEFirmwareVersion,
                regRequest->Remote_RSSI);

            }
            else if (ASEMPmsg->protocolID == 0X02)
            {
                UnsolicitedSensorInfoRequest *unSoliRequest =
                (UnsolicitedSensorInfoRequest *) data;
                fprintf(stderr,"pir : %d\n", unSoliRequest->pir);
                std::cout <<"cause : " <<unSoliRequest->cause;
                std::cout << "min_temp :" << unSoliRequest->min_temp << "\n";
                std::cout << "avg_temp :" << unSoliRequest->avg_temp << "\n";
                std::cout << "max_temp :" << unSoliRequest->max_temp << "\n";
                std::cout << "min_hum : " << unSoliRequest->min_hum << "\n";
                std::cout << "avg_hum : " << unSoliRequest->avg_hum << "\n";
                std::cout << "max_hum : " << unSoliRequest->max_hum << "\n";
                std::cout << "min_lux : " << unSoliRequest->min_lux << "\n";
                std::cout << "max_lux : " << unSoliRequest->max_lux << "\n";
                std::cout <<"battery : " <<unSoliRequest->battery<< "\n";
                std::cout <<"Remote_RSSI : " <<unSoliRequest->Remote_RSSI<< "\n";
                std::cout <<"ac_current : " <<unSoliRequest->ac_current<< "\n";
                std::cout <<"coMax : " <<unSoliRequest->coMax<< "\n";
                std::cout <<"coAvg : " <<unSoliRequest->coAvg<< "\n";
                std::cout <<"coMin : " <<unSoliRequest->coMin<< "\n";
                std::cout <<"co2Max : " <<unSoliRequest->co2Max<< "\n";
                std::cout <<"co2Avg : " <<unSoliRequest->co2Avg<< "\n";
                std::cout <<"co2Min : " <<unSoliRequest->co2Min<< "\n";
                std::cout <<"remoteAck : " <<unSoliRequest->remoteAck<< "\n";

                OnUnsolicitedSensorInfoRequest (Client,unSoliRequest->deviceType,unSoliRequest);
            }
            else if (ASEMPmsg->protocolID == 0X03) // this is CentralCommand response
            {
                CentralCommandResponse *commandResponse = (CentralCommandResponse* )data;
                fprintf(stderr , "Ack : %d \n",commandResponse->ack );
                fprintf(stderr , "protocolID : %d \n",commandResponse->ASEMPMobj.protocolID );
                fprintf(stderr , "Remote-RSSI : %d \n",commandResponse->Remote_RSSI );
                fprintf(stderr , "msgCount : %d \n",commandResponse->ASEMPMobj.msgCount );
                fprintf(stderr , "deviceID : %d \n",commandResponse->deviceID );
                OnCentralCommandResponse(commandResponse);

            }
            else if (ASEMPmsg->protocolID == 0X04) // this is update profile response
            {
                UpdateProfileResponse *profileResponse = (UpdateProfileResponse* )data;
                fprintf(stderr , "Ack : %d \n",profileResponse->ack );
                fprintf(stderr , "protocolID : %d \n",profileResponse->ASEMPMobj.protocolID );
                fprintf(stderr , "Remote-RSSI : %d \n",profileResponse->Remote_RSSI );
                fprintf(stderr , "msgCount : %d \n",profileResponse->ASEMPMobj.msgCount );
                OnUpdateProfileResponse(profileResponse);
            }
            else if (ASEMPmsg->protocolID == 0X05) // this is PING response
            {

            }
            else if (ASEMPmsg->protocolID == 0X06) // this is Remote Device response
            {
                RemoteStatusResponse *zedResponse = (RemoteStatusResponse* )data;
                fprintf(stderr , "Ack : %d \n",zedResponse->ack );
                fprintf(stderr , "protocolID : %d \n",zedResponse->ASEMPMobj.protocolID );
                //OnRemoteStatusResponse(Client,zedResponse);
            }

        }
        else if (size == -1 || size == 0)
        {
            //Disconnected from client
            fprintf (stderr, "Disconnected from client: size=%d\n", size);
            Client->SetConnection (0);
        }
    }
}

/*------------- ping device function start--------------------------*/
int ping_remote_Device(int deviceID)
{
    fprintf (stderr, "In %s\n",__func__);
    string zaddr64;
    //int Addr16 ;                  //see Addr to be used or not ??
    int sent_bytes;
    CZigbeeDevice *pZDev = CZigbeeDevice::getInstance ();
    if (pZDev == NULL)
    {
        fprintf (stderr, "CZigbeeDevice ==Can not be created");
        return -1;
    }

    printf ("Getting data from ZigbeeDevice Table\n");
    pZDev->retrieve (deviceID);

    printf ("Xbee 64 BitAddr= %s\n",pZDev->getXbeeAddr64 ().c_str ());
    zaddr64 = pZDev->getXbeeAddr64();
    //Addr16=atoi(zaddr64.c_str());
    CTcpClientMux* Client = serverSocket1->GetClientFromSocket (atoi(zaddr64.c_str()));
    if(Client == NULL)
    {
        fprintf(stderr,"Client received from connection pool is NULL \n");
        return -1;
    }
    ASEMPMessage ASEMPMObj;
    ASEMPMObj.protocolID = 0xF5;
    fprintf(stderr,"Sending ping request to fd : %d\n",atoi(zaddr64.c_str()));
    sent_bytes = Client->Send ((char *)&ASEMPMObj, sizeof (ASEMPMessage));
    //sent_bytes = send (atoi(zaddr64.c_str()), (char *)&ASEMPMObj , sizeof (ASEMPMessage), 0);
    fprintf (stderr , "Sent  Ping Request : ------ :%d\n", sent_bytes);
    fprintf (stderr, "Out %s\n",__func__);
    return 0;
}
/*------------- ping device function end--------------------------------------*/
/*-----------Unregister Zigbee  Functions start--------------------------------*/
int UnregisterRemoteDevice(int deviceID)
{
    fprintf (stderr, "In %s\n",__func__);
    string zaddr64;
    int Addr16 ;                    //see Addr to be used or not ??
    //int sent_bytes;
    CZigbeeDevice *pZDev = CZigbeeDevice::getInstance ();
    if (pZDev == NULL)
    {
        LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
        //fprintf (stderr, "CZigbeeDevice ==Can not be created");
        return -1;
    }

    printf ("Getting data from ZigbeeDevice Table\n");
    pZDev->retrieve (deviceID);

    printf ("Xbee 64 BitAddr= %s\n",pZDev->getXbeeAddr64 ().c_str ());
    zaddr64 = pZDev->getXbeeAddr64();
    Addr16=atoi(zaddr64.c_str());
    CTcpClientMux* Client = serverSocket1->GetClientFromSocket (atoi(zaddr64.c_str()));
    if(Client == NULL)
    {
        LOG_WARN("server", "Client received from connection pool is NULL");
        //fprintf(stderr,"Client received from connection pool is NULL \n");
        return -1;
    }
    fprintf (stderr, "Shutdown request sent to client :%d",Client->connectedSocket);
    Client->ShutDown ();

    fprintf (stderr, "Out %s\n",__func__);
    return 0;
}

/*-----------Unregister Zigbee  Functions End--------------------------------*/

/*-----------RemoteStatus Functions start-------------------------------------*/
int RemoteStatusRequest1(int deviceID)
{
    fprintf (stderr, "In %s\n",__func__);
    string zaddr64,zedaddr;
    //int Addr16 ;      //see addr to be used or not
    int sent_bytes;
    CZigbeeDevice *pZDev = CZigbeeDevice::getInstance ();
    if (pZDev == NULL)
    {
        LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
        fprintf (stderr, "CZigbeeDevice Can not be created");
        return -1;
    }

    printf ("Getting data from ZigbeeDevice Table\n");
    pZDev->retrieve (deviceID);

    printf ("Xbee 64 BitAddr= %s\n",pZDev->getXbeeAddr64 ().c_str ());
    zaddr64 = pZDev->getXbeeAddr64();
    //Addr16=atoi(zaddr64.c_str());
    CTcpClientMux* Client = serverSocket1->GetClientFromSocket (atoi(zaddr64.c_str()));
    if(Client == NULL)
    {
        LOG_ERROR("server", "Client received from connection pool is NULL");
        //fprintf(stderr,"Client received from connection pool is NULL \n");
        return -1;
    }
    RemoteStatusRequest ZedStatus;
    CZedDev *pZedDev = CZedDev::getInstance ();
    if (pZedDev == NULL)
    {
        LOG_ERROR("server", "CZedDev returned a NULL pointer");
        //fprintf (stderr, "CZedDev Can not be created");
        return -1;
    }
    pZedDev->retrieve (deviceID);
    ZedStatus.ASEMPMobj.protocolID = 0xF6;

    ZedStatus.Status = pZedDev->getStatus(); // currently setting it to enable the device // but this value should be retrieved from DB
    zedaddr =  pZedDev->getAddr();
    fprintf(stderr,"ZedStatus.Status : %d\n",ZedStatus.Status);
    fprintf(stderr,"zedaddr : %s\n",zedaddr.c_str());
    fprintf(stderr,"Sending ZED ENABLE request to fd : %d\n",atoi(zaddr64.c_str()));
    sent_bytes = Client->Send ((char *)&ZedStatus, sizeof (RemoteStatusRequest));
    //sent_bytes = send (atoi(zaddr64.c_str()), (char *)&ASEMPMObj , sizeof (ASEMPMessage), 0);
    fprintf (stderr , "Sent  ZED ENABLE request : ------ :%d\n", sent_bytes);
    fprintf (stderr, "Out %s\n",__func__);
    return 0;

}

int OnRemoteStatusResponse ( CTcpClientMux * pClient , RemoteStatusResponse * ZedResponse)
{
    fprintf (stderr, "In %s\n",__func__);
    //int Addr16 ;              // setting as fd
    string zaddr64;             // setting as fd
    char desc[10];

    zaddr64 = to_string(pClient->connectedSocket);
    //Addr16=pClient->connectedSocket;

    memset(desc,0,strlen(desc));
    CZigbeeAlarm *ptr = CZigbeeAlarm::getInstance();
    if (ptr == NULL)
    {
        LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
        //fprintf (stderr, "CZigbeeAlarm Can not be created");
        return -1;
    }
    strcpy(desc,"ok");
    sprintf(desc+strlen("ok"),"%d",ZedResponse->ack);
    printf("Inserting into ZigbeeAlarm Table for OnRemoteStatusResponse\n");
    //ptr->insert(deviceID, zaddr64.c_str(),Addr16 ,19, 0,0x38,desc); //Command ID UNKNOWN YET //DEVICE ID SHOULD BE ADDED TO STRUCTURE
    fprintf (stderr, "Out %s\n",__func__);
    return 0;
}

/*-----------RemoteStatus Functions end-------------------------------------*/

/*-----------UpdateProfile Functions start-------------------------------------*/
int UpdateProfileRequest1(CTcpClientMux* pClient,int deviceID,UpdateProfileRequest *UprofileReq)
{

    int asemp ,sent_bytes,Addr16;
    string zaddr64;
    fprintf (stderr, "In %s\n",__func__);
    CZigbeeDevice *pZDev = CZigbeeDevice::getInstance();
    if (pZDev == NULL)
    {
        LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
        //fprintf (stderr, "CZigbeeDevice Can not be created\n");
        return -1;
    }
    pZDev->retrieveAddr64(deviceID);
    zaddr64 = pZDev->getXbeeAddr64();
    Addr16=atoi(zaddr64.c_str());
    asemp = profile_fetcher(deviceID,&UprofileReq->ASEMProObj);
    if(asemp == -1)
    {
        LOG_ERROR_FMT("server", "Profile Fetching Error in Update Profile Request for :%d \n",atoi(zaddr64.c_str()));
        //fprintf(stderr,"Profile Fetching Error in Update Profile Request for :%d \n",atoi(zaddr64.c_str()));
    }
    UprofileReq->ASEMProObj.ASEMPMobj.protocolID = 0XF4;
    UprofileReq->deviceID = deviceID;
    fprintf(stderr,"Sending UpdateProfileRequest \n");
        /*Update profile request command use to set new ASEMP profile to device
        and sent by Smart controller
        """""in response"" to a change in the ASE remote device ASEMP profile parameters"""*/

        /*Depending on remote acknowledgement mode and status @ack variable set to :
            0 = remote acknowledgement was requested but not received,
            1 = remote acknowledgement was requested and successfully received.*/
    pClient = serverSocket1->GetClientFromSocket (atoi(zaddr64.c_str()));
    if(pClient == NULL)
    {
        LOG_ERROR("server", "Client received from connection pool is NULL");
        fprintf(stderr,"Client received from connection pool is NULL  in UpdateProfileRequest \n");
        return -1;
    }

    //sent_bytes = send (atoi(zaddr64.c_str()), (char *) UprofileReq, sizeof (UpdateProfileRequest),0);
    sent_bytes = pClient->Send ((char *) UprofileReq, sizeof (UpdateProfileRequest));
    if (sent_bytes<=0)
    {
        CZigbeeAlarm *ptr = CZigbeeAlarm::getInstance();
        if (ptr == NULL)
        {
            LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
            fprintf (stderr, "CZigbeeAlarm Can not be created");
            return -1;
        }
        fprintf(stderr,"Inserting into ZigbeeAlarm Table for Central Command request sending failiure\n");
        ptr->insert(deviceID, zaddr64.c_str(),Addr16 ,19, 1,0x56, "error");
    }
    else
    {
        int ack = 1 ;       //to be decided by some request received from ASE dev
        char desc[10];
        CZigbeeAlarm *pZAlarm = CZigbeeAlarm::getInstance();
        if (pZAlarm == NULL)
        {
            LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
            fprintf (stderr, "CZigbeeAlarm Can not be created");
            return -1;
        }
        memset(desc,0,strlen(desc));
        strcpy(desc,"ok");
        sprintf(desc+strlen("ok"),"%d",ack); // currently ack is set to 1 as some request received ,decides this ack
        printf("Inserting into ZigbeeAlarm Table for Update Profile Request sending Success \n");
        pZAlarm->insert(deviceID, zaddr64.c_str(),Addr16 ,19, 0,0x56,desc);
    }

    fprintf (stderr , "Sent UpdateProfileRequest :%d\n", sent_bytes);
    fprintf (stderr, "Out %s\n",__func__);
    return 0;

}


int OnUpdateProfileResponse(UpdateProfileResponse *pProfileResponse)
{
    fprintf (stderr, "In %s\n",__func__);
    int Addr16 ;                // setting as fd
    string zaddr64;             // setting as fd
    char desc[10];
    memset(desc,0,strlen(desc));


    strcpy(desc,"ok");
    sprintf(desc,"%d",pProfileResponse->ack);
    CZigbeeDevice *pZDev = CZigbeeDevice::getInstance();
    if (pZDev == NULL)
    {
        LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
        fprintf (stderr, "CZigbeeDevice Can not be created in Update profile response\n");
        return -1;
    }
    pZDev->retrieveAddr64( pProfileResponse->deviceID );
    zaddr64 = pZDev->getXbeeAddr64();
    Addr16=atoi(zaddr64.c_str());

    CZigbeeAlarm *pZAlaram = CZigbeeAlarm::getInstance();       //issue in conditioning
    if (pZAlaram == NULL)
    {
        LOG_ERROR("server", "CDeviceRegistration returned a NULL pointer");
        fprintf (stderr, "CDeviceiRegistration Can not be created");
        return -1;
    }
    fprintf(stderr,"Inserting into ZigbeeAlarm Table\n");

    //int CZigbeeAlarm::insert(int deviceId,  string addr64, int addr16, int alarmType, int severity, int commandCode, string desc)
    pZAlaram->insert(pProfileResponse->deviceID, zaddr64,Addr16 ,19, 0,0x56, desc);//confusion in addr 16 from it is getting passed ? how can i pass it??
    fprintf (stderr, "Out %s\n",__func__);
    return 0;
}

/*-----------UpdateProfile Functions end-------------------------------------*/

/*-----------Central Command Functions start-------------------------------------*/

int CentralCommandRequest1(CTcpClientMux* pClient,int deviceID  ,CentralCommandRequest *commandRequest)
{

    int sent_bytes,Addr16;
    string zaddr64;
    fprintf (stderr, "In %s\n",__func__);
    commandRequest->ASEMPMobj.protocolID = 0XF3;
    commandRequest->deviceID = deviceID;
    CZigbeeDevice *ptr = CZigbeeDevice::getInstance();
    if (ptr == NULL)
    {
        LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
        fprintf (stderr, "CZigbeeDevice Can not be created\n");
        return -1;
    }
    ptr->retrieveAddr64( deviceID);
    zaddr64 = ptr->getXbeeAddr64();
    Addr16=atoi(zaddr64.c_str());
    pClient = serverSocket1->GetClientFromSocket (atoi(zaddr64.c_str()));
    if(pClient == NULL)
    {
        LOG_ERROR("server", "Client received from connection pool is NULL");
        fprintf(stderr,"Client received from connection pool is NULL  in CentralCommandRequest \n");
        return -1;
    }
    sent_bytes = pClient->Send ((char *) commandRequest, sizeof (CentralCommandRequest));
    //sent_bytes = send (atoi(zaddr64.c_str()), (char *) commandRequest, sizeof (CentralCommandRequest),0);
    if (sent_bytes<=0)
    {
        CZigbeeAlarm *pZAlarm = CZigbeeAlarm::getInstance();
        if (pZAlarm == NULL)
        {
            LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
            fprintf (stderr, "CZigbeeAlarm Can not be created");
            return -1;
        }

        fprintf(stderr,"Inserting into ZigbeeAlarm Table for Central Command request sending failiure\n");
        pZAlarm->insert(deviceID, zaddr64.c_str(),Addr16 ,19, 1,0x52, "error");
    }
    else
    {
        char desc[10];
        memset(desc,0,strlen(desc));
        CZigbeeAlarm *ptr = CZigbeeAlarm::getInstance();
        if (ptr == NULL)
        {
            LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
            fprintf (stderr, "CZigbeeAlarm Can not be created");
            return -1;
        }
        strcpy(desc,"ok");
        sprintf(desc+strlen("ok"),"%d",commandRequest->ack_requester);
        printf("Inserting into ZigbeeAlarm Table for Central Command request sending Success - bytes Sent : %d\n",sent_bytes);
        ptr->insert(deviceID, zaddr64.c_str(),Addr16 ,19, 0,0x52,desc);
    }
    fprintf (stderr,"Sent CentralCommandRequest bytes :%d to fd :%d\n", sent_bytes,atoi(zaddr64.c_str()));
    fprintf (stderr, "Out %s\n",__func__);
    return 0;
}

int OnCentralCommandResponse(CentralCommandResponse *pCommandResponse)
{
    string zaddr64;
    int Addr16=0;               // currently set as fd
    char desc[10];
    fprintf (stderr, "In %s\n",__func__);
    memset(desc,0,strlen(desc));
    CZigbeeAlarm *pZAlarm = CZigbeeAlarm::getInstance();        //issue in conditioning
    if (pZAlarm == NULL)
    {
        LOG_ERROR("server", "CDeviceRegistration returned a NULL pointer");
        fprintf (stderr, "CDeviceiRegistration Can not be created");
        return -1;
    }
    fprintf(stderr,"Inserting into ZigbeeAlarm Table\n");
    strcpy(desc,"ok");
    sprintf(desc+strlen("ok"),"%d",pCommandResponse->ack);
    CZigbeeDevice *pZDev = CZigbeeDevice::getInstance();
    if (pZDev == NULL)
    {
        LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
        fprintf (stderr, "CZigbeeDevice Can not be created\n");
        return -1;
    }
    pZDev->retrieveAddr64( pCommandResponse->deviceID );
    zaddr64 = pZDev->getXbeeAddr64();
    Addr16=atoi(zaddr64.c_str());
    pZAlarm->insert(pCommandResponse->deviceID, zaddr64,Addr16 ,19, 0,0x52, desc);
    fprintf (stderr, "Out %s\n",__func__);
    return 0;
}



/*-----------Central Command Functions end-------------------------------------*/
/*-----------unsolicited Request Functions starts-------------------------------------*/
int OnUnsolicitedSensorInfoRequest (CTcpClientMux* pClient,int deviceID,UnsolicitedSensorInfoRequest *
                        infoRequest)
{


    int reportType = 0 ;
    int ret;
    string srcAddr="balpreet";//currently this is unknown to me
    fprintf (stderr, "In %s\n",__func__);
    CSensorsdyn *ptr = CSensorsdyn::getInstance ();
    if (ptr == NULL)
    {
        LOG_ERROR("server", "CSensorsdyn returned a NULL pointer");
        fprintf (stderr, "CSensorsdyn Can not be created");
        return -1;
    }

    CSensorsdyn::getInstance ()->insert (reportType, infoRequest->deviceType,infoRequest->max_temp,
        infoRequest->min_temp,infoRequest->avg_temp,infoRequest->max_hum,infoRequest->min_hum,
        infoRequest->avg_hum,infoRequest->max_lux,infoRequest->min_lux,infoRequest->coMax,
        infoRequest->coMin,infoRequest->coAvg,infoRequest->co2Max,infoRequest->co2Min,
        infoRequest->co2Avg,infoRequest->pir,infoRequest->Remote_RSSI,
        infoRequest->battery,infoRequest->remoteAck);
    fprintf (stderr, "written in db CSensorsdyn\n");

    /*this part should be called by upper layer on notification into DB
    device id should be passed through upper layer */
    UnsolicitedSensorInfoResponse* infoResponse=new UnsolicitedSensorInfoResponse ();
    ret=UnsolicitedSensorInfoResponse1(pClient,srcAddr, infoRequest->deviceType,infoResponse);
    if(ret == -1)
    {
        LOG_ERROR_FMT("server", "UnsolicitedSensorInfoResponse1 returned with status: %d", ret);
        fprintf(stderr,"IGNORE: UnsolicitedSensorInfoResponse1 returned with status :%d \n",ret);
    }
    delete infoResponse;
    return 0;

}
int UnsolicitedSensorInfoResponse1(CTcpClientMux* pClient,string srcAddr, int deviceID, UnsolicitedSensorInfoResponse *infoResponse)
{
    int asemp ,sent_bytes;
    fprintf (stderr, "In %s\n",__func__);
    infoResponse->ASEMProObj.ASEMPMobj.protocolID = 0XF2;
    asemp = profile_fetcher(deviceID,(ASEMProfile*)infoResponse);
    fprintf(stderr,"Sending Unsolicited infoResponse to fd : %d\n",pClient->connectedSocket);
    sent_bytes = pClient->Send ((char *) infoResponse, sizeof (UnsolicitedSensorInfoResponse));

    fprintf (stderr , "Sent Unsolicited infoResponse :%d\n", sent_bytes);
    fprintf (stderr, "Out %s\n",__func__);
    return asemp;
}

/*-----------unsolicited Request Functions ends-------------------------------------*/

/*-----------Registration Request Functions starts-------------------------------------*/
int OnRegistrationRequest (CTcpClientMux* pClient,DeviceType deviceType,
                   int zigbeeHardwareVersion,
                   int zigbeeFirmwareVersion,
                   int ASEHardwareVersion,
                   int ASEFirmwareVersion, int Remote_RSSI)
{
    fprintf(stderr,"received deviceType:%d and pClient->connectedSocket:%d\n",deviceType,pClient->connectedSocket);
                                    //currently we are using deviceType as device ID passed from the client
    char *srcAddr = new char[sizeof(int)];
    sprintf(srcAddr,"%d",pClient->connectedSocket); //ASSIGNING socket file descriptor to SRCADDR
    int status=0;
    int Addr16 =pClient->connectedSocket;   // ???????????????
    int eventtype = 1; // ?????????????? as mentioned in example in command and queries
    CSettings *pCSetting = CSettings::getInstance ();
    if (pCSetting == NULL)
    {
        LOG_ERROR("server", "CSettings returned a NULL pointer");
        fprintf (stderr, "CSettings Can not be created");
        return -1;
    }
    pCSetting->retrieve();
    fprintf(stderr, " registration mode : %d \n",pCSetting->getValue());
    if (pCSetting->getValue() ==0) //disabled mode
    {

        fprintf(stderr, " registration mode : DISABLED \n");
        fprintf (stderr, "Shutdown request sent to client :%d",pClient->connectedSocket);
        pClient->ShutDown ();
    }
    else if (pCSetting->getValue() ==1 || pCSetting->getValue() ==2)
    {

        CDeviceRegistration *pDevReg = CDeviceRegistration::getInstance ();
        if (pDevReg == NULL)
        {
            LOG_ERROR("server", "CDeviceRegistration returned a NULL pointer");
            fprintf (stderr, "CDeviceiRegistration Can not be created");
            return -1;
        }

        pDevReg->insert (eventtype, deviceType,
                (int) zigbeeHardwareVersion,
                (int) zigbeeFirmwareVersion,
                (int) ASEHardwareVersion,
                (int) ASEFirmwareVersion,
                Remote_RSSI, status,string(srcAddr));
        fprintf (stderr, "written in db CDeviceRegistration\n");
        /*INSERT INTO registrations (id, updated, event_type, device_type, zigbee_addr64, device_id, zone_id, status, asemp_id) VALUES (NULL, NOW(), 1, @device_type, '@addr64', @device_id, @zone_id, 2, @asemp);
        INSERT INTO alarms_zigbee (id, updated, device_id, type_, severity, description) VALUES (NULL, NOW(), @device_id, 19, 1, '0x50 OK : 1');*/
        //this is to be considered ????? which registration is going to happen


        if (pCSetting->getValue() ==1)      //adhoc mode
        {
            /*RegistrationResponse *regResponse = new RegistrationResponse ();
            fprintf(stderr,"passed deviceType :%d\n",deviceType);
            status = RegistrationResponse1 (pClient,deviceType,regResponse);
            delete regResponse;*/
        }

    }
                // when there is should be no registration .. ANy alarm should be generated ???
    if(0)
    {
        CZigbeeAlarm *ptr = CZigbeeAlarm::getInstance();
        if (ptr == NULL)
        {
            LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
            fprintf (stderr, "CZigbeeAlarm Can not be created");
            return -1;
        }

        printf("Inserting into ZigbeeAlarm Table\n");
        //int CZigbeeAlarm::insert(int deviceId,  string addr64, int addr16, int alarmType, int severity, int commandCode, string desc)
        CZigbeeAlarm::getInstance()->insert(deviceType, srcAddr,Addr16 ,19, 2,0x50, "error");//confusion in addr 16 from it is getting passed ? how can i pass it??
        //else if
        //insert(int eventType, int deviceID, int zigbee_hw, int zigbee_fw, int rssi, int status)
    }
    return 0;
}

int RegistrationResponse1 (CTcpClientMux* Client,int deviceID,RegistrationResponse * regResponse)
{
    //How to check whther request is accepted or rejected by WEBUI??????????????

    string zaddr64;
    int Addr16;
    fprintf (stderr, "In %s\n",__func__);
    int status ,sent_bytes;
    CZigbeeDevice *ptr = CZigbeeDevice::getInstance();
    if (ptr == NULL)
    {
        fprintf (stderr, "CZigbeeDevice Can not be created\n");
        return -1;
    }
    ptr->retrieveAddr64( deviceID);
    zaddr64 = ptr->getXbeeAddr64();
    Addr16=atoi(zaddr64.c_str());
    fprintf(stderr,"Address : %d for device ID :%d\n",Addr16,deviceID);
    Client = serverSocket1->GetClientFromSocket (atoi(zaddr64.c_str()));
    if(Client == NULL)
    {
        LOG_ERROR("server", "Client received from connection pool is NULL");
        fprintf(stderr,"Client received from connection pool is NULL \n");
        return -1;
    }
    CDeviceRegistration *pDevReg = CDeviceRegistration::getInstance ();
    if (pDevReg == NULL)
    {
        LOG_ERROR("server", "CDeviceRegistration returned a NULL pointer");
        fprintf (stderr, "CDeviceiRegistration Can not be created");
        return -1;
    }
    pDevReg->retrieveStatus(zaddr64);
    if (pDevReg->getStatus() == 3) // request is rejected from the upper end
    {
        LOG_INFO("server", "Registration rejected by user");
        fprintf(stderr, "Registration rejected by the User \n");
        fprintf (stderr, "Shut down request sent to client :%d",Client->connectedSocket);
        Client->ShutDown ();
        return 0;
    }

    regResponse->ASEMProObj.ASEMPMobj.protocolID = 0XF1;
    status = profile_fetcher(deviceID,(ASEMProfile*)regResponse);
    if(status == -1)
    {
        LOG_INFO_FMT("server", "profile_fetcher in RegistrationResponse1 returned with status: %d", status);
        fprintf(stderr,"IGNORE: profile_fetcher in RegistrationResponse1 returned with status :%d \n",status);
    }

    fprintf(stderr,"Sending regResponse to fd : %d\n",atoi(zaddr64.c_str()));
    //sent_bytes = send (atoi(zaddr64.c_str()), (char *) regResponse, sizeof (RegistrationResponse), 0);
    sent_bytes = Client->Send ((char *) regResponse, sizeof (RegistrationResponse));

    if(sent_bytes<=0)
    {
        CZigbeeAlarm *pZAlarm = CZigbeeAlarm::getInstance();
        if (pZAlarm == NULL)
        {
            LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
            fprintf (stderr, "CZigbeeAlarm Can not be created");
            return -1;
        }

        printf("Inserting into ZigbeeAlarm Table for Registration Response sending failiure\n");

        pZAlarm->insert(deviceID, zaddr64.c_str(),Addr16 ,19, 1,0x50, "error");
        return -1;
    }

    else
    {
        CZigbeeAlarm *pZAlarm = CZigbeeAlarm::getInstance();
        if (pZAlarm == NULL)
        {
            LOG_ERROR("server", "CZigbeeAlarm returned a NULL pointer");
            fprintf (stderr, "CZigbeeAlarm Can not be created");
            return -1;
        }
        char desc[10];
        memset(desc,0,strlen(desc));
        strcpy(desc,"ok");
        sprintf(desc+strlen("ok"),"%d",2); //HOW to check whther registration is accepted or rejected by the upper layer
        printf("Inserting into ZigbeeAlarm Table for Registration Response  sending Success \n");
        pZAlarm->insert(deviceID, zaddr64.c_str(),Addr16 ,19, 0,0x50,desc);
    }
    fprintf (stderr , "Sent  Regresponse ------ :%d\n", sent_bytes);
    fprintf (stderr, "Out %s\n",__func__);
    return 0;
}

/*-----------Registration Request Functions ends-------------------------------------*/

int profile_fetcher(int deviceID,ASEMProfile *pdata)
{

    CZigbeeDevice *pZDev = CZigbeeDevice::getInstance ();
    if (pZDev == NULL)
    {
        LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
        fprintf (stderr, "CZigbeeDevice ==Can not be created");
        return -1;
    }

    printf ("Getting data from ZigbeeDevice Table\n");
    CZigbeeDevice::getInstance ()->retrieve (deviceID);

    printf ("Xbee 64 BitAddr= %s\n",
        CZigbeeDevice::getInstance ()->getXbeeAddr64 ().c_str ());
    printf ("Zone Id = %d \n", CZigbeeDevice::getInstance ()->getZoneId ());
    printf ("Device Type = %d\n",
        CZigbeeDevice::getInstance ()->getDeviceType ());
    printf ("ASEMP = %d \n", CZigbeeDevice::getInstance ()->getASEMP ());

    printf ("Getting data from Zone Table\n");
    CZone *pZone = CZone::getInstance ();

    if (pZone == NULL)
    {
        LOG_ERROR("server", "CZone returned a NULL pointer");
        fprintf (stderr, "CZone Can not be created");
        return -1;
    }

    printf ("Getting occupation from Zone Table\n");
    CZone::getInstance ()->retrieve (CZigbeeDevice::getInstance ()->getZoneId ());
    pdata->zone_occu = CZone::getInstance ()->getOcupation ();
    printf ("Occupation = %d \n", CZone::getInstance ()->getOcupation ());

    CASEMP *asemp = CASEMP::getInstance ();
    if (asemp == NULL)
    {
        LOG_ERROR("server", "CASEMP returned a NULL pointer");
        fprintf (stderr, "Can not initialize asemp\n");
        return -1;
    }
    printf ("Getting data from ASEMP Table\n");
    asemp->retrieve (CZigbeeDevice::getInstance ()->getASEMP ());
    pdata->occu_rep = asemp->getProfileValues(PROFILE_OCCUPIED_REPORTING_PERIOD);
    pdata->unoccu_rep = asemp->getProfileValues(PROFILE_UNOCCUPIED_REPORTING_PERIOD);
    pdata->occu_pir = asemp->getProfileValues(PROFILE_OCCUPIED_PIR_TRIGGER_ENABLE);
    pdata->unoccu_pir = asemp->getProfileValues(PROFILE_UNOCCUPIED_PIR_TRIGGER_ENABLE);
    pdata->max_retry = asemp->getProfileValues(PROFILE_MAX_RETRY_COUNT_ENABLE);
    pdata->max_wait = asemp->getProfileValues(PROFILE_MAX_WAIT_TIMER_ENABLE);
    pdata->min_rep_wait = asemp->getProfileValues(PROFILE_MIN_REPORT_INTERVAL_ENABLE);
    pdata->bat_stat_thr = asemp->getProfileValues(PROFILE_BATTERY_THRESHOLD_TRIGGER_ENABLE);
    pdata->up_temp_tr = asemp->getProfileValues(PROFILE_TEMP_UPTHRESHOLD_TRIGGER_ENABLE);
    pdata->up_hum_tr = asemp->getProfileValues(PROFILE_HUMIDITY_UPTHRESHOLD_TRIGGER_ENABLE);
    pdata->lo_hum_tr = asemp->getProfileValues(PROFILE_HUMIDITY_DNTHRESHOLD_TRIGGER_ENABLE);
    pdata->lux_sl_tr = asemp->getProfileValues(PROFILE_LUX_SLOPE_TRIGGER_ENABLE);
    pdata->up_co_tr = asemp->getProfileValues(PROFILE_CO_UPTHRESHOLD_TRIGGER_ENABLE);
    pdata->up_co2_tr = asemp->getProfileValues(PROFILE_CO2_UPTHRESHOLD_TRIGGER_ENABLE);
    pdata->aud_alarm = asemp->getProfileValues(PROFILE_AUDIBLE_ALARM_ENABLE);
    pdata->led_alarm = asemp->getProfileValues(PROFILE_LED_ALARM_ENABLE);
    pdata->temp_sl_alarm = asemp->getProfileValues(PROFILE_TEMP_SLOPE_TRIGGER_ENABLE);
    pdata->mcu_sleep = asemp->getProfileValues(PROFILE_MCU_SLEEP_TIMER);
    pdata->ac_curr_thr = asemp->getProfileValues(PROFILE_AC_UPTHRESHOLD_TRIGGER_ENABLE);
    pdata->lo_temp_tr = asemp->getProfileValues(PROFILE_TEMP_DNTHRESHOLD_TRIGGER_ENABLE);

    fprintf
     (stderr, "zone_occu :%d \noccu_rep : %d \nunoccu_rep : %d \noccu_pir:%d\nunoccu_pir:%d\nmax_retry:%d\nmax_wait:%d\nmin_rep_wait:%d\nbat_stat_thr:%d\nup_temp_tr:%d\nlo_temp_tr:%d\nup_hum_tr:%d\nlo_hum_tr:%d\nlux_sl_tr:%d\nup_co_tr:%d\nup_co2_tr:%d\naud_alarm:%d\nled_alarm:%d\ntemp_sl_alarm:%f\nmcu_sleep:%d\nacc_curr_thr:%f\n\n",
        pdata->zone_occu,pdata->occu_rep, pdata->unoccu_rep, pdata->occu_pir,
          pdata->unoccu_pir, pdata->max_retry, pdata->max_wait,pdata->min_rep_wait ,pdata->bat_stat_thr ,pdata->up_temp_tr ,pdata->lo_temp_tr ,pdata->up_hum_tr ,pdata->lo_hum_tr ,pdata->lux_sl_tr ,pdata->up_co_tr ,pdata->up_co2_tr ,pdata->aud_alarm ,pdata->led_alarm ,pdata->temp_sl_alarm,pdata->mcu_sleep,pdata->ac_curr_thr);

    return 0;
}
#endif
