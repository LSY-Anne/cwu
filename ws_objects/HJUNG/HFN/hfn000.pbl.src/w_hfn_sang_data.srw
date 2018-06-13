$PBExportHeader$w_hfn_sang_data.srw
$PBExportComments$관리항목에 의한 상계Data 조회
forward
global type w_hfn_sang_data from window
end type
type cbx_1 from checkbox within w_hfn_sang_data
end type
type cb_retrieve from commandbutton within w_hfn_sang_data
end type
type cb_cancel from commandbutton within w_hfn_sang_data
end type
type cb_ok from commandbutton within w_hfn_sang_data
end type
type dw_main from cuo_dwwindow_one_hin within w_hfn_sang_data
end type
end forward

global type w_hfn_sang_data from window
integer width = 4146
integer height = 1964
boolean titlebar = true
string title = "미결Data 도움말"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
cbx_1 cbx_1
cb_retrieve cb_retrieve
cb_cancel cb_cancel
cb_ok cb_ok
dw_main dw_main
end type
global w_hfn_sang_data w_hfn_sang_data

type variables
integer	ii_acct_class
string	is_acct_code

end variables

event ue_db_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
dw_main.SetReDraw(FALSE)
dw_main.Retrieve(ii_acct_class, is_acct_code)
dw_main.setfocus()
dw_main.SetReDraw(TRUE)

end event

on w_hfn_sang_data.create
this.cbx_1=create cbx_1
this.cb_retrieve=create cb_retrieve
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_main=create dw_main
this.Control[]={this.cbx_1,&
this.cb_retrieve,&
this.cb_cancel,&
this.cb_ok,&
this.dw_main}
end on

on w_hfn_sang_data.destroy
destroy(this.cbx_1)
destroy(this.cb_retrieve)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_main)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: open
//	기 능 설 명: 거래처 정보 도움말
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com

f_centerme(this)

lstr_com = Message.PowerObjectParm

if not isvalid(lstr_com) then close(this)

ii_acct_class = integer(lstr_com.ls_item[1])
is_acct_code  = lstr_com.ls_item[2]

this.trigger event ue_db_retrieve()

end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE
end event

type cbx_1 from checkbox within w_hfn_sang_data
integer x = 3077
integer y = 28
integer width = 1024
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "새로운 미결자료 관리Data 보기"
end type

event clicked;if this.checked then
	dw_main.dataobject = 'd_hfn_sang_data_new'
else
	dw_main.dataobject = 'd_hfn_sang_data'
end if

dw_main.settransobject(sqlca)

parent.trigger event ue_db_retrieve()

end event

type cb_retrieve from commandbutton within w_hfn_sang_data
boolean visible = false
integer x = 2034
integer y = 16
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

type cb_cancel from commandbutton within w_hfn_sang_data
boolean visible = false
integer x = 2034
integer y = 248
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

type cb_ok from commandbutton within w_hfn_sang_data
boolean visible = false
integer x = 2034
integer y = 132
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

lstr_com.ls_item[1] = trim(dw_main.getitemstring(ll_getrow, 'mana_data'))
lstr_com.ls_item[2] = trim(f_mana_data_name_proc(dw_main.getitemnumber(ll_getrow, 'mana_code'), dw_main.getitemstring(ll_getrow, 'mana_data')))
lstr_com.ls_item[3] = string(dw_main.getitemnumber(ll_getrow, 'com_jan_amt'))

CloseWithReturn(PARENT,lstr_com)

end event

type dw_main from cuo_dwwindow_one_hin within w_hfn_sang_data
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 116
integer width = 4087
integer height = 1728
integer taborder = 20
string dataobject = "d_hfn_sang_data"
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

