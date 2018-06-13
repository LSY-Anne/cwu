$PBExportHeader$w_hfn006m.srw
$PBExportComments$관리항목에 의한 유가증권 조회
forward
global type w_hfn006m from window
end type
type dw_head from datawindow within w_hfn006m
end type
type st_1 from statictext within w_hfn006m
end type
type cb_retrieve from commandbutton within w_hfn006m
end type
type cb_cancel from commandbutton within w_hfn006m
end type
type cb_ok from commandbutton within w_hfn006m
end type
type dw_main from cuo_dwwindow_one_hin within w_hfn006m
end type
type gb_1 from groupbox within w_hfn006m
end type
end forward

global type w_hfn006m from window
integer width = 2766
integer height = 1880
boolean titlebar = true
string title = "유가증권 도움말"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
dw_head dw_head
st_1 st_1
cb_retrieve cb_retrieve
cb_cancel cb_cancel
cb_ok cb_ok
dw_main dw_main
gb_1 gb_1
end type
global w_hfn006m w_hfn006m

type variables
integer	ii_sec_opt
end variables

event ue_db_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
dw_main.SetReDraw(FALSE)
dw_main.Retrieve(ii_sec_opt)
dw_main.setfocus()
dw_main.SetReDraw(TRUE)

end event

on w_hfn006m.create
this.dw_head=create dw_head
this.st_1=create st_1
this.cb_retrieve=create cb_retrieve
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_main=create dw_main
this.gb_1=create gb_1
this.Control[]={this.dw_head,&
this.st_1,&
this.cb_retrieve,&
this.cb_cancel,&
this.cb_ok,&
this.dw_main,&
this.gb_1}
end on

on w_hfn006m.destroy
destroy(this.dw_head)
destroy(this.st_1)
destroy(this.cb_retrieve)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_main)
destroy(this.gb_1)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: open
//	기 능 설 명: 차입번호 정보 도움말
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
datawindowchild	ldw_temp

f_centerme(this)

f_getdwcommon(dw_head, 'sec_opt', 0, 730)
dw_head.setitem(1, 'code', '0')
ii_sec_opt = 0

this.trigger event ue_db_retrieve()

end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE
end event

type dw_head from datawindow within w_hfn006m
integer x = 347
integer y = 76
integer width = 1248
integer height = 104
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) or trim(data) = '0' or trim(data) = '' then	
	ii_sec_opt	=	0
else
	ii_sec_opt	=	long(data)
end if

cb_retrieve.triggerevent(clicked!)

end event

type st_1 from statictext within w_hfn006m
integer x = 59
integer y = 92
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "증권구분"
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_hfn006m
boolean visible = false
integer x = 2034
integer y = 16
integer width = 306
integer height = 116
integer taborder = 40
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

type cb_cancel from commandbutton within w_hfn006m
boolean visible = false
integer x = 2034
integer y = 248
integer width = 306
integer height = 116
integer taborder = 60
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

type cb_ok from commandbutton within w_hfn006m
boolean visible = false
integer x = 2034
integer y = 132
integer width = 306
integer height = 116
integer taborder = 50
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


lstr_com.ls_item[1] = trim(dw_main.getitemstring(ll_getrow, 'sec_no'))
lstr_com.ls_item[2] = ''


CloseWithReturn(PARENT,lstr_com)

end event

type dw_main from cuo_dwwindow_one_hin within w_hfn006m
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 200
integer width = 2702
integer height = 1544
integer taborder = 70
string dataobject = "d_hfn006m_1"
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

type gb_1 from groupbox within w_hfn006m
integer x = 14
integer y = 12
integer width = 2702
integer height = 184
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

