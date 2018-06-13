$PBExportHeader$w_hpa211b.srw
$PBExportComments$급여 대상자 기초자료 생성
forward
global type w_hpa211b from w_tabsheet
end type
type gb_6 from groupbox within tabpage_sheet01
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type gb_3 from groupbox within tabpage_sheet01
end type
type rb_1 from radiobutton within tabpage_sheet01
end type
type rb_2 from radiobutton within tabpage_sheet01
end type
type dw_dept1 from datawindow within tabpage_sheet01
end type
type st_31 from statictext within tabpage_sheet01
end type
type dw_list002_back from cuo_dwwindow within tabpage_sheet01
end type
type st_3 from statictext within tabpage_sheet01
end type
type st_4 from statictext within tabpage_sheet01
end type
type uo_yearmonth1 from cuo_yearmonth within tabpage_sheet01
end type
type uo_yearmonth2 from cuo_yearmonth within tabpage_sheet01
end type
type dw_list002 from uo_dwgrid within tabpage_sheet01
end type
type pb_create1 from uo_imgbtn within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type pb_create2 from uo_imgbtn within tabpage_sheet02
end type
type dw_list004 from uo_dwgrid within tabpage_sheet02
end type
type gb_21 from groupbox within tabpage_sheet02
end type
type st_1 from statictext within tabpage_sheet02
end type
type dw_list003_back from cuo_dwwindow within tabpage_sheet02
end type
type dw_list004_back from cuo_dwwindow within tabpage_sheet02
end type
type st_311 from statictext within tabpage_sheet02
end type
type st_32 from statictext within tabpage_sheet02
end type
type rb_3 from radiobutton within tabpage_sheet02
end type
type rb_4 from radiobutton within tabpage_sheet02
end type
type dw_dept2 from datawindow within tabpage_sheet02
end type
type uo_yearmonth3 from cuo_yearmonth within tabpage_sheet02
end type
type em_pay_date from editmask within tabpage_sheet02
end type
type st_2 from statictext within tabpage_sheet02
end type
type rb_member from radiobutton within tabpage_sheet02
end type
type rb_all from radiobutton within tabpage_sheet02
end type
type uo_insa from cuo_insa_member within tabpage_sheet02
end type
type dw_list003 from uo_dwgrid within tabpage_sheet02
end type
type gb_61 from groupbox within tabpage_sheet02
end type
type gb_32 from groupbox within tabpage_sheet02
end type
type gb_1 from groupbox within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
pb_create2 pb_create2
dw_list004 dw_list004
gb_21 gb_21
st_1 st_1
dw_list003_back dw_list003_back
dw_list004_back dw_list004_back
st_311 st_311
st_32 st_32
rb_3 rb_3
rb_4 rb_4
dw_dept2 dw_dept2
uo_yearmonth3 uo_yearmonth3
em_pay_date em_pay_date
st_2 st_2
rb_member rb_member
rb_all rb_all
uo_insa uo_insa
dw_list003 dw_list003
gb_61 gb_61
gb_32 gb_32
gb_1 gb_1
end type
type st_19 from statictext within w_hpa211b
end type
type em_incentive_per from editmask within w_hpa211b
end type
type st_20 from statictext within w_hpa211b
end type
end forward

global type w_hpa211b from w_tabsheet
string title = "급여 대상자 기초자료 생성"
st_19 st_19
em_incentive_per em_incentive_per
st_20 st_20
end type
global w_hpa211b w_hpa211b

type variables
datawindowchild	idw_child
datawindow			idw_preview, idw_data 
datawindow			idw_1, idw_2, idw_3, idw_4, idw_dept1, idw_dept2

statictext			ist_back

string		is_dept1, is_dept2, is_yearmonth1, is_yearmonth2, is_yearmonth3, is_today

string		is_member			// 조회용 개인번호
end variables

forward prototypes
public function integer wf_retrieve ()
public function integer wf_create1 ()
public subroutine wf_getchild ()
public function integer wf_create2 ()
end prototypes

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

integer	li_tab

li_tab	=	tab_sheet.selectedtab

if li_tab = 1 then
	idw_1.setredraw(false)
	idw_2.setredraw(false)

	idw_1.retrieve(is_yearmonth1, is_dept1, '')
	idw_2.retrieve(is_yearmonth2, is_dept1, '')

	idw_2.setredraw(true)
	idw_1.setredraw(true)
else
	if tab_sheet.tabpage_sheet02.rb_all.checked then
		is_member	=	''
	else
		is_member	= tab_sheet.tabpage_sheet02.uo_insa.is_MemberNo
		If isnull(is_member) or trim(is_member) = '' Then
			f_messagebox('1', '생성할 교/직원을 선택해 주시기 바랍니다.!')
			tab_sheet.tabpage_sheet02.uo_insa.sle_kname.SetFocus()
			return	100
		End if
	end if

	idw_3.setredraw(false)
	idw_4.setredraw(false)

	idw_3.retrieve(is_yearmonth3, is_dept2, is_member)
	idw_4.retrieve(is_yearmonth3, is_dept2, is_member)
	
	idw_4.setredraw(true)
	idw_3.setredraw(true)
end if

return	0

end function

