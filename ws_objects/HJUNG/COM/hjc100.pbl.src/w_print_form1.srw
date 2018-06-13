$PBExportHeader$w_print_form1.srw
$PBExportComments$예산관리 출력 Form 1(년도, 회계단위, 대체구분, 금액구분)
forward
global type w_print_form1 from w_msheet
end type
type uo_slip_class from cuo_slip_class within w_print_form1
end type
type rb_3 from radiobutton within w_print_form1
end type
type rb_2 from radiobutton within w_print_form1
end type
type rb_1 from radiobutton within w_print_form1
end type
type gb_1 from groupbox within w_print_form1
end type
type uo_bdgt_year from cuo_year within w_print_form1
end type
type gb_3 from groupbox within w_print_form1
end type
type st_back from statictext within w_print_form1
end type
type dw_print from cuo_dwprint within w_print_form1
end type
type dw_con from uo_dwfree within w_print_form1
end type
end forward

global type w_print_form1 from w_msheet
integer height = 2616
string title = "주관부서 접수(주관부서용)"
uo_slip_class uo_slip_class
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
uo_bdgt_year uo_bdgt_year
gb_3 gb_3
st_back st_back
dw_print dw_print
dw_con dw_con
end type
global w_print_form1 w_print_form1

type variables
datawindowchild	idw_child

string	is_bdgt_year					// 요구년도
string	is_bef_bdgt_year				// 전년도
integer	ii_bdgt_class					// 예산구분
integer	ii_acct_class					// 회계단위
string	is_slip_class					// 대체구분
string	is_amt_gubun					// 출력금액 구분
end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_getchild ()
public subroutine wf_button_control ()
end prototypes

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

end subroutine

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
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

end subroutine

on w_print_form1.create
int iCurrent
call super::create
this.uo_slip_class=create uo_slip_class
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.uo_bdgt_year=create uo_bdgt_year
this.gb_3=create gb_3
this.st_back=create st_back
this.dw_print=create dw_print
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_slip_class
this.Control[iCurrent+2]=this.rb_3
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.uo_bdgt_year
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.st_back
this.Control[iCurrent+9]=this.dw_print
this.Control[iCurrent+10]=this.dw_con
end on

on w_print_form1.destroy
call super::destroy
destroy(this.uo_slip_class)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
destroy(this.uo_bdgt_year)
destroy(this.gb_3)
destroy(this.st_back)
destroy(this.dw_print)
destroy(this.dw_con)
end on

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

is_bdgt_year		=	uo_bdgt_year.uf_getyy()
is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)
is_slip_class		=	uo_slip_class.uf_getcode()
is_amt_gubun		=	'1'

st_back.bringtotop = true

wf_button_control()

wf_getchild()

end event

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
//wf_setMsg('조회중')

st_back.bringtotop	=	true

wf_retrieve()

if dw_print.rowcount() > 0	then
	st_back.bringtotop	=	false
end if

//wf_setMsg('')
//f_setpointer('END')
return 1
end event

type ln_templeft from w_msheet`ln_templeft within w_print_form1
end type

type ln_tempright from w_msheet`ln_tempright within w_print_form1
end type

type ln_temptop from w_msheet`ln_temptop within w_print_form1
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_print_form1
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_print_form1
end type

type ln_tempstart from w_msheet`ln_tempstart within w_print_form1
end type

type uc_retrieve from w_msheet`uc_retrieve within w_print_form1
end type

type uc_insert from w_msheet`uc_insert within w_print_form1
end type

type uc_delete from w_msheet`uc_delete within w_print_form1
end type

type uc_save from w_msheet`uc_save within w_print_form1
end type

type uc_excel from w_msheet`uc_excel within w_print_form1
end type

type uc_print from w_msheet`uc_print within w_print_form1
end type

type st_line1 from w_msheet`st_line1 within w_print_form1
end type

type st_line2 from w_msheet`st_line2 within w_print_form1
end type

type st_line3 from w_msheet`st_line3 within w_print_form1
end type

type uc_excelroad from w_msheet`uc_excelroad within w_print_form1
end type

type ln_dwcon from w_msheet`ln_dwcon within w_print_form1
end type

type uo_slip_class from cuo_slip_class within w_print_form1
event destroy ( )
integer x = 887
integer y = 48
integer taborder = 90
boolean bringtotop = true
end type

on uo_slip_class.destroy
call cuo_slip_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;is_slip_class	=	uf_getcode()

end event

type rb_3 from radiobutton within w_print_form1
integer x = 3223
integer y = 88
integer width = 361
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "확정금액"
end type

event clicked;is_amt_gubun	=	'3'

rb_3.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_1.textcolor = rgb(0, 0, 0)

end event

type rb_2 from radiobutton within w_print_form1
integer x = 2725
integer y = 88
integer width = 361
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조정금액"
end type

event clicked;is_amt_gubun	=	'2'

rb_2.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

end event

type rb_1 from radiobutton within w_print_form1
integer x = 2226
integer y = 88
integer width = 361
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
string text = "요구금액"
boolean checked = true
end type

event clicked;is_amt_gubun	=	'1'

rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

end event

type gb_1 from groupbox within w_print_form1
integer x = 1943
integer width = 1938
integer height = 96
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_bdgt_year from cuo_year within w_print_form1
integer x = 96
integer y = 52
integer taborder = 70
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;is_bdgt_year	=	uf_getyy()
is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)

end event

on uo_bdgt_year.destroy
call cuo_year::destroy
end on

type gb_3 from groupbox within w_print_form1
integer width = 1938
integer height = 72
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_back from statictext within w_print_form1
integer x = 55
integer y = 288
integer width = 4379
integer height = 1984
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_print from cuo_dwprint within w_print_form1
integer x = 55
integer y = 288
integer width = 4379
integer height = 1992
integer taborder = 30
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_con from uo_dwfree within w_print_form1
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 50
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
func.of_design_con(dw_con)
This.insertrow(0)
end event

