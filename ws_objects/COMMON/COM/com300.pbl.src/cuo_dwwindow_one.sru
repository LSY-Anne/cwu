$PBExportHeader$cuo_dwwindow_one.sru
$PBExportComments$한행의 데이타 원도우를 가질경루.주로 저장용 데이타 원도우에 사용.
forward
global type cuo_dwwindow_one from u_dw
end type
end forward

global type cuo_dwwindow_one from u_dw
event ue_mousemove pbm_dwnmousemove
event ue_lbtndown pbm_lbuttondown
event ue_resize pbm_mousemove
event ue_lbtnup pbm_lbuttonup
event ue_checkpoint ( )
event un_unmove pbm_syscommand
end type
global cuo_dwwindow_one cuo_dwwindow_one

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
	String		RowSelectColor 						= '248,231,237' //230,230,230 Grid Dw에서 라인을 선택시 해당 선택라인색상 결정.
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
public subroutine of_ondisplay ()
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
public function boolean uf_isnewrow ()
public function integer uf_tab ()
public subroutine uf_winid (window as_window)
end prototypes

event ue_mousemove;Integer		li_pos

IF Pos(This.GetBandAtPointer(), "header", 1) > 0  THEN
	IF dwo.type = 'text' THEN
		li_pos = Pos(dwo.name, NORMAL_SUB, 1)
		IF li_pos > 0 THEN
			//ls_colname
			IF is_old <> dwo.name THEN
				SetCapture(Handle(This))
				//이전 자료를 초기화 해준다.
				of_oldsetting()
				//현제 자료 셋팅 
				of_newsetting(dwo)
			END IF			
		END IF
	ELSE
		IF Not ib_mouseon THEN
				ReleaseCapture()
				//이전 자료를 초기화 해준다.
				of_oldsetting()
		END IF
	END IF
Else
	IF Not ib_mouseon THEN
//		If Not ib_mousemove Then
			ReleaseCapture()
//		End If
		//이전 자료를 초기화 해준다.
		of_oldsetting()
	END IF
END IF
end event

event ue_lbtndown;
String ls_colname, ls_objname
Integer	li_pos 

IF Not ib_mouseon THEN
	ls_objname = This.GetObjectAtPointer()
	ls_objname = MID(ls_objname, 1, POS(ls_objname, "~t") - 1)
	
	li_pos = Pos(ls_objname, GRAYSEP1, 1)
	
	IF li_pos = 0 THEN
		li_pos = Pos(ls_objname, GRAYSEP2, 1)
	END IF
	
	IF li_pos > 0 THEN
		ib_mouseon = True
		ls_colname = Left(ls_objname, Len(ls_objname) - Len(GRAYSEP1))
		ii_idx = of_getcolindex(ls_colname)
	ELSE
		ii_idx = 0
		ib_mouseon = False
	END IF
END IF

end event

event ue_resize;IF ib_mouseon THEN
	IF flags = 1 THEN
		IF ii_idx > 0 THEN
			This.SetRedraw(False)
			This.of_resize(ii_idx, xpos)
			This.SetRedraw(True)
		END IF
	END IF
END IF


end event

event ue_lbtnup;
IF ib_mouseon THEN
	ii_idx = 0
	ib_mouseon = False
END IF

end event

event ue_checkpoint();POINT lp
ulong ll
ulong lul

lul = Handle(This)

IF GetCursorPos(lp) THEN
	IF Screentoclient(lul, lp) THEN
		IF lp.x > Long(This.Describe(is_old + ".x")) AND lp.x < (Long(This.Describe(is_old + ".x")) + Long(This.Describe(is_old + ".width"))) AND lp.y  > 0 AND lp.y < Long(This.Describe("Datawindow.Header.Height")) THEN //UnitsToPixels(Long(This.Describe("Datawindow.Header.Height")), YUnitsToPixels!) THEN
			IF Not mouseover THEN
				SetCapture(Handle(This))
				mouseover = True
				of_ondisplay()
			END IF
		ELSE
			IF mouseover THEN
				mouseover = False
				ReleaseCapture()
				of_oldsetting()
				This.SetRedRaw(True)
				of_ondisplay()
			END IF
		END IF
	END IF
END IF

end event

event un_unmove;uint li_msg
li_msg = message.wordparm
CHOOSE CASE li_msg
	CASE 61456, 61458
		message.processed = true
//		message.returnvalue = 0
END CHOOSE

return
end event

private function boolean of_checkprocess ();String 	ls_rtn, ls_syntax
Long		ll_pos 
Boolean	lb_rtn = True
ls_rtn = This.Describe(PROCESSING)
IF ls_rtn <> "0"  AND Not ( UseGrid	AND ls_rtn = "1" ) THEN 
	lb_rtn = False
ELSE
	lb_rtn = True
	IF UseGrid	THEN  
		lb_rtn = True
		ls_syntax = This.Describe("Datawindow.Syntax")
		IF ls_rtn = "1" THEN
			replaceall(ls_Syntax, "processing=1", "processing=0")
			replaceall(ls_syntax, "selected.mouse=yes", "")
			IF This.Create(ls_syntax, ls_rtn) > 0 THEN
				lb_rtn = True
			ELSE
				Messagebox("Error", "Create Processing Error : " + ls_rtn)
				lb_rtn = False
			END IF	
		END IF
	ELSE
		lb_rtn = True
	END IF
END IF

return lb_rtn

end function

private function integer of_getcolindex (string as_colname);Integer i, li_cnt, li_idx

li_cnt = UpperBound(istr_dwlv.item)

FOR i = 1 TO li_cnt
	IF istr_dwlv.item[i].column = as_colname THEN Exit
NEXT

return i
end function

private function boolean of_modify (string as_syntax);String ls_err
ls_err = This.Modify(as_syntax)
IF ls_err  <> "" THEN 
	::Clipboard(This.ClassName() + "~r~n" + as_syntax)
	messagebox("Info", This.ClassName() + " Create Syntax Failed in DWLV : " + ls_err)
	return false
