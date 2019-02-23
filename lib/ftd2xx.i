%module "ftd2xx"

DWORD ft_create_device_info_list();
FT_HANDLE ft_open(int device_index);
ULONG ft_write(FT_HANDLE handle, VALUE message);
ULONG ft_read(FT_HANDLE handle, VALUE reply);

%include windows.i

%{
#include "ftd2xx.h"
%}

%include "ftd2xx.h"

%inline%{
DWORD ft_create_device_info_list()
{
	DWORD number_of_devices = 0;
	FT_STATUS status = FT_OK;
	status = FT_CreateDeviceInfoList(&number_of_devices);
	if (status == FT_OK)
		return number_of_devices;
	return 0;
}	
	
FT_HANDLE ft_open(int device_index)
{
	FT_STATUS status = FT_OK;
	FT_HANDLE handle = 0;
	status = FT_Open(device_index,&handle);
	if (status == FT_OK)
		return handle;
	return NULL;
}

ULONG ft_write(FT_HANDLE handle, VALUE message)
{
	FT_STATUS status = FT_OK;
	ULONG bytesWritten = 0;
	char * tempMessage = (char *)malloc(sizeof(char) * RSTRING_LEN(message));
	strcpy(tempMessage, RSTRING_PTR(message));
	status = FT_Write(handle, tempMessage, sizeof(tempMessage), &bytesWritten);
	free(tempMessage);
	if (status == FT_OK)
		return bytesWritten;
	return 0;
}

ULONG ft_read(FT_HANDLE handle, VALUE reply)
{
	FT_STATUS status = FT_OK;
	ULONG bytesRead = 0;
	status = FT_Read(handle, RSTRING_PTR(reply), RSTRING_LEN(reply), &bytesRead);
	if (status == FT_OK)
		return bytesRead;
	return 0;
}

%}