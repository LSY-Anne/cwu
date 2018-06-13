$PBExportHeader$cuo_dwwindow_one_hin.sru
$PBExportComments$인사공통 데이타원도우
forward
global type cuo_dwwindow_one_hin from cuo_dwwindow_one
end type
end forward

global type cuo_dwwindow_one_hin from cuo_dwwindow_one
integer width = 608
integer height = 496
boolean hscrollbar = true
boolean vscrollbar = true
string linecolor = "203,214,236"
string colselectcolor = "255,0,0"
string hotbackcolor = "255,255,255"
string nobackcolor = "206,218,236"
string graysepcolor = "190,193,198"
string graysepcolor2 = "203,214,236"
string hotlinecolor = "206,218,236"
string nomallinecolor = "206,218,236"
string alternatefirstcolor = "243,244,249"
string nofontcolor = "57,91,126"
string hotfontcolor = "57,91,126"
event type long ue_db_append ( )
event type long ue_db_delete ( string as_msg )
event type long ue_db_new ( )
event type boolean ue_db_save ( )
event ue_et_processenter pbm_dwnprocessenter
event ue_et_sort ( )
end type
global cuo_dwwindow_one_hin cuo_dwwindow_one_hin

type variables
Boolean	ib_RowSelect 
Boolean	ib_RowSingle = TRUE

Long	il_LastClickedRow
Boolean	ib_RowFocusChanged

Boolean	ib_SortGubn = FALSE
Boolean	ib_EnterChk = FALSE
end variables

event type long ue_db_append();//////////////////////////////////////////////////////////////////////////////////////////
//	이벤트  명 : ue_db_append
//	작성/수정자: 
//	작성/수정일: 
//	기 능 설 명: 현재 데이타원도우의 마지막 행에 한 ROW를 추가한다.
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
IF ib_RowSingle THEN
//	IF f_chk_update(THIS,'') = 3 THEN RETURN 0
	THIS.Reset()
END IF

Long	ll_InsertRow
ll_InsertRow = THIS.InsertRow(0)

THIS.SetRow(ll_InsertRow)
THIS.ScrollToRow(ll_InsertRow)
THIS.SetFocus()
IF ib_RowSelect THEN
	THIS.SelectRow(0,FALSE)
	THIS.SelectRow(ll_InsertRow,TRUE)
ELSE
//	THIS.Object.DataWindow.HorizontalScrollPosition = 0
END IF

RETURN ll_InsertRow
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_db_delete;////////////////////////////////////////////////////////////////////////////////////////// 
//	이벤트  명 : ue_db_delete
//	작성/수정자: 
//	작성/수정일: 
//	기 능 설 명: CLICK한 ROW를 삭제처리한다.
//	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////// 
// 1. CLICK한 ROW가 정확하지 않을 경우 RETURN
////////////////////////////////////////////////////////////////////////////////
Long	ll_GetRow
ll_GetRow = THIS.GetRow()
IF ll_GetRow = 0 THEN RETURN -1

THIS.AcceptText()
////////////////////////////////////////////////////////////////////////////////
// 3. SINGLE(ib_RowSingle = TRUE )인 경우 ; 선택된 행 삭제처리
//		MULTI (ib_RowSingle = FALSE)인 경우 ; 선택된 행 삭제처리
////////////////////////////////////////////////////////////////////////////////
Long	ll_InsertRow
Long	ll_NextSelectRow
	
IF ib_RowSingle THEN
	/////////////////////////////////////////////////////////////////////////////
	// 3.1. 빈 로우일 경우는 삭제메세지 처리하지 않는다.
	/////////////////////////////////////////////////////////////////////////////
	IF THIS.GetItemStatus(ll_GetRow,0,Primary!) <> New! THEN
		IF MessageBox('확인','자료를 삭제하시겠습니까?~r~n'+as_Msg,&
									Question!,YesNo!,2) = 2 THEN
			RETURN 0
		END IF
	END IF
	
