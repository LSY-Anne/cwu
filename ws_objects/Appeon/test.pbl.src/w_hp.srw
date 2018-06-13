$PBExportHeader$w_hp.srw
forward
global type w_hp from w_ancsheet
end type
type uo_1 from u_tab within w_hp
end type
type p_1 from u_picture within w_hp
end type
type tab_1 from tab within w_hp
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tab_1 from tab within w_hp
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_1 from uo_dwlv within w_hp
end type
end forward

global type w_hp from w_ancsheet
uo_1 uo_1
p_1 p_1
tab_1 tab_1
dw_1 dw_1
end type
global w_hp w_hp

on w_hp.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.p_1=create p_1
this.tab_1=create tab_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_hp.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.p_1)
destroy(this.tab_1)
destroy(this.dw_1)
end on

type uo_1 from u_tab within w_hp
integer x = 183
integer y = 776
integer taborder = 20
string #selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type p_1 from u_picture within w_hp
integer x = 1696
integer y = 592
integer width = 265
integer height = 84
string picturename = "..\img\button\topBtn_retrieve.gif"
end type

event clicked;call super::clicked;//ttt
end event

type tab_1 from tab within w_hp
integer x = 73
integer y = 924
integer width = 2496
integer height = 788
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
boolean showtext = false
boolean showpicture = false
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 48
integer width = 2459
integer height = 724
long backcolor = 67108864
string text = "HP"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 48
integer width = 2459
integer height = 724
long backcolor = 67108864
string text = "PENTA"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type dw_1 from uo_dwlv within w_hp
integer x = 59
integer y = 48
integer width = 2363
integer height = 500
integer taborder = 10
string dataobject = "d_pgm"
boolean livescroll = true
end type

