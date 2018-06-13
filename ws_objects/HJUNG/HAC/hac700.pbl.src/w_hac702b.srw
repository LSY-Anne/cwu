$PBExportHeader$w_hac702b.srw
$PBExportComments$예산편성 확정(예산부서용)
forward
global type w_hac702b from w_tabsheet
end type
type st_2 from statictext within w_hac702b
end type
type st_31 from statictext within w_hac702b
end type
type uo_1 from cuo_search within w_hac702b
end type
type gb_3 from groupbox within w_hac702b
end type
type dw_list002 from uo_dwgrid within w_hac702b
end type
type dw_list003 from uo_dwgrid within w_hac702b
end type
type pb_process from uo_imgbtn within w_hac702b
end type
type pb_delete from uo_imgbtn within w_hac702b
end type
end forward

global type w_hac702b from w_tabsheet
string title = "예산편성 확정(예산부서용)"
st_2 st_2
st_31 st_31
uo_1 uo_1
gb_3 gb_3
dw_list002 dw_list002
dw_list003 dw_list003
pb_process pb_process
pb_delete pb_delete
end type
global w_hac702b w_hac702b

type variables
datawindowchild	idw_child
datawindow			idw_mast, idw_data, idw_mgr_dept

//string	is_bdgt_year, is_unit_dept
//integer	ii_acct_class					// 회계단위
//integer	ii_bdgt_class					// 예산구분
integer	ii_stat_1		=	23			// 상태구분(23 예산부서 접수)
integer	ii_stat_2		=	41			// 상태구분(41 예산부서 확정)
integer	ii_stat_class_1, ii_stat_class_2

//string	is_mgr_dept						// 주관부서
string	is_main_dept					// 로긴 예산부서
//string	is_pay_date						// 배정예산일자

string	is_process

long 	il_currentrow

end variables

forward prototypes
public function integer wf_process ()
public subroutine wf_retrieve ()
public subroutine wf_retrieve_2 ()
public subroutine wf_getchild ()
public function integer wf_create ()
public subroutine wf_button_control ()
public function integer wf_delete ()
end prototypes

public function integer wf_process ();// ==========================================================================================
// 기    능 : 	부서확정처리
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_process()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	i, li_stat_class, li_cnt
String ls_mgr_dept, ls_bdgt_year
Integer li_bdgt_class

dw_con.accepttext()

ls_mgr_dept = dw_con.object.code[1]
ls_bdgt_year = STring(dw_con.object.year[1], 'yyyy')
li_bdgt_class = Integer(dw_con.object.bdgt_class[1])

if ls_mgr_dept <> '%' then
	if trim(ls_mgr_dept) = '' then
		f_messagebox('1', '확정처리할 주관부서를 선택해 주세요.!')
		idw_mgr_dept.setfocus()
		return	100
	end if
end if

if idw_mast.rowcount() < 1 then
	f_messagebox('1', '처리할 자료가 존재하지 않습니다.~n~n조회한 후 실행해주시기 바랍니다.!')	
	return	100
end if

select	count(*)
into		:li_cnt
from		acdb.hac011h
where		bdgt_year	=		:ls_bdgt_year
and		gwa			like	:ls_mgr_dept||'%'
and		acct_class	=		:gi_acct_class
and		bdgt_class	=		:li_bdgt_class	
and		stat_class	not in (:ii_stat_class_1, :ii_stat_class_2)	;

if li_cnt > 0 then
	f_messagebox('1', '확정할 자료 이외의 자료가 존재합니다.~n~n확인한 후 실행해주시기 바랍니다.!')	
	return	100
end if
	
for i = 1 to idw_mast.rowcount()
	li_stat_class = idw_mast.getitemnumber(i, 'stat_class')
	if li_stat_class = ii_stat_class_1 then
		idw_mast.setitem(i, 'stat_class', 	ii_stat_class_2)
		idw_mast.setitem(i, 'confirm_amt', 	idw_mast.getitemnumber(i, 'adjust_amt'))
		idw_mast.setitem(i, 'job_uid',		gs_empcode)
		idw_mast.setitem(i, 'job_add',		gs_ip)
		idw_mast.setitem(i, 'job_date',		f_sysdate())
	end if
next

is_process	=	'C'

return	0

end function

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_name
integer	li_tab
String 	ls_bdgt_year, ls_mgr_dept
Integer 	li_bdgt_class

dw_con.accepttext()

ls_bdgt_year = String(dw_con.object.year[1], 'yyyy')
li_bdgt_class = Integer(dw_con.object.bdgt_class[1])
ls_mgr_dept = dw_con.object.code[1]

if f_chkterm(ls_bdgt_year, li_bdgt_class, ii_stat_2) < 0 then
	ii_stat_class_1 = -1
	ii_stat_class_2 = -1
else
	ii_stat_class_1 = ii_stat_1
	ii_stat_class_2 = ii_stat_2
end if

wf_button_control()

idw_mast.retrieve(ls_bdgt_year, ls_mgr_dept, gi_acct_class, li_bdgt_class, ii_stat_class_1, ii_stat_class_2)

end subroutine

public subroutine wf_retrieve_2 ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve_2()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_acct_code, ls_dept_code, ls_io_gubun
String 	ls_bdgt_year
Integer	li_bdgt_class

dw_con.accepttext()
ls_bdgt_year = String(dw_con.object.year[1], 'yyyy')
li_bdgt_class = Integer(dw_con.object.bdgt_class[1])

if idw_mast.rowcount() < 1 or il_currentrow < 1 then	return

