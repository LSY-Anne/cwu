$PBExportHeader$cuo_year.sru
$PBExportComments$년도조회(예산/회계에서 사용)
forward
global type cuo_year from userobject
end type
type st_title from statictext within cuo_year
end type
type em_year from editmask within cuo_year
end type
type st_122 from statictext within cuo_year
end type
end forward

global type cuo_year from userobject
integer width = 677
integer height = 92
boolean border = true
long backcolor = 31112622
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
st_title st_title
em_year em_year
st_122 st_122
end type
global cuo_year cuo_year

type variables
string	is_year_title
end variables

forward prototypes
public function string uf_getyy ()
end prototypes

public function string uf_getyy ();string	ls_year

ls_year = em_year.text

return	ls_year

end function

on cuo_year.create
this.st_title=create st_title
this.em_year=create em_year
this.st_122=create st_122
this.Control[]={this.st_title,&
this.em_year,&
this.st_122}
end on

on cuo_year.destroy
destroy(this.st_title)
destroy(this.em_year)
destroy(this.st_122)
end on

event constructor;string	ls_yy

//st_title.text = is_year_title
ls_yy	= f_today()

em_year.text = left(ls_yy, 4)

end event

type st_title from statictext within cuo_year
integer x = 41
integer y = 16
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
boolean enabled = false
string text = "요구년도"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_year from editmask within cuo_year
integer x = 366
integer width = 283
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean autoskip = true
boolean spin = true
string minmax = "1900~~2999"
end type

event getfocus;selecttext(1, len(this.text))

end event

event modified;parent.triggerevent('ue_itemchange')
end event

type st_122 from statictext within cuo_year
integer width = 123
integer height = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

