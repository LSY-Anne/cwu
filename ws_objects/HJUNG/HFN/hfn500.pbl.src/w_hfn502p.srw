$PBExportHeader$w_hfn502p.srw
$PBExportComments$대차대조표 출력(년결산용)
forward
global type w_hfn502p from w_hfn_print_form2
end type
type st_3 from statictext within w_hfn502p
end type
type em_bdgt_year from editmask within w_hfn502p
end type
end forward

global type w_hfn502p from w_hfn_print_form2
string title = "대차대조표 출력"
st_3 st_3
em_bdgt_year em_bdgt_year
end type
global w_hfn502p w_hfn502p

forward prototypes
public function integer wf_calc_proc ()
public subroutine wf_retrieve ()
public function boolean wf_yearmonth_chk (string as_bdgt_year)
end prototypes

public function integer wf_calc_proc ();// ------------------------------------------------------------------------------------------
// Function Name	: 	wf_calc_proc
// Function 설명	:	합계잔액시산표를 출력하기 위한 자료를 넣는다.
// Argument			:	
// Return			:	integer(sqlca.sqcode)
// ------------------------------------------------------------------------------------------

long		ll_rowcnt, i, j

string	ls_form_code, ls_acct_code, ls_form_name, ls_drcr_class
integer	li_location, li_calc_class, li_used_gbn
string	ls_used_gbn_1, ls_used_gbn_2, ls_used_gbn_3

// 시산표출력용 Table Clear....
delete	from	fndb.hfn901h
where		year_month	=	:is_yearmonth
and		form_class	=	:is_form_class
and		acct_class	=	:ii_acct_class	;

if sqlca.sqlcode <> 0 then return sqlca.sqlcode

li_used_gbn		=	integer(is_form_class)

// ==========================================================================================
// 출력위치 =	0	:	차변과 대변은 각각 sum 되어 amt1:차변금액, amt2:대변금액위치에 놓인다.
// 출력위치 =	11	:	차변과 대변은 각각 sum 되어 amt1:대변금액, amt2:차변금액위치에 놓인다.
// 출력위치 =	21	:	차변은 차변 - 대변, 대변은 대변 - 차변으로 계산해서 D:amt1, C:amt2위치에 놓인다.
// 출력위치 =	31	:	차대구분에 해당하는 금액이 amt1:차변금액, amt2:대변금액위치에 놓인다.
// ==========================================================================================
// ==========================================================================================
// 계정코드 이동 또는 범위계산(11) ===> 계정코드 From 부터 To 까지의 자료를 Insert 한다.
// ==========================================================================================
li_calc_class	=	11

insert	into	fndb.hfn901h
		(	year_month, acct_class, form_class, form_code, acct_code, form_name, 
			amt_1, amt_2, amt_3, amt_4,
			worker, ipaddr, work_date, 
			job_uid, job_add, job_date	)
select	:is_yearmonth, :ii_acct_class, :is_form_class, 
			form_code, acct_code, form_name,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)
								when		a.location	=	11
									then	nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)
								when		a.location	=	21	and	a.drcr_class	=	'D'
									then	(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)) - 
											(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'D'
									then	(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)) 
								else	0	
							end	
				from		fndb.hfn502h
				where		decode(:ii_acct_class, 0, :ii_acct_class, acct_class)	=	:ii_acct_class
				AND		bdgt_year	=	:is_bdgt_year
				and		acct_date	<= :is_enddate
				and		acct_code	>=	a.str_code
				and		acct_code	<=	a.end_code	)	as	amt_1,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)
								when		a.location	=	11
									then	nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)
								when		a.location	=	21	and	a.drcr_class	=	'C'
									then	(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)) - 
											(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'C'
									then	(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)) 
								else	0	
							end	
				from		fndb.hfn502h
				where		decode(:ii_acct_class, 0, :ii_acct_class, acct_class)	=	:ii_acct_class
				and		bdgt_year	=	:is_bdgt_year
				and		acct_date	<= :is_enddate
				and		acct_code	>=	a.str_code
				and		acct_code	<=	a.end_code	)	as	amt_2,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)
								when		a.location	=	11
									then	nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)
								when		a.location	=	21	and	a.drcr_class	=	'D'
									then	(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)) - 
											(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'D'
									then	(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)) 
								else	0	
							end	
				from		fndb.hfn502h
				where		decode(:ii_acct_class, 0, :ii_acct_class, acct_class)	=	:ii_acct_class
				and		bdgt_year	=	:is_bef_bdgt_year
				and		acct_date	<= :is_bef_enddate
				and		acct_code	>=	a.str_code
				and		acct_code	<=	a.end_code	)	as	amt_3,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)
								when		a.location	=	11
									then	nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)
								when		a.location	=	21	and	a.drcr_class	=	'C'
									then	(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)) - 
											(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'C'
									then	(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)) 
								else	0	
							end	
				from		fndb.hfn502h
				where		decode(:ii_acct_class, 0, :ii_acct_class, acct_class)	=	:ii_acct_class
				and		bdgt_year	=	:is_bef_bdgt_year
				and		acct_date	<= :is_bef_enddate
				and		acct_code	>=	a.str_code
				and		acct_code	<=	a.end_code	)	as	amt_4,
			:gs_empcode, :gs_ip, sysdate,
			:gs_empcode, :gs_ip, sysdate
