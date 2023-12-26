//http://www.techpowerup.com/forums/threads/c-c-sockets-faq-and-how-to-win-linux.56901/
//http://msdn.microsoft.com/en-us/library/windows/desktop/ms742213(v=vs.85).aspx

#pragma once

#include "net/stdafx.h"
#include "net/tcp_client_mux.h"

typedef void (*TOnServerDisconnectCallback)(void);

class CTcpSocketMux
{
	bool bIsConnected;
	int clientSocketCount;

	#ifdef __WINDOWS
	WSADATA wsaData;
	#endif

	std::vector<CTcpClientMux*> connectedClientList;
	
	//Creating your first socket
	struct sockaddr_in destination;

public:
	std::string Unparsedjson;
public:
	CTcpSocketMux(void);
	~CTcpSocketMux(void);

private:
	bool Create();
	int Send(const char* buffer);
	int Receive(char* buffer, int length);
	static void* ReceiveThreadProc (void* lpdwThreadParam );
	void CreateReceiveThread(CTcpSocketMux* socket);
	void ProcessReceiveThread();
public:
	int thisSocket;
	static TOnMessageCallback mOnMessge;
	void RegisterCallback(TOnMessageCallback callback){mOnMessge=callback;}
	static TOnServerDisconnectCallback mOnServerDisconnect;
	void RegisterServerDisconnectCallback(TOnServerDisconnectCallback callback){mOnServerDisconnect=callback;}

	bool IsConnected();
	bool Bind(u_short port);
	bool Listen();
	void Accept();
	bool Connect(const char* ipAddr,u_short port, int timeout_in_milisec=-1);
	void Close();
	void ShutDown();
	CTcpClientMux* GetClient(unsigned int index);
	CTcpClientMux *GetClientFromSocket (int socketaddr);
	int GetClientCount();
	int Send(char* buffer ,int len);
};

