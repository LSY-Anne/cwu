$PBExportHeader$w_hin304b.srw
$PBExportComments$급여 이체은행자료 일괄생성
forward
global type w_hin304b from w_msheet
end type
type uo_member from cuo_insa_member within w_hin304b
end type
type st_21 from statictext within w_hin304b
end type
type ddlb_gubn from dropdownlistbox within w_hin304b
end type
type dw_list from cuo_dwwindow_one_hin within w_hin304b
end type
type st_2 from statictext within w_hin304b
end type
type cb_create from commandbutton within w_hin304b
end type
type dw_update from cuo_dwwindow_one_hin within w_hin304b
end type
type gb_1 from groupbox within w_hin304b
end type
type st_6 from statictext within w_hin304b
end type
end forward

global type w_hin304b from w_msheet
string title = "급여이체은행자료일괄생성"
event type boolean ue_chk_condition ( )
uo_member uo_member
st_21 st_21
ddlb_gubn ddlb_gubn
dw_list dw_list
st_2 st_2
cb_create cb_create
dw_update dw_update
gb_1 gb_1
st_6 st_6
end type
global w_hin304b w_hin304b

type variables
String	is_JikJongCode		//직종구분
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
// 1.1 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_JikJongCode = MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_KName    = TRIM(uo_member.sle_kname.Text)
is_MemberNo = TRIM(uo_member.sle_member_no.Text)

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

public subroutine wf_setmenubtn (string as_type);//입력
//저장
//삭제
//조회
//검색
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

on w_hin304b.create
int iCurrent
call super::create
this.uo_member=create uo_member
this.st_21=create st_21
this.ddlb_gubn=create ddlb_gubn
this.dw_list=create dw_list
this.st_2=create st_2
this.cb_create=create cb_create
this.dw_update=create dw_update
this.gb_1=create gb_1
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_member
this.Control[iCurrent+2]=this.st_21
this.Control[iCurrent+3]=this.ddlb_gubn
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_create
this.Control[iCurrent+7]=this.dw_update
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.st_6
end on

on w_hin304b.destroy
call super::destroy
destroy(this.uo_member)
destroy(this.st_21)
destroy(this.ddlb_gubn)
destroy(this.dw_list)
destroy(this.st_2)
destroy(this.cb_create)
destroy(this.dw_update)
destroy(this.gb_1)
destroy(this.st_6)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 급여이체 은행자료를 일괄 생성한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN -1

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(is_KName,is_MemberNo,is_JikjongCode)
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('R')
	wf_SetMsg('자료가 조회되었습니다.')
END IF
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
ls_NotNullCol[1] = 'member_no/개인번호'
ls_NotNullCol[2] = 'acct_no/계좌번호'
ls_NotNullCol[3] = 'bank_code/은행명'
ls_NotNullCol[3] = 'depositor/예금주'
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
	ls_Worker    = gs_empcode		//등록자
	ls_IpAddr    = gs_ip	//등록단말기
END IF
DO WHILE ll_Row > 0
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1.1 수정항목 처리
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
//wf_SetMenuBtn('R')
uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin304b
end type

type ln_tempright from w_msheet`ln_tempright within w_hin304b
end type

type ln_temptop from w_msheet`ln_temptop within w_hin304b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin304b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin304b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin304b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin304b
end type

type uc_insert from w_msheet`uc_insert within w_hin304b
end type

type uc_delete from w_msheet`uc_delete within w_hin304b
end type

type uc_save from w_msheet`uc_save within w_hin304b
end type

type uc_excel from w_msheet`uc_excel within w_hin304b
end type

type uc_print from w_msheet`uc_print within w_hin304b
end type

type st_line1 from w_msheet`st_line1 within w_hin304b
end type

type st_line2 from w_msheet`st_line2 within w_hin304b
end type

type st_line3 from w_msheet`st_line3 within w_hin304b
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin304b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin304b
end type

type uo_member from cuo_insa_member within w_hin304b
integer x = 1015
integer y = 100
integer height = 76
integer taborder = 20
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type st_21 from statictext within w_hin304b
integer x = 251
integer y = 116
integer width = 334
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "교직원구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_gubn from dropdownlistbox within w_hin304b
integer x = 590
integer y = 100
integer width = 379
integer height = 324
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"1. 교원","2. 직원","3. 전체"}
borderstyle borderstyle = stylelowered!
end type

event constructor;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: constructor
//	기 능 설 명: 활성화되는 시점에 로그인한 사람의 권한그룹을 체크하여
//						교직원구분을 셋팅한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UserID		//로그인사번
Integer	li_JikJongCode	//교직원구분코드
ls_UserID = TRIM(gs_empcode)			//로그인사번
IF LEN(ls_UserID) = 0 THEN
	li_JikJongCode = 1
	RETURN
END IF

String 	ls_GroupID		//권한그굽코드
Boolean	lb_GroupChk = FALSE
SELECT	A.GROUP_ID
INTO		:ls_GroupID
FROM		CDDB.KCH403M A
WHERE		A.MEMBER_NO = :ls_UserID
AND		A.GROUP_ID  IN ('Hin00','Hin01','Hin02','Admin','Mnger','PGMer2')
AND		ROWNUM       = 1;

CHOOSE CASE TRIM(ls_GroupID)
	CASE 'Hin01'
		li_JikJongCode = 2	//사무처
	CASE 'Hin02'
		li_JikJongCode = 1	//교무처
	CASE ELSE
		li_JikJongCode = 3	//관리자
		lb_GroupChk    = TRUE
END CHOOSE

THIS.SelectItem(li_JikJongCode)
THIS.Enabled = lb_GroupChk

