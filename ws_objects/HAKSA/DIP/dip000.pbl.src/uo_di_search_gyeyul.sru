$PBExportHeader$uo_di_search_gyeyul.sru
$PBExportComments$[대학원입시] 년도/학기/모집구분/종별/계열
forward
global type uo_di_search_gyeyul from userobject
end type
type st_5 from statictext within uo_di_search_gyeyul
end type
type dw_3 from uo_dwc_di_hakgwa within uo_di_search_gyeyul
end type
type st_4 from statictext within uo_di_search_gyeyul
end type
type st_3 from statictext within uo_di_search_gyeyul
end type
type dw_2 from uo_dwc_di_jongbyul within uo_di_search_gyeyul
end type
type dw_1 from uo_dwc_di_mojip within uo_di_search_gyeyul
end type
type st_2 from statictext within uo_di_search_gyeyul
end type
type st_1 from statictext within uo_di_search_gyeyul
end type
type ddlb_1 from uo_ddlb_di_hakgi within uo_di_search_gyeyul
end type
type em_1 from uo_em_di_year within uo_di_search_gyeyul
end type
end forward

global type uo_di_search_gyeyul from userobject
integer width = 2930
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_5 st_5
dw_3 dw_3
st_4 st_4
st_3 st_3
dw_2 dw_2
dw_1 dw_1
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
em_1 em_1
end type
global uo_di_search_gyeyul uo_di_search_gyeyul

on uo_di_search_gyeyul.create
this.st_5=create st_5
this.dw_3=create dw_3
this.st_4=create st_4
this.st_3=create st_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.em_1=create em_1
this.Control[]={this.st_5,&
this.dw_3,&
this.st_4,&
this.st_3,&
this.dw_2,&
this.dw_1,&
this.st_2,&
this.st_1,&
this.ddlb_1,&
this.em_1}
end on

on uo_di_search_gyeyul.destroy
destroy(this.st_5)
destroy(this.dw_3)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.em_1)
end on

type st_5 from statictext within uo_di_search_gyeyul
integer x = 2226
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
string text = "계열"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_3 from uo_dwc_di_hakgwa within uo_di_search_gyeyul
integer x = 2409
integer width = 489
integer taborder = 50
string dataobject = "d_list_di_gyeyul"
end type

type st_4 from statictext within uo_di_search_gyeyul
integer x = 1650
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
string text = "종 별"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within uo_di_search_gyeyul
integer x = 951
integer y = 16
integer width = 261
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "모집구분"
boolean focusrectangle = false
end type

type dw_2 from uo_dwc_di_jongbyul within uo_di_search_gyeyul
integer x = 1819
integer taborder = 40
end type

type dw_1 from uo_dwc_di_mojip within uo_di_search_gyeyul
integer x = 1216
integer taborder = 30
end type

type st_2 from statictext within uo_di_search_gyeyul
integer x = 494
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
string text = "학 기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within uo_di_search_gyeyul
integer x = 5
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

type ddlb_1 from uo_ddlb_di_hakgi within uo_di_search_gyeyul
integer x = 667
integer taborder = 20
end type

type em_1 from uo_em_di_year within uo_di_search_gyeyul
integer x = 178
integer taborder = 10
end type

