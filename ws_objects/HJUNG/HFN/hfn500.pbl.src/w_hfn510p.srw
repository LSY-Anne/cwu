$PBExportHeader$w_hfn510p.srw
$PBExportComments$자금계산서 출력(월결산용)
forward
global type w_hfn510p from w_hfn_print_form1
end type
end forward

global type w_hfn510p from w_hfn_print_form1
string title = "결산서 출력"
end type
global w_hfn510p w_hfn510p

type variables
string	is_strdate, is_enddate
end variables

forward prototypes
public subroutine wf_jagum_proc (string as_gubun, string as_bdgt_year)
public function decimal wf_data_proc (string as_bdgt_year, string as_acct_code, string as_type)
public subroutine wf_retrieve ()
public subroutine wf_transfer_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_slip_class)
public subroutine wf_jasan_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_slip_class)
public subroutine wf_foreign_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_slip_class)
public subroutine wf_reset_amt (string as_acct_code, string as_slip_class, decimal adc_acct_month_amt, decimal adc_acct_amt, string as_oper_gbn)
end prototypes

public subroutine wf_jagum_proc (string as_gubun, string as_bdgt_year);// ==========================================================================================
// 기    능	:	Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.07
// 함수원형 : 	wf_jagum_proc()
// 인    수 :	as_gubun(처리구분-1:전기,2:당기), as_bdgt_year(처리년도)
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
datawindowchild	ldw_child
Long					Ll_row
Dec{0}	Ldc_1110_amt, Ldc_1120_amt, Ldc_2120_amt, Ldc_2130_amt, Ldc_2140_amt
Dec{0}	Ldc_bdgt_1110_amt, Ldc_bdgt_1120_amt, Ldc_bdgt_2120_amt, Ldc_bdgt_2130_amt, Ldc_bdgt_2140_amt
Dec{0}	Ldc_Acct_Amt, Ldc_bdgt_Acct_Amt

// 미사용전기이월자금 계산	=	전기기초유동자산[유동자금(1110) + 기타유동자산(1120)] -
// 									전기기초유동부채[예수금(2120) + 선수금(2130) + 기타유동부채(2140)]
// 미사용차기이월자금 계산	=	당기기초유동자산[유동자금(1110) + 기타유동자산(1120)] -
// 									당기기초유동부채[예수금(2120) + 선수금(2130) + 기타유동부채(2140)]

// 유동자금
Ldc_bdgt_1110_Amt = wf_data_proc(as_bdgt_year, '911100', '1')
Ldc_1110_Amt      = wf_data_proc(as_bdgt_year, '111000', '2')
// 기타유동자산
Ldc_bdgt_1120_Amt = wf_data_proc(as_bdgt_year, '911200', '1')
Ldc_1120_Amt      = wf_data_proc(as_bdgt_year, '112000', '2')
// 예수금
Ldc_bdgt_2120_Amt = wf_data_proc(as_bdgt_year, '912100', '1')
Ldc_2120_Amt      = wf_data_proc(as_bdgt_year, '212000', '2')
// 선수금
Ldc_bdgt_2130_Amt = wf_data_proc(as_bdgt_year, '912200', '1')
Ldc_2130_Amt      = wf_data_proc(as_bdgt_year, '213000', '2')
// 기타유동부채
Ldc_bdgt_2140_Amt = wf_data_proc(as_bdgt_year, '912300', '1')
Ldc_2140_Amt      = wf_data_proc(as_bdgt_year, '214000', '2')

Ldc_bdgt_Acct_Amt = Ldc_bdgt_1110_amt + Ldc_bdgt_1120_amt - Ldc_bdgt_2120_amt - Ldc_bdgt_2130_amt - Ldc_bdgt_2140_amt
Ldc_Acct_Amt      = Ldc_1110_amt + Ldc_1120_amt - Ldc_2120_amt - Ldc_2130_amt - Ldc_2140_amt

// 삽입

// 이월자금
If as_gubun = '1' Then
	if is_slip_class = '' then
		dw_print.getchild('dw_1', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'1')
		ldw_child.setitem(Ll_row, 'sort',				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'10000')
		ldw_child.setitem(Ll_row, 'large_name',		'미사용전기이월자금')
		ldw_child.setitem(Ll_row, 'middle_name',		'')
		ldw_child.setitem(Ll_row, 'acct_name',			'')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_acct_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'1')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'1')
		dw_print.setitem(Ll_row, 'sort',				'4')
		dw_print.setitem(Ll_row, 'large_code',		'10000')
		dw_print.setitem(Ll_row, 'large_name',		'미사용전기이월자금')
		dw_print.setitem(Ll_row, 'middle_name',	'')
		dw_print.setitem(Ll_row, 'acct_name',		'')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_acct_amt)
		dw_print.setitem(Ll_row, 'gubun',			'1')
	end if
Else
	if is_slip_class = '' then
		dw_print.getchild('dw_2', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'2')
		ldw_child.setitem(Ll_row, 'sort',				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'20000')
		ldw_child.setitem(Ll_row, 'large_name',		'미사용차기이월자금')
		ldw_child.setitem(Ll_row, 'middle_name',		'')
		ldw_child.setitem(Ll_row, 'acct_name',			'')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_acct_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'1')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'2')
		dw_print.setitem(Ll_row, 'sort',				'4')
		dw_print.setitem(Ll_row, 'large_code',		'20000')
		dw_print.setitem(Ll_row, 'large_name',		'미사용차기이월자금')
		dw_print.setitem(Ll_row, 'middle_name',	'')
		dw_print.setitem(Ll_row, 'acct_name',		'')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_acct_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_acct_amt)
		dw_print.setitem(Ll_row, 'gubun',			'1')
	end if
