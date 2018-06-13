$PBExportHeader$w_hfn536p.srw
$PBExportComments$실험실습비원장
forward
global type w_hfn536p from w_hfn_print_form5
end type
end forward

global type w_hfn536p from w_hfn_print_form5
end type
global w_hfn536p w_hfn536p

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();DateTime	ldt_SysDateTime
  String Ls_From_Date, ls_gwa
    date ld_date
	 long Ll_cnt
String	ls_str_date, ls_end_date	 

dw_print.Reset()
dw_con.accepttext()


ls_str_date = string(dw_con.object.fr_date[1], 'yyyymmdd')

ls_end_date = string(dw_con.object.to_date[1], 'yyyymmdd')

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

// 요구기준일자
select From_Date into :Ls_From_Date from acdb.hac003m
 where :ls_str_date between from_date and to_date
   and bdgt_class = 0
   and stat_class = 0 ;

ls_gwa = dw_con.getitemstring(1,'code')

wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(gi_acct_class, Ls_From_Date, ls_str_date, ls_end_date, ls_gwa)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true

   dw_print.Object.t_bdgt_year.Text = left(ls_str_date,4) + '년'
   dw_print.Object.t_slip_date.Text = string(ls_str_date, '@@@@/@@/@@' )+ ' ∼ ' + string(ls_end_date, '@@@@/@@/@@')
end if

wf_setMsg('')

end subroutine

on w_hfn536p.create
int iCurrent
call super::create
end on

on w_hfn536p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//datawindowchild	ldw_child
//string  				ls_sys_date
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ls_sys_date = f_today()
//
//em_fr_date.text = string(ls_sys_date, '@@@@/@@/@@')
//em_to_date.text = string(ls_sys_date, '@@@@/@@/@@')
//
//dw_dept.GetChild('code',ldw_child)
//ldw_child.SetTransObject(SQLCA)
//ldw_child.Retrieve(1, 3)
//ldw_child.insertrow(1)
//ldw_child.setitem(1,'dept_code','%')
//ldw_child.setitem(1,'dept_name','전체')
//
//dw_dept.InsertRow(0)
//dw_dept.Object.code[1] = gs_DeptCode
//
//em_fr_date.SetFocus()
end event

event ue_postopen;call super::ue_postopen;datawindowchild	ldw_child

dw_con.object.fr_date[1] = date(string( f_today(), '@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string( f_today(), '@@@@/@@/@@'))

dw_con.GetChild('code',ldw_child)
ldw_child.SetTransObject(SQLCA)
ldw_child.Retrieve(1, 3)
ldw_child.insertrow(1)
ldw_child.setitem(1,'dept_code','%')
ldw_child.setitem(1,'dept_name','전체')


dw_con.Object.code[1] = gs_DeptCode

dw_con.SetFocus()
dw_con.setcolumn('to_date')
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

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn536p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn536p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn536p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn536p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn536p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn536p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn536p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn536p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn536p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn536p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn536p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn536p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn536p
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn536p
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn536p
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn536p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn536p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn536p
boolean visible = false
integer x = 2789
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn536p
boolean visible = false
integer x = 2395
integer y = 80
integer width = 1029
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn536p
string dataobject = "d_hfn536p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn536p
string dataobject = "d_hfn202a_con"
end type

event dw_con::constructor;call super::constructor;this.object.code_t.text = '조회부서'
This.object.fr_date_t.text = '회계일자'
end event

