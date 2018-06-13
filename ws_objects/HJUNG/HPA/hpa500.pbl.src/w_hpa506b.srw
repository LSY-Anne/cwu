$PBExportHeader$w_hpa506b.srw
$PBExportComments$월 지급 강사료 생성(전체/학과별 생성)
forward
global type w_hpa506b from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type hpb_1 from hprogressbar within w_hpa506b
end type
type st_status from statictext within w_hpa506b
end type
type cb_1 from commandbutton within w_hpa506b
end type
type uo_yearhakgi from cuo_yyhakgi within w_hpa506b
end type
type uo_month from cuo_month within w_hpa506b
end type
type st_31 from statictext within w_hpa506b
end type
type uo_gwa from cuo_hakgwa within w_hpa506b
end type
type gb_4 from groupbox within w_hpa506b
end type
type rb_all from radiobutton within w_hpa506b
end type
type rb_gwa from radiobutton within w_hpa506b
end type
type rb_member_no from radiobutton within w_hpa506b
end type
type em_pay_date from editmask within w_hpa506b
end type
type st_pay_date from statictext within w_hpa506b
end type
type uo_insa from cuo_insa_member_gangsa within w_hpa506b
end type
type dw_list002 from uo_dwgrid within w_hpa506b
end type
type dw_list003 from uo_dwgrid within w_hpa506b
end type
type pb_1 from uo_imgbtn within w_hpa506b
end type
end forward

global type w_hpa506b from w_tabsheet
integer width = 4530
integer height = 2440
string title = "월 지급 강사료 생성"
hpb_1 hpb_1
st_status st_status
cb_1 cb_1
uo_yearhakgi uo_yearhakgi
uo_month uo_month
st_31 st_31
uo_gwa uo_gwa
gb_4 gb_4
rb_all rb_all
rb_gwa rb_gwa
rb_member_no rb_member_no
em_pay_date em_pay_date
st_pay_date st_pay_date
uo_insa uo_insa
dw_list002 dw_list002
dw_list003 dw_list003
pb_1 pb_1
end type
global w_hpa506b w_hpa506b

type variables
datawindowchild	idw_child
datawindow			idw_mast, idw_data

string	is_pay_date
string	is_dept_code, is_member_no
string	is_yy, is_hakgi
integer	ii_month
end variables

forward prototypes
public subroutine wf_getdate ()
public subroutine wf_getchild ()
public function integer wf_condition_chk ()
public function integer wf_retrieve ()
public function integer wf_create_1 ()
public function integer wf_create_2 ()
public function integer wf_create_3 ()
end prototypes

public subroutine wf_getdate ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 지급일자
select	nvl(to_date, '')
into		:is_pay_date
from		padb.hpa101m
where		year	=	:is_yy
and		hakgi	=	:is_hakgi
and		month	=	:ii_month	;

if sqlca.sqlcode <> 0	then
	f_messagebox('1', is_yy + '년도 ' + is_hakgi + '학기 ' + string(ii_month) + '월의 주 자료가 존재하지 않습니다.')
	is_pay_date	=	left(f_today(), 6) + '25'
end if

em_pay_date.text = string(is_pay_date, '@@@@/@@/@@')

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

//// 학과명
//dw_head.getchild('code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('1') < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//
//dw_head.reset()
//dw_head.insertrow(0)

