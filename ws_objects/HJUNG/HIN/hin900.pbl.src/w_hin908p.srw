$PBExportHeader$w_hin908p.srw
$PBExportComments$직원표창수상자현황
forward
global type w_hin908p from w_msheet
end type
type dw_con from uo_dwfree within w_hin908p
end type
type dw_print from uo_dwfree within w_hin908p
end type
end forward

global type w_hin908p from w_msheet
string title = "직원표창수상자현황"
event type boolean ue_chk_condition ( )
dw_con dw_con
dw_print dw_print
end type
global w_hin908p w_hin908p

type variables
String	is_PrizeCode	//포상코드
String	is_FrDate		//포상기간
String	is_ToDate		//포상기간
String	is_JikJongGb	//교직원구분

end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

event type boolean ue_chk_condition();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_chk_condition
//	기 능 설 명: 조회조건체크처리
//	작성/수정자: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
dw_con.accepttext()

////////////////////////////////////////////////////////////////////////////////////
// 1.1 포상명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_PrizeCode = TRIM(dw_con.Object.prize_code[1])
IF isNull(is_PrizeCode) OR is_PrizeCode = '0' THEN is_PrizeCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.2 포상기간 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
//em_fr_date.GetData(is_FrDate)
is_FrDate = dw_con.object.fr_date[1] //TRIM(is_FrDate)
IF NOT f_isDate(is_FrDate) THEN
	MessageBox('확인','포상기간FROM 입력오류입니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('fr_date')
	RETURN FALSE
END IF
//em_to_date.GetData(is_ToDate)
is_ToDate = dw_con.object.to_date[1]  //TRIM(is_ToDate)
IF NOT f_isDate(is_ToDate) THEN
	MessageBox('확인','포상기간TO를 입력오류입니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('to_date')
	RETURN FALSE
END IF
IF is_FrDate > is_ToDate THEN
	MessageBox('확인','포상기간 오류입니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('to_date')
	RETURN FALSE
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.3 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_JikJongGb = dw_con.object.gubn[1]//MID(ddlb_gubn.Text,1,1)

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

on w_hin908p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_print
end on

on w_hin908p.destroy
call super::destroy
destroy(this.dw_con)
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
ll_RowCnt = dw_print.Retrieve(is_PrizeCode,is_FrDate,is_ToDate,is_JikJongGb)
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UnivName
ls_UnivName = GF_GLOBAL_VALUE(2)// gstru_uid_uname.univ_name
dw_print.Object.t_prize_date.Text = String(is_FrDate,'@@@@/@@/@@') + ' ∼ ' + &
												String(is_ToDate,'@@@@/@@/@@')

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

event ue_print;call super::ue_print;//f_print(dw_print)
end event

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 직원표창 수상자 현황을 출력한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 포상명
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//dw_prize_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('prize_code',0) = 0 THEN
//	wf_setmsg('공통코드[상벌]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	Long	ll_InsRow
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code',0)
//	ldwc_Temp.SetItem(ll_InsRow,'fname','')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_prize_code.InsertRow(0)
//dw_prize_code.Object.code.dddw.PercentWidth	= 150
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 포상기간
//////////////////////////////////////////////////////////////////////////////////////
//em_fr_date.Text = f_today()
//em_to_date.Text = f_lastdate(f_today())
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
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 직원표창 수상자 현황을 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 포상명
////////////////////////////////////////////////////////////////////////////////////


DataWindowChild	ldwc_Temp
dw_con.GetChild('prize_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('prize_code',0) = 0 THEN
	wf_setmsg('공통코드[상벌]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	Long	ll_InsRow
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_prize_code.InsertRow(0)
dw_con.Object.prize_code.dddw.PercentWidth	= 150
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 포상기간
////////////////////////////////////////////////////////////////////////////////////
//em_fr_date.Text = f_today()
dw_con.object.fr_date[1] = f_today()
//em_to_date.Text = f_lastdate(f_today())
dw_con.object.to_date[1] = f_lastdate(f_today())
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

type ln_templeft from w_msheet`ln_templeft within w_hin908p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin908p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin908p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin908p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin908p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin908p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin908p
end type

type uc_insert from w_msheet`uc_insert within w_hin908p
end type

type uc_delete from w_msheet`uc_delete within w_hin908p
end type

type uc_save from w_msheet`uc_save within w_hin908p
end type

type uc_excel from w_msheet`uc_excel within w_hin908p
end type

type uc_print from w_msheet`uc_print within w_hin908p
end type

type st_line1 from w_msheet`st_line1 within w_hin908p
end type

type st_line2 from w_msheet`st_line2 within w_hin908p
end type

type st_line3 from w_msheet`st_line3 within w_hin908p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin908p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin908p
end type

type dw_con from uo_dwfree within w_hin908p
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hin908p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
this.insertrow(0)
//////////////////////////////////////////////////////////////////////////////////////////
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
ls_UserID = gs_empcode //TRIM(gstru_uid_uname.uid)			//로그인사번
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

This.object.gubn[1] = string(li_JikJongCode)
//THIS.SelectItem(li_JikJongCode)
If lb_Groupchk = FALSE  Then 
	This.object.gubn.protect = 1
Else
	This.object.gubn.protect = 0
eND iF
//THIS.Enabled = lb_GroupChk

//uo_member.is_JikJongCode = String(li_JikJongCode)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type dw_print from uo_dwfree within w_hin908p
integer x = 50
integer y = 292
integer width = 4379
integer height = 1964
integer taborder = 50
string dataobject = "d_hin908p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

