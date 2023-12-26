#include "net/stdafx.h"
#include "net/tcp_socket_mux.h"

FILE *fd;
TOnMessageCallback CTcpSocketMux::mOnMessge = 0;
TOnServerDisconnectCallback CTcpSocketMux::mOnServerDisconnect = 0;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
CTcpSocketMux::CTcpSocketMux (void)
{
  clientSocketCount = 0;
#ifdef __WINDOWS
  WSAStartup (0x0202, &wsaData);
#endif
  Create ();
}

CTcpSocketMux::~CTcpSocketMux (void)
{
#ifdef EMULATOR
  for (unsigned int i = 0; i < connectedClientList.size (); i++)
    {
      delete connectedClientList.at (i);
      connectedClientList.at (i) = NULL;
    }
  connectedClientList.clear ();
#endif
  Close ();
}

CTcpClientMux *
CTcpSocketMux::GetClient (unsigned int index)
{
  if (index >= 0 && index < connectedClientList.size ())
    return connectedClientList.at (index);
  else
    return NULL;
}

int
CTcpSocketMux::GetClientCount ()
{
  return connectedClientList.size ();
}
CTcpClientMux *
CTcpSocketMux::GetClientFromSocket (int socketaddr)
{
pthread_mutex_lock (&lock);	
unsigned int index=0;
  
  for (std::vector<CTcpClientMux*>::iterator it=connectedClientList.begin();it < connectedClientList.end();it++)
  {	
	  if(  (*it)->connectedSocket == socketaddr)
	  {
		if (index >= 0 && index < connectedClientList.size ())
		{
			pthread_mutex_unlock (&lock);
			return connectedClientList.at (index);
		}
		else
		{
			pthread_mutex_unlock (&lock);
			return NULL;
		}
	  }
	  index++;
  }
  pthread_mutex_unlock (&lock);
  return NULL;

}
void *
CTcpSocketMux::ReceiveThreadProc (void *lpdwThreadParam)
{
  CTcpSocketMux *socket = (CTcpSocketMux *) lpdwThreadParam;
  if (socket == 0)
    return 0;
  socket->ProcessReceiveThread ();
  return 0;
}

bool
CTcpSocketMux::IsConnected ()
{
  return bIsConnected;
}

void CTcpSocketMux::ProcessReceiveThread()
{
	int bufflen;
	fprintf(stderr,"CTcpSocket::ProcessReceiveThread called");
	while(IsConnected())
	{
		char* buffer = new char[BUFFER_SIZE];
		if(buffer == NULL)continue;

		int size = Receive(buffer,BUFFER_SIZE);
		bufflen=strlen(buffer);
		//fprintf(stderr," buffer recieved:%d\n",size);
		if(mOnMessge!=NULL && size >0)
		{
			mOnMessge(this,buffer,bufflen);
		}
                else if(size==-1||size==0)
                {
                        //Disconnected from client
                        fprintf(stderr,"Disconnected from server: size=%d\n",size );
                        bIsConnected=false;
                }

		delete[] buffer;
		buffer = NULL;	
	}
}


