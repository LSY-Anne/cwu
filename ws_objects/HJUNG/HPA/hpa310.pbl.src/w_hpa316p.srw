$PBExportHeader$w_hpa316p.srw
$PBExportComments$정산 내역서 출력
forward
global type w_hpa316p from w_print_form2
end type
end forward

global type w_hpa316p from w_print_form2
string title = "정산 내역서 출력"
end type
global w_hpa316p w_hpa316p

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
String ls_code
st_back.bringtotop = true

dw_con.accepttext()
is_yearmonth = string(dw_con.object.yearmonth[1], 'yyyymm')
ls_code = dw_con.object.code[1]
if isnull(ls_code) or trim(ls_code) = '0' or trim(ls_code) = '' then	
			ii_str_jikjong	=	0
			ii_end_jikjong	=	9
		else
			ii_str_jikjong = integer(trim(ls_code))
			ii_end_jikjong = integer(trim(ls_code))
		end if


if dw_print.retrieve(is_yearmonth, ii_str_jikjong, ii_end_jikjong) > 0 then
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

on w_hpa316p.create
int iCurrent
call super::create
end on

on w_hpa316p.destroy
call super::destroy
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
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

wf_getchild()
idw_print = dw_print
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "정산내역서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_print_form2`ln_templeft within w_hpa316p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa316p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa316p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa316p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa316p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa316p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa316p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa316p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa316p
end type

type uc_save from w_print_form2`uc_save within w_hpa316p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa316p
end type

type uc_print from w_print_form2`uc_print within w_hpa316p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa316p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa316p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa316p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa316p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa316p
end type

type st_back from w_print_form2`st_back within w_hpa316p
boolean visible = false
integer y = 288
integer height = 1980
end type

type dw_print from w_print_form2`dw_print within w_hpa316p
integer y = 288
integer height = 1980
string dataobject = "d_hpa316p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_print::retrieveend;call super::retrieveend;//dw_display_title.uf_display_title(this)


end event

type st_1 from w_print_form2`st_1 within w_hpa316p
boolean visible = false
integer x = 1070
integer y = 68
end type

type dw_head from w_print_form2`dw_head within w_hpa316p
boolean visible = false
integer x = 1326
integer y = 56
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa316p
boolean visible = false
integer x = 142
integer y = 0
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa316p
boolean visible = false
integer x = 1490
integer y = 32
end type

type st_2 from w_print_form2`st_2 within w_hpa316p
boolean visible = false
integer x = 1888
integer y = 0
end type

type st_3 from w_print_form2`st_3 within w_hpa316p
boolean visible = false
integer x = 1888
integer y = 52
end type

type st_con from w_print_form2`st_con within w_hpa316p
boolean visible = false
integer x = 69
integer y = 0
end type

type dw_con from w_print_form2`dw_con within w_hpa316p
string dataobject = "d_hpa316p_con"
end type

event dw_con::constructor;call super::constructor;
f_getdwcommon2(dw_con, 'jikjong_code', 0, 'code', 750, 100)
this.object.yearmonth[1] = date(string(f_today(), '@@@@/@@/@@'))
end event

event dw_con::itemchanged;call super::itemchanged;this.accepttext()

Choose case dwo.name
	Case 'yearmonth'
		is_yearmonth = string(date(data), 'yyyymm')
	Case 'code'
		if isnull(data) or trim(data) = '0' or trim(data) = '' then	
			ii_str_jikjong	=	0
			ii_end_jikjong	=	9
		else
			ii_str_jikjong = integer(trim(data))
			ii_end_jikjong = integer(trim(data))
		end if
	
End Choose
end event

