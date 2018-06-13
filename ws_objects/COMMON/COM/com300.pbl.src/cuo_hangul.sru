$PBExportHeader$cuo_hangul.sru
forward
global type cuo_hangul from nonvisualobject
end type
end forward

global type cuo_hangul from nonvisualobject
end type
global cuo_hangul cuo_hangul

type prototypes
function LONG ImmGetContext( long handle ) LIBRARY "IMM32.DLL"
function LONG ImmSetConversionStatus( long hIMC, long fFlag, long l ) LIBRARY "IMM32.DLL"
function LONG ImmReleaseContext( long handle, long hIMC )  LIBRARY "IMM32.DLL"
subroutine keybd_event ( int bVk, int bScan, int dwFlags, int dwExtraInfo)   LIBRARY "user32.dll"

end prototypes

forward prototypes
public function integer uf_auto_select ()
public function integer uf_auto_tab ()
public function integer uf_auto_deselect ()
public function integer uf_hangul_on (long al_handle)
public function integer uf_hangul_off (long al_handle)
end prototypes

public function integer uf_auto_select ();keybd_event(16,0,0,0) // SHIFT가 눌렸다.
keybd_event(35,0,0,0) // End가   눌렸다.
keybd_event(16,0,2,0) // SHIFT가 띄어졌다. (생략 불가능)	
keybd_event(35,0,2,0) // End가   띄어졌다. (생략 불가능)	
return 1
end function

public function integer uf_auto_tab ();keybd_event(9,0,0,0) // TAB이 눌렸다.
keybd_event(9,0,2,0) // TAB이 띄어졌다. (생략가능)
return 1
end function

public function integer uf_auto_deselect ();keybd_event(16,0,0,0) // SHIFT가 눌렸다.
keybd_event(36,0,0,0) // End가   눌렸다.
keybd_event(16,0,2,0) // SHIFT가 띄어졌다. (생략 불가능)	
keybd_event(36,0,2,0) // End가   띄어졌다. (생략 불가능)	
return 1
end function

public function integer uf_hangul_on (long al_handle);LONG hIMC
hIMC = ImmGetContext( al_handle )     // hIMC = ImmGetContext( Handle(Parent) )
ImmSetConversionStatus( hIMC, 1, 0 )
//ImmSetConversionStatus( hIMC, 0, 0 )
ImmReleaseContext(al_handle, hIMC )
return 1
end function

public function integer uf_hangul_off (long al_handle);LONG hIMC
hIMC = ImmGetContext(al_handle)     // hIMC = ImmGetContext( Handle(Parent) )
//ImmSetConversionStatus( hIMC, 1, 0 )
ImmSetConversionStatus( hIMC, 0, 0 )
ImmReleaseContext( al_handle, hIMC )
return 1
end function

on cuo_hangul.create
call super::create
TriggerEvent( this, "constructor" )
end on

on cuo_hangul.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

