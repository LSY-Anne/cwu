$PBExportHeader$w_hin806p.srw
$PBExportComments$전임교원 승진 현황
forward
global type w_hin806p from w_msheet
end type
type st_3 from statictext within w_hin806p
end type
type dw_print from cuo_dwwindow_one_hin within w_hin806p
end type
type ddlb_date from dropdownlistbox within w_hin806p
end type
type em_year from editmask within w_hin806p
end type
type gb_1 from groupbox within w_hin806p
end type
end forward

global type w_hin806p from w_msheet
string title = "정기승진대상자출력"
event type boolean ue_chk_condition ( )
st_3 st_3
dw_print dw_print
ddlb_date ddlb_date
em_year em_year
gb_1 gb_1
end type
global w_hin806p w_hin806p

type variables
String	is_JikJongCode		//직종구분
String	is_AnnounceDate	//기준일자
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

event ue_chk_condition;//////////////////////////////////////////////////////////////////////////////////////////
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
//is_JikJongCode = MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 기준일자 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_Year
em_year.GetData(ls_Year)
ls_Year = TRIM(ls_Year)
IF LEN(ls_Year) = 0 OR isNull(ls_Year) THEN
	MessageBox('확인','기준년도를 입력하시기 바랍니다.')
	em_year.SetFocus()
	RETURN FALSE
END IF
String	ls_Date
String	ls_DateGb
ls_DateGb = MID(ddlb_date.Text,1,1)	//1. 04월01일
ls_Date   = MID(ddlb_date.Text,4)
IF LEN(ls_Year) = 0 OR isNull(ls_Year) THEN
	MessageBox('확인','기준일자를 선택하시기 바랍니다.')
	ddlb_date.SetFocus()
	RETURN FALSE
END IF
/////////////////////////////////////////////////////////////////////////////////
// 1.2.1 기준일자에서 숫자만을 가지고 온다(예 : 04월01일 -> 0401)
/////////////////////////////////////////////////////////////////////////////////
Long		ll_idx
Long		ll_Len
String	ls_Tmp
String	ls_Rtn
ll_Len = LEN(ls_Date)
FOR ll_idx = 1 TO ll_Len
	ls_Tmp = MID(ls_Date,ll_idx,1)
	IF Pos('1234567890',ls_Tmp) = 0 THEN CONTINUE
	ls_Rtn = ls_Rtn + ls_Tmp
NEXT
is_AnnounceDate = ls_Year + ls_Rtn

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

on w_hin806p.create
int iCurrent
call super::create
this.st_3=create st_3
this.dw_print=create dw_print
this.ddlb_date=create ddlb_date
this.em_year=create em_year
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_print
this.Control[iCurrent+3]=this.ddlb_date
this.Control[iCurrent+4]=this.em_year
this.Control[iCurrent+5]=this.gb_1
end on

on w_hin806p.destroy
call super::destroy
destroy(this.st_3)
destroy(this.dw_print)
destroy(this.ddlb_date)
destroy(this.em_year)
destroy(this.gb_1)
end on

event ue_retrieve;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_db_retrieve
////	기 능 설 명: 자료조회 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN -1
//
SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
string ls_day, ls_day1, ls_yy, ls_dddmm
ls_yy   = trim(em_year.text)
if isnull(ls_yy) or len(ls_yy) <> 4 then
	Messagebox("확인","기준일자를 입력하세요")
	return -1
end if

ls_dddmm = mid(ddlb_date.text, 4, 2) + mid(ddlb_date.text, 8, 2)
ls_day = ls_yy + ls_dddmm

dw_print.SetReDraw(FALSE)

ll_RowCnt = dw_print.retrieve('숭의여대', ls_day)

dw_print.SetReDraw(TRUE)
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 데이타원도우에 출력조건 및 시스템일자 처리
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_UnivName
//ls_UnivName = gstru_uid_uname.univ_name
//dw_print.Object.t_campus.Text        = ls_UnivName
//dw_print.Object.t_jikjong_code.Text  = MID(ddlb_gubn.Text,4)
//dw_print.Object.t_announce_date.Text = String(is_AnnounceDate,'@@@@/@@/@@')
//
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
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
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_print;f_print(dw_print)
end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 전임교원 승진 현황을 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
//wf_setmenu('R',TRUE)         //조회버튼 활성화
//wf_setmenu('P',TRUE)         //조회버튼 활성화s
////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_open
////	기 능 설 명: 오픈시 처리사항 기술
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 직종구분
//////////////////////////////////////////////////////////////////////////////////////
//ddlb_gubn.Selectitem(1)
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 기준일자
//////////////////////////////////////////////////////////////////////////////////////
em_year.Text = MID(f_today(),1,4)
ddlb_date.Selectitem(1)
THIS.Trigger Event ue_retrieve()

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

event ue_init;call super::ue_init;////////////////////////////////////////////////////////////////////////////////////////////
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
//ddlb_date.SetFocus()
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin806p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin806p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin806p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin806p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin806p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin806p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin806p
end type

type uc_insert from w_msheet`uc_insert within w_hin806p
end type

type uc_delete from w_msheet`uc_delete within w_hin806p
end type

type uc_save from w_msheet`uc_save within w_hin806p
end type

type uc_excel from w_msheet`uc_excel within w_hin806p
end type

type uc_print from w_msheet`uc_print within w_hin806p
end type

type st_line1 from w_msheet`st_line1 within w_hin806p
end type

type st_line2 from w_msheet`st_line2 within w_hin806p
end type

type st_line3 from w_msheet`st_line3 within w_hin806p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin806p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin806p
end type

type st_3 from statictext within w_hin806p
integer x = 352
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
string text = "기준일자"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_print from cuo_dwwindow_one_hin within w_hin806p
integer x = 14
integer y = 252
integer width = 3845
integer height = 2348
integer taborder = 50
string dataobject = "d_hin806p_1"
end type

type ddlb_date from dropdownlistbox within w_hin806p
integer x = 805
integer y = 100
integer width = 480
integer height = 324
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"1. 04월01일","2. 10월01일"}
borderstyle borderstyle = stylelowered!
end type

type em_year from editmask within w_hin806p
integer x = 631
integer y = 100
integer width = 169
integer height = 84
integer taborder = 30
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
string mask = "####"
boolean autoskip = true
end type

event modified;parent.postevent('ue_retrieve')
end event

type gb_1 from groupbox within w_hin806p
integer x = 14
integer y = 12
integer width = 3845
integer height = 228
integer taborder = 10
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

