#include <sstream>
#include <stdio.h>
#include <iostream>
#include "net/stdafx.h"
#include "net/tcp_client_mux.h"

TOnMessageCallback CTcpClientMux::mOnMessge = 0;
TOnMessageCallback CTcpClientMux::mOnMessageMDIntf = 0;
#ifdef __WINDOWS
CTcpClientMux::CTcpClientMux (SOCKET newSocket, int clientNo)
{
  myNumber = clientNo;
  bIsConnected = true;
  printf ("New client connected.\n");
  connectedSocket = newSocket;
  CreateClientConnectionThread (this);
}
#endif
#ifdef __LINUX
CTcpClientMux::CTcpClientMux (int newSocket, int clientNo,std::vector<CTcpClientMux*>* list)
{
  
  myNumber = clientNo;
  bIsConnected = true;
  fprintf (stderr, "New client connected to Server.\n");
  connectedSocket = newSocket;
  connectedClientList = list;
 
  CreateClientConnectionThread (this);
}
#endif
CTcpClientMux::~CTcpClientMux (void)
{
#ifdef __LINUX
	int index=0;
  bIsConnected=false;
  close (connectedSocket);
  for (std::vector<CTcpClientMux*>::iterator it=connectedClientList->begin();it < connectedClientList->end();it++)
  {
	
	  if(  (*it)->connectedSocket == connectedSocket)
	  {
		connectedClientList->erase(connectedClientList->begin()+index);
		//fprintf(stderr,"begin:%d   INDEX =%d & it =%d\n",connectedClientList->begin(),index,it);
	  }
	  index++;
	  //std::cout<<(*it)->myNumber<<"\t"<<(*it)->connectedSocket<<"size = "<<connectedClientList->size()<<"\n";
  }
#endif
  fprintf(stderr,"\nCTcpClientMux::~CTcpClientMux()\n");
}
CTcpClientMux *
CTcpClientMux::GetClient (int socketaddr)
{
	unsigned int index=0;
  
  for (std::vector<CTcpClientMux*>::iterator it=connectedClientList->begin();it < connectedClientList->end();it++)
  {	
	  if(  (*it)->connectedSocket == socketaddr)
	  {
		if (index >= 0 && index < connectedClientList->size ())
			return connectedClientList->at (index);
		else
			return NULL;
	  }
	  index++;
  }
  return NULL;

}
void
CTcpClientMux::ShutDown ()
{
#ifdef __LINUX
  int res = shutdown (connectedSocket, SHUT_RDWR);
  if (res == -1)
    fprintf (stderr,
	     "CTcpClientMux::ShutDown() socket could not successfully get shutdown\n");
#endif
}

/*void
CTcpClientMux::RemoveNullChar (int formPos, char *buffer)
{
  if (buffer == NULL)
    return;
  for (int i = formPos; i < strlen (buffer); i++)
    {
      buffer[i] = '\0';
    }
}
*/
std::vector < std::string > CTcpClientMux::GetSubStringList (std::string strBuff,
							  char strSeperator)
{
  std::vector < std::string > stringList;
  int
    size = strBuff.length ();
  while (size >= 1)
    {
      int
	pos = strBuff.find (strSeperator);
      if (pos != -1)
	{
	  if (pos == 0)
	    {
	      strBuff = strBuff.substr (1, strBuff.length ());
	      size = strBuff.length ();
	    }
	  else
	    {
	      std::string substring = strBuff.substr (0, pos);
	      if (!substring.empty ())
		stringList.push_back (substring);
	      strBuff = strBuff.substr (pos + 1, strBuff.length ());
	      size = strBuff.length ();
	    }
	}
      else
	{
	  stringList.push_back (strBuff);
	  size = pos;
	}
    }
  return stringList;
}

void *
CTcpClientMux::ClientConnectionThreadProc (void *lpdwThreadParam)      //////////////////////
{

  printf ("Before ProcessClientConnectionThread()\n");
  CTcpClientMux *client = (CTcpClientMux *) lpdwThreadParam;
  if (client == 0)
    return 0;
  client->ProcessClientConnectionThread ();
  return 0;
}

void
CTcpClientMux::ProcessClientConnectionThread ()   /////////////////////////////////
{
/*	int index=0;
  for (std::vector<CTcpClientMux*>::iterator it=connectedClientList->begin();it < connectedClientList->end();it++){index++;
  std::cout<<"Index : "<<index<<"\t"<<(*it)->myNumber<<"\t"<<(*it)->connectedSocket<<"size = "<<connectedClientList->size()<<"\n";}
*/  while (IsConnected ())
    {
      char *data = new char[BUFFER_SIZE];
      if (data == NULL)
	continue;
      int size = Receive (data, BUFFER_SIZE);
      if (mOnMessge != NULL)
	{
	  mOnMessge (this,data, size);
	}
	if (mOnMessageMDIntf != NULL)
	{
	  mOnMessageMDIntf (this,data, size);
	}
		
      delete data;
	  data=NULL;

    }
  delete this;
}

#ifdef __WINDOWS
void
CTcpClientMux::CreateClientConnectionThread (CTcpClientMux * socket)
{
  DWORD dwThreadId = 0;
  if (CreateThread (NULL,	//Choose default security
		    0,		//Default stack size
		    (LPTHREAD_START_ROUTINE) & ClientConnectionThreadProc,
		    //Routine to execute
		    (LPVOID) socket,	//Thread parameter
		    0,		//Immediately run the thread
		    &dwThreadId	//Thread Id
      ) == NULL)
    {
      fprintf (stderr, "Error Creating Thread\n");
      return;
    }
  else
    {
      fprintf (stderr, "Thread created to connect client...\n");
    }
}
#endif
#ifdef __LINUX
void
CTcpClientMux::CreateClientConnectionThread (CTcpClientMux * socket)
{
  int err;
  pthread_t thrd_id = 0;
  err =
    pthread_create (&(thrd_id), NULL, &ClientConnectionThreadProc, socket);
  if (err != 0)
    {
      fprintf (stderr, "Error Creating Thread\n");
    }
  else
    {
      fprintf (stderr, "Thread created to connect client...\n");
    }
}
#endif

//Sending data over a socket
/*So you've got a socket set up at last, how do you send data over it?
The send() function takes the following:
The socket you want to send data over.
*/
int
CTcpClientMux::Send (char *data, int len)                        ////////////////////////////
{
  
  int result = -1;

#ifdef __WINDOWS
  result = send (connectedSocket, data, len, 0);
#endif
#ifdef __LINUX
  printf ("in correct send--\n");
  result = send (connectedSocket, data, len, 0);
#endif
  return result;
}

//Receiving data over a socket
/*The revc() function takes the following:
The socket you want to recieve data from.
The function returns the number of bytes that were received, up to the maximum you speficied.
WARNING - this function BLOCKS until data arrives.*/
int
CTcpClientMux::Receive (char *buffer, int length)
{
  int newData = 0;

#ifdef __WINDOWS
  newData = recv (connectedSocket, buffer, length, 0);
#endif
#ifdef __LINUX
  newData = recv (connectedSocket, buffer, length, MSG_NOSIGNAL);           
  //fprintf (stderr, "Recieved data in server :newData :%d\n",newData);
#endif

  return newData;
}




