$PBExportHeader$w_hfn201a.srw
$PBExportComments$결의서등록(부서용)
forward
global type w_hfn201a from w_msheet
end type
type dw_tax from datawindow within w_hfn201a
end type
type dw_list from cuo_dwwindow_one_hin within w_hfn201a
end type
type dw_con from uo_dwfree within w_hfn201a
end type
type uo_tab from u_tab within w_hfn201a
end type
type tab_1 from tab within w_hfn201a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update1 from uo_dwfree within tabpage_1
end type
type dw_update2 from uo_dwfree within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_update1 dw_update1
dw_update2 dw_update2
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hfn201a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_all from datawindow within w_hfn201a
end type
type cb_preview from uo_imgbtn within w_hfn201a
end type
end forward

global type w_hfn201a from w_msheet
event type boolean ue_chk_condition ( )
dw_tax dw_tax
dw_list dw_list
dw_con dw_con
uo_tab uo_tab
tab_1 tab_1
dw_all dw_all
cb_preview cb_preview
end type
global w_hfn201a w_hfn201a

type variables
DataWindow			idw_main[]			//

//Integer	ii_AcctClass		//회계구분
//String	is_ResolDept		//발의부서
//Integer	ii_SlipClass		//전표구분
String	is_AcctCode			//계정과목
String	is_DrcrClass		//차대구분
//String	is_FrDate			//발의기간
//String	is_ToDate			//발의기간
String	is_AcctClassNm		//회계구분명
String	is_ResolDeptNm		//발의부서명
String	is_SlipClassNm		//전표구분명
String	is_AcctCodeNm		//계정과목명
String	is_DrcrClassNm		//차대구분명

String	is_SubTitle[] = {'[결의서]',&
								  '[결의내역]'}

boolean	ib_tax_proc			//계산서,세금계산서 작업 실행 여부

end variables

forward prototypes
public function integer wf_hfn102h_proc (integer ai_acct_class, string as_resol_date, integer ai_resol_no, integer ai_log_opt)
public function integer wf_mana_chk_null (datawindow adw_drcr)
public subroutine wf_hac012m_proc (datawindow adw, integer ai_row, string as_bdgt_year, string as_gwa, string as_acct_code, integer ai_acct_class, string as_io_gubun)
public subroutine wf_setmenubtn (string as_type)
public function integer wf_update_temp_amt (string as_type, datawindow adw, integer ai_row, string as_acct_code, decimal adec_resol_amt)
public function integer wf_delete_tax (string tax_type, integer slip_class, string resol_no, string resol_seq)
public function integer wf_open_tax (string tax_type, integer slip_class, string resol_no, string resol_seq)
public function integer wf_update_resol_no (string old_no, string new_no)
public function integer wf_update_resol_seq (string resol_no, integer old_no, integer new_no)
public function integer wf_save_tax ()
public function boolean wf_check_tax (string resol_no, integer resol_seq)
public function integer wf_chk_magam_tax ()
end prototypes

event type boolean ue_chk_condition();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_chk_condition
//	기 능 설 명: 조회조건체크처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
date		ld_date
String      ls_ResolDept, ls_FrDate, ls_ToDate
Integer	li_slipclass

wf_SetMsg('조회조건 체크 중입니다...')



// 발의부서 입력여부 체크
ls_ResolDept = TRIM(dw_con.Object.code[1])

IF LEN(ls_ResolDept) = 0 OR isNull(ls_ResolDept) OR ls_ResolDept = '0' THEN
	ls_Msg = '결의부서를 선택하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	dw_con.SetFocus()
	dw_con.setcolumn('code')
	RETURN FALSE
END IF

// 전표구분 입력여부 체크
li_SlipClass = Integer(MID(TRIM(dw_con.object.slip_class[1]),1,1))

IF li_SlipClass = 0 OR isNull(li_SlipClass) THEN
	ls_Msg = '결의구분을 선택하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	dw_con.SetFocus()
	dw_con.setcolumn('slip_class')
	RETURN FALSE
END IF

// 발의기간 입력여부 체크

