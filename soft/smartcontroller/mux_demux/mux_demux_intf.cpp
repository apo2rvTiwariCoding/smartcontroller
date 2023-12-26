#include <memory>
#include <string>
#include <stdio.h>
#include <vector>
#include <cassert>
#include <chrono>
#include <thread>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <poll.h>
#include <sys/stat.h>
#include "net/tcp_socket_mux.h"
#include "net/tcp_client_mux.h"
#include "mux_demux/mux_demux_intf.h"
#include "db/PendingAction.h"
#include "mux_demux/action_thread.h"
#include "db/Actions.h"


static int onNotifyMessage();
static int onNotifyMessage(string refTable, int refId, int recordType, int priority);


#ifdef UDF_USE_PIPE

class TDbNotificationsListener
{
public:
    typedef ::std::unique_ptr< TDbNotificationsListener > TUPtr;

    TDbNotificationsListener()
      {
          m_fd.fd = INVALID_FD;
          m_fd.events = POLLIN;

          const mode_t old_umask = ::umask(0);

          ::unlink(s_file_name);
          if (0 == ::mkfifo(s_file_name,
                  S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH))
          {
              Open();
          }

          umask(old_umask);
      }

    ~TDbNotificationsListener()
      {
          if (IsOpen())
          {
              ::close(m_fd.fd);
          }
      }

    inline bool IsOpen() const noexcept { return INVALID_FD != m_fd.fd; }

    bool WaitOne()
      {
          int ret;
          for(;;)
          {
              if (!IsOpen())
              {
                  return false;
              }

              ret = ::poll(&m_fd, 1, -1);
              if ((m_fd.revents & POLLHUP) && 0 == (m_fd.revents & ~POLLHUP))
              {
                  // The other side has just been disconnected.
                  Open();
              }
              else
              {
                  break;
              }
          } while(0);

          if (0 == ret)
          {
              // timeout
              return false;
          }
          else if (1 == ret)
          {
              uint8_t byte;
              ::read(m_fd.fd, &byte, sizeof(byte));
              return true;
          }
          else
          {
              return false;
          }
    }

private:
    static const int INVALID_FD = -1;
    struct ::pollfd m_fd;

    static const char *const s_file_name;

    void Open()
      {
          if (IsOpen())
          {
              ::close(m_fd.fd);
          }
          m_fd.fd = ::open(s_file_name, O_RDONLY | O_NONBLOCK);
      }
};
const char *const TDbNotificationsListener::s_file_name = "/tmp/muxdemux";

static TDbNotificationsListener::TUPtr s_listener;


int InitDbNotificationsListener()
{
    TDbNotificationsListener::TUPtr tmp(new TDbNotificationsListener());
    if (tmp->IsOpen())
    {
        s_listener = ::std::move(tmp);
        return 0;
    }
    else
    {
        return -1;
    }
}

int RunDbNotificationsListener()
{
    assert(static_cast< bool >(s_listener));

    onNotifyMessage();
    for(;;)
    {
        if (s_listener->WaitOne())
        {
            onNotifyMessage();
        }
        else
        {
            break;
        }
    }
    return 0;
}

#else

#define SERVER_PORT 93214

CTcpSocketMux *clientSocket=NULL;
CTcpSocketMux* serverSocket;

void OnMessageReceivedClient(void * pClient, char* buffer, int length)
{
}

void OnMessageReceivedServer(void * pClient, char* buffer, int length)
{
	if(strncmp(buffer, "NOTIFY",6)==0)
	{
		printf("Notification Received\n");
		onNotifyMessage();
	}
}

void OnServerDisconnect()
{
	printf("\nServer disconnected:(");
	initClient("127.0.0.1", SERVER_PORT);
}

