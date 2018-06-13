$PBExportHeader$w_hfn_hst_help.srw
$PBExportComments$자재/장비/노임에 대한 결의서 조회
forward
global type w_hfn_hst_help from window
end type
type cb_cancel from u_picture within w_hfn_hst_help
end type
type cb_ok from u_picture within w_hfn_hst_help
end type
type cb_retrieve from u_picture within w_hfn_hst_help
end type
type dw_main from uo_dwgrid within w_hfn_hst_help
end type
type em_to_date from editmask within w_hfn_hst_help
end type
type st_2 from statictext within w_hfn_hst_help
end type
type em_from_date from editmask within w_hfn_hst_help
end type
type st_1 from statictext within w_hfn_hst_help
end type
type gb_1 from groupbox within w_hfn_hst_help
end type
end forward

global type w_hfn_hst_help from window
integer width = 3511
integer height = 1880
boolean titlebar = true
string title = "결의서내역 조회"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
cb_cancel cb_cancel
cb_ok cb_ok
cb_retrieve cb_retrieve
dw_main dw_main
em_to_date em_to_date
st_2 st_2
em_from_date em_from_date
st_1 st_1
gb_1 gb_1
end type
global w_hfn_hst_help w_hfn_hst_help

type variables

end variables

event ue_db_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
string	ls_from_date, ls_to_date
date		ld_date

if not isdate(em_from_date.text) then
	messagebox('확인', '결의기간(From)를 올바르게 입력하시기 바랍니다.')
	em_from_date.setfocus()
	return
end if

if not isdate(em_to_date.text) then
	messagebox('확인', '결의기간(To)를 올바르게 입력하시기 바랍니다.')
	em_to_date.setfocus()
	return
end if

if em_from_date.text > em_to_date.text then
	messagebox('확인', '결의기간의 범위가 올바르지 않습니다.')
	em_to_date.setfocus()
	return
end if

em_from_date.getdata(ld_date)
ls_from_date = string(ld_date, 'yyyymmdd')
em_to_date.getdata(ld_date)
ls_to_date = string(ld_date, 'yyyymmdd')

SetPointer(HourGlass!)
dw_main.SetReDraw(FALSE)
dw_main.Retrieve(ls_from_date, ls_to_date, gstru_uid_uname.uid)
dw_main.setfocus()
dw_main.SetReDraw(TRUE)

end event

on w_hfn_hst_help.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_retrieve=create cb_retrieve
this.dw_main=create dw_main
this.em_to_date=create em_to_date
this.st_2=create st_2
this.em_from_date=create em_from_date
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.cb_retrieve,&
this.dw_main,&
this.em_to_date,&
this.st_2,&
this.em_from_date,&
this.st_1,&
this.gb_1}
end on

on w_hfn_hst_help.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_retrieve)
destroy(this.dw_main)
destroy(this.em_to_date)
destroy(this.st_2)
destroy(this.em_from_date)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: open
//	기 능 설 명: 결의서 도움말
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
f_centerme(this)

string	ls_sys_date

ls_sys_date = f_today()

em_from_date.text = string(ls_sys_date, '@@@@/@@') + '/01'
em_to_date.text   = string(ls_sys_date, '@@@@/@@/@@')

end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE
end event

type cb_cancel from u_picture within w_hfn_hst_help
integer x = 3182
integer y = 80
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_cancel.gif"
end type

event clicked;call super::clicked;CLOSE(PARENT)
end event

type cb_ok from u_picture within w_hfn_hst_help
integer x = 2894
integer y = 80
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_ok.gif"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_ok::clicked
//	기 능 설 명: 확인
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
IF dw_main.RowCount() = 0 THEN
	MessageBox('확인','자료를 조회 후 사용하시기 바랍니다.')
	return
END IF

Long		ll_GetRow

ll_GetRow = dw_main.getrow()

IF ll_GetRow = 0 THEN
	MessageBox('확인','자료를 선택 후 사용하시기 바랍니다.')
	return
END IF

s_insa_com	lstr_com

lstr_com.ls_item[1]  = dw_main.getitemstring(ll_getrow, 'resol_date')				// 결의일자
lstr_com.ls_item[2]  = dw_main.getitemstring(ll_getrow, 'remark')						// 적요
lstr_com.ls_item[3]  = string(dw_main.getitemnumber(ll_getrow, 'resol_amt'))		// 결의금액
lstr_com.ls_item[4]  = dw_main.getitemstring(ll_getrow, 'cust_name')					// 거래처

CloseWithReturn(PARENT,lstr_com)

end event

type cb_retrieve from u_picture within w_hfn_hst_help
integer x = 2606
integer y = 80
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_retrieve.gif"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: p_retrieve::clicked
//	기 능 설 명: 조회처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
parent.trigger event ue_db_retrieve()

end event

type dw_main from uo_dwgrid within w_hfn_hst_help
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 212
integer width = 3470
integer height = 1532
integer taborder = 80
string dataobject = "d_hfn_hst_help"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_dwnkey;IF KeyDown(KeyEnter!) THEN
	cb_ok.trigger event clicked()
END IF
end event

event doubleclicked;call super::doubleclicked;if row = 0 then return

cb_ok.trigger event clicked()

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type em_to_date from editmask within w_hfn_hst_help
integer x = 905
integer y = 80
integer width = 457
integer height = 80
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
boolean spin = true
end type

type st_2 from statictext within w_hfn_hst_help
integer x = 791
integer y = 92
integer width = 105
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_from_date from editmask within w_hfn_hst_help
integer x = 329
integer y = 80
integer width = 457
integer height = 80
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
boolean spin = true
end type

type st_1 from statictext within w_hfn_hst_help
integer x = 46
integer y = 92
integer width = 274
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "결의기간"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hfn_hst_help
integer x = 14
integer y = 12
integer width = 3470
integer height = 196
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

