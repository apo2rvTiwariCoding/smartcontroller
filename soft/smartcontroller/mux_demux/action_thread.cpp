
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <sstream>
#include <iterator>
#include <memory>
#include <memory>
#include "db/Database.h"
#include "db/Relays.h"
#include "db/Zigbee.h"
#include "db/Commands.h"
#include "db/ASEMP.h"
#include "db/DeviceRegistration.h"
#include "db/RemoteControl.h"
#include "db/ZigbeeDevice.h"
#include "db/Zone.h"
#include "db/SmartDevices.h"
#include "inc/SensorTypes.h"
#include "inc/ASEMPImpl.h"
#include "mux_demux/action_thread.h"
#include "mux_demux/hal.h"
#include "mux_demux/zed_emulation.h"
#include "mux_demux/zigbee.h"
#include "util/log/log.h"

using namespace std;

#define DEBUGAT

extern int hal_init_err;

CActionThread::CActionThread()
{}

void CActionThread::SetThreadPriority() 
{
    int ret;
    pthread_t this_thread = pthread_self();
	
	struct sched_param params;
	
	switch(mPriority)
	{
		case 1:
		{
			params.sched_priority += 5;
		}
		break;
		case 2:
		{
			params.sched_priority += 10;
		}
		break;
	}
	
	ret = pthread_setschedparam(this_thread, SCHED_FIFO, &params);
	if (ret != 0) 
	{
		std::cout << "Unsuccessful in setting thread realtime prio" << std::endl;
		return;
	}
}

CActionThread::CActionThread(int id, string refTable, int refId, int recordType, int priority)
{
	mId = id;
	mRefTable = refTable;
	mRefId = refId;
	mRecordType = recordType;
	mPriority = priority;
}

CActionThread::~CActionThread()
{
	#ifdef DEBUGAT
	printf("CActionThread::~CActionThread()\n");
	#endif
}

int CActionThread::start()
{
	CreateActionThread(this);
	return 0;
}

void* CActionThread::ActionThreadProc (void* pVoid)
{
	CActionThread* pThis = (CActionThread*)pVoid;
	#ifdef DEBUGAT
	printf("\nCActionThread::ActionThreadProc(): Inside Thread\n");
	#endif
	if(pThis != NULL)
	{
		pThis->processAction();
	}
	return 0;
}

