$PBExportHeader$u_imagebtn.sru
forward
global type u_imagebtn from userobject
end type
type st_text from statictext within u_imagebtn
end type
type p_1 from picture within u_imagebtn
end type
type designedw from datawindow within u_imagebtn
end type
end forward

global type u_imagebtn from userobject
string tag = "textstylepicturebutton"
integer width = 293
integer height = 88
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event clicked ( )
event ue_checkpoint ( )
event ue_enable pbm_enable
st_text st_text
p_1 p_1
designedw designedw
end type
global u_imagebtn u_imagebtn

type prototypes
FUNCTION ulong SetCapture(ulong hwnd) LIBRARY "user32.dll"
FUNCTION ulong ReleaseCapture() LIBRARY "user32.dll"
FUNCTION boolean GetCursorPos(REF POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"

//V1.9.9.016   웹과 CS가 사이즈를 달리 가지고 오는 문제...
//function ulong GetDC(ulong hWnd) Library "USER32.DLL"
//function long ReleaseDC(ulong hWnd, ulong hdcr) Library "USER32.DLL"
//function ulong SelectObject(ulong hdc, ulong hWnd) Library "GDI32.DLL"
//function boolean GetTextExtentPoint32(ulong hdcr, string lpString, long nCount, ref str_size size) Library "GDI32.DLL" alias for "GetTextExtentPoint32W"
//FUNCTION boolean ShowWindow (ulong hWnd, int nCmdShow) Library "USER32.DLL"

//FUNCTION Long CreateFont ( Long H, Long W, Long E, Long O, Long W, Long I, Long u, Long S, Long C, Long OP, Long CP, Long Q, Long PAF, String F) LIBRARY "gdi32" ALIAS FOR "CreateFontW"
//FUNCTION Long SelectObject ( Long hdc, Long hObject) LIBRARY "gdi32"
//FUNCTION Long DeleteObject ( Long hObject) LIBRARY "gdi32"
//FUNCTION Long TextOut ( Long hdc, Long xpos, Long ypos, String lpString,  Long nCount) LIBRARY "gdi32" ALIAS FOR "TextOutW"

FUNCTION BOOLEAN gettextsize( Long hWnd, String lpszText, int sizeoffont, String lpszFace,ref str_size lpSize) LIBRARY "pentalib.dll" ALIAS FOR "gettextsize;ansi"
//=====================================
end prototypes

type variables
Private:
	Boolean		imagecheck
	Boolean		mouseover
	Boolean		mousedown
	Boolean		mouseclick
	Boolean		roleenabled = true
	
	Integer		ii_height
	Integer		ii_width
	n_timing	in_timer
	Decimal		INTERVAL		= 0.1
Protected:
	String		fontcolor					//tab font color
	String		selectfontcolor			//tab select font color
	String		enablefontcolor			//enable font color
	String		fontface					//font name
	
	Integer	fontsize						//text fontsize
	Integer	textgaby					//fontheight gab
	Integer	ClickedTextXGab			//clicked시 x 위치 변경
	Integer	ClickedTextYGab			//clicked시 y 위치 변경
	
	String		btnname					//버튼명
	
	String 	FILEPATH		 		= "..\img\"
	String		FRONT_SELECT  		= "btn_front.gif"
	String		BACK_SELECT  			= "btn_back.gif"
	String		END_SELECT			= "btn_end.gif"
	
	//name rul
	CONSTANT String		NAME_RUL_FRONT		= "frt"
	CONSTANT String		NAME_RUL_BACK			= "bck"
	CONSTANT String		NAME_RUL_END			= "end"
	CONSTANT String		NAME_RUL_Txt				= "txt"
	CONSTANT	String		MOUSE_OVER				= "ov_"
	CONSTANT 	String		MOUSE_DOWN				= "cl_"
	CONSTANT 	String		ENABLE_FALS				= "df_"

Public:
	Boolean		CallEvent = False
	String			is_event
	
end variables

forward prototypes
private function boolean of_imgsize (string filename, ref long al_height, ref long al_width)
public subroutine of_resize ()
public subroutine of_enable (boolean ab_enable)
private function boolean of_modify (string as_syntax)
public subroutine of_setevent (string as_event)
public function string of_getevent ()
public subroutine of_ondisplay ()
private function boolean of_createimg ()
private function str_size of_getcolumnwidth (string as_text)
protected function boolean of_mousedown ()
protected function boolean of_mouseout ()
protected function boolean of_mouseover ()
public subroutine setroleenabled (boolean enable)
public function boolean getroleenabled ()
public subroutine setbtnname (string buttonname)
public function string getbtnname ()
end prototypes

event clicked();
end event

event ue_checkpoint();
end event

event ue_enable;
end event

private function boolean of_imgsize (string filename, ref long al_height, ref long al_width);
return true
end function

public subroutine of_resize ();
end subroutine

public subroutine of_enable (boolean ab_enable);
end subroutine

private function boolean of_modify (string as_syntax);
return true
end function

public subroutine of_setevent (string as_event);
end subroutine

public function string of_getevent ();return is_event
end function

public subroutine of_ondisplay ();
end subroutine

private function boolean of_createimg ();
Return True
end function

private function str_size of_getcolumnwidth (string as_text);
str_size lstr_Size
Return lstr_Size
end function

protected function boolean of_mousedown ();
return true
end function

protected function boolean of_mouseout ();
return true
end function

protected function boolean of_mouseover ();
return true
end function

public subroutine setroleenabled (boolean enable);
end subroutine

public function boolean getroleenabled ();return roleenabled
end function

public subroutine setbtnname (string buttonname);
end subroutine

public function string getbtnname ();return this.btnname
end function

on u_imagebtn.create
this.st_text=create st_text
this.p_1=create p_1
this.designedw=create designedw
this.Control[]={this.st_text,&
this.p_1,&
this.designedw}
end on

on u_imagebtn.destroy
destroy(this.st_text)
destroy(this.p_1)
destroy(this.designedw)
end on

event constructor;
end event

type st_text from statictext within u_imagebtn
boolean visible = false
integer x = 82
integer y = 16
integer width = 457
integer height = 48
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type p_1 from picture within u_imagebtn
integer width = 288
integer height = 84
boolean originalsize = true
string picturename = "..\img\btn\btn_temp.gif"
boolean focusrectangle = false
end type

type designedw from datawindow within u_imagebtn
event ue_mousedown pbm_lbuttondown
event ue_mouseoverout pbm_mousemove
event ue_mouseup pbm_lbuttonup
boolean visible = false
integer width = 279
integer height = 80
integer taborder = 10
string title = "none"
boolean border = false
boolean livescroll = true
end type

event ue_mousedown;
end event

event ue_mouseoverout;
end event

event ue_mouseup;
end event

