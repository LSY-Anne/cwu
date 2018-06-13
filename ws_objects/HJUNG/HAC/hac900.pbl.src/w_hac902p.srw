$PBExportHeader$w_hac902p.srw
$PBExportComments$DM출력
forward
global type w_hac902p from w_msheet
end type
type dw_print2 from datawindow within w_hac902p
end type
type dw_print from datawindow within w_hac902p
end type
type cb_2 from commandbutton within w_hac902p
end type
type cb_1 from commandbutton within w_hac902p
end type
type cb_3 from commandbutton within w_hac902p
end type
type st_1 from statictext within w_hac902p
end type
type dw_head from datawindow within w_hac902p
end type
end forward

global type w_hac902p from w_msheet
integer width = 2039
integer height = 844
dw_print2 dw_print2
dw_print dw_print
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
st_1 st_1
dw_head dw_head
end type
global w_hac902p w_hac902p

type variables
string is_cnt

end variables

on w_hac902p.create
int iCurrent
call super::create
this.dw_print2=create dw_print2
this.dw_print=create dw_print
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.st_1=create st_1
this.dw_head=create dw_head
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print2
this.Control[iCurrent+2]=this.dw_print
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_head
end on

on w_hac902p.destroy
call super::destroy
destroy(this.dw_print2)
destroy(this.dw_print)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.dw_head)
end on

event ue_open;call super::ue_open;dw_head.SetTransObject(sqlca)
dw_print.SetTransOBject(sqlca)
dw_print2.SetTransOBject(sqlca)

dw_head.InsertRow(0)

dw_head.SetFocus()

end event

type ln_templeft from w_msheet`ln_templeft within w_hac902p
end type

type ln_tempright from w_msheet`ln_tempright within w_hac902p
end type

type ln_temptop from w_msheet`ln_temptop within w_hac902p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hac902p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hac902p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hac902p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hac902p
end type

type uc_insert from w_msheet`uc_insert within w_hac902p
end type

type uc_delete from w_msheet`uc_delete within w_hac902p
end type

type uc_save from w_msheet`uc_save within w_hac902p
end type

type uc_excel from w_msheet`uc_excel within w_hac902p
end type

type uc_print from w_msheet`uc_print within w_hac902p
end type

type st_line1 from w_msheet`st_line1 within w_hac902p
end type

type st_line2 from w_msheet`st_line2 within w_hac902p
end type

type st_line3 from w_msheet`st_line3 within w_hac902p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hac902p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hac902p
end type

type dw_print2 from datawindow within w_hac902p
boolean visible = false
integer x = 654
integer y = 416
integer width = 736
integer height = 328
integer taborder = 20
boolean titlebar = true
string dataobject = "d_hac902p_letter"
boolean minbox = true
end type

type dw_print from datawindow within w_hac902p
boolean visible = false
integer x = 9
integer y = 420
integer width = 736
integer height = 328
integer taborder = 20
boolean titlebar = true
string dataobject = "d_hac902p_label"
boolean minbox = true
end type

type cb_2 from commandbutton within w_hac902p
integer x = 1614
integer y = 584
integer width = 334
integer height = 96
integer taborder = 40
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "닫  기"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_hac902p
integer x = 1275
integer y = 584
integer width = 334
integer height = 96
integer taborder = 30
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Label"
end type

event clicked;string   ls_zip,    ls_section,  ls_name,   ls_dm_flag



dw_head.AcceptText()

ls_zip     = trim(string(dw_head.Object.zip[1], '' )) + '%'
ls_section = trim(string(dw_head.Object.dm_section[1], '')) + '%'
ls_name    = trim(string(dw_head.Object.reci_name[1], '' )) +  '%'
ls_dm_flag = trim(string(dw_head.Object.dm_flag[1], '')) + '%'

if dw_print.Retrieve(ls_zip,  ls_section, ls_name , ls_dm_flag) > 0 then
	OpenWithParm(w_printoption, dw_print)
else
	messagebox('확인', '출력할 대상자료가 없습니다.')
end if



end event

type cb_3 from commandbutton within w_hac902p
integer x = 919
integer y = 584
integer width = 357
integer height = 96
integer taborder = 20
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "편지봉투"
end type

event clicked;string   ls_zip,    ls_section,  ls_name,   ls_dm_flag



dw_head.AcceptText()

ls_zip     = trim(string(dw_head.Object.zip[1], '' )) + '%'
ls_section = trim(string(dw_head.Object.dm_section[1], '')) + '%'
ls_name    = trim(string(dw_head.Object.reci_name[1], '' )) +  '%'
ls_dm_flag = trim(string(dw_head.Object.dm_flag[1], '')) + '%'

if dw_print2.Retrieve(ls_zip,  ls_section, ls_name , ls_dm_flag) > 0 then
	OpenWithParm(w_printoption, dw_print2)
else
	messagebox('확인', '출력할 대상자료가 없습니다.')
end if



end event

type st_1 from statictext within w_hac902p
integer x = 219
integer y = 412
integer width = 1477
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "출력조건을 입력하지 않을경우 모든데이터를 출력합니다."
boolean focusrectangle = false
end type

type dw_head from datawindow within w_hac902p
integer x = 37
integer y = 40
integer width = 1920
integer height = 328
integer taborder = 10
string dataobject = "d_hac902p_plab"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemfocuschanged;// 한영변환
CHOOSE CASE	dwo.name
	CASE 'reci_name'
		f_pro_toggle('K', handle(parent))
	CASE ELSE
		f_pro_toggle('E', handle(parent))
END CHOOSE

end event

