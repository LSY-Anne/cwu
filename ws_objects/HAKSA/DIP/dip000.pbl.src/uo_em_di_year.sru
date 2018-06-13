$PBExportHeader$uo_em_di_year.sru
$PBExportComments$[대학원입시] editmask - 년도 검색조건용
forward
global type uo_em_di_year from editmask
end type
end forward

global type uo_em_di_year from editmask
integer width = 242
integer height = 80
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
global uo_em_di_year uo_em_di_year

on uo_em_di_year.create
end on

on uo_em_di_year.destroy
end on

event constructor;//string	ls_year
//
//ls_year	= f_haksa_iljung_year()
//
//this.text	= ls_year

string	ls_year

SELECT	NEXT_YEAR  
INTO		:ls_year  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE		SIJUM_FLAG = '1'
;

this.text = ls_year
end event

