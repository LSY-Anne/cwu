$PBExportHeader$w_hin203p.srw
$PBExportComments$교직원조건별검색및출력
forward
global type w_hin203p from w_msheet
end type
type tab_1 from tab within w_hin203p
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_update dw_update
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tabpage_3 from userobject within tab_1
end type
type dw_print_skip from uo_dwfree within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_print_skip dw_print_skip
end type
type tab_1 from tab within w_hin203p
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_1 from u_tab within w_hin203p
end type
type dw_con from uo_dwfree within w_hin203p
end type
type uo_member from cuo_insa_member within w_hin203p
end type
end forward

global type w_hin203p from w_msheet
string title = "교직원조건별검색및출력"
tab_1 tab_1
uo_1 uo_1
dw_con dw_con
uo_member uo_member
end type
global w_hin203p w_hin203p

type variables

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

on w_hin203p.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
this.dw_con=create dw_con
this.uo_member=create uo_member
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_member
end on

on w_hin203p.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.dw_con)
destroy(this.uo_member)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 교직원조건별 검색용을 사용한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 부서명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//Long					ll_InsRow
//
//dw_dept_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('%') = 0 THEN
//	wf_setmsg('부서코드 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'gwa','9999')
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_dept_code.InsertRow(0)
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 보직명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_bojik_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve(0) = 0 THEN
//	wf_setmsg('보직코드 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_bojik_code.InsertRow(0)
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 조회조건 - 직종명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_jikjong_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
//	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_jikjong_code.InsertRow(0)
//dw_jikjong_code.Object.code.dddw.PercentWidth	= 100
//////////////////////////////////////////////////////////////////////////////////////
//// 1.4 조회조건 - 직위명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_jikwi_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jikwi_code',0) = 0 THEN
//	wf_setmsg('공통코드[직위]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code',0)
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_jikwi_code.InsertRow(0)
//dw_jikwi_code.Object.code.dddw.PercentWidth	= 100
//////////////////////////////////////////////////////////////////////////////////////
//// 1.5 조회조건 - 직급명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_duty_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve() = 0 THEN
//	wf_setmsg('직급코드 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code','0')
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_duty_code.InsertRow(0)
//////////////////////////////////////////////////////////////////////////////////////
//// 1.6 조회조건 - 학원임용기간
//////////////////////////////////////////////////////////////////////////////////////
////em_fr_date.Text = f_today()
////em_to_date.Text = f_lastdate(f_today())
//////////////////////////////////////////////////////////////////////////////////////
//// 1.7 조회조건 - 발령구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_change_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('change_opt',0) = 0 THEN
//	wf_setmsg('공통코드[발령구분]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code',0)
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_change_opt.InsertRow(0)
//dw_change_opt.Object.code.dddw.PercentWidth	= 100
//////////////////////////////////////////////////////////////////////////////////////
//// 1.8 조회조건 - 재직구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_jaejik_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
//	wf_setmsg('공통코드[재직구분]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code',0)
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_jaejik_opt.InsertRow(0)
//dw_jaejik_opt.Object.code.dddw.PercentWidth	= 100
//
//
//tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
//tab_1.tabpage_2.dw_print.Object.DataWindow.Zoom = 75
//tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
//tab_1.tabpage_3.dw_print_skip.Object.DataWindow.Zoom = 75
//tab_1.tabpage_3.dw_print_skip.Object.DataWindow.Print.Preview = 'YES'
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

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')

dw_con.accepttext()
////////////////////////////////////////////////////////////////////////////////////
// 1.1 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 부서명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_DeptCode
ls_DeptCode = TRIM(dw_con.Object.dept_code[1])
IF LEN(ls_DeptCode) = 0 OR isNull(ls_DeptCode) OR ls_DeptCode = '9999' THEN ls_DeptCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.3 보직명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_BojikCode
ls_BojikCode = TRIM(dw_con.Object.bojik_code[1])
IF LEN(ls_BojikCode) = 0 OR isNull(ls_BojikCode) THEN ls_BojikCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.4 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JikJongGb
ls_JikJongGb = dw_con.object.gubn[1] //MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.5 직종명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JikJongCode
ls_JikJongCode = TRIM(dw_con.Object.jikjong_code[1])
IF LEN(ls_JikJongCode) = 0 OR isNull(ls_JikJongCode) OR ls_JikJongCode = '0' THEN ls_JikJongCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.6 직위명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JikWiCode
ls_JikWiCode = TRIM(dw_con.Object.jikwi_code[1])
IF LEN(ls_JikWiCode) = 0 OR isNull(ls_JikWiCode) OR ls_JikWiCode = '0' THEN ls_JikWiCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.7 직급명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_DutyCode
ls_DutyCode = TRIM(dw_con.Object.duty_code[1])
IF LEN(ls_DutyCode) = 0 OR isNull(ls_DutyCode) OR ls_DutyCode = '0' THEN ls_DutyCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.8 학원임용기간 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_FrDate
//em_fr_date.GetData(ls_FrDate)
ls_FrDate = dw_con.object.fr_date[1]//TRIM(ls_FrDate)
IF LEN(ls_FrDate) > 0 THEN
	IF NOT f_isDate(ls_FrDate) THEN
		MessageBox('확인','학원임용기간FROM 입력오류입니다.')
		dw_con.SetFocus()
		RETURN -1
	END IF
