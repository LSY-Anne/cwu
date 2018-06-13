$PBExportHeader$w_hfn604b.srw
$PBExportComments$기타/사업소득 지급조서 생성
forward
global type w_hfn604b from w_msheet
end type
type sle_name from singlelineedit within w_hfn604b
end type
type sle_sosok from singlelineedit within w_hfn604b
end type
type st_9 from statictext within w_hfn604b
end type
type st_3 from statictext within w_hfn604b
end type
type sle_c from singlelineedit within w_hfn604b
end type
type st_8 from statictext within w_hfn604b
end type
type sle_b from singlelineedit within w_hfn604b
end type
type st_7 from statictext within w_hfn604b
end type
type sle_a from singlelineedit within w_hfn604b
end type
type st_6 from statictext within w_hfn604b
end type
type em_date from editmask within w_hfn604b
end type
type st_5 from statictext within w_hfn604b
end type
type sle_tel from singlelineedit within w_hfn604b
end type
type st_4 from statictext within w_hfn604b
end type
type em_year from editmask within w_hfn604b
end type
type st_1 from statictext within w_hfn604b
end type
type ddlb_gubun from dropdownlistbox within w_hfn604b
end type
type st_2 from statictext within w_hfn604b
end type
type gb_1 from groupbox within w_hfn604b
end type
type gb_2 from groupbox within w_hfn604b
end type
type dw_list from uo_dwgrid within w_hfn604b
end type
type cb_1 from uo_imgbtn within w_hfn604b
end type
end forward

global type w_hfn604b from w_msheet
sle_name sle_name
sle_sosok sle_sosok
st_9 st_9
st_3 st_3
sle_c sle_c
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
gb_1 gb_1
gb_2 gb_2
dw_list dw_list
cb_1 cb_1
end type
global w_hfn604b w_hfn604b

forward prototypes
public subroutine wf_hfn301h_proc (string as_file_name, string as_year)
public subroutine wf_hfn302h_proc (string as_file_name, string as_year)
public subroutine wf_hfn301h_proc_2003 (string as_file_name, string as_year)
end prototypes

public subroutine wf_hfn301h_proc (string as_file_name, string as_year);// ==========================================================================================
// 기    능	:	기타소득 지급조서
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_hfn301h_proc()
// 인    수 :
// 되 돌 림 :	
// 주의사항 :
// 수정사항 :
// ==========================================================================================

//2004년도 기타소득 변경 170byte로 변경....
//2008년도 기타소득 변경 소득구분코드 60(일반기타소득) -> 61(필요경비80%발생소득)로 DB Data변경 : 2009.02.04


integer	li_open_num, li_space_cnt
integer	li_income_class, li_income_rate
long	ll_tot_cnt, ll_cnt, ll_tot_inwon, ll_jigub_cnt
dec{0}	ldec_income_amt, ldec_tax_amt, ldec_jumin_amt
dec{0}	ldec_pay_amt, ldec_need_amt
date	ld_date
string	ls_date
string	ls_tax_office_code, ls_business_no, ls_campus_name, ls_jumin_no, ls_president
string 	ls_sosok, ls_name, ls_tel
string	ls_income_name, ls_geju_gubun, ls_pay_date, ls_yyyymm, ls_income_juso, ls_foreign_type
string	ls_write
string	ls_hometax

em_date.getdata(ld_date)
ls_date = string(ld_date, 'yyyymmdd')

//파일열기
li_open_num = fileopen(as_file_name, linemode!, write!, lockreadwrite!, replace!)

select	tax_office_code, 			business_no, 		campus_name, 
			jumin_no, 					president
into		:ls_tax_office_code, 	:ls_business_no, 	:ls_campus_name, 
			:ls_jumin_no, 				:ls_president
from		cddb.kch000m	;

select	count(jumin_no)
into		:ll_tot_cnt
from		fndb.hfn301h
where		substr(yyyymm,1,4) = :as_year
group by jumin_no	;


// A 레코드 - 제출자(대리인) 레코드
ls_write = ''

// 1 레코드 구분
ls_write += 'A'
// 2 자료구분
ls_write += '23'


if isnull(ls_tax_office_code) 	then ls_tax_office_code = space(3)
if isnull(ls_business_no) 			then ls_business_no 		= space(10)
if isnull(ls_campus_name) 			then ls_campus_name 		= space(30)
if isnull(ls_jumin_no) 				then ls_jumin_no 			= space(13)
if isnull(ls_president) 			then ls_president 		= space(30)

