$PBExportHeader$uo_date.sru
$PBExportComments$[청운대]editmask - 년월일 검색용
forward
global type uo_date from editmask
end type
end forward

global type uo_date from editmask
integer width = 457
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy.mm.dd"
boolean autoskip = true
boolean spin = true
end type
global uo_date uo_date

on uo_date.create
end on

on uo_date.destroy
end on

event constructor;
string ls_date

select to_char(sysdate,'yyyy/mm/dd')
into :ls_date
from dual;

this.text = ls_date
end event

