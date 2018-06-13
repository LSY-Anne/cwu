$PBExportHeader$w_hpa601a.srw
$PBExportComments$연말정산 기초자료 관리/생성
forward
global type w_hpa601a from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_3 from cuo_search_insa within tabpage_sheet01
end type
type dw_update from uo_dwfree within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type dw_list003 from uo_dwgrid within tabpage_sheet03
end type
type gb_21 from groupbox within tabpage_sheet03
end type
type st_4 from statictext within tabpage_sheet03
end type
type st_6 from statictext within tabpage_sheet03
end type
type st_7 from statictext within tabpage_sheet03
end type
type uo_member_no from cuo_member_fromto_year within tabpage_sheet03
end type
type rb_ret from radiobutton within tabpage_sheet03
end type
type rb_jae from radiobutton within tabpage_sheet03
end type
type rb_all from radiobutton within tabpage_sheet03
end type
type dw_jikjong from datawindow within tabpage_sheet03
end type
type st_5 from statictext within tabpage_sheet03
end type
type dw_list002 from uo_dwgrid within tabpage_sheet03
end type
type pb_create2 from uo_imgbtn within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_list003 dw_list003
gb_21 gb_21
st_4 st_4
st_6 st_6
st_7 st_7
uo_member_no uo_member_no
rb_ret rb_ret
rb_jae rb_jae
rb_all rb_all
dw_jikjong dw_jikjong
st_5 st_5
dw_list002 dw_list002
pb_create2 pb_create2
end type
end forward

global type w_hpa601a from w_tabsheet
integer height = 2644
string title = "연말정산 기초자료 관리/생성"
end type
global w_hpa601a w_hpa601a

type variables
datawindowchild	idw_child, idw_child2, idw_child_kname
datawindow			idw_list, idw_data,  idw_3, idw_4





string	is_str_member = '          ', is_end_member = 'zzzzzzzzzz'

integer	ii_jaejik_opt	//	0=전체 1=재직 3=퇴직
end variables

forward prototypes
public subroutine wf_setitem (string as_colname, string as_data)
public subroutine wf_dwcopy ()
public subroutine wf_getchild_member ()
public subroutine wf_getchild ()
public subroutine wf_getchild2 ()
public function integer wf_create ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_setitem (string as_colname, string as_data);// ==========================================================================================
// 기    능 : 	datawindow setitem
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_setitem(string as_colname, string as_data)
// 인    수 :	as_colname	-	column name
//					as_data		-	data
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_type

ls_type 	= idw_data.describe(as_colname + ".coltype")