End If

// 유동자산
If as_gubun = '1' Then
	if is_slip_class = '' then
		dw_print.getchild('dw_1', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'1')
		ldw_child.setitem(Ll_row, 'sort',				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'10000')
		ldw_child.setitem(Ll_row, 'middle_code',		'11100')
		ldw_child.setitem(Ll_row, 'middle_name',		'기초유동자산')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1110_amt + Ldc_bdgt_1120_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_1110_amt + Ldc_1120_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'2')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'1')
		dw_print.setitem(Ll_row, 'sort',				'4')
		dw_print.setitem(Ll_row, 'large_code',		'10000')
		dw_print.setitem(Ll_row, 'middle_code',	'11100')
		dw_print.setitem(Ll_row, 'middle_name',	'기초유동자산')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1110_amt + Ldc_bdgt_1120_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_1110_amt + Ldc_1120_amt)
		dw_print.setitem(Ll_row, 'gubun',			'2')
	end if
Else
	if is_slip_class = '' then
		dw_print.getchild('dw_2', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'2')
		ldw_child.setitem(Ll_row, 'sort',				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'20000')
		ldw_child.setitem(Ll_row, 'middle_code',		'21100')
		ldw_child.setitem(Ll_row, 'middle_name',		'기말유동자산')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1110_amt + Ldc_bdgt_1120_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_1110_amt + Ldc_1120_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'2')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'2')
		dw_print.setitem(Ll_row, 'sort',				'4')
		dw_print.setitem(Ll_row, 'large_code',		'20000')
		dw_print.setitem(Ll_row, 'middle_code',	'21100')
		dw_print.setitem(Ll_row, 'middle_name',	'기말유동자산')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1110_amt + Ldc_bdgt_1120_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_1110_amt + Ldc_1120_amt)
		dw_print.setitem(Ll_row, 'gubun',			'2')
	end if
End If

// 유동자금
If as_gubun = '1' Then
	if is_slip_class = '' then
		dw_print.getchild('dw_1', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'1')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'10000')
		ldw_child.setitem(Ll_row, 'middle_code',		'11100')
		ldw_child.setitem(Ll_row, 'acct_code',			'11110')
		ldw_child.setitem(Ll_row, 'acct_name', 		'유동자금')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1110_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_1110_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'1')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'10000')
		dw_print.setitem(Ll_row, 'middle_code',	'11100')
		dw_print.setitem(Ll_row, 'acct_code',		'11110')
		dw_print.setitem(Ll_row, 'acct_name', 		'유동자금')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1110_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_1110_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
Else
	if is_slip_class = '' then
		dw_print.getchild('dw_2', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'2')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'20000')
		ldw_child.setitem(Ll_row, 'middle_code',		'21100')
		ldw_child.setitem(Ll_row, 'acct_code',			'21110')
		ldw_child.setitem(Ll_row, 'acct_name', 		'유동자금')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1110_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_1110_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'2')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'20000')
		dw_print.setitem(Ll_row, 'middle_code',	'21100')
		dw_print.setitem(Ll_row, 'acct_code',		'21110')
		dw_print.setitem(Ll_row, 'acct_name', 		'유동자금')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1110_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_1110_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
End If

// 기타유동자산
If as_gubun = '1' Then
	if is_slip_class = '' then
		dw_print.getchild('dw_1', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'1')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'10000')
		ldw_child.setitem(Ll_row, 'middle_code',		'11100')
		ldw_child.setitem(Ll_row, 'acct_code',			'11120')
		ldw_child.setitem(Ll_row, 'acct_name', 		'기타유동자산')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1120_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_1120_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'1')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'10000')
		dw_print.setitem(Ll_row, 'middle_code',	'11100')
		dw_print.setitem(Ll_row, 'acct_code',		'11120')
		dw_print.setitem(Ll_row, 'acct_name', 		'기타유동자산')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1120_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_1120_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
Else
	if is_slip_class = '' then
		dw_print.getchild('dw_2', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'2')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'20000')
		ldw_child.setitem(Ll_row, 'middle_code',		'21100')
		ldw_child.setitem(Ll_row, 'acct_code',			'21120')
		ldw_child.setitem(Ll_row, 'acct_name', 		'기타유동자산')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1120_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_1120_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'2')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'20000')
		dw_print.setitem(Ll_row, 'middle_code',	'21100')
		dw_print.setitem(Ll_row, 'acct_code',		'21120')
		dw_print.setitem(Ll_row, 'acct_name', 		'기타유동자산')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_1120_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_1120_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
End If

// 유동부채
If as_gubun = '1' Then
	if is_slip_class = '' then
		dw_print.getchild('dw_1', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class', 		'1')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'10000')
		ldw_child.setitem(Ll_row, 'middle_code',		'12100')
		ldw_child.setitem(Ll_row, 'middle_name',  	'기초유동부채')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2120_amt + Ldc_bdgt_2130_amt + Ldc_bdgt_2140_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_2120_amt + Ldc_2130_amt + Ldc_2140_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'2')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class', 	'1')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'10000')
		dw_print.setitem(Ll_row, 'middle_code',	'12100')
		dw_print.setitem(Ll_row, 'middle_name',  	'기초유동부채')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2120_amt + Ldc_bdgt_2130_amt + Ldc_bdgt_2140_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_2120_amt + Ldc_2130_amt + Ldc_2140_amt)
		dw_print.setitem(Ll_row, 'gubun',			'2')
	end if
