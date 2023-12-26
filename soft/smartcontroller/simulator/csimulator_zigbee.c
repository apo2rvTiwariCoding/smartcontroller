#include <pthread.h>
#include "util/ini.h" 
#include "inc/ASEMPImpl.h"
#include "simulator/csimulator_zigbee.h"

#ifdef EMULATOR
struct sockaddr_in destination;

int thisSocket,bIsConnected;
int gPort=CLIENT_PORT;
char* gIpaddress;
char* gUnsolicited_file;
char* gDevice_file;
int NetLED;
int PowLED;
int ZED_Enabler;
int value ;

//----------------Read From Ini Functions start----------------------------------------------

void* retrieveFromDatabaseFile (char* filename,int type ,void* pDevice)
{
  //----Code to check directory exists in given path if not exists create directory----//

  if(type==1)
  {
        RegistrationRequest *data = (RegistrationRequest* )pDevice;
        //data = (RegistrationRequest *)malloc(sizeof(RegistrationRequest));
        //if(stat("./config",&data) != 0)
        //mkdir("./config",0777);
        //----------------------------------------------------------------------------------//
        
		if (ini_parse(filename, handler1, pDevice) < 0) {
        printf("Can't load :%s\n",filename);
        return data;
		 }
		
		fprintf(stderr,"Data read from CONFIG FILE \ndeviceID:%d\nzigbeeHardwareVersion:%d\nzigbeeFirmwareVersion:%d\n \
			ASEHardwareVersion:%d\nASEFirmwareVersion:%d\nRemote_RSSI:%d\n",data->deviceType ,data->zigbeeHardwareVersion,
			data->zigbeeFirmwareVersion,data->ASEHardwareVersion,data->ASEFirmwareVersion ,data->Remote_RSSI);
         return data;
  }
  else if (type ==2)
  {
	    UnsolicitedSensorInfoRequest *data =(UnsolicitedSensorInfoRequest*)pDevice;
      	if (ini_parse(filename, handler, pDevice) < 0) {
        printf("Can't load :%s\n",filename);
        return data;
		 }

	        fprintf(stderr,"deviceType :%d\n",data->deviceType);
			fprintf(stderr,"pir : %d\n",data->pir);
            fprintf(stderr,"cause : %d\n",data->cause);
            fprintf(stderr,"min_temp :%f\n",data->min_temp);
            fprintf(stderr,"avg_temp :%f\n" ,data->avg_temp);
            fprintf(stderr,"max_temp :%f\n",data->max_temp);
            fprintf(stderr,"min_hum : %f\n",data->min_hum);
            fprintf(stderr,"avg_hum : %f\n",data->avg_hum);
            fprintf(stderr,"max_hum : %f\n",data->max_hum);
            fprintf(stderr,"min_lux : %d\n",data->min_lux);
            fprintf(stderr,"max_lux : %d\n",data->max_lux);
            fprintf(stderr,"battery : %d\n",data->battery);
            fprintf(stderr,"Remote_RSSI : %d\n",data->Remote_RSSI);
			fprintf(stderr,"ac_current : %f\n",data->ac_current);
			fprintf(stderr,"coMax : %d\n",data->coMax);
			fprintf(stderr,"coAvg : %d\n",data->coAvg);
			fprintf(stderr,"coMin : %d\n",data->coMin);
			fprintf(stderr,"co2Max : %d\n",data->co2Max);
			fprintf(stderr,"co2Avg : %d\n",data->co2Avg);
			fprintf(stderr,"co2Min : %d\n",data->co2Min);
			fprintf(stderr,"remoteAck : %d\n",data->remoteAck);

		
        //fclose(fp);
        return data;
  }
  return 0;
}
static int handler1(void* user, const char* section, const char* name,
                   const char* value )
{
    RegistrationRequest* pconfig = (RegistrationRequest*)user;

    #define MATCH(s, n) strcmp(section, s) == 0 && strcmp(name, n) == 0
    if (MATCH("Register", "deviceType")) {
		pconfig->deviceType = atoi(value);
      	
    } else if (MATCH("Register", "zigbeeHardwareVersion")) {
		pconfig->zigbeeHardwareVersion = atoi(value);

	} else if (MATCH("Register", "zigbeeFirmwareVersion")) {
		pconfig->zigbeeFirmwareVersion = atoi(value);
      	
    } else if (MATCH("Register", "ASEFirmwareVersion")) {
		pconfig->ASEFirmwareVersion = atoi(value);
      	
    } else if (MATCH("Register", "ASEHardwareVersion")) {
		pconfig->ASEHardwareVersion = atoi(value);
      	
    } else if (MATCH("Register", "Remote_RSSI")) {
		pconfig->Remote_RSSI = atoi(value);
      	
    }  
	 else {
        return 0;  
    }
    return 0;
}
static int handler(void* user, const char* section, const char* name,
                   const char* value )
{
    UnsolicitedSensorInfoRequest* pconfig = (UnsolicitedSensorInfoRequest*)user;

    #define MATCH(s, n) strcmp(section, s) == 0 && strcmp(name, n) == 0
    if (MATCH("unsolicited", "deviceType")) {
		pconfig->deviceType = atoi(value);
      	
    } else if (MATCH("unsolicited", "pir")) {
		pconfig->pir = atoi(value);
		fprintf(stderr,"pir -> %x ::: atoi(value) : %x ::value :%s\n",pconfig->pir,atoi(value),value);
      	//fprintf(stderr,"pir : %d\n",pconfig->pir;
    } else if (MATCH("unsolicited", "cause")) {
		pconfig->cause = atoi(value);
      	
    } else if (MATCH("unsolicited", "min_temp")) {
		pconfig->min_temp = atoi(value);
      	
    } else if (MATCH("unsolicited", "avg_temp")) {
		pconfig->avg_temp = atoi(value);
      	
    } else if (MATCH("unsolicited", "max_temp")) {
		pconfig->max_temp = atoi(value);
      	
    } else if (MATCH("unsolicited", "min_hum")) {
		pconfig->min_hum = atoi(value);
      	
    }  else if (MATCH("unsolicited", "avg_hum")) {
		pconfig->avg_hum = atoi(value);
      	
    }  else if (MATCH("unsolicited", "max_hum")) {
		pconfig->max_hum = atoi(value);
      	
    }  else if (MATCH("unsolicited", "min_lux")) {
		pconfig->min_lux = atoi(value);
      	
    }  else if (MATCH("unsolicited", "max_lux")) {
		pconfig->max_lux = atoi(value);
      	
    }  else if (MATCH("unsolicited", "battery")) {
		pconfig->battery = atoi(value);
      	
    }  else if (MATCH("unsolicited", "Remote_RSSI")) {
		pconfig->Remote_RSSI = atoi(value);
      	
    } else if (MATCH("unsolicited", "Remote_RSSI")) {
		pconfig->Remote_RSSI = atoi(value);
      	
    } else if (MATCH("unsolicited", "ac_current")) {
		pconfig->ac_current = atoi(value);
      	
    } else if (MATCH("unsolicited", "coMax")) {
		pconfig->coMax = atoi(value);
      	
    } else if (MATCH("unsolicited", "coAvg")) {
		pconfig->coAvg = atoi(value);
      	
    } else if (MATCH("unsolicited", "coMin")) {
		pconfig->coMin = atoi(value);
      	
    } else if (MATCH("unsolicited", "co2Max")) {
		pconfig->co2Max = atoi(value);
      	
    } else if (MATCH("unsolicited", "co2Avg")) {
		pconfig->co2Avg = atoi(value);
      	
    } else if (MATCH("unsolicited", "co2Min")) {
		pconfig->co2Min = atoi(value);
      	
    } else if (MATCH("unsolicited", "remoteAck")) {
		pconfig->remoteAck = atoi(value);
      	
    } 
	 else {
        return 0;  
    }
    return 0;
}
//----------------Read From Ini Functions end----------------------------------------------
//---------------- Message recieve Function -----------------------------------------------