idw_data.accepttext()

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(idw_list.getrow(), as_colname, dec(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, dec(as_data))
elseif ls_type = 'date' then
	idw_list.setitem(idw_list.getrow(), as_colname, date(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, date(as_data))
elseif ls_type = 'datetime' then
	idw_list.setitem(idw_list.getrow(), as_colname, datetime(date(left(as_data, 10)), time(right(as_data, 8))))
	idw_data.setitem(idw_data.getrow(), as_colname, datetime(date(left(as_data, 10)), time(right(as_data, 8))))
else	//char or string
	idw_list.setitem(idw_list.getrow(), as_colname, trim(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, trim(as_data))
end if

end subroutine

public subroutine wf_dwcopy ();// ==========================================================================================
// 기    능 : 	datawindow copy
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_dwcopy()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_val[]
long		ll_row

ll_row	=	idw_list.getrow()

idw_data.reset()

if ll_row < 1 then	return

idw_list.rowscopy(ll_row, ll_row, primary!, idw_data, 1, primary!) 

end subroutine

public subroutine wf_getchild_member ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild_member()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 개인번호
String	ls_dept_code

dw_con.accepttext()
ls_dept_code = trim(dw_con.object.dept_code[1])
If ls_dept_code = '' or isnull(ls_dept_code) Then ls_dept_code = '%'

idw_data.getchild('member_no', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0, 9, ls_dept_code) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 성명
idw_data.getchild('name', idw_child_kname)
idw_child_kname.settransobject(sqlca)
if idw_child_kname.retrieve(0, 9, ls_dept_code) < 1 then
	idw_child_kname.reset()
	idw_child_kname.insertrow(0)
end if


// 국적코드
idw_data.getchild('hpa019h_foreigner_gbn', idw_child2)
idw_child2.settransobject(sqlca)
if idw_child2.retrieve('kukjuk_code',0) < 1 then
	idw_child2.reset()
	idw_child2.insertrow(0)
end if



end subroutine

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

idw_3.getchild('jaejik_opt', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jaejik_opt', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_4.getchild('jaejik_opt', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jaejik_opt', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

wf_getchild_member()

end subroutine

public subroutine wf_getchild2 ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild2()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String ls_year, ls_dept_code, ls_jikjong_code, ls_jaejik_opt
Integer li_str_jikjong, li_end_jikjong, li_jaejik_opt
dw_con.accepttext()
ls_year = STring(dw_con.object.year[1], 'yyyy')
ls_dept_code = trim(dw_con.object.dept_code[1])
If ls_dept_code = '' or isnull(ls_dept_code)  Then ls_dept_code = '%'
ls_jikjong_code = trim(tab_sheet.tabpage_sheet03.dw_jikjong.object.code[1])
//ls_jaejik_opt = trim(dw_con.object.jaejik_opt[1])

if isnull(ls_jikjong_code) or trim(ls_jikjong_code) = '0' or trim(ls_jikjong_code) = '' then	
	li_str_jikjong	=	0
	li_end_jikjong	=	9
else
	li_str_jikjong = integer(trim(ls_jikjong_code))
	li_end_jikjong = integer(trim(ls_jikjong_code))
end if

//if isnull(ls_jaejik_opt) or trim(ls_jaejik_opt) = '0' or trim(ls_jaejik_opt) = '' then	
//	ls_jaejikopt	=	'%'
//	
//else
//	ls_jaejikopt = string(trim(ls_jaejik_opt))
//end if
tab_sheet.tabpage_sheet03.uo_member_no.uf_getchild(ls_year, li_str_jikjong, li_end_jikjong, ls_dept_code, ii_jaejik_opt)

end subroutine

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	data create
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcdoe
// 주의사항 :
// 수정사항 :  건강보험가져올 때 정산된 금액도 가져와야 한다.
// ==========================================================================================

long		ll_rowcount
string	ls_first_date
string	ls_year, ls_jikjong_code, ls_dept_code
Integer li_str_jikjong, li_end_jikjong

dw_con.accepttext()
ls_year = String(dw_con.object.year[1], 'yyyy')
ls_dept_code = trim(dw_con.object.dept_code[1])
If ls_dept_code = '' or isnull(ls_dept_code) Then ls_dept_code  = '%'

ls_jikjong_code = trim(dw_con.object.jikjong_code[1])

if isnull(ls_jikjong_code) or trim(ls_jikjong_code) = '0' or trim(ls_jikjong_code) = '' then	
	li_str_jikjong	=	0
	li_end_jikjong	=	9
else
	li_str_jikjong = integer(trim(ls_jikjong_code))
	li_end_jikjong = integer(trim(ls_jikjong_code))
end if


wf_retrieve()

// 인사기본 자료 체크
if idw_3.rowcount() < 1 then
	f_messagebox('1', '급여기본 자료가 존재하지 않습니다.!')
	return	100
end if

ll_rowcount = idw_4.rowcount()

if ll_rowcount > 0 then
	if f_messagebox('2', string(ls_year, '@@@@년도') + '의 자료가 이미 존재합니다~n~n삭제후 다시 생성하시겠습니까?') = 1 then
		
		// 재직여부가 전체일 경우
		if ii_jaejik_opt	=	0	then
			// 자료 삭제
			delete	from	padb.hpa019h
			where		year			=		:ls_year
			and		member_no	in		(	select	a.member_no
													from		indb.hin001m a, 
																(	select	duty_code	
																	from		indb.hin003m_02v
																	where		jikjong_code	>=	:li_str_jikjong
																	and		jikjong_code	<=	:li_end_jikjong	)	b
													where		a.gwa				like	:ls_dept_code || '%'
													and		a.member_no		>=		:is_str_member
													and		a.member_no		<=		:is_end_member	
													and		a.duty_code		=		b.duty_code (+)	)	;

		// 재직여부가 재직일 경우													
		elseif ii_jaejik_opt = 1 then
			delete	from	padb.hpa019h
			where		year			=		:ls_year
			and		member_no	in		(	select	a.member_no
													from		indb.hin001m a, 
																(	select	duty_code	
																	from		indb.hin003m_02v
																	where		jikjong_code	>=	:li_str_jikjong
																	and		jikjong_code	<=	:li_end_jikjong	)	b
													where		a.gwa				like	:ls_dept_code || '%'
													and		a.member_no		>=		:is_str_member
													and		a.member_no		<=		:is_end_member	
													and		a.jaejik_opt	in		(1, 2, 4)
													and		a.duty_code		=		b.duty_code (+)	)	;

		// 재직여부가 퇴직일 경우													
		else
			delete	from	padb.hpa019h
			where		year			=		:ls_year
			and		member_no	in		(	select	a.member_no
													from		indb.hin001m a, 
																(	select	duty_code	
																	from		indb.hin003m_02v
																	where		jikjong_code	>=	:li_str_jikjong
																	and		jikjong_code	<=	:li_end_jikjong	)	b
													where		a.gwa				like	:ls_dept_code || '%'
													and		a.member_no		>=		:is_str_member
													and		a.member_no		<=		:is_end_member	
													and		a.jaejik_opt	not in	(1, 2, 4)
													and		substr(a.retire_date, 1, 4)	=	:ls_year
													and		a.duty_code		=		b.duty_code (+)	)	;
		end if
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	else
		return	100
	end if
else
	if f_messagebox('2', string(ls_year, '@@@@년도') + '의 자료를 생성하시겠습니까?') <> 1 then	return	100
end if

idw_4.reset()

// 전체일 경우
if ii_jaejik_opt	=	0	then
	
	insert	into	padb.hpa019h	
			(	member_no, year, wife_num, support_20_num, support_60_num, old_num, child_num, 
				insure_pension_amt, insure_medical_amt, constribution_legal_amt, worker, ipaddr, work_date, job_uid, job_add, job_date)
	select	distinct b.member_no, :ls_year, 
				(	select	decode(count(*), 1, 1, 0)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	=	2	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								<= 20	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								>= decode(substr(jumin_no, 7, 1), '1', 60, '3', 60, 55)	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								>= 65	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								<= 6	),
				(	select	nvl(sum(nvl(pay_amt, 0)), 0)
					from		padb.hpa005d
					where		substr(year_month, 1, 4)	=	:ls_year
					and		code			=	'53'
					and		member_no	=	a.member_no	),
				(	select	nvl(sum(nvl(pay_amt, 0)), 0)
					from		padb.hpa005d
					where		substr(year_month, 1, 4)	=	:ls_year
					and		code			=	'54'
					and		member_no	=	a.member_no	) +
				(	select	nvl(sum(nvl(pay_amt, 0)), 0)
					from		padb.hpa005d
					where		substr(year_month, 1, 4)	=	:ls_year
					and		code			=	'57'
					and		member_no	=	a.member_no	),
				(	select	nvl(sum(nvl(contribution, 0)), 0)
					from		padb.hpa001m
					where		substr(year_month, 1, 4)	=	:ls_year
					and		member_no	=	a.member_no	),
				:gs_empcode, :gs_ip, sysdate,
				:gs_empcode, :gs_ip, sysdate
	from		(	select	A.member_no
					from	padb.hpa001m A
					where	A.year_month LIKE :ls_year || '%'	
					and		A.member_no	>=	:is_str_member	
					and		A.member_no	<=	:is_end_member
					UNION
					select	A.member_no
					from	padb.hpa111H A
					where	A.year 		 =  :ls_year 
					and		A.member_no	>=	:is_str_member	
					and		A.member_no	<=	:is_end_member	)	a, 
				indb.hin001m b, indb.hin003m c
	where		b.gwa				like	:ls_dept_code || '%'
	and		c.jikjong_code	>=		:li_str_jikjong
	and		c.jikjong_code	<=		:li_end_jikjong
	and		b.member_no		>=		:is_str_member
	and		b.member_no		<=		:is_end_member
	and		rtrim(b.member_no)	=	rtrim(a.member_no (+)) 
	and		b.duty_code				=	c.duty_code	(+)
	and		b.member_no		in		(	select	member_no
												from	(	select	member_no, jumin_no
															from		indb.hin001m a
															order by	jaejik_opt,
																		decode(substr(duty_code, 1, 1), '3', 'z' || duty_code, '0' || duty_code),
																		firsthire_date	DESC,
																		decode(substr(member_no, 1, 1), '0', 'z' || member_no, '0' || member_no) )
												where		jumin_no	=	b.jumin_no
												and		rownum	=	1	)	;

// 재직일 경우
elseif ii_jaejik_opt = 1	then
	// Insert
	insert	into	padb.hpa019h	
			(	member_no, year, wife_num, support_20_num, support_60_num, old_num, child_num, 
				insure_pension_amt, insure_medical_amt, constribution_legal_amt, worker, ipaddr, work_date, job_uid, job_add, job_date)
	select	distinct b.member_no, :ls_year, 
				(	select	decode(count(*), 1, 1, 0)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	=	2	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								<= 20	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								>= decode(substr(jumin_no, 7, 1), '1', 60, '3', 60, 55)	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								>= 65	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								<= 6	),
				(	select	nvl(sum(nvl(pay_amt, 0)), 0)
					from		padb.hpa005d
					where		substr(year_month, 1, 4)	=	:ls_year
					and		code			=	'53'
					and		member_no	=	a.member_no	),
				(	select	nvl(sum(nvl(pay_amt, 0)), 0)
					from		padb.hpa005d
					where		substr(year_month, 1, 4)	=	:ls_year
					and		code			=	'54'
					and		member_no	=	a.member_no	) +
				(	select	nvl(sum(nvl(pay_amt, 0)), 0)
					from		padb.hpa005d
					where		substr(year_month, 1, 4)	=	:ls_year
					and		code			=	'57'
					and		member_no	=	a.member_no	),
				(	select	nvl(sum(nvl(contribution, 0)), 0)
					from		padb.hpa001m
					where		substr(year_month, 1, 4)	=	:ls_year
					and		member_no	=	a.member_no	),
				:gs_empcode, :gs_ip, sysdate,
				:gs_empcode, :gs_ip, sysdate
	from		(	select	A.member_no
					from	padb.hpa001m A
					where	A.year_month LIKE :ls_year || '%'	
					and		A.member_no	>=	:is_str_member	
					and		A.member_no	<=	:is_end_member
					UNION
					select	A.member_no
					from	padb.hpa111H A
					where	A.year 		 =  :ls_year 
					and		A.member_no	>=	:is_str_member	
					and		A.member_no	<=	:is_end_member	)	a, 
				indb.hin001m b, indb.hin003m c
	where		b.gwa				like	:ls_dept_code || '%'
	and		c.jikjong_code	>=		:li_str_jikjong
	and		c.jikjong_code	<=		:li_end_jikjong
	and		b.member_no		>=		:is_str_member
	and		b.member_no		<=		:is_end_member
	and		rtrim(b.member_no)	=	rtrim(a.member_no (+)) 
	and		b.duty_code				=	c.duty_code	(+)
	and		b.jaejik_opt	in		(1, 2, 4)
	and		b.member_no		in		
				(	select	member_no
					from	(	select	member_no, jumin_no
								from		indb.hin001m a
								where		(jaejik_opt in	(1, 2, 4) or retire_date like :ls_year || '%') 
								order by	jaejik_opt, 
											decode(substr(duty_code, 1, 1), '3', 'z' || duty_code, '0' || duty_code),
											firsthire_date	DESC,
											decode(substr(member_no, 1, 1), '0', 'z' || member_no, '0' || member_no) )
					where		jumin_no	=	b.jumin_no
					and		rownum	=	1	)	;	

// 퇴직일 경우
else
	// Insert
	insert	into	padb.hpa019h	
			(	member_no, year, wife_num, support_20_num, support_60_num, old_num, child_num, 
				insure_pension_amt, insure_medical_amt, constribution_legal_amt, worker, ipaddr, work_date, job_uid, job_add, job_date)
	select	distinct b.member_no, :ls_year, 
				(	select	decode(count(*), 1, 1, 0)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	=	2	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								<= 20	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								>= decode(substr(jumin_no, 7, 1), '1', 60, '3', 60, 55)	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								>= 65	),
				(	select	count(*)
					from		indb.hin019h
					where		member_no		=	a.member_no
					and		gwangae_code	<>	1
					and		gwangae_code	<>	2	
					and		to_number(:ls_year) - 
								to_number(decode(substr(jumin_no, 7, 1), '1', '19', '2', '19', '3', '20', '4', '20', '') || substr(jumin_no, 1, 2))
								<= 6	),
				(	select	nvl(sum(nvl(pay_amt, 0)), 0)
					from		padb.hpa005d
					where		substr(year_month, 1, 4)	=	:ls_year
					and		code			=	'53'
					and		member_no	=	a.member_no	),
				(	select	nvl(sum(nvl(pay_amt, 0)), 0)
					from		padb.hpa005d
					where		substr(year_month, 1, 4)	=	:ls_year
					and		code			=	'54'
					and		member_no	=	a.member_no	)	+
				(	select	nvl(sum(nvl(pay_amt, 0)), 0)
					from		padb.hpa005d
					where		substr(year_month, 1, 4)	=	:ls_year
					and		code			=	'57'
					and		member_no	=	a.member_no	),
				(	select	nvl(sum(nvl(contribution, 0)), 0)
					from		padb.hpa001m
					where		substr(year_month, 1, 4)	=	:ls_year
					and		member_no	=	a.member_no	),
				:gs_empcode, :gs_ip, sysdate,
				:gs_empcode, :gs_ip, sysdate
	from		(	select	A.member_no
					from	padb.hpa001m A
					where	A.year_month LIKE :ls_year || '%'	
					and		A.member_no	>=	:is_str_member	
					and		A.member_no	<=	:is_end_member
					UNION
					select	A.member_no
					from	padb.hpa111H A
					where	A.year 		 =  :ls_year 
					and		A.member_no	>=	:is_str_member	
					and		A.member_no	<=	:is_end_member	)	a, 
				indb.hin001m b, indb.hin003m c
	where		b.gwa				like	:ls_dept_code || '%'
	and		c.jikjong_code	>=		:li_str_jikjong
	and		c.jikjong_code	<=		:li_end_jikjong
	and		b.member_no		>=		:is_str_member
	and		b.member_no		<=		:is_end_member
	and		rtrim(b.member_no)	=	rtrim(a.member_no (+)) 
	and		b.duty_code				=	c.duty_code	(+)
	and		b.jaejik_opt	not	in	(1, 2, 4)
	and		substr(b.retire_date, 1, 4)	=	:ls_year
	and		b.member_no		in		
				(	select	member_no
					from	(	select	member_no, jumin_no
								from		indb.hin001m a
								where		(jaejik_opt in	(2, 3, 96) or retire_date like :ls_year || '%') 
								order by	jaejik_opt, 
											decode(substr(duty_code, 1, 1), '3', 'z' || duty_code, '0' || duty_code),
											firsthire_date	DESC,
											decode(substr(member_no, 1, 1), '0', 'z' || member_no, '0' || member_no) )
					where		jumin_no	=	b.jumin_no
					and		rownum	=	1	)	;
end if

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

if tab_sheet.tabpage_sheet03.rb_all.checked then
	ii_jaejik_opt = 0
elseif tab_sheet.tabpage_sheet03.rb_jae.checked then
	ii_jaejik_opt = 1
elseif tab_sheet.tabpage_sheet03.rb_ret.checked then
	ii_jaejik_opt = 3
end if

idw_4.retrieve(ls_year, ls_dept_code, is_str_member, is_end_member, ii_jaejik_opt)

return	sqlca.sqlcode

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

String	ls_name, ls_jaejik
integer	li_tab
String	ls_year,  ls_jikjong_code, ls_dept_code, ls_jaejikopt
Integer li_str_jikjong, li_end_jikjong

dw_con.accepttext()
ls_year = String(dw_con.object.year[1], 'yyyy')
ls_dept_code = trim(dw_con.object.dept_code[1])
If ls_dept_code = '' or isnull(ls_dept_code) Then ls_dept_code = '%'
ls_jaejikopt = trim(dw_con.object.jaejik_opt[1])
If ls_jaejikopt = '' or isnull(ls_jaejikopt) Then ls_jaejikopt = '%'
ls_jikjong_code = trim(dw_con.object.jikjong_code[1])

if isnull(ls_jikjong_code) or trim(ls_jikjong_code) = '0' or trim(ls_jikjong_code) = '' then	
	li_str_jikjong	=	0
	li_end_jikjong	=	9
else
	li_str_jikjong = integer(trim(ls_jikjong_code))
	li_end_jikjong = integer(trim(ls_jikjong_code))
end if



li_tab  = tab_sheet.selectedtab



wf_getchild_member()

if tab_sheet.tabpage_sheet03.rb_all.checked then
	ii_jaejik_opt = 0
elseif tab_sheet.tabpage_sheet03.rb_jae.checked then
	ii_jaejik_opt = 1
elseif tab_sheet.tabpage_sheet03.rb_ret.checked then
	ii_jaejik_opt = 3
end if

idw_list.retrieve(ls_year, ls_dept_code, li_str_jikjong, li_end_jikjong, ls_jaejikopt)
idw_3.retrieve(ls_year, ls_dept_code, li_str_jikjong, li_end_jikjong, is_str_member, is_end_member, ii_jaejik_opt)
idw_4.retrieve(ls_year, ls_dept_code, is_str_member, is_end_member, ii_jaejik_opt)

return 0
end function

on w_hpa601a.create
int iCurrent
call super::create
end on

on w_hpa601a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


idw_list.setredraw(false)
idw_data.setredraw(false)

wf_retrieve()

idw_list.setredraw(true)
idw_data.setredraw(true)
return 1

end event

event ue_insert;call super::ue_insert;		/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

integer	li_newrow, li_newrow2
String	ls_year
dw_con.accepttext()
ls_year	= String(dw_con.object.year[1], 'yyyy')


//idw_data.Selectrow(0, false)	

idw_data.reset()
li_newrow	=	1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

li_newrow2 	=	idw_list.getrow() + 1
idw_list.insertrow(li_newrow2)
idw_list.setrow(li_newrow2)

idw_data.setcolumn('member_no')
idw_data.setfocus()

wf_setitem('year', ls_year)

idw_list.setitem(li_newrow2, 'worker',		gs_empcode)
idw_list.setitem(li_newrow2, 'ipaddr',		gs_ip)
idw_list.setitem(li_newrow2, 'work_date',	f_sysdate())



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
//DataWindowChild	ldwc_Temp
//long 		ll_insrow
//
//idw_list		=	tab_sheet.tabpage_sheet01.dw_list001
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//idw_3			=	tab_sheet.tabpage_sheet03.dw_list002
//idw_4			=	tab_sheet.tabpage_sheet03.dw_list003
//
//wf_getchild()
//tab_sheet.tabpage_sheet03.rb_all.checked	=	true
//ii_jaejik_opt	=	1
//wf_getchild2()
//
////uo_year.st_title.text = '기준년도'
////is_year	=	uo_year.uf_getyy()
//
//uo_dept_code.uf_setdept('', '학과명')
//is_dept_code	=	uo_dept_code.uf_getcode()
//
//f_getdwcommon(dw_head, 'jikjong_code', 0, 750)
//f_getdwcommon(tab_sheet.tabpage_sheet03.dw_jikjong, 'jikjong_code', 0, 600)
//
//
//tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'member_no', 'name')
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 재직구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_jaejik_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
//	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code','0')
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//
//dw_jaejik_opt.InsertRow(0)
//dw_jaejik_opt.Object.code[1] = ''
//dw_jaejik_opt.Object.code.dddw.PercentWidth = 100
//
////triggerevent('ue_retrieve')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////



IF idw_list.Update(true) = 1 THEN
 	COMMIT;
//	triggerevent('ue_retrieve')
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText + '~r~n' )
  ROLLBACK;
END IF


return 1

end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow


wf_setMsg('삭제중')

li_deleterow	=	idw_list.deleterow(0)
wf_dwcopy()

wf_setMsg('.')

return 

end event

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력 처리
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

IF idw_print.RowCount() < 1 THEN	return

OpenWithParm(w_printoption, idw_print)

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

DataWindowChild	ldwc_Temp
long 		ll_insrow

idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_print	=	tab_sheet.tabpage_sheet02.dw_print

idw_3			=	tab_sheet.tabpage_sheet03.dw_list002
idw_4			=	tab_sheet.tabpage_sheet03.dw_list003



//uo_year.st_title.text = '기준년도'
//is_year	=	uo_year.uf_getyy()


dw_con.GetChild('dept_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa','9999')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF


//f_getdwcommon(dw_con, 'jikjong_code', 0, 750)

dw_con.GetChild('jikjong_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF


dw_con.Object.jikjong_code[1] = ''
dw_con.Object.jikjong_code.dddw.PercentWidth = 100

f_getdwcommon(tab_sheet.tabpage_sheet03.dw_jikjong, 'jikjong_code', 0, 600)


tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'member_no', 'name')

////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 재직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('jaejik_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF


dw_con.Object.jaejik_opt[1] = ''
dw_con.Object.jaejik_opt.dddw.PercentWidth = 100

wf_getchild()
tab_sheet.tabpage_sheet03.rb_all.checked	=	true
ii_jaejik_opt	=	1
wf_getchild2()


//triggerevent('ue_retrieve')

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa601a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa601a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa601a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa601a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa601a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa601a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa601a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa601a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa601a
end type

type uc_save from w_tabsheet`uc_save within w_hpa601a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa601a
end type

type uc_print from w_tabsheet`uc_print within w_hpa601a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa601a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa601a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa601a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa601a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa601a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa601a
integer y = 324
integer width = 4384
integer height = 1988
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
end type

event tab_sheet::selectionchanged;call super::selectionchanged;////if oldindex	< 0 or newindex < 0	then	return
//
//choose case newindex
//	case	1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case	else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
end event

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
this.tabpage_sheet03=create tabpage_sheet03
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
this.Control[iCurrent+2]=this.tabpage_sheet03
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
destroy(this.tabpage_sheet03)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 1868
long backcolor = 1073741824
string text = "연말정산기초자료관리"
gb_4 gb_4
uo_3 uo_3
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.uo_3=create uo_3
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_3
this.Control[iCurrent+3]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_3)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 101
integer height = 100
string dataobject = "d_hpa601a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)

wf_dwcopy()


end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(1)

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 168
integer width = 1883
integer height = 1704
string dataobject = "d_hpa601a_1"
end type

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(1)

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)

wf_dwcopy()


end event

type uo_tab from w_tabsheet`uo_tab within w_hpa601a
integer x = 1728
integer y = 320
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hpa601a
string dataobject = "d_hpa601a_con"
end type

event dw_con::constructor;call super::constructor;this.object.year[1] = date(String(f_today(), '@@@@/@@/@@'))
end event

event dw_con::itemchanged;call super::itemchanged;accepttext()
wf_getchild2()
end event

type st_con from w_tabsheet`st_con within w_hpa601a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_4 from groupbox within tabpage_sheet01
integer y = -20
integer width = 4347
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type uo_3 from cuo_search_insa within tabpage_sheet01
integer x = 114
integer y = 40
integer width = 3566
integer taborder = 50
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 1897
integer y = 168
integer width = 2455
integer height = 1708
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa601a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
string	ls_col, ls_type
string	ls_bef_member, ls_member_no
integer	li_rtncnt
long		ll_row, ll_childrow

datawindowchild	ldw_child
long		ll_findrow
dec{0}	ldb_insure_medical_amt, ldb_constribution_legal_amt, ldb_insure_pension_amt

String	ls_year
dw_con.accepttext()
ls_year	= String(dw_con.object.year[1], 'yyyy')


ls_col 	= 	dwo.name
ls_type 	= 	describe(ls_col + ".coltype")

data		=	trim(data)
ll_row	=	idw_list.getrow()

if ls_col = 'member_no' or ls_col = 'name' then
	if ls_col = 'member_no' then
		ll_findrow		=	idw_child.find("trim(member_no) = '" + data + "'	", 1, idw_child.rowcount())
		ldw_child		=	idw_child
		ls_member_no	=	trim(data)
	else
		ll_findrow	=	idw_child_kname.find("trim(name) = '" + data + "'	", 1, idw_child_kname.rowcount())
		ldw_child	=	idw_child_kname
	end if
	
	if ll_findrow < 1 or trim(data) = '' then	
//		ls_bef_member = getitemstring(row, 'member_no')
//		setitem(row, 'member_no', ls_bef_member)
//		f_messagebox('3', '개인번호를 정확히 입력해 주세요.!')
//		return 1
//	end if
	else
		ll_childrow	=	ldw_child.getrow()
		
		if ls_col = 'member_no' then
			wf_setitem('name', 						ldw_child.getitemstring(ll_childrow, 'name'))
		else
			ls_member_no	=	trim(ldw_child.getitemstring(ll_childrow, 'member_no'))
			wf_setitem('member_no', 				ls_member_no)
		end if	
		wf_setitem('hin001m_jumin_no',			ldw_child.getitemstring(ll_childrow, 'jumin_no'))
		wf_setitem('kch003m_dept_name',			ldw_child.getitemstring(ll_childrow, 'dept_name'))
		wf_setitem('hin003m_02v_jikjong_name',	ldw_child.getitemstring(ll_childrow, 'fname'))
		
		accepttext()
//국적을 가져온다.
		int	li_kukjuk
		select nation_code	into	:li_kukjuk
		  from indb.hin001m
		 where member_no  =  :ls_member_no;
		wf_setitem('hpa019h_foreigner_gbn',	string(li_kukjuk))
		
		
		// 배우자를 구한다.
		li_rtncnt = f_getwifecnt(data)
		wf_setitem('hpa019h_wife_num',	string(li_rtncnt))
	
		// 부양자20세를 구한다.
		li_rtncnt = f_getfamilycnt(data, 2)
		wf_setitem('hpa019h_support_20_num',	string(li_rtncnt))
	
		// 부양자60세를 구한다.
		li_rtncnt = f_getfamilycnt(data, 3)
		wf_setitem('hpa019h_support_60_num',	string(li_rtncnt))
		
		// 경로우대자를 구한다.
		li_rtncnt = f_getfamilycnt(data, 4)
		wf_setitem('hpa019h_old_num',	string(li_rtncnt))
	
		// 자녀양육(6세이하)를 구한다.
		li_rtncnt = f_getfamilycnt(data, 5)
		wf_setitem('hpa019h_child_num',	string(li_rtncnt))
		
		// 의료보험료를 구한다.
		ldb_insure_medical_amt	=	0
		
		select	nvl(sum(nvl(pay_amt, 0)), 0)
		into		:ldb_insure_medical_amt
		from		padb.hpa005d
		where		substr(year_month, 1, 4)	=	:ls_year
		and		member_no	=	:ls_member_no
		and		code			=	'54'	;
		
		if sqlca.sqlcode <> 0 then	ldb_insure_medical_amt = 0
			
		wf_setitem('hpa019h_insure_medical_amt', string(ldb_insure_medical_amt))

		// 연금부담금을 구한다.
		ldb_insure_pension_amt	=	0
		
		select	nvl(sum(nvl(pay_amt, 0)), 0)
		into		:ldb_insure_pension_amt
		from		padb.hpa005d
		where		substr(year_month, 1, 4)	=	:ls_year
		and		member_no	=	:ls_member_no
		and		code			=	'53'	;
		
		if sqlca.sqlcode <> 0 then	ldb_insure_pension_amt = 0
			
		wf_setitem('hpa019h_insure_pension_amt', string(ldb_insure_pension_amt))
		
		// 기부금공제
		ldb_constribution_legal_amt	=	0
		
		select	nvl(sum(nvl(contribution, 0)), 0)
		into		:ldb_constribution_legal_amt
		from		padb.hpa001m
		where		substr(year_month, 1, 4)	=	:ls_year
		and		member_no	=	:ls_member_no	;
		
		if sqlca.sqlcode <> 0 then	ldb_constribution_legal_amt	=	0
		
		wf_setitem('hpa019h_constribution_legal_amt', string(ldb_constribution_legal_amt))
	end if
end if

accepttext()

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(ll_row, ls_col, dec(data))
elseif ls_type = 'date' then
	idw_list.setitem(ll_row, ls_col, date(data))
else	
	idw_list.setitem(ll_row, ls_col, data)
end if

idw_list.setitem(ll_row, 'job_uid',		gs_empcode)
idw_list.setitem(ll_row, 'job_add',		gs_ip)
idw_list.setitem(ll_row, 'job_date',	f_sysdate())

// 금액이 변동될 경우에 처리한다.
if dwo.name = 'hpa019h_insure_employee_amt' or dwo.name = 'hpa019h_insure_medical_amt' & 
	or dwo.name = 'hpa019h_insure_life_amt1' or dwo.name = 'hpa019h_insure_life_amt2' & 
	or dwo.name = 'hpa019h_insure_handicap_amt' then
	wf_setitem('hpa019h_insure_amt', string(getitemnumber(row, 'comp_insure_amt')))
	
elseif dwo.name = 'hpa019h_medical_self_amt' or dwo.name = 'hpa019h_medical_gen_amt' & 
	or dwo.name = 'hpa019h_medical_old_amt' or dwo.name = 'hpa019h_medical_handicap_amt' then
	wf_setitem('hpa019h_medical_amt', string(getitemnumber(row, 'comp_medical_amt')))
	
elseif dwo.name = 'hpa019h_education_self_amt' or dwo.name = 'hpa019h_education_wife_amt' &
	or dwo.name = 'hpa019h_education_amt1' or dwo.name = 'hpa019h_education_amt2' &
	or dwo.name = 'hpa019h_education_handicap_amt' or dwo.name = 'hpa019h_education_children_amt' then
	wf_setitem('hpa019h_education_amt', string(getitemnumber(row, 'comp_education_amt')))
	
elseif dwo.name = 'hpa019h_house_installment' or dwo.name = 'hpa019h_house_in_amt' &
	or dwo.name = 'hpa019h_house_save'  or dwo.name = 'hpa019h_house_long' &
	or dwo.name = 'hpa019h_house_repay_amt'  or dwo.name = 'hpa019h_house_repay_amt2' then
	wf_setitem('hpa019h_house_amt', string(getitemnumber(row, 'comp_house_amt')))

elseif dwo.name = 'hpa019h_card_used_amt' or dwo.name = 'hpa019h_card_giro' &
	 or dwo.name = 'hpa019h_card_pass' or dwo.name = 'hpa019h_cash_used_amt' or dwo.name = 'hpa019h_card_except' then
	wf_setitem('hpa019h_card_detuct_amt', string(getitemnumber(row, 'comp_card_amt')))
	return 2
end if

end event

event losefocus;call super::losefocus;accepttext()
end event

event constructor;call super::constructor;//settransobject(sqlca)
insertrow(0)
end event

type tabpage_sheet02 from userobject within tab_sheet
boolean visible = false
integer x = 18
integer y = 104
integer width = 4347
integer height = 1868
string text = "연말정산기초자료내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_sheet02.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_sheet02.destroy
destroy(this.dw_print)
end on

type dw_print from cuo_dwprint within tabpage_sheet02
integer width = 4347
integer height = 1868
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa212a_3"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_sheet03 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1868
string text = "연말정산기초자료생성"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list003 dw_list003
gb_21 gb_21
st_4 st_4
st_6 st_6
st_7 st_7
uo_member_no uo_member_no
rb_ret rb_ret
rb_jae rb_jae
rb_all rb_all
dw_jikjong dw_jikjong
st_5 st_5
dw_list002 dw_list002
pb_create2 pb_create2
end type

on tabpage_sheet03.create
this.dw_list003=create dw_list003
this.gb_21=create gb_21
this.st_4=create st_4
this.st_6=create st_6
this.st_7=create st_7
this.uo_member_no=create uo_member_no
this.rb_ret=create rb_ret
this.rb_jae=create rb_jae
this.rb_all=create rb_all
this.dw_jikjong=create dw_jikjong
this.st_5=create st_5
this.dw_list002=create dw_list002
this.pb_create2=create pb_create2
this.Control[]={this.dw_list003,&
this.gb_21,&
this.st_4,&
this.st_6,&
this.st_7,&
this.uo_member_no,&
this.rb_ret,&
this.rb_jae,&
this.rb_all,&
this.dw_jikjong,&
this.st_5,&
this.dw_list002,&
this.pb_create2}
end on

on tabpage_sheet03.destroy
destroy(this.dw_list003)
destroy(this.gb_21)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.uo_member_no)
destroy(this.rb_ret)
destroy(this.rb_jae)
destroy(this.rb_all)
destroy(this.dw_jikjong)
destroy(this.st_5)
destroy(this.dw_list002)
destroy(this.pb_create2)
end on

