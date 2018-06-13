$PBExportHeader$cuo_dwwindow_one_dwgrid.sru
$PBExportComments$한행의 데이타 원도우를 가질경루.주로 저장용 데이타 원도우에 사용.
forward
global type cuo_dwwindow_one_dwgrid from u_dw
end type
end forward

global type cuo_dwwindow_one_dwgrid from u_dw
event lbuttonup pbm_dwnlbuttonup
event columnmoving ( )
event lbuttondown pbm_lbuttondown
event columnmove pbm_dwnmousemove
event ue_checkpoint ( )
end type
global cuo_dwwindow_one_dwgrid cuo_dwwindow_one_dwgrid

type variables
CONSTANT string SORT 							= "Datawindow.Table.Sort"

CONSTANT String 	ARROW_SUB					= "_arrow"   //화살표

CONSTANT string 	ARROW_ASCENDING 		= "t"				
CONSTANT string 	ARROW_DESCENDING 	= "u"
CONSTANT Long	ARROWGABX					= PixelsToUnits(2, XPixelsToUnits!)
CONSTANT Long 	ARROWGABY					= PixelsToUnits(2, YPixelsToUnits!)	
CONSTANT string 	TEXTSUB 						= "_t"

protected:
	String				RowSelectColor 					= '230,230,230'
	String				HotBackColor 					= '238,243,249'
	String				NoBackColor 						= '180,215,245'
	String				GraySepColor1					= '100,150,195'
	String				GraySepColor2					= '245,245,240'
	String				HotLineColor						= '155,184,216'
	String				NomalLineColor					= '187,187,187'
	String				NoFontColor						= '60,60,60'
	String				HotFontColor						= '60,60,60'	
	String				AlternateFirstColor				= '245,245,245'
	String				AlternateSecondColor			= '255,255,255'
	String				CheckBoxName
	
	Boolean 			AlternateRowColors = true
	Boolean 			SortVisible = true
	Boolean				RowSelect = true
	//V1.9.9.015  data가 없으면 alternate row가 안나왔으면 하는 요청... 옵션으로 처리.
	Boolean				EnableRowDataAlternate = true
	//==================================================
Private:
	String 				is_objectarray[]
	String				is_destroyobj[]

	Boolean				ib_multsort = False
	
	String				is_maxobj
	String				is_destroy
	Boolean				ib_mousedown = false
	Boolean				ib_columnmove = false
end variables

forward prototypes
public subroutine setdataobject (string as_dataobject)
private function integer of_adjustseparators ()
private function integer of_destroystyle ()
private function integer of_getgridwidth ()
private function integer of_getobjects (ref string as_objlist[])
private function integer of_setstyle ()
private subroutine of_sort (dwobject dwo)
protected subroutine of_alternaterow (integer rowcount)
public subroutine createalternaterow (long rowcount)
public subroutine destroyalternaterow ()
public function integer reset ()
public function integer deleterow (long r)
end prototypes

event lbuttonup;Post Event columnmoving()
end event

event columnmoving();IF ( RowSelect OR AlternateRowColors ) AND ib_columnmove AND ib_mousedown THEN
	Long		ll_cnt, i
	String 	ls_syntax
	This.setRedraw(FALSE)
	of_getgridwidth()
	IF AlternateRowColors THEN
		ll_cnt = UpperBound(is_destroyobj)
		FOR i = ll_cnt TO 1 Step -1
			ls_syntax += ' ~n' + is_destroyobj[i] + '.width="0~tLong(Describe(~'' + is_maxobj + '.x~')) + Long(Describe(~'' + is_maxobj + '.width~'))"'
		Next
	END IF
	
	IF RowSelect THEN
		ls_syntax += ' ~nrt_current.width="0~tLong(Describe(~'' + is_maxobj + '.x~')) + Long(Describe(~'' + is_maxobj + '.width~'))"'
	END IF
	//SSC 2009.10.12
	String ls_clip
	ls_clip = ls_syntax
	//::Clipboard(ls_syntax)
	//==============
	
	ls_syntax = This.Modify(ls_syntax)
	IF Len(ls_syntax) > 0 THEN
		//SSC 2009.10.12
		::Clipboard(ls_clip)
		//==============

		Messagebox("Error", ls_syntax)
	END IF
	This.setRedraw(TRUE)
	ib_mousedown = false
	ib_columnmove = false
