#include <pthread.h>
#include "util/ini.h" 
#include "net/stdafx.h"
#include "net/tcp_socket_mux.h"
#include "inc/ASEMPImpl.h"
#include "simulator/csimulator.h"
int gPort;
string gIpaddress;
char* gUnsolicited_file;
CTcpSocketMux clientSocket1;

CSimulator* CSimulator::mInstance = NULL;
CSimulator* CSimulator::getInstance(char *ipAddress, int portNum,char* Unsolicited_file)
{
        if(mInstance == NULL)
        {
                mInstance = new CSimulator(ipAddress, portNum,Unsolicited_file);
        }
        return mInstance;
}
CSimulator* CSimulator::getInstance()
{
        return mInstance;
}

CSimulator::CSimulator(char *ipAddress, int portNum,char* Unsolicited_file )
{
        gPort=portNum;
        gIpaddress=string(ipAddress);
        gUnsolicited_file = new char[strlen(Unsolicited_file) +1];
	strcpy(gUnsolicited_file,Unsolicited_file);
//        gASEMProfile=mASEMProfile=profile;
	
}
void *CSimulator::retrieveFromDatabaseFile (char* filename,int type ,void* pDevice)
{
  //----Code to check directory exists in given path if not exists create directory----//

  if(type==1)
  {
        RegistrationRequest *data = (RegistrationRequest* )pDevice;
        //data = (RegistrationRequest *)malloc(sizeof(RegistrationRequest));
        //if(stat("./config",&data) != 0)
        //mkdir("./config",0777);
        //----------------------------------------------------------------------------------//
        
		if (ini_parse("./config/CSimulator.ini", handler1, pDevice) < 0) {
        printf("Can't load './config/CSimulator.ini'\n");
        return data;
		 }
		
        {
         std::cout << data->deviceType << " : " << data->zigbeeHardwareVersion
                << " : " << data->zigbeeFirmwareVersion << " : " << data->ASEHardwareVersion
                << " : " << data->ASEFirmwareVersion << " : " << data->Remote_RSSI << "\n";
        }
        return data;
  }
  else if (type ==2)
  {

        UnsolicitedSensorInfoRequest *data =(UnsolicitedSensorInfoRequest*)pDevice;
		if (ini_parse("config/UnSoli.ini", handler, pDevice) < 0) {
        printf("Can't load 'test.ini'\n");
        return data;
		 }
			std::cout<<"deviceID :"<<data->deviceID<<"\n";
            std::cout<<"pir : "<<data->pir<<"\n";
            std::cout<<"min_temp :"<<data->min_temp<<"\n";
            std::cout<<"avg_temp :"<<data->avg_temp<<"\n";
            std::cout<<"max_temp :"<<data->max_temp<<"\n";
            std::cout<<"min_hum : "<<data->min_hum<<"\n";
            std::cout<<"avg_hum : "<<data->avg_hum<<"\n";
            std::cout<<"max_hum : "<<data->max_hum<<"\n";
            std::cout<<"min_lux : "<<data->min_lux<<"\n";
            std::cout<<"max_lux : "<<data->max_lux<<"\n";
            std::cout<<"min_bat_pow : "<<data->min_bat_pow<<"\n";
            std::cout<<"Remote_RSSI : "<<data->Remote_RSSI<<"\n";
        return data;
  }

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
		//fprintf(stderr,"pir -> %x ::: atoi(value) : %x ::value :%s\n",pconfig->pir,atoi(value),value);
      	//std::cout<<"pir : "<<pconfig->pir;
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
        return 0;  /* unknown section/name, error */
    }
    return 0;
}
static int handler(void* user, const char* section, const char* name,
                   const char* value )
{
    UnsolicitedSensorInfoRequest* pconfig = (UnsolicitedSensorInfoRequest*)user;

    #define MATCH(s, n) strcmp(section, s) == 0 && strcmp(name, n) == 0
    if (MATCH("unsolicited", "deviceID")) {
		pconfig->deviceID = atoi(value);
      	
    } else if (MATCH("unsolicited", "pir")) {
		pconfig->pir = atoi(value);
		fprintf(stderr,"pir -> %x ::: atoi(value) : %x ::value :%s\n",pconfig->pir,atoi(value),value);
      	//std::cout<<"pir : "<<pconfig->pir;
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
      	
    }  else if (MATCH("unsolicited", "min_bat_pow")) {
		pconfig->min_bat_pow = atoi(value);
      	
    }  else if (MATCH("unsolicited", "Remote_RSSI")) {
		pconfig->Remote_RSSI = atoi(value);
      	
    } 
	 else {
        return 0;  /* unknown section/name, error */
    }
    return 0;
}

