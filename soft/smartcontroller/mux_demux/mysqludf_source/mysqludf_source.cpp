#define DLLEXP

#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include <mysql/mysql.h>
#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#ifndef UDF_USE_PIPE
# include "mux_demux/MuxDemuxIntf.h"
# include "mux_demux/test/TestMuxDemux.cpp"
#endif
#ifdef	__cplusplus
extern "C" {
#endif

#define SETENV(name,value)		setenv(name,value,1);

DLLEXP my_bool initClient_init(UDF_INIT *initid, UDF_ARGS *args, char *message);
DLLEXP void initClient_deinit(UDF_INIT *initid __attribute__((unused)));
DLLEXP char *initClient(UDF_INIT *initid __attribute__((unused)), UDF_ARGS *args, char *result, unsigned long *length, char *is_null, char *error __attribute__((unused)));
 
DLLEXP my_bool notifyMuxDemux_init(UDF_INIT *initid, UDF_ARGS *args, char *message);
DLLEXP void notifyMuxDemux_deinit(UDF_INIT *initid __attribute__((unused)));
DLLEXP char *notifyMuxDemux(UDF_INIT *initid __attribute__((unused)), UDF_ARGS *args, char *result, unsigned long *length, char *is_null, char *error __attribute__((unused)));

DLLEXP my_bool closeClient_init(UDF_INIT *initid, UDF_ARGS *args, char *message);
DLLEXP void closeClient_deinit(UDF_INIT *initid __attribute__((unused)));
DLLEXP char *closeClient(UDF_INIT *initid __attribute__((unused)), UDF_ARGS *args, char *result, unsigned long *length, char *is_null, char *error __attribute__((unused)));

DLLEXP my_bool shutClient_init(UDF_INIT *initid, UDF_ARGS *args, char *message);
DLLEXP void shutClient_deinit(UDF_INIT *initid __attribute__((unused)));
DLLEXP char *shutClient(UDF_INIT *initid __attribute__((unused)), UDF_ARGS *args, char *result, unsigned long *length, char *is_null, char *error __attribute__((unused)));

#ifdef	__cplusplus
}
#endif

//using namespace std;

#define SERVER_PORT 93214

my_bool initClient_init(UDF_INIT *initid, UDF_ARGS *args, char *message) {
	if (args->arg_count != 0)
	{
		strcpy(message,"Wrong arguments to sockets;  Use the source");
		return 1;
	}	
	FILE *fd=fopen("/tmp/op.txt","a");
	fprintf(fd,"Inside initClient_init\n");
	fclose(fd);
	return 0;
}

void initClient_deinit(UDF_INIT *initid __attribute__((unused))) {
	FILE *fd=fopen("/tmp/op.txt","a");
	fprintf(fd,"Inside initClient_deinit\n");
	fclose(fd);
}

char *initClient(UDF_INIT *initid __attribute__((unused)), UDF_ARGS *args, char *result, unsigned long *length, char *is_null, char *error __attribute__((unused)))
{
#ifndef UDF_USE_PIPE
	if(!(initClient("127.0.0.1", SERVER_PORT)))
	{
        strcpy(result, "Client not initialized");
        *length = 23;
        return result;		
	}
#endif
	
    strcpy(result, "Client initialized");
    *length = 19;
    return result;		
	
/*
	FILE *fd=fopen("/tmp/op.txt","a");	
	fprintf(fd,"Inside initClient\n");
	fclose(fd);
	return 0;
*/
}


/* NOtify MuxDemux */

my_bool notifyMuxDemux_init(UDF_INIT *initid, UDF_ARGS *args, char *message)
{
#ifdef UDF_USE_PIPE
	if (args->arg_count != 0)
	{
		strcpy(message,"Wrong arguments to sockets;  Use the source");
		return 1;
	}
#else
    FILE *fd=fopen("/tmp/op.txt","a");
    fprintf(fd,"Inside notifyMuxDemux init\n");
    fclose(fd);
#endif
	return 0;
}

void notifyMuxDemux_deinit(UDF_INIT *initid __attribute__((unused)))
{
#ifndef UDF_USE_PIPE
	FILE *fd=fopen("/tmp/op.txt","a");
	fprintf(fd,"Inside notifyMuxDemux denit\n");
	fclose(fd);
#endif
}

