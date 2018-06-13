$PBExportHeader$uo_tabselect.sru
forward
global type uo_tabselect from userobject
end type
type st_text from statictext within uo_tabselect
end type
type hsb_1 from hscrollbar within uo_tabselect
end type
type p_1 from picture within uo_tabselect
end type
type designedw from datawindow within uo_tabselect
end type
type ln_1 from line within uo_tabselect
end type
type p_close from u_picture within uo_tabselect
end type
type str_bitmap from structure within uo_tabselect
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

global type uo_tabselect from userobject
integer width = 2606
integer height = 152
long backcolor = 134217747
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
string powertiptext = "test"
event ue_setroll ( str_tree astr_data )
st_text st_text
hsb_1 hsb_1
p_1 p_1
designedw designedw
ln_1 ln_1
p_close p_close
end type
global uo_tabselect uo_tabselect

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
	tab			itb_select
	Integer		ii_selecttab
	
	datastore		ids_nlt_ft, ids_nlt_bk, ids_nlt_ed, ids_txt

	Integer		ii_scrollpos	= 1
	Integer		ii_scrollmax
	Integer		ii_this
	Integer		ii_height
	
	Boolean		ib_destroy
	Boolean		ib_opensheetwithparm
	Boolean		ib_tabclicked = true
	
	//V1.9.9.012_  of_select의 변화가 필요하여 넣었다.
	w_base		iw_active
	//==============================
Protected:
	String			linecolor					//color
	String			fontcolor					//tab font color
	String			_backcolor		= ''		//background color
	String			selectfontcolor		//tab select font color
	String			fontface				//font name
	
	Integer		fontsize					//text fontsize
	Integer		imgGabPix				//image gab
	Integer		linethickness			//line thickness
	Integer		textgaby				//fontheight gab
	Integer		closewinxgab			//close window button x gab
	Integer		closewinygab			//close window button y gab
	Integer		TextLeftRightGab	//Text left Right Gab
	
	Boolean		overlapstyle			//overlap style tab
	Boolean		tooltab					//toolbar tab image style
	Boolean		buttomimagmode	//buttom image mode
	Boolean		tabbuttom				//위치가 밑에 일때
		
	String 		FILEPATH		 			= "..\..\img\"
	String		FRONT_SELECT  		= "tab_front_select.gif"
	String		BACK_SELECT  			= "tab_back_select.gif"
	String		END_SELECT				= 	"tab_end_select.gif"
	
	String		FRONT_NONSELECT	= "tab_front_nonselect.gif"
	String		BACK_NONSELECT		= "tab_back_nonselect.gif"
	String		END_NONSELECT		= "tab_end_nonselect.gif"

	String		CLOSE_TOOLTAB		= "closetooltab.gif"
	
	String		BUTTOM_IMAG			= "tab_line.gif"
	//name rul
	Constant String		NAME_RUL_FRONT		= "frt"
	Constant String		NAME_RUL_BACK			= "bck"
	Constant String		NAME_RUL_END			= "end"
	Constant String		NAME_RUL_SELECT		= "slt_"
	Constant String		NAME_RUL_NONSELECT	= "nlt_"
	Constant String		NAME_RUL_Txt				= "txt_"
	Constant String		NAME_RUL_BUTTOM		= "line"

Public:
	String		selecttabobject		//tabobject object
	Boolean		ib_close = True
end variables

forward prototypes
public subroutine of_select (integer selecttab)
public subroutine of_resizetab ()
private function integer of_dwdisign ()
private function boolean of_imgsize (string filename, ref long al_height, ref long al_width)
private subroutine of_selectwin (integer ai_select)
private subroutine of_newdisign ()
public subroutine of_next ()
public subroutine of_back ()
public function long of_createtab (str_tree astr_data)
private subroutine of_openwindow (str_tree astr_data)
protected subroutine of_scrollset ()
protected subroutine of_scrolltotab (long al_scrollpos)
private function boolean of_settab (powerobject apo)
public subroutine of_closewin ()
private function str_size of_getcolumnwidth (string as_text)
protected function boolean of_resize ()
private subroutine of_selecttab (integer selecttab)
private subroutine of_cpclosebtn (integer selecttab)
private subroutine of_imgselecttop (integer selecttab)
public subroutine of_destroytab (string as_pgmno)
private function integer of_checkwindow (string as_pgmno)
public function boolean of_select (string as_pgmno)
public function w_base of_opensheet (string as_title, string as_winname, string as_pgmno)
public function w_base of_opensheetparm (string as_title, string as_winname, string as_pgmno, long al_arg)
public function w_base of_opensheetparm (string as_title, string as_winname, string as_pgmno, powerobject apo_arg)
public function w_base of_opensheetparm (string as_title, string as_winname, string as_pgmno, string as_arg)
public function boolean of_select (string as_pgmno, ref w_base aw_return)
end prototypes