Else
	if is_slip_class = '' then
		dw_print.getchild('dw_2', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class', 		'2')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'20000')
		ldw_child.setitem(Ll_row, 'middle_code',		'22100')
		ldw_child.setitem(Ll_row, 'middle_name', 		'기말유동부채')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2120_amt + Ldc_bdgt_2130_amt + Ldc_bdgt_2140_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_2120_amt + Ldc_2130_amt + Ldc_2140_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'2')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class', 	'2')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'20000')
		dw_print.setitem(Ll_row, 'middle_code',	'22100')
		dw_print.setitem(Ll_row, 'middle_name', 	'기말유동부채')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2120_amt + Ldc_bdgt_2130_amt + Ldc_bdgt_2140_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_2120_amt + Ldc_2130_amt + Ldc_2140_amt)
		dw_print.setitem(Ll_row, 'gubun',			'2')
	end if
End If

// 예수금
If as_gubun = '1' Then
	if is_slip_class = '' then
		dw_print.getchild('dw_1', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'1')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'10000')
		ldw_child.setitem(Ll_row, 'middle_code',		'12100')
		ldw_child.setitem(Ll_row, 'acct_code',			'12120')
		ldw_child.setitem(Ll_row, 'acct_name', 		'예수금')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2120_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_2120_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'1')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'10000')
		dw_print.setitem(Ll_row, 'middle_code',	'12100')
		dw_print.setitem(Ll_row, 'acct_code',		'12120')
		dw_print.setitem(Ll_row, 'acct_name', 		'예수금')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2120_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_2120_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
Else
	if is_slip_class = '' then
		dw_print.getchild('dw_2', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'2')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'20000')
		ldw_child.setitem(Ll_row, 'middle_code',		'22100')
		ldw_child.setitem(Ll_row, 'acct_code',			'22120')
		ldw_child.setitem(Ll_row, 'acct_name', 		'예수금')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2120_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_2120_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'2')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'20000')
		dw_print.setitem(Ll_row, 'middle_code',	'22100')
		dw_print.setitem(Ll_row, 'acct_code',		'22120')
		dw_print.setitem(Ll_row, 'acct_name', 		'예수금')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2120_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_2120_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
End If

// 선수금
If as_gubun = '1' Then
	if is_slip_class = '' then
		dw_print.getchild('dw_1', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'1')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'10000')
		ldw_child.setitem(Ll_row, 'middle_code',		'12100')
		ldw_child.setitem(Ll_row, 'acct_code',			'12130')
		ldw_child.setitem(Ll_row, 'acct_name', 		'선수금')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2130_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_2130_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'1')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'10000')
		dw_print.setitem(Ll_row, 'middle_code',	'12100')
		dw_print.setitem(Ll_row, 'acct_code',		'12130')
		dw_print.setitem(Ll_row, 'acct_name', 		'선수금')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2130_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_2130_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
Else
	if is_slip_class = '' then
		dw_print.getchild('dw_2', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'2')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'20000')
		ldw_child.setitem(Ll_row, 'middle_code',		'22100')
		ldw_child.setitem(Ll_row, 'acct_code',			'22130')
		ldw_child.setitem(Ll_row, 'acct_name', 		'선수금')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2130_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_2130_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'2')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'20000')
		dw_print.setitem(Ll_row, 'middle_code',	'22100')
		dw_print.setitem(Ll_row, 'acct_code',		'22130')
		dw_print.setitem(Ll_row, 'acct_name', 		'선수금')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2130_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_2130_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
End If

// 기타유동부채
If as_gubun = '1' Then
	if is_slip_class = '' then
		dw_print.getchild('dw_1', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'1')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'10000')
		ldw_child.setitem(Ll_row, 'middle_code',		'12100')
		ldw_child.setitem(Ll_row, 'acct_code',			'12140')
		ldw_child.setitem(Ll_row, 'acct_name', 		'기타유동부채')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2140_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_2140_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'1')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'10000')
		dw_print.setitem(Ll_row, 'middle_code',	'12100')
		dw_print.setitem(Ll_row, 'acct_code',		'12140')
		dw_print.setitem(Ll_row, 'acct_name', 		'기타유동부채')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2140_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_2140_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
Else
	if is_slip_class = '' then
		dw_print.getchild('dw_2', ldw_child)
		ll_row = ldw_child.insertrow(0)
		ldw_child.setitem(Ll_row, 'slip_class',		'2')
		ldw_child.setitem(Ll_row, 'sort', 				'4')
		ldw_child.setitem(Ll_row, 'large_code',		'20000')
		ldw_child.setitem(Ll_row, 'middle_code',		'22100')
		ldw_child.setitem(Ll_row, 'acct_code',			'22140')
		ldw_child.setitem(Ll_row, 'acct_name', 		'기타유동부채')
		ldw_child.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2140_amt)
		ldw_child.setitem(Ll_row, 'acct_amt',			Ldc_2140_amt)
		ldw_child.setitem(Ll_row, 'gubun',				'3')
	else
		ll_row = dw_print.insertrow(0)
		dw_print.setitem(Ll_row, 'slip_class',		'2')
		dw_print.setitem(Ll_row, 'sort', 			'4')
		dw_print.setitem(Ll_row, 'large_code',		'20000')
		dw_print.setitem(Ll_row, 'middle_code',	'22100')
		dw_print.setitem(Ll_row, 'acct_code',		'22140')
		dw_print.setitem(Ll_row, 'acct_name', 		'기타유동부채')
		dw_print.setitem(Ll_row, 'bdgt_acct_amt',	Ldc_bdgt_2140_amt)
		dw_print.setitem(Ll_row, 'acct_amt',		Ldc_2140_amt)
		dw_print.setitem(Ll_row, 'gubun',			'3')
	end if
