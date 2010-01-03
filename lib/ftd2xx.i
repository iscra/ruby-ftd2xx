%module "ftd2xx"

DWORD create_device_info_list();
FT_HANDLE open(int device_index);
ULONG write(FT_HANDLE handle, VALUE message);
ULONG read(FT_HANDLE handle, VALUE reply);

%include windows.i

%{
#include "ftd2xx.h"
%}

%include "ftd2xx.h"

%inline%{
DWORD create_device_info_list()
{
	DWORD number_of_devices = 0;
	FT_STATUS status = FT_OK;
	status = FT_CreateDeviceInfoList(&number_of_devices);
	if (status == FT_OK)
		return number_of_devices;
	return 0;
}	
	
FT_HANDLE open(int device_index)
{
	FT_STATUS status = FT_OK;
	FT_HANDLE handle = 0;
	status = FT_Open(device_index,&handle);
	if (status == FT_OK)
		return handle;
	return NULL;
}

ULONG write(FT_HANDLE handle, VALUE message)
{
	FT_STATUS status = FT_OK;
	ULONG bytesWritten = 0;
	char * tempMessage = (char *)malloc(sizeof(char) * RSTRING(message)->len);
	strcpy(tempMessage, RSTRING(message)->ptr);
	status = FT_Write(handle, tempMessage, sizeof(tempMessage), &bytesWritten);
	free(tempMessage);
	if (status == FT_OK)
		return bytesWritten;
	return 0;
}

ULONG read(FT_HANDLE handle, VALUE reply)
{
	FT_STATUS status = FT_OK;
	ULONG bytesRead = 0;
	status = FT_Read(handle, RSTRING(reply)->ptr, RSTRING(reply)->len, &bytesRead);
	if (status == FT_OK)
		return bytesRead;
	return 0;
}

%}