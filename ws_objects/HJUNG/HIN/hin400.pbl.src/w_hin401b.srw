$PBExportHeader$w_hin401b.srw
$PBExportComments$호봉획정자료생성
forward
global type w_hin401b from w_msheet
end type
type dw_list from cuo_dwwindow_one_hin within w_hin401b
end type
type dw_update from cuo_dwwindow_one_hin within w_hin401b
end type
type dw_con from uo_dwfree within w_hin401b
end type
type uo_member from cuo_insa_member within w_hin401b
end type
type cb_create from uo_imgbtn within w_hin401b
end type
end forward

global type w_hin401b from w_msheet
string title = "호봉획정자료생성"
event type boolean ue_chk_condition ( )
dw_list dw_list
dw_update dw_update
dw_con dw_con
uo_member uo_member
cb_create cb_create
end type
global w_hin401b w_hin401b

type variables
String	is_JikJongCode		//교직원구분
String	is_GubunCode		//처리구분
String	is_GubunName		//구분명
String	is_SalDate			//호봉산정일자
String	is_KName				//성명
String	is_MemberNo			//개인번호
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

event type boolean ue_chk_condition();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_chk_condition
//	기 능 설 명: 조회조건체크처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
////////////////////////////////////////////////////////////////////////////////////

dw_con.accepttext()