END IF
return true
end function

private subroutine of_newsetting (dwobject dwo);String ls_colname, ls_err, ls_syntax

IF Pos(dwo.name, NORMAL_SUB, 1) > 0 THEN
	ls_colname = Left(dwo.name, Len(String(dwo.name)) - Len(NORMAL_SUB))
	
	ls_syntax = " ~n" + dwo.name + ".Visible=0"
	ls_syntax += " ~n" + ls_colname + HOTFIX_SUB + ".Visible=1"
	ls_syntax += " ~n" + ls_colname + HOTFIX_TEMP + ".Visible=1"
	ls_syntax += " ~n" + ls_colname + SHADE_SUB + '.pen.color="1073741824~trgb(' + HotLineColor + ')"'
	
	IF Not This.of_modify(ls_syntax) THEN return
	
	is_old = ls_colname + HOTFIX_SUB
END IF

//ib_mousemove = False
end subroutine

private subroutine of_resize (integer ai_idx, integer xpos);Integer i, li_cnt, li_idx, j
long		ll_xpos, ll_width, ll_frontpos
String	ls_colname, ls_syntax, ls_err

li_cnt = UpperBound(istr_dwlv.item)
ll_xpos = xpos + LONG(This.Describe("Datawindow.HorizontalScrollPosition"))
ll_frontpos = Long(This.Describe( istr_dwlv.item[ai_idx].column + NORMAL_SUB + ".x")) + MinSize

IF ll_xpos < ll_frontpos THEN return
//GSep1
ls_syntax = istr_dwlv.item[ai_idx].column + GRAYSEP1 + ".x1=" + String(ll_xpos)
ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + GRAYSEP1 + ".x2=" + String(ll_xpos)

//GSep2
ll_xpos = ll_xpos + VLINEGAB
ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + GRAYSEP2 + ".x1=" + String(ll_xpos)
ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + GRAYSEP2 + ".x2=" + String(ll_xpos)

IF GridStyle THEN
	//line
	ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + VERTICAL_LINE + ".x1=" + String(ll_xpos)
	ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + VERTICAL_LINE + ".x2=" + String(ll_xpos)
END IF

//Hot/normal
ll_width = ll_xpos - Long(This.Describe( istr_dwlv.item[ai_idx].column + NORMAL_SUB + ".x")) - GRAYSEP_GAB - VLINEGAB
//Nomal
ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + NORMAL_SUB + ".width=" + String(ll_width)
//Hot
ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + HOTFIX_SUB + ".width=" + String(ll_width)
//Hot Tep
ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + HOTFIX_TEMP + ".width=" + String(ll_width)

//Arrow
IF SortVisible THEN
	ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + 	ARROW_SUB + ".x=" + String(long(This.Describe( istr_dwlv.item[ai_idx].column + HOTFIX_SUB + ".x")) + ll_width - 55 - ARROWGABX)
END IF

//Shade
ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + SHADE_SUB + ".x2=" + String(ll_xpos - GRAYSEP_GAB)

//Column
istr_dwlv.item[ai_idx].width = ll_width - ( DETAILCOLUMNGAB * 2 )
ls_syntax += " ~n" + istr_dwlv.item[ai_idx].column + ".width=" + String(istr_dwlv.item[ai_idx].width)
li_idx = UpperBound(istr_dwlv.item[ai_idx].obj)
FOR i = 1 TO li_idx
	ls_syntax += " ~n" + istr_dwlv.item[ai_idx].obj[i] + ".width=" + String(istr_dwlv.item[ai_idx].width)
NEXT

IF ai_idx < li_cnt THEN
	ai_idx++
	For i = ai_idx To li_cnt
		ll_xpos = ll_xpos + VLINEGAB
		
		//Nomal/Hot
		ls_syntax += " ~n" + istr_dwlv.item[i].column + NORMAL_SUB + ".x=" + String(ll_xpos)
		ls_syntax += " ~n" + istr_dwlv.item[i].column + HOTFIX_SUB + ".x=" + String(ll_xpos)
		ls_syntax += " ~n" + istr_dwlv.item[i].column + HOTFIX_TEMP + ".x=" + String(ll_xpos)
		
		//Arrow
		IF SortVisible THEN
			ls_syntax += " ~n" + istr_dwlv.item[i].column + 	ARROW_SUB + ".x=" + String(long(This.Describe( istr_dwlv.item[i].column + HOTFIX_SUB + ".width")) + ll_xpos - 55 - ARROWGABX)
		END IF

		//Column
		istr_dwlv.item[i].x = ll_xpos + DETAILCOLUMNGAB
		ls_syntax += " ~n" + istr_dwlv.item[i].column + ".x=" + String(istr_dwlv.item[i].x)
		li_idx = UpperBound(istr_dwlv.item[i].obj)
		FOR j = 1 TO li_idx
			ls_syntax += " ~n" + istr_dwlv.item[i].obj[j] + ".x=" + String(istr_dwlv.item[i].x)
		NEXT
		
		//Shade
		ls_syntax += " ~n" + istr_dwlv.item[i].column + SHADE_SUB + ".x1=" + String(ll_xpos)
		ll_xpos = ll_xpos + Long(This.Describe(istr_dwlv.item[i].column + HOTFIX_SUB + ".width"))
		ls_syntax += " ~n" + istr_dwlv.item[i].column + SHADE_SUB + ".x2=" + String(ll_xpos)
		
		//GSep1
		ll_xpos = ll_xpos + VLINEGAB
		ls_syntax += " ~n" + istr_dwlv.item[i].column + GRAYSEP1 + ".x1=" + String(ll_xpos)
		ls_syntax += " ~n" + istr_dwlv.item[i].column + GRAYSEP1 + ".x2=" + String(ll_xpos)

		
		//GSep2
		ll_xpos = ll_xpos + VLINEGAB
		ls_syntax += " ~n" + istr_dwlv.item[i].column + GRAYSEP2 + ".x1=" + String(ll_xpos)
		ls_syntax += " ~n" + istr_dwlv.item[i].column + GRAYSEP2 + ".x2=" + String(ll_xpos)

		//line		
		IF GridStyle THEN
			ls_syntax += " ~n" + istr_dwlv.item[i].column + VERTICAL_LINE + ".x1=" + String(ll_xpos)
			ls_syntax += " ~n" + istr_dwlv.item[i].column + VERTICAL_LINE + ".x2=" + String(ll_xpos)
		END IF
	Next