void OnMessageReceivedClient(char* buffer ,int len)
{
	ASEMPMessage *ASEMPmsg1 = (ASEMPMessage *)buffer;
	#ifdef DEBUG
	fprintf(stderr,"In %s \n",__func__);
	#endif
	printf ("\n\nMessage Received on Client socketfd ");
        printf ("protocolID :%x \nsizeof buff :%d \n ",ASEMPmsg1->protocolID,len);
        if(ASEMPmsg1->protocolID == 0XF1)//it is registration response
        {
                RegistrationResponse *regResponse ;//
				NetLED=1;
				fprintf(stderr,"Registration Response from server \n");
                regResponse = (RegistrationResponse *)buffer;
		    	fprintf(stderr,"zone_occu : %d \noccu_rep : %d \nunoccu_rep : %d \noccu_pir:%d\nunoccu_pir:%d\nmax_retry:%d\nmax_wait:%d\nmin_rep_wait:%d\nbat_stat_thr:%d\nup_temp_tr:%d\nlo_temp_tr:%d\nup_hum_tr:%d\nlo_hum_tr:%d\nlux_sl_tr:%d\nup_co_tr:%d\nup_co2_tr:%d\naud_alarm:%d\nled_alarm:%d\ntemp_sl_alarm:%f\nmcu_sleep:%d\nac_curr_thr:%f\n\n",
					regResponse->ASEMProObj.zone_occu,regResponse->ASEMProObj.occu_rep, regResponse->ASEMProObj.unoccu_rep, regResponse->ASEMProObj.occu_pir,
					regResponse->ASEMProObj.unoccu_pir, regResponse->ASEMProObj.max_retry, regResponse->ASEMProObj.max_wait,regResponse->ASEMProObj.min_rep_wait ,regResponse->ASEMProObj.bat_stat_thr ,regResponse->ASEMProObj.up_temp_tr ,regResponse->ASEMProObj.lo_temp_tr ,regResponse->ASEMProObj.up_hum_tr ,regResponse->ASEMProObj.lo_hum_tr ,regResponse->ASEMProObj.lux_sl_tr ,
					regResponse->ASEMProObj.up_co_tr ,regResponse->ASEMProObj.up_co2_tr ,regResponse->ASEMProObj.aud_alarm ,regResponse->ASEMProObj.led_alarm ,regResponse->ASEMProObj.temp_sl_alarm,
					regResponse->ASEMProObj.mcu_sleep,regResponse->ASEMProObj.ac_curr_thr);
				UnsolicitedReqThreadFunc (regResponse);
		}
         else if(ASEMPmsg1->protocolID == 0XF2 && ZED_Enabler ==1)//it is unsolicited response
        {
                UnsolicitedSensorInfoResponse *infoResponse ;//
				fprintf(stderr,"Unsolicited Response from server \n");
                infoResponse = (UnsolicitedSensorInfoResponse *)buffer;
				fprintf(stderr,"zone_occu : %d\noccu_rep : %d \nunoccu_rep : %d \noccu_pir:%d\nunoccu_pir:%d\nmax_retry:%d\nmax_wait:%d\nmin_rep_wait:%d\nbat_stat_thr:%d\nup_temp_tr:%d\nlo_temp_tr:%d\nup_hum_tr:%d\nlo_hum_tr:%d\nlux_sl_tr:%d\nup_co_tr:%d\nup_co2_tr:%d\naud_alarm:%d\nled_alarm:%d\ntemp_sl_alarm:%f\nmcu_sleep:%d\nac_curr_thr:%f\n\n",
					infoResponse->ASEMProObj.zone_occu,infoResponse->ASEMProObj.occu_rep, infoResponse->ASEMProObj.unoccu_rep, infoResponse->ASEMProObj.occu_pir,
					infoResponse->ASEMProObj.unoccu_pir, infoResponse->ASEMProObj.max_retry, infoResponse->ASEMProObj.max_wait,infoResponse->ASEMProObj.min_rep_wait ,infoResponse->ASEMProObj.bat_stat_thr ,infoResponse->ASEMProObj.up_temp_tr ,infoResponse->ASEMProObj.lo_temp_tr ,infoResponse->ASEMProObj.up_hum_tr ,infoResponse->ASEMProObj.lo_hum_tr ,
					infoResponse->ASEMProObj.lux_sl_tr ,infoResponse->ASEMProObj.up_co_tr ,infoResponse->ASEMProObj.up_co2_tr ,infoResponse->ASEMProObj.aud_alarm ,infoResponse->ASEMProObj.led_alarm ,
					infoResponse->ASEMProObj.temp_sl_alarm,infoResponse->ASEMProObj.mcu_sleep,infoResponse->ASEMProObj.ac_curr_thr);
        }   
		else if (ASEMPmsg1->protocolID == 0XF3 && ZED_Enabler ==1) // it is central command request
		{
			 CentralCommandRequest *commandRequest= (CentralCommandRequest* )buffer;
			 int i;
			 CentralCommandResponse *commandResponse = (CentralCommandResponse*)malloc(sizeof(CentralCommandResponse));
			 fprintf(stderr,"CentralCommandRequest from server \n");
			 OnCentralCommandRequest(commandRequest);  //actions to be performed in client ??????????
			 commandResponse->deviceID = commandRequest->deviceID;
			 if (commandRequest->ack_requester == 0 )
				commandResponse->ack = -1; 
			 else 
				commandResponse->ack = 1 ; // ??????????????????? what should be the condiion of setting it to 1 or 0
			 commandResponse->ASEMPMobj.protocolID = 0X03;
			 commandResponse->Remote_RSSI = 0 ; // this value will be received by ASE device 
			 i = Send((char *)commandResponse,sizeof(CentralCommandResponse));
			 fprintf(stderr,"number of bytes send  for commandResponse =: %d \n",i);
			 
		}
		 else if (ASEMPmsg1->protocolID == 0XF4 && ZED_Enabler ==1)
		 {
			 UpdateProfileRequest *profileRequest= (UpdateProfileRequest* )buffer;
			 UpdateProfileResponse *profileResponse = (UpdateProfileResponse*)malloc(sizeof(UpdateProfileResponse));
			 int i;
			 fprintf(stderr,"UpdateProfileRequest from server \n");
			 OnUpdateProfileRequest(profileRequest);
			 ////////////////////actions performed ??????????????????///////////////////
			 profileResponse->ASEMPMobj.protocolID = 0x04;
			 profileResponse->deviceID = profileRequest->deviceID;
			 profileResponse->Remote_RSSI = 0; // value receicved by ase device 
			 profileResponse->ack = 1 ; /*@ack_state received via payload and may have following values :
										0 = command not acknowledged;
										1 = command acknowledged. */

			 i = Send((char*)profileResponse,sizeof(UpdateProfileResponse));
			 fprintf(stderr,"number of bytes send  for commandResponse =: %d \n",i);
		 }
		 else if(ASEMPmsg1->protocolID == 0XF5 && ZED_Enabler ==1) //added extra PING REQUEST RECEIVED
		 {
			 fprintf(stderr,"ping request from  server \n");
			 ////////////////////actions performed ??????????????????///////////////////
			
		 }
		 else if(ASEMPmsg1->protocolID == 0XF6) //added extra Remote STATUS REQUEST RECEIVED
		 {
			 RemoteStatusRequest *zedRequest= (RemoteStatusRequest* )buffer;
			 fprintf(stderr,"Zed Enabler request from  server \n");
			 
			 ZED_Enabler = zedRequest->Status;
			 
			 OnRemoteStatusRequest(zedRequest);
			  
			 ////////////////////actions performed ??????????????????///////////////////
			
		 }
		 
	#ifdef DEBUG
	fprintf(stderr,"Out %s \n",__func__);
	#endif
}

