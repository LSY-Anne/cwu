$PBExportHeader$uo_di_suhum.sru
$PBExportComments$[대학원입시] 학번검색용
forward
global type uo_di_suhum from uo_sle
end type
end forward

global type uo_di_suhum from uo_sle
integer width = 338
integer limit = 6
end type
global uo_di_suhum uo_di_suhum

on uo_di_suhum.create
end on

on uo_di_suhum.destroy
end on

event getfocus;call super::getfocus;f_pro_toggle('E', Handle(THIS)) 
end event