END IF

IF GridStyle THEN
	FOR i = 1 TO ii_bkrowcnt
		ls_syntax += " ~n" + "rt_" + String(i) + ".width=" + String(ll_xpos)
	NEXT
	IF RowSelect THEN	ls_syntax += " ~n" + "rt_current.width=" + String(ll_xpos)
END IF

ls_syntax += " "
IF Not This.of_modify(ls_syntax) THEN return
end subroutine

public subroutine of_ondisplay ();IF mouseover THEN
	IF Not IsValid(in_timer) THEN
		in_timer = CREATE n_timing
		in_timer.event ke_setparent(this, "ue_checkpoint")
		in_timer.Start(INTERVAL)
	END IF
ELSE
	IF ISVALID(in_timer) THEN
		ReleaseCapture()
		in_timer.Stop()
		DESTROY in_timer
	END IF
END IF
end subroutine

private subroutine of_oldsetting ();String ls_err, ls_syntax, ls_colname

ls_colname = Left(is_old, Len(String(is_old)) - Len(HOTFIX_SUB))

IF Not IsNull(is_old) AND is_old <> "" THEN
	ls_syntax = " ~n" + ls_colname  + HOTFIX_SUB + ".Visible=0"
	ls_syntax += " ~n" + ls_colname  + HOTFIX_TEMP + ".Visible=0"
	ls_syntax += " ~n" + ls_colname  + NORMAL_SUB + ".Visible=1"
	ls_syntax += " ~n" + ls_colname + SHADE_SUB + ".pen.color='1073741824~trgb(" + NomalLineColor + ")'"
	IF Not This.of_modify(ls_syntax) THEN return
END IF

//ib_mousemove = True
end subroutine

private function integer of_defaltseting ();string	ls_modify
boolean	lb_rtn


IF of_checkprocess() THEN
	String		ls_temp[]
	str_dwlv	lstr_temp
	//초기화
	is_old =  ''
	is_new = ''
	is_sortsyntax = ''
	ii_idx = 0
	ii_bkrowcnt = 0
	ib_multsort = False
	ib_mouseon = False
	
	is_col = ls_temp
	istr_dwlv = lstr_temp
	
	lb_rtn = true
	of_setobjects(lb_rtn)

	//lb_rtn = of_checkversion()
	
	IF lb_rtn THEN
		of_init()
	END IF
END IF
return 1

end function

private function string of_getobjects (ref string as_objlist[], long al_x, datastore ads_more, long xpos, long widthpos);Integer	i, li_row
String		ls_syntax
ads_more.SetFilter("objectpositionx=" + String(al_x))
ads_more.Filter()

li_row = ads_more.rowcount()
FOR i = li_row TO 1 Step -1 
	as_objlist[i] = ads_more.GetItemString(i, "objectname")
	ls_syntax += " ~n" + as_objlist[i] + ".x=" + String(xpos)
	ls_syntax += " ~n" + as_objlist[i] + ".width=" + String(widthpos)
NEXT

return ls_syntax
end function

public subroutine of_init ();long		ll_cpu
String					ls_syntax
str_uservalue		uservalue
str_defaultvalue	defaultvalue

uservalue.GridStyle					= GridStyle
uservalue.AlternateRowColors		= AlternateRowColors
uservalue.SortVisible					= SortVisible
uservalue.RowSelect					= rowselect

defaultvalue.FontBorderTrue		= FontBorderTrue
defaultvalue.fontBorderFalse		= fontBorderFalse
defaultvalue.GRAYSEP_GAB			= GRAYSEP_GAB
defaultvalue.GRAYSEP_TBGAB 		= GRAYSEP_TBGAB
defaultvalue.HBAND_GAB				= HBAND_GAB
defaultvalue.LINE_GAB				= LINE_GAB		
defaultvalue.GLINEGAB				= GLINEGAB	
defaultvalue.VLINEGAB				= VLINEGAB
defaultvalue.HLINEGAB				= HLINEGAB	
defaultvalue.TOPMARGIN				= TOPMARGIN
defaultvalue.BOTUMMARGIN			= BOTUMMARGIN
defaultvalue.DETAILCOLUMNGAB	= DETAILCOLUMNGAB
defaultvalue.ARROWGABX			= ARROWGABX
defaultvalue.ARROWGABY			= ARROWGABY	

ls_syntax		= this.Object.datawindow.syntax
ls_syntax		= of_setdesign(ls_syntax, this.height, istr_dwlv, defaultvalue, uservalue)

IF this.Create(ls_syntax) > 0 THEN
	
//	String 	ls_path
//	Blob		lb_data
//	
//	ls_path = getcurrentdir()
//	ls_path = ls_path + '\dwcache'
//	ls_path = ls_path + '\' + this.dataobject
//	ls_syntax = this.Object.datawindow.syntax
//	lb_data = Blob(ls_syntax, EncodingAnsi!)
//	
//	filemanager		file
//	file = Create filemanager
//	file.setfile( ls_path, lb_data, file.OTHER)
//	destroy file
	
END IF
end subroutine

