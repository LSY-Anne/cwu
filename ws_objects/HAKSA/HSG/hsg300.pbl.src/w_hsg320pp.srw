$PBExportHeader$w_hsg320pp.srw
$PBExportComments$[청운대]학생조회popup
forward
global type w_hsg320pp from window
end type
type dw_1 from datawindow within w_hsg320pp
end type
end forward

global type w_hsg320pp from window
integer width = 2551
integer height = 1212
boolean titlebar = true
string title = "학생조회"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
dw_1 dw_1
end type
global w_hsg320pp w_hsg320pp

on w_hsg320pp.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_hsg320pp.destroy
destroy(this.dw_1)
end on

event open;String ls_name,  ls_gwa
Int    l_row

//f_center_window(This)

ls_name = Message.StringParm

dw_1.SetTransobject(sqlca)

ls_gwa  = gstru_uid_uname.dept_code

IF ls_gwa  = '1200' OR ls_gwa = '1201' OR ls_gwa = '2902' THEN
	ls_gwa  = '%'
ELSE
	ls_gwa  = gstru_uid_uname.dept_code + '%'
END IF

l_row      = dw_1.Retrieve(ls_name + '%', ls_gwa)


end event

type dw_1 from datawindow within w_hsg320pp
integer x = 9
integer y = 8
integer width = 2519
integer height = 1100
integer taborder = 10
string dataobject = "d_hsg320pp_1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//String ls_name,  ls_gwa
//
//this.settransobject(sqlca)
//
//ls_name = Message.StringParm
//
//IF ls_gwa  = '1200' OR ls_gwa = '1201' OR ls_gwa = '2902' THEN
//	ls_gwa  = '%'
//ELSE
//	ls_gwa  = gstru_uid_uname.dept_code + '%'
//END IF
//
//dw_1.Retrieve(ls_name + '%', ls_gwa)
//
end event

event doubleclicked;string	ls_hakbun
int		li_row

if row > 0 then
	li_row = this.getrow()
	
	ls_hakbun = this.getitemstring(li_row, 'hakbun')
	
	CloseWithReturn(Parent, ls_hakbun)
end if
end event

event clicked;if row > 0 then
	this.selectrow(0, false)
	this.selectrow(row, true)
end if
end event

