$PBExportHeader$w_hfn506p.srw
$PBExportComments$회계원장
forward
global type w_hfn506p from w_hfn_print_form5
end type
type cb_1 from uo_imgbtn within w_hfn506p
end type
end forward

global type w_hfn506p from w_hfn_print_form5
cb_1 cb_1
end type
global w_hfn506p w_hfn506p

type variables
String is_bdgt_year
end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_data_proc ()
end prototypes

public subroutine wf_retrieve ();DateTime	ldt_SysDateTime
string	ls_acct_code
string	ls_gubun
    date ld_date
	 long Ll_cnt
String 	ls_str_date, ls_end_date, ls_all_printyn	 

dw_con.accepttext()
dw_print.Reset()

ls_str_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
ls_end_date = string(dw_con.object.to_date[1], 'yyyymmdd')
ls_all_printyn = dw_con.object.all_printyn[1]
ls_gubun = dw_con.object.gubun[1]

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
select	bdgt_year	into	:is_bdgt_year
from		acdb.hac003m
where		:ls_str_date	between from_date and to_date
and		bdgt_class = 0
and		stat_class = 0	;

// 조회계정코드
ls_acct_code = trim(dw_con.Object.acct_code[1])

wf_setMsg('조회중')

dw_print.SetRedraw(False)


if ls_all_printyn = 'Y'  then		//연속용지
	dw_print.DataObject = 'd_hfn506p_11'
else
	dw_print.DataObject = 'd_hfn506p_1'
end if

dw_print.SetTransObject(SQLCA)
dw_print.Modify("DataWindow.Print.Preview='yes'")


dw_print.retrieve(gi_acct_class, is_bdgt_year, ls_str_date, ls_end_date, ls_acct_code, ls_gubun)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true

	if ls_acct_code = '' then
		// 전기이월운영차액을 처리한다.
		// 전기이월운영차액 = 당기운영차액
		wf_data_proc()
		dw_print.setsort('com_acct_code, com_acct_name, com_acct_date, com_slip_date, com_slip_no, com_slip_seq')
		dw_print.sort()
		dw_print.groupcalc()
	end if
end if

wf_setMsg('')

end subroutine

public subroutine wf_data_proc ();// 당기의 운영차액을 계산하여 삽입한다.
// 당기운영차액 = 수익합계 - 지출합계 - 기본금대체액합계
String  Ls_FrCode[] = {'5000', '4000', '6000'}
String  Ls_ToCode[] = {'5999', '4999', '6999'}
Long    Ll_Row
Dec{0}  Ldc_Dr_Cash[], Ldc_Dr_Alt[], Ldc_Cr_Cash[], Ldc_Cr_Alt[]
Dec{0}  Ldc_Dr_Cash_Amt, Ldc_Dr_Alt_Amt, Ldc_Cr_Cash_Amt, Ldc_Cr_Alt_Amt
Integer Li_Num

// 수익, 지출, 기본금대체액 합계
// 1:수익, 2:지출, 3:기본금대체액
FOR Li_Num = 1 TO 3
	 // 변수금액 초기화
	 Ldc_Dr_Cash[Li_Num] = 0
	 Ldc_Dr_Alt[Li_Num]  = 0
	 Ldc_Cr_Cash[Li_Num] = 0
	 Ldc_Cr_Alt[Li_Num]  = 0
	 
	 SELECT	DECODE(B.DRCR_CLASS,'D',NVL(SUM(A.DR_CASH_AMT),0),NVL(SUM(A.CR_CASH_AMT),0)),
	 			DECODE(B.DRCR_CLASS,'D',NVL(SUM(A.DR_ALT_AMT),0),NVL(SUM(A.CR_ALT_AMT),0)),
				DECODE(B.DRCR_CLASS,'D',NVL(SUM(A.CR_CASH_AMT),0),NVL(SUM(A.DR_CASH_AMT),0)),
				DECODE(B.DRCR_CLASS,'D',NVL(SUM(A.CR_ALT_AMT),0),NVL(SUM(A.DR_ALT_AMT),0))
	 INTO		:LDC_DR_CASH[LI_NUM],
	 			:LDC_DR_ALT[LI_NUM],
				:LDC_CR_CASH[LI_NUM],
				:LDC_CR_ALT[LI_NUM]
	 FROM		FNDB.HFN502H A, ACDB.HAC001M B
	 WHERE	A.ACCT_CLASS = :II_ACCT_CLASS
	 AND		A.BDGT_YEAR  = :is_bdgt_year
	 AND		SUBSTR(A.ACCT_CODE,1,4) BETWEEN :LS_FRCODE[LI_NUM] AND :LS_TOCODE[LI_NUM]
	 AND		SUBSTR(A.ACCT_CODE,1,4)||'00' = B.ACCT_CODE (+)
	 GROUP BY B.DRCR_CLASS ;
NEXT

