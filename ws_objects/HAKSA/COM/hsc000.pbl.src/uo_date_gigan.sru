$PBExportHeader$uo_date_gigan.sru
$PBExportComments$[청운대]editmask - 년월일 기간 검색용
forward
global type uo_date_gigan from userobject
end type
type st_2 from statictext within uo_date_gigan
end type
type st_1 from statictext within uo_date_gigan
end type
type em_2 from uo_date within uo_date_gigan
end type
type em_1 from uo_date within uo_date_gigan
end type
end forward

global type uo_date_gigan from userobject
integer width = 1271
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_2 st_2
st_1 st_1
em_2 em_2
em_1 em_1
end type
global uo_date_gigan uo_date_gigan

on uo_date_gigan.create
this.st_2=create st_2
this.st_1=create st_1
this.em_2=create em_2
this.em_1=create em_1
this.Control[]={this.st_2,&
this.st_1,&
this.em_2,&
this.em_1}
end on

on uo_date_gigan.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_2)
destroy(this.em_1)
end on

type st_2 from statictext within uo_date_gigan
integer x = 763
integer y = 20
integer width = 46
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "~~"
boolean focusrectangle = false
end type

type st_1 from statictext within uo_date_gigan
integer x = 14
integer y = 20
integer width = 283
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "조회기간"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_2 from uo_date within uo_date_gigan
integer x = 809
integer y = 8
integer taborder = 20
end type

type em_1 from uo_date within uo_date_gigan
integer x = 302
integer y = 8
integer taborder = 10
end type

