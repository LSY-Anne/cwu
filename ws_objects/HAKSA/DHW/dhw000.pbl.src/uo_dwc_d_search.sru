$PBExportHeader$uo_dwc_d_search.sru
$PBExportComments$[대학원] dwc - 년도/학기/과정/학과/전공 검색
forward
global type uo_dwc_d_search from userobject
end type
type dw_2 from uo_dwc_d_gwa_jungong within uo_dwc_d_search
end type
type st_3 from statictext within uo_dwc_d_search
end type
type dw_1 from uo_dwc_d_gwajung within uo_dwc_d_search
end type
type ddlb_1 from uo_ddlb_d_hakgi within uo_dwc_d_search
end type
type st_2 from statictext within uo_dwc_d_search
end type
type st_1 from statictext within uo_dwc_d_search
end type
type em_1 from uo_em_d_year within uo_dwc_d_search
end type
end forward

global type uo_dwc_d_search from userobject
integer width = 3374
integer height = 92
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
st_3 st_3
dw_1 dw_1
ddlb_1 ddlb_1
st_2 st_2
st_1 st_1
em_1 em_1
end type
global uo_dwc_d_search uo_dwc_d_search

on uo_dwc_d_search.create
this.dw_2=create dw_2
this.st_3=create st_3
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.st_1=create st_1
this.em_1=create em_1
this.Control[]={this.dw_2,&
this.st_3,&
this.dw_1,&
this.ddlb_1,&
this.st_2,&
this.st_1,&
this.em_1}
end on

on uo_dwc_d_search.destroy
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_1)
end on

type dw_2 from uo_dwc_d_gwa_jungong within uo_dwc_d_search
integer x = 1445
integer y = 8
integer taborder = 40
end type

type st_3 from statictext within uo_dwc_d_search
integer x = 923
integer y = 20
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
boolean focusrectangle = false
end type

type dw_1 from uo_dwc_d_gwajung within uo_dwc_d_search
integer x = 1097
integer y = 8
integer taborder = 30
end type

type ddlb_1 from uo_ddlb_d_hakgi within uo_dwc_d_search
integer x = 658
integer y = 4
integer taborder = 20
end type

type st_2 from statictext within uo_dwc_d_search
integer x = 489
integer y = 20
integer width = 160
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "학 기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within uo_dwc_d_search
integer x = 9
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
string text = "년 도"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from uo_em_d_year within uo_dwc_d_search
integer x = 187
integer y = 4
integer taborder = 10
end type

