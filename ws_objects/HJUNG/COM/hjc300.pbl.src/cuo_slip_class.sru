$PBExportHeader$cuo_slip_class.sru
$PBExportComments$대체구분(전체/수입/지출)
forward
global type cuo_slip_class from userobject
end type
type rb_3 from radiobutton within cuo_slip_class
end type
type rb_2 from radiobutton within cuo_slip_class
end type
type rb_1 from radiobutton within cuo_slip_class
end type
end forward

global type cuo_slip_class from userobject
integer width = 942
integer height = 100
long backcolor = 31112622
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchanged pbm_custom01
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
end type
global cuo_slip_class cuo_slip_class

type variables

end variables

forward prototypes
public function string uf_getfname ()
public function string uf_getcode ()
public subroutine uf_enabled (boolean ab_enabled)
end prototypes

public function string uf_getfname ();string	ls_name

if rb_1.checked then
	ls_name	=	rb_1.text
elseif rb_2.checked then
	ls_name	=	rb_2.text
elseif rb_3.checked then
	ls_name	=	rb_3.text
else
	ls_name = ''
end if

return	ls_name
end function

public function string uf_getcode ();string	ls_code

if rb_2.checked then
	ls_code	=	'1'
elseif rb_3.checked then
	ls_code	=	'2'
else
	ls_code	=	''
end if

return	ls_code
end function

public subroutine uf_enabled (boolean ab_enabled);rb_1.enabled	=	ab_enabled
rb_2.enabled	=	ab_enabled
rb_3.enabled	=	ab_enabled

end subroutine

on cuo_slip_class.create
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.Control[]={this.rb_3,&
this.rb_2,&
this.rb_1}
end on

on cuo_slip_class.destroy
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
end on

type rb_3 from radiobutton within cuo_slip_class
integer x = 690
integer y = 20
integer width = 238
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 31112622
string text = "지출"
boolean checked = true
end type

event clicked;rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 255)

parent.triggerevent('ue_itemchanged')

end event

type rb_2 from radiobutton within cuo_slip_class
integer x = 352
integer y = 20
integer width = 238
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "수입"
end type

event clicked;rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_itemchanged')

end event

type rb_1 from radiobutton within cuo_slip_class
integer x = 14
integer y = 20
integer width = 238
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "전체"
end type

event clicked;rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_itemchanged')

end event

