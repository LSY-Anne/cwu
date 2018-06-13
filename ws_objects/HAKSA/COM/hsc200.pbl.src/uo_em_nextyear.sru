$PBExportHeader$uo_em_nextyear.sru
$PBExportComments$[청운대]next년도 검색조건용(등록)
forward
global type uo_em_nextyear from editmask
end type
end forward

global type uo_em_nextyear from editmask
integer width = 242
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
global uo_em_nextyear uo_em_nextyear

on uo_em_nextyear.create
end on

on uo_em_nextyear.destroy
end on

event constructor;string	ls_year

SELECT	NEXT_YEAR
INTO		:ls_year
FROM		HAKSA.HAKSA_ILJUNG
WHERE		SIJUM_FLAG = 'Y'
;

this.text	= ls_year
end event