// 1.1 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_JikJongCode = dw_con.object.gubn[1]//MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 처리구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_GubunCode =  dw_con.object.gubn1[1] //String(Integer(MID(ddlb_gubn1.Text,1,2)))
is_GubunName =  dw_con.describe("Evaluate ('LookUpDisplay (gubn1)', " + string(1) + ")") //MID(ddlb_gubn1.Text,5)
////////////////////////////////////////////////////////////////////////////////////
// 1.3 호봉산정일자 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
//em_date.GetData(is_SalDate)
is_SalDate = dw_con.object.date[1]// TRIM(is_SalDate)
IF NOT f_isDate(is_SalDate) THEN
	MessageBox('확인','호봉산정일자 입력오류입니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('date')
	RETURN FALSE
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.4 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_KName    = TRIM(uo_member.sle_kname.Text)
is_MemberNo = TRIM(uo_member.sle_member_no.Text)
IF LEN(is_MemberNo) = 0 AND is_GubunCode = '91' THEN
	MessageBox('확인','개인번호를 입력하시기 바랍니다.')
	uo_member.sle_kname.SetFocus()
	RETURN FALSE
END IF

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

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
//
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

on w_hin401b.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_update=create dw_update
this.dw_con=create dw_con
this.uo_member=create uo_member
this.cb_create=create cb_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_update
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_member
this.Control[iCurrent+5]=this.cb_create
end on

on w_hin401b.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_update)
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.cb_create)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 호봉획정자료를 생성한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 처리구분
//////////////////////////////////////////////////////////////////////////////////////
//ddlb_gubn1.Selectitem(2)
//CHOOSE CASE UPPER(SQLCA.ServerName)
//	CASE 'CWU'
//		ddlb_gubn1.Deleteitem(1)
//	CASE 'ORA9'
//END CHOOSE
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 호봉산정일자
//////////////////////////////////////////////////////////////////////////////////////
//em_date.Text = f_today()
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
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
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN -1

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(is_GubunCode,is_SalDate,is_KName,is_JikJongCode)
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('SR')
	wf_SetMsg('자료가 조회되었습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

return 1
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
ls_NotNullCol[2] = 'change_opt/발령구분'
ls_NotNullCol[3] = 'announce_date/발령기간'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
// 3.1 저장처리
////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IpAddr		//등록단말기

String	ls_MemberNo		//개인번호
Integer	li_SeqNo			//인사변동순번
Integer	li_ChagneOpt	//변동코드

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode // gstru_uid_uname.uid		//등록자
	ls_IpAddr    =  gs_ip   //gstru_uid_uname.address	//등록단말기
END IF
DO WHILE ll_Row > 0
	ls_MemberNo = dw_update.Object.member_no[ll_Row]
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1.1 인사변동에 신규임용자료 삭제처리
	//			인사변동에 순번MAX + 1을 SELECT
	/////////////////////////////////////////////////////////////////////////////////
	li_ChagneOpt = Integer(is_GubunCode)
	DELETE	FROM	INDB.HIN007H
	WHERE		CHANGE_OPT    = :li_ChagneOpt
	AND		MEMBER_NO     = :ls_MemberNo;
	IF SQLCA.SQLCODE <> 0 THEN
		wf_SetMsg('인사변동자료 삭제처리 중 에러가 발생하였습니다.')
		MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
		ROLLBACK USING SQLCA;	
		RETURN -1
	END IF
	
	SELECT	NVL(MAX(A.SEQ_NO),0)+1
	INTO		:li_SeqNo
	FROM		INDB.HIN007H A
	WHERE		A.MEMBER_NO = :ls_MemberNo;
	CHOOSE CASE SQLCA.SQLCODE
		CASE 0
		CASE 100
			li_SeqNo = 1
		CASE ELSE
			wf_SetMsg('인사변동사항에 순번 처리 중 오류가 발생하였습니다.')
			MessageBox('오류',&
							'인사변동사항에 순번 처리 중 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;
			RETURN -1
	END CHOOSE
	

	dw_update.Object.seq_no       [ll_Row] = li_SeqNo
	dw_update.Object.sal_year     [ll_Row] = dw_update.Object.com_next_sal_year     [ll_Row]
	dw_update.Object.sal_class    [ll_Row] = dw_update.Object.com_next_sal_class    [ll_Row]
	dw_update.Object.sal_date     [ll_Row] = dw_update.Object.com_next_sal_date     [ll_Row]
	dw_update.Object.sal_leftmonth[ll_Row] = dw_update.Object.com_next_sal_leftmonth[ll_Row]

	/////////////////////////////////////////////////////////////////////////////////
	// 3.1.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	dw_update.Object.worker   [ll_Row] = ls_Worker		//등록자
	dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
	dw_update.Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
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
//wf_SetMenuBtn('SR')
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
dw_update.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('RS')
dw_con.SetFocus()
dw_con.setcolumn('date')
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
//IF dw_update.ib_RowSingle THEN &
	ll_GetRow = dw_update.GetRow()
//IF NOT dw_update.ib_RowSingle THEN &
//	ll_GetRow = dw_update.GetSelectedRow(0)
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
Long		ll_DeleteCnt

IF dw_update.ib_RowSingle OR &
	dw_update.getrow() = 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 2.1 삭제전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
ELSE
//	SetNull(ls_Msg)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
ll_DeleteCnt = dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	////////////////////////////////////////////////////////////////////////////////////
	//	3.2 Multi 처리인 경우.
	//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
	////////////////////////////////////////////////////////////////////////////////////
	IF dw_update.RowCount() > 0 THEN
//		wf_SetMenuBtn('RDS')
	ELSE
//		wf_SetMenuBtn('RS')
	END IF
ELSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 호봉획정자료를 생성한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 처리구분
////////////////////////////////////////////////////////////////////////////////////
dw_con.insertrow(0)

dw_con.object.gubn1[1] = '11'
//ddlb_gubn1.Selectitem(2)
//CHOOSE CASE UPPER(SQLCA.ServerName)
//	CASE 'CWU'
//		dw_con.object.gubn1.ddlb.deleteitem(1)
////		ddlb_gubn1.Deleteitem(1)
//	CASE 'ORA9'
//END CHOOSE

////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 호봉산정일자
////////////////////////////////////////////////////////////////////////////////////
//em_date.Text = f_today()
dw_con.object.date[1] = f_today()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin401b
end type

type ln_tempright from w_msheet`ln_tempright within w_hin401b
end type

type ln_temptop from w_msheet`ln_temptop within w_hin401b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin401b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin401b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin401b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin401b
end type

type uc_insert from w_msheet`uc_insert within w_hin401b
end type

type uc_delete from w_msheet`uc_delete within w_hin401b
end type

type uc_save from w_msheet`uc_save within w_hin401b
end type

type uc_excel from w_msheet`uc_excel within w_hin401b
end type

type uc_print from w_msheet`uc_print within w_hin401b
end type

type st_line1 from w_msheet`st_line1 within w_hin401b
end type

type st_line2 from w_msheet`st_line2 within w_hin401b
end type

type st_line3 from w_msheet`st_line3 within w_hin401b
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin401b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin401b
end type

type dw_list from cuo_dwwindow_one_hin within w_hin401b
boolean visible = false
integer x = 23
integer y = 1188
integer width = 3822
integer height = 1132
boolean titlebar = true
string dataobject = "d_hin401b_2"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = true
boolean righttoleft = true
end type

type dw_update from cuo_dwwindow_one_hin within w_hin401b
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 50
string dataobject = "d_hin401b_1"
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = FALSE
//ib_SortGubn  = TRUE
//ib_EnterChk  = TRUE
end event

type dw_con from uo_dwfree within w_hin401b
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hin401b_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin401b
event destroy ( )
integer x = 2697
integer y = 176
integer taborder = 80
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type cb_create from uo_imgbtn within w_hin401b
integer x = 59
integer y = 36
integer taborder = 51
boolean bringtotop = true
string btnname = "호봉획정자료생성"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_create
//	기 능 설 명: 호봉획정 생성
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
IF NOT PARENT.TRIGGER EVENT ue_chk_condition() THEN RETURN

dw_update.Reset()
///////////////////////////////////////////////////////////////////////////////////////
// 2. 호봉획정 생성용 자료 조회
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt			//총건수
String	ls_GubunCode
IF is_GubunCode = '91' THEN
	is_GubunCode = ''
END IF

dw_list.SetReDraw(FALSE)
dw_list.Reset()
ll_RowCnt = dw_list.Retrieve(is_GubunCode,is_KName,is_JikJongCode)
dw_list.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 호봉획정 추가
///////////////////////////////////////////////////////////////////////////////////////
Long			ll_InsRow				//추가된행
Long			ll_Row					//현재행
//인사변동사항LAYOUT
String		ls_MemberNo				//개인번호
Integer		li_SeqNo					//순번
String		ls_ChangeDate			//발령일자
Integer		li_ChangeOpt			//변동코드
String		ls_AnnounceCon			//변동내용
String		ls_DeptCode				//부서코드
String		ls_SosokDate			//소속일자
String		ls_JikJongDate			//직종일자
Integer		li_JikWiCode			//직위코드
String		ls_DutyCode				//직급코드
String		ls_DutyDate				//직급일자
String		ls_SalYear				//호봉년도
String		ls_SalClass				//호봉코드
String		ls_SalDate				//호봉일자
Integer		li_SalLeftMonth		//호봉잔여월수
String		ls_JaeImYongStart		//재임용시작일자
String		ls_JaeImYongEnd		//재임용종료일자
String		ls_RetireDate			//퇴직일자
Integer		li_OldChangeOpt		//구발령코드
String		ls_OldDept				//구조직코드
Integer		li_JikMuCode			//직무코드
Integer		li_SignOpt				//결재구분
Integer		li_CancelOpt			//탈락사유

String		ls_KName					//성명
String		ls_DeptNm				//부서명
String		ls_JikWiNm				//직위명
String		ls_DutyNm				//직급명	
String		ls_JikMuNm				//직무명
String		ls_SignNm				//결재구분명
Long			ll_SalClass				//잔여월수
Integer		li_SalClassSeq			//호봉코듸 뒤두자리
String		ls_MaxSalClass			//최대호봉코드
Decimal{2}	ldc_SalLeftMonth		//잔여월수
String		ls_JikJongCode			//직종코드
String		ls_NextSalYear			//다음호봉년도
String		ls_NextSalClass		//다음호봉코드
Decimal{2}	ldc_NextSalClass		//다음호봉코드
String		ls_NextSalDate			//다음호봉일자
Integer		li_NextSalLeftMonth	//다음호봉잔여월수

dw_update.SetReDraw(FALSE)
dw_update.Reset()
FOR ll_Row = 1 TO ll_RowCnt
	ls_MemberNo       = dw_list.Object.com_member_no      [ll_Row]	//개인번호
	ls_ChangeDate     = is_SalDate											//발령일자
	li_ChangeOpt      = Integer(is_GubunCode)								//발령코드
	ls_AnnounceCon    = is_GubunName											//발령내용
	ls_DeptCode       = dw_list.Object.com_dept_code      [ll_Row]	//부서코드
	ls_SosokDate      = dw_list.Object.com_sosok_date     [ll_Row]	//소속일자
	ls_JikJongDate    = dw_list.Object.com_jikjong_date   [ll_Row]	//직종일자
	li_JikWiCode      = dw_list.Object.com_jikwi_code     [ll_Row]	//직위코드
	ls_DutyCode       = dw_list.Object.com_duty_code      [ll_Row]	//직급코드
	ls_DutyDate       = is_SalDate											//직급일자
	ls_SalYear        = dw_list.Object.com_sal_year       [ll_Row]	//호봉년도
	ls_SalClass       = dw_list.Object.com_sal_class      [ll_Row]	//호봉코드
	ls_SalDate        = dw_list.Object.com_sal_date			[ll_Row]	//호봉일자
	ldc_SalLeftMonth  = dw_list.Object.com_sal_leftmonth  [ll_Row]	//호봉잔여월수
	ls_JaeImYongStart = dw_list.Object.com_jaeimyong_start[ll_Row]	//재임용시작일자
	ls_JaeImYongEnd   = dw_list.Object.com_jaeimyong_end  [ll_Row]	//재임용종료일자
	ls_RetireDate     = dw_list.Object.com_retire_date    [ll_Row]	//퇴직일자
	li_JikMuCode      = dw_list.Object.com_jikmu_code     [ll_Row]	//직무코드
	li_SignOpt        = 1														//결재구분(미결)
	
	ls_KName          = dw_list.Object.com_kname          [ll_Row]	//성명
	ls_DeptNm         = dw_list.Object.com_dept_nm        [ll_Row]	//부서명
	ls_JikWiNm        = dw_list.Object.com_jikwi_nm       [ll_Row]	//직위명
	ls_DutyNm         = dw_list.Object.com_duty_nm        [ll_Row]	//직급명	
	ls_JikMuNm        = dw_list.Object.com_jikmu_nm       [ll_Row]	//직무명
	ls_SignNm           = '미결'												//결재구분명
	ls_MaxSalClass    = dw_list.Object.com_max_sal_class  [ll_Row]	//최대호봉코드
	
	
	////////////////////////////////////////////////////////////////////////////////////
	// 3.1 다음 호봉년도, 호봉코드, 호봉산정일, 호봉잔여월 처리
	////////////////////////////////////////////////////////////////////////////////////
	ls_NextSalYear   = dw_list.Object.com_next_sal_year  [ll_Row]	//다음호봉년도
	ls_NextSalDate   = is_SalDate												//다음호봉일자
	ldc_NextSalClass = dw_list.Object.com_next_sal_class [ll_Row]	//다음호봉코드
	IF ldc_NextSalClass < 0 THEN ldc_NextSalClass = 1
	//다음호봉잔여월수
	li_NextSalLeftMonth = (ldc_NextSalClass - Truncate(ldc_NextSalClass,0)) * 100
	ls_NextSalClass     = String(Truncate(ldc_NextSalClass,0),'000')
	ls_JikJongCode      = MID(ls_DutyCode,1,1)
	IF ls_JikJongCode = '1' OR ls_JikJongCode = '2' THEN
		/////////////////////////////////////////////////////////////////////////////////
		// 3.1.1 직급이 교원, 조교인 경우처리
		/////////////////////////////////////////////////////////////////////////////////
		IF isNull(ldc_NextSalClass) OR ls_NextSalClass = '000' THEN ldc_NextSalClass = 1
		IF ls_JikJongCode = '1' AND ldc_NextSalClass > 35 THEN
			ls_NextSalClass = 'G' + String(ldc_NextSalClass - 35,'00')
			IF ls_NextSalClass > 'G10' THEN ls_NextSalClass = 'G10'
		END IF
	END IF
	IF ls_NextSalClass > ls_MaxSalClass THEN ls_NextSalClass = ls_MaxSalClass

	ll_InsRow = dw_update.InsertRow(0)
	IF ll_InsRow = 0 THEN EXIT
	dw_update.Object.member_no             [ll_InsRow] = ls_MemberNo				//개인번호
	dw_update.Object.seq_no                [ll_InsRow] = li_SeqNo					//순번
	dw_update.Object.change_opt            [ll_InsRow] = li_ChangeOpt				//발령코드
	dw_update.Object.from_date             [ll_InsRow] = ls_ChangeDate			//변동시작일
	dw_update.Object.change_reason         [ll_InsRow] = ls_AnnounceCon			//발령사유
	dw_update.Object.change_con            [ll_InsRow] = ls_AnnounceCon			//발령내용
	dw_update.Object.gwa                   [ll_InsRow] = ls_DeptCode				//부서코드
	dw_update.Object.sosok_date            [ll_InsRow] = ls_SosokDate				//소속일자
	dw_update.Object.jikjong_date          [ll_InsRow] = ls_JikjongDate			//직종일자
	dw_update.Object.jikwi_code            [ll_InsRow] = li_JikWiCode				//직위코드
	dw_update.Object.duty_code             [ll_InsRow] = ls_DutyCode				//직급코드
	dw_update.Object.duty_date             [ll_InsRow] = ls_DutyDate				//직급일자
	dw_update.Object.sal_year              [ll_InsRow] = ls_SalYear				//호봉년도
	dw_update.Object.sal_class             [ll_InsRow] = ls_SalClass				//호봉코드
	dw_update.Object.sal_date              [ll_InsRow] = ls_SalDate				//호봉일자
	dw_update.Object.sal_leftmonth         [ll_InsRow] = li_SalLeftMonth			//호봉잔여월
	dw_update.Object.jaeimyong_start       [ll_InsRow] = ls_JaeImYongStart		//재임용시작일
	dw_update.Object.jaeimyong_end         [ll_InsRow] = ls_JaeImYongEnd			//재임용종료일
	dw_update.Object.retire_date           [ll_InsRow] = ls_RetireDate			//퇴직일
	dw_update.Object.old_from_date         [ll_InsRow] = ls_SalDate				//구변동시작일
	dw_update.Object.sign_opt              [ll_InsRow] = li_SignOpt				//결재구분(미결)
	
	dw_update.Object.jikmu_code            [ll_InsRow] = li_JikMuCode				//직무코드
	dw_update.Object.com_member_nm         [ll_InsRow] = ls_KName					//성명
	dw_update.Object.com_change_opt_nm     [ll_InsRow] = ls_AnnounceCon			//발령구분명
	dw_update.Object.com_dept_nm           [ll_InsRow] = ls_DeptNm					//부서명
	dw_update.Object.com_jikwi_nm          [ll_InsRow] = ls_JikWiNm				//직위명
	dw_update.Object.com_duty_nm           [ll_InsRow] = ls_DutyNm					//직급명	
	dw_update.Object.com_jikmu_nm          [ll_InsRow] = ls_JikMuNm				//직무명
	dw_update.Object.com_sign_nm           [ll_InsRow] = ls_SignNm					//결재구분명
	dw_update.Object.com_next_sal_year     [ll_InsRow] = ls_NextSalYear			//다음호봉년도
	dw_update.Object.com_next_sal_class    [ll_InsRow] = ls_NextSalClass			//다음호봉코드
	dw_update.Object.com_next_sal_date     [ll_InsRow] = ls_NextSalDate			//다음호봉일자
	dw_update.Object.com_next_sal_leftmonth[ll_InsRow] = li_NextSalLeftMonth	//다음호봉잔여월
NEXT
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_InsRow > 0 THEN
//	wf_SetMenuBtn('SDR')
	wf_SetMsg('호봉획정 생성되었습니다. 확인 후 자료를 저장하시기 바랍니다.')
ELSE
//	wf_SetMenuBtn('R')
	wf_SetMsg('호봉획정대상자가 없습니다.')
END IF

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cb_create.destroy
call uo_imgbtn::destroy
end on