End If

end subroutine

public function decimal wf_data_proc (string as_bdgt_year, string as_acct_code, string as_type);// ==========================================================================================
// 기    능	:	Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.07
// 함수원형 : 	wf_data_proc()
// 인    수 :	as_bdgt_year(처리년도), as_acct_code(처리계정), as_type(처리구분)
// 되 돌 림 :	Ldc_Return_Amt(계정잔액)
// 주의사항 :
// 수정사항 :
// ==========================================================================================
Dec{0}	Ldc_Return_Amt
// 처리구분(1:예산, 2:잔액)
If as_type = '1' Then
	if as_bdgt_year = is_bdgt_year then
		Select	nvl(sum(a.assn_used_amt),0)
		Into		:Ldc_Return_Amt
		From		acdb.hac012m a
		Where		a.bdgt_year					=	:is_bdgt_year
		And		substr(a.acct_code,1,4)	=	substr(:as_acct_code,1,4)
		And		decode(:ii_acct_class,0,0,a.acct_class) = :ii_acct_class
		And		io_gubun = '2'	;
	else
		Select	nvl(sum(a.assn_used_amt),0)
		Into		:Ldc_Return_Amt
		From		acdb.hac012m a
		Where		a.bdgt_year					=	:is_bdgt_year
		And		substr(a.acct_code,1,4)	=	substr(:as_acct_code,1,4)
		And		decode(:ii_acct_class,0,0,a.acct_class) = :ii_acct_class
		And		io_gubun = '1'	;
	end if
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

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능	:	Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
datawindowchild	ldw_child
String				ls_yearmonth
string				ls_bef_bdgt_year
date					ld_date
String ls_all_printyn

dw_con.accepttext()

ls_yearmonth = string(dw_con.object.yearmonth[1], 'yyyymm')
ls_all_printyn = dw_con.object.all_printyn[1]

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

ls_bef_bdgt_year = string(integer(is_bdgt_year) - 1)

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


if ls_all_printyn = 'Y' then		//연속용지
	CHOOSE CASE is_slip_class
		CASE '1'			// 수입
			  dw_print.DataObject = 'd_hfn510p_2_1'
		CASE '2'			// 지출
			  dw_print.DataObject = 'd_hfn510p_3_1'
		CASE ELSE		// 수입/지출
			  dw_print.DataObject = 'd_hfn510p_1_1'
	END CHOOSE
else
	CHOOSE CASE is_slip_class
		CASE '1'			// 수입
			  dw_print.DataObject = 'd_hfn510p_2'
		CASE '2'			// 지출
			  dw_print.DataObject = 'd_hfn510p_3'
		CASE ELSE		// 수입/지출
			  dw_print.DataObject = 'd_hfn510p_1'
	END CHOOSE
end if


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

// 고정자산 매각수입에 대한 금액 보정
// 고정자산 매각수입 = 고정자산매각수입 - 고정자산처분손실
if is_slip_class = '' or is_slip_class = '1' then 
	wf_jasan_proc(is_bdgt_year, '1311', '4426', '1')
	wf_jasan_proc(is_bdgt_year, '1312', '4426', '1')
	wf_jasan_proc(is_bdgt_year, '1313', '4426', '1')
	wf_jasan_proc(is_bdgt_year, '1314', '4426', '1')
	wf_jasan_proc(is_bdgt_year, '1315', '4426', '1')
	wf_jasan_proc(is_bdgt_year, '1316', '4426', '1')
	wf_jasan_proc(is_bdgt_year, '1317', '4426', '1')
	wf_jasan_proc(is_bdgt_year, '1318', '4426', '1')
	wf_jasan_proc(is_bdgt_year, '1319', '4426', '1')
	wf_jasan_proc(is_bdgt_year, '1321', '4426', '1')
end if

//지출출력시 건물매입비에서 건설가계정 금액 감산...
//지출출력시 차량운반구에서 건설가계정 금액 감산...(2005.07.12)
if is_slip_class = '' or is_slip_class = '2' then 
	wf_transfer_proc(is_bdgt_year, '1312', '1319', '2')	//건물매입비
	wf_transfer_proc(is_bdgt_year, '1316', '1319', '2')	//차량운반구
end if

//기계기구,집기비품 계정을 건물로 대체한 전표가 있음. (물품관리전환 건물대체)(2005.07.12)
if is_slip_class = '1' or is_slip_class = '2' then 	//수입 또는 지출 조회
	wf_transfer_proc(is_bdgt_year, '1312', '1314', is_slip_class)	//기계기구
	wf_transfer_proc(is_bdgt_year, '1312', '1315', is_slip_class)	//집기비품
else																	//전체 조회
	wf_transfer_proc(is_bdgt_year, '1312', '1314', '1')	//기계기구
	wf_transfer_proc(is_bdgt_year, '1312', '1315', '1')	//집기비품
	wf_transfer_proc(is_bdgt_year, '1312', '1314', '2')	//기계기구
	wf_transfer_proc(is_bdgt_year, '1312', '1315', '2')	//집기비품
end if