private function string of_setdesign (string dwsyntax, long dwheight, str_dwlv columns, str_defaultvalue defaultvalue, str_uservalue uservalue);String		ls_syntax,ls_text, ls_y, ls_create, ls_BrushColor
String		ls_fontface, ls_alignment, ls_fontheight
Integer	li_cnt	, i, j
Long		ll_headerheight, ll_ary, ll_detailheight
long		ll_colrow, ll_comprow
long		ll_hx, ll_hwidth, ll_hy, ll_hheight
long		ll_lx, ll_lheight, ll_ly

ls_syntax = '' 
li_cnt = UPPERBOUND(columns.item)

//라인을 만들어주는 포인트 
ll_headerheight 		= Long(This.Describe("Datawindow.header.Height"))// - GRAYSEP_TBGAB
ll_detailheight			= Long(This.Describe("Datawindow.Detail.Height"))
ls_y						= String(defaultvalue.TOPMARGIN)

//detail and header design setting ============================================
FOR i = 1 TO li_cnt
	ll_hx 			= columns.item[i].x - defaultvalue.DETAILCOLUMNGAB
	ll_hwidth		= columns.item[i].width + (2 * defaultvalue.DETAILCOLUMNGAB)

	//Create SHAD
	ls_create 	+= ' ~nline(band=foreground x1="' + String(ll_hx) + '" y1="' + String(ll_headerheight) + '"' + &
						' x2="' + String(ll_hx + ll_hwidth) + '" y2="' + String(ll_headerheight) + '"' + &
						' name=' + columns.item[i].column + SHADE_SUB + &
						' visible="1" pen.style="0" pen.width="' + String(defaultvalue.GLINEGAB) + '"' + &
						' pen.color="1073741824~trgb(' + NomalLineColor + ')"  background.mode="2" background.color="1073741824" )'
	
	//=============================================================
	ll_hy			= long(This.Describe(columns.item[i].column + "_t.y"))
	ll_hheight	= long(This.Describe(columns.item[i].column + "_t.height"))
	ls_fontface		= This.Describe(columns.item[i].column + "_t.font.face")
	ls_alignment	= This.Describe(columns.item[i].column + "_t.alignment")
	ls_fontheight	=  This.Describe(columns.item[i].column + "_t.font.height")
	
	//Create Nomal
	ls_text 		= This.Describe(columns.item[i].column + "_t.text")

	IF Pos(ls_text, "~r~n") > 0 THEN
		ls_text = Mid(ls_text, 1 + Len('"'))
		ls_text = Mid(ls_text, 1, Len(ls_text) - Len('"'))
	END IF

	ls_create 	+= ' ~ntext(band=header alignment="' + ls_alignment + '"' + &
						' text="' + ls_text + '" border="0" color="1073741824~trgb(' + NoFontColor + ')" x="' + String(ll_hx) + '"' +  &
						' y="' +  String(ll_hy) + '" height="' + String(ll_hheight) + '" width="' + String(ll_hwidth) + '"' +  &
						' pointer="HyperLink!" html.valueishtml="0"  name=' + columns.item[i].column + NORMAL_SUB + &
						' visible="1"  font.face="' + ls_fontface + '"' +  &
						' font.height="' + ls_fontheight + '"' +  &
						' font.weight="' + defaultvalue.FontBorderTrue + '"' +  &
						' font.family="2" font.pitch="2" font.charset="0" background.mode="0" background.color="1073741824~trgb(' +  NoBackColor + ')")'
	
	//Create Hot Temp
	ls_create	 	+= ' ~ntext(band=header alignment="' + ls_alignment +  '"' + &
						' text="" border="0" color="1073741824~trgb(' + HotFontColor + ')" x="' + String(ll_hx) +  '"' + &
						' y="0" height="' + String(ll_headerheight) + '" width="' + String(ll_hwidth) +  '"' + &
						' pointer="HyperLink!" html.valueishtml="0"  name=' + columns.item[i].column + HOTFIX_TEMP +  &
						' visible="0"  font.face="' + ls_fontface +  '"' + &
						' font.height="' + ls_fontheight +  '"' + &
						' font.weight="' + defaultvalue.FontBorderTrue +  '"' + &
						' font.family="2" font.pitch="2" font.charset="0" background.mode="0" background.color="1073741824~trgb(' + HotBackColor + ')")'

	//Create Hot 
	ls_create 	+= ' ~ntext(band=header alignment="' +  ls_alignment +  '"' + &
						' text="' + ls_text + '" border="0" color="1073741824~trgb(' + HotFontColor + ')" x="' + String(ll_hx) +  '"' + &
						' y="' + String(ll_hy) + '" height="' + String(ll_hheight) + '" width="' + String(ll_hwidth) +  '"' + &
						' pointer="HyperLink!" html.valueishtml="0"  name=' + columns.item[i].column + HOTFIX_SUB + &
						' visible="0"  font.face="' + ls_fontface +  '"' + &
						' font.height="' + ls_fontheight +  '"' + &
						' font.weight="' + defaultvalue.FontBorderTrue +  '"' + &
						' font.family="2" font.pitch="2" font.charset="0" background.mode="0" background.color="1073741824~trgb(' + HotBackColor + ')")'

	//Arrow
	IF SortVisible THEN
		ll_ary 		= Round(( ll_headerheight - 48 ) / 2, 0) - defaultvalue.ARROWGABY
		IF ll_ary <= 0 THEN ll_ary = defaultvalue.ARROWGABY
		ls_create 	+=' ~ntext(band=foreground alignment="0" text="' + ARROW_DESCENDING +  '"' + & 
						 	' border="0" color="268435456" x="' + String(ll_hx + ll_hwidth - 55 - defaultvalue.ARROWGABX) +  '"' + &
							' y="' + String(ll_ary) + '" height="48" width="55" html.valueishtml="0"  name=' + columns.item[i].column + ARROW_SUB + &
							' visible="0"  font.face="Marlett" font.height="-12" font.weight="400"  font.family="0" ' + &
							' font.pitch="2" font.charset="2" background.mode="1" background.color="553648127")'
	END IF

	//Create Gsep1
	//vline = name, x1x2, y1, y2, band, pencolor, penwidth
	ll_lx			= ll_hx + ll_hwidth + defaultvalue.GRAYSEP_GAB  
	ll_ly 			= defaultvalue.GRAYSEP_TBGAB
	ll_lheight		= ll_headerheight - defaultvalue.GRAYSEP_TBGAB
	
	ls_create 	+=	' ~nline(band=header x1="' + String(ll_lx) + '" y1="' + String(ll_ly) + '" x2="' + String(ll_lx) +  '"' + &
						' y2="' + String(ll_lheight) + '"  pointer="SizeWE!" name=' + columns.item[i].column + GRAYSEP1 +  &
						' visible="1" pen.style="0" pen.width="' + String(defaultvalue.VLINEGAB) + '" pen.color="1073741824~trgb(' + GraySepColor + ')"' + &
						' background.mode="2" background.color="1073741824" )'

	//Vertical Line
	IF uservalue.GridStyle THEN
		ls_create		+=' ~nline(band=foreground x1="' + String(ll_lx) + '" y1="' + String(ll_headerheight) + '" x2="' + String(ll_lx) +  '"' + &
							' y2="' + String(This.height) + '"  name=' + columns.item[i].column + VERTICAL_LINE + &
							' visible="1" pen.style="0" pen.width="' +  String(defaultvalue.VLINEGAB) + '" pen.color="1073741824~trgb(' + LineColor + ')"' + &
							' background.mode="2" background.color="1073741824" )'
	END IF

	//Create Gsep2
	ll_lx 		= ll_lx + VLINEGAB
	ls_create +=	' ~nline(band=header x1="' + String(ll_lx) + '" y1="' + String(ll_ly) + '" x2="' + String(ll_lx) + '" y2="' + String(ll_lheight) +  '"' + &
						' pointer="SizeWE!" name=' + columns.item[i].column + GRAYSEP2 + &
						' visible="1" pen.style="0" pen.width="' + String(defaultvalue.VLINEGAB) +  '"' + &
						' pen.color="1073741824~trgb(' + GraySepColor2 + ')"  background.mode="2" background.color="1073741824" )'