public subroutine of_select (integer selecttab);
end subroutine

public subroutine of_resizetab ();
end subroutine

private function integer of_dwdisign ();
return 0
end function

private function boolean of_imgsize (string filename, ref long al_height, ref long al_width);
return true
end function

private subroutine of_selectwin (integer ai_select);
end subroutine

private subroutine of_newdisign ();
end subroutine

public subroutine of_next ();
end subroutine

public subroutine of_back ();
end subroutine

public function long of_createtab (str_tree astr_data);
return 0
end function

private subroutine of_openwindow (str_tree astr_data);
end subroutine

protected subroutine of_scrollset ();
end subroutine

protected subroutine of_scrolltotab (long al_scrollpos);
end subroutine

private function boolean of_settab (powerobject apo);
return true
end function

public subroutine of_closewin ();
end subroutine

private function str_size of_getcolumnwidth (string as_text);
str_size lstr_Size

Return lstr_Size
end function

protected function boolean of_resize ();
return true

end function

private subroutine of_selecttab (integer selecttab);
end subroutine

private subroutine of_cpclosebtn (integer selecttab);
end subroutine

private subroutine of_imgselecttop (integer selecttab);
end subroutine

public subroutine of_destroytab (string as_pgmno);
end subroutine

private function integer of_checkwindow (string as_pgmno);
return 0
end function

public function boolean of_select (string as_pgmno);
return true
end function

public function w_base of_opensheet (string as_title, string as_winname, string as_pgmno);
w_base 	lw_Child
return lw_child
end function

public function w_base of_opensheetparm (string as_title, string as_winname, string as_pgmno, long al_arg);
w_base 	lw_Child
return lw_child
end function

public function w_base of_opensheetparm (string as_title, string as_winname, string as_pgmno, powerobject apo_arg);
w_base 	lw_Child
return lw_child
end function

public function w_base of_opensheetparm (string as_title, string as_winname, string as_pgmno, string as_arg);
w_base 	lw_Child
return lw_child
end function

public function boolean of_select (string as_pgmno, ref w_base aw_return);
return true
end function

on uo_tabselect.create
this.st_text=create st_text
this.hsb_1=create hsb_1
this.p_1=create p_1
this.designedw=create designedw
this.ln_1=create ln_1
this.p_close=create p_close
this.Control[]={this.st_text,&
this.hsb_1,&
this.p_1,&
this.designedw,&
this.ln_1,&
this.p_close}
end on

on uo_tabselect.destroy
destroy(this.st_text)
destroy(this.hsb_1)
destroy(this.p_1)
destroy(this.designedw)
destroy(this.ln_1)
destroy(this.p_close)
end on

event constructor;
end event

type st_text from statictext within uo_tabselect
boolean visible = false
integer x = 1701
integer y = 28
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type hsb_1 from hscrollbar within uo_tabselect
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

type p_1 from picture within uo_tabselect
boolean visible = false
integer x = 1673
integer y = 316
integer width = 229
integer height = 200
boolean originalsize = true
boolean focusrectangle = false
end type

type designedw from datawindow within uo_tabselect
integer width = 2597
integer height = 136
integer taborder = 10
string title = "none"
boolean minbox = true
boolean border = false
boolean livescroll = true
end type

event clicked;
end event

type ln_1 from line within uo_tabselect
long linecolor = 33554432
integer linethickness = 13
integer beginy = 140
integer endx = 2601
integer endy = 140
end type

type p_close from u_picture within uo_tabselect
boolean visible = false
integer x = 1358
integer y = 304
integer width = 73
integer height = 64
boolean bringtotop = true
end type

event clicked;call super::clicked;
end event

