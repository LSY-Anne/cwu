$PBExportHeader$w_hpa605r.srw
$PBExportComments$소득공제명세 - 가족사항
forward
global type w_hpa605r from w_print_form3
end type
type gb_2 from gb_3 within w_hpa605r
end type
type st_5 from statictext within w_hpa605r
end type
type em_zoom from editmask within w_hpa605r
end type
type st_9 from statictext within w_hpa605r
end type
type st_7 from st_1 within w_hpa605r
end type
type st_8 from st_2 within w_hpa605r
end type
type st_4 from st_2 within w_hpa605r
end type
type uo_member_no from cuo_member_fromto within w_hpa605r
end type
type rb_1 from radiobutton within w_hpa605r
end type
type rb_2 from radiobutton within w_hpa605r
end type
type rb_3 from radiobutton within w_hpa605r
end type
end forward

global type w_hpa605r from w_print_form3
string title = "소득자별 근로소득 원천징수영수증 출력"
gb_2 gb_2
st_5 st_5
em_zoom em_zoom
st_9 st_9
st_7 st_7
st_8 st_8
st_4 st_4
uo_member_no uo_member_no
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
end type
global w_hpa605r w_hpa605r

type variables
mailSession 		m_mail_session 
mailReturnCode		m_rtn
mailMessage 		m_message

string	is_str_member	= '          ', is_end_member = 'zzzzzzzzzz'
integer	ii_jaejik_opt	=	0
end variables

forward prototypes
public subroutine wf_filter ()
public subroutine wf_getchild ()
public subroutine wf_getchild2 ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_filter ();// ==========================================================================================
// 기    능 : 	datawindow filter
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_filter()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

if ii_jaejik_opt = 0 then
	dw_print.setfilter("")
	dw_print.filter()
elseif ii_jaejik_opt = 1 then
	dw_print.setfilter("hin001m_jaejik_opt in (1, 2, 4)")
	dw_print.filter()
else
	dw_print.setfilter("hin001m_jaejik_opt not in (1, 2, 4)")
	dw_print.filter()
end if	


end subroutine

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

public subroutine wf_getchild2 ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild2()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

uo_member_no.uf_getchild(ii_str_jikjong, ii_end_jikjong, is_dept_code, ii_jaejik_opt)

is_str_member	=	'          '
is_end_member	=	'zzzzzzzzzz'

dw_print.reset()



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
 


//dw_print.setfilter("")
//dw_print.filter()
string ls_jaejik
ls_jaejik = string(ii_jaejik_opt)
if ii_jaejik_opt = 0 then  ls_jaejik = ''
if dw_print.retrieve(is_year, is_dept_code, ii_str_jikjong, ii_end_jikjong, is_str_member, is_end_member, ls_jaejik) > 0 then
//	wf_filter()

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

on w_hpa605r.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.st_5=create st_5
this.em_zoom=create em_zoom
this.st_9=create st_9
this.st_7=create st_7
this.st_8=create st_8
this.st_4=create st_4
this.uo_member_no=create uo_member_no
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.em_zoom
this.Control[iCurrent+4]=this.st_9
this.Control[iCurrent+5]=this.st_7
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.uo_member_no
this.Control[iCurrent+9]=this.rb_1
this.Control[iCurrent+10]=this.rb_2
this.Control[iCurrent+11]=this.rb_3
end on

on w_hpa605r.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.st_5)
destroy(this.em_zoom)
destroy(this.st_9)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_4)
destroy(this.uo_member_no)
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
wf_getchild2()

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

type ln_templeft from w_print_form3`ln_templeft within w_hpa605r
end type

type ln_tempright from w_print_form3`ln_tempright within w_hpa605r
end type

type ln_temptop from w_print_form3`ln_temptop within w_hpa605r
end type

type ln_tempbuttom from w_print_form3`ln_tempbuttom within w_hpa605r
end type

type ln_tempbutton from w_print_form3`ln_tempbutton within w_hpa605r
end type

type ln_tempstart from w_print_form3`ln_tempstart within w_hpa605r
end type

type uc_retrieve from w_print_form3`uc_retrieve within w_hpa605r
end type

type uc_insert from w_print_form3`uc_insert within w_hpa605r
end type

type uc_delete from w_print_form3`uc_delete within w_hpa605r
end type

type uc_save from w_print_form3`uc_save within w_hpa605r
end type

type uc_excel from w_print_form3`uc_excel within w_hpa605r
end type

type uc_print from w_print_form3`uc_print within w_hpa605r
end type

type st_line1 from w_print_form3`st_line1 within w_hpa605r
end type

type st_line2 from w_print_form3`st_line2 within w_hpa605r
end type

type st_line3 from w_print_form3`st_line3 within w_hpa605r
end type

type uc_excelroad from w_print_form3`uc_excelroad within w_hpa605r
end type

type ln_dwcon from w_print_form3`ln_dwcon within w_hpa605r
end type

type uo_year from w_print_form3`uo_year within w_hpa605r
integer x = 50
end type

type gb_3 from w_print_form3`gb_3 within w_hpa605r
end type

type dw_print from w_print_form3`dw_print within w_hpa605r
integer y = 536
integer height = 1984
integer taborder = 60
string dataobject = "d_hpa605p_4"
end type

type st_1 from w_print_form3`st_1 within w_hpa605r
integer x = 2057
end type

type dw_head from w_print_form3`dw_head within w_hpa605r
integer x = 2290
end type

event dw_head::itemchanged;call super::itemchanged;wf_getchild2()
end event

type uo_dept_code from w_print_form3`uo_dept_code within w_hpa605r
integer x = 809
end type

event uo_dept_code::ue_itemchange;call super::ue_itemchange;wf_getchild2()
end event

type st_2 from w_print_form3`st_2 within w_hpa605r
boolean visible = false
integer x = 3259
end type

type st_3 from w_print_form3`st_3 within w_hpa605r
boolean visible = false
integer x = 3259
end type

type dw_con from w_print_form3`dw_con within w_hpa605r
end type

type gb_2 from gb_3 within w_hpa605r
integer y = 156
integer height = 332
end type

type st_5 from statictext within w_hpa605r
integer x = 3259
integer y = 252
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

type em_zoom from editmask within w_hpa605r
integer x = 3511
integer y = 236
integer width = 206
integer height = 84
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

event modified;dw_print.object.DataWindow.Print.Preview.Zoom = integer(this.text)
end event

type st_9 from statictext within w_hpa605r
integer x = 3730
integer y = 252
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

type st_7 from st_1 within w_hpa605r
integer x = 110
integer y = 244
integer width = 288
string text = "개 인 별"
end type

type st_8 from st_2 within w_hpa605r
boolean visible = true
integer x = 2601
integer y = 216
integer width = 613
string text = "※ 개인번호를 지우면"
end type

type st_4 from st_2 within w_hpa605r
boolean visible = true
integer x = 2601
integer y = 280
integer width = 613
string text = "   전체가 조회됩니다."
end type

type uo_member_no from cuo_member_fromto within w_hpa605r
integer x = 411
integer y = 224
integer taborder = 120
boolean bringtotop = true
end type

on uo_member_no.destroy
call cuo_member_fromto::destroy
end on

event ue_itemchanged();call super::ue_itemchanged;is_str_member	=	uf_str_member()
is_end_member	=	uf_end_member()

end event

type rb_1 from radiobutton within w_hpa605r
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

wf_getchild2()
//wf_filter()

end event

type rb_2 from radiobutton within w_hpa605r
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

wf_getchild2()
//wf_filter()

end event

type rb_3 from radiobutton within w_hpa605r
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

wf_getchild2()
//wf_filter()

end event

