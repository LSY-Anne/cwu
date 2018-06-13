$PBExportHeader$cuo_mm.sru
$PBExportComments$월
forward
global type cuo_mm from userobject
end type
type em_mm from editmask within cuo_mm
end type
type st_2 from statictext within cuo_mm
end type
type st_122 from statictext within cuo_mm
end type
end forward

global type cuo_mm from userobject
integer width = 393
integer height = 108
long backcolor = 31112622
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
em_mm em_mm
st_2 st_2
st_122 st_122
end type
global cuo_mm cuo_mm

forward prototypes
public function string uf_getmm ()
end prototypes

public function string uf_getmm ();int i_mm

i_mm   = Integer(em_mm.text )
return	string(i_mm, '00')
end function

on cuo_mm.create
this.em_mm=create em_mm
this.st_2=create st_2
this.st_122=create st_122
this.Control[]={this.em_mm,&
this.st_2,&
this.st_122}
end on

on cuo_mm.destroy
destroy(this.em_mm)
destroy(this.st_2)
destroy(this.st_122)
end on

event constructor;string s_yy

s_yy       = f_today()

em_mm.text = mid(s_yy,5,2)

end event

type em_mm from editmask within cuo_mm
integer x = 128
integer y = 8
integer width = 247
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "1~~12"
end type

event modified;parent.triggerevent('ue_itemchange')
end event

type st_2 from statictext within cuo_mm
integer x = 5
integer y = 20
integer width = 114
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "월"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_122 from statictext within cuo_mm
integer width = 123
integer height = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