int CActionThread::processAction()
{
	#ifdef DEBUGAT
	printf("CActionThread::processAction()\n");
	printf("CActionThread::processAction(): mID........ = %d\n", mId);
	printf("CActionThread::processAction(): mRefTable.. = %s\n", mRefTable.c_str());
	printf("CActionThread::processAction(): mRefId..... = %d\n", mRefId);
	printf("CActionThread::processAction(): mRecordType = %d\n", mRecordType);
	printf("CActionThread::processAction(): mPriority.. = %d\n", mPriority);
	#endif
	SetThreadPriority();
	if(!(strcmp(mRefTable.c_str(), "relays")))
	{
		#ifdef DEBUGAT
		printf("\nCActionThread::processAction(): Ref Table Name: %s\n", mRefTable.c_str());
		#endif
		CRelays* pRelaysCmd = new CRelays();
		if(pRelaysCmd == NULL)
		{
			LOG_ERROR("server", "CRelays returned a NULL pointer");
			return 0;
		}
		CRelays pRelaysCmdObj;
		pRelaysCmd->retrieve(pRelaysCmdObj);
		
		#ifdef DEBUGAT
		printf("CActionThread::processAction(): mRefId = %d\n", mRefId);
		printf("CActionThread::processAction(): R1 = %d\n", pRelaysCmdObj.getR1());
		printf("CActionThread::processAction(): R2 = %d\n", pRelaysCmdObj.getR2());
		printf("CActionThread::processAction(): R3 = %d\n", pRelaysCmdObj.getR3());
		printf("CActionThread::processAction(): R4 = %d\n", pRelaysCmdObj.getR4());
		printf("CActionThread::processAction(): R5 = %d\n", pRelaysCmdObj.getR5());
		printf("CActionThread::processAction(): R6 = %d\n", pRelaysCmdObj.getR6());
		#endif
		delete pRelaysCmd;
	}
	else if(!(strcmp(mRefTable.c_str(), "zigbee")))
	{
		#ifdef DEBUGAT
		printf("\nRef Table Name: zigbee\n");
		#endif
		CZigbee* pZigbee = new CZigbee();
		if(pZigbee == NULL)
		{
			LOG_ERROR("server", "CZigbee returned a NULL pointer");
			return 0;
		}
		CZigbee pZigbeeObj;
		pZigbee->retrieve(mRefId, pZigbeeObj);
		pZigbee->retrieveEncryption(mRefId, pZigbeeObj);

		#ifdef DEBUGAT
		printf("CActionThread::processAction(): Channel... = %d\n", pZigbeeObj.getChannel());
		printf("CActionThread::processAction(): PanId..... = %d\n", pZigbeeObj.getPanId());
		printf("CActionThread::processAction(): PanIdSel.. = %d\n", pZigbeeObj.getPanIdSel());
		printf("CActionThread::processAction(): Encryption = %d\n", pZigbeeObj.getEncryption());
		printf("CActionThread::processAction(): SecKey.... = %s\n", pZigbeeObj.getSecKey().c_str());
		#endif
		delete pZigbee;
	}
	else if(!(strcmp(mRefTable.c_str(), "asemp")))
	{
		#ifdef DEBUGAT
		printf("CActionThread::processAction(): Ref Table Name: asemp\n");
		#endif
		CASEMP* pA = new CASEMP();
		if(pA == NULL)
		{
			LOG_ERROR("server", "CASEMP returned a NULL pointer");
			return 0;
		}
		CASEMP pAObj;
		pA->retrieve(mRefId, pAObj);

		#ifdef DEBUGAT
		printf("CActionThread::processAction(): Parameter... = %s\n", pAObj.getParameter().c_str());
		printf("CActionThread::processAction(): Value..... = %d\n", pAObj.getValue());
		#endif
		delete pA;
	}
	else if(!(strcmp(mRefTable.c_str(), "registrations")))
	{
		#ifdef DEBUGAT
		printf("CActionThread::processAction(): Ref Table Name: registrations\n");
		#endif
		CDeviceRegistration* pDevReg = new CDeviceRegistration();	
		if(pDevReg == NULL)
		{
			LOG_ERROR("server", "CDeviceRegistration returned a NULL pointer");
			return 0;
		}
		CDeviceRegistration pDevRegObj;
		pDevReg->retrieve(mRefId, pDevRegObj);

		#ifdef DEBUGAT
		printf("CActionThread::processAction(): ZigbeeShort  = %d\n", pDevRegObj.getZigbeeShort());
		printf("CActionThread::processAction(): ZigbeeAddr64 = %s\n", pDevRegObj.getZigbeeAddr64().c_str());
		#endif
		delete pDevReg;
	}
	else if(!(strcmp(mRefTable.c_str(), "devices")))
	{
		#ifdef DEBUGAT
		printf("CActionThread::processAction(): Ref Table Name: devices\n");
		#endif
		CZigbeeDevice* pZigDev = new CZigbeeDevice(); 
		if(pZigDev == NULL)
		{
			LOG_ERROR("server", "CZigbeeDevice returned a NULL pointer");
			return 0;
		}
		CZigbeeDevice pZigDevObj;
		pZigDev->retrieve(mRefId, pZigDevObj);

		#ifdef DEBUGAT
		printf("CActionThread::processAction(): XbeeAddr64 = %s\n", pZigDevObj.getXbeeAddr64().c_str());
		printf("CActionThread::processAction(): ASEMP..... = %d\n", pZigDevObj.getASEMP());
		printf("CActionThread::processAction(): ZoneId.... = %d\n", pZigDevObj.getZoneId());
		printf("CActionThread::processAction(): DeviceType = %d\n", pZigDevObj.getDeviceType());
		#endif
		delete pZigDev;
	}
	else if(!(strcmp(mRefTable.c_str(), "zonesdyn")))
	{
		#ifdef DEBUGAT
		printf("CActionThread::processAction(): Ref Table Name: zonesdyn\n");
		#endif
		CZone* pZone = new CZone(); 
		if(pZone == NULL)
		{
			LOG_ERROR("server", "CZone returned a NULL pointer");
			return 0;
		}
		CZone pZoneObj;
		pZone->retrieve(mRefId, pZoneObj);
	
		#ifdef DEBUGAT
		printf("CActionThread::processAction(): Occupation = %d\n", pZoneObj.getOcupation());
		#endif
		delete pZone;
	}
	else if(!(strcmp(mRefTable.c_str(), "commands")))
	{
		#ifdef DEBUGAT
		printf("CActionThread::processAction(): Ref Table Name: commands\n");
		#endif
		CCommands* pCmnd = new CCommands();
		if(pCmnd == NULL)
		{
			LOG_ERROR("server", "CCommands returned a NULL pointer");
			return 0;
		}
		printf("MY reference id is :%d \n",mRefId);
		
		CCommands pCmndObj;
		pCmnd->retrieve(mRefId, pCmndObj);

		#ifdef DEBUGAT
		printf("Id........ = %d\n", pCmndObj.getId());
		printf("Command... = %d\n", pCmndObj.getCommand());
		printf("Command... = %x\n", pCmndObj.getCommand());
		printf("Priority.. = %d\n", pCmndObj.getPriority());
		printf("Flags..... = %d\n", pCmndObj.getFlags());
		printf("Type...... = %d\n", pCmndObj.getType());
		printf("Device ID. = %d\n", pCmndObj.getDeviceId());
		printf("Parameters = %s\n", pCmndObj.getParameters().c_str());
		#endif

		switch(pCmndObj.getCommand())
		{
			case SET_RELAY_HVAC:
			{
				CHVAC* pHVAC = new CHVAC(); 
				if(pHVAC == NULL)
				{
					LOG_ERROR("server", "CHVAC returned a NULL pointer");
				}
				else
				{
					CHVAC pHVACObj;
					pHVAC->retrieve(pHVACObj);
					unsigned int pos;
					if((pos = pHVACObj.getW1()) < 2)
						SetRelayPosition(Hal::RELAY_K18, pos);
					if((pos = pHVACObj.getW2()) < 2)
						SetRelayPosition(Hal::RELAY_K22, pos);
					if((pos = pHVACObj.getY1()) < 2)
						SetRelayPosition(Hal::RELAY_K2, pos);
					if((pos = pHVACObj.getY2()) < 2)
						SetRelayPosition(Hal::RELAY_K5, pos);
					if((pos = pHVACObj.getG()) < 2)
						SetRelayPosition(Hal::RELAY_K8, pos);
					if((pos = pHVACObj.getOB()) < 2)
						SetRelayPosition(Hal::RELAY_K10, pos);
					if((pos = pHVACObj.getAux()) < 2)
						SetRelayPosition(Hal::RELAY_K14, pos);
					if((pos = pHVACObj.getRcRh()) < 2)
						SetRelayPosition(Hal::RELAY_K3, pos);
				}
				delete pHVAC;
			}
			break;
			
			case SET_RELAY_AUXILIARY:
			{
				CRelays* pRelays = new CRelays(); 
				if(pRelays == NULL)
				{
					LOG_ERROR("server", "CRelays returned a NULL pointer");
				}
				else
				{
					CRelays pRelaysObj;
					pRelays->retrieve(pRelaysObj);
					SetRelayPosition(Hal::RELAY_K11, pRelaysObj.getR1());
					SetRelayPosition(Hal::RELAY_K15, pRelaysObj.getR2());
					SetRelayPosition(Hal::RELAY_K19, pRelaysObj.getR3());
					SetRelayPosition(Hal::RELAY_K12, pRelaysObj.getR4());
					SetRelayPosition(Hal::RELAY_K16, pRelaysObj.getR5());
					SetRelayPosition(Hal::RELAY_K20, pRelaysObj.getR6());
				}	
				delete pRelays;
			}
			break;
			
			case SET_RELAY_HUMIDIFIER:
			{
				CHumidifier* pHumidifier = new CHumidifier(); 
				if(pHumidifier == NULL)
				{
					LOG_ERROR("server", "CHumidifier returned a NULL pointer");
				}
				else
				{
					CHumidifier pHumidifierObj;
					pHumidifier->retrieve(pHumidifierObj);
					SetRelayPosition(Hal::RELAY_K6, pHumidifierObj.getHumidifier());
				}
				delete pHumidifier;
			}
			break;
			
			case SET_RELAY_RANDOM:		//Command 0x13 = 19
			{
				Hal::TRelayId relay_no;
				switch(atoi(pCmndObj.getParameters().c_str()))
				{
					case 0:
					{
						relay_no = Hal::RELAY_K6;
					}
					break;
					case 1:
					{
						relay_no = Hal::RELAY_K18;
					}
					break;
					case 2:
					{
						relay_no = Hal::RELAY_K22;
					}
					break;
					case 3:
					{
						relay_no = Hal::RELAY_K2;
					}
					break;
					case 4:
					{
						relay_no = Hal::RELAY_K5;
					}
					break;
					case 5:
					{
						relay_no = Hal::RELAY_K8;
					}
					break;
					case 6:
					{
						relay_no = Hal::RELAY_K10;
					}
					break;
					case 7:
					{
						relay_no = Hal::RELAY_K14;
					}
					break;
					case 8:
					{
						relay_no = Hal::RELAY_K3;
					}
					break;
					case 9:
					{
						relay_no = Hal::RELAY_K17;
					}
					break;
					case 10:
					{
						relay_no = Hal::RELAY_K21;
					}
					break;
					case 11:
					{
						relay_no = Hal::RELAY_K1;
					}
					break;
					case 12:
					{
						relay_no = Hal::RELAY_K4;
					}
					break;
					case 13:
					{
						relay_no = Hal::RELAY_K7;
					}
					break;
					case 14:
					{
						relay_no = Hal::RELAY_K9;
					}
					break;
					case 15:
					{
						relay_no = Hal::RELAY_K13;
					}
					break;
					case 16:
					{
						relay_no = Hal::RELAY_K11;
					}
					break;
					case 17:
					{
						relay_no = Hal::RELAY_K15;
					}
					break;
					case 18:
					{
						relay_no = Hal::RELAY_K19;
					}
					break;
					case 19:
					{
						relay_no = Hal::RELAY_K12;
					}
					break;
					case 20:
					{
						relay_no = Hal::RELAY_K16;
					}
					break;
					case 21:
					{
						relay_no = Hal::RELAY_K20;
					}
					break;
				}
				SetRelayPosition(relay_no, true);
			}
			break;
			
			case RESET_RELAY_RANDOM:	//Command 0x14 = 20
			{
				Hal::TRelayId relay_no;
				switch(atoi(pCmndObj.getParameters().c_str()))
				{
					case 0:
					{
						relay_no = Hal::RELAY_K6;
					}
					break;
					case 1:
					{
						relay_no = Hal::RELAY_K18;
					}
					break;
					case 2:
					{
						relay_no = Hal::RELAY_K22;
					}
					break;
					case 3:
					{
						relay_no = Hal::RELAY_K2;
					}
					break;
					case 4:
					{
						relay_no = Hal::RELAY_K5;
					}
					break;
					case 5:
					{
						relay_no = Hal::RELAY_K8;
					}
					break;
					case 6:
					{
						relay_no = Hal::RELAY_K10;
					}
					break;
					case 7:
					{
						relay_no = Hal::RELAY_K14;
					}
					break;
					case 8:
					{
						relay_no = Hal::RELAY_K3;
					}
					break;
					case 9:
					{
						relay_no = Hal::RELAY_K17;
					}
					break;
					case 10:
					{
						relay_no = Hal::RELAY_K21;
					}
					break;
					case 11:
					{
						relay_no = Hal::RELAY_K1;
					}
					break;
					case 12:
					{
						relay_no = Hal::RELAY_K4;
					}
					break;
					case 13:
					{
						relay_no = Hal::RELAY_K7;
					}
					break;
					case 14:
					{
						relay_no = Hal::RELAY_K9;
					}
					break;
					case 15:
					{
						relay_no = Hal::RELAY_K13;
					}
					break;
					case 16:
					{
						relay_no = Hal::RELAY_K11;
					}
					break;
					case 17:
					{
						relay_no = Hal::RELAY_K15;
					}
					break;
					case 18:
					{
						relay_no = Hal::RELAY_K19;
					}
					break;
					case 19:
					{
						relay_no = Hal::RELAY_K12;
					}
					break;
					case 20:
					{
						relay_no = Hal::RELAY_K16;
					}
					break;
					case 21:
					{
						relay_no = Hal::RELAY_K20;
					}
					break;
				}
				SetRelayPosition(relay_no, false);
			}
			break;
			
			case ENUMERATE_ONE_WIRE:
			{
				W1EnumerateDevice();
			}
			break;			

			case READ_ONE_WIRE:
			{
				// Read raw value from 1-wire device
                Hal::TW1DeviceAddress addr;
				::std::stringstream ss;
				ss << std::hex <<  pCmndObj.getParameters();
				ss >> addr;
				GetW1Value(addr);
			}
			break;

			case RTC_SET:
			{
				SetRtc(pCmndObj.getParameters().c_str());
			}
			break;			

			case RTC_GET:
			{
				GetRtc();
			}
			break;			

			case READ_CO_SENSOR:
			{
				// Read CO sensor value
				GetCOValue();				
			}
			break;		

			case READ_ADC_PROBES:
			    GetAdcValue(atoi(pCmndObj.getParameters().c_str()));
			    break;

			case READ_I2C_SENSORS:
			{
				//GetTempHumCo2();				
			}
			break;		

			case SENSOR_LOCAL_ENABLE:
			    OnSensorLocalEnable(pCmnd);
			    break;

			case SENSOR_LOCAL_DISABLE:
			    OnSensorLocalDisable(pCmnd);
			    break;

			case SENSOR_LOCAL_READ_CURR:
			    OnSensorLocalReadCurr(pCmnd);
			    break;

			case SENSOR_LOCAL_SET_UPDATE:
			    OnSensorLocalSetUpdate(pCmnd);
			    break;

			case SENSOR_LOCAL_SET_HIGH:
			{
				CSmartDevices* pDevSmartHT = new CSmartDevices();
				if(pDevSmartHT == NULL)
				{
					LOG_ERROR("server", "CCommands returned a NULL pointer");
					return 0;
				}
				CSmartDevices pDevSmartHTObj;
				pDevSmartHT->retrieveHighThr(atoi(pCmndObj.getParameters().c_str()), pDevSmartHTObj);
				SetAdcHigh(atoi(pDevSmartHTObj.getAddress().c_str()),
				        pDevSmartHTObj.getHighThr());
				delete pDevSmartHT;
			}
			break;		

			case SENSOR_LOCAL_SET_LOW:
			{
				CSmartDevices* pDevSmartLT = new CSmartDevices();
				if(pDevSmartLT == NULL)
				{
					LOG_ERROR("server", "CCommands returned a NULL pointer");
					return 0;
				}
				CSmartDevices pDevSmartLTObj;
				pDevSmartLT->retrieveLowThr(atoi(pCmndObj.getParameters().c_str()), pDevSmartLTObj);
				SetAdcLow(atoi(pDevSmartLTObj.getAddress().c_str()),
				        pDevSmartLTObj.getLowThr());
				delete pDevSmartLT;
			}
			break;		

// ****************************** ZIGBEE COMMANDS ************************************* //

			case ZIGBEE_RESET_RADIO_MODULE:
			{
			#if 0 // Reserved for future use
				unsigned long long int addr64;		
				::std::stringstream ss;
				ss << std::hex << pCmndObj.getParameters();
				ss >> addr64;
				ZigbeeResetRadioModule(addr64);
			#endif	
			}
			break;		

			case ZIGBEE_CREATE_NETWORK_CMD:
			{
				ZigbeeCreateNetwork(atoi(pCmndObj.getParameters().c_str()));
			}
			break;		

			case ZIGBEE_SET_PANID_CMD:
			{
			#if 0 // Reserved for future use
				ZigbeeSetPanId(atoi(pCmndObj.getParameters().c_str()));
			#endif
			}
			break;		

			case ZIGBEE_SET_RFCHANNEL_CMD:
			{
			#if 0 // Reserved for future use
				ZigbeeSetRFChannel(atoi(pCmndObj.getParameters().c_str()));
			#endif
			}
			break;		

			case ZIGBEE_SET_SECURITY_CMD:
			{
			#if 0 // Reserved for future use
				ZigbeeSetSecurity(atoi(pCmndObj.getParameters().c_str()));
			#endif
			}
			break;		

			case ZIGBEE_ALLOW_NEWDEV_CMD:
			{
				std::string param = pCmndObj.getParameters();
				std::istringstream buf(param);
				std::istream_iterator<std::string> beg(buf), end;
				std::vector<std::string> tokens(beg, end); // done!				

				fprintf(stderr, "Token @ 0 = %d\n", atoi(tokens[0].c_str()));				
				fprintf(stderr, "Token @ 1 = %d\n", atoi(tokens[1].c_str()));

				bool allow = (bool)atoi(tokens[0].c_str());
				int interval;
				
				if (!(strcmp(tokens[1].c_str(), "")))
				{
					interval = 120;		//Default interval value
				}
				else
				{
					interval = atoi(tokens[1].c_str());
				}
				ZigbeeAllowNewDevice(allow, interval);
			}
			break;		

			case ZIGBEE_REMOVE_DEV_CMD:
			{
				ZigbeeRemoveDevice(atoi(pCmndObj.getParameters().c_str()));
			}
			break;		

			case ZIGBEE_ROUTE_DISCOVERY_CMD:
			{
				ZigbeeDiscoverRoute();
			}
			break;			

			case ZIGBEE_PING_DEVICE_CMD:
			{
			#if 0 // Reserved for future use
				ZigbeePingRemoteDev(pCmndObj.getDeviceId());
			#endif
			}
			break;			

			case ZIGBEE_ENABLE_ZED:
			{
				#ifdef EMULATOR
				RemoteStatusRequest1(pCmndObj.getDeviceId());
				#endif
				ZigbeeEnableZedDev(pCmndObj.getDeviceId());
			}
			break;

			case SET_AC_ONOFF_DIGI:
			{
				ZigbeeEnableDigiAC(pCmndObj.getDeviceId());
			}
			break;

			case READ_AC_CURRENT:
			{
				ZigbeeReadCurrent(pCmndObj.getDeviceId());
			}
			break;

			case RESPONSE_REGISTERATION:
			{			
				ASEMProfile* aseMProfile = new ASEMProfile();
				ZigbeeRegistrationResponse(pCmndObj.getDeviceId(), aseMProfile);
				delete aseMProfile;

				#ifdef EMULATOR
				RegistrationResponse * registrationResponse = new RegistrationResponse();
				RegistrationResponse1(NULL, pCmndObj.getDeviceId(), registrationResponse);
				delete registrationResponse;
				#endif
			}
			break;

			case CENTRAL_COMMAND_REQUEST:
			{
				CentralCommandRequest *centralCommandRequest = new CentralCommandRequest();
				centralCommandRequest->ASEMPMobj.protocolID = 0XF3;
				centralCommandRequest->command_type = pCmndObj.getType();
				centralCommandRequest->command_data = atoi(pCmndObj.getParameters().c_str());
				centralCommandRequest->deviceID = pCmndObj.getDeviceId();
				ZigbeeCentralCommandRequest(pCmndObj.getDeviceId(), centralCommandRequest);
				delete centralCommandRequest;

				#ifdef EMULATOR
				switch(pCmndObj.getType())
				{
					case 0:
						centralCommandRequest->louver_pos = atoi(pCmndObj.getParameters().c_str());
					break;
					case 1:
						centralCommandRequest->ac_dev_time = 1;
					break;
					case 2:
						centralCommandRequest->ac_dev_time = 0;
					break;
					case 3:
						centralCommandRequest->dimmer_val = atoi(pCmndObj.getParameters().c_str());
					break;
					case 4:
						centralCommandRequest->unsoli_reporting_int = atoi(pCmndObj.getParameters().c_str());
					break;
					case 5:
						centralCommandRequest->req_unsoli_info = 1;
					break;
					case 6:
						centralCommandRequest->led_alarm = 1;
					break;
					case 7:
						centralCommandRequest->led_alarm = 0;
					break;
					case 8:
						centralCommandRequest->aud_alarm = 1;
					break;
					case 9:
						centralCommandRequest->aud_alarm = 0;
					break;
					case 10:
						centralCommandRequest->relay = 1;
						centralCommandRequest->relay_id = atoi(pCmndObj.getParameters().c_str());
					break;
					case 11:
						centralCommandRequest->relay = 0;
						centralCommandRequest->relay_id = atoi(pCmndObj.getParameters().c_str());
					break;
					case 12:
					break;
					default:
						LOG_ERROR("server", "Incorrect type passed as an argument");
					break;
				}

				CRemoteControl* RemContCmnds = CRemoteControl::getInstance();
				if(RemContCmnds == NULL)
				{
					LOG_ERROR("server", "RemContCmnds returned a NULL pointer");
					return 0;
				}
				centralCommandRequest->ack_requester = RemContCmnds->getRemoteAck();
				CentralCommandRequest1(NULL, pCmndObj.getDeviceId(), centralCommandRequest);

				ZigbeeCentralRequest(pCmndObj.getDeviceId(), centralCommandRequest);
				#endif
			}
			break;

			case ASEMP_PROFILE_UPDATE:
			{
				UpdateProfileRequest * asempProfile = new UpdateProfileRequest();
				#ifdef EMULATOR
				UpdateProfileRequest1(NULL, pCmndObj.getDeviceId(), asempProfile);
				#endif
				ZigbeeUpdateProfile(pCmndObj.getDeviceId(), asempProfile);
				delete asempProfile;
			}
			break;
// ************************************************************************************ //
		}
		delete pCmnd;
		pCmnd = NULL;
	}
	else
	{
		LOG_ERROR_FMT("server", "No retrieve method defined for table %s", mRefTable.c_str());
		#ifdef DEBUGAT
		printf("CActionThread::processAction(): This table doesn't have a retrieve() method\n");
		#endif
	}
	#ifdef DEBUGAT
	printf("CActionThread::processAction(): Thread Terminated\n");
	#endif
	delete this;
	return 0;
}

