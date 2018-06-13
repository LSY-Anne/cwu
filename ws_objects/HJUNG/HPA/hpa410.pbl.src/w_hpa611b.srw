$PBExportHeader$w_hpa611b.srw
$PBExportComments$연말정산 지급조서 자료 생성
forward
global type w_hpa611b from w_tabsheet
end type
type em_date1 from editmask within w_hpa611b
end type
type st_1 from statictext within w_hpa611b
end type
type st_2 from statictext within w_hpa611b
end type
type em_date2 from editmask within w_hpa611b
end type
type uo_year from cuo_year within w_hpa611b
end type
type st_21 from statictext within w_hpa611b
end type
type sle_filename from singlelineedit within w_hpa611b
end type
type pb_fileupload from picturebutton within w_hpa611b
end type
type st_message from statictext within w_hpa611b
end type
type st_status from statictext within w_hpa611b
end type
type hpb_1 from hprogressbar within w_hpa611b
end type
type dw_list from dw_list001 within w_hpa611b
end type
type st_3 from statictext within w_hpa611b
end type
type st_4 from statictext within w_hpa611b
end type
type st_5 from statictext within w_hpa611b
end type
type dw_print from datawindow within w_hpa611b
end type
type gb_1 from groupbox within w_hpa611b
end type
type gb_2 from groupbox within w_hpa611b
end type
type gb_4 from groupbox within w_hpa611b
end type
end forward

global type w_hpa611b from w_tabsheet
string title = "연말정산 지급조서 자료 생성"
long backcolor = 134217750
em_date1 em_date1
st_1 st_1
st_2 st_2
em_date2 em_date2
uo_year uo_year
st_21 st_21
sle_filename sle_filename
pb_fileupload pb_fileupload
st_message st_message
st_status st_status
hpb_1 hpb_1
dw_list dw_list
st_3 st_3
st_4 st_4
st_5 st_5
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
end type
global w_hpa611b w_hpa611b

type prototypes
FUNCTION ulong GetCurrentDirectoryA(ulong BufferLen, ref string currentdir) LIBRARY "kernel32.dll" Alias For "GetCurrentDirectoryA;Ansi"

end prototypes

type variables
datawindowchild	idw_child
datawindow			idw_preview, idw_data

statictext			ist_back

string		is_year						// 지급년도
string		is_date1, is_date2		// 제출년월일, 영수(지급)년월일


string		is_yearmonth


end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
public function integer wf_filedownload ()
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

