$PBExportHeader$w_hin910p.srw
$PBExportComments$퇴직예정자명단출력--미사용
forward
global type w_hin910p from w_msheet
end type
type em_date from editmask within w_hin910p
end type
type st_31 from statictext within w_hin910p
end type
type uo_member from cuo_insa_member within w_hin910p
end type
type st_21 from statictext within w_hin910p
end type
type ddlb_gubn from dropdownlistbox within w_hin910p
end type
type dw_print from cuo_dwwindow_one_hin within w_hin910p
end type
type gb_1 from groupbox within w_hin910p
end type
end forward

global type w_hin910p from w_msheet
integer height = 2616
string title = "퇴직예정자명단출력"
event type boolean ue_chk_condition ( )
em_date em_date
st_31 st_31
uo_member uo_member
st_21 st_21
ddlb_gubn ddlb_gubn
dw_print dw_print
gb_1 gb_1
end type
global w_hin910p w_hin910p

type variables
String	is_JikJongCode		//직종구분
String	is_Date				//처리일자
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
// 1.2 처리일자 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
em_date.GetData(is_Date)
is_Date = TRIM(is_Date)
IF NOT f_isDate(is_Date) THEN
	MessageBox('확인','처리일자 입력오류입니다.')
	em_date.SetFocus()
	RETURN FALSE
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.3 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_KName    = TRIM(uo_member.sle_kname.Text)
is_MemberNo = TRIM(uo_member.sle_member_no.Text)

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

on w_hin910p.create
int iCurrent
call super::create
this.em_date=create em_date
this.st_31=create st_31
this.uo_member=create uo_member
this.st_21=create st_21
this.ddlb_gubn=create ddlb_gubn
this.dw_print=create dw_print
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_date
this.Control[iCurrent+2]=this.st_31
this.Control[iCurrent+3]=this.uo_member
this.Control[iCurrent+4]=this.st_21
this.Control[iCurrent+5]=this.ddlb_gubn
this.Control[iCurrent+6]=this.dw_print
this.Control[iCurrent+7]=this.gb_1
end on

on w_hin910p.destroy
call super::destroy
destroy(this.em_date)
destroy(this.st_31)
destroy(this.uo_member)
destroy(this.st_21)
destroy(this.ddlb_gubn)
destroy(this.dw_print)
destroy(this.gb_1)
end on

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
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(is_KName,is_MemberNo,is_JikJongCode,is_Date)
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UnivName
ls_UnivName = gstru_uid_uname.univ_name
dw_print.Object.t_jikjong_code.Text = MID(ddlb_gubn.Text,4)
dw_print.Object.t_name.Text         = is_KName
dw_print.Object.t_date.Text         = String(is_Date,'@@@@/@@/@@')

//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('RP')
	wf_SetMsg('자료가 조회되었습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;f_print(dw_print)
end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 퇴직예정자명단를 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 처리일자
////////////////////////////////////////////////////////////////////////////////////
em_date.Text = f_today()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

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
dw_print.SetReDraw(FALSE)
dw_print.Reset()
dw_print.Object.DataWindow.Print.Preview = 'YES'
dw_print.Object.DataWindow.Zoom = 100
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')
uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin910p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin910p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin910p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin910p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin910p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin910p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin910p
end type

type uc_insert from w_msheet`uc_insert within w_hin910p
end type

type uc_delete from w_msheet`uc_delete within w_hin910p
end type

type uc_save from w_msheet`uc_save within w_hin910p
end type

type uc_excel from w_msheet`uc_excel within w_hin910p
end type

type uc_print from w_msheet`uc_print within w_hin910p
end type

type st_line1 from w_msheet`st_line1 within w_hin910p
end type

type st_line2 from w_msheet`st_line2 within w_hin910p
end type

type st_line3 from w_msheet`st_line3 within w_hin910p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin910p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin910p
end type

type em_date from editmask within w_hin910p
integer x = 2400
integer y = 100
integer width = 366
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

type st_31 from statictext within w_hin910p
integer x = 2117
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
string text = "처리일자"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_member from cuo_insa_member within w_hin910p
integer x = 1001
integer y = 100
integer height = 76
integer taborder = 30
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type st_21 from statictext within w_hin910p
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

type ddlb_gubn from dropdownlistbox within w_hin910p
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
ls_UserID = TRIM(gstru_uid_uname.uid)			//로그인사번
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
AND		A.GROUP_ID  IN ('Hin01','Hin02','Admin','Mnger','PGMer2','Hin00')
AND		ROWNUM       = 1;

CHOOSE CASE TRIM(ls_GroupID)
	CASE 'Hin01'
		li_JikJongCode = 2	//사무처
	CASE 'Hin02'
		li_JikJongCode = 1	//교무처
	CASE 'Admin','Mnger','PGMer2','Hin00'
		li_JikJongCode = 3	//관리자
		lb_GroupChk    = TRUE
	CASE ELSE
		li_JikJongCode = 1	//교무처
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

type dw_print from cuo_dwwindow_one_hin within w_hin910p
integer x = 14
integer y = 248
integer width = 3845
integer height = 2256
integer taborder = 30
string dataobject = "d_hin910p_1"
end type

type gb_1 from groupbox within w_hin910p
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

