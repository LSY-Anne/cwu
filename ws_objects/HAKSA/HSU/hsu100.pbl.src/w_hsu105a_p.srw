﻿$PBExportHeader$w_hsu105a_p.srw
$PBExportComments$[청운대]시간표입력-popup
forward
global type w_hsu105a_p from w_popup
end type
type dw_1 from uo_dwfree within w_hsu105a_p
end type
end forward

global type w_hsu105a_p from w_popup
integer width = 3579
integer height = 1968
string title = "과목개설정보"
dw_1 dw_1
end type
global w_hsu105a_p w_hsu105a_p

on w_hsu105a_p.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_hsu105a_p.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;str_parms s_parms
string ls_year, ls_hakgi, ls_gwa, ls_hakyun, ls_ban
int	li_ans

s_parms = Message.PowerObjectParm

ls_year		= s_parms.s[1]
ls_hakgi		= s_parms.s[2]
ls_gwa		= s_parms.s[3]
ls_hakyun	= s_parms.s[4]
ls_ban		= s_parms.s[5]

li_ans = dw_1.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakyun + '%', ls_ban + '%')

if li_ans <= 0 then
	
	messagebox("확인","조회한 자료가 없습니다.")
	close(this)
	return

end if
end event

event ue_ok;call super::ue_ok;close(this)
end event

type p_msg from w_popup`p_msg within w_hsu105a_p
integer y = 1772
end type

type st_msg from w_popup`st_msg within w_hsu105a_p
integer y = 1772
end type

type uc_printpreview from w_popup`uc_printpreview within w_hsu105a_p
end type

type uc_cancel from w_popup`uc_cancel within w_hsu105a_p
end type

type uc_ok from w_popup`uc_ok within w_hsu105a_p
end type

type uc_excelroad from w_popup`uc_excelroad within w_hsu105a_p
end type

type uc_excel from w_popup`uc_excel within w_hsu105a_p
end type

type uc_save from w_popup`uc_save within w_hsu105a_p
end type

type uc_delete from w_popup`uc_delete within w_hsu105a_p
end type

type uc_insert from w_popup`uc_insert within w_hsu105a_p
end type

type uc_retrieve from w_popup`uc_retrieve within w_hsu105a_p
end type

type ln_temptop from w_popup`ln_temptop within w_hsu105a_p
end type

type ln_1 from w_popup`ln_1 within w_hsu105a_p
integer beginy = 1832
integer endy = 1832
end type

type ln_2 from w_popup`ln_2 within w_hsu105a_p
integer endy = 1892
end type

type ln_3 from w_popup`ln_3 within w_hsu105a_p
integer endy = 1892
end type

type r_backline1 from w_popup`r_backline1 within w_hsu105a_p
end type

type r_backline2 from w_popup`r_backline2 within w_hsu105a_p
end type

type r_backline3 from w_popup`r_backline3 within w_hsu105a_p
end type

type uc_print from w_popup`uc_print within w_hsu105a_p
end type

type dw_1 from uo_dwfree within w_hsu105a_p
integer x = 55
integer y = 180
integer width = 3479
integer height = 1580
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsu100a_5_p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event

