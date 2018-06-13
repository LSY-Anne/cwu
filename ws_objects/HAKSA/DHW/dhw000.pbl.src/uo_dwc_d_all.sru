$PBExportHeader$uo_dwc_d_all.sru
$PBExportComments$[대학원] dwc - 과정/학과/전공 검색
forward
global type uo_dwc_d_all from userobject
end type
type dw_2 from uo_dwc_d_gwa_jungong within uo_dwc_d_all
end type
type st_1 from statictext within uo_dwc_d_all
end type
type dw_1 from uo_dwc_d_gwajung within uo_dwc_d_all
end type
end forward

global type uo_dwc_d_all from userobject
integer width = 2496
integer height = 80
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
st_1 st_1
dw_1 dw_1
end type
global uo_dwc_d_all uo_dwc_d_all

on uo_dwc_d_all.create
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.st_1,&
this.dw_1}
end on

on uo_dwc_d_all.destroy
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

type dw_2 from uo_dwc_d_gwa_jungong within uo_dwc_d_all
integer x = 558
integer y = 4
integer taborder = 20
end type

type st_1 from statictext within uo_dwc_d_all
integer x = 18
integer y = 16
integer width = 169
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

type dw_1 from uo_dwc_d_gwajung within uo_dwc_d_all
integer x = 197
integer y = 4
integer taborder = 10
end type

