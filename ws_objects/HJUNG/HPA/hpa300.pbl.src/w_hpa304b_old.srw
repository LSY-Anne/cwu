$PBExportHeader$w_hpa304b_old.srw
$PBExportComments$월 세금계산 생성(전체/학과별 생성)
forward
global type w_hpa304b_old from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type rb_1 from radiobutton within w_hpa304b_old
end type
type rb_2 from radiobutton within w_hpa304b_old
end type
type hpb_1 from hprogressbar within w_hpa304b_old
end type
type st_status from statictext within w_hpa304b_old
end type
type cb_1 from commandbutton within w_hpa304b_old
end type
type gb_1 from groupbox within w_hpa304b_old
end type
type gb_4 from groupbox within w_hpa304b_old
end type
type dw_list002 from cuo_dwwindow within w_hpa304b_old
end type
type dw_list003 from cuo_dwwindow within w_hpa304b_old
end type
type pb_1 from picturebutton within w_hpa304b_old
end type
type uo_yearmonth from cuo_yearmonth within w_hpa304b_old
end type
type uo_dept_code from cuo_dept within w_hpa304b_old
end type
type st_2 from statictext within w_hpa304b_old
end type
type st_1 from statictext within w_hpa304b_old
end type
type dw_head from datawindow within w_hpa304b_old
end type
type st_3 from statictext within w_hpa304b_old
end type
type em_per from editmask within w_hpa304b_old
end type
type st_4 from statictext within w_hpa304b_old
end type
type cbx_1 from checkbox within w_hpa304b_old
end type
type cbx_2 from checkbox within w_hpa304b_old
end type
type cbx_3 from checkbox within w_hpa304b_old
end type
type cbx_4 from checkbox within w_hpa304b_old
end type
type cbx_5 from checkbox within w_hpa304b_old
end type
type dw_list004 from datawindow within w_hpa304b_old
end type
type em_pay_date from editmask within w_hpa304b_old
end type
type uo_insa from cuo_insa_member within w_hpa304b_old
end type
end forward

global type w_hpa304b_old from w_tabsheet
integer width = 4041
integer height = 2724
string title = "월 세금계산 생성"
event type long ue_check_option ( )
rb_1 rb_1
rb_2 rb_2
hpb_1 hpb_1
st_status st_status
cb_1 cb_1
gb_1 gb_1
gb_4 gb_4
dw_list002 dw_list002
dw_list003 dw_list003
pb_1 pb_1
uo_yearmonth uo_yearmonth
uo_dept_code uo_dept_code
st_2 st_2
st_1 st_1
dw_head dw_head
st_3 st_3
em_per em_per
st_4 st_4
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
dw_list004 dw_list004
em_pay_date em_pay_date
uo_insa uo_insa
end type
global w_hpa304b_old w_hpa304b_old

type variables
datawindowchild	idw_child
datawindow			idw_mast, idw_data,  idw_item

string	is_yearmonth
string	is_dept_code
string	is_item1	=	'51'				// 소득세 코드
string	is_item2 =	'52'				// 주민세 코드
string	is_item3 =	'53'				// 사학연금
string	is_item4 =	'54'				// 의료보험료


string	is_pay_date
string	is_date_gbn						// 명절구분(1=평월, 2=명절)

string	is_member_no, is_code, is_name, is_today
integer	ii_excepte_gbn, ii_sort
dec{0}	idb_amt, idb_nontax_amt

integer	ii_str_jikjong, ii_end_jikjong
end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_insert ()
public function integer wf_create ()
public function integer wf_retrieve ()
end prototypes

event type long ue_check_option();////////////////////////////////////////////////////////
// 1. 기준년원 체크
////////////////////////////////////////////////////////
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
if is_yearmonth = '' or isnull(is_yearmonth) then
		f_messagebox('1', st_2.text + '를 정확히 입력해 주시기 바랍니다.!')
		return -1
end if
is_pay_date = is_yearmonth + right(em_pay_date.text, 2)
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')
////////////////////////////////////////////////////////
// 2. 부서학과명 체크
is_dept_code = uo_dept_code.uf_getcode()
////////////////////////////////////////////////////////
// 3. 지급일자체크
////////////////////////////////////////////////////////
date		ldt_pay_date
string	ls_bef_date

ls_bef_date	=	 em_pay_date.text

if em_pay_date.getdata(ldt_pay_date) < 0 then
	f_messagebox('1', st_2.text + '를 정확히 입력해 주시기 바랍니다.!')
	em_pay_date.text = ls_bef_date
	is_pay_date = ''
end if

is_pay_date	=	string(ldt_pay_date, 'yyyymmdd')
/////////////////////////////////////////////////////////
// 4. 직종명 체크
/////////////////////////////////////////////////////////

IF dw_head.rowcount() > 0 then
	ii_str_jikjong = integer(dw_head.object.code[1])
end if
if isnull(ii_str_jikjong) or ii_str_jikjong = 0 then	
	ii_str_jikjong	=	0
	ii_end_jikjong	=	9
else
	ii_str_jikjong = ii_str_jikjong
	ii_end_jikjong = ii_str_jikjong
end if


return 0
end event

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 항목구분
idw_data.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if


end subroutine

public function integer wf_insert ();// ==========================================================================================
// 기    능 : 	개인별 월 지급에 insert
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_insert()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long	ll_row

// 개인별 급여지급내역에 Insert...//


if idb_amt = 0 and idb_nontax_amt = 0	then	return	0

Insert	into	padb.hpa005d_20051123	
	(	member_no, year_month, chasu, code, item_name, pay_date, pay_amt, nontax_amt, retro_amt,excepte_gbn, sort, contents, remark, 
		worker, work_date, ipaddr, job_uid, job_add, job_date	)	