//	THIS.SelectRow(0,FALSE)
//	ll_NextSelectRow = ll_GetRow + 1
//	THIS.ScrollToRow(ll_NextSelectRow)
//	THIS.SetRedraw(TRUE)

	THIS.DeleteRow(ll_GetRow)
	RETURN 1
ELSE
	/////////////////////////////////////////////////////////////////////////////
	// 3.2 선택된 행 만 찾아 삭제처리한다.
	/////////////////////////////////////////////////////////////////////////////
	Long	ll_NextRow
	Long	ll_SelectRow
	Long	ll_DeleteCnt
	Long	ll_DeleteRow[]
	Boolean	lb_DeleteMsgChk = FALSE
	
	ll_SelectRow = THIS.GetSelectedRow(0)
	IF ll_SelectRow = 0 THEN RETURN 0
	DO WHILE ll_SelectRow > 0 
		ll_DeleteCnt++
		ll_DeleteRow[ll_DeleteCnt] = ll_SelectRow
		//////////////////////////////////////////////////////////////////////////
		// 3.2.1 빈 로우가 않인 경우만 삭제 메세지를 처리하기 위함.
		//////////////////////////////////////////////////////////////////////////
		IF THIS.GetItemStatus(ll_SelectRow,0,Primary!) <> New! THEN
			lb_DeleteMsgChk = TRUE
		END IF
		
		ll_SelectRow = THIS.GetSelectedRow(ll_SelectRow)
	LOOP
	
	IF lb_DeleteMsgChk THEN
		IF MessageBox('확인','자료를 삭제하시겠습니까?~r~n'+as_Msg,&
									Question!,YesNo!,2) = 2 THEN
			RETURN 0
		END IF
	END IF
	
	/////////////////////////////////////////////////////////////////////////////
	// 3.3 삭제 후 다음 로우를 SELECTROW한다.
	/////////////////////////////////////////////////////////////////////////////
	ll_NextSelectRow = il_LastClickedRow + 1
	THIS.SelectRow(0,FALSE)
	THIS.SelectRow(ll_NextSelectRow,TRUE)
	
	Long	ll_idx
	THIS.SetRedraw(FALSE)
	FOR ll_idx = ll_DeleteCnt TO 1 STEP -1
		IF THIS.DeleteRow(ll_DeleteRow[ll_idx]) = 1 THEN
		END IF
	NEXT
	THIS.SetRedraw(TRUE)

	RETURN ll_DeleteCnt
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type long ue_db_new();////////////////////////////////////////////////////////////////////////////////////////// 
//	이벤트  명 : ue_db_new
//	작성/수정자: 
//	작성/수정일: 
//	기 능 설 명: CLICK한 ROW의 다음에 한 ROW를 INSERT한다.
//	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////// 
// 1. 현재의 ROW값
////////////////////////////////////////////////////////////////////////////////
Long	ll_GetRow
ll_GetRow = THIS.GetRow()
//IF ll_GetRow = 0 AND NOT ib_RowSingle THEN RETURN -1

////////////////////////////////////////////////////////////////////////////////
// 2. SINGLE(ib_RowSingle = TRUE )인 경우 ; 자료저장유무 CHECK
//										  DATAWINDOW CLEAR
//										  INSERT ROW
//		MULTI (ib_RowSingle = FALSE)인 경우 ; CLICK한 ROW의 다음에 한 ROW를 INSERT
////////////////////////////////////////////////////////////////////////////////
Long	ll_InsertRow
IF ib_RowSingle THEN
//	IF f_chk_update(THIS,'') = 3 THEN RETURN 0
//	PARENT.TriggerEvent('ue_et_update_check')
	THIS.Reset()
	ll_InsertRow = THIS.InsertRow(0)
	THIS.ScrollToRow(ll_InsertRow)
	THIS.SetRow(ll_InsertRow)
	THIS.SetFocus()