void CActionThread::CreateActionThread(CActionThread* const actionThread)
{
	int err;
	pthread_t thrd_id=0;
	err = pthread_create(&(thrd_id), NULL, &ActionThreadProc, actionThread);
	if (err != 0)
	{
        LOG_ERROR("server", "Error in creating thread");
	}
    else
	{
		#ifdef DEBUGAT
        printf("CActionThread::CreateActionThread(): Action Thread created\n");
		#endif
		if(!pthread_detach(thrd_id))
		{
			#ifdef DEBUGAT
			printf("CActionThread::CreateActionThread(): Detached\n");
			#endif
		}
	}
}

void CActionThread::OnSensorLocalEnable(CCommands *const pCmnds)
{
    // Enable local sensor
    CSmartDevices* pDevSmart = new CSmartDevices();
    if(pDevSmart == NULL)
    {
        LOG_ERROR("server", "CCommands returned a NULL pointer");
    }
    else
    {
		CSmartDevices pDevSmartObj;
        pDevSmart->retrieve(atoi(pCmnds->getParameters().c_str()), pDevSmartObj);

        if(pDevSmartObj.getInterface() == CSmartDevices::TInterface::W1)          //interface = 1wire
        {
            Hal::TW1DeviceAddress address;
            ::std::stringstream ss;
            ss << std::hex << pDevSmartObj.getAddress();
            ss >> address;

            cout << "Address In ActionThread is : " << address << '\n';

            W1PeriodicUpdate(address, pDevSmartObj.getInterval());
            std::string str;
            ss >> str;
            LOG_INFO_FMT("server", "The 1-wire device with address %s is disabled", str.c_str());
        }
        else if (pDevSmartObj.getInterface() == CSmartDevices::TInterface::I2C)         //interface = i2c
        {
            switch(pDevSmartObj.getType())
            {
                case CSmartDevices::TDevice::ONBOARD_CO2_SENSOR:
                    {
                        if(hal_init_err)
                        {
                            LOG_ERROR("server", "HAL is not initialized");
                        }
                        else
                        {
                            Co2PeriodicUpdate(pDevSmartObj.getInterval());
                            LOG_INFO("server", "CO2 device is enabled");
                        }
                    }
                    break;

                case CSmartDevices::TDevice::ONBOARD_TEMPERATURE_SENSOR:
                    {
                        if(hal_init_err)
                        {
                            LOG_ERROR("server", "HAL is not initialized");
                        }
                        else
                        {
                            TemperaturePeriodicUpdate(pDevSmartObj.getInterval());
                            LOG_INFO("server", "Temp Periodic Update enabled");
                        }
                    }
                    break;

                case CSmartDevices::TDevice::ONBOARD_HUMIDITY_SENSOR:
                    {
                        if(hal_init_err)
                        {
                            LOG_ERROR("server", "HAL is not initialized");
                        }
                        else
                        {
                            HumidityPeriodicUpdate(pDevSmartObj.getInterval());
                            LOG_INFO("server", "Humidity Periodic Update enabled");
                        }
                    }
                    break;

                default:
                    LOG_WARN_FMT("server", "Unhandled device type %u",
                            pDevSmartObj.getType());
                    break;
            } // switch
        }
        else if (pDevSmartObj.getInterface() == CSmartDevices::TInterface::ADC)         //interface = i2c
        {
            const int channel = atoi(pDevSmartObj.getAddress().c_str());
            if (1 == channel)
            {
                CoPeriodicUpdate(pDevSmartObj.getInterval());
                LOG_INFO("server", "CO device is enabled");
            }
            SetAdcLow(channel, pDevSmartObj.getLowThr());
            SetAdcHigh(channel, pDevSmartObj.getHighThr());
            AdcPeriodicUpdate(channel, pDevSmartObj.getInterval());
            LOG_INFO_FMT("server", "ADC channel %i enabled", channel);
        }
        else
        {
            LOG_WARN_FMT("server", "Unhandled interface type %u",
                    pDevSmartObj.getInterface());
        }
    }
	delete pDevSmart;
}