ELSE
	ls_FrDate = '00000000'
END IF
String	ls_ToDate
//em_to_date.GetData(ls_ToDate)
ls_ToDate = dw_con.object.to_Date[1]//TRIM(ls_ToDate)
IF LEN(ls_ToDate) > 0 THEN
	IF NOT f_isDate(ls_ToDate) THEN
		MessageBox('확인','학원임용기간TO를 입력오류입니다.')
		dw_con.SetFocus()
		RETURN -1
	END IF
ELSE
	ls_ToDate = '99999999'
END IF
IF LEN(ls_FrDate) > 0 AND LEN(ls_ToDate) > 0 THEN
	IF ls_FrDate > ls_ToDate THEN
		MessageBox('확인','학원임용기간 오류입니다.')
		dw_con.SetFocus()
		RETURN -1
	END IF
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.9 발령구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_ChangeOpt
ls_ChangeOpt = TRIM(dw_con.Object.change_opt[1])
IF LEN(ls_ChangeOpt) = 0 OR isNull(ls_ChangeOpt) OR ls_ChangeOpt = '0' THEN ls_ChangeOpt = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.10 재직구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JaejikOpt
ls_JaejikOpt = TRIM(dw_con.Object.jaejik_opt[1])
IF LEN(ls_JaejikOpt) = 0 OR isNull(ls_JaejikOpt) OR ls_JaejikOpt = '0' THEN ls_JaejikOpt = ''


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

Long	ll_RowCnt
tab_1.tabpage_1.dw_update.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_update.Retrieve(ls_KName,ls_DeptCode,ls_BojikCode,ls_JikJongGb,&
															ls_JikJongCode,ls_JikWiCode,ls_DutyCode,&
															ls_FrDate,ls_ToDate,ls_ChangeOpt,ls_JaejikOpt)
tab_1.tabpage_1.dw_update.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
ls_DeptCode    =   dw_con.describe("Evaluate ('LookUpDisplay (dept_code)', " + string(1) + ")") //TRIM(dw_dept_code.Object.code_name[1])
ls_BojikCode   = dw_con.describe("Evaluate ('LookUpDisplay (bojik_code)', " + string(1) + ")")  //TRIM(dw_bojik_code.Object.code_name[1])
ls_JikJongGb   =dw_con.describe("Evaluate ('LookUpDisplay (gubn)', " + string(1) + ")")  // MID(ddlb_gubn.Text,4)
ls_JikJongCode = dw_con.describe("Evaluate ('LookUpDisplay (jikjong_code)', " + string(1) + ")")  //TRIM(dw_jikjong_code.Object.code_name[1])
ls_JikWiCode   = dw_con.describe("Evaluate ('LookUpDisplay (jikwi_code)', " + string(1) + ")")  //TRIM(dw_jikwi_code.Object.code_name[1])
ls_DutyCode    = dw_con.describe("Evaluate ('LookUpDisplay (duty_code)', " + string(1) + ")")  //TRIM(dw_duty_code.Object.code_name[1])
ls_ChangeOpt   = dw_con.describe("Evaluate ('LookUpDisplay (change_opt)', " + string(1) + ")")  //TRIM(dw_change_opt.Object.code_name[1])
ls_JaejikOpt   = dw_con.describe("Evaluate ('LookUpDisplay (jaejik_opt)', " + string(1) + ")")  //TRIM(dw_jaejik_opt.Object.code_name[1])

tab_1.tabpage_2.dw_print.Object.t_kname.Text           = ls_KName
tab_1.tabpage_2.dw_print.Object.t_dept_nm.Text         = ls_DeptCode
tab_1.tabpage_2.dw_print.Object.t_bojik_nm.Text        = ls_BojikCode
tab_1.tabpage_2.dw_print.Object.t_jikjong_gb_nm.Text   = ls_JikJongGb
tab_1.tabpage_2.dw_print.Object.t_jikjong_nm.Text      = ls_JikJongCode
tab_1.tabpage_2.dw_print.Object.t_jikwi_nm.Text        = ls_JikWiCode
tab_1.tabpage_2.dw_print.Object.t_duty_nm.Text         = ls_DutyCode
tab_1.tabpage_2.dw_print.Object.t_hakwonhire_date.Text = &
		String(ls_FrDate,'@@@@/@@/@@') + ' ∼ ' + String(ls_ToDate,'@@@@/@@/@@')