// 납부구분
idw_data.getchild('pay_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('pay_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('pay_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('pay_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('pay_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('pay_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
end subroutine

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

dw_print.retrieve(is_year, gs_empname, is_date1)

return	0
end function

public function integer wf_filedownload ();// ==========================================================================================
// 기    능 : 	file download
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_filedownload()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// Upload File Open
Integer	li_Rtn
String	ls_FullName
String	ls_FileName
String	ls_message

long		ll_rowcount, ll_row, ll_cnt, ll_cnt2, ll_cnt4
string	ls_report
string	ls_business_no, ls_campus_name, ls_president, ls_corp_no, ls_tel_phone, ls_tax_office_code, ls_fname

string	ls_member_no, ls_first_date, ls_retire_date, ls_kname, ls_jumin_no
long		ll_bef_count 
dec{0}	ldb_year_pay_amt, ldb_year_nontax_amt, ldb_year_bonus_amt, ldb_chagam_amt, ldb_foreign_amt, ldb_non_etc_amt, ldb_pay_total
dec{0}	ldb_special_amt, ldb_standard_amt, ldb_income_tax_amt, ldb_basic_amt, ldb_add_amt, ldb_add_detuct_amt, ldb_insure_pension_amt

string	ls_work_place, ls_register_no, ls_gam_term, ls_live_home_cd, ls_fund_amt_cd,ls_income_cd
dec{0}	ldb_bef_pay_total, ldb_bef_bonus_total, ldb_prepay_pay, ldb_prepay_bon, ldb_prepay
dec{0}	ldb_bef_income_amt, ldb_bef_jumin_amt, ldb_bef_farm_amt, ldb_bef_tot_tax, ldb_variable
dec{0}	ldb_pension_indi_amt, ldb_pension_SAVE_amt, ldb_invest_income_amt, ldb_card_amt, ldb_FUND_AMT,ldb_income_total
dec{0}	ldb_janggijusik_amt, ldb_house_long_amt

string	ls_support_name, ls_support_jumin_no, ls_foreigner_gbn, ls_gwangae_code, ls_basic_opt			
string	ls_handicap_opt, ls_child_opt, ls_insure_opt, ls_medical_opt, ls_education_opt, ls_card_opt
string	ls_woman_opt, ls_old_opt, ls_add_child_opt, ls_birth_opt
long		ll_cnt3, ll_support_count, ll_string

datastore	lds_data
datastore	lds_bef
datastore	lds_support
st_status.text = '생성 준비중입니다...'

// 생성할 자료 Retrieve
lds_data	=	create	datastore
lds_data.dataobject	=	'd_hpa611b_1'
lds_data.settransobject(sqlca)

// 생성할 자료 Retrieve(종전근무지)
lds_bef	=	create	datastore
lds_bef.dataobject	=	'd_hpa611b_2'
lds_bef.settransobject(sqlca)

// 생성할 자료 Retrieve(부양가족공제자)
lds_support	=	create	datastore
lds_support.dataobject	=	'd_hpa611b_5'
lds_support.settransobject(sqlca)

ll_rowcount = lds_data.retrieve(is_year)

if ll_rowcount < 1 then	
	f_messagebox('1', '생성할 자료가 존재하지 않습니다.!')
	return	100
end if

// A Record(제출자 레코드)
select	nvl(business_no, ' '), nvl(campus_name, ' '), nvl(president, ' '), nvl(corp_no, ' '), 
			nvl(tel_phone, ' '), nvl(tax_office_code, '   ')
into		:ls_business_no, :ls_campus_name, :ls_president, :ls_corp_no, :ls_tel_phone, :ls_tax_office_code
from		CDDB.KCH000M
where		campus_code	=	(	select	min(campus_code)
									from		CDDB.KCH000M	)	;
									
select fname 
into :ls_fname
from cddb.kch003m
where gwa= '1301'	;								

if sqlca.sqlcode <> 0 then
	f_messagebox('1', '캠퍼스 자료가 존재하지 않습니다.~n~n캠퍼스 관리에서 확인하시기 바랍니다.!')
	return	100
end if

if trim(ls_tax_office_code) = '' then
	f_messagebox('1', '세무서 코드가 존재하지 않습니다.~n~n캠퍼스 관리에서 확인하시기 바랍니다.!')
	return	100
end if

if trim(ls_business_no) = '' then
	f_messagebox('1', '사업자등록번호가 존재하지 않습니다.~n~n캠퍼스 관리에서 확인하시기 바랍니다.!')
	return	100
end if

ls_business_no			=	trim(ls_business_no)
ls_campus_name			=	trim(ls_campus_name)
ls_president			=	trim(ls_president)
ls_corp_no				=	trim(ls_corp_no)
ls_tel_phone			=	trim(ls_tel_phone)
ls_tax_office_code	=	trim(ls_tax_office_code)
ls_fname					=	trim(ls_fname)

ls_filename	=	'C' + left(ls_business_no, 7) + '.' + right(ls_business_no, 3)

//MSDN--> DWORD GetCurrentDirectory(DWORD nBufferLength, LPTSTR lpBuffer);
//FUNCTION ulong GetCurrentDirectoryA(ulong BufferLen, ref string currentdir) LIBRARY "kernel32.dll"
string	ls_dir
ulong		lul_buf

lul_buf 	= 100
ls_dir 	= space(100)
GetCurrentDirectoryA(lul_buf, ls_dir)

ls_dir = ls_dir + '\'
ls_fullname	=	ls_dir + ls_filename

if trim(sle_filename.text) = '' then
	sle_filename.text	=	ls_fullname
elseif right(trim(sle_filename.text), 12) <> ls_filename then
	f_messagebox('3', '생성 화일명이 정확하지 않습니다.!')
	sle_filename.text	=	ls_fullname
end if	
ls_fullname	=	trim(sle_filename.text)

// 화일 존재여부 체크
if FileExists(ls_fullname) then
	if f_messagebox('2', ls_fullname + '~n화일이 존재합니다.~n~n삭제 후 다시 생성하시겠습니까?') = 2 then	
		return 100
	else
		if FileDelete(ls_fullname) = false	then
			f_messagebox('3', ls_fullname + '~n화일을 삭제할 수 없습니다.~n~n확인 후 다시 실행해주시기 바랍니다.!')
			return	100
		end if
	end if
end if

idw_preview.reset()

// Process Bar Setting
hpb_1.setrange(1, ll_rowcount + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0

// A Record(제출자 레코드) Insert
ll_row = idw_preview.insertrow(0)
idw_preview.scrolltorow(ll_row)

ls_report	=	'A' + '20' + ls_tax_office_code + is_date1 + '2' + space(6)	+	&
					'cwu3120' + space(20 - len(trim('cwu3120'))) + '9000' +	&
					ls_business_no	+	&
					trim(ls_campus_name) + space(40 - len(trim(ls_campus_name)))	+	&
					trim(ls_fname) + space(30 - len(trim(ls_fname)))	+	&
					'박현정' + space(30 - len(trim('박현정')))	+	&
					trim(ls_tel_phone) + space(15 - len(trim(ls_tel_phone))) +	&
					string(1, '00000') + '101' + '1' + space(641)

idw_preview.setitem(ll_row, 'report', ls_report)

// B Record(원천징수의무자별 집계 레코드)
ll_bef_count = lds_bef.retrieve(is_year,ls_member_no)

ll_row = idw_preview.insertrow(0)
idw_preview.scrolltorow(ll_row)

ls_report	=	'B' + '20' + ls_tax_office_code + string(1, '000000') +	&
					ls_business_no	+	&
					ls_campus_name + space(40 - len(ls_campus_name)) 		+	&
					ls_president + space(30 - len(ls_president)) 			+	&
					left(ls_corp_no, 13)	+	space(13 - len(ls_corp_no))	+	&
					string(ll_rowcount, 	'0000000')	+	&
					string(ll_bef_count, '0000000')	+	&
					string(lds_data.getitemnumber(1, 'total_sum'), 	fill('0', 14))	+	&
					string(lds_data.getitemnumber(1, 'decision_income_tax_sum'), 		fill('0', 13))	+	&
					fill('0', 13)	+	&
					string(lds_data.getitemnumber(1, 'decision_jumin_tax_sum'), 		fill('0', 13))	+	&
					string(lds_data.getitemnumber(1, 'decision_farm_tax_sum'), 			fill('0', 13))	+	&
					string(lds_data.getitemnumber(1, 'decision_tax_sum'), 				fill('0', 13))	+	&
					space(622)


idw_preview.setitem(ll_row, 'report', ls_report)

// C Record(주(현)근무처 레코드)						
for ll_cnt = 1 to ll_rowcount
	ll_row = idw_preview.insertrow(0)
	idw_preview.scrolltorow(ll_row)
	ldb_prepay	 =	0	
	ls_member_no = trim(lds_data.getitemstring(ll_cnt, 'member_no'))
	ll_bef_count = lds_bef.retrieve(is_year, ls_member_no)

	if isnull(lds_data.getitemstring(ll_cnt, 'firsthire_date')) or trim(lds_data.getitemstring(ll_cnt, 'firsthire_date')) = '' or left(lds_data.getitemstring(ll_cnt, 'firsthire_date'), 4) < is_year then
		ls_first_date	=	is_year + '0101'
	else
		ls_first_date	=	lds_data.getitemstring(ll_cnt, 'firsthire_date')
	end if
	if isnull(lds_data.getitemstring(ll_cnt, 'retire_date')) or trim(lds_data.getitemstring(ll_cnt, 'retire_date')) = '' or left(lds_data.getitemstring(ll_cnt, 'retire_date'), 4) > is_year then
		ls_retire_date	=	is_year + '1231'
	else
		ls_retire_date	=	lds_data.getitemstring(ll_cnt, 'retire_date')
	end if
	ls_kname		=	trim(lds_data.getitemstring(ll_cnt, 'name'))
	ls_jumin_no	=	trim(lds_data.getitemstring(ll_cnt, 'jumin_no'))
	ls_gam_term  =	TRIM(lds_data.getitemstring(ll_cnt, 'MINUS_TERM'))						// 감면기간 
	if isnull(ls_gam_term) or ls_gam_term = '' then ls_gam_term = '0000000000000000'

	if len(ls_jumin_no) < 13 then	ls_jumin_no	=	ls_jumin_no + fill('0', 13 - len(ls_jumin_no))
	
	ldb_year_pay_amt			=	lds_data.getitemnumber(ll_cnt, 'pay_tot')				// 급여총액
	ldb_year_nontax_amt		=	lds_data.getitemnumber(ll_cnt, 'non_tax_tot')		// 비과세총액
	ldb_foreign_amt			=	lds_data.getitemnumber(ll_cnt, 'non_foreign_amt')	// 비과세 국외근로
	ldb_non_etc_amt			=	lds_data.getitemnumber(ll_cnt, 'non_etc_amt')		// 기타비과세
	ldb_year_bonus_amt		=	lds_data.getitemnumber(ll_cnt, 'bon_tot')				// 상여총액
	ldb_prepay_pay				=	lds_data.getitemnumber(ll_cnt, 'prepay')				// 전근무급여
	ldb_prepay_bon				=	lds_data.getitemnumber(ll_cnt, 'prebon')				// 전근무지상여
	ldb_prepay					=	ldb_prepay_pay	+	ldb_prepay_bon							//전근무지급여총계
	
	ldb_pay_total				=	lds_data.getitemnumber(ll_cnt, 'pay_total_amt')			// 급상여총액
	
	ldb_special_amt			=	lds_data.getitemnumber(ll_cnt, 'special_amt')			// 특별공제계
	ldb_standard_amt			=	lds_data.getitemnumber(ll_cnt, 'standard_amt')			// 표준공제
	if ldb_standard_amt > 0 then	ldb_special_amt = 0

	ldb_income_tax_amt		=	lds_data.getitemnumber(ll_cnt, 'income_tax_amt')		// 과세대상근로소득금액
	ldb_basic_amt				=	lds_data.getitemnumber(ll_cnt, 'basic_amt')				// 기본공제계
	ldb_add_amt					=	lds_data.getitemnumber(ll_cnt, 'add_amt')					// 추가공제계
	ldb_add_detuct_amt		=	lds_data.getitemnumber(ll_cnt, 'add_detuct_amt')		// 소수공제자추가공제
	ldb_insure_pension_amt	=	lds_data.getitemnumber(ll_cnt, 'insure_pension_amt')	// 연금보험료공제
	ldb_pension_indi_amt    =  lds_data.getitemnumber(ll_cnt, 'pension_indi_amt') 
	ldb_pension_SAVE_amt	   =  lds_data.getitemnumber(ll_cnt, 'pension_SAVE_amt') 
   ldb_invest_income_amt	=	lds_data.getitemnumber(ll_cnt, 'invest_income_amt') 
	ldb_card_amt				=	lds_data.getitemnumber(ll_cnt, 'card_amt')
	ldb_FUND_AMT				=	lds_data.getitemnumber(ll_cnt, 'FUND_AMT')
	ldb_house_long_amt		=	lds_data.getitemnumber(ll_cnt, 'house_long_amt')
	ldb_janggijusik_amt		=	lds_data.getitemnumber(ll_cnt, 'janggijusik_amt')
	
	ldb_income_total			= ldb_pension_indi_amt 	+ ldb_pension_SAVE_amt 					+ ldb_invest_income_amt + &
									  ldb_card_amt 			+ ldb_FUND_AMT +ldb_house_long_amt  + ldb_janggijusik_amt
	if	ldb_income_total	>=	0	then	ls_income_cd = '0' else ls_income_cd = '1'
	
	ls_live_home_cd			=	lds_data.getitemstring(ll_cnt, 'live_home_cd')			// 거주국코드
	if	len(ls_live_home_cd)	>	2	then	ls_live_home_cd = left(ls_live_home_cd,2)
	
	if	ldb_FUND_AMT	>=	0	then	ls_fund_amt_cd = '0' else ls_fund_amt_cd = '1'		// 우리사주조합
	
	ldb_bef_income_amt		=	lds_data.getitemnumber(ll_cnt, 'PREPAY_INCOME_TAX')
	ldb_bef_jumin_amt			=	lds_data.getitemnumber(ll_cnt, 'PREPAY_JUMIN_TAX')
	ldb_bef_farm_amt			=	lds_data.getitemnumber(ll_cnt, 'PREPAY_FARM_TAX')
	ldb_bef_tot_tax			=	lds_data.getitemnumber(ll_cnt, 'PREPAY_TAX')
	
	ls_report	=	'C' + '20' + ls_tax_office_code + string(ll_cnt, '000000')			//	[1]레코드구분(1)[,1], 자료구분(2)[,3], 세무서(3)[,6], 일련번호(4)[,12]
	ls_report	+=	ls_business_no																		// [1]사업자등록번호(10)[,22]
	//소득자(근로자)
	ls_report	+=	string(ll_bef_count, '00')														// [1]종(전)근무처수(2)[,24]
	ls_report	+=	lds_data.getitemstring(ll_cnt, 'live_gbn')								// [1]거주자구분코드(1)[,25]
	ls_report	+=	TRIM(lds_data.getitemstring(ll_cnt, 'LIVE_HOME_CD'))					// [1]거주지국가코드(2)[,27]
	ls_report	+=	'2'																					// [1]외국인단일세율적용(1)[,28]
	ls_report	+=	ls_first_date	+ fill('0', 8 - len(trim(ls_first_date)))				// [1]귀속연도시작연월일(8)[8,36]
	ls_report	+=	ls_retire_date	+ fill('0', 8 - len(trim(ls_retire_date)))			// [1]귀속연도종료연월일(8)[8,44]
	ls_report	+=	trim(ls_kname) + space(30 - len(trim(ls_kname)))						// [1]성명(30)[,74]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'foreigner_gbn'))				// [1]내외국인구분(1)[,75]
	ls_report	+=	trim(ls_jumin_no)	+ space(13 - len(trim(ls_jumin_no)))				// [1]주민등록번호(13)[,88]
	ls_report	+=	ls_gam_term 	+ fill('0', 16 - len(trim(ls_gam_term)))				// [1]감면기간(16)[,104]
	//근무처별 소득명세주(현)근무처 총급여
	ls_report	+=	string(ldb_year_pay_amt, 	fill('0', 11))									// [1]급여총액(11)(현근무지의급여, 비과세제외)[,115]
	ldb_variable	=	ldb_year_bonus_amt + ldb_prepay_bon
	ls_report	+=	string(ldb_year_bonus_amt, fill('0', 11))									// [1]상여총액(11)(현근무지의상여, 비과세제외)[,126]
	ls_report	+=	fill('0', 11)																		// [1]인정상여(11)[.137]
	ls_report	+= fill('0', 11)																		// [1]주(현)주식매수선택권 행사이익[148]
	ldb_variable	=	ldb_year_pay_amt + ldb_year_bonus_amt									
	ls_report	+=	string(ldb_variable, fill('0', 11)) 										// [1]계(11)(급여총액+상여총액+인정상여)[,159]
   //비과세 소득
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'NON_EXP_AMT'),fill('0', 10))//[1]연구활동비(10)[,169]
	ls_report	+=	fill('0', 10)																		// [1]국외근로소득(10)[,179]
	ls_report	+=	fill('0', 10)																		// [1]야간근로소당등(10)[,189]
	ls_report	+=	fill('0', 10)																		//[25]출산보육수당(10)[,199]
	ls_report	+=	string(ldb_foreign_amt, fill('0', 10))										//[26]외국인 근로자(10)[,209]
	ls_report	+=	string(ldb_non_etc_amt, fill('0', 10))		 								// [1]그밖의 기타비과세(10)[,219]
	ls_report	+=	string(ldb_year_nontax_amt, fill('0', 10))		 						// [1]비과세 계(10)[,229]
	//정산명세
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'pay_total_amt'), fill('0', 11))		 		// [29]총급여(11)(현근무지계 + 전근무지계)[,240]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'income_detuct_amt'), fill('0', 10))			// [30]근로소득공제(10)[,250]
	ls_report	+=	string(ldb_income_tax_amt, 	fill('0', 11))													// [1]과세대상근로소득금액(11)[,241]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'basic_self_amt'), fill('0', 8))				// [1]본인공제금액(8)[,267]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'basic_wife_amt'), fill('0', 8))				// [1]배우자공제금액(8)[,277]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'support_20_num') + &
								 lds_data.getitemnumber(ll_cnt, 'support_60_num'), fill('0', 2))				// [1]부양가족인원(2)[,279]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'basic_family_amt'), fill('0', 8))			//	[1]부양가족공제금액(8)(100만원*인원)[,287]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'old_num') + &
								 lds_data.getitemnumber(ll_cnt, 'support_70_num'), fill('0', 2))				// [1]경로우대공제인원(2)[,289]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'add_old_amt'), fill('0', 8))					// [1]경로우대공제금액(8)[,297]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'handicap_num'), fill('0', 2))					// [1]장애인공제인원[,299]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'add_handicap_amt'), fill('0', 8))			// [1]장애인공제금액[,307]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'add_woman_amt'), fill('0', 8))				// [1]부녀자공제금액[,315]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'child_num'), fill('0', 2))						// [1]자녀양육비공제인원[,317]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'add_child_amt'), fill('0', 8))				// [1]자녀양육비공제금액[,325]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'birth_num'), fill('0', 2))						// [1][,325]출산입양자공제인원
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'birth_amt'), fill('0', 8))						// [1][,325]출산입양자공제금액
	ls_report	+=	fill('0', 10)																							//공란(10)[,345]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'full_child_num'), fill('0', 2))				// [1]다자녀추가공제인원[307]
	ls_report	+=	string(ldb_add_detuct_amt, fill('0', 8))														// [1]다자녀추가금액[,292]
	ls_report	+=	fill('0', 10)																							// [1]국민연금보험료
	ls_report	+=	string(ldb_insure_pension_amt, fill('0', 10))												//기타연금보혐료공제
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'retire_pension_amt'),fill('0', 10))			// [1]퇴직연금소득공제[,450]
	//[특별공제]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'special_insure_amt'), fill('0', 10))		// [1]보험료공제금액[,310]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'special_medical_amt'), fill('0', 10))		// [1]의료비공제금액[,320]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'special_education_amt'), fill('0', 8))		// [1]교육비공제금액[,328]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'house_wolligeum_amt'), fill('0', 8))		//주택임대차차입금원리금상환공제금액
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'house_iya_amt'), fill('0', 8))				//장기주택정당차입금이자상환공제금액
	//ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'special_house_amt'), fill('0', 8))			// [1]주택자금공제금액[,336]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'special_contribute_amt'), fill('0', 10))	// [1]기부금공제금액[,346]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'weding_move_fun_amt'), fill('0', 10))		// [1]혼인,이사,장례금액[,356]
	ls_report	+=	fill('0', 10)																							//공란[1][,366]
	ls_report	+=	string(ldb_special_amt, fill('0', 10))															// [1]특별공제계[,376]
	ls_report	+=	string(ldb_standard_amt, fill('0', 8))															// [1]표준공제[,384]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'minus_income_amt'), fill('0', 11))			// [1]차감소득공제[,394]
	//[그밖의 소득공제]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'pension_indi_amt'),	fill('0', 8))			// [1]개인연금저축소득공제[,403]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'pension_SAVE_amt'),	fill('0', 8))			// [1]연금저축소득공제[,411]
	ls_report	+=	fill('0', 10)																							// [1]소기업공제부금소득공제
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'house_long_amt'), fill('0', 10))				//주택마련저축소득공제
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'invest_income_amt'),	fill('0', 10))			// [1]투자조합출자등소득공제[,421]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'card_amt'),	fill('0', 8))						// [1]신용카드사용소득공제[,429]
	ls_report	+=	ls_fund_amt_cd																							// [1]우리사주출자금구분 양수:0 음수;1[,430]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'FUND_AMT'),fill('0', 10))						// [1]우리사주출자금[,440]
	
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'janggijusik_amt'),fill('0', 10))				// [1][,440]//장기주식형저축소득공제
	
	ls_report	+=	ls_income_cd																							// [1]기타소득공제계 = 양수:0 , 음수;1[,451]
	ls_report	+= string(ldb_income_total, fill('0', 10))														// [1]기타소득공제계[,461]																									//조특소득공제계[458]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'TOTAL_INCOME_STD'),	fill('0', 11))			// [1]종합소득과세표준[,472]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'product_tax'),	fill('0', 10))					// [1]산출세액[,482]
	//[세액감면]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'exception_law_amt'),	fill('0', 10))			// [1]세액감면소득세법[,492]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'INCOME_LAW_AMT'),	fill('0', 10))				// [1]세액감면조특법[,502]
	ls_report	+=	fill('0', 10)																							//[1]공란[,512]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'LAW_AMT'),	fill('0', 10))						// [1]감면세액계[,522]
	//[세액공제]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'LABOR_income_tax'),	fill('0', 8))			// [1]근로소득세액공제[,530]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'UNION_TAX'),	fill('0', 8))					// [1]납세조합공제[,538]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'HOUSE_LOAN_TAX'),	fill('0', 8))				// [1]주택차입금[,546]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'political_funds_amt'),	fill('0', 10))		// [1]기부정치자금[,556]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'FOREIGN_TAX'),	fill('0', 8))					// [1]외국납부[,564]
	ls_report	+=	fill('0', 8)																							//[1]공란[,572]
	//ls_report	+=	fill('0', 8)																							//[1][,580]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'TAX_TAX'),	fill('0', 8))						//[1] 세액공제계[,588]
	//[결정세액]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'DECISION_INCOME_TAX'),	fill('0', 10))		// [1]소득세[,598]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'DECISION_JUMIN_TAX'),	fill('0', 10))		// [1]주민세[,608]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'DECISION_FARM_TAX'),	fill('0', 10))			// [1]농특세[,618]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'DECISION_TAX'),	fill('0', 10))				// [1]결정세액 계[,628]
	//[종(전)근무지]
	ls_report	+=	string(ldb_bef_income_amt,	fill('0', 10))														// [1]전근무지 소득세[,638]
	ls_report	+=	string(ldb_bef_jumin_amt,	fill('0', 10))														// [1]전근무지 주민세[,648]
	ls_report	+=	string(ldb_bef_farm_amt,	fill('0', 10))														// [1]전근무지 농특세[,658]
	ls_report	+=	string(ldb_bef_tot_tax,		fill('0', 10))														// [1]전근무지 계[,668]
	//[주(현)근무지]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'tax_amt'),	fill('0', 10))						// [1]현근무지 소득세[,678]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'jumin_amt'),fill('0', 10))						// [1]현근무지 주민세[,688]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'farm_amt'),	fill('0', 10))						// [1]현근무지 농특세[,698]
	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'tax_tot'),	fill('0', 10))						// [1]현근무지 계[,708]
