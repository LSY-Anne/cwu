$PBExportHeader$uo_topselect.sru
forward
global type uo_topselect from userobject
end type
type st_text from statictext within uo_topselect
end type
type hsb_1 from hscrollbar within uo_topselect
end type
type p_1 from picture within uo_topselect
end type
type designedw from datawindow within uo_topselect
end type
type ln_1 from line within uo_topselect
end type
type str_bitmap from structure within uo_topselect
end type
end forward

type str_bitmap from structure
	long		bmtype
	long		bmwidth
	long		bmheight
	long		bmwidthbytes
	integer		bmplanes
	integer		bmbitspixel
	integer		bmbits
end type

global type uo_topselect from userobject
integer width = 3141
integer height = 284
long backcolor = 134217747
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
string powertiptext = "test"
event ue_setroll ( str_tree astr_data )
event ue_constructor ( )
st_text st_text
hsb_1 hsb_1
p_1 p_1
designedw designedw
ln_1 ln_1
end type
global uo_topselect uo_topselect

type prototypes
function ulong GetDC(ulong hWnd) Library "USER32.DLL"
function long ReleaseDC(ulong hWnd, ulong hdcr) Library "USER32.DLL"
FUNCTION boolean ShowWindow (ulong hWnd, int nCmdShow) Library "USER32.DLL"

//V1.9.9.016   웹과 CS가 사이즈를 달리 가지고 오는 문제...
//FUNCTION Long CreateFont ( Long H, Long W, Long E, Long O, Long W, Long I, Long u, Long S, Long C, Long OP, Long CP, Long Q, Long PAF, String F) LIBRARY "gdi32" ALIAS FOR "CreateFontW"
//FUNCTION Long SelectObject ( Long hdc, Long hObject) LIBRARY "gdi32"
//FUNCTION Long DeleteObject ( Long hObject) LIBRARY "gdi32"
//FUNCTION Long TextOut ( Long hdc, Long xpos, Long ypos, String lpString,  Long nCount) LIBRARY "gdi32" ALIAS FOR "TextOutW"
//function boolean GetTextExtentPoint32(ulong hdcr, string lpString, long nCount, ref str_size size) Library "GDI32.DLL" alias for "GetTextExtentPoint32W"
FUNCTION BOOLEAN gettextsize( Long hWnd, String lpszText, int sizeoffont, String lpszFace,ref str_size lpSize) LIBRARY "pentalib.dll" ALIAS FOR "gettextsize;ansi"
//=====================================
end prototypes

type variables
Private:
	Integer		ii_selecttab
	
	datastore		ids_nlt_ft, ids_nlt_bk, ids_nlt_ed, ids_txt
	DataStore			ids_data
	
	Integer		ii_scrollpos	= 1
	Integer		ii_scrollmax
	Integer		ii_this
	Integer		ii_moveselect
	Integer		ii_height
	
	Boolean		ib_destroy
	Boolean		ib_create = false
	Boolean		ib_opensheetwithparm
Protected:
	String			linecolor				//color
	String			fontcolor				//tab font color
	String			selectfontcolor		//tab select font color
	String			fontface				//font name
	
	Integer		fontsize				//text fontsize
	Integer		imgGabPix				//image gab
	Integer		linethickness			//line thickness
	Integer		textgaby				//fontheight gab
	Integer		buttomimggab		//buttom image gab
	Integer		startmenu_xgab		//Start menu x position gab
	Integer		startmenu_ygab		//Start menu y position gab
	Integer		leftimgwidth			= 0	//Left Image width
	Integer		centerimgwidth		= 0	//center image width
	Integer		rightimgwidth			= 0 	//Right image width
	
	Boolean		overlapstyle			//overlap style tab
	Boolean		buttomimagmode	//buttom image mode
	Boolean		topleftimg_originalsize	//topleftimg original size true false
	Boolean		topcenterimg_originalsize	//topcenterimg original size true false
	Boolean		toprightimg_originalsize	//toprightimg original size true false
	
	String 		FILEPATH		 		= "..\..\img\"
	String			FRONT_SELECT  		= "tab_front_select.gif"
	String			BACK_SELECT  			= "tab_back_select.gif"
	String			END_SELECT			= 	"tab_end_select.gif"
	
	String			FRONT_NONSELECT	= "tab_front_nonselect.gif"
	String			BACK_NONSELECT		= "tab_back_nonselect.gif"
	String			END_NONSELECT		= "tab_end_nonselect.gif"
	
	String			LEFT_IMG				= "topleftimg.gif"
	String			CENTER_IMG			= "topcenterimg.gif"
	String			RIGHT_IMG				= "toprightimg.gif"
	String			BUTTOM_IMAG			= "tab_line.gif"
	
	//name rul
	Constant String		NAME_RUL_FRONT				= "frt"
	Constant String		NAME_RUL_BACK					= "bck"
	Constant String		NAME_RUL_END					= "end"
	Constant String		NAME_RUL_SELECT				= "slt_"
	Constant String		NAME_RUL_NONSELECT			= "nlt_"
	Constant String		NAME_RUL_Txt						= "txt_"
	Constant String		NAME_RUL_BUTTOM				= "line"
	Constant String		NAME_RUL_TOPLEFTIMG 		= "topleftimg"
	Constant String		NAME_RUL_TOPCENTERIMG 	= "topcentertimg"
	Constant String		NAME_RUL_TOPRIGHTIMG 		= "toprightimg"
	Constant String		NAME_RUL_TOPBUTTOMIMG 	= "topbuttomimg"
	
