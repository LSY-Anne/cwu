$PBExportHeader$w_hfn307b.srw
$PBExportComments$전표 확정/취소
forward
global type w_hfn307b from w_msheet
end type
type dw_con from uo_dwfree within w_hfn307b
end type
type dw_update from uo_dwgrid within w_hfn307b
end type
type dw_detail from uo_dwgrid within w_hfn307b
end type
type pb_select from uo_imgbtn within w_hfn307b
end type
type pb_noselect from uo_imgbtn within w_hfn307b
end type
end forward

global type w_hfn307b from w_msheet
string title = "전표확정/취소"
dw_con dw_con
dw_update dw_update
dw_detail dw_detail
pb_select pb_select
pb_noselect pb_noselect
end type
global w_hfn307b w_hfn307b

type variables
datawindowchild	idw_child

Integer	ii_retrieve_step				// 조회상태(1:전표접수(4), 2:전표확정(5))
integer	ii_step_opt						// 저장상태(1:전표확정(5), 2:전표접수(4))
string	is_stat_title
end variables

forward prototypes
public subroutine wf_retrieve ()
public function integer wf_data_proc (integer ai_acct_class, string as_slip_date, integer ai_slip_no, string as_acct_date, integer ai_stat_gbn)
public function integer wf_save ()
public function integer wf_hfn203_proc (integer ai_acct_class, string as_slip_date, integer ai_slip_no, string as_slip_class, integer ai_stat_gbn)
public subroutine wf_button_control ()
public function integer wf_hfn203m_h_proc (integer ai_log_opt, integer ai_acct_class, string as_acct_code, integer ai_mana_code, string as_mana_data, string as_stat_gubun, string as_slip_date, integer ai_slip_no, integer ai_slip_seq, decimal adec_bal_amt, decimal adec_sang_amt, string as_remark, string as_new_slip_date, integer ai_new_slip_no, integer ai_new_slip_seq)
end prototypes

public subroutine wf_retrieve ();// ------------------------------------------------------------------------------------------
// Function Name	:	wf_retrieve(List Datawindow Retrieve)
// Function 설명	:	조회를 한다.
// Argument			:	
//	Return			:	sqlca.sqlcode
// ------------------------------------------------------------------------------------------

long		ll_rowcount
integer	li_step_opt
Integer	li_slip_class
String	ls_str_date, ls_end_date
dw_con.accepttext()
li_slip_class = Integer(dw_con.object.slip_class[1])
ls_str_date = String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_end_date = String(dw_con.object.to_date[1], 'yyyymmdd')

dw_update.retrieve(gi_acct_class, li_slip_class, ls_str_date, ls_end_date, ii_step_opt)

end subroutine

public function integer wf_data_proc (integer ai_acct_class, string as_slip_date, integer ai_slip_no, string as_acct_date, integer ai_stat_gbn);// ==========================================================================================
// 기    능	:	각종기초정보 관리에 Update
// 작 성 인 : 	이현수
// 작성일자 : 	2003.01
// 함수원형 : 	wf_data_proc(integer ai_acct_class, string as_slip_date, integer ai_slip_no) return integer
// 인    수 :  ai_acct_class(회계단위)
//             as_slip_date(전표일자)
//             ai_slip_no(전표번호)
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_acct_code, ls_drcr_class, ls_com_drcr_class, ls_mana_data
string	ls_close_yn
dec{0}	ldec_slip_amt
long		ll_cnt
datetime	ldt_sysdate

ldt_sysdate = f_sysdate()

dw_detail.reset()
dw_detail.retrieve(ai_acct_class, as_slip_date, ai_slip_no)

for ll_cnt = 1 to dw_detail.rowcount()
	ls_acct_code = dw_detail.getitemstring(ll_cnt, 'acct_code')
	ls_drcr_class = dw_detail.getitemstring(ll_cnt, 'drcr_class')
	ls_com_drcr_class = dw_detail.getitemstring(ll_cnt, 'com_drcr_class')
	ls_mana_data = dw_detail.getitemstring(ll_cnt, 'mana_data1')
	
	choose case ls_acct_code
		// 당좌예금(111209), 받을어음(112601), 지급어음(214301)
		// 수표어음관리(hfn004m)에 update
		case '111209', '112601', '214301'
			if ls_drcr_class <> ls_com_drcr_class then
				if ai_stat_gbn = 1 then
					ls_close_yn = 'Y'
				else
					ls_close_yn = 'N'
				end if

				update	fndb.hfn004m
				set		close_yn = :ls_close_yn,
							acct_date = :as_acct_date
				where		notes_no = :ls_mana_data	;
				
				if sqlca.sqlcode <> 0 then return -1
			end if
		// 유가증권(122101, 122102, 122103, 122104)
		// 유가증권관리(hfn006m)에 update
		case '122101', '122102', '122103', '122104'
			if ls_drcr_class <> ls_com_drcr_class then
				if ai_stat_gbn = 1 then
					ls_close_yn = 'N'
					ldec_slip_amt = dw_detail.getitemnumber(ll_cnt, 'slip_amt')
				else
					ls_close_yn = 'Y'
					ldec_slip_amt = 0
				end if

				update	fndb.hfn006m
				set		stat_class = :ls_close_yn,
							disp_date = :as_acct_date,
							disp_amt = :ldec_slip_amt
				where		sec_no = :ls_mana_data	;
				
				if sqlca.sqlcode <> 0 then return -1
			end if
		// 단기차입금(211101), 장기차입금(221101, 221109)
		// 차입금관리(hfn005m)에 update
		case '211101', '221101', '221109'
			if ls_drcr_class <> ls_com_drcr_class then
				if ai_stat_gbn = 1 then
					ldec_slip_amt = dw_detail.getitemnumber(ll_cnt, 'slip_amt')
				else
					ldec_slip_amt = dw_detail.getitemnumber(ll_cnt, 'slip_amt') * -1
				end if

				update	fndb.hfn005m
				set		loan_rtn_amt = nvl(loan_rtn_amt,0) + :ldec_slip_amt,
							close_date = :as_acct_date
				where		loan_no = :ls_mana_data	;
				
				if sqlca.sqlcode <> 0 then return -1
				
				// 사용유무 Update
				update	fndb.hfn005m
				set		use_yn = decode(nvl(loan_amt,0),nvl(loan_rtn_amt,0),'Y','N')
				where		loan_no = :ls_mana_data	;
				
				if sqlca.sqlcode <> 0 then return -1
			end if
	end choose