// 2007.01.14
//	ls_report	+=	string(lds_data.getitemnumber(ll_cnt, 'cash_used_amt'),	fill('0', 11))				// 현금영수즌사용액[,719]2007.01.14
	ls_report	+=	space(7)																									//[1][,730]

	idw_preview.setitem(ll_row, 'report', ls_report)
	
	FOR ll_cnt2 = 1 to ll_bef_count
		 ll_row = idw_preview.insertrow(0)
		 idw_preview.scrolltorow(ll_row)
	
		 ls_work_place			=	trim(lds_bef.getitemstring(ll_cnt2, 'work_place'))
		 ls_register_no		=	trim(lds_bef.getitemstring(ll_cnt2, 'register_no'))
		 ldb_bef_pay_total	=	lds_bef.getitemnumber(ll_cnt2, 'pay_total')							//비과세를 제외한 금액임
		 ldb_bef_bonus_total	=	lds_bef.getitemnumber(ll_cnt2, 'bonus_total')
		 
		 ls_report	=	'D' + '20' + ls_tax_office_code + string(ll_cnt, '000000')	+	&
							ls_business_no	+	space(50)	+	&
							ls_jumin_no		+	&
							ls_work_place 	+ space(40 - len(ls_work_place)) 	+	&
							ls_register_no + space(10 - len(ls_register_no)) 	+	&
							string(ldb_bef_pay_total, fill('0', 11))		+	&
							string(ldb_bef_bonus_total, fill('0', 11))	+	&
							fill('0', 11)	+	fill('0', 11) + &
							string(ldb_bef_pay_total 		+ ldb_bef_bonus_total, fill('0', 11))	+	&
							string(ll_cnt2, '00')			+ space(628)
							
		idw_preview.setitem(ll_row, 'report', ls_report)
	NEXT

	
	ll_support_count = lds_support.retrieve(is_year, ls_member_no)

	ls_report   = ''


	integer li_support_seq

	li_support_seq = 1
	
	FOR ll_cnt3 = 1 TO ll_support_count
	
			string ls_insure_amt, ls_medical_amt,ls_education_amt,ls_card_amt,ls_cash_amt
			string ls_a_insure_amt, ls_a_medical_amt, ls_a_education_amt, ls_a_card_amt,ls_a_gibo_amt
			dec{0} ldb_insure_amt, ldb_medical_amt, ldb_education_amt, ldb_cards_amt, ldb_cash_amt
			dec{0} ldb_a_insure_amt, ldb_a_medical_amt, ldb_a_education_amt, ldb_a_card_amt, ldb_a_gibo_amt
			
			ls_support_name		=	trim(lds_support.getitemstring(ll_cnt3, 'name'))
			ls_support_jumin_no	=	trim(lds_support.getitemstring(ll_cnt3, 'jumin_no'))
			if len(ls_support_jumin_no) < 13 then	ls_support_jumin_no	=	ls_support_jumin_no + fill('0', 13 - len(ls_support_jumin_no))
			
			ls_foreigner_gbn		=	string(lds_support.getitemnumber(ll_cnt3, 'foreigner_gbn'))
			ls_gwangae_code		=	string(lds_support.getitemnumber(ll_cnt3, 'gwangae_code'))
			
			ls_basic_opt			=	string(lds_support.getitemnumber(ll_cnt3, 'basic_opt'))
			ls_handicap_opt		=	string(lds_support.getitemnumber(ll_cnt3, 'handicap_opt'))
			ls_child_opt			=	string(lds_support.getitemnumber(ll_cnt3, 'child_opt'))
			ls_insure_opt			=	string(lds_support.getitemnumber(ll_cnt3, 'insure_opt'))
			ls_medical_opt			=	string(lds_support.getitemnumber(ll_cnt3, 'medical_opt'))
			ls_education_opt		=	string(lds_support.getitemnumber(ll_cnt3, 'education_opt'))
			ls_card_opt				=	string(lds_support.getitemnumber(ll_cnt3, 'card_opt'))
			ls_woman_opt			=	string(lds_support.getitemnumber(ll_cnt3, 'woman_opt'))
			ls_old_opt				=	string(lds_support.getitemnumber(ll_cnt3, 'old_opt'))
			ls_add_child_opt		=	string(lds_support.getitemnumber(ll_cnt3, 'add_child_opt'))
			ls_birth_opt			=	string(lds_support.getitemnumber(ll_cnt3, 'birth_opt'))
			
			if isnull(ls_basic_opt) 		or ls_basic_opt 		= '0' 	then ls_basic_opt 		= space(1)
			if isnull(ls_handicap_opt) 	or ls_handicap_opt 	= '0' 	then ls_handicap_opt 	= space(1)
			if isnull(ls_child_opt) 		or ls_child_opt 		= '0' 	then ls_child_opt 		= space(1)
			if isnull(ls_insure_opt) 		or ls_insure_opt 		= '0' 	then ls_insure_opt 		= space(1)
			if isnull(ls_medical_opt) 		or ls_medical_opt 	= '0' 	then ls_medical_opt		= space(1)
			if isnull(ls_education_opt) 	or ls_education_opt 	= '0' 	then ls_education_opt 	= space(1)
			if isnull(ls_card_opt) 		 	or ls_card_opt 		= '0' 	then ls_card_opt 			= space(1)
			if isnull(ls_woman_opt) 		or ls_woman_opt 		= '0' 	then ls_woman_opt 		= space(1)
			if isnull(ls_old_opt) 		 	or ls_old_opt 		   = '0' 	then ls_old_opt 			= space(1)
			if isnull(ls_add_child_opt) 	or ls_add_child_opt 	= '0' 	then ls_add_child_opt 	= space(1)
			if isnull(ls_birth_opt) 		or ls_birth_opt 		= '0' 	then ls_birth_opt 		= space(1)
			
			ldb_insure_amt 		=	lds_support.getitemnumber(ll_cnt3, 'insure_amt')
			ldb_medical_amt 		=	lds_support.getitemnumber(ll_cnt3, 'medical_amt')
			ldb_education_amt 	=	lds_support.getitemnumber(ll_cnt3, 'education_amt')
			ldb_cards_amt 			=	lds_support.getitemnumber(ll_cnt3, 'card_amt')
			ldb_cash_amt 			=	lds_support.getitemnumber(ll_cnt3, 'cash_amt')
			ldb_a_insure_amt 		=	lds_support.getitemnumber(ll_cnt3, 'a_insure_amt')
			ldb_a_medical_amt 	=	lds_support.getitemnumber(ll_cnt3, 'a_medical_amt')
			ldb_a_education_amt 	=	lds_support.getitemnumber(ll_cnt3, 'a_education_amt')
			ldb_a_card_amt 		=	lds_support.getitemnumber(ll_cnt3, 'a_card_amt')
			ldb_a_gibo_amt 		=	lds_support.getitemnumber(ll_cnt3, 'a_gibo_amt')
			if isnull(ldb_insure_amt) 		or ls_add_child_opt 	= '' 	then ldb_insure_amt 		= 0
			if isnull(ldb_medical_amt) 	or ls_add_child_opt 	= '' 	then ldb_medical_amt 	= 0
			if isnull(ldb_education_amt) 	or ls_add_child_opt 	= '' 	then ldb_education_amt 	= 0
			if isnull(ldb_cards_amt) 		or ls_add_child_opt 	= '' 	then ldb_cards_amt 		= 0
			if isnull(ldb_cash_amt) 		or ls_add_child_opt 	= '' 	then ldb_cash_amt 		= 0
			if isnull(ldb_a_insure_amt) 	or ls_add_child_opt 	= '' 	then ldb_a_insure_amt 	= 0
			if isnull(ldb_a_medical_amt) 	or ls_add_child_opt 	= '' 	then ldb_a_medical_amt 	= 0
			if isnull(ldb_a_education_amt) 	or ls_add_child_opt 	= '' 	then ldb_a_education_amt 	= 0
			if isnull(ldb_a_card_amt) 		or ls_add_child_opt 	= '' 	then ldb_a_card_amt 		= 0
			if isnull(ldb_a_gibo_amt) 		or ls_add_child_opt 	= '' 	then ldb_a_gibo_amt 		= 0
			
			//부양자 가족 지급조서 생성
			IF mod(ll_cnt3,5) = 1 THEN
				ls_report	=	'E' 																							//	레코드구분(1)[,1] 
				ls_report	+= '20' 																							// 자료구분(2)[,3],
				ls_report	+= ls_tax_office_code 																		// 세무서(3)[,6],
				ls_report	+= string(ll_cnt, '000000')																// 일련번호(6)[,12]
				//원청징수의무자
				ls_report	+=	ls_business_no																				// 사업자등록번호(10)[,22]
				ls_report	+= ls_jumin_no																					//소득자 주민번호[,35]
		   END IF
			//소득공제자 부양가족 공제자 명세			
				ls_report	+=	trim(ls_gwangae_code) 		+ space(1 - len(trim(ls_gwangae_code)))			// 관계(1)[36]
				ls_report	+=	trim(ls_foreigner_gbn) 		+ space(1 - len(trim(ls_foreigner_gbn)))			// 내외국인(1)[,37]
				ls_report	+=	trim(ls_support_name) 		+ space(20 - len(trim(ls_support_name)))			// 부양가족	성명[,57]
				ls_report	+=	trim(ls_support_jumin_no)	+ space(13 - len(trim(ls_support_jumin_no)))		// 부걍가족주민번호(1)[,70]
				
				ls_report	+=	trim(ls_basic_opt) 			+ space(1 - len(trim(ls_basic_opt)))				// 기본공제[,71]
				ls_report	+=	trim(ls_handicap_opt)		+ space(1 - len(trim(ls_handicap_opt)))			// 장애인[,72]
				ls_report	+=	trim(ls_child_opt) 			+ space(1 - len(trim(ls_child_opt)))				// 자녀양육[,73]
				ls_report	+=	trim(ls_woman_opt) 			+ space(1 - len(trim(ls_woman_opt)))				// 부녀자공제[,74]
				ls_report	+=	trim(ls_old_opt) 				+ space(1 - len(trim(ls_old_opt)))					// 경로우대공제[,75]
				ls_report	+=	trim(ls_add_child_opt) 		+ space(1 - len(trim(ls_add_child_opt)))			// 다자녀추가공제[,76]
				ls_report	+=	trim(ls_birth_opt) 			+ space(1 - len(trim(ls_birth_opt)))			   //출산입양자공제[,77]
			
				ls_report	+=	string(ldb_insure_amt, fill('0', 10)) 		// 보험료금액[,86]
				ls_report	+=	string(ldb_medical_amt, fill('0', 10))		// 의료비금액[,96]
				ls_report	+=	string(ldb_education_amt, fill('0', 10))	// 교육비금액[,106]
				ls_report	+=	string(ldb_cards_amt, fill('0', 10))		//신용카드금액[,116]
				ls_report	+=	string(ldb_cash_amt, fill('0', 10))			// 현금영수증금액[,126]
				ls_report	+=	string(ldb_a_insure_amt, fill('0', 10))	// 보험료금액[,136]
				ls_report	+=	string(ldb_a_medical_amt, fill('0', 10))	// 의료비금액[,146]
				ls_report	+=	string(ldb_a_education_amt, fill('0', 10))		// 교육비금액[,156]
				ls_report	+=	string(ldb_a_card_amt, fill('0', 10))		// 신용카드금액[,166]
				ls_report	+=	string(ldb_a_gibo_amt, fill('0', 10))		// 기부금금액[,176]
				
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'insure_amt'), fill('0', 10))		// 보험료금액[,86]
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'medical_amt'), fill('0', 10))	// 의료비금액[,96]
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'education_amt'), fill('0', 10))	// 교육비금액[,106]
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'card_amt'), fill('0', 10))		//신용카드금액[,116]
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'cash_amt'), fill('0', 10))		// 현금영수증금액[,126]
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'a_insure_amt'), fill('0', 10))	// 보험료금액[,136]
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'a_medical_amt'), fill('0', 10))	// 의료비금액[,146]
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'a_education_amt'), fill('0', 10))		// 교육비금액[,156]
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'a_card_amt'), fill('0', 10))		// 신용카드금액[,166]
//				ls_report	+=	string(lds_support.getitemnumber(ll_cnt3, 'a_gibo_amt'), fill('0', 10))		// 기부금금액[,176]
				
			if mod(ll_cnt3,5) = 0 then
				ll_string  = 745 - len(ls_report)
				ls_report 	+= space(ll_string)
				ls_report	+=	string(li_support_seq, '00')		// 부양가족일련번호
				ls_report	+=	space(73)	
				ll_row = idw_preview.insertrow(0)
				idw_preview.scrolltorow(ll_row)
				idw_preview.setitem(ll_row, 'report', ls_report)
				li_support_seq ++
			end if
	NEXT		
   		//부양가족 5명 보다작을때
			IF 5 - mod(ll_support_count,5) > 0 THEN
				for ll_cnt3 = 1 to (5 - mod(ll_support_count,5))
					    ls_report += space(42)
					    ls_report += fill('0', 100)
				next
		
			END IF
	
	IF mod(ll_support_count,5) <> 0 and ll_support_count > 0 THEN
		ll_string  = 745 - len(ls_report)
		ls_report 	+= space(ll_string)
		ls_report	+=	string(li_support_seq, '00')		// 부양가족일련번호
		ls_report	+=	space(73)	
