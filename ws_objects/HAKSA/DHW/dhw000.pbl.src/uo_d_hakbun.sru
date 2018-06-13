$PBExportHeader$uo_d_hakbun.sru
$PBExportComments$[대학원] 학번검색용
forward
global type uo_d_hakbun from uo_sle
end type
end forward

global type uo_d_hakbun from uo_sle
integer limit = 9
end type
global uo_d_hakbun uo_d_hakbun

on uo_d_hakbun.create
end on

on uo_d_hakbun.destroy
end on

event getfocus;call super::getfocus;f_pro_toggle('E', Handle(THIS)) 
end event

