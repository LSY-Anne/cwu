$PBExportHeader$uo_di_name.sru
$PBExportComments$[대학원입시] 성명검색용
forward
global type uo_di_name from uo_sle
end type
end forward

global type uo_di_name from uo_sle
integer width = 338
end type
global uo_di_name uo_di_name

on uo_di_name.create
end on

on uo_di_name.destroy
end on

event modified;call super::modified;f_pro_toggle('K', Handle(THIS)) 
end event

