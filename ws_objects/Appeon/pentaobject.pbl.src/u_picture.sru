$PBExportHeader$u_picture.sru
$PBExportComments$[이수미]픽쳐 클래스
forward
global type u_picture from picture
end type
end forward

global type u_picture from picture
string tag = "picturebutton"
integer width = 229
integer height = 200
string pointer = "HyperLink!"
boolean originalsize = true
boolean focusrectangle = false
event ue_mouseoverout pbm_mousemove
event ue_mouseup pbm_lbuttonup
event ue_mousedown pbm_lbuttondown
event ue_checkpoint ( )
event ue_enable pbm_enable
end type
global u_picture u_picture

type prototypes
FUNCTION ulong SetCapture(ulong hwnd) LIBRARY "user32.dll"
FUNCTION ulong ReleaseCapture() LIBRARY "user32.dll"
FUNCTION boolean GetCursorPos(REF POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
end prototypes

type variables
Public:
	Boolean			CallEvent = False
	String			is_event
	
	CONSTANT	String		MOUSE_OVER	= "ov_"
	CONSTANT 	String		MOUSE_DOWN	= "cl_"
	CONSTANT 	String		ENABLE_FALS	= "df_"

Private:
	
	String			img_path, img_name
	Boolean			mouseover 
	n_timing			in_timer
	Decimal			INTERVAL		= 0.1
	Boolean			roleenabled = true
end variables

forward prototypes
public subroutine of_enable (boolean ab_enable)
public subroutine of_setevent (string as_event)
public function string of_getevent ()
public function string of_getpath ()
public function string of_getimgname ()
public subroutine of_setmouseover (boolean ab_mouseover)
public function boolean of_getmouseover ()
public subroutine of_ondisplay ()
public subroutine setroleenabled (boolean enable)
public function boolean getroleenabled ()
end prototypes

event ue_mouseoverout;
end event

event ue_mouseup;
end event

event ue_mousedown;
end event

event ue_checkpoint();
end event

event ue_enable;
end event

public subroutine of_enable (boolean ab_enable);
end subroutine

public subroutine of_setevent (string as_event);
end subroutine

public function string of_getevent ();return is_event
end function

public function string of_getpath ();return img_path
end function

public function string of_getimgname ();return img_name
end function

public subroutine of_setmouseover (boolean ab_mouseover);
end subroutine

public function boolean of_getmouseover ();return mouseover 
end function

public subroutine of_ondisplay ();
end subroutine

public subroutine setroleenabled (boolean enable);
end subroutine

public function boolean getroleenabled ();return roleenabled
end function

on u_picture.create
end on

on u_picture.destroy
end on

event constructor;
end event

event clicked;
end event

event destructor;
end event

