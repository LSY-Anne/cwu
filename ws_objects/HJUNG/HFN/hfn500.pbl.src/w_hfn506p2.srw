$PBExportHeader$w_hfn506p2.srw
$PBExportComments$회계원장(자금계정)
forward
global type w_hfn506p2 from w_hfn_print_form5
end type
type cb_1 from uo_imgbtn within w_hfn506p2
end type
end forward

global type w_hfn506p2 from w_hfn_print_form5
cb_1 cb_1
end type
global w_hfn506p2 w_hfn506p2

type variables
string is_bdgt_year

end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_jasan_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_strdate, string as_enddate)
public subroutine wf_transfer_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_strdate, string as_enddate, string as_slip_class)
public subroutine wf_foreign_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_strdate, string as_enddate, string as_slip_class)
end prototypes

public subroutine wf_retrieve ();DateTime	ldt_SysDateTime
string	ls_acct_code, ls_gubun
    date ld_date
	 long ll_cnt
	 
STring 	ls_all_printyn, ls_slip_class
dw_con.accepttext()

ls_all_printyn = dw_con.object.all_printyn[1]
is_str_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
is_end_date = string(dw_con.object.to_date[1], 'yyyymmdd')
ls_slip_class = dw_con.object.slip_class[1]
// 조회계정코드
ls_acct_code = dw_con.Object.acct_code[1]


dw_print.Reset()


