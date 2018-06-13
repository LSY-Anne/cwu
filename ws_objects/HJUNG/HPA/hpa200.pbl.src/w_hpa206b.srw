$PBExportHeader$w_hpa206b.srw
$PBExportComments$급여 대상자 기초자료 생성
forward
global type w_hpa206b from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type rb_7 from radiobutton within tabpage_sheet02
end type
type rb_6 from radiobutton within tabpage_sheet02
end type
type rb_5 from radiobutton within tabpage_sheet02
end type
type st_1 from statictext within tabpage_sheet02
end type
type dw_list003 from cuo_dwwindow within tabpage_sheet02
end type
type dw_list004 from cuo_dwwindow within tabpage_sheet02
end type
type gb_21 from groupbox within tabpage_sheet02
end type
type gb_61 from groupbox within tabpage_sheet02
end type
type st_311 from statictext within tabpage_sheet02
end type
type st_32 from statictext within tabpage_sheet02
end type
type rb_3 from radiobutton within tabpage_sheet02
end type
type rb_4 from radiobutton within tabpage_sheet02
end type
type pb_create2 from picturebutton within tabpage_sheet02
end type
type dw_dept2 from datawindow within tabpage_sheet02
end type
type uo_yearmonth3 from cuo_yearmonth within tabpage_sheet02
end type
type em_pay_date from editmask within tabpage_sheet02
end type
type st_2 from statictext within tabpage_sheet02
end type
type gb_1 from groupbox within tabpage_sheet02
end type
type rb_member from radiobutton within tabpage_sheet02
end type
type rb_all from radiobutton within tabpage_sheet02
end type
type uo_insa from cuo_insa_member within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
st_1 st_1
dw_list003 dw_list003
dw_list004 dw_list004
gb_21 gb_21
gb_61 gb_61
st_311 st_311
st_32 st_32
rb_3 rb_3
rb_4 rb_4
pb_create2 pb_create2
dw_dept2 dw_dept2
uo_yearmonth3 uo_yearmonth3
em_pay_date em_pay_date
st_2 st_2
gb_1 gb_1
rb_member rb_member
rb_all rb_all
uo_insa uo_insa
end type
end forward

global type w_hpa206b from w_tabsheet
integer width = 3936
integer height = 2724
string title = "급여 대상자 기초자료 생성"
end type
global w_hpa206b w_hpa206b

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
integer	li_work_year



// 급여자료 체크(급여확정을 마친 상태이면 급여 마스타를 재생성할 수 없다.)

//if	f_getconfirm(is_yearmonth3, 'Y')	>	0	then	return	100
LONG LL_JUDGE

SELECT COUNT(*)
  INTO :LL_JUDGE
  FROM PADB.HPA021M
 WHERE YEAR_MONTH = :is_yearmonth3
   AND CONFIRM_GBN = 9;

IF SQLCA.SQLCODE <> 0 THEN 
	MESSAGEBOX('','확정 테이블 ERROR 전산실로 연락 하십시요')
   RETURN sqlca.sqlcode 
END IF 

IF LL_JUDGE < 0 THEN
	MESSAGEBOX('','급여 확정 처리가 되었습니다.')
	RETURN 100
END IF



if wf_retrieve() = 100	then	return	100

// 기존의 자료 체크
if idw_3.rowcount() < 1 then
	f_messagebox('1', '인사기본 자료가 존재하지 않습니다.!')
	return	100
end if

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

		// 입력항목을 제외한 모든 항목을 삭제한다.
		delete	from	padb.hpa005d
		where		year_month	=	:is_yearmonth3
		and		member_no	in	(	select	member_no
											from		padb.hpa001m
											where		year_month	=		:is_yearmonth3
											and		gwa			like	:is_dept2 	|| '%'	
											and		member_no	like	:is_member	|| '%'	)
		and		code	 not in	(	select	code
											from		padb.hpa003m
											where		opt	= 3	)	;

		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

		// Hpa015m Clear
		delete	from	padb.hpa015m
		where		year_month	=	:is_yearmonth3
		and		member_no	in	(	select	member_no
											from		padb.hpa001m
											where		year_month		=		padb.hpa015m.year_month
											and		gwa				like	:is_dept2	||	'%'
											and		member_no		like	:is_member	||	'%'	)	;

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

string	ls_curryear, ls_member_no, ls_yymm, ls_day, ls_today, ls_month
integer	i, li_max, li_month

