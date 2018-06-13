$PBExportHeader$w_hfn505p.srw
$PBExportComments$총계정원장
forward
global type w_hfn505p from w_hfn_print_form5
end type
end forward

global type w_hfn505p from w_hfn_print_form5
end type
global w_hfn505p w_hfn505p

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();DateTime	ldt_SysDateTime
string	ls_acct_code
string	ls_gubun
string	ls_bdgt_year
    date ld_date
	 long Ll_cnt

STring 	ls_all_printyn, ls_str_date, ls_end_date
dw_con.accepttext()

ls_all_printyn = dw_con.object.all_printyn[1]
ls_gubun = dw_con.object.gubun[1]
ls_str_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
ls_end_date = string(dw_con.object.to_date[1], 'yyyymmdd')
// 조회계정코드
ls_acct_code = dw_con.Object.acct_code[1]

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
	f_messagebox('1', '회계기간에 해당하는 일자가 아닙니다.~r~r' + &
	                  '확인 후 조회하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return
end if

// 회계년도 가져오기
select	bdgt_year	into	:ls_bdgt_year
from		acdb.hac003m
where		:ls_str_date	between from_date and to_date
and		bdgt_class = 0
and		stat_class = 0	;



wf_setMsg('조회중')

if ls_all_printyn = 'Y' then		//연속용지
	dw_print.DataObject = 'd_hfn505p_11'
else
	dw_print.DataObject = 'd_hfn505p_1'
end if

dw_print.SetTransObject(SQLCA)
dw_print.Modify("DataWindow.Print.Preview='yes'")

dw_print.SetRedraw(False)
dw_print.retrieve(gi_acct_class, ls_bdgt_year, ls_str_date, ls_end_date, ls_acct_code, ls_gubun)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true
end if

wf_setMsg('')

end subroutine

on w_hfn505p.create
int iCurrent
call super::create
end on

on w_hfn505p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//datawindowchild	ldw_child
//string 				ls_sys_date
//
//
//
//dw_con.object.gubun[1] = '1'
//			
//dw_con.getchild('acct_code', ldw_child)
//ldw_child.settransobject(sqlca)
//ldw_child.reset()
//ldw_child.retrieve('1')
//ldw_child.insertrow(1)
//ldw_child.setitem(1, 'com_code', '')
//ldw_child.setitem(1, 'com_name', '계정전체')		
//dw_con.setitem(1, 'acct_code', '')
//
//
//ls_sys_date = f_today()
//
//dw_con.object.fr_date[1] = date(string(ls_sys_date, '@@@@/@@/@@'))
//dw_con.object.to_date[1] = date(string(ls_sys_date, '@@@@/@@/@@'))
//
end event

event ue_postopen;call super::ue_postopen;datawindowchild	ldw_child
string 				ls_sys_date



dw_con.object.gubun[1] = '1'
			
dw_con.getchild('acct_code', ldw_child)
ldw_child.settransobject(sqlca)
ldw_child.reset()
ldw_child.retrieve('1')
ldw_child.insertrow(1)
ldw_child.setitem(1, 'com_code', '')
ldw_child.setitem(1, 'com_name', '계정전체')		
dw_con.setitem(1, 'acct_code', '')


ls_sys_date = f_today()

dw_con.object.fr_date[1] = date(string(ls_sys_date, '@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string(ls_sys_date, '@@@@/@@/@@'))
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

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn505p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn505p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn505p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn505p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn505p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn505p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn505p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn505p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn505p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn505p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn505p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn505p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn505p
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn505p
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn505p
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn505p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn505p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn505p
boolean visible = false
integer x = 2903
integer y = 96
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn505p
boolean visible = false
integer x = 2862
integer y = 620
integer width = 599
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn505p
integer y = 288
integer height = 1988
integer taborder = 50
string dataobject = "d_hfn505p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn505p
string dataobject = "d_hfn505p_con"
end type

event dw_con::itemchanged;call super::itemchanged;This.accepttext()
Choose Case dwo.name
	case 'gubun'
		datawindowchild	ldw_child
		string				ls_gubun
		
		ls_gubun = data
				
		dw_con.getchild('acct_code', ldw_child)
		ldw_child.settransobject(sqlca)
		ldw_child.reset()
		ldw_child.retrieve(ls_gubun)
		ldw_child.insertrow(1)
		ldw_child.setitem(1, 'com_code', '')
		ldw_child.setitem(1, 'com_name', '계정전체')		
		dw_con.setitem(1, 'acct_code', '')


End Choose
end event

event dw_con::constructor;call super::constructor;if gs_DeptCode = '2902' then
	dw_con.object.all_printyn.visible = true
	//dw_con.object.all_printyn[1] = 'Y'
else
	dw_con.object.all_printyn.visible = false
	//dw_con.object.all_printyn[1] = 'N'
end if
end event

