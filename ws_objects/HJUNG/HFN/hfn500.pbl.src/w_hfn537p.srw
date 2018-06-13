$PBExportHeader$w_hfn537p.srw
$PBExportComments$등록금명세서
forward
global type w_hfn537p from w_hfn_print_form5
end type
end forward

global type w_hfn537p from w_hfn_print_form5
end type
global w_hfn537p w_hfn537p

type variables

end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();DateTime Ldt_SysDateTime
string	ls_date
date		ld_date
String	ls_str_date, ls_end_date
dw_print.Reset()
dw_con.accepttext()


ls_date = string(dw_con.object.bdgt_year[1],'yyyymm') + '01'

// 회계년도에 대한 기간 구하기
ls_str_date = ''
ls_end_date = mid(ls_date,1,6) + '31'

Select From_Date Into :ls_str_date
  From acdb.hac003m
 Where :ls_date between from_date and to_date
   And bdgt_class = 0
	And stat_class = 0 ;
	
if sqlca.sqlcode <> 0 then
	messagebox('확인', '회계년월의 설정이 올바르지 않습니다.')
	return
end if

wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(gi_acct_class, ls_str_date, ls_end_date)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true

	dw_print.Object.t_slip_date.Text = mid(ls_str_date,1,4) + '년(' + String(dw_con.object.bdgt_year[1], 'yyyy/mm') + ')'
end if

wf_setMsg('')

end subroutine

on w_hfn537p.create
int iCurrent
call super::create
end on

on w_hfn537p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//string  ls_sys_date
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ls_sys_date = f_today()
//
//em_bdgt_year.text = left(ls_sys_date,4) + '/' + mid(ls_sys_date,5,2)
//
//em_bdgt_year.SetFocus()
//
end event

event ue_postopen;call super::ue_postopen;

dw_con.object.bdgt_year[1] = date(String(f_today(), '@@@@/@@/@@'))

dw_con.SetFocus()
dw_con.setcolumn('bdgt_year')
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

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn537p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn537p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn537p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn537p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn537p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn537p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn537p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn537p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn537p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn537p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn537p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn537p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn537p
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn537p
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn537p
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn537p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn537p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn537p
boolean visible = false
integer x = 832
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn537p
boolean visible = false
integer x = 2190
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn537p
integer taborder = 20
string dataobject = "d_hfn537p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn537p
string dataobject = "d_hfn537p_con"
end type

