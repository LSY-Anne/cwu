$PBExportHeader$w_hpa409p.srw
$PBExportComments$근로소득 지급 명세서
forward
global type w_hpa409p from w_print_form3
end type
end forward

global type w_hpa409p from w_print_form3
string title = "근로소득 지급 명세서 출력"
end type
global w_hpa409p w_hpa409p

type variables

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


 dw_print.retrieve(is_year, is_dept_code, ii_str_jikjong, ii_end_jikjong) 


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

on w_hpa409p.create
int iCurrent
call super::create
end on

on w_hpa409p.destroy
call super::destroy
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

end event

event ue_first;call super::ue_first;dw_print.scrolltorow(1)
end event

event ue_last;call super::ue_last;dw_print.scrolltorow(dw_print.rowcount())
end event

event ue_next;call super::ue_next;dw_print.scrollpriorpage()
end event

event ue_prior;call super::ue_prior;dw_print.scrollnextpage()
end event

type ln_templeft from w_print_form3`ln_templeft within w_hpa409p
end type

type ln_tempright from w_print_form3`ln_tempright within w_hpa409p
end type

type ln_temptop from w_print_form3`ln_temptop within w_hpa409p
end type

type ln_tempbuttom from w_print_form3`ln_tempbuttom within w_hpa409p
end type

type ln_tempbutton from w_print_form3`ln_tempbutton within w_hpa409p
end type

type ln_tempstart from w_print_form3`ln_tempstart within w_hpa409p
end type

type uc_retrieve from w_print_form3`uc_retrieve within w_hpa409p
end type

type uc_insert from w_print_form3`uc_insert within w_hpa409p
end type

type uc_delete from w_print_form3`uc_delete within w_hpa409p
end type

type uc_save from w_print_form3`uc_save within w_hpa409p
end type

type uc_excel from w_print_form3`uc_excel within w_hpa409p
end type

type uc_print from w_print_form3`uc_print within w_hpa409p
end type

type st_line1 from w_print_form3`st_line1 within w_hpa409p
end type

type st_line2 from w_print_form3`st_line2 within w_hpa409p
end type

type st_line3 from w_print_form3`st_line3 within w_hpa409p
end type

type uc_excelroad from w_print_form3`uc_excelroad within w_hpa409p
end type

type ln_dwcon from w_print_form3`ln_dwcon within w_hpa409p
end type

type uo_year from w_print_form3`uo_year within w_hpa409p
end type

type gb_3 from w_print_form3`gb_3 within w_hpa409p
end type

type dw_print from w_print_form3`dw_print within w_hpa409p
integer taborder = 60
string dataobject = "d_hpa409p_1"
end type

type st_1 from w_print_form3`st_1 within w_hpa409p
end type

type dw_head from w_print_form3`dw_head within w_hpa409p
end type

type uo_dept_code from w_print_form3`uo_dept_code within w_hpa409p
end type

type st_2 from w_print_form3`st_2 within w_hpa409p
end type

type st_3 from w_print_form3`st_3 within w_hpa409p
end type

type dw_con from w_print_form3`dw_con within w_hpa409p
end type