NEXT
//==============detail and header design setting=======================

//alternaterow setting=========================================
IF uservalue.GridStyle THEN
	IF uservalue.AlternateRowColors THEN
		ii_bkrowcnt 			= Integer(Round( (dwheight - ll_headerheight ) / ll_DetailHeight, 0))
		
		FOR i = 1 TO ii_bkrowcnt
			IF Mod(i,2) = 0 THEN
				ls_BrushColor = AlternateFirstColor
			ELSE	
				ls_BrushColor = AlternateSecondColor
			END IF
			
			IF i = 1 Then 
				ls_Y = String(ll_HeaderHeight)
			ELSE
				ls_Y = String(Integer(ls_Y) + ll_DetailHeight)
			END IF	
		
			ls_syntax +=	' ~nrectangle(band=background x="0" y="' + ls_y + '" height="' + String(ll_DetailHeight + 4) + '"' + &
								' width="' + string(ll_lx) + '"  name=rt_' + String(i) + ' visible="1" brush.hatch="6" brush.color="1073741824~trgb(' + ls_BrushColor + ')"' + &
								' pen.style="0" pen.width="' + String(defaultvalue.LINE_GAB) + '" pen.color="1073741824~trgb(' +  LineColor + ')"' + &
								' background.mode="2" background.color="0" )'
		Next			
	END IF
END IF 
//==================alternaterow setting=======================

//selectrow setting ==========================================
IF uservalue.RowSelect THEN
	ls_syntax		+=	'~nrectangle(band=detail x="0" y="0" height="' + String(ll_DetailHeight) + '" width="' + String(ll_lx) + '"' + &
						' name=rt_current visible="1~tif(getrow() = currentrow(), 1, if(isSelected(), 1, 0) )" brush.hatch="6" brush.color="1073741824~trgb(' + RowSelectColor + ')"' +  &
						' pen.style="0" pen.width="' + String(defaultvalue.LINE_GAB) + '" pen.color="1073741824~trgb(' +  LineColor + ')"' + &
						' background.mode="1" background.color="0" )'
END IF
ls_create = trim(ls_syntax + ls_create) + '~n'
//==============selectrow setting ============================

//default syntax modify ====================================
ll_colrow = Pos(dwsyntax, "column(name", 1)
ll_comprow = Pos(dwsyntax, "compute(name", 1)

IF ll_colrow < ll_comprow AND ll_colrow > 0 AND ll_comprow > 0 THEN
	dwsyntax = Left( dwsyntax, ll_colrow - 1) + ls_create + Mid( dwsyntax,  ll_colrow )
ELSEIF ll_colrow > ll_comprow AND ll_colrow > 0 AND ll_comprow > 0 THEN
	dwsyntax = Left( dwsyntax, ll_comprow - 1) + ls_create +  Mid( dwsyntax,  ll_comprow )
ELSEIF ll_colrow = 0 AND ll_comprow > 0 THEN
	dwsyntax = Left( dwsyntax, ll_comprow - 1) + ls_create + Mid( dwsyntax,  ll_comprow )
ELSEIF ll_colrow > 0 AND ll_comprow = 0 THEN
	dwsyntax = Left( dwsyntax, ll_colrow - 1) + ls_create + Mid( dwsyntax,  ll_colrow )
END IF
//================= default syntax modify ===================

//replaceall(dwsyntax, "processing=1", "processing=0")
//replaceall(dwsyntax, "selected.mouse=yes", "")

return dwsyntax

end function

