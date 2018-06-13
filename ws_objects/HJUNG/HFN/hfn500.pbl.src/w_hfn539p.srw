$PBExportHeader$w_hfn539p.srw
$PBExportComments$결산 명세서 출력(년월,수입/지출)
forward
global type w_hfn539p from w_hfn_print_form1
end type
end forward

global type w_hfn539p from w_hfn_print_form1
string title = "결산 명세서 출력"
end type
global w_hfn539p w_hfn539p

type variables
string	is_strdate, is_enddate
end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_jagum_proc (string as_gubun, string as_bdgt_year)
public function decimal wf_data_proc (string as_bdgt_year, string as_acct_code)
public subroutine wf_jasan_proc (string as_bdgt_year)
public subroutine wf_building_proc (string as_bdgt_year)
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
string ls_bef_bdgt_year, ls_slip_class
date	 ld_date

dw_con.accepttext()

ls_yearmonth = string(dw_con.object.bdgt_year[1], 'yyyymm')
ls_slip_class = dw_con.object.slip_class[1]
If ls_slip_class = '%' Then ls_slip_class = ''
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

CHOOSE CASE ls_slip_class
	CASE '1'			// 수입
		  dw_print.DataObject = 'd_hfn539p_2'
	CASE '2'			// 지출
		  dw_print.DataObject = 'd_hfn539p_3'
	CASE ELSE		// 수입/지출
		  dw_print.DataObject = 'd_hfn539p_1'
END CHOOSE

dw_print.SetTransObject(SQLCA)

dw_print.Modify("DataWindow.Print.Preview='yes'")

dw_print.retrieve(ii_acct_class, is_bdgt_year, is_strdate, is_enddate)

If dw_print.RowCount() > 0 Then
	// 조회된 자료가 있을 경우 전기이월자금과 차기이월자금을 계산하여 삽입한다.
	CHOOSE CASE ls_slip_class
		CASE '1'			// 수입
			  wf_jagum_proc('1', Ls_bef_bdgt_year)
		CASE '2'			// 지출
			  wf_jagum_proc('2', is_bdgt_year)
		CASE ELSE		// 수입/지출
			  wf_jagum_proc('1', Ls_bef_bdgt_year)
			  wf_jagum_proc('2', is_bdgt_year)
	END CHOOSE

	// 고정자산 매각수입에 대한 금액 보정
	// 고정자산 매각수입 = 고정자산매각수입 - 고정자산처분손실
	if ls_slip_class = '' or ls_slip_class = '1' then wf_jasan_proc(is_bdgt_year)

	//건물매입비에서 건설가계정 금액 감산...
	if ls_slip_class = '' or ls_slip_class = '2' then wf_building_proc(is_bdgt_year)

	dw_print.setfilter("slip_amt <> 0")
	dw_print.filter()
End If

dw_print.sort()
dw_print.groupcalc()
end subroutine

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
Dec{0}	Ldc_Acct_Amt

// 유동자금
Ldc_1110_Amt = wf_data_proc(as_bdgt_year, '111000')
// 기타유동자산
Ldc_1120_Amt = wf_data_proc(as_bdgt_year, '112000')
// 예수금
Ldc_2120_Amt = wf_data_proc(as_bdgt_year, '212000')
// 선수금
Ldc_2130_Amt = wf_data_proc(as_bdgt_year, '213000')
// 기타유동부채
Ldc_2140_Amt = wf_data_proc(as_bdgt_year, '214000')

Ldc_Acct_Amt = Ldc_1110_amt + Ldc_1120_amt - Ldc_2120_amt - Ldc_2130_amt - Ldc_2140_amt

// 삽입
Long	Ll_row
Ll_row = dw_print.InsertRow(0)

If as_gubun = '1' Then
	dw_print.setitem(Ll_row, 'slip_class', '1')
	dw_print.setitem(Ll_row, 'sort', 		'4')
	dw_print.setitem(Ll_row, 'acct_code',	'19999')
	dw_print.setitem(Ll_row, 'acct_name',  '미사용전기이월자금')
	dw_print.setitem(Ll_row, 'slip_amt',	Ldc_acct_amt)
	dw_print.setitem(Ll_row, 'remark',		'')
	dw_print.setitem(Ll_row, 'slip_date',	'')
	dw_print.setitem(Ll_row, 'slip_no',		0)
Else
	dw_print.setitem(Ll_row, 'slip_class', '2')
	dw_print.setitem(Ll_row, 'sort', 		'4')
	dw_print.setitem(Ll_row, 'acct_code',	'29999')
	dw_print.setitem(Ll_row, 'acct_name',  '미사용차기이월자금')
	dw_print.setitem(Ll_row, 'slip_amt',	Ldc_acct_amt)
	dw_print.setitem(Ll_row, 'remark',		'')
	dw_print.setitem(Ll_row, 'slip_date',	'')
	dw_print.setitem(Ll_row, 'slip_no',		0)
