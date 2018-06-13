$PBExportHeader$w_hin451i.srw
$PBExportComments$위원회명단관리
forward
global type w_hin451i from w_msheet
end type
type uo_member from cuo_insa_member within w_hin451i
end type
type dw_hin001m from cuo_dwwindow_one_hin within w_hin451i
end type
type dw_hin029m from cuo_dwwindow_one_hin within w_hin451i
end type
type dw_update from cuo_dwwindow_one_hin within w_hin451i
end type
type cb_search from uo_imgbtn within w_hin451i
end type
type cb_insert from uo_imgbtn within w_hin451i
end type
type st_1 from statictext within w_hin451i
end type
end forward

global type w_hin451i from w_msheet
string title = "위원회명단"
uo_member uo_member
dw_hin001m dw_hin001m
dw_hin029m dw_hin029m
dw_update dw_update
cb_search cb_search
cb_insert cb_insert
st_1 st_1
end type
global w_hin451i w_hin451i

type variables
DataWindowChild	idw_JikJong
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

public subroutine wf_setmenubtn (string as_type);////입력
////저장
////삭제
////조회
////검색
//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN
//		CHOOSE CASE ls_Flag[li_idx]
//			CASE 'I' ; IF is_Auth[1] = 'Y' THEN lb_Value = TRUE
//			CASE 'S' ; IF is_Auth[3] = 'Y' THEN lb_Value = TRUE
//			CASE 'D' ; IF is_Auth[2] = 'Y' THEN lb_Value = TRUE
//			CASE 'R' ; IF is_Auth[4] = 'Y' THEN lb_Value = TRUE
//			CASE 'P' ; IF is_Auth[5] = 'Y' THEN lb_Value = TRUE
//		END CHOOSE
//	END IF 
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE ls_Flag[li_idx]
//		CASE 'I' ;ib_insert   = lb_Value
//		CASE 'S' ;ib_update   = lb_Value
//		CASE 'D' ;ib_delete   = lb_Value
//		CASE 'R' ;ib_retrieve = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

on w_hin451i.create
int iCurrent
call super::create
this.uo_member=create uo_member
this.dw_hin001m=create dw_hin001m
this.dw_hin029m=create dw_hin029m
this.dw_update=create dw_update
this.cb_search=create cb_search
this.cb_insert=create cb_insert
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_member
this.Control[iCurrent+2]=this.dw_hin001m
this.Control[iCurrent+3]=this.dw_hin029m
this.Control[iCurrent+4]=this.dw_update
this.Control[iCurrent+5]=this.cb_search
this.Control[iCurrent+6]=this.cb_insert
this.Control[iCurrent+7]=this.st_1
end on

on w_hin451i.destroy
call super::destroy
destroy(this.uo_member)
destroy(this.dw_hin001m)
destroy(this.dw_hin029m)
destroy(this.dw_update)
destroy(this.cb_search)
destroy(this.cb_insert)
destroy(this.st_1)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 위원회명단을 관리한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 위원회구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_CommiteeOpt
//dw_update.GetChild('commitee_opt',ldwc_CommiteeOpt)
//ldwc_CommiteeOpt.SetTransObject(SQLCA)
//IF ldwc_CommiteeOpt.Retrieve('commitee_opt',1) = 0 THEN
//	wf_setmsg('공통코드[위원회구분]를 입력하시기 바랍니다.')
//	ldwc_CommiteeOpt.InsertRow(0)
//END IF
//dw_update.GetChild('coll_opt',ldwc_CommiteeOpt)
//ldwc_CommiteeOpt.SetTransObject(SQLCA)
//IF ldwc_CommiteeOpt.Retrieve('coll_opt',1) = 0 THEN
//	wf_setmsg('공통코드[교내외구분]를 입력하시기 바랍니다.')
//	ldwc_CommiteeOpt.InsertRow(0)
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
//
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
ll_GetRow = dw_hin029m.GetRow()
IF ll_GetRow = 0 THEN RETURN -1
ll_RowCnt = dw_hin029m.RowCount()
IF ll_RowCnt = 0 THEN RETURN -1
/////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 체크
/////////////////////////////////////////////////////////////////////////////
Integer	li_CommiteeCode	//위원회코드
li_CommiteeCode = dw_hin029m.Object.commitee_code[ll_GetRow]

String	ls_SysDate
ls_SysDate = f_today()

////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(li_CommiteeCode,ls_SysDate)
dw_update.SetReDraw(TRUE)