END IF
end event

event lbuttondown;ib_mousedown = true
end event

event columnmove;IF ib_mousedown THEN
	ib_columnmove = true
END IF
end event

public subroutine setdataobject (string as_dataobject);
String ls_objects

//SSC 2009.10.13
IF IsNull(as_dataobject) OR Len(as_dataobject) = 0 THEN Return
//=================

This.setRedraw(false)
this.dataobject = as_dataobject

ls_objects = THIS.Describe("Datawindow.Objects")

//SSC 2009.10.13
IF IsNull(ls_objects) OR Len(ls_objects) = 0 OR ls_objects = '?' OR ls_objects = '!' THEN 
	This.setRedraw(True)
	Return
END IF
//=================

of_getObjects( is_objectarray)

of_setstyle()

//V1.9.9.015  data가 없으면 alternate row가 안나왔으면 하는 요청... 옵션으로 처리.
IF EnableRowDataAlternate THEN
	of_alternaterow(0)
END IF
//==========================
//of_alternaterow(0)
//==========================
This.setRedraw(true)

end subroutine

private function integer of_adjustseparators ();String ls_x, ls_width, ls_return
Long ll_index, ll_count, ll_x, ll_width

ll_count = UpperBound(is_objectarray)

FOR ll_index = 1 TO ll_count
	
	ls_width = THIS.Describe(is_objectarray[ll_index] + '.width')
	ls_x = THIS.Describe(is_objectarray[ll_index] + '.x')
	
	ll_x = Long(ls_width) + Long(ls_x)
	
	IF ll_x > ll_width THEN
		ll_width = ll_x
	END IF
	
	ls_return += '~n' + is_objectarray[ll_index] + '_line1.x1=' + String(ll_x)
	ls_return += '~n' + is_objectarray[ll_index] + '_line1.x2=' + String(ll_x)
	ls_return += '~n' + is_objectarray[ll_index] + '_line2.x1=' + String(ll_x + 3)
	ls_return += '~n' + is_objectarray[ll_index] + '_line2.x2=' + String(ll_x + 3)
NEXT

ls_return += '~nheaderline1.x1="0"'
ls_return += '~nheaderline2.x1="0"'

ls_return += '~nheaderline1.x2="' + String(ll_width) +'"'
ls_return += '~nheaderline2.x2="' + String(ll_width) +'"'

This.Modify(ls_return)

RETURN 1
end function

private function integer of_destroystyle ();String ls_return
Long ll_index, ll_count

ll_count = UpperBound(is_objectarray)

FOR ll_index = 1 TO ll_count
	
	ls_return += '~nDestroy ' + is_objectarray[ll_index] + '_line1'
	ls_return += '~nDestroy ' + is_objectarray[ll_index] + '_line2'
NEXT

ls_return += '~nDestroy headerline1'
ls_return += '~nDestroy headerline2'

This.Modify(ls_return)
RETURN 1
end function

private function integer of_getgridwidth ();String ls_x, ls_width, ls_return
Long ll_index, ll_count, ll_x
Long ll_width = 0

ll_count = UpperBound(is_objectarray)

FOR ll_index = 1 TO ll_count
	
	ls_width = THIS.Describe(is_objectarray[ll_index] + '.width')
	ls_x = THIS.Describe(is_objectarray[ll_index] + '.x')
	
	ll_x = Long(ls_width) + Long(ls_x)
	
	IF ll_x > ll_width THEN
		ll_width = ll_x
		is_maxobj = is_objectarray[ll_index]
	END IF
	
NEXT

RETURN ll_width
end function

private function integer of_getobjects (ref string as_objlist[]);string	ls_ObjString, ls_ObjHolder
integer	li_Start=1, li_Tab, li_Count=0

/* Get the Object String */
ls_ObjString = This.Describe("Datawindow.Objects")

