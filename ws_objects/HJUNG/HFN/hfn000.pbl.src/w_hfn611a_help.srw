$PBExportHeader$w_hfn611a_help.srw
$PBExportComments$[산학협력단]기타소득자 조회
forward
global type w_hfn611a_help from window
end type
type cb_cancel from u_picture within w_hfn611a_help
end type
type cb_ok from u_picture within w_hfn611a_help
end type
type cb_retrieve from u_picture within w_hfn611a_help
end type
type ddlb_1 from dropdownlistbox within w_hfn611a_help
end type
type st_3 from statictext within w_hfn611a_help
end type
type em_data from editmask within w_hfn611a_help
end type
type dw_main from cuo_dwwindow_one_hin within w_hfn611a_help
end type
type st_1 from statictext within w_hfn611a_help
end type
type gb_1 from groupbox within w_hfn611a_help
end type
end forward

global type w_hfn611a_help from window
integer width = 2734
integer height = 1880
boolean titlebar = true
string title = "계정코드도움말"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
cb_cancel cb_cancel
cb_ok cb_ok
cb_retrieve cb_retrieve
ddlb_1 ddlb_1
st_3 st_3
em_data em_data
dw_main dw_main
st_1 st_1
gb_1 gb_1
end type
global w_hfn611a_help w_hfn611a_help

type variables

end variables

event ue_db_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_gubun, ls_data

ls_gubun = string(ddlb_1.finditem(ddlb_1.text,0))
em_data.GetData(ls_data)

SetPointer(HourGlass!)
dw_main.SetReDraw(FALSE)
dw_main.Retrieve(ls_gubun, trim(ls_data))
dw_main.setfocus()
dw_main.SetReDraw(TRUE)

end event

on w_hfn611a_help.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_retrieve=create cb_retrieve
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.em_data=create em_data
this.dw_main=create dw_main
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.cb_retrieve,&
this.ddlb_1,&
this.st_3,&
this.em_data,&
this.dw_main,&
this.st_1,&
this.gb_1}
end on

on w_hfn611a_help.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_retrieve)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.em_data)
destroy(this.dw_main)
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
string	ls_data

f_centerme(this)

ls_data = message.stringparm

if mid(ls_data,1,1) = '1' then
	ddlb_1.selectitem(1)
else
	ddlb_1.selectitem(2)
end if

em_data.text  = mid(ls_data, 2)

this.trigger event ue_db_retrieve()

end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE
end event

type cb_cancel from u_picture within w_hfn611a_help
integer x = 2405
integer y = 244
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_cancel.gif"
end type

event clicked;call super::clicked;CLOSE(PARENT)
end event

type cb_ok from u_picture within w_hfn611a_help
integer x = 2405
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

s_insa_com	lstr_com

lstr_com.ls_item[1] = dw_main.Object.income_name[ll_GetRow]		//소득자명
lstr_com.ls_item[2] = dw_main.Object.jumin_no[ll_GetRow]			//주민등록번호
lstr_com.ls_item[3] = dw_main.Object.income_juso[ll_GetRow]		//주소

CloseWithReturn(PARENT,lstr_com)

end event

type cb_retrieve from u_picture within w_hfn611a_help
integer x = 2405
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

type ddlb_1 from dropdownlistbox within w_hfn611a_help
integer x = 526
integer y = 96
integer width = 489
integer height = 216
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean allowedit = true
string item[] = {"소득자명","주민등록번호"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;st_1.text = text

end event

type st_3 from statictext within w_hfn611a_help
integer x = 105
integer y = 104
integer width = 398
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_data from editmask within w_hfn611a_help
integer x = 526
integer y = 200
integer width = 649
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type dw_main from cuo_dwwindow_one_hin within w_hfn611a_help
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 384
integer width = 2683
integer height = 1360
integer taborder = 70
string dataobject = "d_hfn611a_help"
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

type st_1 from statictext within w_hfn611a_help
integer x = 105
integer y = 212
integer width = 398
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "주민등록번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hfn611a_help
integer x = 14
integer y = 12
integer width = 2359
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

