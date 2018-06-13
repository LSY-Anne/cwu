$PBExportHeader$w_hpa301b.srw
$PBExportComments$월 지급급여 생성(전체/학과별 생성)
forward
global type w_hpa301b from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type hpb_1 from hprogressbar within w_hpa301b
end type
type st_status from statictext within w_hpa301b
end type
type cb_1 from commandbutton within w_hpa301b
end type
type gb_4 from groupbox within w_hpa301b
end type
type uo_yearmonth from cuo_yearmonth within w_hpa301b
end type
type uo_dept_code from cuo_dept within w_hpa301b
end type
type st_2 from statictext within w_hpa301b
end type
type em_pay_date from editmask within w_hpa301b
end type
type dw_list004 from datawindow within w_hpa301b
end type
type dw_list005 from datawindow within w_hpa301b
end type
type cbx_1 from checkbox within w_hpa301b
end type
type st_1 from statictext within w_hpa301b
end type
type dw_head from datawindow within w_hpa301b
end type
type rb_all from radiobutton within w_hpa301b
end type
type rb_member from radiobutton within w_hpa301b
end type
type dw_update from datawindow within w_hpa301b
end type
type rb_2 from radiobutton within w_hpa301b
end type
type rb_4 from radiobutton within w_hpa301b
end type
type rb_5 from radiobutton within w_hpa301b
end type
type dw_list002_back from cuo_dwwindow within w_hpa301b
end type
type uo_insa from cuo_insa_member within w_hpa301b
end type
type dw_list002 from uo_dwgrid within w_hpa301b
end type
type dw_list003 from uo_dwgrid within w_hpa301b
end type
type dw_list003_back from cuo_dwwindow within w_hpa301b
end type
type pb_1 from uo_imgbtn within w_hpa301b
end type
end forward

global type w_hpa301b from w_tabsheet
string title = "월 지급 급여 생성"
hpb_1 hpb_1
st_status st_status
cb_1 cb_1
gb_4 gb_4
uo_yearmonth uo_yearmonth
uo_dept_code uo_dept_code
st_2 st_2
em_pay_date em_pay_date
dw_list004 dw_list004
dw_list005 dw_list005
cbx_1 cbx_1
st_1 st_1
dw_head dw_head
rb_all rb_all
rb_member rb_member
dw_update dw_update
rb_2 rb_2
rb_4 rb_4
rb_5 rb_5
dw_list002_back dw_list002_back
uo_insa uo_insa
dw_list002 dw_list002
dw_list003 dw_list003
dw_list003_back dw_list003_back
pb_1 pb_1
end type
global w_hpa301b w_hpa301b

type variables
datawindowchild	idw_child
datawindow			idw_mast, idw_data//, idw_update
datawindow			idw_item, idw_item_dtl

string	is_yearmonth, is_pay_date
string	is_str_yymm						// 소급 기준 년월
string	is_dept_code
string	is_date_gbn						// 명절구분(1=평월, 2=명절)
integer	ii_str_jikjong, ii_end_jikjong	// 직종구분

string	is_member_no, is_code, is_name, is_today
integer	ii_excepte_gbn, ii_sort, ii_num_of_paywork, ii_num_of_bonwork
integer	ii_item_gbn1					// 소급구분(0/9)
integer	ii_item_gbn2					// 계산기준(1:일기준, 2:월기준)
integer	ii_ann_opt						// 급여지급구분(1:정상지급, 2:연봉제)
dec{0}	idb_amt, idb_nontax_amt, idb_sudang_etc1, idb_sudang_etc2, idb_gongje_etc1, idb_gongje_etc2
dec{0}	idb_sudang[30], idb_gongje[30]
dec{0}	idb_youngu_amt, idb_samu_amt, idb_upmu_amt
string	is_sangjo_opt					// 상조회여부
string	is_union_opt					// 노조회여부
string	is_first_date					// 최초임용일자

string	is_member						// 조회용 사번
string	is_retire_date					// 퇴직일자
string	is_pay_opt						// 급여(1:수당, 2:공제)
integer	ii_jaejik_opt					// 재직구분
dec		ii_work_year					// 근무년수

//string	is_code_holi	=	'22'		// 명절휴가비 코드


end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_insert ()
public function integer wf_retrieve ()
public function integer wf_create4 ()
public function integer wf_create5 ()
public function integer wf_create2 ()
end prototypes

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

// 직위코드
idw_mast.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 보직코드
idw_mast.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

//// 변동구분
//idw_mast.getchild('change_opt', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('change_opt', 0) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if

// 항목구분
idw_data.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if


end subroutine

public function integer wf_insert ();// ==========================================================================================
// 기    능 : 	개인별 월 지급에 Insert
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_insert()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :

// 수정사항 :
// ==========================================================================================

long		ll_row
dec{0}	ldb_retro_amt
integer	li_work_year
dec		ldb_month
string   ls_chasu

if idb_amt = 0 and idb_nontax_amt = 0	then	return 0

if ii_num_of_paywork <= 0 then	return	0

ldb_retro_amt	=	0

if ii_ann_opt = 2 and is_code <> '00' and is_code < '50' then
	idb_amt 			= 0
	idb_nontax_amt = 0
	ldb_retro_amt 	= 0
end if

if rb_2.checked = true then
	ls_chasu = '2'
elseif rb_4.checked = true then
   ls_chasu = '4'
elseif rb_5.checked = true then
	ls_chasu ='5'
end if
//messagebox('','3'+'/'+is_member_no +'/'+string(idb_amt))
Insert	into	padb.hpa005d	
	(	member_no, year_month, chasu, code, item_name, pay_date, pay_amt, nontax_amt, retro_amt, 
		excepte_gbn, sort, contents, remark, 
		worker, work_date, ipaddr, job_uid, job_add, job_date	)	values	(
		:is_member_no, :is_yearmonth, :ls_chasu, :is_code, :is_name, :is_pay_date, :idb_amt, :idb_nontax_amt, :ldb_retro_amt, 
		:ii_excepte_gbn, :ii_sort, '', '', 
		:gs_empcode, sysdate, :gs_ip   , :gs_empcode , :gs_ip   , sysdate )	;

if sqlca.sqlcode <> 0 	then	
	
	return	sqlca.sqlcode
end if

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

if rb_all.checked then
	is_member	=	''
else
	is_member = uo_insa.is_MemberNo
	If isnull(is_member) or trim(is_member) = '' Then
		f_messagebox('1', '생성할 교/직원을 선택해 주시기 바랍니다.!')
		uo_insa.sle_kname.SetFocus()
		return	100
	End if
end if

idw_mast.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, is_member)

return 0
end function

public function integer wf_create4 ();// ==========================================================================================
// 기    능 : 	월급여생성
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_str_member, ls_end_member, ls_name
string	ls_year_month, ls_pay_date, ls_chasu
long		ll_count
long		ll_code_count
integer	i

if	f_getconfirm('4', is_yearmonth, 'Y')	>	0	then	return	100

if wf_retrieve() = 100 then	return	100

st_status.text = '급여 생성 준비중 입니다. 잠시만 기다려 주시기 바랍니다!...'