/* Get the first tab position. */
li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Do While li_Tab > 0
	ls_ObjHolder = Mid(ls_ObjString, li_Start, (li_Tab - li_Start))

	// Determine if object is the right type and in the right band
	If (THis.Describe(ls_ObjHolder + ".type") = "column" Or THis.Describe(ls_ObjHolder + ".type") = "compute") And THis.Describe(ls_ObjHolder + ".band") = "detail" And THis.Describe(ls_ObjHolder + ".visible") = "1"  Then
			li_Count ++
			as_ObjList[li_Count] = ls_ObjHolder
	End if

	/* Get the next tab position. */
	li_Start = li_Tab + 1
	li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Loop 

// Check the last object
ls_ObjHolder = Mid(ls_ObjString, li_Start, Len(ls_ObjString))

// Determine if object is the right type and in the right band
If (THis.Describe(ls_ObjHolder + ".type") = "column" Or THis.Describe(ls_ObjHolder + ".type") = "compute") And THis.Describe(ls_ObjHolder + ".band") = "detail" And THis.Describe(ls_ObjHolder + ".visible") = "1"  Then
		li_Count ++
		as_ObjList[li_Count] = ls_ObjHolder
End if

Return li_Count
end function

private function integer of_setstyle ();String ls_x, ls_width, ls_return, ls_text, ls_linecolor, ls_height, ls_dwsyntax
Long ll_index, ll_count, ll_x, ll_width, ll_colrow, ll_comprow, ll_ary
String ls_rtn
of_DestroyStyle()

ll_count = UpperBound(is_objectarray)

FOR ll_index = 1 TO ll_count
	
	ls_width = THIS.Describe(is_objectarray[ll_index] +  TEXTSUB + '.width')
	ls_x = THIS.Describe(is_objectarray[ll_index] + TEXTSUB + '.x')
	ls_height = THIS.Describe('Datawindow.Header.height')
	
	ls_x = String(Long(ls_width) + Long(ls_x))
	
	ls_rtn += "~n" + is_objectarray[ll_index] + TEXTSUB + ".Pointer='HyperLink!'"
	ls_rtn += "~n" + is_objectarray[ll_index] + TEXTSUB + ".Font.Weight='700'"
	ls_rtn += "~n" + is_objectarray[ll_index] + TEXTSUB + ".Color='0~trgb(" + NoFontColor + ")'"
	
	ls_rtn += '~nCreate line(' + &
	'band=foreground ' + &
	'x1="0~tLong(Describe(~'' + is_objectarray[ll_index] + TEXTSUB + '.x~')) + Long(Describe(~'' + is_objectarray[ll_index] + TEXTSUB + '.width~'))" y1="12" x2="0~tLong(Describe(~'' + is_objectarray[ll_index] + TEXTSUB + '.x~')) + Long(Describe(~'' + is_objectarray[ll_index] + TEXTSUB + '.width~'))" y2="' + String( Long(ls_height)  - PixelsToUnits(3, YpixelsToUnits!)) + '" ' + &
	'name=' + is_objectarray[ll_index] + '_line1 ' + &
	'visible="1~tlong(describe(~''+ is_objectarray[ll_index] + '.visible~'))" pen.style="0" pen.width="5" pen.color="16777215~trgb(' + GraySepColor1 + ')"  background.mode="2" background.color="16777215~trgb(' + GraySepColor1 + ')" )'
	
	ls_rtn += '~nCreate line(' + &
	'band=foreground ' + &
	'x1="0~tLong(Describe(~'' + is_objectarray[ll_index] + TEXTSUB + '.x~')) + Long(Describe(~'' + is_objectarray[ll_index] + TEXTSUB + '.width~')) + 3" y1="12" x2="0~tLong(Describe(~'' + is_objectarray[ll_index] + TEXTSUB + '.x~')) + Long(Describe(~'' + is_objectarray[ll_index] + TEXTSUB + '.width~')) + 3" y2="' +String( Long(ls_height)  - PixelsToUnits(3, YpixelsToUnits!)) + '" ' + &
	'name=' + is_objectarray[ll_index] + '_line2 ' + &
	'visible="1~tlong(describe(~''+ is_objectarray[ll_index] + '.visible~'))" pen.style="0" pen.width="5" pen.color="16777215~trgb(' + GraySepColor2 + ')"  background.mode="2" background.color="16777215~trgb(' + GraySepColor2 + ')" )' 
	
		//Arrow
	IF SortVisible THEN
		ll_ary 		= Round(( Long(ls_height) - 48 ) / 2, 0) - ARROWGABY
		IF ll_ary <= 0 THEN ll_ary = ARROWGABY
		ls_rtn 	+=' ~nCreate text(band=foreground alignment="0" text="' + ARROW_DESCENDING +  '"' + & 
						 	' border="0" color="268435456" x="0~tLong(Describe(~'' + is_objectarray[ll_index] + '.x~')) + Long(Describe(~'' + is_objectarray[ll_index] + '.width~')) - 55 - ' + String(ARROWGABX) +  '"' + &
							' y="' + String(ll_ary) + '" height="48" width="55" html.valueishtml="0"  name=' + is_objectarray[ll_index] + ARROW_SUB + &
							' visible="0"  font.face="Marlett" font.height="-12" font.weight="400"  font.family="0" ' + &
							' font.pitch="2" font.charset="2" background.mode="1" background.color="553648127")'
	END IF
