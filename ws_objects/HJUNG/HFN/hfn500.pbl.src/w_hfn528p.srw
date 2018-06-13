$PBExportHeader$w_hfn528p.srw
$PBExportComments$기본금명세서
forward
global type w_hfn528p from w_hfn_print_form5
end type
type st_3 from statictext within w_hfn528p
end type
type em_bdgt_year from editmask within w_hfn528p
end type
end forward

global type w_hfn528p from w_hfn_print_form5
st_3 st_3
em_bdgt_year em_bdgt_year
end type
global w_hfn528p w_hfn528p

type variables

end variables

forward prototypes
public subroutine wf_insert_data ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_insert_data ();// 당기의 운영차액을 계산하여 삽입한다.
// 당기운영차액 = 수익합계 - 지출합계 - 기본금대체액합계
String  Ls_FrCode[] = {'5000', '4000', '6000'}
String  Ls_ToCode[] = {'5999', '4999', '6199'}
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
	 WHERE	DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
	 AND		A.BDGT_YEAR = SUBSTR(:IS_STR_DATE,1,4)
	 AND		A.ACCT_DATE <= :IS_END_DATE
	 AND		SUBSTR(A.ACCT_CODE,1,4) BETWEEN :LS_FRCODE[LI_NUM] AND :LS_TOCODE[LI_NUM]
	 AND		SUBSTR(A.ACCT_CODE,1,4)||'00' = B.ACCT_CODE (+)
	 GROUP BY B.DRCR_CLASS ;
NEXT

Ldc_Dr_Cash_Amt = Ldc_Dr_Cash[1] - Ldc_Dr_Cash[2] - Ldc_Dr_Cash[3]
Ldc_Dr_Alt_Amt  = Ldc_Dr_Alt[1] - Ldc_Dr_Alt[2] - Ldc_Dr_Alt[3]
Ldc_Cr_Cash_Amt = Ldc_Cr_Cash[1] - Ldc_Cr_Cash[2] - Ldc_Cr_Cash[3]
Ldc_Cr_Alt_Amt  = Ldc_Cr_Alt[1] - Ldc_Cr_Alt[2] - Ldc_Cr_Alt[3]

Ll_Row = Dw_Print.InsertRow(0)

Dw_Print.SetItem(Ll_Row, 'com_gubun', '3')
Dw_Print.SetItem(Ll_Row, 'com_acct_name', '당기운영차액')
Dw_Print.SetItem(Ll_Row, 'com_trans_amt', 0)
Dw_Print.SetItem(Ll_Row, 'com_dr_cash_amt', Ldc_Dr_Cash_Amt)
Dw_Print.SetItem(Ll_Row, 'com_dr_alt_amt', Ldc_Dr_Alt_Amt)
Dw_Print.SetItem(Ll_Row, 'com_cr_cash_amt', Ldc_Cr_Cash_Amt)
Dw_Print.SetItem(Ll_Row, 'com_cr_alt_amt', Ldc_Cr_Alt_Amt)

end subroutine

public subroutine wf_retrieve ();DateTime Ldt_SysDateTime
string	ls_date
date		ld_date

dw_print.Reset()

em_bdgt_year.getdata(ld_date)
ls_date = string(ld_date,'yyyymm') + '01'

// 회계년도에 대한 기간 구하기
is_str_date = ''
is_end_date = mid(ls_date,1,6) + '31'

Select From_Date Into :is_str_date
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
dw_print.retrieve(ii_acct_class, is_str_date, is_end_date)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	// 당기운영차액 계산 후 삽입
	wf_insert_data()
	
	dw_print.bringtotop = true

	dw_print.Object.t_slip_date.Text = mid(is_str_date,1,4) + '년(' + em_bdgt_year.text + ')'
end if

wf_setMsg('')

end subroutine

on w_hfn528p.create
int iCurrent
call super::create
this.st_3=create st_3
this.em_bdgt_year=create em_bdgt_year
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.em_bdgt_year
end on

on w_hfn528p.destroy
call super::destroy
destroy(this.st_3)
destroy(this.em_bdgt_year)
end on

event ue_open;call super::ue_open;string  ls_sys_date

uo_acct_class.dw_commcode.setitem(1, 'code', '1')
ii_acct_class = 1

ls_sys_date = f_today()

em_bdgt_year.text = left(ls_sys_date,4) + '/' + mid(ls_sys_date,5,2)

em_bdgt_year.SetFocus()

end event

type st_2 from w_hfn_print_form5`st_2 within w_hfn528p
integer x = 832
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn528p
boolean visible = false
integer x = 2190
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn528p
integer taborder = 20
string dataobject = "d_hfn528p_1"
end type

type st_3 from statictext within w_hfn528p
integer x = 46
integer y = 100
integer width = 274
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "회계년월"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_bdgt_year from editmask within w_hfn528p
integer x = 325
integer y = 88
integer width = 398
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm"
boolean autoskip = true
boolean spin = true
end type

