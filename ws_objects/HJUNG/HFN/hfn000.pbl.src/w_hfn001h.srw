$PBExportHeader$w_hfn001h.srw
$PBExportComments$계정코드도움말(계정코드,계정명)-예산공통으로 자금계정조회시
forward
global type w_hfn001h from window
end type
type cb_cancel from u_picture within w_hfn001h
end type
type cb_ok from u_picture within w_hfn001h
end type
type cb_retrieve from u_picture within w_hfn001h
end type
type em_acct_code from editmask within w_hfn001h
end type
type dw_main from cuo_dwwindow_one_hin within w_hfn001h
end type
type sle_acct_name from singlelineedit within w_hfn001h
end type
type st_8 from statictext within w_hfn001h
end type
type st_1 from statictext within w_hfn001h
end type
type gb_1 from groupbox within w_hfn001h
end type
end forward

global type w_hfn001h from window
integer width = 2377
integer height = 1880
boolean titlebar = true
string title = "계정코드도움말"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
cb_cancel cb_cancel
cb_ok cb_ok
cb_retrieve cb_retrieve
em_acct_code em_acct_code
dw_main dw_main
sle_acct_name sle_acct_name
st_8 st_8
st_1 st_1
gb_1 gb_1
end type
global w_hfn001h w_hfn001h

type variables
string	is_acct_code, is_acct_name, is_io_gubun
integer	ii_acct_class
end variables

event ue_db_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_AcctCode
String	ls_AcctName

em_acct_code.GetData(is_acct_code)

is_acct_code = trim(is_acct_code)
is_acct_name = trim(sle_acct_name.Text)


SetPointer(HourGlass!)
dw_main.SetReDraw(FALSE)
dw_main.Retrieve(is_acct_code,is_acct_name,ii_acct_class)
dw_main.setfocus()
dw_main.SetReDraw(TRUE)

end event

on w_hfn001h.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_retrieve=create cb_retrieve
this.em_acct_code=create em_acct_code
this.dw_main=create dw_main
this.sle_acct_name=create sle_acct_name
this.st_8=create st_8
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.cb_retrieve,&
this.em_acct_code,&
this.dw_main,&
this.sle_acct_name,&
this.st_8,&
this.st_1,&
this.gb_1}
end on

on w_hfn001h.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_retrieve)
destroy(this.em_acct_code)
destroy(this.dw_main)
destroy(this.sle_acct_name)
destroy(this.st_8)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: open
//	기 능 설 명: 계정과목 정보 도움말
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
f_centerme(this)

s_insa_com	lstr_com
lstr_com = Message.PowerObjectParm

if not isvalid(lstr_com) then close(this)

is_acct_code  = lstr_com.ls_item[1]				//계정과목
is_acct_name  = lstr_com.ls_item[2]				//계정명칭
ii_acct_class = integer(lstr_com.ls_item[3])	//회계단위

em_acct_code.Text  = trim(is_acct_code)
sle_acct_name.Text = trim(is_acct_name)

this.trigger event ue_db_retrieve()

sle_acct_name.setfocus()

end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE
end event

type cb_cancel from u_picture within w_hfn001h
integer x = 2053
integer y = 244
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_cancel.gif"
end type

event clicked;call super::clicked;CLOSE(PARENT)
end event

type cb_ok from u_picture within w_hfn001h
integer x = 2053
integer y = 156
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

String	ls_AcctCode
String	ls_DrcrClass
String	ls_AcctName
String	ls_BdgtCntlYn
Long		ll_mana_code

ls_AcctCode     = dw_main.getitemstring(ll_getrow, 'com_acct_code')
ls_DrcrClass    = dw_main.getitemstring(ll_getrow, 'com_drcr_class')
ls_AcctName     = dw_main.getitemstring(ll_getrow, 'com_acct_name')
ls_BdgtCntlYn   = dw_main.getitemstring(ll_getrow, 'com_bdgt_cntl_yn')
ll_mana_code    = dw_main.getitemnumber(ll_getrow, 'com_mana_code')

s_insa_com	lstr_com
lstr_com.ls_item[1] = ls_AcctCode		//계정코드
lstr_com.ls_item[2] = ls_AcctName		//계정과목명
lstr_com.ls_item[3] = ls_DrcrClass		//차대구분
lstr_com.ls_item[4] = ls_BdgtCntlYn		//예산통제여부
lstr_com.ls_item[5] = string(ll_mana_code)

CloseWithReturn(PARENT,lstr_com)

end event

type cb_retrieve from u_picture within w_hfn001h
integer x = 2053
integer y = 68
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

type em_acct_code from editmask within w_hfn001h
integer x = 338
integer y = 124
integer width = 334
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####-##"
end type

type dw_main from cuo_dwwindow_one_hin within w_hfn001h
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 384
integer width = 2327
integer height = 1360
integer taborder = 70
string dataobject = "d_hfn001h_1"
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

type sle_acct_name from singlelineedit within w_hfn001h
integer x = 338
integer y = 204
integer width = 1010
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_hfn001h
integer x = 64
integer y = 220
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "계정명"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_hfn001h
integer x = 64
integer y = 136
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "계정코드"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hfn001h
integer x = 14
integer y = 12
integer width = 2007
integer height = 356
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

