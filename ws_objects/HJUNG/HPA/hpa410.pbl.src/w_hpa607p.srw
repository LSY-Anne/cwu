$PBExportHeader$w_hpa607p.srw
$PBExportComments$소득자료 제출 집계표 출력
forward
global type w_hpa607p from w_print_form3
end type
type rb_1 from radiobutton within w_hpa607p
end type
type rb_2 from radiobutton within w_hpa607p
end type
type rb_3 from radiobutton within w_hpa607p
end type
type st_4 from statictext within w_hpa607p
end type
end forward

global type w_hpa607p from w_print_form3
string title = "소득자료 제출 집계표 출력"
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
st_4 st_4
end type
global w_hpa607p w_hpa607p

type variables
integer	ii_jaejik_opt
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
//// 직종코드
//dw_print.getchild('hpa018h_jikjong_code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('jikjong_code', 0) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if


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



if rb_1.checked then
	dw_print.dataobject = 'd_hpa607p_1'
elseif rb_2.checked then
	dw_print.dataobject = 'd_hpa607p_2'
else
	dw_print.dataobject = 'd_hpa607p_3'
end if

dw_print.settransobject(sqlca)
dw_print.object.datawindow.print.preview = 'yes'
string ls_jaejik
ls_jaejik = string(ii_jaejik_opt)
if ii_jaejik_opt = 0 or isnull(ii_jaejik_opt)  then  ls_jaejik = ''
if dw_print.retrieve(is_year, is_dept_code, ii_str_jikjong, ii_end_jikjong) > 0 then
	if ii_str_jikjong > 0 then
		dw_print.object.t_jikjong_name.text = '[' + dw_head.getitemstring(dw_head.getrow(), 'code_name') + ']'
	end if

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

on w_hpa607p.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_3
this.Control[iCurrent+4]=this.st_4
end on

on w_hpa607p.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.st_4)
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

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

wf_getchild()

idw_print = dW_print
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
avc_data.SetProperty('title', "소득자료제출집계표")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_print_form3`ln_templeft within w_hpa607p
end type

type ln_tempright from w_print_form3`ln_tempright within w_hpa607p
end type

type ln_temptop from w_print_form3`ln_temptop within w_hpa607p
end type

type ln_tempbuttom from w_print_form3`ln_tempbuttom within w_hpa607p
end type

type ln_tempbutton from w_print_form3`ln_tempbutton within w_hpa607p
end type

type ln_tempstart from w_print_form3`ln_tempstart within w_hpa607p
end type

type uc_retrieve from w_print_form3`uc_retrieve within w_hpa607p
integer y = 44
end type

type uc_insert from w_print_form3`uc_insert within w_hpa607p
integer y = 44
end type

type uc_delete from w_print_form3`uc_delete within w_hpa607p
integer y = 44
end type

type uc_save from w_print_form3`uc_save within w_hpa607p
integer y = 44
end type

type uc_excel from w_print_form3`uc_excel within w_hpa607p
integer y = 44
end type

type uc_print from w_print_form3`uc_print within w_hpa607p
end type

type st_line1 from w_print_form3`st_line1 within w_hpa607p
end type

type st_line2 from w_print_form3`st_line2 within w_hpa607p
end type

type st_line3 from w_print_form3`st_line3 within w_hpa607p
end type

type uc_excelroad from w_print_form3`uc_excelroad within w_hpa607p
end type

type ln_dwcon from w_print_form3`ln_dwcon within w_hpa607p
end type

type uo_year from w_print_form3`uo_year within w_hpa607p
integer x = 137
integer y = 184
end type

type gb_3 from w_print_form3`gb_3 within w_hpa607p
boolean visible = false
integer y = 0
integer height = 72
end type

type dw_print from w_print_form3`dw_print within w_hpa607p
integer y = 300
integer taborder = 60
string dataobject = "d_hpa607p_1"
end type

type st_1 from w_print_form3`st_1 within w_hpa607p
integer x = 2130
integer y = 192
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
end type

type dw_head from w_print_form3`dw_head within w_hpa607p
integer x = 2363
integer y = 180
integer width = 686
integer height = 80
end type

type uo_dept_code from w_print_form3`uo_dept_code within w_hpa607p
integer x = 891
integer y = 184
end type

type st_2 from w_print_form3`st_2 within w_hpa607p
boolean visible = false
end type

type st_3 from w_print_form3`st_3 within w_hpa607p
boolean visible = false
end type

type dw_con from w_print_form3`dw_con within w_hpa607p
boolean visible = false
end type

type rb_1 from radiobutton within w_hpa607p
integer x = 3200
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

//wf_getchild2()


end event

type rb_2 from radiobutton within w_hpa607p
integer x = 3438
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

//wf_getchild2()

end event

type rb_3 from radiobutton within w_hpa607p
integer x = 3671
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

//wf_getchild2()

end event

type st_4 from statictext within w_hpa607p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31112622
boolean focusrectangle = false
end type

