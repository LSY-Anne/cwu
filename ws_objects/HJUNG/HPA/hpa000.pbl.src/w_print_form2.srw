$PBExportHeader$w_print_form2.srw
$PBExportComments$급여관리 출력 Form 2(기준년월, 학과명, 직종명)
forward
global type w_print_form2 from w_msheet
end type
type st_back from statictext within w_print_form2
end type
type dw_print from cuo_dwprint within w_print_form2
end type
type st_1 from statictext within w_print_form2
end type
type dw_head from datawindow within w_print_form2
end type
type uo_yearmonth from cuo_yearmonth within w_print_form2
end type
type uo_dept_code from cuo_dept within w_print_form2
end type
type st_2 from statictext within w_print_form2
end type
type st_3 from statictext within w_print_form2
end type
type st_con from statictext within w_print_form2
end type
type dw_con from uo_dwfree within w_print_form2
end type
end forward

global type w_print_form2 from w_msheet
st_back st_back
dw_print dw_print
st_1 st_1
dw_head dw_head
uo_yearmonth uo_yearmonth
uo_dept_code uo_dept_code
st_2 st_2
st_3 st_3
st_con st_con
dw_con dw_con
end type
global w_print_form2 w_print_form2

type variables
datawindowchild	idw_child

string	is_yearmonth					// 기준년월
string	is_dept_code					// 학과명
integer	ii_str_jikjong					// 직종명(Start)
integer	ii_end_jikjong					// 직종명(End)

end variables

forward prototypes
public subroutine wf_button_control ()
end prototypes

public subroutine wf_button_control ();//// ==========================================================================================
//// 기    능 : 	버튼을 Control 한다.
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 함수원형 : 	wf_button_control()
//// 인    수 :
//// 되 돌 림 :
//// 주의사항 :
//// 수정사항 :
//// ==========================================================================================
//
//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		TRUE)
//
end subroutine

on w_print_form2.create
int iCurrent
call super::create
this.st_back=create st_back
this.dw_print=create dw_print
this.st_1=create st_1
this.dw_head=create dw_head
this.uo_yearmonth=create uo_yearmonth
this.uo_dept_code=create uo_dept_code
this.st_2=create st_2
this.st_3=create st_3
this.st_con=create st_con
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_back
this.Control[iCurrent+2]=this.dw_print
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_head
this.Control[iCurrent+5]=this.uo_yearmonth
this.Control[iCurrent+6]=this.uo_dept_code
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_con
this.Control[iCurrent+10]=this.dw_con
end on

on w_print_form2.destroy
call super::destroy
destroy(this.st_back)
destroy(this.dw_print)
destroy(this.st_1)
destroy(this.dw_head)
destroy(this.uo_yearmonth)
destroy(this.uo_dept_code)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_con)
destroy(this.dw_con)
end on

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

uo_dept_code.uf_setdept('', '소속명')
is_dept_code	=	uo_dept_code.uf_getcode()

f_getdwcommon2(dw_head, 'jikjong_code', 0, 'code', 750, 100)

st_back.bringtotop = true

wf_button_control()

uo_yearmonth.em_yearmonth.setfocus()
end event

type ln_templeft from w_msheet`ln_templeft within w_print_form2
end type

type ln_tempright from w_msheet`ln_tempright within w_print_form2
end type

type ln_temptop from w_msheet`ln_temptop within w_print_form2
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_print_form2
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_print_form2
end type

type ln_tempstart from w_msheet`ln_tempstart within w_print_form2
end type

type uc_retrieve from w_msheet`uc_retrieve within w_print_form2
end type

type uc_insert from w_msheet`uc_insert within w_print_form2
end type

type uc_delete from w_msheet`uc_delete within w_print_form2
end type

type uc_save from w_msheet`uc_save within w_print_form2
end type

type uc_excel from w_msheet`uc_excel within w_print_form2
end type

type uc_print from w_msheet`uc_print within w_print_form2
end type

type st_line1 from w_msheet`st_line1 within w_print_form2
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_msheet`st_line2 within w_print_form2
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_msheet`st_line3 within w_print_form2
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_msheet`uc_excelroad within w_print_form2
end type

type ln_dwcon from w_msheet`ln_dwcon within w_print_form2
end type

type st_back from statictext within w_print_form2
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_print from cuo_dwprint within w_print_form2
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_print_form2
integer x = 2222
integer y = 196
integer width = 206
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "직종명"
boolean focusrectangle = false
end type

type dw_head from datawindow within w_print_form2
integer x = 2455
integer y = 180
integer width = 690
integer height = 84
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) or trim(data) = '0' or trim(data) = '' then	
	ii_str_jikjong	=	0
	ii_end_jikjong	=	9
else
	ii_str_jikjong = integer(trim(data))
	ii_end_jikjong = integer(trim(data))
end if



end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type uo_yearmonth from cuo_yearmonth within w_print_form2
integer x = 119
integer y = 180
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;is_yearmonth	=	uf_getyearmonth()

//parent.triggerevent('ue_retrieve')

end event

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

type uo_dept_code from cuo_dept within w_print_form2
end type

on uo_dept_code.destroy
call cuo_dept::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_dept_code = uf_getcode()

//parent.triggerevent('ue_retrieve')
end event

type st_2 from statictext within w_print_form2
integer x = 3301
integer y = 168
integer width = 521
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 반드시 조회를 "
boolean focusrectangle = false
end type

type st_3 from statictext within w_print_form2
integer x = 3301
integer y = 220
integer width = 549
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "   하시기 바랍니다."
boolean focusrectangle = false
end type

type st_con from statictext within w_print_form2
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
boolean focusrectangle = false
end type

type dw_con from uo_dwfree within w_print_form2
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 40
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
func.of_design_con(dw_con)
This.insertrow(0)
end event

