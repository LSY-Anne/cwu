$PBExportHeader$u_toptab.sru
forward
global type u_toptab from uo_topselect
end type
end forward

global type u_toptab from uo_topselect
string linecolor = "170,170,170"
string fontcolor = "255,255,255"
string selectfontcolor = "255,255,0"
string fontface = "Tahoma"
integer fontsize = 10
integer textgaby = 9
integer startmenu_xgab = 280
integer startmenu_ygab = 31
boolean overlapstyle = true
boolean topleftimg_originalsize = true
boolean toprightimg_originalsize = true
string filepath = "..\img\tlr_style\thema_1\"
string front_select = "topmenuleft.gif"
string back_select = "topmenucenter.gif"
string end_select = "topmenuright.gif"
string front_nonselect = "topmenuleft.gif"
string back_nonselect = "topmenucenter.gif"
string end_nonselect = "topmenuright.gif"
string left_img = "top_left.gif"
string center_img = "top_title.gif"
string right_img = "top_right.gif"
string buttom_imag = ""
end type
global u_toptab u_toptab

on u_toptab.create
call super::create
end on

on u_toptab.destroy
call super::destroy
end on

event constructor;call super::constructor;This.SetPosition(ToTop!)
end event

type st_text from uo_topselect`st_text within u_toptab
end type

type hsb_1 from uo_topselect`hsb_1 within u_toptab
end type

type p_1 from uo_topselect`p_1 within u_toptab
end type

type designedw from uo_topselect`designedw within u_toptab
integer x = 5
integer width = 2674
end type

type ln_1 from uo_topselect`ln_1 within u_toptab
end type