NEXT

ls_rtn += '~nDataWindow.Header.Color= "67108864~trgb(' + NoBackColor + ')"' 
ls_rtn += '~nDataWindow.Detail.Color= "67108864~tif( mod ( getrow ( ) , 2 ) = 0 , rgb ( ' + AlternateSecondColor + ' ) ,  rgb ( ' + AlternateFirstColor + ' ) ) "' 

ll_width = of_GetGridWidth()
//band=foreground
//V1.9.9.010  헤더가 76을 넘을때 라인이 중간에 나타나는 버그 수정...
ls_rtn += '~nCreate line(band=header x1="0" y1="' + ls_height + '" x2="' + String(ll_width) +'" y2="' + ls_height + '"  name=headerline2 visible="1" pen.style="0" pen.width="5" pen.color="10789024~tRGB(214,210,194)"  background.mode="2" background.color="16777215" )'
ls_height = String(Long(ls_height) - PixelsToUnits(1, YPixelsToUnits!))
ls_rtn += '~nCreate line(band=header x1="0" y1="' + ls_height + '" x2="' + String(ll_width) +'" y2="' + ls_height + '"  name=headerline1 visible="1" pen.style="0" pen.width="5" pen.color="10789024~tRGB(226,222,205)"  background.mode="2" background.color="16777215" )'
//===============================================
//ls_rtn += '~nCreate line(band=header x1="0" y1="74" x2="' + String(ll_width) +'" y2="74"  name=headerline1 visible="1" pen.style="0" pen.width="5" pen.color="10789024~tRGB(226,222,205)"  background.mode="2" background.color="16777215" )'
//ls_rtn += '~nCreate line(band=header x1="0" y1="76" x2="' + String(ll_width) +'" y2="76"  name=headerline2 visible="1" pen.style="0" pen.width="5" pen.color="10789024~tRGB(214,210,194)"  background.mode="2" background.color="16777215" )'
//===============================================

//SSC 2009.10.12
String ls_clip
ls_clip = ls_rtn
//::Clipboard(ls_rtn)
//==============

ls_rtn = this.modify(ls_rtn)
IF Len(ls_rtn) > 0 THEN
	//SSC 2009.10.12
	::Clipboard(ls_clip)
	//==============

	Messagebox('Error', ls_rtn)
END IF

