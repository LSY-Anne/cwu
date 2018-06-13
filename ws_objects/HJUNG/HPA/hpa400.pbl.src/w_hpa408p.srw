$PBExportHeader$w_hpa408p.srw
$PBExportComments$대학별 비과세 연구보조비 지급액 총괄표 출력
forward
global type w_hpa408p from w_print_form2
end type
type uo_year from cuo_year within w_hpa408p
end type
end forward

global type w_hpa408p from w_print_form2
string title = "대학별 비과세 연구보조비 지급액 총괄표 출력"
uo_year uo_year
end type
global w_hpa408p w_hpa408p

type variables
mailSession 		m_mail_session 
mailReturnCode		m_rtn
mailMessage 		m_message

string	is_str_member= '          ', is_end_member = 'zzzzzzzzzz'
string	is_year, is_bef_year

string	is_youngu_code = '06', is_str_duty = '101', is_end_duty = '104'
string	is_youngu1_code = '10'

end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_getchild2 ()
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

end subroutine

public subroutine wf_getchild2 ();
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



 dw_print.retrieve(is_year) 

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

on w_hpa408p.create
int iCurrent
call super::create
this.uo_year=create uo_year
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_year
end on

on w_hpa408p.destroy
call super::destroy
destroy(this.uo_year)
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

type ln_templeft from w_print_form2`ln_templeft within w_hpa408p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa408p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa408p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa408p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa408p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa408p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa408p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa408p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa408p
end type

type uc_save from w_print_form2`uc_save within w_hpa408p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa408p
end type

type uc_print from w_print_form2`uc_print within w_hpa408p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa408p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa408p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa408p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa408p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa408p
end type

type st_back from w_print_form2`st_back within w_hpa408p
boolean visible = false
integer x = 46
end type

type dw_print from w_print_form2`dw_print within w_hpa408p
integer taborder = 60
string dataobject = "d_hpa408p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_print::retrieveend;call super::retrieveend;//long		ll_row
//integer	i
//string	ls_campus_name, ls_business_no, ls_address, ls_tel_phone
//
//if rowcount < 0 then return
//
//ls_campus_name	=	getitemstring(1, 'campus_name')
//ls_business_no	=	getitemstring(1, 'business_no')
//ls_address		=	getitemstring(1, 'address')
//ls_tel_phone	=	getitemstring(1, 'tel_phone')
//	
//for i = 1 to 4
//	ll_row	=	insertrow(0)
//	setitem(ll_row, 'duty_code',	'@' + string(i))
//	setitem(ll_row, 'duty_name',	'')
//	setitem(ll_row, 'member_no',	'')
//	setitem(ll_row, 'year',			'')
//	setitem(ll_row, 'campus_name',	ls_campus_name)
//	setitem(ll_row, 'business_no',	ls_business_no)
//	setitem(ll_row, 'address',			ls_address)
//	setitem(ll_row, 'tel_phone',		ls_tel_phone)
//next
end event

type st_1 from w_print_form2`st_1 within w_hpa408p
boolean visible = false
end type

type dw_head from w_print_form2`dw_head within w_hpa408p
boolean visible = false
end type

event dw_head::itemchanged;call super::itemchanged;wf_getchild2()
end event

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa408p
boolean visible = false
integer y = 144
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa408p
boolean visible = false
end type

event uo_dept_code::ue_itemchange;call super::ue_itemchange;wf_getchild2()
end event

type st_2 from w_print_form2`st_2 within w_hpa408p
integer x = 864
integer y = 204
integer width = 1303
string text = "※ 반드시 조회를 하시기 바랍니다."
end type

type st_3 from w_print_form2`st_3 within w_hpa408p
boolean visible = false
end type

type st_con from w_print_form2`st_con within w_hpa408p
end type

type dw_con from w_print_form2`dw_con within w_hpa408p
boolean visible = false
end type

type uo_year from cuo_year within w_hpa408p
integer x = 105
integer y = 184
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

