#include <cassert>
#include <iostream>
#include "mux_demux/mux_demux.h"
#include "mux_demux/mux_demux_intf.h"
#include "mux_demux/hal.h"
#include "db/Database.h"
#include "db/SmartDevices.h"
#include "util/log/log.h"
#include "zigbee/zigbee_sync.h"
#include "mux_demux/zigbee_cb.h"


static const char s_sql_server_ip[] = "127.0.0.1";
extern volatile int hal_init_err;
extern volatile int zigbee_error;

#ifndef UDF_USE_PIPE
#define SERVER_PORT     93214
#define MUXDEMUX_PORT   12345
#endif

void* db_muxdemux(void* args)
{
#ifdef UDF_USE_PIPE
    RunDbNotificationsListener();
#else
    initServer(SERVER_PORT);
    closeServer();
#endif
    return 0;
}

#ifndef UDF_USE_PIPE
void db_handler(int s)
{
    printf("Caught signal %d\n",s);
    printf("Shutting down Client connection\n");

    char query[100];
    VRECORD record;
    sprintf(query, "SELECT shutClient();");
    int result = pdb->dbQuery(query, record);
    if(result > 0)
    {
        LOG_INFO("server", "MuxDemux-DB client Shut down");
        fprintf(stderr, "Client shutdown\n");
    }
    printf("\nDB Query Result = %d\n", result);
    closeServer();
    exit(1);
}
#endif


/**
 * @brief 
 * 
 * @param user 
 * @param password 
 * @param database 
 * @return int 
 */
int MuxDemuxInit(const ::std::string& user,
        const ::std::string& password, const ::std::string& database)
{
    // input arguments are references to : 
    // user string type         username
    // password string type     password
    // database string type     database related ?


    // ::CLog::getInstance()->info(section, __LINE__, __FILE__, msg);
    // log information using CLog class -> getInstance() using -> section ("server"), filename (log.h), line number, message ("Starting Server!!!")
    LOG_INFO("server", "Starting Server!!!");



    // writing message to standard error stream
    fprintf(stderr, "Getting DB instance\n");

    
    CDatabase* const pdb =
            CDatabase::getInstance(s_sql_server_ip, user, password, database);
    if(pdb ==NULL)
    {
        fprintf(stderr,"Database instance is not created\n");
        return -1;
    }


    fprintf(stderr, "Initializing HAL\n");
    if (Hal::Init())
    {
        hal_init_err = 1;
        LOG_ERROR("server", "HAL is not initialized");

        return -1;
    }
    else
    {
        hal_init_err = 0;
        LOG_INFO("server", "HAL initialized successfully");
        Hal::InterruptsRegisterHandler(OnInterrupt);
        W1EnumerateDevice();
        GetRtc();
        GetInterruptsStatus();


        CSmartDevices *const pDevSmart = new CSmartDevices();//::getInstance();
        assert(pDevSmart);
		
		CSmartDevices pDevSmartObj;
        pDevSmart->retrieveStatus(CSmartDevices::TDevice::ONBOARD_CO2_SENSOR, pDevSmartObj);
        if (pDevSmartObj.getStatus())
        {
            pDevSmart->retrieveInt(CSmartDevices::TDevice::ONBOARD_CO2_SENSOR, pDevSmartObj);
            Co2PeriodicUpdate(pDevSmartObj.getInterval());
        }

        pDevSmart->retrieveStatus(CSmartDevices::TDevice::ONBOARD_CO_SENSOR, pDevSmartObj);
        if (pDevSmartObj.getStatus())
        {
            pDevSmart->retrieveInt(CSmartDevices::TDevice::ONBOARD_CO_SENSOR, pDevSmartObj);
            CoPeriodicUpdate(pDevSmartObj.getInterval());
        }

        pDevSmart->retrieveStatus(CSmartDevices::TDevice::ONBOARD_TEMPERATURE_SENSOR, pDevSmartObj);
        if (pDevSmartObj.getStatus())
        {
            pDevSmart->retrieveInt(CSmartDevices::TDevice::ONBOARD_TEMPERATURE_SENSOR, pDevSmartObj);
            TemperaturePeriodicUpdate(pDevSmartObj.getInterval());
        }

        pDevSmart->retrieveStatus(CSmartDevices::TDevice::ONBOARD_HUMIDITY_SENSOR, pDevSmartObj);
        if (pDevSmartObj.getStatus())
        {
            pDevSmart->retrieveInt(CSmartDevices::TDevice::ONBOARD_HUMIDITY_SENSOR, pDevSmartObj);
            HumidityPeriodicUpdate(pDevSmartObj.getInterval());
        }

        for(int ch = 1; ch <= 4; ch++)
        {
            pDevSmart->retrieveStatusInt(CSmartDevices::TInterface::ADC, ch, pDevSmartObj);
            if (pDevSmartObj.getStatus())
            {
                pDevSmart->retrieveThrs(CSmartDevices::TInterface::ADC, ch, pDevSmartObj);

                SetAdcLow(ch, pDevSmartObj.getLowThr());
                SetAdcHigh(ch, pDevSmartObj.getHighThr());

                pDevSmart->retrieveIntInt(CSmartDevices::TInterface::ADC, ch, pDevSmartObj);
                AdcPeriodicUpdate(ch, pDevSmartObj.getInterval());
            }
            else
            {
                // It will prevent generating ADC interrupts.
                SetAdcLow(ch, 0);
                SetAdcHigh(ch, 0);
            }
        }
		delete pDevSmart;
        return 0;
    }
}

int MuxDemuxRun()
{
#ifdef UDF_USE_PIPE
    fprintf(stderr, "Initializing DB notifications listener\n");
    if (InitDbNotificationsListener())
    {
        return -1;
    }
#endif


    pthread_t tid=0;
    int err;
    fprintf(stderr, "Creating thread for db-muxdemux\n");
    err=pthread_create(&tid,NULL,db_muxdemux,NULL);
    if (err != 0)
    {
        fprintf(stderr, "Error Creating Thread for db_muxdemux\n");
    }
    else
    {
        fprintf(stderr, "Thread created for  db_muxdemux\n");
    }

#ifdef EMULATOR
    pthread_t tid1=0;
    fprintf(stderr, "Creating thread for muxdemux-remote\n");
    err=pthread_create(&tid1,NULL,muxdemux_remote,NULL);
    if (err != 0)
    {
        fprintf(stderr, "Error Creating Thread for muxdemux_remote\n");
    }
    else
    {
        fprintf(stderr, "Thread created for  muxdemux_remote\n");
    }
#endif


#ifndef UDF_USE_PIPE
    struct sigaction sigIntHandler;
    sigIntHandler.sa_handler = db_handler;
    sigemptyset(&sigIntHandler.sa_mask);
    sigIntHandler.sa_flags = 0;
    sigaction(SIGINT, &sigIntHandler, NULL);

//	initClient(SERVER_IP, SERVER_PORT);

    char query[100];
    VRECORD record;
    fprintf(stderr, "Initializing client\n");
    sprintf(query, "SELECT initClient();");
    int result = pdb->dbQuery(query, record);
    LOG_INFO("server", "MuxDemux-DB client initialized");
    printf("\nDB Query Result = %d\n", result);
#endif

    pthread_join(tid,NULL);
    #ifdef EMULATOR
    pthread_join(tid1,NULL);
    #endif
    return 0;
}