type dw_list003 from uo_dwgrid within tabpage_sheet03
integer y = 1124
integer width = 4352
integer height = 880
integer taborder = 30
boolean titlebar = true
string title = "연말정산 기초 자료"
string dataobject = "d_hpa601a_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_3, 'member_no')

end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_3, this, 'member_no')

end event

type gb_21 from groupbox within tabpage_sheet03
integer y = -20
integer width = 4347
integer height = 244
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type st_4 from statictext within tabpage_sheet03
integer x = 1019
integer y = 124
integer width = 233
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "개인별"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_sheet03
boolean visible = false
integer x = 2514
integer y = 40
integer width = 699
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "※ 개인번호를 모두 지우면"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_sheet03
boolean visible = false
integer x = 2514
integer y = 104
integer width = 699
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "   전체를 생성합니다."
boolean focusrectangle = false
end type

type uo_member_no from cuo_member_fromto_year within tabpage_sheet03
integer x = 1243
integer y = 108
integer taborder = 110
boolean bringtotop = true
end type

on uo_member_no.destroy
call cuo_member_fromto_year::destroy
end on

event ue_itemchanged();call super::ue_itemchanged;is_str_member	=	uf_str_member()
is_end_member	=	uf_end_member()

end event

type rb_ret from radiobutton within tabpage_sheet03
integer x = 1175
integer y = 36
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "퇴직"
end type