//selectrow setting ==========================================
IF RowSelect THEN
	ls_height = This.Describe("Datawindow.Detail.height")
	ls_rtn		=	'~nrectangle(band=detail x="0~t0" y="0" height="' + ls_height + '" width="0~tLong(Describe(~'' + is_maxobj + '.x~')) + Long(Describe(~'' + is_maxobj + '.width~'))"' + &
						' name=rt_current visible="1~tif(getrow() = currentrow(), 1, if(isSelected(), 1, 0) )" brush.hatch="6" brush.color="1073741824~trgb(' + RowSelectColor + ')"' +  &
						' pen.style="0" pen.width="4" pen.color="1073741824~trgb(235,235,235)"' + &
						' background.mode="1" background.color="0" )'
	
	ls_dwsyntax = THis.Describe("Datawindow.Syntax")
	ll_colrow = Pos(ls_dwsyntax, "column(name", 1)
	ll_comprow = Pos(ls_dwsyntax, "compute(name", 1)
	
	IF ll_colrow < ll_comprow AND ll_colrow > 0 AND ll_comprow > 0 THEN
		ls_dwsyntax = Left( ls_dwsyntax, ll_colrow - 1) + ls_rtn + Mid( ls_dwsyntax,  ll_colrow )
	ELSEIF ll_colrow > ll_comprow AND ll_colrow > 0 AND ll_comprow > 0 THEN
		ls_dwsyntax = Left( ls_dwsyntax, ll_comprow - 1) + ls_rtn +  Mid( ls_dwsyntax,  ll_comprow )
	ELSEIF ll_colrow = 0 AND ll_comprow > 0 THEN
		ls_dwsyntax = Left( ls_dwsyntax, ll_comprow - 1) + ls_rtn + Mid( ls_dwsyntax,  ll_comprow )
	ELSEIF ll_colrow > 0 AND ll_comprow = 0 THEN
		ls_dwsyntax = Left( ls_dwsyntax, ll_colrow - 1) + ls_rtn + Mid( ls_dwsyntax,  ll_colrow )
	END IF
	
	This.Create(ls_dwsyntax)
END IF

RETURN 1
end function

private subroutine of_sort (dwobject dwo);String 	ls_colname, ls_sort, ls_err, ls_syntax, ls_text, ls_sorttype, ls_oldsorttype
Long		ll_pos
Integer	i, li_cnt
String		ls_temp, ls_coltyp
Boolean	lb_edt
IF dwo.type = "text" THEN
	ll_pos = Pos( dwo.name, ARROW_SUB, 1)
	IF ll_pos > 0 THEN
		ls_colname = Left( dwo.name, Len(String(dwo.name)) - Len(ARROW_SUB))
	ELSE
		ll_pos =  Pos( dwo.name, TEXTSUB, 1)
		ls_colname = Left( dwo.name, Len(String(dwo.name)) - Len(TEXTSUB))
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
			li_cnt = UpperBound(is_objectarray)
			FOR i = 1 TO li_cnt
				ls_syntax += " ~n" + is_objectarray[i] + ARROW_SUB + ".text='" + ARROW_DESCENDING + "'"
				ls_syntax += " ~n" + is_objectarray[i] + ARROW_SUB + ".visible=0"
			NEXT
			IF Len(This.Modify(ls_syntax)) > 0 THEN return
		END IF	
		
		ls_syntax = ls_colname + ARROW_SUB + ".text='" + ls_text + "'"
		ls_syntax += " ~n" + ls_colname + ARROW_SUB + ".visible=1"
		
		IF Len(This.Modify(ls_syntax)) > 0  THEN return
	END IF
END IF
end subroutine

protected subroutine of_alternaterow (integer rowcount);//alternaterow setting=========================================
This.SetRedraw(false)

IF appeongetclienttype() = "PB" THEN
	destroyalternaterow()
END IF

Post createalternaterow(rowcount)
This.Post SetRedraw(true)
end subroutine

public subroutine createalternaterow (long rowcount);is_destroy = ""
String	ls_BrushColor, ls_y, ls_syntax
Long		ll_height, ll_detailheight, ll_row, ll_check, i, ll_headerheight
String	ls_temp[]

is_destroyobj = ls_temp