li_space_cnt 	= 30 - len(trim(ls_campus_name))
ls_campus_name = trim(ls_campus_name) + space(li_space_cnt)
li_space_cnt 	= 30 - len(trim(ls_president))
ls_president 	= trim(ls_president) + space(li_space_cnt)
li_space_cnt 	= 20 - len(trim('cwu3120'))
ls_hometax 		= trim('cwu3120') + space(li_space_cnt)
li_space_cnt 	= 30 - len(trim(sle_sosok.text))
ls_sosok 		= trim(sle_sosok.text) + space(li_space_cnt)
li_space_cnt 	= 30 - len(trim(sle_name.text))
ls_name 			= trim(sle_name.text) + space(li_space_cnt)
li_space_cnt 	= 15 - len(trim(sle_tel.text))
ls_tel 			= trim(sle_tel.text) + space(li_space_cnt)


// 3 세무서
ls_write += ls_tax_office_code
// 4 제출연월일
ls_write += ls_date
// 5 제출자(대리인) 구분 : 1:세무대리인/ 2:법인/ 3:개인
ls_write += '2'
// 6 세무대리인 관리번호
ls_write += space(6)
// 7 홈택스 ID
ls_write += ls_hometax
// 8 세무프로그램코드
ls_write += '9000'
// 9 사업자등록번호
ls_write += ls_business_no
// 10 법인명(상호)
ls_write += ls_campus_name
// 11 담당자 부서
ls_write += ls_sosok
// 12 담당자 성명
ls_write += ls_name
// 13 담당자전화번호
ls_write += ls_tel
// 14 신고의무자수
ls_write += string(1, '00000')
// 15 제출대상기간코드 : 연간(1.1～12.31)합산제출 = 1, 휴,폐업에 의한 수시제출 = 2, 수시 분할제출 = 3
ls_write += '1'
// 16 공란
ls_write += space(4)
			  
// 파일쓰기
filewrite(li_open_num, ls_write)


// B 레코드 - 원천징수의무자별 집계레코드
ls_write = ''

select	count(distinct jumin_no)
into		:ll_tot_inwon
from		fndb.hfn301h
where		substr(yyyymm,1,4) = :as_year	;

select	count(*)
into		:ll_tot_cnt
from		fndb.hfn301h
where		substr(yyyymm,1,4) = :as_year	;

select	nvl(sum(pay_amt),0), 	nvl(sum(income_amt),0), 
			nvl(sum(tax_amt),0), 	nvl(sum(jumin_amt),0)
into		:ldec_pay_amt,				:ldec_income_amt, 		
			:ldec_tax_amt, 			:ldec_jumin_amt
from		fndb.hfn301h
where		substr(yyyymm,1,4) = :as_year	;

// 1 레코드 구분
ls_write += 'B'
// 2 자료구분
ls_write += '23'
// 3 세무서
ls_write += ls_tax_office_code
// 4 일련번호
ls_write += '000001'
// 5 사업자등록번호
ls_write += ls_business_no
// 6 법인명(상호)
ls_write += ls_campus_name
// 7 연간소득인원
ls_write += string(ll_tot_inwon, 	'000000')
// 8 연간총지급건수
ls_write += string(ll_tot_cnt, 		'0000000000')
// 9 연간총지급액계
ls_write += string(ldec_pay_amt, 	'000000000000000')
// 10 연간소득금액합계
ls_write += string(ldec_income_amt, '000000000000000')
// 11 소득세합계
ls_write += string(ldec_tax_amt, 	'000000000000000')
// 12 주민세합계
ls_write += string(ldec_jumin_amt, 	'000000000000000')
// 13 원천징수액합계
ls_write += string(ldec_tax_amt + ldec_jumin_amt, '000000000000000')
// 14 공란
ls_write += space(27)
			  
// 파일쓰기
filewrite(li_open_num, ls_write)


// C 레코드 - 기타소득자 레코드
//select income_name, jumin_no, count(*)
//from (
//
//select	income_name, 			jumin_no, 				geju_gubun, 	          nvl(income_class, 0), 		
//		sum(pay_amt), 			sum(need_amt), 			sum(income_amt),           income_rate, 				sum(tax_amt), 	sum(jumin_amt), 
//		nvl(foreign_type, '1')
//from	fndb.hfn301h
//where	substr(yyyymm,1,4) = '2004'
//
//group by income_name, jumin_no, 				geju_gubun, nvl(income_class, 0), income_rate, nvl(foreign_type, '1')
//)
//group by income_name, jumin_no


declare cur_gita cursor for
select	income_name, 			jumin_no, 				geju_gubun, 				nvl(income_class, 0), 		
			sum(pay_amt), 			sum(need_amt), 		sum(income_amt),			income_rate, 				
			sum(tax_amt), 			sum(jumin_amt), 		nvl(foreign_type, '1'),	count(*)
from		fndb.hfn301h
where		substr(yyyymm,1,4) = :as_year
group by income_name, 				jumin_no, 		geju_gubun, 
			nvl(income_class, 0), 	income_rate, 	nvl(foreign_type, '1')	;