/*	
	2007.10.18 집기비품 기증건(전표번호:2007/09/21-3)으로 삭제...
	2008.05.01 기증계정과목은 처리안하고 그 이외의 계정과목은 처리해야함.
*/
//연구기자재 취득자산 대체전표(현물기부금 기자재(5224-02)) (2007.03.20)
//지출출력시 기계기구(1314),집기비품(1315)에서 현물기부금 대체금액 감산...
if is_slip_class = '' or is_slip_class = '2' then 
	wf_jasan_proc(is_bdgt_year, '5224', '1311', '2')
	wf_jasan_proc(is_bdgt_year, '5224', '1312', '2')
	wf_jasan_proc(is_bdgt_year, '5224', '1313', '2')
	wf_jasan_proc(is_bdgt_year, '5224', '1314', '2')
	wf_jasan_proc(is_bdgt_year, '5224', '1315', '2')
	wf_jasan_proc(is_bdgt_year, '5224', '1316', '2')
	wf_jasan_proc(is_bdgt_year, '5224', '1317', '2')
end if


/* 2008.04.02 : 외화환산이익(손실) 대체전표의 경우 -> 잡수입(이익) 계정에서 금액 보정 */
if is_slip_class = '1' then
	wf_foreign_proc(is_bdgt_year, '5421', '5422', '1')	//외화환산이익
elseif is_slip_class = '2' then
	wf_foreign_proc(is_bdgt_year, '4422', '4421', '2')	//외화환산손실
else
	wf_foreign_proc(is_bdgt_year, '5421', '5422', '1')	//외화환산이익
	wf_foreign_proc(is_bdgt_year, '4422', '4421', '2')	//외화환산손실
end if	
/* ********************************* */

////////////////////////////////////////////////////////////////

if is_slip_class = '' then
	dw_print.getchild('dw_1', ldw_child)
	ldw_child.sort()
	ldw_child.groupcalc()
	
	dw_print.getchild('dw_2', ldw_child)
	ldw_child.modify("title.visible = 0")
	ldw_child.modify("com_dang_gigan.visible = 0")
//	ldw_child.setfilter("isnull(acct_code) or acct_code <> '24426'")
//	ldw_child.filter()
	ldw_child.sort()
	ldw_child.groupcalc()
else
//	if is_slip_class = '2' then
//		dw_print.setfilter("isnull(acct_code) or acct_code <> '24426'")
//		dw_print.filter()
//	end if
	dw_print.sort()
	dw_print.groupcalc()
end if

end subroutine

public subroutine wf_transfer_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_slip_class);/*
	대체전표 처리 : 2005.07.12
	대체전표에 대한 자금계산서 계정별 처리

	1. 
		건설가계정 계정 관련...
		건물 건축 완료후 본계정 대체 시...
		자금계산서 지출 중 건물매입비 금액에서 건설가계정 금액을 차감하여 계산...
	2.
		기계기구, 집기비품 매각대 계정 추가 작업...(2005.07.12)
			ㄱ.기계기구,집기비품 계정을 건물로 대체한 전표가 있음. (물품관리전환 건물대체)
			ㄴ.수입일 경우 : 기계기구,집기비품 - 건물 대체금액.
			ㄷ.지출일 경우 : 건물매입비 - 기계기구,집기비품 대체금액 계산함.
	3.
		차량운반구 계정 관련...(2005.07.12)
		차량 제작 완료후 본계정 대체 시...
		자금계산서 지출 중 차량운반구 금액에서 건설가계정 금액을 차감하여 계산...
*/

datawindowchild	ldw_child
dec{0}				ldc_acct_amt, ldc_acct_month_amt
long					ll_row
string 				ls_acct_code_tmp

