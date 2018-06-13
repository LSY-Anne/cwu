$PBExportHeader$cuo_date.sru
$PBExportComments$일자조회
forward
global type cuo_date from userobject
end type
type st_title from statictext within cuo_date
end type
type st_122 from statictext within cuo_date
end type
type em_date from editmask within cuo_date
end type
end forward

global type cuo_date from userobject
integer width = 850
integer height = 96
boolean border = true
long backcolor = 31112622
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
st_title st_title
st_122 st_122
em_date em_date
end type
global cuo_date cuo_date

type variables
string	is_year_title
end variables

forward prototypes
public subroutine uf_settitle (string as_title)
public function string uf_getdate ()
public subroutine uf_enabled (boolean ab_enabled)
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

public function string uf_getdate ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_getdate
// Function 설명	:	일자를 가져온다.
// Argument			:
// Return			:	String(일자)
// ------------------------------------------------------------------------------------------

date		ldt_date
string	ls_bef_date

ls_bef_date	=	 em_date.text

if em_date.getdata(ldt_date) < 0 then
	f_messagebox('1', st_title.text + '을 정확히 입력해 주시기 바랍니다.!')
	em_date.text = ls_bef_date
	return	''
end if

return	string(ldt_date, 'yyyymmdd')

end function

public subroutine uf_enabled (boolean ab_enabled);em_date.enabled	=	ab_enabled

end subroutine

on cuo_date.create
this.st_title=create st_title
this.st_122=create st_122
this.em_date=create em_date
this.Control[]={this.st_title,&
this.st_122,&
this.em_date}
end on

on cuo_date.destroy
destroy(this.st_title)
destroy(this.st_122)
destroy(this.em_date)
end on

event constructor;em_date.text = string(f_today(), '@@@@/@@/@@')

end event

type st_title from statictext within cuo_date
integer x = 18
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
string text = "기준일자"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_122 from statictext within cuo_date
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

type em_date from editmask within cuo_date
integer x = 343
integer width = 489
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
string mask = "yyyy/mm/dd"
boolean autoskip = true
boolean spin = true
string minmax = "190001~~299912"
end type

event modified;parent.triggerevent('ue_itemchange')


end event

event getfocus;selecttext(1, len(this.text))
end event