values(
		:is_member_no, :is_yearmonth, '5', :is_code, :is_name, :is_pay_date, :idb_amt, :idb_nontax_amt, 0,:ii_excepte_gbn, :ii_sort, '', '', 
		:gs_empcode, sysdate, :gs_ip, :gs_empcode, :gs_ip, sysdate	)	;
	
return	sqlca.sqlcode
end function

public function integer wf_create ();string	ls_year, ls_gubun, ls_str_yymm, ls_end_yymm, ls_mes, ls_member
string 	ls_chasu
long		ll_count
integer	li_str_month, li_c, li_curr_month, li_jaejik_opt
double   ldb_overtime_amt
li_curr_month	=	integer(right(is_yearmonth, 2))

if cbx_1.checked then
	ls_chasu = '1'
elseif cbx_2.checked then
	ls_chasu = '2'
elseif cbx_3.checked then
	ls_chasu = '3'
elseif cbx_4.checked then
	ls_chasu = '4'
elseif cbx_5.checked then
	ls_chasu = '5'
end if
if cbx_1.checked and cbx_2.checked and cbx_3.checked and cbx_4.checked and cbx_5.checked then
	ls_chasu = '%'
end if

ls_member = uo_insa.is_MemberNo
If isnull(ls_member)  Then ls_member = ''
if	f_getconfirm(ls_chasu, is_yearmonth, 'Y')	>	0	then	return	100

//============================== 상여해당월을 구한다.===================================//

//select	decode(substr(pay_month, :li_curr_month, 1), '1', instr(substr(pay_month, 1, :li_curr_month), '1', -1, 2) + 1, 0)
//into		:li_str_month
//from		padb.hpa003m
//where		code	=	'03'	;

//messagebox('',ls_pay_month +'/'+string(li_curr_month)+'/'+string(li_str_month))

if sqlca.sqlcode <> 0 then	li_str_month = 0

st_status.text = '세금계산 생성 준비중 입니다. 잠시만 기다려주시기 바랍니다!...'

wf_retrieve()

