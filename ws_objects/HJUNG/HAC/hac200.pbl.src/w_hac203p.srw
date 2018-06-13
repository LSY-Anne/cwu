$PBExportHeader$w_hac203p.srw
$PBExportComments$세입세출예산서(단위부서용)
forward
global type w_hac203p from w_print_form1
end type
type uo_acct_class from cuo_acct_class within w_hac203p
end type
end forward

global type w_hac203p from w_print_form1
string title = "주관부서별 자금예산서(산출내역포함)(주관부서용)"
uo_acct_class uo_acct_class
end type
global w_hac203p w_hac203p

forward prototypes
public subroutine wf_retrieve ()
end prototypes

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

if is_amt_gubun = '1' then
	dw_print.dataobject = 'd_hac203p_1_1'
	dw_print.settransobject(sqlca)

	if dw_print.retrieve(is_bdgt_year, is_bef_bdgt_year, gs_deptcode, ii_acct_class, is_slip_class, ii_bdgt_class) > 0 then
		dw_print.sort()
		dw_print.groupcalc()
	end if
else
	dw_print.dataobject = 'd_hac203p_1_2'
	dw_print.settransobject(sqlca)

	if dw_print.retrieve(is_bdgt_year, is_bef_bdgt_year, gs_deptcode, ii_acct_class, is_slip_class, ii_bdgt_class, is_amt_gubun) > 0 then
		dw_print.sort()
		dw_print.groupcalc()
	end if
end if

end subroutine

on w_hac203p.create
int iCurrent
call super::create
this.uo_acct_class=create uo_acct_class
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_acct_class
end on

on w_hac203p.destroy
call super::destroy
destroy(this.uo_acct_class)
end on

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
ii_acct_class 	= 	uo_acct_class.uf_getcode()
idw_print = dW_print

//rb_2.enabled = false
//rb_3.enabled = false

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

type ln_templeft from w_print_form1`ln_templeft within w_hac203p
end type

type ln_tempright from w_print_form1`ln_tempright within w_hac203p
end type

type ln_temptop from w_print_form1`ln_temptop within w_hac203p
end type

type ln_tempbuttom from w_print_form1`ln_tempbuttom within w_hac203p
end type

type ln_tempbutton from w_print_form1`ln_tempbutton within w_hac203p
end type

type ln_tempstart from w_print_form1`ln_tempstart within w_hac203p
end type

type uc_retrieve from w_print_form1`uc_retrieve within w_hac203p
end type

type uc_insert from w_print_form1`uc_insert within w_hac203p
end type

type uc_delete from w_print_form1`uc_delete within w_hac203p
end type

type uc_save from w_print_form1`uc_save within w_hac203p
end type

type uc_excel from w_print_form1`uc_excel within w_hac203p
end type

type uc_print from w_print_form1`uc_print within w_hac203p
end type

type st_line1 from w_print_form1`st_line1 within w_hac203p
end type

type st_line2 from w_print_form1`st_line2 within w_hac203p
end type

type st_line3 from w_print_form1`st_line3 within w_hac203p
end type

type uc_excelroad from w_print_form1`uc_excelroad within w_hac203p
end type

type ln_dwcon from w_print_form1`ln_dwcon within w_hac203p
end type

type uo_slip_class from w_print_form1`uo_slip_class within w_hac203p
boolean visible = false
end type

type rb_3 from w_print_form1`rb_3 within w_hac203p
boolean visible = false
end type

type rb_2 from w_print_form1`rb_2 within w_hac203p
boolean visible = false
end type

type rb_1 from w_print_form1`rb_1 within w_hac203p
boolean visible = false
end type

type gb_1 from w_print_form1`gb_1 within w_hac203p
boolean visible = false
end type

type uo_bdgt_year from w_print_form1`uo_bdgt_year within w_hac203p
boolean visible = false
integer x = 69
end type

type gb_3 from w_print_form1`gb_3 within w_hac203p
boolean visible = false
end type

type st_back from w_print_form1`st_back within w_hac203p
boolean visible = false
end type

type dw_print from w_print_form1`dw_print within w_hac203p
string dataobject = "d_hac203p_1_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_con from w_print_form1`dw_con within w_hac203p
string dataobject = "d_hac203p_con"
end type

event dw_con::itemchanged;call super::itemchanged;

dw_con.accepttext()
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

event dw_con::constructor;call super::constructor;this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
is_bdgt_year = left(f_today(), 4)
is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)
end event

type uo_acct_class from cuo_acct_class within w_hac203p
event destroy ( )
boolean visible = false
integer x = 2537
integer y = 40
integer taborder = 130
boolean bringtotop = true
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

end event