next

return 0
end function

public function integer wf_save ();long		ll_row
long		ll_cnt, ll_find, ll_end
string	ls_message
string	ls_slip_date, ls_slip_class, ls_acct_date, ls_resol_date
integer	li_slip_no, li_acct_no, li_resol_no

String	ls_bdgt_year, ls_slip_date_con
Integer	li_stat_gbn

dw_con.accepttext()
ls_slip_date_con = String(dw_con.object.slip_date[1], 'yyyymmdd')
ls_bdgt_year = f_getbdgtyear(ls_slip_date_con)
li_stat_gbn = Integer(dw_con.object.stat_gbn[1])

// 일마감처리 여부 체크
select	count(*)
into		:ll_row
from		fndb.hfn010m
where		acct_class	=	:gi_acct_class
and		bdgt_year	=	:ls_bdgt_year
and		close_date	=	:ls_slip_date_con
and		close_yn		=	'Y'	;

if ll_row	> 0	then
	ls_message	=	'일 마감이 이미 처리되었습니다. ' + is_stat_title + '처리를 하신 후 일마감처리를 다시 하시기 바랍니다.'	+	&
						is_stat_title + '처리를 하시겠습니까?'
else
	ls_message	=	is_stat_title + '처리를 하시겠습니까?'
end if

if f_messagebox('2', ls_message) = 2	then	return	999

ll_cnt = 0

ll_end  = dw_update.rowcount()
ll_find = dw_update.find("stat_gbn = 9", 1, ll_end)

do while	ll_find > 0
	
	ls_resol_date = dw_update.getitemstring(ll_find, 'resol_date')
	li_resol_no   = dw_update.getitemnumber(ll_find, 'resol_no')
	ls_slip_date  = dw_update.getitemstring(ll_find, 'slip_date')
	li_slip_no    = dw_update.getitemnumber(ll_find, 'slip_no')
	ls_slip_class = string(dw_update.getitemnumber(ll_find, 'slip_class'))
	ls_acct_date  = dw_update.getitemstring(ll_find, 'acct_date')


	///////////////////////////////////////////////////////////////////////////////
	//이미확정/취소된 전표인지 검사 : 이중확정/취소 발생 방지 (2005.03.17 : Jung Kwang Hoon)
	string 	ls_acct_date_no
	integer	li_step_opt
	
	SELECT 	STEP_OPT,   	ACCT_DATE||ACCT_NO  
   INTO 		:li_step_opt,	:ls_acct_date_no
	FROM 		FNDB.HFN201M
   WHERE 	ACCT_CLASS 	= 	:gi_acct_class 
	AND  		SLIP_DATE 	=  :ls_slip_date
	AND  		SLIP_NO 		=  :li_slip_no	;

	if li_stat_gbn = 1 then		//확정시
		if li_step_opt = 5 or len(ls_acct_date_no) > 8 then
			messagebox('확인', '이미 확정한 전표입니다.('+ls_slip_date+'-'+string(li_slip_no)+')~r~r' + &
									 '다음 전표를 처리합니다.')

			ll_find ++
			if ll_find > ll_end then exit
			ll_find = dw_update.find("stat_gbn = 9", ll_find, ll_end)

			continue
		end if
	else								//취소시
		if li_step_opt = 4 or ls_acct_date_no = '0' then
			messagebox('확인', '이미 취소한 전표입니다.('+ls_slip_date+'-'+string(li_slip_no)+')~r~r' + &
									 '다음 전표를 처리합니다.')

			ll_find ++
			if ll_find > ll_end then exit
			ll_find = dw_update.find("stat_gbn = 9", ll_find, ll_end)

			continue
		end if
	end if
	///////////////////////////////////////////////////////////////////////////////


	// 각종 기초정보관리 Update
	if wf_data_proc(gi_acct_class, ls_slip_date, li_slip_no, ls_acct_date, li_stat_gbn) <> 0 then return -1
	
	// 미결전표관리 및 배정예산 Update
	if wf_hfn203_proc(gi_acct_class, ls_slip_date, li_slip_no, ls_slip_class, li_stat_gbn) <> 0 then return -1
	
	if li_stat_gbn = 1 then
		// 전표에 확정일자 및 번호 Update
		if ll_cnt = 0 then
			// 확정번호 채번
			select	nvl(max(acct_no),0) + 1	into	:li_acct_no
			from		fndb.hfn201m
			where		acct_class = :gi_acct_class
			and		acct_date  = :ls_slip_date_con	;
		end if
	
		dw_update.setitem(ll_find, 'acct_no', li_acct_no)
	
		update	fndb.hfn201m
		set		acct_date = :ls_slip_date_con,
					acct_no   = :li_acct_no,
					step_opt  = 5
		where		acct_class = :gi_acct_class
		and		slip_date  = :ls_slip_date
		and		slip_no    = :li_slip_no	;
	
		if sqlca.sqlcode <> 0 then return -1
		
		update	fndb.hfn101m
		set		step_opt  = 5
		where		acct_class = :gi_acct_class
		and		resol_date = :ls_resol_date
		and		resol_no   = :li_resol_no	;
	
		if sqlca.sqlcode <> 0 then return -1

		li_acct_no ++
	else
		// 전표에 확정일자 및 번호 Update
		update	fndb.hfn201m
		set		acct_date = '',
					acct_no   = 0,
					step_opt  = 4
		where		acct_class = :gi_acct_class
		and		slip_date  = :ls_slip_date
		and		slip_no    = :li_slip_no	;
	
		if sqlca.sqlcode <> 0 then return -1

		update	fndb.hfn101m
		set		step_opt  = 4
		where		acct_class = :gi_acct_class
		and		resol_date = :ls_resol_date
		and		resol_no   = :li_resol_no	;
	
		if sqlca.sqlcode <> 0 then return -1
	end if

	ll_cnt ++

	ll_find ++
	if ll_find > ll_end then exit
	ll_find = dw_update.find("stat_gbn = 9", ll_find, ll_end)
