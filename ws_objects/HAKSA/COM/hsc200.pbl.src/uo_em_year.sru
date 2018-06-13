$PBExportHeader$uo_em_year.sru
$PBExportComments$[청운대]년도 검색조건용 editmask
forward
global type uo_em_year from editmask
end type
end forward

global type uo_em_year from editmask
integer width = 240
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean autoskip = true
boolean spin = true
double increment = 1
end type
global uo_em_year uo_em_year

on uo_em_year.create
end on

on uo_em_year.destroy
end on

event constructor;string	ls_year

ls_year	= f_haksa_iljung_year()

this.text	= ls_year
end event

