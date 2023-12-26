/*
	lib_mysqludf_socket - a library with sockets
	(c) 2014 by ASE Smart Energy
*/

#if defined(_WIN32) || defined(_WIN64) || defined(__WIN32__) || defined(WIN32)
#define DLLEXP __declspec(dllexport)
#else
#define DLLEXP
#endif

#ifdef STANDARD
#include <string.h>
#include <stdlib.h>
#include <time.h>
#ifdef __WIN__
typedef unsigned __int64 ulonglong;
typedef __int64 longlong;
#else
typedef unsigned long long ulonglong;
typedef long long longlong;
#endif /*__WIN__*/
#else
#include <my_global.h>
#include <my_sys.h>
#endif
#include <mysql.h>
#include <m_ctype.h>
#include <m_string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/un.h>
#include <sys/socket.h>

#ifdef HAVE_DLOPEN
#ifdef	__cplusplus
extern "C" {
#endif

#define LIBVERSION "lib_mysqludf_socket version 0.0.2"

#ifdef __WIN__
#define SETENV(name,value)		SetEnvironmentVariable(name,value);
#else
#define SETENV(name,value)		setenv(name,value,1);
#endif

DLLEXP my_bool socketOpen_init(UDF_INIT *initid, UDF_ARGS *args, char *message);
DLLEXP void socketOpen_deinit(UDF_INIT *initid __attribute__((unused)));
DLLEXP char *socketOpen(UDF_INIT *initid __attribute__((unused)), UDF_ARGS *args, char *result, unsigned long *length, char *is_null, char *error __attribute__((unused)));
 
#ifdef	__cplusplus
}
#endif

my_bool socketOpen_init(UDF_INIT *initid, UDF_ARGS *args, char *message) {
  if (args->arg_count != 2 || args->arg_type[0] != STRING_RESULT || args->arg_type[1] != STRING_RESULT)
  {
    strcpy(message,"Wrong arguments to sockets;  Use the source");
    return 1;
  }

  return 0;
}

void socketOpen_deinit(UDF_INIT *initid __attribute__((unused))) {
}

char *socketOpen(UDF_INIT *initid __attribute__((unused)), UDF_ARGS *args, char *result, unsigned long *length, char *is_null, char *error __attribute__((unused))) {
	int sockfd, n, servlen;
	struct sockaddr_un serv_addr;
	char socket_path[100];
	char message[100];

    memcpy(socket_path,args->args[0],args->lengths[0]);
    socket_path[args->lengths[0]] = 0;
    memcpy(message,args->args[1],args->lengths[1]);
    message[args->lengths[1]] = 0;

    sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (sockfd < 0) {
        strcpy(result, "ERROR opening socket");
        *length = 22;
        return result;
    }

    bzero((char *) &serv_addr, sizeof(serv_addr));

    serv_addr.sun_family = AF_UNIX;
    strcpy(serv_addr.sun_path, args->args[0]);

    servlen=strlen(serv_addr.sun_path) + sizeof(serv_addr.sun_family);
    if (connect(sockfd,(struct sockaddr *) &serv_addr, servlen) < 0) {
        strcpy(result, "ERROR connecting");
        *length = 17;
        return result;
    }

    n = write(sockfd, message, strlen(message));
    if (n < 0) {
         strcpy(result, "ERROR writing to socket");
         *length = 24;
         return result;
	}
	bzero(message,100);

	n = read(sockfd, message, 100);

    close(sockfd);
    strcpy(result, message);
    *length = strlen(message);
 	return result;
}

#endif
