$PBExportHeader$w_hfn_cust.srw
$PBExportComments$관리항목에 의한 거래처 조회
forward
global type w_hfn_cust from window
end type
type sle_rsvn_no from singlelineedit within w_hfn_cust
end type
type st_2 from statictext within w_hfn_cust
end type
type sle_cust_name from singlelineedit within w_hfn_cust
end type
type st_1 from statictext within w_hfn_cust
end type
type cb_retrieve from commandbutton within w_hfn_cust
end type
type cb_cancel from commandbutton within w_hfn_cust
end type
type cb_ok from commandbutton within w_hfn_cust
end type
type dw_main from cuo_dwwindow_one_hin within w_hfn_cust
end type
type gb_1 from groupbox within w_hfn_cust
end type
end forward

global type w_hfn_cust from window
integer width = 2432
integer height = 1880
boolean titlebar = true
string title = "거래처 도움말"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
sle_rsvn_no sle_rsvn_no
st_2 st_2
sle_cust_name sle_cust_name
st_1 st_1
cb_retrieve cb_retrieve
cb_cancel cb_cancel
cb_ok cb_ok
dw_main dw_main
gb_1 gb_1
end type
global w_hfn_cust w_hfn_cust

type variables

end variables

event ue_db_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
dw_main.SetReDraw(FALSE)
dw_main.Retrieve(trim(sle_cust_name.text), TRIM(sle_rsvn_no.Text))
dw_main.setfocus()
dw_main.SetReDraw(TRUE)

end event

on w_hfn_cust.create
this.sle_rsvn_no=create sle_rsvn_no
this.st_2=create st_2
this.sle_cust_name=create sle_cust_name
this.st_1=create st_1
this.cb_retrieve=create cb_retrieve
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_main=create dw_main
this.gb_1=create gb_1
this.Control[]={this.sle_rsvn_no,&
this.st_2,&
this.sle_cust_name,&
this.st_1,&
this.cb_retrieve,&
this.cb_cancel,&
this.cb_ok,&
this.dw_main,&
this.gb_1}
end on

on w_hfn_cust.destroy
destroy(this.sle_rsvn_no)
destroy(this.st_2)
destroy(this.sle_cust_name)
destroy(this.st_1)
destroy(this.cb_retrieve)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_main)
destroy(this.gb_1)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: open
//	기 능 설 명: 거래처 정보 도움말
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
datawindowchild	ldw_temp
string				ls_cust_name

ls_cust_name = message.stringparm

sle_cust_name.text = ls_cust_name

f_centerme(this)

this.trigger event ue_db_retrieve()

end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE
end event

type sle_rsvn_no from singlelineedit within w_hfn_cust
integer x = 1541
integer y = 60
integer width = 677
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_hfn_cust
integer x = 1184
integer y = 76
integer width = 462
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "사업자번호"
boolean focusrectangle = false
end type

type sle_cust_name from singlelineedit within w_hfn_cust
integer x = 325
integer y = 60
integer width = 832
integer height = 92
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

type st_1 from statictext within w_hfn_cust
integer x = 55
integer y = 76
integer width = 265
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "거래처명"
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_hfn_cust
boolean visible = false
integer x = 1952
integer y = 188
integer width = 306
integer height = 116
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "조회"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: p_retrieve::clicked
//	기 능 설 명: 조회처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
parent.trigger event ue_db_retrieve()

end event

type cb_cancel from commandbutton within w_hfn_cust
boolean visible = false
integer x = 1952
integer y = 420
integer width = 306
integer height = 116
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "취소"
end type

event clicked;CLOSE(PARENT)
end event

type cb_ok from commandbutton within w_hfn_cust
boolean visible = false
integer x = 1952
integer y = 304
integer width = 306
integer height = 116
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "확인"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_ok::clicked
//	기 능 설 명: 확인
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com
Long			ll_GetRow

IF dw_main.RowCount() = 0 THEN
	MessageBox('확인','자료를 조회 후 사용하시기 바랍니다.')
	return
END IF

ll_GetRow = dw_main.getrow()
IF ll_GetRow = 0 THEN
	MessageBox('확인','자료를 선택 후 사용하시기 바랍니다.')
	return
END IF


lstr_com.ls_item[1] = trim(dw_main.getitemstring(ll_getrow, 'cust_no'))
lstr_com.ls_item[2] = trim(dw_main.getitemstring(ll_getrow, 'cust_name'))
lstr_com.ls_item[3] = trim(string(dw_main.getitemnumber(ll_getrow, 'bank_code')))
lstr_com.ls_item[4] = trim(dw_main.getitemstring(ll_getrow, 'acct_no'))
lstr_com.ls_item[5] = trim(dw_main.getitemstring(ll_getrow, 'depositor'))
lstr_com.ls_item[6] = trim(dw_main.getitemstring(ll_getrow, 'business_no'))


CloseWithReturn(PARENT,lstr_com)

end event

type dw_main from cuo_dwwindow_one_hin within w_hfn_cust
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 212
integer width = 2377
integer height = 1560
integer taborder = 20
string dataobject = "d_hfn_cust"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_dwnkey;IF KeyDown(KeyEnter!) THEN
	cb_ok.trigger event clicked()
END IF
end event

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

event doubleclicked;call super::doubleclicked;if row = 0 then return

cb_ok.trigger event clicked()

end event

type gb_1 from groupbox within w_hfn_cust
integer x = 14
integer width = 2377
integer height = 192
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