//월계 계산...
SELECT	SUM(A.SLIP_AMT)
INTO		:ldc_acct_month_amt
FROM		FNDB.HFN202M A, (
			SELECT	DISTINCT B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				between SUBSTR(:IS_ENDDATE,1,6)||'01' and :IS_ENDDATE
			AND		C.STEP_OPT 					= 	5
			AND		C.SLIP_CLASS				=  3							//대체...
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'D' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'C' ;

//if isnull(ldc_acct_month_amt) or ldc_acct_month_amt = 0 then return
if isnull(ldc_acct_month_amt) then ldc_acct_month_amt = 0

//누계 계산...
SELECT	SUM(A.SLIP_AMT)
INTO		:LDC_ACCT_AMT
FROM		FNDB.HFN202M A, (
			SELECT	DISTINCT B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				<= :IS_ENDDATE
			AND		C.STEP_OPT 					= 	5
			AND		C.SLIP_CLASS				=  3							//대체...
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'D' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'C' ;

//if isnull(ldc_acct_amt) or ldc_acct_amt = 0 then return
if isnull(ldc_acct_amt) then ldc_acct_amt = 0


//수입출력할 경우 계정을 서로 바꿔야 함.
if as_slip_class = '1' then
	ls_acct_code_tmp 	= as_acct_code2
	as_acct_code2 		= as_acct_code1
	as_acct_code1 		= ls_acct_code_tmp
end if


//금액 리셋...
wf_reset_amt(as_acct_code1, as_slip_class, ldc_acct_month_amt, ldc_acct_amt, '-')


end subroutine

public subroutine wf_jasan_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_slip_class);datawindowchild	ldw_child
dec{0}				ldc_acct_amt, ldc_acct_month_amt, ldc_amt
long					ll_row
string				ls_acct_code_tmp, ls_acct_code


ldc_acct_month_amt = 0

//월계 계산...
DECLARE	month_cur CURSOR FOR
SELECT	SUM(A.SLIP_AMT),	A.ACCT_CODE
FROM		FNDB.HFN202M A, (
			SELECT	B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				between SUBSTR(:IS_ENDDATE,1,6)||'01' and :IS_ENDDATE
			AND		C.STEP_OPT 					= 	5
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'C' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'D' 
GROUP BY A.ACCT_CODE;
OPEN	month_cur;
DO WHILE TRUE
	FETCH NEXT month_cur INTO	:ldc_amt, :ls_acct_code	;
	if sqlca.sqlcode <> 0 then exit
	
	//if isnull(ldc_amt) or ldc_amt = 0 then return
	if isnull(ldc_amt) then ldc_amt = 0
	
	//현물기부금, 기증 계정과목인 경우 처리 안함...
	if as_acct_code1 = '5224' and &
		(ls_acct_code = '131102' or ls_acct_code = '131202' or ls_acct_code = '131305' or ls_acct_code = '131407' or &
		 ls_acct_code = '131507' or ls_acct_code = '131603' or ls_acct_code = '131705') then
		ldc_amt = 0
	end if
	
	ldc_acct_month_amt += ldc_amt
LOOP
CLOSE	month_cur;


ldc_acct_amt = 0

//누계 계산...
DECLARE	year_cur CURSOR FOR
SELECT	SUM(A.SLIP_AMT),	A.ACCT_CODE
FROM		FNDB.HFN202M A, (
			SELECT	B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				<= :IS_ENDDATE
			AND		C.STEP_OPT 					= 	5
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'C' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'D' 
GROUP BY A.ACCT_CODE;
OPEN	year_cur;
DO WHILE TRUE
	FETCH NEXT year_cur INTO	:ldc_amt, :ls_acct_code	;
	if sqlca.sqlcode <> 0 then exit

	//if isnull(ldc_amt) or ldc_amt = 0 then return
	if isnull(ldc_amt) then ldc_amt = 0

	//현물기부금, 기증 계정과목인 경우 처리 안함...
	if as_acct_code1 = '5224' and &
		(ls_acct_code = '131102' or ls_acct_code = '131202' or ls_acct_code = '131305' or ls_acct_code = '131407' or &
		 ls_acct_code = '131507' or ls_acct_code = '131603' or ls_acct_code = '131705') then
		ldc_amt = 0
	end if
	
	ldc_acct_amt += ldc_amt
LOOP
CLOSE	year_cur;


//현물기부금 계정일경우 계정을 서로 바꿔야 함.
if as_acct_code1 = '5224' then
	ls_acct_code_tmp 	= as_acct_code2
	as_acct_code2 		= as_acct_code1
	as_acct_code1 		= ls_acct_code_tmp
end if


//금액 리셋...
wf_reset_amt(as_acct_code1, as_slip_class, ldc_acct_month_amt, ldc_acct_amt, '-')


end subroutine

public subroutine wf_foreign_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_slip_class);/*
	대체전표 처리 : 2008.04.02
	대체전표에 대한 자금계산서 계정별 처리
	
	외화환산이익(손실) 계정 -> 잡수입(손실) 계정으로 금액 세팅
*/

datawindowchild	ldw_child
dec{0}				ldc_acct_amt, ldc_acct_month_amt
long					ll_row
string 				ls_acct_code_tmp

//월계 계산...
SELECT	SUM(A.SLIP_AMT)
INTO		:ldc_acct_month_amt
FROM		FNDB.HFN202M A, (
			SELECT	DISTINCT B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				between SUBSTR(:IS_ENDDATE,1,6)||'01' and :IS_ENDDATE
			AND		C.STEP_OPT 					= 	5
			AND		C.SLIP_CLASS				=  3							//대체...
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'D' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'C' ;

//if isnull(ldc_acct_month_amt) or ldc_acct_month_amt = 0 then return
if isnull(ldc_acct_month_amt) then ldc_acct_month_amt = 0

//누계 계산...
SELECT	SUM(A.SLIP_AMT)
INTO		:LDC_ACCT_AMT
FROM		FNDB.HFN202M A, (
			SELECT	DISTINCT B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				<= :IS_ENDDATE
			AND		C.STEP_OPT 					= 	5
			AND		C.SLIP_CLASS				=  3							//대체...
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'D' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'C' ;

//if isnull(ldc_acct_amt) or ldc_acct_amt = 0 then return
if isnull(ldc_acct_amt) then ldc_acct_amt = 0


//지출출력할 경우 계정을 서로 바꿔야 함.
if as_slip_class = '2' then
	ls_acct_code_tmp 	= as_acct_code2
	as_acct_code2 		= as_acct_code1
	as_acct_code1 		= ls_acct_code_tmp
end if


//금액 리셋...
wf_reset_amt(as_acct_code1, as_slip_class, ldc_acct_month_amt, ldc_acct_amt, '+')


end subroutine

public subroutine wf_reset_amt (string as_acct_code, string as_slip_class, decimal adc_acct_month_amt, decimal adc_acct_amt, string as_oper_gbn);datawindowchild	ldw_child
long		ll_row
decimal	ldc_acct_month_amt, ldc_acct_amt


if as_oper_gbn = '+' then
	adc_acct_month_amt 	= 	-adc_acct_month_amt
	adc_acct_amt			=	-adc_acct_amt
end if


// 원계정의 관계정에서 금액을 감산
if is_slip_class = '' then
	dw_print.getchild('dw_' + as_slip_class, ldw_child)
	
	ll_row = ldw_child.find("large_code = '" + as_slip_class + mid(as_acct_code,1,2) + "00' and " + &
									"isnull(middle_code) and isnull(acct_code)", 1, ldw_child.rowcount())
	if ll_row > 0 then
		ldc_acct_month_amt 	= 	ldw_child.getitemnumber(ll_row, 'acct_month_amt')
		ldc_acct_amt			=	ldw_child.getitemnumber(ll_row, 'acct_amt')
		
		if ldc_acct_month_amt > 0 then
			ldw_child.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt - adc_acct_month_amt)
		elseif ldc_acct_month_amt < 0 then
			ldw_child.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt + adc_acct_month_amt)
		end if
		
		if ldc_acct_amt > 0 then
			ldw_child.setitem(ll_row, 'acct_amt', ldc_acct_amt - adc_acct_amt)
		elseif ldc_acct_amt < 0 then
			ldw_child.setitem(ll_row, 'acct_amt', ldc_acct_amt + adc_acct_amt)
		end if
	end if
else
	ll_row = dw_print.find("large_code = '" + as_slip_class + mid(as_acct_code,1,2) + "00' and " + &
						   	  "isnull(middle_code) and isnull(acct_code)", 1, dw_print.rowcount())
	if ll_row > 0 then
		ldc_acct_month_amt 	= 	dw_print.getitemnumber(ll_row, 'acct_month_amt')
		ldc_acct_amt			=	dw_print.getitemnumber(ll_row, 'acct_amt')
		
		if ldc_acct_month_amt > 0 then
			dw_print.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt - adc_acct_month_amt)
		elseif ldc_acct_month_amt < 0 then
			dw_print.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt + adc_acct_month_amt)
		end if
		
		if ldc_acct_amt > 0 then
			dw_print.setitem(ll_row, 'acct_amt', ldc_acct_amt - adc_acct_amt)
		elseif ldc_acct_amt < 0 then
			dw_print.setitem(ll_row, 'acct_amt', ldc_acct_amt + adc_acct_amt)
		end if
	end if