int CSimulator::SimulatorThread(RegistrationRequest *fDevice)
{
	//void *ret;
	//int err;
        initClient(gIpaddress.c_str(),gPort);
		fprintf(stderr, "Done init client\n");
        RegistrationRequest1(fDevice->deviceType,  fDevice->zigbeeHardwareVersion, fDevice->zigbeeFirmwareVersion,fDevice->ASEHardwareVersion, fDevice->ASEFirmwareVersion, fDevice->Remote_RSSI);
		fprintf(stderr, "Done RegistrationRequest \n");
        /*pthread_t tid=0;
        err=pthread_create(&tid,NULL,&UnsolicitedReqThreadProc,this);
        if (err != 0)
        {
                fprintf(stderr, "Error Creating Thread\n");
        }
        else
        {
                fprintf(stderr, "Thread created to connect client...\n");
        }
		pthread_join(tid,NULL);*/
		return 0;

}
void CSimulator::UnsolicitedReqThreadFunc ()
{
	int err;
	pthread_t tid=0;
	err=pthread_create(&tid,NULL,&UnsolicitedReqThreadProc,this);
	if (err != 0)
	{
			fprintf(stderr, "Error Creating Thread\n");
	}
	else
	{
			fprintf(stderr, "Thread created for unsolicited requests\n");
	}
}

void* CSimulator::UnsolicitedReqThreadProc (void* lpdwThreadParam )
{
	printf("Before ProcessClientConnectionThread()\n");
	CSimulator* client=(CSimulator*)lpdwThreadParam;
	if(client==0)return 0;
	while(1)
	{
	UnsolicitedSensorInfoRequest *infoRequest = new UnsolicitedSensorInfoRequest();
	fprintf(stderr,"Sending UnSolicited Request to server\n");
	infoRequest=(UnsolicitedSensorInfoRequest* )client->retrieveFromDatabaseFile (gUnsolicited_file,2,(void*) infoRequest);
	infoRequest->ASEMPMobj.protocolID=0X02;
		UnsolicitedSensorInfoRequest1(infoRequest);
	delete infoRequest;
	sleep(10);
	}
	//client->Receiver();
	return 0;
}


void CSimulator::OnServerDisconnect()
{
        std::cout<<"Server disconnected...\n";
        initClient(gIpaddress.c_str(), gPort);
}

