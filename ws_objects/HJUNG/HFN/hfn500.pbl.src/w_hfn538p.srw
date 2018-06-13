$PBExportHeader$w_hfn538p.srw
$PBExportComments$결산서 출력(년월,수지)
forward
global type w_hfn538p from w_hfn_print_form1
end type
type st_3 from statictext within w_hfn538p
end type
type em_yearmonth from editmask within w_hfn538p
end type
end forward

global type w_hfn538p from w_hfn_print_form1
string title = "결산서 출력"
st_3 st_3
em_yearmonth em_yearmonth
end type
global w_hfn538p w_hfn538p

type variables
string	is_strdate, is_enddate
end variables

forward prototypes
public subroutine wf_retrieve ()
public function decimal wf_data_proc (string as_bdgt_year, string as_acct_code, string as_type)
public subroutine wf_jagum_proc (string as_gubun, string as_bdgt_year)
end prototypes

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능	:	Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String ls_yearmonth
string ls_bef_bdgt_year
date	 ld_date

em_yearmonth.getdata(ld_date)
ls_yearmonth = string(ld_date, 'yyyymm')

// 회계기간 설정
Select	a.bdgt_year, a.from_date
Into		:is_bdgt_year, :is_strdate
From		acdb.hac003m a
Where		:ls_yearmonth||'01' between a.from_date and a.to_date
And		a.bdgt_class	=	0
And		a.stat_class	=	0 ;

if sqlca.sqlcode <> 0 then
	messagebox('확인', '회계년월의 설정이 올바르지 않습니다.')
	return
end if

Ls_bef_bdgt_year = String(Long(is_bdgt_year) - 1, '0000')

if mid(ls_yearmonth,5,2) = '02' then
	if isdate(left(ls_yearmonth,4) + '/' + right(ls_yearmonth,2) + '/29') then
		is_enddate = ls_yearmonth + '29'
	else
		is_enddate = ls_yearmonth + '28'
	end if
else
	if isdate(left(ls_yearmonth,4) + '/' + right(ls_yearmonth,2) + '/31') then
		is_enddate = ls_yearmonth + '31'
	else
		is_enddate = ls_yearmonth + '30'
	end if
end if

CHOOSE CASE is_slip_class
	CASE '1'			// 수입
		  dw_print.DataObject = 'd_hfn538p_2'
	CASE '2'			// 지출
		  dw_print.DataObject = 'd_hfn538p_3'
	CASE ELSE				// 수입/지출
		  dw_print.DataObject = 'd_hfn538p_1'
END CHOOSE

dw_print.SetTransObject(SQLCA)

dw_print.Modify("DataWindow.Print.Preview='yes'")

dw_print.retrieve(ii_acct_class, is_bdgt_year, is_strdate, is_enddate)

If dw_print.RowCount() > 0 Then
	// 조회된 자료가 있을 경우 전기이월자금과 차기이월자금을 계산하여 삽입한다.
	CHOOSE CASE is_slip_class
		CASE '1'			// 수입
			  wf_jagum_proc('1', Ls_bef_bdgt_year)
		CASE '2'			// 지출
			  wf_jagum_proc('2', is_bdgt_year)
		CASE ELSE		// 수입/지출
			  wf_jagum_proc('1', Ls_bef_bdgt_year)
			  wf_jagum_proc('2', is_bdgt_year)
	END CHOOSE
End If

dw_print.sort()
dw_print.groupcalc()
end subroutine

public function decimal wf_data_proc (string as_bdgt_year, string as_acct_code, string as_type);// ==========================================================================================
// 기    능	:	Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_data_proc()
// 인    수 :	as_bdgt_year(처리년도), as_acct_code(처리계정), as_type(처리구분)
// 되 돌 림 :	Ldc_Return_Amt(계정잔액)
// 주의사항 :
// 수정사항 :
// ==========================================================================================
Dec{0}	Ldc_Return_Amt
// 처리구분(1:예산, 2:잔액)
If as_type = '1' Then
	Select	nvl(sum(a.assn_used_amt),0)
	Into		:Ldc_Return_Amt
	From		acdb.hac012m a
	Where		a.bdgt_year					=	:as_bdgt_year
	And		substr(a.acct_code,1,3)	=	substr(:as_acct_code,1,3)
	And		decode(:ii_acct_class,0,0,a.acct_class) = :ii_acct_class	;
