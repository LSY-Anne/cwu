$PBExportHeader$w_dhwhj407q_p.srw
$PBExportComments$[대학원학적] 영문성명입력
forward
global type w_dhwhj407q_p from w_popup
end type
type st_1 from statictext within w_dhwhj407q_p
end type
type sle_1 from singlelineedit within w_dhwhj407q_p
end type
type dw_1 from uo_dwfree within w_dhwhj407q_p
end type
end forward

global type w_dhwhj407q_p from w_popup
integer width = 2811
integer height = 1012
string title = "주소입력"
st_1 st_1
sle_1 sle_1
dw_1 dw_1
end type
global w_dhwhj407q_p w_dhwhj407q_p

on w_dhwhj407q_p.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_dhwhj407q_p.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.dw_1)
end on

event open;call super::open;string	ls_parm, ls_year, ls_hakgi
int	li_row

idw_update[1] = dw_1

ls_parm = Message.StringParm

ls_year	=	mid(ls_parm, 1, 4)
ls_hakgi	=	mid(ls_parm, 5, 1)

li_row = dw_1.retrieve(ls_year, ls_hakgi)

if li_row <= 0 then
	dw_1.insertrow(0)
	
end if
end event

event ue_inquiry;call super::ue_inquiry;string ls_hakbun
int li_ans

ls_hakbun = sle_1.text

li_ans = dw_1.retrieve(ls_hakbun)

if li_ans <= 0 then
	messagebox("확인","자료가 존재하지 않습니다.")
	sle_1.text = ''
	sle_1.setfocus()
end if

Return 1
end event

type p_msg from w_popup`p_msg within w_dhwhj407q_p
integer y = 804
end type

type st_msg from w_popup`st_msg within w_dhwhj407q_p
integer y = 804
integer width = 2601
end type

type uc_printpreview from w_popup`uc_printpreview within w_dhwhj407q_p
end type

type uc_cancel from w_popup`uc_cancel within w_dhwhj407q_p
end type

type uc_ok from w_popup`uc_ok within w_dhwhj407q_p
end type

type uc_excelroad from w_popup`uc_excelroad within w_dhwhj407q_p
end type

type uc_excel from w_popup`uc_excel within w_dhwhj407q_p
end type

type uc_save from w_popup`uc_save within w_dhwhj407q_p
end type

type uc_delete from w_popup`uc_delete within w_dhwhj407q_p
end type

type uc_insert from w_popup`uc_insert within w_dhwhj407q_p
end type

type uc_retrieve from w_popup`uc_retrieve within w_dhwhj407q_p
end type

type ln_temptop from w_popup`ln_temptop within w_dhwhj407q_p
integer endx = 2793
end type

type ln_1 from w_popup`ln_1 within w_dhwhj407q_p
integer beginy = 864
integer endx = 2793
integer endy = 864
end type

type ln_2 from w_popup`ln_2 within w_dhwhj407q_p
integer endy = 924
end type

type ln_3 from w_popup`ln_3 within w_dhwhj407q_p
integer beginx = 2747
integer beginy = 4
integer endx = 2747
integer endy = 928
end type

type r_backline1 from w_popup`r_backline1 within w_dhwhj407q_p
end type

type r_backline2 from w_popup`r_backline2 within w_dhwhj407q_p
end type

type r_backline3 from w_popup`r_backline3 within w_dhwhj407q_p
end type

type uc_print from w_popup`uc_print within w_dhwhj407q_p
end type

type st_1 from statictext within w_dhwhj407q_p
integer x = 128
integer y = 212
integer width = 201
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "학 번"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_dhwhj407q_p
integer x = 334
integer y = 204
integer width = 425
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;Parent.Event ue_inquiry()
end event

event getfocus;f_pro_toggle('E', Handle(THIS)) 
end event

type dw_1 from uo_dwfree within w_dhwhj407q_p
integer x = 82
integer y = 324
integer width = 2583
integer height = 464
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dhwhj407q_p1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)

func.of_design_dw(dw_1)
end event