void CSimulator::OnMessageReceivedClient(void* pServer,char* buffer ,int len)
{
	printf ("\n\nMessage Received on socketfd :%d \n",clientSocket1.thisSocket);
        
        ASEMPMessage *ASEMPmsg1 = (ASEMPMessage *)buffer;//
        printf ("protocolID :%x \nsizeof buff :%d \n ",ASEMPmsg1->protocolID,sizeof(buffer));
        if(ASEMPmsg1->protocolID == 0XF1)//it is registration response
        {

                RegistrationResponse *regResponse ;//
				fprintf(stderr,"Registration Response from server \n");
                regResponse = (RegistrationResponse *)buffer;
		    	fprintf(stderr,"zone_occu : %d \noccu_rep : %d \nunoccu_rep : %d \noccu_pir:%d\nunoccu_pir:%d\nmax_retry:%d\nmax_wait:%d\nmin_rep_wait:%d\nbat_stat_thr:%d\nup_temp_tr:%f\nlo_temp_tr:%f\nup_hum_tr:%f\nlo_hum_tr:%f\nlux_sl_tr:%f\nup_co_tr:%f\nup_co2_tr:%f\naud_alarm:%d\nled_alarm:%d\ntemp_sl_alarm:%f\nmcu_sleep:%d\nac_curr_thr:%f\n\n",
					regResponse->ASEMProObj.zone_occu,regResponse->ASEMProObj.occu_rep, regResponse->ASEMProObj.unoccu_rep, regResponse->ASEMProObj.occu_pir,
					regResponse->ASEMProObj.unoccu_pir, regResponse->ASEMProObj.max_retry, regResponse->ASEMProObj.max_wait,regResponse->ASEMProObj.min_rep_wait ,regResponse->ASEMProObj.bat_stat_thr ,regResponse->ASEMProObj.up_temp_tr ,regResponse->ASEMProObj.lo_temp_tr ,regResponse->ASEMProObj.up_hum_tr ,regResponse->ASEMProObj.lo_hum_tr ,regResponse->ASEMProObj.lux_sl_tr ,
					regResponse->ASEMProObj.up_co_tr ,regResponse->ASEMProObj.up_co2_tr ,regResponse->ASEMProObj.aud_alarm ,regResponse->ASEMProObj.led_alarm ,regResponse->ASEMProObj.temp_sl_alarm,
					regResponse->ASEMProObj.mcu_sleep,regResponse->ASEMProObj.ac_curr_thr);
				CSimulator::getInstance()->UnsolicitedReqThreadFunc ();			
				
		}
         else if(ASEMPmsg1->protocolID == 0XF2)//it is unsolicited response
        {
                UnsolicitedSensorInfoResponse *infoResponse ;//
				fprintf(stderr,"Unsolicited Response from server \n");
                infoResponse = (UnsolicitedSensorInfoResponse *)buffer;
				fprintf(stderr,"zone_occu : %d\noccu_rep : %d \nunoccu_rep : %d \noccu_pir:%d\nunoccu_pir:%d\nmax_retry:%d\nmax_wait:%d\nmin_rep_wait:%d\nbat_stat_thr:%d\nup_temp_tr:%f\nlo_temp_tr:%f\nup_hum_tr:%f\nlo_hum_tr:%f\nlux_sl_tr:%f\nup_co_tr:%f\nup_co2_tr:%f\naud_alarm:%d\nled_alarm:%d\ntemp_sl_alarm:%f\nmcu_sleep:%d\nac_curr_thr:%f\n\n",
					infoResponse->ASEMProObj.zone_occu,infoResponse->ASEMProObj.occu_rep, infoResponse->ASEMProObj.unoccu_rep, infoResponse->ASEMProObj.occu_pir,
					infoResponse->ASEMProObj.unoccu_pir, infoResponse->ASEMProObj.max_retry, infoResponse->ASEMProObj.max_wait,infoResponse->ASEMProObj.min_rep_wait ,infoResponse->ASEMProObj.bat_stat_thr ,infoResponse->ASEMProObj.up_temp_tr ,infoResponse->ASEMProObj.lo_temp_tr ,infoResponse->ASEMProObj.up_hum_tr ,infoResponse->ASEMProObj.lo_hum_tr ,
					infoResponse->ASEMProObj.lux_sl_tr ,infoResponse->ASEMProObj.up_co_tr ,infoResponse->ASEMProObj.up_co2_tr ,infoResponse->ASEMProObj.aud_alarm ,infoResponse->ASEMProObj.led_alarm ,
					infoResponse->ASEMProObj.temp_sl_alarm,infoResponse->ASEMProObj.mcu_sleep,infoResponse->ASEMProObj.ac_curr_thr);
        }   
		 else if (ASEMPmsg1->protocolID == 0XF3) // it is central command request
		{
			 fprintf(stderr,"CentralCommandRequest from server \n");
			 CentralCommandRequest *commandRequest= (CentralCommandRequest* )buffer;
			 CentralCommandResponse *commandResponse = new CentralCommandResponse();
			 OnCentralCommandRequest(commandRequest);  //actions to be performed in client ??????????
			 commandResponse->deviceID = commandRequest->deviceID;
			 if (commandRequest->ack_requester == 0 )
				commandResponse->ack = -1; 
			 else 
				commandResponse->ack = 1 ; // ??????????????????? what should be the condiion of setting it to 1 or 0
			 commandResponse->ASEMPMobj.protocolID = 0X03;
			 commandResponse->Remote_RSSI = 0 ; // this value will be received by ASE device 
			 int i = Send((char *)commandResponse,sizeof(CentralCommandResponse));
			 fprintf(stderr,"number of bytes send  for commandResponse =: %d \n",i);
			 
		}
		 else if (ASEMPmsg1->protocolID == 0XF4)
		 {
			 fprintf(stderr,"UpdateProfileRequest from server \n");
			 UpdateProfileRequest *profileRequest= (UpdateProfileRequest* )buffer;
			 UpdateProfileResponse *profileResponse = new UpdateProfileResponse();
			 OnUpdateProfileRequest(profileRequest);
			 ////////////////////actions performed ??????????????????///////////////////
			 profileResponse->ASEMPMobj.protocolID = 0x04;
			 profileResponse->Remote_RSSI = 0; // value receicved by ase device 
			 int i = Send((char*)profileResponse,sizeof(UpdateProfileResponse));
			 fprintf(stderr,"number of bytes send  for commandResponse =: %d \n",i);
		 }

}


int CSimulator::initClient(const char* ip, int port)
{
        clientSocket1.RegisterCallback(CSimulator::OnMessageReceivedClient);
        clientSocket1.RegisterServerDisconnectCallback(CSimulator::OnServerDisconnect);

        //int val;

        if(clientSocket1.Connect(ip,port))
        {
                std::cout<<"MuxDemux Client started.\n";
                return 1;
        }
        else
        {
                std::cout<<"Connection to server TIMED OUT!\n";
                return 0;
        }
}
//int CSimulator::Send(char* buffer ,int len)
int Send(char* buffer ,int len)
{
        return send(clientSocket1.thisSocket, buffer, len, 0);
}