Else
	Select	Case	When	b.drcr_class = 'D'
				Then	(nvl(sum(a.dr_alt_amt),0) + nvl(sum(a.dr_cash_amt),0)) -
						(nvl(sum(a.cr_alt_amt),0) + nvl(sum(a.cr_cash_amt),0))
				Else	(nvl(sum(a.cr_alt_amt),0) + nvl(sum(a.cr_cash_amt),0)) -
						(nvl(sum(a.dr_alt_amt),0) + nvl(sum(a.dr_cash_amt),0))
				End	amt
	Into		:Ldc_Return_Amt
	From		fndb.hfn502h a, acdb.hac006m b
	Where		decode(:ii_acct_class,0,0,a.acct_class) = :ii_acct_class
	And		a.bdgt_year					=	:as_bdgt_year
	And		a.acct_date					<=	:is_enddate
	And		substr(a.acct_code,1,3)	=	substr(:as_acct_code,1,3)
	And		:as_acct_code				=	b.form_code
	Group By	b.drcr_class ;
End If

Return Ldc_Return_Amt
end function

public subroutine wf_jagum_proc (string as_gubun, string as_bdgt_year);// ==========================================================================================
// 기    능	:	Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_jagum_proc()
// 인    수 :	as_gubun(처리구분-1:전기,2:당기), as_bdgt_year(처리년도)
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================


// 미사용전기이월자금 계산	=	전기기초유동자산[유동자금(1110) + 기타유동자산(1120)] -
// 									전기기초유동부채[예수금(2120) + 선수금(2130) + 기타유동부채(2140)]
// 미사용차기이월자금 계산	=	당기기초유동자산[유동자금(1110) + 기타유동자산(1120)] -
// 									당기기초유동부채[예수금(2120) + 선수금(2130) + 기타유동부채(2140)]
Dec{0}	Ldc_1110_amt, Ldc_1120_amt, Ldc_2120_amt, Ldc_2130_amt, Ldc_2140_amt
Dec{0}	Ldc_bdgt_1110_amt, Ldc_bdgt_1120_amt, Ldc_bdgt_2120_amt, Ldc_bdgt_2130_amt, Ldc_bdgt_2140_amt
Dec{0}	Ldc_Acct_Amt, Ldc_bdgt_Acct_Amt

// 유동자금
Ldc_bdgt_1110_Amt = wf_data_proc(as_bdgt_year, '111000', '1')
Ldc_1110_Amt      = wf_data_proc(as_bdgt_year, '111000', '2')
// 기타유동자산
Ldc_bdgt_1120_Amt = wf_data_proc(as_bdgt_year, '112000', '1')
Ldc_1120_Amt      = wf_data_proc(as_bdgt_year, '112000', '2')
// 예수금
Ldc_bdgt_2120_Amt = wf_data_proc(as_bdgt_year, '212000', '1')
Ldc_2120_Amt      = wf_data_proc(as_bdgt_year, '212000', '2')
// 선수금
Ldc_bdgt_2130_Amt = wf_data_proc(as_bdgt_year, '213000', '1')
Ldc_2130_Amt      = wf_data_proc(as_bdgt_year, '213000', '2')
// 기타유동부채
Ldc_bdgt_2140_Amt = wf_data_proc(as_bdgt_year, '214000', '1')
Ldc_2140_Amt      = wf_data_proc(as_bdgt_year, '214000', '2')

Ldc_bdgt_Acct_Amt = Ldc_bdgt_1110_amt + Ldc_bdgt_1120_amt - Ldc_bdgt_2120_amt - Ldc_bdgt_2130_amt - Ldc_bdgt_2140_amt
Ldc_Acct_Amt      = Ldc_1110_amt + Ldc_1120_amt - Ldc_2120_amt - Ldc_2130_amt - Ldc_2140_amt

// 삽입
Long	Ll_row
Ll_row = dw_print.InsertRow(0)

If as_gubun = '1' Then
	dw_print.setitem(Ll_row, 'slip_class', '1')
	dw_print.setitem(Ll_row, 'sort', 		'4')
	dw_print.setitem(Ll_row, 'large_code',	'19900')
	dw_print.setitem(Ll_row, 'large_name',  '미사용전기이월자금')
	dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
	dw_print.setitem(Ll_row, 'acct_amt',	Ldc_acct_amt)
	dw_print.setitem(Ll_row, 'gubun',		'1')
Else
	dw_print.setitem(Ll_row, 'slip_class', '2')
	dw_print.setitem(Ll_row, 'sort', 		'4')
	dw_print.setitem(Ll_row, 'large_code',	'29900')
	dw_print.setitem(Ll_row, 'large_name',  '미사용차기이월자금')
	dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
	dw_print.setitem(Ll_row, 'acct_amt',	Ldc_acct_amt)
	dw_print.setitem(Ll_row, 'gubun',		'1')
