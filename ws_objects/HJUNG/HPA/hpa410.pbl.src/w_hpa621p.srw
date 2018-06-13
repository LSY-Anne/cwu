$PBExportHeader$w_hpa621p.srw
$PBExportComments$직장가입자보수총액통보서 출력
forward
global type w_hpa621p from w_print_form3
end type
type rb_1 from radiobutton within w_hpa621p
end type
type rb_2 from radiobutton within w_hpa621p
end type
type rb_3 from radiobutton within w_hpa621p
end type
end forward

global type w_hpa621p from w_print_form3
string title = "직장가입자보수총액통보서 출력"
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
end type
global w_hpa621p w_hpa621p

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



dw_print.setfilter("")
dw_print.filter()

if dw_print.retrieve(is_year) > 0 then
	dw_print.setfilter("medical_amt <> 0")
	dw_print.filter()
	

else
	dw_print.reset()
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

on w_hpa621p.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_3
end on

on w_hpa621p.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
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


end event

type uo_year from w_print_form3`uo_year within w_hpa621p
end type

type gb_3 from w_print_form3`gb_3 within w_hpa621p
end type

type dw_print from w_print_form3`dw_print within w_hpa621p
integer taborder = 60
string dataobject = "d_hpa621p_1"
end type

type st_1 from w_print_form3`st_1 within w_hpa621p
boolean visible = false
integer x = 2089
end type

type dw_head from w_print_form3`dw_head within w_hpa621p
boolean visible = false
integer x = 2322
end type

type uo_dept_code from w_print_form3`uo_dept_code within w_hpa621p
boolean visible = false
integer x = 850
end type

type st_2 from w_print_form3`st_2 within w_hpa621p
integer x = 919
integer y = 72
integer width = 1353
string text = "※ 반드시 조회를 하시기 바랍니다."
end type

type st_3 from w_print_form3`st_3 within w_hpa621p
boolean visible = false
end type

type rb_1 from radiobutton within w_hpa621p
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
borderstyle borderstyle = stylelowered!
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

ii_jaejik_opt = 0

//wf_getchild2()


end event

type rb_2 from radiobutton within w_hpa621p
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
borderstyle borderstyle = stylelowered!
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

ii_jaejik_opt = 1

//wf_getchild2()

end event

type rb_3 from radiobutton within w_hpa621p
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
borderstyle borderstyle = stylelowered!
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)

ii_jaejik_opt = 3

//wf_getchild2()

end event

