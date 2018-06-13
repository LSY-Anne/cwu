$PBExportHeader$cuo_yearschoolterm.sru
$PBExportComments$년도,학기조회
forward
global type cuo_yearschoolterm from userobject
end type
type em_term from editmask within cuo_yearschoolterm
end type
type em_year from editmask within cuo_yearschoolterm
end type
type st_2 from statictext within cuo_yearschoolterm
end type
type st_1 from statictext within cuo_yearschoolterm
end type
type st_12131 from statictext within cuo_yearschoolterm
end type
type st_122 from statictext within cuo_yearschoolterm
end type
end forward

global type cuo_yearschoolterm from userobject
integer width = 992
integer height = 100
long backcolor = 31112622
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
em_term em_term
em_year em_year
st_2 st_2
st_1 st_1
st_12131 st_12131
st_122 st_122
end type
global cuo_yearschoolterm cuo_yearschoolterm

forward prototypes
public function string uf_getyy ()
public function string uf_gethakgi ()
end prototypes

public function string uf_getyy ();String  ls_Year

ls_Year  = em_year.text 
return ls_Year
end function

public function string uf_gethakgi ();String ls_Hakgi

ls_Hakgi   = em_term.text 
return ls_Hakgi
end function

on cuo_yearschoolterm.create
this.em_term=create em_term
this.em_year=create em_year
this.st_2=create st_2
this.st_1=create st_1
this.st_12131=create st_12131
this.st_122=create st_122
this.Control[]={this.em_term,&
this.em_year,&
this.st_2,&
this.st_1,&
this.st_12131,&
this.st_122}
end on

on cuo_yearschoolterm.destroy
destroy(this.em_term)
destroy(this.em_year)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_12131)
destroy(this.st_122)
end on

event constructor;em_year.text    = left(f_today(),4)
CHOOSE CASE mid(f_today(),5,2)
	CASE '03','04','05','06'
		em_term.text = '1'
	CASE '07','08'
		em_term.text = '3'
	CASE '09','10','11','12'
		em_term.text = '2'
	CASE '01','02'
		em_term.text = '4'
END CHOOSE


end event

type em_term from editmask within cuo_yearschoolterm
integer x = 741
integer y = 4
integer width = 247
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "1~~4"
end type

type em_year from editmask within cuo_yearschoolterm
integer x = 229
integer y = 4
integer width = 325
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "2000~~2010"
end type

type st_2 from statictext within cuo_yearschoolterm
integer x = 567
integer y = 16
integer width = 174
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within cuo_yearschoolterm
integer x = 5
integer y = 16
integer width = 215
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_12131 from statictext within cuo_yearschoolterm
integer x = 5
integer y = 4
integer width = 219
integer height = 96
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_122 from statictext within cuo_yearschoolterm
integer x = 562
integer width = 123
integer height = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