//---------------------------------Message Receive Function End -------------------------------
int RegistrationRequest1 (DeviceType fdeviceType,  int fzigbeeHardwareVersion, int fzigbeeFirmwareVersion, int fASEHardwareVersion ,int fASEFirmwareVersion, int fRemote_RSSI)
{
	int i;
	RegistrationRequest dataobj;
	#ifdef DEBUG
	fprintf(stderr,"In %s \n",__func__);
	#endif
	dataobj.ASEMPMobj.protocolID = 0X01;		//Defining protocol Id 0X1 for Reg Request 
    dataobj.deviceType = fdeviceType;
    dataobj.zigbeeHardwareVersion = fzigbeeHardwareVersion;
    dataobj.zigbeeFirmwareVersion = fzigbeeFirmwareVersion;
    dataobj.ASEHardwareVersion = fASEHardwareVersion;
    dataobj.ASEFirmwareVersion = fASEFirmwareVersion;
    dataobj.Remote_RSSI = fRemote_RSSI;
	i = Send((char *)&dataobj,sizeof(RegistrationRequest));
	fprintf(stderr,"number of bytes send =:%d on socket :%d\n ",i,thisSocket);
	NetLED=2;
	#ifdef DEBUG
	fprintf(stderr,"Out %s \n",__func__);
	#endif
	return 0;
}


