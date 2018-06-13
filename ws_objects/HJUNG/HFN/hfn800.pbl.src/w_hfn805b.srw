$PBExportHeader$w_hfn805b.srw
$PBExportComments$계산서/세금계산서 합계표 생성
forward
global type w_hfn805b from w_msheet
end type
type sle_i_d from singlelineedit within w_hfn805b
end type
type st_12 from statictext within w_hfn805b
end type
type sle_i_c from singlelineedit within w_hfn805b
end type
type st_11 from statictext within w_hfn805b
end type
type sle_o_d from singlelineedit within w_hfn805b
end type
type st_10 from statictext within w_hfn805b
end type
type ddlb_bungi from dropdownlistbox within w_hfn805b
end type
type st_9 from statictext within w_hfn805b
end type
type sle_o_c from singlelineedit within w_hfn805b
end type
type st_8 from statictext within w_hfn805b
end type
type sle_b from singlelineedit within w_hfn805b
end type
type st_7 from statictext within w_hfn805b
end type
type sle_a from singlelineedit within w_hfn805b
end type
type st_6 from statictext within w_hfn805b
end type
type em_date from editmask within w_hfn805b
end type
type st_5 from statictext within w_hfn805b
end type
type sle_tel from singlelineedit within w_hfn805b
end type
type st_4 from statictext within w_hfn805b
end type
type em_year from editmask within w_hfn805b
end type
type st_1 from statictext within w_hfn805b
end type
type ddlb_gubun from dropdownlistbox within w_hfn805b
end type
type st_2 from statictext within w_hfn805b
end type
type dw_list from uo_dwgrid within w_hfn805b
end type
type cb_1 from uo_imgbtn within w_hfn805b
end type
type gb_1 from groupbox within w_hfn805b
end type
type gb_2 from groupbox within w_hfn805b
end type
type gb_4 from groupbox within w_hfn805b
end type
type gb_3 from groupbox within w_hfn805b
end type
end forward

global type w_hfn805b from w_msheet
sle_i_d sle_i_d
st_12 st_12
sle_i_c sle_i_c
st_11 st_11
sle_o_d sle_o_d
st_10 st_10
ddlb_bungi ddlb_bungi
st_9 st_9
sle_o_c sle_o_c
st_8 st_8
sle_b sle_b
st_7 st_7
sle_a sle_a
st_6 st_6
em_date em_date
st_5 st_5
sle_tel sle_tel
st_4 st_4
em_year em_year
st_1 st_1
ddlb_gubun ddlb_gubun
st_2 st_2
dw_list dw_list
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
gb_3 gb_3
end type
global w_hfn805b w_hfn805b

type variables


end variables

forward prototypes
public subroutine wf_hfn601h_proc (string as_file_name, string as_from_date, string as_to_date)
public subroutine wf_hfn602h_proc (string as_file_name, string as_from_date, string as_to_date)
end prototypes

public subroutine wf_hfn601h_proc (string as_file_name, string as_from_date, string as_to_date);// ==========================================================================================
// 기    능	:	계산서 합계표
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_hfn601h_proc()
// 인    수 :
// 되 돌 림 :	
// 주의사항 :
// 수정사항 :
// ==========================================================================================
integer	li_open_num, li_space_cnt
date		ld_date
string	ls_date
string	ls_write
string	ls_business_no, ls_campus_name, ls_jumin_no, ls_president, ls_zip, ls_address, ls_tel
string	ls_tax_office_code, ls_com_business, ls_com_cust_name, ls_bungi
integer	li_sum_count, li_sum_tax_cnt, li_acct_class
dec{0}	ldec_sum_tax_amt
long		ll_cnt

li_acct_class = gi_acct_class

em_date.getdata(ld_date)
ls_date = string(ld_date, 'yyyymmdd')

//파일열기
li_open_num = fileopen(as_file_name, linemode!, write!, lockreadwrite!, replace!)

select	tax_office_code, business_no, campus_name, jumin_no, president, zip, address
into		:ls_tax_office_code, :ls_business_no, :ls_campus_name, :ls_jumin_no, :ls_president, :ls_zip, :ls_address
from		cddb.kch000m	;

// A 레코드 - 제출자(대리인) 레코드
if	isnull(ls_tax_office_code) then ls_tax_office_code = space(3)
if isnull(ls_business_no) then ls_business_no = space(10)
if isnull(ls_campus_name) then ls_campus_name = space(40)
if isnull(ls_jumin_no) then ls_jumin_no = space(13)
if isnull(ls_president) then ls_president = space(30)
if isnull(ls_zip) then ls_zip = space(10)
if isnull(ls_address) then ls_address = space(70)

li_space_cnt = 40 - len(trim(ls_campus_name))
ls_campus_name = trim(ls_campus_name) + space(li_space_cnt)
li_space_cnt = 13 - len(trim(ls_jumin_no))
ls_jumin_no = trim(ls_jumin_no) + space(li_space_cnt)
li_space_cnt = 30 - len(trim(ls_president))
ls_president = trim(ls_president) + space(li_space_cnt)
li_space_cnt = 15 - len(trim(sle_tel.text))
ls_tel = trim(sle_tel.text) + space(li_space_cnt)
li_space_cnt = 10 - len(trim(ls_zip))
ls_zip = trim(ls_zip) + space(li_space_cnt)
li_space_cnt = 70 - len(trim(ls_address))
ls_address = trim(ls_address) + space(li_space_cnt)

ls_write = ''
// 1
ls_write = 'A'
// 2
ls_write = ls_write + ls_tax_office_code
// 3
ls_write = ls_write + ls_date
// 4
ls_write = ls_write + '2'
// 5
ls_write = ls_write + space(6)
// 6
ls_write = ls_write + ls_business_no
// 7
ls_write = ls_write + ls_campus_name
// 8
ls_write = ls_write + ls_jumin_no
// 9
ls_write = ls_write + ls_president
// 10
ls_write = ls_write + ls_zip
// 11
ls_write = ls_write + ls_address
// 12
ls_write = ls_write + ls_tel
// 13
ls_write = ls_write + '00001'
// 14
ls_write = ls_write + '101'
// 15
ls_write = ls_write + space(13)
			  
// 파일쓰기
filewrite(li_open_num, ls_write)

ls_write = ''
// B 레코드 - 제출의무자 레코드
// 1
ls_write = 'B'
// 2
ls_write = ls_write + ls_tax_office_code
// 3
ls_write = ls_write + '000001'
// 4
ls_write = ls_write + ls_business_no
// 5
ls_write = ls_write + ls_campus_name
// 6
ls_write = ls_write + ls_president
// 7
ls_write = ls_write + ls_zip
// 8
ls_write = ls_write + ls_address
// 9
ls_write = ls_write + space(60)
			  
