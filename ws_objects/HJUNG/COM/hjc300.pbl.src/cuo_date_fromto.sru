$PBExportHeader$cuo_date_fromto.sru
$PBExportComments$일자조회
forward
global type cuo_date_fromto from userobject
end type
type st_1 from statictext within cuo_date_fromto
end type
type em_end_date from editmask within cuo_date_fromto
end type
type st_title from statictext within cuo_date_fromto
end type
type st_122 from statictext within cuo_date_fromto
end type
type em_str_date from editmask within cuo_date_fromto
end type
end forward

global type cuo_date_fromto from userobject
integer width = 1317
integer height = 92
boolean border = true
long backcolor = 80269524
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
st_1 st_1
em_end_date em_end_date
st_title st_title
st_122 st_122
em_str_date em_str_date
end type
global cuo_date_fromto cuo_date_fromto

type variables
string	is_year_title
end variables

forward prototypes
public subroutine uf_settitle (string as_title)
public function string uf_str_getdate ()
public subroutine uf_enabled (boolean ab_enabled)
public function string uf_end_getdate ()
public function integer uf_chk_date ()
end prototypes

public subroutine uf_settitle (string as_title);// ------------------------------------------------------------------------------------------
// Function Name	:	uf_settitle
// Function 설명	:	제목을 변경한다.
// Argument			:	String(as_title)
// Return			:	
// ------------------------------------------------------------------------------------------

if trim(as_title) = '' then
	st_title.text = '기준일자'
else
	st_title.text = as_title
end if	
end subroutine

public function string uf_str_getdate ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_str_getdate
// Function 설명	:	Start 일자를 가져온다.
// Argument			:
// Return			:	String(일자)
// ------------------------------------------------------------------------------------------

date		ldt_date
string	ls_bef_date

ls_bef_date	=	 em_str_date.text

if em_str_date.getdata(ldt_date) < 0 then
//	f_messagebox('1', st_title.text + '(F)을 정확히 입력해 주시기 바랍니다.!')
	em_str_date.text = '00000000'
	return	'00000000'
end if

if uf_chk_date() <> 0 then
	em_str_date.text	=	ls_bef_date
	return	ls_bef_date
end if

return	string(ldt_date, 'yyyymmdd')

end function

public subroutine uf_enabled (boolean ab_enabled);em_str_date.enabled	=	ab_enabled
em_end_date.enabled	=	ab_enabled
end subroutine

public function string uf_end_getdate ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_end_getdate
// Function 설명	:	일자를 가져온다.
// Argument			:
// Return			:	String(일자)
// ------------------------------------------------------------------------------------------

date		ldt_date
string	ls_bef_date

ls_bef_date	=	 em_end_date.text

if em_end_date.getdata(ldt_date) < 0 then
//	f_messagebox('1', st_title.text + '을 정확히 입력해 주시기 바랍니다.!')
	em_end_date.text = '000000000'
	return	'99999999'
end if

if uf_chk_date() <> 0 then
	em_end_date.text	=	ls_bef_date
	return	ls_bef_date
end if

return	string(ldt_date, 'yyyymmdd')

end function

public function integer uf_chk_date ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_str_getdate
// Function 설명	:	일자를 체크한다.
// Argument			:
// Return			:	Integer
// ------------------------------------------------------------------------------------------

string	ls_str_date, ls_end_date

ls_str_date =	em_str_date.text
ls_str_date	=	left(ls_str_date, 4) + mid(ls_str_date, 6, 2) + right(ls_str_date, 2)

ls_end_date =	em_end_date.text
ls_end_date	=	left(ls_end_date, 4) + mid(ls_end_date, 6, 2) + right(ls_end_date, 2)

if ls_end_date = '00000000' then	ls_end_date	=	'99999999'

if ls_str_date > ls_end_date then
	em_end_date.text	=	em_str_date.text
	em_end_date.setfocus()
	return	100
end if

return	0
end function

on cuo_date_fromto.create
this.st_1=create st_1
this.em_end_date=create em_end_date
this.st_title=create st_title
this.st_122=create st_122
this.em_str_date=create em_str_date
this.Control[]={this.st_1,&
this.em_end_date,&
this.st_title,&
this.st_122,&
this.em_str_date}
end on

on cuo_date_fromto.destroy
destroy(this.st_1)
destroy(this.em_end_date)
destroy(this.st_title)
destroy(this.st_122)
destroy(this.em_str_date)
end on

event constructor;em_str_date.text = string(f_today(), '@@@@/@@/@@')
em_end_date.text = string(f_today(), '@@@@/@@/@@')


end event

type st_1 from statictext within cuo_date_fromto
integer x = 791
integer y = 16
integer width = 59
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
boolean enabled = false
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_end_date from editmask within cuo_date_fromto
integer x = 864
integer width = 443
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
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

type st_title from statictext within cuo_date_fromto
integer x = 18
integer y = 16
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "기준일자"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_122 from statictext within cuo_date_fromto
integer width = 123
integer height = 100
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type em_str_date from editmask within cuo_date_fromto
integer x = 343
integer width = 443
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
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

