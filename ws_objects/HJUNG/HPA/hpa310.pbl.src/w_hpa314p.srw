$PBExportHeader$w_hpa314p.srw
$PBExportComments$월급여 이체내역서 출력(A4)
forward
global type w_hpa314p from w_print_form2
end type
type st_4 from statictext within w_hpa314p
end type
type ddlb_1 from dropdownlistbox within w_hpa314p
end type
end forward

global type w_hpa314p from w_print_form2
string title = "월급여 이체내역서 출력"
st_4 st_4
ddlb_1 ddlb_1
end type
global w_hpa314p w_hpa314p

type variables

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
dw_print.getchild('jikjong_code', idw_child)
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
string ls_chasu
// st_back.bringtotop = true

//if ddlb_1.text ='%' then
//	dw_print.dataobject = 'd_hpa314p_1'
//	dw_print.settransobject(sqlca)
//	wf_getchild()
//   if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong) > 0 then
//		// st_back.bringtotop = false
//	else 
//		messagebox('','해당차수에 해당하는 DATA가 없습니다.')
//		return -1
//	end if
//else
  if ddlb_1.text = '1'  then
	dw_print.dataobject = 'd_hpa314p_1'
	dw_print.settransobject(sqlca)
	wf_getchild()
	ls_chasu ='1' 

	if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, ls_chasu) > 0 then
		// st_back.bringtotop = false
	else 
		messagebox('','해당차수에 해당하는 DATA가 없습니다.')
		return -1
	end if
ELSEif ddlb_1.text = '2'  then
	dw_print.dataobject = 'd_hpa314p_2'
	dw_print.settransobject(sqlca)
	wf_getchild()
	ls_chasu ='2'   
	
	if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, ls_chasu) > 0 then
		// st_back.bringtotop = false
	else 
		messagebox('','해당차수에 해당하는 DATA가 없습니다.')
		return -1
	end if
ELSEif ddlb_1.text = '3'  then
	dw_print.dataobject = 'd_hpa314p_3'
	dw_print.settransobject(sqlca)
	wf_getchild()
	ls_chasu ='3'   
	
	if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, ls_chasu) > 0 then
		// st_back.bringtotop = false
	else 
		messagebox('','해당차수에 해당하는 DATA가 없습니다.')
		return -1
	end if
ELSEif ddlb_1.text = '4'  then
	dw_print.dataobject = 'd_hpa314p_4'
	dw_print.settransobject(sqlca)
	wf_getchild()
	ls_chasu ='4'   
	
	if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, ls_chasu) > 0 then
		// st_back.bringtotop = false
	else 
		messagebox('','해당차수에 해당하는 DATA가 없습니다.')
		return -1
	end if
ELSEif ddlb_1.text = '5'  then
	dw_print.dataobject = 'd_hpa314p_5'
	dw_print.settransobject(sqlca)
	wf_getchild()
	ls_chasu ='5'   
	
	if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, ls_chasu) > 0 then
		// st_back.bringtotop = false
	else 
		messagebox('','해당차수에 해당하는 DATA가 없습니다.')
		return -1
	end if
end if

dw_print.modify("datawindow.print.preview='yes'")

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

on w_hpa314p.create
int iCurrent
call super::create
this.st_4=create st_4
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.ddlb_1
end on

on w_hpa314p.destroy
call super::destroy
destroy(this.st_4)
destroy(this.ddlb_1)
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
////wf_getchild()
//ddlb_1.text = '1'
//
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

uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

uo_dept_code.uf_setdept('', '소속명')
is_dept_code	=	uo_dept_code.uf_getcode()

f_getdwcommon2(dw_head, 'jikjong_code', 0, 'code', 750, 100)



wf_button_control()

uo_yearmonth.em_yearmonth.setfocus()

idw_print = dw_print
ddlb_1.text = '1'

end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "급여 이체 내역서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_print_form2`ln_templeft within w_hpa314p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa314p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa314p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa314p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa314p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa314p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa314p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa314p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa314p
end type

type uc_save from w_print_form2`uc_save within w_hpa314p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa314p
end type

type uc_print from w_print_form2`uc_print within w_hpa314p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa314p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa314p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa314p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa314p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa314p
end type

type st_back from w_print_form2`st_back within w_hpa314p
boolean visible = false
integer x = 2871
integer y = 1152
end type

type dw_print from w_print_form2`dw_print within w_hpa314p
string dataobject = "d_hpa314p_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_print::retrieveend;call super::retrieveend;//dw_display_title.uf_display_title(this)


end event

type st_1 from w_print_form2`st_1 within w_hpa314p
end type

type dw_head from w_print_form2`dw_head within w_hpa314p
integer width = 777
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa314p
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa314p
integer x = 997
integer y = 176
boolean border = false
end type

type st_2 from w_print_form2`st_2 within w_hpa314p
boolean visible = false
end type

type st_3 from w_print_form2`st_3 within w_hpa314p
boolean visible = false
end type

type st_con from w_print_form2`st_con within w_hpa314p
end type

type dw_con from w_print_form2`dw_con within w_hpa314p
boolean visible = false
end type

type st_4 from statictext within w_hpa314p
integer x = 3438
integer y = 192
integer width = 160
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "차수"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_hpa314p
integer x = 3589
integer y = 180
integer width = 325
integer height = 388
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
string item[] = {"1","2","3","4","5",""}
borderstyle borderstyle = stylelowered!
end type

