$PBExportHeader$uo_base_dwc.sru
$PBExportComments$[청운대]조상    dwc
forward
global type uo_base_dwc from datawindow
end type
end forward

shared variables

end variables

global type uo_base_dwc from datawindow
integer width = 494
integer height = 360
integer taborder = 1
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
event ue_et_sort ( )
end type
global uo_base_dwc uo_base_dwc

type variables
Boolean	ib_RowSelect
Boolean	ib_RowSingle

Long	il_LastClickedRow
Boolean	ib_RowFocusChanged

Boolean	ib_SortGubn = TRUE
Boolean	ib_EnterChk = FALSE
end variables

event constructor;this.settransobject(sqlca)
   

end event

event dberror;CHOOSE CASE sqldbcode

CASE -195 // Required value is NULL.
		MessageBox(	"Database Problem", "Error inserting row " + string(row))
case 1400
   	MessageBox(	"Error","값을 반드시 입력해야 하는 필드에 Null값이 들어 있습니다.")
case 1
	   MessageBox(	"Error","Primary Key 규약에 어긋납니다.")
case 031114
	   MessageBox(	"Error","DB에 연결되어 있지 않습니다.~n" &
		            + "네트워크에 이상이 있는것 같습니다.")

case else 
		messagebox(	"데이타베이스 오류", this.classname() + "의 " + string(row - 1) + "행에 오류 발생.~n" + &
						sqlerrtext + " SQLDBCODE" + string(sqldbcode))
END CHOOSE

RETURN 1 // Do not display system error message
end event

on uo_base_dwc.create
end on

on uo_base_dwc.destroy
end on

event doubleclicked;string	ls_object	,&
			ls_column

//row가 클릭되지 않은 경우
if row = 0 then

	setpointer(hourglass!)
	ls_object = this.getobjectatpointer()
	ls_object = left(ls_object,pos(ls_object, "~t") - 1)

	if right(ls_object, 2) = '_t' then
		ls_column = left(ls_object,len(ls_object) - 2)
		this.setsort(ls_column + " A")
		this.sort()
		setfocus()
		RETURN 1
	end if

	setpointer(arrow!)
end if
end event

event rbuttondown;//m_main_menu.m_edit.PopMenu(PointerX() + 200 , PointerY())
end event

event retrieveend;//long ll_rowcount 
//long currentrow
//
//ll_rowcount = this.rowcount()
//	
//w_frame.setmicrohelp("Rows " + string(currentrow) + " to " + &
//	this.Object.DataWindow.LastRowOnPage + " of " + string(ll_rowcount))
//
end event

event getfocus;//long	ll_rowcount
//
//ll_rowcount = this.rowcount()
//
//w_frame.setmicrohelp("Rows " +string(this.getrow()) + " to "  + &
//	this.Object.DataWindow.LastRowOnPage + " of " + string(ll_rowcount))
end event

event rowfocuschanged;//long	ll_rowcount 
//
//ll_rowcount = this.rowcount()
//
//w_frame.setmicrohelp("Rows " +string(currentrow) + " to "  + &
//	this.Object.DataWindow.LastRowOnPage + " of " + string(ll_rowcount))
end event

event scrollvertical;//long ll_rowcount
//
//ll_rowcount = this.rowcount()
//
//w_frame.setmicrohelp("Rows " +string(this.getrow()) + " to "  + &
//	this.Object.DataWindow.LastRowOnPage + " of " + string(ll_rowcount))
end event

event clicked;////////////////////////////////////////////////////////////////////////////////////////// 
//	이벤트  명 : CLICKED 자료 선택
//	작성/수정자: 
//	작성/수정일: 
//	기 능 설 명: 
//	주 의 사 항: 
//		ib_RowSelect ; TRUE = 처리함, FALSE = 처리 않함
//		ib_RowSingle ; TRUE = SINGLE, FALSE = MULTI
////////////////////////////////////////////////////////////////////////////////////////// 
Integer	li_idx
String	ls_KeyDownType

////////////////////////////////////////////////////////////////////////////////
// 1. CLICK한 ROW가 정확하지 않을 경우 RETURN
////////////////////////////////////////////////////////////////////////////////
String	ls_ColName
ls_ColName = UPPER(dwo.name)
IF ls_ColName = 'DATAWINDOW' THEN RETURN

////////////////////////////////////////////////////////////////////////////////
// 2. MULTI ROW 처리이고 COLUMN의 HEADER부분 CLICK시 SORT처리
////////////////////////////////////////////////////////////////////////////////
IF THIS.RowCount() > 0 AND UPPER(RIGHT(ls_ColName,2)) = '_T' AND ib_SortGubn THEN
	
//	/////////////////////////////////////////////////////////////////////////////
//	// 2.1 ASCENDING / DESCENDING 처리
//	/////////////////////////////////////////////////////////////////////////////

	THIS.TRIGGER EVENT ue_et_sort()
	
	Long	ll_SelectRow
	ll_SelectRow = THIS.GetSelectedRow(0)
	THIS.SetRedraw(FALSE)
	IF ll_SelectRow = 0 THEN ll_SelectRow = 1
	THIS.ScrollToRow(ll_SelectRow)
	THIS.SetRedraw(TRUE)
	RETURN 1
END IF

IF row < 1 THEN RETURN

////////////////////////////////////////////////////////////////////////////////
// 2. SELECT ROW를 처리하지 않을 경우
////////////////////////////////////////////////////////////////////////////////
IF	NOT ib_RowSelect THEN RETURN

////////////////////////////////////////////////////////////////////////////////
// 3. SELECT ROW SELECT 처리시
////////////////////////////////////////////////////////////////////////////////
IF	ib_RowSingle THEN
	/////////////////////////////////////////////////////////////////////////////
	// 3.1 SINGLE ROW SELECT 처리시
	/////////////////////////////////////////////////////////////////////////////
	THIS.SelectRow(0,FALSE)
	THIS.SelectRow(row,TRUE)
	THIS.SetRow(Row)
	RETURN
END IF

////////////////////////////////////////////////////////////////////////////////
//  4. MULTI ROW SELECT 처리시
//  	4.1 SHIFT KEY를 누르고 CLICK할 경우 처리
//		4.2 CONTROL KEY를 누르고 CLICK할 경우 처리
////////////////////////////////////////////////////////////////////////////////
IF KeyDown(KeyShift!) THEN
	IF il_LastClickedRow = 0 THEN
		THIS.SelectRow(row,TRUE)
	END IF

	IF il_LastClickedRow > row THEN
		FOR li_idx = il_LastClickedRow TO row STEP -1
			THIS.SelectRow(li_idx,TRUE)     	
		NEXT	
	ELSE
		FOR li_idx = il_LastClickedRow TO row
			THIS.SelectRow(li_idx,TRUE)   
		NEXT	
	END IF
ELSE
	IF KeyDown(KeyControl!) THEN
		IF GetSelectedRow(Row - 1) = Row THEN
			THIS.SelectRow(Row,FALSE)
		ELSE
			THIS.SelectRow(Row,TRUE)
		END IF
	Else
		THIS.SelectRow(0,FALSE)
		THIS.SelectRow(Row,True)							
	END IF
END IF

THIS.SetRow(Row)
il_LastClickedRow = Row
THIS.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

