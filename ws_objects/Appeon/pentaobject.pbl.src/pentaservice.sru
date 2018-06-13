$PBExportHeader$pentaservice.sru
forward
global type pentaservice from nonvisualobject
end type
end forward

global type pentaservice from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION boolean ImmSetConversionStatus( long himc, long mode, long sen) library "imm32.dll"
FUNCTION long ImmGetContext( long hWnd ) library "imm32.dll"
FUNCTION LONG ImmReleaseContext( long handle, long hIMC ) LIBRARY "IMM32.DLL"

FUNCTION boolean SetWindowPos(uint luhwnd,uint hwnd2,int x,int y,int  x,int cy,uint fuFlags) library "user32.dll"
FUNCTION Long ShellExecute(Long hwnd, String lpOperation, String lpFile, String lpParameters, String lpDirectory, Long nShowCmd) LIBRARY "shell32.dll" ALIAS FOR "ShellExecuteW"
FUNCTION boolean GetCursorPos(REF POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"

FUNCTION boolean AnimateWindow(long lhWnd, long lTm, long lFlags ) library 'user32.dll'
FUNCTION ulong SetCapture(ulong hwnd) LIBRARY "user32.dll"
FUNCTION ulong ReleaseCapture() LIBRARY "user32.dll"
FUNCTION ulong RealChildWindowFromPoint (ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
FUNCTION ulong ChildWindowFromPoint(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
FUNCTION Long setMDIClientBorder( ulong hWnd, long index ) library "pbaddon.dll"
end prototypes

forward prototypes
public function boolean of_immsetconversionstatus (long himc, long mode, long sen)
public function long of_immgetcontext (long hwnd)
public function long of_immreleasecontext (long handle, long himc)
public function boolean of_setwindowpos (unsignedinteger luhwnd, unsignedinteger hwnd2, integer x, integer y, integer cy, unsignedinteger fuflags)
public function long of_shellexecute (long hwnd, string lpoperation, string lpfile, string lpparameters, string lpdirectory, long nshowcmd)
public function boolean of_getcursorpos (ref point ippoint)
public function boolean of_screentoclient (unsignedlong hwnd, ref point lppoint)
public function boolean of_animatewindow (long lhwnd, long ltm, long lflags)
public function unsignedlong of_setcapture (unsignedlong hwnd)
public function integer of_releasecapture ()
public function unsignedlong of_realchildwindowfrompoint (unsignedlong hwnd, ref point lppoint)
public function unsignedlong of_childwindowfrompoint (unsignedlong hwnd, ref point lppoint)
public function long of_setmdiclientborder (unsignedlong hwnd, long index)
end prototypes

public function boolean of_immsetconversionstatus (long himc, long mode, long sen);//boolean ImmSetConversionStatus( long himc, long mode, long sen)
return ImmSetConversionStatus(himc,mode, sen)
end function

public function long of_immgetcontext (long hwnd);return ImmGetContext(hWnd)
end function

public function long of_immreleasecontext (long handle, long himc);//LONG ImmReleaseContext( long handle, long hIMC )
return ImmReleaseContext( handle, hIMC )
end function

public function boolean of_setwindowpos (unsignedinteger luhwnd, unsignedinteger hwnd2, integer x, integer y, integer cy, unsignedinteger fuflags);//boolean SetWindowPos(uint luhwnd,uint hwnd2,int x,int y,int  x,int cy,uint fuFlags)
return SetWindowPos(luhwnd,hwnd2,x,y,x,cy,fuFlags)
end function

public function long of_shellexecute (long hwnd, string lpoperation, string lpfile, string lpparameters, string lpdirectory, long nshowcmd);//Long ShellExecute(Long hwnd, String lpOperation, String lpFile, String lpParameters, String lpDirectory, Long nShowCmd)
return ShellExecute( hwnd,  lpOperation,  lpFile,  lpParameters,  lpDirectory,  nShowCmd)
end function

public function boolean of_getcursorpos (ref point ippoint);//boolean GetCursorPos(REF POINT ipPoint) LIBRARY "user32.dll"
return GetCursorPos(ipPoint)
end function

public function boolean of_screentoclient (unsignedlong hwnd, ref point lppoint);//boolean ScreenToClient(ulong hWnd, ref POINT lpPoint)
return ScreenToClient(hWnd, lpPoint)
end function

public function boolean of_animatewindow (long lhwnd, long ltm, long lflags);return AnimateWindow(lhWnd, lTm, lFlags )
end function

public function unsignedlong of_setcapture (unsignedlong hwnd);return SetCapture( hwnd)
end function

public function integer of_releasecapture ();return ReleaseCapture()
end function

public function unsignedlong of_realchildwindowfrompoint (unsignedlong hwnd, ref point lppoint);return RealChildWindowFromPoint (hWnd, lpPoint)
end function

public function unsignedlong of_childwindowfrompoint (unsignedlong hwnd, ref point lppoint);return ChildWindowFromPoint(hWnd, lpPoint)
end function

public function long of_setmdiclientborder (unsignedlong hwnd, long index);return setMDIClientBorder(  hWnd, index ) 
end function

on pentaservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pentaservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