// 파일쓰기
filewrite(li_open_num, ls_write)

// C 레코드 - 매출집계 레코드
select	count(a.com_business),
			nvl(sum(a.com_sum_of_tax),0),
			nvl(sum(a.com_tax_amt),0)
into		:li_sum_count, :li_sum_tax_cnt, :ldec_sum_tax_amt
from		(	select	nvl(c.business_no,' ')	com_business,
							count(b.tax_cust_no)		com_sum_of_tax,
							nvl(sum(b.tax_amt),0)	com_tax_amt
				from		fndb.hfn007m b, stdb.hst001m c
				where		b.tax_cust_no = c.cust_no (+)
				and		decode(:gi_acct_class,0,0,b.acct_class) = :gi_acct_class
				and		b.tax_date between :as_from_date and :as_to_date
				and		b.tax_type = '1'
				and		b.tax_gubun = '2'
				group by nvl(c.business_no,' ')	)	a	;

if li_sum_count > 0 then
	ls_write = ''
	// 1
	ls_write = 'C'
	// 2
	ls_write = ls_write + '17'
	// 3, 4	: 기구분,신고구분
	if ddlb_bungi.finditem(ddlb_bungi.text,0) = 1 then			//1기예정
		ls_write = ls_write + '11'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 2 then	//1기확정
		ls_write = ls_write + '12'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 3 then	//2기예정
		ls_write = ls_write + '21'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 4 then	//2기확정
		ls_write = ls_write + '22'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 5 then	//1기합산
		ls_write = ls_write + '12'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 6 then	//2기합산
		ls_write = ls_write + '22'
	else		//1,2기합산
		ls_write = ls_write + '22'
	end if
	// 5
	ls_write = ls_write + ls_tax_office_code
	// 6
	ls_write = ls_write + '000001'
	// 7
	ls_write = ls_write + ls_business_no
	// 8
	ls_write = ls_write + em_year.text
	// 9
	ls_write = ls_write + as_from_date
	// 10
	ls_write = ls_write + as_to_date
	// 11
	ls_write = ls_write + ls_date
	// 12
	ls_write = ls_write + string(li_sum_count, '000000')
	// 13
	ls_write = ls_write + string(li_sum_tax_cnt, '000000')
	// 14
	if ldec_sum_tax_amt < 0 then
		ls_write = ls_write + '1'
	else
		ls_write = ls_write + '0'
	end if
	// 15
	ls_write = ls_write + string(ldec_sum_tax_amt, '00000000000000')
	// 16
	ls_write = ls_write + string(li_sum_count, '000000')
	// 17
	ls_write = ls_write + string(li_sum_tax_cnt, '000000')
	// 18
	if ldec_sum_tax_amt < 0 then
		ls_write = ls_write + '1'
	else
		ls_write = ls_write + '0'
	end if
	// 19
	ls_write = ls_write + string(ldec_sum_tax_amt, '00000000000000')
	// 20
	ls_write = ls_write + '000000'
	// 21
	ls_write = ls_write + '000000'
	// 22
	ls_write = ls_write + '0'
	// 23
	ls_write = ls_write + '00000000000000'
	// 24
	ls_write = ls_write + space(97)

	// 파일쓰기
	filewrite(li_open_num, ls_write)
end if

// D 레코드(매출처 거래명세)
declare cur_601h_1 cursor for
select	b.business_no,
			b.cust_name,
			count(a.acct_class),
			nvl(sum(a.tax_amt),0)
from		fndb.hfn007m a, stdb.hst001m b
where		a.tax_cust_no = b.cust_no (+)
and		decode(:li_acct_class,0,0,a.acct_class) = :li_acct_class
and		a.tax_date between :as_from_date and :as_to_date
and		a.tax_type = '1'
and		a.tax_gubun = '2'
group by b.business_no, b.cust_name
order by b.business_no	;

open cur_601h_1	;

fetch	cur_601h_1 into :ls_com_business, :ls_com_cust_name, :li_sum_tax_cnt, :ldec_sum_tax_amt	;

ll_cnt = 0
do while sqlca.sqlcode = 0
	ll_cnt ++
	
	if isnull(ls_com_business) then ls_com_business = ''
	if isnull(ls_com_cust_name) then ls_com_cust_name = ''
	
	li_space_cnt = 10 - len(trim(ls_com_business))
	ls_com_business = trim(ls_com_business) + space(li_space_cnt)
	li_space_cnt = 40 - len(trim(ls_com_cust_name))
	ls_com_cust_name = trim(ls_com_cust_name) + space(li_space_cnt)
	
	ls_write = ''
	// 1
	ls_write = 'D'
	// 2
	ls_write = ls_write + '17'
	// 3, 4	: 기구분,신고구분
	if ddlb_bungi.finditem(ddlb_bungi.text,0) = 1 then			//1기예정
		ls_write = ls_write + '11'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 2 then	//1기확정
		ls_write = ls_write + '12'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 3 then	//2기예정
		ls_write = ls_write + '21'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 4 then	//2기확정
		ls_write = ls_write + '22'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 5 then	//1기합산
		ls_write = ls_write + '12'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 6 then	//2기합산
		ls_write = ls_write + '22'
	else		//1,2기합산
		ls_write = ls_write + '22'
	end if
	// 5
	ls_write = ls_write + ls_tax_office_code
	// 6
	ls_write = ls_write + string(ll_cnt, '000000')
	// 7
	ls_write = ls_write + ls_business_no
	// 8
	ls_write = ls_write + ls_com_business
	// 9
	ls_write = ls_write + ls_com_cust_name
	// 10
	ls_write = ls_write + string(li_sum_tax_cnt, '00000')
	// 11
	if ldec_sum_tax_amt < 0 then
		ls_write = ls_write + '1'
	else
		ls_write = ls_write + '0'
	end if
	// 12
	ls_write = ls_write + string(ldec_sum_tax_amt, '00000000000000')
	// 13
	ls_write = ls_write + space(134)
	
	// 파일쓰기
	filewrite(li_open_num, ls_write)
	
	fetch	cur_601h_1 into :ls_com_business, :ls_com_cust_name, :li_sum_tax_cnt, :ldec_sum_tax_amt	;
loop

close cur_601h_1	;

