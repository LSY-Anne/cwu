$PBExportHeader$w_hac410p.srw
$PBExportComments$주관부서별 자금예산서(산출근거포함)(예산부서용)
forward
global type w_hac410p from w_print_form1
end type
type uo_acct_class from cuo_acct_class within w_hac410p
end type
type gb_2 from gb_3 within w_hac410p
end type
end forward

global type w_hac410p from w_print_form1
string title = "주관부서별 자금예산서(산출근거포함)"
uo_acct_class uo_acct_class
gb_2 gb_2
end type
global w_hac410p w_hac410p

type variables
string	is_dept_code		// 주관부서

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

// 예산/주관부서
dw_con.getchild('code', idw_child)
idw_child.settransobject(sqlca)

// 로긴부서가 예산부서면 주관부서를 선택하여 조회할 수 있다.
if idw_child.retrieve(1, 2) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
else
	idw_child.insertrow(1)
	idw_child.setitem(1, 'dept_code', '%')
	idw_child.setitem(1, 'dept_name', '전체')
end if
dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
dw_con.object.code_t.text = '주관부서'
is_bdgt_year = left(f_today(), 4)
is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)



idw_child.scrolltorow(1)

is_dept_code		=	''



//// 로긴부서가 주관부서면 로긴부서만 조회한다.
//if gstru_uid_uname.dept_opt1 = 2 then
//	idw_child.insertrow(1)
//	idw_child.setitem(1, 'dept_code',	gstru_uid_uname.dept_code)
//	idw_child.setitem(1, 'dept_name',	f_getdeptname(gstru_uid_uname.dept_code))
//
//	dw_head.reset()
//	dw_head.insertrow(0)
//
//	idw_child.scrolltorow(1)
//
//	dw_head.enabled	=	false
//	dw_head.object.code.background.color = 78682240
//	
//	is_dept_code		=	gstru_uid_uname.dept_code
//
//// 로긴부서가 예산부서면 주관부서를 선택하여 조회할 수 있다.
//elseif gstru_uid_uname.dept_opt1 = 1 then
//	if idw_child.retrieve(1, 2) < 1 then
//		idw_child.reset()
//		idw_child.insertrow(0)
//	else
//		idw_child.insertrow(1)
//		idw_child.setitem(1, 'dept_code', '%')
//		idw_child.setitem(1, 'dept_name', '전체')
//	end if
//	
//	dw_head.reset()
//	dw_head.insertrow(0)
//
//	idw_child.scrolltorow(1)
//	
//	dw_head.enabled	= true
//	dw_head.object.code.background.color = rgb(255, 255, 255)
//
//	is_dept_code		=	''
//else
//	dw_head.reset()
//	dw_head.insertrow(0)
//
//	dw_head.enabled	= false
//	dw_head.object.code.background.color = 78682240
//
//	is_dept_code		=	'*&*&*&*&**&*&*&*&*'
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
dw_con.accepttext()
is_bdgt_year = string(dw_con.object.year[1], 'yyyy')
is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)
is_slip_class = dw_con.object.slip_class[1]
If is_slip_class = '%' Then is_slip_class = ''
is_amt_gubun = dw_con.object.amt_gu[1]
is_dept_code = dw_con.object.code[1]

if dw_print.retrieve(is_bdgt_year, is_bef_bdgt_year, is_dept_code, gi_acct_class, is_slip_class, ii_bdgt_class, is_amt_gubun) > 0 then
	dw_print.sort()
	dw_print.groupcalc()
end if

end subroutine

on w_hac410p.create
int iCurrent
call super::create
this.uo_acct_class=create uo_acct_class
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_acct_class
this.Control[iCurrent+2]=this.gb_2
end on

on w_hac410p.destroy
call super::destroy
destroy(this.uo_acct_class)
destroy(this.gb_2)
end on

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//ii_acct_class = uo_acct_class.uf_getcode()
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
//ii_acct_class = uo_acct_class.uf_getcode()

wf_getchild()
idw_print = dw_print
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

type ln_templeft from w_print_form1`ln_templeft within w_hac410p
end type

type ln_tempright from w_print_form1`ln_tempright within w_hac410p
end type

type ln_temptop from w_print_form1`ln_temptop within w_hac410p
end type

type ln_tempbuttom from w_print_form1`ln_tempbuttom within w_hac410p
end type

type ln_tempbutton from w_print_form1`ln_tempbutton within w_hac410p
end type

type ln_tempstart from w_print_form1`ln_tempstart within w_hac410p
end type

type uc_retrieve from w_print_form1`uc_retrieve within w_hac410p
end type

type uc_insert from w_print_form1`uc_insert within w_hac410p
end type

type uc_delete from w_print_form1`uc_delete within w_hac410p
end type

type uc_save from w_print_form1`uc_save within w_hac410p
end type

type uc_excel from w_print_form1`uc_excel within w_hac410p
end type

type uc_print from w_print_form1`uc_print within w_hac410p
end type

type st_line1 from w_print_form1`st_line1 within w_hac410p
end type

type st_line2 from w_print_form1`st_line2 within w_hac410p
end type

type st_line3 from w_print_form1`st_line3 within w_hac410p
end type

type uc_excelroad from w_print_form1`uc_excelroad within w_hac410p
end type

type ln_dwcon from w_print_form1`ln_dwcon within w_hac410p
integer beginy = 360
integer endy = 360
end type

type uo_slip_class from w_print_form1`uo_slip_class within w_hac410p
boolean visible = false
end type

type rb_3 from w_print_form1`rb_3 within w_hac410p
boolean visible = false
end type

type rb_2 from w_print_form1`rb_2 within w_hac410p
boolean visible = false
end type

type rb_1 from w_print_form1`rb_1 within w_hac410p
boolean visible = false
end type

type gb_1 from w_print_form1`gb_1 within w_hac410p
boolean visible = false
end type

type uo_bdgt_year from w_print_form1`uo_bdgt_year within w_hac410p
boolean visible = false
integer x = 73
end type

type gb_3 from w_print_form1`gb_3 within w_hac410p
boolean visible = false
end type

type st_back from w_print_form1`st_back within w_hac410p
boolean visible = false
integer y = 364
integer height = 1916
end type

type dw_print from w_print_form1`dw_print within w_hac410p
integer y = 364
integer height = 1916
string dataobject = "d_hac410p_1_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_con from w_print_form1`dw_con within w_hac410p
integer height = 196
string dataobject = "d_hac409p_con"
end type

event dw_con::itemchanged;call super::itemchanged;dw_con.accepttext()
Choose Case dwo.name
	Case 'year'
		is_bdgt_year = left(data, 4)
		is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)
	Case 'slip_class'
		
		is_slip_class = data
	Case 'amt_gu'
		is_amt_gubun = data
End Choose

end event

type uo_acct_class from cuo_acct_class within w_hac410p
event destroy ( )
boolean visible = false
integer x = 2537
integer y = 44
integer taborder = 190
boolean bringtotop = true
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

end event

type gb_2 from gb_3 within w_hac410p
integer y = 160
integer width = 3881
integer taborder = 20
end type

