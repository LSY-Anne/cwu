$PBExportHeader$w_hfn_print_form2.srw
$PBExportComments$회계관리 출력 Form 1(기준년도, 회계단위) - 결산출력용
forward
global type w_hfn_print_form2 from w_msheet
end type
type dw_form from datawindow within w_hfn_print_form2
end type
type st_11 from statictext within w_hfn_print_form2
end type
type ddlb_acct_class from dropdownlistbox within w_hfn_print_form2
end type
type uo_slip_class from cuo_slip_class within w_hfn_print_form2
end type
type uo_acct_class from cuo_acct_class within w_hfn_print_form2
end type
type uo_year from cuo_year within w_hfn_print_form2
end type
type dw_print from cuo_dwprint within w_hfn_print_form2
end type
type dw_con from uo_dwfree within w_hfn_print_form2
end type
end forward

global type w_hfn_print_form2 from w_msheet
integer height = 2616
dw_form dw_form
st_11 st_11
ddlb_acct_class ddlb_acct_class
uo_slip_class uo_slip_class
uo_acct_class uo_acct_class
uo_year uo_year
dw_print dw_print
dw_con dw_con
end type
global w_hfn_print_form2 w_hfn_print_form2

type variables
datawindowchild	idw_child

string	is_bdgt_year										// 기준년도
string	is_strdate, is_enddate							// 회계기간
string	is_yearmonth										// 조회년월(전체년:년도 + '99')
string	is_trandate											// 이월(년도 + '0000')
string	is_bef_bdgt_year									// 기준년도(전년도)
string	is_bef_strdate, is_bef_enddate				// 회계기간(전년도)
string	is_bef_yearmonth									// 조회년월(전체년:년도 + '99')(전년도)
string	is_bef_trandate									// 이월(년도 + '0000')(전년도)

string	is_campus_code										// 캠퍼스코드(1)
integer	ii_acct_class										// 회계단위
integer	ii_str_acct_class, ii_end_acct_class		// 회계단위
string	is_slip_class										// 수입/지출

string	is_dept_code										// 학과명
integer	ii_str_jikjong										// 직종명(Start)
integer	ii_end_jikjong										// 직종명(End)

string	is_form_class										// 출력구분(1:합계잔액시산표, 2:운영계산서, 3:대차대조표)
integer	ii_form_class										// 출력구분(1:합계잔액시산표, 2:운영계산서, 3:대차대조표)
end variables

forward prototypes
public function boolean wf_chk_retrieve ()
public subroutine wf_retrieve ()
public subroutine wf_button_control ()
end prototypes

public function boolean wf_chk_retrieve ();// ------------------------------------------------------------------------------------------
// Function Name : wf_chk_retrieve
// Function 설명 : 조회조건을 체크한다.
// Argument      :
// Return        : Boolean
// ------------------------------------------------------------------------------------------

// 조회년도 체크
if (is_bdgt_year = '' or is_bdgt_year = '0000') and uo_year.em_year.enabled = true then
	f_messagebox('1', '기준년도를 입력해 주세요.!')
	setfocus(uo_year.em_year)
	return	false
end if

// 조회년도/년월에 대한 회계기간 구하기
is_strdate = f_getacctyear(is_bdgt_year)

if left(is_strdate, 1) = '1' then return false

is_enddate	= right(is_strdate, 8)
is_strdate	= mid(is_strdate, 2, 8)

is_yearmonth	= is_bdgt_year + '99'
is_trandate		= is_bdgt_year + '0000'

// 조회년도/년월에 대한 전년도 회계기간 구하기
is_bef_bdgt_year = string(integer(is_bdgt_year) - 1)	// 전년도 

is_bef_strdate = f_getacctyear(is_bef_bdgt_year)

if left(is_bef_strdate, 1) = '1' then return false

is_bef_enddate = right(is_bef_strdate, 8)
is_bef_strdate = mid(is_bef_strdate, 2, 8)

is_bef_yearmonth	= is_bef_bdgt_year + '99'
is_bef_trandate	= is_bef_bdgt_year + '0000'

//// 회계단위 체크
//if ii_acct_class = '' and dw_acct.enabled = true then
//	messagebox('확인', '회계단위를 선택해 주세요.!')
//	setfocus(dw_acct)
//	return	false
//end if

return	true
end function

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능	:	Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================


end subroutine

public subroutine wf_button_control ();// ------------------------------------------------------------------------------------------
// Function Name	:	wf_button_control
// Function 설명	:	버튼을 Control 한다.
// Argument			:	
// Return			:	
// ------------------------------------------------------------------------------------------

//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		TRUE)
//
end subroutine