sle_a.text   = '1'
sle_b.text 	 = '1'
sle_o_c.text = '1'
sle_o_d.text = string(ll_cnt)

// C 레코드 - 매입집계 레코드
select	count(a.com_business),
			nvl(sum(a.com_sum_of_tax),0),
			nvl(sum(a.com_tax_amt),0)
into		:li_sum_count, :li_sum_tax_cnt, :ldec_sum_tax_amt
from		(	select	nvl(c.business_no,' ')	com_business,
							count(b.tax_cust_no)		com_sum_of_tax,
							nvl(sum(b.tax_amt),0)	com_tax_amt
				from		fndb.hfn007m b, stdb.hst001m c
				where		b.tax_cust_no = c.cust_no (+)
				and		decode(:gi_acct_class,0,0,b.acct_class) = :gi_acct_class
				and		b.tax_date between :as_from_date and :as_to_date
				and		b.tax_type = '1'
				and		b.tax_gubun = '1'
				group by nvl(c.business_no,' ')	)	a	;

if li_sum_count > 0 then
	ls_write = ''
	// 1
	ls_write = 'C'
	// 2
	ls_write = ls_write + '18'
	// 3, 4	: 기구분,신고구분
	if ddlb_bungi.finditem(ddlb_bungi.text,0) = 1 then			//1기예정
		ls_write = ls_write + '11'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 2 then	//1기확정
		ls_write = ls_write + '12'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 3 then	//2기예정
		ls_write = ls_write + '21'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 4 then	//2기확정
		ls_write = ls_write + '22'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 5 then	//1기합산
		ls_write = ls_write + '12'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 6 then	//2기합산
		ls_write = ls_write + '22'
	else		//1,2기합산
		ls_write = ls_write + '22'
	end if
	// 5
	ls_write = ls_write + ls_tax_office_code
	// 6
	ls_write = ls_write + '000001'
	// 7
	ls_write = ls_write + ls_business_no
	// 8
	ls_write = ls_write + em_year.text
	// 9
	ls_write = ls_write + as_from_date
	// 10
	ls_write = ls_write + as_to_date
	// 11
	ls_write = ls_write + ls_date
	// 12
	ls_write = ls_write + string(li_sum_count, '000000')
	// 13
	ls_write = ls_write + string(li_sum_tax_cnt, '000000')
	// 14
	if ldec_sum_tax_amt < 0 then
		ls_write = ls_write + '1'
	else
		ls_write = ls_write + '0'
	end if
	// 15
	ls_write = ls_write + string(ldec_sum_tax_amt, '00000000000000')
	// 16
	ls_write = ls_write + space(151)

	// 파일쓰기
	filewrite(li_open_num, ls_write)
end if

// D 레코드(매출처 거래명세)
declare cur_601h_2 cursor for
select	b.business_no,
			b.cust_name,
			count(a.acct_class),
			nvl(sum(a.tax_amt),0)
from		fndb.hfn007m a, stdb.hst001m b
where		a.tax_cust_no = b.cust_no (+)
and		decode(:li_acct_class,0,0,a.acct_class) = :li_acct_class
and		a.tax_date between :as_from_date and :as_to_date
and		a.tax_type = '1'
and		a.tax_gubun = '1'
group by b.business_no, b.cust_name
order by b.business_no	;

open cur_601h_2	;

fetch	cur_601h_2 into :ls_com_business, :ls_com_cust_name, :li_sum_tax_cnt, :ldec_sum_tax_amt	;

ll_cnt = 0
do while sqlca.sqlcode = 0
	ll_cnt ++
	
	if isnull(ls_com_business) then ls_com_business = ''
	if isnull(ls_com_cust_name) then ls_com_cust_name = ''
	
	li_space_cnt = 10 - len(trim(ls_com_business))
	ls_com_business = trim(ls_com_business) + space(li_space_cnt)
	li_space_cnt = 40 - len(trim(ls_com_cust_name))
	ls_com_cust_name = trim(ls_com_cust_name) + space(li_space_cnt)
	
	ls_write = ''
	// 1
	ls_write = 'D'
	// 2
	ls_write = ls_write + '18'
	// 3, 4	: 기구분,신고구분
	if ddlb_bungi.finditem(ddlb_bungi.text,0) = 1 then			//1기예정
		ls_write = ls_write + '11'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 2 then	//1기확정
		ls_write = ls_write + '12'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 3 then	//2기예정
		ls_write = ls_write + '21'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 4 then	//2기확정
		ls_write = ls_write + '22'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 5 then	//1기합산
		ls_write = ls_write + '12'
	elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 6 then	//2기합산
		ls_write = ls_write + '22'
	else		//1,2기합산
		ls_write = ls_write + '22'
	end if
	// 5
	ls_write = ls_write + ls_tax_office_code
	// 6
	ls_write = ls_write + string(ll_cnt, '000000')
	// 7
	ls_write = ls_write + ls_business_no
	// 8
	ls_write = ls_write + ls_com_business
	// 9
	ls_write = ls_write + ls_com_cust_name
	// 10
	ls_write = ls_write + string(li_sum_tax_cnt, '00000')
	// 11
	if ldec_sum_tax_amt < 0 then
		ls_write = ls_write + '1'
	else
		ls_write = ls_write + '0'
	end if
	// 12
	ls_write = ls_write + string(ldec_sum_tax_amt, '00000000000000')
	// 13
	ls_write = ls_write + space(134)
	
	// 파일쓰기
	filewrite(li_open_num, ls_write)
	
	fetch	cur_601h_2 into :ls_com_business, :ls_com_cust_name, :li_sum_tax_cnt, :ldec_sum_tax_amt	;
loop

close cur_601h_2	;

sle_i_c.text = '1'
sle_i_d.text = string(ll_cnt)

// 파일닫기
fileclose(li_open_num)

end subroutine

public subroutine wf_hfn602h_proc (string as_file_name, string as_from_date, string as_to_date);// ==========================================================================================
// 기    능	:	세금계산서 합계표
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_hfn601h_proc()
// 인    수 :
// 되 돌 림 :	
// 주의사항 :
// 수정사항 :
// ==========================================================================================
integer	li_open_num, li_space_cnt
date		ld_date
string	ls_date
string	ls_write
string	ls_business_no, ls_campus_name, ls_jumin_no, ls_president, ls_zip, ls_address, ls_tel
string	ls_tax_office_code, ls_com_business, ls_com_cust_name, ls_bungi
string	ls_condition, ls_category, ls_com_uptae, ls_com_upjong
integer	li_sum_count, li_sum_of_tax, li_acct_class
dec{0}	ldec_sum_tax_amt, ldec_sum_tax_vat
long		ll_cnt