private subroutine of_sort (dwobject dwo);String 	ls_colname, ls_sort, ls_err, ls_syntax, ls_text, ls_sorttype, ls_oldsorttype
Long		ll_pos
Integer	i, li_cnt
String		ls_temp, ls_coltyp
Boolean	lb_edt
IF dwo.type = "text" THEN
	ll_pos = Pos(dwo.name, HOTFIX_SUB, 1)
	IF ll_pos = 0 THEN
		ll_pos = Pos( dwo.name, ARROW_SUB, 1)
		IF ll_pos > 0 THEN
			ls_colname = Left( dwo.name, Len(String(dwo.name)) - Len(ARROW_SUB))
		END IF
	ELSE
		ls_colname = Left( dwo.name, Len(String(dwo.name)) - Len(HOTFIX_SUB))
	END IF
	
	IF Pos(CheckBoxName, ls_colname, 1) > 0 THEN Return
	
	//=====================================
	ls_temp = Trim(This.Describe(ls_colname + ".DDDW.Name"))
	IF IsNull(ls_temp) THEN ls_temp = ''
	CHOOSE CASE ls_temp
		CASE '','!','?'
		CASE ELSE
			lb_edt = TRUE
	END CHOOSE
	
	ls_temp = Trim(This.Describe(ls_colname + ".DDLB.VScrollBar"))
	IF IsNull(ls_temp) THEN ls_temp = ''
	CHOOSE CASE ls_temp
		CASE '','!','?'
		CASE ELSE
			lb_edt = TRUE
	END CHOOSE
	
	ls_temp = Lower(Trim(This.Describe(ls_colname + ".Edit.CodeTable")))
	CHOOSE CASE ls_temp
		CASE 'yes','1'
			lb_edt = TRUE
	END CHOOSE
	
	ls_temp = Lower(Trim(This.Describe(ls_colname + ".EditMask.CodeTable")))
	CHOOSE CASE ls_temp
		CASE 'yes','1'
			lb_edt = TRUE
	END CHOOSE
	
	//=====================================
	IF ll_pos > 0 THEN
		ls_sort = This.Describe(ls_colname + ARROW_SUB + ".text")
		
		IF ls_sort = ARROW_ASCENDING THEN
			ls_sorttype = "D"
			ls_oldsorttype = "A"
			ls_text = ARROW_DESCENDING
		ELSE
			ls_sorttype = "A"
			ls_oldsorttype = "D"
			ls_text = ARROW_ASCENDING
		END IF
		
		ls_temp = ls_colname
		IF lb_edt THEN
			ls_temp = "lookupdisplay ( " + ls_temp + " )"
		END IF		
		
		ls_coltyp = Upper(This.Describe(ls_colname + ".Coltype"))
		CHOOSE CASE true
			CASE Pos(ls_coltyp, 'CHAR') > 0
				ls_temp = 'if ( isnull ( ' + ls_temp + ' ) , "" , ' + ls_temp + ' )'
			CASE Pos(ls_coltyp, 'DATETIME') > 0
				ls_temp = 'if ( isnull ( ' + ls_temp + ' ) , 1999-01-01 00:00:00, ' + ls_temp + ' )'
			CASE Pos(ls_coltyp, 'DATE') > 0
				ls_temp = 'if ( isnull ( ' + ls_temp + ' ) , 1999-01-01, ' + ls_temp + ' )'
			CASE Pos(ls_coltyp, 'DECIMAL') > 0 OR  Pos(ls_coltyp, 'INT')  > 0 OR Pos(ls_coltyp, 'LONG')  > 0 OR Pos(ls_coltyp, 'NUMBER')  > 0 OR Pos(ls_coltyp, 'REAL')  > 0 OR Pos(ls_coltyp, 'ULONG')  > 0
				ls_temp = 'if ( isnull ( ' + ls_temp + ' ) , 0, ' + ls_temp + ' )'
			CASE Pos(ls_coltyp, 'TIME') > 0
				ls_temp = 'if ( isnull ( ' + ls_temp + ' ) , 00:00:00, ' + ls_temp + ' )'
			CASE Pos(ls_coltyp, 'TIMESTAMP') > 0
				ls_temp = 'if ( isnull ( ' + ls_temp + ' ) , 1999-01-01 00:00:00:000, ' + ls_temp + ' )'
		END CHOOSE
		
		IF ib_multsort THEN
			ls_sort = This.Describe(SORT)
			li_cnt = replaceall(ls_sort,  ls_temp + " " + ls_oldsorttype, ls_temp + " " + ls_sorttype )
			
			IF li_cnt = 0 THEN
				IF IsNull(ls_sort) OR Trim(ls_sort) = "" THEN
					ls_sort += ls_temp + " " + ls_sorttype
				ELSE
					ls_sort += ", " + ls_temp + " " + ls_sorttype
				END IF
			END IF
		ELSE
			ls_sort = ls_temp + " " + ls_sorttype
		END IF
		
		This.SetSort(ls_sort)
		This.Sort()
		
		//V1.9.9.011 Group일때 정렬이 잘 안됨..
		THis.Groupcalc( )
		//=================

		IF Not ib_multsort THEN
			li_cnt = UpperBound(istr_dwlv.item)
			FOR i = 1 TO li_cnt
				ls_syntax += " ~n" + istr_dwlv.item[i].column + ARROW_SUB + ".text='" + ARROW_DESCENDING + "'"
				ls_syntax += " ~n" + istr_dwlv.item[i].column + ARROW_SUB + ".visible=0"
			NEXT
			IF Not This.of_modify(ls_syntax) THEN return
		END IF	
		
		ls_syntax = ls_colname + ARROW_SUB + ".text='" + ls_text + "'"
		ls_syntax += " ~n" + ls_colname + ARROW_SUB + ".visible=1"
		
		IF Not This.of_modify(ls_syntax) THEN return
	END IF
END IF
end subroutine

