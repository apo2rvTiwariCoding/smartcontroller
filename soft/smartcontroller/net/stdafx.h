// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <vector>
#include <ctime>
using namespace std;
#define BUFFER_SIZE 1000
#define MAX_PATH 255 
//#define __WINDOWS
#define __LINUX 
#define DEBUGMDI

#ifdef __WINDOWS
//#include <winsock.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#define WIN32_LEAN_AND_MEAN
// Need to link with Ws2_32.lib
#pragma comment(lib, "ws2_32.lib")	
#endif

#ifdef __LINUX
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <pthread.h>

// Libraries to get MAC Id
#include <sys/ioctl.h>
#include <linux/if.h>
#include <netdb.h>
#endif