//-----------------------unsolicted Functions start---------------------------------
void UnsolicitedReqThreadFunc (RegistrationResponse *fregResponse)		////////////////////////////////////////////////
{
	int err;
	pthread_t tid=0;
	RegistrationResponse *regResponseData = (RegistrationResponse*)malloc(sizeof(RegistrationResponse));
	if (regResponseData == NULL)
	{
			#ifdef DEBUG
			fprintf(stderr," regResponseData is NULL in %s \n",__func__);
			#endif
			//return 0;						// handle this situation properly
	}
	memcpy(regResponseData,fregResponse,sizeof(RegistrationResponse));
	
	err=pthread_create(&tid,NULL,&UnsolicitedReqThreadProc,(void*)regResponseData);
	if (err != 0)
	{
			fprintf(stderr, "Error Creating Thread\n");
	}
	else
	{
			fprintf(stderr, "Thread created for unsolicited requests\n");
	}

}
void* UnsolicitedReqThreadProc (void* lpdwThreadParam )
{
	RegistrationResponse *regResponseData = (RegistrationResponse *) lpdwThreadParam ;
	#ifdef DEBUG
	fprintf(stderr,"In %s \n",__func__);
	#endif

	//
	//fprintf(stderr,"Before ProcessClientConnectionThread()\n");
    /*CSimulator* client=(CSimulator*)lpdwThreadParam;
    if(client==0)return 0;*/

		/*
		USE THIS lpdwThreadParam 
		USE OF lpdwThreadParam= REGRESPONSE, IS LEFT HERE  just min_rep wait is used in sleep only
		*/
	
	while(1)
	{
		if(ZED_Enabler == 1)
		{
			UnsolicitedSensorInfoRequest *infoRequest = (UnsolicitedSensorInfoRequest*) malloc(sizeof(UnsolicitedSensorInfoRequest));
			fprintf(stderr,"Sending UnSolicited Request to server\n");
			infoRequest=(UnsolicitedSensorInfoRequest* )retrieveFromDatabaseFile (gUnsolicited_file,2,(void*) infoRequest);
			infoRequest->ASEMPMobj.protocolID=0X02;
			UnsolicitedSensorInfoRequest1(infoRequest);
			free(infoRequest);
			//(RegistrationResponse*)lpdwThreadParam->ASEMProObj.min_rep_wait)
			fprintf(stderr,"WAITING TIME : %d \n\n",regResponseData->ASEMProObj.min_rep_wait);
			if (regResponseData->ASEMProObj.min_rep_wait < 5)
				sleep(5);
			else
				sleep(regResponseData->ASEMProObj.min_rep_wait);
		}
	}
        //client->Receiver();
	#ifdef DEBUG
	fprintf(stderr,"Out %s \n",__func__);
	#endif
        return 0;
}
int UnsolicitedSensorInfoRequest1(UnsolicitedSensorInfoRequest *infoRequest)
{
	int i;
	i=Send((char *)infoRequest,sizeof(UnsolicitedSensorInfoRequest))	;
	fprintf(stderr,"number of bytes send =:%d on socket :%d\n",i, thisSocket);
	return 0;
}
//------------------------Unsolicited Functions End-----------------------------------
//------------------------Central Command Function Start------------------------------
int OnCentralCommandRequest(CentralCommandRequest *commandRequest)
{
	fprintf(stderr,"command_type : %d \n", commandRequest->command_type);
	fprintf(stderr,"louver_pos : %d \n", commandRequest->louver_pos);
	//fprintf(stderr,"AC_dev_enable; %d \n", commandRequest->AC_dev_enable);
	fprintf(stderr,"ac_dev_time;%d \n", commandRequest->ac_dev_time);
	fprintf(stderr,"dimmer_val; %d \n", commandRequest->dimmer_val);
	fprintf(stderr,"unsoli_reporting_int; %d \n", commandRequest->unsoli_reporting_int);
	//fprintf(stderr,"ir_data_seq; %u ----this is a pointer ????\n", commandRequest->ir_data_seq);
	fprintf(stderr,"req_unsoli_info; %d \n", commandRequest->req_unsoli_info);
	fprintf(stderr,"aud_alarm; %d \n", commandRequest->aud_alarm);
	fprintf(stderr,"led_alarm; %d \n", commandRequest->led_alarm);
	fprintf(stderr,"relay; %d \n", commandRequest->relay);
	fprintf(stderr,"relay_id; %d \n", commandRequest->relay_id);
	//fprintf(stderr," enable_tmp_reporting; %d \n", commandRequest->enable_tmp_reporting);
	
	return 0;
}