public subroutine of_resize ();Integer 	i, li_cnt
String 		ls_syntax, ls_err, ls_arg[11], ls_width, ls_destroy
String		ls_DetailHeight, ls_HeaderHeight, ls_BrushColor, ls_Y

IF Long(This.Describe("DataWindow.Units")) = 1 THEN
	ls_DetailHeight   	= String(PixelsToUnits(Long(THIS.Describe("DataWindow.Detail.Height")), YPixelsToUnits!))
	ls_HeaderHeight 	= String(PixelsToUnits(Long(THIS.Describe("DataWindow.Header.Height")), YPixelsToUnits!))
ELSE
	ls_DetailHeight   	= THIS.Describe("DataWindow.Detail.Height")
	ls_HeaderHeight 	= THIS.Describe("DataWindow.Header.Height")
END IF
li_cnt = UpperBound(istr_dwlv.item)

ls_width				= This.Describe(istr_dwlv.item[li_cnt].column + GRAYSEP2 + ".x1")

ii_bkrowcnt = Integer(Round( (This.Height - Long(ls_headerheight) ) / Long(ls_DetailHeight), 0))

FOR i = 1 TO ii_bkrowcnt
	IF AlternateRowColors THEN
		IF Mod(i,2) = 0 THEN
			ls_BrushColor = AlternateFirstColor
		ELSE	
			ls_BrushColor = AlternateSecondColor
		END IF
	ELSE
		ls_BrushColor = AlternateSecondColor
	END IF	
	
	IF i = 1 Then 
		ls_Y = ls_HeaderHeight
	ELSE
		ls_Y = String(Integer(ls_Y) + Integer(ls_DetailHeight))
	END IF	
	
	ls_err = this.describe('rt_' + String(i) + '.x')
	if ls_err <> '!' then
		if i = 1 then
			ls_destroy 	= "destroy " + "rt_" + String(i)
		else
			ls_destroy 	+= "~n destroy " + "rt_" + String(i)
		end if
	else
		if i > 1 then
			ls_syntax += '~n '
		end if

		ls_syntax +=	'create rectangle(band=background x="0" y="' + ls_y + '" height="' + String(Long(ls_DetailHeight) + 4) + '"' +  &
					' width="' + ls_width + '"  name=rt_' + String(i) + ' visible="1" brush.hatch="6" brush.color="1073741824~trgb(' + ls_BrushColor + ')"' + &
					' pen.style="0" pen.width="' + String(LINE_GAB) + '" pen.color="1073741824~trgb(' +  LineColor + ')"' + &
					' background.mode="2" background.color="0" )'
	end if
Next			

FOR i = li_cnt TO 1 Step -1
	IF GridStyle THEN
		ls_syntax += " ~n " + istr_dwlv.item[i].column + VERTICAL_LINE + ".y2=" + String(this.height)
	END IF
Next

//This.of_modify(ls_destroy)
This.of_modify(ls_syntax)
this.setredraw( true)
end subroutine

protected function boolean of_checkversion ();String ls_path, ls_data
Blob	 lb_data
integer li_rtn
Boolean	lb_rtn

ls_path = getcurrentdir()
ls_path = ls_path + '\dwcache'

IF Not DirectoryExists(ls_path) THEN
	CreateDirectory(ls_path)
END IF

ls_data = ls_path + '\' + this.dataobject + "_old"

filemanager file
file = Create filemanager

file.getfile(ls_data, lb_data)

ls_data = String(lb_data, EncodingAnsi!)

lb_data = Blob('')

IF ls_data = String(this.object.datawindow.syntax) THEN
	ls_data = ls_path + '\' + this.dataobject
	
	file.getfile(ls_data, lb_data)
	
	ls_data = String(lb_data, EncodingAnsi!)
	lb_data = Blob('')
	
	this.create(ls_data)
	lb_rtn = false
ELSE
	ls_path = ls_path + '\' + this.dataobject + "_old"
	ls_data = this.object.datawindow.syntax
	lb_data = Blob(ls_data, EncodingAnsi!)
	
	li_rtn = file.setfile( ls_path, lb_data, file.OTHER)
	lb_rtn = true
END IF

Destroy file

return lb_rtn
end function

private subroutine of_setobjects (boolean ab_create);String 		ls_objString, ls_ObjHolder, ls_objects[], ls_visible
Integer		li_Count, li_row, i, j
DataStore				lds_sort, lds_more

lds_sort = Create DataStore
lds_more	= Create DataStore

lds_sort.DataObject 	= 'd_objectsort'
lds_more.DataObject = 'd_objectsort'

ls_objString = This.Describe(OBJECTS)

Long	ll_pos

do while Len(ls_objString) > 0
	ll_pos = Pos(ls_objString, '~t')
	IF ll_pos = 0 THEN
		ls_ObjHolder	= ls_objString
		ls_objString 	= ''
	ELSE
		ls_ObjHolder = Left(ls_objString, ll_pos - 1)
		ls_objString = Mid(ls_objString, ll_pos + Len('~t'))
	END IF
	
	ls_visible = This.Describe(ls_ObjHolder + ".visible")
	
	replaceall(ls_visible, '"', '')
	replaceall(ls_visible, "'", "")
	ls_visible = Left(ls_visible, 1)

	If 	(This.Describe(ls_ObjHolder + ".type") 	= "column" 	Or This.Describe(ls_ObjHolder + ".type") 	= "compute"	) And (This.Describe(ls_ObjHolder + ".band") 	= "detail" 	) And ( ls_visible = "1"	) Then
		li_row = lds_sort.Insertrow(0)
		lds_sort.SetItem(li_row, "objectname", ls_ObjHolder)
		lds_sort.SetItem(li_row, "objectpositionx", Long(This.Describe(ls_objHolder + ".x")))
	ELSE
		li_row = lds_more.Insertrow(0)
		lds_more.SetItem(li_row, "objectname", ls_ObjHolder)
		lds_more.SetItem(li_row, "objectpositionx", Long(This.Describe(ls_objHolder + ".x")))
	End if
