$PBExportHeader$uo_ddlb_hakgi.sru
$PBExportComments$[청운대]학기 검색용 ddlb
forward
global type uo_ddlb_hakgi from dropdownlistbox
end type
end forward

global type uo_ddlb_hakgi from dropdownlistbox
integer width = 219
integer height = 468
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean allowedit = true
string item[] = {"1","2","3","4"}
borderstyle borderstyle = stylelowered!
end type
global uo_ddlb_hakgi uo_ddlb_hakgi

on uo_ddlb_hakgi.create
end on

on uo_ddlb_hakgi.destroy
end on

event constructor;string	ls_hakgi

ls_hakgi	= f_haksa_iljung_hakgi()

this.text	= ls_hakgi
end event