ELSE
	ll_InsertRow = THIS.InsertRow(ll_GetRow + 1)
	THIS.SetRow(ll_InsertRow)
	THIS.ScrollToRow(ll_InsertRow)
	THIS.SetFocus()
	IF ib_RowSelect THEN
		THIS.SelectRow(0,FALSE)
		THIS.SelectRow(ll_InsertRow,TRUE)
	END IF
//	THIS.Object.DataWindow.HorizontalScrollPosition = 0
END IF

RETURN ll_InsertRow
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_db_save;////////////////////////////////////////////////////////////////////////////////////////// 
//	이벤트  명 : ue_db_save
//	작성/수정자 : 전희열
//	작성/수정일 : 1999.08.03 (화)
//	기 능 설 명: 자료를 저장한다.
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
THIS.AcceptText()

IF THIS.UPDATE() = 1 THEN
	COMMIT USING SQLCA;
	RETURN TRUE
ELSE
	ROLLBACK USING SQLCA;
	RETURN FALSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_et_processenter;IF ib_EnterChk THEN 
	SEND(HANDLE(THIS),256,9,LONG(0,0))
	RETURN 1
END IF
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
//String	ls_DataObject
//String	ls_Sort
//String	ls_Parm
//
//ls_DataObject = THIS.DataObject
//ls_Sort       = THIS.Object.DataWindow.Table.Sort
//IF LEN(ls_Sort) > 1 THEN 
//	ls_Parm = ls_DataObject+'~t'+ls_Sort
//ELSE
//	ls_Parm = ls_DataObject
//END IF
//
////OpenWithParm(w_c_sort,ls_Parm)
//
//ls_Sort = Message.StringParm
//IF LEN(ls_Sort) = 0 THEN RETURN
//
//THIS.SetSort(ls_Sort)
//THIS.Sort()
////gf_dis_msg(1,'자료가 정렬되었습니다.','')	


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

on cuo_dwwindow_one_hin.create
call super::create
end on

on cuo_dwwindow_one_hin.destroy
call super::destroy
end on

event dberror;call super::dberror;THIS.SetRow(row)
THIS.ScrollToRow(row)

IF ib_RowSelect AND row > 0 THEN
	THIS.SelectRow(0,FALSE)
	THIS.SelectRow(row,TRUE)
END IF

/*
CHOOSE CASE SQLDBCODE
	CASE 0
//	CASE 1
//			gf_dis_msg(2,'해당자료가 이미 존재합니다.','S')
	CASE 2627
			MessageBox('오류','키값이 중복 되었습니다')
			THIS.SetFocus()
	CASE ELSE
			MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SqlDbCode) + '~r~n' + &
									'장애내역 : ' + SqlErrText + '~r~n' + &
									'해당로우 : ' + String(row))
END CHOOSE
*/

RETURN AncestorReturnValue
end event

event itemerror;call super::itemerror;RETURN 1
end event

event retrievestart;call super::retrievestart;THIS.Reset()
//THIS.Object.DataWindow.HorizontalScrollPosition = 0



end event

event rowfocuschanged;call super::rowfocuschanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이벤트  명 : RowFocusChanged 자료이동 시점
//	작성/수정자: 
//	작성/수정일: 
//	기 능 설 명: 
//	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////// 
il_LastClickedRow = currentrow

////////////////////////////////////////////////////////////////////////////////
// 1. SELECT ROW를 처리하지 않을 경우
////////////////////////////////////////////////////////////////////////////////
IF NOT ib_RowSelect THEN RETURN

////////////////////////////////////////////////////////////////////////////////
// 2. SHIFT KEY, CONTROL KEY 처리
////////////////////////////////////////////////////////////////////////////////
IF KeyDown(KeyShift!) OR KeyDown(KeyControl!) THEN RETURN	

////////////////////////////////////////////////////////////////////////////////
// 3. SELECT ROW를 처리
////////////////////////////////////////////////////////////////////////////////
IF currentrow = 0 THEN RETURN

THIS.SelectRow(0,FALSE)
THIS.SelectRow(currentrow,TRUE)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

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

event constructor;call super::constructor;this.setPosition(totop!)
end event