End If

Ll_row = dw_print.InsertRow(0)

If as_gubun = '1' Then
	dw_print.setitem(Ll_row, 'slip_class', 	'1')
	dw_print.setitem(Ll_row, 'sort', 			'4')
	dw_print.setitem(Ll_row, 'large_code',		'19900')
	dw_print.setitem(Ll_row, 'middle_code',	'19990')
	dw_print.setitem(Ll_row, 'middle_name',  	'전기이월자금')
	dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
	dw_print.setitem(Ll_row, 'acct_amt',		Ldc_acct_amt)
	dw_print.setitem(Ll_row, 'gubun',			'2')
Else
	dw_print.setitem(Ll_row, 'slip_class', 	'2')
	dw_print.setitem(Ll_row, 'sort', 			'4')
	dw_print.setitem(Ll_row, 'large_code',		'29900')
	dw_print.setitem(Ll_row, 'middle_code',	'29999')
	dw_print.setitem(Ll_row, 'middle_name', 	'차기이월자금')
	dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
	dw_print.setitem(Ll_row, 'acct_amt',		Ldc_acct_amt)
	dw_print.setitem(Ll_row, 'gubun',			'2')
End If

Ll_row = dw_print.InsertRow(0)

If as_gubun = '1' Then
	dw_print.setitem(Ll_row, 'slip_class',		'1')
	dw_print.setitem(Ll_row, 'sort', 			'4')
	dw_print.setitem(Ll_row, 'large_code',		'19900')
	dw_print.setitem(Ll_row, 'middle_code',	'19990')
	dw_print.setitem(Ll_row, 'acct_code',		'19999')
	dw_print.setitem(Ll_row, 'acct_name', 		'전기이월자금')
	dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
	dw_print.setitem(Ll_row, 'acct_amt',		Ldc_acct_amt)
	dw_print.setitem(Ll_row, 'gubun',			'3')
Else
	dw_print.setitem(Ll_row, 'slip_class',		'2')
	dw_print.setitem(Ll_row, 'sort', 			'4')
	dw_print.setitem(Ll_row, 'large_code',		'29900')
	dw_print.setitem(Ll_row, 'middle_code',	'29999')
	dw_print.setitem(Ll_row, 'acct_code',		'29999')
	dw_print.setitem(Ll_row, 'acct_name', 		'차기이월자금')
	dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
	dw_print.setitem(Ll_row, 'acct_amt',		Ldc_acct_amt)
	dw_print.setitem(Ll_row, 'gubun',			'3')
End If

end subroutine

event open;call super::open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
string	ls_sysdate

ls_sysdate = f_today()

uo_acct_class.dw_commcode.setitem(1, 'code', '1')
ii_acct_class = 1
uo_acct_class.uf_enabled(false)

em_yearmonth.text = string(ls_sysdate, '@@@@/@@')

end event

on w_hfn538p.create
int iCurrent
call super::create
this.st_3=create st_3
this.em_yearmonth=create em_yearmonth
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.em_yearmonth
end on

on w_hfn538p.destroy
call super::destroy
destroy(this.st_3)
destroy(this.em_yearmonth)
end on

type st_1 from w_hfn_print_form1`st_1 within w_hfn538p
integer x = 2331
integer y = 100
end type

type uo_slip_class from w_hfn_print_form1`uo_slip_class within w_hfn538p
integer x = 873
integer y = 72
end type

type uo_acct_class from w_hfn_print_form1`uo_acct_class within w_hfn538p
boolean visible = false
integer x = 992
integer y = 820
integer taborder = 50
end type

type uo_year from w_hfn_print_form1`uo_year within w_hfn538p
boolean visible = false
integer x = 2926
integer taborder = 60
end type

type dw_print from w_hfn_print_form1`dw_print within w_hfn538p
integer height = 2268
string dataobject = "d_hfn931p_1"
end type

type st_2 from w_hfn_print_form1`st_2 within w_hfn538p
integer x = 1938
integer y = 100
integer width = 443
end type

type st_3 from statictext within w_hfn538p
integer x = 50
integer y = 96
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "회계년월"
boolean focusrectangle = false
end type

type em_yearmonth from editmask within w_hfn538p
integer x = 315
integer y = 80
integer width = 361
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm"
boolean spin = true
end type

