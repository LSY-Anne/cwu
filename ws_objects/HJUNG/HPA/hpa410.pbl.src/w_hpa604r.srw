$PBExportHeader$w_hpa604r.srw
$PBExportComments$소득자별 근로소득 원천징수부 출력/직원용
forward
global type w_hpa604r from w_print_form3
end type
type st_7 from st_1 within w_hpa604r
end type
type st_8 from st_2 within w_hpa604r
end type
type em_zoom from editmask within w_hpa604r
end type
type gb_2 from gb_3 within w_hpa604r
end type
type st_4 from st_2 within w_hpa604r
end type
type st_5 from statictext within w_hpa604r
end type
type st_9 from statictext within w_hpa604r
end type
type uo_member_no from cuo_member_fromto within w_hpa604r
end type
type em_1 from editmask within w_hpa604r
end type
type rb_3 from radiobutton within w_hpa604r
end type
type rb_1 from radiobutton within w_hpa604r
end type
type rb_2 from radiobutton within w_hpa604r
end type
type st_6 from statictext within w_hpa604r
end type
end forward

global type w_hpa604r from w_print_form3
string title = "소득자별 근로소득 원천징수부 출력"
st_7 st_7
st_8 st_8
em_zoom em_zoom
gb_2 gb_2
st_4 st_4
st_5 st_5
st_9 st_9
uo_member_no uo_member_no
em_1 em_1
rb_3 rb_3
rb_1 rb_1
rb_2 rb_2
st_6 st_6
end type
global w_hpa604r w_hpa604r

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



dw_print.setfilter("")
dw_print.filter()
String ls_jaejik
ls_jaejik = string(ii_jaejik_opt)
if ii_jaejik_opt = 0 then ls_jaejik = '%'
if dw_print.retrieve(is_year, is_dept_code, ii_str_jikjong, ii_end_jikjong, is_str_member, is_end_member, ls_jaejik) > 0 then
	wf_filter()

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

on w_hpa604r.create
int iCurrent
call super::create
this.st_7=create st_7
this.st_8=create st_8
this.em_zoom=create em_zoom
this.gb_2=create gb_2
this.st_4=create st_4
this.st_5=create st_5
this.st_9=create st_9
this.uo_member_no=create uo_member_no
this.em_1=create em_1
this.rb_3=create rb_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_7
this.Control[iCurrent+2]=this.st_8
this.Control[iCurrent+3]=this.em_zoom
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.st_9
this.Control[iCurrent+8]=this.uo_member_no
this.Control[iCurrent+9]=this.em_1
this.Control[iCurrent+10]=this.rb_3
this.Control[iCurrent+11]=this.rb_1
this.Control[iCurrent+12]=this.rb_2
this.Control[iCurrent+13]=this.st_6
end on

on w_hpa604r.destroy
call super::destroy
destroy(this.st_7)
destroy(this.st_8)
destroy(this.em_zoom)
destroy(this.gb_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_9)
destroy(this.uo_member_no)
destroy(this.em_1)
destroy(this.rb_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_6)
end on

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

idw_print = dw_print

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

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "근로소득원천징수부")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_print_form3`ln_templeft within w_hpa604r
end type

type ln_tempright from w_print_form3`ln_tempright within w_hpa604r
end type

type ln_temptop from w_print_form3`ln_temptop within w_hpa604r
end type

type ln_tempbuttom from w_print_form3`ln_tempbuttom within w_hpa604r
end type

type ln_tempbutton from w_print_form3`ln_tempbutton within w_hpa604r
end type

type ln_tempstart from w_print_form3`ln_tempstart within w_hpa604r
end type

type uc_retrieve from w_print_form3`uc_retrieve within w_hpa604r
end type

type uc_insert from w_print_form3`uc_insert within w_hpa604r
end type

type uc_delete from w_print_form3`uc_delete within w_hpa604r
end type

type uc_save from w_print_form3`uc_save within w_hpa604r
end type

type uc_excel from w_print_form3`uc_excel within w_hpa604r
end type

type uc_print from w_print_form3`uc_print within w_hpa604r
end type

