#include <pthread.h>
#include "util/ini.h" 
#include "inc/ASEMPImpl.h"
#include "simulator/csimulator_zigbee.h"



int main(int argc,char* argv[])
{
	#ifdef DEBUG
	fprintf(stderr,"In %s \n",__func__);
	#endif
	if(argc!=3)
	{
		fprintf(stderr,"please enter Device config file and Unsoli ini file to read \n \
					   ./testsimulatorz ./config/CSimulator./config/UnSoli.ini \n \
					   For further detailed instructions Read : smartcontroller/simulator/Readme.md \n");
		exit(0);
	}        
	fprintf(stderr,"first argument :%s \nsecond argument is : %s \n",argv[1],argv[2]);
	
	
	//if(atoi(argv[2])==2)
	//{	
	//	strcpy(gUnsolicited_file, argv[1]);
	//	fprintf(stderr,"Name of file entered is :%s\n",gUnsolicited_file);
	//}
	//gPort=portNum;
	initializer(argv[1],argv[2]);
	fprintf(stderr,"UNREGISTERED -- To register ENTER 1 \n");
	while(1)
	{
		sleep(60);
		fprintf(stderr,"Client's Simulator functioning\n");
	}
/*	scanf("%d",&input);
	if (input == 1)
	{
		RegistrationRequest *pDevice = (RegistrationRequest*) malloc(sizeof(RegistrationRequest));	
		pDevice = (RegistrationRequest *)retrieveFromDatabaseFile ("./config/CSimulator.ini",1,(void*)pDevice);
		SimulatorThread(pDevice);
		free(pDevice);
		while(1)
		{
			sleep(60);
			fprintf(stderr,"Client's Simulator functioning\n");
		}
	}
*/
	#ifdef DEBUG
	fprintf(stderr,"Out %s \n",__func__);
	#endif
	return 0;

}