end if


// 원계정의 항계정에서 금액을 감산
if is_slip_class = '' then
	dw_print.getchild('dw_' + as_slip_class, ldw_child)
	
	ll_row = ldw_child.find("large_code = '" + as_slip_class + mid(as_acct_code,1,2) + "00' and " + &
									"middle_code = '" + as_slip_class + mid(as_acct_code,1,3) + "0' and " + &
									"isnull(acct_code)", 1, ldw_child.rowcount())
	if ll_row > 0 then
		ldc_acct_month_amt 	= 	ldw_child.getitemnumber(ll_row, 'acct_month_amt')
		ldc_acct_amt			=	ldw_child.getitemnumber(ll_row, 'acct_amt')
		
		if ldc_acct_month_amt > 0 then
			ldw_child.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt - adc_acct_month_amt)
		elseif ldc_acct_month_amt < 0 then
			ldw_child.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt + adc_acct_month_amt)
		end if
		
		if ldc_acct_amt > 0 then
			ldw_child.setitem(ll_row, 'acct_amt', ldc_acct_amt - adc_acct_amt)
		elseif ldc_acct_amt < 0 then
			ldw_child.setitem(ll_row, 'acct_amt', ldc_acct_amt + adc_acct_amt)
		end if
	end if
else
	ll_row = dw_print.find("large_code = '" + as_slip_class + mid(as_acct_code,1,2) + "00' and " + &
						   	  "middle_code = '" + as_slip_class + mid(as_acct_code,1,3) + "0' and " + &
								  "isnull(acct_code)", 1, dw_print.rowcount())
	if ll_row > 0 then
		ldc_acct_month_amt 	= 	dw_print.getitemnumber(ll_row, 'acct_month_amt')
		ldc_acct_amt			=	dw_print.getitemnumber(ll_row, 'acct_amt')
		
		if ldc_acct_month_amt > 0 then
			dw_print.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt - adc_acct_month_amt)
		elseif ldc_acct_month_amt < 0 then
			dw_print.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt + adc_acct_month_amt)
		end if
		
		if ldc_acct_amt > 0 then
			dw_print.setitem(ll_row, 'acct_amt', ldc_acct_amt - adc_acct_amt)
		elseif ldc_acct_amt < 0 then
			dw_print.setitem(ll_row, 'acct_amt', ldc_acct_amt + adc_acct_amt)
		end if
	end if
end if


// 원계정의 목계정에서 금액을 감산
if is_slip_class = '' then
	dw_print.getchild('dw_' + as_slip_class, ldw_child)
	
	ll_row = ldw_child.find("large_code = '" + as_slip_class + mid(as_acct_code,1,2) + "00' and " + &
									"middle_code = '" + as_slip_class + mid(as_acct_code,1,3) + "0' and " + &
									"acct_code = '" + as_slip_class + as_acct_code + "'", 1, ldw_child.rowcount())
	if ll_row > 0 then
		ldc_acct_month_amt 	= 	ldw_child.getitemnumber(ll_row, 'acct_month_amt')
		ldc_acct_amt			=	ldw_child.getitemnumber(ll_row, 'acct_amt')
		
		if ldc_acct_month_amt > 0 then
			ldw_child.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt - adc_acct_month_amt)
		elseif ldc_acct_month_amt < 0 then
			ldw_child.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt + adc_acct_month_amt)
		end if
		
		if ldc_acct_amt > 0 then
			ldw_child.setitem(ll_row, 'acct_amt', ldc_acct_amt - adc_acct_amt)
		elseif ldc_acct_amt < 0 then
			ldw_child.setitem(ll_row, 'acct_amt', ldc_acct_amt + adc_acct_amt)
		end if
	end if
