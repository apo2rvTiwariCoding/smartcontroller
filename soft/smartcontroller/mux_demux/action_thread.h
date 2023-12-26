#ifndef _ACTION_THREAD_MD
#define _ACTION_THREAD_MD

#include "net/tcp_socket_mux.h"
#include "net/tcp_client_mux.h"
#include "mux_demux/mux_demux_intf.h"

class CCommands;

class CActionThread
{
	public:
		CActionThread();
		CActionThread(int id, string refTable, int refId, int recordType, int priority);
		~CActionThread();
		
	public:
		int start();
		int processAction();
		
	private:
		static void* ActionThreadProc (void* pVoid);
		void CreateActionThread(CActionThread* const socket);
		void SetThreadPriority();
	
	private:
		int mId;
		string mRefTable;
		int mRefId;
		int mRecordType;
		int mPriority;
		
//		static CDatabase* mATInstance;

    void OnSensorLocalEnable(CCommands *const pCmnds);
    void OnSensorLocalDisable(CCommands *const pCmnds);
    void OnSensorLocalReadCurr(CCommands *const pCmnds);
    void OnSensorLocalSetUpdate(CCommands *const pCmnds);

};

#endif