////////////////////////////////////////////////////////////////////////////////
// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
	wf_SetMsg('자료가 조회되었읍니다.')
	dw_update.SetFocus()
ELSE
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	uo_member.sle_kname.SetFocus()
END IF
IF dw_hin001m.RowCount() > 0 AND dw_hin029m.RowCount() > 0 THEN
//	wf_SetMenu('I',TRUE)
ELSE
//	wf_SetMenu('I',FALSE)
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
IF dw_update.ib_RowSingle THEN ll_GetRow = dw_update.GetRow()
IF NOT dw_update.ib_RowSingle THEN ll_GetRow = dw_update.getrow()
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
Long		ll_DeleteCnt

IF dw_update.ib_RowSingle OR dw_update.getrow() = 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 2.1 삭제전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
//	String	ls_JikJongNm		//직종명
//	String	ls_DutyNm			//직급명
//	
//	ls_AccYear      = dw_update.Object.acc_year     [ll_GetRow]	//회계년도
//	ls_CauseID      = dw_update.Object.cause_id     [ll_GetRow]	//원인행위번호
//	ls_ResolutionID = dw_update.Object.resolution_id[ll_GetRow]	//지출결의번호
//	
//	ls_Msg = '자료를 삭제하기겠습니까?~r~n~r~n' + &
//				'      회계년도 : ' + ls_AccYear + '~r~n' + &
//				'원인행위번호 : ' + ls_CauseID +'-'+ ls_ResolutionID + '~r~n~r~n' + &
//				'삭제시 지출결의자료 및 수령인자료가 전부 삭제됩니다.'
//				
//	li_Rtn = MessageBox('확인',ls_Msg,Question!,YesNo!,2)
	IF li_Rtn = 2 THEN RETURN
ELSE
//	SetNull(ls_Msg)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
ll_DeleteCnt = dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	IF dw_update.ib_RowSingle THEN
		/////////////////////////////////////////////////////////////////////////////
		// 3.1 Single 처리인 경우.
		//			3.1.1 저장처리.
		//			3.1.2 한로우를 다시 추가.
		//			3.1.3 데이타원도우를 읽기모드로 수정.
		/////////////////////////////////////////////////////////////////////////////
		IF dw_update.TRIGGER EVENT ue_db_save() THEN
			dw_update.TRIGGER EVENT ue_db_append()
			dw_update.Object.DataWindow.ReadOnly = 'YES'
//			wf_SetMenu('R',TRUE)
//			wf_SetMenu('I',TRUE)
//			wf_SetMenu('D',FALSE)
//			wf_SetMenu('S',FALSE)
		END IF
	ELSE
		/////////////////////////////////////////////////////////////////////////////
		//	3.2 Multi 처리인 경우.
		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
		/////////////////////////////////////////////////////////////////////////////
		IF dw_update.RowCount() > 0 THEN
//			wf_SetMenu('R',TRUE)
//			wf_SetMenu('I',TRUE)
//			wf_SetMenu('D',TRUE)
//			wf_SetMenu('S',TRUE)
		ELSE
//			wf_SetMenu('R',TRUE)
//			wf_SetMenu('I',TRUE)
//			wf_SetMenu('D',FALSE)
//			wf_SetMenu('S',TRUE)
		END IF
	END IF
ELSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 자료추가전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 위원회코드 선택 유무체크
////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
ll_GetRow = dw_hin029m.GetRow()
IF ll_GetRow = 0 THEN
	wf_SetMsg('위원회 자료를 선택하시기 바랍니다.')
	RETURN
END IF
Integer	li_CommiteeCode	//위원회코드
li_CommiteeCode = dw_hin029m.Object.commitee_code[ll_GetRow]	

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_InsRow
ll_InsRow = dw_update.TRIGGER EVENT ue_db_new()
IF ll_InsRow = 0 THEN RETURN

dw_update.Object.commitee_code[ll_InsRow] = li_CommiteeCode		//위원회코드
dw_update.object.term_opt     [ll_InsRow] = '2'						//임기구분(1:당연직,2:기간표시)
dw_update.object.commitee_opt [ll_InsRow] = 3						//위원구분(3:위원)
	

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
//dw_update.SetItemStatus(ll_GetRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 버튼 활성화/비활성화처리 및 메세지처리, 데이타원도우로 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
IF ll_InsRow > 0 THEN
	wf_SetMsg('자료가 추가되었습니다.')
ELSE
	wf_SetMsg('자료가 기 존재합니다.')
