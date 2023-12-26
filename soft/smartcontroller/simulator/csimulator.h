#include <iostream>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <pthread.h>
#include <sys/types.h>
#include "inc/ASEMPImpl.h"
#define CLIENT_PORT 12345

class CSimulator
{
        static CSimulator* mInstance;
        //static int initClient(const char* ip, int port,ASEMProfile *profile);
		static int initClient(const char* ip, int port);
        static void OnServerDisconnect();
        
        CSimulator(char *ipAddress, int portNum,char* Unsolicited_file);
        static void* UnsolicitedReqThreadProc (void* lpdwThreadParam );
        public:
	    //ASEMProfile *mASEMProfile;
        static CSimulator* getInstance(char *ipAddress, int portNum,char* Unsolicited_file);
        static CSimulator* getInstance();
        int SimulatorThread(RegistrationRequest *);
        public:
	
        void * retrieveFromDatabaseFile(char* filename,int type,void* pDevice);
        int SaveToDatabaseFile();
		int thisSocket1;
		static void OnMessageReceivedClient(void* pServer,char* buffer ,int len);
		void UnsolicitedReqThreadFunc ( );
};
	int Send(char* buffer,int len);

	
//typedef  void* (CSimulator::*CSimulatorPtr)(void*);
//typedef  void* (*PthreadPtr)(void*);
