$PBExportHeader$u_bottomtab.sru
forward
global type u_bottomtab from uo_tabselect
end type
end forward

global type u_bottomtab from uo_tabselect
string linecolor = "187.187.187"
string fontcolor = "108.157.197"
string selectfontcolor = "255,255,255"
string fontface = "돋움"
integer fontsize = 8
integer linethickness = 2
integer textleftrightgab = 15
boolean overlapstyle = true
boolean tabbuttom = true
string filepath = "..\img\tab\"
string front_select = "cl_con_bottom_tab_left.gif"
string back_select = "cl_con_bottom_tab_midle.gif"
string end_select = "cl_con_bottom_tab_right.gif"
string front_nonselect = "con_bottom_tab_left.gif"
string back_nonselect = "con_bottom_tab_midle.gif"
string end_nonselect = "con_bottom_tab_right.gif"
boolean ib_close = false
end type
global u_bottomtab u_bottomtab

on u_bottomtab.create
call super::create
end on

on u_bottomtab.destroy
call super::destroy
end on

type st_text from uo_tabselect`st_text within u_bottomtab
end type

type hsb_1 from uo_tabselect`hsb_1 within u_bottomtab
end type

type p_1 from uo_tabselect`p_1 within u_bottomtab
end type

type designedw from uo_tabselect`designedw within u_bottomtab
end type

type ln_1 from uo_tabselect`ln_1 within u_bottomtab
end type

type p_close from uo_tabselect`p_close within u_bottomtab
end type