public function integer wf_create1 ();//// ==========================================================================================
//// 기    능 : 	급여대상자기초자료생성(전월)
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 함수원형 : 	wf_create1()	return	integer
//// 인    수 :
//// 되 돌 림 :	sqlca.sqlcode
//// 주의사항 :
//// 수정사항 :
//// ==========================================================================================
//
//long		ll_rowcount
//
//// 급여자료 체크(급여확정을 마친 상태이면 급여 마스타를 재생성할 수 없다.)
//if	f_getconfirm(is_yearmonth2, 'Y')	>	0	then	return	100
//
//// 기존의 자료 체크
//if idw_1.retrieve(is_yearmonth1, is_dept1) < 1 then
//	f_messagebox('1', string(is_yearmonth1, '@@@@년 @@월') + '의 자료가 존재하지 않습니다.!')
//	return	100
//end if
//
//// 급여자료 체크
//select	count(*)
//into		:ll_rowcount
//from		padb.hpa005d a, padb.hpa001m b
//where		a.year_month	=		:is_yearmonth2
//and		b.gwa				like	:is_dept1	|| '%'
//and		a.year_month	=		b.year_month
//and		a.member_no		=		b.member_no	;
//
//if ll_rowcount > 0 then
//	if f_messagebox('2', string(is_yearmonth2, '@@@@년 @@월') + '의 급여를 이미 생성하셨습니다.~n~n삭제후 다시 생성하시겠습니까?') = 1 then
//
//		// 입력,명절항목을 제외한 모든 항목을 삭제한다.
//		delete	from	padb.hpa005d
//		where		year_month	=	:is_yearmonth2
//		and		member_no	in	(	select	member_no
//											from		padb.hpa001m
//											where		year_month	=		:is_yearmonth2
//											and		gwa	like	:is_dept1 || '%'	)	
//		and		code	 not in	(	select	code
//											from		padb.hpa003m
//											where		opt	in	(3, 4)	)	;
//
//		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
//
////		delete	from	padb.hpa015m
////		where		year_month	=	:is_yearmonth3
////		and		member_no	in	(	select	member_no
////											from		padb.hpa001m
////											where		year_month	=		:is_yearmonth3
////											and		gwa	like	:is_dept2 || '%'	)	;
////
////		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
//	end if
//end if
//		
////if ll_rowcount > 0 then
////	f_messagebox('1', string(is_yearmonth2, '@@@@년 @@월') + '의 급여를 이미 생성하셨습니다.~n~n전산실에 문의하시기 바랍니다.!')
////	return	100
////end if
//
//// 생성할 자료 체크
//if idw_2.retrieve(is_yearmonth2, is_dept1) > 0 then
//	if f_messagebox('2', string(is_yearmonth2, '@@@@년 @@월') + '의 자료가 이미 존재합니다~n~n삭제후 다시 생성하시겠습니까?') = 1 then
//		delete	from	padb.hpa001m
//		where		year_month	=		:is_yearmonth2
//		and		gwa	like	:is_dept1 || '%'	;
//		
//		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
//	else
//		return	100
//	end if
//else
//	if f_messagebox('2', string(is_yearmonth2, '@@@@년 @@월') + '의 자료를 생성하시겠습니까?') <> 1 then	return	100
//end if
//
//idw_2.reset()
//
//string	ls_day, ls_yymm, ls_curryear, ls_today
//
//ls_day		=	right(is_today, 2)
//ls_yymm 		=	left(is_today, 6)
//ls_curryear	=	left(is_yearmonth3, 4)
//
//ls_today = string(is_today, '@@@@/@@/@@')
//
//// Insert
//insert	into	padb.hpa001m
//		(	member_no, year_month, name, jumin_no, gwa, jikjong_code, jikwi_code, duty_code, 
//			sal_class, jikmu_code, bojik_code, salary, jaejik_opt, first_date, retire_date, 
//			work_year, ann_opt, 
//			num_of_paywork, 
//			num_of_bonwork, 
//			num_of_healthwork, num_of_abs, num_of_long, wife_num, family_num, support_20, support_60, handycap, old_num, 
//			hakbi1_yn, hakbi2_yn, hakbi3_yn, iphak_amt, hakgy_amt, gisung_amt, overtime_num, woman,
//			etc_saving, etc_gongje, contribution, sangjo_opt, union_opt, pay_opt, old_gwa, 
//			live_cnt, license_opt, change_opt, 
//			food_nontax_amt, youngu_nontax_amt, youngubojo_nontax_amt, jikgubbojo_nontax_amt,
//			confirm_gbn,
//			worker, ipaddr, work_date,
//			job_uid, job_add, job_date	)
//
//select	member_no, :is_yearmonth2, name, jumin_no, gwa, jikjong_code, jikwi_code, duty_code,
//			sal_class, jikmu_code, bojik_code, salary, jaejik_opt, first_date, retire_date, 
//			work_year, nvl(ann_opt, 1), 
//			case	
//				when		a.retire_date is null or rtrim(a.retire_date) = ''
//					then	to_number(to_char(last_day(to_date(:ls_today)), 'dd'))
//				when		to_number(a.retire_date) > 0 and substr(a.retire_date, 1, 6) = substr(a.firsthire_date, 1, 6)
//					then	to_number(substr(a.retire_date, 7, 2)) - to_number(substr(a.firsthire_date, 7, 2)) + 1
//				when		to_number(a.retire_date) > 0 and substr(a.retire_date, 1, 6) <> substr(a.firsthire_date, 1, 6) and
//							substr(a.retire_date, 1, 6) = :is_yearmonth3
//					then	to_number(substr(a.retire_date, 7, 2))
//				when		to_number(a.retire_date) > 0 and substr(a.retire_date, 1, 6) <> substr(a.firsthire_date, 1, 6) and
//							substr(a.retire_date, 1, 6) <> :is_yearmonth3
//					then	to_number(to_char(last_day(to_date(:ls_today)), 'dd'))
//				else		0
//			end,
//			num_of_bonwork, 
//			num_of_healthwork, num_of_abs, num_of_long, wife_num, family_num, support_20, support_60, handycap, old_num, 
//			hakbi1_yn, hakbi2_yn, hakbi3_yn, iphak_amt, hakgy_amt, gisung_amt, overtime_num, woman,
//			etc_saving, etc_gongje, contribution, sangjo_opt, union_opt, pay_opt, old_gwa, 
//			live_cnt, license_opt, change_opt,
//			food_nontax_amt, youngu_nontax_amt, youngubojo_nontax_amt, jikgubbojo_nontax_amt,
//			0,
//			:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate,
//			:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate
//from		padb.hpa001m
//where		year_month	=		:is_yearmonth1
//and		gwa	like	:is_dept1 || '%'	;
//
//if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
//
return	sqlca.sqlcode

end function

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

// 학과명(tabpage1)
idw_dept1.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('') < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_dept1.reset()
idw_dept1.insertrow(0)

// 학과명(tabpage2)
idw_dept2.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('') < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_dept2.reset()
idw_dept2.insertrow(0)