loop

return ll_cnt

end function

public function integer wf_hfn203_proc (integer ai_acct_class, string as_slip_date, integer ai_slip_no, string as_slip_class, integer ai_stat_gbn);// ==========================================================================================
// 기    능	:	미결전표 관리에 Update
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_hfn203_proc(integer ai_acct_class, string as_slip_date, integer ai_slip_no, inteher ai_stat_gbn) return integer
// 인    수 :  ai_acct_class(회계단위)
//             as_slip_date(전표일자)
//             ai_slip_no(전표번호)
//             ai_stat_gbn(처리구분)
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_acct_code, ls_drcr_class, ls_acct_drcr_class
string	ls_mana_data, ls_remark, ls_mi_acct_yn, ls_gwa, ls_slip_date
integer	li_mana_code, li_slip_no, li_slip_seq, li_sang_seq
long		ll_cnt, ll_find
dec{0}	ldec_slip_amt, ldec_bal_amt
datetime	ldt_sysdate

String	ls_slip_date_con, ls_bdgt_year

dw_con.accepttext()
ls_slip_date_con = String(dw_con.object.slip_date[1], 'yyyymmdd')
ls_bdgt_year = f_getbdgtyear(ls_slip_date_con)


// 배정예산관리 집행금액, 가집행금액 update오류로 막음 (20041005:Jung Kwang Hoon)
////2003-12-01
//declare  proc_jiphaeng procedure for acdb.usp_jiphaeng_batch(:ls_bdgt_year,:ls_gwa,:ls_Acct_Code,:gi_acct_class,:as_slip_class) ;

ldt_sysdate = f_sysdate()

dw_detail.reset()
dw_detail.retrieve(ai_acct_class, as_slip_date, ai_slip_no)