End If

end subroutine

public function decimal wf_data_proc (string as_bdgt_year, string as_acct_code);// ==========================================================================================
// 기    능	:	Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_data_proc()
// 인    수 :	as_bdgt_year(처리년도), as_acct_code(처리계정)
// 되 돌 림 :	Ldc_Return_Amt(계정잔액)
// 주의사항 :
// 수정사항 :
// ==========================================================================================
Dec{0}	Ldc_Return_Amt

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

Return Ldc_Return_Amt
end function

public subroutine wf_jasan_proc (string as_bdgt_year);dec{0}				ldc_acct_amt
long					ll_row, ll_end, ll_find, ll_slip_no, ll_cnt
string 				ls_acct_code, ls_slip_date


ll_end  = dw_print.rowcount()
ll_find = dw_print.find("slip_class = '1' and mid(acct_code, 2, 2) = '13'", 1, ll_end)

do while	ll_find > 0
	ls_acct_code   = dw_print.getitemstring(ll_find, 'acct_code')
	ls_acct_code 	= right(ls_acct_code, 4)
	ls_slip_date   = dw_print.getitemstring(ll_find, 'slip_date')
	ll_slip_no   	= dw_print.getitemnumber(ll_find, 'slip_no')
	

	// 고정자산 매각수입에 대한 금액 보정
	// 고정자산 매각수입 = 고정자산매각수입 - 고정자산처분손실
		
	// 고정자산처분손실금액 select...
	SELECT	SUM(A.SLIP_AMT)
	INTO		:ldc_acct_amt
	FROM		FNDB.HFN202M A, (
				SELECT	B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO
				FROM		FNDB.HFN202M B, FNDB.HFN201M C
				WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
				AND		B.SLIP_DATE 				= 	C.SLIP_DATE
				AND		B.SLIP_NO 					= 	C.SLIP_NO
				AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
				AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
				AND		C.SLIP_DATE 				= 	:ls_slip_date
				AND		C.SLIP_NO 					= 	:ll_slip_no
				AND		C.STEP_OPT 					= 	5
				AND		SUBSTR(B.ACCT_CODE,1,4) = 	:ls_acct_code
				AND		B.DRCR_CLASS 				= 	'C' ) D
	WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
	AND		A.SLIP_DATE 				= D.SLIP_DATE
	AND		A.SLIP_NO 					= D.SLIP_NO
	AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
	AND		SUBSTR(A.ACCT_CODE,1,4) = '4426'
	AND		A.DRCR_CLASS 				= 'D' ;
	
	if isnull(ldc_acct_amt) then ldc_acct_amt = 0
	
	dw_print.setitem(ll_find, 'slip_amt', dw_print.getitemnumber(ll_find, 'slip_amt') - ldc_acct_amt)

	
//	//대체전표 금액보정
//	
//	//대체금액 select...
//	SELECT	count(*)
//	INTO		:ll_cnt
//	FROM		FNDB.HFN202M B, FNDB.HFN201M C
//	WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
//	AND		B.SLIP_DATE 				= 	C.SLIP_DATE
//	AND		B.SLIP_NO 					= 	C.SLIP_NO
//	AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
//	AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
//	AND		C.ACCT_DATE 				= 	:ls_acct_date
//	AND		C.ACCT_NO 					= 	:ll_acct_no
//	AND		C.STEP_OPT 					= 	5
//	AND		C.SLIP_CLASS				=  3							//대체...
//	AND		B.ACCT_CODE 				= 	:ls_acct_code
//	AND		B.DRCR_CLASS 				= 	'D'
//	;
//	
//	if ll_cnt > 0 then dw_print.setitem(ll_find, 'com_acct_amt', 0)

	ll_find ++
	if ll_find > ll_end then exit
	ll_find = dw_print.find("slip_class = '1' and mid(acct_code, 2, 2) = '13'", ll_find, ll_end)
loop

end subroutine

public subroutine wf_building_proc (string as_bdgt_year);/*
건설가계정 계정 관련...
건물 건축 완료후 본계정 대체 시 ...
자금계산서 지출 중 건물매입비 금액에서 건설가계정 금액을 차감하여 계산...
*/

dec{0}				ldc_acct_amt
long					ll_row, ll_end, ll_find, ll_slip_no, ll_cnt, ll_slip_class
string 				ls_acct_code, ls_slip_date