// 직위명
idw_1.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_2.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_3.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_4.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 성별코드
idw_3.getchild('sex_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('sex_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 국적코드
idw_3.getchild('nation_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('kukjuk_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if


end subroutine

public function integer wf_create2 ();// ==========================================================================================
// 기    능 : 	급여대상자기초자료생성(인사->급여)
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create2()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long		ll_rowcount
string	ls_first_date, ls_retire_date
integer	li_work_year, li_incentive_per

//// 생성조건 체크
//if trim(is_yearmonth3) = '' or trim(is_yearmonth3) = '000000' then

// 급여자료 체크(급여확정을 마친 상태이면 급여 마스타를 재생성할 수 없다.)
if	f_getconfirm('%', is_yearmonth3, 'Y')	>	0	then	return	100

if wf_retrieve() = 100	then	return	100

// 기존의 자료 체크
if idw_3.rowcount() < 1 then
	f_messagebox('1', '인사기본 자료가 존재하지 않습니다.!')
	return	100
end if
//messageBox('',is_yearmonth3)
// 급여자료 체크
select	count(*)
into		:ll_rowcount
from		padb.hpa005d a, padb.hpa001m b
where		a.year_month	=		:is_yearmonth3
and		b.gwa				like	:is_dept2	|| '%'
and		a.member_no		like	:is_member	|| '%'	
and		a.year_month	=		b.year_month
and		a.member_no		=		b.member_no	;

if ll_rowcount > 0 then
	if f_messagebox('2', string(is_yearmonth3, '@@@@년 @@월') + '의 급여를 이미 생성하셨습니다.~n~n삭제후 다시 생성하시겠습니까?') = 1 then

		// 입력,명절항목을 제외한 모든 항목을 삭제한다.
		delete	from	padb.hpa005d
		where		year_month	=	:is_yearmonth3
		and		member_no	in	(	select	member_no
											from		padb.hpa001m
											where		year_month	=		:is_yearmonth3
											and		gwa			like	:is_dept2 	|| '%'	
											and		member_no	like	:is_member	|| '%'	)
		and		code	 not in	(	select	code
											from		padb.hpa003m
											where		opt	=	3	)	;

		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

	end if
end if
		
// 생성할 자료 체크
if idw_4.retrieve(is_yearmonth3, is_dept2, is_member) > 0 then
	if f_messagebox('2', string(is_yearmonth3, '@@@@년 @@월') + '의 기초 자료가 이미 존재합니다~n~n삭제후 다시 생성하시겠습니까?') = 1 then
		delete	from	padb.hpa001m
		where		year_month	=		:is_yearmonth3
		and		gwa			like	:is_dept2 	|| '%'	
		and		member_no	like	:is_member	||	'%'	;
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	else
		return	100
	end if
else
	if f_messagebox('2', string(is_yearmonth3, '@@@@년 @@월') + '의 자료를 생성하시겠습니까?') <> 1 then	return	100
end if

idw_4.reset()

string	ls_curryear, ls_member_no, ls_yymm, ls_day, ls_today
integer	i, li_max

ls_day		=	right(is_today, 2)
ls_yymm 		=	left(is_today, 6)
ls_curryear	=	left(is_yearmonth3, 4)
ls_today		= 	string(is_today, '@@@@@@@@')

// Insert
insert	into	padb.hpa001m
		(	member_no, year_month, name, jumin_no, gwa, jikjong_code, jikwi_code, duty_code, sal_year,
			sal_class, jikmu_code, bojik_code, salary, jaejik_opt, 
			first_date, retire_date, work_year, ann_opt,
			num_of_paywork, 
			num_of_bonwork, career_ym, num_of_abs, num_of_long, 
			wife_num, 
			family_num,
			support_20, 
			support_60, 
			old_num, 
			handycap,
			contribution, 
			pay_opt, change_opt,
			FOOD_nontax_amt, YOUNGU_nontax_amt, YOUNGUBOJO_nontax_amt, JIKGUBBOJO_nontax_amt,
			use_day,
			confirm_gbn)	 
select	a.member_no, :is_yearmonth3, rtrim(name), jumin_no, a.gwa, nvl(b.jikjong_code, 0), jikwi_code, nvl(a.duty_code, 0), a.sal_year,
			nvl(a.sal_class, '0000'), jikmu_code, bojik_code1, nvl(c.sal_amt, 0), decode(a.jaejik_opt, 1, 1, 2), 
			a.firsthire_date, a.retire_date, a.career_ym, a.ann_opt,
			case			//firsthire_date 를 hakwonhire_date로 수정함(2003/02/19)
				when		(a.retire_date is null or rtrim(a.retire_date) = '') and substr(a.hakwonhire_date, 1, 6) = :is_yearmonth3
					then	to_number(to_char(last_day(to_date(:ls_today, 'yyyymmdd')), 'dd')) - to_number(substr(a.hakwonhire_date, 7, 2))
				when		(a.retire_date is null or rtrim(a.retire_date) = '') and substr(a.hakwonhire_date, 1, 6) <> :is_yearmonth3
					then	to_number(to_char(last_day(to_date(:ls_today, 'yyyymmdd')), 'dd'))
				when		to_number(a.retire_date) > 0 and substr(a.retire_date, 1, 6) = substr(a.hakwonhire_date, 1, 6)
					then	to_number(substr(a.retire_date, 7, 2)) - to_number(substr(a.hakwonhire_date, 7, 2)) + 1
				when		to_number(a.retire_date) > 0 and substr(a.retire_date, 1, 6) <> substr(a.hakwonhire_date, 1, 6) and
							substr(a.retire_date, 1, 6) = :is_yearmonth3
					then	to_number(substr(a.retire_date, 7, 2))
				when		to_number(a.retire_date) > 0 and substr(a.retire_date, 1, 6) <> substr(a.hakwonhire_date, 1, 6) and
							substr(a.retire_date, 1, 6) <> :is_yearmonth3
					then	to_number(to_char(last_day(to_date(:ls_today, 'yyyymmdd')), 'dd'))
				else		0
			end,
			0, a.career_ym, 0, a.career_ym,
			
//			//가족사항 인원구하기
//			(	select	decode(count(*), 1, 1, 0)
//				from		indb.hin019h
//				where		member_no		=	a.member_no
//				and		gwangae_code	in	(5)		//가족관계이다.(배우자)
//				and		sudang_yn		=	'1'	),
//			(	select	count(*)
//				from		(	select	member_no, 
//											nvl(handicap_opt, 0) as handicap_opt, 
//											(floor(round(months_between(to_date(:is_yearmonth3 || '01', 'yyyymmdd'), 
//												to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01', 'yyyymmdd')), 0) / 12) +
//											mod(round(months_between(to_date(:is_yearmonth3 || '01', 'yyyymmdd'), 
//												to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01', 'yyyymmdd')), 0), 12) * 0.01)
//											as exp
//								from		indb.hin019h
//								where		gwangae_code	in (8,9)) sub	//13은 자인데 19세 이하를 체크한다.
//				where		member_no	=	a.member_no
//				and		decode(sub.handicap_opt, 0, sub.exp, 0)	<=	20	)	+
//			(	select	count(*)
//				from		indb.hin019h
//				where		member_no		=	a.member_no
//				and		gwangae_code	in	(1, 2, 3, 4)  //부,모, 등이다.
//				and		sudang_yn		=	'1'	),
//			(	select	count(*)
//				from		(	select	member_no, (floor(round(months_between(to_date(:is_yearmonth3 || '01', 'yyyymmdd'), 
//												to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01', 'yyyymmdd')), 0) / 12) +
//											mod(round(months_between(to_date(:is_yearmonth3 || '01', 'yyyymmdd'), 
//												to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01', 'yyyymmdd')), 0), 12) * 0.01)
//											as exp
//								from		indb.hin019h
//								where		gwangae_code	not in (8, 9)	) sub		//부양자20세이하
//				where		member_no	=	a.member_no
//				and		sub.exp	<	21	),
//			(	select	count(*)
//				from		(	select	member_no, jumin_no,
//											(floor(round(months_between(to_date(:is_yearmonth3 || '01', 'yyyymmdd'), 
//												to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01', 'yyyymmdd')), 0) / 12) +
//											mod(round(months_between(to_date(:is_yearmonth3 || '01', 'yyyymmdd'), 
//												to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01', 'yyyymmdd')), 0), 12) * 0.01)
//											as exp
//								from		indb.hin019h
//								where		gwangae_code	not in (1, 2,3,4)	) sub		//부양자60세
//				where		member_no	=	a.member_no
//				and		sub.exp	> decode(substr(sub.jumin_no, 7, 1), '1', 59, '3', 59, 54 )	),
//			(	select	count(*)
//				from		(	select	member_no, (floor(round(months_between(to_date(:is_yearmonth3 || '01', 'yyyymmdd'), 
//												to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01', 'yyyymmdd')), 0) / 12) +
//											mod(round(months_between(to_date(:is_yearmonth3 || '01', 'yyyymmdd'), 
//												to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01', 'yyyymmdd')), 0), 12) * 0.01)
//											as exp
//								from		indb.hin019h
//								where		gwangae_code	not in (1, 2)	) sub			//경로우대
//				where		member_no	=	a.member_no
//				and		sub.exp		> 64	),
//			decode(nvl(d.handicap_opt, 0), 0, 0, 9),		//장애자
		
		   0,0,0,0,0,0,		   //가족사항해소시 삭자할 것.
			0,			            //기부금
			9, a.change_opt,		//급여지급구분, 변동구분
			0, 0, 0, 0, 			//비과세1,2,3,4
         0,							//년가사용일수
			0
from		indb.hin001m a, indb.hin003m b, indb.hin004m c, indb.hin011m d
where		gwa	like	:is_dept2 || '%'	
and		rtrim(a.duty_code)	=	rtrim(b.duty_code (+))
and		decode(a.ann_opt, 2, '801', decode(substr(a.duty_code, 1, 1), '1', '100', rtrim(a.duty_code)))	=	trim(c.duty_code(+))
and		a.sal_year  	=  c.sal_year (+)
and		a.sal_class	=	c.sal_class (+)
and		a.member_no		=	d.member_no (+)
and		(a.jaejik_opt	in (1, 2, 4)	or (retire_date like :is_yearmonth3 || '%'))
and		a.member_no		like	:is_member	|| '%'
and		a.duty_code		not	like	'3%'
order by a.member_no	;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

idw_4.setredraw(false)

ll_rowcount = idw_4.retrieve(is_yearmonth3, is_dept2, is_member) 

if ll_rowcount < 1 then	return 100

for i = 1 to ll_rowcount
	ls_member_no 	=	idw_4.getitemstring(i, 'member_no')
	ls_first_date	=	idw_4.getitemstring(i, 'first_date')
	ls_retire_date	=	idw_4.getitemstring(i, 'retire_date')
	li_work_year	= 	idw_4.getitemnumber(i, 'work_year')
	
//	// 근무년수를 구한다.
//	idw_4.setitem(i, 'work_year', f_getworkyear(ls_member_no, is_yearmonth3, is_today, ls_first_date))

	// 상여근무월수를 구한다.
	idw_4.setitem(i, 'num_of_bonwork',	f_getsangyeomonth(ls_member_no, is_yearmonth3, ls_first_date, ls_retire_date, is_today))
	
	if idw_4.getitemnumber(i, 'wife_num') = 0 then
		li_max = 4
	else
		li_max = 3
	end if
	
	if idw_4.getitemnumber(i, 'family_num') > li_max then	
		idw_4.setitem(i, 'family_num', li_max)
	end if
next

return	sqlca.sqlcode



end function

on w_hpa211b.create
int iCurrent
call super::create
this.st_19=create st_19
this.em_incentive_per=create em_incentive_per
this.st_20=create st_20
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_19
this.Control[iCurrent+2]=this.em_incentive_per
this.Control[iCurrent+3]=this.st_20
end on

on w_hpa211b.destroy
call super::destroy
destroy(this.st_19)
destroy(this.em_incentive_per)
destroy(this.st_20)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()

return 1
end event

event ue_insert;call super::ue_insert;///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타를 입력한다.                           //
//// 작성일자 : 2001. 08                                     //
//// 작 성 인 : 								                       //
///////////////////////////////////////////////////////////////
//
//integer	li_newrow, li_rank
//
//f_setpointer('START')
//
//idw_data.Selectrow(0, false)	
//
//li_newrow	=	idw_data.getrow() + 1
//idw_data.insertrow(li_newrow)
//
//idw_data.setrow(li_newrow)
//li_rank	= integer(idw_data.describe("evaluate('max(rank)', 1)"))
//li_rank ++
//
//idw_data.setitem(li_newrow, 'rank',	li_rank)
//
//idw_data.setcolumn('rank')
//idw_data.setfocus()
//
//f_setpointer('END')
//
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//string	ls_yymm, ls_pay_month
//
//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		fALSE)
//
//idw_1			=	tab_sheet.tabpage_sheet01.dw_list001
//idw_2			=	tab_sheet.tabpage_sheet01.dw_list002
//idw_dept1	=	tab_sheet.tabpage_sheet01.dw_dept1
//idw_3			=	tab_sheet.tabpage_sheet02.dw_list003
//idw_4			=	tab_sheet.tabpage_sheet02.dw_list004
//idw_dept2	=	tab_sheet.tabpage_sheet02.dw_dept2
//
//ls_yymm	=	left(f_today(), 6)
//
//tab_sheet.tabpage_sheet01.uo_yearmonth1.uf_settitle('지급년월')
//is_yearmonth1	=	tab_sheet.tabpage_sheet01.uo_yearmonth1.uf_getyearmonth()
//
//tab_sheet.tabpage_sheet01.uo_yearmonth2.uf_settitle('생성년월')
//is_yearmonth2	=	tab_sheet.tabpage_sheet01.uo_yearmonth2.uf_getyearmonth()
//
//idw_1.title = string(is_yearmonth1, '@@@@년 @@월') + ' 급여 기초 자료'
//idw_2.title = string(is_yearmonth2, '@@@@년 @@월') + ' 급여 기초 자료'
//
//tab_sheet.tabpage_sheet02.uo_yearmonth3.uf_settitle('생성년월')
//is_yearmonth3	=	tab_sheet.tabpage_sheet02.uo_yearmonth3.uf_getyearmonth()
//
//idw_4.title = string(is_yearmonth3, '@@@@년 @@월') + ' 급여 기초 자료'
//
//is_today = f_lastdate(is_yearmonth3)
//tab_sheet.tabpage_sheet02.em_pay_date.text = string(is_today, '@@@@/@@/@@')
//
//wf_getchild()
//
//tab_sheet.tabpage_sheet01.rb_1.checked = true
//tab_sheet.tabpage_sheet01.rb_1.triggerevent('clicked')
//
//tab_sheet.tabpage_sheet02.rb_3.checked = true
//tab_sheet.tabpage_sheet02.rb_3.triggerevent('clicked')
//
//tab_sheet.tabpage_sheet02.rb_all.triggerevent(clicked!)
//
//// Incentive Per
//select	substr(pay_month, to_number(substr(:is_yearmonth3, 5, 2)), 1)
//into		:ls_pay_month
//from		padb.hpa003m
//where		code	=	'28'	;
//
//if sqlca.sqlcode <> 0 or ls_pay_month	=	'0'	then
//	em_incentive_per.enabled	=	false
//	em_incentive_per.text		=	'0'
//else
//	em_incentive_per.enabled	=	true
//end if
//
//triggerevent('ue_retrieve')
//
////idw_3.setredraw(false)
////idw_4.setredraw(false)
////
////idw_3.retrieve(is_dept2)
////idw_4.retrieve(is_yearmonth3, is_dept2)
////
////idw_4.setredraw(true)
////idw_3.setredraw(true)
////
end event

event ue_save;call super::ue_save;///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타를 저장한다.		                       //
//// 작성일자 : 2001. 8                                      //
//// 작 성 인 : 						                             //
///////////////////////////////////////////////////////////////
//
//cuo_dwwindow	dw_name
//integer	li_findrow
//long		ll_currentrow
//
//f_setpointer('START')
//
//dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우
//
////li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
//IF dw_name.Update(true) = 1 THEN
//	COMMIT;
//	wf_retrieve2()
//ELSE
//  ROLLBACK;
//END IF
//
//f_setpointer('END')
return 1
//
end event

event ue_delete;call super::ue_delete;///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타를 삭제한다.                           //
//// 작성일자 : 2001. 08                                     //
//// 작 성 인 : 						                             //
///////////////////////////////////////////////////////////////
//
//integer		li_deleterow
//
//f_setpointer('START')

//wf_setMsg('삭제중')
//
//li_deleterow	=	idw_data.deleterow(0)
//
//wf_setMsg('.')
//f_setpointer('END')
//
//return 0
//
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF idw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, idw_print)

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

string	ls_yymm, ls_pay_month

//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		fALSE)

idw_1			=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_2			=	tab_sheet.tabpage_sheet01.dw_list002
idw_dept1	=	tab_sheet.tabpage_sheet01.dw_dept1
idw_3			=	tab_sheet.tabpage_sheet02.dw_list003
idw_4			=	tab_sheet.tabpage_sheet02.dw_list004
idw_dept2	=	tab_sheet.tabpage_sheet02.dw_dept2

ls_yymm	=	left(f_today(), 6)

tab_sheet.tabpage_sheet01.uo_yearmonth1.uf_settitle('지급년월')
is_yearmonth1	=	tab_sheet.tabpage_sheet01.uo_yearmonth1.uf_getyearmonth()

tab_sheet.tabpage_sheet01.uo_yearmonth2.uf_settitle('생성년월')
is_yearmonth2	=	tab_sheet.tabpage_sheet01.uo_yearmonth2.uf_getyearmonth()

idw_1.title = string(is_yearmonth1, '@@@@년 @@월') + ' 급여 기초 자료'
idw_2.title = string(is_yearmonth2, '@@@@년 @@월') + ' 급여 기초 자료'

tab_sheet.tabpage_sheet02.uo_yearmonth3.uf_settitle('생성년월')
is_yearmonth3	=	tab_sheet.tabpage_sheet02.uo_yearmonth3.uf_getyearmonth()

idw_4.title = string(is_yearmonth3, '@@@@년 @@월') + ' 급여 기초 자료'

is_today = f_lastdate(is_yearmonth3)
tab_sheet.tabpage_sheet02.em_pay_date.text = string(is_today, '@@@@/@@/@@')

wf_getchild()

tab_sheet.tabpage_sheet01.rb_1.checked = true
tab_sheet.tabpage_sheet01.rb_1.triggerevent('clicked')

tab_sheet.tabpage_sheet02.rb_3.checked = true
tab_sheet.tabpage_sheet02.rb_3.triggerevent('clicked')

tab_sheet.tabpage_sheet02.rb_all.triggerevent(clicked!)

// Incentive Per
select	substr(pay_month, to_number(substr(:is_yearmonth3, 5, 2)), 1)
into		:ls_pay_month
from		padb.hpa003m
where		code	=	'28'	;

if sqlca.sqlcode <> 0 or ls_pay_month	=	'0'	then
	em_incentive_per.enabled	=	false
	em_incentive_per.text		=	'0'
else
	em_incentive_per.enabled	=	true
end if

triggerevent('ue_retrieve')

//idw_3.setredraw(false)
//idw_4.setredraw(false)
//
//idw_3.retrieve(is_dept2)
//idw_4.retrieve(is_yearmonth3, is_dept2)
//
//idw_4.setredraw(true)
//idw_3.setredraw(true)
//
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa211b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa211b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa211b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa211b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa211b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa211b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa211b
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa211b
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa211b
end type

type uc_save from w_tabsheet`uc_save within w_hpa211b
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa211b
end type

type uc_print from w_tabsheet`uc_print within w_hpa211b
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa211b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa211b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa211b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa211b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa211b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa211b
integer y = 168
integer width = 4384
integer height = 2120
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		fALSE)
//	case 2
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose

end event

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
event create ( )
event destroy ( )
string tag = "N"
boolean visible = false
integer y = 104
integer width = 4347
integer height = 2000
string text = "급여대상자기초자료생성(전월)"
gb_6 gb_6
gb_2 gb_2
gb_3 gb_3
rb_1 rb_1
rb_2 rb_2
dw_dept1 dw_dept1
st_31 st_31
dw_list002_back dw_list002_back
st_3 st_3
st_4 st_4
uo_yearmonth1 uo_yearmonth1
uo_yearmonth2 uo_yearmonth2
dw_list002 dw_list002
pb_create1 pb_create1
end type

on tabpage_sheet01.create
this.gb_6=create gb_6
this.gb_2=create gb_2
this.gb_3=create gb_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_dept1=create dw_dept1
this.st_31=create st_31
this.dw_list002_back=create dw_list002_back
this.st_3=create st_3
this.st_4=create st_4
this.uo_yearmonth1=create uo_yearmonth1
this.uo_yearmonth2=create uo_yearmonth2
this.dw_list002=create dw_list002
this.pb_create1=create pb_create1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_6
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.dw_dept1
this.Control[iCurrent+7]=this.st_31
this.Control[iCurrent+8]=this.dw_list002_back
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.uo_yearmonth1
this.Control[iCurrent+12]=this.uo_yearmonth2
this.Control[iCurrent+13]=this.dw_list002
this.Control[iCurrent+14]=this.pb_create1
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_6)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_dept1)
destroy(this.st_31)
destroy(this.dw_list002_back)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.uo_yearmonth1)
destroy(this.uo_yearmonth2)
destroy(this.dw_list002)
destroy(this.pb_create1)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 408
integer width = 0
integer height = 0
boolean titlebar = true
string dataobject = "d_hpa211b_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

