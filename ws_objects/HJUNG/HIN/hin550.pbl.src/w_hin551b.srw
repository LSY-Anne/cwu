$PBExportHeader$w_hin551b.srw
$PBExportComments$년가생성관리
forward
global type w_hin551b from w_msheet
end type
type dw_list from cuo_dwwindow_one_hin within w_hin551b
end type
type st_2 from statictext within w_hin551b
end type
type ddlb_gubn from dropdownlistbox within w_hin551b
end type
type st_1 from statictext within w_hin551b
end type
type cb_create from commandbutton within w_hin551b
end type
type em_date from editmask within w_hin551b
end type
type st_3 from statictext within w_hin551b
end type
type dw_update from cuo_dwwindow_one_hin within w_hin551b
end type
type st_6 from statictext within w_hin551b
end type
type gb_1 from groupbox within w_hin551b
end type
end forward

global type w_hin551b from w_msheet
string title = "년가생성관리"
event type boolean ue_chk_condition ( )
dw_list dw_list
st_2 st_2
ddlb_gubn ddlb_gubn
st_1 st_1
cb_create cb_create
em_date em_date
st_3 st_3
dw_update dw_update
st_6 st_6
gb_1 gb_1
end type
global w_hin551b w_hin551b

type variables
String	is_JikJongCode		//직종구분
String	is_Date				//기준일자
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
// 1.1 구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_JikJongCode = MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 기준일자 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
em_date.GetData(is_date)
is_date = TRIM(is_date)
IF LEN(is_date) = 0 OR isNull(is_date) THEN
	MessageBox('확인','기준일자를 입력하시기 바랍니다.')
	em_date.SetFocus()
	RETURN FALSE
END IF

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

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

on w_hin551b.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.st_2=create st_2
this.ddlb_gubn=create ddlb_gubn
this.st_1=create st_1
this.cb_create=create cb_create
this.em_date=create em_date
this.st_3=create st_3
this.dw_update=create dw_update
this.st_6=create st_6
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.ddlb_gubn
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_create
this.Control[iCurrent+6]=this.em_date
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.dw_update
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.gb_1
end on

on w_hin551b.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.st_2)
destroy(this.ddlb_gubn)
destroy(this.st_1)
destroy(this.cb_create)
destroy(this.em_date)
destroy(this.st_3)
destroy(this.dw_update)
destroy(this.st_6)
destroy(this.gb_1)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 년가자료를 생성한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 직종구분
////////////////////////////////////////////////////////////////////////////////////
ddlb_gubn.Selectitem(2)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 기준일자
////////////////////////////////////////////////////////////////////////////////////
em_date.Text = f_today()
////////////////////////////////////////////////////////////////////////////////////
// 1.3 데이타원도우 변경
////////////////////////////////////////////////////////////////////////////////////
CHOOSE CASE UPPER(SQLCA.ServerName)
	CASE 'SEWC' ; dw_list.DataObject = 'd_hin551b_2'
	CASE 'ORA9' ; dw_list.DataObject = 'd_hin551b_3'
END CHOOSE
dw_list.SetTransObject(SQLCA)

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
ll_RowCnt = dw_update.Retrieve(is_date,is_JikJongCode)
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
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IpAddr		//등록단말기

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gstru_uid_uname.uid		//등록자
	ls_IpAddr    = gstru_uid_uname.address	//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = dw_update.GetItemStatus(ll_Row,0,Primary!)
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 저장처리전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		dw_update.Object.worker   [ll_Row] = ls_Worker		//등록일자
		dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록자
		dw_update.Object.ipaddr   [ll_Row] = ls_IPAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
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
////wf_SetMenuBtn('R')
em_date.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin551b
end type

type ln_tempright from w_msheet`ln_tempright within w_hin551b
end type

type ln_temptop from w_msheet`ln_temptop within w_hin551b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin551b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin551b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin551b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin551b
end type

type uc_insert from w_msheet`uc_insert within w_hin551b
end type

type uc_delete from w_msheet`uc_delete within w_hin551b
end type

type uc_save from w_msheet`uc_save within w_hin551b
end type

type uc_excel from w_msheet`uc_excel within w_hin551b
end type

type uc_print from w_msheet`uc_print within w_hin551b
end type

type st_line1 from w_msheet`st_line1 within w_hin551b
end type

type st_line2 from w_msheet`st_line2 within w_hin551b
end type

type st_line3 from w_msheet`st_line3 within w_hin551b
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin551b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin551b
end type

type dw_list from cuo_dwwindow_one_hin within w_hin551b
boolean visible = false
integer x = 14
integer y = 1008
integer width = 3835
integer height = 648
boolean titlebar = true
string dataobject = "d_hin551b_2"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hsplitscroll = true
boolean righttoleft = true
end type

event constructor;call super::constructor;ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
end event