// 월지급급여가 있는지 확인한다.
if idw_mast.rowcount() < 1 then
	f_messagebox('1', '월 지급급여가 존재하지 않습니다.~n~n월 지급급여를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if

// 세금계산자료가 있는지 확인한다.
if idw_data.retrieve(is_yearmonth, is_dept_code, is_item1, is_item2, ii_str_jikjong, ii_end_jikjong, ls_member) > 0 then
	if f_messagebox('2', '해당년월의 세금계산이 완료된 상태입니다. 자료를 삭제 후 생성하시겠습니까?') <> 1 then return	100
	
	delete	from	padb.hpa005d_20051123
	where		year_month	=	:is_yearmonth
	and		code			in	('51', '52')
	and      chasu       = '5'
	and		member_no	in	(	select	member_no
										from		padb.hpa001m
										where		year_month		=		padb.hpa005d_20051123.year_month
										and		gwa				like	:is_dept_code	||	'%'
										and		member_no		like	:ls_member||'%'
										and		jikjong_code	>=		:ii_str_jikjong
										and		jikjong_code	<=		:ii_end_jikjong	)	;

	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

end if

dec{0}	ldb_sub_income, ldb_sub_income2, ldb_sub_income3, ldb_sub_income4, ldb_sub_income5, ldb_sub_income_max
dec{0}   ldb_acc1, ldb_acc2, ldb_acc3, ldb_acc4, ldb_acc5
dec{0}	ldb_sub_basic, ldb_sub_addition, ldb_sub_add1, ldb_sub_add2, ldb_sub_standard
dec{0}	ldb_sub_labor1, ldb_sub_labor2, ldb_sub_labor_max
dec{0}	ldb_etc1, ldb_etc2, ldb_etc3
dec{0}	ldb_medical_limit_amt, ldb_card_limit_amt, ldb_pension_indi_limit_amt, ldb_pension_limit_amt
dec		ldb_sub_rate1, ldb_sub_rate2, ldb_sub_rate3, ldb_sub_rate4, ldb_sub_rate5, ldb_sub_labor_rate1, ldb_sub_labor_rate2
integer	li_month = 12

// 세금계산 기준세율표 Retrieve(padb.hpa013m)
ls_year	=	left(is_yearmonth, 4)

// 세금공제기준 Retrieve(padb.hpa014m)
select	sub_income, 
			sub_rate1, 
			acc_sub1,
			sub_income2, 
			sub_rate2, 
			acc_sub2,
			sub_income3, 
			sub_rate3, 
			acc_sub3,
			sub_income4, 
			sub_rate4, 
			acc_sub4,
			sub_income5, 
			sub_rate5, 
			acc_sub5,
			sub_income_max,
			sub_basic, 
			sub_addition, 
			sub_add1, 
			sub_add2, 
			sub_standard, 
			sub_labor1, 
			sub_labor_rate1, 
			sub_labor2, 
			sub_labor_rate2, 
			sub_labor_max, 
			etc1, 
			etc2, 
			etc3,
		   medical_limit_amt,
			constribution_limit_amt,
			pension_indi_limit_amt,
			pension_limit_amt
into		:ldb_sub_income, :ldb_sub_rate1, :ldb_acc1, :ldb_sub_income2, :ldb_sub_rate2, :ldb_acc2,
			:ldb_sub_income3, :ldb_sub_rate3, :ldb_acc3,:ldb_sub_income4, :ldb_sub_rate4, :ldb_acc4,
			:ldb_sub_income5, :ldb_sub_rate5,:ldb_acc5, :ldb_sub_income_max,
			:ldb_sub_basic, :ldb_sub_addition, :ldb_sub_add1, :ldb_sub_add2, :ldb_sub_standard, 
			:ldb_sub_labor1, :ldb_sub_labor_rate1, :ldb_sub_labor2, :ldb_sub_labor_rate2, :ldb_sub_labor_max, 
			:ldb_etc1, :ldb_etc2, :ldb_etc3,
			:ldb_medical_limit_amt, :ldb_card_limit_amt, :ldb_pension_indi_limit_amt, :ldb_pension_limit_amt
from		padb.hpa014m
where		sub_year	=	:ls_year	;

 

if sqlca.sqlcode = 100 then
	f_messagebox('1', '세금공제기준 자료가 존재하지 않습니다.~n~n확인 후 다시 처리해 주시기 바랍니다.!')
	return	100
elseif sqlca.sqlcode <> 0 then
	return	sqlca.sqlcode
end if

ll_count = idw_mast.rowcount()		// 급여기초자료 Count

// Process Bar Setting
hpb_1.setrange(1, ll_count + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0

// 자료 생성 Start.....
long		ll_cnt1
integer	li_wife_num, li_support_20, li_support_60, li_handycap, li_old_num
string	ls_woman
dec{0}	ldb_amt_sum	= 0, ldb_nontax_sum = 0, ldb_contribution = 0, ldb_pension = 0, ldb_income = 0, ldb_injuk = 0, ldb_special = 0
dec{0}	ldb_amt = 0, ldb_gibon = 0, ldb_add = 0, ldb_sosuadd = 0, ldb_standard = 0, ldb_gwasae = 0, ldb_sanchul = 0, ldb_incomesae = 0
integer	li_gibon_num =	0
dec{0}	ldb_1cha_amt, ldb_2cha_amt, ldb_3cha_amt, ldb_4cha_amt, ldb_5cha_amt, ldb_medi_amt = 0, ldb_stand
dec{0}	ldb_gongje_amt[2]
integer	li_gongje_sort[2]

setpointer(hourglass!)

st_status.text = '세금 계산 생성중 입니다!...'

idw_data.reset()

// 급여기초자료 Loop
for ll_cnt1	= 1 to ll_count
	ldb_amt_sum			 =	0
	ldb_nontax_sum		 =	0
	ldb_contribution	 =	0
	ldb_pension        =	0
	ldb_medi_amt		 =	0			 
	ldb_income			 =	0
	ldb_injuk			 =	0
	ldb_special			 =	0
	ldb_amt				 =	0
	ldb_gibon			 =	0
	ldb_add				 =	0
	ldb_sosuadd			 =	0
	ldb_standard		 =	0
	ldb_gwasae			 =	0
	ldb_sanchul			 =	0
	ldb_incomesae		 =	0
	li_gibon_num		 =	0

	is_member_no		  =	idw_mast.getitemstring(ll_cnt1, 'member_no')
	li_wife_num			  =	idw_mast.getitemnumber(ll_cnt1, 'wife_num')
	li_support_20		  =	idw_mast.getitemnumber(ll_cnt1, 'support_20')
	li_support_60		  =	idw_mast.getitemnumber(ll_cnt1, 'support_60')
	li_handycap			  =	idw_mast.getitemnumber(ll_cnt1, 'handycap')
	li_old_num		  	  =	idw_mast.getitemnumber(ll_cnt1, 'old_num')
	ls_woman				  =	idw_mast.getitemstring(ll_cnt1, 'woman')
	ldb_contribution	  =	idw_mast.getitemnumber(ll_cnt1, 'contribution')
	ldb_amt_sum			  =	idw_mast.getitemnumber(ll_cnt1, 'amt_sum')
	ldb_nontax_sum		  =	idw_mast.getitemnumber(ll_cnt1, 'nontax_sum')
	ldb_pension         =	idw_mast.getitemnumber(ll_cnt1, 'insure_pension')
//	ldb_medi_amt        =	idw_mast.getitemnumber(ll_cnt1, 'medi_amt')
	li_jaejik_opt		  =	idw_mast.getitemnumber(ll_cnt1, 'jaejik_opt')
	
	// 퇴직예정자는 세금이 없다.
	if li_jaejik_opt	=	2 then	continue
	
	// ==========================================================================================
	// 1.	과세대상 근로소득(A)(ldb_amt) = 총급여액 - 비과세소득
	// 상여월일경우 (상여 + 지급대상기간의 상여이외의 급여) / 지급대상기간의 월수
	// ==========================================================================================
	
	if li_str_month = 0 then
		ldb_amt	=	ldb_amt_sum - ldb_nontax_sum
	else
//		ls_str_yymm	=	left(is_yearmonth, 4) + string(li_str_month, '00')
//		
//		integer	li_member_cnt
//		
//		select	count(*)
//		into		:li_member_cnt
//		from		padb.hpa001m
//		where		year_month	>=	:ls_str_yymm
//		and		year_month	<=	:is_yearmonth
//		and		member_no	=	:is_member_no	;
//		
//		if sqlca.sqlcode <> 0 	then	li_member_cnt = 0
//
//		select	trunc((sum(a.pay_amt) - sum(a.nontax_amt)) / (:li_member_cnt), 0) 
//		into		:ldb_amt
//		from		padb.hpa005d a, padb.hpa003m b
//		where		year_month	>=	:ls_str_yymm
//		and		year_month	<=	:is_yearmonth
//		and		member_no	=	:is_member_no
//		and		b.pay_opt	=	'1'
//		and		b.trans_gbn	=	'9'
//		and		a.code		=	b.code	;
//		
//		if sqlca.sqlcode <> 0 then	ldb_amt = 0
		
	 end if

//	messagebox('상여월계산', li_member_cnt)
//	messagebox('상여월계산', ls_str_yymm)
//	messagebox('상여월계산', is_yearmonth)

//if is_member_no = 'F0057'  then
//	messagebox('급여', ldb_amt_sum)
//	messagebox('비과세', ldb_nontax_sum)
//	messagebox('과세소득', ldb_amt)
//end if

	// ==========================================================================================
	// 2.	근로소득 공제(B)(ldb_income)
	//		-	A <= 5,000,000 							: B = A
	//		-	5,000,000  < A <= 15,000,000 			: B = 5,000,000 + (A - 2,750,000) * 50%(총급여액*50%+2,750,000)
	//		-	15,000,000 < A <= 30,000,000 			: B = 9,750,000 + (A - 7,250,000) * 15%(총급여액*15%+7,250,000)
	//		-	30,000,000 < A <= 45,000,000 			: B = 12,000,000 + (A - 8,750,000) * 10%(총급여액*10%+8,750,000)
	//		-	A > 45,000,000								: B = 13,500,000 + (A - 45,000,000) * 5%(총급여액*5%+11,000,000)
	// ------------------------------------------------------------------------------------------
	//		-	A <= ldb_sub_income							: B = A
	//		-	ldb_sub_income  < A <= ldb_sub_income2	: B = ldb_sub_income + (A - ldb_sub_income) * (ldb_sub_rate2 / 100)
	//		-	ldb_sub_income2 < A <= ldb_sub_income3	: B = ((ldb_sub_income2 - ldb_sub_income) * ((100 - ldb_sub_rate3) / 100)) +
	//																		(A - ldb_sub_income2) * (ldb_sub_rate3 / 100)
	//		-	ldb_sub_income3 < A <= ldb_sub_income4	: B = ((ldb_sub_income4 - ldb_sub_income2) * ((100 - ldb_sub_rate4) / 100)) +
	//																		(A - ldb_sub_income3) * (ldb_sub_rate4 / 100)
	//		-	B > ldb_sub_income4		 					: B = ldb_sub_income4 + (A - ldb_sub_income4) * (ldb_sub_rate5 / 100)
	// ==========================================================================================
	// 월급여를 년으로 계산한다.
	ldb_amt = ldb_amt * 12
	if ldb_amt > ldb_sub_income	and ldb_amt <= ldb_sub_income2 then		//50%
		ldb_income =  ldb_acc2 + (ldb_amt - ldb_sub_income) * (ldb_sub_rate2 / 100)
	elseif ldb_amt > ldb_sub_income2 and ldb_amt <= ldb_sub_income3 then		//15%
		ldb_income =  ldb_acc3 + (ldb_amt - ldb_sub_income2) * (ldb_sub_rate3 / 100)
	elseif ldb_amt > ldb_sub_income3 and ldb_amt <= ldb_sub_income4 then		//10%
		ldb_income =  ldb_acc4 + (ldb_amt - ldb_sub_income3) * (ldb_sub_rate4 / 100)
	elseif ldb_amt > ldb_sub_income4 then			                            //5%
		ldb_income =  ldb_acc5 + (ldb_amt - ldb_sub_income4) * (ldb_sub_rate5 / 100)
	else
		ldb_income = ldb_amt		//100%
	end if	

//if is_member_no = 'F0057'  then
//	messagebox('총급여', ldb_amt)
// 	messagebox('근로소득공제', ldb_income)
//end if
	
	// ==========================================================================================
	// 3.	과세대상근로소득금액(ldb_income_tax_amt)	:	총급여(A) - 근로소득공제(B)
	// ==========================================================================================
	dec{0}	ldb_income_tax_amt
	
	ldb_income_tax_amt	=	ldb_amt - ldb_income

//messagebox('근로소득금액', ldb_income_tax_amt)	
	
	// ==========================================================================================
	//	4.	기본공제(C)(ldb_gibon)
	//		-	본인		: a = 1,000,000
	//		-	배우자	: b = 1,000,000
	//		-	부양가족	: c = 부양가족수 * 1,000,000
	//		-	C = a + b + c
	// ------------------------------------------------------------------------------------------
	//		-	본인		: a = ldb_sub_basic
	//		-	배우자	: b = li_wife_num * ldb_sub_basic
	//		-	부양가족	: c = (li_support_20 + li_support_60) * ldb_sub_basic
	//		-	C = a + b + c
	// ==========================================================================================
	ldb_gibon = ldb_sub_basic + (li_wife_num * ldb_sub_basic) + ((li_support_20 + li_support_60) * ldb_sub_basic)

//messagebox('배우자', li_wife_num)
//messagebox('부양가족20', li_support_20)
//messagebox('부양가족60', li_support_60)
//if is_member_no = 'F0057'  then
//	messagebox('기본공제', ldb_gibon)
//end if

	// ==========================================================================================
	//	5.	추가공제(D)(ldb_add)
	//		-	장애자			: a = 장애자수 * 1,000,000
	//		-	경로우대자		: b = 경로우대자수(65세이상) * 1,000,000
	//		-	부녀자세대주 	: c = 500,000
	//		-	D = a + b + c
	// ------------------------------------------------------------------------------------------
	//		-	장애자			: a = li_handycap * ldb_sub_addition
	//		-	경로우대자		: b = li_old_num * ldb_sub_addition
	//		-	부녀자세대주 	: c = ldb_sub_addition
	//		-	D = a + b + c
	// ==========================================================================================
	if li_handycap = 9 then
		li_handycap = 1
	else
		li_handycap = 0
	end if
	
	ldb_add = (li_handycap * ldb_sub_addition) + (li_old_num * ldb_sub_addition)
	if ls_woman = '9' then
		ldb_add += ldb_sub_addition
	end if

//if is_member_no = 'F0057'  then
//	messagebox('추가공제', ldb_add)
//end if

	// ==========================================================================================
	//	6.	소수공제자추가공제(E)(ldb_sosuadd)
	//		-	기본공제자수 = 1	: E = 1,000,000
	//		-	기본공제자수 = 2	: E = 500,000
	// ------------------------------------------------------------------------------------------
	//		-	기본공제자수 = 1	: E = ldb_sub_add1
	//		-	기본공제자수 = 2	: E = ldb_sub_add2
	// ==========================================================================================
	li_gibon_num = li_wife_num + li_support_20 + li_support_60 + 1
	if li_gibon_num = 1 then
		ldb_sosuadd = ldb_sub_add1
	elseif li_gibon_num = 2 then
		ldb_sosuadd = ldb_sub_add2
	end if

//if is_member_no = 'F0057' then
//	messagebox('소수공제자추가공제', ldb_sosuadd)
//end if

	// ==========================================================================================
	// 인적공제(ldb_injuk) = 기본공제 + 추가ldb_contribution공제 + 소수공제자추가공제
	// ==========================================================================================
	ldb_injuk	= ldb_gibon + ldb_add + ldb_sosuadd

//if is_member_no = 'F0057'  then
//	messagebox('인적공제', ldb_injuk)
//end if

   // ==========================================================================================
	// 사학연금(ldb_injuk) = 연금보험료공제 2004-01-30
	// ========================================================================================== 

   ldb_pension = ldb_pension * 12

//	messagebox('사학연금', ldb_pension)

	// ==========================================================================================
	// 8. 특별공제(ldb_special_amt) = 보험료공제 + 의료비공제 + 교육비공제 + 주택자금공제 + 기부금공제
	// 	특별공제(ldb_special) =  기부금공제(전액) - 월에서는 이것만 해준다.
	// ==========================================================================================
	ldb_special = ldb_contribution

//if is_member_no = 'F0057'  then
//	messagebox('특별공제', ldb_special)
//end if

	// ==========================================================================================
	//	1.	표준공제(G)(ldb_standard)
	//		-	특별공제 < 600,000	: G = 600,000
	//		-	특별공제 >= 600,000	: G = 0
	// ------------------------------------------------------------------------------------------
	//		-	ldb_special < ldb_sub_standard	: G = ldb_sub_standard
	//		-	ldb_special >= ldb_sub_standard	: G = 0
	// ==========================================================================================
	if ldb_special < ldb_sub_standard	then
		ldb_standard	=	ldb_sub_standard
	else
		ldb_standard	=	0
	end if

//	if li_gibon_num  <= 2 then
//		ldb_stand = 1200000
//	elseif li_gibon_num  >= 3 then
//		ldb_stand = 2400000
//	end if 
		
		
		
		
//if is_member_no = 'F0057'  then
//messagebox('표준공제22', ldb_stand)
//end if

	// ==========================================================================================
	//	10.	기타소득공제(ldb_etc_amt) = 개인연금저축소득공제 + 연금저축소득공제 + 투자조합출자소득공제 + 신용카드소득공제
	//	월에서는 계산하지 않는다.
	// ==========================================================================================

	// ==========================================================================================
	// 17.	과세표준 = (근로소득 - 근로소득공제) - (인적공제 + 특별공제 + 표준공제 + 기타소득공제)
	// 17.	과세표준(ldb_gwasae) 
	//			과세표준 = (총급여 - 근로소득공제) - 인적공제 - (특별공제 + 표준공제) - 연금보험료공제 - 기타소득공제)
	// ==========================================================================================
	if ldb_special > ldb_standard then
		ldb_gwasae = ldb_income_tax_amt - ldb_injuk - ldb_special 
	else
		ldb_gwasae = ldb_income_tax_amt - ldb_injuk - ldb_pension - ldb_stand
	end if	

	if ldb_gwasae <= 0 then	ldb_gwasae = 0

//if is_member_no = 'F0057'  then
//	messagebox('과세표준', ldb_gwasae)
//end if

	// ==========================================================================================
	// 18.	산출세액(ldb_sanchul)
	//			산출세액 = (과세표준(ldb_gwasae) * 과세표준 기준표에 의한 세율(ldb_tax_rate)) - 누진공제액
	// ==========================================================================================
	dec		ldb_rate
	dec{0}	ldb_tax_sum_amount
	
	ldb_rate	=	0.0
	ldb_tax_sum_amount	=	0

//	messagebox('세금전',ls_year + string(ldb_gwasae))
	
	select	nvl(tax_rate, 0) / 100.0, nvl(tax_sum_amt ,0)
	into		:ldb_rate, :ldb_tax_sum_amount
	from		padb.hpa013m
	where		tax_year			=	:ls_year
	and		tax_from_date 	<=	:ldb_gwasae
	and		tax_to_date	  	>=	:ldb_gwasae	;
	
	if sqlca.sqlcode = 100 then	
		f_messagebox('1', '세금계산 기준세율표 자료가 존재하지 않습니다.~n~n확인 후 다시 처리해 주시기 바랍니다.!')
		return	100
	elseif sqlca.sqlcode <> 0 then	
		return	sqlca.sqlcode
	end if
	
	ldb_tax_sum_amount	=	truncate(ldb_tax_sum_amount, 0)
	ldb_sanchul = 	truncate(ldb_gwasae * ldb_rate, 0) - ldb_tax_sum_amount
	
////if is_member_no = 'F0057'  then
//	messagebox('누진공제액', ldb_tax_sum_amount)
//	messagebox('비율', ldb_rate)
//	messagebox('산출세액', ldb_sanchul)
//end if

	// ==========================================================================================
	//	1.	근로소득세액공제(H)(ldb_incomesae)
	//		-	산출세액 <= 500,000	: H = 산출세액 * 45%
	//		-	산출세액 > 500,000	: H = (500,000 * 45%) + ((산출세액 - 500,000) * 30%))
	//		-	H > 600,000				: H = 600,000
	//		-	H <= 600,000			: H = H
	// ------------------------------------------------------------------------------------------
	//		-	ldb_product_tax_amt <= ldb_sub_labor1	: H = ldb_product_tax_amt * (ldb_sub_labor_rate1 / 100)
	//		-	ldb_product_tax_amt > ldb_sub_labor2	: H = (ldb_sub_labor1 * (ldb_sub_labor_rate1 / 100)) + 
	//																		((ldb_product_tax_amt - ldb_sub_labor2) * (ldb_sub_labor_rate2 / 100))
	//		-	H > ldb_sub_labor_max			: H = ldb_sub_labor_max
	//		-	H <= ldb_sub_labor_max			: H = H
	// ==========================================================================================
	if ldb_sanchul <= ldb_sub_labor1 then
		ldb_incomesae = truncate(ldb_sanchul * (ldb_sub_labor_rate1 / 100.0), 0)
	else
		ldb_incomesae = truncate((ldb_sub_labor1 * (ldb_sub_labor_rate1 / 100.0)), 0) + truncate(((ldb_sanchul - ldb_sub_labor2) * (ldb_sub_labor_rate2 / 100.0)), 0)
	end if		
	if ldb_incomesae > ldb_sub_labor_max then	ldb_incomesae = ldb_sub_labor_max

//if is_member_no = 'F0057'  then
//	messagebox('근로소득세액공제', ldb_incomesae)
//end if

	// ==========================================================================================
	// 결정세액 = 산출세액 - 근로소득세액공제
	// 소득세 = 결정세액
	// 상여월이면 비상여월의 소득세 + 주민세를 - 처리한다.
	// ==========================================================================================
	dec{0}	ldb_nontax

	idb_amt	= ldb_sanchul - ldb_incomesae

	if idb_amt < 0 then	idb_amt = 0
	
//	if li_str_month <> 0 then
//		ls_end_yymm	=	left(is_yearmonth, 4) + string(li_curr_month - 1, '00')
//		
//		select	nvl(sum(pay_amt), 0)
//		into		:ldb_nontax
//		from		padb.hpa005d
//		where		year_month	>=	:ls_str_yymm
//		and		year_month	<=	:ls_end_yymm
//		and		member_no	=	:is_member_no
//		and		code			in	(:is_item1, :is_item2)	;
//		
////	messagebox('상여월계산', ls_str_yymm)
////	messagebox('상여월계산', ls_end_yymm)
////	messagebox('상여월계산', is_item1)
////	messagebox('상여월계산', is_item2)
////	messagebox('상여월세금계산', ldb_nontax)
//		
//		if idb_amt > ldb_nontax then
//			idb_amt = idb_amt - ldb_nontax
//		end if
//	end if
//	messagebox('결정세액', idb_amt)

//////////////////////////////////////////////////////////////////////////////
// 비율에 따라 조정한다. 20030403/11:30분에 김미겸 선생이랑 최종확정된 사항임.
//////////////////////////////////////////////////////////////////////////////
	Dec{2}	ld_rate
	ld_rate	=	Dec(em_per.Text)

	idb_amt = truncate(idb_amt * ld_rate / 100 / 12 , 0)		//다시월로 계산해야 된다.
	idb_amt	= truncate(idb_amt / 10, 0) * 10
//if is_member_no = 'F0057'  then
//	messagebox('갑근세', idb_amt)
//end if

	select	code, rtrim(item_name), nvl(nontax_amt, 0), excepte_gbn, sort
	into		:is_code, :is_name, :idb_nontax_amt, :ii_excepte_gbn, :ii_sort
	from		padb.hpa003m
	where		code	=	:is_item1	;
	
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	// 원단위는 절사한다.	
	ldb_gongje_amt[1] =	truncate(idb_amt / 10, 0) * 10

	li_gongje_sort[1] =	ii_sort


	// 개인별 급여지급내역에 Insert...(소득세 Insert)
	if wf_insert() < 0 then	return	sqlca.sqlcode


	// ==========================================================================================
	// 주민세 = 소득세 * 10%
	// ==========================================================================================
	idb_amt	=	truncate(idb_amt * 0.1, 0)
	idb_amt	=	truncate(idb_amt / 10, 0) * 10		//	원단위는 절사한다.

	select	code, rtrim(item_name), nvl(nontax_amt, 0), excepte_gbn, sort
	into		:is_code, :is_name, :idb_nontax_amt, :ii_excepte_gbn, :ii_sort
	from		padb.hpa003m
	where		code	=	:is_item2	;
	
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
	ldb_gongje_amt[2] =	idb_amt
	li_gongje_sort[2] =	ii_sort

//	messagebox('wf_insert2', idb_amt)
	// 개인별 급여지급내역에 Insert...(주민세 Insert)
	if wf_insert() < 0 then	return	sqlca.sqlcode

	// 소득세/주민세 Update
	ls_mes	=	"	update	padb.hpa015m_20051123	"	+	&
					"	set		gongje_" + string(li_gongje_sort[1]) + " = " + string(ldb_gongje_amt[1])	+	",	"	+	&
					"				gongje_" + string(li_gongje_sort[2]) + " = " + string(ldb_gongje_amt[2])	+	" 	"	+	&
					"	where		year_month	=	'"	+	is_yearmonth	+	"'	"	+	&
					"	and		member_no	=	'"	+	is_member_no	+	"'	"
	
	clipboard(ls_mes)
	
	execute	immediate	:ls_mes	;
	
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
	hpb_1.position += 1
	st_status.text = string(ll_cnt1, '#,##0') + ' 건 세금 계산 생성중 입니다!...'
next

hpb_1.position += 1
SetPointer(Arrow!)

return	0

end function

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string ls_member
String	ls_chasu[5]
ls_chasu[1] = ''
ls_chasu[2] = ''
ls_chasu[3] = ''
ls_chasu[4] = ''
ls_chasu[5] = ''
if cbx_1.checked = true then ls_chasu[1] = '1'
if cbx_2.checked = true then ls_chasu[2] = '2'
if cbx_3.checked = true then ls_chasu[3] = '3'
if cbx_4.checked = true then ls_chasu[4] = '4'
if cbx_5.checked = true then ls_chasu[5] = '5'

ls_member = uo_insa.is_MemberNo
If isnull(ls_member)  Then ls_member = ''

idw_mast.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, ls_member, ls_chasu)
idw_data.retrieve(is_yearmonth, is_dept_code, is_item1, is_item2, ii_str_jikjong, ii_end_jikjong, ls_member)

return 0
end function

on w_hpa304b_old.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.hpb_1=create hpb_1
this.st_status=create st_status
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_4=create gb_4
this.dw_list002=create dw_list002
this.dw_list003=create dw_list003
this.pb_1=create pb_1
this.uo_yearmonth=create uo_yearmonth
this.uo_dept_code=create uo_dept_code
this.st_2=create st_2
this.st_1=create st_1
this.dw_head=create dw_head
this.st_3=create st_3
this.em_per=create em_per
this.st_4=create st_4
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.dw_list004=create dw_list004
this.em_pay_date=create em_pay_date
this.uo_insa=create uo_insa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.hpb_1
this.Control[iCurrent+4]=this.st_status
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.dw_list002
this.Control[iCurrent+9]=this.dw_list003
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.uo_yearmonth
this.Control[iCurrent+12]=this.uo_dept_code
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.dw_head
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.em_per
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.cbx_1
this.Control[iCurrent+20]=this.cbx_2
this.Control[iCurrent+21]=this.cbx_3
this.Control[iCurrent+22]=this.cbx_4
this.Control[iCurrent+23]=this.cbx_5
this.Control[iCurrent+24]=this.dw_list004
this.Control[iCurrent+25]=this.em_pay_date
this.Control[iCurrent+26]=this.uo_insa
end on

on w_hpa304b_old.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.hpb_1)
destroy(this.st_status)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.dw_list002)
destroy(this.dw_list003)
destroy(this.pb_1)
destroy(this.uo_yearmonth)
destroy(this.uo_dept_code)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_head)
destroy(this.st_3)
destroy(this.em_per)
destroy(this.st_4)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.dw_list004)
destroy(this.em_pay_date)
destroy(this.uo_insa)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		fALSE)