li_acct_class = gi_acct_class

em_date.getdata(ld_date)
ls_date = string(ld_date, 'yyyymmdd')

//파일열기
li_open_num = fileopen(as_file_name, linemode!, write!, lockreadwrite!, replace!)

select	tax_office_code, business_no, campus_name, jumin_no, president, zip, address, condition, category
into		:ls_tax_office_code, :ls_business_no, :ls_campus_name, :ls_jumin_no, :ls_president, :ls_zip, :ls_address, :ls_condition, :ls_category
from		cddb.kch000m	;

// 표지
if	isnull(ls_tax_office_code) then ls_tax_office_code = space(3)
if isnull(ls_business_no) 		then ls_business_no = space(10)
if isnull(ls_campus_name) 		then ls_campus_name = space(30)
if isnull(ls_jumin_no) 			then ls_jumin_no = space(13)
if isnull(ls_president) 		then ls_president = space(15)
if isnull(ls_zip) 				then ls_zip = space(10)
if isnull(ls_address) 			then ls_address = space(45)
if isnull(ls_condition) 		then ls_condition = space(17)
if isnull(ls_category) 			then ls_category = space(25)

li_space_cnt 	= 30 - len(trim(ls_campus_name))
ls_campus_name = trim(ls_campus_name) + space(li_space_cnt)
li_space_cnt 	= 13 - len(trim(ls_jumin_no))
ls_jumin_no 	= trim(ls_jumin_no) + space(li_space_cnt)
li_space_cnt 	= 15 - len(trim(ls_president))
ls_president 	= trim(ls_president) + space(li_space_cnt)
li_space_cnt 	= 15 - len(trim(sle_tel.text))
ls_tel 			= trim(sle_tel.text) + space(li_space_cnt)
li_space_cnt 	= 10 - len(trim(ls_zip))
ls_zip 			= trim(ls_zip) + space(li_space_cnt)
li_space_cnt 	= 45 - len(trim(ls_address))
ls_address 		= trim(ls_address) + space(li_space_cnt)
li_space_cnt 	= 17 - len(trim(ls_condition))
ls_condition 	= trim(ls_condition) + space(li_space_cnt)
li_space_cnt 	= 25 - len(trim(ls_category))
ls_category 	= trim(ls_category) + space(li_space_cnt)

ls_write = ''
// 1
ls_write = '7'
// 2
ls_write = ls_write + ls_business_no
// 3
ls_write = ls_write + ls_campus_name
// 4
ls_write = ls_write + ls_president
// 5
ls_write = ls_write + ls_address
// 6
ls_write = ls_write + ls_condition
// 7
ls_write = ls_write + ls_category
// 8
ls_write = ls_write + mid(as_from_date,3,6) + mid(as_to_date,3,6)
// 9
ls_write = ls_write + mid(as_to_date,3,6)
// 10
ls_write = ls_write + space(9)
			  
// 파일쓰기
filewrite(li_open_num, ls_write)

sle_a.text   = '1'
sle_b.text 	 = ''

// 매출자료(data)
declare cur_602h_1 cursor for
select	b.business_no,
			b.cust_name,
			b.uptae,
			b.upjong,
			count(a.acct_class),
			nvl(sum(a.tax_amt),0),
			nvl(sum(a.tax_vat),0)
from		fndb.hfn007m a, stdb.hst001m b
where		a.tax_cust_no 	= b.cust_no (+)
and		decode(:gi_acct_class,0,0,a.acct_class) = :gi_acct_class
and		a.tax_date 		between :as_from_date and :as_to_date
and		a.tax_type 		= '2'
and		a.tax_gubun 	= '2'
and		a.jumin_gbn 	= 'N'		//개인(주민등록번호분) 발행 제외
group by b.business_no, b.cust_name, b.uptae, b.upjong
order by b.business_no	;
open cur_602h_1	;
fetch	cur_602h_1 into :ls_com_business, :ls_com_cust_name, :ls_com_uptae, :ls_com_upjong, :li_sum_count, :ldec_sum_tax_amt, :ldec_sum_tax_vat	;

ll_cnt = 0
do while sqlca.sqlcode = 0
	ll_cnt ++
	
	if isnull(ls_com_business) 	then ls_com_business = space(10)
	if isnull(ls_com_cust_name) 	then ls_com_cust_name = space(30)
	if isnull(ls_com_uptae) 		then ls_com_uptae = space(17)
	if isnull(ls_com_upjong) 		then ls_com_upjong = space(25)
	
	li_space_cnt 		= 10 - len(trim(ls_com_business))
	ls_com_business 	= trim(ls_com_business) + space(li_space_cnt)

	if len(trim(ls_com_cust_name)) > 30 then
		ls_com_cust_name 	= left(trim(ls_com_cust_name),30)
	else
		li_space_cnt 		= 30 - len(trim(ls_com_cust_name))
		ls_com_cust_name 	= trim(ls_com_cust_name) + space(li_space_cnt)
	end if
	
	if len(trim(ls_com_uptae)) > 17 then
		ls_com_uptae = left(trim(ls_com_uptae),17)
	else
		li_space_cnt = 17 - len(trim(ls_com_uptae))
		ls_com_uptae = trim(ls_com_uptae) + space(li_space_cnt)
	end if

	if len(trim(ls_com_upjong)) > 25 then
		ls_com_upjong 	= left(trim(ls_com_upjong),25)
	else
		li_space_cnt 	= 25 - len(trim(ls_com_upjong))
		ls_com_upjong 	= trim(ls_com_upjong) + space(li_space_cnt)
	end if
	
	ls_write = ''
	// 1
	ls_write = '1'
	// 2
	ls_write = ls_write + ls_business_no
	// 3
	ls_write = ls_write + string(ll_cnt, '0000')
	// 4
	ls_write = ls_write + ls_com_business
	// 5
	ls_write = ls_write + ls_com_cust_name
	// 6
	ls_write = ls_write + ls_com_uptae
	// 7
	ls_write = ls_write + ls_com_upjong
	// 8
	ls_write = ls_write + string(li_sum_count, '0000000')
	// 9
	
	ls_write = ls_write + string(14 - len(trim(string(ldec_sum_tax_amt))), '00')
	// 10
	if ldec_sum_tax_amt < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_amt))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_amt, '00000000000000')
	end if
	
	// 11
	if ldec_sum_tax_vat < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_vat))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_vat, '0000000000000')
	end if
	
	// 12
	ls_write = ls_write + '0'
	// 13
	ls_write = ls_write + '0'
	// 14
	ls_write = ls_write + '9001'
	// 15
	ls_write = ls_write + ls_tax_office_code
	// 16
	ls_write = ls_write + space(28)
			  
	// 파일쓰기
	filewrite(li_open_num, ls_write)

	fetch	cur_602h_1 into :ls_com_business, :ls_com_cust_name, :ls_com_uptae, :ls_com_upjong, :li_sum_count, :ldec_sum_tax_amt, :ldec_sum_tax_vat	;