end variables

forward prototypes
private function boolean of_imgsize (string filename, ref long al_height, ref long al_width)
private function string of_reverssyntax (string as_syntax, string as_arg[])
protected subroutine of_scrollset ()
protected subroutine of_scrolltotab (long al_scrollpos)
public subroutine of_init ()
public function long of_backgroundsetting (ref string as_syntax)
public function long of_createtab (str_tree astr_data)
private subroutine of_dwdisign ()
private subroutine of_newdisign (string as_syntax, long al_height)
public function str_size of_getcolumnwidth (string as_text)
public subroutine of_select (integer selecttab, boolean ab_retrieve)
public function boolean of_resize ()
end prototypes

private function boolean of_imgsize (string filename, ref long al_height, ref long al_width);
return true
end function

private function string of_reverssyntax (string as_syntax, string as_arg[]);
return ''
end function

protected subroutine of_scrollset ();
end subroutine

protected subroutine of_scrolltotab (long al_scrollpos);
end subroutine

public subroutine of_init ();
end subroutine

public function long of_backgroundsetting (ref string as_syntax);
return 0
end function

public function long of_createtab (str_tree astr_data);
return 0
end function

private subroutine of_dwdisign ();
end subroutine

private subroutine of_newdisign (string as_syntax, long al_height);
end subroutine

public function str_size of_getcolumnwidth (string as_text);
str_size lstr_Size
Return lstr_Size
end function

public subroutine of_select (integer selecttab, boolean ab_retrieve);
end subroutine

public function boolean of_resize ();
return True
end function

on uo_topselect.create
this.st_text=create st_text
this.hsb_1=create hsb_1
this.p_1=create p_1
this.designedw=create designedw
this.ln_1=create ln_1
this.Control[]={this.st_text,&
this.hsb_1,&
this.p_1,&
this.designedw,&
this.ln_1}
end on

on uo_topselect.destroy
destroy(this.st_text)
destroy(this.hsb_1)
destroy(this.p_1)
destroy(this.designedw)
destroy(this.ln_1)
end on

event constructor;
end event

type st_text from statictext within uo_topselect
boolean visible = false
integer x = 1294
integer y = 92
integer width = 1024
integer height = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type hsb_1 from hscrollbar within uo_topselect
boolean visible = false
integer x = 2450
integer y = 32
integer width = 151
integer height = 76
integer minposition = 1
integer maxposition = 100
integer position = 1
end type

event lineleft;
end event

event lineright;
end event

type p_1 from picture within uo_topselect
boolean visible = false
integer x = 1673
integer y = 316
integer width = 229
integer height = 200
boolean originalsize = true
boolean focusrectangle = false
end type

type designedw from datawindow within uo_topselect
event ue_mousemove pbm_dwnmousemove
integer width = 2679
integer height = 284
integer taborder = 10
string title = "none"
boolean minbox = true
boolean border = false
boolean livescroll = true
end type

event clicked;
end event

type ln_1 from line within uo_topselect
long linecolor = 33554432
integer linethickness = 13
integer beginy = 140
integer endx = 2601
integer endy = 140
end type

