$PBExportHeader$w_hpa325p.srw
$PBExportComments$연말공제내역서
forward
global type w_hpa325p from w_print_form2
end type
type uo_year from cuo_year within w_hpa325p
end type
end forward

global type w_hpa325p from w_print_form2
string title = "연말공제내역서"
uo_year uo_year
end type
global w_hpa325p w_hpa325p

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
is_yearmonth =  string(dw_con.object.year[1],'yyyy')// mid(is_yearmonth,1,4) 
//messagebox('',is_yearmonth)
if dw_print.retrieve(is_yearmonth) > 0 then
	st_back.bringtotop = false
end if

return 0

end function

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////
dw_print.settransobject(sqlca)

//wf_retrieve()
st_back.bringtotop = true
is_yearmonth = mid(is_yearmonth,1,4) 
//messagebox('',is_yearmonth)
if dw_print.retrieve(is_yearmonth) > 0 then
	st_back.bringtotop = false
end if

//return 0

return 1
end event

on w_hpa325p.create
int iCurrent
call super::create
this.uo_year=create uo_year
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_year
end on

on w_hpa325p.destroy
call super::destroy
destroy(this.uo_year)
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

event ue_open;//
// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

wf_button_control()

idw_print = dw_print

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

type ln_templeft from w_print_form2`ln_templeft within w_hpa325p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa325p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa325p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa325p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa325p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa325p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa325p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa325p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa325p
end type

type uc_save from w_print_form2`uc_save within w_hpa325p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa325p
end type

type uc_print from w_print_form2`uc_print within w_hpa325p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa325p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa325p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa325p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa325p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa325p
end type

type st_back from w_print_form2`st_back within w_hpa325p
boolean visible = false
end type

type dw_print from w_print_form2`dw_print within w_hpa325p
string dataobject = "d_hpa325p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_print::retrieveend;//
//dw_display_title.uf_display_title(this)


end event

event dw_print::constructor;//
end event

type st_1 from w_print_form2`st_1 within w_hpa325p
boolean visible = false
integer x = 1339
integer y = 76
end type

type dw_head from w_print_form2`dw_head within w_hpa325p
boolean visible = false
integer x = 1065
integer y = 40
string dataobject = ""
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa325p
boolean visible = false
integer x = 2482
integer y = 44
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa325p
boolean visible = false
integer x = 1541
integer y = 24
end type

type st_2 from w_print_form2`st_2 within w_hpa325p
end type

type st_3 from w_print_form2`st_3 within w_hpa325p
end type

type st_con from w_print_form2`st_con within w_hpa325p
boolean visible = false
integer x = 55
integer y = 12
end type

type dw_con from w_print_form2`dw_con within w_hpa325p
string dataobject = "d_hpa325p_con"
end type

event dw_con::constructor;call super::constructor;string	ls_yy

//st_title.text = is_year_title
ls_yy	= f_today()

this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))

is_yearmonth = left(ls_yy, 4)
end event

type uo_year from cuo_year within w_hpa325p
boolean visible = false
integer x = 110
integer y = 52
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
boolean border = false
end type

on uo_year.destroy
call cuo_year::destroy
end on

event constructor;call super::constructor;string	ls_yy

//st_title.text = is_year_title
ls_yy	= f_today()

em_year.text = left(ls_yy, 4)
is_yearmonth = left(ls_yy, 4)
end event