int initClient(const char* ip, int port)
{
	clientSocket = new CTcpSocketMux();

	if(clientSocket->Connect(ip,port))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

int closeClient()
{
	printf("Closing client\n");
	clientSocket->Close();
	delete clientSocket;
	clientSocket = NULL;
	return 0;
}

int shutdownClient()
{
	printf("Shutting down client\n");
	clientSocket->ShutDown();
	clientSocket->Close();
	delete clientSocket;
	clientSocket = NULL;
	return 0;
}

int initServer(int port)
{
	CTcpClientMux::RegisterCallbackMDIntf(OnMessageReceivedServer);
	serverSocket= new CTcpSocketMux();
	if(serverSocket!= NULL)
	{
		printf("\nServer started...\n");
		if(serverSocket->Bind(port))
		{
			if(serverSocket->Listen())
			{	
				serverSocket->Accept();
			}
		}
	}
	return 0;
}

int closeServer()
{
	serverSocket->Close();
	printf("Server stopped...\n");
	delete serverSocket;
	serverSocket = NULL;
	return 0;
}

int NotifyMuxDemux()
{
	char* buffer;
	int result = -2;
	buffer = new char(strlen("NOTIFY"));
	strcpy(buffer,"NOTIFY");
	if(clientSocket != NULL)
	{
		result = clientSocket->Send(buffer, 6);
	}
	printf("buffer : %s\n",buffer);
	delete buffer;
	return result;
}

int NotifyMuxDemux(string refTable, int refId, int recordType, int priority)
{
	return 0;
}

#endif // #ifndef UDF_USE_PIPE


int onNotifyMessage()
{
	vector<CPendingAction::Action*> actionList;

	CPendingAction* pAction = CPendingAction::getInstance();
	assert(pAction);

#if 1
	for(int wait = 0; wait < 10; wait++)
	{
	    pAction->retrieve(actionList);
	    if (actionList.size())
	    {
	        break;
	    }
        // We received the notification but the command either has not been
	    // written yet or it has been already processed
	    // Let's wait for a while.
        ::std::this_thread::sleep_for(::std::chrono::milliseconds(10));
	}

    for(unsigned int i=0;i<actionList.size();i++)
    {
        printf("Value of i while processing action list: %d\n", i);
        if(actionList[i]!=NULL)
        {
            printf("Row ID No..... = %d\n", actionList[i]->id);
            printf("Ref Table Name = %s\n", (actionList[i]->table).c_str());
            printf("Ref ID........ = %d\n", actionList[i]->refId);
            printf("Type.......... = %d\n", actionList[i]->recordType);
            printf("Priority...... = %d\n", actionList[i]->priority);

            CActionThread* pAct = new CActionThread(actionList[i]->id,  (actionList[i]->table).c_str(),  actionList[i]->refId,  actionList[i]->recordType,  actionList[i]->priority);
            if(pAct == NULL)
            {
                fprintf(stderr, "onNotifyMessage: Null pointer returned by CActionThread\n");
                return 1;
            }
            pAct->start();

            CActions * pActions = new CActions();
            if(pActions == NULL)
            {
                fprintf(stderr, "onNotifyMessage(): cActions is NULL");
            }
            int dbResult = pActions->remove(actionList[i]->id);
            if(dbResult == 1)
            {
                printf("onNotifyMessage(): Row deleted from actions\n");
            }
            else if(dbResult == -1)
            {
                printf("onNotifyMessage(): Row is not deleted from actions\n");
            }
            delete pActions;
            pActions = NULL;
        }
    }

#else
	for(int z=2;z;z--)
	{
		printf("Getting data from actions Table\n");
		pAction->retrieve(actionList);
		printf("No of pending actions = %d\n", actionList.size());
		
		for(unsigned int i=0;i<actionList.size();i++)
		{
			printf("Value of i while processing action list: %d\n", i);
			if(actionList[i]!=NULL)
			{
				printf("Row ID No..... = %d\n", actionList[i]->id);
				printf("Ref Table Name = %s\n", (actionList[i]->table).c_str());
				printf("Ref ID........ = %d\n", actionList[i]->refId);
				printf("Type.......... = %d\n", actionList[i]->recordType);
				printf("Priority...... = %d\n", actionList[i]->priority);
			
				CActionThread* pAct = new CActionThread(actionList[i]->id,  (actionList[i]->table).c_str(),  actionList[i]->refId,  actionList[i]->recordType,  actionList[i]->priority);
				if(pAct == NULL)
				{
					fprintf(stderr, "onNotifyMessage: Null pointer returned by CActionThread\n");
					return 1;
				}
				pAct->start();
				
				CActions * pActions = new CActions();
				if(pActions == NULL)
				{
					fprintf(stderr, "onNotifyMessage(): cActions is NULL");
				}
				int dbResult = pActions->remove(actionList[i]->id);
				if(dbResult == 1)
				{
					printf("onNotifyMessage(): Row deleted from actions\n");
				}
				else if(dbResult == -1)
				{
					printf("onNotifyMessage(): Row is not deleted from actions\n");
				}
				delete pActions;
				pActions = NULL;			
			}
		}
		int actionListSize = actionList.size();
		printf("onNotifyMessage(): actionListSize variable value: %d\n", actionListSize);
		for(int i=0;i<actionListSize;i++)
		{
			printf("onNotifyMessage(): actionList size: %d\n", actionList.size());
			actionList.erase(actionList.begin());
			actionList[i] = NULL;
		}
		printf("onNotifyMessage(): actionList size after everything: %d\n", actionList.size());
		sleep(1);
	}
#endif
	return 0;
}

int onNotifyMessage(string refTable, int refId, int recordType, int priority)
{return 0;}