for ll_cnt = 1 to dw_detail.rowcount()
	ls_acct_code       = dw_detail.getitemstring(ll_cnt, 'acct_code')
	li_mana_code       = dw_detail.getitemnumber(ll_cnt, 'mana_code1')
	ls_mana_data       = dw_detail.getitemstring(ll_cnt, 'mana_data1')
	ldec_slip_amt      = dw_detail.getitemnumber(ll_cnt, 'slip_amt')
	ls_slip_date       = dw_detail.getitemstring(ll_cnt, 'slip_date')
	li_slip_no         = dw_detail.getitemnumber(ll_cnt, 'slip_no')
	li_slip_seq        = dw_detail.getitemnumber(ll_cnt, 'slip_seq')
	ls_remark          = dw_detail.getitemstring(ll_cnt, 'remark')
	ls_drcr_class      = dw_detail.getitemstring(ll_cnt, 'drcr_class')
	ls_acct_drcr_class = dw_detail.getitemstring(ll_cnt, 'com_drcr_class')
	ls_mi_acct_yn      = dw_detail.getitemstring(ll_cnt, 'mi_acct_yn')
	ls_gwa             = dw_detail.getitemstring(ll_cnt, 'used_gwa')
	
	if isnull(ls_mana_data) or trim(ls_mana_data) = '' then ls_mana_data = ' '
	
	if ai_stat_gbn = 1 then		// 전표확정
		// 미결전표관리에 Update
		// 계정이 미결관리이면서 계정의 차대구분과 동일하면 발생
		// 다르면 상계처리
		if ls_mi_acct_yn = 'Y' then
			if ls_drcr_class = ls_acct_drcr_class then	// 발생
				// 존재하는 발생자료 확인
				select	count(acct_class)
				into		:ll_find
				from		fndb.hfn203m
				where		acct_class = :gi_acct_class
				and		acct_code = :ls_acct_code
				and		mana_code = :li_mana_code
				and		mana_data = :ls_mana_data	;
				
				if ll_find > 0 then
					//미결전표 로그 생성...
					wf_hfn203m_h_proc(2, gi_acct_class, ls_acct_code, li_mana_code, ls_mana_data, &
											'', '', 0, 0, ldec_slip_amt, 0, '', ls_slip_date, li_slip_no, li_slip_seq)

					update	fndb.hfn203m
					set		bal_amt = nvl(bal_amt,0) + :ldec_slip_amt
					where		acct_class = :gi_acct_class
					and		acct_code = :ls_acct_code
					and		mana_code = :li_mana_code
					and		mana_data = :ls_mana_data	;
				else
					// 미결전표에 삽입
					insert	into	fndb.hfn203m	(	acct_class,
																acct_code,
																mana_code,
																mana_data,
																stat_gubun,
																slip_date,
																slip_no,
																slip_seq,
																bal_amt,
																sang_amt,
																remark,
																worker,
																ipaddr,
																work_date,
																job_uid,
																job_add,
																job_date	)
												values	(	:gi_acct_class,
																:ls_acct_code,
																:li_mana_code,
																:ls_mana_data,
																'Y',
																:as_slip_date,
																:ai_slip_no,
																:li_slip_seq,
																:ldec_slip_amt,
																0,
																:ls_remark,
																:gs_empcode,
																:gs_ip,
																:ldt_sysdate,
																:gs_empcode,
																:gs_ip,
																:ldt_sysdate	)	;
					
					//미결전표 로그 생성...
					wf_hfn203m_h_proc(1, gi_acct_class, ls_acct_code, li_mana_code, ls_mana_data, 'Y', &
											as_slip_date, ai_slip_no, li_slip_seq, ldec_slip_amt, 0, ls_remark, &
											ls_slip_date, li_slip_no, li_slip_seq)
				end if
				
				if sqlca.sqlcode <> 0 then return -1
			else														// 상계
				// 상계순번 획득
				select	nvl(max(sang_seq),0) + 1	into	:li_sang_seq
				from		fndb.hfn203h
				where		acct_class = :gi_acct_class
				and		acct_code  = :ls_acct_code
				and		mana_code  = :li_mana_code
				and		mana_data  = :ls_mana_data	;

				// 미결전표내역에 삽입
				insert	into	fndb.hfn203h	(	acct_class,
															acct_code,
															mana_code,
															mana_data,
															sang_seq,
															slip_date,
															slip_no,
															slip_seq,
															sang_amt,
															remark,
															worker,
															ipaddr,
															work_date,
															job_uid,
															job_add,
															job_date	)
											values	(	:gi_acct_class,
															:ls_acct_code,
															:li_mana_code,
															:ls_mana_data,
															:li_sang_seq,
															:as_slip_date,
															:ai_slip_no,
															:li_slip_seq,
															:ldec_slip_amt,
															:ls_remark,
															:gs_empcode,
															:gs_ip,
															:ldt_sysdate,
															:gs_empcode,
															:gs_ip,
															:ldt_sysdate	)	;
													
				if sqlca.sqlcode <> 0 then return -1
				
				//미결전표 로그 생성...
				wf_hfn203m_h_proc(2, gi_acct_class, ls_acct_code, li_mana_code, ls_mana_data, &
										'', '', 0, 0, 0, ldec_slip_amt, '', ls_slip_date, li_slip_no, li_slip_seq)

				// 미결전표에 Update
				update	fndb.hfn203m
				set		sang_amt = nvl(sang_amt,0) + :ldec_slip_amt
				where		acct_class = :gi_acct_class
				and		acct_code  = :ls_acct_code
				and		mana_code  = :li_mana_code
				and		mana_data  = :ls_mana_data	;
				
				if sqlca.sqlcode <> 0 then return -1
				
			end if
		end if
		
		// 배정예산관리에 Update
		// 가집행금액 (-)
		// 집행금액 (+)
		update	acdb.hac012m
		set		assn_temp_amt = nvl(assn_temp_amt,0) - :ldec_slip_amt,
					assn_real_amt = nvl(assn_real_amt,0) + :ldec_slip_amt
		where		bdgt_year  = :ls_bdgt_year
		and		gwa        = :ls_gwa
		and		acct_code  = :ls_acct_code
		and		acct_class = :gi_acct_class
		and		io_gubun   = :as_slip_class	;
		
		if	sqlca.sqlcode <> 0 then return -1
		
	else								// 확정취소
		// 미결전표관리에 Delete
		// 계정이 미결관리이면서 계정의 차대구분과 동일하면 발생삭제
		// 다르면 상계처리 삭제
		if ls_mi_acct_yn = 'Y' then
			if ls_drcr_class = ls_acct_drcr_class then
				// 존재하는 발생자료 확인
				select	nvl(bal_amt,0)
				into		:ldec_bal_amt
				from		fndb.hfn203m
				where		acct_class = :gi_acct_class
				and		acct_code = :ls_acct_code
				and		mana_code = :li_mana_code
				and		mana_data = :ls_mana_data	;
				
				if ldec_bal_amt <> ldec_slip_amt then
					//미결전표 로그 생성...
					wf_hfn203m_h_proc(2, gi_acct_class, ls_acct_code, li_mana_code, ls_mana_data, &
											'', '', 0, 0, -ldec_slip_amt, 0, '', ls_slip_date, li_slip_no, li_slip_seq)

					update	fndb.hfn203m
					set		bal_amt = nvl(bal_amt,0) - :ldec_slip_amt
					where		acct_class = :gi_acct_class
					and		acct_code = :ls_acct_code
					and		mana_code = :li_mana_code
					and		mana_data = :ls_mana_data	;
				else
					//미결전표 로그 생성...
					wf_hfn203m_h_proc(3, gi_acct_class, ls_acct_code, li_mana_code, ls_mana_data, &
											'', '', 0, 0, 0, 0, '', ls_slip_date, li_slip_no, li_slip_seq)

					// 미결전표 삭제
					delete	fndb.hfn203m
					where		acct_class = :gi_acct_class
					and		acct_code  = :ls_acct_code
					and		mana_code  = :li_mana_code
					and		mana_data  = :ls_mana_data	;
				end if
				
				if sqlca.sqlcode <> 0 then return -1
				
			else
				// 미결전표내역 삭제
				delete	fndb.hfn203h
				where		acct_class = :gi_acct_class
				and		acct_code  = :ls_acct_code
				and		mana_code  = :li_mana_code
				and		mana_data  = :ls_mana_data
				and		slip_date  = :as_slip_date
				and		slip_no    = :ai_slip_no
				and		slip_seq   = :li_slip_seq	;
				
				if sqlca.sqlcode <> 0 then return -1

				//미결전표 로그 생성...
				wf_hfn203m_h_proc(2, gi_acct_class, ls_acct_code, li_mana_code, ls_mana_data, &
										'', '', 0, 0, 0, -ldec_slip_amt, '', ls_slip_date, li_slip_no, li_slip_seq)

				// 미결전표에 Update
				update	fndb.hfn203m
				set		sang_amt = nvl(sang_amt,0) - :ldec_slip_amt
				where		acct_class = :gi_acct_class
				and		acct_code  = :ls_acct_code
				and		mana_code  = :li_mana_code
				and		mana_data  = :ls_mana_data	;
				
				if sqlca.sqlcode <> 0 then return -1
				
			end if
		end if

		// 배정예산관리에 Update
		// 가집행금액 (+)
		// 집행금액 (-)
		update	acdb.hac012m
		set		assn_temp_amt = nvl(assn_temp_amt,0) + :ldec_slip_amt,
					assn_real_amt = nvl(assn_real_amt,0) - :ldec_slip_amt
		where		bdgt_year  = :ls_bdgt_year
		and		gwa        = :ls_gwa
		and		acct_code  = :ls_acct_code
		and		acct_class = :gi_acct_class
		and		io_gubun   = :as_slip_class	;

		if	sqlca.sqlcode <> 0 then return -1
		
	end if
	
