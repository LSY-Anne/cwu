$PBExportHeader$uo_dwc_di_gwajung_gwa.sru
$PBExportComments$[대학원입시] dwc - 과정/학과 검색
forward
global type uo_dwc_di_gwajung_gwa from userobject
end type
type st_2 from statictext within uo_dwc_di_gwajung_gwa
end type
type st_1 from statictext within uo_dwc_di_gwajung_gwa
end type
type dw_2 from uo_dwc_d_hakgwa within uo_dwc_di_gwajung_gwa
end type
type dw_1 from uo_dwc_d_gwajung within uo_dwc_di_gwajung_gwa
end type
end forward

global type uo_dwc_di_gwajung_gwa from userobject
integer width = 1815
integer height = 80
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_2 st_2
st_1 st_1
dw_2 dw_2
dw_1 dw_1
end type
global uo_dwc_di_gwajung_gwa uo_dwc_di_gwajung_gwa

on uo_dwc_di_gwajung_gwa.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.st_1,&
this.dw_2,&
this.dw_1}
end on

on uo_dwc_di_gwajung_gwa.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type st_2 from statictext within uo_dwc_di_gwajung_gwa
integer x = 594
integer y = 16
integer width = 174
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "학 과"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within uo_dwc_di_gwajung_gwa
integer x = 27
integer y = 16
integer width = 174
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "과 정"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from uo_dwc_d_hakgwa within uo_dwc_di_gwajung_gwa
integer x = 777
integer y = 4
integer taborder = 20
string dataobject = "d_list_di_hakgwa"
end type

type dw_1 from uo_dwc_d_gwajung within uo_dwc_di_gwajung_gwa
integer x = 206
integer y = 4
integer taborder = 10
string dataobject = "d_list_di_gwajung"
end type