loop

close	cur_602h_1	;

sle_o_d.text = string(ll_cnt)

// 매출합계(total)
select	count(a.com_business),
			nvl(sum(a.com_sum_of_tax),0),
			nvl(sum(a.com_tax_amt),0),
			nvl(sum(a.com_tax_vat),0)
into		:li_sum_count, :li_sum_of_tax, :ldec_sum_tax_amt, :ldec_sum_tax_vat
from		(	
				select	decode(b.jumin_gbn,'N',nvl(c.business_no,' '),nvl(d.jumin_no,' '))	com_business,
							count(b.tax_cust_no)		com_sum_of_tax,
							nvl(sum(b.tax_amt),0)	com_tax_amt,
							nvl(sum(b.tax_vat),0)	com_tax_vat
				from		fndb.hfn007m b, 
							stdb.hst001m c,
							fndb.hfn603h d
				where		b.tax_cust_no 	= c.cust_no (+)
				and		b.tax_cust_no 	= d.cust_no (+)
				and		decode(:gi_acct_class,0,0,b.acct_class) = :gi_acct_class
				and		b.tax_date 		between :as_from_date and :as_to_date
				and		b.tax_type 		= '2'
				and		b.tax_gubun 	= '2'
				group by decode(b.jumin_gbn,'N',nvl(c.business_no,' '),nvl(d.jumin_no,' '))
			)	a	
;

if li_sum_count > 0 then
	ls_write = ''
	// 1
	ls_write = '3'
	// 2
	ls_write = ls_write + ls_business_no
	// 합계분
	// 3
	ls_write = ls_write + string(li_sum_count, '0000000')
	// 4
	ls_write = ls_write + string(li_sum_of_tax, '0000000')
	// 5
	if ldec_sum_tax_amt < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_amt))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_amt, '000000000000000')
	end if
	// 6
	if ldec_sum_tax_vat < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_vat))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_vat, '00000000000000')
	end if
	
	// 사업자번호발행분...
	select	count(a.com_business), 
				nvl(sum(a.com_sum_of_tax),0), 
				nvl(sum(a.com_tax_amt),0), 
				nvl(sum(a.com_tax_vat),0)
	into		:li_sum_count, :li_sum_of_tax, :ldec_sum_tax_amt, :ldec_sum_tax_vat
	from		(	
					select	decode(b.jumin_gbn,'N',nvl(c.business_no,' '),nvl(d.jumin_no,' '))	com_business,
								count(b.tax_cust_no)		com_sum_of_tax,
								nvl(sum(b.tax_amt),0)	com_tax_amt,
								nvl(sum(b.tax_vat),0)	com_tax_vat
					from		fndb.hfn007m b, 
								stdb.hst001m c,
								fndb.hfn603h d
					where		b.tax_cust_no 	= c.cust_no (+)
					and		b.tax_cust_no 	= d.cust_no (+)
					and		decode(:gi_acct_class,0,0,b.acct_class) = :gi_acct_class
					and		b.tax_date 		between :as_from_date and :as_to_date
					and		b.tax_type 		= '2'
					and		b.tax_gubun 	= '2'
					and		b.jumin_gbn		= 'N'
					group by decode(b.jumin_gbn,'N',nvl(c.business_no,' '),nvl(d.jumin_no,' '))
				)	a	;
	
	// 7
	ls_write = ls_write + string(li_sum_count, '0000000')
	// 8
	ls_write = ls_write + string(li_sum_of_tax, '0000000')
	// 9
	if ldec_sum_tax_amt < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_amt))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_amt, '000000000000000')
	end if
	// 10
	if ldec_sum_tax_vat < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_vat))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_vat, '00000000000000')
	end if
	
	// 주민번호 발행분...
	select	count(a.com_business), 
				nvl(sum(a.com_sum_of_tax),0), 
				nvl(sum(a.com_tax_amt),0), 
				nvl(sum(a.com_tax_vat),0)
	into		:li_sum_count, :li_sum_of_tax, :ldec_sum_tax_amt, :ldec_sum_tax_vat
	from		(	
					select	decode(b.jumin_gbn,'N',nvl(c.business_no,' '),nvl(d.jumin_no,' '))	com_business,
								count(b.tax_cust_no)		com_sum_of_tax,
								nvl(sum(b.tax_amt),0)	com_tax_amt,
								nvl(sum(b.tax_vat),0)	com_tax_vat
					from		fndb.hfn007m b, 
								stdb.hst001m c,
								fndb.hfn603h d
					where		b.tax_cust_no 	= c.cust_no (+)
					and		b.tax_cust_no 	= d.cust_no (+)
					and		decode(:gi_acct_class,0,0,b.acct_class) = :gi_acct_class
					and		b.tax_date 		between :as_from_date and :as_to_date
					and		b.tax_type 		= '2'
					and		b.tax_gubun 	= '2'
					and		b.jumin_gbn		= 'Y'
					group by decode(b.jumin_gbn,'N',nvl(c.business_no,' '),nvl(d.jumin_no,' '))
				)	a	;
	// 11
	ls_write = ls_write + string(li_sum_count, '0000000')
	// 12
	ls_write = ls_write + string(li_sum_of_tax, '0000000')
	// 13
	if ldec_sum_tax_amt < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_amt))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_amt, '000000000000000')
	end if
	// 14
	if ldec_sum_tax_vat < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_vat))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_vat, '00000000000000')
	end if
	// 15
	ls_write = ls_write + space(30)

	// 파일쓰기
	filewrite(li_open_num, ls_write)
	
	sle_o_c.text = '1'
end if

// 매입자료(data)
declare cur_602h_2 cursor for
select	b.business_no,
			b.cust_name,
			b.uptae,
			b.upjong,
			count(a.acct_class),
			nvl(sum(a.tax_amt),0),
			nvl(sum(a.tax_vat),0)
