$PBExportHeader$w_hin384p.srw
$PBExportComments$교직원 개인별 보직명단
forward
global type w_hin384p from w_msheet
end type
type dw_con from uo_dwfree within w_hin384p
end type
type uo_member from cuo_insa_member within w_hin384p
end type
type dw_print from uo_dwfree within w_hin384p
end type
end forward

global type w_hin384p from w_msheet
integer height = 2616
string title = "보직발령등록"
long backcolor = 1073741824
dw_con dw_con
uo_member uo_member
dw_print dw_print
end type
global w_hin384p w_hin384p

type variables
DataWindowChild	idwc_DutyCode	//직급코드 DDDW

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

on w_hin384p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.uo_member=create uo_member
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.uo_member
this.Control[iCurrent+3]=this.dw_print
end on

on w_hin384p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.dw_print)
end on

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 교직원 개인별 보직명단을 출력한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 보직코드 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_BoJikCodeMain
//dw_print.GetChild('appoint_code',ldwc_BoJikCodeMain)
//ldwc_BoJikCodeMain.SetTransObject(SQLCA)
//IF ldwc_BoJikCodeMain.Retrieve(1) = 0 THEN
//	wf_setmsg('보직코드를 입력하시기 바랍니다.')
//	ldwc_BoJikCodeMain.InsertRow(0)
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 결재구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//dw_sign_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('sign_opt',0) = 0 THEN
//	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_sign_opt.InsertRow(0)
//dw_sign_opt.Object.code.dddw.PercentWidth	= 100
//
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_setMenuBtn('R')
//uo_member.sle_kname.SetFocus()
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
wf_SetMsg('조회조건 체크 중입니다...')
dw_con.accepttext()
////////////////////////////////////////////////////////////////////////////////////
// 1.1 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 개인번호 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo
ls_MemberNo = TRIM(uo_member.sle_member_no.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.3 해임일자 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_Firedate
ls_Firedate = TRIM(dw_con.Object.sign_opt[1])
IF LEN(ls_Firedate) = 0 OR isNull(ls_Firedate) OR ls_Firedate = '0' THEN ls_Firedate = ''

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 3. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(ls_KName,ls_Firedate)
dw_print.SetReDraw(TRUE)

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
return 1
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//f_print(dw_print)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 교직원 개인별 보직명단을 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 보직코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.insertrow(0)

DataWindowChild	ldwc_BoJikCodeMain
dw_print.GetChild('appoint_code',ldwc_BoJikCodeMain)
ldwc_BoJikCodeMain.SetTransObject(SQLCA)
IF ldwc_BoJikCodeMain.Retrieve(1) = 0 THEN
	wf_setmsg('보직코드를 입력하시기 바랍니다.')
	ldwc_BoJikCodeMain.InsertRow(0)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 결재구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
dw_con.GetChild('sign_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('sign_opt',0) = 0 THEN
	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
//dw_sign_opt.InsertRow(0)
dw_con.Object.sign_opt.dddw.PercentWidth	= 100


///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenuBtn('R')
uo_member.sle_kname.SetFocus()
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
dw_print.SetReDraw(TRUE)
idw_print = dw_print
///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')
dw_con.SetFocus()
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

type ln_templeft from w_msheet`ln_templeft within w_hin384p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin384p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin384p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin384p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin384p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin384p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin384p
end type

type uc_insert from w_msheet`uc_insert within w_hin384p
end type

type uc_delete from w_msheet`uc_delete within w_hin384p
end type

type uc_save from w_msheet`uc_save within w_hin384p
end type

type uc_excel from w_msheet`uc_excel within w_hin384p
end type

type uc_print from w_msheet`uc_print within w_hin384p
end type

type st_line1 from w_msheet`st_line1 within w_hin384p
end type

type st_line2 from w_msheet`st_line2 within w_hin384p
end type

type st_line3 from w_msheet`st_line3 within w_hin384p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin384p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin384p
end type

type dw_con from uo_dwfree within w_hin384p
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hin384p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin384p
event destroy ( )
integer x = 1335
integer y = 184
integer taborder = 90
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type dw_print from uo_dwfree within w_hin384p
integer x = 50
integer y = 292
integer width = 4379
integer height = 1964
integer taborder = 40
string dataobject = "d_hin384p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