ls_day		=	right(is_today, 2)
ls_yymm 		=	left(is_today, 6)
ls_curryear	=	left(is_yearmonth3, 4)
//messagebox('',is_today)
ls_today = string(is_today, '@@@@/@@/@@')

li_month	=	integer(right(is_yearmonth3, 2))
ls_month	=	right(is_yearmonth3, 2)

string	ls_pay_code[], ls_nontax_code[]
string	ls_pay_month[], ls_nontax_month[]

ls_pay_code[]		=	{'13', '14'}					// 학비보조(중고)(13), 학비보조(대학)(14)
ls_nontax_code[]	=	{'17', '06', '10', '19'}	// 식대보조비(17), 연구비(06), 연구보조비(10), 직급보조비(19)

ls_nontax_code[1]	=	'17'

// 식대보조비(17), 연구비(06), 연구보조비(10), 직급보조비(19)의 마지막 지급월을 구한다.
for	i	=	2	to	4
	select	trim(to_char(nvl(instr(substr(pay_month, 1, :li_month - 1), '1', -1, 1), 0), '00'))
	into		:ls_nontax_month[i]
	from		padb.hpa003m
	where		code		=	:ls_nontax_code[i]
	and		substr(pay_month, :li_month, 1)	=	'1'	;
	
	if sqlca.sqlcode	<>	0	then	ls_nontax_month[i]	=	'00'
next

// 학비보조(중고)(13), 학비보조(대학)(14)의 마지막 지급월을 구한다.
for	i	=	1	to	2
	select	trim(to_char(nvl(instr(substr(pay_month, 1, :li_month - 1), '1', -1, 1), 0), '00'))
	into		:ls_pay_month[i]
	from		padb.hpa003m
	where		code		=	:ls_pay_code[i]
	and		substr(pay_month, :li_month, 1)	=	'1'	;
	
	if sqlca.sqlcode	<>	0	then	ls_pay_month[i]	=	'00'
next

// Insert
insert	into	padb.hpa001m
		(	member_no, year_month, name, jumin_no, gwa, jikjong_code, jikwi_code, 
			duty_code, sal_class,jikmu_code, bojik_code, salary, jaejik_opt, 
			first_date, retire_date, work_year, ann_opt,
			num_of_paywork, 
			num_of_bonwork, num_of_healthwork, num_of_abs, num_of_long, 
			handycap,
			contribution, pay_opt, change_opt,
			hakbi1_yn, hakbi2_yn, hakbi3_yn,
			iphak_amt, hakgy_amt, gisung_amt,
			worker, ipaddr,work_date,
			job_uid, job_add, job_date)