//		ls_report  = Replace(ls_report, ll_string, 720, " ")
   	ll_row = idw_preview.insertrow(0)
	   idw_preview.scrolltorow(ll_row)
	   idw_preview.setitem(ll_row, 'report', ls_report)
	END IF

	hpb_1.position ++
	st_status.text = string(ll_cnt, '#,##0') + ' 건 연말정산 지급조서 화일 생성중 입니다!...'
next

hpb_1.position ++

if idw_preview.saveas(ls_fullname, Text!, false) = 1 then
	f_messagebox('1', ls_fullname + '~n화일 생성을 성공했습니다.!')
else
	f_messagebox('3', ls_fullname + '~n화일 생성을 실패했습니다.!')
end if

destroy	lds_data
destroy	lds_bef
destroy	lds_support
return	0

end function

on w_hpa611b.create
int iCurrent
call super::create
this.em_date1=create em_date1
this.st_1=create st_1
this.st_2=create st_2
this.em_date2=create em_date2
this.uo_year=create uo_year
this.st_21=create st_21
this.sle_filename=create sle_filename
this.pb_fileupload=create pb_fileupload
this.st_message=create st_message
this.st_status=create st_status
this.hpb_1=create hpb_1
this.dw_list=create dw_list
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_date1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_date2
this.Control[iCurrent+5]=this.uo_year
this.Control[iCurrent+6]=this.st_21
this.Control[iCurrent+7]=this.sle_filename
this.Control[iCurrent+8]=this.pb_fileupload
this.Control[iCurrent+9]=this.st_message
this.Control[iCurrent+10]=this.st_status
this.Control[iCurrent+11]=this.hpb_1
this.Control[iCurrent+12]=this.dw_list
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.dw_print
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.gb_4
end on

