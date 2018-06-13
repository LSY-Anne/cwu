$PBExportHeader$w_hpa418p.srw
$PBExportComments$근로징수부합계내역서
forward
global type w_hpa418p from w_print_form2
end type
type uo_year from cuo_year within w_hpa418p
end type
type st_71 from st_1 within w_hpa418p
end type
type st_81 from st_2 within w_hpa418p
end type
type st_4 from st_2 within w_hpa418p
end type
type uo_member_no from cuo_member_fromto within w_hpa418p
end type
type rb_all from radiobutton within w_hpa418p
end type
type rb_curr from radiobutton within w_hpa418p
end type
type rb_reti from radiobutton within w_hpa418p
end type
end forward

global type w_hpa418p from w_print_form2
string title = "근로징수부합계내역서"
uo_year uo_year
st_71 st_71
st_81 st_81
st_4 st_4
uo_member_no uo_member_no
rb_all rb_all
rb_curr rb_curr
rb_reti rb_reti
end type
global w_hpa418p w_hpa418p

type variables
mailSession 		m_mail_session 
mailReturnCode		m_rtn
mailMessage 		m_message

string	is_str_member= '          ', is_end_member = 'zzzzzzzzzz'
string	is_year, is_bef_year

string	is_sang_code	=	'03', is_youngu_code = '06', is_youngu1_code = '10'

string	is_jaejik_opt
end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_getchild2 ()
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

// 직위코드
dw_print.getchild('hin001m_jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 보직코드
dw_print.getchild('hin001m_bojik_code1', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

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

uo_member_no.uf_getchild(1, 1, is_dept_code, 0)

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

st_back.bringtotop = true

//if dw_print.retrieve(is_year, is_bef_year, is_dept_code, '101', '104', is_str_member, is_end_member, is_sang_code, is_youngu_code, is_youngu1_code) > 0 then
if dw_print.retrieve(is_year, is_jaejik_opt) > 0 then
	st_back.bringtotop = false
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

on w_hpa418p.create
int iCurrent
call super::create
this.uo_year=create uo_year
this.st_71=create st_71
this.st_81=create st_81
this.st_4=create st_4
this.uo_member_no=create uo_member_no
this.rb_all=create rb_all
this.rb_curr=create rb_curr
this.rb_reti=create rb_reti
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_year
this.Control[iCurrent+2]=this.st_71
this.Control[iCurrent+3]=this.st_81
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.uo_member_no
this.Control[iCurrent+6]=this.rb_all
this.Control[iCurrent+7]=this.rb_curr
this.Control[iCurrent+8]=this.rb_reti
end on

on w_hpa418p.destroy
call super::destroy
destroy(this.uo_year)
destroy(this.st_71)
destroy(this.st_81)
destroy(this.st_4)
destroy(this.uo_member_no)
destroy(this.rb_all)
destroy(this.rb_curr)
destroy(this.rb_reti)
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

type ln_templeft from w_print_form2`ln_templeft within w_hpa418p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa418p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa418p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa418p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa418p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa418p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa418p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa418p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa418p
end type

type uc_save from w_print_form2`uc_save within w_hpa418p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa418p
end type

type uc_print from w_print_form2`uc_print within w_hpa418p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa418p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa418p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa418p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa418p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa418p
end type

type st_back from w_print_form2`st_back within w_hpa418p
integer y = 192
integer height = 2320
end type

type dw_print from w_print_form2`dw_print within w_hpa418p
integer y = 192
integer height = 2328
integer taborder = 60
string dataobject = "d_hpa418p_1"
end type

type st_1 from w_print_form2`st_1 within w_hpa418p
boolean visible = false
end type

type dw_head from w_print_form2`dw_head within w_hpa418p
boolean visible = false
end type

event dw_head::itemchanged;call super::itemchanged;wf_getchild2()
end event

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa418p
boolean visible = false
integer y = 144
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa418p
boolean visible = false
end type

event uo_dept_code::ue_itemchange;call super::ue_itemchange;wf_getchild2()
end event

type st_2 from w_print_form2`st_2 within w_hpa418p
integer x = 2871
end type

type st_3 from w_print_form2`st_3 within w_hpa418p
integer x = 2871
end type

type st_con from w_print_form2`st_con within w_hpa418p
end type

type dw_con from w_print_form2`dw_con within w_hpa418p
end type

type uo_year from cuo_year within w_hpa418p
integer x = 96
integer y = 52
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_year.destroy
call cuo_year::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_year = uf_getyy()

is_bef_year = string(integer(is_year) - 1)
end event

event constructor;call super::constructor;em_year.text = left(f_today(), 4)

triggerevent('ue_itemchange')
end event

type st_71 from st_1 within w_hpa418p
integer x = 160
integer y = 252
integer width = 288
string text = "개 인 별"
end type

type st_81 from st_2 within w_hpa418p
boolean visible = false
integer y = 224
integer width = 613
string text = "※ 개인번호를 지우면"
end type

type st_4 from st_2 within w_hpa418p
boolean visible = false
integer y = 288
integer width = 613
string text = "   전체가 조회됩니다."
end type

type uo_member_no from cuo_member_fromto within w_hpa418p
boolean visible = false
integer x = 457
integer y = 228
integer taborder = 110
boolean bringtotop = true
end type

on uo_member_no.destroy
call cuo_member_fromto::destroy
end on

event ue_itemchanged();call super::ue_itemchanged;is_str_member	=	uf_str_member()
is_end_member	=	uf_end_member()

end event

type rb_all from radiobutton within w_hpa418p
integer x = 2002
integer y = 64
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
rb_curr.textcolor = rgb(0, 0, 0)
rb_reti.textcolor = rgb(0, 0, 0)

is_jaejik_opt = '%'
//wf_getchild2()


end event

type rb_curr from radiobutton within w_hpa418p
integer x = 2240
integer y = 64
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
rb_all.textcolor = rgb(0, 0, 0)
rb_reti.textcolor = rgb(0, 0, 0)

is_jaejik_opt = '1'

//wf_getchild2()

end event

type rb_reti from radiobutton within w_hpa418p
integer x = 2473
integer y = 64
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
rb_curr.textcolor = rgb(0, 0, 0)
rb_reti.textcolor = rgb(0, 0, 0)

is_jaejik_opt = '3'

//wf_getchild2()

end event

