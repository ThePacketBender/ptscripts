#include <stdlib.h>
#include <stdio.h>
#include <FileAPI.h>

void main ()
{
	char b [125];
	sprintf(b, "%s\\AppData\\Local\\Google\\Chrome\\User Data\\Default\\TransportSecurity", getenv("USERPROFILE"));
	BOOL WINAPI DeleteFile(_In_ LPCTSTR f);
	return 1;
}
