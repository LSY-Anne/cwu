$PBExportHeader$w_hpa204p.srw
$PBExportComments$고용보험 월별 합계
forward
global type w_hpa204p from w_print_form2
end type
type uo_year from cuo_year within w_hpa204p
end type
type st_81 from st_2 within w_hpa204p
end type
type st_4 from st_2 within w_hpa204p
end type
type uo_member from cuo_insa_member within w_hpa204p
end type
end forward

global type w_hpa204p from w_print_form2
string title = "연간소득내역서"
uo_year uo_year
st_81 st_81
st_4 st_4
uo_member uo_member
end type
global w_hpa204p w_hpa204p

type variables
mailSession 		m_mail_session 
mailReturnCode		m_rtn
mailMessage 		m_message

string	is_memberNo
string	is_year

end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
public subroutine wf_getchild2 ()
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
is_memberNo = TRIM(uo_member.sle_member_no.Text)
if dw_print.retrieve(is_year, is_memberNo) > 0 then
	st_back.bringtotop = false
end if

return 0

end function

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

end subroutine

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

on w_hpa204p.create
int iCurrent
call super::create
this.uo_year=create uo_year
this.st_81=create st_81
this.st_4=create st_4
this.uo_member=create uo_member
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_year
this.Control[iCurrent+2]=this.st_81
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.uo_member
end on

on w_hpa204p.destroy
call super::destroy
destroy(this.uo_year)
destroy(this.st_81)
destroy(this.st_4)
destroy(this.uo_member)
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

type ln_templeft from w_print_form2`ln_templeft within w_hpa204p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa204p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa204p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa204p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa204p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa204p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa204p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa204p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa204p
end type

type uc_save from w_print_form2`uc_save within w_hpa204p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa204p
end type

type uc_print from w_print_form2`uc_print within w_hpa204p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa204p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa204p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa204p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa204p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa204p
end type

type st_back from w_print_form2`st_back within w_hpa204p
boolean visible = false
integer y = 296
end type

type dw_print from w_print_form2`dw_print within w_hpa204p
integer y = 300
integer height = 1988
integer taborder = 60
string dataobject = "d_hpa204p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_1 from w_print_form2`st_1 within w_hpa204p
boolean visible = false
end type

type dw_head from w_print_form2`dw_head within w_hpa204p
boolean visible = false
end type

event dw_head::itemchanged;call super::itemchanged;wf_getchild2()
end event

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa204p
boolean visible = false
integer y = 144
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa204p
boolean visible = false
end type

event uo_dept_code::ue_itemchange;call super::ue_itemchange;wf_getchild2()
end event

type st_2 from w_print_form2`st_2 within w_hpa204p
integer x = 2871
end type

type st_3 from w_print_form2`st_3 within w_hpa204p
integer x = 2871
end type

type st_con from w_print_form2`st_con within w_hpa204p
end type

type dw_con from w_print_form2`dw_con within w_hpa204p
boolean visible = false
end type

type uo_year from cuo_year within w_hpa204p
integer x = 96
integer y = 180
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_year.destroy
call cuo_year::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_year = uf_getyy()


end event

event constructor;call super::constructor;em_year.text = left(f_today(), 4)

triggerevent('ue_itemchange')
end event

type st_81 from st_2 within w_hpa204p
boolean visible = false
integer y = 224
integer width = 613
string text = "※ 개인번호를 지우면"
end type

type st_4 from st_2 within w_hpa204p
boolean visible = false
integer y = 288
integer width = 613
string text = "   전체가 조회됩니다."
end type

type uo_member from cuo_insa_member within w_hpa204p
event destroy ( )
integer x = 841
integer y = 184
integer taborder = 30
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

