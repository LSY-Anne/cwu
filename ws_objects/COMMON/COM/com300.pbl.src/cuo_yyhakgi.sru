$PBExportHeader$cuo_yyhakgi.sru
$PBExportComments$년도,학기조회
forward
global type cuo_yyhakgi from userobject
end type
type em_hakgi from editmask within cuo_yyhakgi
end type
type em_yy from editmask within cuo_yyhakgi
end type
type st_2 from statictext within cuo_yyhakgi
end type
type st_1 from statictext within cuo_yyhakgi
end type
type st_12131 from statictext within cuo_yyhakgi
end type
type st_122 from statictext within cuo_yyhakgi
end type
end forward

global type cuo_yyhakgi from userobject
integer width = 992
integer height = 108
boolean border = true
long backcolor = 31112622
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
em_hakgi em_hakgi
em_yy em_yy
st_2 st_2
st_1 st_1
st_12131 st_12131
st_122 st_122
end type
global cuo_yyhakgi cuo_yyhakgi

forward prototypes
public function string uf_gethakgi ()
public function string uf_getyy ()
end prototypes

event ue_itemchange;//parent.triggerevent("ue_retrieve")
end event

public function string uf_gethakgi ();int li_mm

li_mm   = Integer(em_hakgi.text )
return string(li_mm,'0')
end function

public function string uf_getyy ();int li_yy,li_mm
li_yy   = Integer(em_yy.text )
return string(li_yy,'0000')
end function

on cuo_yyhakgi.create
this.em_hakgi=create em_hakgi
this.em_yy=create em_yy
this.st_2=create st_2
this.st_1=create st_1
this.st_12131=create st_12131
this.st_122=create st_122
this.Control[]={this.em_hakgi,&
this.em_yy,&
this.st_2,&
this.st_1,&
this.st_12131,&
this.st_122}
end on

on cuo_yyhakgi.destroy
destroy(this.em_hakgi)
destroy(this.em_yy)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_12131)
destroy(this.st_122)
end on

event constructor;string ls_yy, ls_hakgi

SELECT next_yy, next_hakgi
INTO :ls_yy, :ls_hakgi
FROM cddb.kch004m
WHERE yy = '****' AND hakgi = '*' ;
em_yy.text    = ls_yy
em_hakgi.text = ls_hakgi

end event

type em_hakgi from editmask within cuo_yyhakgi
integer x = 741
integer y = 8
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#"
boolean spin = true
string minmax = "1~~4"
end type

event modified;parent.triggerevent('ue_itemchange')
end event

type em_yy from editmask within cuo_yyhakgi
integer x = 229
integer y = 8
integer width = 325
integer height = 84
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
string mask = "####"
boolean spin = true
string minmax = "0~~9999"
end type

event modified;parent.triggerevent('ue_itemchange')
end event

type st_2 from statictext within cuo_yyhakgi
integer x = 567
integer y = 12
integer width = 174
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
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within cuo_yyhakgi
integer x = 5
integer y = 16
integer width = 215
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
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_12131 from statictext within cuo_yyhakgi
integer x = 5
integer y = 4
integer width = 219
integer height = 96
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_122 from statictext within cuo_yyhakgi
integer x = 562
integer width = 123
integer height = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