uo_member.is_JikJongCode = String(li_JikJongCode)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event selectionchanged;uo_member.is_JikJongCode = String(index)

end event

type dw_list from cuo_dwwindow_one_hin within w_hin304b
boolean visible = false
integer x = 23
integer y = 1960
integer width = 3831
integer height = 640
boolean titlebar = true
string dataobject = "d_hin304b_2"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = true
end type

type st_2 from statictext within w_hin304b
integer x = 3483
integer y = 64
integer width = 274
integer height = 152
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 67108864
boolean enabled = false
string text = "급여이체은행자료일괄생성"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_create from commandbutton within w_hin304b
integer x = 3383
integer y = 44
integer width = 475
integer height = 192
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = " "
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_create
//	기 능 설 명: 급여이체 은행자료 일괄생성
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
IF NOT PARENT.TRIGGER EVENT ue_chk_condition() THEN RETURN

dw_update.Reset()
///////////////////////////////////////////////////////////////////////////////////////
// 2. 급여이체 은행자료 일괄생성
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt			//총건수
dw_list.SetReDraw(FALSE)
dw_list.Reset()
ll_RowCnt = dw_list.Retrieve(is_KName,is_MemberNo,is_JikJongCode)
dw_list.SetReDraw(TRUE)
////////////////////////////////////////////////////////////////////////////////////
// 2.1 추가
////////////////////////////////////////////////////////////////////////////////////
Long			ll_InsRow				//추가된행
Long			ll_Row					//현재행
//개인별이체은행LAYOUT(HPA020M)
String		ls_MemberNo				//개인번호
String		ls_AcctNo				//계좌번호
Integer		li_BankCode				//은행코드
String		ls_Depositor			//예금주
Integer		li_PayClass				//지급구분
String		ls_UseYn	= '9'			//사용유무(사용)

String		ls_BankNm				//은행명
String		ls_PayClassNm			//지급구분명
String		ls_KName					//성명
String		ls_DeptNm				//부서명
String		ls_JikWiNm				//직위명
String		ls_DutyNm				//직급명	
String		ls_JikMuNm				//직무명

dw_update.SetReDraw(FALSE)
dw_update.Reset()
FOR ll_Row = 1 TO ll_RowCnt
	ls_MemberNo   = dw_list.Object.com_member_no   [ll_Row]	//개인번호
	ls_AcctNo     = dw_list.Object.com_acct_no     [ll_Row]	//계좌번호
	li_BankCode   = dw_list.Object.com_bank_no     [ll_Row]	//은행코드
	ls_Depositor  = dw_list.Object.com_name        [ll_Row]	//예금주
	li_PayClass   = dw_list.Object.com_pay_class   [ll_Row]	//지급구분
	
	ls_BankNm     = dw_list.Object.com_bank_nm     [ll_Row]	//은행명
	ls_PayClassNm = dw_list.Object.com_pay_class_nm[ll_Row]	//지급구분명
	ls_DeptNm     = dw_list.Object.com_dept_nm     [ll_Row]	//부서명
	ls_JikWiNm    = dw_list.Object.com_jikwi_nm    [ll_Row]	//직위명
	ls_DutyNm     = dw_list.Object.com_duty_nm     [ll_Row]	//직급명	
	ls_JikMuNm    = dw_list.Object.com_jikmu_nm    [ll_Row]	//직무명
	
	ll_InsRow = dw_update.InsertRow(0)
	IF ll_InsRow = 0 THEN EXIT
	dw_update.Object.member_no       [ll_InsRow] = ls_MemberNo		//개인번호
	dw_update.Object.acct_no         [ll_InsRow] = ls_AcctNo			//계좌번호
	dw_update.Object.bank_code       [ll_InsRow] = li_BankCode		//은행코드
	dw_update.Object.depositor       [ll_InsRow] = ls_Depositor		//예금주
	dw_update.Object.pay_class       [ll_InsRow] = li_PayClass		//지급구분
	dw_update.Object.use_yn          [ll_InsRow] = ls_UseYn			//사용유무
	
	dw_update.Object.com_bank_nm     [ll_InsRow] = ls_BankNm			//은행명
	dw_update.Object.com_pay_class_nm[ll_InsRow] = ls_PayClassNm	//지급구분명
	dw_update.Object.name            [ll_InsRow] = ls_Depositor		//성명
	dw_update.Object.com_dept_nm     [ll_InsRow] = ls_DeptNm			//부서명
	dw_update.Object.com_jikwi_nm    [ll_InsRow] = ls_JikWiNm		//직위명
	dw_update.Object.com_duty_nm     [ll_InsRow] = ls_DutyNm			//직급명	
	dw_update.Object.com_jikmu_nm    [ll_InsRow] = ls_JikMuNm		//직무명
NEXT
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_InsRow > 0 THEN
//	wf_SetMenuBtn('SR')
	wf_SetMsg('경력자료가 생성되었습니다. 확인 후 자료를 저장하시기 바랍니다.')
ELSE
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 없습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type dw_update from cuo_dwwindow_one_hin within w_hin304b
integer x = 14
integer y = 252
integer width = 3849
integer height = 2356
integer taborder = 50
string dataobject = "d_hin304b_1"
boolean livescroll = false
boolean ib_sortgubn = false
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = TRUE
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
String	ls_Msg
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
	CASE ''
		/////////////////////////////////////////////////////////////////////////////////
		//	
		/////////////////////////////////////////////////////////////////////////////////
		
	CASE ELSE
		
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type gb_1 from groupbox within w_hin304b
integer x = 14
integer y = 12
integer width = 3351
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

type st_6 from statictext within w_hin304b
integer x = 3374
integer y = 36
integer width = 489
integer height = 204
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