on w_hfn_print_form2.create
int iCurrent
call super::create
this.dw_form=create dw_form
this.st_11=create st_11
this.ddlb_acct_class=create ddlb_acct_class
this.uo_slip_class=create uo_slip_class
this.uo_acct_class=create uo_acct_class
this.uo_year=create uo_year
this.dw_print=create dw_print
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_form
this.Control[iCurrent+2]=this.st_11
this.Control[iCurrent+3]=this.ddlb_acct_class
this.Control[iCurrent+4]=this.uo_slip_class
this.Control[iCurrent+5]=this.uo_acct_class
this.Control[iCurrent+6]=this.uo_year
this.Control[iCurrent+7]=this.dw_print
this.Control[iCurrent+8]=this.dw_con
end on

on w_hfn_print_form2.destroy
call super::destroy
destroy(this.dw_form)
destroy(this.st_11)
destroy(this.ddlb_acct_class)
destroy(this.uo_slip_class)
destroy(this.uo_acct_class)
destroy(this.uo_year)
destroy(this.dw_print)
destroy(this.dw_con)
end on

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

uo_year.st_title.text	=	'기준년도'
is_bdgt_year		=	uo_year.uf_getyy()
is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)
is_slip_class		=	uo_slip_class.uf_getcode()

ddlb_acct_class.selectitem(1)
ii_acct_class	=	0



wf_button_control()

is_campus_code	=	'1'

uo_year.em_year.setfocus()
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF dw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, dw_print)
//
end event

event ue_retrieve;call super::ue_retrieve;wf_retrieve()
return 1






end event

type ln_templeft from w_msheet`ln_templeft within w_hfn_print_form2
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn_print_form2
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn_print_form2
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn_print_form2
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn_print_form2
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn_print_form2
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn_print_form2
end type

type uc_insert from w_msheet`uc_insert within w_hfn_print_form2
end type

type uc_delete from w_msheet`uc_delete within w_hfn_print_form2
end type

type uc_save from w_msheet`uc_save within w_hfn_print_form2
end type

type uc_excel from w_msheet`uc_excel within w_hfn_print_form2
end type

type uc_print from w_msheet`uc_print within w_hfn_print_form2
end type

type st_line1 from w_msheet`st_line1 within w_hfn_print_form2
end type

type st_line2 from w_msheet`st_line2 within w_hfn_print_form2
end type

type st_line3 from w_msheet`st_line3 within w_hfn_print_form2
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn_print_form2
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn_print_form2
end type

type dw_form from datawindow within w_hfn_print_form2
boolean visible = false
integer x = 1422
integer y = 1036
integer width = 987
integer height = 432
integer taborder = 110
string title = "none"
string dataobject = "d_form"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type st_11 from statictext within w_hfn_print_form2
integer x = 1001
integer y = 28
integer width = 297
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "회계단위"
boolean focusrectangle = false
end type

type ddlb_acct_class from dropdownlistbox within w_hfn_print_form2
integer x = 1330
integer y = 8
integer width = 549
integer height = 324
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"0. 합산","1. 법인","2. 교비"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_acct_class	=	index - 1

//parent.triggerevent('ue_retrieve')
end event

type uo_slip_class from cuo_slip_class within w_hfn_print_form2
event destroy ( )
integer x = 2107
integer y = 44
integer taborder = 30
boolean bringtotop = true
end type

on uo_slip_class.destroy
call cuo_slip_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;is_slip_class	=	uf_getcode()

//parent.triggerevent('ue_retrieve')

end event

type uo_acct_class from cuo_acct_class within w_hfn_print_form2
boolean visible = false
integer x = 896
integer y = 24
integer width = 1248
integer taborder = 90
end type

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

if ii_acct_class = 0 then
	ii_str_acct_class	=	0
	ii_end_acct_class	=	9
else
	ii_str_acct_class	=	ii_acct_class
	ii_end_acct_class	=	ii_acct_class
end if

//parent.triggerevent('ue_retrieve')
end event

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

type uo_year from cuo_year within w_hfn_print_form2
integer x = 91
integer y = 12
integer taborder = 90
boolean bringtotop = true
boolean border = false
end type

event constructor;call super::constructor;em_year.text = left(f_today(), 4)

end event

event ue_itemchange;call super::ue_itemchange;is_bdgt_year = uf_getyy()

is_bef_bdgt_year = string(integer(is_bdgt_year) - 1)
end event

on uo_year.destroy
call cuo_year::destroy
end on

type dw_print from cuo_dwprint within w_hfn_print_form2
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type dw_con from uo_dwfree within w_hfn_print_form2
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 180
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)


end event