event dw_list001::retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

selectrow(0, false)
selectrow(1, true)

f_dw_find(idw_2, this, 'member_no')

end event

event dw_list001::rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

selectrow(0, false)
selectrow(currentrow, true)

f_dw_find(this, idw_2, 'member_no')

end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 408
integer width = 4338
integer height = 996
boolean titlebar = true
string title = ""
string dataobject = "d_hpa211b_1"
end type

event dw_update_tab::retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_2, this, 'member_no')

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_2, 'member_no')

end event

type uo_tab from w_tabsheet`uo_tab within w_hpa211b
integer x = 1655
integer y = 168
end type

type dw_con from w_tabsheet`dw_con within w_hpa211b
boolean visible = false
integer width = 0
integer height = 0
end type

type st_con from w_tabsheet`st_con within w_hpa211b
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type gb_6 from groupbox within tabpage_sheet01
integer x = 3401
integer y = 20
integer width = 946
integer height = 200
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_2 from groupbox within tabpage_sheet01
integer y = 20
integer width = 3392
integer height = 200
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "생성 조건"
end type

type gb_3 from groupbox within tabpage_sheet01
integer y = 200
integer width = 4347
integer height = 200
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type rb_1 from radiobutton within tabpage_sheet01
integer x = 283
integer y = 288
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "전체"
boolean checked = true
end type

event clicked;idw_dept1.enabled	=	false
idw_dept1.object.code.background.color = 78682240
is_dept1	=	''

rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)

rb_1.underline	=	true
rb_2.underline	=	false

wf_retrieve()
//parent.triggerevent('ue_retrieve')

end event

type rb_2 from radiobutton within tabpage_sheet01
integer x = 663
integer y = 288
integer width = 283
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "학과별"
end type

event clicked;idw_dept1.enabled	=	true
idw_dept1.object.code.background.color = rgb(255, 255, 255)
is_dept1		=	idw_dept1.getitemstring(idw_dept1.getrow(), 'code')

idw_dept1.setfocus()

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 255)

rb_1.underline	=	false
rb_2.underline	=	true

wf_retrieve()
//parent.triggerevent('ue_retrieve')

end event

type dw_dept1 from datawindow within tabpage_sheet01
integer x = 1449
integer y = 272
integer width = 1115
integer height = 92
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_sosok501_gwa_gubun"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) then return

is_dept1	=	trim(data)

wf_retrieve()
//parent.triggerevent('ue_retrieve')

end event

event rowfocuschanged;triggerevent(itemchanged!)

end event

type st_31 from statictext within tabpage_sheet01
integer x = 1024
integer y = 108
integer width = 270
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "의 자료를"
boolean focusrectangle = false
end type

type dw_list002_back from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 850
integer y = 1404
integer width = 0
integer height = 0
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_hpa211b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

selectrow(0, false)
selectrow(currentrow, true)

f_dw_find(this, idw_1, 'member_no')

end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

selectrow(0, false)
selectrow(1, true)

f_dw_find(idw_1, this, 'member_no')

end event

event constructor;call super::constructor;this.uf_setClick(false)
end event

type st_3 from statictext within tabpage_sheet01
integer x = 1198
integer y = 288
integer width = 219
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "학과명"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_sheet01
integer x = 2203
integer y = 108
integer width = 590
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "의 자료로 생성합니다."
boolean focusrectangle = false
end type

type uo_yearmonth1 from cuo_yearmonth within tabpage_sheet01
integer x = 251
integer y = 96
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;is_yearmonth1	=	uf_getyearmonth()

idw_1.title = string(is_yearmonth1, '@@@@년 @@월') + ' 급여 기초 자료'

//parent.triggerevent('ue_retrieve')
wf_retrieve()

end event

on uo_yearmonth1.destroy
call cuo_yearmonth::destroy
end on

type uo_yearmonth2 from cuo_yearmonth within tabpage_sheet01
integer x = 1413
integer y = 96
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

on uo_yearmonth2.destroy
call cuo_yearmonth::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yearmonth2	=	uf_getyearmonth()

idw_2.title = string(is_yearmonth2, '@@@@년 @@월') + ' 급여 기초 자료'

//parent.triggerevent('ue_retrieve')
wf_retrieve()

end event

type dw_list002 from uo_dwgrid within tabpage_sheet01
integer y = 1404
integer width = 4338
integer height = 596
integer taborder = 40
string dataobject = "d_hpa211b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_1, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_1, 'member_no')

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type pb_create1 from uo_imgbtn within tabpage_sheet01
event destroy ( )
integer x = 3671
integer y = 80
integer taborder = 60
boolean bringtotop = true
string btnname = "생성처리"
end type

on pb_create1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;// 생성처리한다.
integer	li_rtn

setpointer(hourglass!)

li_rtn	=	wf_create1()

setpointer(arrow!)

if	li_rtn = 0 then
	commit	;
	
	wf_retrieve()
	
	f_messagebox('1', string(idw_2.rowcount()) + '건의 자료를 생성했습니다.!')
elseif li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
	wf_retrieve()
end if
end event

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 2000
long backcolor = 16777215
string text = "급여대상자기초자료생성(인사→급여)"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_create2 pb_create2
dw_list004 dw_list004
gb_21 gb_21
st_1 st_1
dw_list003_back dw_list003_back
dw_list004_back dw_list004_back
st_311 st_311
st_32 st_32
rb_3 rb_3
rb_4 rb_4
dw_dept2 dw_dept2
uo_yearmonth3 uo_yearmonth3
em_pay_date em_pay_date
st_2 st_2
rb_member rb_member
rb_all rb_all
uo_insa uo_insa
dw_list003 dw_list003
gb_61 gb_61
gb_32 gb_32
gb_1 gb_1
end type

on tabpage_sheet02.create
this.pb_create2=create pb_create2
this.dw_list004=create dw_list004
this.gb_21=create gb_21
this.st_1=create st_1
this.dw_list003_back=create dw_list003_back
this.dw_list004_back=create dw_list004_back
this.st_311=create st_311
this.st_32=create st_32
this.rb_3=create rb_3
this.rb_4=create rb_4
this.dw_dept2=create dw_dept2
this.uo_yearmonth3=create uo_yearmonth3
this.em_pay_date=create em_pay_date
this.st_2=create st_2
this.rb_member=create rb_member
this.rb_all=create rb_all
this.uo_insa=create uo_insa
this.dw_list003=create dw_list003
this.gb_61=create gb_61
this.gb_32=create gb_32
this.gb_1=create gb_1
this.Control[]={this.pb_create2,&
this.dw_list004,&
this.gb_21,&
this.st_1,&
this.dw_list003_back,&
this.dw_list004_back,&
this.st_311,&
this.st_32,&
this.rb_3,&
this.rb_4,&
this.dw_dept2,&
this.uo_yearmonth3,&
this.em_pay_date,&
this.st_2,&
this.rb_member,&
this.rb_all,&
this.uo_insa,&
this.dw_list003,&
this.gb_61,&
this.gb_32,&
this.gb_1}
end on

on tabpage_sheet02.destroy
destroy(this.pb_create2)
destroy(this.dw_list004)
destroy(this.gb_21)
destroy(this.st_1)
destroy(this.dw_list003_back)
destroy(this.dw_list004_back)
destroy(this.st_311)
destroy(this.st_32)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.dw_dept2)
destroy(this.uo_yearmonth3)
destroy(this.em_pay_date)
destroy(this.st_2)
destroy(this.rb_member)
destroy(this.rb_all)
destroy(this.uo_insa)
destroy(this.dw_list003)
destroy(this.gb_61)
destroy(this.gb_32)
destroy(this.gb_1)
end on

type pb_create2 from uo_imgbtn within tabpage_sheet02
event destroy ( )
integer x = 3799
integer y = 92
integer taborder = 70
boolean bringtotop = true
string btnname = "생성처리"
end type

on pb_create2.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;// 생성처리한다.
integer	li_rtn

setpointer(hourglass!)

li_rtn	=	wf_create2()

setpointer(arrow!)

if	li_rtn = 0 then
	if idw_4.update() = 1 then
		commit	;

		idw_4.setredraw(true)
		
		wf_retrieve()
		f_messagebox('1', string(idw_4.rowcount()) + '건의 자료를 생성했습니다.!')
		
		return
	end if
elseif li_rtn = 100 then
		f_messagebox('1', '이미 확정작업을 하였습니다.')
	return
end if

f_messagebox('3', sqlca.sqlerrtext)
rollback	;
wf_retrieve()


end event

type dw_list004 from uo_dwgrid within tabpage_sheet02
integer y = 1496
integer width = 4347
integer height = 504
integer taborder = 90
boolean titlebar = true
string title = ""
string dataobject = "d_hpa211b_1"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_3, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_3, 'member_no')

end event

type gb_21 from groupbox within tabpage_sheet02
integer y = 24
integer width = 3611
integer height = 200
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "생성 조건"
end type

type st_1 from statictext within tabpage_sheet02
boolean visible = false
integer x = 1769
integer y = 176
integer width = 686
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "근무년수계산기준일자"
boolean focusrectangle = false
end type

type dw_list003_back from cuo_dwwindow within tabpage_sheet02
boolean visible = false
integer x = 754
integer y = 672
integer width = 0
integer height = 0
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "인사 기본 자료"
string dataobject = "d_hpa211b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(false)
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

selectrow(0, false)
selectrow(1, true)

f_dw_find(idw_4, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

selectrow(0, false)
selectrow(currentrow, true)

f_dw_find(this, idw_4, 'member_no')

end event

type dw_list004_back from cuo_dwwindow within tabpage_sheet02
boolean visible = false
integer x = 498
integer y = 1496
integer width = 9
integer height = 12
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_hpa211b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(false)
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

selectrow(0, false)
selectrow(1, true)

f_dw_find(idw_3, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

selectrow(0, false)
selectrow(currentrow, true)

f_dw_find(this, idw_3, 'member_no')

end event

type st_311 from statictext within tabpage_sheet02
integer x = 1024
integer y = 112
integer width = 590
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "의 자료를 생성합니다."
boolean focusrectangle = false
end type

type st_32 from statictext within tabpage_sheet02
integer x = 1198
integer y = 288
integer width = 219
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "학과명"
boolean focusrectangle = false
end type

type rb_3 from radiobutton within tabpage_sheet02
integer x = 283
integer y = 288
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "전체"
boolean checked = true
end type

event clicked;idw_dept2.enabled	=	false
idw_dept2.object.code.background.color = 78682240
is_dept2	=	''

rb_3.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)

rb_3.underline	=	true
rb_4.underline	=	false

wf_retrieve()
//parent.triggerevent('ue_retrieve')

end event

type rb_4 from radiobutton within tabpage_sheet02
integer x = 663
integer y = 288
integer width = 283
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "학과별"
end type

event clicked;idw_dept2.enabled	=	true
idw_dept2.object.code.background.color = rgb(255, 255, 255)
is_dept2		=	idw_dept2.getitemstring(idw_dept2.getrow(), 'code')

idw_dept2.setfocus()

rb_3.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 255)

rb_3.underline	=	false
rb_4.underline	=	true

wf_retrieve()
//parent.triggerevent('ue_retrieve')

end event

type dw_dept2 from datawindow within tabpage_sheet02
integer x = 1449
integer y = 272
integer width = 1120
integer height = 88
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_sosok501_gwa_gubun"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) then return

is_dept2	=	trim(data)

wf_retrieve()
//parent.triggerevent('ue_retrieve')

end event

event rowfocuschanged;triggerevent(itemchanged!)

end event

type uo_yearmonth3 from cuo_yearmonth within tabpage_sheet02
integer x = 251
integer y = 96
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;string	ls_pay_month

is_yearmonth3	=	uf_getyearmonth()

is_today = f_lastdate(is_yearmonth3)
em_pay_date.text = string(is_today, '@@@@/@@/@@')

idw_4.title = string(is_yearmonth3, '@@@@년 @@월') + ' 급여 기초 자료'

// Incentive Per
select	substr(pay_month, to_number(substr(:is_yearmonth3, 5, 2)), 1)
into		:ls_pay_month
from		padb.hpa003m
where		code	=	'28'	;

if sqlca.sqlcode <> 0 or ls_pay_month	=	'0'	then
	em_incentive_per.enabled	=	false
	em_incentive_per.text		=	'0'
else
	em_incentive_per.enabled	=	true
end if

//parent.triggerevent('ue_retrieve')
wf_retrieve()

end event

on uo_yearmonth3.destroy
call cuo_yearmonth::destroy
end on

type em_pay_date from editmask within tabpage_sheet02
integer x = 2313
integer y = 96
integer width = 489
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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

event modified;date		ldt_pay_date
string	ls_bef_date

ls_bef_date	=	 this.text

if getdata(ldt_pay_date) < 0 then
	f_messagebox('1', st_2.text + '를 정확히 입력해 주시기 바랍니다.!')
	this.text = ls_bef_date
	is_today = ''
end if

is_today	=	string(ldt_pay_date, 'yyyymmdd')

end event

type st_2 from statictext within tabpage_sheet02
integer x = 1874
integer y = 112
integer width = 425
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "처리기준일자"
boolean focusrectangle = false
end type

type rb_member from radiobutton within tabpage_sheet02
integer x = 347
integer y = 436
integer width = 288
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
string text = "개인별"
end type

event clicked;uo_insa.trigger event ue_enbled(true)
uo_insa.sle_kname.setfocus()
end event

type rb_all from radiobutton within tabpage_sheet02
integer x = 78
integer y = 436
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
string text = "전체"
boolean checked = true
end type

event clicked;uo_insa.trigger event ue_enbled(false)

end event

type uo_insa from cuo_insa_member within tabpage_sheet02
integer x = 713
integer y = 412
integer width = 3040
integer height = 156
integer taborder = 130
boolean bringtotop = true
end type

on uo_insa.destroy
call cuo_insa_member::destroy
end on

type dw_list003 from uo_dwgrid within tabpage_sheet02
integer y = 584
integer width = 4347
integer height = 908
integer taborder = 30
boolean titlebar = true
string title = "인사 기본 자료"
string dataobject = "d_hpa211b_2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_4, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_4, 'member_no')

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_61 from groupbox within tabpage_sheet02
integer x = 3616
integer y = 20
integer width = 731
integer height = 200
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_32 from groupbox within tabpage_sheet02
integer y = 200
integer width = 4347
integer height = 176
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_1 from groupbox within tabpage_sheet02
integer y = 356
integer width = 4347
integer height = 228
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
end type

type st_19 from statictext within w_hpa211b
boolean visible = false
integer x = 2843
integer y = 564
integer width = 311
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "인센티브%"
boolean focusrectangle = false
end type

type em_incentive_per from editmask within w_hpa211b
boolean visible = false
integer x = 3177
integer y = 548
integer width = 251
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##0"
boolean spin = true
double increment = 1
string minmax = "80~~200"
end type

type st_20 from statictext within w_hpa211b
boolean visible = false
integer x = 3442
integer y = 560
integer width = 608
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "(80% ~~ 200%)"
boolean focusrectangle = false
end type

