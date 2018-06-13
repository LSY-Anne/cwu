$PBExportHeader$cuo_search_insa.sru
$PBExportComments$검색조건(학번과 성명으로 검색)
forward
global type cuo_search_insa from userobject
end type
type st_remark from statictext within cuo_search_insa
end type
type rb_hakbun from radiobutton within cuo_search_insa
end type
type rb_name from radiobutton within cuo_search_insa
end type
type pb_find from picturebutton within cuo_search_insa
end type
type sle_name from singlelineedit within cuo_search_insa
end type
end forward

global type cuo_search_insa from userobject
integer width = 3794
integer height = 96
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchanged pbm_custom01
st_remark st_remark
rb_hakbun rb_hakbun
rb_name rb_name
pb_find pb_find
sle_name sle_name
end type
global cuo_search_insa cuo_search_insa

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
rb_hakbun.tag	=	as_col_code
rb_name.tag		=	as_col_name

sle_name.tag	=	as_col_code

end subroutine

on cuo_search_insa.create
this.st_remark=create st_remark
this.rb_hakbun=create rb_hakbun
this.rb_name=create rb_name
this.pb_find=create pb_find
this.sle_name=create sle_name
this.Control[]={this.st_remark,&
this.rb_hakbun,&
this.rb_name,&
this.pb_find,&
this.sle_name}
end on

on cuo_search_insa.destroy
destroy(this.st_remark)
destroy(this.rb_hakbun)
destroy(this.rb_name)
destroy(this.pb_find)
destroy(this.sle_name)
end on

type st_remark from statictext within cuo_search_insa
integer x = 1687
integer y = 28
integer width = 2062
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "번호 또는 성명으로 자료를 검색할 수 있습니다. "
boolean focusrectangle = false
end type

type rb_hakbun from radiobutton within cuo_search_insa
integer y = 20
integer width = 320
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "번호검색"
boolean checked = true
end type

event clicked;sle_name.tag	=	this.tag
sle_name.limit	=	10

sle_name.setfocus()
end event

type rb_name from radiobutton within cuo_search_insa
integer x = 338
integer y = 20
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "성명검색"
end type

event clicked;sle_name.tag	=	this.tag
sle_name.limit	=	20

sle_name.setfocus()
end event

type pb_find from picturebutton within cuo_search_insa
integer x = 1545
integer width = 110
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "..\img\icon\ib_search.gif"
end type

event clicked;string	ls_acctname
long		ll_row

ls_acctname = trim(sle_name.text)

if ls_acctname = '' then return

if idw_cuo_search_dw.getrow() + 1 > idw_cuo_search_dw.rowcount() then
	ll_row = 0
else
	ll_row = idw_cuo_search_dw.getrow() + 1
end if

ll_row = idw_cuo_search_dw.Find("pos(" + sle_name.tag + ", '" + ls_acctname + "') > 0", ll_row, idw_cuo_search_dw.RowCount())

if ll_row < 1 then	ll_row = idw_cuo_search_dw.Find("pos(" + sle_name.tag + ", '" + ls_acctname + "') > 0", 1, idw_cuo_search_dw.RowCount())

if ll_row < 1 then return

idw_cuo_search_dw.scrolltorow(ll_row)
idw_cuo_search_dw.setfocus()

sle_name.setfocus()
end event

type sle_name from singlelineedit within cuo_search_insa
event ue_dwnprocessenter ( )
event ue_keydown pbm_keydown
integer x = 686
integer y = 8
integer width = 855
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "해당 자료 검색!"
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = KeyEnter! and keyflags = 0 then
	pb_find.triggerevent(clicked!)
end if
end event

event getfocus;selecttext(1, len(this.text))
end event