on w_hpa611b.destroy
call super::destroy
destroy(this.em_date1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_date2)
destroy(this.uo_year)
destroy(this.st_21)
destroy(this.sle_filename)
destroy(this.pb_fileupload)
destroy(this.st_message)
destroy(this.st_status)
destroy(this.hpb_1)
destroy(this.dw_list)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
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
//wf_setMenu('RETRIEVE',	true)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		true)

idw_preview	=	dw_list

uo_year.st_title.text = '기준년도'
is_year	=	uo_year.uf_getyy()

is_date1	=	f_lastdate(f_today())
em_date1.text	=	string(is_date1, '@@@@/@@/@@')

is_date2	=	left(f_today(), 6) + '25'
em_date2.text	=	string(is_date2, '@@@@/@@/@@')

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

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow


wf_setMsg('삭제중')

li_deleterow	=	idw_data.deleterow(0)

wf_setMsg('.')


return 

end event

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력 처리
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

IF dw_print.RowCount() < 1 THEN	return

OpenWithParm(w_printoption, dw_print)

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa611b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa611b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa611b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa611b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa611b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa611b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa611b
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa611b
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa611b
end type

type uc_save from w_tabsheet`uc_save within w_hpa611b
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa611b
end type

type uc_print from w_tabsheet`uc_print within w_hpa611b
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa611b
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa611b
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa611b
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa611b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa611b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa611b
boolean visible = false
integer y = 224
integer width = 3881
integer height = 2296
end type

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
event create ( )
event destroy ( )
string tag = "N"
integer width = 3845
integer height = 2180
string text = "연말정산지급조서자료생성"
end type

