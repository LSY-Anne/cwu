$PBExportHeader$u_dwlvin.sru
forward
global type u_dwlvin from u_dw
end type
end forward

global type u_dwlvin from u_dw
event ue_lbtndown pbm_lbuttondown
event ue_lbtnup pbm_lbuttonup
event ue_resize pbm_mousemove
end type
global u_dwlvin u_dwlvin

type prototypes
FUNCTION ulong SetCapture(ulong hwnd) LIBRARY "user32.dll"
FUNCTION ulong ReleaseCapture() LIBRARY "user32.dll"
FUNCTION boolean GetCursorPos(REF POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
end prototypes

type variables
Protected:
	CONSTANT string COLUMN_COUNT 			= "Datawindow.Column.Count"
	CONSTANT string OBJECTS 						= "DataWindow.Objects"
	CONSTANT string PROCESSING 				= "Datawindow.Processing"
	CONSTANT string SORT 							= "Datawindow.Table.Sort"
	CONSTANT string TAG_SEPARATOR 			= ";"
	
	//naming rull
	CONSTANT String ARROW_SUB				= "_arrow"   //화살표
	CONSTANT String SHADE_SUB					= "_shade"	//밑선
	CONSTANT String HOTFIX_SUB				= "_hfx"	 	//Active
	CONSTANT String HOTFIX_TEMP				= "_hft"		//Temp Text 색깔을 위해서 이다.
	CONSTANT String NORMAL_SUB				= "_nml"		//DeActive
	CONSTANT String VERTICAL_LINE				= "_vline"	//세로라인
	CONSTANT String HORIGENTAL_LINE			= "_hline"	//가로 라인.
	CONSTANT String GRAYSEP1					= "_gsep1"	//세로줄표시
	CONSTANT String GRAYSEP2					= "_gsep2"	//세로줄표시
	CONSTANT string ARROW_ASCENDING 		= "t"				
	CONSTANT string ARROW_DESCENDING 	= "u"
	
	//value
	CONSTANT String 	FontBorderTrue			= "700"
	CONSTANT String 	FontBorderFalse			= "400"
	CONSTANT Long 	GRAYSEP_GAB				= PixelsToUnits(1, XPixelsToUnits!)
	CONSTANT Long 	GRAYSEP_TBGAB			= PixelsToUnits(0, YPixelsToUnits!)
	CONSTANT Long 	HBAND_GAB					= PixelsToUnits(2, YPixelsToUnits!)
	CONSTANT Long 	LINE_GAB					= PixelsToUnits(1, YPixelsToUnits!)
	CONSTANT Long 	GLINEGAB					= PixelsToUnits(2, YPixelsToUnits!)
	CONSTANT Long 	VLINEGAB					= PixelsToUnits(1, XPixelsToUnits!)
	CONSTANT Long 	HLINEGAB					= PixelsToUnits(1, YPixelsToUnits!)
	CONSTANT Long 	MinSize						= PixelsToUnits(5, YPixelsToUnits!)
	CONSTANT Long 	TOPMARGIN					= PixelsToUnits(3, YPixelsToUnits!)
	CONSTANT Long 	BOTUMMARGIN				= PixelsToUnits(1, YPixelsToUnits!)
	CONSTANT Long 	DETAILCOLUMNGAB		= PixelsToUnits(2, XPixelsToUnits!)
	CONSTANT Long	ARROWGABX				= PixelsToUnits(2, XPixelsToUnits!)
	CONSTANT Long	ARROWGABY				= PixelsToUnits(2, YPixelsToUnits!)	
	
Public:
	String		LineColor 								= '245,245,245'
	String		ColSelectColor 						= '120,120,120'
	String		RowSelectColor 						= '230,230,230'
	String		HotBackColor							= '238,243,249'
	String		NoBackColor							= '180,215,245'
	String		GraySepColor							= '100,150,195'
	String		GraySepColor2						= '245,245,240'
	String		HotLineColor							= '155,184,216'
	String 		NomalLineColor						= '187,187,187'
	String		AlternateFirstColor					= '245,245,245'
	String		AlternateSecondColor				= '255,255,255'
	String		NoFontColor							= '60,60,60'
	String		HotFontColor							= '60,60,60'
	String		CheckBoxName
	Boolean		GridStyle	= true
	Boolean 	AlternateRowColors = true
	Boolean 	SortVisible = true
	Boolean		RowSelect = true
	Boolean		UseGrid		= false
Private:
	String		is_old, is_new
	String		is_col[]
	String		is_sortsyntax
	Boolean 	ib_mouseon = False
	Boolean	ib_multsort = False
	Boolean		mouseover
	Boolean	ib_mousemove
	Boolean	ib_resize		= false
	Integer	ii_idx, ii_bkrowcnt
	
	str_dwlv	istr_dwlv
	
	n_timing	in_timer
	
	Decimal	INTERVAL		= 0.1
	
end variables

forward prototypes
private function boolean of_checkprocess ()
private function integer of_getcolindex (string as_colname)
private function boolean of_modify (string as_syntax)
private subroutine of_newsetting (dwobject dwo)
private subroutine of_resize (integer ai_idx, integer xpos)
private subroutine of_oldsetting ()
private function integer of_defaltseting ()
private function string of_getobjects (ref string as_objlist[], long al_x, datastore ads_more, long xpos, long widthpos)
public subroutine of_init ()
private function string of_setdesign (string dwsyntax, long dwheight, str_dwlv columns, str_defaultvalue defaultvalue, str_uservalue uservalue)
private subroutine of_sort (dwobject dwo)
public subroutine of_resize ()
protected function boolean of_checkversion ()
private subroutine of_setobjects (boolean ab_create)
public subroutine setdataobject (string as_dataobject)
end prototypes

event ue_lbtndown;
end event

event ue_lbtnup;
end event

event ue_resize;
end event

private function boolean of_checkprocess ();
return true
end function

private function integer of_getcolindex (string as_colname);
return 1
end function

private function boolean of_modify (string as_syntax);
return true
end function

private subroutine of_newsetting (dwobject dwo);
end subroutine

private subroutine of_resize (integer ai_idx, integer xpos);
end subroutine

private subroutine of_oldsetting ();
end subroutine

private function integer of_defaltseting ();
return 1
end function

private function string of_getobjects (ref string as_objlist[], long al_x, datastore ads_more, long xpos, long widthpos);
return ""
end function

public subroutine of_init ();
end subroutine

private function string of_setdesign (string dwsyntax, long dwheight, str_dwlv columns, str_defaultvalue defaultvalue, str_uservalue uservalue);
return ""
end function

private subroutine of_sort (dwobject dwo);
end subroutine

public subroutine of_resize ();
end subroutine

protected function boolean of_checkversion ();
return true
end function

private subroutine of_setobjects (boolean ab_create);
end subroutine

public subroutine setdataobject (string as_dataobject);
end subroutine

on u_dwlvin.create
call super::create
end on

on u_dwlvin.destroy
call super::destroy
end on

event constructor;
end event

event clicked;
end event

