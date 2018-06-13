$PBExportHeader$cuo_yearmonth_fromto.sru
$PBExportComments$년월조회(From,To)
forward
global type cuo_yearmonth_fromto from userobject
end type
type st_1 from statictext within cuo_yearmonth_fromto
end type
type em_end_yearmonth from editmask within cuo_yearmonth_fromto
end type
type st_title from statictext within cuo_yearmonth_fromto
end type
type st_122 from statictext within cuo_yearmonth_fromto
end type
type em_str_yearmonth from editmask within cuo_yearmonth_fromto
end type
end forward

global type cuo_yearmonth_fromto from userobject
integer width = 1161
integer height = 92
boolean border = true
long backcolor = 31112622
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
st_1 st_1
em_end_yearmonth em_end_yearmonth
st_title st_title
st_122 st_122
em_str_yearmonth em_str_yearmonth
end type
global cuo_yearmonth_fromto cuo_yearmonth_fromto

type variables
string	is_year_title
end variables

forward prototypes
public function integer uf_chk_date ()
public function string uf_end_getyearmonth ()
public subroutine uf_settitle (string as_title)
public function string uf_str_getyearmonth ()
end prototypes

public function integer uf_chk_date ();//// ------------------------------------------------------------------------------------------
//// Function Name	:	uf_str_getdate
//// Function 설명	:	일자를 체크한다.
//// Argument			:
//// Return			:	Integer
//// ------------------------------------------------------------------------------------------
//
//string	ls_str_date, ls_end_date
//
//ls_str_date =	em_str_date.text
//ls_str_date	=	left(ls_str_date, 4) + mid(ls_str_date, 5, 2) + right(ls_str_date, 2)
//
//ls_end_date =	em_end_date.text
//ls_end_date	=	left(ls_end_date, 4) + mid(ls_end_date, 5, 2) + right(ls_end_date, 2)
//
//if ls_end_date = '00000000' then	ls_end_date	=	'99999999'
//
//if ls_str_date > ls_end_date then
//	f_messagebox('1', is_year_title + '를 정확히 입력해 주시기 바랍니다.!')
//	em_str_date.setfocus()
//	return	100
//end if
//
return	0
end function

public function string uf_end_getyearmonth ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_end_getyearmonth
// Function 설명	:	일자를 가져온다.
// Argument			:
// Return			:	String(일자)
// ------------------------------------------------------------------------------------------

date		ldt_date
string	ls_bef_yearmonth

ls_bef_yearmonth	=	 em_end_yearmonth.text

if em_end_yearmonth.getdata(ldt_date) < 0 then
	em_end_yearmonth.text = '000000'
	return	'999999'
end if

//if uf_chk_date() <> 0 then
//	em_end_date.text	=	ls_bef_yearmonth
//	return	ls_bef_yearmonth
//end if

return	string(ldt_date, 'yyyymm')

end function

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

public function string uf_str_getyearmonth ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_str_getyearmonth
// Function 설명	:	일자를 가져온다.
// Argument			:
// Return			:	String(일자)
// ------------------------------------------------------------------------------------------

date		ldt_date
string	ls_bef_yearmonth

ls_bef_yearmonth	=	 em_str_yearmonth.text

if em_str_yearmonth.getdata(ldt_date) < 0 then
	em_str_yearmonth.text = '000000'
	return	'999999'
end if

//if uf_chk_date() <> 0 then
//	em_end_date.text	=	ls_bef_yearmonth
//	return	ls_bef_yearmonth
//end if

return	string(ldt_date, 'yyyymm')

end function

on cuo_yearmonth_fromto.create
this.st_1=create st_1
this.em_end_yearmonth=create em_end_yearmonth
this.st_title=create st_title
this.st_122=create st_122
this.em_str_yearmonth=create em_str_yearmonth
this.Control[]={this.st_1,&
this.em_end_yearmonth,&
this.st_title,&
this.st_122,&
this.em_str_yearmonth}
end on

on cuo_yearmonth_fromto.destroy
destroy(this.st_1)
destroy(this.em_end_yearmonth)
destroy(this.st_title)
destroy(this.st_122)
destroy(this.em_str_yearmonth)
end on

event constructor;em_str_yearmonth.text = string(f_today(), '@@@@/@@')
em_end_yearmonth.text = em_str_yearmonth.text



end event

type st_1 from statictext within cuo_yearmonth_fromto
integer x = 709
integer y = 16
integer width = 59
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
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_end_yearmonth from editmask within cuo_yearmonth_fromto
integer x = 786
integer width = 361
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
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

type st_title from statictext within cuo_yearmonth_fromto
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
string text = "기준년월"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_122 from statictext within cuo_yearmonth_fromto
integer width = 123
integer height = 100
integer textsize = -9
integer weight = 700
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

type em_str_yearmonth from editmask within cuo_yearmonth_fromto
integer x = 343
integer width = 361
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
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