open cur_gita	;
do while true
	fetch next cur_gita 
	into 	:ls_income_name, 		:ls_jumin_no, 			:ls_geju_gubun, 			:li_income_class, 			
			:ldec_pay_amt, 		:ldec_need_amt, 		:ldec_income_amt, 		:li_income_rate, 			
			:ldec_tax_amt, 		:ldec_jumin_amt, 		:ls_foreign_type,			:ll_jigub_cnt	;
			
	if sqlca.sqlcode <> 0 then exit
	ll_cnt ++
	
	li_space_cnt 	= 30 - len(trim(ls_income_name))
	ls_income_name = trim(ls_income_name) + space(li_space_cnt)
	li_space_cnt 	= 13 - len(trim(ls_jumin_no))
	ls_jumin_no 	= trim(ls_jumin_no) + space(li_space_cnt)

	if ls_geju_gubun = 'Y' then
		ls_geju_gubun = '1'
	else
		ls_geju_gubun = '2'
	end if
	
	ls_write = ''
	// 1 레코드 구분
	ls_write += 'C'
	// 2 자료구분
	ls_write += '23'
	// 3 세무서
	ls_write += ls_tax_office_code
	// 4 일련번호
	ls_write += string(ll_cnt, '000000')
	// 5 사업자등록번호
	ls_write += ls_business_no
	// 6 주민등록번호
	ls_write += ls_jumin_no
	// 7 소득자 성명
	ls_write += ls_income_name
	// 8 거주구분
	ls_write += ls_geju_gubun
	// 9 내.외국인구분
	ls_write += ls_foreign_type
	// 10 소득구분코드
	ls_write += string(li_income_class, '00')
	// 11 소득귀속연도
	ls_write += as_year
	// 12 지급연도
	ls_write += as_year
	// 13 지급건수
	ls_write += string(ll_jigub_cnt, '0000')
	// 14 연간지급총액
	if ldec_pay_amt < 0 then
		ls_write += '1' + string(ldec_pay_amt, '0000000000000')
	else
		ls_write += '0' + string(ldec_pay_amt, '0000000000000')
	end if
	// 15 필요경비
	if ldec_need_amt < 0 then
		ls_write += '1' + string(ldec_need_amt, '0000000000000')
	else
		ls_write += '0' + string(ldec_need_amt, '0000000000000')
	end if
	// 16 소득금액
	if ldec_income_amt < 0 then
		ls_write += '1' + string(ldec_income_amt, '0000000000000')
	else
		ls_write += '0' + string(ldec_income_amt, '0000000000000')
	end if
	// 17 세율
	ls_write += string(li_income_rate, '00')
	// 18 소득세
	if ldec_tax_amt < 0 then
		ls_write += '1' + string(ldec_tax_amt, '0000000000000')
	else
		ls_write += '0' + string(ldec_tax_amt, '0000000000000')
	end if
	// 19 주민세
	if ldec_jumin_amt < 0 then
		ls_write += '1' + string(ldec_jumin_amt, '0000000000000')
	else
		ls_write += '0' + string(ldec_jumin_amt, '0000000000000')
	end if
	// 20 원천징수액 계
	if ldec_tax_amt + ldec_jumin_amt < 0 then
		ls_write += '1' + string(ldec_tax_amt + ldec_jumin_amt, '0000000000000')
	else
		ls_write += '0' + string(ldec_tax_amt + ldec_jumin_amt, '0000000000000')
	end if
	// 21 공란
	ls_write += space(3)
	
	// 파일쓰기
	filewrite(li_open_num, ls_write)
	
loop

close cur_gita	;

sle_a.text = '1'
sle_b.text = '1'
sle_c.text = string(ll_cnt)

// 파일닫기
fileclose(li_open_num)


end subroutine

public subroutine wf_hfn302h_proc (string as_file_name, string as_year);// ==========================================================================================
// 기    능	:	사업소득 지급조서
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_hfn301h_proc()
// 인    수 :
// 되 돌 림 :	
// 주의사항 :
// 수정사항 :
// ==========================================================================================
integer	li_open_num, li_space_cnt
integer	li_income_class, li_income_rate
long		ll_tot_cnt, ll_cnt
dec{0}	ldec_pay_amt, ldec_tax_amt, ldec_jumin_amt
date		ld_date
string	ls_date
string	ls_tax_office_code, ls_business_no, ls_campus_name, ls_jumin_no, ls_president, ls_tel
string	ls_income_name, ls_pay_date, ls_yyyymm
string	ls_sangho, ls_saup_no
string	ls_write

em_date.getdata(ld_date)
ls_date = string(ld_date, 'yyyymmdd')

//파일열기
li_open_num = fileopen(as_file_name, linemode!, write!, lockreadwrite!, replace!)

select	tax_office_code, business_no, campus_name, jumin_no, president
into		:ls_tax_office_code, :ls_business_no, :ls_campus_name, :ls_jumin_no, :ls_president
from		cddb.kch000m	;

select	count(jumin_no)
into		:ll_tot_cnt
from		fndb.hfn302h
where		substr(yyyymm,1,4) = :as_year
group by jumin_no	;