void CActionThread::OnSensorLocalDisable(CCommands *const pCmnds)
{
    // Disable local sensor
    CSmartDevices* pDevSmart = new CSmartDevices();
    if(pDevSmart == NULL)
    {
        LOG_ERROR("server", "CCommands returned NULL pointer");
    }
    else
    {
		CSmartDevices pDevSmartObj;
        pDevSmart->retrieve(atoi(pCmnds->getParameters().c_str()),pDevSmartObj);
        cout << "Parameter in " << __func__ << " is: " << pCmnds->getParameters() << '\n';

        if(pDevSmartObj.getInterface() == CSmartDevices::TInterface::W1)          //interface = 1wire
        {
            Hal::TW1DeviceAddress address;
            ::std::stringstream ss;
            ss << std::hex << pDevSmartObj.getAddress();
            ss >> address;
            cout << "Address in "<< __func__ <<" is: " << address << '\n';

            W1PeriodicUpdate(address, 0);
            std::string str;
            ss >> str;
            LOG_INFO_FMT("server", "The 1-wire device with address %s is disabled now", str.c_str());
        }
        else if (pDevSmartObj.getInterface() == CSmartDevices::TInterface::I2C)         //interface = i2c
        {
            switch(pDevSmartObj.getType())
            {
                case CSmartDevices::TDevice::ONBOARD_CO2_SENSOR:
                    {
                        if(hal_init_err)
                        {
                            LOG_ERROR("server", "HAL is not initialized");
                        }
                        else
                        {
                            Co2PeriodicUpdate(0);
                            LOG_INFO("server", "CO2 device is disabled");
                        }
                    }
                    break;

                case CSmartDevices::TDevice::ONBOARD_TEMPERATURE_SENSOR:
                    {
                        if(hal_init_err)
                        {
                            LOG_ERROR("server", "HAL is not initialized");
                        }
                        else
                        {
                            TemperaturePeriodicUpdate(0);
                            LOG_INFO("server", "The Temperature Periodic Update is disabled");
                        }
                    }
                    break;

                case CSmartDevices::TDevice::ONBOARD_HUMIDITY_SENSOR:
                    {
                        if(hal_init_err)
                        {
                            LOG_ERROR("server", "HAL is not initialized");
                        }
                        else
                        {
                            HumidityPeriodicUpdate(0);
                            LOG_INFO("server", "Humidity Periodic Update is disabled");
                        }
                    }
                    break;

                default:
                    LOG_WARN_FMT("server", "Unhandled device type %u",
                            pDevSmartObj.getType());
                    break;
            } // switch
        }
        else if (pDevSmartObj.getInterface() == CSmartDevices::TInterface::ADC)         //interface = i2c
        {
            const int channel = atoi(pDevSmartObj.getAddress().c_str());
            if (1 == channel)
            {
                CoPeriodicUpdate(0);
                LOG_INFO("server", "CO device is disabled");
            }
            SetAdcLow(channel, 0);
            SetAdcHigh(channel, 0);
            AdcPeriodicUpdate(channel, 0);
            LOG_INFO_FMT("server", "ADC channel %i disabled", channel);
        }
        else
        {
            LOG_WARN_FMT("server", "Unhandled interface type %u",
                    pDevSmartObj.getInterface());
        }
    }
	delete pDevSmart;
}