ll_end  = dw_print.rowcount()
	
ll_find = dw_print.find("slip_class = '2' and mid(acct_code, 2, 4) = '1312'", 1, ll_end)

do while	ll_find > 0
	ls_acct_code   = dw_print.getitemstring(ll_find, 'acct_code')
	ls_acct_code 	= right(ls_acct_code, 4)
	ls_slip_date   = dw_print.getitemstring(ll_find, 'slip_date')
	ll_slip_no   	= dw_print.getitemnumber(ll_find, 'slip_no')
	
	//대체전표 금액보정
	
	//대체금액 select...
	SELECT	count(*)
	INTO		:ll_cnt
	FROM		FNDB.HFN202M B, FNDB.HFN201M C
	WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
	AND		B.SLIP_DATE 				= 	C.SLIP_DATE
	AND		B.SLIP_NO 					= 	C.SLIP_NO
	AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
	AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
	AND		C.SLIP_DATE 				= 	:ls_slip_date
	AND		C.SLIP_NO 					= 	:ll_slip_no
	AND		C.STEP_OPT 					= 	5
	AND		C.SLIP_CLASS				=  3							//대체...
	AND		SUBSTR(B.ACCT_CODE,1,4) = 	:ls_acct_code
	AND		B.DRCR_CLASS 				= 	'D'
	;
	
	if ll_cnt > 0 then dw_print.setitem(ll_find, 'slip_amt', 0)

	ll_find ++
	if ll_find > ll_end then exit
	ll_find = dw_print.find("slip_class = '2' and mid(acct_code, 2, 4) = '1312'", ll_find, ll_end)
loop

end subroutine

event open;call super::open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.12
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//string	ls_sysdate
//
//ls_sysdate = f_today()
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//uo_acct_class.uf_enabled(false)
//
//em_yearmonth.text = string(ls_sysdate, '@@@@/@@')
//
end event

on w_hfn539p.create
int iCurrent
call super::create
end on

on w_hfn539p.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================


dw_con.object.bdgt_year[1] = date(string(f_today(), '@@@@/@@/@@'))
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

type ln_templeft from w_hfn_print_form1`ln_templeft within w_hfn539p
end type

type ln_tempright from w_hfn_print_form1`ln_tempright within w_hfn539p
end type

type ln_temptop from w_hfn_print_form1`ln_temptop within w_hfn539p
end type

type ln_tempbuttom from w_hfn_print_form1`ln_tempbuttom within w_hfn539p
end type

type ln_tempbutton from w_hfn_print_form1`ln_tempbutton within w_hfn539p
end type

type ln_tempstart from w_hfn_print_form1`ln_tempstart within w_hfn539p
end type

type uc_retrieve from w_hfn_print_form1`uc_retrieve within w_hfn539p
end type

type uc_insert from w_hfn_print_form1`uc_insert within w_hfn539p
end type

type uc_delete from w_hfn_print_form1`uc_delete within w_hfn539p
end type

type uc_save from w_hfn_print_form1`uc_save within w_hfn539p
end type

type uc_excel from w_hfn_print_form1`uc_excel within w_hfn539p
end type

type uc_print from w_hfn_print_form1`uc_print within w_hfn539p
end type

type st_line1 from w_hfn_print_form1`st_line1 within w_hfn539p
end type

type st_line2 from w_hfn_print_form1`st_line2 within w_hfn539p
end type

type st_line3 from w_hfn_print_form1`st_line3 within w_hfn539p
end type

type uc_excelroad from w_hfn_print_form1`uc_excelroad within w_hfn539p
end type

type ln_dwcon from w_hfn_print_form1`ln_dwcon within w_hfn539p
end type

type st_1 from w_hfn_print_form1`st_1 within w_hfn539p
boolean visible = false
integer x = 2290
integer y = 100
end type

type uo_slip_class from w_hfn_print_form1`uo_slip_class within w_hfn539p
boolean visible = false
integer x = 859
integer y = 76
end type

type uo_acct_class from w_hfn_print_form1`uo_acct_class within w_hfn539p
boolean visible = false
integer x = 1070
integer y = 816
end type

type uo_year from w_hfn_print_form1`uo_year within w_hfn539p
boolean visible = false
integer x = 2917
integer y = 68
end type

type dw_print from w_hfn_print_form1`dw_print within w_hfn539p
integer height = 2268
string dataobject = "d_hfn539p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_2 from w_hfn_print_form1`st_2 within w_hfn539p
boolean visible = false
integer x = 1902
integer y = 100
integer width = 448
end type

type dw_con from w_hfn_print_form1`dw_con within w_hfn539p
string dataobject = "d_hfn539p_con"
end type