// 배정예산관리 집행금액, 가집행금액 update오류로 막음 (20041005:Jung Kwang Hoon)
//	//procedure 2003-12-01
//   execute proc_jiphaeng ;

next

// 미결전표에(미결상태) Update
update	fndb.hfn203m
set		stat_gubun = 'N'
where		bal_amt = sang_amt	;

if sqlca.sqlcode <> 0 then return -1

// 미결전표에(미결상태) Update
update	fndb.hfn203m
set		stat_gubun = 'Y'
where		bal_amt <> sang_amt	;

if sqlca.sqlcode <> 0 then return -1

return 0

end function

public subroutine wf_button_control ();//// ------------------------------------------------------------------------------------------
//// Function Name	:	wf_button_control
//// Function 설명	:	버튼을 Control 한다.
//// Argument			:	
//// Return			:	
//// ------------------------------------------------------------------------------------------
//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		TRUE)
//wf_setMenu('PRINT',		FALSE)
//
end subroutine

public function integer wf_hfn203m_h_proc (integer ai_log_opt, integer ai_acct_class, string as_acct_code, integer ai_mana_code, string as_mana_data, string as_stat_gubun, string as_slip_date, integer ai_slip_no, integer ai_slip_seq, decimal adec_bal_amt, decimal adec_sang_amt, string as_remark, string as_new_slip_date, integer ai_new_slip_no, integer ai_new_slip_seq);//미결계정 로그 테이블 데이터 생성

integer 	li_log_seq
datetime	ldt_sysdate

ldt_sysdate = f_sysdate()