from		acdb.hac006m a
where		substr(used_gbn, :ii_form_class, 1)	=	'9'	
and		acct_class	=	:ii_acct_class	
and		calc_class	=	:li_calc_class	;

if sqlca.sqlcode <> 0 then return sqlca.sqlcode


// ==========================================================================================
// 계정코드 계산(12) ===> 계정코드를 연산자에 의해서 계산한다.
// ==========================================================================================
string	ls_code[], ls_op[]
dec{0}	ldb_totamt, ldb_amt[], ldb_bef_totamt, ldb_bef_amt[]
dec{0}	ldb_dramt, ldb_cramt, ldb_bef_dramt, ldb_bef_cramt

li_calc_class	=	12
ll_rowcnt = dw_form.retrieve(li_used_gbn, ii_acct_class, li_calc_class)

for i = 1 to ll_rowcnt
	ls_form_code	= trim(dw_form.getitemstring(i, 'form_code'))
	ls_acct_code	= trim(dw_form.getitemstring(i, 'acct_code'))
	ls_form_name	= trim(dw_form.getitemstring(i, 'form_name'))
	ls_drcr_class	= trim(dw_form.getitemstring(i, 'drcr_class'))
	li_location		= dw_form.getitemnumber(i, 'location')
	ls_used_gbn_1	= trim(dw_form.getitemstring(i, 'used_gbn_1'))
	ls_used_gbn_2	= trim(dw_form.getitemstring(i, 'used_gbn_2'))
	ls_used_gbn_3	= trim(dw_form.getitemstring(i, 'used_gbn_3'))
	
	ls_code[1] 	= trim(dw_form.getitemstring(i, 'code1'))
	ls_code[2] 	= trim(dw_form.getitemstring(i, 'code2'))
	ls_code[3] 	= trim(dw_form.getitemstring(i, 'code3'))
	ls_code[4] 	= trim(dw_form.getitemstring(i, 'code4'))
	ls_code[5] 	= trim(dw_form.getitemstring(i, 'code5'))
	ls_op[1]		= trim(dw_form.getitemstring(i, 'op1'))
	ls_op[2] 	= trim(dw_form.getitemstring(i, 'op2'))
	ls_op[3]		= trim(dw_form.getitemstring(i, 'op3'))
	ls_op[4] 	= trim(dw_form.getitemstring(i, 'op4'))

	for j = 1 to 5
		ldb_amt[j] 		= 0
		ldb_bef_amt[i]	= 0
	next
	
	for j = 1 to 5
		if isnull(ls_code[j]) or trim(ls_code[j]) = '' then exit
		
		// 금년도 자료계산
		select	case
						when	substr(acct_code,1,1) in ('1', '4')
							then	(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)) - 
									(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0))
						else		(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)) - 
									(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0))
					end
		into		:ldb_amt[j]
		from		fndb.hfn502h
		where		decode(:ii_acct_class, 0, :ii_acct_class, acct_class)	=	:ii_acct_class
		and		bdgt_year	=	:is_bdgt_year
		and		acct_date	<= :is_enddate
		and		acct_code	=	:ls_code[j]	;

		if sqlca.sqlcode <> 0 then	ldb_amt[j] = 0

		// 전년도 자료계산
		select	case
						when	substr(acct_code, 2, 1) in ('1', '4')
							then	(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0)) - 
									(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0))
						else		(nvl(sum(cr_cash_amt), 0) + nvl(sum(cr_alt_amt), 0)) - 
									(nvl(sum(dr_cash_amt), 0) + nvl(sum(dr_alt_amt), 0))
					end
		into		:ldb_bef_amt[j]
		from		fndb.hfn502h a
		where		decode(:ii_acct_class, 0, :ii_acct_class, acct_class)	=	:ii_acct_class
		and		bdgt_year	=	:is_bef_bdgt_year
		and		acct_date	<= is_bef_enddate
		and		acct_code	=	:ls_code[j]	;

		if sqlca.sqlcode <> 0 then	ldb_bef_amt[j] = 0
	next
	
	ldb_totamt 		=	ldb_amt[1]
	ldb_bef_totamt	=	ldb_bef_amt[1]
	for j = 1 to 4
		if isnull(ls_op[j]) or trim(ls_op[j]) = '' then exit
		choose case ls_op[j]
			case	'+'
				ldb_totamt		=	ldb_totamt		+	ldb_amt[j + 1]
				ldb_bef_totamt =	ldb_bef_totamt	+	ldb_bef_amt[j + 1]
			case	'-'
				ldb_totamt		=	ldb_totamt 		-	ldb_amt[j + 1]
				ldb_bef_totamt	=	ldb_bef_totamt -	ldb_bef_amt[j + 1]
			case	'*'
				ldb_totamt		=	ldb_totamt 		*-	ldb_amt[j + 1]
				ldb_bef_totamt	=	ldb_bef_totamt *	ldb_bef_amt[j + 1]
			case	'/' 
				if ldb_amt[j + 1] <> 0 then
					ldb_totamt = 0
				else
					ldb_totamt = ldb_totamt / ldb_amt[j + 1]
				end if
				if ldb_bef_amt[j + 1] <> 0 then
					ldb_bef_totamt = 0
				else
					ldb_bef_totamt = ldb_bef_totamt / ldb_bef_amt[j + 1]
				end if
			case	else				
				ldb_totamt 		=	0
				ldb_bef_totamt	=	0
		end choose
	next	

	if ls_drcr_class = 'D' then
		ldb_dramt 		=	ldb_totamt
		ldb_cramt 		=	0
		ldb_bef_dramt	=	ldb_bef_totamt
		ldb_bef_cramt	=	0
	else
		ldb_dramt 		=	0
		ldb_cramt 		=	ldb_totamt
		ldb_bef_dramt	=	0
		ldb_bef_cramt	=	ldb_bef_totamt
	end if
		
	// 연산자에 의해서 계산된 자료를 Insert 한다.
	insert	into	fndb.hfn901h	
	(	year_month, acct_class, form_class, form_code, acct_code, form_name,
		amt_1, amt_2, amt_3, amt_4,
		worker, ipaddr, work_date, 
		job_uid, job_add, job_date	)
	values
	(	:is_yearmonth, :ii_acct_class, :is_form_class, :ls_form_code, :ls_acct_code, :ls_form_name,
		:ldb_dramt, :ldb_cramt, :ldb_bef_dramt, :ldb_bef_cramt,
		:gs_empcode, :gs_ip, sysdate,
		:gs_empcode, :gs_ip, sysdate	)	;
	
	if sqlca.sqlcode <> 0 then return sqlca.sqlcode