// 강사료구분
idw_mast.getchild('sec_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 은행코드
idw_mast.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public function integer wf_condition_chk ();// ==========================================================================================
// 기    능 : 	create condition check
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_condition_chk()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

wf_setmsg('생성조건 Check')

is_yy     	= 	uo_yearhakgi.uf_getyy()
is_hakgi  	= 	uo_yearhakgi.uf_gethakgi()
ii_month		=	integer(uo_month.uf_getmm())

if isnull(is_yy) or trim(is_yy) = '' then
	f_messagebox('1', '생성년도 정확히 입력해 주세요.!')
	uo_yearhakgi.em_yy.setfocus()
	return 	-1
end if

if isnull(is_hakgi) or trim(is_hakgi) = '' then
	f_messagebox('1', '생성학기를 정확히 입력해 주세요.!')
	uo_yearhakgi.em_hakgi.setfocus()
	return 	-1
end if

if isnull(ii_month) or ii_month = 0 then
	f_messagebox('1', '생성월을 정확히 입력해 주세요.!')
	uo_month.em_mm.setfocus()
	return	-1
end if

If rb_all.Checked Then //전체
	is_dept_code   = '%'
	is_member_no	= '%'
ElseIf rb_gwa.Checked Then //학과
	is_dept_code   = uo_gwa.uf_getgwa()
	If isnull(is_dept_code) or trim(is_dept_code) = '' Then
		f_messagebox('1', '학과를 선택해 주시기 바랍니다.!')
		uo_gwa.SetFocus()
		return	-1
	End if
	is_member_no	= '%'
ElseIf rb_member_no.Checked Then //개인별
	is_dept_code   = '%'
	is_member_no	= uo_insa.sle_Member_No.Text
	If isnull(is_member_no) or trim(is_member_no) = '' Then
		f_messagebox('1', '개인을 선택해 주시기 바랍니다.!')
		uo_insa.sle_kname.SetFocus()
		return	-1
	End if
End if

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

idw_mast.retrieve(is_yy, is_hakgi, is_dept_code, is_member_no)
idw_data.retrieve(is_yy, is_hakgi, ii_month, is_dept_code, is_member_no)

return 0
end function

public function integer wf_create_1 ();// ==========================================================================================
// 기    능 : 	강사료 생성(hpa116t)
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create_1()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_str_member, ls_end_member, ls_name
string	ls_year_month, ls_pay_date
long		ll_count, ll_mast_count
long		ll_code_count, ll_cnt
integer	i

integer	li_str_weekend = 0, li_end_weekend = 0

st_status.text = '급여 생성 준비중 입니다. 잠시만 기다려주시기 바랍니다!...'

// 생성조건 체크
if wf_condition_chk() < 0 then	return	-1

select count(*) 
into	:ll_cnt
from  padb.hpa021m 
where year_month = :is_yy || ltrim(to_char(:ii_month,'00'))
and	CONFIRM_GBN	= '9'
and	chasu      = '1';

if	ll_cnt > 0 then
	f_messagebox('3','이미 확정작업을 하였습니다.')
	return -1
end if

// 수업주차에 자료가 있는지 확인한다.
select	nvl(from_weekend, 0), nvl(to_weekend, 0)
into		:li_str_weekend, :li_end_weekend
from		padb.hpa101m
where		year			=	:is_yy
and		hakgi			=	:is_hakgi
and		month			=	:ii_month	;

if li_str_weekend = 0 or li_end_weekend = 0 or sqlca.sqlcode <> 0 then
	f_messagebox('1', '수업주차자료가 존재하지 않습니다.~n~n수업주차자료를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	-1
end if

idw_data.reset()

wf_retrieve()

// 강사지급기초를 retrieve 한다.
if idw_mast.rowcount() < 1 then
	f_messagebox('1', '강사기초자료가 존재하지 않습니다.~n~n강사기초자료를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	-1
end if

//if ll_mast_count > 0 then
	if f_messagebox('2', is_yy + '년 ' + string(ii_month) + '월의 시간강사료 생성이 이미 완료된 상태입니다.~n~n자료를 삭제 후 다시 생성하시겠습니까?') <> 1 then return	-1
	
	// delete 순서를 바꾸면 안된다....
	delete	from	padb.hpa116t
	where		year			=	:is_yy
	and		hakgi			=	:is_hakgi
	and		month			=	:ii_month
	and		member_no	like	:is_member_no		;
	
	if sqlca.sqlcode <> 0 then
		f_messagebox('3', sqlca.sqlerrtext)
		return	sqlca.sqlcode
	end if

	delete	from	padb.hpa113t
	where		year			=	:is_yy
	and		hakgi			=	:is_hakgi
	and		month			=	:ii_month
	and		member_no	like	:is_member_no	;
	
	if sqlca.sqlcode <> 0 then
		f_messagebox('3', sqlca.sqlerrtext)
		return	sqlca.sqlcode
	end if
	
//end if

if f_messagebox('2', string(is_yy + is_hakgi, '@@@@년 @학기 ') + string(ii_month) + ' 월 강사료를 ' + string(is_pay_date, '@@@@년 @@월 @@일') + '에 지급합니다.~n~n자료를 생성하시겠습니까?')	=	2	then	return	100

ll_mast_count = idw_mast.rowcount()		// 기초자료 Count

// Process Bar Setting
//hpb_1.setrange(1, ll_mast_count + 1)
hpb_1.setrange(1, (ll_mast_count * (li_end_weekend - li_str_weekend + 1)) + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0

// 자료 생성 Start.....
long		ll_cnt1, ll_cnt2
string	ls_member_no
integer	li_num_of_time, li_num_of_general, li_num_of_middle, li_num_of_large
integer	li_num_of_nigeneral, li_num_of_nimiddle, li_num_of_nilarge, li_limit_time

setpointer(hourglass!)

st_status.text = '자료 생성중 입니다!...'

hpb_1.position += 1
// 월 강사료 시수내역 생성(hpa113t)
if wf_create_2() <> 0 then	
	f_messagebox('3', '[hpa113t Insert]' + sqlca.sqlerrtext)
	return	sqlca.sqlcode
end if
// 강사료지급내역 생성(hpa116t)
if wf_create_3() <> 0 then	
	f_messagebox('3', '[hpa116t Insert]' + sqlca.sqlerrtext)
	return	sqlca.sqlcode
end if
SetPointer(Arrow!)

return	0

end function

public function integer wf_create_2 ();// ==========================================================================================
// 기    능 : 	월 강사료 시수내역 생성(hpa113t)
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create_2()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 월 강사료 시수내역 생성(hpa113t)
insert	into	padb.hpa113t	
		(	year, hakgi, month, member_no,
			damdang_tot, 				//담당
			num_of_overtime, 			//초과
			num_of_tottime, 			//책임
			num_of_real,				//미사용
			num_of_month_fee1, 		//초과1
			num_of_month_fee2, 		//초과2
			num_of_month_fee3, 		//초과3
			num_of_month_fee4,		//초과4
			num_of_move_fee1,			//미사용
			num_of_month_ni_fee1, 	//미사용
			num_of_month_ni_fee2, 	//미사용
			num_of_month_ni_fee3, 	//미사용
			num_of_month_ni_fee4, 	//미사용
			num_of_exam, 				//미사용
			num_of_overlecture, 		//초과120
			sum_of_pause, 				//휴강
			bogang_tot,					//보강
			worker, ipaddr, work_date, work_gbn,
			job_uid, job_add, job_date	)
select	:is_yy, :is_hakgi, :ii_month, a.member_no, 
			sum(NVL(b.num_of_general,0))  as gen_sum, //담당시수
			sum(NVL(b.num_of_overtime1,0)) as overtime_sum,  //초과시수
			sum(NVL(b.num_of_time,0)) as time_sum,		//책임시수
			0,		
			sum(b.num_of_overtime1)	num_of_overtime1,		//초과1
			sum(b.num_of_overtime2)	num_of_overtime2,		//초과2
			sum(b.num_of_overtime3)	num_of_overtime3,		//초과3
			sum(b.num_of_overtime4)	num_of_overtime4,		//초과4
			0, 
			0, 0, 0, 0,
			0, 
			NVL(SUM(b.NUM_OF_NIGENERAL),0) as OT120, //초과120
			NVL(SUM(b.TIME_OF_PAUSE1),0)  as PAUSE,	//휴강
			NVL(SUM(b.BOGANG_SISU_1),0)  as BOGANG, //보강시수
			:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate, 'C',
			:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate
from		padb.hpa111m a, padb.hpa112t b
where		a.year		=		:is_yy
and		a.hakgi		=		:is_hakgi
and		a.gwa			like	:is_dept_code 	|| '%'
and		a.member_no	like	:is_member_no	||	'%'
and		b.month		=		:ii_month
and		a.year		=		b.year
and		a.hakgi 		=		b.hakgi
and		a.member_no =		b.member_no
group by a.member_no
order by a.member_no	;

return	sqlca.sqlcode

end function

public function integer wf_create_3 ();// ==========================================================================================
// 기    능 : 	강사료지급내역 생성(hpa116t)
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create_3()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 강사료지급내역 생성(hpa116t)
IF		is_hakgi	=	'1' OR is_hakgi = '2'	THEN
		insert	into	padb.hpa116t
				(	year, hakgi, month, member_no, pay_item_code,
					pay_time, 		//시수
					pay_amt, 		//지급강사료
					retro_amt, 		//초과120강사료
					month_amt, 		//합계금액
					pay_date, holiday_opt,
					worker, ipaddr, work_date, 
					job_uid, job_add, job_date	)
		select	:is_yy, :is_hakgi, :ii_month, X.member_no, AA.pay_item_code,
					AA.SISU, 
					NVL(AA.AMT1,0),
					NVL(AA.HALF,0), 
					NVL(AA.AMT1,0) + NVL(AA.HALF,0),
					:is_pay_date, AA.holiday_opt,										
					:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate, 
					:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate
		from		padb.hpa111H X,
					(SELECT A.YEAR, A.MONTH, A.HAKGI, A.MEMBER_NO, 
							 SUM(B.PRICE_PER_TIME * C.NUM_OF_OVERTIME1) AMT1,
							 SUM(B.PRICE_PER_TIME * C.NUM_OF_OVERTIME2) AMT2,
							 SUM(B.PRICE_PER_TIME * C.NUM_OF_OVERTIME3) AMT3,
							 SUM(B.PRICE_PER_TIME * C.NUM_OF_OVERTIME4) AMT4,
							 SUM(B.PRICE_PER_TIME * C.NUM_OF_NIGENERAL * 0.50) HALF,
							 B.PAY_ITEM_CODE, 
							 SUM(NVL(C.NUM_OF_OVERTIME1,0)) SISU,
							 SUM(NVL(C.NUM_OF_NIGENERAL,0)) HALF_SISU, A.holiday_opt
						 FROM   PADB.HPA111H A, PADB.HPA102M B, PADB.HPA112T C
						WHERE  A.YEAR	=	C.YEAR
						  AND  A.HAKGI	=	C.HAKGI
						  AND  A.MONTH	=	C.MONTH
						  AND  A.MEMBER_NO = C.MEMBER_NO
						  AND  A.SEC_CODE  = B.PAY_ITEM_CODE
						  AND  A.YEAR	    =	:is_yy
						  AND  A.HAKGI	    =	:is_hakgi
						  AND  A.MONTH	    =	:ii_month
						GROUP  BY  A.YEAR, A.MONTH, A.HAKGI, A.MEMBER_NO, B.PAY_ITEM_CODE, A.holiday_opt ) AA
		where		X.year		=	:is_yy
		and		X.hakgi		=	:is_hakgi
		and		X.gwa			like	:is_dept_code 	|| '%'
		and		X.member_no	like	:is_member_no	||	'%'
		and		X.month		=	:ii_month
		AND		X.YEAR		=	AA.YEAR
		AND		X.HAKGI		=	AA.HAKGI
		AND		X.MONTH		=	AA.MONTH
		AND		X.MEMBER_NO	=	AA.MEMBER_NO
		order by X.member_no, AA.pay_item_code	;
ELSE		//계절학기일경우에는 + 3000원이다.
		insert	into	padb.hpa116t
				(	year, hakgi, month, member_no, pay_item_code,
					pay_time, 		//시수
					pay_amt, 		//지급강사료
					retro_amt, 		//초과120강사료
					month_amt, 		//합계금액
					pay_date, holiday_opt,
					worker, ipaddr, work_date, 
					job_uid, job_add, job_date	)
		select	:is_yy, :is_hakgi, :ii_month, X.member_no, AA.pay_item_code,
					AA.SISU, 
					NVL(AA.AMT1,0),
					NVL(AA.HALF,0), 
					NVL(AA.AMT1,0) + NVL(AA.HALF,0),
					:is_pay_date, AA.holiday_opt,										
					:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate, 
					:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate
		from		padb.hpa111H X,
					(SELECT A.YEAR, A.MONTH, A.HAKGI, A.MEMBER_NO, 
							 SUM((B.PRICE_PER_TIME + 3000) * C.NUM_OF_OVERTIME1) AMT1,
							 SUM((B.PRICE_PER_TIME + 3000) * C.NUM_OF_OVERTIME2) AMT2,
							 SUM((B.PRICE_PER_TIME + 3000) * C.NUM_OF_OVERTIME3) AMT3,
							 SUM((B.PRICE_PER_TIME + 3000) * C.NUM_OF_OVERTIME4) AMT4,
							 SUM((B.PRICE_PER_TIME + 3000) * C.NUM_OF_NIGENERAL * 0.50) HALF,
							 B.PAY_ITEM_CODE, SUM(NVL(C.NUM_OF_OVERTIME1,0)) SISU,
							 SUM(NVL(C.NUM_OF_NIGENERAL,0)) HALF_SISU, A.holiday_opt
						 FROM   PADB.HPA111H A, PADB.HPA102M B, PADB.HPA112T C
						WHERE  A.YEAR	=	C.YEAR
						  AND  A.HAKGI	=	C.HAKGI
						  AND  A.MONTH	=	C.MONTH
						  AND  A.MEMBER_NO = C.MEMBER_NO
						  AND  A.SEC_CODE  = B.PAY_ITEM_CODE
						  AND  A.YEAR	    =	:is_yy
						  AND  A.HAKGI	    =	:is_hakgi
						  AND  A.MONTH	    =	:ii_month
						GROUP  BY  A.YEAR, A.MONTH, A.HAKGI, A.MEMBER_NO, B.PAY_ITEM_CODE, A.holiday_opt ) AA
		where		X.year		=	:is_yy
		and		X.hakgi		=	:is_hakgi
		and		X.gwa			like	:is_dept_code 	|| '%'
		and		X.member_no	like	:is_member_no	||	'%'
		and		X.month		=	:ii_month
		AND		X.YEAR		=	AA.YEAR
		AND		X.HAKGI		=	AA.HAKGI
		AND		X.MONTH		=	AA.MONTH
		AND		X.MEMBER_NO	=	AA.MEMBER_NO
		order by X.member_no, AA.pay_item_code	;
END IF

return	sqlca.sqlcode

end function

on w_hpa506b.create
int iCurrent
call super::create
this.hpb_1=create hpb_1
this.st_status=create st_status
this.cb_1=create cb_1
this.uo_yearhakgi=create uo_yearhakgi
this.uo_month=create uo_month
this.st_31=create st_31
this.uo_gwa=create uo_gwa
this.gb_4=create gb_4
this.rb_all=create rb_all
this.rb_gwa=create rb_gwa
this.rb_member_no=create rb_member_no
this.em_pay_date=create em_pay_date
this.st_pay_date=create st_pay_date
this.uo_insa=create uo_insa
this.dw_list002=create dw_list002
this.dw_list003=create dw_list003
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.hpb_1
this.Control[iCurrent+2]=this.st_status
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.uo_yearhakgi
this.Control[iCurrent+5]=this.uo_month
this.Control[iCurrent+6]=this.st_31
this.Control[iCurrent+7]=this.uo_gwa
this.Control[iCurrent+8]=this.gb_4
this.Control[iCurrent+9]=this.rb_all
this.Control[iCurrent+10]=this.rb_gwa
this.Control[iCurrent+11]=this.rb_member_no
this.Control[iCurrent+12]=this.em_pay_date
this.Control[iCurrent+13]=this.st_pay_date
this.Control[iCurrent+14]=this.uo_insa
this.Control[iCurrent+15]=this.dw_list002
this.Control[iCurrent+16]=this.dw_list003
this.Control[iCurrent+17]=this.pb_1
end on

on w_hpa506b.destroy
call super::destroy
destroy(this.hpb_1)
destroy(this.st_status)
destroy(this.cb_1)
destroy(this.uo_yearhakgi)
destroy(this.uo_month)
destroy(this.st_31)
destroy(this.uo_gwa)
destroy(this.gb_4)
destroy(this.rb_all)
destroy(this.rb_gwa)
destroy(this.rb_member_no)
destroy(this.em_pay_date)
destroy(this.st_pay_date)
destroy(this.uo_insa)
destroy(this.dw_list002)
destroy(this.dw_list003)
destroy(this.pb_1)
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

idw_mast	=	dw_list002
idw_data	=	dw_list003

is_yy 	= uo_yearhakgi.uf_getyy()
is_hakgi	= uo_yearhakgi.uf_gethakgi()
ii_month	= integer(uo_month.uf_getmm())


IF ii_month < 8 then
	is_hakgi = '1'
	uo_yearhakgi.em_hakgi.text ='1'
else 
	is_hakgi ='2'
	uo_yearhakgi.em_hakgi.text ='2'
end if

// 지급일자 - 주자료의 월의 마지막일자를 가져온다.
wf_getdate()

wf_getchild()

rb_all.checked = true
rb_all.triggerevent('clicked')

triggerevent('ue_retrieve')

end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa506b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa506b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa506b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa506b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa506b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa506b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa506b
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa506b
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa506b
end type

type uc_save from w_tabsheet`uc_save within w_hpa506b
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa506b
end type

type uc_print from w_tabsheet`uc_print within w_hpa506b
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa506b
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa506b
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa506b
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa506b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa506b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa506b
boolean visible = false
integer y = 224
integer width = 3881
integer height = 2296
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

type uo_tab from w_tabsheet`uo_tab within w_hpa506b
boolean visible = false
integer x = 1115
integer y = 420
end type

type dw_con from w_tabsheet`dw_con within w_hpa506b
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hpa506b
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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

type hpb_1 from hprogressbar within w_hpa506b
integer x = 105
integer y = 672
integer width = 4274
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_status from statictext within w_hpa506b
integer x = 123
integer y = 592
integer width = 3781
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "진행 상태..."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_hpa506b
event keypress pbm_keydown
boolean visible = false
integer x = 1701
integer y = 328
integer width = 370
integer height = 104
integer taborder = 110
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
//
//em_year_month.getdata(ls_year)
//ls_year = trim(ls_year)
//select count(member_no)
//  into :ll_count
//  from jbtmonth_pay
// where year_month = :ls_year
//   and nvl(trim(ok_date), '') <> ''
//using sqlca;
//COMMIT USING SQLCA;
//
//// 확정일자 확인
//if ll_count > 0 then
//	gf_dis_msg(2,'해당년월은 급여지급이 완료된 상태입니다. 확인후 다시 처리해 주시기 바랍니다.','')
//	return
//end if
//
//// 생성조건 입력여부 체크
//string  ls_date, ls_member_from, ls_member_to
//string  ls_campus
//string ls_from, ls_to
//
//if not gf_chk_date(ls_year, 'YM') then
//	gf_dis_msg(2,'지급년월을 입력하시기 바랍니다.','')
//	em_year_month.setfocus()
//	return
//end if
//em_pay_date.getdata(ls_date)
//ls_date = trim(ls_date)
//if not gf_chk_date(ls_date, 'YMD') then
//	gf_dis_msg(2,'지급년월을 입력하시기 바랍니다.','')
//	em_pay_date.setfocus()
//	return
//end if
//
//ls_member_from = trim(em_member_from.text)
//ls_member_to   = trim(em_member_to.text)
////개인번호 처리
//if rb_4.checked then
//	if len(ls_member_from) < 6 then
//		gf_dis_msg(2,'개인번호를 입력하시기 바랍니다.','')
//		em_member_from.setfocus()
//	end if
//	if ls_member_to = '' then
//		em_member_to.text = ls_member_from
//		ls_member_to   = trim(em_member_to.text)
//	elseif len(ls_member_to) < 6 then
//		gf_dis_msg(2,'개인번호를 정확히 입력하시기 바랍니다.','')
//		em_member_to.setfocus()
//	end if
//else
//	//개인번호 전체 처리
//	ls_member_from = '000001'
//	ls_member_to   = '999999'
//end if
//
//// 캠퍼스별
//if rb_1.checked then
//	ls_campus = '1%'
//elseif rb_2.checked then
//	ls_campus = '2%'
//else
//	ls_campus = '%'
//end if
//
//EXECUTE IMMEDIATE "set lock mode to wait 60";
//
//st_status.text = '급여계산 준비중입니다. 잠시만 기다려주시기 바랍니다...'
//
//long ll_member
//SELECT  count(A.member_no)
//into    :ll_member
//FROM    JBTmonth_pay  A,
//        jBTpay_master B,
//		  CATjojik      C
//WHERE   A.member_no    = B.member_no
//AND     A.year_month   = B.year_month
//AND     nvl(B.campus_code,' ') || nvl(B.jojik_code, ' ') || nvl(B.organ_code, ' ') 
//         || nvl(B.class_code, ' ') || nvl(B.major_code, ' ') = C.code
//AND     A.year_month   = :ls_year
//AND     decode(C.campus_code, '0', '1', C.campus_code) like :ls_campus
//AND	  A.member_no between :ls_member_from and :ls_member_to 
//using sqlca;
//
//COMMIT USING SQLCA;
//if ll_member > 0 then
//	if gf_dis_msg(2,'이미 생성된 자료가 있습니다.~r~n' + &
//	               '다시 생성하시려면 [예]를 누르십시오.', 'QY2') = 2 then 
//		RETURN
//	else
//		DELETE FROM person.JBTmonth_pay
//		WHERE   year_month   = :ls_year
//		AND	  member_no in (SELECT  A.member_no
//									  from   jatinsa_master A,
//									 	      CATjojik   B
//									 WHERE   nvl(A.campus_code,' ') || nvl(A.jojik_code, ' ') || nvl(A.organ_code, ' ') 
//												|| nvl(A.class_code, ' ') || nvl(A.major_code, ' ') = B.code
//  										AND   decode(B.campus_code, '0', '1', B.campus_code) like :ls_campus	
//										AND	A.member_no between :ls_member_from and :ls_member_to );
//	   IF SQLCA.SQLCODE <> 0 then
//			ROLLBACK USING SQLCA;
//			gf_dis_msg(2,'전산장애가 발생되었습니다.~r~n' + &
//							'하단의 장애번호와 장애내역을~r~n' + &
//							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
//							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
//							'장애내역 : ' + SQLCA.SqlErrText,'S' )
//			RETURN
//		END IF
//	end if
//end if	
//
//integer li_check
//SELECT  count(A.member_no)
//into    :li_check
//FROM    jBTpay_master A,
//        CATjojik      B
//WHERE   A.year_month = :ls_year
//AND     decode(B.campus_code, '0', '1', B.campus_code) like :ls_campus
//AND	  A.member_no between :ls_member_from and :ls_member_to 
//AND     nvl(A.campus_code,' ') || nvl(A.jojik_code, ' ') || nvl(A.organ_code, ' ') 
//        || nvl(A.class_code, ' ') || nvl(A.major_code, ' ') = B.code
//using sqlca;
//COMMIT USING SQLCA;
//
//IF li_check  < 1  THEN
//	st_status.text = '급여마스터 자료가 존재하지 않습니다. 확인후 다시 생성하여 주시기 바랍니다!'
//	gf_dis_msg(1,'급여마스터 자료가 존재하지 않습니다. 확인후 다시 생성하여 주시기 바랍니다!',"")
//	RETURN
//END IF
//hpb_1.SetRange(1, li_check)
//hpb_1.SetStep = 1
//hpb_1.Position	= 0
//
//setpointer(HourGlass!)
//gf_dis_msg(1,'생성중입니다..','')
//
//// 연구보조비 비과세
//dw_1.retrieve(left(ls_year, 4), mid(ls_year, 5, 2))
//// 수당
//dw_2.retrieve()
////급여계산기준
//dw_3.retrieve(ls_year)
////인사 변동사항
//if right(ls_year, 2) = '04' or right(ls_year, 2) = '10' then
//	ls_from = ls_year
//	if right(ls_year, 2) = '04' then
//		ls_to = string(long(left(ls_year, 4)) - 1) + '11'
//	else
//		ls_to = left(ls_year, 4) + '05'
//	end if
//	dw_4.retrieve(ls_to, ls_from)
//elseif right(ls_year, 2) = '05' or right(ls_year, 2) = '11' then
//	ls_from = ls_year
//	if right(ls_year, 2) = '05' then
//		ls_to = left(ls_year, 4) + '03'
//	else
//		ls_to = left(ls_year, 4) + '09'
//	end if		
//	dw_4.retrieve(ls_to, ls_from)
//elseif right(ls_year, 2) = '03' or right(ls_year, 2) = '09' then
//	ls_from = ls_year
//	if right(ls_year, 2) = '03' then
//		ls_to = string(long(left(ls_year, 4)) - 1) + '10'
//	else
//		ls_to = left(ls_year, 4) + '04'
//	end if
//	dw_4.retrieve(ls_to, ls_from)
//else
//	dw_4.retrieve(ls_year, ls_year)
//end if
//// 강사료
//IF right(ls_year, 2) = '04' or left(ls_year,2) = '10' then	
//	ls_from = right(ls_year, 2)
//	ls_to   = string(long(ls_from) - 1, '00')
//	
//	dw_7.retrieve(ls_year, ls_to, ls_from, ls_campus, ls_member_from, ls_member_to )
//ELSEIF right(ls_year, 2) = '03' or right(ls_year, 2) = '09' then
//	dw_7.reset()	
//ELSE 
//	ls_from = right(ls_year, 2)
//	dw_7.retrieve( ls_year, ls_from, ls_from, ls_campus, ls_member_from, ls_member_to )
//END IF
//
//// 정근수당
//if right(ls_year, 2) = '03' or right(ls_year, 2) = '09' then
//	ls_from = left(ls_year, 4) + string(long(right(ls_year, 2)) - 1, '00')
//	ls_to = ls_from 
//
//	dw_5.retrieve(ls_to, ls_from)
//// 체력단련수당
//elseif right(ls_year, 2) = '04' or right(ls_year, 2) = '10' then
//	ls_from = left(ls_year, 4) + string(long(right(ls_year, 2)) - 1, '00')
//		
//	if right(ls_year, 2) = '04' then
//		ls_to = string(long(left(ls_year, 4)) - 1) + '11'
//	else
//		ls_to = left(ls_year, 4) + '05'
//	end if
//	
//	dw_5.retrieve(ls_to, ls_from)
//// 상여수당
//elseif right(ls_year, 2) = '05' or right(ls_year, 2) = '11' then
//	ls_from = left(ls_year, 4) + string(long(right(ls_year, 2)) - 1, '00')
//		
//	if right(ls_year, 2) = '05' then
//		ls_to = left(ls_year, 4) + '03'
//	else
//		ls_to = left(ls_year, 4) + '09'
//	end if		
//	dw_5.retrieve( ls_to, ls_from )
//else
//	dw_5.reset()	
//end if
//
//string ls_day
//
//if right(ls_year, 2) = '01' then
//	ls_day = string( long( left( ls_year, 4 )) - 1 ) + '12'
//else
//	ls_day = left( ls_year, 4 ) + string( long( right( ls_year, 2 )) - 1, '00' )
//end if
//
////급여마스터 
//string  ls_member_no, ls_year_month, ls_campus_code, ls_jikjong_code, ls_sosok
//string  ls_jikgeub_code, ls_hobong_code, ls_wife_yn, ls_jaejik_opt
//string  ls_support_20, ls_support_60, ls_handycap, ls_older, ls_woman
//string  ls_study_supp_code, ls_spouse_code, ls_family_code, ls_long_code
//string  ls_jido_code, ls_bojik_code, ls_study_code, ls_acct_no, ls_retire_date
//string  ls_duty_code, ls_gubyang_code, ls_hang_supp_code, ls_hakwonhire_date
//string  ls_upmu_supp_code, ls_overtime_code, ls_night_code, ls_union_opt, ls_rest_gubun
//long    ll_bojeon_amt, ll_imsi_amt, ll_tukgun_amt, ll_etc_sudang1, ll_etc_sudang2
//long    ll_exception_amt, ll_tot, ll_find, ll_date, ll_sudang
//long    ll_bonbong, ll_accept_month, ll_bojik_cnt
//long    ll_paywork, ll_bonwork, ll_healthwork
//long    ll_bonbong_date, ll_payday, ll_over_gangsa
//long    ll_study_supp_amt, ll_long_amt, ll_jido_amt, ll_bojik_amt
//long    ll_study_amt, ll_account_amt, ll_duty_amt, ll_gubyang_amt
//long    ll_hang_supp_amt, ll_upmu_supp_amt, ll_overtime_amt, ll_night_amt
//long    ll_family, ll_pay_sum, ll_jungkun_amt, ll_handycap
//dec{0}    ll_sang, ll_bonus, ll_health, ll_health_tot
//long		ll_bonday, ll_bonus_sum, ll_health_amt, ll_spouse
//long    ll_pension, ll_pension_lend_amt, ll_kyowon_deduc, ll_kyowon_lend_deduc
//long    ll_medical_insurance, ll_kyungjo_amt, ll_sangjo_amt, ll_etc_saving
//long    ll_union_cost, ll_pay_total, ll_num_of_abs, ll_bong
//long    ll_month, ll_mod, ll_over_bojik, ll_find2, ll_today
//long    ll_etc_gongje, ll_month_amt, ll_cnt = 0, ll_month_count = 0
//decimal ld_rate_bon, ld_deduct_tot, ld_chagam_amt, ll_study2
//long    ll_sub_limit_amt, ll_sub_limit_tot, ll_gub_amt, ll_limit
//String	ls_EntryNo			//처리자
//DateTime ldt_EntryDateTime //처리일자-시간
//
//ls_EntryNo = gs_entry_no
//ldt_EntryDateTime = Datetime(today(), now())
//
//DECLARE CUR_SOR CURSOR FOR
////급여 마스터 자료 가져오기
//SELECT   trim(A.member_no)               ,
//         trim(A.year_month)              ,
//         trim(A.campus_code)             ,
//         trim(A.jikjong_code)            ,
//         trim(A.jikgeub_code)            ,
//         trim(A.hobong_code)             ,
//			nvl(A.num_of_paywork, 0)        ,
//			nvl(A.num_of_bonwork, 0)        ,
//			nvl(A.num_of_healthwork, 0)     ,
//			nvl(A.num_of_abs, 0)            ,
//			nvl(B.bonbong, 0)               ,
//         nvl(trim(A.wife_yn), '')        ,
//         nvl(A.support_20, 0)            ,
//         nvl(A.support_60, 0)            ,
//         nvl(A.handycap, 0)              ,
//         nvl(A.older, 0)                 ,
//         nvl(trim(A.woman), '')          ,
//         nvl(trim(A.study_supp_code), ''),
//         nvl(trim(A.spouse_code), '')    ,
//         nvl(trim(A.family_code), '')    ,
//         nvl(trim(A.long_code), '')      ,
//         nvl(trim(A.jido_code), '')      ,
//         nvl(trim(A.bojik_code), '')     ,
//         nvl(A.bojik_cnt, 0)             ,
//         nvl(trim(A.study_code), '')     ,
//         nvl(trim(A.acct_no), '')   ,
//         nvl(trim(A.duty_code), '')      ,
//         nvl(A.bojeon_amt, 0)            ,
//         nvl(trim(A.gubyang_code), '')   ,
//         nvl(trim(A.hang_supp_code), '') , 
//         nvl(trim(A.upmu_supp_code), '') ,
//         nvl(trim(A.overtime_code), '')  ,
//         nvl(trim(A.night_code), '')     ,
//         nvl(A.imsi_amt, 0)              ,
//         nvl(A.tukgun_amt, 0)            ,
//         nvl(A.etc_sudang1, 0)           ,
//         nvl(A.etc_sudang2, 0)           ,
//         sum(nvl(C.pay_amt, 0))          ,
//			nvl(D.accept_month, 0)          ,
//			nvl(A.pension, 0)               ,
//			nvl(A.pension_lend_amt, 0)      ,
//			nvl(A.kyowon_deduc, 0)          ,
//		   nvl(A.kyowon_lend_deduc, 0)     ,
//			nvl(A.medical_insurance, 0)     ,
//			nvl(A.kyungjo_amt, 0)           ,
//			nvl(A.sangjo_amt, 0)            ,
//			nvl(A.etc_saving, 0)            ,
//			nvl(A.etc_gongje, 0)            ,
//			nvl(A.union_opt, '')            ,
//			nvl(D.jaejik_opt, '')           ,
//			nvl(D.hakwonhire_date, '')      ,
//			NVL(D.retire_date, '')          ,
//			trim(nvl(D.campus_code,' ') || nvl(D.jojik_code, ' ') || nvl(D.organ_code, ' ') 
//        || nvl(D.class_code, ' ') || nvl(D.major_code, ' '))
//FROM     JBTpay_master                   A,
//         outer JAThobong                 B,
//			JATinsa_master                  D,
//			outer JBTexception_pay          C,
//			catjojik                        E
//WHERE    A.jikjong_code = B.jikjong_code
//AND      A.jikgeub_code = B.jikgeub_code
//AND      A.hobong_code  = B.hobong_code
//AND      A.member_no    = D.member_no
//AND      A.member_no    = C.member_no
//AND      A.year_month   = C.year_month
//AND     nvl(A.campus_code,' ') || nvl(A.jojik_code, ' ') || nvl(A.organ_code, ' ') 
//        || nvl(A.class_code, ' ') || nvl(A.major_code, ' ') = E.code
//AND      A.year_month   = :ls_year
//AND      decode(E.campus_code, '0', '1', E.campus_code) like :ls_campus
//AND		A.member_no between :ls_member_from and :ls_member_to 
//group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 
//         20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,
//			37, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53 ;
//
//OPEN CUR_SOR;
//FETCH CUR_SOR INTO :ls_member_no, :ls_year_month, :ls_campus_code, :ls_jikjong_code, 
//                   :ls_jikgeub_code, :ls_hobong_code, :ll_paywork, :ll_bonwork, :ll_healthwork, :ll_num_of_abs,
//						 :ll_bonbong, :ls_wife_yn, :ls_support_20, :ls_support_60, :ls_handycap,
//						 :ls_older, :ls_woman, :ls_study_supp_code, :ls_spouse_code, :ls_family_code,
//						 :ls_long_code, :ls_jido_code, :ls_bojik_code, :ll_bojik_cnt ,:ls_study_code, :ls_acct_no, 
//                   :ls_duty_code, :ll_bojeon_amt, :ls_gubyang_code, :ls_hang_supp_code, 
//                   :ls_upmu_supp_code, :ls_overtime_code, :ls_night_code, :ll_imsi_amt, 
//                   :ll_tukgun_amt, :ll_etc_sudang1, :ll_etc_sudang2,
//						 :ll_exception_amt, :ll_accept_month,
//						 :ll_pension, :ll_pension_lend_amt, :ll_kyowon_deduc, :ll_kyowon_lend_deduc,
//						 :ll_medical_insurance, :ll_kyungjo_amt, :ll_sangjo_amt, :ll_etc_saving,
//						 :ll_etc_gongje, :ls_union_opt, :ls_jaejik_opt, :ls_hakwonhire_date, :ls_retire_date, :ls_sosok;
//
//DO WHILE SQLCA.SQLCODE = 0
//	//자료수 확인
//	ll_cnt++
//	st_status.text = string(ll_cnt) + ' / ' + string(li_check) + '  생성중입니다..'
//	gf_dis_msg(1,string(ll_cnt) + ' / ' + string(li_check) + ' 생성중입니다..','')
//	//예외지급수당
//	ll_tot = ll_exception_amt
//	ll_study2 = 0
//	//연구보조비
//	ll_study_supp_amt = dw_2.find("sudang_opt = '01' and sudang_code = '" + ls_study_supp_code + "'", 1, dw_2.rowcount())
//   if ll_study_supp_amt > 0 then
//   	ll_study_supp_amt = dw_2.object.sudang_amt[ll_study_supp_amt]
//		
//		if ls_jikjong_code = '21' and ls_sosok = '01' then
//			select sudang_amt
//			  into :ll_sudang
//			  from jbtsudang
//			 where trim(sudang_opt) = '01'
//				and trim(sudang_code) = '99'
//			using sqlca;
//	
//			ll_study_supp_amt = ll_study_supp_amt  + ll_sudang
//		end if
//
//		if right(ls_year, 2) = '03' or right(ls_year, 2) = '04' or right(ls_year, 2) = '09' or right(ls_year, 2) = '10' then
//			ll_study_supp_amt = ll_study_supp_amt * 1
//		else
//			ll_study_supp_amt = ll_study_supp_amt * 1.75
//		end if
//	else
//		ll_study_supp_amt = 0
//	end if
//   //가족수당
//	ll_spouse         = dw_2.find("sudang_opt = '02' and sudang_code = '" + ls_spouse_code + "'", 1, dw_2.rowcount())
//	ll_family         = dw_2.find("sudang_opt = '02' and sudang_code = '" + ls_family_code + "'", 1, dw_2.rowcount())
//	if ll_family > 0 then
//		ll_family      = dw_2.object.sudang_amt[ll_family]
//	else
//		ll_family = 0
//	end if
//	//장기근속수당
//   ll_long_amt       = dw_2.find("sudang_opt = '03' and sudang_code = '" + ls_long_code + "'", 1, dw_2.rowcount())
//   if ll_long_amt > 0 then
//		ll_long_amt    = dw_2.object.sudang_amt[ll_long_amt]
//	else
//		ll_long_amt = 0
//	end if
//	//학생지도수당
//   ll_jido_amt       = dw_2.find("sudang_opt = '04' and sudang_code = '" + ls_jido_code + "'", 1, dw_2.rowcount())
//   if ll_jido_amt > 0 then
//		ll_jido_amt    = dw_2.object.sudang_amt[ll_jido_amt]
//	else
//		ll_jido_amt    = 0
//	end if
//	//보직수당
//   ll_bojik_amt      = dw_2.find("sudang_opt = '05' and sudang_code = '" + ls_bojik_code + "'", 1, dw_2.rowcount())
//	ll_over_bojik     = dw_2.find("sudang_opt = '05' and sudang_code = '99'", 1, dw_2.rowcount())
//	if ll_over_bojik > 0 then
//		ll_over_bojik     = dw_2.object.sudang_amt[ll_over_bojik]
//		ll_bojik_cnt   = ll_bojik_cnt * ll_over_bojik		
//	else
//		ll_over_bojik = 0
//		ll_bojik_cnt = ll_bojik_cnt * ll_over_bojik		
//	end if
//
//   if ll_bojik_amt > 0 then
//		ll_bojik_amt   = dw_2.object.sudang_amt[ll_bojik_amt]
//		ll_bojik_amt   = ll_bojik_amt + ll_bojik_cnt
//	else
//		ll_bojik_amt = 0
//		ll_bojik_amt = ll_bojik_amt + ll_bojik_cnt
//	end if
//	//연구수당
//   ll_study_amt      = dw_2.find("sudang_opt = '06' and sudang_code = '" + ls_study_code + "'", 1, dw_2.rowcount())
//   if ll_study_amt > 0 then
//		ll_study_amt   = dw_2.object.sudang_amt[ll_study_amt]
//	else
//		ll_study_amt = 0
//	end if
//	//출납수당
//   ll_account_amt    = dw_2.find("sudang_opt = '07' and sudang_code = '" + ls_acct_no + "'", 1, dw_2.rowcount())
//   if ll_account_amt > 0 then
//		ll_account_amt = dw_2.object.sudang_amt[ll_account_amt]
//	else
//		ll_account_amt = 0
//	end if
//	//책임수당
//   ll_duty_amt       = dw_2.find("sudang_opt = '08' and sudang_code = '" + ls_duty_code + "'", 1, dw_2.rowcount())
//   if ll_duty_amt > 0 then
//		ll_duty_amt    = dw_2.object.sudang_amt[ll_duty_amt]
//	else
//		ll_duty_amt    = 0 
//	end if
//	//급량비
//	ll_gubyang_amt    = dw_2.find("sudang_opt = '09' and sudang_code = '" + ls_gubyang_code + "'", 1, dw_2.rowcount())
//   if ll_gubyang_amt > 0 then
//		ll_gubyang_amt = dw_2.object.sudang_amt[ll_gubyang_amt]
//	else 
//		ll_gubyang_amt = 0
//	end if
//	//행정보조비
//	ll_hang_supp_amt  = dw_2.find("sudang_opt = '10' and sudang_code = '" + ls_hang_supp_code + "'", 1, dw_2.rowcount())
//   if ll_hang_supp_amt > 0 then
//		ll_hang_supp_amt = dw_2.object.sudang_amt[ll_hang_supp_amt]
//	else
//		ll_hang_supp_amt = 0
//	end if
//	//업무보조비
//	ll_upmu_supp_amt  = dw_2.find("sudang_opt = '11' and sudang_code = '" + ls_upmu_supp_code + "'", 1, dw_2.rowcount())
//   if ll_upmu_supp_amt > 0 then
//		ll_upmu_supp_amt = dw_2.object.sudang_amt[ll_upmu_supp_amt]
//	else
//		ll_upmu_supp_amt = 0
//	end if
//	//휴일및시간외수당
//	ll_overtime_amt   = dw_2.find("sudang_opt = '12' and sudang_code = '" + ls_overtime_code + "'", 1, dw_2.rowcount())
//   if ll_overtime_amt > 0 then
//		ll_overtime_amt = dw_2.object.sudang_amt[ll_overtime_amt]
//	else
//		ll_overtime_amt = 0
//	end if
//	//야근수당
//	ll_night_amt      = dw_2.find("sudang_opt = '13' and sudang_code = '" + ls_night_code + "'", 1, dw_2.rowcount())
//   if ll_night_amt > 0 then
//		ll_night_amt   = dw_2.object.sudang_amt[ll_night_amt]
//	else
//		ll_night_amt   = 0
//	end if
//	//장애수당
//	ll_handycap = 0
//	// 비서실일반조교는 봉급, 연구보조비를 일정금액만큼 넣는다.
//	if ls_jikjong_code = '21' and ls_sosok = '01' then
//		select bonbong
//		  into :ll_bong
//		  from jathobong
//		 where jikjong_code = '21'
//		   and jikgeub_code = '2199'
//			and trim(hobong_code) = '99'
//		using sqlca;
//		
//		ll_bonbong        = ll_bonbong + ll_bong
//	end if
//	// 급여계산일수에 따른 급여계산
//  	ll_bonbong_date = dw_3.find("year_month = '" + ls_year_month + "'", 1, dw_2.rowcount())
//	if ll_bonbong_date > 0 then
//		ll_payday = dw_3.object.num_of_payday[ll_bonbong_date]
//	else
//		ll_payday = 1
//	end if
//	ll_bonbong        = (ll_paywork / ll_payday) * ll_bonbong
//	ll_study_supp_amt = (ll_paywork / ll_payday) * ll_study_supp_amt
//	ll_family         = (ll_paywork / ll_payday) * ll_family
//	ll_long_amt       = (ll_paywork / ll_payday) * ll_long_amt
//	ll_jido_amt       = (ll_paywork / ll_payday) * ll_jido_amt
//	ll_bojik_amt      = (ll_paywork / ll_payday) * ll_bojik_amt
//	ll_study_amt      = (ll_paywork / ll_payday) * ll_study_amt
//	ll_account_amt    = (ll_paywork / ll_payday) * ll_account_amt
//	ll_duty_amt       = (ll_paywork / ll_payday) * ll_duty_amt
//	ll_bojeon_amt     = (ll_paywork / ll_payday) * ll_bojeon_amt
//	ll_gubyang_amt    = (ll_paywork / ll_payday) * ll_gubyang_amt
//	ll_hang_supp_amt  = (ll_paywork / ll_payday) * ll_hang_supp_amt
//	ll_upmu_supp_amt  = (ll_paywork / ll_payday) * ll_upmu_supp_amt
//	ll_overtime_amt   = (ll_paywork / ll_payday) * ll_overtime_amt
//	ll_night_amt      = (ll_paywork / ll_payday) * ll_night_amt
//	ll_imsi_amt       = (ll_paywork / ll_payday) * ll_imsi_amt
//	ll_tukgun_amt     = (ll_paywork / ll_payday) * ll_tukgun_amt
//	ll_handycap       = (ll_paywork / ll_payday) * ll_handycap
//	ll_etc_sudang1    = (ll_paywork / ll_payday) * ll_etc_sudang1
//	ll_etc_sudang2    = (ll_paywork / ll_payday) * ll_etc_sudang2
//	
//	// 감액대상 처리 < 정직, 감봉 > 
//	ll_find = dw_4.find("member_no = '" + ls_member_no + "' and gubun = '1'", 1, dw_4.rowcount())
//	if ll_find > 0 then
//		// 정직기간중 수당 감액지급<수당액의 2/3>
//		if trim(dw_4.object.change_opt[ll_find]) = '72' then
//			ll_bonbong        = ll_bonbong        - (ll_bonbong        * (2 / 3))
//			ll_study_supp_amt = ll_study_supp_amt - (ll_study_supp_amt * (2 / 3))
//      	ll_family         = ll_family         - (ll_family         * (2 / 3))
//			ll_long_amt       = ll_long_amt       - (ll_long_amt       * (2 / 3))
//			ll_jido_amt       = ll_jido_amt       - (ll_jido_amt       * (2 / 3))
//	   	ll_bojik_amt      = ll_bojik_amt      - (ll_bojik_amt      * (2 / 3))
//   		ll_study_amt      = ll_study_amt      - (ll_study_amt      * (2 / 3))
//			ll_account_amt    = ll_account_amt    - (ll_account_amt    * (2 / 3))
//			ll_duty_amt       = ll_duty_amt       - (ll_duty_amt       * (2 / 3))
//			ll_bojeon_amt     = ll_bojeon_amt     - (ll_bojeon_amt     * (2 / 3))
//			ll_gubyang_amt    = ll_gubyang_amt    - (ll_gubyang_amt    * (2 / 3))
//			ll_hang_supp_amt  = ll_hang_supp_amt  - (ll_hang_supp_amt  * (2 / 3))
//			ll_upmu_supp_amt  = ll_upmu_supp_amt  - (ll_upmu_supp_amt  * (2 / 3))
//			ll_overtime_amt   = ll_overtime_amt   - (ll_overtime_amt   * (2 / 3))
//			ll_night_amt      = ll_night_amt      - (ll_night_amt      * (2 / 3))
//			ll_imsi_amt       = ll_imsi_amt       - (ll_imsi_amt       * (2 / 3))
//			ll_tukgun_amt     = ll_tukgun_amt     - (ll_tukgun_amt     * (2 / 3))
//			ll_handycap       = ll_handycap       - (ll_handycap       * (2 / 3))
//			ll_etc_sudang1    = ll_etc_sudang1    - (ll_etc_sudang1    * (2 / 3))
//			ll_etc_sudang2    = ll_etc_sudang2    - (ll_etc_sudang2    * (2 / 3))
//		// 감봉기간중 수당감액지급<수당액의 1/3>
//		elseif trim(dw_4.object.change_opt[ll_find]) = '73' then
//			ll_bonbong        = ll_bonbong        - (ll_bonbong        * (1 / 3))
//			ll_study_supp_amt = ll_study_supp_amt - (ll_study_supp_amt * (1 / 3))
//      	ll_family         = ll_family         - (ll_family         * (1 / 3))
//			ll_long_amt       = ll_long_amt       - (ll_long_amt       * (1 / 3))
////			ll_jido_amt       = ll_jido_amt       - (ll_jido_amt       * (1 / 3))
////	   	ll_bojik_amt      = ll_bojik_amt      - (ll_bojik_amt      * (1 / 3))
//			ll_study_amt      = ll_study_amt      - (ll_study_amt      * (1 / 3))
//			ll_account_amt    = ll_account_amt    - (ll_account_amt    * (1 / 3))
//			ll_duty_amt       = ll_duty_amt       - (ll_duty_amt       * (1 / 3))
//			ll_bojeon_amt     = ll_bojeon_amt     - (ll_bojeon_amt     * (1 / 3))
//			ll_gubyang_amt    = ll_gubyang_amt    - (ll_gubyang_amt    * (1 / 3))
//			ll_hang_supp_amt  = ll_hang_supp_amt  - (ll_hang_supp_amt  * (1 / 3))
//			ll_upmu_supp_amt  = ll_upmu_supp_amt  - (ll_upmu_supp_amt  * (1 / 3))
//			ll_overtime_amt   = ll_overtime_amt   - (ll_overtime_amt   * (1 / 3))
//			ll_night_amt      = ll_night_amt      - (ll_night_amt      * (1 / 3))
//			ll_imsi_amt       = ll_imsi_amt       - (ll_imsi_amt       * (1 / 3))
//			ll_tukgun_amt     = ll_tukgun_amt     - (ll_tukgun_amt     * (1 / 3))
//			ll_handycap       = ll_handycap       - (ll_handycap       * (1 / 3))
//			ll_etc_sudang1    = ll_etc_sudang1    - (ll_etc_sudang1    * (1 / 3))
//			ll_etc_sudang2    = ll_etc_sudang2    - (ll_etc_sudang2    * (1 / 3))
//		// 직위해제기간중 수당감액지급<수당액의 2할>
//		elseif trim(dw_4.object.change_opt[ll_find]) = '74' then
//			ll_bonbong        = ll_bonbong        - (ll_bonbong        * 0.2)
//			ll_study_supp_amt = ll_study_supp_amt - (ll_study_supp_amt * 0.2)
//      	ll_family         = ll_family         - (ll_family         * 0.2)
//			ll_long_amt       = ll_long_amt       - (ll_long_amt       * 0.2)
//			ll_jido_amt       = ll_jido_amt       - (ll_jido_amt       * 0.2)
//	   	ll_bojik_amt      = ll_bojik_amt      - (ll_bojik_amt      * 0.2)
//			ll_study_amt      = ll_study_amt      - (ll_study_amt      * 0.2)
//			ll_account_amt    = ll_account_amt    - (ll_account_amt    * 0.2)
//			ll_duty_amt       = ll_duty_amt       - (ll_duty_amt       * 0.2)
//			ll_bojeon_amt     = ll_bojeon_amt     - (ll_bojeon_amt     * 0.2)
//			ll_gubyang_amt    = ll_gubyang_amt    - (ll_gubyang_amt    * 0.2)
//			ll_hang_supp_amt  = ll_hang_supp_amt  - (ll_hang_supp_amt  * 0.2)
//			ll_upmu_supp_amt  = ll_upmu_supp_amt  - (ll_upmu_supp_amt  * 0.2)
//			ll_overtime_amt   = ll_overtime_amt   - (ll_overtime_amt   * 0.2)
//			ll_night_amt      = ll_night_amt      - (ll_night_amt      * 0.2)
//			ll_imsi_amt       = ll_imsi_amt       - (ll_imsi_amt       * 0.2)
//			ll_tukgun_amt     = ll_tukgun_amt     - (ll_tukgun_amt     * 0.2)
//			ll_handycap       = ll_handycap       - (ll_handycap       * 0.2)
//			ll_etc_sudang1    = ll_etc_sudang1    - (ll_etc_sudang1    * 0.2)
//			ll_etc_sudang2    = ll_etc_sudang2    - (ll_etc_sudang2    * 0.2)
//		end if
//	end if
//	
//	// 휴직기간 중 봉급(기본급)의 5할, 7할, 8할, 전액
//	if ls_jaejik_opt = '3' then
//		ll_find = dw_4.find("member_no = '" + ls_member_no + "' and change_opt = '71'" + &
//		                      " and gubun = '1'" , 1, dw_4.rowcount())
//			if ll_find > 0 then
//				ls_rest_gubun = dw_4.object.rest_gubun[ll_find]
//				
//				choose case ls_rest_gubun
//					case '11'
//						ll_bonbong = ll_bonbong * 0.7
//					case '12'
//						ll_bonbong = ll_bonbong * 0.8
//					case '13'
//						ll_bonbong = ll_bonbong
//					case '17'
//						ll_bonbong = ll_bonbong * 0.5
//					case else
//						ll_bonbong = 0
//				end choose
//			end if
//			ll_study_supp_amt = 0  
//			ll_family         = 0
//			ll_long_amt       = 0
//			ll_jido_amt       = 0
//			ll_bojik_amt      = 0
//			ll_study_amt      = 0
//			ll_account_amt    = 0
//			ll_duty_amt       = 0
//			ll_bojeon_amt     = 0
//			ll_gubyang_amt    = 0
//			ll_hang_supp_amt  = 0
//			ll_upmu_supp_amt  = 0
//			ll_overtime_amt   = 0
//			ll_night_amt      = 0
//			ll_imsi_amt       = 0
//			ll_tukgun_amt     = 0
//			ll_handycap       = 0
//			ll_etc_sudang1    = 0
//			ll_etc_sudang2    = 0
//	// 해외연수, 연구년은 100% (단, 학생지도수당은 지급하지 않는다)
//	elseif ls_jaejik_opt = '4' or ls_jaejik_opt = '5' then
//		ll_jido_amt = 0
//	end if
//
//		ll_bonbong        = truncate(ll_bonbong        / 10, 0) * 10
//		ll_study_supp_amt = truncate(ll_study_supp_amt / 10, 0) * 10
//     	ll_family         = truncate(ll_family         / 10, 0) * 10
//		ll_long_amt       = truncate(ll_long_amt       / 10, 0) * 10
//		ll_jido_amt       = truncate(ll_jido_amt       / 10, 0) * 10 
//	  	ll_bojik_amt      = truncate(ll_bojik_amt      / 10, 0) * 10 
//   	ll_study_amt      = truncate(ll_study_amt      / 10, 0) * 10 
//		ll_account_amt    = truncate(ll_account_amt    / 10, 0) * 10 
//		ll_duty_amt       = truncate(ll_duty_amt       / 10, 0) * 10 
//		ll_bojeon_amt     = truncate(ll_bojeon_amt     / 10, 0) * 10 
//		ll_gubyang_amt    = truncate(ll_gubyang_amt    / 10, 0) * 10 
//		ll_hang_supp_amt  = truncate(ll_hang_supp_amt  / 10, 0) * 10 
//		ll_upmu_supp_amt  = truncate(ll_upmu_supp_amt  / 10, 0) * 10 
//		ll_overtime_amt   = truncate(ll_overtime_amt   / 10, 0) * 10 
//		ll_night_amt      = truncate(ll_night_amt      / 10, 0) * 10 
//		ll_imsi_amt       = truncate(ll_imsi_amt       / 10, 0) * 10
//		ll_tukgun_amt     = truncate(ll_tukgun_amt     / 10, 0) * 10 
//		ll_handycap       = truncate(ll_handycap       / 10, 0) * 10  
//		ll_etc_sudang1    = truncate(ll_etc_sudang1    / 10, 0) * 10 
//		ll_etc_sudang2    = truncate(ll_etc_sudang2    / 10, 0) * 10 
//				
//	//상여수당
//	ll_sang = ll_bonbong + ll_family + ll_long_amt + ll_study_amt + ll_bojeon_amt + ll_overtime_amt + ll_night_amt
//	
//	IF ls_jaejik_opt = '2' THEN
//		ll_find = dw_4.find("member_no = '" + ls_member_no + "' and (change_opt = '81' or change_opt = '82')", 1, dw_4.rowcount())
//		if ll_find > 0 then
//			ll_bonus = 0
//		else
//			ll_bonus = wf_retire_bunus(ls_member_no, ls_retire_date ,ll_sang)
//		end if
//	ELSE
//		if right(ls_year, 2) = '03' or right(ls_year, 2) = '04' or right(ls_year, 2) = '09' or right(ls_year, 2) = '10' then
//			ll_bonus = 0
//		else
//			ll_find = dw_4.find("member_no = '" + ls_member_no + "'", 1, dw_4.rowcount())
//			if ll_find > 0 then
//				ll_find2 = dw_5.find("member_no = '" + ls_member_no + "'", 1, dw_5.rowcount())
//				
//				if ll_find2 > 0 then
//					ll_sang = ll_sang + dw_5.object.bouns[ll_find2]
//	//				ll_month_count = (dw_5.object.month_count[ll_find2] + 1)
//				else
//					ll_sang = ll_sang
//				end if
//				
//				if right(ls_year, 2) = '05' or right(ls_year, 2) = '11' then
//					ll_month_count = 3
//				else
//					ll_month_count = 1
//				end if
//				
//				ll_bonday = dw_3.find("year_month = '" + ls_year_month + "'", 1, dw_2.rowcount())
//				if ll_bonday > 0 then
//					ld_rate_bon = dw_3.object.rate_of_bon[ll_bonday]
//					ll_bonday   = dw_3.object.num_of_bonday[ll_bonday]
//					ll_bonus = ( ll_sang / ll_month_count ) * ld_rate_bon
//				else
//					ll_bonus = 0
//				end if
//			else
//				ll_bonday = dw_3.find("year_month = '" + ls_year_month + "'", 1, dw_2.rowcount())
//				if ll_bonday > 0 then
//					ld_rate_bon = dw_3.object.rate_of_bon[ll_bonday]
//					ll_bonday   = dw_3.object.num_of_bonday[ll_bonday]
//					ll_bonus = ll_sang * ld_rate_bon
//				else
//					ll_bonus = 0
//				end if
//			end if
//		end if
//	end if
//	if right(ls_year, 2) = '05' or right(ls_year, 2) = '11' then
//		if left(ls_hakwonhire_date, 6) = ls_year then
//			if ll_paywork < 15 then
//				ll_bonus = 0
//			end if
//		end if
//	elseif right(ls_year, 2) = '06' or right(ls_year, 2) = '07' or right(ls_year, 2) = '08' &
//		    or right(ls_year, 2) = '12' or right(ls_year, 2) = '01' or right(ls_year, 2) = '02' then
//		if ll_paywork < 15 then
//			ll_bonus = 0
//		end if
//	end if
//
//	ll_sang = ll_bonbong + ll_family + ll_long_amt + ll_study_supp_amt + &
//	          ll_study_amt + ll_bojeon_amt + ll_overtime_amt + ll_night_amt
//   //정근수당
//	if right(ls_year, 1) = '3' or right(ls_year, 1) = '9' then
//		ll_find2 = dw_5.find("member_no = '" + ls_member_no + "'", 1, dw_5.rowcount())
//		if ll_find2 > 0 then
//			ls_to = left(ls_hakwonhire_date, 6)
//			ls_from = string((long(left(ls_year, 4)) - long(left(ls_to, 4))) * 12)
//			ls_from = string(long(ls_from) + (long(MID(ls_year, 5, 2)) - long(MID(ls_to, 5, 2))))
//
//			// 휴직기간 정근기간에서 제외...
//			ll_find = dw_8.find("member_no = '" + ls_member_no + "'", 1, dw_8.rowcount())
//			if ll_find > 0 then
//				ls_from = string(long(ls_from) - long(dw_8.object.month[ll_find]))
//			end if
//				
//			ll_today = Truncate(long(ls_from) / 12, 0)
//				CHOOSE CASE ll_today
//					CASE 0
//						ll_jungkun_amt = ll_sang * 0.5
//					CASE 1
//						ll_jungkun_amt = ll_sang * 0.55
//					CASE 2
//						ll_jungkun_amt = ll_sang * 0.6
//					CASE 3
//						ll_jungkun_amt = ll_sang * 0.65
//					CASE 4
//						ll_jungkun_amt = ll_sang * 0.7
//					CASE 5
//						ll_jungkun_amt = ll_sang * 0.75
//					CASE 6
//						ll_jungkun_amt = ll_sang * 0.8
//					CASE 7
//						ll_jungkun_amt = ll_sang * 0.85
//					CASE 8
//						ll_jungkun_amt = ll_sang * 0.9
//					CASE 9
//						ll_jungkun_amt = ll_sang * 0.95
//					CASE is > 9
//						ll_jungkun_amt = ll_sang * 1
//					CASE ELSE
//						ll_jungkun_amt = 0
//				END CHOOSE
//	
//				//정근수당지급율
//				ld_rate_bon = dw_3.find("year_month = '" + ls_year_month + "'", 1, dw_2.rowcount())
//				if ld_rate_bon > 0 then
//					ll_bonday = dw_3.object.num_of_abs[ld_rate_bon]
//					ld_rate_bon = dw_3.object.rate_of_abs[ld_rate_bon]
//				end if
//				//정근수당
//				ll_jungkun_amt = ll_jungkun_amt * ld_rate_bon
//	
//				//감액대상 체크
//				ld_rate_bon = dw_4.find("member_no = '" + ls_member_no + "' and gubun = '1'", 1, dw_4.rowcount())
//				if ld_rate_bon > 0 then
//					ls_from = dw_4.object.from_date[ld_rate_bon]
//					ls_to   = dw_4.object.to_date[ld_rate_bon]
//					if right(ls_year, 1) = '3' then
//						if left(ls_from, 6) < string(long(left(ls_year, 4)) - 1, '0000') + '10' then
//							ls_from = string(long(left(ls_year, 4)) - 1, '0000') + '10' + '01'
//						end if
//						if left(ls_to, 6) > left(ls_year, 4) + '03' then
//							ls_to = left(ls_year, 4) + '03' + '31'
//						end if
//					elseif right(ls_year, 1) = '9' then
//						if left(ls_from, 6) < left(ls_year, 4) + '04' then
//							ls_from = left(ls_year, 4) + '04' + '01'
//						end if
//						if left(ls_to, 6) > left(ls_year, 4) + '09' then
//							ls_to = left(ls_year, 4) + '09' + '30'
//						end if
//					end if
//
//					// 변동사항기간 - 월
//						ll_month = wf_monthbetween(ls_from, ls_to)
//			
//					// 정직기간중 수당감액지급
//					if trim(dw_4.object.change_opt[ld_rate_bon]) = '72' then
//						ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/9) * ll_month)
//					// 감봉기간중 수당감액지급
//					elseif trim(dw_4.object.change_opt[ld_rate_bon]) = '73' then
//						ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/18) * ll_month)
//					// 직위해제기간중 수당감액지급
//					elseif trim(dw_4.object.change_opt[ld_rate_bon]) = '74' then
//						ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/30) * ll_month)
//					// 휴직기간중 수당감액지급
//					elseif trim(dw_4.object.change_opt[ld_rate_bon]) = '71' then
//						 ls_rest_gubun  = dw_4.object.rest_gubun[ld_rate_bon]
//						choose case ls_rest_gubun
//							case '11'
//								ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/20) * ll_month)
//							case '12'
//								ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/30) * ll_month)
//							case '13'
//								ll_jungkun_amt = ll_jungkun_amt
//							case '17'
//								ll_jungkun_amt = ll_jungkun_amt - ((ll_jungkun_amt * 1/12) * ll_month)
//							case else
//								ll_jungkun_amt = 0
//						end choose
//					end if
//				end if
//		else
//			ll_jungkun_amt = 0
//		end if
//	else
//		ll_jungkun_amt = 0
//	end if
//	
//	ll_find = dw_4.find("member_no = '" + ls_member_no + "' and (change_opt = '81' or change_opt = '82')", 1, dw_4.rowcount())
//	if ll_find > 0 then
//		ll_jungkun_amt = 0
//	end if
//
//   //체력단련비 - 연구보조비 175% 지급시 100%로 계산
//   	if right(ls_year, 2) = '03' or right(ls_year, 2) = '04' or right(ls_year, 2) = '09' or right(ls_year, 2) = '10' then
//			ll_study2 = ll_study_supp_amt
//		else
//			ll_study2 = truncate(ll_study_supp_amt / 1.75, 0)
//		end if
//   ll_health = ll_bonbong + ll_family + ll_long_amt + ll_study2 + &
//	            ll_study_amt + ll_bojeon_amt + ll_overtime_amt + ll_night_amt
//
//	IF ls_jaejik_opt = '2' THEN
////		ll_find = dw_4.find("member_no = '" + ls_member_no + "' and (change_opt = '81' or change_opt = '82')", 1, dw_4.rowcount())
////		if ll_find > 0 then
////			ll_health_tot = 0
////		else
//			ll_health_tot = wf_retire_health(ls_member_no, ls_retire_date ,ll_health)
////		end if
//	ELSE
//		if right(ls_year, 2) = '04' or right(ls_year, 2) = '10' then
//			ll_find = dw_4.find("member_no = '" + ls_member_no + "'", 1, dw_4.rowcount())
//			
//			if ll_find > 0 then
//				ll_find2 = dw_5.find("member_no = '" + ls_member_no + "'", 1, dw_5.rowcount())
//				if ll_find2 > 0 then
//					ll_health = ll_health + dw_5.object.health[ll_find2]
//	//				ll_month_count = (dw_5.object.month_count[ll_find2] + 1)
//				else
//					ll_health = ll_health
//				end if
//				
//				ll_month_count = 6
//	
//				ll_health_amt = dw_3.find("year_month = '" + ls_year + "'", 1, dw_2.rowcount())
//				if ll_health_amt > 0 then
//					ld_rate_bon = dw_3.object.rate_of_health[ll_health_amt]
//					ll_health_amt = dw_3.object.num_of_healthday[ll_health_amt]
//					ll_health_tot =  ( ll_health / ll_month_count ) * ld_rate_bon
//				else
//					ll_health_tot = 0
//				end if
//			else
//				ll_health_amt = dw_3.find("year_month = '" + ls_year + "'", 1, dw_2.rowcount())
//				if ll_health_amt > 0 then
//					ld_rate_bon = dw_3.object.rate_of_health[ll_health_amt]
//					ll_health_amt = dw_3.object.num_of_healthday[ll_health_amt]
//					ll_health_tot =   ll_health * ld_rate_bon
//				else
//					ll_health_tot = 0
//				end if
//			end if
//		else
//			ll_health_tot = 0
//		end if
//	END IF
//   // 무급 휴직은 상여도 지급되지 않는다.
//	if ls_jaejik_opt = '3' then
//		ll_find = dw_4.find("member_no = '" + ls_member_no + "' and change_opt = '71'" + &
//		                      " and gubun = '1'" , 1, dw_4.rowcount())
//			if ll_find > 0 then
//				ls_rest_gubun = dw_4.object.rest_gubun[ll_find]
//				
//				choose case ls_rest_gubun
//					case '11', '12', '13', '17'
//						ll_bonus = ll_bonus 						
//						ll_health_tot = ll_health_tot
//					case else
//						ll_bonus = 0
//						ll_health_tot = 0
//				end choose
//			end if
//	end if
//	// 사환, 촉탁, 고용직, 기타 기본금만 지급..
//	if ls_jikjong_code = '44' or ls_jikjong_code = '45' or ls_jikjong_code = '51' or ls_jikjong_code = '52' then
//		ll_study_supp_amt = 0
//		ll_family         = 0
//		ll_long_amt       = 0
//		ll_jido_amt       = 0
//		ll_bojik_amt      = 0
//		ll_study_amt      = 0
//		ll_account_amt    = 0
//		ll_duty_amt       = 0
//		ll_bojeon_amt     = 0
//		ll_gubyang_amt    = 0
//		ll_hang_supp_amt  = 0
//		ll_upmu_supp_amt  = 0
//		ll_overtime_amt   = 0
//		ll_night_amt      = 0
//		ll_imsi_amt       = 0
//		ll_tukgun_amt     = 0
//		ll_handycap       = 0
//		ll_etc_sudang1    = 0
//		ll_etc_sudang2    = 0
//		ll_bonus          = 0
//		ll_jungkun_amt    = 0
//		ll_health_tot     = 0
//	end if
//
//   //초과강의료
//	ll_over_gangsa = 0
//	ll_find = dw_7.find("member_no = '" + ls_member_no + "'", 1, dw_7.rowcount())
//	if ll_find > 0 then
//		ll_over_gangsa = dw_7.object.pay_tot[ll_find]
//	else
//		ll_over_gangsa = 0
//	end if
//	
//	ll_union_cost = 0
//	ll_month_amt = 0
//
//	//급여합계
//	ll_pay_sum = ll_bonbong + ll_study_supp_amt + ll_family + ll_long_amt + ll_jido_amt + &
//	             ll_bojik_amt + ll_study_amt + ll_account_amt + ll_duty_amt + ll_bojeon_amt + &
//					 ll_gubyang_amt + ll_hang_supp_amt + ll_upmu_supp_amt + ll_overtime_amt + ll_night_amt + & 
//					 ll_imsi_amt + ll_tukgun_amt + ll_handycap + ll_etc_sudang1 + ll_etc_sudang2
//	ll_bonus = Truncate(ll_bonus / 10, 0) * 10
//	ll_jungkun_amt = Truncate(ll_jungkun_amt / 10, 0) * 10
//	ll_health_tot = Truncate(ll_health_tot / 10, 0) * 10
//	//상여합계
//	ll_bonus_sum = ll_bonus + ll_jungkun_amt + ll_health_tot 
//	ll_pay_sum = Truncate(ll_pay_sum / 10, 0) * 10
//	//급여총계
//	ll_pay_total = ll_pay_sum + ll_bonus_sum  // + ll_tot
//	// 공제액계, 차인지급액
//		ld_deduct_tot = ll_pension + ll_pension_lend_amt + ll_kyowon_deduc + ll_kyowon_lend_deduc + &
//		                ll_medical_insurance + ll_union_cost + ll_kyungjo_amt + ll_sangjo_amt + &
//							 ll_month_amt + ll_etc_saving + ll_etc_gongje
//		ld_chagam_amt = ll_pay_total - ld_deduct_tot
//
//	// 연구보조비비과세금액, 연구보조비누계
//	if ll_gubyang_amt > 50000 then
//		ll_gub_amt = 50000
//	else
//		ll_gub_amt = ll_gubyang_amt
//	end if
//	
//	ll_limit = (ll_tot + ll_over_gangsa + ll_pay_total) - (ll_gub_amt)
//
//	ll_find = dw_1.find("member_no = '" + ls_member_no + "'", 1, dw_1.rowcount())
//	if ll_find > 0 then
//			ll_sub_limit_tot = dw_1.object.pay_sum[ll_find]
//			ll_sub_limit_tot = ll_sub_limit_tot + ll_limit
//			ll_sub_limit_tot = ll_sub_limit_tot * 0.2
//			ll_sub_limit_amt = dw_1.object.sub_limit_amt[ll_find]
//			ll_sub_limit_amt = ll_sub_limit_amt + ll_study_supp_amt
//			
//			if ll_sub_limit_tot >= ll_sub_limit_amt then
//				ll_sub_limit_amt = ll_study_supp_amt
//				ll_sub_limit_tot = long(dw_1.object.sub_limit_amt[ll_find]) + ll_sub_limit_amt
//			else
//				ll_sub_limit_amt = ll_sub_limit_tot - long(dw_1.object.sub_limit_amt[ll_find])
//				if ll_sub_limit_amt > ll_study_supp_amt then
//					ll_sub_limit_amt = ll_study_supp_amt
//					ll_sub_limit_tot = long(dw_1.object.sub_limit_amt[ll_find]) + ll_sub_limit_amt
//				else
//					ll_sub_limit_tot = long(dw_1.object.sub_limit_amt[ll_find]) + ll_sub_limit_amt
//				end if
//			end if		
//		else
//			ll_sub_limit_tot = ll_limit * 0.2
//			if ll_sub_limit_tot >= ll_study_supp_amt then
//				ll_sub_limit_amt = ll_study_supp_amt
//				ll_sub_limit_tot = ll_study_supp_amt
//			else
//				ll_sub_limit_amt = ll_sub_limit_tot
//				ll_sub_limit_tot = ll_sub_limit_amt
//			end if
//	end if
//	
//		INSERT INTO person.JBTmonth_pay
//		                   ( member_no, year_month, pay_date,	salary, study_supp_amt,
//								   family_amt,	long_amt, jido_amt, bojik_amt, study_amt,
//									account_amt, duty_amt, bojeon_amt, gubyang_amt,	hang_supp_amt,
//									upmu_supp_amt,	overtime_amt, night_amt, imsi_amt, tukgun_amt,
//									handicap_amt, etc_amt1,	etc_amt2, pay_sum, bonus_amt,	jungkun_amt,
//									health_amt,	bonus_sum, exception_pay_sum,	over_time_amt,
//									pay_total, sub_limit_amt, sub_limit_tot, standard_income,
//									product_tax, income_tax_deduct, income_tax, farm_tax,	resident_tax,
//									pension,	pension_lend_amt,	kyowon_deduct,	kyowon_lend_amt,
//									medical_insurance, union_cost, kyungjo_amt, sangjo_amt, meet_amt,
//									etc_saving,	etc_gongje, add_gongje1, add_gongje2, add_gongje3,
//									add_gongje4, add_gongje5, add_gongje6,	add_gongje7, add_gongje8,
//									add_gongje9, add_gongje10,	deduct_tot, chagam_amt,	pay_opt,	entry_no,
//									entry_date ) 
//					values   (  :ls_member_no,	:ls_year, :ls_date, :ll_bonbong,	:ll_study_supp_amt,
//									:ll_family,	:ll_long_amt, :ll_jido_amt, :ll_bojik_amt, :ll_study_amt,
//									:ll_account_amt, :ll_duty_amt, :ll_bojeon_amt, :ll_gubyang_amt,
//									:ll_hang_supp_amt, :ll_upmu_supp_amt, :ll_overtime_amt, :ll_night_amt,
//									:ll_imsi_amt, :ll_tukgun_amt, :ll_handycap, :ll_etc_sudang1,
//									:ll_etc_sudang2, :ll_pay_sum,	:ll_bonus, :ll_jungkun_amt, :ll_health_tot,
//									:ll_bonus_sum,	:ll_tot,	:ll_over_gangsa, :ll_pay_total, :ll_sub_limit_amt,
//									:ll_sub_limit_tot, 0, 0, 0, 0, 0, 0, :ll_pension, :ll_pension_lend_amt,
//									:ll_kyowon_deduc, :ll_kyowon_lend_deduc, :ll_medical_insurance, 
//									:ll_union_cost, :ll_kyungjo_amt,	:ll_sangjo_amt, :ll_month_amt,
//									:ll_etc_saving, :ll_etc_gongje, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
//									:ld_deduct_tot, :ld_chagam_amt, 'Y', :ls_EntryNo, :ldt_EntryDateTime );
//
//							IF SQLCA.SQLCODE <> 0 THEN
//								ROLLBACK USING SQLCA;
//								st_status.text = '개인번호 : ' + ls_member_no + ' 자료 생성실패입니다!'
//								gf_dis_msg(1,'자료 생성실패입니다.!',"")
//								RETURN
//							END IF
//FETCH CUR_SOR INTO :ls_member_no, :ls_year_month, :ls_campus_code, :ls_jikjong_code, 
//                   :ls_jikgeub_code, :ls_hobong_code, :ll_paywork, :ll_bonwork, :ll_healthwork, :ll_num_of_abs,
//						 :ll_bonbong, :ls_wife_yn, :ls_support_20, :ls_support_60, :ls_handycap,
//						 :ls_older, :ls_woman, :ls_study_supp_code, :ls_spouse_code, :ls_family_code,
//						 :ls_long_code, :ls_jido_code, :ls_bojik_code, :ll_bojik_cnt ,:ls_study_code, :ls_acct_no, 
//                   :ls_duty_code, :ll_bojeon_amt, :ls_gubyang_code, :ls_hang_supp_code, 
//                   :ls_upmu_supp_code, :ls_overtime_code, :ls_night_code, :ll_imsi_amt, 
//                   :ll_tukgun_amt, :ll_etc_sudang1, :ll_etc_sudang2,
//						 :ll_exception_amt, :ll_accept_month,
//						 :ll_pension, :ll_pension_lend_amt, :ll_kyowon_deduc, :ll_kyowon_lend_deduc,
//						 :ll_medical_insurance, :ll_kyungjo_amt, :ll_sangjo_amt, :ll_etc_saving,
//						 :ll_etc_gongje, :ls_union_opt, :ls_jaejik_opt, :ls_hakwonhire_date, :ls_retire_date, :ls_sosok;
//	hpb_1.Position	= hpb_1.position + 1
//LOOP
//CLOSE CUR_SOR;
//
////자료 없음..
//if ll_cnt < 1 then
//	st_status.text = '생성될 자료가 없습니다..'
//	gf_dis_msg(1,'생성될 자료가 없습니다.','')
//	return
//end if
//
//COMMIT USING SQLCA;
//SetPointer(Arrow!)
//st_status.text = string(ll_cnt) + ' 건 자료가 생성되었습니다..'
//gf_dis_msg(1, string(ll_cnt) + '건 자료가 생성되었습니다.','')
end event

type uo_yearhakgi from cuo_yyhakgi within w_hpa506b
event destroy ( )
integer x = 64
integer y = 176
integer width = 1047
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

on uo_yearhakgi.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yy 	= uf_getyy()
is_hakgi	= uf_gethakgi()

// 지급일자 - 주자료의 월의 마지막일자를 가져온다.
wf_getdate()

//parent.triggerevent('ue_retrieve')

end event

event constructor;call super::constructor;is_hakgi	= uf_gethakgi()
if is_hakgi = ' ' then
	is_hakgi = '1'
end if
end event

type uo_month from cuo_month within w_hpa506b
event destroy ( )
integer x = 1047
integer y = 176
integer taborder = 60
boolean bringtotop = true
boolean border = false
end type

on uo_month.destroy
call cuo_month::destroy
end on

event ue_itemchange;call super::ue_itemchange;ii_month	= integer(uf_getmm())

// 지급일자 - 주자료의 월의 마지막일자를 가져온다.
wf_getdate()

parent.triggerevent('ue_retrieve')
end event

type st_31 from statictext within w_hpa506b
boolean visible = false
integer x = 1733
integer y = 112
integer width = 1097
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "※ 생성년도, 학기, 월을 입력해 주세요."
boolean focusrectangle = false
end type

type uo_gwa from cuo_hakgwa within w_hpa506b
event destroy ( )
integer x = 2226
integer y = 172
integer width = 1056
integer taborder = 30
boolean bringtotop = true
long backcolor = 31112622
end type

on uo_gwa.destroy
call cuo_hakgwa::destroy
end on

type gb_4 from groupbox within w_hpa506b
integer x = 59
integer y = 508
integer width = 4379
integer height = 288
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "진행상태"
end type

type rb_all from radiobutton within w_hpa506b
integer x = 3186
integer y = 356
integer width = 242
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "전체"
boolean checked = true
end type

event clicked;uo_gwa.uf_enable(false)
uo_insa.trigger event ue_enbled(false)
end event

type rb_gwa from radiobutton within w_hpa506b
integer x = 3433
integer y = 356
integer width = 242
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "학과"
end type

event clicked;uo_gwa.uf_enable(true)
uo_gwa.dw_daehak.setfocus()
uo_insa.trigger event ue_enbled(false)

end event

type rb_member_no from radiobutton within w_hpa506b
integer x = 3680
integer y = 356
integer width = 306
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "개인별"
end type

event clicked;uo_gwa.uf_enable(false)
uo_insa.trigger event ue_enbled(true)
uo_insa.sle_kname.setfocus()
end event

type em_pay_date from editmask within w_hpa506b
integer x = 1742
integer y = 180
integer width = 480
integer height = 84
integer taborder = 50
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
	f_messagebox('1', st_pay_date.text + '를 정확히 입력해 주시기 바랍니다.!')
	this.text = ls_bef_date
	is_pay_date = ''
end if

is_pay_date	=	string(ldt_pay_date, 'yyyymmdd')

end event

type st_pay_date from statictext within w_hpa506b
integer x = 1458
integer y = 196
integer width = 274
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "지급일자"
boolean focusrectangle = false
end type

type uo_insa from cuo_insa_member_gangsa within w_hpa506b
integer x = 50
integer y = 316
integer width = 4379
integer height = 192
integer taborder = 120
end type

on uo_insa.destroy
call cuo_insa_member_gangsa::destroy
end on

type dw_list002 from uo_dwgrid within w_hpa506b
integer x = 50
integer y = 804
integer width = 4379
integer height = 776
integer taborder = 20
boolean titlebar = true
string title = "강사 기초 사항"
string dataobject = "d_hpa506b_1"
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)
//
f_dw_find(idw_data, this, 'member_no')

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_data, 'member_no')

end event

type dw_list003 from uo_dwgrid within w_hpa506b
integer x = 50
integer y = 1592
integer width = 4379
integer height = 692
integer taborder = 30
boolean titlebar = true
string title = "강사료 지급 내역"
string dataobject = "d_hpa506b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

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

type pb_1 from uo_imgbtn within w_hpa506b
integer x = 46
integer y = 40
integer taborder = 30
boolean bringtotop = true
string btnname = "생성처리"
end type

event clicked;call super::clicked;integer	li_rtn

// 월급여지급을 생성한다.
li_rtn	=	wf_create_1()

if li_rtn < 0 then
	rollback	;
	st_status.text = '진행 상태...'
	return
elseif li_rtn = 0 then
	idw_data.retrieve(is_yy, is_hakgi, ii_month, is_dept_code, is_member_no)
	st_status.text = string(idw_data.rowcount()) + '건의 자료가 생성되었습니다.!'
	f_messagebox('1', st_status.text)
	commit	;
end if



end event

on pb_1.destroy
call uo_imgbtn::destroy
end on