END IF
dw_update.SetColumn('hin001m_kname')
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
IF dw_update.AcceptText() = -1 THEN
	dw_update.SetFocus()
	RETURN -1
END IF
IF dw_update.ModifiedCount() + dw_update.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'member_no/개인번호'
ls_NotNullCol[2] = 'term_opt/임기구분'
ls_NotNullCol[3] = 'syymmdd/임기시작일'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row				//변경된 행
Boolean	lb_Start = TRUE

DateTime	ldt_WorkDate		//등록일자
String	ls_Worker			//등록자
String	ls_IpAddr			//등록단말기

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode //gstru_uid_uname.uid		//등록자
	ls_IpAddr    = gs_ip   //gstru_uid_uname.address	//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = dw_update.GetItemStatus(ll_Row,0,Primary!)
	////////////////////////////////////////////////////////////////////////////////////
	// 3.1 수정항목 처리
	////////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		dw_update.Object.worker   [ll_Row] = ls_Worker		//등록자
		dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
		dw_update.Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
	END IF
	dw_update.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	dw_update.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	dw_update.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF NOT dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
dw_update.SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
dw_update.SetReDraw(FALSE)
dw_update.Reset()
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 위원회코드 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('위원회코드 조회처리 중입니다...')
Long	ll_RowCnt

dw_hin029m.SetReDraw(FALSE)
ll_RowCnt = dw_hin029m.Retrieve()
dw_hin029m.SetReDraw(TRUE)
IF ll_RowCnt = 0 THEN 
	wf_SetMsg('위원회코드를 입력하시기 바랍니다.')
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 위원회코드 자료조회
///////////////////////////////////////////////////////////////////////////////////////
String	ls_KName = '%'	//성명
wf_SetMsg('인사기본정보 조회처리 중입니다...')

dw_hin001m.SetReDraw(FALSE)
ll_RowCnt = dw_hin001m.Retrieve(ls_KName)
dw_hin001m.SetReDraw(TRUE)
IF ll_RowCnt > 0 THEN
	wf_SetMsg('인사기본정보를 입력하시기 바랍니다.')
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('I',TRUE)	//입력버튼 활성화
//wf_setMenu('R',TRUE)	//조회버튼 활성화

uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_templeft.beginx // uo_member.x + uo_member.Width + 16

If cb_search.Enabled Then
	cb_search.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + cb_search.Width + 16
Else
	cb_search.Visible	= FALSE
End If

If cb_insert.Enabled Then
	cb_insert.X			= ll_stnd_pos 
	ll_stnd_pos			= ll_stnd_pos + cb_insert.Width + 16
Else
	cb_insert.Visible	= FALSE
End If

end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 위원회명단을 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 위원회구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_CommiteeOpt
dw_update.GetChild('commitee_opt',ldwc_CommiteeOpt)
ldwc_CommiteeOpt.SetTransObject(SQLCA)
IF ldwc_CommiteeOpt.Retrieve('commitee_opt',1) = 0 THEN
	wf_setmsg('공통코드[위원회구분]를 입력하시기 바랍니다.')
	ldwc_CommiteeOpt.InsertRow(0)
END IF
dw_update.GetChild('coll_opt',ldwc_CommiteeOpt)
ldwc_CommiteeOpt.SetTransObject(SQLCA)
IF ldwc_CommiteeOpt.Retrieve('coll_opt',1) = 0 THEN
	wf_setmsg('공통코드[교내외구분]를 입력하시기 바랍니다.')
	ldwc_CommiteeOpt.InsertRow(0)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

type ln_templeft from w_msheet`ln_templeft within w_hin451i
end type

type ln_tempright from w_msheet`ln_tempright within w_hin451i
end type

type ln_temptop from w_msheet`ln_temptop within w_hin451i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin451i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin451i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin451i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin451i
end type

type uc_insert from w_msheet`uc_insert within w_hin451i
end type

type uc_delete from w_msheet`uc_delete within w_hin451i
end type

type uc_save from w_msheet`uc_save within w_hin451i
end type

type uc_excel from w_msheet`uc_excel within w_hin451i
end type

type uc_print from w_msheet`uc_print within w_hin451i
end type

type st_line1 from w_msheet`st_line1 within w_hin451i
end type

type st_line2 from w_msheet`st_line2 within w_hin451i
end type