if is_str_date > is_end_date then
	f_messagebox('1', '회계일자의 범위가 올바르지 않습니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return
end if

// 요구기간 설정
select count(*) into :ll_cnt from acdb.hac003m
 where (:is_str_date between from_date and to_date
        and bdgt_class = 0
	     and stat_class = 0)
	and (:is_end_date between from_date and to_date
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
where		:is_str_date	between from_date and to_date
and		bdgt_class = 0
and		stat_class = 0	;




if ls_all_printyn = 'Y'  then		//연속용지
	//수입,지출 구분 가져오기
	if ls_slip_class = '1'  then
		dw_print.dataobject = 'd_hfn506p_12'
	else
		dw_print.dataobject = 'd_hfn506p_13'
	end if
else
	//수입,지출 구분 가져오기
	if ls_slip_class = '1'  then
		dw_print.dataobject = 'd_hfn506p_3_1'
	else
		dw_print.dataobject = 'd_hfn506p_3_2'
	end if
end if

dw_print.SetTransObject(SQLCA)
dw_print.Modify("DataWindow.Print.Preview='yes'")


wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(ii_acct_class, is_bdgt_year, is_str_date, is_end_date, ls_acct_code)
dw_print.SetRedraw(True)



if ls_slip_class = '1'  then		//수입
	// 고정자산 매각수입에 대한 금액 보정 : 고정자산 매각수입 = 고정자산매각수입 - 고정자산처분손실
	wf_jasan_proc(is_bdgt_year, '1311', '4426', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '1312', '4426', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '1313', '4426', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '1314', '4426', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '1315', '4426', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '1316', '4426', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '1317', '4426', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '1318', '4426', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '1319', '4426', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '1321', '4426', is_str_date, is_end_date)
end if


//지출출력시 건물매입비에서 건설가계정 금액 감산...
//지출출력시 차량운반구에서 건설가계정 금액 감산...(2005.07.12)
if ls_slip_class = '2'  then 	//지출
	wf_transfer_proc(is_bdgt_year, '1312', '1319', is_str_date, is_end_date, '2')	//건물매입비
	wf_transfer_proc(is_bdgt_year, '1316', '1319', is_str_date, is_end_date, '2')	//차량운반구
end if

//기계기구,집기비품 계정을 건물로 대체한 전표가 있음. (물품관리전환 건물대체)(2005.07.12)
if ls_slip_class = '1'  then 	//수입
	wf_transfer_proc(is_bdgt_year, '1312', '1314', is_str_date, is_end_date, '1')	//기계기구
	wf_transfer_proc(is_bdgt_year, '1312', '1315', is_str_date, is_end_date, '1')	//집기비품
elseif ls_slip_class = '2'  then 	//지출
	wf_transfer_proc(is_bdgt_year, '1312', '1314', is_str_date, is_end_date, '2')	//기계기구
	wf_transfer_proc(is_bdgt_year, '1312', '1315', is_str_date, is_end_date, '2')	//집기비품
end if


/*	
	2007.10.18 집기비품 기증건(전표번호:2007/09/21-3)으로 삭제...
	2008.05.01 기증계정과목은 처리안하고 그 이외의 계정과목은 처리해야함.
*/
//연구기자재 취득자산 대체전표(현물기부금 기자재(5224-02)) (2007.03.20)
//지출출력시 기계기구(1314),집기비품(1315)에서 현물기부금 대체금액 감산...
if ls_slip_class = '2'  then 	//지출
	wf_jasan_proc(is_bdgt_year, '5224', '1311', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '5224', '1312', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '5224', '1313', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '5224', '1314', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '5224', '1315', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '5224', '1316', is_str_date, is_end_date)
	wf_jasan_proc(is_bdgt_year, '5224', '1317', is_str_date, is_end_date)
end if



/* 2008.04.02 : 외화환산이익(손실) 대체전표의 경우 -> 잡수입(이익) 계정에서 금액 보정 */
if  ls_slip_class = '1' then 	//수입
	wf_foreign_proc(is_bdgt_year, '5421', '5422', is_str_date, is_end_date, '1')	//외화환산이익
elseif  ls_slip_class = '2'  then 	//지출
	wf_foreign_proc(is_bdgt_year, '4422', '4421', is_str_date, is_end_date, '2')	//외화환산손실
end if	
/* ********************************* */



if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true

	dw_print.setfilter("com_dr_amt + com_cr_amt <> 0")
	dw_print.filter()
	dw_print.setsort("a_sort A, com_mok_code A, com_acct_date A, com_slip_date A, com_slip_no A, com_slip_seq A")
	dw_print.sort()
	dw_print.groupcalc()

/*
	if ls_acct_code = '' then
		// 전기이월운영차액을 처리한다.
		// 전기이월운영차액 = 당기운영차액
		wf_data_proc()
		dw_print.setsort('com_mok_code, com_acct_date, com_slip_date, com_slip_no, com_slip_seq')
		dw_print.sort()
		dw_print.groupcalc()
	end if
*/

end if

wf_setMsg('')

end subroutine

public subroutine wf_jasan_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_strdate, string as_enddate);//고정자산처분손실 금액 보정
//현물기부금 대체 금액 보정 : 2008.05.02

datawindowchild	ldw_child
dec{0}				ldc_acct_amt, ldc_acct_month_amt
long					ll_row
integer				li_slip_no, li_slip_seq, li_slip_seq2
string				ls_slip_date, ls_acct_date, ls_acct_code, ls_acct_code_tmp

//월계 계산...
DECLARE 	JASAN_CUR CURSOR FOR
SELECT	SUM(A.SLIP_AMT), A.SLIP_DATE, A.SLIP_NO, A.SLIP_SEQ, D.ACCT_DATE, A.ACCT_CODE
FROM		FNDB.HFN202M A, (	
			SELECT	B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO, C.ACCT_DATE
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) 	=	:II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				between :as_strdate and :as_enddate
			AND		C.STEP_OPT 					= 	5
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'C' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'D' 
GROUP BY A.SLIP_DATE, A.SLIP_NO, A.SLIP_SEQ, D.ACCT_DATE, A.ACCT_CODE	;
OPEN JASAN_CUR ;
DO WHILE TRUE
	FETCH NEXT JASAN_CUR INTO	:ldc_acct_month_amt, :ls_slip_date, :li_slip_no, :li_slip_seq, :ls_acct_date, :ls_acct_code ;
	if sqlca.sqlcode <> 0 then exit
	
	if isnull(ldc_acct_month_amt) then ldc_acct_month_amt = 0

	//현물기부금, 기증 계정과목인 경우 처리 안함...
	if as_acct_code1 = '5224' and &
		(ls_acct_code = '131102' or ls_acct_code = '131202' or ls_acct_code = '131305' or ls_acct_code = '131407' or &
		 ls_acct_code = '131507' or ls_acct_code = '131603' or ls_acct_code = '131705') then
		ldc_acct_month_amt = 0
	end if

	if ldc_acct_month_amt <> 0 then

		//현물기부금일 경우 계정을 서로 바꿔야 함.
		if as_acct_code1 = '5224' then
			ls_acct_code_tmp 	= as_acct_code2
			as_acct_code2 		= as_acct_code1
			as_acct_code1 		= ls_acct_code_tmp
	
			//전표순번...
			SELECT	NVL(SLIP_SEQ,0)
			INTO		:li_slip_seq2
			FROM		FNDB.HFN202M
			WHERE		DECODE(:II_ACCT_CLASS,0,0,ACCT_CLASS) = :II_ACCT_CLASS
			AND		SLIP_DATE					=	:ls_slip_date
			AND		SLIP_NO						=	:li_slip_no
			AND		SUBSTR(ACCT_CODE,1,4) 	= 	:as_acct_code2	;
			
			li_slip_seq = li_slip_seq2
		end if
		
		//금액 insert...
		ll_row = dw_print.insertrow(0)
		
		dw_print.setItem(ll_row, 'com_acct_code', 	AS_ACCT_CODE1+'00')
		dw_print.setItem(ll_row, 'com_acct_name', 	f_get_acctname('0', AS_ACCT_CODE1+'00'))
		dw_print.setItem(ll_row, 'com_mok_code', 		AS_ACCT_CODE1+'00')
		dw_print.setItem(ll_row, 'com_mok_name', 		f_get_acctname('0', AS_ACCT_CODE1+'00'))
		dw_print.setItem(ll_row, 'com_drcr_class', 	'D')
		dw_print.setItem(ll_row, 'com_acct_date', 	ls_acct_date)
		dw_print.setItem(ll_row, 'com_slip_date', 	ls_slip_date)
		dw_print.setItem(ll_row, 'com_slip_no', 		li_slip_no)
		dw_print.setItem(ll_row, 'com_slip_seq', 		li_slip_seq)
		dw_print.setItem(ll_row, 'com_remark', 		f_get_acctname('0', AS_ACCT_CODE2+'00')+' 대체 금액')
		if as_acct_code2 = '5224' then
			dw_print.setItem(ll_row, 'com_dr_amt', 		0)
			dw_print.setItem(ll_row, 'com_cr_amt', 		ldc_acct_month_amt)
		else
			dw_print.setItem(ll_row, 'com_dr_amt', 		ldc_acct_month_amt)
			dw_print.setItem(ll_row, 'com_cr_amt', 		0)
		end if
		dw_print.setItem(ll_row, 'a_sort', 				'2')

	/*
		// 원계정의 목계정에서 금액을 감산
		ll_row = dw_print.find("com_slip_date+com_slip_no+com_slip_seq = '"+ls_slip_date+string(li_slip_no)+string(li_slip_seq)+"' and "+&
									  "left(com_acct_code,4) = '"+as_acct_code1+"'", 1, dw_print.rowcount())
		
		if ll_row > 0 then
			if dw_print.getitemnumber(ll_row, 'com_cr_amt') > 0 then
				dw_print.setitem(ll_row, 'com_cr_amt', dw_print.getitemnumber(ll_row, 'com_cr_amt') - ldc_acct_month_amt)
			end if
		end if
	*/
	
	end if
LOOP
CLOSE JASAN_CUR ;

//전월이월 계산...
SELECT	SUM(A.SLIP_AMT)
INTO		:LDC_ACCT_AMT
FROM		FNDB.HFN202M A, (
			SELECT	B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				< 	:as_strdate
			AND		C.STEP_OPT 					= 	5
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'C' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'D' ;

if isnull(ldc_acct_amt) then ldc_acct_amt = 0

if ldc_acct_amt <> 0 then
	
	// 원계정의 목계정에서 금액을 감산
	ll_row = dw_print.find("com_acct_date = '"+left(as_strdate,6)+"00"+"' and left(com_acct_code,4) = '"+as_acct_code1+"'", 1, dw_print.rowcount())
	
	if ll_row > 0 then
		if dw_print.getitemnumber(ll_row, 'com_cr_amt') > 0 then
			dw_print.setitem(ll_row, 'com_cr_amt', dw_print.getitemnumber(ll_row, 'com_cr_amt') - ldc_acct_amt)
		end if
	end if

end if

end subroutine

public subroutine wf_transfer_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_strdate, string as_enddate, string as_slip_class);/*
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
integer				li_slip_no, li_slip_seq, li_slip_seq2
string				ls_slip_date, ls_acct_date, ls_acct_code_tmp

//월계 계산...
DECLARE	building_cur CURSOR FOR
SELECT	SUM(A.SLIP_AMT), 		A.SLIP_DATE, 	A.SLIP_NO, 	A.SLIP_SEQ,	D.ACCT_DATE
FROM		FNDB.HFN202M A, (
			SELECT	DISTINCT B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO, C.ACCT_DATE
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				between :as_strdate and :as_enddate
			AND		C.STEP_OPT 					= 	5
			AND		C.SLIP_CLASS				=  3							/* 대체... */
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'D' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'C' 
GROUP BY A.SLIP_DATE, A.SLIP_NO, A.SLIP_SEQ, D.ACCT_DATE;
open building_cur ;
do while true 
	fetch next building_cur into :ldc_acct_month_amt,	:ls_slip_date,	:li_slip_no, :li_slip_seq, :ls_acct_date ;
	if sqlca.sqlcode <> 0 then exit
	
	if isnull(ldc_acct_month_amt) then ldc_acct_month_amt = 0 

	if ldc_acct_month_amt <> 0 then
	
		//수입출력할 경우 계정을 서로 바꿔야 함.
		if as_slip_class = '1' then
			ls_acct_code_tmp 	= as_acct_code2
			as_acct_code2 		= as_acct_code1
			as_acct_code1 		= ls_acct_code_tmp
			
			//전표순번...
			SELECT	NVL(SLIP_SEQ,0)
			INTO		:li_slip_seq2
			FROM		FNDB.HFN202M
			WHERE		DECODE(:II_ACCT_CLASS,0,0,ACCT_CLASS) = :II_ACCT_CLASS
			AND		SLIP_DATE					=	:ls_slip_date
			AND		SLIP_NO						=	:li_slip_no
			AND		SUBSTR(ACCT_CODE,1,4) 	= 	:as_acct_code2	;
			
			li_slip_seq = li_slip_seq2
		end if

		//건설가계정 금액 insert...
		ll_row = dw_print.insertrow(0)
		
		dw_print.setItem(ll_row, 'com_acct_code', 	AS_ACCT_CODE1+'00')
		dw_print.setItem(ll_row, 'com_acct_name', 	f_get_acctname('0', AS_ACCT_CODE1+'00'))
		dw_print.setItem(ll_row, 'com_mok_code', 		AS_ACCT_CODE1+'00')
		dw_print.setItem(ll_row, 'com_mok_name', 		f_get_acctname('0', AS_ACCT_CODE1+'00'))
		if as_slip_class = '1' then
			dw_print.setItem(ll_row, 'com_drcr_class', 	'C')
		else
			dw_print.setItem(ll_row, 'com_drcr_class', 	'D')
		end if
		dw_print.setItem(ll_row, 'com_acct_date', 	ls_acct_date)
		dw_print.setItem(ll_row, 'com_slip_date', 	ls_slip_date)
		dw_print.setItem(ll_row, 'com_slip_no', 		li_slip_no)
		dw_print.setItem(ll_row, 'com_slip_seq', 		li_slip_seq)
		dw_print.setItem(ll_row, 'com_remark', 		f_get_acctname('0', AS_ACCT_CODE2+'00')+' 대체 금액')
		if as_slip_class = '1' then
			dw_print.setItem(ll_row, 'com_dr_amt', 		ldc_acct_month_amt)
			dw_print.setItem(ll_row, 'com_cr_amt', 		0)
		else
			dw_print.setItem(ll_row, 'com_dr_amt', 		0)
			dw_print.setItem(ll_row, 'com_cr_amt', 		ldc_acct_month_amt)
		end if
		dw_print.setItem(ll_row, 'a_sort', 				'2')
		
	end if
	
loop
close building_cur ;

//if isnull(ldc_acct_month_amt) or ldc_acct_month_amt = 0 then return

//전월이월 계산...
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
			AND		C.ACCT_DATE 				< 	:as_strdate
			AND		C.STEP_OPT 					= 	5
			AND		C.SLIP_CLASS				=  3							/* 대체... */
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'D' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'C' ;

if isnull(ldc_acct_amt) or ldc_acct_amt = 0 then return

if ldc_acct_amt <> 0 then
	
	//수입출력할 경우 계정을 서로 바꿔야 함.
	if as_slip_class = '1' then
		ls_acct_code_tmp 	= as_acct_code2
		as_acct_code2 		= as_acct_code1
		as_acct_code1 		= ls_acct_code_tmp
	end if

	// 원계정의 목계정에서 금액을 감산
	ll_row = dw_print.find("com_acct_date = '"+left(as_strdate,6)+"00"+"' and left(com_acct_code,4) = '"+as_acct_code1+"'", 1, dw_print.rowcount())
	
	if ll_row > 0 then
		if as_slip_class = '1' then
			if dw_print.getitemnumber(ll_row, 'com_cr_amt') > 0 then
				dw_print.setitem(ll_row, 'com_cr_amt', dw_print.getitemnumber(ll_row, 'com_cr_amt') - ldc_acct_amt)
			end if
		else
			if dw_print.getitemnumber(ll_row, 'com_dr_amt') > 0 then
				dw_print.setitem(ll_row, 'com_dr_amt', dw_print.getitemnumber(ll_row, 'com_dr_amt') - ldc_acct_amt)
			end if
		end if
	end if

end if


end subroutine

public subroutine wf_foreign_proc (string as_bdgt_year, string as_acct_code1, string as_acct_code2, string as_strdate, string as_enddate, string as_slip_class);/*
	대체전표 처리 : 2008.04.02
	대체전표에 대한 자금계산서 계정별 처리
	
	외화환산이익(손실) 계정 -> 잡수입(손실) 계정으로 금액 세팅
*/

datawindowchild	ldw_child
dec{0}				ldc_acct_amt, ldc_acct_month_amt
long					ll_row
integer				li_slip_no, li_slip_seq, li_slip_seq2
string				ls_slip_date, ls_acct_date, ls_acct_code_tmp

//월계 계산...
DECLARE	foreign_cur CURSOR FOR
SELECT	SUM(A.SLIP_AMT), 		A.SLIP_DATE, 	A.SLIP_NO, A.SLIP_SEQ, D.ACCT_DATE
FROM		FNDB.HFN202M A, (
			SELECT	DISTINCT B.ACCT_CLASS, B.SLIP_DATE, B.SLIP_NO, C.ACCT_DATE
			FROM		FNDB.HFN202M B, FNDB.HFN201M C
			WHERE		B.ACCT_CLASS 				= 	C.ACCT_CLASS
			AND		B.SLIP_DATE 				= 	C.SLIP_DATE
			AND		B.SLIP_NO 					= 	C.SLIP_NO
			AND		DECODE(:II_ACCT_CLASS,0,0,B.ACCT_CLASS) = :II_ACCT_CLASS
			AND		C.BDGT_YEAR 				= 	:AS_BDGT_YEAR
			AND		C.ACCT_DATE 				between :as_strdate and :as_enddate
			AND		C.STEP_OPT 					= 	5
			AND		C.SLIP_CLASS				=  3							/* 대체... */
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'D' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'C' 
GROUP BY A.SLIP_DATE, A.SLIP_NO, A.SLIP_SEQ,	D.ACCT_DATE ;
open foreign_cur ;
do while true 
	fetch next foreign_cur into :ldc_acct_month_amt,	:ls_slip_date,	:li_slip_no, :li_slip_seq, :ls_acct_date ;
	if sqlca.sqlcode <> 0 then exit
	
	if isnull(ldc_acct_month_amt) then ldc_acct_month_amt = 0 

	if ldc_acct_month_amt <> 0 then
	
		//지출출력할 경우 계정을 서로 바꿔야 함.
		if as_slip_class = '2' then
			ls_acct_code_tmp 	= as_acct_code2
			as_acct_code2 		= as_acct_code1
			as_acct_code1 		= ls_acct_code_tmp
	
			//전표순번...
			SELECT	NVL(SLIP_SEQ,0)
			INTO		:li_slip_seq2
			FROM		FNDB.HFN202M
			WHERE		DECODE(:II_ACCT_CLASS,0,0,ACCT_CLASS) = :II_ACCT_CLASS
			AND		SLIP_DATE					=	:ls_slip_date
			AND		SLIP_NO						=	:li_slip_no
			AND		SUBSTR(ACCT_CODE,1,4) 	= 	:as_acct_code2	;
			
			li_slip_seq = li_slip_seq2
		end if

		//계정 금액 insert...
		ll_row = dw_print.insertrow(0)
		
		dw_print.setItem(ll_row, 'com_acct_code', 	AS_ACCT_CODE1+'00')
		dw_print.setItem(ll_row, 'com_acct_name', 	f_get_acctname('0', AS_ACCT_CODE1+'00'))
		dw_print.setItem(ll_row, 'com_mok_code', 		AS_ACCT_CODE1+'00')
		dw_print.setItem(ll_row, 'com_mok_name', 		f_get_acctname('0', AS_ACCT_CODE1+'00'))
		if as_slip_class = '1' then
			dw_print.setItem(ll_row, 'com_drcr_class', 	'C')
		else
			dw_print.setItem(ll_row, 'com_drcr_class', 	'D')
		end if
		dw_print.setItem(ll_row, 'com_acct_date', 	ls_acct_date)
		dw_print.setItem(ll_row, 'com_slip_date', 	ls_slip_date)
		dw_print.setItem(ll_row, 'com_slip_no', 		li_slip_no)
		dw_print.setItem(ll_row, 'com_slip_seq', 		li_slip_seq)
		dw_print.setItem(ll_row, 'com_remark', 		f_get_acctname('0', AS_ACCT_CODE2+'00')+' 대체 금액')
		if as_slip_class = '1' then
			dw_print.setItem(ll_row, 'com_dr_amt', 		0)
			dw_print.setItem(ll_row, 'com_cr_amt', 		ldc_acct_month_amt)
		else
			dw_print.setItem(ll_row, 'com_dr_amt', 		ldc_acct_month_amt)
			dw_print.setItem(ll_row, 'com_cr_amt', 		0)
		end if
		dw_print.setItem(ll_row, 'a_sort', 				'1')
		
	end if
	
loop
close foreign_cur ;

//if isnull(ldc_acct_month_amt) or ldc_acct_month_amt = 0 then return

//전월이월 계산...
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
			AND		C.ACCT_DATE 				< 	:as_strdate
			AND		C.STEP_OPT 					= 	5
			AND		C.SLIP_CLASS				=  3							/* 대체... */
			AND		SUBSTR(B.ACCT_CODE,1,4) = 	:AS_ACCT_CODE1
			AND		B.DRCR_CLASS 				= 	'D' ) D
WHERE		A.ACCT_CLASS 				= D.ACCT_CLASS
AND		A.SLIP_DATE 				= D.SLIP_DATE
AND		A.SLIP_NO 					= D.SLIP_NO
AND		DECODE(:II_ACCT_CLASS,0,0,A.ACCT_CLASS) = :II_ACCT_CLASS
AND		SUBSTR(A.ACCT_CODE,1,4) = :AS_ACCT_CODE2
AND		A.DRCR_CLASS 				= 'C' ;

if isnull(ldc_acct_amt) or ldc_acct_amt = 0 then return

if ldc_acct_amt <> 0 then
	
	//지출출력할 경우 계정을 서로 바꿔야 함.
	if as_slip_class = '2' then
		ls_acct_code_tmp 	= as_acct_code2
		as_acct_code2 		= as_acct_code1
		as_acct_code1 		= ls_acct_code_tmp
	end if

	// 원계정의 목계정에서 금액을 감산
	ll_row = dw_print.find("com_acct_date = '"+left(as_strdate,6)+"00"+"' and left(com_acct_code,4) = '"+as_acct_code1+"'", 1, dw_print.rowcount())
	
	if ll_row > 0 then
		if as_slip_class = '1' then
			if dw_print.getitemnumber(ll_row, 'com_cr_amt') > 0 then
				dw_print.setitem(ll_row, 'com_cr_amt', dw_print.getitemnumber(ll_row, 'com_cr_amt') - ldc_acct_amt)
			end if
		else
			if dw_print.getitemnumber(ll_row, 'com_dr_amt') > 0 then
				dw_print.setitem(ll_row, 'com_dr_amt', dw_print.getitemnumber(ll_row, 'com_dr_amt') - ldc_acct_amt)
			end if
		end if
	end if

end if


end subroutine

on w_hfn506p2.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_hfn506p2.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_open;call super::ue_open;//datawindowchild	ldw_child
//string 				ls_sys_date
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ddlb_gubun.selectitem(2)
//ddlb_gubun.triggerevent(selectionchanged!)
//ddlb_gubun.enabled = false
//
//ls_sys_date = f_today()
//
//em_fr_date.text = string(ls_sys_date, '@@@@/@@/@@')
//em_to_date.text = string(ls_sys_date, '@@@@/@@/@@')
//
end event

event ue_postopen;call super::ue_postopen;datawindowchild	ldw_child
string 				ls_sys_date


ii_acct_class = 1

dw_con.getchild('acct_code', ldw_child)
ldw_child.settransobject(sqlca)
ldw_child.reset()
ldw_child.retrieve('2')
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

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn506p2
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn506p2
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn506p2
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn506p2
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn506p2
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn506p2
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn506p2
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn506p2
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn506p2
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn506p2
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn506p2
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn506p2
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn506p2
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn506p2
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn506p2
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn506p2
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn506p2
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn506p2
boolean visible = false
integer x = 2903
integer y = 96
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn506p2
boolean visible = false
integer x = 1211
integer y = 20
integer width = 599
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn506p2
integer y = 292
integer taborder = 50
string dataobject = "d_hfn506p_3_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn506p2
string dataobject = "d_hfn506p2_con"
end type

event dw_con::constructor;call super::constructor;if gs_DeptCode = '2902' or gs_empcode = 'admin' then
	dw_con.object.all_printyn.visible = true
	dw_con.object.all_printyn[1] = 'Y'
else
	dw_con.object.all_printyn.visible = false
	dw_con.object.all_printyn[1] = 'N'
end if
end event

type cb_1 from uo_imgbtn within w_hfn506p2
integer x = 50
integer y = 36
integer taborder = 20
boolean bringtotop = true
string btnname = "Excel File"
end type

event constructor;call super::constructor;if gs_DeptCode = '2902' or gs_empcode = 'admin' then
	this.visible = true
else
	this.visible = false
end if

end event

event clicked;call super::clicked;string 	ls_docname, ls_named
integer 	li_value

li_value = GetFileSaveName("Select File", ls_docname, ls_named, "xls", "Excel Files (*.xls), *.xls")

if li_value = 1 then
	dw_print.saveas(ls_docname, Excel!, false)
end if


end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

