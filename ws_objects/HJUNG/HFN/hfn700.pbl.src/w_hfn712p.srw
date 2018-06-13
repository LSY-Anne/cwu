$PBExportHeader$w_hfn712p.srw
$PBExportComments$계좌번호별 입출금내역
forward
global type w_hfn712p from w_hfn_print_form5
end type
end forward

global type w_hfn712p from w_hfn_print_form5
end type
global w_hfn712p w_hfn712p

type variables

end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();DateTime	ldt_SysDateTime
  string ls_bdgt_year, ls_acct_no
    date ld_date
	 long ll_cnt
String ls_str_date, ls_end_date
dw_con.accepttext()
ls_str_date = String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_end_date = String(dw_con.object.to_date[1], 'yyyymmdd')

dw_print.Reset()


if ls_str_date > ls_end_date then
	f_messagebox('1', '회계일자의 범위가 올바르지 않습니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return
end if

// 요구기간 설정
select count(*) into :Ll_cnt from acdb.hac003m
 where (:ls_str_date between from_date and to_date
        and bdgt_class = 0
	     and stat_class = 0)
	and (:ls_end_date between from_date and to_date
        and bdgt_class = 0
	     and stat_class = 0);
 
if ll_cnt < 1 then
	f_messagebox('1', '요구기간에 해당하는 일자가 아닙니다.~r~r' + &
	                  '확인 후 조회하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return
end if

// 회계년도 시작일자
select bdgt_year into :ls_bdgt_year from acdb.hac003m
 where :ls_str_date between from_date and to_date
   and bdgt_class = 0
	and stat_class = 0 ;
	


ls_acct_no = dw_con.getitemstring(1, 'acct_no')
if isnull(ls_acct_no) then ls_acct_no = ''

wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(ii_acct_class, ls_bdgt_year, ls_str_date, ls_end_date, ls_acct_no)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true
end if

wf_setMsg('')

end subroutine

on w_hfn712p.create
int iCurrent
call super::create
end on

on w_hfn712p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//datawindowchild	ldw_child, ldw_child1
//string  				ls_sys_date
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ls_sys_date = f_today()
//
//em_fr_date.text = string(ls_sys_date,'@@@@/@@/@@')
//em_to_date.text = string(ls_sys_date,'@@@@/@@/@@')
//
//dw_gyeja.getchild('acct_no', ldw_child)
//ldw_child.settransobject(sqlca)
//ldw_child.getchild('bank_code', ldw_child1)
//ldw_child1.settransobject(sqlca)
//if ldw_child1.retrieve('bank_code', 1) < 1 then
//	ldw_child1.reset()
//	ldw_child1.insertrow(0)
//end if
//dw_gyeja.insertrow(0)
//
//em_fr_date.SetFocus()
end event

event ue_postopen;call super::ue_postopen;datawindowchild	ldw_child, ldw_child1
string  				ls_sys_date

ls_sys_date = f_today()

dw_con.object.fr_date[1] = date(string(ls_sys_date,'@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string(ls_sys_date,'@@@@/@@/@@'))


dw_con.getchild('acct_no', ldw_child)
ldw_child.settransobject(sqlca)
ldw_child.getchild('bank_code', ldw_child1)
ldw_child1.settransobject(sqlca)
if ldw_child1.retrieve('bank_code', 1) < 1 then
	ldw_child1.reset()
	ldw_child1.insertrow(0)
end if

idw_print = dw_print
dw_con.SetFocus()
dw_con.setcolumn('to_date')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "계좌번호별 입출금내역표")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn712p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn712p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn712p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn712p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn712p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn712p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn712p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn712p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn712p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn712p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn712p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn712p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn712p
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn712p
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn712p
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn712p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn712p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn712p
boolean visible = false
integer x = 2683
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn712p
boolean visible = false
integer x = 2190
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn712p
integer taborder = 20
string dataobject = "d_hfn712p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn712p
string dataobject = "d_hfn712p_con"
end type