select	a.member_no, :is_yearmonth3, rtrim(a.name), a.jumin_no, a.gwa, TO_NUMBER(SUBSTR(A.DUTY_CODE,1,1)), jikwi_code, 
			nvl(a.duty_code, 0),			
         nvl(a.sal_class, ' '),a.jikmu_code, a.bojik_code1, nvl(c.sal_amt, 0), decode(a.jaejik_opt, 1, 1, 2), 
			a.firsthire_date, a.retire_date, a.career_ym, a.ann_opt,
			case	
				when		a.retire_date is null or rtrim(a.retire_date) = ''
					then	to_number(to_char(last_day(to_date(:is_today)), 'dd'))
				when		to_number(a.retire_date) > 0 and substr(a.retire_date, 1, 6) = substr(a.firsthire_date, 1, 6)
					then	to_number(substr(a.retire_date, 7, 2)) - to_number(substr(a.firsthire_date, 7, 2)) + 1
				when		to_number(a.retire_date) > 0 and substr(a.retire_date, 1, 6) <> substr(a.firsthire_date, 1, 6) and
							substr(a.retire_date, 1, 6) = :is_yearmonth3
					then	to_number(substr(a.retire_date, 7, 2))
				when		to_number(a.retire_date) > 0 and substr(a.retire_date, 1, 6) <> substr(a.firsthire_date, 1, 6) and
							substr(a.retire_date, 1, 6) <> :is_yearmonth3
					then	to_number(to_char(last_day(to_date(:is_today)), 'dd'))
				else		0
			end,/*num_of_paywork*/
			0, 0, 0, 0,
			decode(nvl(d.handicap_opt, 0), 0, 0, 9),
			0,
			9, a.change_opt,
         nvl(	(	select	nvl(hakbi1_yn, 0)
						from		padb.hpa001m
						where		substr(year_month, 1, 4)	=	:ls_curryear
						and		substr(year_month, 5, 2)	<	:ls_month
						and		year_month	=	:ls_curryear || :ls_pay_month[1]
						and		member_no	=	a.member_no	), 0),/*hakbi1_yn*/ 
			nvl(	(	select	nvl(hakbi2_yn, 0)
						from		padb.hpa001m
						where		substr(year_month, 1, 4)	=	:ls_curryear
						and		substr(year_month, 5, 2)	<	:ls_month
						and		year_month	=	:ls_curryear || :ls_pay_month[1]
						and		member_no	=	a.member_no	), 0),/*hakbi2_yn*/ 
			nvl(	(	select	nvl(hakbi3_yn, 0)
						from		padb.hpa001m
						where		substr(year_month, 1, 4)	=	:ls_curryear
						and		substr(year_month, 5, 2)	<	:ls_month
						and		year_month	=	:ls_curryear || :ls_pay_month[2]
						and		member_no	=	a.member_no	), 0),/*hakbi3_yn*/ 
			nvl(	(	select	nvl(iphak_amt, 0)
						from		padb.hpa001m
						where		substr(year_month, 1, 4)	=	:ls_curryear
						and		substr(year_month, 5, 2)	<	:ls_month
						and		year_month	=	:ls_curryear || :ls_pay_month[2]
						and		member_no	=	a.member_no	), 0),/*iphak_amt*/ 
			nvl(	(	select	nvl(hakgy_amt, 0)
						from		padb.hpa001m
						where		substr(year_month, 1, 4)	=	:ls_curryear
						and		substr(year_month, 5, 2)	<	:ls_month
						and		year_month	=	:ls_curryear || :ls_pay_month[2]
						and		member_no	=	a.member_no	), 0),/*hakgy_amt*/ 
			nvl(	(	select	nvl(gisung_amt, 0)
						from		padb.hpa001m
						where		substr(year_month, 1, 4)	=	:ls_curryear
						and		substr(year_month, 5, 2)	<	:ls_month
						and		year_month	=	:ls_curryear || :ls_pay_month[2]
						and		member_no	=	a.member_no	), 0),/*gisung_amt*/ 
			:gs_empcode, :gs_ip, sysdate,
			:gs_empcode, :gs_ip, sysdate
from		indb.hin001m a,  indb.hin004m c, indb.hin011m d
where		gwa	like	:is_dept2 || '%'	
and      decode(a.ann_opt,2,'801',DECODE(SUBSTR(A.DUTY_CODE,1,2),'10','100', a.duty_code)) = c.duty_code(+)
and		a.sal_class	=	c.sal_class (+)	
and		a.member_no	=	d.member_no (+)
and		a.jaejik_opt	in (1, 2, 4)
and		a.member_no		LIKE	:is_member	|| '%'
and		a.duty_code		not	like	'3%'		//시간강사는 급여에 포함하지 않는다.
and		c.sal_year		=		substr(:is_yearmonth3, 1, 4)
order by a.member_no	;


if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

//			(	select	nvl(sum(b.napip_amt), 0)
//				from		dndb.hdn001m a, dndb.hdn003h b
//				where		a.member_no		=	a.member_no
//				and		b.wolgup_month	=	:is_yearmonth3	
//				and		a.dm_no			=	b.dm_no	),

idw_4.setredraw(false)

ll_rowcount = idw_4.retrieve(is_yearmonth3, is_dept2, is_member)

if ll_rowcount < 1 then	return 100

for i = 1 to ll_rowcount
	ls_member_no 	=	idw_4.getitemstring(i, 'member_no')
	ls_first_date	=	idw_4.getitemstring(i, 'first_date')
	ls_retire_date	=	idw_4.getitemstring(i, 'retire_date')
	
	li_work_year = idw_4.getitemnumber(i, 'work_year')

//	// 근무년수를 구한다.
//	idw_4.setitem(i, 'work_year', f_getworkyear(ls_member_no, is_yearmonth3, is_today, ls_first_date))

	// 상여근무월수를 구한다.