type st_2 from statictext within w_hin551b
integer x = 3415
integer y = 116
integer width = 411
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 67108864
boolean enabled = false
string text = "년가일수생성"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_gubn from dropdownlistbox within w_hin551b
integer x = 681
integer y = 100
integer width = 338
integer height = 324
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean enabled = false
string text = "none"
string item[] = {"1. 교원","2. 직원"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_hin551b
integer x = 338
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

type cb_create from commandbutton within w_hin551b
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
//	기 능 설 명: 년가일수 생성 
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
IF NOT PARENT.TRIGGER EVENT ue_chk_condition() THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 년가일수 생성 생성 전 삭제여부체크
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_Cnt	//건수
SELECT	COUNT(*)
INTO		:ll_Cnt
FROM		INDB.HIN028M A
WHERE		A.YEAR = SUBSTR(:is_date,1,4);
IF ll_Cnt > 0 THEN
	Integer	li_Rtn
	li_Rtn = MessageBox('확인','기존에 생성된자료가 존재합니다.~r~n'+&
										'기존자료를 삭제하고 다시 생성하시겠습니까?',&
										Question!,YesNo!,1)
	IF li_Rtn = 1 THEN
		DELETE	FROM	INDB.HIN028M
		WHERE		YEAR = SUBSTR(:is_date,1,4);
		IF SQLCA.SQLCODE <> 0 THEN
			wf_SetMsg('년가일수마스터 삭제처리 중 에러가 발생하였습니다.')
			MessageBox('확인','년가일수마스터 삭제시 전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN
		END IF
	ELSE
		wf_SetMsg('년가일수 생성을 취소하였습니다.')
		RETURN
	END IF
END IF

dw_update.Reset()
///////////////////////////////////////////////////////////////////////////////////////
// 3. 년가일수 생성
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Query
Long		ll_InsRow			//추가된행
Long		ll_Row				//현재행
Long		ll_RowCnt			//총건수

String	ls_MemberNo			//개인번호
String	ls_KName				//성명
Long		ll_YearCnt			//년가일수
String	ls_DeptNm			//부서명
String	ls_JikJongNm		//직종명
String	ls_JikWiNm			//직위명
String	ls_DutyNm			//직급명	
String	ls_JikMuNm			//직무명
////////////////////////////////////////////////////////////////////////////////////
// 3.1	전체 교,직원의 학원임용일을 기준으로 근무년수를 가지고 온다.
//			지각,조퇴를 포함해서 3회는 결근1일로 처리	및 결근일수를 가지고온다.
//			휴직기간를 가지고온다.(변동구분(71:휴직))
////////////////////////////////////////////////////////////////////////////////////
dw_list.SetReDraw(FALSE)
dw_list.Reset()
ll_RowCnt = dw_list.Retrieve(is_Date)
dw_list.SetReDraw(TRUE)
////////////////////////////////////////////////////////////////////////////////////
// 3.2 년가일수 추가
////////////////////////////////////////////////////////////////////////////////////
dw_update.SetReDraw(FALSE)
dw_update.Reset()
FOR ll_Row = 1 TO ll_RowCnt
	ls_MemberNo  = dw_list.Object.member_no     [ll_Row]	//개인번호
	ls_KName     = dw_list.Object.kname         [ll_Row]	//성명
	ll_YearCnt   = dw_list.Object.com_year_ilsu [ll_Row]	//년가일수
	ls_DeptNm    = dw_list.Object.com_dept_nm   [ll_Row]	//부서명
	ls_JikJongNm = dw_list.Object.com_jikjong_nm[ll_Row]	//직종명
	ls_JikWiNm   = dw_list.Object.com_jikwi_nm  [ll_Row]	//직위명
	ls_DutyNm    = dw_list.Object.com_duty_nm   [ll_Row]	//직급명	
	ls_JikMuNm   = dw_list.Object.com_jikmu_nm  [ll_Row]	//직무명

	ll_InsRow = dw_update.InsertRow(0)
	IF ll_InsRow = 0 THEN EXIT

	dw_update.Object.member_no     [ll_InsRow] = ls_MemberNo			//개인번호
	dw_update.Object.year          [ll_InsRow] = MID(is_Date,1,4)		//년도
	dw_update.Object.kname         [ll_InsRow] = ls_KName				//성명
	dw_update.Object.year_day      [ll_InsRow] = ll_YearCnt				//년가일수
	dw_update.Object.com_dept_nm   [ll_InsRow] = ls_DeptNm				//부서명
	dw_update.Object.com_jikjong_nm[ll_InsRow] = ls_JikJongNm			//직종명
	dw_update.Object.com_jikwi_nm  [ll_InsRow] = ls_JikWiNm				//직위명
	dw_update.Object.com_duty_nm   [ll_InsRow] = ls_DutyNm				//직급명	
	dw_update.Object.com_jikmu_nm  [ll_InsRow] = ls_JikMuNm				//직무명
NEXT
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_InsRow > 0 THEN
//	wf_SetMenuBtn('SR')
	wf_SetMsg('년가일수가 생성되었습니다. 확인 후 자료를 저장하시기 바랍니다.')
ELSE
//	wf_SetMenuBtn('R')
	wf_SetMsg('생성할 년가일수자료가 없습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type em_date from editmask within w_hin551b
integer x = 1349
integer y = 100
integer width = 361
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

event modified;//
end event

type st_3 from statictext within w_hin551b
integer x = 1070
integer y = 116
integer width = 270
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "기준년도"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_update from cuo_dwwindow_one_hin within w_hin551b
integer x = 14
integer y = 252
integer width = 3835
integer height = 2348
integer taborder = 40
string title = "정기승진 대상자"
string dataobject = "d_hin551b_1"
boolean livescroll = false
boolean ib_sortgubn = false
end type

event constructor;call super::constructor;ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = TRUE
end event

type st_6 from statictext within w_hin551b
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

type gb_1 from groupbox within w_hin551b
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