#ifdef __WINDOWS
void
CTcpSocketMux::CreateReceiveThread (CTcpSocketMux * socket)
{
  DWORD dwThreadId = 0;
  if (CreateThread (NULL,	//Choose default security
		    0,		//Default stack size
		    (LPTHREAD_START_ROUTINE) & ReceiveThreadProc,
		    //Routine to execute
		    (LPVOID) socket,	//Thread parameter
		    0,		//Immediately run the thread
		    &dwThreadId	//Thread Id
      ) == NULL)
    {
      printf ("\nError in creating thread: CTcpSocketMux::CreateReceiveThread");
      return;
    }
  else
    {
      printf
	("\nThread created to communicate with server...:CTcpSocketMux::CreateReceiveThread\n");
    }
}
#endif
#ifdef __LINUX
void
CTcpSocketMux::CreateReceiveThread (CTcpSocketMux * socket)
{
  int err;
  pthread_t thrd_id = 0;
  err = pthread_create (&(thrd_id), NULL, &ReceiveThreadProc, socket);
  if (err != 0)
    {
      fprintf (stderr,
	       "Error in creating thread: CTcpSocketMux::CreateReceiveThread\n");
    }
  else
    {
      fprintf (stderr,
	       "Thread created to communicate with server...:CTcpSocketMux::CreateReceiveThread\n");
    }
}
#endif
//Creating your first socket
bool
CTcpSocketMux::Create ()
{
  destination.sin_family = AF_INET;
  thisSocket = socket (AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if (thisSocket < 0)
    {
      fprintf (stderr, "Socket Creation FAILED! CTcpSocketMux::Create()\n");
      return 0;
    }
  return 1;
}

//Binding to a socket
bool
CTcpSocketMux::Bind (u_short port)
{
  destination.sin_port = htons (port);
  destination.sin_addr.s_addr = INADDR_ANY;
  if (bind
      (thisSocket, (struct sockaddr *) &destination,
       sizeof (destination)) < 0)
    {
      char szLog[255];
      sprintf (szLog, "\nCTcpSocketMux::Bind : Binding to port(%d) FAILED!\n",
	       port);
      perror (szLog);

      if (thisSocket)
	{
	  Close ();
	}
      return 0;
    }
  else
    {
      printf ("\nCTcpSocketMux::Bind : Binding on port(%d) SUCCESS!", port);
    }
  return 1;
}

//Listening on a socket
bool
CTcpSocketMux::Listen ()
{
  if (listen (thisSocket, 5) < 0)
    {
      if (thisSocket)
	{
	  Close ();
	  fprintf (stderr, "\nCTcpSocketMux::Listen() : Failed to listen");
	}
      return 0;
    }
  return 1;
}

//Accepting a connection
void
CTcpSocketMux::Accept ()
{
  if (connectedClientList.size () == 0)
    {
      //CTcpClientMux *newClient = NULL;
      while (true)
	{
#ifdef __WINDOWS
	  struct sockaddr_in clientAddress;
	  int clientSize = sizeof (clientAddress);
	  SOCKET newSocket =
	    accept (thisSocket, (struct sockaddr *) &clientAddress,
		    (int *) &clientSize);
#endif

#ifdef __LINUX
	  struct sockaddr_storage clientAddress;
	  socklen_t clientSize = sizeof (clientAddress);
	  int newSocket = (int) accept (thisSocket, (struct sockaddr *) &clientAddress, &clientSize);
	  fprintf (stderr, "the accepted client is at : %d ", newSocket);
#endif

	  if (newSocket < 0)
	    {

	      if (newSocket)
		{
		  Close ();
		  //fprintf(stderr,"\nCTcpSocketMux::Accept() : Failed to accept ");
		}
	    }
	  else
	    {
	      fprintf (stderr, "\nNew Client added.\n");

	      connectedClientList.
		push_back (new CTcpClientMux (newSocket, ++clientSocketCount,&connectedClientList));
	    }
	}
    }
}

bool
CTcpSocketMux::Connect (const char *ipAddr, u_short port, int timeout_in_sec)
{
  //Connecting to a host
  destination.sin_port = htons (port);
  destination.sin_addr.s_addr = inet_addr (ipAddr);

  if (timeout_in_sec == -1)
    {
		fd=fopen("/tmp/op.txt","a");
		fprintf(fd,"Inside Connect fn\n");
		fclose(fd);
		while (connect(thisSocket, (struct sockaddr *) &destination, sizeof (destination)) != 0)
		{
			fd=fopen("/tmp/op.txt","a");
			fprintf(fd,"Inside connect-while\n");
			fclose(fd);
			//sleep(1);
		}
		fprintf (stderr, "Socket Connection SUCCESS! CTcpSocketMux::Connect()\n");
		bIsConnected = true;
		CreateReceiveThread (this);
		return true;
    }
  else
    {
      int timeInSeconds = 0;

      while (timeInSeconds < timeout_in_sec)
	{
	  clock_t startTime = clock ();
	  if (connect(thisSocket, (struct sockaddr *) &destination, sizeof (destination)) != 0)
	    {

	    }
	  else
	    {
	      fprintf (stderr,
		       "Socket Connection SUCCESS! CTcpSocketMux::Connect()\n");
	      bIsConnected = true;
	      CreateReceiveThread (this);
	      return true;
	    }
	  clock_t endTime = clock ();
	  clock_t clockTicksTaken = endTime - startTime;
	  timeInSeconds = (int) (timeInSeconds + (clockTicksTaken / (double) CLOCKS_PER_SEC));
	}
    }
  return false;
}

//Sending data over a socket
/*So you've got a socket set up at last, how do you send data over it?
The send() function takes the following:
The socket you want to send data over.
A char array containing your data you want to send.
An int containing the amount of data in the buffer.
An offset in the buffer incase you only want to send a part of it. 0 means start from the beginning.*/
int
CTcpSocketMux::Send (const char *buffer)
{
	printf ("in wrong send\n");
  std::string sendstr = std::string ("-");
  sendstr.append (std::string (buffer));
  int result = -1;

#ifdef __WINDOWS
  result = send (thisSocket, sendstr.c_str (), sendstr.length (), 0);
#endif
#ifdef __LINUX
  result =
    send (thisSocket, sendstr.c_str (), sendstr.length (), MSG_NOSIGNAL);
#endif
  return result;
}
int CTcpSocketMux::Send (char *data, int len)                        ////////////////////////////
{
  printf ("in correct send\n");
  int result = -1;

#ifdef __WINDOWS
  result = send (thisSocket, data, len, 0);
#endif
#ifdef __LINUX
  result = send (thisSocket, data, len, 0);
#endif
  return result;
}

//Receiving data over a socket
/*The revc() function takes the following:
The socket you want to recieve data from.
A char array you want to store the data in.
The maximum size of the above array.
An offset in the buffer incase. 0 starts from the beginning.
The function returns the number of bytes that were received, up to the maximum you speficied.
WARNING - this function BLOCKS until data arrives.*/
int
CTcpSocketMux::Receive (char *buffer, int length)
{
  int newData = 0;

#ifdef __WINDOWS
  newData = recv (thisSocket, buffer, length, 0);
#endif
#ifdef __LINUX
  newData = recv (thisSocket, buffer, length, MSG_NOSIGNAL);
#endif

  return newData;
}

void
CTcpSocketMux::Close ()
{
  //Closing your first socket
  close (thisSocket);
}

void
CTcpSocketMux::ShutDown ()
{
  int res = shutdown (thisSocket, SHUT_RDWR);
  if (res == -1)
  {
	fprintf (stderr, "CTcpSocketMux::ShutDown() socket could not successfully get shutdown\n");
  }
}