type st_line3 from w_msheet`st_line3 within w_hin451i
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin451i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin451i
end type

type uo_member from cuo_insa_member within w_hin451i
integer x = 91
integer y = 184
integer taborder = 20
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event ue_enter;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_KName	//성명
ls_KName = TRIM(uo_member.sle_kname.Text)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본정보 조회처리
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt
wf_SetMsg('인사기본정보 조회처리 중입니다...')

dw_hin001m.SetReDraw(FALSE)
ll_RowCnt = dw_hin001m.Retrieve(ls_KName)
dw_hin001m.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
//	wf_SetMenu('I',TRUE)
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
ELSE
//	wf_SetMenu('I',FALSE)
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
	wf_SetMsg('인사기본정보를 입력하시기 바랍니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type dw_hin001m from cuo_dwwindow_one_hin within w_hin451i
integer x = 1810
integer y = 296
integer width = 2624
integer height = 1172
integer taborder = 50
string dataobject = "d_hin451i_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = FALSE
//ib_SortGubn  = TRUE
end event

type dw_hin029m from cuo_dwwindow_one_hin within w_hin451i
integer x = 50
integer y = 296
integer width = 1737
integer height = 1176
integer taborder = 10
string dataobject = "d_hin451i_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;//Override
String	ls_ColName
ls_ColName = UPPER(dwo.name)
IF ls_ColName = 'DATAWINDOW' THEN RETURN

IF THIS.RowCount() > 0 AND UPPER(RIGHT(ls_ColName,2)) = '_T' AND ib_SortGubn THEN
	THIS.TRIGGER EVENT ue_et_sort()
	
	Long	ll_SelectRow
	ll_SelectRow = THIS.getrow()
	THIS.SetRedraw(FALSE)
	IF ll_SelectRow = 0 THEN ll_SelectRow = 1
	THIS.ScrollToRow(ll_SelectRow)
	THIS.SetRedraw(TRUE)
	RETURN 1
END IF

end event

event rowfocuschanging;/////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: rowfocuschanging::dw_hin029m
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
ll_GetRow = newrow
IF ll_GetRow = 0 THEN RETURN
ll_RowCnt = THIS.RowCount()
IF ll_RowCnt = 0 THEN RETURN
////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
////////////////////////////////////////////////////////////////////////////////
Integer	li_CommiteeCode	//위원회코드
li_CommiteeCode = THIS.Object.commitee_code[ll_GetRow]

String	ls_SysDate
ls_SysDate = f_today()

////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(li_CommiteeCode,ls_SysDate)
dw_update.SetReDraw(TRUE)

////////////////////////////////////////////////////////////////////////////////
// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
	wf_SetMsg('자료가 조회되었읍니다.')
	dw_update.SetFocus()
ELSE
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	uo_member.sle_kname.SetFocus()
END IF
IF dw_hin001m.RowCount() > 0 THEN
//	wf_SetMenu('I',TRUE)
ELSE
//	wf_SetMenu('I',FALSE)
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = TRUE
//ib_SortGubn  = TRUE
end event

type dw_update from cuo_dwwindow_one_hin within w_hin451i
integer x = 50
integer y = 1480
integer width = 4384
integer height = 788
integer taborder = 60
string dataobject = "d_hin451i_3"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_sortgubn = false
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = FALSE
//ib_SortGubn  = TRUE
//ib_EnterChk  = TRUE
end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
String	ls_Null
Integer	li_Null

ls_ColName = STRING(dwo.name)
ls_ColData = TRIM(data)
SetNull(ls_Null)
SetNull(li_Null)

String	ls_Find
Long		ll_Find

CHOOSE CASE ls_ColName
	CASE 'hin001m_kname'
		//////////////////////////////////////////////////////////////////////////
		// 성명 도움말 오픈
		//////////////////////////////////////////////////////////////////////////
		s_insa_com	lstr_com
		lstr_com.ls_item[1] = ls_ColData			//성명
		lstr_com.ls_item[2] = ''					//개인번호
		lstr_com.ls_item[3] = '3'					//교직원구분
		
		OpenWithParm(w_hin000h,lstr_com)
		
		lstr_com = Message.PowerObjectParm
		IF NOT isValid(lstr_com) THEN
			MessageBox('오류','개인번호를 선택하시기 바랍니다.')
			RETURN -1
		END IF
		
		dw_update.Object.hin001m_kname[row] = lstr_com.ls_item[1]
		dw_update.Object.member_no    [row] = lstr_com.ls_item[2]
		
	CASE ELSE
		
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type cb_search from uo_imgbtn within w_hin451i
integer x = 50
integer y = 36
integer taborder = 30
boolean bringtotop = true
string btnname = "성명찾기"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_search
//	기 능 설 명: 수정시 전체사용자리스트에서 사용자명을 선택처리해 준다
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
IF MOD(LEN(ls_KName),2) <> 0 THEN RETURN

Long		ll_RowCnt
ll_RowCnt = dw_hin001m.RowCount()
IF ll_RowCnt = 0 THEN RETURN

Long		ll_Find
ll_Find = dw_hin001m.Find("kname LIKE '" + ls_KName + "%'", 1, ll_RowCnt)
IF ll_Find = 0 THEN RETURN

dw_hin001m.ScrollToRow(ll_Find)
//dw_hin001m.SelectRow(0,FALSE)
//dw_hin001m.SelectRow(ll_Find,TRUE)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cb_search.destroy
call uo_imgbtn::destroy
end on

type cb_insert from uo_imgbtn within w_hin451i
integer x = 384
integer y = 36
integer taborder = 60
boolean bringtotop = true
string btnname = "선택추가"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 자료추가전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 위원회코드 선택 유무체크
////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRowHin029m
ll_GetRowHin029m = dw_hin029m.GetRow()
IF ll_GetRowHin029m = 0 THEN
	wf_SetMsg('위원회 자료를 선택하시기 바랍니다.')
	RETURN
END IF
Integer	li_CommiteeCode	//위원회코드
li_CommiteeCode = dw_hin029m.Object.commitee_code[ll_GetRowHin029m]	
////////////////////////////////////////////////////////////////////////////////////
// 1.2 인사기본정보 선택 유무체크
////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRowHin001m
ll_GetRowHin001m = dw_hin001m.GetRow()
IF ll_GetRowHin001m = 0 THEN
	wf_SetMsg('인사기본정보 자료를 선택하시기 바랍니다.')
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowHin001m
Long		ll_RowCnt
Long		ll_InsRow
Long		ll_NewRow
String	ls_Find
Long		ll_Find
Long		ll_DelRow[]
Long		ll_idx

String	ls_MemberNo		//개인번호
String	ls_KName			//성명

ll_RowHin001m = dw_hin001m.getrow()
DO UNTIL ll_RowHin001m = 0
	ls_MemberNo = dw_hin001m.Object.member_no[ll_RowHin001m]	//개인번호
	ls_KName    = dw_hin001m.Object.kname    [ll_RowHin001m]	//성명
	////////////////////////////////////////////////////////////////////////////////////
	// 2.1 다음에 추가할 행을 찾는다.
	////////////////////////////////////////////////////////////////////////////////////
	ll_RowCnt = dw_update.RowCount()
	ls_Find   = "member_no > '"+ls_MemberNo+"'"
	ll_NewRow = dw_update.Find(ls_Find,1,ll_RowCnt) - 1
	IF ll_NewRow < 0 THEN ll_NewRow = dw_update.RowCount()
	dw_update.SetRow(ll_NewRow)
	////////////////////////////////////////////////////////////////////////////////////
	// 2.2 자료추가
	////////////////////////////////////////////////////////////////////////////////////
	ll_InsRow = dw_update.TRIGGER EVENT ue_db_new()
	IF ll_InsRow = 0 THEN
		ll_RowHin001m = dw_hin001m.getrow()
		CONTINUE
	END IF
	
	dw_update.object.member_no    [ll_InsRow] = ls_MemberNo			//개인번호
	dw_update.Object.commitee_code[ll_InsRow] = li_CommiteeCode		//위원회코드
	dw_update.object.hin001m_kname[ll_InsRow] = ls_KName				//성명
	dw_update.object.term_opt     [ll_InsRow] = '2'						//임기구분(1:당연직,2:기간표시)
	dw_update.object.commitee_opt [ll_InsRow] = 3						//위원구분(3:위원)
	
	ll_RowHin001m = dw_hin001m.getrow()
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
//dw_update.SetItemStatus(ll_GetRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 버튼 활성화/비활성화처리 및 메세지처리, 데이타원도우로 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
IF ll_InsRow > 0 THEN
	wf_SetMsg('자료가 추가되었습니다.')
ELSE
	wf_SetMsg('자료가 기 존재합니다.')
END IF
dw_update.SetColumn('syymmdd')
dw_update.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cb_insert.destroy
call uo_imgbtn::destroy
end on

type st_1 from statictext within w_hin451i
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
boolean focusrectangle = false
end type

