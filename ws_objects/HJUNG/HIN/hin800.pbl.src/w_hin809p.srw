$PBExportHeader$w_hin809p.srw
$PBExportComments$전문대학 교원급여 및 수업시수 현황
forward
global type w_hin809p from w_msheet
end type
type dw_print from cuo_dwwindow within w_hin809p
end type
type em_yy from editmask within w_hin809p
end type
type st_1 from statictext within w_hin809p
end type
type gb_1 from groupbox within w_hin809p
end type
end forward

global type w_hin809p from w_msheet
string title = "전문대학 교원급여 및 수업시수 현황"
dw_print dw_print
em_yy em_yy
st_1 st_1
gb_1 gb_1
end type
global w_hin809p w_hin809p

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
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
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

on w_hin809p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.em_yy=create em_yy
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.em_yy
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_hin809p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.em_yy)
destroy(this.st_1)
destroy(this.gb_1)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 전문대학 교원급여 및 수업시수 현황을 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
string ls_yy
//wf_setmenu('R',TRUE)         //조회버튼 활성화
//wf_setmenu('P',TRUE)         //조회버튼 활성화s
dw_print.uf_setPreview(True) //옆의 테두리로 출력물 처리로 보이게한다
dw_print.uf_SetClick(False)  //선택 처리 미사용
select to_char(sysdate, 'yyyy') into :ls_yy from dual;
em_yy.text = ls_yy

THIS.Trigger Event ue_retrieve()

////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_open
////	기 능 설 명: 초기화 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
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
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 발령구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_change_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('change_opt',0) = 0 THEN
//	wf_setmsg('공통코드[발령구분]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	Long	ll_InsRow
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code',0)
//	ldwc_Temp.SetItem(ll_InsRow,'fname','')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_change_opt.InsertRow(0)
//dw_change_opt.Object.code.dddw.PercentWidth	= 100
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 조회조건 - 발령기간
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

event ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 조회된 자료를 출력한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
f_print(dw_print)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;string ls_yy
ls_yy = trim(em_yy.TEXT)
if isnull(ls_yy) or len(ls_yy) <> 4 then
	Messagebox("확인","년도를 입력하세요")
	return -1
end if

dw_print.retrieve('숭의여대', ls_yy)


////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_db_retrieve
////	기 능 설 명: 자료조회 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMsg('조회조건 체크 중입니다...')
//////////////////////////////////////////////////////////////////////////////////////
//// 1.1 성명 입력여부 체크
//////////////////////////////////////////////////////////////////////////////////////
//String	ls_KName
//ls_KName = TRIM(uo_member.sle_kname.Text)
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 결재구분 입력여부 체크
//////////////////////////////////////////////////////////////////////////////////////
//String	ls_SignOpt
//ls_SignOpt = TRIM(dw_sign_opt.Object.code[1])
//IF LEN(ls_SignOpt) = 0 OR isNull(ls_SignOpt) OR ls_SignOpt = '0' THEN ls_SignOpt = ''
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 발령구분 입력여부 체크
//////////////////////////////////////////////////////////////////////////////////////
//String	ls_ChangeOpt
//ls_ChangeOpt = TRIM(dw_change_opt.Object.code[1])
//IF LEN(ls_ChangeOpt) = 0 OR isNull(ls_ChangeOpt) OR ls_ChangeOpt = '0' THEN ls_ChangeOpt = ''
//////////////////////////////////////////////////////////////////////////////////////
//// 1.4 발령기간 입력여부 체크
//////////////////////////////////////////////////////////////////////////////////////
//String	ls_FrDate
//em_fr_date.GetData(ls_FrDate)
//ls_FrDate = TRIM(ls_FrDate)
//IF NOT f_isDate(ls_FrDate) THEN
//	MessageBox('확인','발령기간FROM 입력오류입니다.')
//	em_fr_date.SetFocus()
//	RETURN -1
//END IF
//String	ls_ToDate
//em_to_date.GetData(ls_ToDate)
//ls_ToDate = TRIM(ls_ToDate)
//IF NOT f_isDate(ls_ToDate) THEN
//	MessageBox('확인','발령기간TO를 입력오류입니다.')
//	em_to_date.SetFocus()
//	RETURN -1
//END IF
//IF ls_FrDate > ls_ToDate THEN
//	MessageBox('확인','발령기간 오류입니다.')
//	em_to_date.SetFocus()
//	RETURN -1
//END IF
//
//
//SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMsg('조회 처리 중입니다...')
//Long	ll_RowCnt
//dw_print.SetReDraw(FALSE)
//ll_RowCnt = dw_print.Retrieve(ls_KName,ls_SignOpt,ls_ChangeOpt,ls_FrDate,ls_ToDate)
//dw_print.SetReDraw(TRUE)
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 데이타원도우에 출력조건 및 시스템일자 처리
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_UnivName
//ls_UnivName = gstru_uid_uname.univ_name
//
//dw_print.Object.t_campus.Text        = ls_UnivName
//dw_print.Object.t_campus_jang.Text   = ls_UnivName+'장'
//
//
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
/////////////////////////////////////////////////////////////////////////////////////////
//IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('R')
//	wf_SetMsg('해당자료가 존재하지 않습니다.')
//ELSE
//	wf_SetMenuBtn('RP')
//	wf_SetMsg('자료가 조회되었습니다.')
//	dw_print.SetFocus()
//END IF
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////


return 1
end event

event ue_init();call super::ue_init;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_init
////	기 능 설 명: 초기화 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//dw_print.SetReDraw(FALSE)
//dw_print.Reset()
//dw_print.Object.DataWindow.Print.Preview = 'YES'
//dw_print.SetReDraw(TRUE)
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')
//uo_member.sle_kname.SetFocus()
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

type dw_print from cuo_dwwindow within w_hin809p
integer x = 18
integer y = 324
integer width = 3840
integer height = 2280
integer taborder = 80
string dataobject = "d_hin809p_1"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type em_yy from editmask within w_hin809p
integer x = 1147
integer y = 128
integer width = 265
integer height = 76
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXX"
end type

event modified;//parent.postevent('ue_retrieve')
end event

type st_1 from statictext within w_hin809p
integer x = 791
integer y = 144
integer width = 517
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회년도 :"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hin809p
integer x = 14
integer y = 12
integer width = 3845
integer height = 296
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회조건"
borderstyle borderstyle = stylelowered!
end type