from		fndb.hfn007m a, stdb.hst001m b
where		a.tax_cust_no 	= b.cust_no (+)
and		decode(:gi_acct_class,0,0,a.acct_class) = :gi_acct_class
and		a.tax_date 		between :as_from_date and :as_to_date
and		a.tax_type 		= '2'
and		a.tax_gubun 	= '1'
group by b.business_no, b.cust_name, b.uptae, b.upjong
order by b.business_no	;

open cur_602h_2	;

fetch	cur_602h_2 into :ls_com_business, :ls_com_cust_name, :ls_com_uptae, :ls_com_upjong, :li_sum_count, :ldec_sum_tax_amt, :ldec_sum_tax_vat	;

ll_cnt = 0
do while sqlca.sqlcode = 0
	ll_cnt ++
	
	if isnull(ls_com_business) 	then ls_com_business = space(10)
	if isnull(ls_com_cust_name) 	then ls_com_cust_name = space(30)
	if isnull(ls_com_uptae) 		then ls_com_uptae = space(17)
	if isnull(ls_com_upjong) 		then ls_com_upjong = space(25)
	
	li_space_cnt 		= 10 - len(trim(ls_com_business))
	ls_com_business 	= trim(ls_com_business) + space(li_space_cnt)
	
//	if len(trim(ls_com_cust_name)) > 30 then ls_com_cust_name = left(ls_com_cust_name, 30)
	li_space_cnt 		= 30 - len(trim(ls_com_cust_name))
	ls_com_cust_name 	= trim(ls_com_cust_name) + space(li_space_cnt)

//	if len(trim(ls_com_uptae)) > 17 then ls_com_uptae = left(ls_com_uptae, 17)
	li_space_cnt 		= 17 - len(trim(ls_com_uptae))
	ls_com_uptae 		= trim(ls_com_uptae) + space(li_space_cnt)

//	if len(trim(ls_com_upjong)) > 25 then ls_com_upjong = left(ls_com_upjong, 25)
	li_space_cnt 		= 25 - len(trim(ls_com_upjong))
	ls_com_upjong 		= trim(ls_com_upjong) + space(li_space_cnt)
	
	ls_write = ''
	// 1
	ls_write = '2'
	// 2
	ls_write = ls_write + ls_business_no
	// 3
	ls_write = ls_write + string(ll_cnt, '0000')
	// 4
	ls_write = ls_write + ls_com_business
	// 5
	ls_write = ls_write + ls_com_cust_name
	// 6
	ls_write = ls_write + ls_com_uptae
	// 7
	ls_write = ls_write + ls_com_upjong
	// 8
	ls_write = ls_write + string(li_sum_count, '0000000')

//	ls_write = ls_write + string(li_sum_of_tax, '0000000')
//	messagebox('확인4', li_sum_count)
	// 9
	ls_write = ls_write + string(14 - len(trim(string(ldec_sum_tax_amt))), '00')
	// 10
	if ldec_sum_tax_amt < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_amt))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '00000000000000'),13) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_amt, '00000000000000')
	end if
	// 11
	if ldec_sum_tax_vat < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_vat))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '0000000000000'),12) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_vat, '0000000000000')
	end if
	// 12
	ls_write = ls_write + '0'
	// 13
	ls_write = ls_write + '0'
	// 14
	ls_write = ls_write + '9501'
	// 15
	ls_write = ls_write + ls_tax_office_code
	// 16
	ls_write = ls_write + space(28)
			  
	// 파일쓰기
	filewrite(li_open_num, ls_write)

	fetch	cur_602h_2 into :ls_com_business, :ls_com_cust_name, :ls_com_uptae, :ls_com_upjong, :li_sum_count, :ldec_sum_tax_amt, :ldec_sum_tax_vat	;
loop

close	cur_602h_2	;

sle_i_d.text = string(ll_cnt)

// 매입합계(total)
select	count(a.com_business),
			nvl(sum(a.com_sum_of_tax),0),
			nvl(sum(a.com_tax_amt),0),
			nvl(sum(a.com_tax_vat),0)
into		:li_sum_count, :li_sum_of_tax, :ldec_sum_tax_amt, :ldec_sum_tax_vat
from		(	select	nvl(c.business_no,' ')	com_business,
							count(b.tax_cust_no)		com_sum_of_tax,
							nvl(sum(b.tax_amt),0)	com_tax_amt,
							nvl(sum(b.tax_vat),0)	com_tax_vat
				from		fndb.hfn007m b, stdb.hst001m c
				where		b.tax_cust_no 	= c.cust_no (+)
				and		decode(:gi_acct_class,0,0,b.acct_class) = :gi_acct_class
				and		b.tax_date 		between :as_from_date and :as_to_date
				and		b.tax_type 		= '2'
				and		b.tax_gubun 	= '1'
				group by nvl(c.business_no,' ')	)	a	;

if li_sum_count > 0 then
	ls_write = ''
	// 1
	ls_write = '4'
	// 2
	ls_write = ls_write + ls_business_no
	// 3
	ls_write = ls_write + string(li_sum_count, '0000000')
	// 4
	ls_write = ls_write + string(li_sum_of_tax, '0000000')
	// 5
	if ldec_sum_tax_amt < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_amt))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_amt, '000000000000000'),14) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_amt, '000000000000000')
	end if
	// 6
	if ldec_sum_tax_vat < 0 then
		choose case right(trim(string(abs(ldec_sum_tax_vat))),1)
			case '0'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + '}'
			case '1'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'J'
			case '2'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'K'
			case '3'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'L'
			case '4'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'M'
			case '5'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'N'
			case '6'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'O'
			case '7'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'P'
			case '8'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'Q'
			case '9'
				ls_write = ls_write + left(string(ldec_sum_tax_vat, '00000000000000'),13) + 'R'
		end choose
	else
		ls_write = ls_write + string(ldec_sum_tax_vat, '00000000000000')
	end if
	// 7
	ls_write = ls_write + space(116)

	// 파일쓰기
	filewrite(li_open_num, ls_write)
	
	sle_i_c.text = '1'
end if

// 파일닫기
fileclose(li_open_num)

end subroutine

