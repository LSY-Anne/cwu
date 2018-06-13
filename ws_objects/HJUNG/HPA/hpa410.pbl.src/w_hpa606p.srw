$PBExportHeader$w_hpa606p.srw
$PBExportComments$근로소득 지급 명세서
forward
global type w_hpa606p from w_print_form3
end type
type rb_jae from radiobutton within w_hpa606p
end type
type rb_tae from radiobutton within w_hpa606p
end type
type rb_all from radiobutton within w_hpa606p
end type
end forward

global type w_hpa606p from w_print_form3
string title = "근로소득 지급 명세서 출력"
rb_jae rb_jae
rb_tae rb_tae
rb_all rb_all
end type
global w_hpa606p w_hpa606p

type variables
String	is_jaejik_opt
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


if is_jaejik_opt = '' or isnull(is_jaejik_opt) then is_jaejik_opt = '%'
if dw_print.retrieve(is_year, is_dept_code, ii_str_jikjong, ii_end_jikjong, is_jaejik_opt) > 0 then

end if

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

on w_hpa606p.create
int iCurrent
call super::create
this.rb_jae=create rb_jae
this.rb_tae=create rb_tae
this.rb_all=create rb_all
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_jae
this.Control[iCurrent+2]=this.rb_tae
this.Control[iCurrent+3]=this.rb_all
end on

on w_hpa606p.destroy
call super::destroy
destroy(this.rb_jae)
destroy(this.rb_tae)
destroy(this.rb_all)
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
is_jaejik_opt = '%'
end event

event ue_first;call super::ue_first;dw_print.scrolltorow(1)
end event

event ue_last;call super::ue_last;dw_print.scrolltorow(dw_print.rowcount())
end event

event ue_next;call super::ue_next;dw_print.scrollpriorpage()
end event

event ue_prior;call super::ue_prior;dw_print.scrollnextpage()
end event

type ln_templeft from w_print_form3`ln_templeft within w_hpa606p
end type

type ln_tempright from w_print_form3`ln_tempright within w_hpa606p
end type

type ln_temptop from w_print_form3`ln_temptop within w_hpa606p
end type

type ln_tempbuttom from w_print_form3`ln_tempbuttom within w_hpa606p
end type

type ln_tempbutton from w_print_form3`ln_tempbutton within w_hpa606p
end type

type ln_tempstart from w_print_form3`ln_tempstart within w_hpa606p
end type

type uc_retrieve from w_print_form3`uc_retrieve within w_hpa606p
end type

type uc_insert from w_print_form3`uc_insert within w_hpa606p
end type

type uc_delete from w_print_form3`uc_delete within w_hpa606p
end type

type uc_save from w_print_form3`uc_save within w_hpa606p
end type

type uc_excel from w_print_form3`uc_excel within w_hpa606p
end type

type uc_print from w_print_form3`uc_print within w_hpa606p
end type

type st_line1 from w_print_form3`st_line1 within w_hpa606p
end type

type st_line2 from w_print_form3`st_line2 within w_hpa606p
end type

type st_line3 from w_print_form3`st_line3 within w_hpa606p
end type

type uc_excelroad from w_print_form3`uc_excelroad within w_hpa606p
end type

type ln_dwcon from w_print_form3`ln_dwcon within w_hpa606p
end type

type uo_year from w_print_form3`uo_year within w_hpa606p
end type

type gb_3 from w_print_form3`gb_3 within w_hpa606p
end type

type dw_print from w_print_form3`dw_print within w_hpa606p
integer y = 272
integer height = 2248
integer taborder = 60
string dataobject = "d_hpa606p_1"
end type

type st_1 from w_print_form3`st_1 within w_hpa606p
end type

type dw_head from w_print_form3`dw_head within w_hpa606p
end type

type uo_dept_code from w_print_form3`uo_dept_code within w_hpa606p
end type

type st_2 from w_print_form3`st_2 within w_hpa606p
end type

type st_3 from w_print_form3`st_3 within w_hpa606p
end type

type dw_con from w_print_form3`dw_con within w_hpa606p
end type

type rb_jae from radiobutton within w_hpa606p
integer x = 837
integer y = 192
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 80263581
string text = "재직자"
end type

event clicked;is_jaejik_opt = '1'
end event

type rb_tae from radiobutton within w_hpa606p
integer x = 1339
integer y = 192
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 80263581
string text = "퇴직자"
end type

event clicked;is_jaejik_opt = '3'
end event

type rb_all from radiobutton within w_hpa606p
integer x = 1842
integer y = 192
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 80263581
string text = "전체"
boolean checked = true
end type

event clicked;is_jaejik_opt = '%'
end event