select	nvl(max(log_seq), 0) + 1
into		:li_log_seq
from		fndb.hfn203m_h
where		acct_class 	= :ai_acct_class
and		acct_code 	= :as_acct_code
and		mana_code 	= :ai_mana_code
and		mana_data 	= :as_mana_data	;

if ai_log_opt = 1 then			//입력
	INSERT INTO FNDB.HFN203M_H  
			 ( ACCT_CLASS,   		ACCT_CODE,   			MANA_CODE,   					MANA_DATA,   				LOG_SEQ,   	
				LOG_OPT,   			STAT_GUBUN,   			SLIP_DATE,   					SLIP_NO,   					SLIP_SEQ,   	
				BAL_AMT,   			SANG_AMT,   			REMARK,  	 					WORKER,   					IPADDR,   		
				WORK_DATE,   		JOB_UID,   				JOB_ADD,   						JOB_DATE,					NEW_SLIP_DATE,
				NEW_SLIP_NO,		NEW_SLIP_SEQ	
			 )  
	VALUES ( :ai_acct_class, 	:as_acct_code, 		:ai_mana_code, 				:as_mana_data, 			:li_log_seq, 
				:ai_log_opt,		:as_stat_gubun,		:as_slip_date,					:ai_slip_no,				:ai_slip_seq,
				:adec_bal_amt,		:adec_sang_amt,		:as_remark,						:gs_empcode,	:gs_ip,
				:ldt_sysdate,		:gs_empcode,:gs_ip, 	:ldt_sysdate,				:as_new_slip_date,
				:ai_new_slip_no,	:ai_new_slip_seq
			 ) ;
elseif ai_log_opt = 2 then		//수정
	insert	into	fndb.hfn203m_h
	select	acct_class, 	acct_code, 		mana_code, 		mana_data, 	:li_log_seq,
				:ai_log_opt, 	stat_gubun, 	slip_date, 		slip_no,		slip_seq,
				bal_amt 	+ :adec_bal_amt,		sang_amt + :adec_sang_amt,
//				CASE	WHEN	:adec_bal_amt 	>= 0	THEN	bal_amt 	+ :adec_bal_amt
//						WHEN	:adec_bal_amt 	< 0	THEN	bal_amt 	- :adec_bal_amt 	END,
//				CASE	WHEN	:adec_sang_amt >= 0	THEN	sang_amt + :adec_sang_amt
//						WHEN	:adec_sang_amt < 0	THEN	sang_amt - :adec_sang_amt 	END,
				remark,			:gs_empcode,			:gs_ip,
				:ldt_sysdate,	:gs_empcode,			:gs_ip, 	:ldt_sysdate,				
				:as_new_slip_date,	:ai_new_slip_no,			:ai_new_slip_seq
	from		fndb.hfn203m
	where		acct_class 	= :ai_acct_class
	and		acct_code 	= :as_acct_code
	and		mana_code 	= :ai_mana_code
	and		mana_data 	= :as_mana_data	;
elseif ai_log_opt = 3 then		//삭제
	insert	into	fndb.hfn203m_h
	select	acct_class, 	acct_code, 		mana_code, 		mana_data, 	:li_log_seq,
				:ai_log_opt, 	stat_gubun, 	slip_date, 		slip_no,		slip_seq,
				bal_amt,			sang_amt,		remark,			:gs_empcode,			
				:gs_ip,		:ldt_sysdate,	:gs_empcode,			
				:gs_ip, 		:ldt_sysdate,	:as_new_slip_date,	
				:ai_new_slip_no,					:ai_new_slip_seq
	from		fndb.hfn203m
	where		acct_class 	= :ai_acct_class
	and		acct_code 	= :as_acct_code
	and		mana_code 	= :ai_mana_code
	and		mana_data 	= :as_mana_data	;
end if

return 1


end function

on w_hfn307b.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_update=create dw_update
this.dw_detail=create dw_detail
this.pb_select=create pb_select
this.pb_noselect=create pb_noselect
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_update
this.Control[iCurrent+3]=this.dw_detail
this.Control[iCurrent+4]=this.pb_select
this.Control[iCurrent+5]=this.pb_noselect
end on

on w_hfn307b.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_update)
destroy(this.dw_detail)
destroy(this.pb_select)
destroy(this.pb_noselect)
end on

event ue_open;call super::ue_open;//wf_button_control()
//
//// 조회조건 Clear(회계단위)
//dw_head.getchild('code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('acct_class', 1) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//dw_head.reset()
//dw_head.insertrow(0)
//
//idw_child.scrolltorow(1)
//idw_child.setrow(1)
//
//ii_acct_class	=	idw_child.getitemnumber(1, 'code')
//
//is_end_date		=	f_today()
//is_str_date		=	is_end_date
//
//em_fr_date.text = string(is_str_date, '@@@@/@@/@@')
//em_to_date.text = string(is_end_date, '@@@@/@@/@@')
//
//uo_slip_date.st_title.text = '확정일자'
//is_slip_date	=	f_today()
//is_bdgt_year	=	f_getbdgtyear(is_slip_date)
//
//// 전표 구분(1=수입전표, 2=지출전표, 3=대체전표)
//ii_slip_class	=	2
//ddlb_slip_class.selectitem(ii_slip_class)
//
//// 처리(1=확정, 2=취소)
//ii_stat_gbn	=	1
//ii_step_opt =	4
//ddlb_stat_gbn.selectitem(ii_stat_gbn)
//
end event

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

