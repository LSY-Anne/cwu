$PBExportHeader$cuo_editmask_num.sru
$PBExportComments$숫자키만을 입력하게 만들었슴.
forward
global type cuo_editmask_num from editmask
end type
end forward

global type cuo_editmask_num from editmask
integer width = 247
integer height = 100
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
event key_down pbm_keydown
end type
global cuo_editmask_num cuo_editmask_num

event key_down;//////////////////////////////////////////////////////////////////
// 	작성목적 : 숫자 키만을 입력 받을수 있는 Editmask
//    적 성 인 : 문준영
//		작성일자 : 2001.07
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

Long l_code
IF f_isnumkey(key) then
	l_code = 0
else
	l_code = 1
	MessageBox('확인','숫자만을 입력할수 있습니다.')
end IF
//return l_code
end event

on cuo_editmask_num.create
end on

on cuo_editmask_num.destroy
end on