int RegistrationRequest1 (DeviceType fdeviceType,  float fzigbeeHardwareVersion, float fzigbeeFirmwareVersion, float fASEHardwareVersion ,float fASEFirmwareVersion, int fRemote_RSSI)
{
	int i;
        RegistrationRequest dataobj;
        dataobj.ASEMPMobj.protocolID = 0X01;		//Defining protocol Id 0X1 for Reg Request
        dataobj.deviceType = fdeviceType;
        dataobj.zigbeeHardwareVersion = fzigbeeHardwareVersion;
        dataobj.zigbeeFirmwareVersion = fzigbeeFirmwareVersion;
        dataobj.ASEHardwareVersion = fASEHardwareVersion;
        dataobj.ASEFirmwareVersion = fASEFirmwareVersion;
        dataobj.Remote_RSSI = fRemote_RSSI;
	i = Send((char *)&dataobj,sizeof(RegistrationRequest));
	std::cout<<"number of bytes send =:"<<i<<" on socket :  "<<clientSocket1.thisSocket<<"\n";
	
	return 0;
}

int UnsolicitedSensorInfoRequest1(UnsolicitedSensorInfoRequest *infoRequest)
{
	int i;
	i=Send((char *)infoRequest,sizeof(UnsolicitedSensorInfoRequest))	;
	std::cout<<"number of bytes send =:"<<i<<" on socket : "<<clientSocket1.thisSocket<<"\n";
	return 0;
}

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

int OnUpdateProfileRequest(UpdateProfileRequest *upRequest)
{
	fprintf
    (stderr, "zone_occu : %d \noccu_rep : %d \nunoccu_rep : %d \noccu_pir:%d\nunoccu_pir:%d\nmax_retry:%d\nmax_wait:%d\nmin_rep_wait:%d\nbat_stat_thr:%d\nup_temp_tr:%f\nlo_temp_tr:%f\nup_hum_tr:%f\nlo_hum_tr:%f\nlux_sl_tr:%f\nup_co_tr:%f\nup_co2_tr:%f\naud_alarm:%d\nled_alarm:%d\ntemp_sl_alarm:%f\nnmcu_sleep:%d\nac_curr_thr:%f\n\n",
	 upRequest->ASEMProObj.zone_occu,upRequest->ASEMProObj.occu_rep, upRequest->ASEMProObj.unoccu_rep, upRequest->ASEMProObj.occu_pir,upRequest->ASEMProObj.unoccu_pir, upRequest->ASEMProObj.max_retry, upRequest->ASEMProObj.max_wait,
	 upRequest->ASEMProObj.min_rep_wait,upRequest->ASEMProObj.bat_stat_thr ,upRequest->ASEMProObj.up_temp_tr ,upRequest->ASEMProObj.lo_temp_tr ,upRequest->ASEMProObj.up_hum_tr ,
	 upRequest->ASEMProObj.lo_hum_tr ,upRequest->ASEMProObj.lux_sl_tr ,upRequest->ASEMProObj.up_co_tr ,upRequest->ASEMProObj.up_co2_tr ,upRequest->ASEMProObj.aud_alarm ,
	 upRequest->ASEMProObj.led_alarm ,upRequest->ASEMProObj.temp_sl_alarm,upRequest->ASEMProObj.mcu_sleep,upRequest->ASEMProObj.ac_curr_thr);
	return 0;
}
/*int
main (int argc, char *argv[])
{

	if(argc!=3)
	{
		std::cout<<"please enter ini file to read and type \n";
	}
      	//ASEMProfile *pASEMPobj = new ASEMProfile();//use of this is currently unknown
		std::cout<<"please ::  \n"<<argv[2]<<"\n";
		gUnsolicited_file = new char[strlen(argv[1] +1 )];
		
		if(atoi(argv[2])==2)
	strcpy(gUnsolicited_file, argv[1]);
	std::cout<<"please ::  \n"<<gUnsolicited_file<<"\n";
        //if(pASEMPobj!=NULL)
	{
                char *addr="127.0.0.1";
      		//CSimulator::getInstance(addr,CLIENT_PORT,pASEMPobj);
			CSimulator::getInstance(addr,CLIENT_PORT);
      		//CSimulator::getInstance()->SaveToDatabaseFile ();	//checking of ini file is left 
//		if(atoi(argv[2])==1)	
		{
			RegistrationRequest *pDevice = new RegistrationRequest();	
			pDevice = (RegistrationRequest *)CSimulator::getInstance()->retrieveFromDatabaseFile ("./config/CSimulator.ini",1,(void*)pDevice);
      			CSimulator::getInstance()->SimulatorThread(pDevice);
			delete pDevice;	
		}
//		else if(atoi(argv[2])==2)
		{
		}
	while(1)
	{
		sleep(5);
                std::cout<<"starting the client side";
	}
	}
  return 0;
}
*/