on w_hfn805b.create
int iCurrent
call super::create
this.sle_i_d=create sle_i_d
this.st_12=create st_12
this.sle_i_c=create sle_i_c
this.st_11=create st_11
this.sle_o_d=create sle_o_d
this.st_10=create st_10
this.ddlb_bungi=create ddlb_bungi
this.st_9=create st_9
this.sle_o_c=create sle_o_c
this.st_8=create st_8
this.sle_b=create sle_b
this.st_7=create st_7
this.sle_a=create sle_a
this.st_6=create st_6
this.em_date=create em_date
this.st_5=create st_5
this.sle_tel=create sle_tel
this.st_4=create st_4
this.em_year=create em_year
this.st_1=create st_1
this.ddlb_gubun=create ddlb_gubun
this.st_2=create st_2
this.dw_list=create dw_list
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_i_d
this.Control[iCurrent+2]=this.st_12
this.Control[iCurrent+3]=this.sle_i_c
this.Control[iCurrent+4]=this.st_11
this.Control[iCurrent+5]=this.sle_o_d
this.Control[iCurrent+6]=this.st_10
this.Control[iCurrent+7]=this.ddlb_bungi
this.Control[iCurrent+8]=this.st_9
this.Control[iCurrent+9]=this.sle_o_c
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.sle_b
this.Control[iCurrent+12]=this.st_7
this.Control[iCurrent+13]=this.sle_a
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.em_date
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.sle_tel
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.em_year
this.Control[iCurrent+20]=this.st_1
this.Control[iCurrent+21]=this.ddlb_gubun
this.Control[iCurrent+22]=this.st_2
this.Control[iCurrent+23]=this.dw_list
this.Control[iCurrent+24]=this.cb_1
this.Control[iCurrent+25]=this.gb_1
this.Control[iCurrent+26]=this.gb_2
this.Control[iCurrent+27]=this.gb_4
this.Control[iCurrent+28]=this.gb_3
end on

on w_hfn805b.destroy
call super::destroy
destroy(this.sle_i_d)
destroy(this.st_12)
destroy(this.sle_i_c)
destroy(this.st_11)
destroy(this.sle_o_d)
destroy(this.st_10)
destroy(this.ddlb_bungi)
destroy(this.st_9)
destroy(this.sle_o_c)
destroy(this.st_8)
destroy(this.sle_b)
destroy(this.st_7)
destroy(this.sle_a)
destroy(this.st_6)
destroy(this.em_date)
destroy(this.st_5)
destroy(this.sle_tel)
destroy(this.st_4)
destroy(this.em_year)
destroy(this.st_1)
destroy(this.ddlb_gubun)
destroy(this.st_2)
destroy(this.dw_list)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_3)
end on

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.12
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//string	ls_sysdate
//
//ls_sysdate	  =	f_today()
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ddlb_gubun.selectitem(1)
//
//choose case ddlb_gubun.finditem(ddlb_gubun.text, 0)
//	case 1
//		ddlb_bungi.AddItem('1기합산')
//		ddlb_bungi.AddItem('2기합산')
//		ddlb_bungi.AddItem('1/2기합산')
//	case 2
//		ddlb_bungi.DeleteItem(7)
//		ddlb_bungi.DeleteItem(6)
//		ddlb_bungi.DeleteItem(5)
//end choose
//
//em_year.text = mid(ls_sysdate,1,4)
//
//choose case mid(ls_sysdate,5,2)
//	case '01', '02', '03'
//		ddlb_bungi.selectitem(1)
//	case '04', '05', '06'
//		ddlb_bungi.selectitem(2)
//	case '07', '08', '09'
//		ddlb_bungi.selectitem(3)
//	case '10', '11', '12'
//		ddlb_bungi.selectitem(4)
//	case else
//		ddlb_bungi.selectitem(1)
//end choose
//
//em_date.text = string(ls_sysdate, '@@@@/@@/@@')
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
string	ls_sysdate

ls_sysdate	  =	f_today()

ddlb_gubun.selectitem(1)

choose case ddlb_gubun.finditem(ddlb_gubun.text, 0)
	case 1
		ddlb_bungi.AddItem('1기합산')
		ddlb_bungi.AddItem('2기합산')
		ddlb_bungi.AddItem('1/2기합산')
	case 2
		ddlb_bungi.DeleteItem(7)
		ddlb_bungi.DeleteItem(6)
		ddlb_bungi.DeleteItem(5)
end choose

em_year.text = mid(ls_sysdate,1,4)

choose case mid(ls_sysdate,5,2)
	case '01', '02', '03'
		ddlb_bungi.selectitem(1)
	case '04', '05', '06'
		ddlb_bungi.selectitem(2)
	case '07', '08', '09'
		ddlb_bungi.selectitem(3)
	case '10', '11', '12'
		ddlb_bungi.selectitem(4)
	case else
		ddlb_bungi.selectitem(1)
end choose

em_date.text = string(ls_sysdate, '@@@@/@@/@@')

end event

type ln_templeft from w_msheet`ln_templeft within w_hfn805b
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn805b
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn805b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn805b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn805b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn805b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn805b
end type

type uc_insert from w_msheet`uc_insert within w_hfn805b
end type

type uc_delete from w_msheet`uc_delete within w_hfn805b
end type

type uc_save from w_msheet`uc_save within w_hfn805b
end type

type uc_excel from w_msheet`uc_excel within w_hfn805b
end type

type uc_print from w_msheet`uc_print within w_hfn805b
end type

