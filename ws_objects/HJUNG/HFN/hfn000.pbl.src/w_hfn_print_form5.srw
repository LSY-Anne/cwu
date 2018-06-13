$PBExportHeader$w_hfn_print_form5.srw
$PBExportComments$회계관리 출력 Form 5(회계단위)
forward
global type w_hfn_print_form5 from w_msheet
end type
type st_2 from statictext within w_hfn_print_form5
end type
type uo_acct_class from cuo_acct_class within w_hfn_print_form5
end type
type dw_print from cuo_dwprint within w_hfn_print_form5
end type
type dw_con from uo_dwfree within w_hfn_print_form5
end type
end forward

global type w_hfn_print_form5 from w_msheet
integer height = 2616
st_2 st_2
uo_acct_class uo_acct_class
dw_print dw_print
dw_con dw_con
end type
global w_hfn_print_form5 w_hfn_print_form5

type variables
datawindowchild	idw_child

integer	ii_acct_class										// 회계단위
integer	ii_str_acct_class, ii_end_acct_class		// 회계단위
string	is_str_date, is_end_date                  // 기준일자(From/To)
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

on w_hfn_print_form5.create
int iCurrent
call super::create
this.st_2=create st_2
this.uo_acct_class=create uo_acct_class
this.dw_print=create dw_print
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.uo_acct_class
this.Control[iCurrent+3]=this.dw_print
this.Control[iCurrent+4]=this.dw_con
end on

on w_hfn_print_form5.destroy
call super::destroy
destroy(this.st_2)
destroy(this.uo_acct_class)
destroy(this.dw_print)
destroy(this.dw_con)
end on

event ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================



wf_button_control()

uo_acct_class.dw_commcode.setfocus()
end event

event ue_print;call super::ue_print;//IF dw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, dw_print)
//
end event

event ue_retrieve;call super::ue_retrieve;
wf_retrieve()
return 1
end event

type ln_templeft from w_msheet`ln_templeft within w_hfn_print_form5
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn_print_form5
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn_print_form5
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn_print_form5
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn_print_form5
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn_print_form5
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn_print_form5
end type

type uc_insert from w_msheet`uc_insert within w_hfn_print_form5
end type

type uc_delete from w_msheet`uc_delete within w_hfn_print_form5
end type

type uc_save from w_msheet`uc_save within w_hfn_print_form5
end type

type uc_excel from w_msheet`uc_excel within w_hfn_print_form5
end type

type uc_print from w_msheet`uc_print within w_hfn_print_form5
end type

type st_line1 from w_msheet`st_line1 within w_hfn_print_form5
end type

type st_line2 from w_msheet`st_line2 within w_hfn_print_form5
end type

type st_line3 from w_msheet`st_line3 within w_hfn_print_form5
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn_print_form5
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn_print_form5
end type

type st_2 from statictext within w_hfn_print_form5
integer x = 2930
integer y = 104
integer width = 919
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "※ 반드시 조회를 하시기 바랍니다."
boolean focusrectangle = false
end type

type uo_acct_class from cuo_acct_class within w_hfn_print_form5
integer x = 169
integer y = 24
integer width = 1047
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

type dw_print from cuo_dwprint within w_hfn_print_form5
integer x = 50
integer y = 296
integer width = 4384
integer height = 1996
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type dw_con from uo_dwfree within w_hfn_print_form5
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