tab_1.tabpage_2.dw_print.Object.t_change_opt.Text      = ls_ChangeOpt
tab_1.tabpage_2.dw_print.Object.t_jaejik_opt.Text      = ls_JaejikOpt

DateTime	ldt_SysDateTime
ldt_SysDateTime = f_sysdate()	//시스템일자
tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

tab_1.tabpage_3.dw_print_skip.Object.t_kname.Text           = tab_1.tabpage_2.dw_print.Object.t_kname.Text
tab_1.tabpage_3.dw_print_skip.Object.t_dept_nm.Text         = tab_1.tabpage_2.dw_print.Object.t_dept_nm.Text
tab_1.tabpage_3.dw_print_skip.Object.t_bojik_nm.Text        = tab_1.tabpage_2.dw_print.Object.t_bojik_nm.Text
tab_1.tabpage_3.dw_print_skip.Object.t_jikjong_gb_nm.Text   = tab_1.tabpage_2.dw_print.Object.t_jikjong_gb_nm.Text
tab_1.tabpage_3.dw_print_skip.Object.t_jikjong_nm.Text      = tab_1.tabpage_2.dw_print.Object.t_jikjong_nm.Text
tab_1.tabpage_3.dw_print_skip.Object.t_jikwi_nm.Text        = tab_1.tabpage_2.dw_print.Object.t_jikwi_nm.Text
tab_1.tabpage_3.dw_print_skip.Object.t_duty_nm.Text         = tab_1.tabpage_2.dw_print.Object.t_duty_nm.Text
tab_1.tabpage_3.dw_print_skip.Object.t_hakwonhire_date.Text = tab_1.tabpage_2.dw_print.Object.t_hakwonhire_date.Text
tab_1.tabpage_3.dw_print_skip.Object.t_change_opt.Text      = tab_1.tabpage_2.dw_print.Object.t_change_opt.Text
tab_1.tabpage_3.dw_print_skip.Object.t_jaejik_opt.Text      = tab_1.tabpage_2.dw_print.Object.t_jaejik_opt.Text
tab_1.tabpage_3.dw_print_skip.Object.t_sysdate.Text         = tab_1.tabpage_2.dw_print.Object.t_sysdate.Text
tab_1.tabpage_3.dw_print_skip.Object.t_systime.Text         = tab_1.tabpage_2.dw_print.Object.t_systime.Text

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
	tab_1.tabpage_3.dw_print_skip.Reset()
	tab_1.tabpage_1.dw_update.RowsCopy(1,ll_RowCnt,Primary!,tab_1.tabpage_3.dw_print_skip,1,Primary!)
	tab_1.tabpage_3.dw_print_skip.GroupCalc()
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	tab_1.tabpage_1.dw_update.SetFocus()
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
tab_1.tabpage_1.dw_update.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)//조회버튼 활성화
dw_con.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//CHOOSE CASE tab_1.SelectedTab
//	CASE 2;f_print(tab_1.tabpage_2.dw_print)
//	CASE 3;f_print(tab_1.tabpage_3.dw_print_skip)
//END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 교직원조건별 검색용을 사용한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 부서명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
Long					ll_InsRow

dw_con.insertrow(0)