ls_write = ''
// A 레코드 - 제출자(대리인) 레코드
// 1
ls_write = 'A'
// 2
ls_write = ls_write + '24'

if	isnull(ls_tax_office_code) then ls_tax_office_code = space(3)
if isnull(ls_business_no) then ls_business_no = space(10)
if isnull(ls_campus_name) then ls_campus_name = space(40)
if isnull(ls_jumin_no) then ls_jumin_no = space(13)
if isnull(ls_president) then ls_president = space(30)

li_space_cnt = 40 - len(trim(ls_campus_name))
ls_campus_name = trim(ls_campus_name) + space(li_space_cnt)
li_space_cnt = 30 - len(trim(ls_president))
ls_president = trim(ls_president) + space(li_space_cnt)
li_space_cnt = 15 - len(trim(sle_tel.text))
ls_tel = trim(sle_tel.text) + space(li_space_cnt)

// 3
ls_write = ls_write + ls_tax_office_code
// 4
ls_write = ls_write + ls_date
// 5
ls_write = ls_write + '2'
// 6
ls_write = ls_write + space(6)
// 7
ls_write = ls_write + ls_business_no
// 8
ls_write = ls_write + ls_campus_name
// 9
ls_write = ls_write + ls_jumin_no
// 10
ls_write = ls_write + ls_president
// 11
ls_write = ls_write + ls_tel
// 12
ls_write = ls_write + string(ll_tot_cnt, '00000')
// 13
ls_write = ls_write + '101'
// 14
ls_write = ls_write + '1'
// 15
ls_write = ls_write + space(1)
// 16
ls_write = ls_write + space(141)
			  
// 파일쓰기
filewrite(li_open_num, ls_write)

select	count(jumin_no), nvl(sum(pay_amt),0), nvl(sum(tax_amt),0), nvl(sum(jumin_amt),0)
into		:ll_tot_cnt, :ldec_pay_amt, :ldec_tax_amt, :ldec_jumin_amt
from		fndb.hfn302h
where		substr(yyyymm,1,4) = :as_year	;

ls_write = ''
// B 레코드 - 원천징수의무자별 집계레코드
// 1
ls_write = 'B'
// 2
ls_write = ls_write + '24'
// 3
ls_write = ls_write + ls_tax_office_code
// 4
ls_write = ls_write + '000001'
// 5
ls_write = ls_write + ls_business_no
// 6
ls_write = ls_write + ls_campus_name
// 7
ls_write = ls_write + ls_president
// 8
ls_write = ls_write + ls_jumin_no
// 9
ls_write = ls_write + string(ll_tot_cnt, '0000000')
// 10
ls_write = ls_write + string(ldec_pay_amt, '00000000000000')
// 11
ls_write = ls_write + string(ldec_tax_amt, '0000000000000')
// 12
ls_write = ls_write + '0000000000000'
// 13
ls_write = ls_write + '0000000000000'
// 14
ls_write = ls_write + string(ldec_jumin_amt, '0000000000000')
// 15
ls_write = ls_write + string(ldec_tax_amt + ldec_jumin_amt, '0000000000000')
// 16
ls_write = ls_write + space(1)
// 17
ls_write = ls_write + space(88)
			  
// 파일쓰기
filewrite(li_open_num, ls_write)

// C 레코드 - 사업소득자 레코드
declare cur_saup cursor for
select	sangho, saup_no, income_name, jumin_no, income_class, pay_date, yyyymm,
			pay_amt, income_rate, tax_amt, jumin_amt
from		fndb.hfn302h
where		substr(yyyymm,1,4) = :as_year
order by jumin_no, yyyymm	;

open cur_saup	;

fetch cur_saup into :ls_sangho, :ls_saup_no, :ls_income_name, :ls_jumin_no, :li_income_class, :ls_pay_date, :ls_yyyymm,
						  :ldec_pay_amt, :li_income_rate, :ldec_tax_amt, :ldec_jumin_amt	;

