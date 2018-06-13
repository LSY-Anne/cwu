$PBExportHeader$w_hin432p.srw
$PBExportComments$호봉승급표출력
forward
global type w_hin432p from w_msheet
end type
type dw_con from uo_dwfree within w_hin432p
end type
type uo_member from cuo_insa_member within w_hin432p
end type
type dw_print from uo_dwfree within w_hin432p
end type
end forward

global type w_hin432p from w_msheet
string title = "호봉사정표출력"
event type boolean ue_chk_condition ( )
dw_con dw_con
uo_member uo_member
dw_print dw_print
end type
global w_hin432p w_hin432p

type variables
String	is_JikJongCode		//직종
String	is_KName				//성명

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
// 1.1 직종명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
dw_con.accepttext()

is_JikJongCode = TRIM(dw_con.Object.jikjong_code[1])
IF LEN(is_JikJongCode) = 0 OR isNull(is_JikJongCode) OR is_JikJongCode = '0' THEN
	MessageBox('확인','직종명을 선택하시기 바랍니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('jikjong_code')
	RETURN FALSE
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_KName = TRIM(uo_member.sle_kname.Text)
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

on w_hin432p.create
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

on w_hin432p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.dw_print)
end on

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
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(is_JikJongCode,is_KName)
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UnivName
ls_UnivName = GF_GLOBAL_VALUE(2) // gstru_uid_uname.univ_name
//dw_print.Object.t_campus.Text        = ls_UnivName
//dw_print.Object.t_jikjong_code.Text  = MID(ddlb_gubn.Text,4)
//dw_print.Object.t_announce_date.Text = String(is_AnnounceDate,'@@@@/@@/@@')

DateTime	ldt_SysDateTime
ldt_SysDateTime = f_sysdate()	//시스템일자
dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

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

event ue_print;call super::ue_print;//f_print(dw_print)
end event

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 호봉사정표를 출력한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 직종명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//dw_jikjong_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
//	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_jikjong_code.InsertRow(0)
//dw_jikjong_code.Object.code.dddw.PercentWidth = 100
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
idw_print = dw_print
///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')
uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 호봉사정표를 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 직종명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.insertrow(0)

DataWindowChild	ldwc_Temp
dw_con.GetChild('jikjong_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
//dw_jikjong_code.InsertRow(0)
dw_con.Object.jikjong_code.dddw.PercentWidth = 100

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

type ln_templeft from w_msheet`ln_templeft within w_hin432p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin432p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin432p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin432p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin432p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin432p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin432p
end type

type uc_insert from w_msheet`uc_insert within w_hin432p
end type

type uc_delete from w_msheet`uc_delete within w_hin432p
end type

type uc_save from w_msheet`uc_save within w_hin432p
end type

type uc_excel from w_msheet`uc_excel within w_hin432p
end type

type uc_print from w_msheet`uc_print within w_hin432p
end type

type st_line1 from w_msheet`st_line1 within w_hin432p
end type

type st_line2 from w_msheet`st_line2 within w_hin432p
end type

type st_line3 from w_msheet`st_line3 within w_hin432p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin432p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin432p
end type

type dw_con from uo_dwfree within w_hin432p
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hin431p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin432p
event destroy ( )
integer x = 1225
integer y = 176
integer taborder = 110
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type dw_print from uo_dwfree within w_hin432p
integer x = 50
integer y = 292
integer width = 4379
integer height = 1964
integer taborder = 60
string dataobject = "d_hin432p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