event dw_list001::constructor;call super::constructor;this.uf_setClick(true)
end event

event dw_list001::retrieveend;call super::retrieveend;selectrow(0, false)
selectrow(1, true)

end event

type uo_tab from w_tabsheet`uo_tab within w_hpa611b
end type

type dw_con from w_tabsheet`dw_con within w_hpa611b
end type

type st_con from w_tabsheet`st_con within w_hpa611b
end type

type em_date1 from editmask within w_hpa611b
integer x = 1298
integer y = 92
integer width = 480
integer height = 84
integer taborder = 50
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
	f_messagebox('1', st_1.text + '를 정확히 입력해 주시기 바랍니다.!')
	this.text = ls_bef_date
	is_date1 = ''
end if

is_date1	=	string(ldt_pay_date, 'yyyymmdd')

end event

type st_1 from statictext within w_hpa611b
integer x = 997
integer y = 108
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
string text = "제출일자"
boolean focusrectangle = false
end type

type st_2 from statictext within w_hpa611b
integer x = 2025
integer y = 108
integer width = 302
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

type em_date2 from editmask within w_hpa611b
integer x = 2327
integer y = 92
integer width = 480
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
	is_date2 = ''
end if

is_date2	=	string(ldt_pay_date, 'yyyymmdd')

end event

type uo_year from cuo_year within w_hpa611b
event destroy ( )
integer x = 82
integer y = 92
integer taborder = 70
boolean bringtotop = true
boolean border = false
end type

on uo_year.destroy
call cuo_year::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_year	=	uf_getyy()

if is_year = '0000' then
	is_year = ''
end if

end event

type st_21 from statictext within w_hpa611b
integer x = 146
integer y = 332
integer width = 727
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "연말정산지급조서생성화일명"
boolean focusrectangle = false
end type

type sle_filename from singlelineedit within w_hpa611b
integer x = 891
integer y = 308
integer width = 1481
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type pb_fileupload from picturebutton within w_hpa611b
integer x = 2377
integer y = 300
integer width = 430
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "     화일생성"
string picturename = "..\bmp\INSERT_E.BMP"
string disabledname = "..\bmp\INSERT_D.BMP"
alignment htextalign = left!
vtextalign vtextalign = vcenter!
end type

event clicked;// 자료를 생성한다.

integer	li_rtn

setpointer(hourglass!)

li_rtn = wf_filedownload()

wf_retrieve()

setpointer(arrow!)

//if li_rtn < 0 then
//	f_messagebox('3', sqlca.sqlerrtext)
//	rollback	;
//elseif li_rtn = 0 then
//	if idw_preview.update() = 1 then
//		commit	;
//		wf_retrieve()
//		tab_sheet.tabpage_sheet01.st_status.text = '진행 상태...'
//		parent.triggerevent('ue_retrieve')
//	else
//		rollback	;
//	end if
//end if
//
end event

type st_message from statictext within w_hpa611b
integer x = 2889
integer y = 296
integer width = 887
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "※ 연말정산지급조서화일의"
boolean focusrectangle = false
end type

type st_status from statictext within w_hpa611b
integer x = 64
integer y = 548
integer width = 3749
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

type hpb_1 from hprogressbar within w_hpa611b
integer x = 50
integer y = 628
integer width = 3776
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type dw_list from dw_list001 within w_hpa611b
integer y = 760
integer width = 3881
integer height = 1760
integer taborder = 20
string dataobject = "d_hpa611b_3"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_hpa611b
integer x = 2889
integer y = 368
integer width = 887
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "   화일명은 변경할 수 없습니다."
boolean focusrectangle = false
end type

type st_4 from statictext within w_hpa611b
integer x = 2889
integer y = 76
integer width = 946
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "※ 제출일자와 지급일자를 확인한 후"
boolean focusrectangle = false
end type

type st_5 from statictext within w_hpa611b
integer x = 2889
integer y = 148
integer width = 919
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "   화일을 생성해 주시기 바랍니다."
boolean focusrectangle = false
end type

type dw_print from datawindow within w_hpa611b
boolean visible = false
integer x = 919
integer y = 288
integer width = 1335
integer height = 432
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa611b_4"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type gb_1 from groupbox within w_hpa611b
integer y = 20
integer width = 3881
integer height = 200
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "생성/조회 조건"
end type

type gb_2 from groupbox within w_hpa611b
integer y = 240
integer width = 3881
integer height = 200
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "화일 생성"
end type

type gb_4 from groupbox within w_hpa611b
integer y = 468
integer width = 3881
integer height = 288
integer taborder = 70
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