void CActionThread::OnSensorLocalReadCurr(CCommands *const pCmnds)
{
    // Read current value
    std::string str = pCmnds->getParameters();
    std::istringstream buf(str);
    std::istream_iterator<std::string> beg(buf), end;
    std::vector<std::string> tokens(beg, end); // done!
    fprintf(stderr, "Token @ 0 = %d\n", atoi(tokens[0].c_str()));
    fprintf(stderr, "Token @ 1 (string)= %s\n", tokens[1].c_str());

    CSmartDevices* pDevSmart = new CSmartDevices();
    if(pDevSmart == NULL)
    {
        LOG_ERROR("server", "CSmartDevices returned a NULL pointer");
    }
    else
    {
		CSmartDevices pDevSmartObj;
        pDevSmart->retrieve(atoi(pCmnds->getParameters().c_str()), pDevSmartObj);
        switch (atoi(tokens[0].c_str()))
        {
            case 0:
            {
                pDevSmart->retrieveStatus(CSmartDevices::TDevice::ONBOARD_CO2_SENSOR, pDevSmartObj);
                if(pDevSmartObj.getStatus())
                {
                    GetCO2Value();
                }
            }
            break;
            case 1:
            {
                pDevSmart->retrieveStatus(CSmartDevices::TDevice::ONBOARD_CO_SENSOR, pDevSmartObj);
                if(pDevSmartObj.getStatus())
                {
                    GetCOValue();
                }
            }
            break;
            case 2:
            {
                fprintf(stderr, "Token @ 1 = %d\n", atoi(tokens[1].c_str()));
                pDevSmart->retrieveStatus(CSmartDevices::TDevice::ONBOARD_TEMPERATURE_SENSOR, pDevSmartObj);
                if(pDevSmartObj.getStatus())
                {
                    GetTemperatureValue(atoi(tokens[1].c_str()));
                }
            }
            break;
            case 3:
            {
                fprintf(stderr, "Token @ 1 = %d\n", atoi(tokens[1].c_str()));
                pDevSmart->retrieveStatus(CSmartDevices::TDevice::ONBOARD_HUMIDITY_SENSOR, pDevSmartObj);
                if(pDevSmartObj.getStatus())
                {
                    GetHumidityValue(atoi(tokens[1].c_str()));
                }
            }
            break;

            case 4:
                pDevSmart->retrieve1WDevStatus(tokens[1], pDevSmartObj);
                if(pDevSmartObj.getStatus())
                {
                    Hal::TW1DeviceAddress addr;
                    ::std::stringstream ss;
                    ss << std::hex << tokens[1];
                    ss >> addr;
                    cout << "Val of addr, Token @ 1 for 1-wire devices:" << addr << '\n';
                    GetW1Value(addr);
                }
                else
                {
                    LOG_INFO_FMT("server", "The 1-wire device with address %s is disabled", tokens[1].c_str());
                }
                break;

            case 5:
                pDevSmart->retrieveStatusInt(CSmartDevices::TInterface::ADC, atoi(tokens[1].c_str()), pDevSmartObj);
                if (pDevSmartObj.getStatus())
                {
                    GetAdcValue(atoi(tokens[1].c_str()));
                }
                break;
        }
    }
	delete pDevSmart;
}