loop

lds_sort.SetSort("objectpositionx asc")
lds_sort.Sort()

li_count = lds_sort.rowcount()

long	xpos, ypos, widthpos, heightpos, ll_cntj
string	ls_syntax
FOR i = 1 To  li_count
	ls_ObjHolder = lds_sort.GetItemString(i, "objectname")
	istr_dwlv.item[i].column = ls_ObjHolder
	ls_syntax += " ~n" + istr_dwlv.item[i].column + "_t.visible=0"

	IF i = 1 THEN
		xpos			= Long(This.Describe(ls_ObjHolder + ".x"))  + DETAILCOLUMNGAB + GRAYSEP_GAB
		widthpos		= Long(This.Describe(ls_ObjHolder + ".width")) - (2 * DETAILCOLUMNGAB) - (2 * GRAYSEP_GAB)
	ELSE
		xpos			= xpos + widthpos + (2 *DETAILCOLUMNGAB) + (2 * GRAYSEP_GAB) + (2 * VLINEGAB)
		widthpos		= Long(This.Describe(ls_ObjHolder + ".width")) - ( 2* DETAILCOLUMNGAB ) - ( 2 * GRAYSEP_GAB)
	END IF

	ypos			= Long(This.Describe(ls_ObjHolder + ".y"))
	heightpos	= Long(This.Describe(ls_ObjHolder + ".height"))
	
	istr_dwlv.item[i].x 			= xpos
	istr_dwlv.item[i].y 			= ypos
	istr_dwlv.item[i].width 	= widthpos
	istr_dwlv.item[i].height 	= heightpos
	
	IF ab_create THEN
		//Coloumn
		ls_syntax += " ~n" + istr_dwlv.item[i].column + ".x=" + String(istr_dwlv.item[i].x)
		ls_syntax += " ~n" + istr_dwlv.item[i].column + ".y=" + String(istr_dwlv.item[i].y)
		ls_syntax += " ~n" + istr_dwlv.item[i].column + ".width=" + String(istr_dwlv.item[i].width)
		ls_syntax += " ~n" + istr_dwlv.item[i].column + ".height=" + String(istr_dwlv.item[i].height)
//		IF ShowTabOrder THEN
//			ls_syntax += " ~n" + istr_dwlv.item[i].column + ".background.color='0~trgb(" + ShowTabOrderColor + ")'"
//		END IF
		ls_syntax += of_getobjects(istr_dwlv.item[i].obj[], Long(This.Describe(ls_ObjHolder + ".x")), lds_more, xpos, widthpos)
	END IF
NEXT

IF ab_create THEN
	ls_syntax 	+= " ~n" + "DataWindow.Header.Color='1073741824~trgb(" + NoBackColor + ")'"
	IF NOT this.of_modify( ls_syntax ) THEN return
END IF
end subroutine

public subroutine setdataobject (string as_dataobject);This.setredraw( false)
this.dataobject = as_dataobject
This.of_defaltseting()
This.setredraw( true)

end subroutine

public function boolean uf_isnewrow ();/* IsRowNew Check
	# f_rownew(dw_1, 1)
	Argument : datawindow adw_name <- DateWindow name
				  long al_row	<- Current Row
	Return Value : integer li_rtn (-1:error, 0:old row, 1:new row)
*/

string   s_exp
Boolean  b_return = False
int      i_row 

i_row = this.getrow()

if i_row > 0 then
	s_exp = "evaluate('if(IsRowNew(),~"1~", ~"0~")'," + string(i_row) + "1)"
	IF  integer(this.Describe(s_exp)) = 1 then 
		 b_return = True
	end IF
end if

//현재 행이 새로운 행이면,참 아니면 거짓를 한다..
return b_return

end function

public function integer uf_tab ();//Tab 키와 같은 역할을 한다.
send(handle(this),256,9,0)
return 1
end function

public subroutine uf_winid (window as_window);string ls_window
ls_window = upper(as_window.Classname( ))
This.Modify("w_id.Text='" + ls_window + "'")
end subroutine

on cuo_dwwindow_one.create
call super::create
end on

on cuo_dwwindow_one.destroy
call super::destroy
end on

event constructor;This.SetRedraw(False)
//V1.9.9.009 오류 발생
this.setdataobject(this.dataobject)
//=================================
//setdataobject(this.dataobject)
//=================================
This.SetRedraw(True)

This.SetTransObject(sqlca)
This.tag = '1'
 
end event

event clicked;IF SortVisible THEN
	IF Pos(This.GetBandAtPointer(), "header", 1) > 0  OR Pos(dwo.name, ARROW_SUB) > 0 THEN
		IF KeyDown(KeyControl!) AND KeyDown( KeyLeftButton!) THEN
			ib_multsort = True
		ELSE
			ib_multsort = False
		END IF
		
		of_sort(dwo)
	ELSE
		ib_multsort = False
	END IF
END IF

IF row > 0 THEN
	This.SetRow(row)
END IF
end event

event dberror;call super::dberror;CHOOSE CASE sqldbcode

CASE -391 
		MessageBox("Error", "입력자료(Null)를 확인하십시요")			// not null 항목에 null 입력불가
CASE -268 
		MessageBox("Error", "이미 같은자료가 존재합니다")				// pk 중복
CASE -703 
		MessageBox("Error", "입력자료를 확인하십시요")					// 기본 key에 null이 있음
CASE -1226 
		MessageBox("Error", "입력자료가 맞지 않습니다.")  				// 정밀도 초과
CASE ELSE
		MessageBox("Error", "데이타를 확인 하여 주십시요...~r" + sqlerrtext)  	  // 
END CHOOSE

RETURN 1 // Do not display system error message
end event

