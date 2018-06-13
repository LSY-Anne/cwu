$PBExportHeader$w_hfn404a_help.srw
$PBExportComments$인사기본정보도움말(성명,개인번호)
forward
global type w_hfn404a_help from window
end type
type cb_retrieve from commandbutton within w_hfn404a_help
end type
type cb_cancel from commandbutton within w_hfn404a_help
end type
type cb_ok from commandbutton within w_hfn404a_help
end type
type dw_main from cuo_dwwindow_one_hin within w_hfn404a_help
end type
type sle_kname from singlelineedit within w_hfn404a_help
end type
type st_1 from statictext within w_hfn404a_help
end type
type gb_1 from groupbox within w_hfn404a_help
end type
type st_2 from statictext within w_hfn404a_help
end type
end forward

global type w_hfn404a_help from window
integer width = 3378
integer height = 1628
boolean titlebar = true
string title = "인사기본정보도움말"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
cb_retrieve cb_retrieve
cb_cancel cb_cancel
cb_ok cb_ok
dw_main dw_main
sle_kname sle_kname
st_1 st_1
gb_1 gb_1
st_2 st_2
end type
global w_hfn404a_help w_hfn404a_help

event ue_db_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
Long		ll_RowCnt

ls_KName = TRIM(sle_kname.Text)

SetPointer(HourGlass!)

dw_main.SetReDraw(FALSE)
ll_RowCnt = dw_main.Retrieve(ls_KName)
dw_main.SetReDraw(TRUE)

IF ll_RowCnt > 0 THEN
	dw_main.SetFocus()
ELSE
	sle_kname.SetFocus()
END IF

end event

on w_hfn404a_help.create
this.cb_retrieve=create cb_retrieve
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_main=create dw_main
this.sle_kname=create sle_kname
this.st_1=create st_1
this.gb_1=create gb_1
this.st_2=create st_2
this.Control[]={this.cb_retrieve,&
this.cb_cancel,&
this.cb_ok,&
this.dw_main,&
this.sle_kname,&
this.st_1,&
this.gb_1,&
this.st_2}
end on

on w_hfn404a_help.destroy
destroy(this.cb_retrieve)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_main)
destroy(this.sle_kname)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.st_2)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 인사기본정보 도움말
//	작 성 인 : 이현수
//	작성일자 : 2002.11
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
string	ls_name

f_centerme(this)

ls_name = Message.stringparm

sle_kname.Text = ls_name

THIS.TRIGGER EVENT ue_db_retrieve()

end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE
end event

type cb_retrieve from commandbutton within w_hfn404a_help
boolean visible = false
integer x = 3049
integer y = 16
integer width = 306
integer height = 92
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
PARENT.TRIGGER EVENT ue_db_retrieve()

end event

type cb_cancel from commandbutton within w_hfn404a_help
boolean visible = false
integer x = 3049
integer y = 200
integer width = 306
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "취소"
end type

event clicked;IF NOT THIS.Enabled THEN RETURN
CLOSE(PARENT)
end event

type cb_ok from commandbutton within w_hfn404a_help
boolean visible = false
integer x = 3049
integer y = 108
integer width = 306
integer height = 92
integer taborder = 60
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
Long		ll_GetRow
String	ls_KName
String	ls_MemberNo
String	ls_bank_code
String	ls_acct_no
String	ls_depositor

IF NOT THIS.Enabled THEN RETURN

IF dw_main.RowCount() = 0 THEN
	MessageBox('확인','자료를 조회 후 사용하시기 바랍니다')
	RETURN
END IF

ll_GetRow = dw_main.getrow()
IF ll_GetRow = 0 THEN
	MessageBox('확인','자료를 선택 후 사용하시기 바랍니다')
	RETURN
END IF

ls_KName          = dw_main.Object.name	         [ll_GetRow]
ls_MemberNo       = dw_main.Object.member_no       [ll_GetRow]
ls_bank_code      = string(dw_main.Object.bank_code[ll_GetRow])
ls_acct_no        = dw_main.Object.acct_no         [ll_GetRow]
ls_depositor      = dw_main.Object.depositor       [ll_GetRow]

s_insa_com	lstr_com
lstr_com.ls_item[1] = ls_MemberNo			//개인번호
lstr_com.ls_item[2] = ls_KName				//성명
lstr_com.ls_item[3] = ls_bank_code			//은행코드
lstr_com.ls_item[4] = ls_acct_no			//계좌번호
lstr_com.ls_item[5] = ls_depositor			//예금주

CloseWithReturn(PARENT,lstr_com)

end event

type dw_main from cuo_dwwindow_one_hin within w_hfn404a_help
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 232
integer width = 3337
integer height = 1280
integer taborder = 70
string dataobject = "d_hfn404a_help"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_dwnkey;IF KeyDown(KeyEnter!) THEN
	cb_ok.TRIGGER EVENT clicked()
END IF
end event

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

event doubleclicked;call super::doubleclicked;IF row = 0 THEN RETURN
cb_ok.TRIGGER EVENT clicked()
end event

type sle_kname from singlelineedit within w_hfn404a_help
integer x = 247
integer y = 92
integer width = 457
integer height = 76
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

type st_1 from statictext within w_hfn404a_help
integer x = 78
integer y = 104
integer width = 165
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "성명"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hfn404a_help
integer x = 14
integer y = 12
integer width = 3337
integer height = 216
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type st_2 from statictext within w_hfn404a_help
boolean visible = false
integer x = 3040
integer y = 8
integer width = 325
integer height = 288
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

