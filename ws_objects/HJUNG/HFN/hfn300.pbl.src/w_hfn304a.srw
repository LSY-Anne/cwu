$PBExportHeader$w_hfn304a.srw
$PBExportComments$전표등록 및 출력
forward
global type w_hfn304a from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type gb_3 from groupbox within tabpage_sheet01
end type
type dw_update2 from datawindow within tabpage_sheet01
end type
type dw_update3 from datawindow within tabpage_sheet01
end type
type pb_dr_insert from uo_imgbtn within tabpage_sheet01
end type
type pb_dr_delete from uo_imgbtn within tabpage_sheet01
end type
type pb_cr_insert from uo_imgbtn within tabpage_sheet01
end type
type pb_cr_delete from uo_imgbtn within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_list002 from uo_dwgrid within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_list002 dw_list002
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_print dw_print
end type
type st_20 from statictext within w_hfn304a
end type
type dw_acct_class from datawindow within w_hfn304a
end type
type st_5 from statictext within w_hfn304a
end type
type dw_detail from datawindow within w_hfn304a
end type
type st_no from statictext within w_hfn304a
end type
type st_no2 from statictext within w_hfn304a
end type
type st_dept_code from statictext within w_hfn304a
end type
type dw_dept from datawindow within w_hfn304a
end type
type st_6 from statictext within w_hfn304a
end type
type em_fr_date from editmask within w_hfn304a
end type
type st_26 from statictext within w_hfn304a
end type
type em_to_date from editmask within w_hfn304a
end type
type ddlb_slip_class from dropdownlistbox within w_hfn304a
end type
type cbx_migyul from checkbox within w_hfn304a
end type
type cb_1 from uo_imgbtn within w_hfn304a
end type
type gb_1 from groupbox within w_hfn304a
end type
type cb_preview from uo_imgbtn within w_hfn304a
end type
type dw_update1 from uo_dwgrid within w_hfn304a
end type
type dw_all from datawindow within w_hfn304a
end type
type dw_migyul from datawindow within w_hfn304a
end type
type st_2 from statictext within w_hfn304a
end type
end forward

global type w_hfn304a from w_tabsheet
string title = "전표등록및출력"
st_20 st_20
dw_acct_class dw_acct_class
st_5 st_5
dw_detail dw_detail
st_no st_no
st_no2 st_no2
st_dept_code st_dept_code
dw_dept dw_dept
st_6 st_6
em_fr_date em_fr_date
st_26 st_26
em_to_date em_to_date
ddlb_slip_class ddlb_slip_class
cbx_migyul cbx_migyul
cb_1 cb_1
gb_1 gb_1
cb_preview cb_preview
dw_update1 dw_update1
dw_all dw_all
dw_migyul dw_migyul
st_2 st_2
end type
global w_hfn304a w_hfn304a

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_mast, idw_dr, idw_cr

datawindow			idw_data,  idw_preview




datetime				idt_sysdate
integer				ii_maxcode

string				is_bdgt_year
integer				ii_acct_class
string				is_gwa
string				is_str_date, is_end_date

integer				ii_slip_class
integer				ii_mast_acct_class, ii_step_opt
string				is_mast_slip_date, is_mast_slip_gwa
string				is_gubun

long					il_list_currentrow, il_mast_slip_no

boolean				ib_migyul_proc

end variables

forward prototypes
public function integer wf_condition_chk ()
public subroutine wf_retrieve_detail ()
public subroutine wf_obj_enabled (boolean ab_gubun)
public function integer wf_chk_null (datawindow adw, string as_required[])
public subroutine wf_dw_reset ()
public subroutine wf_getchild ()
public function integer wf_delete_proc (long al_acct_class, string as_slip_date, long al_slip_no)
public subroutine wf_retrieve_mast ()
public function integer wf_hfn202h_proc (integer ai_acct_class, string as_slip_date, integer ai_slip_no, integer ai_log_opt)
public function integer wf_hac012m_proc (datawindow adw_1, datetime adt_sysdate)
public subroutine wf_hac012m_select (datawindow adw, integer ai_row, string as_bdgt_year, string as_gwa, string as_acct_code, integer ai_acct_class, string as_io_gubun)
public function integer wf_mana_chk_null (datawindow adw_drcr)
public function integer wf_insert_drcr (datawindow adw_1, string as_drcr_class)
public function integer wf_save ()
public subroutine wf_delete_drcr (datawindow adw_1)
public function integer wf_retrieve ()
public subroutine wf_pb_drcr_enabled (boolean ab_enabled)
public function integer wf_itemchanged_drcr (datawindow adw_drcr, integer ai_row, string as_colname, string as_data)
end prototypes

public function integer wf_condition_chk ();// ==========================================================================================
// 기    능	:	전표 조회조건 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_condition_chk()	returns	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
date	ld_date

// 전표 조회조건 체크
em_fr_date.getdata(ld_date)
is_str_date = string(ld_date, 'yyyymmdd')
	
if trim(is_str_date) = '' or trim(is_str_date) = '00000000'	then
	f_messagebox('1', '전표 조회조건의 전표일자(From)을 정확히 입력해 주시기 바랍니다.!')
	em_fr_date.setfocus()
	return	100
end if

em_to_date.getdata(ld_date)
is_end_date = string(ld_date, 'yyyymmdd')

if trim(is_end_date) = '' or trim(is_end_date) = '00000000'	then
	f_messagebox('1', '전표 조회조건의 전표일자(To)을 정확히 입력해 주시기 바랍니다.!')
	em_to_date.setfocus()
	return	100
end if

return	0
end function

public subroutine wf_retrieve_detail ();// ==========================================================================================
// 기    능	:	Detail Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_retrieve_detail()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_slip_date
integer	li_acct_class
long		ll_row, ll_slip_no

ll_row	=	idw_mast.getrow()

if ll_row	<	1	then
	idw_dr.reset()
	idw_cr.reset()
	return
end if

idw_dr.setredraw(false)
idw_cr.setredraw(false)

li_acct_class	=	idw_mast.getitemnumber(ll_row, 'acct_class')
ls_slip_date	=	idw_mast.getitemstring(ll_row, 'slip_date')
ll_slip_no		=	idw_mast.getitemnumber(ll_row, 'slip_no')

idw_dr.retrieve(li_acct_class, ls_slip_date, ll_slip_no, 'D')
idw_cr.retrieve(li_acct_class, ls_slip_date, ll_slip_no, 'C')

idw_dr.setredraw(true)
idw_cr.setredraw(true)


end subroutine

public subroutine wf_obj_enabled (boolean ab_gubun);// ==========================================================================================
// 기    능	:	Save
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_obj_enabled()
// 인    수 :  as_gubun('1': 활성화, '0':비활성화)
// 되 돌 림 :	
// 주의사항 :
// 수정사항 :
// ==========================================================================================
ddlb_slip_class.Enabled    = ab_gubun
em_fr_date.Enabled  			= ab_gubun
em_to_date.Enabled  			= ab_gubun
dw_update1.Enabled 			= ab_gubun
tab_sheet.Enabled  			= ab_gubun
end subroutine

public function integer wf_chk_null (datawindow adw, string as_required[]);string	ls_column, ls_col_desc, ls_exp, ls_coltype
long		ll_pos1, ll_pos2, row, ll_col, ll_null_row
Long		ll_idx

adw.accepttext()

ll_idx = adw.GetNextModified(0,Primary!)
DO WHILE ll_idx > 0 
	// 필수입력 필드 체크
	For ll_col = 1 To UpperBound(as_required)
		
		ll_pos1 = Pos(as_required[ll_col], '/')
		
		ls_column = Left(as_required[ll_col], ll_pos1 - 1)
		ls_col_desc = Mid(as_required[ll_col], ll_pos1 + 1, Len(as_required[ll_col]))
		
		ls_coltype = adw.Describe(ls_column + '.coltype')
		ll_pos2 = Pos(ls_coltype, '(')
		If ll_pos2 = 0 Then ll_pos2 = Len(ls_coltype) + 1	
		Choose Case Upper(Left(ls_coltype, ll_pos2 - 1))
			Case 'DECIMAL', 'NUMBER', 'LONG'
				ls_exp = 'IsNull(' + ls_column + ') OR ' + ls_column + ' = 0'
			Case 'CHAR', 'STRING'
				ls_exp = 'Len(Trim(' + ls_column +')) < 1 OR IsNull(' + ls_column + ')'
		End Choose
	
		ll_null_row = adw.Find(ls_exp, ll_idx, ll_idx)
		If ll_null_row > 0 Then
			Beep(1)
			MessageBox('필수 입력', ls_col_desc + '를(을) 입력하지 않았습니다.', stopsign!)
			adw.ScrollToRow(ll_null_row)
			adw.SetRow(ll_null_row)
			adw.SetColumn(ls_column)
			adw.SetFocus()
			Return -1
		End If
	Next

	ll_idx = adw.GetNextModified(ll_idx,Primary!)
LOOP

Return 1

end function

public subroutine wf_dw_reset ();// ==========================================================================================
// 기    능	:	Datawindow Reset
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dw_reset()
// 인    수 :	
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
idw_mast.reset()
idw_dr.reset()
idw_cr.reset()
idw_preview.reset()

idw_print.reset()

end subroutine