next


// ==========================================================================================
// 양식코드 계산(21) ===> 양식코드를 연산자에 의해서 계산한다.
// ==========================================================================================
li_calc_class	=	21
ll_rowcnt = dw_form.retrieve(li_used_gbn, ii_acct_class, li_calc_class)

for i = 1 to ll_rowcnt
	ls_form_code	= trim(dw_form.getitemstring(i, 'form_code'))
	ls_acct_code	= trim(dw_form.getitemstring(i, 'acct_code'))
	ls_form_name	= trim(dw_form.getitemstring(i, 'form_name'))
	ls_drcr_class	= trim(dw_form.getitemstring(i, 'drcr_class'))
	li_location		= dw_form.getitemnumber(i, 'location')
	ls_used_gbn_1	= trim(dw_form.getitemstring(i, 'used_gbn_1'))
	ls_used_gbn_2	= trim(dw_form.getitemstring(i, 'used_gbn_2'))
	ls_used_gbn_3	= trim(dw_form.getitemstring(i, 'used_gbn_3'))
	
	ls_code[1] 	= trim(dw_form.getitemstring(i, 'code1'))
	ls_code[2] 	= trim(dw_form.getitemstring(i, 'code2'))
	ls_code[3] 	= trim(dw_form.getitemstring(i, 'code3'))
	ls_code[4] 	= trim(dw_form.getitemstring(i, 'code4'))
	ls_code[5] 	= trim(dw_form.getitemstring(i, 'code5'))
	ls_op[1]		= trim(dw_form.getitemstring(i, 'op1'))
	ls_op[2] 	= trim(dw_form.getitemstring(i, 'op2'))
	ls_op[3]		= trim(dw_form.getitemstring(i, 'op3'))
	ls_op[4] 	= trim(dw_form.getitemstring(i, 'op4'))

	for j = 1 to 5
		ldb_amt[j] 		= 	0
		ldb_bef_amt[j]	=	0
	next
	
	for j = 1 to 5
		if isnull(ls_code[j]) or trim(ls_code[j]) = '' then exit
		
		// 금년도 자료
		select	case
						when	b.drcr_class = 'D'
							then	nvl(sum(a.amt_1), 0) - nvl(sum(a.amt_2), 0)
						else		nvl(sum(a.amt_2), 0) - nvl(sum(a.amt_1), 0)
					end
		into		:ldb_amt[j]
		from		fndb.hfn901h a, acdb.hac006m b
		where		a.form_class	= :is_form_class
		and		a.acct_class	= :ii_acct_class
		and		a.year_month	= :is_yearmonth
		and		a.form_code		= :ls_code[j]	
		and		substr(b.used_gbn, :ii_form_class, 1)	=	'9'	
		and		b.form_code		= a.form_code	
		group by b.drcr_class	;

		if sqlca.sqlcode <> 0 then	ldb_amt[j] = 0

		// 전년도 자료
		select	case
						when	b.drcr_class = 'D'
							then	nvl(sum(a.amt_3), 0) - nvl(sum(a.amt_4), 0)
						else		nvl(sum(a.amt_4), 0) - nvl(sum(a.amt_3), 0)
					end
		into		:ldb_bef_amt[j]
		from		fndb.hfn901h a, acdb.hac006m b
		where		a.form_class	= :is_form_class
		and		a.acct_class	= :ii_acct_class
		and		a.year_month	= :is_yearmonth
		and		a.form_code		= :ls_code[j]	
		and		substr(b.used_gbn, :ii_form_class, 1)	=	'9'	
		and		b.form_code		= a.form_code	
		group by b.drcr_class	;

		if sqlca.sqlcode <> 0 then	ldb_bef_amt[j] = 0
	next
	
	ldb_totamt 		= 	ldb_amt[1]
	ldb_bef_totamt	=	ldb_bef_amt[1]
	for j = 1 to 4
		if isnull(ls_op[j]) or trim(ls_op[j]) = '' then exit
		choose case ls_op[j]
			case	'+'
				ldb_totamt		=	ldb_totamt		+	ldb_amt[j + 1]
				ldb_bef_totamt =	ldb_bef_totamt	+	ldb_bef_amt[j + 1]
			case	'-'
				ldb_totamt		=	ldb_totamt 		-	ldb_amt[j + 1]
				ldb_bef_totamt	=	ldb_bef_totamt -	ldb_bef_amt[j + 1]
			case	'*'
				ldb_totamt		=	ldb_totamt 		*-	ldb_amt[j + 1]
				ldb_bef_totamt	=	ldb_bef_totamt *	ldb_bef_amt[j + 1]
			case	'/' 
				if ldb_amt[j + 1] <> 0 then
					ldb_totamt = 0
				else
					ldb_totamt = ldb_totamt / ldb_amt[j + 1]
				end if
				if ldb_bef_amt[j + 1] <> 0 then
					ldb_bef_totamt = 0
				else
					ldb_bef_totamt = ldb_bef_totamt / ldb_bef_amt[j + 1]
				end if
			case	else				
				ldb_totamt 		=	0
				ldb_bef_totamt	=	0
		end choose
	next	

	if ls_drcr_class = 'D' then
		ldb_dramt 		=	ldb_totamt
		ldb_cramt 		=	0
		ldb_bef_dramt	=	ldb_bef_totamt
		ldb_bef_cramt	=	0
	else
		ldb_dramt 		=	0
		ldb_cramt 		=	ldb_totamt
		ldb_bef_dramt	=	0
		ldb_bef_cramt	=	ldb_bef_totamt
	end if
		
	// 연산자에 의해서 계산된 자료를 Insert 한다.
	insert	into	fndb.hfn901h	
	(	year_month, acct_class, form_class, form_code, acct_code, form_name,
		amt_1, amt_2, amt_3, amt_4,
		worker, ipaddr, work_date, 
		job_uid, job_add, job_date	)
	values
	(	:is_yearmonth, :ii_acct_class, :is_form_class, :ls_form_code, :ls_acct_code, :ls_form_name,
		:ldb_dramt, :ldb_cramt, :ldb_bef_dramt, :ldb_bef_cramt,
		:gs_empcode, :gs_ip, sysdate,
		:gs_empcode, :gs_ip, sysdate	)	;
	
	if sqlca.sqlcode <> 0 then return sqlca.sqlcode
