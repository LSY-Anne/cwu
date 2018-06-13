$PBExportHeader$w_hpa313p.srw
$PBExportComments$수당/공제금 처리 내역서 출력
forward
global type w_hpa313p from w_print_form2
end type
type rb_1 from radiobutton within w_hpa313p
end type
type rb_2 from radiobutton within w_hpa313p
end type
type rb_3 from radiobutton within w_hpa313p
end type
type rb_4 from radiobutton within w_hpa313p
end type
end forward

global type w_hpa313p from w_print_form2
string title = "수당/공제금 처리 내역서 출력"
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
end type
global w_hpa313p w_hpa313p

type variables
string	is_pay_gbn
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

// 직종명
dw_print.getchild('hpa001m_jikjong_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikjong_code', 0) < 1 then
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

integer	li_sort

st_back.bringtotop = true

if rb_3.checked then
	dw_print.dataobject = 'd_hpa313p_2'
	dw_print.settransobject(sqlca)
	dw_print.object.datawindow.print.preview = 'yes'	
	
	wf_getchild()
	
	if dw_print.retrieve(is_yearmonth, is_dept_code, is_pay_gbn) > 0 then
		st_back.bringtotop	=	false
	else
		dw_print.reset()
	end if
else
	dw_print.dataobject = 'd_hpa313p_1'
	dw_print.settransobject(sqlca)
	dw_print.object.datawindow.print.preview = 'yes'	

	wf_getchild()
	
	if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, is_pay_gbn) > 0 then
		st_back.bringtotop	=	false
	else
		dw_print.reset()
	end if
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

on w_hpa313p.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_3
this.Control[iCurrent+4]=this.rb_4
end on

on w_hpa313p.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
end on

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF dw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, dw_print)
//
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
//
//is_pay_gbn = '1'
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================


uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

uo_dept_code.uf_setdept('', '소속명')
is_dept_code	=	uo_dept_code.uf_getcode()

f_getdwcommon2(dw_head, 'jikjong_code', 0, 'code', 750, 100)

//st_back.bringtotop = true

wf_button_control()

uo_yearmonth.em_yearmonth.setfocus()

wf_getchild()

is_pay_gbn = '1'
idw_print = dw_print
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "수당/공제금처리내역서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_print_form2`ln_templeft within w_hpa313p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa313p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa313p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa313p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa313p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa313p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa313p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa313p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa313p
end type

type uc_save from w_print_form2`uc_save within w_hpa313p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa313p
end type

type uc_print from w_print_form2`uc_print within w_hpa313p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa313p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa313p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa313p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa313p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa313p
end type

type st_back from w_print_form2`st_back within w_hpa313p
boolean visible = false
integer y = 296
end type

type dw_print from w_print_form2`dw_print within w_hpa313p
integer y = 296
string dataobject = "d_hpa313p_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_print::retrieveend;call super::retrieveend;//dw_display_title.uf_display_title(this)


end event

type st_1 from w_print_form2`st_1 within w_hpa313p
integer x = 2025
end type

type dw_head from w_print_form2`dw_head within w_hpa313p
integer x = 2258
integer height = 80
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa313p
integer x = 55
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa313p
integer x = 827
integer y = 180
boolean border = false
end type

type st_2 from w_print_form2`st_2 within w_hpa313p
boolean visible = false
integer x = 1701
integer y = 8
integer height = 64
end type

type st_3 from w_print_form2`st_3 within w_hpa313p
boolean visible = false
integer x = 1701
integer y = 60
end type

type st_con from w_print_form2`st_con within w_hpa313p
end type

type dw_con from w_print_form2`dw_con within w_hpa313p
boolean visible = false
end type

type rb_1 from radiobutton within w_hpa313p
integer x = 3735
integer y = 168
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 31112622
string text = "수당금 내역"
boolean checked = true
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)

is_pay_gbn = '1'
end event

type rb_2 from radiobutton within w_hpa313p
integer x = 3735
integer y = 220
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 31112622
string text = "공제금 내역"
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)

is_pay_gbn = '2'
end event

type rb_3 from radiobutton within w_hpa313p
integer x = 3177
integer y = 168
integer width = 233
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 31112622
string text = "전체"
boolean checked = true
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)


end event

type rb_4 from radiobutton within w_hpa313p
integer x = 3177
integer y = 220
integer width = 247
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 31112622
string text = "직종별"
end type

event clicked;this.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)


end event