ls_acct_code = idw_mast.getitemstring(il_currentrow, 'acct_code')
ls_dept_code = idw_mast.getitemstring(il_currentrow, 'gwa')
ls_io_gubun  = idw_mast.getitemstring(il_currentrow, 'io_gubun')

idw_data.retrieve(ls_bdgt_year, ls_dept_code, ls_acct_code, gi_acct_class, ls_io_gubun, li_bdgt_class, ii_stat_class_2)


end subroutine

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String ls_mgr_dept

dw_con.accepttext()

ls_mgr_dept = dw_con.object.code[1]

// 주관부서
idw_mgr_dept.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 2) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
else
	idw_child.insertrow(1)
	idw_child.setitem(1, 'dept_code', '%')
	idw_child.setitem(1, 'dept_name', '전체')
end if

//idw_mgr_dept.reset()
//idw_mgr_dept.insertrow(0)
ls_mgr_dept	=	'%'
idw_mgr_dept.setitem(1, 'code', ls_mgr_dept)

dw_con.getchild('bdgt_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bdgt_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
	return	
end if

dw_con.object.bdgt_class[1] = '0'


// 요구부서
idw_mast.getchild('gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 주관부서
idw_mast.getchild('mgr_gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 2) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 상태
idw_mast.getchild('stat_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('stat_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public function integer wf_create ();// ==========================================================================================
// 기    능 : 예산배정에 반영한다.(hac012m Update)
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long		ll_count, ll_row, ll_rowcount
string	ls_gwa, ls_acct_code, ls_io_gubun
dec{0}	ldb_confirm_amt

String 	ls_bdgt_year, ls_mgr_dept, ls_pay_date
Integer 	li_bdgt_class

dw_con.accepttext()

ls_bdgt_year = String(dw_con.object.year[1], 'yyyy')
li_bdgt_class = Integer(dw_con.object.bdgt_class[1])
ls_mgr_dept = dw_con.object.code[1]
ls_pay_date =  String(dw_con.object.pay_date[1], 'yyyymmdd')

// 예산배정에 반영한다.(hac012m Update)
select	count(*)
into		:ll_count
from		acdb.hac012m
where		bdgt_year	=	:ls_bdgt_year
and		gwa			in	(	select	gwa
									from		acdb.hac011h
									where		bdgt_year	=		:ls_bdgt_year
									and		mgr_gwa		like	:ls_mgr_dept||'%'
									and		acct_class	=		:gi_acct_class
									and		bdgt_class	=		:li_bdgt_class	)
and		acct_code	in	(	select	acct_code
									from		acdb.hac011h
									where		bdgt_year	=		:ls_bdgt_year
									and		mgr_gwa		like	:ls_mgr_dept||'%'
									and		acct_class	=		:gi_acct_class
									and		bdgt_class	=		:li_bdgt_class	)
and		acct_class	=	:gi_acct_class
and		decode(:li_bdgt_class, 1, assn_1st_amt, 2, assn_2nd_amt, 3, assn_3rd_amt)	<>	0	;

if ll_count > 0 then
	if f_messagebox('2', string(li_bdgt_class) + '차 추경 자료가 존재합니다.~n~n삭제 후 재생성하시겠습니까?') <> 1 then	return	100
end if

ll_rowcount	=	idw_mast.rowcount()

for	ll_row	=	1	to	ll_rowcount
	ls_gwa				=	trim(idw_mast.getitemstring(ll_row, 'gwa'))
	ls_acct_code		=	trim(idw_mast.getitemstring(ll_row, 'acct_code'))
	ls_io_gubun			=	trim(idw_mast.getitemstring(ll_row, 'io_gubun'))
	ldb_confirm_amt	=	idw_mast.getitemnumber(ll_row, 'confirm_amt')
	
	select	count(*)
	into		:ll_count
	from		acdb.hac012m
	where		bdgt_year	=	:ls_bdgt_year
	and		gwa			=	:ls_gwa
	and		acct_code	=	:ls_acct_code
	and		acct_class	=	:gi_acct_class
	and		io_gubun		=	:ls_io_gubun	;

	if ll_count > 0 then
		
		///////////////////////////////////////////////////////////

		//예산전용된 내역이 있다면 이전 예산내역의 금액을 감산한다. 
		//추경에 반영이 되기 때문 : 2004.12.06 - Jung Kwang Hoon
		string	ls_jun_gwa, ls_jun_acct_code, ls_req_date, ls_causes, ls_str_date
		long		ll_req_amt
		
		//배정예산 시작기간 조회
		select 	min(decode(:li_bdgt_class, 1, :ls_bdgt_year||'0301', 2, assn_1st_date, 3, assn_2nd_date))
		into		:ls_str_date
		from		acdb.hac012m
		where		bdgt_year	=	:ls_bdgt_year
		and		acct_class	=	:gi_acct_class ;
		
		//예산전용내역 조회
		SELECT 	GWA,				ACCT_CODE,				REQ_DATE, 		REQ_AMT, 		CAUSES  
		INTO 		:ls_jun_gwa, 	:ls_jun_acct_code, 	:ls_req_date,	:ll_req_amt,	:ls_causes
		FROM 		ACDB.HAC014H  
	   WHERE 	BDGT_YEAR 		= 	:ls_bdgt_year 	
		AND   	ACCT_CLASS 		= 	:gi_acct_class 	
		AND  		IO_GUBUN 		= 	:ls_io_gubun 		
		AND  		TRAN_GWA 		= 	:ls_gwa 			
		AND  		TRAN_ACCT_CODE = 	:ls_acct_code 	
		AND  		STAT_CLASS 		= 	2
		AND		REQ_DATE			>= :ls_str_date 	
		AND 		REQ_DATE			< 	:ls_pay_date			;

		if sqlca.sqlcode <> 100 then	//예산전용에 자료가 있으면
		//전용금액과 추경입력금액이 같으면 => 2007.06.04 삭제
		//	if ldb_confirm_amt = ll_req_amt then	
		
			//예산전용한 계정에 대한 update
			//예산전용(전입) 금액과 날짜 리셋 (추경예산에 반영되었음) : 2007.06.04 추가
			UPDATE	ACDB.HAC012M
			SET		ASSN_TRAN_AMT 	= NVL(ASSN_TRAN_AMT,0) - :ll_req_amt,
						ASSN_TRAN_DATE	= ''
			WHERE 	BDGT_YEAR 	= :ls_bdgt_year 
			AND  		GWA 			= :ls_gwa 
			AND  		ACCT_CODE 	= :ls_acct_code 
			AND  		ACCT_CLASS 	= :gi_acct_class 
			AND  		IO_GUBUN 	= :ls_io_gubun 	;
			
			if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
			
			/* 2007.06.04 backup
				//예산전용한 계정에 대한 update
				UPDATE 	ACDB.HAC012M  
				SET 		ASSN_BDGT_AMT = DECODE(:li_bdgt_class, 1, ASSN_BDGT_AMT 	- :ll_req_amt, ASSN_BDGT_AMT),
							ASSN_1ST_AMT  = DECODE(:li_bdgt_class, 2, ASSN_1ST_AMT  	- :ll_req_amt, ASSN_1ST_AMT),
							ASSN_2ND_AMT  = DECODE(:li_bdgt_class, 3, ASSN_2ND_AMT 	- :ll_req_amt, ASSN_2ND_AMT)
				WHERE 	BDGT_YEAR 	= :ls_bdgt_year 
				AND  		GWA 			= :ls_gwa 
				AND  		ACCT_CODE 	= :ls_acct_code 
				AND  		ACCT_CLASS 	= :gi_acct_class 
				AND  		IO_GUBUN 	= :ls_io_gubun 	;
				//금액조정
	
				if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
				UPDATE 	ACDB.HAC012M  
				SET 		ASSN_BDGT_DATE = DECODE(:li_bdgt_class, 1, '', ASSN_BDGT_DATE),   
							ASSN_1ST_DATE  = DECODE(:li_bdgt_class, 2, '', ASSN_1ST_DATE),   
							ASSN_2ND_DATE  = DECODE(:li_bdgt_class, 3, '', ASSN_2ND_DATE)
				WHERE 	BDGT_YEAR 	= :ls_bdgt_year 	
				AND  		GWA 			= :ls_gwa 			
				AND  		ACCT_CODE 	= :ls_acct_code 	
				AND  		ACCT_CLASS 	= :gi_acct_class 	
				AND  		IO_GUBUN 	= :ls_io_gubun 	
				AND		DECODE(:li_bdgt_class, 1, ASSN_BDGT_AMT, 2, ASSN_1ST_AMT, 3, ASSN_2ND_AMT) = 0	;
				//기간 리셋
	
				if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
			*/
		
			//예산전용한 원래 계정으로 예산금액 돌려줌. 
			//목변경 내역을 추경에 반영하므로 : 2004.12.23 - Jung Kwang Hoon
			//예산전용(전출) 금액과 날짜 리셋 (추경예산에 반영되었음) : 2007.06.04 추가
			UPDATE	ACDB.HAC012M
			SET		ASSN_TRAN_AMT	=	NVL(ASSN_TRAN_AMT,0) + :ll_req_amt,
						ASSN_USED_AMT	=	NVL(ASSN_USED_AMT,0) + :ll_req_amt
			WHERE 	BDGT_YEAR 	= :ls_bdgt_year 
			AND  		GWA 			= :ls_jun_gwa 
			AND  		ACCT_CODE 	= :ls_jun_acct_code 
			AND  		ACCT_CLASS 	= :gi_acct_class 
			AND  		IO_GUBUN 	= :ls_io_gubun 	;
			
			if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
			
			UPDATE	ACDB.HAC012M
			SET		ASSN_TRAN_DATE	=	''
			WHERE 	BDGT_YEAR 	= :ls_bdgt_year 
			AND  		GWA 			= :ls_jun_gwa 
			AND  		ACCT_CODE 	= :ls_jun_acct_code 
			AND  		ACCT_CLASS 	= :gi_acct_class 
			AND  		IO_GUBUN 	= :ls_io_gubun 	
			AND		NVL(ASSN_TRAN_AMT,0) = 0	;
			
			if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
			
			/* 2007.06.04 backup
				//예산전용한 원래 계정으로 예산금액 돌려줌. 
				//목변경 내역을 추경에 반영하므로 : 2004.12.23 - Jung Kwang Hoon
				UPDATE 	ACDB.HAC012M  
				SET 		ASSN_BDGT_DATE = DECODE(:li_bdgt_class, 1, :ls_req_date, ASSN_BDGT_DATE),   
							ASSN_1ST_DATE  = DECODE(:li_bdgt_class, 2, :ls_req_date, ASSN_1ST_DATE),   
							ASSN_2ND_DATE  = DECODE(:li_bdgt_class, 3, :ls_req_date, ASSN_2ND_DATE)
				WHERE 	BDGT_YEAR 	= :ls_bdgt_year 	
				AND  		GWA 			= :ls_jun_gwa 			
				AND  		ACCT_CODE 	= :ls_jun_acct_code 	
				AND  		ACCT_CLASS 	= :gi_acct_class 	
				AND  		IO_GUBUN 	= :ls_io_gubun 	
				AND		DECODE(:li_bdgt_class, 1, ASSN_BDGT_AMT, 2, ASSN_1ST_AMT, 3, ASSN_2ND_AMT) = 0	;
				//기간 부터 update...
	
				if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
				UPDATE 	ACDB.HAC012M  
				SET 		ASSN_BDGT_AMT = DECODE(:li_bdgt_class, 1, ASSN_BDGT_AMT 	+ :ll_req_amt, ASSN_BDGT_AMT),
							ASSN_1ST_AMT  = DECODE(:li_bdgt_class, 2, ASSN_1ST_AMT 	+ :ll_req_amt, ASSN_1ST_AMT),
							ASSN_2ND_AMT  = DECODE(:li_bdgt_class, 3, ASSN_2ND_AMT 	+ :ll_req_amt, ASSN_2ND_AMT),
							ASSN_USED_AMT = ASSN_USED_AMT + :ll_req_amt
				WHERE 	BDGT_YEAR 	= :ls_bdgt_year 
				AND  		GWA 			= :ls_jun_gwa 
				AND  		ACCT_CODE 	= :ls_jun_acct_code 
				AND  		ACCT_CLASS 	= :gi_acct_class 
				AND  		IO_GUBUN 	= :ls_io_gubun 	;
				
				if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
			*/

		//	end if
		end if
		
		///////////////////////////////////////////////////////////
		
		//추경금액, 날짜 Update
		update	acdb.hac012m
		set		assn_1st_amt	=	decode(:li_bdgt_class, 1, nvl(:ldb_confirm_amt, 0),	assn_1st_amt),
					assn_2nd_amt	=	decode(:li_bdgt_class, 2, nvl(:ldb_confirm_amt, 0),	assn_2nd_amt),
					assn_3rd_amt	=	decode(:li_bdgt_class, 3, nvl(:ldb_confirm_amt, 0),	assn_3rd_amt),
					assn_1st_date	=	decode(:li_bdgt_class, 1, :ls_pay_date,					assn_1st_date),
					assn_2nd_date	=	decode(:li_bdgt_class, 2, :ls_pay_date,					assn_2nd_date),
					assn_3rd_date	=	decode(:li_bdgt_class, 3, :ls_pay_date,					assn_3rd_date),
					job_uid			=	:gs_empcode,
					job_add			=	:gs_ip,
					job_date			=	sysdate
		where		bdgt_year		=	:ls_bdgt_year
		and		gwa				=	:ls_gwa
		and		acct_code		=	:ls_acct_code
		and		acct_class		=	:gi_acct_class
		and		io_gubun			=	:ls_io_gubun	;
											
		if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
		
		// 합계금액 Update
		// 전용금액 더하는거 추가 : 2007.06.04
		update	acdb.hac012m
		set		assn_used_amt	=	nvl(assn_bdgt_amt,0) + nvl(assn_tran_amt,0) + 
											nvl(assn_1st_amt,0) + nvl(assn_2nd_amt,0) + nvl(assn_3rd_amt,0)
		where		bdgt_year		=	:ls_bdgt_year
		and		gwa				=	:ls_gwa
		and		acct_code		=	:ls_acct_code
		and		acct_class		=	:gi_acct_class
		and		io_gubun			=	:ls_io_gubun	;
											
		if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode	
	
	else
		
		// 없으면 insert...
		insert	into	acdb.hac012m
				(	bdgt_year, 				gwa, 					acct_code, 			acct_class, 		io_gubun,
					assn_bdgt_amt, 		assn_1st_amt, 		assn_2nd_amt, 		assn_3rd_amt,
					assn_bdgt_date, 		assn_1st_date, 	assn_2nd_date, 	assn_3rd_date,
					assn_used_amt, 		assn_temp_amt, 	assn_real_amt, 	work_gbn,
					worker, 					ipaddr, 										work_date,
					job_uid, 				job_add, 									job_date	)
		values
				(	:ls_bdgt_year, 		:ls_gwa, 			:ls_acct_code, 	:gi_acct_class, 	:ls_io_gubun,
					0, 
					decode(:li_bdgt_class, 1, nvl(:ldb_confirm_amt, 0), 0),
					decode(:li_bdgt_class, 2, nvl(:ldb_confirm_amt, 0), 0),
					decode(:li_bdgt_class, 3, nvl(:ldb_confirm_amt, 0), 0),
					'', 
					decode(:li_bdgt_class, 1, :ls_pay_date, ''),
					decode(:li_bdgt_class, 2, :ls_pay_date, ''),
					decode(:li_bdgt_class, 3, :ls_pay_date, ''),
					:ldb_confirm_amt, 	0, 					0, 					'C',					
					:gs_empcode, :gs_ip, 			sysdate,
					:gs_empcode, :gs_ip, 			sysdate	)	;
		
		if sqlca.sqlcode	<>	0	then	return	sqlca.sqlcode
		
	end if
next

return	0

end function

public subroutine wf_button_control ();// ==========================================================================================
// 기    능 : 	button control
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_button_control()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

if ii_stat_class_2 < 0 then
//	wf_setMenu('INSERT',		FALSE)
//	wf_setMenu('DELETE',		FALSE)
//	wf_setMenu('RETRIEVE',	TRUE)
//	wf_setMenu('UPDATE',		FALSE)
//	wf_setMenu('PRINT',		FALSE)

	pb_process.of_enable(false)
else
//	wf_setMenu('INSERT',		FALSE)
//	wf_setMenu('DELETE',		FALSE)
//	wf_setMenu('RETRIEVE',	TRUE)
//	wf_setMenu('UPDATE',		TRUE)
//	wf_setMenu('PRINT',		FALSE)

	pb_process.of_enable(true)
end if
end subroutine

public function integer wf_delete ();// ==========================================================================================
// 기    능 : 	부서확정취소
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_delete()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_gwa, ls_acct_code, ls_io_gubun
integer	i, li_stat_class, li_cnt
double	ldb_confirm_amt
String 	ls_mgr_dept, ls_bdgt_year, ls_pay_date
Integer	li_acct_class, li_bdgt_class

dw_con.accepttext()

ls_mgr_dept = dw_con.object.code[1]
ls_bdgt_year = String(dw_con.object.year[1], 'yyyy')
li_bdgt_class = Integer(dw_con.object.bdgt_class[1])
ls_pay_date = String(dw_con.object.pay_date[1], 'yyyymmdd')

if ls_mgr_dept <> '%' then
	if trim(ls_mgr_dept) = '' then
		f_messagebox('1', '확정취소 처리할 주관부서를 선택해 주세요.!')
		idw_mgr_dept.setfocus()
		return	100
	end if
end if

if idw_mast.rowcount() < 1 then
	f_messagebox('1', '확정취소 처리할 자료가 존재하지 않습니다.~n~n조회한 후 실행해주시기 바랍니다.!')	
	return	100
end if

select	count(*)
into		:li_cnt
from		acdb.hac011h
where		bdgt_year	=		:ls_bdgt_year
and		gwa			like	:ls_mgr_dept||'%'
and		acct_class	=		:gi_acct_class
and		bdgt_class	=		:li_bdgt_class	
and		stat_class	not in (:ii_stat_class_1, :ii_stat_class_2)	
and		work_gbn		=		'C'	;

if li_cnt > 0 then
	f_messagebox('1', '확정취소할 자료 이외의 자료가 존재합니다.~n~n확인한 후 실행해주시기 바랍니다.!')	
	return	100
end if


for i = 1 to idw_mast.rowcount()
	ls_gwa 				= idw_mast.getitemstring(i, 'gwa')
	ls_acct_code 		= idw_mast.getitemstring(i, 'acct_code')
	ls_io_gubun 		= idw_mast.getitemstring(i, 'io_gubun')
	li_stat_class 		= idw_mast.getitemnumber(i, 'stat_class')
	ldb_confirm_amt	= idw_mast.getitemnumber(i, 'confirm_amt')
	
//	// 배정예산에 Update
//	update	acdb.hac012m
//	set		assn_1st_amt	=	decode(:li_bdgt_class, 1, 0,	assn_1st_amt),
//				assn_2nd_amt	=	decode(:li_bdgt_class, 2, 0,	assn_2nd_amt),
//				assn_3rd_amt	=	decode(:li_bdgt_class, 3, 0,	assn_3rd_amt),
//				assn_1st_date	=	decode(:li_bdgt_class, 1, '',	assn_1st_date),
//				assn_2nd_date	=	decode(:li_bdgt_class, 2, '',	assn_2nd_date),
//				assn_3rd_date	=	decode(:li_bdgt_class, 3, '',	assn_3rd_date),
//				job_uid			=	:gs_empcode,
//				job_add			=	:gs_ip,
//				job_date			=	sysdate
//	where		bdgt_year		=	:ls_bdgt_year
//	and		gwa				=	:ls_gwa
//	and		acct_code		=	:ls_acct_code
//	and		acct_class		=	:gi_acct_class
//	and		io_gubun			=	:ls_io_gubun	;
//											
//	if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode


	///////////////////////////////////////////////////////////
	//예산전용된 내역이 있다면 추경전의 예산내역에 금액을 다시 되돌림.
	//확정 취소시 다시 처리 : 2004.12.22 - Jung Kwang Hoon
	string	ls_jun_gwa, ls_jun_acct_code, ls_req_date, ls_causes, ls_str_date
	long		ll_req_amt
	
	//배정예산 시작기간 조회
	select 	min(decode(:li_bdgt_class, 1, :ls_bdgt_year||'0301', 2, assn_1st_date, 3, assn_2nd_date))
	into		:ls_str_date
	from		acdb.hac012m
	where		bdgt_year	=	:ls_bdgt_year
	and		acct_class	=	:gi_acct_class ;
	
	//예산전용내역 조회
	SELECT 	GWA,				ACCT_CODE,				REQ_DATE, 		REQ_AMT, 		CAUSES  
	INTO 		:ls_jun_gwa, 	:ls_jun_acct_code, 	:ls_req_date,	:ll_req_amt,	:ls_causes
	FROM 		ACDB.HAC014H  
	WHERE 	BDGT_YEAR 		= 	:ls_bdgt_year 	
	AND   	ACCT_CLASS 		= 	:gi_acct_class 	
	AND  		IO_GUBUN 		= 	:ls_io_gubun 		
	AND  		TRAN_GWA 		= 	:ls_gwa 			
	AND  		TRAN_ACCT_CODE = 	:ls_acct_code 	
	AND  		STAT_CLASS 		= 	2   				
	AND		REQ_DATE			>= :ls_str_date 	
	AND 		REQ_DATE			< 	:ls_pay_date			;

	if sqlca.sqlcode <> 100 then	//예산전용에 자료가 있으면
	//전용금액과 추경입력금액이 같으면 : 2007.06.04 삭제
	//	if ldb_confirm_amt = ll_req_amt then	
		
		// 예산전용(전입) 금액 및 날짜 수정 : 2007.06.04 추가
		UPDATE	ACDB.HAC012M
		SET		ASSN_TRAN_AMT 	= NVL(ASSN_TRAN_AMT,0) + :ll_req_amt,
					ASSN_TRAN_DATE	= :ls_req_date
		WHERE 	BDGT_YEAR 	= :ls_bdgt_year 
		AND  		GWA 			= :ls_gwa 
		AND  		ACCT_CODE 	= :ls_acct_code 
		AND  		ACCT_CLASS 	= :gi_acct_class 
		AND  		IO_GUBUN 	= :ls_io_gubun 	;
		
		if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
			
		/* 2007.06.04 backup
			//update...........
			UPDATE 	ACDB.HAC012M  
			SET 		ASSN_BDGT_DATE = DECODE(:li_bdgt_class, 1, :ls_req_date, ASSN_BDGT_DATE),   
						ASSN_1ST_DATE  = DECODE(:li_bdgt_class, 2, :ls_req_date, ASSN_1ST_DATE),   
						ASSN_2ND_DATE  = DECODE(:li_bdgt_class, 3, :ls_req_date, ASSN_2ND_DATE)
			WHERE 	BDGT_YEAR 	= :ls_bdgt_year 	
			AND  		GWA 			= :ls_gwa 			
			AND  		ACCT_CODE 	= :ls_acct_code 	
			AND  		ACCT_CLASS 	= :gi_acct_class 	
			AND  		IO_GUBUN 	= :ls_io_gubun 	;
		//	AND		DECODE(:li_bdgt_class, 1, ASSN_BDGT_AMT, 2, ASSN_1ST_AMT, 3, ASSN_2ND_AMT) = 0
	
			if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
			UPDATE 	ACDB.HAC012M  
			SET 		ASSN_BDGT_AMT = DECODE(:li_bdgt_class, 1, ASSN_BDGT_AMT 	+ :ll_req_amt, ASSN_BDGT_AMT),
						ASSN_1ST_AMT  = DECODE(:li_bdgt_class, 2, ASSN_1ST_AMT 	+ :ll_req_amt, ASSN_1ST_AMT),
						ASSN_2ND_AMT  = DECODE(:li_bdgt_class, 3, ASSN_2ND_AMT 	+ :ll_req_amt, ASSN_2ND_AMT)
			WHERE 	BDGT_YEAR 	= :ls_bdgt_year 
			AND  		GWA 			= :ls_gwa 
			AND  		ACCT_CODE 	= :ls_acct_code 
			AND  		ACCT_CLASS 	= :gi_acct_class 
			AND  		IO_GUBUN 	= :ls_io_gubun 	;
			//금액조정
	
			if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
		*/
	
		//예산전용된 내역이 있다면 추경전의 예산내역(예산전용한 원래 계정과목)에 금액을 마이너스.
		//확정 취소시 다시 처리 : 2004.12.23 - Jung Kwang Hoon
		//예산전용(전출) 금액과 날짜 수정 : 2007.06.04 추가
		UPDATE 	ACDB.HAC012M  
		SET		ASSN_TRAN_AMT 	= NVL(ASSN_TRAN_AMT,0) - :ll_req_amt,
					ASSN_TRAN_DATE	= :ls_req_date,
					ASSN_USED_AMT 	= NVL(ASSN_USED_AMT,0) - :ll_req_amt
		WHERE 	BDGT_YEAR 	= :ls_bdgt_year 
		AND  		GWA 			= :ls_jun_gwa 
		AND  		ACCT_CODE 	= :ls_jun_acct_code 
		AND  		ACCT_CLASS 	= :gi_acct_class 
		AND  		IO_GUBUN 	= :ls_io_gubun 	;
		
		if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
		
		/* 2007.06.04 backup
			//예산전용된 내역이 있다면 추경전의 예산내역(예산전용한 원래 계정과목)에 금액을 마이너스.
			//확정 취소시 다시 처리 : 2004.12.23 - Jung Kwang Hoon
			UPDATE 	ACDB.HAC012M  
			SET 		ASSN_BDGT_AMT = DECODE(:li_bdgt_class, 1, ASSN_BDGT_AMT 	- :ll_req_amt, ASSN_BDGT_AMT),
						ASSN_1ST_AMT  = DECODE(:li_bdgt_class, 2, ASSN_1ST_AMT 	- :ll_req_amt, ASSN_1ST_AMT),
						ASSN_2ND_AMT  = DECODE(:li_bdgt_class, 3, ASSN_2ND_AMT 	- :ll_req_amt, ASSN_2ND_AMT),
						ASSN_USED_AMT = ASSN_USED_AMT - :ll_req_amt
			WHERE 	BDGT_YEAR 	= :ls_bdgt_year 
			AND  		GWA 			= :ls_jun_gwa 
			AND  		ACCT_CODE 	= :ls_jun_acct_code 
			AND  		ACCT_CLASS 	= :gi_acct_class 
			AND  		IO_GUBUN 	= :ls_io_gubun 	;
			
			if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
			UPDATE 	ACDB.HAC012M  
			SET 		ASSN_BDGT_DATE = DECODE(:li_bdgt_class, 1, '', ASSN_BDGT_DATE),   
						ASSN_1ST_DATE  = DECODE(:li_bdgt_class, 2, '', ASSN_1ST_DATE),   
						ASSN_2ND_DATE  = DECODE(:li_bdgt_class, 3, '', ASSN_2ND_DATE)
			WHERE 	BDGT_YEAR 	= :ls_bdgt_year 	
			AND  		GWA 			= :ls_jun_gwa 			
			AND  		ACCT_CODE 	= :ls_jun_acct_code 	
			AND  		ACCT_CLASS 	= :gi_acct_class 	
			AND  		IO_GUBUN 	= :ls_io_gubun 	
			AND		DECODE(:li_bdgt_class, 1, ASSN_BDGT_AMT, 2, ASSN_1ST_AMT, 3, ASSN_2ND_AMT) = 0		;
	
			if	sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
		*/
			
	//	end if
	end if
	///////////////////////////////////////////////////////////

	
	if li_stat_class = ii_stat_class_2 then
		idw_mast.setitem(i, 'stat_class', 	ii_stat_class_1)
		idw_mast.setitem(i, 'confirm_amt', 	0)
		idw_mast.setitem(i, 'job_uid',		gs_empcode)
		idw_mast.setitem(i, 'job_add',		gs_ip)
		idw_mast.setitem(i, 'job_date',		f_sysdate())
	end if
next

is_process	=	'D'

return	0

end function

on w_hac702b.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_31=create st_31
this.uo_1=create uo_1
this.gb_3=create gb_3
this.dw_list002=create dw_list002
this.dw_list003=create dw_list003
this.pb_process=create pb_process
this.pb_delete=create pb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_31
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.dw_list002
this.Control[iCurrent+6]=this.dw_list003
this.Control[iCurrent+7]=this.pb_process
this.Control[iCurrent+8]=this.pb_delete
end on

on w_hac702b.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_31)
destroy(this.uo_1)
destroy(this.gb_3)
destroy(this.dw_list002)
destroy(this.dw_list003)
destroy(this.pb_process)
destroy(this.pb_delete)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
wf_setMsg('조회중')

wf_retrieve()

wf_setMsg('')
//f_setpointer('END')
return 1
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_mast			=	dw_list002
//idw_data			=	dw_list003
//idw_mgr_dept	=	dw_con
//
////is_bdgt_year	=	uo_bdgt_year.uf_getyy()
//is_main_dept	=	gs_deptcode
////is_mgr_dept		=	'%'
//
//
//dw_con.object.pay_date[1]	=	date(string(f_today(), '@@@@/@@/@@'))
//dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
//dw_con.object.code[1] = '%'
//
//wf_getchild()
//
//uo_1.uf_reset(idw_mast,	'acct_code', 'acct_name')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                       //
/////////////////////////////////////////////////////////////

integer	li_rtn
String ls_bdgt_year, ls_pay_Date, ls_mgr_dept
Integer 	li_bdgt_class

dw_con.accepttext()

ls_bdgt_year = String(dw_con.object.year[1], 'yyyy')
ls_mgr_dept = dw_con.object.code[1]
ls_pay_date =  String(dw_con.object.pay_date[1], 'yyyymmdd')
li_bdgt_class = Integer(dw_con.object.bdgt_class[1])

if idw_mast.modifiedcount() < 1 and idw_mast.deletedcount() < 1 then	return -1

//f_setpointer('START')
wf_setMsg('저장중')

if is_process	=	'C'	then
	li_rtn = f_messagebox('2', string(li_bdgt_class) + '차 예산편성을 최종 확정합니다.~n확정 후 ' + string(ls_pay_date, '@@@@년 @@월 @@일') + '자로 예산이 배정됩니다.~n~n저장 하시겠습니까?')
else	
	li_rtn = f_messagebox('2', string(li_bdgt_class) + '차 예산편성확정을 취소합니다.~n확정취소 후 예산 배정 자료도 삭제됩니다.~n~n저장 하시겠습니까?')
end if

if li_rtn = 1 then
	if idw_mast.update() = 1 then
		
		if is_process = 'C' then
			// 배정예산 생성
			li_rtn = wf_create()
		else
			// 배정예산 Update
			update	acdb.hac012m
			set		assn_1st_amt	=	decode(:li_bdgt_class, 1, 0,	assn_1st_amt),
						assn_2nd_amt	=	decode(:li_bdgt_class, 2, 0,	assn_2nd_amt),
						assn_3rd_amt	=	decode(:li_bdgt_class, 3, 0,	assn_3rd_amt),
						assn_1st_date	=	decode(:li_bdgt_class, 1, '',	assn_1st_date),
						assn_2nd_date	=	decode(:li_bdgt_class, 2, '',	assn_2nd_date),
						assn_3rd_date	=	decode(:li_bdgt_class, 3, '',	assn_3rd_date),
						job_uid			=	:gs_empcode,
						job_add			=	:gs_ip,
						job_date			=	sysdate
			where		bdgt_year		=		:ls_bdgt_year
			and		gwa				like	:ls_mgr_dept||'%'
			and		acct_class		=		:gi_acct_class	;
			
			if sqlca.sqlcode <> 0 then
				f_messagebox('3', sqlca.sqlerrtext)
				rollback	;
				wf_setMsg('')

				return	-1			
			end if
			
			// 배정예산 Update : 예산전용 금액 더하기 추가(2007.06.04)
			update	acdb.hac012m
			set		assn_used_amt	=		nvl(assn_bdgt_amt,0) + nvl(assn_tran_amt,0) + 
													nvl(assn_1st_amt,0) + nvl(assn_2nd_amt,0) + nvl(assn_3rd_amt,0)
			where		bdgt_year		=		:ls_bdgt_year
			and		gwa				like	:ls_mgr_dept||'%'
			and		acct_class		=		:gi_acct_class	;
			
			if sqlca.sqlcode <> 0 then
				f_messagebox('3', sqlca.sqlerrtext)
				rollback	;
				wf_setMsg('')

				return -1			
			end if			
			
			// 본예산 금액이 있을경우 삭제하지 않음.(2004.02.03 : Jung Kwang Hoon)
			delete	from	acdb.hac012m
			where		bdgt_year		=		:ls_bdgt_year
			and		gwa				like	:ls_mgr_dept||'%'	
			and		acct_class		=		:gi_acct_class
			and		assn_used_amt	=		0	
			and		assn_temp_amt	=		0
			and		assn_real_amt	=		0	
			and 		assn_bdgt_amt 	= 		0 
			and 		decode(:li_bdgt_class, 2, assn_1st_amt, 3, assn_1st_amt, 0)	=	0
			and 		decode(:li_bdgt_class, 3, assn_2nd_amt, 0)						=	0 ;
			
			li_rtn	=	sqlca.sqlcode
		end if
		
		if li_rtn = 0 then
			commit	;
		elseif li_rtn < 0 then
			f_messagebox('3', sqlca.sqlerrtext)
			rollback	;
		end if
		
	else
		ROLLBACK;
	end if
end if

wf_setMsg('')
//f_setpointer('END')

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_mast			=	dw_list002
idw_data			=	dw_list003
idw_mgr_dept	=	dw_con

//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
is_main_dept	=	gs_deptcode
//is_mgr_dept		=	'%'


dw_con.object.pay_date[1]	=	date(string(f_today(), '@@@@/@@/@@'))
dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
dw_con.object.code[1] = '%'

wf_getchild()

uo_1.uf_reset(idw_mast,	'acct_code', 'acct_name')

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_templeft.beginx

If pb_process.Enabled Then
	 pb_process.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + pb_process.Width + 16
Else
	 pb_process.Visible	= FALSE
End If

If pb_delete.Enabled Then
	 pb_delete.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + pb_delete.Width + 16
Else
	 pb_delete.Visible	= FALSE
End If
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hac702b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac702b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac702b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac702b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac702b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac702b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac702b
end type

type uc_insert from w_tabsheet`uc_insert within w_hac702b
end type

type uc_delete from w_tabsheet`uc_delete within w_hac702b
end type

type uc_save from w_tabsheet`uc_save within w_hac702b
end type

type uc_excel from w_tabsheet`uc_excel within w_hac702b
end type

type uc_print from w_tabsheet`uc_print within w_hac702b
end type

type st_line1 from w_tabsheet`st_line1 within w_hac702b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac702b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac702b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac702b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac702b
integer beginy = 368
integer endy = 368
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac702b
boolean visible = false
integer y = 1916
integer width = 3881
integer height = 604
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

event tab_sheet::selectionchanged;call super::selectionchanged;wf_button_control()
end event

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 3845
integer height = 484
long backcolor = 1073741824
string text = "주관부서접수처리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 3845
integer height = 988
string dataobject = "d_hac211a_1"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer width = 3840
end type

type uo_tab from w_tabsheet`uo_tab within w_hac702b
integer x = 1609
integer y = 1920
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac702b
integer height = 204
string dataobject = "d_hac702b_con"
end type

event dw_con::constructor;call super::constructor;st_31.setposition(totop!)
st_2.setposition(totop!)
end event

type st_con from w_tabsheet`st_con within w_hac702b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_2 from statictext within w_hac702b
integer x = 2601
integer y = 280
integer width = 1550
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 저장시에 배정예산이 생성됩니다. 일자를 확인해주세요."
boolean focusrectangle = false
end type

type st_31 from statictext within w_hac702b
integer x = 2601
integer y = 188
integer width = 1289
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 확정처리,확정취소를 하면 동시에 저장이 됩니다."
boolean focusrectangle = false
end type

type uo_1 from cuo_search within w_hac702b
event destroy ( )
integer x = 201
integer y = 428
integer width = 3575
integer taborder = 60
end type

on uo_1.destroy
call cuo_search::destroy
end on

type gb_3 from groupbox within w_hac702b
integer x = 55
integer y = 360
integer width = 4379
integer height = 200
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type dw_list002 from uo_dwgrid within w_hac702b
integer x = 50
integer y = 568
integer width = 4375
integer height = 968
integer taborder = 50
string dataobject = "d_hac702b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;if dwo.name = 'stat_class' then
	if integer(data) = 23 and getitemnumber(row, 'adjust_amt') = 0 then
		setitem(row, 'adjust_amt', getitemnumber(row, 'req_amt'))
	else
		setitem(row, 'adjust_amt', 0)
	end if
end if

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())
end event

event losefocus;call super::losefocus;accepttext()
end event

event retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(1)

end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then
	idw_data.reset()
	return
end if

il_currentrow = currentrow

//selectrow(0, false)
//selectrow(currentrow, true)

wf_retrieve_2()


end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_list003 from uo_dwgrid within w_hac702b
integer x = 50
integer y = 1540
integer width = 4375
integer height = 732
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hac702b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type pb_process from uo_imgbtn within w_hac702b
integer x = 155
integer y = 36
integer taborder = 40
boolean bringtotop = true
string btnname = "확정처리"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('부서확정 처리중')
setpointer(hourglass!)

wf_process()
parent.triggerevent('ue_save')

setpointer(arrow!)
wf_setMsg('')


end event

on pb_process.destroy
call uo_imgbtn::destroy
end on

type pb_delete from uo_imgbtn within w_hac702b
integer x = 530
integer y = 36
integer taborder = 50
boolean bringtotop = true
string btnname = "확정취소"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////
integer	li_rtn


wf_setMsg('부서확정취소 처리중')
setpointer(hourglass!)

li_rtn = wf_delete()

if li_rtn <> 100 and li_rtn <> 0 then
	f_messagebox('3', '부서확정취소 처리중 에러가 발생하였습니다.~r~n전산시스템운영팀으로 문의바랍니다.')
	rollback	;
	wf_setMsg('')

	return				
end if

parent.triggerevent('ue_save')

setpointer(arrow!)
wf_setMsg('')


end event

on pb_delete.destroy
call uo_imgbtn::destroy
end on