next

// ==========================================================================================
// 양식코드 가산(22) ===> 양식코드 From 부터 To 까지의 자료를 Insert 한다.
// ==========================================================================================
li_calc_class	=	22

insert	into	fndb.hfn901h
		(	year_month, acct_class, form_class, form_code, acct_code, form_name, 
			amt_1, amt_2, amt_3, amt_4,
			worker, ipaddr, work_date, 
			job_uid, job_add, job_date	)
select	:is_yearmonth, :ii_acct_class, :is_form_class, 
			form_code, acct_code, form_name,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(amt_1), 0)
								when		a.location	=	11
									then	nvl(sum(amt_2), 0)
								when		a.location	=	21	and	a.drcr_class	=	'D'
									then	(nvl(sum(amt_1), 0)) - (nvl(sum(amt_2), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'D'
									then	nvl(sum(amt_1), 0)
								else	0	
							end	
				from		fndb.hfn901h
				where		year_month	=	:is_yearmonth
				and		acct_class	=	:ii_acct_class
				and		form_class	=	:is_form_class
				and		form_code	>=	a.str_code
				and		form_code	<=	a.end_code	)	as	amt_1,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(amt_2), 0)
								when		a.location	=	11
									then	nvl(sum(amt_1), 0)
								when		a.location	=	21	and	a.drcr_class	=	'C'
									then	(nvl(sum(amt_2), 0)) - (nvl(sum(amt_1), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'C'
									then	nvl(sum(amt_2), 0)
								else	0	
							end	
				from		fndb.hfn901h
				where		year_month	=	:is_yearmonth
				and		acct_class	=	:ii_acct_class
				and		form_class	=	:is_form_class
				and		form_code	>=	a.str_code
				and		form_code	<=	a.end_code	)	as	amt_2,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(amt_3), 0)
								when		a.location	=	11
									then	nvl(sum(amt_4), 0)
								when		a.location	=	21	and	a.drcr_class	=	'D'
									then	(nvl(sum(amt_3), 0)) - (nvl(sum(amt_4), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'D'
									then	nvl(sum(amt_3), 0)
								else	0	
							end	
				from		fndb.hfn901h
				where		year_month	=	:is_yearmonth
				and		acct_class	=	:ii_acct_class
				and		form_class	=	:is_form_class
				and		form_code	>=	a.str_code
				and		form_code	<=	a.end_code	)	as	amt_3,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(amt_4), 0)
								when		a.location	=	11
									then	nvl(sum(amt_3), 0)
								when		a.location	=	21	and	a.drcr_class	=	'C'
									then	(nvl(sum(amt_4), 0)) - (nvl(sum(amt_3), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'C'
									then	nvl(sum(amt_4), 0)
								else	0	
							end	
				from		fndb.hfn901h
				where		year_month	=	:is_yearmonth
				and		acct_class	=	:ii_acct_class
				and		form_class	=	:is_form_class
				and		form_code	>=	a.str_code
				and		form_code	<=	a.end_code	)	as	amt_4,
			:gs_empcode, :gs_ip, sysdate,
			:gs_empcode, :gs_ip, sysdate
from		acdb.hac006m a
where		substr(used_gbn, :ii_form_class, 1)	=	'9'	
and		acct_class	=	:ii_acct_class	
and		calc_class	=	:li_calc_class	;

if sqlca.sqlcode <> 0 then return sqlca.sqlcode


// ==========================================================================================
// 양식코드 이동(23) ===> 양식코드 같은 자료를 Insert 한다.
// ==========================================================================================
li_calc_class	=	23

insert	into	fndb.hfn901h
		(	year_month, acct_class, form_class, form_code, acct_code, form_name, 
			amt_1, amt_2, amt_3, amt_4,
			worker, ipaddr, work_date, 
			job_uid, job_add, job_date	)
select	:is_yearmonth, :ii_acct_class, :is_form_class, 
			form_code, acct_code, form_name,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(amt_1), 0)
								when		a.location	=	11
									then	nvl(sum(amt_2), 0)
								when		a.location	=	21	and	a.drcr_class	=	'D'
									then	(nvl(sum(amt_1), 0)) - (nvl(sum(amt_2), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'D'
									then	nvl(sum(amt_1), 0)
								else	0	
							end	
				from		fndb.hfn901h
				where		year_month	=	:is_yearmonth
				and		acct_class	=	:ii_acct_class
				and		form_class	=	:is_form_class
				and		form_code	=	a.code1	)	as	amt_1,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(amt_2), 0)
								when		a.location	=	11
									then	nvl(sum(amt_1), 0)
								when		a.location	=	21	and	a.drcr_class	=	'C'
									then	(nvl(sum(amt_2), 0)) - (nvl(sum(amt_1), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'C'
									then	nvl(sum(amt_2), 0)
								else	0	
							end	
				from		fndb.hfn901h
				where		year_month	=	:is_yearmonth
				and		acct_class	=	:ii_acct_class
				and		form_class	=	:is_form_class
				and		form_code	=	a.code1	)	as	amt_2,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(amt_3), 0)
								when		a.location	=	11
									then	nvl(sum(amt_4), 0)
								when		a.location	=	21	and	a.drcr_class	=	'D'
									then	(nvl(sum(amt_3), 0)) - (nvl(sum(amt_4), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'D'
									then	nvl(sum(amt_3), 0)
								else	0	
							end	
				from		fndb.hfn901h
				where		year_month	=	:is_yearmonth
				and		acct_class	=	:ii_acct_class
				and		form_class	=	:is_form_class
				and		form_code	=	a.code1	)	as	amt_3,
			(	select	case
								when		a.location	=	0
									then	nvl(sum(amt_4), 0)
								when		a.location	=	11
									then	nvl(sum(amt_3), 0)
								when		a.location	=	21	and	a.drcr_class	=	'C'
									then	(nvl(sum(amt_4), 0)) - (nvl(sum(amt_3), 0)) 
								when		a.location	=	31 and	a.drcr_class	=	'C'
									then	nvl(sum(amt_4), 0)
								else	0	
							end	
				from		fndb.hfn901h
				where		year_month	=	:is_yearmonth
				and		acct_class	=	:ii_acct_class
				and		form_class	=	:is_form_class
				and		form_code	=	a.code1	)	as	amt_4,
			:gs_empcode, :gs_ip, sysdate,
			:gs_empcode, :gs_ip, sysdate
from		acdb.hac006m a
where		substr(used_gbn, :ii_form_class, 1)	=	'9'	
and		acct_class	=	:ii_acct_class	
and		calc_class	=	:li_calc_class	;

if sqlca.sqlcode <> 0 then return sqlca.sqlcode


return 0

end function

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능	:	Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_tab
integer	li_return, li_rtn

if not wf_yearmonth_chk(em_bdgt_year.text) then return

li_return = wf_calc_proc()

if li_return = 0 then
	commit	;
else	
	rollback	;
	f_messagebox('3', '전산실에 문의하세요.!~n~n' + sqlca.sqlerrtext)
	dw_print.reset()
	return
end if

dw_print.retrieve(is_yearmonth, is_bef_yearmonth, ii_acct_class, is_form_class, is_strdate, is_enddate, is_bef_strdate, is_bef_enddate)

end subroutine

public function boolean wf_yearmonth_chk (string as_bdgt_year);// ------------------------------------------------------------------------------------------
// Function Name	: 	wf_yearmonth_chk
// Function 설명	:	대차대조표를 출력하기 위한 자료를 넣는다.
// Argument			:	as_bdgt_year(회계년도)
// Return			:	true/false
// ------------------------------------------------------------------------------------------
string	ls_bdgt_year

// 회계년도에 해당하는 기간을 가져온다.
SELECT	BDGT_YEAR, FROM_DATE, TO_DATE
INTO		:IS_BDGT_YEAR,	:IS_STRDATE, :IS_ENDDATE
FROM		ACDB.HAC003M
WHERE		BDGT_YEAR  = :AS_BDGT_YEAR
AND		BDGT_CLASS = 0
AND		STAT_CLASS = 0 ;

if sqlca.sqlcode <> 0 then
	messagebox('확인', '회계년도의 설정이 올바르지 않습니다.')
	return false
end if

ls_bdgt_year = string(integer(as_bdgt_year) - 1)

// 전년도 회계년도에 해당하는 기간을 가져온다.
SELECT	BDGT_YEAR, FROM_DATE, TO_DATE
INTO		:IS_BEF_BDGT_YEAR,	:IS_BEF_STRDATE,	:IS_BEF_ENDDATE
FROM		ACDB.HAC003M
WHERE		BDGT_YEAR  = :LS_BDGT_YEAR
AND		BDGT_CLASS = 0 
AND		STAT_CLASS = 0 ;

if sqlca.sqlcode <> 0 then
	messagebox('확인', '전년도 회계년도의 설정이 올바르지 않습니다.')
	return false
end if

is_yearmonth 	  = is_bdgt_year + '99'
is_bef_yearmonth = is_bef_bdgt_year + '99'
is_trandate  	  = is_bdgt_year + '0000'
is_bef_trandate  = is_bef_bdgt_year + '0000'

return true
end function

on w_hfn502p.create
int iCurrent
call super::create
this.st_3=create st_3
this.em_bdgt_year=create em_bdgt_year
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.em_bdgt_year
end on

on w_hfn502p.destroy
call super::destroy
destroy(this.st_3)
destroy(this.em_bdgt_year)
end on

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
string	ls_sysdate

ls_sysdate = f_today()

uo_slip_class.uf_enabled(false)

em_bdgt_year.text = mid(ls_sysdate,1,4)

is_form_class	=	'3'
ii_form_class	=	integer(is_form_class)


end event

type dw_form from w_hfn_print_form2`dw_form within w_hfn502p
integer x = 2427
integer y = 1196
end type

type st_11 from w_hfn_print_form2`st_11 within w_hfn502p
boolean visible = false
integer x = 1207
integer y = 1004
end type

type ddlb_acct_class from w_hfn_print_form2`ddlb_acct_class within w_hfn502p
boolean visible = false
integer x = 1513
integer y = 988
end type

type uo_slip_class from w_hfn_print_form2`uo_slip_class within w_hfn502p
boolean visible = false
integer x = 2190
integer y = 652
boolean enabled = false
end type

type uo_acct_class from w_hfn_print_form2`uo_acct_class within w_hfn502p
integer x = 1001
integer y = 768
end type

type uo_year from w_hfn_print_form2`uo_year within w_hfn502p
boolean visible = false
integer x = 2030
integer y = 80
end type

type dw_print from w_hfn_print_form2`dw_print within w_hfn502p
integer height = 2272
string dataobject = "d_hfn502p_1"
end type

type st_3 from statictext within w_hfn502p
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
string text = "회계년도"
boolean focusrectangle = false
end type

type em_bdgt_year from editmask within w_hfn502p
integer x = 315
integer y = 80
integer width = 293
integer height = 92
integer taborder = 100
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
string mask = "yyyy"
boolean spin = true
end type