char *notifyMuxDemux(UDF_INIT *initid __attribute__((unused)),
        UDF_ARGS *args, char *result, unsigned long *length, char *is_null,
        char *error __attribute__((unused)))
{
#ifdef UDF_USE_PIPE

    static const int MSG_MAX_SIZE = 80; // Recommended by mysql documentation
    static const char *const file = "/tmp/muxdemux";

    static int fd = -1;
    if (-1 == fd)
    {
        fd = open(file, O_WRONLY | O_NONBLOCK);
    }
    if (-1 == fd)
    {
        snprintf(result, MSG_MAX_SIZE, "Failed to open '%s' "
                "(err %i, %s).", file, errno, strerror(errno));
    }
    else
    {
        int tries = 2;
        while(tries--)
        {
            uint8_t byte = 0xAA;
            if (-1 == write(fd, &byte, sizeof(byte)))
            {
                if (EPIPE == errno)
                {
                    // reopen the pipe
                    close(fd);
                    fd = open(file, O_WRONLY | O_NONBLOCK);
                    if (-1 != fd)
                    {
                        // successfully reopened, try to send the notification again
                        continue;
                    }
                }

                snprintf(result, MSG_MAX_SIZE, "Failed to send notification "
                        "(err %i, %s).", errno, strerror(errno));
            }
            else
            {
                strncpy(result, "Notification sent.", MSG_MAX_SIZE);
            }
            break;
        } // while
    }

    *length = strlen(result);
    return result;

#else
	int ret = NotifyMuxDemux();
	if(ret == -2)
	{
        strcpy(result, "MuxDemux could not send notification");
        *length = strlen(result);
        return result;		
	}
	
	if(ret == -1)
	{
        strcpy(result, "Notification not sent");
        *length = strlen(result);
        return result;		
	}	
	
    strcpy(result, "Notification Sent");
    *length = strlen(result);;
    return result;
/*	
	FILE *fd=fopen("/tmp/op.txt","a");	
	fprintf(fd,"Inside notifyMuxDemux main\n");
	fclose(fd);
	return 0;
*/
#endif
}

/* Close Client */

my_bool closeClient_init(UDF_INIT *initid, UDF_ARGS *args, char *message) {
	if (args->arg_count != 0)
	{
		strcpy(message,"Wrong arguments to sockets;  Use the source");
		return 1;
	}	
	FILE *fd=fopen("/tmp/op.txt","a");
	fprintf(fd,"Inside closeClient init\n");
	fclose(fd);
	return 0;
}

void closeClient_deinit(UDF_INIT *initid __attribute__((unused))) {
	FILE *fd=fopen("/tmp/op.txt","a");
	fprintf(fd,"Inside closeClient denit\n");
	fclose(fd);
}

char *closeClient(UDF_INIT *initid __attribute__((unused)), UDF_ARGS *args, char *result, unsigned long *length, char *is_null, char *error __attribute__((unused)))
{
#ifndef UDF_USE_PIPE
	closeClient();

    strcpy(result, "Client Closed");
    *length = 14;
    return result;
	
	FILE *fd=fopen("/tmp/op.txt","a");	
	fprintf(fd,"Inside closeClient  main\n");
	fclose(fd);
#endif
	return 0;
}

/* Shutdown Client */

my_bool shutClient_init(UDF_INIT *initid, UDF_ARGS *args, char *message) {
	if (args->arg_count != 0)
	{
		strcpy(message,"Wrong arguments to sockets;  Use the source");
		return 1;
	}	
	FILE *fd=fopen("/tmp/op.txt","a");
	fprintf(fd,"Inside shutClient_init\n");
	fclose(fd);
	return 0;
}

void shutClient_deinit(UDF_INIT *initid __attribute__((unused))) {
	FILE *fd=fopen("/tmp/op.txt","a");
	fprintf(fd,"Inside shutClient_deinit\n");
	fclose(fd);
}

char *shutClient(UDF_INIT *initid __attribute__((unused)), UDF_ARGS *args, char *result, unsigned long *length, char *is_null, char *error __attribute__((unused)))
{
#ifndef UDF_USE_PIPE
	shutdownClient();

    strcpy(result, "Client Shut down");
    *length = 14;
    return result;
#else
    return 0;
#endif
}
