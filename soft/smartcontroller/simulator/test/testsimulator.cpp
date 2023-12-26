#include <pthread.h>
#include "util/ini.h" 
#include "net/stdafx.h"
#include "net/tcp_socket_mux.h"
#include "inc/ASEMPImpl.h"
#include "simulator/csimulator.h"


int
main (int argc, char *argv[])
{
	#ifdef DEBUG
	fprintf(stderr,"In %s \n",__func__);
	#endif

	if(argc!=3)
	{
		std::cout<<"please enter Device config file and Unsoli ini file to read \n";
		exit(0);
	}
	fprintf(stderr,"first argument :%s \nsecond argument is : %s \n",argv[1],argv[2]);
	char *addr="127.0.0.1";
      		
	//CSimulator::getInstance(addr,CLIENT_PORT,argv[1],argv[2]);	
	initializer(addr,CLIENT_PORT,argv[1],argv[2]);
	fprintf(stderr,"UNREGISTERED -- To register ENTER 1 \n");
	while(1)
	{
		sleep(60);
		fprintf(stderr,"Client's Simulator functioning\n");
	}
	/*RegistrationRequest *pDevice = new RegistrationRequest();	
	pDevice = (RegistrationRequest *)CSimulator::getInstance()->retrieveFromDatabaseFile ("./config/CSimulator.ini",1,(void*)pDevice);
    CSimulator::getInstance()->SimulatorThread(pDevice);
	delete pDevice;*/	
  return 0;
}