do while sqlca.sqlcode = 0
	ll_cnt ++
	
	li_space_cnt = 40 - len(trim(ls_sangho))
	ls_sangho = trim(ls_sangho) + space(li_space_cnt)
	li_space_cnt = 10 - len(trim(ls_saup_no))
	ls_saup_no = trim(ls_saup_no) + space(li_space_cnt)
	li_space_cnt = 30 - len(trim(ls_income_name))
	ls_income_name = trim(ls_income_name) + space(li_space_cnt)
	li_space_cnt = 13 - len(trim(ls_jumin_no))
	ls_jumin_no = trim(ls_jumin_no) + space(li_space_cnt)
	li_space_cnt = 8 - len(trim(ls_pay_date))
	ls_pay_date = trim(ls_pay_date) + space(li_space_cnt)
	
	ls_write = ''
	// 1
	ls_write = 'C'
	// 2
	ls_write = ls_write + '24'
	// 3
	ls_write = ls_write + ls_tax_office_code
	// 4
	ls_write = ls_write + string(ll_cnt, '000000')
	// 5
	ls_write = ls_write + ls_business_no
	// 6
	ls_write = ls_write + ls_sangho
	// 7
	ls_write = ls_write + ls_saup_no
	// 8
	ls_write = ls_write + ls_income_name
	// 9
	ls_write = ls_write + '1'
	// 10
	ls_write = ls_write + ls_jumin_no
	// 11
	ls_write = ls_write + string(li_income_class, '00')
	// 12
	ls_write = ls_write + ls_pay_date
	// 13
	ls_write = ls_write + ls_yyyymm

	// 14
	if ldec_pay_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_pay_amt, '00000000000')
	else
		ls_write = ls_write + '0' + string(ldec_pay_amt, '00000000000')
	end if
	// 15
	ls_write = ls_write + string(li_income_rate, '0')
	// 16
	if ldec_tax_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_tax_amt, '000000000')
	else
		ls_write = ls_write + '0' + string(ldec_tax_amt, '000000000')
	end if
	// 17
	if ldec_jumin_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_jumin_amt, '000000000')
	else
		ls_write = ls_write + '0' + string(ldec_jumin_amt, '000000000')
	end if
	// 18
	if ldec_tax_amt + ldec_jumin_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_tax_amt + ldec_jumin_amt, '000000000')
	else
		ls_write = ls_write + '0' + string(ldec_tax_amt + ldec_jumin_amt, '000000000')
	end if
	// 19
	ls_write = ls_write + space(9)
	// 20
	ls_write = ls_write + ls_pay_date
	// 21
	ls_write = ls_write + space(1)
	// 22
	ls_write = ls_write + '1'
	// 23
	ls_write = ls_write + space(86)
	
	// 파일쓰기
	filewrite(li_open_num, ls_write)
	
	fetch cur_saup into :ls_sangho, :ls_saup_no, :ls_income_name, :ls_jumin_no, :li_income_class, :ls_pay_date, :ls_yyyymm,
							  :ldec_pay_amt, :li_income_rate, :ldec_tax_amt, :ldec_jumin_amt	;
loop

close cur_saup	;

sle_a.text = '1'
sle_b.text = '1'
sle_c.text = string(ll_cnt)

// 파일닫기
fileclose(li_open_num)

end subroutine

public subroutine wf_hfn301h_proc_2003 (string as_file_name, string as_year);//2003년도 기타소득 전산자료 제출 파일생성 backup...


// ==========================================================================================
// 기    능	:	기타소득 지급조서
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_hfn301h_proc()
// 인    수 :
// 되 돌 림 :	
// 주의사항 :
// 수정사항 :
// ==========================================================================================
integer	li_open_num, li_space_cnt
integer	li_income_class, li_income_rate
long		ll_tot_cnt, ll_cnt
dec{0}	ldec_income_amt, ldec_tax_amt, ldec_jumin_amt
dec{0}	ldec_pay_amt, ldec_need_amt
date		ld_date
string	ls_date
string	ls_tax_office_code, ls_business_no, ls_campus_name, ls_jumin_no, ls_president, ls_tel
string	ls_income_name, ls_geju_gubun, ls_pay_date, ls_yyyymm, ls_income_juso, ls_foreign_type
string	ls_write

em_date.getdata(ld_date)
ls_date = string(ld_date, 'yyyymmdd')

//파일열기
li_open_num = fileopen(as_file_name, linemode!, write!, lockreadwrite!, replace!)

select	tax_office_code, business_no, campus_name, jumin_no, president
into		:ls_tax_office_code, :ls_business_no, :ls_campus_name, :ls_jumin_no, :ls_president
from		cddb.kch000m	;

select	count(jumin_no)
into		:ll_tot_cnt
from		fndb.hfn301h
where		substr(yyyymm,1,4) = :as_year
group by jumin_no	;

ls_write = ''
// A 레코드 - 제출자(대리인) 레코드
// 1
ls_write = 'A'
// 2
ls_write = ls_write + '23'

if	isnull(ls_tax_office_code) then ls_tax_office_code = space(3)
if isnull(ls_business_no) then ls_business_no = space(10)
if isnull(ls_campus_name) then ls_campus_name = space(40)
if isnull(ls_jumin_no) then ls_jumin_no = space(13)
if isnull(ls_president) then ls_president = space(30)

li_space_cnt = 40 - len(trim(ls_campus_name))
ls_campus_name = trim(ls_campus_name) + space(li_space_cnt)
li_space_cnt = 30 - len(trim(ls_president))
ls_president = trim(ls_president) + space(li_space_cnt)
li_space_cnt = 15 - len(trim(sle_tel.text))
ls_tel = trim(sle_tel.text) + space(li_space_cnt)