//-----------------------Central Command Function End---------------------------------

//-----------------------Update Profile Function start---------------------------------
int OnUpdateProfileRequest(UpdateProfileRequest *upRequest)
{
	fprintf(stderr,"IN : %s \n",__func__); 
	fprintf(stderr,"deviceId received : %d \n",upRequest->deviceID);
	fprintf
    (stderr, "zone_occu : %d \noccu_rep : %d \nunoccu_rep : %d \noccu_pir:%d\nunoccu_pir:%d\nmax_retry:%d\nmax_wait:%d\nmin_rep_wait:%d\nbat_stat_thr:%d\nup_temp_tr:%d\nlo_temp_tr:%d\nup_hum_tr:%d\nlo_hum_tr:%d\nlux_sl_tr:%d\nup_co_tr:%d\nup_co2_tr:%d\naud_alarm:%d\nled_alarm:%d\ntemp_sl_alarm:%f\nnmcu_sleep:%d\nac_curr_thr:%f\n\n",
	 upRequest->ASEMProObj.zone_occu,upRequest->ASEMProObj.occu_rep, upRequest->ASEMProObj.unoccu_rep, upRequest->ASEMProObj.occu_pir,upRequest->ASEMProObj.unoccu_pir, upRequest->ASEMProObj.max_retry, upRequest->ASEMProObj.max_wait,
	 upRequest->ASEMProObj.min_rep_wait,upRequest->ASEMProObj.bat_stat_thr ,upRequest->ASEMProObj.up_temp_tr ,upRequest->ASEMProObj.lo_temp_tr ,upRequest->ASEMProObj.up_hum_tr ,
	 upRequest->ASEMProObj.lo_hum_tr ,upRequest->ASEMProObj.lux_sl_tr ,upRequest->ASEMProObj.up_co_tr ,upRequest->ASEMProObj.up_co2_tr ,upRequest->ASEMProObj.aud_alarm ,
	 upRequest->ASEMProObj.led_alarm ,upRequest->ASEMProObj.temp_sl_alarm,upRequest->ASEMProObj.mcu_sleep,upRequest->ASEMProObj.ac_curr_thr);
	fprintf(stderr,"OUT : %s \n",__func__); 
	return 0;
}
//-----------------------Update Profile Function end---------------------------------
//-----------------------Remote Status Function Start---------------------------------
int OnRemoteStatusRequest(RemoteStatusRequest* zedRequest)
{
	int i;
	RemoteStatusResponse *zedResponse = (RemoteStatusResponse*)malloc(sizeof(RemoteStatusResponse));
	zedResponse->ASEMPMobj.protocolID = 0x06;
	zedResponse->ack = 1;
	i = Send((char*)zedResponse,sizeof(RemoteStatusResponse));
	fprintf(stderr,"Number of bytes sent  OnRemoteStatusRequest: %d \n",i);
	free(zedResponse);
	return 0;
}
//-----------------------Remote Status Function End---------------------------------


