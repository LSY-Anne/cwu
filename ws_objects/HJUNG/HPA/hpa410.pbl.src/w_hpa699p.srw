$PBExportHeader$w_hpa699p.srw
$PBExportComments$연말정산 직종별 건수조회
forward
global type w_hpa699p from w_print_form3
end type
type rb_1 from radiobutton within w_hpa699p
end type
type rb_2 from radiobutton within w_hpa699p
end type
type rb_3 from radiobutton within w_hpa699p
end type
type dw_list from uo_dwgrid within w_hpa699p
end type
end forward

global type w_hpa699p from w_print_form3
string title = "직장가입자보수총액통보서 출력"
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
dw_list dw_list
end type
global w_hpa699p w_hpa699p

type variables
integer	ii_jaejik_opt
end variables

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
STring ls_year
dw_con.accepttext()
ls_year = String(dw_con.object.year[1], 'yyyy')


if dw_list.retrieve(ls_year) > 0 then

else
	dw_list.reset()
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

on w_hpa699p.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_3
this.Control[iCurrent+4]=this.dw_list
end on

on w_hpa699p.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.dw_list)
end on

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력 처리
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

IF dw_print.RowCount() < 1 THEN	return

OpenWithParm(w_printoption, dw_print)

end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//wf_getchild()
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

//wf_getchild()
end event

type ln_templeft from w_print_form3`ln_templeft within w_hpa699p
end type

type ln_tempright from w_print_form3`ln_tempright within w_hpa699p
end type

type ln_temptop from w_print_form3`ln_temptop within w_hpa699p
end type

type ln_tempbuttom from w_print_form3`ln_tempbuttom within w_hpa699p
end type

type ln_tempbutton from w_print_form3`ln_tempbutton within w_hpa699p
end type

type ln_tempstart from w_print_form3`ln_tempstart within w_hpa699p
end type

type uc_retrieve from w_print_form3`uc_retrieve within w_hpa699p
end type

type uc_insert from w_print_form3`uc_insert within w_hpa699p
end type

type uc_delete from w_print_form3`uc_delete within w_hpa699p
end type

type uc_save from w_print_form3`uc_save within w_hpa699p
end type

type uc_excel from w_print_form3`uc_excel within w_hpa699p
end type

type uc_print from w_print_form3`uc_print within w_hpa699p
end type

type st_line1 from w_print_form3`st_line1 within w_hpa699p
end type

type st_line2 from w_print_form3`st_line2 within w_hpa699p
end type

type st_line3 from w_print_form3`st_line3 within w_hpa699p
end type

type uc_excelroad from w_print_form3`uc_excelroad within w_hpa699p
end type

type ln_dwcon from w_print_form3`ln_dwcon within w_hpa699p
end type

type uo_year from w_print_form3`uo_year within w_hpa699p
boolean visible = false
integer x = 91
end type

type gb_3 from w_print_form3`gb_3 within w_hpa699p
boolean visible = false
end type

type dw_print from w_print_form3`dw_print within w_hpa699p
boolean visible = false
integer x = 206
integer y = 296
integer width = 101
integer height = 100
integer taborder = 60
string dataobject = "d_hpa699p"
end type

type st_1 from w_print_form3`st_1 within w_hpa699p
boolean visible = false
integer x = 2089
end type

type dw_head from w_print_form3`dw_head within w_hpa699p
boolean visible = false
integer x = 2322
end type

type uo_dept_code from w_print_form3`uo_dept_code within w_hpa699p
boolean visible = false
integer x = 850
end type

type st_2 from w_print_form3`st_2 within w_hpa699p
boolean visible = false
integer x = 919
integer y = 72
integer width = 1353
string text = "※ 반드시 조회를 하시기 바랍니다."
end type

type st_3 from w_print_form3`st_3 within w_hpa699p
boolean visible = false
end type

type dw_con from w_print_form3`dw_con within w_hpa699p
string dataobject = "d_hpa325p_con"
end type

event dw_con::constructor;call super::constructor;This.object.year_t.text = '기준년도'

this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
end event

type rb_1 from radiobutton within w_hpa699p
boolean visible = false
integer x = 3159
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

ii_jaejik_opt = 0

//wf_getchild2()


end event

type rb_2 from radiobutton within w_hpa699p
boolean visible = false
integer x = 3397
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

ii_jaejik_opt = 1

//wf_getchild2()

end event

type rb_3 from radiobutton within w_hpa699p
boolean visible = false
integer x = 3630
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

ii_jaejik_opt = 3

//wf_getchild2()

end event

type dw_list from uo_dwgrid within w_hpa699p
integer x = 50
integer y = 292
integer width = 4384
integer height = 1976
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_hpa699p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

