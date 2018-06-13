$PBExportHeader$u_tooltab.sru
forward
global type u_tooltab from uo_tabselect
end type
end forward

global type u_tooltab from uo_tabselect
integer height = 408
string linecolor = "215,217,222"
string fontcolor = "53,122,177"
string _backcolor = "255,255,255"
string selectfontcolor = "255,255,255"
string fontface = "돋음"
integer fontsize = 9
integer imggabpix = 2
integer linethickness = 3
integer textgaby = 1
integer closewinxgab = 10
integer closewinygab = 2
integer textleftrightgab = 20
boolean overlapstyle = true
boolean tooltab = true
string filepath = "..\img\tab\"
string front_select = "top_tab_selected_left_s.gif"
string back_select = "top_tab_selected_back.gif"
string end_select = "top_tab_selected_right.gif"
string front_nonselect = "top_tab_left_s.gif"
string back_nonselect = "top_tab_back.gif"
string end_nonselect = "top_tab_right.gif"
string buttom_imag = "tooltab_line.gif"
end type
global u_tooltab u_tooltab

forward prototypes
public function integer resize (integer w, integer h)
end prototypes

public function integer resize (integer w, integer h);of_scrollset()

return 1
end function

on u_tooltab.create
call super::create
end on

on u_tooltab.destroy
call super::destroy
end on

type st_text from uo_tabselect`st_text within u_tooltab
end type

type hsb_1 from uo_tabselect`hsb_1 within u_tooltab
end type

type p_1 from uo_tabselect`p_1 within u_tooltab
end type

type designedw from uo_tabselect`designedw within u_tooltab
end type

type ln_1 from uo_tabselect`ln_1 within u_tooltab
end type

type p_close from uo_tabselect`p_close within u_tooltab
end type