// 급여기초를 retrieve 한다.
//idw_mast: hpa001m
if idw_mast.rowcount() < 1 then
	f_messagebox('1', '급여기초자료가 존재하지 않습니다.~n~n급여기초자료를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if

// 월지급내역에 자료가 있는지 확인한다.
select	count(*)
into		:ll_count
from		padb.hpa005d a, padb.hpa001m b
where		a.year_month	=		:is_yearmonth
and		b.gwa				like	:is_dept_code 	|| '%'
and		a.member_no		like	:is_member		|| '%'
and		a.year_month	=		b.year_month
and		a.member_no		=		b.member_no
and      a.chasu        = '4'
and		substr(b.duty_code, 1, 1) >=	:ii_str_jikjong	
and		substr(b.duty_code, 1, 1) <=	:ii_end_jikjong	
and		code	 not in	(	select	code
									from		padb.hpa003m
									where		opt	=	3	)	;
//opt: 과세구분
if ll_count > 0 then
	if f_messagebox('2', '해당년월의 급여지급이 완료된 상태입니다. 자료를 삭제 후 생성하시겠습니까?') <> 1 then return	100
	
	// 입력항목을 제외한 모든 항목을 삭제한다.
	delete	from	padb.hpa005d
	where		year_month	=	:is_yearmonth
	and      chasu ='4'
	and		member_no	in	(	select	member_no
										from		padb.hpa001m
										where		year_month		=		padb.hpa005d.year_month
										and		gwa				like	:is_dept_code	||	'%'	
										and		member_no		like	:is_member		||	'%'
										and		jikjong_code	>=		:ii_str_jikjong
										and		jikjong_code	<=		:ii_end_jikjong	)
	and		code	 not in	(	select	code
										from		padb.hpa003m
										where		opt	=	3	)	;
   //opt: 과세구분
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

	// Hpa015m Clear
	delete	from	padb.hpa015m
	where		year_month	=	:is_yearmonth
	and      chasu ='4'
	and		member_no	in	(	select	member_no
										from		padb.hpa001m
										where		year_month		=		padb.hpa015m.year_month
										and		gwa				like	:is_dept_code	||	'%'
										and		member_no		like	:is_member		||	'%'
										and		jikjong_code	>=		:ii_str_jikjong
										and		jikjong_code	<=		:ii_end_jikjong	)	;
	
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
end if

ll_count = idw_mast.rowcount()		// 급여기초자료 Count

// Process Bar Setting
hpb_1.setrange(1, ll_count + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0

// 자료 생성 Start.....
long		ll_cnt1, ll_cnt2, ll_cnt3, ll_calc_count
string	ls_calc_gbn, ls_jikgub, ls_bojik, ls_gubun_chk
integer	li_jikjong, li_jikwi, li_jikmu, li_code, li_family_num
string	ls_hakbi1_yn, ls_hakbi2_yn, ls_hakbi3_yn, ls_tax_class
dec{0}	ldb_salary, ldb_iphak_amt, ldb_hakgy_amt, ldb_gisung_amt
dec{0}	ldb_sang_amt
dec		ldb_biyul
integer	li_wife_num

dec{0}	ldb_youngu_amt


setpointer(hourglass!)

st_status.text = '급여 생성중 입니다!...'
//idw_data: hpa005d
idw_data.reset()

// 급여기초자료 Loop
for ll_cnt1	= 1 to ll_count
	is_member_no		=	idw_mast.getitemstring(ll_cnt1, 'member_no')
	li_jikjong			= 	idw_mast.getitemnumber(ll_cnt1, 'jikjong_code')
	ls_jikgub			= 	idw_mast.getitemstring(ll_cnt1, 'duty_code')
	li_jikwi				= 	idw_mast.getitemnumber(ll_cnt1, 'jikwi_code')
	li_jikmu				= 	idw_mast.getitemnumber(ll_cnt1, 'jikmu_code')
	ls_bojik				= 	idw_mast.getitemstring(ll_cnt1, 'bojik_code')
	ii_work_year		= 	idw_mast.getitemnumber(ll_cnt1, 'work_year')
	ldb_salary			= 	idw_mast.getitemnumber(ll_cnt1, 'salary')
	ls_hakbi1_yn		= 	idw_mast.getitemstring(ll_cnt1, 'hakbi1_yn')
	ls_hakbi2_yn		= 	idw_mast.getitemstring(ll_cnt1, 'hakbi2_yn')
	ls_hakbi3_yn		= 	idw_mast.getitemstring(ll_cnt1, 'hakbi3_yn')
	ldb_iphak_amt		= 	idw_mast.getitemnumber(ll_cnt1, 'iphak_amt')
	ldb_hakgy_amt		= 	idw_mast.getitemnumber(ll_cnt1, 'hakgy_amt')
	ldb_gisung_amt		= 	idw_mast.getitemnumber(ll_cnt1, 'gisung_amt')
	li_wife_num			= 	idw_mast.getitemnumber(ll_cnt1, 'wife_num')
	li_family_num		= 	idw_mast.getitemnumber(ll_cnt1, 'family_num')
	ii_num_of_paywork	= 	idw_mast.getitemnumber(ll_cnt1, 'num_of_paywork')
	ii_num_of_bonwork = 	idw_mast.getitemnumber(ll_cnt1, 'num_of_bonwork')
	is_sangjo_opt		= 	idw_mast.getitemstring(ll_cnt1, 'sangjo_opt')
	is_union_opt		= 	idw_mast.getitemstring(ll_cnt1, 'union_opt')
	is_first_date		= 	idw_mast.getitemstring(ll_cnt1, 'first_date')
	ii_ann_opt			=	idw_mast.getitemnumber(ll_cnt1, 'ann_opt')
	ii_jaejik_opt		=	idw_mast.getitemnumber(ll_cnt1, 'jaejik_opt')
	is_retire_date		=	idw_mast.getitemstring(ll_cnt1, 'retire_date')
	
	for i = 1 to 30
		idb_sudang[i] = 0
		idb_gongje[i] = 0
	next
	ldb_sang_amt	=	0
	
	
//	// 본봉을 변경하지 않기 위해서 (나중에 삭제할것임)
//	select	nvl(pay_amt, 0)
//	into		:ldb_salary
//	from		padb.hpa005d
//	where		year_month 	= 	:is_yearmonth
//	and		code			=	'00'
//	and		member_no	=	:is_member_no	;
//	
//	if sqlca.sqlcode <> 0	then	return	sqlca.sqlcode

	
	// ==========================================================================================
	// 고정항목 Start
	// ==========================================================================================
	// 급여항목정보 hpa003m Retrieve... (고정항목) 두번째 아규먼트
	
	ll_code_count = idw_item.retrieve(integer(right(is_yearmonth, 2)), '1', '%')
	
	// 급여항목자료 Loop (고정항목자료)
	for ll_cnt2 = 1 to ll_code_count
		
		idb_amt 			=	0			// 금액
		idb_nontax_amt	=	0			// 비과세금액
		
		is_code			=	idw_item.getitemstring(ll_cnt2, 'code')//항목코드
		is_name			=	idw_item.getitemstring(ll_cnt2, 'item_name')//항목명
		ii_excepte_gbn	=	idw_item.getitemnumber(ll_cnt2, 'excepte_gbn')//항목구분
		ii_sort			=	idw_item.getitemnumber(ll_cnt2, 'sort')//대장출력 순서
		ls_tax_class	=	idw_item.getitemstring(ll_cnt2, 'tax_class')//과세구분
		ii_item_gbn1	=	idw_item.getitemnumber(ll_cnt2, 'item_gbn1')//소급여부
		ii_item_gbn2	=	idw_item.getitemnumber(ll_cnt2, 'item_gbn2')//특정계산월수
		is_pay_opt		=	idw_item.getitemstring(ll_cnt2, 'pay_opt')//지급구분
		
		// 급여계산기준정보 hpa003d Retrieve
		if is_code = '10' or is_code ='12' then
		  ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
		
		  if ll_calc_count < 1 then	continue
		
		// 급여계산기준정보 중에서 첫 자료만으로 계산한다.
		     ll_cnt3 = 1
		
		     ls_gubun_chk	= idw_item_dtl.getitemstring(ll_cnt3, 'gubun_chk')
		     
			  if ls_gubun_chk = '1' then
				  idb_amt	=	idw_item_dtl.getitemnumber(ll_cnt3, 'amt')
			  else
				  idb_amt	=	ldb_salary * (idw_item_dtl.getitemnumber(ll_cnt3, 'rate') / 100)
			  end if

		
		// 개인별 급여지급내역에 Insert...
		     if wf_insert() < 0 then	return	sqlca.sqlcode
	   end if
	next
	next
//// ==========================================================================================
//// 기타수당과 입력항목을 재정리시키기 위한것이다.
idw_update[1].retrieve(is_yearmonth,'4')
if idw_update[1].update() <> 1 then	return	-1

update	padb.hpa005d
set		remark		=	''
where		year_month	=	:is_yearmonth	
  and    chasu       ='4' 
  and		member_no	in	(	select	member_no
									from		padb.hpa001m
									where		year_month		=		padb.hpa005d.year_month
									and		gwa				like	:is_dept_code	||	'%'	
									and		member_no		like	:is_member		||	'%'
									and		jikjong_code	>=		:ii_str_jikjong
									and		jikjong_code	<=		:ii_end_jikjong	)	;

if sqlca.sqlcode	<>	0	then	return	sqlca.sqlcode
// 기타사항을 재정리시키기 위한것이다.
string	ls_member_no

for ll_cnt1	= 1 to ll_count
	ls_member_no	=	idw_mast.getitemstring(ll_cnt1, 'member_no')

	DECLARE sp_proc2 PROCEDURE FOR padb.usp_hpa015m_ud1(:is_yearmonth, :ls_member_no, '4')	;
	EXECUTE sp_proc2	;
next

hpb_1.position += 1
SetPointer(Arrow!)

return	0

end function

public function integer wf_create5 ();// ==========================================================================================
// 기    능 : 	월급여생성
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_str_member, ls_end_member, ls_name
string	ls_year_month, ls_pay_date, ls_jumin_no, ls_alien
long		ll_count
long		ll_code_count
Dec{2}   ll_between_month
integer	i

if	f_getconfirm('5',is_yearmonth, 'Y')	>	0	then	return	100

if wf_retrieve() = 100 then	return	100

st_status.text = '급여 생성 준비중 입니다. 잠시만 기다려 주시기 바랍니다!...'

if idw_mast.rowcount() < 1 then
	f_messagebox('1', '급여기초자료가 존재하지 않습니다.~n~n급여기초자료를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if

select	count(*)
into		:ll_count
from		padb.hpa005d a, padb.hpa001m b
where		a.year_month	=		:is_yearmonth
and		b.gwa				like	:is_dept_code 	|| '%'
and		a.member_no		like	:is_member		|| '%'
and		a.year_month	=		b.year_month
and		a.member_no		=		b.member_no
and      a.chasu        = '5'
and		substr(b.duty_code, 1, 1) >=	:ii_str_jikjong	
and		substr(b.duty_code, 1, 1) <=	:ii_end_jikjong	
and		code	 not in	(	select	code
									from		padb.hpa003m
									where		opt	=	3	)	;

if ll_count > 0 then
	if f_messagebox('2', '해당년월의 급여지급이 완료된 상태입니다. 자료를 삭제 후 생성하시겠습니까?') <> 1 then return	100
	
	delete	from	padb.hpa005d
	where		year_month	=	:is_yearmonth
	and      chasu ='5'
	and		member_no	in	(	select	member_no
										from		padb.hpa001m
										where		year_month		=		padb.hpa005d.year_month
										and		gwa				like	:is_dept_code	||	'%'	
										and		member_no		like	:is_member		||	'%'
										and		jikjong_code	>=		:ii_str_jikjong
										and		jikjong_code	<=		:ii_end_jikjong	)
	and		code	 not in	(	select	code
										from		padb.hpa003m
										where		opt	=	3	)	;

	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

	delete	from	padb.hpa015m
	where		year_month	=	:is_yearmonth
	and      chasu ='5'
	and		member_no	in	(	select	member_no
										from		padb.hpa001m
										where		year_month		=		padb.hpa015m.year_month
										and		gwa				like	:is_dept_code	||	'%'
										and		member_no		like	:is_member		||	'%'
										and		jikjong_code	>=		:ii_str_jikjong
										and		jikjong_code	<=		:ii_end_jikjong	)	;
	
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
end if

ll_count = idw_mast.rowcount()		


hpb_1.setrange(1, ll_count + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0


long		ll_cnt1, ll_cnt2, ll_cnt3, ll_calc_count
string	ls_calc_gbn, ls_jikgub, ls_bojik, ls_gubun_chk
integer	li_jikjong, li_jikwi, li_jikmu, li_code, li_family_num
string	ls_hakbi1_yn, ls_hakbi2_yn, ls_hakbi3_yn, ls_tax_class
dec{0}	ldb_salary, ldb_iphak_amt, ldb_hakgy_amt, ldb_gisung_amt
dec{0}	ldb_sang_amt
dec		ldb_biyul
integer	li_wife_num

dec		ldb_nontax_rate
dec{0}	ldb_total_amt, ldb_code_amt
dec{0}	ldb_youngu_amt, ldb_tax_amt


setpointer(hourglass!)

st_status.text = '급여 생성중 입니다!...'

idw_data.reset()


for ll_cnt1	= 1 to ll_count
	is_member_no		=	idw_mast.getitemstring(ll_cnt1, 'member_no')
	ls_jumin_no       =  idw_mast.getitemstring(ll_cnt1, 'jumin_no')
	li_jikjong			= 	idw_mast.getitemnumber(ll_cnt1, 'jikjong_code')
	ls_jikgub			= 	idw_mast.getitemstring(ll_cnt1, 'duty_code')
	li_jikwi				= 	idw_mast.getitemnumber(ll_cnt1, 'jikwi_code')
	li_jikmu				= 	idw_mast.getitemnumber(ll_cnt1, 'jikmu_code')
	ls_bojik				= 	idw_mast.getitemstring(ll_cnt1, 'bojik_code')
	ii_work_year		= 	idw_mast.getitemnumber(ll_cnt1, 'work_year')
	ldb_salary			= 	idw_mast.getitemnumber(ll_cnt1, 'salary')
	ls_hakbi1_yn		= 	idw_mast.getitemstring(ll_cnt1, 'hakbi1_yn')
	ls_hakbi2_yn		= 	idw_mast.getitemstring(ll_cnt1, 'hakbi2_yn')
	ls_hakbi3_yn		= 	idw_mast.getitemstring(ll_cnt1, 'hakbi3_yn')
	ldb_iphak_amt		= 	idw_mast.getitemnumber(ll_cnt1, 'iphak_amt')
	ldb_hakgy_amt		= 	idw_mast.getitemnumber(ll_cnt1, 'hakgy_amt')
	ldb_gisung_amt		= 	idw_mast.getitemnumber(ll_cnt1, 'gisung_amt')
	li_wife_num			= 	idw_mast.getitemnumber(ll_cnt1, 'wife_num')
	li_family_num		= 	idw_mast.getitemnumber(ll_cnt1, 'family_num')
	ii_num_of_paywork	= 	idw_mast.getitemnumber(ll_cnt1, 'num_of_paywork')
	ii_num_of_bonwork = 	idw_mast.getitemnumber(ll_cnt1, 'num_of_bonwork')
	is_sangjo_opt		= 	idw_mast.getitemstring(ll_cnt1, 'sangjo_opt')
	is_union_opt		= 	idw_mast.getitemstring(ll_cnt1, 'union_opt')
	is_first_date		= 	idw_mast.getitemstring(ll_cnt1, 'first_date')
	ii_ann_opt			=	idw_mast.getitemnumber(ll_cnt1, 'ann_opt')
	ii_jaejik_opt		=	idw_mast.getitemnumber(ll_cnt1, 'jaejik_opt')
	is_retire_date		=	idw_mast.getitemstring(ll_cnt1, 'retire_date')
	
	for i = 1 to 30
		idb_sudang[i] = 0
		idb_gongje[i] = 0
	next
	ldb_sang_amt	=	0
	
	

	
	// ==========================================================================================
	// 고정항목 Start
	// ==========================================================================================

	
	ll_code_count = idw_item.retrieve(integer(right(is_yearmonth, 2)), '1', '%')
	
	// 급여항목자료 Loop (고정항목자료)
	for ll_cnt2 = 1 to ll_code_count
		idb_amt 			=	0			
		idb_nontax_amt	=	0			
		
		is_code			=	idw_item.getitemstring(ll_cnt2, 'code')
		is_name			=	idw_item.getitemstring(ll_cnt2, 'item_name')
		ii_excepte_gbn	=	idw_item.getitemnumber(ll_cnt2, 'excepte_gbn')
		ii_sort			=	idw_item.getitemnumber(ll_cnt2, 'sort')
		ls_tax_class	=	idw_item.getitemstring(ll_cnt2, 'tax_class')
		ii_item_gbn1	=	idw_item.getitemnumber(ll_cnt2, 'item_gbn1')
		ii_item_gbn2	=	idw_item.getitemnumber(ll_cnt2, 'item_gbn2')
		is_pay_opt		=	idw_item.getitemstring(ll_cnt2, 'pay_opt')
		ldb_nontax_rate = idw_item.getitemnumber(ll_cnt2, 'nontax_rate')
		ldb_tax_amt		=	idw_item.getitemnumber(ll_cnt2, 'nontax_amt')
		
		if is_code <> '12' and is_code <> '10' then			//2차항목은 제외
           
				   
            ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				
				if ll_calc_count < 1 then	continue
					
				ll_cnt3 = 1
					
				ls_gubun_chk	= idw_item_dtl.getitemstring(ll_cnt3, 'gubun_chk')
				if ls_gubun_chk = '1' then
					idb_amt	=	idw_item_dtl.getitemnumber(ll_cnt3, 'amt')
				else
					idb_amt	=	ldb_salary * (idw_item_dtl.getitemnumber(ll_cnt3, 'rate') / 100)
				end if
				 IF	ls_tax_class  =  '2'	and  ldb_tax_amt > 0 THEN	idb_nontax_amt = ldb_tax_amt
				 IF	ls_tax_class  =  '2'	and  ldb_nontax_rate > 0 THEN	
						idb_nontax_amt = idb_amt 
				 END IF
			 
				if wf_insert() < 0 then	return	sqlca.sqlcode
			
	 	end if
	next
	
	// ==========================================================================================
	// 고정항목 End
	// ==========================================================================================
	
	// ==========================================================================================
	// 변동항목 Start
	// ==========================================================================================
	
	ll_code_count = idw_item.retrieve(integer(right(is_yearmonth, 2)), '2', '%')
	
	
	for ll_cnt2 = 1 to ll_code_count
		idb_amt 			=	0			
		idb_nontax_amt	=	0			

		is_code			=	idw_item.getitemstring(ll_cnt2, 'code')
		is_name			=	idw_item.getitemstring(ll_cnt2, 'item_name')
		ii_excepte_gbn	=	idw_item.getitemnumber(ll_cnt2, 'excepte_gbn')
		ii_sort			=	idw_item.getitemnumber(ll_cnt2, 'sort')
		ls_tax_class	=	idw_item.getitemstring(ll_cnt2, 'tax_class')
		ii_item_gbn1	=	idw_item.getitemnumber(ll_cnt2, 'item_gbn1')
		ii_item_gbn2	=	idw_item.getitemnumber(ll_cnt2, 'item_gbn2')
		is_pay_opt		=	idw_item.getitemstring(ll_cnt2, 'pay_opt')
				
		idw_item_dtl.setsort("")
		idw_item_dtl.sort()

		choose case	is_code
			// ================================================================================
			// 봉급(00)	
			// ================================================================================
			case	'00'
				idb_amt	=	ldb_salary
				
			// ================================================================================
			// 근속수당(01)	--->	
			// ================================================================================
			case	'01'
				ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				if ll_calc_count > 0 then
				   ll_cnt3 = 1
					ls_gubun_chk	= idw_item_dtl.getitemstring(ll_cnt3, 'gubun_chk')
				if ls_gubun_chk = '1' then
						idb_amt	=	idw_item_dtl.getitemnumber(ll_cnt3, 'amt')
					else
						idb_amt	=	ldb_salary * (idw_item_dtl.getitemnumber(ll_cnt3, 'rate') / 100)
					end if
				end if

			// ================================================================================
			// 가족수당(02)	--->	교원(1)		:	배우자 : 30,000, 부양가족 : 20,000
			// 							일반직(4)	:	배우자 : 30,000, 부양가족 : 20,000
			// 							기능직(5)	:	배우자 : 30,000, 부양가족 : 20,000
			// ================================================================================
			case	'02'
				
				ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				
				if ll_calc_count = 1 then
					if li_jikjong = 1 or li_jikjong = 4 or li_jikjong = 5 or li_jikjong = 6 then
						ls_gubun_chk	= idw_item_dtl.getitemstring(ll_cnt3, 'gubun_chk')
						
						if ls_gubun_chk = '1' then
							idb_amt = (li_family_num * idw_item_dtl.getitemnumber(2, 'amt'))
						else
							idb_amt = (li_family_num * (ldb_salary * (idw_item_dtl.getitemnumber(2, 'rate') / 100)))
						end if
					end if
				elseif ll_calc_count = 2 then
					if li_jikjong = 1 or li_jikjong = 4 or li_jikjong = 5 or li_jikjong = 6 then
						ls_gubun_chk	= idw_item_dtl.getitemstring(ll_cnt3, 'gubun_chk')
						
						if ls_gubun_chk = '1' then
							idb_amt = (li_wife_num * idw_item_dtl.getitemnumber(1, 'amt')) + (li_family_num * idw_item_dtl.getitemnumber(2, 'amt'))
						else
							idb_amt = (li_wife_num * (ldb_salary * (idw_item_dtl.getitemnumber(1, 'rate') / 100))) +	&
										 (li_family_num * (ldb_salary * (idw_item_dtl.getitemnumber(2, 'rate') / 100)))
						end if
					end if
			end if
				
			// ================================================================================
			// 상여수당(03)	--->	교원(1)		:	(본봉*50%)
			// 							일반직(4)	:	(본봉*50%)
			// 							기능직(5)	:	(본봉*50%)
			// ================================================================================
			case	'03'
				integer	li_num
				integer	li_curr_month, li_str_month
				dec{0}	ldb_salary2, ldb_youngu_amt2, ldb_samu_amt2, ldb_upmu_amt2
				string	ls_str_yymm
				
				if ii_jaejik_opt	= 2 then
					continue
				end if
				
 			select months_between(to_date(:is_pay_date, 'yyyymmdd'),to_date(:is_first_date,'yyyymmdd'))
				  into :ll_between_month
				  from dual;
          	 
				 if sqlca.sqlcode <> 0 then
	   			 return	sqlca.sqlcode
	          end if
				 IF ll_between_month > 3 then
					choose case	li_jikjong
						case	1 to 9 			// 교원~연봉직
   						idb_amt	=	truncate((ldb_salary * 0.5) , 0)
						case else		// 기타
							idb_amt = 0
					end choose
				end if
				
				ldb_sang_amt	=	idb_amt
		
			// ================================================================================
			// 정근수당(04)	--->	교원(1)		:	(당월본봉+당월연구수당)*비율
			// 							일반직(4)	:	(당월본봉+당월사무수당)*비율
			// 							기능직(5)	:	(당월본봉+당월업무수당)*비율
			// 							조교(2)		:	당월본봉*50%
			// ================================================================================
			case	'04'//정근수당

					idw_item_dtl.setsort("")
					idw_item_dtl.sort()
					ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
					idw_item_dtl.setsort("year_f D")
					idw_item_dtl.sort()

					if ll_calc_count > 0 then	

						ll_cnt3 = 1

						ls_gubun_chk	= idw_item_dtl.getitemstring(ll_cnt3, 'gubun_chk')
						if ls_gubun_chk = '2' then
							
							ldb_biyul	=	idw_item_dtl.getitemnumber(ll_cnt3, 'rate') / 100
					
							choose case	li_jikjong
								case	1			
									idb_amt = (ldb_salary ) * ldb_biyul
								case	4,5,6			
									idb_amt = (ldb_salary ) * ldb_biyul
								case else
									idb_amt = 0
							end choose
						else
							choose case	li_jikjong
								case	1
									idb_amt = (ldb_salary + idb_youngu_amt) + idw_item_dtl.getitemnumber(ll_cnt3, 'amt')

								case	4,6
									idb_amt = (ldb_salary + idb_samu_amt) + idw_item_dtl.getitemnumber(ll_cnt3, 'amt')
								
							   case	5
									idb_amt = (ldb_salary + idb_upmu_amt) + idw_item_dtl.getitemnumber(ll_cnt3, 'amt')
								case else
									idb_amt = 0
							end choose
						end if
					end if
			// ================================================================================
			// 학사지도비	(09)	교원은 보직이 없는자(0066)는 무조건 40,000원이다.
			// ================================================================================
			
		case	'09'
							
				if	left(ls_jikgub,2)	=	'10'	and	ls_bojik	=	'0066'  then	
					idb_amt	=	40000
				else
				  	ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
					
					if ll_calc_count < 1 then	continue

					ls_gubun_chk	= idw_item_dtl.getitemstring(1, 'gubun_chk')
					
						if ls_gubun_chk = '1' then
							idb_amt	=	idw_item_dtl.getitemnumber(1, 'amt')
						else
							idb_amt	=	ldb_salary * (idw_item_dtl.getitemnumber(1, 'rate') / 100)
						end if
				end if
         // ================================================================================
			// 학비보조수당(중고생)(13)	--->	교원(1)		:
			// 											일반직(4)	:	
			// 											기능직(5)	:
			// ================================================================================
			case	'13'
			
				ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				
				if isnull(ls_hakbi1_yn) or trim(ls_hakbi1_yn) = '' then	ls_hakbi1_yn = '0'
				if isnull(ls_hakbi2_yn) or trim(ls_hakbi2_yn) = '' then	ls_hakbi2_yn = '0'
				
				if ll_calc_count > 0 then	
					ls_gubun_chk	= idw_item_dtl.getitemstring(1, 'gubun_chk')
					
			
					if (li_jikjong = 1 or li_jikjong = 4 or li_jikjong = 5 or li_jikjong = 6) and (integer(ls_hakbi1_yn) > 0) then
						if ls_gubun_chk = '1' then
							idb_amt = idw_item_dtl.getitemnumber(1, 'amt')
						else
							idb_amt = ldb_salary * (idw_item_dtl.getitemnumber(1, 'rate') / 100)
						end if
						idb_amt = integer(ls_hakbi1_yn) * idb_amt
					end if

			
					if (li_jikjong = 1 or li_jikjong = 4 or li_jikjong = 5 or li_jikjong = 6) and (integer(ls_hakbi2_yn) > 0) then
						if ls_gubun_chk = '1' then
							idb_amt += idw_item_dtl.getitemnumber(2, 'amt')
						else
							idb_amt += ldb_salary * (idw_item_dtl.getitemnumber(2, 'rate') / 100)
						end if
						idb_amt = integer(ls_hakbi2_yn) * idb_amt
					end if
				end if

			// ================================================================================
			// 학비보조수당(대학생)(14)	--->	교원(1)		:	(입학금+학교비+기성회비)*70%
			// 											일반직(4)	:	(입학금+학교비+기성회비)*70%
			// 											기능직(5)	:	(입학금+학교비+기성회비)*70%
			// ================================================================================
			case	'14'
			
				ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				
				if ll_calc_count > 0 then	
					ls_gubun_chk	= idw_item_dtl.getitemstring(1, 'gubun_chk')
					
			
					if (li_jikjong = 1 or li_jikjong = 4 or li_jikjong = 5 or li_jikjong = 6) and (ls_hakbi3_yn = '9') then
						if ls_gubun_chk = '1' then
							idb_amt = idw_item_dtl.getitemnumber(1, 'amt')
						else
							idb_amt = (ldb_iphak_amt + ldb_hakgy_amt + ldb_gisung_amt) * (idw_item_dtl.getitemnumber(1, 'rate') / 100)
						end if
					end if
				end if				
         // ================================================================================
			// 출납수당(18)	--->	남자 :50000
			//                      여자 :30000
			// ================================================================================
		   case '18'
			
				ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				
				if ll_calc_count > 0 then	
						ls_gubun_chk	= idw_item_dtl.getitemstring(1, 'gubun_chk')
						
						if ls_gubun_chk = '1' then
							idb_amt = idw_item_dtl.getitemnumber(1, 'amt')
						else
							idb_amt = (ldb_iphak_amt + ldb_hakgy_amt + ldb_gisung_amt) * (idw_item_dtl.getitemnumber(1, 'rate') / 100)
						end if
				end if
			// ================================================================================
			// 운전수당(27)	---> 직무가 기사인사람만
			// ================================================================================
			case '27'
			
				ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				
				if ll_calc_count > 0 then	
					if li_jikmu = 31 then
						ls_gubun_chk	= idw_item_dtl.getitemstring(1, 'gubun_chk')
						
						if ls_gubun_chk = '1' then
							idb_amt = idw_item_dtl.getitemnumber(1, 'amt')
						else
							idb_amt = (ldb_iphak_amt + ldb_hakgy_amt + ldb_gisung_amt) * (idw_item_dtl.getitemnumber(1, 'rate') / 100)
						end if
					end if
				end if
         // ================================================================================
			// 시간외 수당(29)	---> 직무가 노무담당, 운전직, 교환인 사람만
			// ================================================================================
			case '29'
			
				ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				
				if ll_calc_count > 0 then	
					
					
					if li_jikmu	=	32	or li_jikmu = 31 or li_jikmu = 11 then
						ls_gubun_chk	= idw_item_dtl.getitemstring(1, 'gubun_chk')
						if ls_gubun_chk = '1' then
							idb_amt = idw_item_dtl.getitemnumber(1, 'amt')
						else
							idb_amt = (ldb_iphak_amt + ldb_hakgy_amt + ldb_gisung_amt) * (idw_item_dtl.getitemnumber(1, 'rate') / 100)
						end if
				   end if
				end if
			// ================================================================================
			// 연금부담(53)	--->	사학연금납부(padb.hpa010h) : tot_amt(납부총액)
			// ================================================================================
			case	'53'
				select	nvl(sum(tot_amt), 0)
				into		:idb_amt
				from		padb.hpa010h
				where		year_month	=	:is_yearmonth
				and		member_no	=	:is_member_no	;
				
				if sqlca.sqlcode = 100	then
					idb_amt	=	0
				elseif sqlca.sqlcode < 0 then
					return	sqlca.sqlcode
				end if

			// ================================================================================
			// 의료보험(54)	--->	건강보험공제(padb.hpa007h) : curr_amt(당월보험료)
			// 의료보험 금액이 0여도 Insert 한다.
			// ================================================================================
			case	'54'
				select	nvl(sum(SELF_INSUR_TOT), 0)
				into		:idb_amt
				from		padb.hpa007h
				where		year_month	=	:is_yearmonth
				and		member_no	=	:is_member_no	;
				
				if sqlca.sqlcode = 100 or idb_amt = 0 then	
					idb_amt = 0
					
					Insert into	padb.hpa005d	
						     ( member_no,     year_month,     code,          item_name, 
							    pay_date,      pay_amt,        nontax_amt,    retro_amt,
								 excepte_gbn,   sort,           contents,      remark,      
								 worker,        work_date,      ipaddr,        chasu)	
				     values( :is_member_no,   :is_yearmonth, :is_code,     :is_name, 
					          :is_pay_date,    :idb_amt,      0,            0,
								 :ii_excepte_gbn, :ii_sort,      '',            '',           
								 :gstru_uid_uname.uid, sysdate,       :gstru_uid_uname.address,    '5')	;

					if sqlca.sqlcode <> 0	then	return	sqlca.sqlcode
				elseif sqlca.sqlcode < 0 then
					return	sqlca.sqlcode
				end if
				
			// ================================================================================
			// 교원공제비(55)	--->	교원공제(padb.hpa008m) : gongje_amt(고지금액(공제금액))
			// ================================================================================
			case	'55'
				select	nvl(sum(gongje_amt), 0)
				into		:idb_amt
				from		padb.hpa008m
				where		year_month	=	:is_yearmonth
				and		member_no	=	:is_member_no	;
				
				if sqlca.sqlcode = 100	then
					idb_amt	=	0
				elseif sqlca.sqlcode < 0 then
					return	sqlca.sqlcode
				end if
				
			// ================================================================================
			// 연금상환(56)	--->	사학연금상환(padb.hpa011h) : gongje_amt(고지금액(공제금액))
			// ================================================================================
			case	'56'
				select	nvl(sum(source_amt), 0) + nvl(sum(int_amt), 0) + nvl(sum(delay_int), 0)
				into		:idb_amt
				from		padb.hpa011h
				where		year_month	=	:is_yearmonth
				and		member_no	=	:is_member_no	;
				
				if sqlca.sqlcode = 100	then
					idb_amt	=	0
				elseif sqlca.sqlcode < 0 then
					return	sqlca.sqlcode
				end if

			// ================================================================================
			// 건강보험료상환(57)	--->	건강보험료상환(padb.hpa008h) : total_amt(합계금액)
			// ================================================================================
			case	'57'
				select	nvl(sum(nvl(total_amt, 0)), 0)
				into		:idb_amt
				from		padb.hpa008h
				where		year_month	=	:is_yearmonth
				and		member_no	=	:is_member_no	;
				
				if sqlca.sqlcode = 100	then
					idb_amt	=	0
				elseif sqlca.sqlcode < 0 then
					return	sqlca.sqlcode
				end if
			 // ================================================================================
			// 상조회비(59)	--->	내국인 교원들과 조교들로 부과한다.
			// ================================================================================
		   case '59'
			
				ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				
				if ll_calc_count > 0 then	
               
					IF ls_jikgub < '111' or 	ls_jikgub > '200' THEN			

						ls_gubun_chk	= idw_item_dtl.getitemstring(1, 'gubun_chk')
						
						if ls_gubun_chk = '1' then
							idb_amt = idw_item_dtl.getitemnumber(1, 'amt')
						else
							idb_amt = (ldb_iphak_amt + ldb_hakgy_amt + ldb_gisung_amt) * (idw_item_dtl.getitemnumber(1, 'rate') / 100)
						end if
					end if
				end if
			 // ================================================================================
			// 청사 회비(73)	--->	여직원과 여조교들에게 부과한다. 
			// ================================================================================
		   case '73'
			
				ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
				
				if ll_calc_count > 0 then	
					
					if (mid(ls_jumin_no,7,1) = '2' or mid(ls_jumin_no,7,1) = '4') then
						
						ls_gubun_chk	= idw_item_dtl.getitemstring(1, 'gubun_chk')
						
						if ls_gubun_chk = '1' then
							idb_amt = idw_item_dtl.getitemnumber(1, 'amt')
						else
							idb_amt = (ldb_iphak_amt + ldb_hakgy_amt + ldb_gisung_amt) * (idw_item_dtl.getitemnumber(1, 'rate') / 100)
						end if
						
					end if
				
			   end if

		end choose
      if wf_insert() < 0 then	return	sqlca.sqlcode
	next
	// ==========================================================================================
	// 변동항목 End
	// ==========================================================================================

	// ==========================================================================================
	// 비과세 계산 생성(연봉자 제외)
	// ==========================================================================================
	
	// ==========================================================================================
	
	// 연말정산 환급금은 1월만 가능하다.
//	if right(is_yearmonth, 2) = '01' then
	if right(is_yearmonth, 2) = '02' then
	
//		select	b.code, b.item_name, nvl(balance_income_amt, 0), b.excepte_gbn, b.sort
//		into		:is_code, :is_name, :idb_amt, :ii_excepte_gbn, :ii_sort
//		from		padb.hpa018h a, padb.hpa003m b
//		where		year		=	to_char(to_number(substr(:is_yearmonth, 1, 4)) - 1)
//		and		b.code	=	'61'
//		and		substr(pay_month, to_number(substr(:is_yearmonth, 5, 2)), 1) = '1'
//		and		balance_tax_amt <> 0	
//		and		a.member_no	=	:is_member_no	;


//2009년 정산분
select	b.code, b.item_name, nvl((nvl(p46ctx, 0) +nvl(P46CRT,0 ) + nvl(P46CFT, 0)) * -1 , 0), b.excepte_gbn, b.sort
		into		:is_code, :is_name, :idb_amt, :ii_excepte_gbn, :ii_sort
		from		padb.HPAP46T a, padb.hpa003m b
		where		p46yar		=	to_char(to_number(substr(:is_yearmonth, 1, 4)) - 1)
		and		b.code	=	'61'
		and		substr(pay_month, to_number(substr(:is_yearmonth, 5, 2)), 1) = '1'
		and		(nvl(p46ctx, 0) +nvl(P46CRT,0 ) + nvl(P46CFT, 0))   <> 0	
		and		a.p46nno	=	:is_member_no	;
		
		if sqlca.sqlcode = 0 then
		Insert	into	padb.hpa005d	
				(	member_no, year_month, code, chasu, item_name, pay_date, pay_amt, nontax_amt, retro_amt, 
					excepte_gbn, sort, contents, remark, 
					worker, work_date, ipaddr, job_uid, job_add, job_date	)	
	   values(
					:is_member_no, :is_yearmonth, :is_code, '5', :is_name, :is_pay_date, :idb_amt, 0, 0, 
					:ii_excepte_gbn, :ii_sort, '', '', 
					:gstru_uid_uname.uid, sysdate, :gstru_uid_uname.address, :gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate )	;
	
			if sqlca.sqlcode	<>	0	then	return	sqlca.sqlcode
		end if
	end if
	hpb_1.position += 1
	
	st_status.text = string(ll_cnt1, '#,##0') + ' 건 급여 생성중 입니다!...'
next


idw_update[1].retrieve(is_yearmonth,'5')
if idw_update[1].update() <> 1 then	return	-1

update	padb.hpa005d
set		remark		=	''
where		year_month	=	:is_yearmonth	
and      chasu       ='5'
and		member_no	in	(	select	member_no
									from		padb.hpa001m
									where		year_month		=		padb.hpa005d.year_month
									and		gwa				like	:is_dept_code	||	'%'	
									and		member_no		like	:is_member		||	'%'
									and		jikjong_code	>=		:ii_str_jikjong
									and		jikjong_code	<=		:ii_end_jikjong	)	;

if sqlca.sqlcode	<>	0	then	return	sqlca.sqlcode

// 기타사항을 재정리시키기 위한것이다.
string	ls_member_no

for ll_cnt1	= 1 to ll_count
	ls_member_no	=	idw_mast.getitemstring(ll_cnt1, 'member_no')

	DECLARE sp_proc2 PROCEDURE FOR padb.usp_hpa015m_ud1(:is_yearmonth, :ls_member_no, '5')	;
	EXECUTE sp_proc2	;
next

hpb_1.position += 1
SetPointer(Arrow!)

return	0

end function

public function integer wf_create2 ();// ==========================================================================================
// 기    능 : 	월급여생성
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_str_member, ls_end_member, ls_name
string	ls_year_month, ls_pay_date
long		ll_count
long		ll_code_count
integer	i




if	f_getconfirm('2', is_yearmonth, 'Y')	>	0	then	return	100

if wf_retrieve() = 100 then	return	100

st_status.text = '급여 생성 준비중 입니다. 잠시만 기다려 주시기 바랍니다!...'

// 급여기초를 retrieve 한다.
//idw_mast: hpa001m
if idw_mast.rowcount() < 1 then
	f_messagebox('1', '급여기초자료가 존재하지 않습니다.~n~n급여기초자료를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if

// 월지급내역에 자료가 있는지 확인한다.
select	count(*)
into		:ll_count
from		padb.hpa005d a, padb.hpa001m b
where		a.year_month	=		:is_yearmonth
and		b.gwa				like	:is_dept_code 	|| '%'
and		a.member_no		like	:is_member		|| '%'
and		a.year_month	=		b.year_month
and		a.member_no		=		b.member_no
and      a.chasu        = '2'
and		substr(b.duty_code, 1, 1) >=	:ii_str_jikjong	
and		substr(b.duty_code, 1, 1) <=	:ii_end_jikjong	
and		code	 not in	(	select	code
									from		padb.hpa003m
									where		opt	=	3	)	;
//opt: 과세구분
if ll_count > 0 then
	if f_messagebox('2', '해당년월의 급여지급이 완료된 상태입니다. 자료를 삭제 후 생성하시겠습니까?') <> 1 then return	100
	
	// 입력항목을 제외한 모든 항목을 삭제한다.
	delete	from	padb.hpa005d
	where		year_month	=	:is_yearmonth
	and      chasu ='2'
	and		member_no	in	(	select	member_no
										from		padb.hpa001m
										where		year_month		=		padb.hpa005d.year_month
										and		gwa				like	:is_dept_code	||	'%'	
										and		member_no		like	:is_member		||	'%'
										and		jikjong_code	>=		:ii_str_jikjong
										and		jikjong_code	<=		:ii_end_jikjong	)
	and		code	 not in	(	select	code
										from		padb.hpa003m
										where		opt	=	3	)	;
   //opt: 과세구분
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

	// Hpa015m Clear
	delete	from	padb.hpa015m
	where		year_month	=	:is_yearmonth
	and      chasu ='2'
	and		member_no	in	(	select	member_no
										from		padb.hpa001m
										where		year_month		=		padb.hpa015m.year_month
										and		gwa				like	:is_dept_code	||	'%'
										and		member_no		like	:is_member		||	'%'
										and		jikjong_code	>=		:ii_str_jikjong
										and		jikjong_code	<=		:ii_end_jikjong	)	;
	
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
end if

ll_count = idw_mast.rowcount()		// 급여기초자료 Count

// Process Bar Setting
hpb_1.setrange(1, ll_count + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0

// 자료 생성 Start.....
long		ll_cnt1, ll_cnt2, ll_cnt3, ll_calc_count
string	ls_calc_gbn, ls_jikgub, ls_bojik, ls_gubun_chk
integer	li_jikjong, li_jikwi, li_jikmu, li_code, li_family_num
string	ls_hakbi1_yn, ls_hakbi2_yn, ls_hakbi3_yn, ls_tax_class
dec{0}	ldb_salary, ldb_iphak_amt, ldb_hakgy_amt, ldb_gisung_amt
dec{0}	ldb_sang_amt
dec		ldb_biyul
integer	li_wife_num
dec		ldb_nontax_rate
dec{0}	ldb_total_amt, ldb_code_amt
dec{0}	ldb_youngu_amt, ldb_tax_amt


setpointer(hourglass!)

st_status.text = '급여 생성중 입니다!...'

idw_data.reset()

// 급여기초자료 Loop
for ll_cnt1	= 1 to ll_count
	is_member_no		=	idw_mast.getitemstring(ll_cnt1, 'member_no')
	li_jikjong			= 	idw_mast.getitemnumber(ll_cnt1, 'jikjong_code')
	ls_jikgub			= 	idw_mast.getitemstring(ll_cnt1, 'duty_code')
	li_jikwi				= 	idw_mast.getitemnumber(ll_cnt1, 'jikwi_code')
	li_jikmu				= 	idw_mast.getitemnumber(ll_cnt1, 'jikmu_code')
	ls_bojik				= 	idw_mast.getitemstring(ll_cnt1, 'bojik_code')
	ii_work_year		= 	idw_mast.getitemnumber(ll_cnt1, 'work_year')
	ldb_salary			= 	idw_mast.getitemnumber(ll_cnt1, 'salary')
	ls_hakbi1_yn		= 	idw_mast.getitemstring(ll_cnt1, 'hakbi1_yn')
	ls_hakbi2_yn		= 	idw_mast.getitemstring(ll_cnt1, 'hakbi2_yn')
	ls_hakbi3_yn		= 	idw_mast.getitemstring(ll_cnt1, 'hakbi3_yn')
	ldb_iphak_amt		= 	idw_mast.getitemnumber(ll_cnt1, 'iphak_amt')
	ldb_hakgy_amt		= 	idw_mast.getitemnumber(ll_cnt1, 'hakgy_amt')
	ldb_gisung_amt		= 	idw_mast.getitemnumber(ll_cnt1, 'gisung_amt')
	li_wife_num			= 	idw_mast.getitemnumber(ll_cnt1, 'wife_num')
	li_family_num		= 	idw_mast.getitemnumber(ll_cnt1, 'family_num')
	ii_num_of_paywork	= 	idw_mast.getitemnumber(ll_cnt1, 'num_of_paywork')
	ii_num_of_bonwork = 	idw_mast.getitemnumber(ll_cnt1, 'num_of_bonwork')
	is_sangjo_opt		= 	idw_mast.getitemstring(ll_cnt1, 'sangjo_opt')
	is_union_opt		= 	idw_mast.getitemstring(ll_cnt1, 'union_opt')
	is_first_date		= 	idw_mast.getitemstring(ll_cnt1, 'first_date')
	ii_ann_opt			=	idw_mast.getitemnumber(ll_cnt1, 'ann_opt')
	ii_jaejik_opt		=	idw_mast.getitemnumber(ll_cnt1, 'jaejik_opt')
	is_retire_date		=	idw_mast.getitemstring(ll_cnt1, 'retire_date')
	
	for i = 1 to 30
		idb_sudang[i] = 0
		idb_gongje[i] = 0
	next
	ldb_sang_amt	=	0
	
	ll_code_count = idw_item.retrieve(integer(right(is_yearmonth, 2)), '1', '%')
   
   LONG LL_CODES_COUNT
	int  li_year
   li_year = integer(right(is_yearmonth,2))
   
	SELECT count(*)
     INTO :LL_CODES_COUNT
     FROM "PADB"."HPA003M"  
    WHERE ( PADB."HPA003M"."USE_YN" = '9' ) AND
	       ( PADB."HPA003M"."CODE"   IN ('10','12')) AND
          ( PADB."HPA003M"."OPT" like '1%' ) AND  
		    ( decode(:li_year, 0, PADB."HPA003M"."PAY_MONTH", substr(PADB."HPA003M"."PAY_MONTH", :li_year, 1 ))	=
			   decode(:li_year, 0, '000000000000', '1'));
 
   if sqlca.sqlcode < 0 then return sqlca.sqlcode

   if ll_codes_count < 1 then
		messagebox('','연구 보조비 지급월이 아닙니다. 다시 확인하여 주십시요')
		return 100
	end if

	
   
	for ll_cnt2 = 1 to ll_code_count
		idb_amt 			=	0			
		idb_nontax_amt	=	0			
		
		is_code			=	idw_item.getitemstring(ll_cnt2, 'code')
		is_name			=	idw_item.getitemstring(ll_cnt2, 'item_name')
		ii_excepte_gbn	=	idw_item.getitemnumber(ll_cnt2, 'excepte_gbn')
		ii_sort			=	idw_item.getitemnumber(ll_cnt2, 'sort')
		ls_tax_class	=	idw_item.getitemstring(ll_cnt2, 'tax_class')
		ii_item_gbn1	=	idw_item.getitemnumber(ll_cnt2, 'item_gbn1')
		ii_item_gbn2	=	idw_item.getitemnumber(ll_cnt2, 'item_gbn2')
		is_pay_opt		=	idw_item.getitemstring(ll_cnt2, 'pay_opt')
		ldb_nontax_rate = idw_item.getitemnumber(ll_cnt2, 'nontax_rate')
		ldb_tax_amt 	=  idw_item.getitemnumber(ll_cnt2, 'nontax_amt')

		if is_code = '10' or is_code ='12' then
		 
		 ll_calc_count = idw_item_dtl.retrieve(is_code, li_jikjong, ls_jikgub, li_jikwi, li_jikmu, ls_bojik, ii_work_year)
	     
		 if ll_calc_count < 1 then	 continue
		 
		 ll_cnt3 = 1
		
		 ls_gubun_chk	= idw_item_dtl.getitemstring(ll_cnt3, 'gubun_chk')
		     
		 if ls_gubun_chk = '1' then
			 idb_amt	=	idw_item_dtl.getitemnumber(ll_cnt3, 'amt')
		 else
			 idb_amt	=	ldb_salary * (idw_item_dtl.getitemnumber(ll_cnt3, 'rate') / 100)
		 end if
		 IF	ls_tax_class  =  '2'	and  ldb_tax_amt > 0 THEN	idb_nontax_amt = ldb_tax_amt
		 IF	ls_tax_class  =  '2'	and  ldb_nontax_rate > 0 THEN	
				idb_nontax_amt = idb_amt 
		 END IF
		 if wf_insert() < 0 then	return	sqlca.sqlcode
	  end if
	next

	hpb_1.position += 1 
   
next
//messagebox('',is_yearmonth)
idw_update[1].retrieve(is_yearmonth,'2')
if idw_update[1].update() <> 1 then	return	-1

update	padb.hpa005d
set		remark		=	''
where		year_month	=	:is_yearmonth	
  and    chasu       ='2' 
  and		member_no	in	(	select	member_no
									from		padb.hpa001m
									where		year_month		=		padb.hpa005d.year_month
									and		gwa				like	:is_dept_code	||	'%'	
									and		member_no		like	:is_member		||	'%'
									and		jikjong_code	>=		:ii_str_jikjong
									and		jikjong_code	<=		:ii_end_jikjong	)	;

if sqlca.sqlcode	<>	0	then	return	sqlca.sqlcode
// 기타사항을 재정리시키기 위한것이다.
string	ls_member_no

for ll_cnt1	= 1 to ll_count
	ls_member_no	=	idw_mast.getitemstring(ll_cnt1, 'member_no')

	DECLARE sp_proc2 PROCEDURE FOR padb.usp_hpa015m_ud1(:is_yearmonth, :ls_member_no, '2')	;
	EXECUTE sp_proc2	;
next



SetPointer(Arrow!)
return	0

end function

on w_hpa301b.create
int iCurrent
call super::create
this.hpb_1=create hpb_1
this.st_status=create st_status
this.cb_1=create cb_1
this.gb_4=create gb_4
this.uo_yearmonth=create uo_yearmonth
this.uo_dept_code=create uo_dept_code
this.st_2=create st_2
this.em_pay_date=create em_pay_date
this.dw_list004=create dw_list004
this.dw_list005=create dw_list005
this.cbx_1=create cbx_1
this.st_1=create st_1
this.dw_head=create dw_head
this.rb_all=create rb_all
this.rb_member=create rb_member
this.dw_update=create dw_update
this.rb_2=create rb_2
this.rb_4=create rb_4
this.rb_5=create rb_5
this.dw_list002_back=create dw_list002_back
this.uo_insa=create uo_insa
this.dw_list002=create dw_list002
this.dw_list003=create dw_list003
this.dw_list003_back=create dw_list003_back
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.hpb_1
this.Control[iCurrent+2]=this.st_status
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_4
this.Control[iCurrent+5]=this.uo_yearmonth
this.Control[iCurrent+6]=this.uo_dept_code
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.em_pay_date
this.Control[iCurrent+9]=this.dw_list004
this.Control[iCurrent+10]=this.dw_list005
this.Control[iCurrent+11]=this.cbx_1
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.dw_head
this.Control[iCurrent+14]=this.rb_all
this.Control[iCurrent+15]=this.rb_member
this.Control[iCurrent+16]=this.dw_update
this.Control[iCurrent+17]=this.rb_2
this.Control[iCurrent+18]=this.rb_4
this.Control[iCurrent+19]=this.rb_5
this.Control[iCurrent+20]=this.dw_list002_back
this.Control[iCurrent+21]=this.uo_insa
this.Control[iCurrent+22]=this.dw_list002
this.Control[iCurrent+23]=this.dw_list003
this.Control[iCurrent+24]=this.dw_list003_back
this.Control[iCurrent+25]=this.pb_1
end on

on w_hpa301b.destroy
call super::destroy
destroy(this.hpb_1)
destroy(this.st_status)
destroy(this.cb_1)
destroy(this.gb_4)
destroy(this.uo_yearmonth)
destroy(this.uo_dept_code)
destroy(this.st_2)
destroy(this.em_pay_date)
destroy(this.dw_list004)
destroy(this.dw_list005)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.dw_head)
destroy(this.rb_all)
destroy(this.rb_member)
destroy(this.dw_update)
destroy(this.rb_2)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.dw_list002_back)
destroy(this.uo_insa)
destroy(this.dw_list002)
destroy(this.dw_list003)
destroy(this.dw_list003_back)
destroy(this.pb_1)
end on

event ue_retrieve;call super::ue_retrieve;///////////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()


return 1
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
//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		fALSE)
//
//idw_mast			=	dw_list002
//idw_data			=	dw_list003
//idw_item			=	dw_list004
//idw_item_dtl	=	dw_list005
//idw_update		=	dw_update
//
//
//
//// 월 생성 년월
//uo_yearmonth.uf_settitle('지급년월')
//is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
//
//// 학과명
//uo_dept_code.uf_setdept('', '학과명')
//is_dept_code	=	uo_dept_code.uf_getcode()
//
//// 지급일자
//is_pay_date	=	left(f_today(), 6) + '25'
//em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')
//
//is_date_gbn	=	'1'		// 평월
//rb_all.triggerevent(clicked!)
//rb_2.checked = true
//f_getdwcommon(dw_head, 'jikjong_code', 0, 750)
//
//wf_getchild()
//
////triggerevent('ue_retrieve')
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
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

idw_mast			=	dw_list002
idw_data			=	dw_list003
idw_item			=	dw_list004
idw_item_dtl	=	dw_list005
idw_update[1]		=	dw_update



// 월 생성 년월
uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

// 학과명
uo_dept_code.uf_setdept('', '학과명')
is_dept_code	=	uo_dept_code.uf_getcode()

// 지급일자
is_pay_date	=	left(f_today(), 6) + '25'
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')


is_date_gbn	=	'1'		// 평월

f_getdwcommon(dw_head, 'jikjong_code', 0, 750)

wf_getchild()

rb_all.triggerevent(clicked!)
rb_all.checked = true
rb_2.checked = true
//triggerevent('ue_retrieve')

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa301b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa301b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa301b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa301b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa301b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa301b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa301b
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa301b
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa301b
end type

type uc_save from w_tabsheet`uc_save within w_hpa301b
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa301b
end type

type uc_print from w_tabsheet`uc_print within w_hpa301b
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa301b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa301b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa301b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa301b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa301b
integer beginy = 544
integer endy = 544
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa301b
boolean visible = false
integer y = 1800
integer width = 3881
integer height = 720
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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
integer y = 104
integer width = 3845
integer height = 600
string text = "급여계산기준코드관리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 312
integer width = 873
integer height = 1868
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

type uo_tab from w_tabsheet`uo_tab within w_hpa301b
integer x = 1751
integer y = 1904
end type

type dw_con from w_tabsheet`dw_con within w_hpa301b
boolean visible = false
integer width = 41
end type

type st_con from w_tabsheet`st_con within w_hpa301b
integer x = 55
integer height = 380
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 3845
integer height = 600
long backcolor = 79741120
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type hpb_1 from hprogressbar within w_hpa301b
integer x = 101
integer y = 716
integer width = 4283
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_status from statictext within w_hpa301b
integer x = 114
integer y = 636
integer width = 3781
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "진행 상태..."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_hpa301b
event keypress pbm_keydown
boolean visible = false
integer x = 1701
integer y = 328
integer width = 370
integer height = 104
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "처리"
end type

event keypress;if key = keyenter! then
	this.post event clicked()
end if
end event

event clicked;//string ls_year
//long   ll_count
//

end event

type gb_4 from groupbox within w_hpa301b
integer x = 50
integer y = 556
integer width = 4384
integer height = 288
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "진행상태"
end type

type uo_yearmonth from cuo_yearmonth within w_hpa301b
event destroy ( )
integer x = 114
integer y = 180
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yearmonth	=	uf_getyearmonth()

is_pay_date = is_yearmonth + right(em_pay_date.text, 2)
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')

//parent.triggerevent('ue_retrieve')

end event

type uo_dept_code from cuo_dept within w_hpa301b
event destroy ( )
integer x = 1019
integer y = 176
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

on uo_dept_code.destroy
call cuo_dept::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_dept_code = uf_getcode()

//parent.triggerevent('ue_retrieve')
end event

type st_2 from statictext within w_hpa301b
integer x = 178
integer y = 288
integer width = 279
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "지급일자"
boolean focusrectangle = false
end type

type em_pay_date from editmask within w_hpa301b
integer x = 453
integer y = 272
integer width = 480
integer height = 84
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
	is_pay_date = ''
end if

is_pay_date	=	string(ldt_pay_date, 'yyyymmdd')

end event

type dw_list004 from datawindow within w_hpa301b
event ue_dwnkey pbm_dwnkey
boolean visible = false
integer x = 1353
integer y = 868
integer width = 1509
integer height = 512
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa301b_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_list005 from datawindow within w_hpa301b
boolean visible = false
integer x = 18
integer y = 1664
integer width = 3867
integer height = 512
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa301b_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cbx_1 from checkbox within w_hpa301b
boolean visible = false
integer x = 2386
integer y = 284
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
string text = "소급금계산"
end type

type st_1 from statictext within w_hpa301b
integer x = 1042
integer y = 288
integer width = 206
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "직종명"
boolean focusrectangle = false
end type

type dw_head from datawindow within w_hpa301b
integer x = 1262
integer y = 272
integer width = 686
integer height = 84
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) or trim(data) = '0' or trim(data) = '' then	
	ii_str_jikjong	=	0
	ii_end_jikjong	=	9
else
	ii_str_jikjong = integer(trim(data))
	ii_end_jikjong = integer(trim(data))
end if

end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type rb_all from radiobutton within w_hpa301b
integer x = 2039
integer y = 288
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "전체"
boolean checked = true
boolean automatic = false
end type

event clicked;uo_insa.trigger event ue_enbled(false)
this.checked = true
rb_member.checked = false

end event

type rb_member from radiobutton within w_hpa301b
integer x = 2249
integer y = 288
integer width = 288
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "개인별"
boolean automatic = false
end type

event clicked;uo_insa.trigger event ue_enbled(true)
uo_insa.sle_kname.setfocus()
this.checked = true
rb_all.checked = false
end event

type dw_update from datawindow within w_hpa301b
boolean visible = false
integer x = 398
integer y = 1232
integer width = 2679
integer height = 432
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa301b_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type rb_2 from radiobutton within w_hpa301b
integer x = 471
integer y = 48
integer width = 576
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "2차 연구 보조비"
boolean automatic = false
end type

event clicked;is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
is_pay_date	=	left(is_yearmonth, 6) + '05'
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')
this.checked = true
rb_5.checked = false
end event

type rb_4 from radiobutton within w_hpa301b
boolean visible = false
integer x = 2619
integer y = 192
integer width = 576
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "4차 유 사 급 여"
end type

event clicked;is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
is_pay_date	=	left(is_yearmonth, 6) + '25'
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')
end event

type rb_5 from radiobutton within w_hpa301b
integer x = 1093
integer y = 48
integer width = 576
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "5차 정 상 급 여"
boolean automatic = false
end type

event clicked;is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
is_pay_date	=	left(is_yearmonth, 6) + '25'
em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')
this.checked = true
rb_2.checked = false
end event

type dw_list002_back from cuo_dwwindow within w_hpa301b
event un_unmove pbm_syscommand
boolean visible = false
integer x = 73
integer y = 924
integer width = 9
integer height = 12
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "급여 기초 사항"
string dataobject = "d_hpa301b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(false)
end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row
string ls_chasu

if isnull(currentrow) or currentrow < 1 then return

selectrow(0, false)
selectrow(currentrow, true)

//f_dw_find(this, dw_data, 'member_no')
if rb_2.checked = true then
	ls_chasu = '2'
elseif rb_4.checked = true then
	ls_chasu = '4'
elseif rb_5.checked = true then
	ls_chasu = '5'
end if
idw_data.retrieve(is_yearmonth, is_dept_code, getitemstring(currentrow, 'member_no'),ls_chasu )


end event

event retrieveend;call super::retrieveend;long	ll_row
string ls_chasu

if isnull(rowcount) or rowcount < 1 then return

selectrow(0, false)
selectrow(1, true)

//f_dw_find(dw_data, this, 'member_no')
if rb_2.checked = true then
	ls_chasu = '2'
elseif rb_4.checked = true then
	ls_chasu = '4'
elseif rb_5.checked = true then
	ls_chasu = '5'
end if

idw_data.retrieve(is_yearmonth, is_dept_code, getitemstring(1, 'member_no'),ls_chasu)



end event

type uo_insa from cuo_insa_member within w_hpa301b
integer x = 210
integer y = 364
integer width = 3877
integer height = 172
integer taborder = 120
boolean bringtotop = true
end type

on uo_insa.destroy
call cuo_insa_member::destroy
end on

type dw_list002 from uo_dwgrid within w_hpa301b
integer x = 50
integer y = 848
integer width = 4375
integer height = 840
integer taborder = 100
boolean bringtotop = true
boolean titlebar = true
string title = "급여 기초 사항"
string dataobject = "d_hpa301b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event retrieveend;call super::retrieveend;long	ll_row
string ls_chasu

if isnull(rowcount) or rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

//f_dw_find(dw_data, this, 'member_no')
if rb_2.checked = true then
	ls_chasu = '2'
elseif rb_4.checked = true then
	ls_chasu = '4'
elseif rb_5.checked = true then
	ls_chasu = '5'
end if

idw_data.retrieve(is_yearmonth, is_dept_code, getitemstring(1, 'member_no'),ls_chasu)



end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row
string ls_chasu

if isnull(currentrow) or currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

//f_dw_find(this, dw_data, 'member_no')
if rb_2.checked = true then
	ls_chasu = '2'
elseif rb_4.checked = true then
	ls_chasu = '4'
elseif rb_5.checked = true then
	ls_chasu = '5'
end if
idw_data.retrieve(is_yearmonth, is_dept_code, getitemstring(currentrow, 'member_no'),ls_chasu )


end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_list003 from uo_dwgrid within w_hpa301b
integer x = 50
integer y = 1688
integer width = 4375
integer height = 580
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string title = "급여 지급 내역"
string dataobject = "d_hpa301b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_mast, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_mast, 'member_no')

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_list003_back from cuo_dwwindow within w_hpa301b
boolean visible = false
integer x = 521
integer y = 1600
integer width = 9
integer height = 12
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "급여 지급 내역"
string dataobject = "d_hpa301b_2"
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

type pb_1 from uo_imgbtn within w_hpa301b
integer x = 55
integer y = 36
integer taborder = 20
boolean bringtotop = true
string btnname = "생성처리"
end type

event clicked;call super::clicked;// 생성처리한다.
integer	li_rtn
long		ll_count, ll_judge
string   ls_chasu

setpointer(hourglass!)

if rb_5.checked = true then
	ls_chasu = '5'
	select count(*)
	  into :ll_judge
	  from padb.hpa021m 
	 where confirm_gbn = 9
		and year_month = :is_yearmonth
		and chasu      = :ls_chasu;
	
	if sqlca.sqlcode <> 0 then return 
   
	if ll_judge = 0 then
	   li_rtn	=	wf_create5()
	else
		messagebox('','이미 확정처리가 되었습니다.')
	   return
   end if
	
elseif rb_4.checked = true then
	
	ls_chasu = '4'
	
	select count(*)
	  into :ll_judge
	  from padb.hpa021m 
	 where confirm_gbn = 9
		and year_month = :is_yearmonth
		and chasu      = :ls_chasu;
	
	if sqlca.sqlcode <> 0 then return 
   
	if ll_judge = 0 then
	   li_rtn	=	wf_create4()
	else
		messagebox('','이미 확정처리가 되었습니다.')
	   return
   end if

elseif rb_2.checked = true then
	ls_chasu = '2'
	
	select count(*)
	  into :ll_judge
	  from padb.hpa021m 
	 where confirm_gbn = 9
		and year_month = :is_yearmonth
		and chasu      = :ls_chasu;
	
	if sqlca.sqlcode <> 0 then return 
   
	if ll_judge = 0 then
	   li_rtn	=	wf_create2()
	else
		messagebox('','이미 확정처리가 되었습니다.')
	   return
   end if
	
end if
//
setpointer(arrow!)

if	li_rtn = 0 then
	commit;
	parent.triggerevent('ue_retrieve')
	
	select	count(distinct b.member_no)
	into		:ll_count
	from		padb.hpa005d a, padb.hpa001m b
	where		b.year_month	=		:is_yearmonth	
	and		b.gwa				like	:is_dept_code 	|| '%'
	and		b.member_no		like	:is_member		|| '%'
	and      a.chasu        = :ls_chasu
	and		a.year_month	=		b.year_month
	and		a.member_no		=		b.member_no	
	and		b.jikjong_code	>=		:ii_str_jikjong
	and		b.jikjong_code	<=		:ii_end_jikjong	;

	f_messagebox('1', string(ll_count, '#0') + '건의 자료를 생성했습니다.!')
elseif li_rtn < 0 then
	f_messagebox('3', '[' + is_member_no + '/' + is_code + ']' + sqlca.sqlerrtext)

	rollback	;
	parent.triggerevent('ue_retrieve')
end if


end event

on pb_1.destroy
call uo_imgbtn::destroy
end on

