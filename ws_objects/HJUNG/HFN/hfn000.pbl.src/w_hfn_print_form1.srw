$PBExportHeader$w_hfn_print_form1.srw
$PBExportComments$회계관리 출력 Form 1(기준년도, 회계단위, 수지구분)
forward
global type w_hfn_print_form1 from w_msheet
end type
type st_1 from statictext within w_hfn_print_form1
end type
type uo_slip_class from cuo_slip_class within w_hfn_print_form1
end type
type uo_acct_class from cuo_acct_class within w_hfn_print_form1
end type
type uo_year from cuo_year within w_hfn_print_form1
end type
type dw_print from cuo_dwprint within w_hfn_print_form1
end type
type st_2 from statictext within w_hfn_print_form1
end type
type dw_con from uo_dwfree within w_hfn_print_form1
end type
end forward

global type w_hfn_print_form1 from w_msheet
integer height = 2616
st_1 st_1
uo_slip_class uo_slip_class
uo_acct_class uo_acct_class
uo_year uo_year
dw_print dw_print
st_2 st_2
dw_con dw_con
end type
global w_hfn_print_form1 w_hfn_print_form1

type variables
datawindowchild	idw_child

integer	ii_acct_class										// 회계단위
integer	ii_str_acct_class, ii_end_acct_class		// 회계단위
string	is_slip_class										// 수입/지출
string	is_bdgt_year										// 기준년도
string	is_bef_bdgt_year									// 직전년도
string	is_dept_code										// 학과명
integer	ii_str_jikjong										// 직종명(Start)
integer	ii_end_jikjong										// 직종명(End)

end variables

forward prototypes
public subroutine wf_button_control ()
public subroutine wf_retrieve ()
end prototypes

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

end subroutine

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

on w_hfn_print_form1.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_slip_class=create uo_slip_class
this.uo_acct_class=create uo_acct_class
this.uo_year=create uo_year
this.dw_print=create dw_print
this.st_2=create st_2
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_slip_class
this.Control[iCurrent+3]=this.uo_acct_class
this.Control[iCurrent+4]=this.uo_year
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_con
end on

on w_hfn_print_form1.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uo_slip_class)
destroy(this.uo_acct_class)
destroy(this.uo_year)
destroy(this.dw_print)
destroy(this.st_2)
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

is_bdgt_year		=	uo_year.uf_getyy()
is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)
is_slip_class		=	uo_slip_class.uf_getcode()


wf_button_control()

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

event ue_retrieve;call super::ue_retrieve;



wf_retrieve()

return 1





end event

type ln_templeft from w_msheet`ln_templeft within w_hfn_print_form1
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn_print_form1
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn_print_form1
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn_print_form1
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn_print_form1
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn_print_form1
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn_print_form1
end type

type uc_insert from w_msheet`uc_insert within w_hfn_print_form1
end type

type uc_delete from w_msheet`uc_delete within w_hfn_print_form1
end type

type uc_save from w_msheet`uc_save within w_hfn_print_form1
end type

type uc_excel from w_msheet`uc_excel within w_hfn_print_form1
end type

type uc_print from w_msheet`uc_print within w_hfn_print_form1
end type

type st_line1 from w_msheet`st_line1 within w_hfn_print_form1
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn_print_form1
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn_print_form1
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn_print_form1
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn_print_form1
end type

type st_1 from statictext within w_hfn_print_form1
integer x = 3209
integer y = 136
integer width = 571
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "   하시기 바랍니다."
boolean focusrectangle = false
end type

type uo_slip_class from cuo_slip_class within w_hfn_print_form1
event destroy ( )
integer x = 2112
integer y = 36
integer taborder = 30
boolean bringtotop = true
long backcolor = 1073741824
end type

on uo_slip_class.destroy
call cuo_slip_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;is_slip_class	=	uf_getcode()

//parent.triggerevent('ue_retrieve')

end event

type uo_acct_class from cuo_acct_class within w_hfn_print_form1
integer x = 937
integer y = 40
integer width = 1248
integer taborder = 90
long backcolor = 1073741824
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

type uo_year from cuo_year within w_hfn_print_form1
integer x = 96
integer y = 40
integer taborder = 90
boolean bringtotop = true
boolean border = false
long backcolor = 1073741824
end type

event constructor;call super::constructor;em_year.text = left(f_today(), 4)

end event

event ue_itemchange;call super::ue_itemchange;is_bdgt_year = uf_getyy()

is_bef_bdgt_year = string(integer(is_bdgt_year) - 1)
end event

on uo_year.destroy
call cuo_year::destroy
end on

type dw_print from cuo_dwprint within w_hfn_print_form1
integer x = 50
integer y = 292
integer width = 4384
integer height = 2024
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_hfn_print_form1
integer x = 3209
integer y = 72
integer width = 571
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "※ 반드시 조회를"
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_hfn_print_form1
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 170
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)


end event