Ldc_Cr_Cash_Amt = Ldc_Dr_Cash[1] - Ldc_Dr_Cash[2] - Ldc_Dr_Cash[3]
Ldc_Cr_Alt_Amt  = Ldc_Dr_Alt[1] - Ldc_Dr_Alt[2] - Ldc_Dr_Alt[3]
Ldc_Dr_Cash_Amt = Ldc_Cr_Cash[1] - Ldc_Cr_Cash[2] - Ldc_Cr_Cash[3]
Ldc_Dr_Alt_Amt  = Ldc_Cr_Alt[1] - Ldc_Cr_Alt[2] - Ldc_Cr_Alt[3]

// 당기운영차액 삽입
Ll_Row = dw_print.insertrow(0)
dw_print.setitem(ll_row, 'com_acct_code', 	'313301')
dw_print.setitem(ll_row, 'com_acct_name', 	'당기운영차액')
dw_print.setitem(ll_row, 'com_mok_name', 		'당기운영차액')
dw_print.setitem(ll_row, 'com_drcr_class', 	'C')
//dw_print.setitem(ll_row, 'com_acct_date', 	'')
//dw_print.setitem(ll_row, 'com_slip_date', 	'')
//dw_print.setitem(ll_row, 'com_slip_no', 		0)
//dw_print.setitem(ll_row, 'com_slip_seq', 		0)
//dw_print.setitem(ll_row, 'com_gwa', 			'')
//dw_print.setitem(ll_row, 'com_remark', 		'')
//dw_print.setitem(ll_row, 'com_cust_no', 		'')
dw_print.setitem(ll_row, 'com_dr_amt', 		Ldc_Dr_Alt_Amt + Ldc_Dr_Cash_Amt)
dw_print.setitem(ll_row, 'com_cr_amt', 		Ldc_Cr_Alt_Amt + Ldc_Cr_Cash_Amt)
//dw_print.setitem(ll_row, 'com_mana_code1', 	0)
//dw_print.setitem(ll_row, 'com_mana_data1', 	'')
//dw_print.setitem(ll_row, 'com_mana_code2', 	0)
//dw_print.setitem(ll_row, 'com_mana_data2', 	'')
//dw_print.setitem(ll_row, 'com_mana_code3', 	0)
//dw_print.setitem(ll_row, 'com_mana_data3', 	'')
//dw_print.setitem(ll_row, 'com_mana_code4', 	0)
//dw_print.setitem(ll_row, 'com_mana_data4', 	'')

end subroutine

on w_hfn506p.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_hfn506p.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_open;call super::ue_open;//datawindowchild	ldw_child
//string 				ls_sys_date
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ddlb_gubun.selectitem(1)
//ddlb_gubun.triggerevent(selectionchanged!)
//
//ls_sys_date = f_today()
//
//em_fr_date.text = string(ls_sys_date, '@@@@/@@/@@')
//em_to_date.text = string(ls_sys_date, '@@@@/@@/@@')
//
//
end event

event ue_postopen;call super::ue_postopen;datawindowchild	ldw_child

		

dw_con.object.gubun[1] = '1'				
dw_con.getchild('acct_code', ldw_child)
ldw_child.settransobject(sqlca)
ldw_child.reset()
ldw_child.retrieve('1')
ldw_child.insertrow(1)
ldw_child.setitem(1, 'com_code', '')
ldw_child.setitem(1, 'com_name', '계정전체')		
dw_con.setitem(1, 'acct_code', '')



dw_con.object.fr_date[1] = date(string( f_today(), '@@@@/@@/@@'))
dw_con.object.to_date[1]=  date(string( f_today(), '@@@@/@@/@@'))

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

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn506p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn506p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn506p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn506p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn506p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn506p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn506p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn506p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn506p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn506p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn506p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn506p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn506p
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn506p
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn506p
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn506p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn506p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn506p
boolean visible = false
integer x = 2903
integer y = 96
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn506p
boolean visible = false
integer x = 2862
integer y = 620
integer width = 599
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn506p
integer y = 288
integer height = 1980
integer taborder = 50
string dataobject = "d_hfn506p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn506p
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
	dw_con.object.all_printyn[1] = 'Y'
else
	dw_con.object.all_printyn.visible = false
	dw_con.object.all_printyn[1] = 'N'
end if
end event

type cb_1 from uo_imgbtn within w_hfn506p
integer x = 50
integer y = 36
integer taborder = 20
boolean bringtotop = true
string btnname = "excel 파일저장"
end type

event clicked;call super::clicked;string 	ls_docname, ls_named
integer 	li_value

li_value = GetFileSaveName("Select File", ls_docname, ls_named, "XLS", "Excel Files (*.xls), *.xls")

if li_value = 1 then
	dw_print.saveas(ls_docname, Excel!, false)
end if


end event

event constructor;call super::constructor;if gs_DeptCode = '2902' or gs_empcode = 'admin' then
	this.visible = true
else
	this.visible = false
end if

end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

