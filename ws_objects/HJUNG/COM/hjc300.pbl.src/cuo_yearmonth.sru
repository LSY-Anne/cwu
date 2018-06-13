$PBExportHeader$cuo_yearmonth.sru
$PBExportComments$년월조회
forward
global type cuo_yearmonth from userobject
end type
type st_title from statictext within cuo_yearmonth
end type
type st_122 from statictext within cuo_yearmonth
end type
type em_yearmonth from editmask within cuo_yearmonth
end type
end forward

global type cuo_yearmonth from userobject
integer width = 731
integer height = 96
boolean border = true
long backcolor = 31112622
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
st_title st_title
st_122 st_122
em_yearmonth em_yearmonth
end type
global cuo_yearmonth cuo_yearmonth

type variables
string	is_year_title
end variables

forward prototypes
public subroutine uf_settitle (string as_title)
public function string uf_getyearmonth ()
end prototypes

public subroutine uf_settitle (string as_title);// ------------------------------------------------------------------------------------------
// Function Name	:	uf_settitle
// Function 설명	:	제목을 변경한다.
// Argument			:	String(as_title)
// Return			:	
// ------------------------------------------------------------------------------------------

if trim(as_title) = '' then
	st_title.text = '기준년월'
else
	st_title.text = as_title
end if	
end subroutine

public function string uf_getyearmonth ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_getyearmonth
// Function 설명	:	년월을 가져온다.
// Argument			:
// Return			:	String(년월)
// ------------------------------------------------------------------------------------------

date		ldt_yearmonth
string	ls_bef_yearmonth

ls_bef_yearmonth	=	 em_yearmonth.text

if em_yearmonth.getdata(ldt_yearmonth) < 0 then
	f_messagebox('1', st_title.text + '을 정확히 입력해 주시기 바랍니다.!')
	em_yearmonth.text = ls_bef_yearmonth
	return	''
end if

return	string(ldt_yearmonth, 'yyyymm')

end function

on cuo_yearmonth.create
this.st_title=create st_title
this.st_122=create st_122
this.em_yearmonth=create em_yearmonth
this.Control[]={this.st_title,&
this.st_122,&
this.em_yearmonth}
end on

on cuo_yearmonth.destroy
destroy(this.st_title)
destroy(this.st_122)
destroy(this.em_yearmonth)
end on

event constructor;string	ls_yymm

ls_yymm	= left(f_today(), 6)

em_yearmonth.text = string(ls_yymm, '@@@@/@@')

end event

type st_title from statictext within cuo_yearmonth
integer x = 23
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
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "기준년월"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_122 from statictext within cuo_yearmonth
integer width = 123
integer height = 100
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 31112622
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type em_yearmonth from editmask within cuo_yearmonth
integer x = 343
integer width = 375
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm"
boolean autoskip = true
boolean spin = true
string minmax = "190001~~299912"
end type

event modified;parent.triggerevent('ue_itemchange')


end event

event getfocus;selecttext(1, len(this.text))
end event