type st_line1 from w_msheet`st_line1 within w_hfn805b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn805b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn805b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn805b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn805b
end type

type sle_i_d from singlelineedit within w_hfn805b
integer x = 3246
integer y = 592
integer width = 366
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_12 from statictext within w_hfn805b
integer x = 2912
integer y = 608
integer width = 329
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "D 레코드수"
boolean focusrectangle = false
end type

type sle_i_c from singlelineedit within w_hfn805b
integer x = 2391
integer y = 592
integer width = 366
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_11 from statictext within w_hfn805b
integer x = 2043
integer y = 608
integer width = 334
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "C 레코드수"
boolean focusrectangle = false
end type

type sle_o_d from singlelineedit within w_hfn805b
integer x = 1289
integer y = 592
integer width = 366
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within w_hfn805b
integer x = 955
integer y = 608
integer width = 329
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "D 레코드수"
boolean focusrectangle = false
end type

type ddlb_bungi from dropdownlistbox within w_hfn805b
integer x = 1728
integer y = 204
integer width = 379
integer height = 660
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"1기예정","1기확정","2기예정","2기확정"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//ddlb_gubun.Triggerevent(SelectionChanged!)

end event

type st_9 from statictext within w_hfn805b
integer x = 1403
integer y = 216
integer width = 274
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "처리기수"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_o_c from singlelineedit within w_hfn805b
integer x = 434
integer y = 592
integer width = 366
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_hfn805b
integer x = 87
integer y = 608
integer width = 334
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "C 레코드수"
boolean focusrectangle = false
end type

type sle_b from singlelineedit within w_hfn805b
integer x = 1289
integer y = 400
integer width = 366
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_hfn805b
integer x = 955
integer y = 416
integer width = 329
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "B 레코드수"
boolean focusrectangle = false
end type

type sle_a from singlelineedit within w_hfn805b
integer x = 434
integer y = 400
integer width = 366
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_hfn805b
integer x = 96
integer y = 416
integer width = 334
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "A 레코드수"
boolean focusrectangle = false
end type

type em_date from editmask within w_hfn805b
integer x = 2423
integer y = 200
integer width = 475
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
boolean autoskip = true
boolean spin = true
end type

type st_5 from statictext within w_hfn805b
integer x = 850
integer y = 216
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "처리년도"
boolean focusrectangle = false
end type

type sle_tel from singlelineedit within w_hfn805b
integer x = 3227
integer y = 200
integer width = 663
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_hfn805b
integer x = 2958
integer y = 216
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "전화번호"
boolean focusrectangle = false
end type

type em_year from editmask within w_hfn805b
integer x = 1120
integer y = 200
integer width = 293
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean autoskip = true
boolean spin = true
end type

type st_1 from statictext within w_hfn805b
integer x = 2149
integer y = 216
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "제출일자"
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_hfn805b
integer x = 361
integer y = 200
integer width = 443
integer height = 212
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
string item[] = {"계산서","세금계산서"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case finditem(text, 0)
	case 1
		dw_list.dataobject 	= 'd_hfn805b_1'
		ddlb_bungi.AddItem('1기합산')
		ddlb_bungi.AddItem('2기합산')
		ddlb_bungi.AddItem('1/2기합산')
	case 2
		dw_list.dataobject 	= 'd_hfn805b_2'
		ddlb_bungi.DeleteItem(7)
		ddlb_bungi.DeleteItem(6)
		ddlb_bungi.DeleteItem(5)
end choose

//dw_list.settransobject(sqlca)
dw_list.triggerevent(constructor!)

end event

type st_2 from statictext within w_hfn805b
integer x = 96
integer y = 216
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "조회구분"
boolean focusrectangle = false
end type

type dw_list from uo_dwgrid within w_hfn805b
integer x = 50
integer y = 716
integer width = 4384
integer height = 1548
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_hfn805b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type cb_1 from uo_imgbtn within w_hfn805b
integer x = 3442
integer y = 400
integer taborder = 60
boolean bringtotop = true
string btnname = "합계표생성"
end type

event clicked;call super::clicked;string	ls_file_name
string	ls_business_no
string	ls_from_date, ls_to_date
long		ll_cnt
integer	li_rtn

if not isdate(em_date.text) then
	messagebox('확인', '제출일자를 올바르게 입력하시기 바랍니다.')
	em_date.setfocus()
	return
end if

if isnull(sle_tel.text) or trim(sle_tel.text) = '' then
	messagebox('확인', '전화번호를 입력하시기 바랍니다.')
	sle_tel.setfocus()
	return
end if

if ddlb_bungi.finditem(ddlb_bungi.text,0) = 1 then
	ls_from_date = em_year.text + '0101'
	ls_to_date   = em_year.text + '0331'
elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 2 then
	ls_from_date = em_year.text + '0401'
	ls_to_date   = em_year.text + '0630'
elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 3 then
	ls_from_date = em_year.text + '0701'
	ls_to_date   = em_year.text + '0930'
elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 4 then
	ls_from_date = em_year.text + '1001'
	ls_to_date   = em_year.text + '1231'
elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 5 then
	ls_from_date = em_year.text + '0101'
	ls_to_date   = em_year.text + '0630'
elseif ddlb_bungi.finditem(ddlb_bungi.text,0) = 6 then
	ls_from_date = em_year.text + '0701'
	ls_to_date   = em_year.text + '1231'
else
	ls_from_date = em_year.text + '0101'
	ls_to_date   = em_year.text + '1231'
end if

dw_list.reset()

// 생성 대상자료 Check
if ddlb_gubun.finditem(ddlb_gubun.text, 0) = 1 then
	select	count(acct_class)
	into		:ll_cnt
	from		fndb.hfn007m
	where		decode(:gi_acct_class,0,0,acct_class) = :gi_acct_class
	and		tax_type = '1'
	and		tax_date between :ls_from_date and :ls_to_date	;
else
	select	count(acct_class)
	into		:ll_cnt
	from		fndb.hfn007m
	where		decode(:gi_acct_class,0,0,acct_class) = :gi_acct_class
	and		tax_type = '2'
	and		tax_date between :ls_from_date and :ls_to_date	;
end if

// 파일명
select	business_no
into		:ls_business_no
from		cddb.kch000m	;

if isnull(ls_business_no) or trim(ls_business_no) = '' then
	messagebox('확인', '캠퍼스정보의 사업자등록번호가 없습니다.')
	return
end if

if ddlb_gubun.finditem(ddlb_gubun.text, 0) = 1 then
	ls_file_name = 'H' + mid(ls_business_no,1,7) + '.' + mid(ls_business_no,8)
else
	ls_file_name = 'K' + mid(ls_business_no,1,7) + '.' + mid(ls_business_no,8)
end if

if ll_cnt < 1 then
	messagebox('확인', '생성대상 자료가 없습니다.')
	return
end if

li_rtn = getfilesavename('저장화일 선택', ls_file_name, ls_file_name, '', '모든화일 (*.*),*.*')

if li_rtn < 1 then return



dw_list.retrieve(gi_acct_class, ls_from_date, ls_to_date)

if ddlb_gubun.finditem(ddlb_gubun.text, 0) = 1 then
	wf_hfn601h_proc(ls_file_name, ls_from_date, ls_to_date)
else
	wf_hfn602h_proc(ls_file_name, ls_from_date, ls_to_date)
end if



end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type gb_1 from groupbox within w_hfn805b
integer x = 50
integer y = 132
integer width = 4384
integer height = 200
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "생성 조건"
end type

type gb_2 from groupbox within w_hfn805b
integer x = 50
integer y = 344
integer width = 4384
integer height = 180
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "생성 결과"
end type

type gb_4 from groupbox within w_hfn805b
integer x = 1993
integer y = 532
integer width = 2441
integer height = 180
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "매입처 생성 결과"
end type

type gb_3 from groupbox within w_hfn805b
integer x = 50
integer y = 532
integer width = 1938
integer height = 180
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "매출처 생성 결과"
end type

