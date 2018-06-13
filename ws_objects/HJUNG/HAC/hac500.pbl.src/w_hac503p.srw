$PBExportHeader$w_hac503p.srw
$PBExportComments$부서별 예산사용 현황 출력(전체부서-기획처)
forward
global type w_hac503p from w_print_form1
end type
end forward

global type w_hac503p from w_print_form1
end type
global w_hac503p w_hac503p

type variables
datawindow			idw_mast




end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
// 요구부서
dw_con.getchild('code', idw_child)
idw_child.settransobject(sqlca)
idw_child.retrieve(1,3)
idw_child.insertrow(1)
idw_child.setitem(1,'dept_code','')
idw_child.setitem(1,'dept_name','전체')

dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
dw_con.object.year_t.text = '요구년도'
dw_con.object.code_t.text = '요구부서'


//idw_print.getchild('gwa', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(1, 3) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if

end subroutine

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String ls_bdgt_year, ls_gwa, ls_slip_class
dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1],'yyyy')
ls_gwa = dw_con.object.code[1]
ls_slip_class =  dw_con.object.slip_class[1]
If ls_slip_class = '%' Then ls_slip_class = ''


if idw_print.retrieve(ls_bdgt_year, ls_gwa, gi_acct_class, ls_slip_class) < 1 then


	idw_print.reset()
	dw_con.setfocus()
	dw_con.setcolumn('year')
else

end if


end subroutine

on w_hac503p.create
int iCurrent
call super::create
end on

on w_hac503p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_print		=	dw_print
//ist_back			=	st_back
//
////uo_slip_class.rb_1.visible = false
//
//wf_getchild()
//
//dw_con.setitem(1, 'code', gs_deptcode)
//
//
//is_pay_date = f_today()
//
end event

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
wf_setMsg('조회중')

wf_retrieve()

wf_setMsg('')
//f_setpointer('END')
return 1

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_print		=	dw_print


//uo_slip_class.rb_1.visible = false

wf_getchild()

dw_con.setitem(1, 'code', gs_deptcode)


//is_pay_date = f_today()

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

type ln_templeft from w_print_form1`ln_templeft within w_hac503p
end type

type ln_tempright from w_print_form1`ln_tempright within w_hac503p
end type

type ln_temptop from w_print_form1`ln_temptop within w_hac503p
end type

type ln_tempbuttom from w_print_form1`ln_tempbuttom within w_hac503p
end type

type ln_tempbutton from w_print_form1`ln_tempbutton within w_hac503p
end type

type ln_tempstart from w_print_form1`ln_tempstart within w_hac503p
end type

type uc_retrieve from w_print_form1`uc_retrieve within w_hac503p
end type

type uc_insert from w_print_form1`uc_insert within w_hac503p
end type

type uc_delete from w_print_form1`uc_delete within w_hac503p
end type

type uc_save from w_print_form1`uc_save within w_hac503p
end type

type uc_excel from w_print_form1`uc_excel within w_hac503p
end type

type uc_print from w_print_form1`uc_print within w_hac503p
end type

type st_line1 from w_print_form1`st_line1 within w_hac503p
end type

type st_line2 from w_print_form1`st_line2 within w_hac503p
end type

type st_line3 from w_print_form1`st_line3 within w_hac503p
end type

type uc_excelroad from w_print_form1`uc_excelroad within w_hac503p
end type

type ln_dwcon from w_print_form1`ln_dwcon within w_hac503p
end type

type uo_slip_class from w_print_form1`uo_slip_class within w_hac503p
boolean visible = false
integer x = 2272
end type

event uo_slip_class::ue_itemchanged;call super::ue_itemchanged;is_slip_class	=	uf_getcode()

end event

type rb_3 from w_print_form1`rb_3 within w_hac503p
boolean visible = false
integer x = 3163
integer y = 352
end type

type rb_2 from w_print_form1`rb_2 within w_hac503p
boolean visible = false
integer x = 2665
integer y = 352
end type

type rb_1 from w_print_form1`rb_1 within w_hac503p
boolean visible = false
integer x = 2167
integer y = 352
end type

type gb_1 from w_print_form1`gb_1 within w_hac503p
boolean visible = false
integer x = 1883
integer y = 264
end type

type uo_bdgt_year from w_print_form1`uo_bdgt_year within w_hac503p
boolean visible = false
integer y = 56
end type

event uo_bdgt_year::ue_itemchange;call super::ue_itemchange;is_bdgt_year	=	uf_getyy()

end event

type gb_3 from w_print_form1`gb_3 within w_hac503p
boolean visible = false
integer width = 3872
integer height = 180
end type

type st_back from w_print_form1`st_back within w_hac503p
boolean visible = false
end type

type dw_print from w_print_form1`dw_print within w_hac503p
string dataobject = "d_hac503p"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_con from w_print_form1`dw_con within w_hac503p
string dataobject = "d_hac104a_con"
end type