em_per.text	=	'100'

idw_mast	=	dw_list002
idw_data	=	dw_list003
idw_item	=	dw_list004

uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

uo_dept_code.uf_setdept('', '학과명')
is_dept_code	=	uo_dept_code.uf_getcode()

is_pay_date	=	is_yearmonth + '25'//f_today()
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')

f_getdwcommon(dw_head, 'jikjong_code', 0, 750)

wf_getchild()

cbx_1.checked = true
cbx_2.checked = true
cbx_3.checked = true
cbx_4.checked = true
cbx_5.checked = true


end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa304b_old
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa304b_old
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa304b_old
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa304b_old
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa304b_old
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa304b_old
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa304b_old
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa304b_old
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa304b_old
end type

type uc_save from w_tabsheet`uc_save within w_hpa304b_old
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa304b_old
end type

type uc_print from w_tabsheet`uc_print within w_hpa304b_old
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa304b_old
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa304b_old
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa304b_old
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa304b_old
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa304b_old
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa304b_old
boolean visible = false
integer y = 224
integer width = 3881
integer height = 2296
integer taborder = 60
tabpage_sheet02 tabpage_sheet02
end type

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer width = 3845
integer height = 2180
string text = "급여계산기준코드관리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 14
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

event dw_list001::clicked;call super::clicked;//String s_memberno
//IF row > 0 then
//	s_memberno = dw_list001.getItemString(row,'member_no')
//	dw_update101.retrieve(s_memberno)
//end IF
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
end type