//	idw_4.setitem(i, 'num_of_bonwork',	f_getsangyeomonth(ls_member_no, is_yearmonth3, ls_first_date, ls_retire_date, is_today))
//	
//	if idw_4.getitemnumber(i, 'wife_num') = 0 then
//		li_max = 4
//	else
//		li_max = 3
//	end if
//	
	if idw_4.getitemnumber(i, 'family_num') > li_max then	
		idw_4.setitem(i, 'family_num', li_max)
	end if
	
//long ll_pandan
// select count(*)
//   into :ll_pandan
//	  from indb.hin019h
//	 where  member_no = :ls_member_no
//	   and (length(jumin_no) < 13
//	   OR (SUBSTR(JUMIN_NO,3,2)  > 12 
//           OR SUBSTR(JUMIN_NO,3,2) = '00'));
//
//if sqlca.sqlcode <> 0 then return sqlca.sqlcode
//
//if ll_pandan = 0 then 
/*wife_num*/
update padb.hpa001m
set		wife_num = (	select	decode(count(*), 1, 1, 0)
	                       from		indb.hin019h
	                      where		member_no		=	:ls_member_no
		                     and		gwangae_code	=  5	
									and		sudang_yn		=	'1'	)
where	year_month	=		:is_yearmonth3
and		member_no	=	:ls_member_no;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