void CActionThread::OnSensorLocalSetUpdate(CCommands *const pCmnds)
{
    CSmartDevices* pDevSmart = new CSmartDevices();
    if(pDevSmart == NULL)
    {
        LOG_ERROR("server", "CSmartDevices returned a NULL pointer");
    }
    else
    {
		CSmartDevices pDevSmartObj;
        pDevSmart->retrieve(atoi(pCmnds->getParameters().c_str()), pDevSmartObj);
        if(pDevSmartObj.getInterface() == CSmartDevices::TInterface::W1)          //interface = 1wire
        {
            if(pDevSmartObj.getStatus())
            {
                Hal::TW1DeviceAddress address;
                ::std::stringstream ss;
                ss << std::hex << pDevSmartObj.getAddress();
                ss >> address;
                cout << "Address is in Action Thread: " << address << '\n';

                W1PeriodicUpdate(address, pDevSmartObj.getInterval());
                LOG_INFO_FMT("server", "The 1-wire device with address %s is enabled", pDevSmart->getAddress().c_str());
            }
            else
            {
                LOG_INFO_FMT("server", "The 1-wire device with address %s is disabled", pDevSmart->getAddress().c_str());
            }
        }
        else if (pDevSmartObj.getInterface() == CSmartDevices::TInterface::I2C)         //interface = i2c
        {
            switch(pDevSmartObj.getType())
            {
                case CSmartDevices::TDevice::ONBOARD_CO2_SENSOR:
                {
                    if(pDevSmartObj.getStatus())
                    {
                        Co2PeriodicUpdate(pDevSmartObj.getInterval());
                        LOG_INFO("server", "CO2 device is enabled");
                    }
                    else
                    {
                        LOG_INFO("server", "CO2 device is disabled");
                    }

                }
                break;

                case CSmartDevices::TDevice::ONBOARD_CO_SENSOR:
                {
                    if(pDevSmartObj.getStatus())
                    {
                        CoPeriodicUpdate(pDevSmartObj.getInterval());
                        LOG_INFO("server", "CO device is enabled");
                    }
                    else
                    {
                        LOG_INFO("server", "CO device is disabled");
                    }
                }
                break;

                case CSmartDevices::TDevice::ONBOARD_TEMPERATURE_SENSOR:
                {
                    if(pDevSmartObj.getStatus())
                    {
                        if(hal_init_err)
                        {
                            LOG_ERROR("server", "HAL is not initialized");
                        }
                        else
                        {
                            TemperaturePeriodicUpdate(pDevSmartObj.getInterval());
                            LOG_INFO("server", "Temperature Periodic Update enabled");
                        }
                    }
                    else
                    {
                        LOG_INFO("server", "Temperature Periodic Update disabled");
                    }
                }
                break;

                case CSmartDevices::TDevice::ONBOARD_HUMIDITY_SENSOR:
                {
                    if(pDevSmartObj.getStatus())
                    {
                        HumidityPeriodicUpdate(pDevSmartObj.getInterval());
                        LOG_INFO("server", "HumidityPeriodicUpdate is enabled");
                    }
                    else
                    {
                        LOG_INFO("server", "HumidityPeriodicUpdate is disabled");
                    }
                }
                break;
            }
        } // i2c
        else if (pDevSmartObj.getInterface() == CSmartDevices::TInterface::ADC)         //interface = i2c
        {
            if(pDevSmartObj.getStatus())
            {
                const int channel = atoi(pDevSmartObj.getAddress().c_str());
                switch(channel)
                {
                case 1:
                    CoPeriodicUpdate(pDevSmartObj.getInterval());
                    LOG_INFO("server", "CO device is enabled");
                    break;

                case 2:
                case 3:
                case 4:
                    AdcPeriodicUpdate(channel, pDevSmartObj.getInterval());
                    LOG_INFO_FMT("server", "ADC channel %i enabled", channel);
                    break;
                } // switch
            }
            else
            {
                LOG_INFO_FMT("server", "The device (%d) is not enabled",
                        pDevSmartObj.getType());
            }
        }
        else
        {
            LOG_WARN_FMT("server", "Unhandled interface type %u",
                    pDevSmartObj.getInterface());
        }
    }
	delete pDevSmart;
}
