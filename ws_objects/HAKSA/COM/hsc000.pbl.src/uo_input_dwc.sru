$PBExportHeader$uo_input_dwc.sru
$PBExportComments$[청운대]입력용 dwc
forward
global type uo_input_dwc from uo_haksagrid
end type
end forward

global type uo_input_dwc from uo_haksagrid
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
string linecolor = "203,214,236"
string colselectcolor = "255,0,0"
string hotbackcolor = "190,193,198"
string nobackcolor = "190,193,198"
string graysepcolor = "155,160,168"
string graysepcolor2 = "203,214,236"
string hotlinecolor = "155,160,168"
string nomallinecolor = "190,193,198"
string alternatefirstcolor = "243,244,249"
string nofontcolor = "57,91,126"
string hotfontcolor = "0,0,255"
event ue_dwnenter pbm_dwnprocessenter
event ue_et_sort ( )
event ue_keydown pbm_dwnkey
end type
global uo_input_dwc uo_input_dwc

type variables
Boolean	ib_RowSelect
Boolean	ib_RowSingle

Long	il_LastClickedRow
Boolean	ib_RowFocusChanged

Boolean	ib_SortGubn = TRUE
Boolean	ib_EnterChk = FALSE
end variables

event ue_dwnenter;send(handle(this),256,9,long(0,0))
return 1
end event

event ue_et_sort();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_et_sort
//	기 능 설 명: 자료 정렬처리
//	작성/수정자 : 
//	작성/수정일 : 
// 인      수 : 
// 되  돌  림 : 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

String	ls_Object
String	ls_Band
ls_Object = THIS.GetObjectAtPointer()
ls_Band   = THIS.GetBandAtPointer()
IF Match(ls_Object, "[_t0-9]$") AND LEFT(ls_Band, 6) = 'header' then
	IF This.Rowcount() > 0 THEN
		OpenWithParm(w_sort, THIS)
	END IF
END IF

//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_keydown;long ll_column
int li_ans

if KeyDown(KeyShift!)  and keydown(KeyleftArrow!) then
	ll_column = this.getcolumn()
	this.setcolumn(ll_column - 1)
	return 1
end if

if KeyDown(KeyShift!) and keydown(KeyRightArrow!) then
	ll_column = this.getcolumn()
	this.setcolumn(ll_column + 1)
	return 1
end if
end event

event constructor;call super::constructor;This.settransobject(sqlca)

this.setPosition(totop!)
end event

event dberror;call super::dberror;CHOOSE CASE sqldbcode

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

on uo_input_dwc.create
call super::create
end on

on uo_input_dwc.destroy
call super::destroy
end on

event clicked;call super::clicked;////////////////////////////////////////////////////////////////////////////////////////// 
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
	
//	String	ls_ColText
//	String	ls_Sort
//	
//	/////////////////////////////////////////////////////////////////////////////
//	// 2.1 ASCENDING / DESCENDING 처리
//	/////////////////////////////////////////////////////////////////////////////
//	ls_Sort = THIS.Object.DataWindow.Table.Sort
//	ls_ColText = THIS.DESCRIBE(ls_ColName+'.Text')
//	
//	CHOOSE CASE RIGHT(ls_Sort,1)
//		CASE 'A'
//			ls_Sort = MID(ls_ColName,1,LEN(ls_ColName) - 2) + ' D'
//		CASE ELSE
//			ls_Sort = MID(ls_ColName,1,LEN(ls_ColName) - 2) + ' A'
//	END CHOOSE
//	
//	THIS.SetSort(ls_Sort)
//	THIS.Sort()
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