//-----------------------intializer's threads---------------------------------------
void* LedDisplayer(void* arg)
{
	while(1)
	{
		if(PowLED==1)
			fprintf(stderr,"\t\t\tPOWER ON");
		else if(PowLED == 0)
			fprintf(stderr,"\t\t\tPOWER OFF");
		if(NetLED == 0)
			fprintf(stderr,"\t\tNET OFF(UNREG)\n");
		else if (NetLED == 1 && ZED_Enabler == 1)
			fprintf(stderr,"\t\tNET ON (REG - ENABLE MODE)\n");
		else if (NetLED == 1 && ZED_Enabler == 0)
			fprintf(stderr,"\t\tNET ON (REG - DISABLED MODE)\n");
		else if (NetLED ==2)
			fprintf(stderr,"\t\tNET BLINKING(UNREG)\n");
		sleep(4);
	}
	return 0;
}
int SimulatorThread(RegistrationRequest *fDevice)
{
	#ifdef DEBUG
	fprintf(stderr,"In %s \n",__func__);
	#endif
	//void *ret;

       initClient(gIpaddress,gPort);
		//fprintf(stderr, "Done init client\n");

        RegistrationRequest1(fDevice->deviceType,  fDevice->zigbeeHardwareVersion, fDevice->zigbeeFirmwareVersion,fDevice->ASEHardwareVersion, fDevice->ASEFirmwareVersion, fDevice->Remote_RSSI);
        

	#ifdef DEBUG
	fprintf(stderr,"Out %s \n",__func__);
	#endif
	return 0;

}
int initializer(char* device_file , char* Unsoli_file)
{
	int err;
	pthread_t thrd_id = 0;
	int input = 0;
	gIpaddress=(char*)"127.0.0.1";
	gUnsolicited_file = malloc(strlen(Unsoli_file +1));
	gDevice_file = malloc(strlen(device_file +1));
	NetLED = 0;
	value = 0 ;
	PowLED = 1;
	ZED_Enabler=1;
	strcpy(gUnsolicited_file,Unsoli_file);
	strcpy(gDevice_file,device_file);
	fprintf(stderr,"Name of Device file  entered is :%s\n",gDevice_file);
	fprintf(stderr,"Name of Unsolicited file  entered is :%s\n",gUnsolicited_file);
	
	  
	err = pthread_create (&(thrd_id), NULL, LedDisplayer, NULL);
	if (err != 0)
	{
		fprintf (stderr,
			"Error in creating thread:LedDisplayer\n");
	}
	else
	{
		fprintf (stderr,
			"LedDisplayer Thread created \n");
	}
	
	//fprintf(stderr,"UNREGISTERED -- To register ENTER 1 \n");
	while(1)
	{
		scanf("%d",&input);
		if(input != value)
		{
			value = input ;
			if (value == 1) //registration happening 
			{
				RegistrationRequest *pDevice = (RegistrationRequest*) malloc(sizeof(RegistrationRequest));	
				ZED_Enabler=1;
				pDevice = (RegistrationRequest *)retrieveFromDatabaseFile (gDevice_file,1,(void*)pDevice);
				SimulatorThread(pDevice);
				free(pDevice);
			}
			else if (value ==2) //socket to be shutdown
			{
				//NetLed = 0;
				ShutDown();
			}
		}
	}

}
//------------------------------End Initializer---------------------------------

