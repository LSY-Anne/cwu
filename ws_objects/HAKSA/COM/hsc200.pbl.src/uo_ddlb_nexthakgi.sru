$PBExportHeader$uo_ddlb_nexthakgi.sru
$PBExportComments$[청운대]next학기 검색용 ddlb(등록)
forward
global type uo_ddlb_nexthakgi from dropdownlistbox
end type
end forward

global type uo_ddlb_nexthakgi from dropdownlistbox
integer width = 201
integer height = 472
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean allowedit = true
string item[] = {"1","2","3","4 "}
borderstyle borderstyle = stylelowered!
end type
global uo_ddlb_nexthakgi uo_ddlb_nexthakgi

on uo_ddlb_nexthakgi.create
end on

on uo_ddlb_nexthakgi.destroy
end on

event constructor;string	ls_hakgi

SELECT	NEXT_HAKGI
INTO		:ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE		SIJUM_FLAG = 'Y'
;

this.text	= ls_hakgi
end event

