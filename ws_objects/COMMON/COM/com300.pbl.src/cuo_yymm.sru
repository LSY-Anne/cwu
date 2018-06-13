$PBExportHeader$cuo_yymm.sru
$PBExportComments$년도,월조회
forward
global type cuo_yymm from userobject
end type
type em_mm from editmask within cuo_yymm
end type
type em_yy from editmask within cuo_yymm
end type
type st_2 from statictext within cuo_yymm
end type
type st_1 from statictext within cuo_yymm
end type
type st_12131 from statictext within cuo_yymm
end type
type st_122 from statictext within cuo_yymm
end type
end forward

global type cuo_yymm from userobject
integer width = 960
integer height = 112
boolean border = true
long backcolor = 80269524
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
em_mm em_mm
em_yy em_yy
st_2 st_2
st_1 st_1
st_12131 st_12131
st_122 st_122
end type
global cuo_yymm cuo_yymm

forward prototypes
public function string uf_getyy ()
public function string uf_getyymm ()
public function string uf_getmm ()
end prototypes

public function string uf_getyy ();int i_yy,i_mm
i_yy   = Integer(em_yy.text )
return string(i_yy,'0000')
end function

public function string uf_getyymm ();int i_yy,i_mm
i_yy   = Integer(em_yy.text )
i_mm   = Integer(em_mm.text )
return string(i_yy,'0000')+ string(i_mm,'00')
end function

public function string uf_getmm ();int i_mm

i_mm   = Integer(em_mm.text )
return string(i_mm,'00')
end function

on cuo_yymm.create
this.em_mm=create em_mm
this.em_yy=create em_yy
this.st_2=create st_2
this.st_1=create st_1
this.st_12131=create st_12131
this.st_122=create st_122
this.Control[]={this.em_mm,&
this.em_yy,&
this.st_2,&
this.st_1,&
this.st_12131,&
this.st_122}
end on

on cuo_yymm.destroy
destroy(this.em_mm)
destroy(this.em_yy)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_12131)
destroy(this.st_122)
end on

event constructor;string s_yy
s_yy       = f_today()
//s_yy       = left(s_yy,6)
//s_yy       = f_preyymm(s_yy)
em_yy.text = left(s_yy,4)
em_mm.text = mid(s_yy,5,2)

end event

type em_mm from editmask within cuo_yymm
integer x = 690
integer width = 247
integer height = 100
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
string minmax = "1~~12"
end type

event modified;parent.triggerevent('ue_itemchange')
end event

type em_yy from editmask within cuo_yymm
integer x = 229
integer width = 325
integer height = 100
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
string minmax = "0~~9999"
end type

event modified;parent.triggerevent('ue_itemchange')
end event

type st_2 from statictext within cuo_yymm
integer x = 567
integer y = 16
integer width = 114
integer height = 68
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
boolean enabled = false
string text = "월"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within cuo_yymm
integer x = 5
integer y = 16
integer width = 215
integer height = 68
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
boolean enabled = false
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_12131 from statictext within cuo_yymm
integer x = 5
integer y = 4
integer width = 219
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_122 from statictext within cuo_yymm
integer x = 562
integer width = 123
integer height = 100
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