void ShutDown ()
{
	int res = shutdown (thisSocket, SHUT_RDWR);
	NetLED = 0;
	ZED_Enabler=0;
	value = 2;
  
	if (res == -1)
		fprintf (stderr,
	     "ShutDown() socket could not successfully get shutdown\n");
}
int IsConnected ()
{
  return bIsConnected;
}
int Send(char* buffer ,int len)
{
        return send(thisSocket, buffer, len, 0);
}

int Receive (char *buffer, int length)
{
  int newData = 0;

  newData = recv (thisSocket, buffer, length, MSG_NOSIGNAL);

  return newData;
}

void *ReceiveThreadProc (void *lpdwThreadParam)
{
	int bufflen,size;
  int socket = *(int *)lpdwThreadParam;
  free(lpdwThreadParam);
  fprintf(stderr,"socketfd : %d  \n" ,socket);
  if (socket == 0)
    return 0;

  
	fprintf(stderr,"ReceiveThreadProc called\n");
	while(IsConnected())
	{
		char* buffer = (char *)malloc(BUFFER_SIZE);
		if(buffer == NULL)continue;

		size = Receive(buffer,BUFFER_SIZE);
		bufflen=strlen(buffer);
		//fprintf(stderr," buffer recieved:%d\n",size);
		if(size >0)
		{
			OnMessageReceivedClient(buffer,bufflen);
		}
        else if(size==-1||size==0)
        {
                        //Disconnected from client
                        fprintf(stderr,"Disconnected from server: size=%d\n",size );
                        bIsConnected=0;
						NetLED=0;
						value=2;
        }

		free(buffer);
		buffer = NULL;	
	}
	return 0;
}