event clicked;ii_jaejik_opt	=	3

rb_ret.textcolor = rgb(0, 0, 255)
rb_jae.textcolor = rgb(0, 0, 0)
rb_all.textcolor = rgb(0, 0, 0)

wf_getchild2()
end event

type rb_jae from radiobutton within tabpage_sheet03
integer x = 942
integer y = 36
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "재직"
end type

event clicked;ii_jaejik_opt	=	1

rb_jae.textcolor = rgb(0, 0, 255)
rb_all.textcolor = rgb(0, 0, 0)
rb_ret.textcolor = rgb(0, 0, 0)

wf_getchild2()
end event

type rb_all from radiobutton within tabpage_sheet03
integer x = 704
integer y = 36
integer width = 201
integer height = 60
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

event clicked;ii_jaejik_opt	=	0

rb_all.textcolor = rgb(0, 0, 255)
rb_jae.textcolor = rgb(0, 0, 0)
rb_ret.textcolor = rgb(0, 0, 0)

wf_getchild2()
end event

type dw_jikjong from datawindow within tabpage_sheet03
integer x = 293
integer y = 108
integer width = 686
integer height = 84
integer taborder = 60
boolean bringtotop = true
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//if isnull(data) or trim(data) = '0' or trim(data) = '' then	
//	ii_str_jikjong	=	0
//	ii_end_jikjong	=	9
//else
//	ii_str_jikjong = integer(trim(data))
//	ii_end_jikjong = integer(trim(data))
//end if
//
end event

