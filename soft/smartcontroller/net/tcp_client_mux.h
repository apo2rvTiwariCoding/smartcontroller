#pragma once

#include "net/stdafx.h"
//#include "../db/MuxDemuxDb.h"
typedef int DeviceType ;
typedef void (*TOnMessageCallback)(void* pVoid,char *buffer ,int size);
class CTcpClientMux
{	
	int myNumber;
	bool bIsConnected;
	char mAnchorId[20];
public:
	std::string Unparsedjson;
public:
	#ifdef __WINDOWS
	SOCKET connectedSocket;
	CTcpClientMux(SOCKET newSocket,int clientNo);
	#endif
	#ifdef __LINUX
	CTcpClientMux(int newSocket,int clientNo,std::vector<CTcpClientMux*>* list);
	
	#endif
	std::vector<CTcpClientMux*>* connectedClientList;
	~CTcpClientMux(void);

public:
	int connectedSocket;
	static TOnMessageCallback mOnMessge;
	static TOnMessageCallback mOnMessageMDIntf;
	static void RegisterCallback(TOnMessageCallback callback){mOnMessge=callback;}
	static void RegisterCallbackMDIntf(TOnMessageCallback callback){mOnMessageMDIntf=callback;}
	CTcpClientMux *GetClient (int socketaddr);
private:
	int Receive(char* buffer, int length);
	static void* ClientConnectionThreadProc (void* lpdwThreadParam );
	void CreateClientConnectionThread(CTcpClientMux* socket);
	void ProcessClientConnectionThread();

public:
	//static void RemoveNullChar(int formPos, char* buffer);
	static std::vector<std::string> GetSubStringList(std::string strBuff, char strSeperator);

	void SetConnection(bool flag){bIsConnected=flag;}
	bool IsConnected(){return bIsConnected;}	
	int MyNumber(){return myNumber;}
	char* getAnchorId(){return mAnchorId;}
	void ShutDown();
	int Send(char* data,int len);
};

