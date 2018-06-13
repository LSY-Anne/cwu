$PBExportHeader$cuo_search.sru
$PBExportComments$검색조건(코드와 명칭으로 검색)
forward
global type cuo_search from userobject
end type
type st_remark from statictext within cuo_search
end type
type rb_1 from radiobutton within cuo_search
end type
type rb_2 from radiobutton within cuo_search
end type
type pb_find from picturebutton within cuo_search
end type
type sle_name from singlelineedit within cuo_search
end type
end forward

global type cuo_search from userobject
integer width = 3762
integer height = 96
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchanged pbm_custom01
st_remark st_remark
rb_1 rb_1
rb_2 rb_2
pb_find pb_find
sle_name sle_name
end type
global cuo_search cuo_search

type variables
datawindow	idw_cuo_search_dw

end variables

forward prototypes
public subroutine uf_reset (datawindow aobj_dw, string as_col_code, string as_col_name)
end prototypes

public subroutine uf_reset (datawindow aobj_dw, string as_col_code, string as_col_name);// ------------------------------------------------------------------------------------------
// Function Name	:	uf_reset
// Function 설명	:	조건을 Reset한다.
//	Argument			:	aobj_dw(Datawindow)	: 검색할 데이타윈도우
//							as_col_code(String)	:	검색코드컬럼명칭
//							as_col_name(String)	:	검색명칭컬럼명칭
//	Return			:	
// ------------------------------------------------------------------------------------------

idw_cuo_search_dw	=	aobj_dw
rb_1.tag	=	as_col_code
rb_2.tag	=	as_col_name

sle_name.tag	=	as_col_code

if rb_1.checked then
	rb_1.triggerevent(clicked!)
else
	rb_2.triggerevent(clicked!)
end if	
end subroutine

on cuo_search.create
this.st_remark=create st_remark
this.rb_1=create rb_1
this.rb_2=create rb_2
this.pb_find=create pb_find
this.sle_name=create sle_name
this.Control[]={this.st_remark,&
this.rb_1,&
this.rb_2,&
this.pb_find,&
this.sle_name}
end on

on cuo_search.destroy
destroy(this.st_remark)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.pb_find)
destroy(this.sle_name)
end on

type st_remark from statictext within cuo_search
integer x = 1687
integer y = 16
integer width = 2062
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "계정과목코드 또는 계정과목명으로 자료를 검색할 수 있습니다. "
boolean focusrectangle = false
end type

type rb_1 from radiobutton within cuo_search
integer y = 16
integer width = 320
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "코드검색"
boolean checked = true
end type

event clicked;sle_name.tag	=	this.tag

sle_name.setfocus()
end event

type rb_2 from radiobutton within cuo_search
integer x = 338
integer y = 16
integer width = 311
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "명칭검색"
end type

event clicked;sle_name.tag	=	this.tag

sle_name.setfocus()
end event

type pb_find from picturebutton within cuo_search
integer x = 1545
integer width = 110
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "..\img\icon\ib_search.gif"
end type

event clicked;string	ls_acctname, ls_type, ls_condition
long		ll_row

ls_acctname = trim(sle_name.text)

if ls_acctname = '' then return

if idw_cuo_search_dw.getrow() + 1 > idw_cuo_search_dw.rowcount() then
	ll_row = 0
else
	ll_row = idw_cuo_search_dw.getrow() + 1
end if

//ll_row = idw_cuo_search_dw.Find("pos(" + sle_name.tag + ", '" + ls_acctname + "') > 0", ll_row, idw_cuo_search_dw.RowCount())
ls_type 	= idw_cuo_search_dw.describe(sle_name.tag + ".coltype")

// 데이타윈도우의 컬럼 타입을 알아낸다.
if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	ls_condition	=	sle_name.tag +	"	=	"	+ ls_acctname
elseif ls_type = 'date' then
	ls_condition	=	sle_name.tag +	"	=	'"	+ ls_acctname + "'	"
elseif ls_type = 'datetime' then
	ls_condition	=	sle_name.tag +	"	=	'"	+ ls_acctname + "'	"
else	
	ls_condition	=	"pos(" + sle_name.tag + ", '" + ls_acctname + "') > 0"
end if

ll_row = idw_cuo_search_dw.Find(ls_condition, ll_row, idw_cuo_search_dw.RowCount())

if ll_row < 1 then	ll_row = idw_cuo_search_dw.Find(ls_condition, 1, idw_cuo_search_dw.RowCount())

if ll_row < 1 then return

idw_cuo_search_dw.scrolltorow(ll_row)
idw_cuo_search_dw.setfocus()

sle_name.setfocus()

end event

type sle_name from singlelineedit within cuo_search
event ue_dwnprocessenter ( )
event ue_keydown pbm_keydown
integer x = 686
integer y = 8
integer width = 855
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "해당 자료 검색!"
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

event ue_keydown;if key = KeyEnter! and keyflags = 0 then
	pb_find.triggerevent(clicked!)
end if
end event

event getfocus;selecttext(1, len(this.text))

end event