type st_5 from statictext within tabpage_sheet03
string tag = "직종명"
integer x = 23
integer y = 124
integer width = 247
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "직종명"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_list002 from uo_dwgrid within tabpage_sheet03
integer y = 228
integer width = 4352
integer height = 880
integer taborder = 20
boolean titlebar = true
string title = "급여 기초 자료"
string dataobject = "d_hpa601a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return
//
//selectrow(0, false)
//selectrow(1, true)
//
f_dw_find(idw_4, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return
//
//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_4, 'member_no')

end event

type pb_create2 from uo_imgbtn within tabpage_sheet03
integer x = 3442
integer y = 112
integer width = 315
integer taborder = 120
boolean bringtotop = true
string btnname = "생성처리"
end type

event clicked;call super::clicked;// 생성처리한다.
integer	li_rtn

setpointer(hourglass!)

li_rtn	=	wf_create()

setpointer(arrow!)

if	li_rtn = 0 then
	commit	;
	wf_retrieve()
	f_messagebox('1', string(idw_4.rowcount()) + '건의 자료를 생성했습니다.!')
	return
elseif li_rtn = 100 then
	return
end if

f_messagebox('3', sqlca.sqlerrtext)
rollback	;
wf_retrieve()


end event

on pb_create2.destroy
call uo_imgbtn::destroy
end on