type st_line1 from w_print_form3`st_line1 within w_hpa604r
end type

type st_line2 from w_print_form3`st_line2 within w_hpa604r
end type

type st_line3 from w_print_form3`st_line3 within w_hpa604r
end type

type uc_excelroad from w_print_form3`uc_excelroad within w_hpa604r
end type

type ln_dwcon from w_print_form3`ln_dwcon within w_hpa604r
end type

type uo_year from w_print_form3`uo_year within w_hpa604r
integer x = 50
integer y = 180
end type

type gb_3 from w_print_form3`gb_3 within w_hpa604r
boolean visible = false
end type

type dw_print from w_print_form3`dw_print within w_hpa604r
integer y = 488
integer height = 1796
integer taborder = 60
string dataobject = "d_hpa604p_4_2009"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_1 from w_print_form3`st_1 within w_hpa604r
integer x = 2057
integer y = 196
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
end type

type dw_head from w_print_form3`dw_head within w_hpa604r
integer x = 2290
integer y = 180
integer width = 686
integer height = 76
end type

event dw_head::itemchanged;call super::itemchanged;wf_getchild2()
end event

type uo_dept_code from w_print_form3`uo_dept_code within w_hpa604r
integer x = 809
integer y = 176
end type

event uo_dept_code::ue_itemchange;call super::ue_itemchange;wf_getchild2()
end event

type st_2 from w_print_form3`st_2 within w_hpa604r
boolean visible = false
integer x = 3259
end type

type st_3 from w_print_form3`st_3 within w_hpa604r
boolean visible = false
integer x = 3259
end type

type dw_con from w_print_form3`dw_con within w_hpa604r
boolean visible = false
end type

type st_7 from st_1 within w_hpa604r
integer x = 160
integer y = 376
integer width = 288
integer weight = 400
long textcolor = 8388608
long backcolor = 1073741824
string text = "개 인 별"
end type

type st_8 from st_2 within w_hpa604r
boolean visible = true
integer x = 2651
integer y = 340
integer width = 613
integer height = 60
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
string text = "※ 직원인 경우"
end type

type em_zoom from editmask within w_hpa604r
integer x = 3561
integer y = 360
integer width = 206
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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

type gb_2 from gb_3 within w_hpa604r
boolean visible = true
integer x = 50
integer y = 284
integer width = 4389
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_4 from st_2 within w_hpa604r
boolean visible = true
integer x = 2670
integer y = 400
integer width = 613
integer height = 56
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
string text = "   출력합니다"
end type

type st_5 from statictext within w_hpa604r
integer x = 3310
integer y = 376
integer width = 242
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "보기배율"
boolean focusrectangle = false
end type

type st_9 from statictext within w_hpa604r
integer x = 3781
integer y = 376
integer width = 59
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "%"
boolean focusrectangle = false
end type

type uo_member_no from cuo_member_fromto within w_hpa604r
integer x = 462
integer y = 352
integer taborder = 110
boolean bringtotop = true
end type

on uo_member_no.destroy
call cuo_member_fromto::destroy
end on

event ue_itemchanged();call super::ue_itemchanged;is_str_member	=	uf_str_member()
is_end_member	=	uf_end_member()

end event

type em_1 from editmask within w_hpa604r
boolean visible = false
integer x = 3520
integer y = 144
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

event modified;dw_print.object.datawindow.zoom	= this.text
end event

type rb_3 from radiobutton within w_hpa604r
integer x = 3630
integer y = 200
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "퇴직"
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)

ii_jaejik_opt = 3

wf_getchild2()

end event

type rb_1 from radiobutton within w_hpa604r
integer x = 3159
integer y = 200
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 31112622
string text = "전체"
boolean checked = true
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

ii_jaejik_opt = 0

wf_getchild2()


end event

type rb_2 from radiobutton within w_hpa604r
integer x = 3397
integer y = 200
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "재직"
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

ii_jaejik_opt = 1

wf_getchild2()

end event

type st_6 from statictext within w_hpa604r
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
boolean focusrectangle = false
end type

