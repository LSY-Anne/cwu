$PBExportHeader$uo_dwc_nexthakgwa.sru
$PBExportComments$[청운대]dwc - NEXT(년도,학년,학기,학과)
forward
global type uo_dwc_nexthakgwa from userobject
end type
type ddlb_2 from uo_ddlb_nexthakgi within uo_dwc_nexthakgwa
end type
type em_1 from uo_em_nextyear within uo_dwc_nexthakgwa
end type
type st_4 from statictext within uo_dwc_nexthakgwa
end type
type dw_1 from uo_dddw_dwc within uo_dwc_nexthakgwa
end type
type st_3 from statictext within uo_dwc_nexthakgwa
end type
type st_2 from statictext within uo_dwc_nexthakgwa
end type
type st_1 from statictext within uo_dwc_nexthakgwa
end type
type ddlb_1 from uo_ddlb_hakyun within uo_dwc_nexthakgwa
end type
end forward

global type uo_dwc_nexthakgwa from userobject
integer width = 2286
integer height = 88
long backcolor = 31112622
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
ddlb_2 ddlb_2
em_1 em_1
st_4 st_4
dw_1 dw_1
st_3 st_3
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
end type
global uo_dwc_nexthakgwa uo_dwc_nexthakgwa

on uo_dwc_nexthakgwa.create
this.ddlb_2=create ddlb_2
this.em_1=create em_1
this.st_4=create st_4
this.dw_1=create dw_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.Control[]={this.ddlb_2,&
this.em_1,&
this.st_4,&
this.dw_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.ddlb_1}
end on

on uo_dwc_nexthakgwa.destroy
destroy(this.ddlb_2)
destroy(this.em_1)
destroy(this.st_4)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
end on

type ddlb_2 from uo_ddlb_nexthakgi within uo_dwc_nexthakgwa
integer x = 626
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string item[] = {"1","2","3","4"}
end type

type em_1 from uo_em_nextyear within uo_dwc_nexthakgwa
integer x = 183
integer taborder = 50
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_4 from statictext within uo_dwc_nexthakgwa
integer x = 1307
integer y = 16
integer width = 151
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "학과"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from uo_dddw_dwc within uo_dwc_nexthakgwa
integer x = 1463
integer y = 4
integer width = 795
integer taborder = 40
string dataobject = "d_list_hakgwa"
end type

type st_3 from statictext within uo_dwc_nexthakgwa
integer x = 471
integer y = 16
integer width = 151
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within uo_dwc_nexthakgwa
integer x = 878
integer y = 16
integer width = 151
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "학년"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within uo_dwc_nexthakgwa
integer x = 27
integer y = 20
integer width = 151
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from uo_ddlb_hakyun within uo_dwc_nexthakgwa
integer x = 1033
integer taborder = 30
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

