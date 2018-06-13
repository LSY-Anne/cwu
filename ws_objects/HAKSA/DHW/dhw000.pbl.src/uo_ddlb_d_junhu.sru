$PBExportHeader$uo_ddlb_d_junhu.sru
$PBExportComments$[대학원] ddlb - 전후기구분
forward
global type uo_ddlb_d_junhu from dropdownlistbox
end type
end forward

global type uo_ddlb_d_junhu from dropdownlistbox
integer width = 297
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean allowedit = true
string item[] = {"전기","후기"}
borderstyle borderstyle = stylelowered!
end type
global uo_ddlb_d_junhu uo_ddlb_d_junhu

on uo_ddlb_d_junhu.create
end on

on uo_ddlb_d_junhu.destroy
end on

event constructor;//string	ls_hakgi
//
//SELECT	HAKGI  
//INTO		:ls_hakgi  
//FROM		HAKSA.D_HAKSA_ILJUNG  
//WHERE		SIJUM_FLAG = '1'
//;
//
//if ls_hakgi = '1' then
//	ls_hakgi = '후기'
//	
//elseif ls_hakgi = '2' then
//	ls_hakgi = '전기'
//	
//end if
//
//this.text = ls_hakgi
end event

