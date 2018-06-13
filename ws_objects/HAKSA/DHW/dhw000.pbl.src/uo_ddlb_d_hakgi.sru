$PBExportHeader$uo_ddlb_d_hakgi.sru
$PBExportComments$[대학원] ddlb - 학기 검색용
forward
global type uo_ddlb_d_hakgi from dropdownlistbox
end type
end forward

global type uo_ddlb_d_hakgi from dropdownlistbox
integer width = 201
integer height = 208
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean allowedit = true
string item[] = {"1","2"}
borderstyle borderstyle = stylelowered!
end type
global uo_ddlb_d_hakgi uo_ddlb_d_hakgi

on uo_ddlb_d_hakgi.create
end on

on uo_ddlb_d_hakgi.destroy
end on

event constructor;//string	ls_hakgi
//
//ls_hakgi	= f_haksa_iljung_hakgi()
//
//this.text	= ls_hakgi

string	ls_hakgi

SELECT	HAKGI  
INTO		:ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE		SIJUM_FLAG = '1'
;

this.text = ls_hakgi
end event

