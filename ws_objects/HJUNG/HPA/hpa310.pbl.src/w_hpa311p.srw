$PBExportHeader$w_hpa311p.srw
$PBExportComments$명절휴가비 대장 출력
forward
global type w_hpa311p from w_print_form2
end type
type dw_display_title from cuo_display_title within w_hpa311p
end type
type st_5 from statictext within w_hpa311p
end type
type st_9 from statictext within w_hpa311p
end type
type dw_print2 from datawindow within w_hpa311p
end type
type pb_print from picturebutton within w_hpa311p
end type
type em_zoom from editmask within w_hpa311p
end type
end forward

global type w_hpa311p from w_print_form2
string title = "명절 휴가비 대장 출력"
dw_display_title dw_display_title
st_5 st_5
st_9 st_9
dw_print2 dw_print2
pb_print pb_print
em_zoom em_zoom
end type
global w_hpa311p w_hpa311p

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 보직코드
dw_print.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if


end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_tab
string	ls_jikjong_code

if ii_str_jikjong = 0 then
	ls_jikjong_code = ''
else
	ls_jikjong_code = string(ii_str_jikjong)
end if

dw_print2.visible		=	false
pb_print.text			=	'   표지보이기'
st_back.bringtotop 	=	true

if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong) > 0 then
	dw_print2.retrieve(is_yearmonth, is_dept_code, ls_jikjong_code, '22')
	st_back.bringtotop 	= 	false
	pb_print.enabled		=	true
else
	dw_print.reset()
	dw_print2.reset()
	pb_print.enabled		=	false
end if

return	0
end function

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

on w_hpa311p.create
int iCurrent
call super::create
this.dw_display_title=create dw_display_title
this.st_5=create st_5
this.st_9=create st_9
this.dw_print2=create dw_print2
this.pb_print=create pb_print
this.em_zoom=create em_zoom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_display_title
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_9
this.Control[iCurrent+4]=this.dw_print2
this.Control[iCurrent+5]=this.pb_print
this.Control[iCurrent+6]=this.em_zoom
end on

on w_hpa311p.destroy
call super::destroy
destroy(this.dw_display_title)
destroy(this.st_5)
destroy(this.st_9)
destroy(this.dw_print2)
destroy(this.pb_print)
destroy(this.em_zoom)
end on

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력 처리
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

if dw_print2.visible then
	IF dw_print2.RowCount() < 1 THEN	return

	OpenWithParm(w_printoption, dw_print2)
else
	IF dw_print.RowCount() < 1 THEN	return

	OpenWithParm(w_printoption, dw_print)
end if

end event

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

wf_getchild()

dw_print2.object.datawindow.print.preview = 'yes'
dw_print2.visible = false
end event

type st_back from w_print_form2`st_back within w_hpa311p
integer y = 204
end type

type dw_print from w_print_form2`dw_print within w_hpa311p
integer y = 204
string dataobject = "d_hpa311p_1"
end type

event dw_print::retrieveend;call super::retrieveend;dw_display_title.uf_display_title(this, 0)

end event

type st_1 from w_print_form2`st_1 within w_hpa311p
integer y = 72
end type

type dw_head from w_print_form2`dw_head within w_hpa311p
integer y = 56
integer width = 818
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa311p
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa311p
end type

type st_2 from w_print_form2`st_2 within w_hpa311p
boolean visible = false
end type

type st_3 from w_print_form2`st_3 within w_hpa311p
boolean visible = false
end type

type dw_display_title from cuo_display_title within w_hpa311p
boolean visible = false
integer x = 1600
integer y = 80
integer taborder = 40
boolean bringtotop = true
end type

event constructor;call super::constructor;settransobject(sqlca)

end event

type st_5 from statictext within w_hpa311p
boolean visible = false
integer x = 3291
integer y = 72
integer width = 242
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "보기배율"
boolean focusrectangle = false
end type

type st_9 from statictext within w_hpa311p
boolean visible = false
integer x = 3762
integer y = 72
integer width = 59
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "%"
boolean focusrectangle = false
end type

type dw_print2 from datawindow within w_hpa311p
boolean visible = false
integer y = 204
integer width = 3881
integer height = 2336
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa311p_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type pb_print from picturebutton within w_hpa311p
boolean visible = false
integer x = 3355
integer y = 44
integer width = 475
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "     표지보이기"
string picturename = "..\bmp\query_e.BMP"
string disabledname = "..\bmp\query_d.BMP"
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;if dw_print2.rowcount() < 1 then	return

if	dw_print2.visible	then
	this.text	=	'   표지보이기'
	dw_print2.visible = false
else
	this.text	=	'   표지감추기'
	dw_print2.visible = true
end if

end event

type em_zoom from editmask within w_hpa311p
integer x = 3141
integer y = 60
integer width = 206
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "100"
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean autoskip = true
boolean spin = true
double increment = 10
string minmax = "50~~400"
end type

event modified;dw_print.object.datawindow.zoom	= this.text

if this.text <= '80' then
	dw_print.object.datawindow.print.paper.size = 9
else
	dw_print.object.datawindow.print.paper.size = 8
end if	
end event

event constructor;if gs_empcode = '0109035' then
	this.visible = true
else
	this.visible = false
end if

end event

