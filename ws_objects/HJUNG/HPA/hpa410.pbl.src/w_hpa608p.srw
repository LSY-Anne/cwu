$PBExportHeader$w_hpa608p.srw
$PBExportComments$소득세 징수액 집계표 출력
forward
global type w_hpa608p from w_print_form3
end type
type em_1 from editmask within w_hpa608p
end type
type rb_1 from radiobutton within w_hpa608p
end type
type rb_2 from radiobutton within w_hpa608p
end type
type rb_3 from radiobutton within w_hpa608p
end type
type em_zoom from editmask within w_hpa608p
end type
end forward

global type w_hpa608p from w_print_form3
string title = "소득세 징수액 집계표 출력"
em_1 em_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
em_zoom em_zoom
end type
global w_hpa608p w_hpa608p

type variables


end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_getchild ();//// ==========================================================================================
//// 기    능 : 	getchild
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 함수원형 : 	wf_getchild()
//// 인    수 :
//// 되 돌 림 :
//// 주의사항 :
//// 수정사항 :
//// ==========================================================================================
//
//// 직위코드
//dw_print.getchild('hin001m_jikwi_code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('jikwi_code', 0) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//
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

string	ls_jikjong, ls_jaejik



if ii_str_jikjong = 0 then
	ls_jikjong	=	''
else
	ls_jikjong	=	string(ii_str_jikjong)
end if

if rb_1.checked then
	dw_print.dataobject = 'd_hpa608p_1'		// 전체(5명포함)
	ls_jaejik	=	'%'
elseif rb_2.checked then
	dw_print.dataobject = 'd_hpa608p_2'		//	재직
	ls_jaejik	=	'1'
else
	dw_print.dataobject = 'd_hpa608p_3'		// 전체퇴직
	ls_jaejik	=	'3'
end if
//messagebox('',ls_jikjong)
dw_print.settransobject(sqlca)
dw_print.object.datawindow.print.preview = 'yes'

if dw_print.retrieve(is_year, ls_jikjong) > 0 then

end if

//em_1.triggerevent(modified!)

return 0

end function

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

on w_hpa608p.create
int iCurrent
call super::create
this.em_1=create em_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.em_zoom=create em_zoom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.em_zoom
end on

on w_hpa608p.destroy
call super::destroy
destroy(this.em_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.em_zoom)
end on

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력 처리
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

IF dw_print.RowCount() < 1 THEN	return

OpenWithParm(w_printoption, dw_print)

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

//wf_SetMenu('FIRST', 	TRUE)
//wf_SetMenu('NEXT', 	TRUE)
//wf_SetMenu('PRE', 	TRUE)
//wf_SetMenu('LAST', 	TRUE)



end event

event ue_first;call super::ue_first;dw_print.scrolltorow(1)
end event

event ue_last;call super::ue_last;dw_print.scrolltorow(dw_print.rowcount())
end event

event ue_next;call super::ue_next;dw_print.scrollpriorpage()
end event

event ue_prior;call super::ue_prior;dw_print.scrollnextpage()
end event

type ln_templeft from w_print_form3`ln_templeft within w_hpa608p
end type

type ln_tempright from w_print_form3`ln_tempright within w_hpa608p
end type

type ln_temptop from w_print_form3`ln_temptop within w_hpa608p
end type

type ln_tempbuttom from w_print_form3`ln_tempbuttom within w_hpa608p
end type

type ln_tempbutton from w_print_form3`ln_tempbutton within w_hpa608p
end type

type ln_tempstart from w_print_form3`ln_tempstart within w_hpa608p
end type

type uc_retrieve from w_print_form3`uc_retrieve within w_hpa608p
end type

type uc_insert from w_print_form3`uc_insert within w_hpa608p
end type

type uc_delete from w_print_form3`uc_delete within w_hpa608p
end type

type uc_save from w_print_form3`uc_save within w_hpa608p
end type

type uc_excel from w_print_form3`uc_excel within w_hpa608p
end type

type uc_print from w_print_form3`uc_print within w_hpa608p
end type

type st_line1 from w_print_form3`st_line1 within w_hpa608p
end type

type st_line2 from w_print_form3`st_line2 within w_hpa608p
end type

type st_line3 from w_print_form3`st_line3 within w_hpa608p
end type

type uc_excelroad from w_print_form3`uc_excelroad within w_hpa608p
end type

type ln_dwcon from w_print_form3`ln_dwcon within w_hpa608p
end type

type uo_year from w_print_form3`uo_year within w_hpa608p
end type

type gb_3 from w_print_form3`gb_3 within w_hpa608p
end type

type dw_print from w_print_form3`dw_print within w_hpa608p
integer taborder = 60
string dataobject = "d_hpa608p_1"
end type

type st_1 from w_print_form3`st_1 within w_hpa608p
integer x = 974
end type

type dw_head from w_print_form3`dw_head within w_hpa608p
integer x = 1207
integer width = 777
end type

type uo_dept_code from w_print_form3`uo_dept_code within w_hpa608p
boolean visible = false
end type

type st_2 from w_print_form3`st_2 within w_hpa608p
boolean visible = false
integer width = 549
end type

type st_3 from w_print_form3`st_3 within w_hpa608p
boolean visible = false
end type

type dw_con from w_print_form3`dw_con within w_hpa608p
end type

type em_1 from editmask within w_hpa608p
boolean visible = false
integer x = 2368
integer y = 12
integer width = 242
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "100"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##0"
boolean spin = true
string minmax = "0~~300"
end type

event modified;dw_print.object.datawindow.zoom	= this.text

if this.text <= '80' then
	dw_print.object.datawindow.print.paper.size = 9
else
	dw_print.object.datawindow.print.paper.size = 8
end if	
end event

type rb_1 from radiobutton within w_hpa608p
integer x = 2322
integer y = 68
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
string text = "전체"
boolean checked = true
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

//wf_getchild2()


end event

type rb_2 from radiobutton within w_hpa608p
integer x = 2587
integer y = 68
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "재직"
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

//wf_getchild2()

end event

type rb_3 from radiobutton within w_hpa608p
integer x = 2853
integer y = 68
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "퇴직"
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)

end event

type em_zoom from editmask within w_hpa608p
integer x = 1906
integer y = 52
integer width = 206
integer height = 76
integer taborder = 80
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

event constructor;if gs_empcode = '0109035' then
	this.visible = true
else
	this.visible = false
end if

end event

event modified;dw_print.object.datawindow.zoom	= this.text

if this.text <= '80' then
	dw_print.object.datawindow.print.paper.size = 9
else
	dw_print.object.datawindow.print.paper.size = 8
end if	
end event