String ls_fr_date, ls_to_date

dw_con.accepttext()
ls_fr_date = String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date = String(dw_con.object.to_date[1], 'yyyymmdd')
//if not isdate(em_fr_date.text) then
//	messagebox('확인', '전표일자(From)가 올바르지 않습니다.')
//	em_fr_date.setfocus()
//	return -1
//end if
//
//if not isdate(em_to_date.text) then
//	messagebox('확인', '전표일자(To)가 올바르지 않습니다.')
//	em_to_date.setfocus()
//	return -1
//end if

if ls_fr_date > ls_to_date  then
	messagebox('확인', '전표일자의 조회기간이 올바르지 않습니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return -1
end if




wf_retrieve()

Return 1

end event

event ue_save;call super::ue_save;integer	li_rtn
long		ll_find, ll_end
Integer	li_stat_gbn

dw_con.accepttext()
li_stat_gbn = Integer(dw_con.object.stat_gbn[1])

ll_end  = dw_update.rowcount()
ll_find = dw_update.find("stat_gbn = 9", 1, ll_end)

do while ll_find > 0
	if li_stat_gbn = 1 then
		if f_chk_magam(gi_acct_class, left(dw_update.getitemstring(ll_find, 'acct_date'),6)) > 0 then return -1
	else
		if f_chk_magam(gi_acct_class, left(dw_update.getitemstring(ll_find, 'old_acct_date'),6)) > 0 then return -1
	end if
	if f_chk_magam(gi_acct_class, dw_update.getitemstring(ll_find, 'bdgt_year')) > 0 then return -1
	
	ll_find ++
	if ll_find > ll_end then exit
	ll_find = dw_update.find("stat_gbn = 9", ll_find, ll_end)
loop

li_rtn	=	wf_save()

if li_rtn > 0 and li_rtn < 999 then
	commit	;
	f_messagebox('1', string(li_rtn) + '건의 ' + is_stat_title + '처리를 성공적으로 저장 했습니다.!')
	this.triggerevent('ue_retrieve')
elseif li_rtn < 0 then
	rollback	;
	f_messagebox('3', is_stat_title + '처리를 실패 했습니다.!~n~n' + sqlca.sqlerrtext)
elseif li_rtn = 0 then
	rollback	;
	f_messagebox('1', is_stat_title + '처리할 자료가 존재하지 않습니다.!')
end if

end event

event ue_postopen;call super::ue_postopen;wf_button_control()


dw_con.object.fr_date[1] = date(string(f_today(), '@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string(f_today(), '@@@@/@@/@@'))

dw_con.object.slip_date[1] =  date(string(f_today(), '@@@@/@@/@@'))



// 전표 구분(1=수입전표, 2=지출전표, 3=대체전표)
dw_con.object.slip_class[1]	=	'2'


// 처리(1=확정, 2=취소)
dw_con.object.stat_gbn[1]	=	'1'
ii_step_opt =	4


end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_templeft.beginx

If pb_select.Enabled Then
	pb_select.X		= ll_stnd_pos
	ll_stnd_pos		= ll_stnd_pos + pb_select.Width + 16
Else
	pb_select.Visible	= FALSE
End If

If pb_noselect.Enabled Then
	pb_noselect.X		= ll_stnd_pos
	ll_stnd_pos		= ll_stnd_pos + pb_noselect.Width + 16
Else
	pb_noselect.Visible	= FALSE
End If
end event

type ln_templeft from w_msheet`ln_templeft within w_hfn307b
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn307b
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn307b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn307b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn307b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn307b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn307b
end type

type uc_insert from w_msheet`uc_insert within w_hfn307b
end type

type uc_delete from w_msheet`uc_delete within w_hfn307b
end type

type uc_save from w_msheet`uc_save within w_hfn307b
end type

type uc_excel from w_msheet`uc_excel within w_hfn307b
end type

type uc_print from w_msheet`uc_print within w_hfn307b
end type

type st_line1 from w_msheet`st_line1 within w_hfn307b
end type

type st_line2 from w_msheet`st_line2 within w_hfn307b
end type

type st_line3 from w_msheet`st_line3 within w_hfn307b
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn307b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn307b
integer beginy = 356
integer endy = 356
end type

type dw_con from uo_dwfree within w_hfn307b
integer x = 50
integer y = 164
integer width = 4384
integer height = 192
integer taborder = 190
boolean bringtotop = true
string dataobject = "d_hfn307b_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
end event

event itemchanged;call super::itemchanged;long	ll_find, ll_end
String 	ls_slip_date, ls_bdgt_year
dw_con.accepttext()

Choose Case dwo.name
	Case 'stat_gbn'
		
		if data = '1' then
			ii_step_opt	=	4
		else
			ii_step_opt	=	5
		end if

		is_stat_title	=	mid(trim(dw_con.describe("Evaluate ('LookUpDisplay (stat_gbn)', " + string(1) + ")")), 3, len(trim( dw_con.describe("Evaluate ('LookUpDisplay (stat_gbn)', " + string(1) + ")"))) - 2)
	Case 'slip_date'


		ls_slip_date	=	string(data, '@@@@@@@@')
		ls_bdgt_year	=	f_getbdgtyear(ls_slip_date)
		
		ll_end  = dw_update.rowcount()
		ll_find = dw_update.find("stat_gbn = 9", 1, ll_end)
		
		do while ll_find > 0
			dw_update.setitem(ll_find, 'acct_date', ls_slip_date)
			
			ll_find ++
			if ll_find > ll_end then exit
			ll_find = dw_update.find("stat_gbn = 9", ll_find, ll_end)
		loop

End Choose
end event

type dw_update from uo_dwgrid within w_hfn307b
integer x = 50
integer y = 364
integer width = 4384
integer height = 1936
integer taborder = 90
string dataobject = "d_hfn307b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String 	ls_slip_date
Integer	li_stat_gbn

dw_con.accepttext()
ls_slip_date = string(dw_con.object.slip_date[1], 'yyyymmdd')
li_stat_gbn = Integer(dw_con.object.stat_gbn[1])

if dwo.name = 'stat_gbn' then
	
	if data = '9' then
		if li_stat_gbn = 1 then
			if getitemstring(row, 'slip_date') <= ls_slip_date then
				setitem(row, 'acct_date', ls_slip_date)
			else
				messagebox('확인', '확정일자가 전표일자 이전으로 처리할 수 없습니다.')
				setitem(row, 'stat_gbn', '0')
				return 1
			end if
		else
			setitem(row, 'acct_date', '')
			setitem(row, 'acct_no', 0)
		end if
	else
		if li_stat_gbn = 1 then
			setitem(row, 'acct_date', '')
		else
			setitem(row, 'acct_date', getitemstring(row, 'old_acct_date'))
			setitem(row, 'acct_no', getitemnumber(row, 'old_acct_no'))
		end if
	end if
end if
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

event doubleclicked;call super::doubleclicked;s_insa_com	lstr_com

if row < 1 then return

lstr_com.ls_item[1] = string(getitemnumber(row, 'acct_class'))		// 회계단위
lstr_com.ls_item[2] = 		  getitemstring(row, 'slip_date')		// 전표일자
lstr_com.ls_item[3] = string(getitemnumber(row, 'slip_no'))			//	전표일자

openwithparm(w_hfn202m_help, lstr_com)

//dw_detail.retrieve(getitemnumber(row, 'acct_class'), getitemstring(row, 'slip_date'), getitemnumber(row, 'slip_no'))

end event

event itemerror;call super::itemerror;return 1
end event

event losefocus;call super::losefocus;accepttext()
end event

type dw_detail from uo_dwgrid within w_hfn307b
boolean visible = false
integer x = 603
integer y = 640
integer taborder = 100
boolean bringtotop = true
boolean titlebar = true
string title = "전표내역"
string dataobject = "d_hfn307b_2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type pb_select from uo_imgbtn within w_hfn307b
integer x = 55
integer y = 36
integer taborder = 90
boolean bringtotop = true
string btnname = "전체선택"
end type

event clicked;call super::clicked;long	ll_row, ll_rowcount
String	ls_slip_date
Integer	li_stat_gbn

dw_con.accepttext()
li_stat_gbn = Integer(dw_con.object.stat_gbn[1])
ls_slip_date = String(dw_con.object.slip_date[1], 'yyyymmdd')

ll_rowcount	=	dw_update.rowcount()

for ll_row = 1 to ll_rowcount
	if li_stat_gbn = 1 then
		// 확정일자 이후의 전표일자 자료는 제외
		if dw_update.getitemstring(ll_row, 'slip_date') <= ls_slip_date then
			dw_update.setitem(ll_row, 'acct_date', ls_slip_date)
			dw_update.setitem(ll_row, 'stat_gbn', 9)
		end if
	else
		dw_update.setitem(ll_row, 'acct_date', '')
		dw_update.setitem(ll_row, 'acct_no', 0)
		dw_update.setitem(ll_row, 'stat_gbn', 9)
	end if
next

end event

on pb_select.destroy
call uo_imgbtn::destroy
end on

type pb_noselect from uo_imgbtn within w_hfn307b
integer x = 480
integer y = 36
integer taborder = 100
boolean bringtotop = true
string btnname = "전체해지"
end type

event clicked;call super::clicked;long	ll_row, ll_rowcount
Integer	li_stat_gbn

dw_con.accepttext()
li_stat_gbn = Integer(dw_con.object.stat_gbn[1])

ll_rowcount	=	dw_update.rowcount()

for ll_row = 1 to ll_rowcount
	if li_stat_gbn = 1 then
		dw_update.setitem(ll_row, 'acct_date', '')
		dw_update.setitem(ll_row, 'stat_gbn', 	0)
	else
		dw_update.setitem(ll_row, 'acct_date', dw_update.getitemstring(ll_row, 'old_acct_date'))
		dw_update.setitem(ll_row, 'acct_no', 	dw_update.getitemnumber(ll_row, 'old_acct_no'))
		dw_update.setitem(ll_row, 'stat_gbn', 	0)
	end if
next

end event

on pb_noselect.destroy
call uo_imgbtn::destroy
end on

