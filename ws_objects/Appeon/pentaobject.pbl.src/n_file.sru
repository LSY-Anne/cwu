$PBExportHeader$n_file.sru
forward
global type n_file from nonvisualobject
end type
end forward

global type n_file from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION Long FileTimeToLocalFileTime(REF FILETIME lpFileTime, REF FILETIME lpLocalFileTime) LIBRARY "kernel32"
FUNCTION Long FileTimeToSystemTime(REF FILETIME lpFileTime, REF SYSTEMTIME lpSystemFileTime) LIBRARY "kernel32"
FUNCTION Long GetFileTime(Long hFile, REF FILETIME lpCreatonTime, REF FILETIME lpLastAccessTime, REF FILETIME lpLastWriteTime) LIBRARY "kernel32"
FUNCTION Long CreateFile(String lpFileName, Long dwDesiredAccess, Long dwSharedMode, Long lpSecurityAttributes, Long dwCreationDisposition, Long dwFlagsAndAttributes, Long hTemplateFile) LIBRARY "kernel32" ALIAS FOR "CreateFileW"
FUNCTION Boolean CloseHandle( Long handle ) LIBRARY "kernel32"

end prototypes

type variables
CONSTANT LONG GENERIC_WRITE 		= 1073741824
CONSTANT LONG OPEN_EXISTING			= 3
CONSTANT LONG FILE_SHARE_READ		= 1
CONSTANT LONG FILE_SHARE_WRITE	= 2
end variables

forward prototypes
public function integer getfiletime (string filepath, ref string createtime, ref string lastaccestime, ref string lastwritetime)
end prototypes

public function integer getfiletime (string filepath, ref string createtime, ref string lastaccestime, ref string lastwritetime);Long					ll_handle
FILETIME   		fctime, Fatime, fwtime, ftemptime
SYSTEMTIME 	Systime

ll_handle = CreateFile(filepath, GENERIC_WRITE, FILE_SHARE_READ + FILE_SHARE_WRITE, 0, OPEN_EXISTING, 0, 0)

IF ll_handle < 0 THEN Return -1

GetFileTime( ll_handle, fctime, Fatime, fwtime )

FileTimeToLocalfileTime(fctime, ftemptime)
FileTimeToSystemTime(ftemptime, Systime)
createtime = String(Systime.wYear, '0000' ) + "-" + String(Systime.wMonth, '00' ) + "-" + String(Systime.wDay, '00' ) + " " + String(Systime.wHour, '00' ) + ":" + String(Systime.wMinute, '00' ) + ":" + String(Systime.wSecond, '00')

FileTimeToLocalfileTime(fatime, ftemptime)
FileTimeToSystemTime(ftemptime, Systime)
lastaccestime = String(Systime.wYear, '0000' ) + "-" + String(Systime.wMonth, '00' ) + "-" + String(Systime.wDay, '00' ) + " " + String(Systime.wHour, '00' ) + ":" + String(Systime.wMinute, '00' ) + ":" + String(Systime.wSecond, '00')

FileTimeToLocalfileTime(fwtime, ftemptime)
FileTimeToSystemTime(ftemptime, Systime)
lastwritetime = String(Systime.wYear, '0000' ) + "-" + String(Systime.wMonth, '00' ) + "-" + String(Systime.wDay, '00' ) + " " + String(Systime.wHour, '00' ) + ":" + String(Systime.wMinute, '00' ) + ":" + String(Systime.wSecond, '00')

CloseHandle(ll_handle)

return 1
end function

on n_file.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_file.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