type uo_tab from w_tabsheet`uo_tab within w_hpa304b_old
end type

type dw_con from w_tabsheet`dw_con within w_hpa304b_old
end type

type st_con from w_tabsheet`st_con within w_hpa304b_old
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3845
integer height = 2180
long backcolor = 79741120
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type rb_1 from radiobutton within w_hpa304b_old
boolean visible = false
integer x = 1298
integer y = 288
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "평월"
boolean checked = true
end type

event clicked;rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)

rb_1.underline	=	true
rb_2.underline	=	false

is_date_gbn	= '1'

//dw_dept_code.enabled	=	false
//dw_dept_code.object.code.background.color = 78682240
//is_dept_code	=	''
//
//rb_1.textcolor = rgb(0, 0, 255)
//rb_2.textcolor = rgb(0, 0, 0)
//
//rb_1.underline	=	true
//rb_2.underline	=	false
//
//parent.triggerevent('ue_retrieve')
//
end event

type rb_2 from radiobutton within w_hpa304b_old
boolean visible = false
integer x = 1641
integer y = 288
integer width = 494
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "명절(설날,추석)"
end type

event clicked;rb_2.textcolor = rgb(0, 0, 255)
rb_1.textcolor = rgb(0, 0, 0)

rb_2.underline	=	true
rb_1.underline	=	false

is_date_gbn	= '2'

//dw_dept_code.enabled	=	true
//dw_dept_code.object.code.background.color = rgb(255, 255, 255)
//is_dept_code	=	dw_dept_code.getitemstring(dw_dept_code.getrow(), 'code')
//
//dw_dept_code.setfocus()
//
//rb_1.textcolor = rgb(0, 0, 0)
//rb_2.textcolor = rgb(0, 0, 255)
//
//rb_1.underline	=	false
//rb_2.underline	=	true
//
//parent.triggerevent('ue_retrieve')
//
end event

type hpb_1 from hprogressbar within w_hpa304b_old
integer x = 50
integer y = 584
integer width = 3776
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_status from statictext within w_hpa304b_old
integer x = 64
integer y = 504
integer width = 3781
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "진행 상태..."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_hpa304b_old
event keypress pbm_keydown
boolean visible = false
integer x = 1701
integer y = 328
integer width = 370
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "처리"
end type

event keypress;if key = keyenter! then
	this.post event clicked()
end if
end event

event clicked;//string ls_year
//long   ll_count

end event

type gb_1 from groupbox within w_hpa304b_old
integer width = 3881
integer height = 420
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "생성조건"
end type

type gb_4 from groupbox within w_hpa304b_old
integer y = 424
integer width = 3881
integer height = 288
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "진행상태"
end type

type dw_list002 from cuo_dwwindow within w_hpa304b_old
event ue_syscommand pbm_syscommand
integer y = 720
integer width = 3881
integer height = 900
integer taborder = 70
boolean titlebar = true
string title = "월 세금계산 대상자 기초사항"
string dataobject = "d_hpa311b_1_20051123"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(false)
end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

selectrow(0, false)
selectrow(currentrow, true)

f_dw_find(this, idw_data, 'member_no')

end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

selectrow(0, false)
selectrow(1, true)

f_dw_find(idw_data, this, 'member_no')

end event

type dw_list003 from cuo_dwwindow within w_hpa304b_old
integer y = 1620
integer width = 3881
integer height = 900
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "월 세금 내역"
string dataobject = "d_hpa311b_2_20051123"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event un_unmove;call super::un_unmove;// Title Bar가 있으면서 DataWindow를 이동시킬 수 없다.

uint	lui_wordparm

//lui_wordparm = message.wordparm　 

lui_wordparm = 61456

CHOOSE CASE lui_wordparm
      CASE 61456, 61458
         message.processed = true
         message.returnvalue = 0
END CHOOSE

return


//// Title Bar가 있으면서 DataWindow를 이동시킬 수 없다.
//unsignedinteger	lui_wordparm
//lui_wordparm = message.wordparm　 
//CHOOSE CASE lui_wordparm
//      CASE 61456, 61458
//         message.processed = true
//         message.returnvalue = 0
//END CHOOSE
//return


end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

selectrow(0, false)
selectrow(currentrow, true)

f_dw_find(this, idw_mast, 'member_no')

end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

selectrow(0, false)
selectrow(1, true)

f_dw_find(idw_mast, this, 'member_no')

end event

event constructor;call super::constructor;this.uf_setClick(False)
end event

type pb_1 from picturebutton within w_hpa304b_old
integer x = 3250
integer y = 276
integer width = 480
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "   세금계산"
string picturename = "..\bmp\PROCES_E.BMP"
string disabledname = "..\bmp\PROCES_D.BMP"
vtextalign vtextalign = vcenter!
end type

event clicked;// 생성처리한다.
integer	li_rtn
long     ll_judge
   
	
	select count(*)
	  into :ll_judge
	  from padb.hpa021m 
	 where confirm_gbn = 9
		and year_month = :is_yearmonth
		and chasu      = '5';
//	messagebox('ll_judge', string(ll_judge))
	if sqlca.sqlcode <> 0 then return sqlca.sqlcode
   
	if ll_judge <> 0 then
		messagebox('','이미 확정처리가 되었습니다.')
	   return
   end if
	

setpointer(hourglass!)

IF NOT PARENT.TRIGGER EVENT ue_check_option() = 0 THEN RETURN 999

li_rtn	=	wf_create()

setpointer(arrow!)

if	li_rtn = 0 then
	commit	;
	parent.triggerevent('ue_retrieve')
	
	f_messagebox('1', string(idw_mast.rowcount()) + '건의 자료를 생성했습니다.!')
elseif li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
	parent.triggerevent('ue_retrieve')
end if

st_status.text = '진행 상태...'


end event

type uo_yearmonth from cuo_yearmonth within w_hpa304b_old
event destroy ( )
integer x = 14
integer y = 56
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yearmonth	=	this.uf_getyearmonth()
is_pay_date		=	is_yearmonth + '25'
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')

end event

type uo_dept_code from cuo_dept within w_hpa304b_old
event destroy ( )
integer x = 869
integer y = 48
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

on uo_dept_code.destroy
call cuo_dept::destroy
end on

type st_2 from statictext within w_hpa304b_old
integer x = 50
integer y = 156
integer width = 293
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
string text = "지급일자"
boolean focusrectangle = false
end type

type st_1 from statictext within w_hpa304b_old
integer x = 878
integer y = 156
integer width = 206
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
boolean enabled = false
string text = "직종명"
boolean focusrectangle = false
end type

type dw_head from datawindow within w_hpa304b_old
integer x = 1111
integer y = 140
integer width = 768
integer height = 104
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type st_3 from statictext within w_hpa304b_old
integer x = 1911
integer y = 156
integer width = 160
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
boolean enabled = false
string text = "비율"
boolean focusrectangle = false
end type

type em_per from editmask within w_hpa304b_old
integer x = 2048
integer y = 140
integer width = 347
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "###.00"
boolean spin = true
double increment = 10
string minmax = "80~~200"
end type

type st_4 from statictext within w_hpa304b_old
integer x = 2395
integer y = 148
integer width = 64
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
string text = "%"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_hpa304b_old
integer x = 2583
integer y = 40
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "1차 강의료"
end type

type cbx_2 from checkbox within w_hpa304b_old
integer x = 2583
integer y = 104
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "2차 연구보조비"
end type

type cbx_3 from checkbox within w_hpa304b_old
integer x = 2583
integer y = 164
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "3차 특별상여"
end type

type cbx_4 from checkbox within w_hpa304b_old
integer x = 3250
integer y = 40
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "4차 유사급여"
end type

type cbx_5 from checkbox within w_hpa304b_old
integer x = 3250
integer y = 104
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "5차 정상급여"
end type

type dw_list004 from datawindow within w_hpa304b_old
event ue_dwnkey pbm_dwnkey
boolean visible = false
integer x = 1019
integer y = 428
integer width = 1509
integer height = 512
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa301b_3_20051123"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type em_pay_date from editmask within w_hpa304b_old
integer x = 357
integer y = 140
integer width = 480
integer height = 84
integer taborder = 40
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
string mask = "yyyy/mm/dd"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "19000101~~29991231"
end type

type uo_insa from cuo_insa_member within w_hpa304b_old
integer x = 46
integer y = 228
integer width = 3067
integer height = 180
integer taborder = 130
boolean bringtotop = true
end type

on uo_insa.destroy
call cuo_insa_member::destroy
end on

