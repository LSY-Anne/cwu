$PBExportHeader$w_hpa330p.srw
$PBExportComments$연간소득내역서
forward
global type w_hpa330p from w_print_form2
end type
type st_81 from st_2 within w_hpa330p
end type
type st_4 from st_2 within w_hpa330p
end type
type uo_member from cuo_insa_member within w_hpa330p
end type
end forward

global type w_hpa330p from w_print_form2
string title = "연간소득내역서"
st_81 st_81
st_4 st_4
uo_member uo_member
end type
global w_hpa330p w_hpa330p

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
dw_con.accepttext()
//is_yearmonth =  string(dw_con.object.year[1],'yyyy')
is_year =  string(dw_con.object.year[1],'yyyy')
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

on w_hpa330p.create
int iCurrent
call super::create
this.st_81=create st_81
this.st_4=create st_4
this.uo_member=create uo_member
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_81
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.uo_member
end on

on w_hpa330p.destroy
call super::destroy
destroy(this.st_81)
destroy(this.st_4)
destroy(this.uo_member)
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
//wf_getchild2()
//
//wf_SetMenu('FIRST', 	TRUE)
//wf_SetMenu('NEXT', 	TRUE)
//wf_SetMenu('PRE', 	TRUE)
//wf_SetMenu('LAST', 	TRUE)
//
end event

event ue_first;call super::ue_first;dw_print.scrolltorow(1)
end event

event ue_last;call super::ue_last;dw_print.scrolltorow(dw_print.rowcount())
end event

event ue_next;call super::ue_next;dw_print.scrollpriorpage()
end event

event ue_prior;call super::ue_prior;dw_print.scrollnextpage()
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
wf_getchild2()
idw_print = dw_print
//wf_SetMenu('FIRST', 	TRUE)
//wf_SetMenu('NEXT', 	TRUE)
//wf_SetMenu('PRE', 	TRUE)
//wf_SetMenu('LAST', 	TRUE)

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_print_form2`ln_templeft within w_hpa330p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa330p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa330p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa330p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa330p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa330p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa330p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa330p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa330p
end type

type uc_save from w_print_form2`uc_save within w_hpa330p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa330p
end type

type uc_print from w_print_form2`uc_print within w_hpa330p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa330p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa330p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa330p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa330p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa330p
end type

type st_back from w_print_form2`st_back within w_hpa330p
boolean visible = false
integer y = 288
end type

type dw_print from w_print_form2`dw_print within w_hpa330p
integer y = 288
integer height = 1980
integer taborder = 60
string dataobject = "d_hpa330p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_1 from w_print_form2`st_1 within w_hpa330p
boolean visible = false
integer x = 2098
integer y = 0
end type

type dw_head from w_print_form2`dw_head within w_hpa330p
boolean visible = false
integer x = 2327
integer y = 0
end type

event dw_head::itemchanged;call super::itemchanged;wf_getchild2()
end event

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa330p
boolean visible = false
integer x = 123
integer y = 8
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa330p
boolean visible = false
integer x = 923
end type

event uo_dept_code::ue_itemchange;call super::ue_itemchange;wf_getchild2()
end event

type st_2 from w_print_form2`st_2 within w_hpa330p
boolean visible = false
integer x = 2674
integer y = 0
end type

type st_3 from w_print_form2`st_3 within w_hpa330p
boolean visible = false
integer x = 2921
integer y = 116
end type

type st_con from w_print_form2`st_con within w_hpa330p
boolean visible = false
integer x = 27
integer y = 0
end type

type dw_con from w_print_form2`dw_con within w_hpa330p
string dataobject = "d_hpa325p_con"
end type

event dw_con::constructor;call super::constructor;uo_member.setposition(totop!)
string	ls_yy

//st_title.text = is_year_title
ls_yy	= f_today()

this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))

is_yearmonth = left(ls_yy, 4)
end event

type st_81 from st_2 within w_hpa330p
integer x = 3031
integer y = 8
integer width = 613
string text = "※ 개인번호를 지우면"
end type

type st_4 from st_2 within w_hpa330p
integer x = 1998
integer width = 613
string text = "   전체가 조회됩니다."
end type

type uo_member from cuo_insa_member within w_hpa330p
event destroy ( )
integer x = 841
integer y = 180
integer taborder = 30
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;If gs_empcode = 'admin' Then
	
	THIS.TRIGGER EVENT ue_enbled(true)
End If
end event

