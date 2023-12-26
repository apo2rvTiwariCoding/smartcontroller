#ifndef _MuxDemux_H
#define _MuxDemux_H


enum {
	RC_ERROR = -1,
	RC_OK = 1
};

#ifdef UDF_USE_PIPE

int InitDbNotificationsListener();
int RunDbNotificationsListener();

#else

int initClient(const char* ip, int port);
int initServer(int port);

int NotifyMuxDemux();
int NotifyMuxDemux(std::string refTable, int refId, int recordType, int priority);  
  
int shutdownClient();

int closeClient();
int closeServer();

#endif  // #ifndef UDF_USE_PIPE

#endif