void CreateReceiveThread (int thisSocket1)
{
  int err;
  pthread_t thrd_id = 0;
  int *socketfd = (void*)malloc(sizeof(int));
  *socketfd = thisSocket1;
  err = pthread_create (&(thrd_id), NULL, &ReceiveThreadProc, (void*)socketfd);
  if (err != 0)
    {
      fprintf (stderr,
	       "Error in creating thread:CreateReceiveThread\n");
    }
  else
    {
      fprintf (stderr,
	       "Thread created to communicate with server :%d. \n",thisSocket1);
    }
}


int
Connect (const char *ipAddr, u_short port)
{
  fprintf(stderr,"In %s \n",__func__);
	//Connecting to a host
  destination.sin_port = htons (port);
  destination.sin_addr.s_addr = inet_addr (ipAddr);
  
  //thisSocket=10;
  while (connect(thisSocket, (struct sockaddr *) &destination,
	      sizeof (destination)) != 0)
	{}
  fprintf (stderr, "Socket Connection SUCCESS!\n");
  bIsConnected = 1;
  CreateReceiveThread (thisSocket);
  return 1;
}
int Create ()
{
  destination.sin_family = AF_INET;
  thisSocket = socket (AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if (thisSocket < 0)
    {
      fprintf (stderr, "Socket Creation FAILED! \n");
      return 0;
    }
  return 1;
}
int initClient(const char* ip, int port)
{
	//int val;
	#ifdef DEBUG
	fprintf(stderr,"In %s \n",__func__);
	#endif
        //clientSocket1.RegisterCallback(CSimulator::OnMessageReceivedClient);
        //clientSocket1.RegisterServerDisconnectCallback(CSimulator::OnServerDisconnect);


		if(Create())
		{
			if(Connect(ip,port))
			{
					fprintf(stderr,"MuxDemux Client started.\n");
					#ifdef DEBUG
					fprintf(stderr,"Out %s \n",__func__);
					#endif

					return 1;
			}
			else
			{
					fprintf(stderr,"Connection to server TIMED OUT!\n");
						#ifdef DEBUG
						fprintf(stderr,"Out %s \n",__func__);
						#endif
					return 0;
			}
		}
		return 0;
}

/*
int main(int argc,char* argv[])
{
	#ifdef DEBUG
	fprintf(stderr,"In %s \n",__func__);
	#endif
	if(argc!=3)
	{
		fprintf(stderr,"please enter Unsoli ini file to read and type (2) \n");
		exit(0);
	}        
	fprintf(stderr,"second argument is : %d \n",atoi(argv[2]));
	gUnsolicited_file = malloc(strlen(argv[1] +1 ));
	
	if(atoi(argv[2])==2)
	{	
		strcpy(gUnsolicited_file, argv[1]);
		fprintf(stderr,"Name of file entered is :%s\n",gUnsolicited_file);
	}
	//gPort=portNum;
	gIpaddress=(char*)"127.0.0.1";
	RegistrationRequest *pDevice = (RegistrationRequest*) malloc(sizeof(RegistrationRequest));	
	pDevice = (RegistrationRequest *)retrieveFromDatabaseFile ("./config/CSimulator.ini",1,(void*)pDevice);
	SimulatorThread(pDevice);
	#ifdef DEBUG
	fprintf(stderr,"Out %s \n",__func__);
	#endif
	return 0;
}
*/
#endif