else
	ll_row = dw_print.find("large_code = '" + as_slip_class + mid(as_acct_code,1,2) + "00' and " + &
								  "middle_code = '" + as_slip_class + mid(as_acct_code,1,3) + "0' and " + &
								  "acct_code = '" + as_slip_class + as_acct_code + "'", 1, dw_print.rowcount())
	if ll_row > 0 then
		ldc_acct_month_amt 	= 	dw_print.getitemnumber(ll_row, 'acct_month_amt')
		ldc_acct_amt			=	dw_print.getitemnumber(ll_row, 'acct_amt')
		
		if ldc_acct_month_amt > 0 then
			dw_print.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt - adc_acct_month_amt)
		elseif ldc_acct_month_amt < 0 then
			dw_print.setitem(ll_row, 'acct_month_amt', ldc_acct_month_amt + adc_acct_month_amt)
		end if
		
		if ldc_acct_amt > 0 then
			dw_print.setitem(ll_row, 'acct_amt', ldc_acct_amt - adc_acct_amt)
		elseif ldc_acct_amt < 0 then
			dw_print.setitem(ll_row, 'acct_amt', ldc_acct_amt + adc_acct_amt)
		end if
	end if
end if


end subroutine

event open;call super::open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.11
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//string	ls_sysdate
//
//ls_sysdate = f_today()
//
//uo_slip_class.rb_1.checked = true
//uo_acct_class.uf_enabled(false)
//
//ii_acct_class = 1
//
//em_yearmonth.text = mid(ls_sysdate,1,4) + '/' + mid(ls_sysdate,5,2)
//
end event

on w_hfn510p.create
int iCurrent
call super::create
end on

on w_hfn510p.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
//string	ls_sysdate
//
//ls_sysdate = f_today()

//uo_slip_class.rb_1.checked = true
//uo_acct_class.uf_enabled(false)

ii_acct_class = 1
is_slip_class = ''

dw_con.object.yearmonth[1]  = date(string(f_today(), '@@@@/@@/@@'))
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

type ln_templeft from w_hfn_print_form1`ln_templeft within w_hfn510p
end type

type ln_tempright from w_hfn_print_form1`ln_tempright within w_hfn510p
end type

type ln_temptop from w_hfn_print_form1`ln_temptop within w_hfn510p
end type

type ln_tempbuttom from w_hfn_print_form1`ln_tempbuttom within w_hfn510p
end type

type ln_tempbutton from w_hfn_print_form1`ln_tempbutton within w_hfn510p
end type

type ln_tempstart from w_hfn_print_form1`ln_tempstart within w_hfn510p
end type

type uc_retrieve from w_hfn_print_form1`uc_retrieve within w_hfn510p
end type

type uc_insert from w_hfn_print_form1`uc_insert within w_hfn510p
end type

type uc_delete from w_hfn_print_form1`uc_delete within w_hfn510p
end type

type uc_save from w_hfn_print_form1`uc_save within w_hfn510p
end type

type uc_excel from w_hfn_print_form1`uc_excel within w_hfn510p
end type

type uc_print from w_hfn_print_form1`uc_print within w_hfn510p
end type

type st_line1 from w_hfn_print_form1`st_line1 within w_hfn510p
end type

type st_line2 from w_hfn_print_form1`st_line2 within w_hfn510p
end type

type st_line3 from w_hfn_print_form1`st_line3 within w_hfn510p
end type

type uc_excelroad from w_hfn_print_form1`uc_excelroad within w_hfn510p
end type

type ln_dwcon from w_hfn_print_form1`ln_dwcon within w_hfn510p
end type

type st_1 from w_hfn_print_form1`st_1 within w_hfn510p
boolean visible = false
integer x = 2286
integer y = 100
end type

type uo_slip_class from w_hfn_print_form1`uo_slip_class within w_hfn510p
boolean visible = false
integer x = 827
integer y = 72
end type

type uo_acct_class from w_hfn_print_form1`uo_acct_class within w_hfn510p
boolean visible = false
integer x = 736
integer y = 0
end type

type uo_year from w_hfn_print_form1`uo_year within w_hfn510p
boolean visible = false
integer x = 2871
end type

type dw_print from w_hfn_print_form1`dw_print within w_hfn510p
integer height = 2268
string dataobject = "d_hfn510p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_2 from w_hfn_print_form1`st_2 within w_hfn510p
boolean visible = false
integer x = 1888
integer y = 100
integer width = 443
end type

type dw_con from w_hfn_print_form1`dw_con within w_hfn510p
string dataobject = "d_hfn510p_con"
end type

event dw_con::constructor;call super::constructor;if gs_DeptCode = '2902' or gs_empcode = 'admin' then
	dw_con.object.all_printyn.visible = true
	dw_con.object.all_printyn[1] = 'Y'
else
	dw_con.object.all_printyn.visible = false
	dw_con.object.all_printyn[1] = 'N'
end if
end event

event dw_con::itemchanged;call super::itemchanged;accepttext()

Choose Case dwo.name
	Case 'slip_class'
		If data = '%' Then
			is_slip_class = ''
		Else
			is_slip_class =  data
		End If
End Choose
end event