IF AlternateRowColors THEN
	ll_headerheight 	=	Long(This.Describe("Datawindow.Header.Height"))
	ll_detailheight 	= 	Long(This.Describe("Datawindow.Detail.Height"))
	
	ll_height = This.Height - ll_headerheight - ( ll_detailheight * rowcount)
	
	IF ll_height > ll_detailheight THEN
		ll_row = Round(ll_height / ll_detailheight, 0)
	
		FOR i = 1 TO ll_row
			IF Mod(rowcount, 2) = 0 THEN
				ll_check = 1
			ELSE
				ll_check = 0
			END IF

			IF Mod(i,2) = ll_check THEN
				ls_BrushColor = AlternateFirstColor
			ELSE	
				ls_BrushColor = AlternateSecondColor
			END IF
			
			IF i = 1 Then 
				ls_Y = String(ll_headerheight + ( ll_detailheight * rowcount))
			ELSE
				ls_Y = String(Integer(ls_Y) + ll_DetailHeight)
			END IF	
		
			ls_syntax +=	' ~ncreate rectangle(band=background x="0~t0" y="' + ls_y + '" height="' + String(ll_DetailHeight + 4) + '"' + &
								' width="0~tLong(describe(~'' + is_maxobj + '.x~')) + Long(describe(~'' + is_maxobj + '.width~'))"  name=rt_' + String(i) + ' visible="1" brush.hatch="6" brush.color="1073741824~trgb(' + ls_BrushColor + ')"' + &
								' pen.style="0" pen.width="4" pen.color="1073741824~trgb(235,235,235)"' + &
								' background.mode="2" background.color="0" )'
			is_destroy += ' ~ndestroy rt_' + String(i)
			is_destroyobj[i] = 'rt_' + String(i)
		Next			
		
		//SSC 2009.10.12
		String ls_clip
		ls_clip = ls_syntax
		//::Clipboard(ls_syntax)
		//==============

		ls_syntax = This.Modify(ls_syntax)
		IF Len(ls_syntax) > 0 THEN 
			//SSC 2009.10.12
			::Clipboard(ls_clip)
			//==============

			Messagebox("Error", ls_syntax)
		END IF
	END IF
END IF
//==================alternaterow setting=======================


end subroutine

public subroutine destroyalternaterow ();This.modify(is_destroy)
end subroutine

public function integer reset ();//SSC 2009-10-15
//insertrow스크립트 삭제
//reset에 스크립트 추가
Long		ll_row, ll_rowcount

ll_row = super::reset()

//V1.9.9.015  data가 없으면 alternate row가 안나왔으면 하는 요청... 옵션으로 처리.
IF EnableRowDataAlternate THEN
	ll_rowcount = super::rowcount()
	of_alternaterow(ll_rowcount)
END IF
//==========================
//ll_rowcount = super::rowcount()
//of_alternaterow(ll_rowcount)
//==========================

return ll_row
end function

public function integer deleterow (long r);Long		ll_row, ll_rowcount

ll_row = super::deleterow(r)

//V1.9.9.015  data가 없으면 alternate row가 안나왔으면 하는 요청... 옵션으로 처리.
IF EnableRowDataAlternate THEN
	ll_rowcount = super::rowcount()
	of_alternaterow(ll_rowcount)
END IF
//==========================
//ll_rowcount = super::rowcount()
//of_alternaterow(ll_rowcount)
//==========================

return ll_row
end function

on cuo_dwwindow_one_dwgrid.create
call super::create
end on

on cuo_dwwindow_one_dwgrid.destroy
call super::destroy
end on

event constructor;call super::constructor;//V1.9.9.009 오류 발생
this.setdataobject(this.dataobject)
//=================================
//setdataobject(this.dataobject)
//=================================

This.SetTransObject(sqlca)
This.tag = '1'
 
end event

event retrieveend;call super::retrieveend;IF EnableRowDataAlternate THEN
	of_alternaterow(rowcount)
END IF

end event

event clicked;call super::clicked;IF SortVisible THEN
	Long	ll_true
	String ls_temp
	ls_temp = This.GetBandAtPointer()
	
	/*=================
	LINE 클릭시 에러 수정.
	=================*/
	//ll_true += Pos(ls_temp, "background", 1)
	IF Pos(ls_temp, "background", 1) = 0 THEN
	//==================
		ll_true += Pos(ls_temp, "foreground", 1)
		
		ls_temp = dwo.name
		ll_true += Pos(ls_temp, ARROW_SUB)
		ll_true += Pos(ls_temp, TEXTSUB)
		
		IF ll_true > 0 THEN
			IF KeyDown(KeyControl!) AND KeyDown( KeyLeftButton!) THEN
				ib_multsort = True
			ELSE
				ib_multsort = False
			END IF
			
			of_sort(dwo)
		ELSE
			ib_multsort = False
		END IF
	//=====================	
	END IF
	//=====================
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

