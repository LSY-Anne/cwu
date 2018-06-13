$PBExportHeader$w_hpa315p.srw
$PBExportComments$명절휴가비 이체내역서 출력
forward
global type w_hpa315p from w_print_form2
end type
end forward

global type w_hpa315p from w_print_form2
string title = "명절휴가비 이체내역서 출력"
end type
global w_hpa315p w_hpa315p

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

st_back.bringtotop = true

if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, '22') > 0 then
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

on w_hpa315p.create
int iCurrent
call super::create
end on

on w_hpa315p.destroy
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

end event

type st_back from w_print_form2`st_back within w_hpa315p
end type

type dw_print from w_print_form2`dw_print within w_hpa315p
string dataobject = "d_hpa315p_1"
end type

event dw_print::retrieveend;call super::retrieveend;//dw_display_title.uf_display_title(this)


end event

type st_1 from w_print_form2`st_1 within w_hpa315p
end type

type dw_head from w_print_form2`dw_head within w_hpa315p
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa315p
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa315p
end type

type st_2 from w_print_form2`st_2 within w_hpa315p
end type

type st_3 from w_print_form2`st_3 within w_hpa315p
end type