dw_con.GetChild('dept_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa','9999')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_dept_code.InsertRow(0)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 보직명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('bojik_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve(0) = 0 THEN
	wf_setmsg('보직코드 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
//dw_bojik_code.InsertRow(0)
////////////////////////////////////////////////////////////////////////////////////
// 1.3 조회조건 - 직종명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('jikjong_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
//dw_jikjong_code.InsertRow(0)
dw_con.Object.jikjong_code.dddw.PercentWidth	= 100
////////////////////////////////////////////////////////////////////////////////////
// 1.4 조회조건 - 직위명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('jikwi_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikwi_code',0) = 0 THEN
	wf_setmsg('공통코드[직위]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_jikwi_code.InsertRow(0)
dw_con.Object.jikwi_code.dddw.PercentWidth	= 100
////////////////////////////////////////////////////////////////////////////////////
// 1.5 조회조건 - 직급명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('duty_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('직급코드 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_duty_code.InsertRow(0)
////////////////////////////////////////////////////////////////////////////////////
// 1.6 조회조건 - 학원임용기간
////////////////////////////////////////////////////////////////////////////////////
//em_fr_date.Text = f_today()
//em_to_date.Text = f_lastdate(f_today())
////////////////////////////////////////////////////////////////////////////////////
// 1.7 조회조건 - 발령구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('change_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('change_opt',0) = 0 THEN
	wf_setmsg('공통코드[발령구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_change_opt.InsertRow(0)
dw_con.Object.change_opt.dddw.PercentWidth	= 100
////////////////////////////////////////////////////////////////////////////////////
// 1.8 조회조건 - 재직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('jaejik_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
	wf_setmsg('공통코드[재직구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_jaejik_opt.InsertRow(0)
dw_con.Object.jaejik_opt.dddw.PercentWidth	= 100


tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
tab_1.tabpage_2.dw_print.Object.DataWindow.Zoom = 75
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print

tab_1.tabpage_3.dw_print_skip.Object.DataWindow.Zoom = 75
tab_1.tabpage_3.dw_print_skip.Object.DataWindow.Print.Preview = 'YES'

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hin203p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin203p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin203p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin203p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin203p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin203p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin203p
end type

type uc_insert from w_msheet`uc_insert within w_hin203p
end type

type uc_delete from w_msheet`uc_delete within w_hin203p
end type

type uc_save from w_msheet`uc_save within w_hin203p
end type

type uc_excel from w_msheet`uc_excel within w_hin203p
boolean callevent = false
end type

type uc_print from w_msheet`uc_print within w_hin203p
end type

type st_line1 from w_msheet`st_line1 within w_hin203p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_msheet`st_line2 within w_hin203p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_msheet`st_line3 within w_hin203p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin203p
boolean callevent = false
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin203p
integer beginy = 444
integer endy = 444
end type

type tab_1 from tab within w_hin203p
integer x = 50
integer y = 488
integer width = 4389
integer height = 1836
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;
CHOOSE CASE newindex
	CASE 1,2
		idw_print  = tab_1.tabpage_2.dw_print
	CASE 3
		idw_print = tab_1.tabpage_3.dw_print_skip
END CHOOSE
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4352
integer height = 1716
long backcolor = 16777215
string text = "교직원조건별 검색"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update dw_update
end type

on tabpage_1.create
this.dw_update=create dw_update
this.Control[]={this.dw_update}
end on

on tabpage_1.destroy
destroy(this.dw_update)
end on

type dw_update from cuo_dwwindow_one_hin within tabpage_1
integer y = 4
integer width = 4352
integer height = 1704
integer taborder = 10
string dataobject = "d_hin203p_1"
boolean border = false
borderstyle borderstyle = stylebox!
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

event clicked;call super::clicked;String	ls_ColName
ls_ColName = UPPER(dwo.name)
IF ls_ColName = 'DATAWINDOW' THEN RETURN
IF THIS.RowCount() > 0 AND UPPER(RIGHT(ls_ColName,2)) = '_T' AND ib_SortGubn THEN
	Long		ll_RowCnt
	ll_RowCnt = THIS.RowCount()
	tab_1.tabpage_3.dw_print_skip.Reset()
	tab_1.tabpage_1.dw_update.RowsCopy(1,ll_RowCnt,Primary!,tab_1.tabpage_3.dw_print_skip,1,Primary!)
	tab_1.tabpage_3.dw_print_skip.Object.DataWindow.Table.Sort = THIS.Object.DataWindow.Table.Sort
	tab_1.tabpage_3.dw_print_skip.GroupCalc()
END IF

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4352
integer height = 1716
long backcolor = 16777215
string text = "교직원조건별 출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from uo_dwfree within tabpage_2
integer y = 4
integer width = 4357
integer height = 1704
integer taborder = 20
string dataobject = "d_hin203p_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4352
integer height = 1716
long backcolor = 16777215
string text = "교직원조건별출력(소속별PageSkip)"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print_skip dw_print_skip
end type

on tabpage_3.create
this.dw_print_skip=create dw_print_skip
this.Control[]={this.dw_print_skip}
end on

on tabpage_3.destroy
destroy(this.dw_print_skip)
end on

type dw_print_skip from uo_dwfree within tabpage_3
integer y = 12
integer width = 4338
integer height = 1692
integer taborder = 20
string dataobject = "d_hin203p_3"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from u_tab within w_hin203p
event destroy ( )
integer x = 1851
integer y = 260
integer taborder = 70
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type dw_con from uo_dwfree within w_hin203p
integer x = 50
integer y = 164
integer width = 4379
integer height = 280
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hin203p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin203p
event destroy ( )
integer x = 3141
integer y = 176
integer taborder = 80
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