public subroutine wf_getchild ();// ==========================================================================================
// 기    능	:	DatawindowChild Getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
// 전표부서
dw_dept.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

dw_dept.reset()
dw_dept.insertrow(0)

// 사용부서
idw_dr.getchild('used_gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_cr.getchild('used_gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 증빙종류
idw_dr.getchild('proof_gubun', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('proof_gubun', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_cr.getchild('proof_gubun', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('proof_gubun', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('proof_gubun', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('proof_gubun', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

dw_all.getchild('proof_gubun', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('proof_gubun', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public function integer wf_delete_proc (long al_acct_class, string as_slip_date, long al_slip_no);// ==========================================================================================
// 기    능	:	Save
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_hac012m_proc(long al_acct_class, string as_slip_date, long al_slip_no)	returns	integer
// 인    수 :	al_acct_class : 회계단위, as_slip_date : 전표일자, al_slip_no : 전표번호
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_bdgt_year, ls_used_gwa, ls_acct_code, ls_io_gubun
integer	li_acct_class, li_slip_class
dec{0}	ldc_acct_amt

declare	cur_hac012m	cursor	for
select	b.bdgt_year, b.used_gwa, b.acct_code, b.slip_amt, b.acct_class, a.slip_class
from		fndb.hfn201m a, fndb.hfn202m b
where		a.acct_class	=	b.acct_class
and		a.slip_date		=	b.slip_date
and		a.slip_no		=	b.slip_no
and		a.acct_class	=	:al_acct_class
and		a.slip_date		=	:as_slip_date
and		a.slip_no		=	:al_slip_no ;

open	cur_hac012m ;

fetch	cur_hac012m	into :ls_bdgt_year, :ls_used_gwa, :ls_acct_code, :ldc_acct_amt, :li_acct_class, :li_slip_class ;
if li_slip_class = 3 then
	ls_io_gubun = ''
else
	ls_io_gubun = string(li_slip_class)
end if

do while sqlca.sqlcode = 0
	update	acdb.hac012m
	set		assn_temp_amt = nvl(assn_temp_amt,0) - :ldc_acct_amt
	where		bdgt_year	=	:ls_bdgt_year
	and		gwa			=	:ls_used_gwa
	and		acct_code	=	:ls_acct_code
	and		acct_class	=	:li_acct_class
	and		io_gubun		=	:ls_io_gubun ;
	
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
	fetch	cur_hac012m	into :ls_bdgt_year, :ls_used_gwa, :ls_acct_code, :ldc_acct_amt, :li_acct_class, :li_slip_class ;
	if li_slip_class = 3 then
		ls_io_gubun = ''
	else
		ls_io_gubun = string(li_slip_class)
	end if
loop

close	cur_hac012m ;

return 0
end function

public subroutine wf_retrieve_mast ();// ==========================================================================================
// 기    능	:	Mast Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_retrieve_mast()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_slip_date
integer	li_acct_class
long		ll_row, ll_slip_no, ll_step_opt

ll_row	=	idw_list.getrow()

if ll_row	<	1 then	return

idw_mast.setredraw(false)

li_acct_class	=	idw_list.getitemnumber(ll_row, 'acct_class')
ls_slip_date	=	idw_list.getitemstring(ll_row, 'slip_date')
ll_slip_no		=	idw_list.getitemnumber(ll_row, 'slip_no')
ii_step_opt		=	idw_list.getitemnumber(ll_row, 'step_opt')
ll_step_opt		=	idw_list.getitemnumber(ll_row, 'step_opt')



if idw_mast.retrieve(li_acct_class, ls_slip_date, ll_slip_no) > 0 then
	if ll_step_opt = 5 then
		wf_setmsg('이미 확정처리되어 수정 또는 삭제할 수 없습니다.!')
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
		idw_mast.object.datawindow.readonly = True
		idw_dr.object.datawindow.readonly   = True
		idw_cr.object.datawindow.readonly   = True
		wf_pb_drcr_enabled(false)
	else
		wf_setmsg('')
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
		idw_mast.object.datawindow.readonly = false
		idw_dr.object.datawindow.readonly   = false
		idw_cr.object.datawindow.readonly   = false
		wf_pb_drcr_enabled(true)
	end if
	idw_preview.retrieve(li_acct_class, ls_slip_date, ll_slip_no)
	
	idw_print.retrieve(li_acct_class, ls_slip_date, ll_slip_no)
	dw_all.retrieve(li_acct_class, ls_slip_date, ll_slip_no)

else
	idw_preview.reset()
	idw_print.reset()
	dw_all.reset()
end if

if il_list_currentrow	<>	0	then 
	idw_mast.setredraw(true)
end if
end subroutine

public function integer wf_hfn202h_proc (integer ai_acct_class, string as_slip_date, integer ai_slip_no, integer ai_log_opt);// ==========================================================================================
// 기    능	:	전표이력 정보 Update
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_hfn202h_proc(integer ai_acct_class, string as_slip_date, integer ai_slip_no, integer ai_log_opt) return integer
// 인    수 :	ai_acct_class(회계단위)
//             as_slip_date(전표일자)
//             ai_slip_no(전표번호)
//             ai_log_opt(이력구분) - 1:입력, 2:수정, 3:삭제
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long	li_log_seq

select	nvl(max(log_seq),0) + 1	into :li_log_seq
from		fndb.hfn202h
where		acct_class = :ai_acct_class
and		slip_date  = :as_slip_date
and		slip_no    = :ai_slip_no ;

insert	into	fndb.hfn202h
select	b.acct_class,
			b.slip_date,
			b.slip_no,
			b.slip_seq,
			:li_log_seq,
			:ai_log_opt,
			a.slip_gwa,
			b.acct_code,
			b.drcr_class,
			b.slip_amt,
			b.remark,
			b.job_uid,
			b.job_add,
			b.job_date,
			b.job_uid,
			b.job_add,
			b.job_date
from		fndb.hfn201m a, fndb.hfn202m b
where		a.acct_class = b.acct_class
and		a.slip_date  = b.slip_date
and		a.slip_no    = b.slip_no
and		a.acct_class = :ai_acct_class
and		a.slip_date  = :as_slip_date
and		a.slip_no    = :ai_slip_no ;
			
if sqlca.sqlcode <> 0 then return -1

return 0
end function

public function integer wf_hac012m_proc (datawindow adw_1, datetime adt_sysdate);// ==========================================================================================
// 기    능	:	Save
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_hac012m_proc(datawindow adw_1, datetime adt_sysdate)	returns	integer
// 인    수 :	adw_chadae(전표예산변경내역 처리할 차변/대변 datawindow)
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long		ll_row, ll_del_row, ll_del_cnt
dec{0}	ldc_acct_amt, ldc_assn_used_amt, ldc_assn_temp_amt, ldc_assn_real_amt, ldc_com_assn_temp_amt
long		ll_acct_class, ll_slip_no, ll_slip_seq
string	ls_slip_date, ls_drcr_class, ls_bdgt_year, ls_used_gwa, ls_acct_code, ls_slip_class

if ii_slip_class = 3 then
	ls_slip_class = ''
else
	ls_slip_class = string(ii_slip_class)
end if

// 삭제자료의 처리
ll_del_cnt = adw_1.deletedcount()
if ll_del_cnt > 0 then
	for ll_del_row = ll_del_cnt to 1 step -1
		ll_acct_class = adw_1.object.acct_class.delete[ll_del_row]
		ls_slip_date  = adw_1.object.slip_date.delete[ll_del_row]
		ll_slip_no    = adw_1.object.slip_no.delete[ll_del_row]
		ll_slip_seq   = adw_1.object.slip_seq.delete[ll_del_row]
		ls_drcr_class = adw_1.object.drcr_class.delete[ll_del_row]
		ls_bdgt_year  = adw_1.object.bdgt_year.delete[ll_del_row]
		ls_used_gwa   = trim(adw_1.object.used_gwa.delete[ll_del_row])
		ls_acct_code  = adw_1.object.acct_code.delete[ll_del_row]
		ldc_acct_amt  = adw_1.object.slip_amt.delete[ll_del_row]
	
		// 예산자료에 금액 Update
		update	acdb.hac012m
		set		assn_temp_amt = nvl(assn_temp_amt,0) - :ldc_acct_amt
		where		bdgt_year  = :ls_bdgt_year
		and		gwa        = :ls_used_gwa
		and		acct_code  = :ls_acct_code
		and		acct_class = :ll_acct_class
		and		io_gubun   = :ls_slip_class ;
	
		if sqlca.sqlcode <> 0 then return sqlca.sqlcode
	next
end if

// 신규 또는 편집자료의 처리
ll_row	=	adw_1.getnextmodified(0, primary!)
do	while	ll_row > 0
	ll_acct_class         = adw_1.getitemnumber(ll_row, 'acct_class')
	ls_slip_date          = adw_1.getitemstring(ll_row, 'slip_date')
	ll_slip_no            = adw_1.getitemnumber(ll_row, 'slip_no')
	ll_slip_seq           = adw_1.getitemnumber(ll_row, 'slip_seq')
	ls_drcr_class         = adw_1.getitemstring(ll_row, 'drcr_class')
	ls_bdgt_year          = adw_1.getitemstring(ll_row, 'bdgt_year')
	ls_used_gwa           = trim(adw_1.getitemstring(ll_row, 'used_gwa'))
	ls_acct_code          = adw_1.getitemstring(ll_row, 'acct_code')
	ldc_acct_amt          = adw_1.getitemnumber(ll_row, 'slip_amt')
	ldc_assn_used_amt     = adw_1.getitemnumber(ll_row, 'assn_used_amt')
	ldc_assn_temp_amt     = adw_1.getitemnumber(ll_row, 'assn_temp_amt')
	ldc_com_assn_temp_amt = adw_1.getitemnumber(ll_row, 'com_temp_amt')
	ldc_assn_real_amt     = adw_1.getitemnumber(ll_row, 'assn_real_amt')
	if isnull(ldc_acct_amt) then ldc_acct_amt = 0
	if isnull(ldc_assn_used_amt) then ldc_assn_used_amt = 0
	if isnull(ldc_assn_temp_amt) then ldc_assn_temp_amt = 0
	if isnull(ldc_com_assn_temp_amt) then ldc_com_assn_temp_amt = 0
	if isnull(ldc_assn_real_amt) then ldc_assn_real_amt = 0
	
	// 예산자료에 금액 Update
	update	acdb.hac012m
	set		assn_temp_amt = nvl(assn_temp_amt,0) - :ldc_com_assn_temp_amt + :ldc_acct_amt
	where		bdgt_year  = :ls_bdgt_year
	and		gwa        = :ls_used_gwa
	and		acct_code  = :ls_acct_code
	and		acct_class = :ll_acct_class
	and		io_gubun   = :ls_slip_class ;
	
	if sqlca.sqlcode <> 0 then return sqlca.sqlcode
	
	ll_row	=	adw_1.getnextmodified(ll_row, primary!)
loop

return 0
end function

public subroutine wf_hac012m_select (datawindow adw, integer ai_row, string as_bdgt_year, string as_gwa, string as_acct_code, integer ai_acct_class, string as_io_gubun);// ==========================================================================================
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

adw.setitem(ai_row, 'assn_used_amt', ldec_assn_used_amt)
adw.setitem(ai_row, 'assn_temp_amt', ldec_assn_temp_amt)
adw.setitem(ai_row, 'assn_real_amt', ldec_assn_real_amt)

end subroutine

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
		// 발생전표번호 제외
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
		// 발생전표번호 제외
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
		// 발생전표번호 제외
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
		// 발생전표번호 제외
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

public function integer wf_insert_drcr (datawindow adw_1, string as_drcr_class);// ==========================================================================================
// 기    능	:	Dr/Cr Datawindow Insert
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_insert_drcr(datawindow adw_1, string as_drcr_class)	returns	integer
// 인    수 :	adw_1				-	Datawindow
//					as_drcr_class	-	Dr/Cr
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_remark
integer	li_newrow, li_code, li_max_code
dec{0}	ldb_amt, ldb_amt2

if idw_mast.rowcount() = 0 then
	f_messagebox('1', '입력 아이콘 버튼(또는 신규 메뉴)을 클릭해 주세요.!')
	return	-1
end if

if isnull(is_mast_slip_date) or trim(is_mast_slip_date) = '' or not isdate(string(is_mast_slip_date, '@@@@/@@/@@')) then
	f_messagebox('1', '전표일자를 정확히 입력해 주세요.!')
	idw_mast.setcolumn('slip_date')
	idw_mast.setfocus()
	return	-1
end if

if isnull(is_mast_slip_date) or trim(is_mast_slip_date) = '' or not isdate(string(is_mast_slip_date, '@@@@/@@/@@')) then
	f_messagebox('1', '전표일자를 정확히 입력해 주세요.!')
	idw_mast.setcolumn('slip_date')
	idw_mast.setfocus()
	return	-1
end if


ls_remark = trim(idw_mast.getitemstring(1, 'remark'))
adw_1.setredraw(false)

li_newrow	=	adw_1.rowcount() + 1
adw_1.insertrow(li_newrow)

ldb_amt2 = 0
if adw_1 = idw_dr then
	if idw_cr.rowcount() > 0 then
		ldb_amt2	=	idw_cr.getitemnumber(1, 'comp_sum_amt')
	end if
else
	if idw_dr.rowcount() > 0 then
		ldb_amt2	=	idw_dr.getitemnumber(1, 'comp_sum_amt')
	end if
end if
ldb_amt	=	ldb_amt2 - adw_1.getitemnumber(1, 'comp_sum_amt') 

if ldb_amt2 = 0 then	ldb_amt = 0

adw_1.setitem(li_newrow, 'acct_class',		ii_mast_acct_class)
adw_1.setitem(li_newrow, 'slip_date',		is_mast_slip_date)
adw_1.setitem(li_newrow, 'slip_no',			il_mast_slip_no)
adw_1.setitem(li_newrow, 'drcr_class',		as_drcr_class)
adw_1.setitem(li_newrow, 'used_gwa',		gs_DeptCode)
adw_1.setitem(li_newrow, 'proof_gubun',	0)
adw_1.setitem(li_newrow, 'slip_amt',		ldb_amt)
adw_1.setitem(li_newrow, 'remark',			ls_remark)
adw_1.setitem(li_newrow, 'mana_code1',		0)
adw_1.setitem(li_newrow, 'mana_code2',		0)
adw_1.setitem(li_newrow, 'mana_code3',		0)
adw_1.setitem(li_newrow, 'mana_code4',		0)
adw_1.setitem(li_newrow, 'bdgt_year',		is_bdgt_year)

adw_1.setitem(li_newrow, 'worker',			gs_empcode)
adw_1.setitem(li_newrow, 'ipaddr',			gs_ip)
adw_1.setitem(li_newrow, 'work_date',		f_sysdate())
adw_1.setitem(li_newrow, 'job_uid',			gs_empcode)
adw_1.setitem(li_newrow, 'job_add',			gs_ip)
adw_1.setitem(li_newrow, 'job_date',		f_sysdate())

adw_1.setcolumn('acct_code')
adw_1.setredraw(true)

adw_1.scrolltorow(li_newrow)
adw_1.setrow(li_newrow)
adw_1.setcolumn('acct_code')
adw_1.setfocus()



return	0

end function

public function integer wf_save ();// ==========================================================================================
// 기    능	:	Save
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_save()	returns	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
datawindow	ldw_1
string		ls_mast_insert, ls_mast_modify
string		ls_slip_date, ls_drcr_class, ls_acct_code
long			ll_slip_no, ll_slip_seq, ll_return
integer		li_acct_class
integer		li_slip_seq
dec{0}		ldb_amt
string		ls_slip_class_name, ls_slip_name
integer		li_compare1, li_compare2
integer		li_rowocunt, i, j
dec{0}		ldb_dr_amt, ldb_cr_amt
integer		li_log_opt

ls_mast_insert	=	idw_mast.describe("evaluate('isRowNew()', 1)")
ls_mast_modify	=	idw_mast.describe("evaluate('isRowModified()', 1)")

if idw_dr.rowcount()	<	1	or	idw_cr.rowcount() < 1	then	
	f_messagebox('1', '저장할 자료가 존재하지 않습니다.~n~n확인 후 저장하시기 바랍니다.!')
	return	100
end if

// 저장 대상자료와 조건의 구분이 다른경우
ls_slip_class_name = ddlb_slip_class.text
li_compare1			 = idw_mast.getitemnumber(1, 'slip_class')
li_compare2			 = ddlb_slip_class.finditem(ls_slip_class_name, 0)
if li_compare1 <> li_compare2 then
	if li_compare1 = 1 then
		ls_slip_name = '수입전표'
	elseif li_compare1 = 2 then
		ls_slip_name = '지출전표'
	else
		ls_slip_name = '대체전표'
	end if
	messagebox('확인', '현재 저장할 내용은 ' + ls_slip_name + ' 입니다.~r~r' + &
	                   '상단의 전표구분과 상이하므로 저장할 수 없습니다.~r' + &
							 '상단의 전표구분을 변경하시거나 자료를 다시 조회하신 후~r' + &
							 '저장하시기 바랍니다.')
	return 100
end if

// Not Null 항목 체크
if f_chk_null(idw_mast, {'slip_date/전표일자'})	<	0	then	return	100

if f_chk_null(idw_dr, {'acct_code/계정과목', 'slip_amt/전표금액', 'used_gwa/전표부서'})	<	0	then	return	100

if f_chk_null(idw_cr, {'acct_code/계정과목', 'slip_amt/전표금액', 'used_gwa/전표부서'})	<	0	then	return	100

// 차변금액과 대변금액은 같아야 한다.
if idw_dr.rowcount() < 1 then
	ldb_dr_amt	=	0
else
	ldb_dr_amt	=	idw_dr.getitemnumber(1, 'comp_sum_amt')
end if

if idw_cr.rowcount() < 1 then
	ldb_cr_amt	=	0
else
	ldb_cr_amt	=	idw_cr.getitemnumber(1, 'comp_sum_amt')
end if

if ldb_dr_amt <> ldb_cr_amt	then
	f_messagebox('3', '차변금액 [' + string(ldb_dr_amt, '#,##0') + ']과 대변금액 [' + string(ldb_cr_amt, '#,##0') + ']이 같아야 합니다.~n~n' +	&
			'확인 후 다시 입력해 주시기 바랍니다.')
	return	100
end if

// 관리항목 내용 확인
if wf_mana_chk_null(idw_dr) < 0 then return 100
if wf_mana_chk_null(idw_cr) < 0 then return 100

// 저장 확인 메세지
if f_messagebox('2', '저장을 하시겠습니까?') = 2	then	return	100

// Mast Insert
// Slip No를 부여한다. 접수번호 Max를 가져온다.
if ls_mast_insert	=	'true'	then
	select	nvl(max(slip_no), 0) + 1
	into		:il_mast_slip_no
	from		fndb.hfn201m
	where		acct_class	=	:ii_mast_acct_class
	and		slip_date	=	:is_mast_slip_date	;
	
	if sqlca.sqlcode <> 0 then	il_mast_slip_no	=	1

	idw_mast.setitem(idw_mast.getrow(), 'slip_no', 	il_mast_slip_no)
	
	// 이력구분
	li_log_opt = 1
else
	// 이력구분
	li_log_opt = 2
end if

// Mast Update
if idw_mast.modifiedcount() > 0 or idw_mast.deletedcount() > 0 then
	IF idw_mast.Update(true)	<>	1 then	return	-1
end if

// Slip No Setitem, 계정체크
// 차변/대변금액 Update
for j = 1 to 2
	if j = 1 then
		ldw_1 =	idw_dr
	else
		ldw_1	=	idw_cr
	end if
	
	if ldw_1.modifiedcount() > 0 or ldw_1.deletedcount() > 0 then
		select	nvl(max(slip_seq),0)
		into		:li_slip_seq
		from		fndb.hfn202m
		where		acct_class	=	:ii_mast_acct_class
		and		slip_date	=	:is_mast_slip_date
		and		slip_no		=	:il_mast_slip_no ;

		li_rowocunt	=	ldw_1.rowcount()
		for i = 1 to li_rowocunt
			if ldw_1.getitemstatus(i,0,primary!) = new! or ldw_1.getitemstatus(i,0,primary!) = newmodified! then
				li_slip_seq ++
				ldw_1.setitem(i, 'slip_no', 	il_mast_slip_no)
				ldw_1.setitem(i, 'slip_seq', 	li_slip_seq)
				
				// 관리항목이 전표번호인 경우 삽입
				if ldw_1.getitemnumber(i, 'mana_code1') = 9 and &
				   ldw_1.getitemstring(i, 'drcr_class') = ldw_1.getitemstring(i, 'com_drcr_class') then
					ldw_1.setitem(i, 'mana_data1', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
				if ldw_1.getitemnumber(i, 'mana_code2') = 9 and &
				   ldw_1.getitemstring(i, 'drcr_class') = ldw_1.getitemstring(i, 'com_drcr_class') then
					ldw_1.setitem(i, 'mana_data2', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
				if ldw_1.getitemnumber(i, 'mana_code3') = 9 and &
				   ldw_1.getitemstring(i, 'drcr_class') = ldw_1.getitemstring(i, 'com_drcr_class') then
					ldw_1.setitem(i, 'mana_data3', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
				if ldw_1.getitemnumber(i, 'mana_code4') = 9 and &
				   ldw_1.getitemstring(i, 'drcr_class') = ldw_1.getitemstring(i, 'com_drcr_class') then
					ldw_1.setitem(i, 'mana_data4', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
			end if
		next
	
		// 전표예산내역 저장
		ll_return = wf_hac012m_proc(ldw_1, idt_sysdate)
	
		if ll_return <> 0 then return ll_return
		
		if ldw_1.update() <>	1	then	return	-1
	end if
next

// 전표이력 정보 Update
if wf_hfn202h_proc(ii_mast_acct_class, is_mast_slip_date, il_mast_slip_no, li_log_opt) <> 0 then return -1

return	0

end function

public subroutine wf_delete_drcr (datawindow adw_1);// ==========================================================================================
// 기    능	:	Drcr Delete
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_delete_drcr(datawindow adw_1)
// 인    수 :	adw_1	-	Datawindow
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long		ll_resol_no, ll_slip_seq, ll_find_row
string	ls_drcr_class


wf_setMsg('삭제중')

if adw_1.rowcount() > 0 then
	if f_messagebox('2', '[' + string(adw_1.getrow()) + ']항의 자료를 삭제하시겠습니까?')	=	1	then
		adw_1.deleterow(adw_1.getrow())
			
		if idw_dr.rowcount() = 0 and idw_cr.rowcount() = 0 then	idw_mast.deleterow(0)
	end if
end if

wf_setMsg('.')


end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능	:	List Datawindow Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_retrieve()	returns	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================
date	ld_date

idw_list.setredraw(false)
idw_mast.setredraw(false)
idw_dr.setredraw(false)
idw_cr.setredraw(false)

em_fr_date.getdata(ld_date)
is_str_date = string(ld_date, 'yyyymmdd')
em_to_date.getdata(ld_date)
is_end_date = string(ld_date, 'yyyymmdd')

idw_list.retrieve(ii_acct_class, ii_slip_class, is_gwa, is_str_date, is_end_date)

idw_list.setredraw(true)
idw_mast.setredraw(true)
idw_dr.setredraw(true)
idw_cr.setredraw(true)

return 0
end function

public subroutine wf_pb_drcr_enabled (boolean ab_enabled);// ==========================================================================================
// 기    능	:	Dr/Cr Button Enabled Check
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_pb_drcr_enabled(boolean ab_enabled)
// 인    수 :	ab_enabled	-	Button Enabled True/False
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
tab_sheet.tabpage_sheet01.pb_dr_insert.of_enable( ab_enabled) 
tab_sheet.tabpage_sheet01.pb_dr_delete.of_enable( ab_enabled) 
tab_sheet.tabpage_sheet01.pb_cr_insert.of_enable( ab_enabled) 
tab_sheet.tabpage_sheet01.pb_cr_delete.of_enable( ab_enabled) 
cb_1.of_enable( ab_enabled) 
end subroutine

public function integer wf_itemchanged_drcr (datawindow adw_drcr, integer ai_row, string as_colname, string as_data);// ==========================================================================================
// 기    능	:	Dr/Cr Datawindow Check
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_itemchanged(integer ai_row, string as_colname, string as_data) return integer
// 인    수 :	ai_row(현재행), as_colname(현재 Object명), as_data(현재 Data)
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
s_insa_com	lstr_com, lstr_Rtn
string		ls_acct_code, ls_acct_name
integer		li_mana_code, li_mana_code1, li_mana_code2, li_mana_code3, li_mana_code4
string		ls_bdgt_cntl_yn, ls_drcr_class, ls_com_drcr_class, ls_com_mi_gubun
long			ll_cnt

idw_mast.accepttext()

as_data = trim(as_data)

if adw_drcr = idw_dr then
	ls_drcr_class = 'D'
else
	ls_drcr_class = 'C'
end if

choose case as_colname
	case 'acct_code', 'com_acct_name'
		if as_colname = 'acct_code' then
			select	count(*)	into	:ll_cnt	from	acdb.hac001m
			where		acct_code	like	:as_data||'%'
			and		level_class		=		'4' ;
		else
			select	count(*)	into	:ll_cnt	from	acdb.hac001m
			where		acct_name	like	'%'||:as_data||'%'
			and		level_class		=		'4' ;
		end if
		
		if ll_cnt < 1 then
			messagebox('확인', '등록된 계정이 없습니다.')
			adw_drcr.setitem(ai_row, 'acct_code', '')
			adw_drcr.setitem(ai_row, 'com_acct_name', '')
			return 1
		end if
		
		if ll_cnt = 1 then
			if as_colname = 'acct_code' then
				select	acct_code, acct_name, bdgt_cntl_yn, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn, mana_code
				into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun, :li_mana_code
				from		acdb.hac001m
				where		acct_code	like	:as_data||'%'
				and		level_class		=		'4' ;
			else
				select	acct_code, acct_iname, bdgt_cntl_yn, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn, mana_code
				into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun, :li_mana_code
				from		acdb.hac001m
				where		acct_name	like	'%'||:as_data||'%'
				and		level_class		=		'4' ;
			end if
			
			adw_drcr.setitem(ai_row, 'acct_code', ls_acct_code)
			adw_drcr.setitem(ai_row, 'com_acct_name', ls_acct_name)
			adw_drcr.setitem(ai_row, 'bdgt_cntl_yn', ls_bdgt_cntl_yn)
			adw_drcr.setitem(ai_row, 'com_drcr_class', ls_com_drcr_class)
			adw_drcr.setitem(ai_row, 'com_mana_code', li_mana_code)
			adw_drcr.setitem(ai_row, 'com_mi_gubun', ls_com_mi_gubun)
			adw_drcr.setitem(ai_row, 'mana_code1', li_mana_code1)
			if li_mana_code1 = 0 then adw_drcr.setitem(ai_row, 'mana_data1', '')
			adw_drcr.setitem(ai_row, 'mana_code2', li_mana_code2)
			if li_mana_code2 = 0 then adw_drcr.setitem(ai_row, 'mana_data2', '')
			adw_drcr.setitem(ai_row, 'mana_code3', li_mana_code3)
			if li_mana_code3 = 0 then adw_drcr.setitem(ai_row, 'mana_data3', '')
			adw_drcr.setitem(ai_row, 'mana_code4', li_mana_code4)
			if li_mana_code4 = 0 then adw_drcr.setitem(ai_row, 'mana_data4', '')

			wf_hac012m_select(adw_drcr, ai_row, adw_drcr.getitemstring(ai_row, 'bdgt_year'), adw_drcr.getitemstring(ai_row, 'used_gwa'), &
							    	adw_drcr.getitemstring(ai_row, 'acct_code'), ii_acct_class, string(ii_slip_class))

			if ii_slip_class <> 3 then
				if adw_drcr.getitemstring(ai_row, 'bdgt_cntl_yn') = 'Y' and adw_drcr.getitemnumber(ai_row, 'slip_amt') > adw_drcr.getitemnumber(ai_row, 'com_jan_amt') then
					adw_drcr.setitem(ai_row, 'slip_amt', 0)
					messagebox('확인', '사용할 수 있는 예산잔액보다 전표금액이 클 수 없습니다.')
					return 1
				end if
			end if
			return 1
		else
			if as_colname = 'acct_code' then
				lstr_com.ls_item[1] = trim(as_data)
				lstr_com.ls_item[2] = ''
				lstr_com.ls_item[3] = string(ii_acct_class)
				lstr_com.ls_item[4] = ''
				lstr_com.ls_item[5] = ls_drcr_class
			else
				lstr_com.ls_item[1] = ''
				lstr_com.ls_item[2] = trim(as_data)
				lstr_com.ls_item[3] = string(ii_acct_class)
				lstr_com.ls_item[4] = ''
				lstr_com.ls_item[5] = ls_drcr_class
			end if
			
			openwithparm(w_hfn002h, lstr_com)
			
			lstr_rtn = message.powerobjectparm
			
			if not isvalid(lstr_rtn) then
				adw_drcr.setitem(ai_row, 'acct_code', '')
				adw_drcr.setitem(ai_row, 'com_acct_name', '')
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
			
			adw_drcr.setitem(ai_row, 'acct_code', ls_acct_code)
			adw_drcr.setitem(ai_row, 'com_acct_name', ls_acct_name)
			adw_drcr.setitem(ai_row, 'bdgt_cntl_yn', ls_bdgt_cntl_yn)
			adw_drcr.setitem(ai_row, 'com_drcr_class', ls_com_drcr_class)
			adw_drcr.setitem(ai_row, 'com_mana_code', li_mana_code)
			adw_drcr.setitem(ai_row, 'com_mi_gubun', ls_com_mi_gubun)
			adw_drcr.setitem(ai_row, 'mana_code1', li_mana_code1)
			if li_mana_code1 = 0 then adw_drcr.setitem(ai_row, 'mana_data1', '')
			adw_drcr.setitem(ai_row, 'mana_code2', li_mana_code2)
			if li_mana_code2 = 0 then adw_drcr.setitem(ai_row, 'mana_data2', '')
			adw_drcr.setitem(ai_row, 'mana_code3', li_mana_code3)
			if li_mana_code3 = 0 then adw_drcr.setitem(ai_row, 'mana_data3', '')
			adw_drcr.setitem(ai_row, 'mana_code4', li_mana_code4)
			if li_mana_code4 = 0 then adw_drcr.setitem(ai_row, 'mana_data4', '')

			wf_hac012m_select(adw_drcr, ai_row, adw_drcr.getitemstring(ai_row, 'bdgt_year'), adw_drcr.getitemstring(ai_row, 'used_gwa'), &
							    	adw_drcr.getitemstring(ai_row, 'acct_code'), ii_acct_class, string(ii_slip_class))

			if ii_slip_class <> 3 then
				if adw_drcr.getitemstring(ai_row, 'bdgt_cntl_yn') = 'Y' and adw_drcr.getitemnumber(ai_row, 'slip_amt') > adw_drcr.getitemnumber(ai_row, 'com_jan_amt') then
					adw_drcr.setitem(ai_row, 'slip_amt', 0)
					messagebox('확인', '사용할 수 있는 예산잔액보다 전표금액이 클 수 없습니다.')
					return 1
				end if
			end if
			return 1
		end if
	case 'proof_gubun'
		if as_data = '0' then adw_drcr.setitem(ai_row, 'proof_date', '')
	case 'proof_date'
		if isnull(as_data) or as_data = '' then return 0
		
		if not isdate(mid(as_data,1,4) + '/' + mid(as_data,5,2) + '/' + mid(as_data,7,2)) then
			messagebox('확인', '증빙일자를 올바르게 입력하시기 바랍니다.')
			adw_drcr.setitem(ai_row, 'proof_date', '')
			return 1
		end if
	case 'slip_amt'
		wf_hac012m_select(adw_drcr, ai_row, adw_drcr.getitemstring(ai_row, 'bdgt_year'), adw_drcr.getitemstring(ai_row, 'used_gwa'), &
						    	adw_drcr.getitemstring(ai_row, 'acct_code'), ii_acct_class, string(ii_slip_class))

		if ii_slip_class <> 3 then
			if adw_drcr.getitemstring(ai_row, 'bdgt_cntl_yn') = 'Y' and dec(as_data) > adw_drcr.getitemnumber(ai_row, 'com_jan_amt') then
				adw_drcr.setitem(ai_row, 'slip_amt', 0)
				messagebox('확인', '사용할 수 있는 예산잔액보다 전표금액이 클 수 없습니다.')
				return 1
			end if
		end if
		
		if adw_drcr.getitemstring(ai_row, 'com_mi_gubun') = 'Y' then
			if adw_drcr.getitemstring(ai_row, 'drcr_class') <> adw_drcr.getitemstring(ai_row, 'com_drcr_class') then
				if adw_drcr.getitemnumber(ai_row, 'mana_code1') = adw_drcr.getitemnumber(ai_row, 'com_mana_code') then adw_drcr.setitem(ai_row, 'mana_data1', '')
				if adw_drcr.getitemnumber(ai_row, 'mana_code2') = adw_drcr.getitemnumber(ai_row, 'com_mana_code') then adw_drcr.setitem(ai_row, 'mana_data2', '')
				if adw_drcr.getitemnumber(ai_row, 'mana_code3') = adw_drcr.getitemnumber(ai_row, 'com_mana_code') then adw_drcr.setitem(ai_row, 'mana_data3', '')
				if adw_drcr.getitemnumber(ai_row, 'mana_code4') = adw_drcr.getitemnumber(ai_row, 'com_mana_code') then adw_drcr.setitem(ai_row, 'mana_data4', '')
			end if
		end if
	case 'mana_data1'
		if isnull(as_data) or as_data = '' then return 0
		
		if f_mana_data_chk_proc(adw_drcr.getitemnumber(ai_row, 'mana_code1'), as_data) < 0 then
			adw_drcr.setitem(ai_row, 'mana_data1', '')
			return 1
		end if
		
		adw_drcr.setitem(ai_row, 'com_mana1_name', f_mana_data_name_proc(adw_drcr.getitemnumber(ai_row, 'mana_code1'), as_data))
	case 'mana_data2'
		if isnull(as_data) or as_data = '' then return 0
		
		if f_mana_data_chk_proc(adw_drcr.getitemnumber(ai_row, 'mana_code2'), as_data) < 0 then
			adw_drcr.setitem(ai_row, 'mana_data2', '')
			return 1
		end if
		
		adw_drcr.setitem(ai_row, 'com_mana2_name', f_mana_data_name_proc(adw_drcr.getitemnumber(ai_row, 'mana_code2'), as_data))
	case 'mana_data3'
		if isnull(as_data) or as_data = '' then return 0
		
		if f_mana_data_chk_proc(adw_drcr.getitemnumber(ai_row, 'mana_code3'), as_data) < 0 then
			adw_drcr.setitem(ai_row, 'mana_data3', '')
			return 1
		end if
		
		adw_drcr.setitem(ai_row, 'com_mana3_name', f_mana_data_name_proc(adw_drcr.getitemnumber(ai_row, 'mana_code3'), as_data))
	case 'mana_data4'
		if isnull(as_data) or as_data = '' then return 0
		
		if f_mana_data_chk_proc(adw_drcr.getitemnumber(ai_row, 'mana_code4'), as_data) < 0 then
			adw_drcr.setitem(ai_row, 'mana_data4', '')
			return 1
		end if
		
		adw_drcr.setitem(ai_row, 'com_mana4_name', f_mana_data_name_proc(adw_drcr.getitemnumber(ai_row, 'mana_code4'), as_data))
end choose

return 0
end function

on w_hfn304a.create
int iCurrent
call super::create
this.st_20=create st_20
this.dw_acct_class=create dw_acct_class
this.st_5=create st_5
this.dw_detail=create dw_detail
this.st_no=create st_no
this.st_no2=create st_no2
this.st_dept_code=create st_dept_code
this.dw_dept=create dw_dept
this.st_6=create st_6
this.em_fr_date=create em_fr_date
this.st_26=create st_26
this.em_to_date=create em_to_date
this.ddlb_slip_class=create ddlb_slip_class
this.cbx_migyul=create cbx_migyul
this.cb_1=create cb_1
this.gb_1=create gb_1
this.cb_preview=create cb_preview
this.dw_update1=create dw_update1
this.dw_all=create dw_all
this.dw_migyul=create dw_migyul
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_20
this.Control[iCurrent+2]=this.dw_acct_class
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.st_no
this.Control[iCurrent+6]=this.st_no2
this.Control[iCurrent+7]=this.st_dept_code
this.Control[iCurrent+8]=this.dw_dept
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.em_fr_date
this.Control[iCurrent+11]=this.st_26
this.Control[iCurrent+12]=this.em_to_date
this.Control[iCurrent+13]=this.ddlb_slip_class
this.Control[iCurrent+14]=this.cbx_migyul
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.cb_preview
this.Control[iCurrent+18]=this.dw_update1
this.Control[iCurrent+19]=this.dw_all
this.Control[iCurrent+20]=this.dw_migyul
this.Control[iCurrent+21]=this.st_2
end on

on w_hfn304a.destroy
call super::destroy
destroy(this.st_20)
destroy(this.dw_acct_class)
destroy(this.st_5)
destroy(this.dw_detail)
destroy(this.st_no)
destroy(this.st_no2)
destroy(this.st_dept_code)
destroy(this.dw_dept)
destroy(this.st_6)
destroy(this.em_fr_date)
destroy(this.st_26)
destroy(this.em_to_date)
destroy(this.ddlb_slip_class)
destroy(this.cbx_migyul)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.cb_preview)
destroy(this.dw_update1)
destroy(this.dw_all)
destroy(this.dw_migyul)
destroy(this.st_2)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1

end event

event ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2001. 11                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////
integer	li_newrow, li_code, li_max_code
integer	li_listnewrow
string	ls_slip_date

// 바로 전에 입력한 전표일자 획득
if idw_mast.rowcount() < 1 then
	ls_slip_date = ''
else
	ls_slip_date = idw_mast.getitemstring(1, 'slip_date')
end if



wf_retrieve()

idw_mast.object.datawindow.readonly = False
idw_dr.object.datawindow.readonly   = False
idw_cr.object.datawindow.readonly   = False

li_listnewrow	=	idw_list.insertrow(0)
idw_list.scrolltorow(li_listnewrow)

idw_mast.reset()
idw_dr.reset()
idw_cr.reset()
wf_pb_drcr_enabled(true)

idw_mast.setredraw(true)
idw_dr.setredraw(true)
idw_cr.setredraw(true)

li_newrow	=	1
idw_mast.insertrow(li_newrow)
idw_mast.scrolltorow(li_newrow)
idw_mast.setrow(li_newrow)

if isnull(ls_slip_date) or trim(ls_slip_date) = '' then
	is_mast_slip_date		=	f_today()
else
	is_mast_slip_date		=	ls_slip_date
end if
ii_mast_acct_class	=	1
is_mast_slip_gwa		=	gs_DeptCode
il_mast_slip_no		=	0

idw_mast.setitem(li_newrow, 'acct_class',	ii_mast_acct_class)
idw_mast.setitem(li_newrow, 'slip_date',	is_mast_slip_date)
idw_mast.setitem(li_newrow, 'slip_gwa', 	is_mast_slip_gwa)
idw_mast.setitem(li_newrow, 'slip_class', ii_slip_class)
idw_mast.setitem(li_newrow, 'genesis_gb', 3)
idw_mast.setitem(li_newrow, 'step_opt', 	4)
idw_mast.setitem(li_newrow, 'bdgt_year',	is_bdgt_year)
idw_mast.setitem(li_newrow, 'worker',		gs_empcode)
idw_mast.setitem(li_newrow, 'ipaddr',		gs_ip)
idw_mast.setitem(li_newrow, 'work_date',	f_sysdate())

idw_list.setitem(li_listnewrow, 'acct_class',ii_mast_acct_class)
idw_list.setitem(li_listnewrow, 'slip_date',	is_mast_slip_date)
idw_list.setitem(li_listnewrow, 'slip_class',ii_slip_class)
idw_list.setitem(li_listnewrow, 'slip_gwa',	is_mast_slip_gwa)

idw_mast.TRIGGER EVENT itemchanged(1,idw_mast.Object.slip_date,is_mast_slip_date)

idw_mast.setcolumn('slip_gwa')

idw_mast.setfocus()
//wf_setMenu('DELETE',	TRUE)
//wf_setMenu('UPDATE',	TRUE)

wf_setmsg('')

end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.11
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//idw_list		=	dw_update1
//idw_mast		=	tab_sheet.tabpage_sheet01.dw_list001
//idw_dr		=	tab_sheet.tabpage_sheet01.dw_update2
//idw_cr		=	tab_sheet.tabpage_sheet01.dw_update3
//
//idw_preview	=	tab_sheet.tabpage_sheet02.dw_list002
//
//idw_print	=	tab_sheet.tabpage_sheet03.dw_print
//
//
//triggerevent('ue_init')
//
//// 전표 구분(1=수입전표, 2=지출전표, 3=대체전표)
//ddlb_slip_class.selectitem(2)
//ii_slip_class	=	2
//
//wf_getchild()
//
//idt_sysdate		=	f_sysdate()
//
//dw_acct_class.getchild('code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('acct_class', 1) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//dw_acct_class.reset()
//dw_acct_class.insertrow(0)
//
//idw_child.scrolltorow(1)
//idw_child.setrow(1)
//ii_acct_class	=	idw_child.getitemnumber(1, 'code')
//
//dw_dept.setitem(1, 'code', gs_DeptCode)
//is_gwa			=	gs_DeptCode
//is_str_date		=	left(f_today(), 6) + '01'
//is_end_date		=	f_today()
//
//em_fr_date.text	=	string(is_str_date, '@@@@/@@/@@')
//em_to_date.text	=	string(is_end_date, '@@@@/@@/@@')
//
//is_bdgt_year		=	f_getbdgtyear(is_end_date)
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////
integer	li_rtn
long		ll_row

idw_mast.accepttext()
idw_dr.accepttext()
idw_cr.accepttext()
if f_chk_magam(ii_acct_class, is_bdgt_year) > 0 then return -1



li_rtn	=	wf_save()

if li_rtn = 0 then
	COMMIT	;
	wf_setmsg('저장을 완료했습니다.!')

	idw_mast.setredraw(true)
	idw_dr.setredraw(true)
	idw_cr.setredraw(true)
	
	if idw_mast.rowcount() > 0 then
		idw_list.setitem(idw_list.getrow(), 'slip_no',		idw_mast.getitemnumber(1, 'slip_no'))
		
		if idw_dr.rowcount() > 0 then
			idw_list.setitem(idw_list.getrow(), 'com_tot_amt', idw_dr.getitemnumber(1, 'comp_sum_amt'))
		else
			idw_list.setitem(idw_list.getrow(), 'com_tot_amt', idw_cr.getitemnumber(1, 'comp_sum_amt'))
		end if
		
		idw_mast.retrieve(ii_mast_acct_class, is_mast_slip_date, il_mast_slip_no)
		idw_preview.retrieve(ii_mast_acct_class, is_mast_slip_date, il_mast_slip_no)
		
		if idw_print.retrieve(ii_mast_acct_class, is_mast_slip_date, il_mast_slip_no) < 1 then

		else

		end if
		dw_all.retrieve(ii_mast_acct_class, is_mast_slip_date, il_mast_slip_no)
	else
		triggerevent('ue_retrieve')
	end if

elseif	li_rtn < 0 then
	f_messagebox('3', '저장을 실패했습니다.!' + sqlca.sqlerrtext)
	ROLLBACK;
END IF



return 1

end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow, i
long			ll_row, ll_rowcount
long			ll_acct_class, ll_slip_no
string		ls_slip_date


wf_setMsg('삭제중')

if idw_list.getrow() < 1 or idw_mast.getrow() < 1 then
	f_messagebox('3', '삭제할 자료가 존재하지 않습니다.!')
else
	// 마스타 자료를 삭제하면 디테일 자료도 같이 삭제된다.(trigger)
	if f_messagebox('2', '자료를 삭제하면 차대변자료도 모두 삭제됩니다.~n~n' + string(is_mast_slip_date, '@@@@년 @@월 @@일') + '의 전표번호 [' + string(il_mast_slip_no) + ']의 자료를 삭제하시겠습니까?')	=	1	then
	
		ll_acct_class = idw_mast.getitemnumber(1, 'acct_class')
		ls_slip_date  = idw_mast.getitemstring(1, 'slip_date')
		ll_slip_no    = idw_mast.getitemnumber(1, 'slip_no')
		
		// 삭제전 전표예산금액을 배정예산에 감산
		if wf_delete_proc(ll_acct_class, ls_slip_date, ll_slip_no) <> 0 then

			rollback using sqlca ;
			wf_setMsg('전표자료 삭제에 실패하였습니다.')			
			f_messagebox('3', '전표자료 삭제를 실패했습니다.!~n' + sqlca.sqlerrtext)
			return
		end if
		
		// 전표이력 정보 Update
		if wf_hfn202h_proc(ll_acct_class, ls_slip_date, ll_slip_no, 3) <> 0 then

			rollback using sqlca ;
			wf_setMsg('전표자료 삭제에 실패하였습니다.')			
			f_messagebox('3', '전표자료 삭제를 실패했습니다.!~n' + sqlca.sqlerrtext)
			return
		end if
		
		delete	from	fndb.hfn201m
		where		acct_class = :ll_acct_class
		and		slip_date  = :ls_slip_date
		and		slip_no    = :ll_slip_no ;
		
		if sqlca.sqlcode <> 0 then

			rollback using sqlca ;
			wf_setMsg('전표자료 삭제에 실패하였습니다.')			
			f_messagebox('3', '전표자료 삭제를 실패했습니다.!~n' + sqlca.sqlerrtext)
			return
		end if
	end if
end if

commit using sqlca ;
wf_setMsg('전표삭제에 성공하였습니다.')

this.Triggerevent('ue_retrieve')
return 

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
//
end event

event open;call super::open;//미결계정
//ib_migyul_proc = true
if gs_empcode = 'F0012' or gs_empcode = 'F0021' or gs_empcode = 'F0092' then
	cbx_migyul.visible = true
else
	cbx_migyul.visible = false
end if

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
idw_list		=	dw_update1
idw_mast		=	tab_sheet.tabpage_sheet01.dw_list001
idw_dr		=	tab_sheet.tabpage_sheet01.dw_update2
idw_cr		=	tab_sheet.tabpage_sheet01.dw_update3

idw_preview	=	tab_sheet.tabpage_sheet02.dw_list002

idw_print	=	tab_sheet.tabpage_sheet03.dw_print


triggerevent('ue_init')

// 전표 구분(1=수입전표, 2=지출전표, 3=대체전표)
ddlb_slip_class.selectitem(2)
ii_slip_class	=	2

wf_getchild()

idt_sysdate		=	f_sysdate()

dw_acct_class.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('acct_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
dw_acct_class.reset()
dw_acct_class.insertrow(0)

idw_child.scrolltorow(1)
idw_child.setrow(1)
ii_acct_class	=	idw_child.getitemnumber(1, 'code')

dw_dept.setitem(1, 'code', gs_DeptCode)
is_gwa			=	gs_DeptCode
is_str_date		=	left(f_today(), 6) + '01'
is_end_date		=	f_today()

em_fr_date.text	=	string(is_str_date, '@@@@/@@/@@')
em_to_date.text	=	string(is_end_date, '@@@@/@@/@@')

is_bdgt_year		=	f_getbdgtyear(is_end_date)

end event

event ue_button_set;call super::ue_button_set;long ll_stnd_pos
ll_stnd_pos = dw_update1.x + dw_update1.width 
	cb_1.X			= ll_stnd_pos - cb_1.width
	
	ll_stnd_pos		= ll_stnd_pos - cb_1.width - 16
	
	cb_preview.X			= ll_stnd_pos - cb_preview.width
	
	
ll_stnd_pos = tab_sheet.tabpage_sheet01.gb_2.x + 16

tab_sheet.tabpage_sheet01.pb_dr_insert.x = ll_stnd_pos
ll_stnd_pos			= ll_stnd_pos + tab_sheet.tabpage_sheet01.pb_dr_insert.Width +16
tab_sheet.tabpage_sheet01.pb_dr_delete.x = ll_stnd_pos
 
 ll_stnd_pos = tab_sheet.tabpage_sheet01.gb_3.x + 16

tab_sheet.tabpage_sheet01.pb_cr_insert.x = ll_stnd_pos
ll_stnd_pos			= ll_stnd_pos + tab_sheet.tabpage_sheet01.pb_cr_insert.Width +16
tab_sheet.tabpage_sheet01.pb_cr_delete.x = ll_stnd_pos	
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hfn304a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hfn304a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hfn304a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hfn304a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hfn304a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hfn304a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hfn304a
end type

type uc_insert from w_tabsheet`uc_insert within w_hfn304a
end type

type uc_delete from w_tabsheet`uc_delete within w_hfn304a
end type

type uc_save from w_tabsheet`uc_save within w_hfn304a
end type

type uc_excel from w_tabsheet`uc_excel within w_hfn304a
end type

type uc_print from w_tabsheet`uc_print within w_hfn304a
end type

type st_line1 from w_tabsheet`st_line1 within w_hfn304a
end type

type st_line2 from w_tabsheet`st_line2 within w_hfn304a
end type

type st_line3 from w_tabsheet`st_line3 within w_hfn304a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hfn304a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hfn304a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hfn304a
integer x = 59
integer y = 1116
integer width = 4370
integer height = 1188
integer taborder = 90
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
end type

event tab_sheet::selectionchanged;call super::selectionchanged;choose case newindex
	case	1
		cb_preview.visible = false
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('PRINT',		FALSE)
//		if ii_step_opt = 5 then
//			wf_setMenu('DELETE',	FALSE)
//			wf_setMenu('UPDATE',	FALSE)
//		else
//			wf_setMenu('DELETE',	TRUE)
//			wf_setMenu('UPDATE',	TRUE)
//		end if
	case	2
		cb_preview.visible = false
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		FALSE)
	case	else
		if idw_print.rowcount() > 0 then cb_preview.visible = true
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
end choose
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
integer width = 4334
integer height = 1068
long backcolor = 1073741824
string text = "전표관리"
gb_2 gb_2
gb_3 gb_3
dw_update2 dw_update2
dw_update3 dw_update3
pb_dr_insert pb_dr_insert
pb_dr_delete pb_dr_delete
pb_cr_insert pb_cr_insert
pb_cr_delete pb_cr_delete
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_update2=create dw_update2
this.dw_update3=create dw_update3
this.pb_dr_insert=create pb_dr_insert
this.pb_dr_delete=create pb_dr_delete
this.pb_cr_insert=create pb_cr_insert
this.pb_cr_delete=create pb_cr_delete
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.dw_update2
this.Control[iCurrent+4]=this.dw_update3
this.Control[iCurrent+5]=this.pb_dr_insert
this.Control[iCurrent+6]=this.pb_dr_delete
this.Control[iCurrent+7]=this.pb_cr_insert
this.Control[iCurrent+8]=this.pb_cr_delete
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_update2)
destroy(this.dw_update3)
destroy(this.pb_dr_insert)
destroy(this.pb_dr_delete)
destroy(this.pb_cr_insert)
destroy(this.pb_cr_delete)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
integer y = 4
integer width = 3845
integer height = 224
string dataobject = "d_hfn304a_2"
boolean vscrollbar = false
boolean border = false
end type

event dw_list001::retrieveend;call super::retrieveend;string	ls_job_uid, ls_name

if rowcount < 1 then 
	wf_dw_reset()
	wf_pb_drcr_enabled(false)
	return
end if

wf_pb_drcr_enabled(true)

ii_mast_acct_class	=	getitemnumber(1, 'acct_class')
is_mast_slip_date		=	getitemstring(1, 'slip_date')
il_mast_slip_no		=	getitemnumber(1, 'slip_no')
is_mast_slip_gwa		=	getitemstring(1, 'slip_gwa')

wf_retrieve_detail()
end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(False)
end event

event dw_list001::itemchanged;call super::itemchanged;long	ll_row

data	=	trim(data)

accepttext()

ii_mast_acct_class	=	getitemnumber(row, 'acct_class')
is_mast_slip_date		=	getitemstring(row, 'slip_date')
il_mast_slip_no		=	getitemnumber(row, 'slip_no')
is_mast_slip_gwa		=	getitemstring(row, 'slip_gwa')

if dwo.name = 'slip_date' then
	if not f_isdate(data) then
		setitem(row, 'slip_date', '')
		return 1
	end if
	
	is_bdgt_year	=	f_getbdgtyear(data)
	if isnull(is_bdgt_year) or trim(is_bdgt_year) = '' then
		setitem(row, 'slip_date', '')
		setcolumn('slip_date')
		return 1
	end if

	if f_chk_magam(ii_acct_class, left(data,6)) > 0 then
		setitem(row, 'slip_date', '')
		return 1
	end if

	if f_chk_magam(ii_acct_class, is_bdgt_year) > 0 then
		setitem(row, 'slip_date', '')
		return 1
	end if

	setitem(row,	'bdgt_year',	is_bdgt_year)
	
	// 차변, 대변 값 변경
	for ll_row = 1 to idw_dr.rowcount()
		idw_dr.setitem(ll_row, 'slip_date', data)
		idw_dr.setitem(ll_row, 'bdgt_year', is_bdgt_year)
	next
	for ll_row = 1 to idw_cr.rowcount()
		idw_cr.setitem(ll_row, 'slip_date', data)
		idw_cr.setitem(ll_row, 'bdgt_year', is_bdgt_year)
	next
end if

setitem(row, 'job_uid', 	gs_empcode)
setitem(row, 'job_add', 	gs_ip)
setitem(row, 'job_date',	f_sysdate())

idw_list.setitem(idw_list.getrow(), 'slip_date',	getitemstring(row, 'slip_date'))
idw_list.setitem(idw_list.getrow(), 'remark',	getitemstring(row, 'remark'))

end event

event dw_list001::itemerror;call super::itemerror;return 1
end event

event dw_list001::losefocus;call super::losefocus;accepttext()
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
boolean visible = false
integer width = 101
integer height = 100
end type

type uo_tab from w_tabsheet`uo_tab within w_hfn304a
integer x = 1239
integer y = 1096
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hfn304a
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hfn304a
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_2 from groupbox within tabpage_sheet01
integer y = 208
integer width = 1920
integer height = 148
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_3 from groupbox within tabpage_sheet01
integer x = 1925
integer y = 208
integer width = 1920
integer height = 148
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type dw_update2 from datawindow within tabpage_sheet01
event ue_dwnkey pbm_dwnkey
integer y = 356
integer width = 1920
integer height = 720
integer taborder = 40
string title = "none"
string dataobject = "d_hfn304a_3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

event losefocus;accepttext()
end event

event itemchanged;integer	li_rtn

li_rtn = wf_itemchanged_drcr(this, row, dwo.name, data)

return li_rtn
end event

event itemerror;return	1
end event

event doubleclicked;// 관리항목 도움말 정보 조회
choose case dwo.name
	case 'mana_data1', 'mana_data2', 'mana_data3', 'mana_data4'
		if ib_migyul_proc then
			f_mana_data_help_tmp(this, row, dwo.name, dw_migyul)
		else
			f_mana_data_help(this, row, dwo.name)
		end if
end choose

end event

event retrieveend;integer		li_row

if rowcount < 1 then	return

for li_row = 1 to	rowcount
	setitem(li_row, 'com_mana1_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code1'), trim(getitemstring(li_row, 'mana_data1'))))
	setitem(li_row, 'com_mana2_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code2'), trim(getitemstring(li_row, 'mana_data2'))))
	setitem(li_row, 'com_mana3_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code3'), trim(getitemstring(li_row, 'mana_data3'))))
	setitem(li_row, 'com_mana4_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code4'), trim(getitemstring(li_row, 'mana_data4'))))
next

resetupdate()

end event

type dw_update3 from datawindow within tabpage_sheet01
event ue_dwnkey pbm_dwnkey
integer x = 1925
integer y = 356
integer width = 1920
integer height = 720
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hfn304a_3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

event itemchanged;integer	li_rtn

li_rtn = wf_itemchanged_drcr(this, row, dwo.name, data)

return li_rtn
end event

event itemerror;return	1
end event

event losefocus;accepttext()
end event

event doubleclicked;// 관리항목 도움말 정보 조회
choose case dwo.name
	case 'mana_data1', 'mana_data2', 'mana_data3', 'mana_data4'
		f_mana_data_help(this, row, dwo.name)
end choose

end event

event retrieveend;integer		li_row

if rowcount < 1 then	return

for li_row = 1 to	rowcount
	setitem(li_row, 'com_mana1_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code1'), trim(getitemstring(li_row, 'mana_data1'))))
	setitem(li_row, 'com_mana2_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code2'), trim(getitemstring(li_row, 'mana_data2'))))
	setitem(li_row, 'com_mana3_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code3'), trim(getitemstring(li_row, 'mana_data3'))))
	setitem(li_row, 'com_mana4_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code4'), trim(getitemstring(li_row, 'mana_data4'))))
next

resetupdate()

end event

type pb_dr_insert from uo_imgbtn within tabpage_sheet01
event destroy ( )
integer x = 32
integer y = 252
integer taborder = 110
boolean bringtotop = true
boolean enabled = false
string btnname = "항추가"
end type

on pb_dr_insert.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;wf_insert_drcr(idw_dr, 'D')

end event

type pb_dr_delete from uo_imgbtn within tabpage_sheet01
event destroy ( )
integer x = 343
integer y = 252
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
string btnname = "항삭제"
end type

on pb_dr_delete.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;wf_delete_drcr(idw_dr)
end event

type pb_cr_insert from uo_imgbtn within tabpage_sheet01
event destroy ( )
integer x = 1966
integer y = 252
integer taborder = 130
boolean bringtotop = true
boolean enabled = false
string btnname = "항추가"
end type

on pb_cr_insert.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;wf_insert_drcr(idw_cr, 'C')

end event

type pb_cr_delete from uo_imgbtn within tabpage_sheet01
event destroy ( )
integer x = 2277
integer y = 252
integer taborder = 140
boolean bringtotop = true
boolean enabled = false
string btnname = "항삭제"
end type

on pb_cr_delete.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;wf_delete_drcr(idw_cr)
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4334
integer height = 1068
string text = "전표조회"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list002 dw_list002
end type

on tabpage_sheet02.create
this.dw_list002=create dw_list002
this.Control[]={this.dw_list002}
end on

on tabpage_sheet02.destroy
destroy(this.dw_list002)
end on

type dw_list002 from uo_dwgrid within tabpage_sheet02
integer x = 5
integer width = 4329
integer height = 1068
integer taborder = 130
string dataobject = "d_hfn304a_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return
end event

type tabpage_sheet03 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4334
integer height = 1068
string text = "전표출력"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_sheet03.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_sheet03.destroy
destroy(this.dw_print)
end on

type dw_print from cuo_dwprint within tabpage_sheet03
integer width = 4338
integer height = 1068
integer taborder = 10
string dataobject = "d_hfn304a_6"
boolean vscrollbar = true
boolean border = false
end type

type st_20 from statictext within w_hfn304a
boolean visible = false
integer x = 87
integer y = 168
integer width = 270
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
string text = "회계단위"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_acct_class from datawindow within w_hfn304a
boolean visible = false
integer x = 393
integer y = 152
integer width = 809
integer height = 80
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_acct_class	=	integer(data)

end event

type st_5 from statictext within w_hfn304a
integer x = 91
integer y = 208
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
string text = "전표구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_detail from datawindow within w_hfn304a
boolean visible = false
integer x = 2496
integer y = 16
integer width = 1051
integer height = 432
integer taborder = 110
boolean titlebar = true
string title = "none"
string dataobject = "d_hfn303a_7"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type st_no from statictext within w_hfn304a
boolean visible = false
integer x = 2683
integer y = 24
integer width = 270
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "발의번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_no2 from statictext within w_hfn304a
boolean visible = false
integer x = 3355
integer y = 36
integer width = 119
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_dept_code from statictext within w_hfn304a
integer x = 786
integer y = 208
integer width = 302
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "전표부서"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_dept from datawindow within w_hfn304a
integer x = 1097
integer y = 192
integer width = 1120
integer height = 92
integer taborder = 30
string title = "none"
string dataobject = "ddw_sosok501_group_opt1"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) or trim(data) = '0' or trim(data) = '' then	
	is_gwa	=	''
else
	is_gwa	=	trim(data)
end if

end event

type st_6 from statictext within w_hfn304a
integer x = 2286
integer y = 208
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
string text = "전표기간"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fr_date from editmask within w_hfn304a
integer x = 2574
integer y = 196
integer width = 448
integer height = 76
integer taborder = 40
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

type st_26 from statictext within w_hfn304a
integer x = 3031
integer y = 208
integer width = 46
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "∼"
boolean focusrectangle = false
end type

type em_to_date from editmask within w_hfn304a
integer x = 3095
integer y = 196
integer width = 448
integer height = 76
integer taborder = 50
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

type ddlb_slip_class from dropdownlistbox within w_hfn304a
integer x = 379
integer y = 196
integer width = 379
integer height = 264
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"1.수입","2.지출","3.대체"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_slip_class	=	index

end event

type cbx_migyul from checkbox within w_hfn304a
boolean visible = false
integer x = 3570
integer y = 68
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "미결"
end type

event clicked;if this.checked then
	ib_migyul_proc = true
	dw_migyul.visible = true
else
	ib_migyul_proc = false
	dw_migyul.visible = false
end if

end event

type cb_1 from uo_imgbtn within w_hfn304a
integer x = 4128
integer y = 1064
integer taborder = 160
boolean bringtotop = true
boolean enabled = false
string btnname = "계산서입력"
end type

event clicked;call super::clicked;in_open.opensheetwithparm('w_hfn801a_help', '', w_pf_main)
end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type gb_1 from groupbox within w_hfn304a
integer x = 59
integer y = 136
integer width = 4370
integer height = 172
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "결의서 조회조건"
end type

type cb_preview from uo_imgbtn within w_hfn304a
boolean visible = false
integer x = 3785
integer y = 1064
integer taborder = 170
boolean bringtotop = true
string btnname = "출력전체보기"
end type

event clicked;call super::clicked;dw_all.bringtotop = true
dw_all.visible = true
end event

on cb_preview.destroy
call uo_imgbtn::destroy
end on

type dw_update1 from uo_dwgrid within w_hfn304a
integer x = 59
integer y = 308
integer width = 4370
integer height = 732
integer taborder = 50
string dataobject = "d_hfn304a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;if rowcount < 1 then 
	wf_dw_reset()
	return
else
	wf_pb_drcr_enabled(true)
end if

trigger event rowfocuschanged(1)

end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then	
	wf_dw_reset()
	return
end if

//selectrow(0, false)
//selectrow(currentrow, true)
//
setpointer(hourglass!)

wf_retrieve_mast()

setpointer(arrow!)

end event

event rowfocuschanging;call super::rowfocuschanging;il_list_currentrow	=	currentrow
end event

type dw_all from datawindow within w_hfn304a
boolean visible = false
integer x = 50
integer y = 316
integer width = 4384
integer height = 1960
integer taborder = 150
boolean titlebar = true
string title = "출력전체보기"
string dataobject = "d_hfn303a_6"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
this.Modify("DataWindow.Print.Preview='yes'")

end event

type dw_migyul from datawindow within w_hfn304a
boolean visible = false
integer x = 219
integer y = 576
integer width = 3410
integer height = 540
integer taborder = 50
string title = "none"
string dataobject = "d_hfn_sang_data_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type st_2 from statictext within w_hfn304a
boolean visible = false
integer x = 87
integer y = 816
integer width = 270
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "회계단위"
alignment alignment = right!
boolean focusrectangle = false
end type