/*family_num*/
long ll_family_count1, ll_family_count2
	
	select	count(*)
	  into   :ll_family_count1
	  from		indb.hin019h
	 where		member_no		=	:ls_member_no
		and		gwangae_code	in	(8,9)				//자녀,
		and		sudang_yn		=	'1';		
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

   select	count(*)
	  into   :ll_family_count2
	  from  (	select	member_no, nvl(handicap_opt, 0) as handicap_opt, (floor(round(months_between(to_date(:is_yearmonth3 || '01'), 
								to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01')), 0) / 12) +
								mod(round(months_between(to_date(:is_yearmonth3 || '01'), 
								to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01')), 0), 12) * 0.01)
								as exp
						from   indb.hin019h
					  where		gwangae_code	=	9	
					    and   length(jumin_no) > 12) sub
	where		sub.member_no	=	:ls_member_no
	  and		decode(sub.handicap_opt, 0, sub.exp, 0)	<=	20;
	  
  if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode	 

  ll_family_count1 = ll_family_count1 + ll_family_count2

update padb.hpa001m
set   family_num = :ll_family_count1 
where	year_month	=		:is_yearmonth3
and		member_no	=	:ls_member_no;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode


/*support_20*/


update padb.hpa001m
   set support_20 = (	select	count(*)
							    from		(	select	member_no, nvl((floor(round(months_between(to_date(:is_yearmonth3 || '01','yyyymmdd'), 
															to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01','yyyymmdd')), 0) / 12) + 
							   							mod(round(months_between(to_date(:is_yearmonth3 || '01','yyyymmdd'), 
								   						to_date(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01','yyyymmdd')), 0), 12) * 0.01),0)
									            		as exp
												 from		indb.hin019h
												where		gwangae_code	IN (6,7,8,9)
												  and   length(jumin_no) > 12
												  and    member_no = :ls_member_no) sub
								 where	sub.exp	<	21	)
where	year_month	=		:is_yearmonth3
and		member_no	=	:ls_member_no;

if sqlca.sqlcode <> 0 then	return sqlca.sqlcode


//
/*support_60*/																			
											
update padb.hpa001m
  set support_60 = (	select	count(*)
							  from		(	select	member_no, jumin_no,
								    						nvl((floor(round(months_between(:is_yearmonth3 || '01', 
															decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01'), 0) / 12) +
										    				mod(round(months_between(:is_yearmonth3 || '01', 
															decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01'), 0), 12) * 0.01),0)
												   		as exp
												 from		indb.hin019h
												where		gwangae_code	not in (5)
												  and   length(jumin_no) > 12) sub
						    where		member_no	=	:ls_member_no
								and		sub.exp	> decode(substr(sub.jumin_no, 7, 1), '1', 59, '3', 59, 54 )	)
where	year_month	=		:is_yearmonth3
and		member_no	=	:ls_member_no;
if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode								

update padb.hpa001m
   set old_num =(	select	count(*)
						  from		(	select	member_no, nvl((floor(round(months_between(:is_yearmonth3 || '01', 
														decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01'), 0) / 12) +
														mod(round(months_between(:is_yearmonth3 || '01', 
														decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '19') || substr(jumin_no, 1, 4) || '01'), 0), 12) * 0.01),0)
														as exp
											 from		indb.hin019h
						               where		gwangae_code	in (1,2,3,4)
											  and   length(jumin_no) > 12) sub
						 where		member_no	=	:ls_member_no
							and		sub.exp		> 64	)
where	year_month	=		:is_yearmonth3
and		member_no	=	:ls_member_no;
if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

//else
//     messagebox('',ls_member_no)
//end if
// 총근무년수를 구한다.
update	padb.hpa001m
set		work_year =	(	select	nvl(NVL(CAREER_YM, 0) + 
												(FLOOR(TRUNC(MONTHS_BETWEEN(TO_CHAR(TO_DATE(DECODE(RETIRE_DATE, NULL, :is_today, RETIRE_DATE)) + 1, 'YYYYMMDD'), 
													(	select	nvl(to_char(to_date(firsthire_date) + 
																	(	select	nvl(sum(to_date(to_date) - to_date(from_date) + 1), 0)
																		from		indb.hin007h
																		where		member_no	=:ls_member_no
																		and		change_opt	=	71	), 'yyyymmdd'), '')
														from		indb.hin001m b
														where		member_no	=	:ls_member_no	)	
													), 0) / 12)	+
												((MOD(ROUND(MONTHS_BETWEEN(TO_CHAR(TO_DATE(DECODE(RETIRE_DATE, NULL, :is_today, RETIRE_DATE), 'YYYYMMDD') + 1, 'YYYYMMDD'),
													(	select	nvl(to_char(to_date(firsthire_date) + 
																	(	select	nvl(sum(to_date(to_date) - to_date(from_date) + 1), 0)
																		from		indb.hin007h
																		where		member_no	=	:ls_member_no
																		and		change_opt	=	71	), 'yyyymmdd'), '')
														from		indb.hin001m b
														where		member_no	=	:ls_member_no	)	
													), 0), 12) * 0.01))), 0) as yearmonth
								from		indb.hin001m a
								where		member_no	= :ls_member_no	)
where		year_month	=		:is_yearmonth3
and		member_no	=	:ls_member_no;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

next

return 0


end function

on w_hpa206b.create
int iCurrent
call super::create
end on

on w_hpa206b.destroy
call super::destroy
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

string	ls_yymm, ls_dd

//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		fALSE)

idw_1			=	tab_sheet.tabpage_sheet01.dw_list001
idw_3			=	tab_sheet.tabpage_sheet02.dw_list003
idw_4			=	tab_sheet.tabpage_sheet02.dw_list004
idw_dept2	=	tab_sheet.tabpage_sheet02.dw_dept2

ls_yymm	=	left(f_today(), 6)



idw_1.title = string(is_yearmonth1, '@@@@년 @@월') + ' 급여 기초 자료'

tab_sheet.tabpage_sheet02.uo_yearmonth3.uf_settitle('생성년월')
is_yearmonth3	=	tab_sheet.tabpage_sheet02.uo_yearmonth3.uf_getyearmonth()
//messagebox('',is_yearmonth3)
idw_4.title = string(is_yearmonth3, '@@@@년 @@월') + ' 급여 기초 자료'

select to_char(last_day(to_date(:is_yearmonth3||'01')),'dd') 
  into :ls_dd
  from dual;
  //messageBox('',ls_dd)
is_today = string(relativedate(date(string(is_yearmonth3, '@@@@/@@/'+ls_dd)), 0), 'yyyymmdd')
tab_sheet.tabpage_sheet02.em_pay_date.text = string(is_yearmonth3+ls_dd, '@@@@/@@/@@')
//is_today = string(is_yearmonth3+ls_dd,'yyyymmdd'

wf_getchild()


tab_sheet.tabpage_sheet02.rb_3.checked = true
tab_sheet.tabpage_sheet02.rb_3.triggerevent('clicked')

tab_sheet.tabpage_sheet02.rb_all.triggerevent(clicked!)


end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa206b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa206b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa206b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa206b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa206b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa206b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa206b
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa206b
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa206b
end type

type uc_save from w_tabsheet`uc_save within w_hpa206b
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa206b
end type

type uc_print from w_tabsheet`uc_print within w_hpa206b
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa206b
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa206b
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa206b
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa206b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa206b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa206b
integer y = 4
integer width = 3881
integer height = 2516
integer selectedtab = 2
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
string tag = "N"
boolean visible = false
integer width = 3845
integer height = 2400
string text = "급여대상자기초자료생성(전월)"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
integer y = 408
integer width = 3845
integer height = 996
boolean titlebar = true
string dataobject = "d_hpa206b_1"
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
end type

type uo_tab from w_tabsheet`uo_tab within w_hpa206b
end type

type dw_con from w_tabsheet`dw_con within w_hpa206b
end type

type st_con from w_tabsheet`st_con within w_hpa206b
end type

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3845
integer height = 2400
long backcolor = 79741120
string text = "급여대상자기초자료생성(인사→급여)"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
st_1 st_1
dw_list003 dw_list003
dw_list004 dw_list004
gb_21 gb_21
gb_61 gb_61
st_311 st_311
st_32 st_32
rb_3 rb_3
rb_4 rb_4
pb_create2 pb_create2
dw_dept2 dw_dept2
uo_yearmonth3 uo_yearmonth3
em_pay_date em_pay_date
st_2 st_2
gb_1 gb_1
rb_member rb_member
rb_all rb_all
uo_insa uo_insa
end type

on tabpage_sheet02.create
this.rb_7=create rb_7
this.rb_6=create rb_6
this.rb_5=create rb_5
this.st_1=create st_1
this.dw_list003=create dw_list003
this.dw_list004=create dw_list004
this.gb_21=create gb_21
this.gb_61=create gb_61
this.st_311=create st_311
this.st_32=create st_32
this.rb_3=create rb_3
this.rb_4=create rb_4
this.pb_create2=create pb_create2
this.dw_dept2=create dw_dept2
this.uo_yearmonth3=create uo_yearmonth3
this.em_pay_date=create em_pay_date
this.st_2=create st_2
this.gb_1=create gb_1
this.rb_member=create rb_member
this.rb_all=create rb_all
this.uo_insa=create uo_insa
this.Control[]={this.rb_7,&
this.rb_6,&
this.rb_5,&
this.st_1,&
this.dw_list003,&
this.dw_list004,&
this.gb_21,&
this.gb_61,&
this.st_311,&
this.st_32,&
this.rb_3,&
this.rb_4,&
this.pb_create2,&
this.dw_dept2,&
this.uo_yearmonth3,&
this.em_pay_date,&
this.st_2,&
this.gb_1,&
this.rb_member,&
this.rb_all,&
this.uo_insa}
end on

on tabpage_sheet02.destroy
destroy(this.rb_7)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.st_1)
destroy(this.dw_list003)
destroy(this.dw_list004)
destroy(this.gb_21)
destroy(this.gb_61)
destroy(this.st_311)
destroy(this.st_32)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.pb_create2)
destroy(this.dw_dept2)
destroy(this.uo_yearmonth3)
destroy(this.em_pay_date)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.rb_member)
destroy(this.rb_all)
destroy(this.uo_insa)
end on

type rb_7 from radiobutton within tabpage_sheet02
integer x = 2830
integer y = 288
integer width = 251
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "직원"
end type

event clicked;idw_3.dataobject ='d_hpa206b_23'
idw_3.settransobject(sqlca)
idw_4.dataobject ='d_hpa206b_13'
idw_4.settransobject(sqlca)
wf_getchild()
end event

type rb_6 from radiobutton within tabpage_sheet02
integer x = 2487
integer y = 292
integer width = 274
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조교"
end type

event clicked;idw_3.dataobject ='d_hpa206b_22'
idw_3.settransobject(sqlca)
idw_4.dataobject ='d_hpa206b_12'
idw_4.settransobject(sqlca)
wf_getchild()
end event

type rb_5 from radiobutton within tabpage_sheet02
integer x = 2139
integer y = 292
integer width = 242
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "교원"
end type

event clicked;idw_3.dataobject ='d_hpa206b_21'
idw_3.settransobject(sqlca)
idw_4.dataobject ='d_hpa206b_11'
idw_4.settransobject(sqlca)
wf_getchild()

end event

type st_1 from statictext within tabpage_sheet02
boolean visible = false
integer x = 1769
integer y = 176
integer width = 686
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
string text = "근무년수계산기준일자"
boolean focusrectangle = false
end type

type dw_list003 from cuo_dwwindow within tabpage_sheet02
integer y = 596
integer width = 3845
integer height = 908
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "인사 기본 자료"
string dataobject = "d_hpa206b_2"
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

type dw_list004 from cuo_dwwindow within tabpage_sheet02
integer y = 1504
integer width = 3845
integer height = 908
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_hpa206b_1"
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

type gb_21 from groupbox within tabpage_sheet02
integer y = 20
integer width = 3109
integer height = 200
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "생성 조건"
end type

type gb_61 from groupbox within tabpage_sheet02
integer x = 3113
integer y = 20
integer width = 731
integer height = 380
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_311 from statictext within tabpage_sheet02
integer x = 1024
integer y = 112
integer width = 590
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "의 자료를 생성합니다."
boolean focusrectangle = false
end type

type st_32 from statictext within tabpage_sheet02
integer x = 722
integer y = 288
integer width = 219
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
string text = "학과명"
boolean focusrectangle = false
end type

type rb_3 from radiobutton within tabpage_sheet02
integer x = 91
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
long textcolor = 16711680
long backcolor = 67108864
string text = "전체"
boolean checked = true
end type

event clicked;idw_3.dataobject ='d_hpa206b_2'
idw_3.settransobject(sqlca)
wf_getchild()
idw_dept2.enabled	=	false
idw_dept2.object.code.background.color = 78682240
is_dept2	=	''

rb_3.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)

rb_3.underline	=	true
rb_4.underline	=	false



end event

type rb_4 from radiobutton within tabpage_sheet02
integer x = 366
integer y = 288
integer width = 283
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
string text = "학과별"
end type

event clicked;idw_3.dataobject ='d_hpa206b_21'
idw_3.settransobject(sqlca)
wf_getchild()
idw_dept2.enabled	=	true
idw_dept2.object.code.background.color = rgb(255, 255, 255)
is_dept2		=	idw_dept2.getitemstring(idw_dept2.getrow(), 'code')

idw_dept2.setfocus()

rb_3.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 255)

rb_3.underline	=	false
rb_4.underline	=	true



end event

type pb_create2 from picturebutton within tabpage_sheet02
integer x = 3246
integer y = 168
integer width = 480
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "   생성처리"
string picturename = "..\bmp\PROCES_E.BMP"
string disabledname = "..\bmp\PROCES_D.BMP"
vtextalign vtextalign = vcenter!
end type

event clicked;// 생성처리한다.
integer	li_rtn

setpointer(hourglass!)

li_rtn	=	wf_create2()

setpointer(arrow!)

if	li_rtn = 0 then
	if idw_4.update() = 1 then
		commit;

		idw_4.setredraw(true)
		
		wf_retrieve()
		f_messagebox('1', string(idw_4.rowcount()) + '건의 자료를 생성했습니다.!')
		
		return
	end if
elseif li_rtn = 100 then
	return
end if

f_messagebox('3', sqlca.sqlerrtext)
rollback	;
wf_retrieve()


end event

type dw_dept2 from datawindow within tabpage_sheet02
integer x = 951
integer y = 268
integer width = 1143
integer height = 96
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_sosok501_gwa_gubun"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) then return

is_dept2	=	trim(data)


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

event ue_itemchange;call super::ue_itemchange;string ls_dd

is_yearmonth3	=	uf_getyearmonth()

select to_char(last_day(to_date(:is_yearmonth3||'01')),'dd') 
  into :ls_dd
  from dual;
  
//is_today = string(relativedate(date(string(is_yearmonth3, '@@@@/@@/' + ls_dd)), 0), 'yyyymmdd')
is_today = is_yearmonth3+ls_dd
em_pay_date.text = string(is_yearmonth3+ls_dd, '@@@@/@@/@@')

idw_4.title = string(is_yearmonth3, '@@@@년 @@월') + ' 급여 기초 자료'


end event

on uo_yearmonth3.destroy
call cuo_yearmonth::destroy
end on

type em_pay_date from editmask within tabpage_sheet02
integer x = 2313
integer y = 92
integer width = 489
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
integer y = 108
integer width = 425
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
string text = "처리기준일자"
boolean focusrectangle = false
end type

type gb_1 from groupbox within tabpage_sheet02
integer y = 380
integer width = 3845
integer height = 200
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type rb_member from radiobutton within tabpage_sheet02
integer x = 357
integer y = 464
integer width = 288
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
string text = "개인별"
end type

event clicked;uo_insa.trigger event ue_enbled(true)
uo_insa.sle_kname.setfocus()
end event

type rb_all from radiobutton within tabpage_sheet02
integer x = 87
integer y = 464
integer width = 233
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

