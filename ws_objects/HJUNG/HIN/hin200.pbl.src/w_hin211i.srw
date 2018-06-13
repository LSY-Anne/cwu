$PBExportHeader$w_hin211i.srw
$PBExportComments$연구업적관리
forward
global type w_hin211i from w_msheet
end type
type dw_update from cuo_dwwindow_one_hin within w_hin211i
end type
type dw_list from cuo_dwwindow_one_hin within w_hin211i
end type
type uo_member from cuo_insa_member within w_hin211i
end type
type gb_1 from groupbox within w_hin211i
end type
end forward

global type w_hin211i from w_msheet
string title = "인사발령등록"
dw_update dw_update
dw_list dw_list
uo_member uo_member
gb_1 gb_1
end type
global w_hin211i w_hin211i

type variables
//DataWindowChild	idwc_DutyCode	//직급코드 DDDW

end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

public subroutine wf_setmenubtn (string as_type);//입력
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

on w_hin211i.create
int iCurrent
call super::create
this.dw_update=create dw_update
this.dw_list=create dw_list
this.uo_member=create uo_member
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.uo_member
this.Control[iCurrent+4]=this.gb_1
end on

on w_hin211i.destroy
call super::destroy
destroy(this.dw_update)
destroy(this.dw_list)
destroy(this.uo_member)
destroy(this.gb_1)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 연구업적자료를 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 연구구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
dw_update.GetChild('hin800m_yg_gb',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('yg_gb',0) = 0 THEN
	wf_setmsg('연구구분을 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

THIS.TRIGGER EVENT ue_init()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 1.1 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_list.SetReDraw(FALSE)
ll_RowCnt = dw_list.Retrieve(ls_KName)
dw_list.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
	wf_SetMsg('해당자료가 존재하지 않습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
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
// 1.1 자료추가전 필수입력사항 체크
////////////////////////////////////////////////////////////////////////////////////
// 1.1.1 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////
String	ls_KName				//성명
String	ls_MemberNo			//개인번호
ls_KName    = TRIM(uo_member.sle_kname.Text)			//성명
ls_MemberNo = TRIM(uo_member.sle_member_no.Text)	//개인번호
IF isNull(ls_MemberNo) OR LEN(ls_MemberNo) = 0 THEN
	wf_SetMsg('성명을 반드시 입력후 추가하시기 바랍니다.')
	uo_member.sle_kname.SetFocus()
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long	 ll_InsRow
ll_InsRow = dw_update.TRIGGER EVENT ue_db_new()
IF ll_InsRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_SysDate
ls_SysDate = f_today()
dw_update.Object.hin800m_member_no[ll_InsRow] = ls_MemberNo			//개인번호
dw_update.Object.hin001m_kname    [ll_InsRow] = ls_KName				//성명
dw_update.SetItemStatus(ll_InsRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우호 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenu('S',TRUE)
//wf_SetMenu('D',TRUE)
wf_SetMsg('자료가 추가되었습니다.')
dw_update.Object.DataWindow.ReadOnly = 'NO'
dw_update.SetColumn('hin800m_fr_date')
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
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
ls_NotNullCol[1] = 'hin800m_member_no/개인번호'
ls_NotNullCol[2] = 'hin800m_fr_date/시작일'
ls_NotNullCol[3] = 'hin800m_to_date/종료일'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기
String	ls_Msg			//메세지

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gstru_uid_uname.uid			//등록자
	ls_IPAddr    = gstru_uid_uname.address		//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = dw_update.GetItemStatus(ll_Row,0,Primary!)
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 등록항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		dw_update.Object.hin800m_worker   [ll_Row] = ls_Worker		//등록일자
		dw_update.Object.hin800m_work_date[ll_Row] = ldt_WorkDate	//등록자
		dw_update.Object.hin800m_ipaddr   [ll_Row] = ls_IPAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	dw_update.Object.hin800m_job_uid  [ll_Row] = ls_Worker		//등록자
	dw_update.Object.hin800m_job_add  [ll_Row] = ls_IpAddr		//등록단말기
	dw_update.Object.hin800m_job_date [ll_Row] = ldt_WorkDate	//등록일자
	
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
//wf_SetMenuBtn('IDSR')
dw_update.SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;call super::ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
//IF dw_update.ib_RowSingle THEN 
	ll_GetRow = dw_update.GetRow()
//IF NOT dw_update.ib_RowSingle THEN ll_GetRow = dw_update.getrow()
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
	String	ls_MemberNo			//개인번호
	String	ls_KName				//성명
	Integer	li_SeqNo				//순번
	String	ls_YgGb		//연구구분
	
	ls_MemberNo = dw_update.Object.hin800m_member_no[ll_GetRow]	//개인번호
	ls_KName    = dw_update.Object.hin001m_kname    [ll_GetRow]	//성명
	ls_YgGb    = dw_update.&
					Describe("Evaluate('LookUpDisplay(hin800m_yg_gb)',"+String(ll_GetRow)+")")
	
	ls_Msg = '개인번호   : '+ls_MemberNo+'~r~n'+&
				'성      명 : '+ls_KName+'~r~n'+&
				'연구구분   : '+ls_YgGb
ELSE
//	SetNull(ls_Msg)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
ll_DeleteCnt = dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
dw_list.TRIGGER EVENT ue_db_delete(ls_Msg)

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
//			wf_SetMenuBtn('RI')
		END IF
	ELSE
		/////////////////////////////////////////////////////////////////////////////
		//	3.2 Multi 처리인 경우.
		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
		/////////////////////////////////////////////////////////////////////////////
		IF dw_update.RowCount() > 0 THEN
//			wf_SetMenuBtn('IDSR')
		ELSE
//			wf_SetMenuBtn('ISR')
		END IF
	END IF
ELSE
END IF
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
dw_update.InsertRow(0)
dw_update.Object.DataWindow.ReadOnly = 'YES'
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('IR')
uo_member.sle_kname.text = ''
uo_member.sle_kname.SetFocus()
uo_member.sle_member_no.text = ''
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

type ln_templeft from w_msheet`ln_templeft within w_hin211i
end type

type ln_tempright from w_msheet`ln_tempright within w_hin211i
end type

type ln_temptop from w_msheet`ln_temptop within w_hin211i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin211i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin211i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin211i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin211i
end type

type uc_insert from w_msheet`uc_insert within w_hin211i
end type

type uc_delete from w_msheet`uc_delete within w_hin211i
end type

type uc_save from w_msheet`uc_save within w_hin211i
end type

type uc_excel from w_msheet`uc_excel within w_hin211i
end type

type uc_print from w_msheet`uc_print within w_hin211i
end type

type st_line1 from w_msheet`st_line1 within w_hin211i
end type

type st_line2 from w_msheet`st_line2 within w_hin211i
end type

type st_line3 from w_msheet`st_line3 within w_hin211i
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin211i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin211i
end type

type dw_update from cuo_dwwindow_one_hin within w_hin211i
event type long ue_postitemchanged ( long row,  dwobject dwo,  string data )
integer x = 14
integer y = 1888
integer width = 3845
integer height = 716
integer taborder = 60
string dataobject = "d_hin211i_2"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event type long ue_postitemchanged(long row, dwobject dwo, string data);////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: ue_postitemchanged::dw_update
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
	CASE 'change_opt'
		///////////////////////////////////////////////////////////////////////////////// 
		//	발령구분변경시 발령사유가 없으면 발령구분명을 발령사유에 넣어준다.
		/////////////////////////////////////////////////////////////////////////////////
		String	ls_ChangeOpt
		ls_ChangeOpt = THIS.Describe("Evaluate('LookUpDisplay(change_opt)',"+String(row)+")")
		THIS.Object.announce_con[row] = ls_ChangeOpt
	CASE ELSE
END CHOOSE
RETURN 0
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event constructor;call super::constructor;//ib_RowSelect = FALSE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

event buttonclicked;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: buttonclikced::dw_update
//	기 능 설 명: 인사정보코드 도움말 버튼 선택시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
IF row = 0 THEN RETURN
IF UPPER(THIS.Object.DataWindow.ReadOnly) = 'YES' THEN RETURN

////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
ls_ColName = STRING(dwo.name)

CHOOSE CASE ls_ColName
	CASE 'btn_member_no'
		//////////////////////////////////////////////////////////////////////////
		// 조회조건 체크
		//////////////////////////////////////////////////////////////////////////
		s_insa_com	lstr_com
		
		lstr_com.ls_item[1] = ''	//성명
		lstr_com.ls_item[2] = ''	//개인번호
		
		OpenWithParm(w_hin000h,lstr_com)
		
		lstr_com = Message.PowerObjectParm
		IF NOT isValid(lstr_com) THEN
			MessageBox('오류','개인번호를 선택하시기 바랍니다.')
			RETURN -1
		END IF
		
		dw_update.Object.kname    [row] = lstr_com.ls_item[1]
		dw_update.Object.member_no[row] = lstr_com.ls_item[2]
		
	CASE ELSE
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
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
	CASE 'hin800m_fr_date', 'hin800m_to_date'
		///////////////////////////////////////////////////////////////////////////////// 
		//	시작일자,종료일자 체크
		/////////////////////////////////////////////////////////////////////////////////
		IF NOT f_isDate(ls_ColData) THEN RETURN 1
	CASE ELSE
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type dw_list from cuo_dwwindow_one_hin within w_hin211i
integer x = 14
integer y = 252
integer width = 3845
integer height = 1628
integer taborder = 50
string dataobject = "d_hin211i_1"
boolean hsplitscroll = true
end type

event rowfocuschanging;/////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_retrieve
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
IF ll_RowCnt = 0 THEN
	dw_update.SetReDraw(FALSE)
	dw_update.Reset()
	dw_update.InsertRow(0)
	dw_update.Object.DataWindow.ReadOnly = 'YES'
	dw_update.SetReDraw(TRUE)
	RETURN
END IF
///////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo	//개인번호
ls_MemberNo = dw_list.Object.hin800m_member_no[ll_GetRow]


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
dw_update.SetReDraw(FALSE)
dw_update.Reset()
ll_RowCnt = dw_update.Retrieve(ls_MemberNo)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
//	wf_SetMenuBtn('IDSR')
	wf_SetMsg('자료가 조회되었습니다.')
	dw_update.Object.DataWindow.ReadOnly = 'NO'
	dw_update.SetFocus()
ELSE
	dw_update.InsertRow(0)
//	wf_SetMenuBtn('IR')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	dw_update.Object.DataWindow.ReadOnly = 'YES'
END IF
dw_update.SetReDraw(TRUE)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

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

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

type uo_member from cuo_insa_member within w_hin211i
integer x = 261
integer y = 104
integer height = 76
integer taborder = 10
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type gb_1 from groupbox within w_hin211i
integer x = 14
integer y = 12
integer width = 3845
integer height = 228
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회조건"
end type

