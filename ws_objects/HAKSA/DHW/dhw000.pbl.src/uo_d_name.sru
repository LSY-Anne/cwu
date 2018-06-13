$PBExportHeader$uo_d_name.sru
$PBExportComments$[대학원] 성명검색용
forward
global type uo_d_name from uo_sle
end type
end forward

global type uo_d_name from uo_sle
integer width = 338
end type
global uo_d_name uo_d_name

on uo_d_name.create
end on

on uo_d_name.destroy
end on

event getfocus;call super::getfocus;f_pro_toggle('K', Handle(THIS)) 
end event