// 3
ls_write = ls_write + ls_tax_office_code
// 4
ls_write = ls_write + ls_date
// 5
ls_write = ls_write + '2'
// 6
ls_write = ls_write + space(6)
// 7
ls_write = ls_write + ls_business_no
// 8
ls_write = ls_write + ls_campus_name
// 법인명(영문) : 20040216
ls_write = ls_write + space(50)
// 9
ls_write = ls_write + ls_jumin_no
// 10
ls_write = ls_write + ls_president
// 11
ls_write = ls_write + ls_tel
// 12
//ls_write = ls_write + string(ll_tot_cnt, '00000')			// ??????????????
ls_write = ls_write + string(1, '00000')
// 13
ls_write = ls_write + '101'
// 14
ls_write = ls_write + '1'
// 15
ls_write = ls_write + space(1)
// 16
ls_write = ls_write + space(211)
			  
// 파일쓰기
filewrite(li_open_num, ls_write)

//select	count(jumin_no), nvl(sum(income_amt),0), nvl(sum(tax_amt),0), nvl(sum(jumin_amt),0)
//into		:ll_tot_cnt, :ldec_income_amt, :ldec_tax_amt, :ldec_jumin_amt
//from		fndb.hfn301h
//where		substr(yyyymm,1,4) = :as_year	;

select	count(*)
into		:ll_tot_cnt
from		fndb.hfn301h
where		substr(yyyymm,1,4) = :as_year	;

select	nvl(sum(income_amt),0), nvl(sum(tax_amt),0), nvl(sum(jumin_amt),0)
into		:ldec_income_amt, 		:ldec_tax_amt, 		:ldec_jumin_amt
from		fndb.hfn301h
where		substr(yyyymm,1,4) = :as_year	;

ls_write = ''
// B 레코드 - 원천징수의무자별 집계레코드
// 1
ls_write = 'B'
// 2
ls_write = ls_write + '23'
// 3
ls_write = ls_write + ls_tax_office_code
// 4
ls_write = ls_write + '000001'
// 5
ls_write = ls_write + ls_business_no
// 6
ls_write = ls_write + ls_campus_name
// 법인명(영문) : 20040216
ls_write = ls_write + space(50)
// 7
ls_write = ls_write + ls_president
// 8
ls_write = ls_write + ls_jumin_no
// 9
ls_write = ls_write + string(ll_tot_cnt, '0000000')
// 10
ls_write = ls_write + string(ldec_income_amt, '00000000000000')
// 11
ls_write = ls_write + string(ldec_tax_amt, '0000000000000')
// 12
ls_write = ls_write + '0000000000000'
// 13
ls_write = ls_write + string(ldec_jumin_amt, '0000000000000')
// 14
ls_write = ls_write + '0000000000000'
// 15
ls_write = ls_write + string(ldec_tax_amt + ldec_jumin_amt, '0000000000000')
// 16
ls_write = ls_write + space(1)
// 17
ls_write = ls_write + space(158)
			  
// 파일쓰기
filewrite(li_open_num, ls_write)

// C 레코드 - 기타소득자 레코드
declare cur_gita cursor for
select	income_name, 	jumin_no, 	geju_gubun, 	nvl(income_class, 0), 	pay_date, 	yyyymm,
			pay_amt, 		need_amt, 	income_amt, 	income_rate, 				tax_amt, 	jumin_amt, 
			nvl(income_juso, ' '),		nvl(foreign_type, '1')
from		fndb.hfn301h
where		substr(yyyymm,1,4) = :as_year
order by jumin_no, yyyymm	;

open cur_gita	;

fetch cur_gita 
into 		:ls_income_name, 	:ls_jumin_no, 		:ls_geju_gubun, 	:li_income_class, :ls_pay_date, 	:ls_yyyymm,
			:ldec_pay_amt, 	:ldec_need_amt, 	:ldec_income_amt, :li_income_rate, 	:ldec_tax_amt, :ldec_jumin_amt, 
			:ls_income_juso,	:ls_foreign_type	;