ls_FrDate = TRIM(string(dw_con.object.fr_date[1], 'yyyymmdd'))
IF NOT f_isDate(ls_FrDate) THEN
	MessageBox('확인','결의기간(FROM)을 올바르게 입력하시기 바랍니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('fr_date')
	RETURN FALSE
END IF


ls_ToDate = TRIM(string(dw_con.object.to_date[1], 'yyyymmdd'))
IF NOT f_isDate(ls_ToDate) THEN
	MessageBox('확인','결의기간(TO)를 올바르게 입력하시기 바랍니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('to_date')
	RETURN FALSE
END IF

IF ls_FrDate > ls_ToDate THEN
	MessageBox('확인','결의기간 올바르지 않습니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('to_date')
	RETURN FALSE
END IF

RETURN TRUE

end event

public function integer wf_hfn102h_proc (integer ai_acct_class, string as_resol_date, integer ai_resol_no, integer ai_log_opt);// ==========================================================================================
// 기    능	:	전표이력 정보 Update
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_hfn102h_proc(integer ai_acct_class, string as_resol_date, integer ai_resol_no, integer ai_log_opt) return integer
// 인    수 :	ai_acct_class(회계단위)
//             as_resol_date(결의일자)
//             ai_resol_no(결의번호)
//             ai_log_opt(이력구분) - 1:입력, 2:수정, 3:삭제
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
integer	li_log_seq

select	nvl(max(log_seq),0) + 1	into	:li_log_seq
from		fndb.hfn102h
where		acct_class = :ai_acct_class
and		resol_date = :as_resol_date
and		resol_no   = :ai_resol_no ;

insert	into	fndb.hfn102h
select	acct_class,
			resol_date,
			resol_no,
			resol_seq,
			:li_log_seq,
			:ai_log_opt,
			acct_code,
			drcr_class,
			resol_amt,
			:gs_empcode,
			:gs_ip,
			sysdate,
			:gs_empcode,
			:gs_ip,
			sysdate
from		fndb.hfn102m
where		acct_class = :ai_acct_class
and		resol_date = :as_resol_date
and		resol_no   = :ai_resol_no ;

if sqlca.sqlcode <> 0 then return -1

return 0

end function

public function integer wf_mana_chk_null (datawindow adw_drcr);// ==========================================================================================
// 기    능	:	Dr/Cr Datawindow Check
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_itemchanged(datawindow adw_drcr) return integer
// 인    수 :	adw_drcr(현재 처리 Datawindow)
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long		ll_row
string	ls_mana_data

for ll_row = 1 to adw_drcr.rowcount()
	if adw_drcr.getitemnumber(ll_row, 'mana_code1') <> 0 then
		// 발생전표 번호 제외
		if adw_drcr.getitemnumber(ll_row, 'mana_code1') <> 9 or &
		   adw_drcr.getitemstring(ll_row, 'drcr_class') <> adw_drcr.getitemstring(ll_row, 'com_drcr_class') then
			ls_mana_data = adw_drcr.getitemstring(ll_row, 'mana_data1')
			if isnull(ls_mana_data) or trim(ls_mana_data) = '' then
				messagebox('확인', '관리항목1의 내용을 입력하시기 바랍니다.')
				adw_drcr.scrolltorow(ll_row)
				adw_drcr.setrow(ll_row)
				adw_drcr.setcolumn('mana_data1')
				adw_drcr.setfocus()
				return -1
			end if
		end if
	end if

	if adw_drcr.getitemnumber(ll_row, 'mana_code2') <> 0 then
		// 발생전표 번호 제외
		if adw_drcr.getitemnumber(ll_row, 'mana_code2') <> 9 or &
		   adw_drcr.getitemstring(ll_row, 'drcr_class') <> adw_drcr.getitemstring(ll_row, 'com_drcr_class') then
			ls_mana_data = adw_drcr.getitemstring(ll_row, 'mana_data2')
			if isnull(ls_mana_data) or trim(ls_mana_data) = '' then
				messagebox('확인', '관리항목2의 내용을 입력하시기 바랍니다.')
				adw_drcr.scrolltorow(ll_row)
				adw_drcr.setrow(ll_row)
				adw_drcr.setcolumn('mana_data2')
				adw_drcr.setfocus()
				return -1
			end if
		end if
	end if

	if adw_drcr.getitemnumber(ll_row, 'mana_code3') <> 0 then
		// 발생전표 번호 제외
		if adw_drcr.getitemnumber(ll_row, 'mana_code3') <> 9 or &
		   adw_drcr.getitemstring(ll_row, 'drcr_class') <> adw_drcr.getitemstring(ll_row, 'com_drcr_class') then
			ls_mana_data = adw_drcr.getitemstring(ll_row, 'mana_data3')
			if isnull(ls_mana_data) or trim(ls_mana_data) = '' then
				messagebox('확인', '관리항목3의 내용을 입력하시기 바랍니다.')
				adw_drcr.scrolltorow(ll_row)
				adw_drcr.setrow(ll_row)
				adw_drcr.setcolumn('mana_data3')
				adw_drcr.setfocus()
				return -1
			end if
		end if
	end if

	if adw_drcr.getitemnumber(ll_row, 'mana_code4') <> 0 then
		// 발생전표 번호 제외
		if adw_drcr.getitemnumber(ll_row, 'mana_code4') <> 9 or &
		   adw_drcr.getitemstring(ll_row, 'drcr_class') <> adw_drcr.getitemstring(ll_row, 'com_drcr_class') then
			ls_mana_data = adw_drcr.getitemstring(ll_row, 'mana_data4')
			if isnull(ls_mana_data) or trim(ls_mana_data) = '' then
				messagebox('확인', '관리항목4의 내용을 입력하시기 바랍니다.')
				adw_drcr.scrolltorow(ll_row)
				adw_drcr.setrow(ll_row)
				adw_drcr.setcolumn('mana_data4')
				adw_drcr.setfocus()
				return -1
			end if
		end if
	end if
next

return 0
end function

public subroutine wf_hac012m_proc (datawindow adw, integer ai_row, string as_bdgt_year, string as_gwa, string as_acct_code, integer ai_acct_class, string as_io_gubun);// ==========================================================================================
// 기    능	:	예산금액의 확인
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_hac012m_proc(string as_bdgt_year, string as_gwa, string as_acct_code, integer ai_acct_class, string as_io_gubun)
// 인    수 :	as_bdgt_year(예산년도)
//					as_gwa(부서)
//					as_acct_code(계정코드)
//					ai_acct_class(회계단위)
//					as_io_gubun(수입/지출)
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
dec{0}	ldec_assn_used_amt
dec{0}	ldec_assn_temp_amt
dec{0}	ldec_assn_real_amt

if adw.getitemstatus(ai_row, 0, primary!) <> new! and adw.getitemstatus(ai_row, 0, primary!) <> newmodified! then return

select	nvl(assn_used_amt,0),	nvl(assn_temp_amt,0),	nvl(assn_real_amt,0)
into		:ldec_assn_used_amt,		:ldec_assn_temp_amt,		:ldec_assn_real_amt
from		acdb.hac012m
where		bdgt_year	=	:as_bdgt_year
and		gwa			=	:as_gwa
and		acct_code	=	:as_acct_code
and		acct_class	=	:ai_acct_class
and		io_gubun		=	:as_io_gubun	;

if	isnull(ldec_assn_used_amt) then ldec_assn_used_amt = 0
if	isnull(ldec_assn_temp_amt) then ldec_assn_temp_amt = 0
if	isnull(ldec_assn_real_amt) then ldec_assn_real_amt = 0


//입력한 데이터윈도우의 예산배정액과 잔액을 계산한다.
dec{0}	ldec_assn_temp_amt_1
long ll_row
string ls_acct_code

for ll_row = 1 to adw.rowcount()
	ls_acct_code = adw.getitemstring(ll_row, 'acct_code')
	
	if ll_row <> ai_row and as_acct_code = ls_acct_code and &
		(adw.getitemstatus(ll_row, 0, primary!) = new! or adw.getitemstatus(ll_row, 0, primary!) = newmodified!) then 
		ldec_assn_temp_amt_1 += adw.getitemnumber(ll_row, 'resol_amt')
	end if
next


adw.setitem(ai_row, 'assn_used_amt', ldec_assn_used_amt)
adw.setitem(ai_row, 'assn_temp_amt', ldec_assn_temp_amt + ldec_assn_temp_amt_1)
adw.setitem(ai_row, 'assn_real_amt', ldec_assn_real_amt)

end subroutine

public subroutine wf_setmenubtn (string as_type);//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN
////		wf_setmenu(ls_Flag[li_idx], true)
//	else
////		wf_setmenu(ls_Flag[li_idx], false)
//	END IF
//
////	lb_Value = FALSE
////	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN
////		if is_Auth[1] = 'Y' then lb_value = true
////	END IF
////	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
////	
////	CHOOSE CASE ls_Flag[li_idx]
////		CASE 'I' ; ib_insert   = lb_Value
////		CASE 'S' ; ib_update   = lb_Value
////		CASE 'D' ; ib_delete   = lb_Value
////		CASE 'R' ; ib_retrieve = lb_Value
////		CASE 'P' ; ib_print    = lb_Value
////		CASE 'P' ; ib_print    = lb_Value
////	END CHOOSE
//NEXT
end subroutine

public function integer wf_update_temp_amt (string as_type, datawindow adw, integer ai_row, string as_acct_code, decimal adec_resol_amt);dec{0}	ldec_resol_amt, ldec_assn_temp_amt, ldec_diff_amt
string 	ls_acct_code
long 		ll_row

if lower(as_type) = 'delete' then
	if ai_row = adw.rowcount() then return 0

	ldec_resol_amt = adw.getItemNumber(ai_row, 'resol_amt')		//항삭제할 결의금액...
	
	for ll_row = ai_row + 1 to adw.rowcount()
		ls_acct_code = adw.getItemString(ll_row, 'acct_code')
		
		if ll_row <> ai_row and as_acct_code = ls_acct_code then 
			ldec_assn_temp_amt = adw.getItemNumber(ll_row, 'assn_temp_amt')
			adw.setItem(ll_row, 'assn_temp_amt', ldec_assn_temp_amt - ldec_resol_amt)
		end if
	next
elseif lower(as_type) = 'itemchanged' then
	//변경되기전 결의금액, adec_resol_amt : 변경된 결의금액...
	ldec_resol_amt = adw.getItemNumber(ai_row, 'resol_amt')
	
	if isnull(ldec_resol_amt) then ldec_resol_amt = 0 
	
	ldec_diff_amt = adec_resol_amt - ldec_resol_amt

//	if ldec_resol_amt > adec_resol_amt then
//		ldec_diff_amt = adec_resol_amt - ldec_resol_amt
//	elseif ldec_resol_amt < adec_resol_amt then
//		ldec_diff_amt = ldec_resol_amt - adec_resol_amt
//	end if
	
	for ll_row = 1 to adw.rowcount()
		ls_acct_code = adw.getItemString(ll_row, 'acct_code')
		
		if ll_row <> ai_row and as_acct_code = ls_acct_code then 
			ldec_assn_temp_amt = adw.getItemNumber(ll_row, 'assn_temp_amt')
			adw.setItem(ll_row, 'assn_temp_amt', ldec_assn_temp_amt + ldec_diff_amt)
		end if
	next
	
end if

return 1

end function

public function integer wf_delete_tax (string tax_type, integer slip_class, string resol_no, string resol_seq);String	ls_tax_type, ls_tax_gubun
Long		ll_find

if tax_type = '1' then			//세금계산서일 경우...
	ls_tax_type = '2'
elseif tax_type = '2' then 	//계산서일 경우...
	ls_tax_type = '1'
end if

if slip_class = 1 then			//수입
	ls_tax_gubun = '2'	//매출
elseif slip_class = 2 then		//지출
	ls_tax_gubun = '1'	//매입
end if

//부가세 Data를 지운다.
ll_find = dw_tax.find("tax_gubun = '"+ls_tax_gubun+"' and resol_no = '"+resol_no+"' and resol_seq = "+resol_seq+ &
							 " and tax_type like '"+ls_tax_type+"%'", 0, dw_tax.rowcount())

do while ll_find <> 0
	dw_tax.DeleteRow(ll_find)
	ll_find = dw_tax.find("tax_gubun = '"+ls_tax_gubun+"' and resol_no = '"+resol_no+"' and resol_seq = "+resol_seq+ &
								 " and tax_type like '"+ls_tax_type+"%'", ll_find, dw_tax.rowcount())
loop

//20060725 부가세 입력시 거래처가 관리항목에 세팅되게(삭제처리)
if idw_main[2].Object.mana_code1[idw_main[2].getRow()] = 2 then
	idw_main[2].Object.mana_data1[idw_main[2].getRow()] 		= ''
	idw_main[2].Object.com_mana1_name[idw_main[2].getRow()] 	= ''
elseif idw_main[2].Object.mana_code2[idw_main[2].getRow()] = 2 then
	idw_main[2].Object.mana_data2[idw_main[2].getRow()] 		= ''
	idw_main[2].Object.com_mana2_name[idw_main[2].getRow()] 	= ''
elseif idw_main[2].Object.mana_code3[idw_main[2].getRow()] = 2 then
	idw_main[2].Object.mana_data3[idw_main[2].getRow()] 		= ''
	idw_main[2].Object.com_mana3_name[idw_main[2].getRow()] 	= ''
elseif idw_main[2].Object.mana_code4[idw_main[2].getRow()] = 2 then
	idw_main[2].Object.mana_data4[idw_main[2].getRow()] 		= ''
	idw_main[2].Object.com_mana4_name[idw_main[2].getRow()] 	= ''
end if

idw_main[2].Object.remark[idw_main[2].getRow()] 			= ''

return 1

end function

public function integer wf_open_tax (string tax_type, integer slip_class, string resol_no, string resol_seq);long				ll_find
s_tax				str_tax							//structure
DataStore 		lds_tax             			//DataStore 선언 
string			ls_tax_type, ls_tax_gubun

if tax_type = '1' then			//세금계산서일 경우...
	ls_tax_type = '2'
elseif tax_type = '2' then 	//계산서일 경우...
	ls_tax_type = '1'
end if

if slip_class = 1 then			//수입
	ls_tax_gubun = '2'	//매출
elseif slip_class = 2 then		//지출
	ls_tax_gubun = '1'	//매입
end if

//dw_tax.setFilter("tax_gubun = '"+ls_tax_gubun+"' and resol_no = '"+resol_no+"' and tax_type like '"+ls_tax_type+"%'")
dw_tax.setFilter("tax_gubun = '"+ls_tax_gubun+"' and resol_no = '"+resol_no+"' and resol_seq = "+resol_seq)
dw_tax.filter()

str_tax.tax_type 		= 	ls_tax_type
str_tax.tax_gubun 	= 	ls_tax_gubun
str_tax.resol_no		=	resol_no
str_tax.resol_seq		=	integer(resol_seq)
str_tax.dw_tax			=	dw_tax

OpenWithParm(w_hfn201a_tax, str_tax)

dw_tax.setFilter("")
dw_tax.filter()

//제대로 리턴이 되면...
if Not isNull(Message.PowerObjectParm) then

	lds_tax = Create DataStore    // 메모리에 할당
	lds_tax = Message.PowerObjectParm
	lds_tax.SetTransObject(sqlca)
	
	//1. 예전 Data를 지운다.
//	ll_find = dw_tax.find("tax_gubun = '"+ls_tax_gubun+"' and resol_no = '"+resol_no+"' and tax_type like '"+ls_tax_type+"%'",&
	ll_find = dw_tax.find("tax_gubun = '"+ls_tax_gubun+"' and resol_no = '"+resol_no+"' and resol_seq = "+resol_seq,&
								 0, dw_tax.rowcount())
	
	do while ll_find <> 0
		dw_tax.DeleteRow(ll_find)
//		ll_find = dw_tax.find("tax_gubun = '"+ls_tax_gubun+"' and resol_no = '"+resol_no+"' and tax_type like '"+ls_tax_type+"%'",&
		ll_find = dw_tax.find("tax_gubun = '"+ls_tax_gubun+"' and resol_no = '"+resol_no+"' and resol_seq = "+resol_seq,&
									 ll_find, dw_tax.rowcount())
	loop
	
	//2. 리턴된 데이타를 DataWindow에 update시킨다.
	lds_tax.RowsCopy(1, lds_tax.RowCount(), Primary!, dw_tax, 1, Primary!)
	

	//3. 리턴된 데이타에서 부가세 정보를 결의서내역에 출력한다.
	if lds_tax.RowCount() > 0 then
		//20060725 부가세 입력시 거래처가 관리항목에 세팅되게(삭제처리)
		if idw_main[2].Object.mana_code1[idw_main[2].getRow()] = 2 then
			idw_main[2].Object.mana_data1[idw_main[2].getRow()] 		= lds_tax.Object.tax_cust_no[1]
			idw_main[2].Object.com_mana1_name[idw_main[2].getRow()] 	= lds_tax.Object.cust_name[1]
		elseif idw_main[2].Object.mana_code2[idw_main[2].getRow()] = 2 then
			idw_main[2].Object.mana_data2[idw_main[2].getRow()] 		= lds_tax.Object.tax_cust_no[1]
			idw_main[2].Object.com_mana2_name[idw_main[2].getRow()] 	= lds_tax.Object.cust_name[1]
		elseif idw_main[2].Object.mana_code3[idw_main[2].getRow()] = 2 then
			idw_main[2].Object.mana_data3[idw_main[2].getRow()] 		= lds_tax.Object.tax_cust_no[1]
			idw_main[2].Object.com_mana3_name[idw_main[2].getRow()] 	= lds_tax.Object.cust_name[1]
		elseif idw_main[2].Object.mana_code4[idw_main[2].getRow()] = 2 then
			idw_main[2].Object.mana_data4[idw_main[2].getRow()] 		= lds_tax.Object.tax_cust_no[1]
			idw_main[2].Object.com_mana4_name[idw_main[2].getRow()] 	= lds_tax.Object.cust_name[1]
		end if
		
		idw_main[2].Object.proof_date[idw_main[2].getRow()] 		= lds_tax.Object.tax_date[1]
		idw_main[2].Object.remark[idw_main[2].getRow()] 			= lds_tax.Object.remark[1]
	else
		//20060725 부가세 입력시 거래처가 관리항목에 세팅되게(삭제처리)
		if idw_main[2].Object.mana_code1[idw_main[2].getRow()] = 2 then
			idw_main[2].Object.mana_data1[idw_main[2].getRow()] 		= ''
			idw_main[2].Object.com_mana1_name[idw_main[2].getRow()] 	= ''
		elseif idw_main[2].Object.mana_code2[idw_main[2].getRow()] = 2 then
			idw_main[2].Object.mana_data2[idw_main[2].getRow()] 		= ''
			idw_main[2].Object.com_mana2_name[idw_main[2].getRow()] 	= ''
		elseif idw_main[2].Object.mana_code3[idw_main[2].getRow()] = 2 then
			idw_main[2].Object.mana_data3[idw_main[2].getRow()] 		= ''
			idw_main[2].Object.com_mana3_name[idw_main[2].getRow()] 	= ''
		elseif idw_main[2].Object.mana_code4[idw_main[2].getRow()] = 2 then
			idw_main[2].Object.mana_data4[idw_main[2].getRow()] 		= ''
			idw_main[2].Object.com_mana4_name[idw_main[2].getRow()] 	= ''
		end if
		
		idw_main[2].Object.proof_date[idw_main[2].getRow()] 		= ''
		idw_main[2].Object.remark[idw_main[2].getRow()] 			= ''
	end if

end if

return 1


end function

public function integer wf_update_resol_no (string old_no, string new_no);//부가세 Data의 결의번호를 변경.
long 	ll_find

ll_find = dw_tax.find("resol_no = '"+old_no+"'", 0, dw_tax.rowcount())

do while ll_find <> 0
	dw_tax.setItem(ll_find, 'resol_no', new_no)
	ll_find = dw_tax.find("resol_no = '"+old_no+"'", ll_find, dw_tax.rowcount())
loop

return 1



end function

public function integer wf_update_resol_seq (string resol_no, integer old_no, integer new_no);//부가세 Data의 결의항번을 변경.
long 	ll_find

ll_find = dw_tax.find("resol_no = '"+resol_no+"' and resol_seq = "+String(old_no), 0, dw_tax.rowcount())

do while ll_find <> 0
	dw_tax.setItem(ll_find, 'resol_seq', new_no)
	ll_find = dw_tax.find("resol_no = '"+resol_no+"' and resol_seq = "+String(old_no), ll_find, dw_tax.rowcount())
loop

return 1



end function

public function integer wf_save_tax ();long 		ll_tax_no, ll_row
String	ls_bdgt_year
dwitemstatus	ldw_status

//우선 정렬
dw_tax.SetSort('resol_no A, resol_seq A, com_row A')
dw_tax.Sort()

//예산-회계년도 가져오고
ls_bdgt_year = idw_main[1].Object.bdgt_year[idw_main[1].GetRow()]

//부가세 max 번호도 select
select	nvl(max(substr(tax_no,5,6)),0)
into		:ll_tax_no
from		fndb.hfn007m
where		acct_class 				= :gi_acct_class
and		substr(tax_no,1,4) 	= :ls_bdgt_year	;

if isnull(ll_tax_no) then ll_tax_no = 0

//새로 입력된 것이 있으면 번호 setting
ll_row = dw_tax.getnextmodified(0, primary!)

do	while ll_row > 0
	ldw_status = dw_tax.getitemstatus(ll_row, 0, primary!)
	
	if ldw_status = new! or ldw_status = newmodified! then
		ll_tax_no ++
		dw_tax.setitem(ll_row, 'tax_no', ls_bdgt_year + string(ll_tax_no,'000000'))
		dw_tax.setitem(ll_row, 'acct_class', gi_acct_class)
	end if
	
	ll_row = dw_tax.getnextmodified(ll_row, primary!)
loop

//데이터 저장
return dw_tax.update();

end function

public function boolean wf_check_tax (string resol_no, integer resol_seq);long 	ll_row, ll_find
string	ls_resol_date, ls_tax_type
integer	li_resol_no, li_resol_seq
boolean	lb_exist_tax

lb_exist_tax = true

		
ll_find = dw_tax.find("resol_no = '"+resol_no+"' and resol_seq = "+String(resol_seq), 0, dw_tax.rowcount())


if ll_find = 0 then	lb_exist_tax = false


return lb_exist_tax

end function

public function integer wf_chk_magam_tax ();long 	ll_row
string	ls_tax_date, ls_yymm, ls_close_yn


for ll_row = 1 TO dw_tax.rowcount()
	ls_tax_date = dw_tax.Object.tax_date[ll_row]
	if isnull(ls_tax_date) then ls_tax_date = ''

	//마감여부 SELECT...
	SELECT	ACCT_YYMM, 	CLOSE_YN	
	INTO 	:ls_yymm,	:ls_close_yn
	FROM	FNDB.HFN012M
	WHERE	ACCT_CLASS 		= 		:gi_acct_class
	AND		:ls_tax_date 	BETWEEN BEGIN_DATE AND END_DATE
	;

	if ls_close_yn = 'Y' then
		messagebox('확인', string(ls_yymm, '@@@@/@@') + ' 년월은 월마감이 확정되었습니다.~r~n' + &
				   '계산서일자('+string(ls_tax_date, '@@@@/@@/@@')+')를 수정하십시요.', exclamation!)
		return -1
	end if
next

return 0

end function

on w_hfn201a.create
int iCurrent
call super::create
this.dw_tax=create dw_tax
this.dw_list=create dw_list
this.dw_con=create dw_con
this.uo_tab=create uo_tab
this.tab_1=create tab_1
this.dw_all=create dw_all
this.cb_preview=create cb_preview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tax
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_tab
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.dw_all
this.Control[iCurrent+7]=this.cb_preview
end on

on w_hfn201a.destroy
call super::destroy
destroy(this.dw_tax)
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.uo_tab)
destroy(this.tab_1)
destroy(this.dw_all)
destroy(this.cb_preview)
end on

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 결의서등록.
////	작 성 인 : 이현수
////	작성일자 : 2002.11
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//datawindowchild	ldwc_temp
//string				ls_str_date, ls_last_date
//
//if gs_empcode = 'F0018'or gs_empcode = 'F0057' or gs_empcode = 'F0092' then
//	dw_resol_dept.Object.code.Background.mode = 0
//	dw_resol_dept.enabled = true
//else
//	dw_resol_dept.Object.code.Background.mode = 1
//	dw_resol_dept.enabled = false
//end if
//
//idw_main[01] = tab_1.tabpage_1.dw_update1
//idw_main[02] = tab_1.tabpage_1.dw_update2
//idw_main[03] = tab_1.tabpage_2.dw_print
//
//// 초기값처리
//dw_acct_class.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('acct_class',1) = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//dw_acct_class.InsertRow(0)
//dw_acct_class.Object.code[1] = '1'
//
//dw_resol_dept.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve(1, 3) = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_resol_dept.InsertRow(0)
//dw_resol_dept.Object.code[1] = gs_DeptCode
//
//ddlb_slip_class.SelectItem(2)
//ddlb_slip_class.TRIGGER EVENT SelectionChanged(1)
//
//ls_str_date  = f_today()
//ls_last_date = f_lastdate(f_today())
//
//em_fr_date.Text = left(ls_str_date,4) + '/' + mid(ls_str_date,5,2) + '/' + right(ls_str_date,2)
//em_to_date.Text = left(ls_last_date,4) + '/' + mid(ls_last_date,5,2) + '/' + right(ls_last_date,2)
//
//// 발의서내역 데이타원도우 DDDW초기화
//// 관리항목 DDDW초기화처리
//idw_main[2].GetChild('mana_code1',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve() = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//idw_main[2].GetChild('mana_code2',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve() = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//idw_main[2].GetChild('mana_code3',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve() = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//// 증빙종류 DDDW초기화처리
//idw_main[2].GetChild('proof_gubun',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('proof_gubun', 0) = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//idw_main[3].GetChild('proof_gubun',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('proof_gubun', 0) = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//dw_all.GetChild('proof_gubun',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('proof_gubun', 0) = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//THIS.TRIGGER EVENT ue_init()
//
////부가세
//ib_tax_proc = true
////if gs_empcode = 'F0012'or gs_empcode = 'F0092' then
////	cbx_tax.visible = true
////else
////	cbx_tax.visible = false
////end if
//
end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
//wf_SetMenuBtn('IR')

dw_con.object.slip_class.protect = 0
dw_con.SetFocus()
dw_con.setcolumn('to_date')

dw_list.Reset()

idw_main[01].SetReDraw(FALSE)
idw_main[01].Reset()
idw_main[01].InsertRow(0)
idw_main[01].Object.DataWindow.ReadOnly = 'YES'
idw_main[01].SetReDraw(TRUE)

idw_main[02].SetReDraw(FALSE)
idw_main[02].Reset()
idw_main[02].InsertRow(0)
idw_main[02].Object.DataWindow.ReadOnly = 'YES'
idw_main[02].SetReDraw(TRUE)

tab_1.tabpage_2.dw_print.Reset()

end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long	ll_RowCnt
String 	ls_ResolDept, ls_FrDate, ls_ToDate
Integer 	li_slipclass
dw_con.accepttext()
// 조회조건 체크
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN -1



// 자료조회
wf_SetMsg('조회 처리 중입니다...')

dw_list.SetReDraw(FALSE)
//ddlb_slip_class.Enabled = TRUE
dw_con.object.slip_class.protect = 0
ls_ResolDept = dw_con.object.code[1]
li_slipclass = integer(dw_con.object.slip_class[1])
ls_frdate = String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_ToDate = String(dw_con.object.to_date[1], 'yyyymmdd')

ll_RowCnt = dw_list.Retrieve(gi_acct_class, ls_ResolDept, li_SlipClass, ls_frdate, ls_ToDate)
dw_list.SetReDraw(TRUE)


// 메뉴버튼 활성/비활성화 처리 및 메세지 처리
IF ll_RowCnt = 0 THEN 
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	
	idw_main[1].SetReDraw(FALSE)
	idw_main[1].Reset()
	idw_main[1].InsertRow(0)
	idw_main[1].Object.DataWindow.ReadOnly = 'YES'
	idw_main[1].SetReDraw(TRUE)

	idw_main[2].SetReDraw(FALSE)
	idw_main[2].Reset()
	idw_main[2].InsertRow(0)
	idw_main[2].Object.DataWindow.ReadOnly = 'YES'
	idw_main[2].SetReDraw(TRUE)
	
	if ib_tax_proc then dw_tax.Reset()
	
//	wf_SetMenuBtn('IR')
	
END IF

//wf_SetMenu('IDP',FALSE)
return 1

end event

event ue_insert;call super::ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Integer	li_SelectedTab
String	ls_SysDate
String	ls_resoldept
Integer	li_slipclass

// 자료추가전 필수입력사항 체크
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN

li_SelectedTab = tab_1.SelectedTab
IF li_SelectedTab = 2 THEN RETURN

// 결의마스터 자료추가
idw_main[1].Reset()
idw_main[1].InsertRow(0)
idw_main[1].Object.DataWindow.ReadOnly = 'NO'

// 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
ls_SysDate = f_today()
dw_con.accepttext()
li_slipclass = Integer(dw_con.object.slip_class[1])
ls_resoldept = dw_con.object.code[1]


idw_main[1].Object.acct_class[1] = gi_acct_class
idw_main[1].Object.resol_date[1] = ls_SysDate
idw_main[1].Object.slip_class[1] = li_SlipClass
idw_main[1].Object.resol_gwa [1] = ls_ResolDept
idw_main[1].Object.step_opt  [1] = 1
idw_main[1].Object.genesis_gb[1] = 0

idw_main[1].TRIGGER EVENT itemchanged(1,idw_main[1].Object.resol_date,ls_SysDate)

// 발의내역 자료추가
idw_main[2].Reset()
idw_main[2].InsertRow(0)
idw_main[2].Object.DataWindow.ReadOnly = 'NO'

//계정코드 변경 가능하게(2004.09.16)...
idw_main[2].Object.acct_code.Protect 		= 0
idw_main[2].Object.com_acct_name.Protect 	= 0

// 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
idw_main[2].Object.acct_class   [1] = gi_acct_class
idw_main[2].Object.resol_date   [1] = ls_SysDate
idw_main[2].Object.proof_gubun  [1] = 0
if li_slipclass = 1 then
	idw_main[2].Object.drcr_class[1] = 'C'
else
	idw_main[2].Object.drcr_class[1] = 'D'
end if
idw_main[2].Object.bdgt_year    [1] = idw_main[1].Object.bdgt_year[1]
idw_main[2].Object.resol_gwa 	  [1] = idw_main[1].Object.resol_gwa[1]
idw_main[2].Object.mana_code1   [1] = 0
idw_main[2].Object.mana_code2   [1] = 0
idw_main[2].Object.mana_code3   [1] = 0
idw_main[2].Object.mana_code4   [1] = 0

wf_SetMsg('자료가 추가되었습니다.')
//wf_SetMenuBtn('IDSR')
idw_main[1].SetFocus()

//부가세 리셋
if ib_tax_proc then dw_tax.reset()

end event

event ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Integer	li_SelectedTab
String	ls_Msg
Integer	li_Rtn
String	ls_ResolDate
Integer	li_ResolNo
long		ll_row, ll_DelRowCnt, ll_DelRow, ll_find
string	ls_BdgtCntlYn, ls_bdgt_year, ls_gwa, ls_acct_code, ls_slip_class
integer	li_acct_class, li_step_opt
dec{0}	ldc_resol_amt

// 현재선택된 데이타원도우의 체크.
li_SelectedTab = tab_1.SelectedTab

IF li_SelectedTab = 0 THEN RETURN

// 삭제메세지 처리.
ls_ResolDate  = TRIM(idw_main[1].Object.resol_date[1])
li_ResolNo    = idw_main[1].Object.resol_no[1]
ls_slip_class = string(idw_main[1].object.slip_class[1])
li_step_opt   = idw_main[1].Object.step_opt[1]

if li_step_opt <> 1 then
	messagebox("확인", "결의상태가 '결의서작성'인 결의서만 삭제가능합니다.", stopsign!)
	return
end if

ls_Msg = '자료를 삭제하시겠습니까?~r~n~r~n'+&
			'결의일자 : '+String(ls_ResolDate,'@@@@/@@/@@')+'~r~n'+&
			'결의번호 : '+String(li_ResolNo)+'~r~n~r~n'+&
			'삭제시 관계된 모든자료가 삭제됩니다.'

li_Rtn = MessageBox('확인',ls_Msg,Question!,YesNo!,2)

IF li_Rtn = 2 THEN RETURN



// 삭제처리.
// 결의내역 삭제처리
wf_SetMsg('결의내역 자료를 삭제처리 중입니다.')

// 결의자료 삭제전 예산부분에 해당하는 가집행금액을 처리한다.
FOR ll_row = 1 TO idw_main[2].rowcount()
	 ls_BdgtCntlYn = idw_main[2].Object.bdgt_cntl_yn[ll_Row]
//	 if ls_BdgtCntlYn = 'Y' then
		 ls_bdgt_year  = idw_main[2].Object.bdgt_year[ll_row]
		 ls_gwa        = idw_main[2].Object.resol_gwa[ll_row]
		 ls_acct_code  = idw_main[2].Object.acct_code[ll_row]
		 li_acct_class = idw_main[2].object.acct_class[ll_row]
		 ldc_resol_amt = idw_main[2].Object.resol_amt[ll_row]
		 
		 UPDATE	ACDB.HAC012M
		 SET		ASSN_TEMP_AMT = NVL(ASSN_TEMP_AMT,0) - :ldc_resol_amt
		 WHERE	BDGT_YEAR  = :ls_bdgt_year
		 AND		GWA        = :ls_gwa
		 AND		ACCT_CODE  = :ls_acct_code
		 AND		ACCT_CLASS = :li_acct_class
		 AND		IO_GUBUN	  = :ls_slip_class ;

		 IF SQLCA.SQLCODE <> 0 THEN

			 Rollback using sqlca ;
			 wf_SetMsg('배정예산처리 중 오류가 발생하였습니다.')
			 MessageBox('확인','배정예산처리 중 전산장애가 발생되었습니다.~r~n' + &
				 					 '하단의 장애번호와 장애내역을~r~n' + &
									 '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									 '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
									 '장애내역 : ' + SQLCA.SqlErrText)
			 RETURN
		 END IF
//	 end if
NEXT


//////////////////////////////////////////////////////////////////////////////////////////////
// 결의서내역 행삭제 한것도 처리 (20040519 : Jung Kwang Hoon)
ll_DelRowCnt = idw_main[2].DeletedCount()

IF ll_DelRowCnt > 0 THEN
	FOR ll_DelRow = ll_DelRowCnt TO 1 STEP -1 
		// 배정예산(HAC012M) 변경처리
		ls_BdgtCntlYn = idw_main[2].Object.bdgt_cntl_yn.delete[ll_DelRow]
//		IF ls_BdgtCntlYn = 'Y' THEN
			ls_bdgt_year     	= idw_main[2].Object.bdgt_year.delete[ll_DelRow]	//회계년도
		 	ls_gwa        		= idw_main[2].Object.resol_gwa.delete[ll_DelRow]	//결의발생학과
			ls_acct_code     	= idw_main[2].Object.acct_code.delete[ll_DelRow]	//계정과목
		 	li_acct_class 		= idw_main[2].object.acct_class.delete[ll_DelRow]
			ldc_resol_amt 		= idw_main[2].Object.resol_amt.delete[ll_DelRow] 	//발의금액
			
			UPDATE	ACDB.HAC012M
			SET		ASSN_TEMP_AMT = NVL(ASSN_TEMP_AMT,0) - :ldc_resol_amt
			WHERE		BDGT_YEAR  = :ls_bdgt_year
			AND		GWA        = :ls_gwa
			AND		ACCT_CODE  = :ls_acct_code
			AND		ACCT_CLASS = :li_acct_class
			AND		IO_GUBUN   = :ls_slip_class ;
			
			if sqlca.sqlcode <> 0 then

			 	Rollback using sqlca ;
				wf_SetMsg('배정예산처리 중 오류가 발생하였습니다.')
				MessageBox('확인','배정예산처리 중 전산장애가 발생되었습니다.~r~n' + &
										'하단의 장애번호와 장애내역을~r~n' + &
										'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
										'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
										'장애내역 : ' + SQLCA.SqlErrText)
				RETURN 
			end if
//		END IF
	NEXT
END IF
//////////////////////////////////////////////////////////////////////////////////////////////


//부가세 삭제
if ib_tax_proc then
	ll_find = dw_tax.find("resol_no = '"+ls_ResolDate+String(li_ResolNo)+"'", 0, dw_tax.rowcount())

	do while ll_find <> 0
		dw_tax.DeleteRow(ll_find)
		ll_find = dw_tax.find("resol_no = '"+ls_ResolDate+String(li_ResolNo)+"'", ll_find, dw_tax.rowcount())
	loop
	
	if dw_tax.update() <> 1 then

		Rollback using sqlca ;
		wf_SetMsg('부가세정보 처리 중 오류가 발생하였습니다.')
		MessageBox('확인','부가세정보 처리 중 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
		RETURN
	end if
end if


// 결의이력 자료에 Update
if wf_hfn102h_proc(gi_acct_class, ls_resoldate, li_resolno, 3) <> 0 then

	Rollback using sqlca ;
	wf_SetMsg('결의이력정보 중 오류가 발생하였습니다.')
	MessageBox('확인','결의이력정보 처리 중 전산장애가 발생되었습니다.~r~n' + &
	 					   '하단의 장애번호와 장애내역을~r~n' + &
						   '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
						   '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
						   '장애내역 : ' + SQLCA.SqlErrText)
	RETURN
end if

DELETE	FROM	FNDB.HFN102M A
WHERE		A.ACCT_CLASS	=	:gi_acct_class
AND		A.RESOL_DATE	=	:LS_RESOLDATE
AND		A.RESOL_NO		=	:LI_RESOLNO ;

If	sqlca.sqlcode <> 0 Then

	Rollback Using Sqlca ;
	ls_Msg = '결의내역 삭제시 오류가 발생하였습니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인','결의내역 삭제처리 중 전산장애가 발생되었습니다.~r~n' + &
		 					'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	Return
End If

// 결의서 삭제처리
wf_SetMsg('결의서 자료를 삭제처리 중입니다.')

DELETE	FROM	FNDB.HFN101M A
WHERE		A.ACCT_CLASS	=	:gi_acct_class
AND		A.RESOL_DATE	=	:LS_RESOLDATE
AND		A.RESOL_NO		=	:LI_RESOLNO ;

If	sqlca.sqlcode <> 0 Then

	Rollback Using Sqlca ;
	ls_Msg = '결의서 삭제시 오류가 발생하였습니다.'
	MessageBox('확인','결의서 삭제처리 중 전산장애가 발생되었습니다.~r~n' + &
		 					'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	wf_SetMsg(ls_Msg)
	Return 
End If

Commit Using Sqlca ;

wf_SetMsg('자료가 삭제되었습니다.')

idw_main[1].Reset()
idw_main[1].InsertRow(0)
idw_main[1].Object.DataWindow.ReadOnly = 'YES'

idw_main[2].Reset()
idw_main[2].InsertRow(0)
idw_main[2].Object.DataWindow.ReadOnly = 'YES'

//wf_SetMenuBtn('RI')


end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
DwItemStatus	ldis_Status, ldis_Status_column
dwObject		ldwo_Object	
Integer			li_idx
Integer			li_ChgDw[]
Integer			li_Arr
string			ls_base_year
String			ls_NotNullCol[]
String			ls_Null[]
Long			ll_Row				//변경된행
DateTime		ldt_WorkDate		//등록일자
String			ls_Worker			//등록자
String			ls_IpAddr			//등록단말기
Boolean			lb_Start
Boolean			lb_StartLog
Integer			li_AcctClass		//회계단위
string			ls_slip_class		//결의구분
String			ls_ResolDate		//발의일자
Integer			li_ResolNo			//발의번호
Integer			li_ResolSeq			//발의항번
String			ls_DrcrClass		//차대구분
Integer			li_LogSeq			//이력순번
String			ls_LogDate			//이력일자
Integer			li_LogOpt			//이력구분
String			ls_BdgtCntlYn		//예산통제여부
String			ls_BdgtYear			//회계년도
String			ls_DeptCode			//부서코드
String			ls_AcctCode			//계정과목
Decimal			ldc_AssnTempAmt	//가집행금액
Decimal			ldc_old_AssnTempAmt	//가집행금액
Long			ll_DelRow
Long			ll_DelRowCnt
String			ls_Msg
Integer			li_Rtn
integer			li_log_opt
long 			ll_find

// 배정예산관리 집행금액, 가집행금액 update오류로 막음 (20041005:Jung Kwang Hoon)
////2003-12-01
//declare  proc_jiphaeng procedure for acdb.usp_jiphaeng_batch(:ls_BdgtYear,:ls_DeptCode,:ls_AcctCode,:li_acctclass,:ls_slip_class) ;

// 변경여부 CHECK
FOR li_idx = 1 TO UpperBound(idw_main)
	IF idw_main[li_idx].AcceptText() = -1 THEN
		idw_main[li_idx].SetFocus()
		RETURN -1
	END IF
	IF idw_main[li_idx].ModifiedCount() + &
		idw_main[li_idx].DeletedCount() > 0 THEN 
		li_Arr++
		li_ChgDw[li_Arr] = li_idx
	END IF
NEXT

IF li_Arr = 0 THEN
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

ls_base_year = idw_main[1].getitemstring(1, 'bdgt_year')

// 결산마감 확인
if f_chk_magam(gi_acct_class, ls_base_year) > 0 then return -1

// 필수입력항목 체크
wf_SetMsg('필수입력항목 체크 중입니다...')

FOR li_Arr = 1 TO UpperBound(li_ChgDw)
	li_idx = li_ChgDw[li_Arr]
	ls_NotNullCol = ls_Null
	CHOOSE CASE li_idx
		CASE 1	//발의서
			ls_NotNullCol[1] = 'resol_date/결의일자'
			ls_NotNullCol[2] = 'resol_dept/결의부서'
			ls_NotNullCol[3] = 'slip_class/결의구분'
		CASE 2	//발의서내역
			ls_NotNullCol[1] = 'acct_code/계정과목'
			ls_NotNullCol[2] = 'resol_amt/결의금액'
	END CHOOSE
	
	IF f_chk_null(idw_main[li_idx],ls_NotNullCol) = -1 THEN
		tab_1.SelectedTab = 1
		RETURN -1
	END IF
NEXT

// 저장처리전 체크사항 기술
wf_SetMsg('저장하시전에 체크사항을 처리 중입니다...')

// 결의금액이 0인 경우 처리 않됨.
FOR ll_row = 1 TO idw_main[2].rowcount()
	if isnull(idw_main[2].getitemnumber(ll_row, 'resol_amt')) or idw_main[2].getitemnumber(ll_row, 'resol_amt') = 0 then
		f_messagebox('1', '[' + string(ll_row) + ']항의 ' + ' 결의금액을 반드시 입력해 주세요.!')
		idw_main[2].scrolltorow(ll_row)
		idw_main[2].setcolumn('resol_amt')
		idw_main[2].setfocus()
		return	-1
	end if
NEXT

if wf_mana_chk_null(idw_main[2]) < 0 then return -1


//저장하기전에 세금계산서(계산서) 항목이 입력되었는지 체크하자.
if ib_tax_proc then 
	string	ls_resol_date, ls_tax_type
	integer	li_resol_no, li_resol_seq
	
	ls_resol_date	= idw_main[1].Object.resol_date[1]
	li_resol_no		= idw_main[1].Object.resol_no[1]
	if isnull(li_resol_no) then li_resol_no = 0
	
	for ll_row = 1 TO idw_main[2].rowcount()
		li_resol_seq	= idw_main[2].Object.resol_seq[ll_row]
		ls_tax_type 	= string(idw_main[2].Object.proof_gubun[ll_row])
		if isnull(li_resol_seq) then li_resol_seq = ll_row

		//계산서,세금계산서
		if ls_tax_type = '1' or ls_tax_type = '2' then	
			if wf_check_tax(ls_resol_date+String(li_resol_no), li_resol_seq) = false then 
				f_messagebox('1', '[' + string(ll_row) + ']항의 ' + ' 세금계산서(계산서)내용을 반드시 입력해 주세요.!')
				idw_main[2].scrolltorow(ll_row)
				idw_main[2].setfocus()
				return -1
			end if
		end if
	next

	// 결산마감 확인(월마감이 되었는지)
	if wf_chk_magam_tax() < 0 then return -1
end if
////////////////////////




li_AcctClass  = idw_main[1].Object.acct_class[1]	//회계단위
ls_ResolDate  = idw_main[1].Object.resol_date[1]	//결의일자
li_ResolNo    = idw_main[1].Object.resol_no  [1]	//결의번호
ls_DeptCode   = idw_main[1].Object.resol_gwa [1]	//부서코드
ls_slip_class = string(idw_main[1].object.slip_class[1])
ls_LogDate    = f_today()

// 이력구분
if isnull(li_resolno) or li_resolno = 0 then
	li_log_opt = 1
else
	li_log_opt = 2
end if

FOR li_Arr = 1 TO UpperBound(li_ChgDw)
	lb_Start    = TRUE
	lb_StartLog = TRUE
	li_idx      = li_ChgDw[li_Arr]
	ll_Row      = idw_main[li_idx].GetNextModified(0,primary!)
	
	IF ll_Row > 0 THEN
		ldt_WorkDate = f_sysdate()						//등록일자
		ls_Worker    = gs_empcode			//등록자
		ls_IpAddr    = gs_ip		//등록단말기
	END IF
	
	DO WHILE ll_Row > 0
		ldis_Status = idw_main[li_idx].GetItemStatus(ll_Row,0,Primary!)
		
		// 항목체크
		CHOOSE CASE li_idx
			CASE 1	// 결의서
				IF ldis_Status = New! OR ldis_Status = NewModified! THEN
					// 결의번호처리
					wf_SetMsg('결의번호 생성 중 입니다...')

					SELECT	NVL(MAX(A.RESOL_NO),0) + 1
					INTO		:li_ResolNo
					FROM		FNDB.HFN101M A
					WHERE		A.ACCT_CLASS = :li_AcctClass
					AND		A.RESOL_DATE = :ls_ResolDate;
					
					if sqlca.sqlcode <> 0 then
						rollback ;

						wf_SetMsg('결의번호 생성 중 오류가 발생하였습니다.')
						MessageBox('확인',&
									  '결의번호 생성시 전산장애가 발생되었습니다.~r~n' + &
									  '하단의 장애번호와 장애내역을~r~n' + &
									  '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									  '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
									  '장애내역 : ' + SQLCA.SqlErrText)
						RETURN -1
					end if

					idw_main[li_idx].Object.resol_no[ll_Row] = li_ResolNo
					
					//부가세 결의번호 update
					if ib_tax_proc then wf_update_resol_no(ls_ResolDate + '0', ls_ResolDate + String(li_ResolNo))
				END IF
			CASE 2	// 결의서내역
				idw_main[li_idx].Object.acct_class[ll_Row] = li_AcctClass	//회계단위
				idw_main[li_idx].Object.resol_date[ll_Row] = ls_ResolDate	//결의일자
				idw_main[li_idx].Object.resol_no  [ll_Row] = li_ResolNo		//결의번호

				// 결의항번처리
				IF ldis_Status = New! OR ldis_Status = NewModified! THEN
					wf_SetMsg('결의항번 생성 중 입니다...')
					
					IF lb_Start THEN
						lb_Start = FALSE
						SELECT	NVL(MAX(A.RESOL_SEQ),0) + 1
						INTO		:li_ResolSeq
						FROM		FNDB.HFN102M A
						WHERE		A.ACCT_CLASS = :li_AcctClass
						AND		A.RESOL_DATE = :ls_ResolDate
						AND		A.RESOL_NO   = :li_ResolNo;
						
						if sqlca.sqlcode <> 0 then
							rollback ;

							wf_SetMsg('결의항번 생성 중 오류가 발생하였습니다.')
							MessageBox('확인',&
										  '결의항번 생성시 전산장애가 발생되었습니다.~r~n' + &
										  '하단의 장애번호와 장애내역을~r~n' + &
										  '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
										  '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
										  '장애내역 : ' + SQLCA.SqlErrText)
							RETURN -1
						end if
					ELSE
						li_ResolSeq++
					END IF
					idw_main[li_idx].Object.resol_seq[ll_Row] = li_ResolSeq

					//부가세 결의항번 update
					if ib_tax_proc then 
						if ll_row <> li_ResolSeq then wf_update_resol_seq(ls_ResolDate + String(li_ResolNo), ll_Row, li_ResolSeq)
					end if
				END IF

				// 배정예산(HAC012M) 변경처리
				ls_BdgtYear    	  = idw_main[2].Object.bdgt_year[ll_Row]			//회계년도
				ls_AcctCode         = idw_main[2].Object.acct_code[ll_Row]			//계정과목
				ldc_AssnTempAmt     = idw_main[2].Object.resol_amt[ll_Row] 			//결의금액
				ldc_old_AssnTempAmt = idw_main[2].Object.com_resol_amt[ll_Row] 	//결의금액
					
				IF isNull(ldc_AssnTempAmt) THEN ldc_AssnTempAmt = 0
				IF isNull(ldc_old_AssnTempAmt) THEN ldc_old_AssnTempAmt = 0
					
				ldis_Status_column = idw_main[2].GetItemStatus(ll_Row, 'resol_amt', Primary!)

				IF ldis_Status_column = New! or ldis_Status_column = NewModified! or ldis_Status_column = DataModified! THEN
					UPDATE	ACDB.HAC012M
					SET		ASSN_TEMP_AMT = NVL(ASSN_TEMP_AMT,0) + :ldc_AssnTempAmt - :ldc_old_assntempamt
					WHERE		BDGT_YEAR  = :ls_BdgtYear
					AND		GWA        = :ls_DeptCode
					AND		ACCT_CODE  = :ls_AcctCode
					AND		ACCT_CLASS = :li_acctclass
					AND		IO_GUBUN   = :ls_slip_class ;
						
					if sqlca.sqlcode <> 0 then
						rollback ;

						wf_SetMsg('배정예산처리 중 오류가 발생하였습니다.')
						MessageBox('확인','배정예산처리 중 전산장애가 발생되었습니다.~r~n' + &
												'하단의 장애번호와 장애내역을~r~n' + &
												'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
												'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
												'장애내역 : ' + SQLCA.SqlErrText)
						RETURN -1
					end if
				end if
		END CHOOSE
		
		IF ldis_Status = New! OR ldis_Status = NewModified! THEN
			idw_main[li_idx].Object.worker   [ll_Row] = ls_Worker		//등록자
			idw_main[li_idx].Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
			idw_main[li_idx].Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
		END IF
		
		// 수정항목 처리
		idw_main[li_idx].Object.job_uid  [ll_Row] = ls_Worker			//등록자
		idw_main[li_idx].Object.job_add  [ll_Row] = ls_IpAddr			//등록단말기
		idw_main[li_idx].Object.job_date [ll_Row] = ldt_WorkDate		//등록일자
		
		ll_Row = idw_main[li_idx].GetNextModified(ll_Row,primary!)
	LOOP
NEXT

// 자료삭제시 처리
// 결의서내역 삭제시 처리
lb_StartLog = TRUE
li_LogSeq = 0
ll_DelRowCnt = idw_main[2].DeletedCount()

IF ll_DelRowCnt > 0 THEN
	FOR ll_DelRow = ll_DelRowCnt TO 1 STEP -1 
		// 배정예산(HAC012M) 변경처리
		ls_BdgtCntlYn = idw_main[2].Object.bdgt_cntl_yn.delete[ll_DelRow]
		
//		IF ls_BdgtCntlYn = 'Y' THEN	//예산통제여부 삭제(20041008 : Jung Kwang Hoon)
			ls_BdgtYear     = idw_main[2].Object.bdgt_year.delete[ll_DelRow]	//회계년도
			ls_AcctCode     = idw_main[2].Object.acct_code.delete[ll_DelRow]	//계정과목
			ldc_AssnTempAmt = idw_main[2].Object.resol_amt.delete[ll_DelRow] 	//발의금액
			
			IF isNull(ldc_AssnTempAmt) THEN ldc_AssnTempAmt = 0
			
			UPDATE	ACDB.HAC012M
			SET		ASSN_TEMP_AMT = NVL(ASSN_TEMP_AMT,0) - :ldc_AssnTempAmt
			WHERE		BDGT_YEAR  = :ls_BdgtYear
			AND		GWA        = :ls_DeptCode
			AND		ACCT_CODE  = :ls_AcctCode
			AND		ACCT_CLASS = :li_acctclass
			AND		IO_GUBUN   = :ls_slip_class ;
			
			if sqlca.sqlcode <> 0 then
				rollback ;

				wf_SetMsg('배정예산처리 중 오류가 발생하였습니다.')
				MessageBox('확인','배정예산처리 중 전산장애가 발생되었습니다.~r~n' + &
										'하단의 장애번호와 장애내역을~r~n' + &
										'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
										'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
										'장애내역 : ' + SQLCA.SqlErrText)
				RETURN -1
			end if
//		END IF
	NEXT
END IF


//////////////////////////////////////
//부가세 저장...
if ib_tax_proc then 
	if wf_save_tax() <> 1 then
		rollback ;

		MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
		RETURN -1
	end if
end if
//////////////////////////////////////


// 자료저장처리
FOR li_Arr = 1 TO UpperBound(li_ChgDw)
	ls_Msg = '변경된 자료를 저장 중 입니다...'
	li_idx = li_ChgDw[li_Arr]
	wf_SetMsg(ls_Msg)
	li_Rtn = idw_main[li_idx].UPDATE()
	IF li_Rtn <> 1 THEN EXIT
NEXT

IF li_Rtn <> 1 THEN
	rollback ;

	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN -1
END IF

// 배정예산관리 집행금액, 가집행금액 update오류로 막음 (20041005:Jung Kwang Hoon)
////procedure 2003-12-01
//execute proc_jiphaeng ;

// 결의이력정보 Update
IF wf_hfn102h_proc(li_acctclass, ls_resoldate, li_resolno, li_log_opt) <> 0 THEN
	rollback ;

	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN -1
END IF

COMMIT USING SQLCA;

idw_main[1].SetReDraw(TRUE)
idw_main[2].SetReDraw(TRUE)


// 결의서 출력 조회
ll_Row = idw_main[2].GetRow()
IF ll_Row = 0 THEN
	idw_main[3].Reset()
//	wf_SetMenu('P',FALSE)
END IF

li_ResolSeq  = idw_main[2].Object.resol_seq [ll_Row]	//결의항번

// 메세지, 메뉴버튼 활성/비활성화 처리

wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSR')
idw_main[1].SetFocus()


//20041203 Jung Kwang Hoon : 결의서 삭제시 부가세 오류가 나는것을 막기위해 저장하면 리스트 retrieve
/*
idw_main[3].SetReDraw(FALSE)
ll_Row = idw_main[3].Retrieve(ii_AcctClass, ls_ResolDate, li_ResolNo)
dw_all.Retrieve(ii_AcctClass, ls_ResolDate, li_ResolNo)
idw_main[3].SetReDraw(TRUE)

IF ll_Row > 0 THEN
	wf_SetMenu('P',TRUE)
ELSE
	wf_SetMenu('P',FALSE)
END IF
*/

THIS.TRIGGER EVENT ue_retrieve()

ll_find = dw_list.find("acct_class = "+string(gi_acct_class)+" and resol_date = '"+ls_ResolDate+"' and resol_no = "+String(li_ResolNo), 0, dw_list.rowcount())

if ll_find > 0 then
	dw_list.trigger event rowfocuschanging(0, ll_find)
	dw_list.ScrollToRow(ll_find)
end if
///////////////////////////////

RETURN 1

end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//tab_1.SelectTab(2)
//f_print(tab_1.tabpage_2.dw_print)
//
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 결의서등록.
//	작 성 인 : 이현수
//	작성일자 : 2002.11
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
datawindowchild	ldwc_temp
string				ls_str_date, ls_last_date

if gs_empcode = 'F0018'or gs_empcode = 'F0057' or gs_empcode = 'F0092' or gs_empcode = 'admin' then
	dw_con.Object.code.Background.mode = 0
	dw_con.object.code.protect = 0 
else
	dw_con.Object.code.Background.mode = 1
	dw_con.object.code.protect = 1
end if

idw_main[01] = tab_1.tabpage_1.dw_update1
idw_main[02] = tab_1.tabpage_1.dw_update2
idw_main[03] = tab_1.tabpage_2.dw_print
idw_print =  tab_1.tabpage_2.dw_print
dw_con.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve(1, 3) = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF

dw_con.Object.code[1] = gs_DeptCode

dw_con.object.slip_class[1] = '2'

ls_str_date  = f_today()
ls_last_date = f_lastdate(f_today())

dw_con.object.fr_date[1] = date(left(ls_str_date,4) + '/' + mid(ls_str_date,5,2) + '/' + right(ls_str_date,2))
dw_con.object.to_Date[1] = date(left(ls_last_date,4) + '/' + mid(ls_last_date,5,2) + '/' + right(ls_last_date,2))

// 발의서내역 데이타원도우 DDDW초기화
// 관리항목 DDDW초기화처리
idw_main[2].GetChild('mana_code1',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF

idw_main[2].GetChild('mana_code2',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF

idw_main[2].GetChild('mana_code3',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF

// 증빙종류 DDDW초기화처리
idw_main[2].GetChild('proof_gubun',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('proof_gubun', 0) = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF

idw_main[3].GetChild('proof_gubun',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('proof_gubun', 0) = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF

dw_all.GetChild('proof_gubun',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('proof_gubun', 0) = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF

THIS.TRIGGER EVENT ue_init()

//부가세
ib_tax_proc = true
//if gs_empcode = 'F0012'or gs_empcode = 'F0092' then
//	cbx_tax.visible = true
//else
//	cbx_tax.visible = false
//end if

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hfn201a
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn201a
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn201a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn201a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn201a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn201a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn201a
end type

type uc_insert from w_msheet`uc_insert within w_hfn201a
end type

type uc_delete from w_msheet`uc_delete within w_hfn201a
end type

type uc_save from w_msheet`uc_save within w_hfn201a
end type

type uc_excel from w_msheet`uc_excel within w_hfn201a
end type

type uc_print from w_msheet`uc_print within w_hfn201a
end type

type st_line1 from w_msheet`st_line1 within w_hfn201a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn201a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn201a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn201a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn201a
end type

type dw_tax from datawindow within w_hfn201a
boolean visible = false
integer x = 197
integer y = 500
integer width = 3479
integer height = 632
integer taborder = 70
boolean titlebar = true
string title = "부가세 관련 Datawindow"
string dataobject = "d_hfn201a_tax"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

event retrieveend;long 		ll_row

for ll_row = 1 to this.rowcount()
	this.setitem(ll_row, 'com_row', ll_row)
next

end event

type dw_list from cuo_dwwindow_one_hin within w_hfn201a
integer x = 50
integer y = 300
integer width = 4384
integer height = 840
integer taborder = 60
string dataobject = "d_hfn201a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;//Override
String	ls_ColName
ls_ColName = UPPER(dwo.name)
IF ls_ColName = 'DATAWINDOW' THEN RETURN

IF THIS.RowCount() > 0 AND UPPER(RIGHT(ls_ColName,2)) = '_T' AND ib_SortGubn THEN
	THIS.TRIGGER EVENT ue_et_sort()
	
	Long	ll_SelectRow
	ll_SelectRow = THIS.getrow()
	THIS.SetRedraw(FALSE)
	IF ll_SelectRow = 0 THEN ll_SelectRow = 1
	THIS.ScrollToRow(ll_SelectRow)
	THIS.SetRedraw(TRUE)
	RETURN 1
END IF

end event

event rowfocuschanging;/////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: rowfocuschanging
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
String	ls_ResolDate
Integer	li_ResolNo
Integer	li_StepOpt
Integer	li_GensisGb

ll_GetRow = newrow
IF ll_GetRow = 0 THEN RETURN

ll_RowCnt = THIS.RowCount()

IF ll_RowCnt = 0 THEN
	idw_main[1].SetReDraw(FALSE)
	idw_main[1].Reset()
	idw_main[1].InsertRow(0)
	idw_main[1].Object.DataWindow.ReadOnly = 'YES'
	idw_main[1].SetReDraw(TRUE)

	idw_main[2].SetReDraw(FALSE)
	idw_main[2].Reset()
	idw_main[2].InsertRow(0)
	idw_main[2].Object.DataWindow.ReadOnly = 'YES'
	idw_main[2].SetReDraw(TRUE)
	
	if ib_tax_proc then dw_tax.Reset()
	
	RETURN
END IF

// 조회조건
ls_ResolDate = dw_list.Object.resol_date[ll_GetRow]
li_ResolNo   = dw_list.Object.resol_no  [ll_GetRow]
li_StepOpt   = dw_list.Object.step_opt  [ll_GetRow]
li_GensisGb  = dw_list.Object.genesis_gb[ll_GetRow]

// 자료조회
wf_SetMsg('[결의서] 조회중입니다...')

idw_main[1].SetReDraw(FALSE)
idw_main[1].Reset()
idw_main[1].Retrieve(gi_acct_class,ls_ResolDate,li_ResolNo)
idw_main[1].SetReDraw(TRUE)

//	결의서내역 조회처리
idw_main[2].SetReDraw(FALSE)
idw_main[2].Reset()
idw_main[2].Retrieve(gi_acct_class,ls_ResolDate,li_ResolNo)

// 결의상태가 전환이면 변경불가처리
//ddlb_slip_class.Enabled = FALSE
dw_con.object.slip_class.protect = 1

IF li_StepOpt > 1 OR li_GensisGb = 1 THEN
	wf_SetMsg('결의상태가 결의서작성이거나 발생구분이 결의인 자료만 변경이 가능합니다.')
	idw_main[1].Object.DataWindow.ReadOnly = 'YES'
	idw_main[2].Object.DataWindow.ReadOnly = 'YES'
//	wf_SetMenuBtn('IR')
ELSE
	wf_SetMsg('[결의서] 자료가 조회되었습니다.')
	idw_main[1].Object.DataWindow.ReadOnly = 'NO'
	idw_main[2].Object.DataWindow.ReadOnly = 'NO'
	
	//계정코드 변경불가(2004.09.16)...
	idw_main[2].Object.acct_code.Protect 		= 1
	idw_main[2].Object.com_acct_name.Protect 	= 1
	
//	wf_SetMenuBtn('IDSR')
END IF
idw_main[2].SetReDraw(TRUE)

// 결의서출력 조회처리
idw_main[3].SetReDraw(FALSE)
idw_main[3].Retrieve(gi_acct_class, ls_ResolDate, li_ResolNo)
dw_all.Retrieve(gi_acct_class, ls_ResolDate, li_ResolNo)
idw_main[3].SetReDraw(TRUE)
IF ll_RowCnt > 0 THEN
//	wf_SetMenu('P',TRUE)
ELSE
//	wf_SetMenu('P',FALSE)
END IF


//부가세 출력처리
if ib_tax_proc then
	integer li_slip_class
	string ls_bdgt_year

	li_slip_class 	= this.Object.slip_class[ll_GetRow]
	ls_bdgt_year 	= this.Object.bdgt_year[ll_GetRow]
	
	if li_slip_class = 1 then			//수입 -> 매출
		dw_tax.retrieve(gi_acct_class, '', '2', ls_bdgt_year, ls_ResolDate + string(li_ResolNo))
	elseif li_slip_class = 2 then		//지출 -> 매입
		dw_tax.retrieve(gi_acct_class, '', '1', ls_bdgt_year, ls_ResolDate + string(li_ResolNo))
	end if

end if

end event

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

type dw_con from uo_dwfree within w_hfn201a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hfn201a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
end event

event itemchanged;call super::itemchanged;parent.triggerevent('ue_retrieve')
end event

type uo_tab from u_tab within w_hfn201a
event destroy ( )
integer x = 1509
integer y = 1280
integer taborder = 130
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

type tab_1 from tab within w_hfn201a
integer x = 50
integer y = 1188
integer width = 4384
integer height = 1112
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;if newindex = 2 then
	if idw_main[3].rowcount() > 0 then
		cb_preview.visible = true
	end if
else
	cb_preview.visible = false
end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 992
string text = "결의서관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update1 dw_update1
dw_update2 dw_update2
end type

on tabpage_1.create
this.dw_update1=create dw_update1
this.dw_update2=create dw_update2
this.Control[]={this.dw_update1,&
this.dw_update2}
end on

on tabpage_1.destroy
destroy(this.dw_update1)
destroy(this.dw_update2)
end on

type dw_update1 from uo_dwfree within tabpage_1
integer y = 8
integer width = 4343
integer height = 224
integer taborder = 70
string dataobject = "d_hfn201a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update1
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
String	ls_Null
Integer	li_Null
String	ls_Find
Long		ll_Find, ll_row
String	ls_BdgtYear

wf_SetMsg('')

// 항목 변경시 처리
ls_ColName = STRING(dwo.name)
ls_ColData = TRIM(data)
SetNull(ls_Null)
SetNull(li_Null)

CHOOSE CASE ls_ColName
	CASE 'resol_date'
		//	일자변경시 처리
		IF NOT f_isdate(ls_ColData) THEN
			setitem(row, 'resol_date', '')
			return 1
		end if
		
		SELECT	BDGT_YEAR	INTO	:LS_BDGTYEAR
		FROM		ACDB.HAC003M
		WHERE		:LS_COLDATA BETWEEN FROM_DATE AND TO_DATE
		AND		BDGT_CLASS = 0
		AND		STAT_CLASS = 0 ;
		
		if isnull(ls_bdgtyear) or trim(ls_bdgtyear) = '' then
			setitem(row, ls_ColName, '')
			messagebox('확인', '회계사용기간 설정이 되어 있지 않습니다.~r~r' + &
			                   '예산부서에 회계사용기간의 설정을 문의하시기 바랍니다.')
			return 1
		end if
		
		if f_chk_magam(gi_acct_class, left(data,6)) > 0 then
			setitem(row, 'resol_date', '')
			return 1
		end if
		
		if f_chk_magam(gi_acct_class, ls_BdgtYear) > 0 then
			setitem(row, 'resol_date', '')
			return 1
		end if

		THIS.Object.bdgt_year[row] = ls_BdgtYear
		
		for ll_row = 1 to dw_update2.rowcount()
			dw_update2.object.bdgt_year[ll_row] = ls_BdgtYear
		next

		//부가세 관련 
		if ib_tax_proc then
			String	ls_resol_no_org
			
			//부가세 Data를 변경.
			for ll_row = 1 to dw_tax.rowcount()
				ls_resol_no_org = dw_tax.getItemString(ll_row, 'resol_no')
				dw_tax.setItem(ll_row, 'resol_no', data + right(ls_resol_no_org, len(ls_resol_no_org) - len(data)))
			next
		end if
	CASE 'remark'
		// 공통적요를 처리
		if idw_main[2].rowcount() < 1 then return
		
		if isnull(idw_main[2].getitemstring(1, 'remark')) or trim(idw_main[2].getitemstring(1, 'remark')) = '' then
			idw_main[2].setitem(1, 'remark', trim(data))
		end if
	CASE ELSE
END CHOOSE

end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: buttonclikced::dw_update1
//	기 능 설 명: 결의내역에 항추가 및 삭제처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
String	ls_ColName 
String	ls_ColData
Long		ll_RowCnt
Long		ll_InsRow
Long		ll_GetRow
String	ls_AcctCode
String	ls_AcctName
Integer	li_ResolSeq, li_slipclass
Long		ll_DelRow

wf_SetMsg('')

IF row = 0 THEN RETURN

IF UPPER(THIS.Object.DataWindow.ReadOnly) = 'YES' THEN RETURN

dw_con.accepttext()
li_slipclass = Integer(dw_con.object.slip_class[1])

// 결의내역에 항추가 및 삭제처리
ls_ColName = STRING(dwo.name)
ll_RowCnt  = dw_update2.RowCount()

CHOOSE CASE ls_ColName
	CASE 'btn_insert'
		// 항추가처리
		// 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
		dw_update2.SetReDraw(FALSE)

		ll_InsRow = dw_update2.InsertRow(0)
		
		if li_slipclass = 1 then
			dw_update2.Object.drcr_class[ll_InsRow] = 'C'
		else
			dw_update2.Object.drcr_class[ll_InsRow] = 'D'
		end if
		dw_update2.Object.acct_class [ll_InsRow] = gi_acct_class
		dw_update2.Object.proof_gubun[ll_InsRow] = 0
		dw_update2.Object.bdgt_year  [ll_InsRow] = idw_main[1].Object.bdgt_year[1]		//회계년도
		dw_update2.Object.resol_gwa  [ll_InsRow] = idw_main[1].Object.resol_gwa[1]		//결의부서
		dw_update2.Object.remark     [ll_InsRow] = trim(idw_main[1].Object.remark[1])	//적요
		dw_update2.Object.DataWindow.ReadOnly   = 'NO'

		dw_update2.SetReDraw(TRUE)
		
		dw_update2.SetItemStatus(ll_InsRow,0,Primary!,NotModified!)
		
		// 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우로 포커스이동
		wf_SetMsg('[결의내역] 자료가 추가되었습니다.')

		dw_update2.scrolltorow(ll_insrow)
		dw_update2.SetColumn('acct_code')
		dw_update2.SetFocus()
	CASE 'btn_delete'
		// 항삭제처리
		ll_GetRow = dw_update2.GetRow()
		
		IF ll_GetRow = 0 THEN RETURN
		
		ls_AcctCode = TRIM(dw_update2.Object.acct_code    [ll_GetRow])
		ls_AcctName = TRIM(dw_update2.Object.com_acct_name[ll_GetRow])
		li_ResolSeq = dw_update2.Object.resol_seq[ll_GetRow]
		
		if isnull(li_ResolSeq) then li_ResolSeq = ll_GetRow
		
		ls_Msg = '결의서내역 자료를 삭제하시겠습니까?~r~n~r~n'+&
					'계정코드 : ' + String(ls_AcctCode,'@-@@@@-@@') + '~r~n' + &
					'계 정 명 : ' + ls_AcctName + '~r~n' + &
					'결의항번 : ' + String(li_ResolSeq)

		IF MessageBox('확인','자료를 삭제하시겠습니까?~r~n'+ls_Msg,Question!,YesNo!,2) = 2 THEN RETURN

		// 집행누계액(가집행금액) 재계산 (20031120 Jung Kwang Hoon) ...
		wf_update_temp_amt('Delete', dw_update2, ll_GetRow, ls_AcctCode, 0)
		

		/////////////////////////////////////////////
		//부가세 관련 삭제
		if ib_tax_proc then
			String	ls_tax_type, ls_resol_date
			Integer	li_slip_class, li_resol_no
			
			li_slip_class 	= this.Object.slip_class[row]
			ls_resol_date	= this.Object.resol_date[row]
			li_resol_no		= this.Object.resol_no[row]
			ls_tax_type		= string(dw_update2.Object.proof_gubun[ll_GetRow])

			if isnull(li_resol_no) then li_resol_no = 0
			
			if ls_tax_type = '1' or ls_tax_type = '2' then
				wf_delete_tax(ls_tax_type, li_slip_class, ls_resol_date+string(li_resol_no), string(li_ResolSeq))
			end if
		end if
		/////////////////////////////////////////////

		
		// 발의내역자료 삭제
		dw_update2.SetReDraw(FALSE)
		ll_DelRow = dw_update2.DeleteRow(ll_GetRow)
		dw_update2.SetReDraw(TRUE)
		
		IF ll_DelRow <> 1 THEN RETURN
		
		IF dw_update2.RowCount() = 0 THEN
			dw_update2.SetReDraw(FALSE)
			dw_update2.InsertRow(0)
			dw_update2.Object.DataWindow.ReadOnly = 'NO'
			dw_update2.SetReDraw(TRUE)
		END IF
	CASE ELSE
		
END CHOOSE

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_update2 from uo_dwfree within tabpage_1
integer y = 232
integer width = 4338
integer height = 760
integer taborder = 70
string dataobject = "d_hfn201a_3"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event buttonclicked;call super::buttonclicked;integer li_slip_class, li_resol_no, li_resol_seq
string ls_tax_type, ls_tax_gubun, ls_resol_date

		
if ib_tax_proc then
	if dwo.name = 'b_tax' then	

		li_slip_class 	= dw_update1.Object.slip_class[1]
		ls_resol_date	= dw_update1.Object.resol_date[1]
		li_resol_no		= dw_update1.Object.resol_no[1]
		li_resol_seq	= this.Object.resol_seq[row]
		ls_tax_type 	= string(this.Object.proof_gubun[row])

		if isnull(li_resol_no) then li_resol_no = 0
		if isnull(li_resol_seq) then li_resol_seq = row

		if ls_tax_type = '1' or ls_tax_type = '2' then
			wf_open_tax(ls_tax_type, li_slip_class, ls_resol_date+string(li_resol_no), string(li_resol_seq))
		end if
	end if
else
	
end if

end event

event doubleclicked;call super::doubleclicked;if row < 1 then return

// 관리항목 도움말 정보 조회
choose case dwo.name
	case 'mana_data1', 'mana_data2', 'mana_data3', 'mana_data4'
		f_mana_data_help(this, row, dwo.name)
end choose

end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update1
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com, lstr_Rtn
string		ls_data, ls_acct_code, ls_acct_name, ls_bdgt_cntl_yn, ls_drcr_class
string		ls_com_drcr_class, ls_com_mi_gubun
integer		li_mana_code1, li_mana_code2, li_mana_code3, li_mana_code4, li_mana_code
long			ll_cnt
String	ls_resoldept
Integer	li_slipclass
dw_con.accepttext()
ls_resoldept = dw_con.object.code[1]
li_slipclass = Integer(dw_con.object.slip_class[1])

ls_drcr_class = getitemstring(row, 'drcr_class')

choose case dwo.name
	case 'acct_code', 'com_acct_name'
		ls_data = trim(data)
		
		if dwo.name = 'acct_code' then
			if li_slipclass = 1 then
				select	count(*)	into	:ll_cnt	from	acdb.hac001m
				where		acct_code	like	:ls_data||'%'
				and		suip_gubun	=		'Y'
				and		level_class	=		'4' ;
			else
				select	count(*)	into	:ll_cnt	from	acdb.hac001m
				where		acct_code	like	:ls_data||'%'
				and		jichul_gubun	=		'Y'
				and		level_class		=		'4' ;
			end if
		else
			if li_slipclass = 1 then
				select	count(*)	into	:ll_cnt	from	acdb.hac001m
				where		acct_name	like	'%'||:ls_data||'%'
				and		suip_gubun	=		'Y'
				and		level_class	=		'4' ;
			else
				select	count(*)	into	:ll_cnt	from	acdb.hac001m
				where		acct_name	like	'%'||:ls_data||'%'
				and		jichul_gubun	=		'Y'
				and		level_class		=		'4' ;
			end if
		end if
		
		if ll_cnt < 1 then
			messagebox('확인', '등록된 계정이 없습니다.')
			setitem(row, 'acct_code', '')
			setitem(row, 'com_acct_name', '')
			return 1
		end if
		
		if ll_cnt = 1 then
			if dwo.name = 'acct_code' then
				if li_slipclass = 1 then
					select	acct_code, acct_name, bdgt_cntl_yn, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn, mana_code
					into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun, :li_mana_code
					from		acdb.hac001m
					where		acct_code	like	:ls_data||'%'
					and		suip_gubun		=		'Y'
					and		level_class		=		'4' ;
				else
					select	acct_code, acct_name, bdgt_cntl_yn, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn, mana_code
					into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun, :li_mana_code
					from		acdb.hac001m
					where		acct_code	like	:ls_data||'%'
					and		jichul_gubun	=		'Y'
					and		level_class		=		'4' ;
				end if
			else
				if li_slipclass = 1 then
					select	acct_code, acct_name, bdgt_cntl_yn, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn, mana_code
					into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun, :li_mana_code
					from		acdb.hac001m
					where		acct_iname	like	'%'||:ls_data||'%'
					and		suip_gubun		=		'Y'
					and		level_class		=		'4' ;
				else
					select	acct_code, acct_name, bdgt_cntl_yn, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn, mana_code
					into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun, :li_mana_code
					from		acdb.hac001m
					where		acct_oname	like	'%'||:ls_data||'%'
					and		jichul_gubun	=		'Y'
					and		level_class		=		'4' ;
				end if
			end if
			
			setitem(row, 'acct_code', ls_acct_code)
			setitem(row, 'com_acct_name', ls_acct_name)
			setitem(row, 'bdgt_cntl_yn', ls_bdgt_cntl_yn)
			setitem(row, 'com_drcr_class', ls_com_drcr_class)
			setitem(row, 'com_mana_code', li_mana_code)
			setitem(row, 'com_mi_gubun', ls_com_mi_gubun)
			setitem(row, 'mana_code1', li_mana_code1)
			if li_mana_code1 = 0 then setitem(row, 'mana_data1', '')
			setitem(row, 'mana_code2', li_mana_code2)
			if li_mana_code2 = 0 then setitem(row, 'mana_data2', '')
			setitem(row, 'mana_code3', li_mana_code3)
			if li_mana_code3 = 0 then setitem(row, 'mana_data3', '')
			setitem(row, 'mana_code4', li_mana_code4)
			if li_mana_code4 = 0 then setitem(row, 'mana_data4', '')
			wf_hac012m_proc(this, row, getitemstring(row, 'bdgt_year'), ls_resoldept, & 
							    getitemstring(row, 'acct_code'), gi_acct_class, string(li_slipclass))
					    
							    
			if getitemstring(row, 'bdgt_cntl_yn') = 'Y' and getitemnumber(row, 'resol_amt') > getitemnumber(row, 'com_jan_amt') then
				setitem(row, 'resol_amt', 0)
				messagebox('확인', '사용할 수 있는 예산잔액보다 결의금액이 클 수 없습니다.')
			end if
			return 1
		else
			if dwo.name = 'acct_code' then
				lstr_com.ls_item[1] = trim(data)
				lstr_com.ls_item[2] = ''
				lstr_com.ls_item[3] = string(gi_acct_class)
				lstr_com.ls_item[4] = string(li_slipclass)
				lstr_com.ls_item[5] = ls_drcr_class
			else
				lstr_com.ls_item[1] = ''
				lstr_com.ls_item[2] = trim(data)
				lstr_com.ls_item[3] = string(gi_acct_class)
				lstr_com.ls_item[4] = string(li_slipclass)
				lstr_com.ls_item[5] = ls_drcr_class
			end if
			
			openwithparm(w_hfn002h, lstr_com)
			
			lstr_rtn = message.powerobjectparm
			
			if not isvalid(lstr_rtn) then
				setitem(row, 'acct_code', '')
				setitem(row, 'com_acct_name', '')
				return 1
			end if
			
			ls_acct_code	   = lstr_rtn.ls_item[1]
			ls_acct_name 	   = lstr_rtn.ls_item[2]
			ls_com_drcr_class = lstr_rtn.ls_item[3]
			ls_bdgt_cntl_yn   = lstr_rtn.ls_item[4]
			li_mana_code1	   = integer(lstr_rtn.ls_item[5])
			li_mana_code2	   = integer(lstr_rtn.ls_item[6])
			li_mana_code3	   = integer(lstr_rtn.ls_item[7])
			li_mana_code4	   = integer(lstr_rtn.ls_item[8])
			li_mana_code		= integer(lstr_rtn.ls_item[9])
			ls_com_mi_gubun	= lstr_rtn.ls_item[10]
			
			setitem(row, 'acct_code', ls_acct_code)
			setitem(row, 'com_acct_name', ls_acct_name)
			setitem(row, 'bdgt_cntl_yn', ls_bdgt_cntl_yn)
			setitem(row, 'com_drcr_class', ls_com_drcr_class)
			setitem(row, 'com_mana_code', li_mana_code)
			setitem(row, 'com_mi_gubun', ls_com_mi_gubun)
			setitem(row, 'mana_code1', li_mana_code1)
			if li_mana_code1 = 0 then setitem(row, 'mana_data1', '')
			setitem(row, 'mana_code2', li_mana_code2)
			if li_mana_code2 = 0 then setitem(row, 'mana_data2', '')
			setitem(row, 'mana_code3', li_mana_code3)
			if li_mana_code3 = 0 then setitem(row, 'mana_data3', '')
			setitem(row, 'mana_code4', li_mana_code4)
			if li_mana_code4 = 0 then setitem(row, 'mana_data4', '')
		end if
		wf_hac012m_proc(this, row, getitemstring(row, 'bdgt_year'), ls_resoldept, &
						    getitemstring(row, 'acct_code'), gi_acct_class, string(li_slipclass))
		if getitemstring(row, 'bdgt_cntl_yn') = 'Y' and getitemnumber(row, 'resol_amt') > getitemnumber(row, 'com_jan_amt') then
			setitem(row, 'resol_amt', 0)
			messagebox('확인', '사용할 수 있는 예산잔액보다 결의금액이 클 수 없습니다.')
		end if
		return 1
	case 'proof_gubun'
		
		if data = '0' then setitem(row, 'proof_date', '')
		
		//부가세 입력
		if ib_tax_proc then
			if data <> '1' and data <> '2' then
				this.Object.b_tax.visible = 0
			else
				this.Object.b_tax.visible = 1
			end if
			
			integer 	li_slip_class, li_resol_no, li_resol_seq
			string 	ls_tax_gubun, ls_resol_date

			li_slip_class 	= dw_update1.Object.slip_class[1]
			ls_resol_date	= dw_update1.Object.resol_date[1]
			li_resol_no		= dw_update1.Object.resol_no[1]
			li_resol_seq	= this.Object.resol_seq[row]
			
			if isnull(li_resol_no) then li_resol_no = 0
			if isnull(li_resol_seq) then li_resol_seq = row

			//(세금)계산서->다른것 으로 변경시 이미 저장된 데이타가 있다면 삭제한다.
			if data <> '1' and data <> '2' then
				wf_delete_tax('', li_slip_class, ls_resol_date+string(li_resol_no), string(li_resol_seq))
			end if
			
			//부가세 입력 창 오픈
			if data = '1' or data = '2' then
				wf_open_tax(data, li_slip_class, ls_resol_date+string(li_resol_no), string(li_resol_seq))
			end if
		else
			this.Object.b_tax.visible = 0
		end if
		
	case 'proof_date'
		if isnull(data) or trim(data) = '' then return
		
		if not isdate(mid(data,1,4) + '/' + mid(data,5,2) + '/' + mid(data,7,2)) then
			messagebox('확인', '증빙일자를 올바르게 입력하시기 바랍니다.')
			setitem(row, 'proof_date', '')
			return 1
		end if
	case 'resol_amt'
		wf_hac012m_proc(this, row, getitemstring(row, 'bdgt_year'), ls_resoldept, &
						    getitemstring(row, 'acct_code'), gi_acct_class, string(li_slipclass))

		if getitemstring(row, 'bdgt_cntl_yn') = 'Y' and dec(data) > getitemnumber(row, 'com_jan_amt') then
			setitem(row, 'resol_amt', 0)
			messagebox('확인', '사용할 수 있는 예산잔액보다 결의금액이 클 수 없습니다.')
			return 1
		end if

		// 집행누계액(가집행금액) 재계산 (20031120 Jung Kwang Hoon) ...
//		wf_update_temp_amt('ItemChanged', this, row, getItemString(row, 'acct_code'), dec(data))
	case 'mana_data1'
		if isnull(data) or trim(data) = '' then return 0
		
		if f_mana_data_chk_proc(getitemnumber(row, 'mana_code1'), trim(data)) < 0 then
			setitem(row, 'mana_data1', '')
			return 1
		end if
		
		setitem(row, 'com_mana1_name', f_mana_data_name_proc(getitemnumber(row, 'mana_code1'), trim(data)))
	case 'mana_data2'
		if isnull(data) or trim(data) = '' then return 0
		
		if f_mana_data_chk_proc(getitemnumber(row, 'mana_code2'), trim(data)) < 0 then
			setitem(row, 'mana_data2', '')
			return 1
		end if
		
		setitem(row, 'com_mana2_name', f_mana_data_name_proc(getitemnumber(row, 'mana_code2'), trim(data)))
	case 'mana_data3'
		if isnull(data) or trim(data) = '' then return 0
		
		if f_mana_data_chk_proc(getitemnumber(row, 'mana_code3'), trim(data)) < 0 then
			setitem(row, 'mana_data3', '')
			return 1
		end if
		
		setitem(row, 'com_mana3_name', f_mana_data_name_proc(getitemnumber(row, 'mana_code3'), trim(data)))
	case 'mana_data4'
		if isnull(data) or data = '' then return 0
		
		if f_mana_data_chk_proc(getitemnumber(row, 'mana_code4'), trim(data)) < 0 then
			setitem(row, 'mana_data4', '')
			return 1
		end if
		
		setitem(row, 'com_mana4_name', f_mana_data_name_proc(getitemnumber(row, 'mana_code4'), trim(data)))
end choose


end event

event itemfocuschanged;call super::itemfocuschanged;integer 	li_mana_code, li_length

if this.rowcount() < 1 then	return

if dwo.name = 'mana_data1' or dwo.name = 'mana_data2' or dwo.name = 'mana_data3' or dwo.name = 'mana_data4' then

	li_mana_code = this.getItemNumber(row, 'mana_code'+right(dwo.name, 1))

	//관리항목 길이...
	SELECT 	DATA_LENGTH  
    INTO 	:li_length
    FROM 	FNDB.HFN001M  
	WHERE 	MANA_CODE = :li_mana_code ;

	this.Modify(dwo.name+'.Edit.Limit = '+string(li_length))
	
end if

end event

event retrieveend;call super::retrieveend;integer		li_row

if rowcount < 1 then	return

for li_row = 1 to	rowcount
	setitem(li_row, 'com_mana1_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code1'), trim(getitemstring(li_row, 'mana_data1'))))
	setitem(li_row, 'com_mana2_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code2'), trim(getitemstring(li_row, 'mana_data2'))))
	setitem(li_row, 'com_mana3_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code3'), trim(getitemstring(li_row, 'mana_data3'))))
	setitem(li_row, 'com_mana4_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code4'), trim(getitemstring(li_row, 'mana_data4'))))
next

resetupdate()

end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow = 0 THEN RETURN
THIS.SetRow(currentrow)

//부가세
if ib_tax_proc then
	integer 	li_proof_gubun
	
	li_proof_gubun = this.Object.proof_gubun[currentrow]

	if li_proof_gubun = 1 or li_proof_gubun = 2 then
		this.Object.b_tax.visible = 1
	else
		this.Object.b_tax.visible = 0
	end if
end if


end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 992
string text = "결의서출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from uo_dwfree within tabpage_2
integer y = 12
integer width = 4347
integer height = 980
integer taborder = 20
string dataobject = "d_hfn201a_9"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
this.object.datawindow.print.preview = 'yes'
end event

type dw_all from datawindow within w_hfn201a
boolean visible = false
integer x = 50
integer y = 288
integer width = 4379
integer height = 2008
integer taborder = 30
boolean titlebar = true
string title = "출력전체보기"
string dataobject = "d_hfn201a_9"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
this.object.datawindow.print.preview = 'yes'

end event

type cb_preview from uo_imgbtn within w_hfn201a
boolean visible = false
integer x = 3968
integer y = 1140
integer width = 457
integer height = 92
integer taborder = 90
boolean bringtotop = true
string btnname = "출력전체보기"
end type

event clicked;call super::clicked;dw_all.bringtotop = true
dw_all.visible = true
end event

on cb_preview.destroy
call uo_imgbtn::destroy
end on