do while sqlca.sqlcode = 0
	ll_cnt ++
	
	li_space_cnt = 30 - len(trim(ls_income_name))
	ls_income_name = trim(ls_income_name) + space(li_space_cnt)
	li_space_cnt = 13 - len(trim(ls_jumin_no))
	ls_jumin_no = trim(ls_jumin_no) + space(li_space_cnt)
	li_space_cnt = 8 - len(trim(ls_pay_date))
	ls_pay_date = trim(ls_pay_date) + space(li_space_cnt)
	li_space_cnt = 80 - len(trim(ls_income_juso))
	ls_income_juso = trim(ls_income_juso) + space(li_space_cnt)

	if ls_geju_gubun = 'Y' then
		ls_geju_gubun = '1'
	else
		ls_geju_gubun = '2'
	end if
	
	ls_write = ''
	// 1
	ls_write = 'C'
	// 2
	ls_write = ls_write + '23'
	// 3
	ls_write = ls_write + ls_tax_office_code
	// 4
	ls_write = ls_write + string(ll_cnt, '000000')
	// 5
	ls_write = ls_write + ls_business_no
	// 6
	ls_write = ls_write + space(10)
	// 7
	ls_write = ls_write + space(40)
	// 8
	ls_write = ls_write + ls_income_name
	// 9
	ls_write = ls_write + ls_jumin_no
	// 주소 : 20040216
	ls_write = ls_write + ls_income_juso
	// 10
	ls_write = ls_write + ls_geju_gubun
	// 11
	ls_write = ls_write + space(2)
	// 12		//내외국인구분
	ls_write = ls_write + ls_foreign_type
	// 13
	ls_write = ls_write + string(li_income_class, '00')
	// 14
	ls_write = ls_write + ls_pay_date
	// 15
	ls_write = ls_write + ls_yyyymm
	
	// 16
	if ldec_pay_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_pay_amt, '00000000000')
	else
		ls_write = ls_write + '0' + string(ldec_pay_amt, '00000000000')
	end if
	// 17
	if ldec_need_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_need_amt, '00000000000')
	else
		ls_write = ls_write + '0' + string(ldec_need_amt, '00000000000')
	end if
	// 18
	if ldec_income_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_income_amt, '00000000000')
	else
		ls_write = ls_write + '0' + string(ldec_income_amt, '00000000000')
	end if
	// 19
	ls_write = ls_write + string(li_income_rate, '00')
	// 20
	if ldec_tax_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_tax_amt, '000000000')
	else
		ls_write = ls_write + '0' + string(ldec_tax_amt, '000000000')
	end if
	// 21
	ls_write = ls_write + '0' + '000000000'
	// 22
	if ldec_jumin_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_jumin_amt, '000000000')
	else
		ls_write = ls_write + '0' + string(ldec_jumin_amt, '000000000')
	end if
	// 23
	ls_write = ls_write + '0' + '000000000'
	// 24
	if ldec_tax_amt + ldec_jumin_amt < 0 then
		ls_write = ls_write + '1' + string(ldec_tax_amt + ldec_jumin_amt, '000000000')
	else
		ls_write = ls_write + '0' + string(ldec_tax_amt + ldec_jumin_amt, '000000000')
	end if
	// 25
	ls_write = ls_write + space(50) + ls_pay_date + space(1) + space(38)
	
	// 파일쓰기
	filewrite(li_open_num, ls_write)
	
	fetch cur_gita 
	into :ls_income_name, 	:ls_jumin_no, 		:ls_geju_gubun, 	:li_income_class, :ls_pay_date, 	:ls_yyyymm,
		  :ldec_pay_amt, 		:ldec_need_amt, 	:ldec_income_amt, :li_income_rate, 	:ldec_tax_amt, :ldec_jumin_amt, 
		  :ls_income_juso,	:ls_foreign_type	;
loop

close cur_gita	;

sle_a.text = '1'
sle_b.text = '1'
sle_c.text = string(ll_cnt)

// 파일닫기
fileclose(li_open_num)

end subroutine

on w_hfn604b.create
int iCurrent
call super::create
this.sle_name=create sle_name
this.sle_sosok=create sle_sosok
this.st_9=create st_9
this.st_3=create st_3
this.sle_c=create sle_c
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
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_list=create dw_list
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_name
this.Control[iCurrent+2]=this.sle_sosok
this.Control[iCurrent+3]=this.st_9
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.sle_c
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.sle_b
this.Control[iCurrent+8]=this.st_7
this.Control[iCurrent+9]=this.sle_a
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.em_date
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.sle_tel
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.em_year
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.ddlb_gubun
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.dw_list
this.Control[iCurrent+22]=this.cb_1
end on

on w_hfn604b.destroy
call super::destroy
destroy(this.sle_name)
destroy(this.sle_sosok)
destroy(this.st_9)
destroy(this.st_3)
destroy(this.sle_c)
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
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_list)
destroy(this.cb_1)
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
//ddlb_gubun.selectitem(1)
//
//em_year.text = mid(ls_sysdate,1,4)
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

em_year.text = mid(ls_sysdate,1,4)

em_date.text = string(ls_sysdate, '@@@@/@@/@@')

end event

type ln_templeft from w_msheet`ln_templeft within w_hfn604b
integer beginy = 84
integer endy = 2368
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn604b
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn604b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn604b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn604b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn604b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn604b
end type

type uc_insert from w_msheet`uc_insert within w_hfn604b
end type

type uc_delete from w_msheet`uc_delete within w_hfn604b
end type

type uc_save from w_msheet`uc_save within w_hfn604b
end type

type uc_excel from w_msheet`uc_excel within w_hfn604b
end type

type uc_print from w_msheet`uc_print within w_hfn604b
end type

type st_line1 from w_msheet`st_line1 within w_hfn604b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn604b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn604b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn604b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn604b
end type

type sle_name from singlelineedit within w_hfn604b
integer x = 3625
integer y = 176
integer width = 279
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_sosok from singlelineedit within w_hfn604b
integer x = 2336
integer y = 176
integer width = 279
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within w_hfn604b
integer x = 3410
integer y = 192
integer width = 210
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
string text = "담당자"
boolean focusrectangle = false
end type

type st_3 from statictext within w_hfn604b
integer x = 2062
integer y = 192
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
string text = "담당부서"
boolean focusrectangle = false
end type

type sle_c from singlelineedit within w_hfn604b
integer x = 2144
integer y = 384
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

type st_8 from statictext within w_hfn604b
integer x = 1810
integer y = 400
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

type sle_b from singlelineedit within w_hfn604b
integer x = 1289
integer y = 384
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

type st_7 from statictext within w_hfn604b
integer x = 955
integer y = 400
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

type sle_a from singlelineedit within w_hfn604b
integer x = 434
integer y = 384
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

type st_6 from statictext within w_hfn604b
integer x = 96
integer y = 400
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

type em_date from editmask within w_hfn604b
integer x = 1595
integer y = 176
integer width = 439
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

type st_5 from statictext within w_hfn604b
integer x = 745
integer y = 192
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
string text = "귀속년도"
boolean focusrectangle = false
end type

type sle_tel from singlelineedit within w_hfn604b
integer x = 2917
integer y = 176
integer width = 457
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

type st_4 from statictext within w_hfn604b
integer x = 2647
integer y = 192
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

type em_year from editmask within w_hfn604b
integer x = 1015
integer y = 176
integer width = 270
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

type st_1 from statictext within w_hfn604b
integer x = 1321
integer y = 192
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

type ddlb_gubun from dropdownlistbox within w_hfn604b
integer x = 361
integer y = 180
integer width = 357
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
string item[] = {"기타소득","사업소득"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case finditem(text, 0)
	case 1
		dw_list.dataobject 	= 'd_hfn604b_1'
	case 2
		dw_list.dataobject 	= 'd_hfn604b_2'
end choose

//dw_list.settransobject(sqlca)
dw_list.triggerevent(constructor!)

end event

type st_2 from statictext within w_hfn604b
integer x = 96
integer y = 192
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

type gb_1 from groupbox within w_hfn604b
integer x = 50
integer y = 112
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

type gb_2 from groupbox within w_hfn604b
integer x = 50
integer y = 312
integer width = 4384
integer height = 200
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "생성 결과"
end type

type dw_list from uo_dwgrid within w_hfn604b
integer x = 50
integer y = 512
integer width = 4384
integer height = 1760
integer taborder = 70
string dataobject = "d_hfn604b_1"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type cb_1 from uo_imgbtn within w_hfn604b
integer x = 3401
integer y = 384
integer taborder = 60
boolean bringtotop = true
string btnname = "지급조서생성"
end type

event clicked;call super::clicked;string	ls_file_name
string	ls_business_no
long		ll_cnt
integer	li_rtn

if not isdate(em_date.text) then
	messagebox('확인', '제출일자를 올바르게 입력하시기 바랍니다.')
	em_date.setfocus()
	return
end if

if isnull(sle_sosok.text) or trim(sle_sosok.text) = '' then
	messagebox('확인', '담당부서를 입력하시기 바랍니다.')
	sle_sosok.setfocus()
	return
end if
if isnull(sle_tel.text) or trim(sle_tel.text) = '' then
	messagebox('확인', '전화번호를 입력하시기 바랍니다.')
	sle_tel.setfocus()
	return
end if
if isnull(sle_name.text) or trim(sle_name.text) = '' then
	messagebox('확인', '담당자를 입력하시기 바랍니다.')
	sle_name.setfocus()
	return
end if

dw_list.reset()

// 생성 대상자료 Check
if ddlb_gubun.finditem(ddlb_gubun.text, 0) = 1 then
	select	count(jumin_no)
	into		:ll_cnt
	from		fndb.hfn301h
	where		substr(yyyymm,1,4) = :em_year.text	;
else
	select	count(jumin_no)
	into		:ll_cnt
	from		fndb.hfn302h
	where		substr(yyyymm,1,4) = :em_year.text	;
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
	ls_file_name = 'G' + mid(ls_business_no,1,7) + '.' + mid(ls_business_no,8)
else
	ls_file_name = 'F' + mid(ls_business_no,1,7) + '.' + mid(ls_business_no,8)
end if

if ll_cnt < 1 then
	messagebox('확인', '생성대상 자료가 없습니다.')
	return
end if

li_rtn = getfilesavename('저장화일 선택', ls_file_name, ls_file_name, '', '모든화일 (*.*),*.*')

if li_rtn < 1 then return



dw_list.retrieve(em_year.text)

if ddlb_gubun.finditem(ddlb_gubun.text, 0) = 1 then
	wf_hfn301h_proc(ls_file_name, em_year.text)
else
	wf_hfn302h_proc(ls_file_name, em_year.text)
end if



end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

