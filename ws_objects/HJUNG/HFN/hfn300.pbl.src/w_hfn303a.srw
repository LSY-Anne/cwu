$PBExportHeader$w_hfn303a.srw
$PBExportComments$결의서분개및취소
forward
global type w_hfn303a from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type gb_3 from groupbox within tabpage_sheet01
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
type dw_update2 from datawindow within tabpage_sheet01
end type
type pb_dr_tax from uo_imgbtn within tabpage_sheet01
end type
type pb_cr_tax from uo_imgbtn within tabpage_sheet01
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
type st_20 from statictext within w_hfn303a
end type
type dw_acct_class from datawindow within w_hfn303a
end type
type st_2 from statictext within w_hfn303a
end type
type dw_slip_acct_class from datawindow within w_hfn303a
end type
type uo_slip_date from cuo_date within w_hfn303a
end type
type st_slip_no from statictext within w_hfn303a
end type
type em_slip_no from editmask within w_hfn303a
end type
type st_5 from statictext within w_hfn303a
end type
type st_7 from statictext within w_hfn303a
end type
type dw_detail from datawindow within w_hfn303a
end type
type st_no from statictext within w_hfn303a
end type
type st_no2 from statictext within w_hfn303a
end type
type st_dept_code from statictext within w_hfn303a
end type
type dw_dept from datawindow within w_hfn303a
end type
type st_6 from statictext within w_hfn303a
end type
type em_fr_date from editmask within w_hfn303a
end type
type st_26 from statictext within w_hfn303a
end type
type em_to_date from editmask within w_hfn303a
end type
type ddlb_step_opt from dropdownlistbox within w_hfn303a
end type
type ddlb_slip_class from dropdownlistbox within w_hfn303a
end type
type gb_1 from groupbox within w_hfn303a
end type
type dw_update1 from uo_dwgrid within w_hfn303a
end type
type st_1 from statictext within w_hfn303a
end type
type st_3 from statictext within w_hfn303a
end type
type cb_1 from uo_imgbtn within w_hfn303a
end type
type cb_prev from uo_imgbtn within w_hfn303a
end type
type cb_next from uo_imgbtn within w_hfn303a
end type
type gb_4 from groupbox within w_hfn303a
end type
type dw_all from datawindow within w_hfn303a
end type
type cb_preview from uo_imgbtn within w_hfn303a
end type
end forward

global type w_hfn303a from w_tabsheet
string title = "결의서분개"
st_20 st_20
dw_acct_class dw_acct_class
st_2 st_2
dw_slip_acct_class dw_slip_acct_class
uo_slip_date uo_slip_date
st_slip_no st_slip_no
em_slip_no em_slip_no
st_5 st_5
st_7 st_7
dw_detail dw_detail
st_no st_no
st_no2 st_no2
st_dept_code st_dept_code
dw_dept dw_dept
st_6 st_6
em_fr_date em_fr_date
st_26 st_26
em_to_date em_to_date
ddlb_step_opt ddlb_step_opt
ddlb_slip_class ddlb_slip_class
gb_1 gb_1
dw_update1 dw_update1
st_1 st_1
st_3 st_3
cb_1 cb_1
cb_prev cb_prev
cb_next cb_next
gb_4 gb_4
dw_all dw_all
cb_preview cb_preview
end type
global w_hfn303a w_hfn303a

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_mast, idw_dr, idw_cr

datawindow			idw_data,  idw_preview



uo_imgbtn		ipb_dr_insert, ipb_cr_insert, ipb_dr_delete, ipb_cr_delete

datetime				idt_sysdate
integer				ii_stat_gbn						// 처리구분(1:전표분개, 2:분개취소, 3:전표수정)
string				is_stat_gbn_title				// 처리구분 타이틀
integer				ii_step_opt						// 상태구분(4:전표분개, 2:분개취소, 4:전표수정)
integer				ii_retrieve_step				// 조회상태(2:전표분개, 4:분개취소, 4:전표수정)

//	결의서 조회조건
integer				ii_acct_class					// 회계단위
integer				ii_slip_class					// 전표구분
string				is_gwa							// 부서
string				is_str_date, is_end_date	// 기간

// 전표조회/입력조건
integer				ii_slip_acct_class			// 회계단위
string				is_slip_date					//	전표일자
long					il_slip_no						// 전표번호
string				is_bdgt_year					// 회계년도

// 마스터자료
integer				ii_mast_acct_class
string				is_mast_slip_date, is_mast_slip_gwa
string				is_gubun

long					il_list_currentrow, il_mast_slip_no

boolean				ib_tax_proc
end variables

forward prototypes
public function integer wf_chk_null (datawindow adw, string as_required[])
public subroutine wf_delete_drcr (datawindow adw_1)
public subroutine wf_dw_reset ()
public subroutine wf_obj_enabled (boolean ab_gubun)
public subroutine wf_retrieve_detail ()
public subroutine wf_retrieve_mast ()
public subroutine wf_getchild ()
public function integer wf_condition_chk ()
public function integer wf_hfn202h_proc (integer ai_acct_class, string as_slip_date, integer ai_slip_no, integer ai_log_opt)
public function integer wf_insert_drcr (datawindow adw_1, string as_drcr_class)
public function integer wf_mana_chk_null (datawindow adw_drcr)
public function integer wf_save ()
public subroutine wf_pb_drcr_enabled (boolean ab_enabled)
public function integer wf_retrieve ()
public function integer wf_itemchanged_drcr (datawindow adw_drcr, integer ai_row, string as_colname, string as_data)
public function string wf_acct_name (string as_acct_code)
public function integer wf_chk_slip_no (integer a_acct_class, string a_resol_date, integer a_resol_no)
end prototypes

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
	ll_resol_no	  =	adw_1.getitemnumber(adw_1.getrow(), 'resol_no')
	ll_slip_seq	  =	adw_1.getitemnumber(adw_1.getrow(), 'slip_seq')
	ls_drcr_class =	adw_1.getitemstring(adw_1.getrow(), 'drcr_class')
	
	if ll_resol_no <> 0 then
		f_messagebox('3', '[' + string(ll_slip_seq) + ']항의 자료는 결의번호 [' + string(ll_resol_no) + '] 이므로~n~n삭제할 수 없습니다.!')
	else
		if isnull(ll_slip_seq) then ll_slip_seq = adw_1.getrow()
		
		if f_messagebox('2', '[' + string(ll_slip_seq) + ']항의 자료를 삭제하시겠습니까?')	=	1	then
			
			adw_1.deleterow(adw_1.getrow())
			
			if idw_dr.rowcount() = 0 and idw_cr.rowcount() = 0 then	idw_mast.deleterow(0)
		end if
	end if
end if

wf_setMsg('.')


end subroutine

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
// 처리구분 = 전표분개
if ii_stat_gbn	=	1	then
	
	ddlb_step_opt.Enabled		=	ab_gubun
	
	ddlb_slip_class.enabled		=	ab_gubun

	// 결의서 DW
	idw_list.enabled				=	ab_gubun
	
	// 전표조회조건
	uo_slip_date.uf_enabled(ab_gubun)
	
	// 전표 DW
	idw_mast.enabled				=	ab_gubun
	
	// 항추가삭제버튼
	wf_pb_drcr_enabled(ab_gubun)
	
	// 전표내역 DW
	idw_dr.enabled					=	ab_gubun
	idw_cr.enabled					=	ab_gubun
	
// 처리구분 = 전표수정
elseif ii_stat_gbn	=	5	then

	ddlb_step_opt.Enabled		=	ab_gubun

	uo_slip_date.uf_enabled(ab_gubun)
	em_slip_no.enabled			=	ab_gubun

	// 전표 DW
	idw_mast.enabled				=	ab_gubun
	
	// 항추가삭제버튼
	wf_pb_drcr_enabled(ab_gubun)
	
	// 전표내역 DW
	idw_dr.enabled					=	ab_gubun
	idw_cr.enabled					=	ab_gubun
end if

end subroutine

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


idw_dr.setredraw(false)
idw_cr.setredraw(false)

idw_dr.retrieve(ii_slip_acct_class, is_slip_date, il_slip_no, 'D')
idw_cr.retrieve(ii_slip_acct_class, is_slip_date, il_slip_no, 'C')

idw_preview.retrieve(ii_slip_acct_class, is_slip_date, il_slip_no)

if idw_print.retrieve(ii_slip_acct_class, is_slip_date, il_slip_no) > 0 then
	dw_all.retrieve(ii_slip_acct_class, is_slip_date, il_slip_no)

end if

idw_dr.setredraw(true)
idw_cr.setredraw(true)

end subroutine

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
long		ll_row, ll_slip_no

ll_row	=	idw_list.getrow()

if ll_row	<	1 then	return

idw_mast.setredraw(false)

li_acct_class	=	idw_list.getitemnumber(ll_row, 'acct_class')
ls_slip_date	=	idw_list.getitemstring(ll_row, 'slip_date')
ll_slip_no		=	idw_list.getitemnumber(ll_row, 'slip_no')



if idw_mast.retrieve(li_acct_class, ls_slip_date, ll_slip_no) > 0 then
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
// 결의부서
dw_dept.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_child.insertrow(1)
idw_child.setitem(1, 'dept_code', '')
idw_child.setitem(1, 'dept_name', '부서전체')

dw_dept.reset()
dw_dept.insertrow(0)

// 결의발생구분
idw_list.getchild('genesis_gb', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('genesis_gb', 0) < 1 then
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

public function integer wf_condition_chk ();// ==========================================================================================
// 기    능	:	결의서 조회조건 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_condition_chk()	returns	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
date	ld_date

// 결의서 조회조건 체크
if ddlb_slip_class.enabled then
	em_fr_date.getdata(ld_date)
	is_str_date = string(ld_date, 'yyyymmdd')
	
	if trim(is_str_date) = '' or trim(is_str_date) = '00000000'	then
		f_messagebox('1', '결의서 조회조건의 결의일자(From)을 정확히 입력해 주시기 바랍니다.!')
		em_fr_date.setfocus()
		return	100
	end if

	em_to_date.getdata(ld_date)
	is_end_date = string(ld_date, 'yyyymmdd')

	if trim(is_end_date) = '' or trim(is_end_date) = '00000000'	then
		f_messagebox('1', '결의서 조회조건의 결의일자(To)을 정확히 입력해 주시기 바랍니다.!')
		em_to_date.setfocus()
		return	100
	end if
	
// 전표 조회조건 체크
else
	if trim(is_slip_date) = '' or trim(is_slip_date) = '00000000' then
		f_messagebox('1', '전표조회 조건의 전표일자를 정확히 입력해 주시기 바랍니다.!')
		uo_slip_date.em_date.setfocus()
		return	100
	end if
	
	if	il_slip_no	=	0	then
		f_messagebox('1', '전표조회 조건의 전표번호를 정확히 입력해 주시기 바랍니다.!')
		em_slip_no.setfocus()
		return	100
	end if		
end if

return	0
end function

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
integer	li_newrow, li_code, li_max_code
dec{0}	ldb_amt, ldb_amt2
string	ls_remark

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
adw_1.setitem(li_newrow, 'resol_no',		0)
adw_1.setitem(li_newrow, 'ai_stat_gbn',	ii_stat_gbn)

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

string	ls_mast_insert, ls_mast_modify
long		ll_rowcount, ll_row, ll_slip_seq
integer	li_count, li_slip_seq
string	ls_resol_date, ls_chk_resol_date, ls_chk_slip_date
long		ll_resol_no, ll_chk_resol_no, ll_return

if idw_mast.rowcount()	<	1	then	
	f_messagebox('1', is_stat_gbn_title + ' 자료가 존재하지 않습니다.~n~n확인 후 저장하시기 바랍니다.!')
	return	100
end if
	
if idw_dr.rowcount()	<	1	or	idw_cr.rowcount() < 1	then	
	f_messagebox('1', is_stat_gbn_title + ' 자료가 존재하지 않습니다.~n~n확인 후 저장하시기 바랍니다.!')
	return	100
end if


// Not Null 항목 체크
if wf_chk_null(idw_mast, {'slip_date/전표일자'})	<	0	then	return	100

if wf_chk_null(idw_dr, {'acct_code/계정과목', 'slip_amt/전표금액'})	<	0	then	return	100
	
if wf_chk_null(idw_cr, {'acct_code/계정과목', 'slip_amt/전표금액'})	<	0	then	return	100

if ii_stat_gbn = 1 or ii_stat_gbn = 5 then
	if idw_mast.modifiedcount() = 0 and &
   	idw_dr.modifiedcount() = 0 and &
		idw_dr.deletedcount() = 0 and &
		idw_cr.modifiedcount() = 0 and &
		idw_cr.deletedcount() = 0 then
		wf_setmsg('자료를 변경하신 후 저장하시기 바랍니다.')
		return 100
	end if
end if


///////////////////////////////////////////////////////////////////////////////
//이미분개된 결의서인지 검사 : 이중전표발생 방지 (2005.03.17 : Jung Kwang Hoon)
// 처리상태 = 전표분개(1) 일경우 체크하는것...
if ii_stat_gbn = 1 then
	ls_chk_resol_date = idw_mast.getItemString(idw_mast.getrow(), 'resol_date')
	ll_chk_resol_no 	= idw_mast.getItemNumber(idw_mast.getrow(), 'resol_no')

	if wf_chk_slip_no(ii_mast_acct_class, ls_chk_resol_date, ll_chk_resol_no) > 0 then
		f_messagebox('1', '이미 전표분개한 결의서입니다.('+ls_chk_resol_date+'-'+string(ll_chk_resol_no)+')~r~r' + &
								'결의서목록을 다시 조회하시기 바랍니다.')
		return 100
	end if
end if
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// 전표일자, 결의일자 검사 (2006.03.08 : Jung Kwang Hoon)
// 처리상태 = 전표분개(1) 일경우 체크하는것...
if ii_stat_gbn = 1 then
	ls_chk_slip_date  = idw_mast.getItemString(idw_mast.getrow(), 'slip_date')
	ls_chk_resol_date = idw_mast.getItemString(idw_mast.getrow(), 'resol_date')

	if ls_chk_resol_date > ls_chk_slip_date then
		f_messagebox('1', '전표일자가 결의서일자와 같거나 이후이어야 합니다.~n~n확인 후 저장하시기 바랍니다.!')
		return 100
	end if
end if
///////////////////////////////////////////////////////////////////////////////


// 관리항목 내용 확인
if wf_mana_chk_null(idw_dr) < 0 then return 100
if wf_mana_chk_null(idw_cr) < 0 then return 100

// 저장 확인 메세지
if f_messagebox('2', is_stat_gbn_title + '를(을) 하시겠습니까?') = 2	then	return	100

// 처리상태 = 전표분개(1) or 전표수정(5)
if ii_stat_gbn = 1 or ii_stat_gbn = 3 then
	ls_mast_insert	=	idw_mast.describe("evaluate('isRowNew()', 1)")
	ls_mast_modify	=	idw_mast.describe("evaluate('isRowModified()', 1)")
	
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
	end if

	// Mast Update
	if idw_mast.modifiedcount() > 0 or idw_mast.deletedcount() > 0 then
		IF idw_mast.Update(true)	<>	1 then	return	-1
	end if

	// 차변금액과 대변금액은 같아야 한다.
	dec{0}	ldb_dr_amt, ldb_cr_amt
	
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

	// Slip No Setitem
	// 차변금액 Update
	if idw_dr.modifiedcount() > 0 or idw_dr.deletedcount() > 0 then
		select	nvl(max(slip_seq),0)
		into		:li_slip_seq
		from		fndb.hfn202m
		where		acct_class	=	:ii_mast_acct_class
		and		slip_date	=	:is_mast_slip_date
		and		slip_no		=	:il_mast_slip_no ;
		
		ll_rowcount	=	idw_dr.rowcount()
		for ll_row = 1 to ll_rowcount
			if idw_dr.getitemstatus(ll_row,0,primary!) = new! or idw_dr.getitemstatus(ll_row,0,primary!) = newmodified! then
				li_slip_seq ++
				idw_dr.setitem(ll_row, 'slip_no', 	il_mast_slip_no)
				idw_dr.setitem(ll_row, 'slip_seq', 	li_slip_seq)
				
				// 관리항목이 전표번호인 경우 삽입
				if idw_dr.getitemnumber(ll_row, 'mana_code1') = 9 and &
				   idw_dr.getitemstring(ll_row, 'drcr_class') = idw_dr.getitemstring(ll_row, 'com_drcr_class') then
					idw_dr.setitem(ll_row, 'mana_data1', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
				if idw_dr.getitemnumber(ll_row, 'mana_code2') = 9 and &
				   idw_dr.getitemstring(ll_row, 'drcr_class') = idw_dr.getitemstring(ll_row, 'com_drcr_class') then
					idw_dr.setitem(ll_row, 'mana_data2', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
				if idw_dr.getitemnumber(ll_row, 'mana_code3') = 9 and &
				   idw_dr.getitemstring(ll_row, 'drcr_class') = idw_dr.getitemstring(ll_row, 'com_drcr_class') then
					idw_dr.setitem(ll_row, 'mana_data3', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
				if idw_dr.getitemnumber(ll_row, 'mana_code4') = 9 and &
				   idw_dr.getitemstring(ll_row, 'drcr_class') = idw_dr.getitemstring(ll_row, 'com_drcr_class') then
					idw_dr.setitem(ll_row, 'mana_data4', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
			end if
		next			

		if idw_dr.update() <>	1	then	return	-1
	end if
	
	// Slip No Setitem
	// 대변금액 Update
	if idw_cr.modifiedcount() > 0 or idw_cr.deletedcount() > 0 then
		select	nvl(max(slip_seq),0)
		into		:li_slip_seq
		from		fndb.hfn202m
		where		acct_class	=	:ii_mast_acct_class
		and		slip_date	=	:is_mast_slip_date
		and		slip_no		=	:il_mast_slip_no ;

		ll_rowcount	=	idw_cr.rowcount()
		for ll_row = 1 to ll_rowcount
			if idw_cr.getitemstatus(ll_row,0,primary!) = new! or idw_cr.getitemstatus(ll_row,0,primary!) = newmodified! then
				li_slip_seq ++
				idw_cr.setitem(ll_row, 'slip_no', 	il_mast_slip_no)
				idw_cr.setitem(ll_row, 'slip_seq', 	li_slip_seq)
				
				// 관리항목이 전표번호인 경우 삽입
				if idw_cr.getitemnumber(ll_row, 'mana_code1') = 9 and &
				   idw_cr.getitemstring(ll_row, 'drcr_class') = idw_cr.getitemstring(ll_row, 'com_drcr_class') then
					idw_cr.setitem(ll_row, 'mana_data1', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
				if idw_cr.getitemnumber(ll_row, 'mana_code2') = 9 and &
				   idw_cr.getitemstring(ll_row, 'drcr_class') = idw_cr.getitemstring(ll_row, 'com_drcr_class') then
					idw_cr.setitem(ll_row, 'mana_data2', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
				if idw_cr.getitemnumber(ll_row, 'mana_code3') = 9 and &
				   idw_cr.getitemstring(ll_row, 'drcr_class') = idw_cr.getitemstring(ll_row, 'com_drcr_class') then
					idw_cr.setitem(ll_row, 'mana_data3', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
				if idw_cr.getitemnumber(ll_row, 'mana_code4') = 9 and &
				   idw_cr.getitemstring(ll_row, 'drcr_class') = idw_cr.getitemstring(ll_row, 'com_drcr_class') then
					idw_cr.setitem(ll_row, 'mana_data4', is_mast_slip_date + '-' + string(il_mast_slip_no) + '-' + string(li_slip_seq))
				end if
			end if
		next
	
		if idw_cr.update() <>	1	then	return	-1
	end if
	
	// 접수(1)일 경우는 결의서에 전표번호, 전표항을 삽입한다.
	if ii_stat_gbn = 1 then
		ll_rowcount	=	idw_list.rowcount()
		for	ll_row = 1 to ll_rowcount
			if	idw_list.getitemnumber(ll_row, 'step_opt') = 4 then
				ls_resol_date	=	idw_list.getitemstring(ll_row, 'resol_date')
				ll_resol_no		=	idw_list.getitemnumber(ll_row, 'resol_no')
				
				// 결의서 Mast 전표일자, 전표번호 Update
				update	fndb.hfn101m
				set		step_opt		=	4,
							slip_date	=	:is_mast_slip_date,
							slip_no		=	:il_mast_slip_no
				where		acct_class	=	:ii_acct_class
				and		resol_date	=	:ls_resol_date
				and		resol_no		=	:ll_resol_no	;
				
				if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
				
				// 결의서 Detail 전표일자, 전표번호 Update
				update	fndb.hfn102m
				set		slip_date	=	:is_mast_slip_date,
							slip_no		=	:il_mast_slip_no
				where		acct_class	=	:ii_acct_class
				and		resol_date	=	:ls_resol_date
				and		resol_no		=	:ll_resol_no	;
				
				if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
			end if
		next
				
		// 결의서 Detail 전표항 Update
		update	fndb.hfn102m
		set		slip_date	=	:is_mast_slip_date,
					slip_no		=	:il_mast_slip_no,
					slip_seq		=	rownum
		where		acct_class	=	:ii_acct_class
		and		slip_date	=	:is_mast_slip_date
		and		slip_no		=	:il_mast_slip_no	;
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
		
		// 결의이력정보에 Update
		if wf_hfn202h_proc(ii_acct_class, is_mast_slip_date, il_mast_slip_no, 1) <> 0 then return -1
	else
		// 결의이력정보에 Update
		if wf_hfn202h_proc(ii_acct_class, is_mast_slip_date, il_mast_slip_no, 2) <> 0 then return -1
	end if

// 처리상태 = 접수취소(3)
elseif ii_stat_gbn = 2 then
	// 결의이력정보에 Update
	if wf_hfn202h_proc(ii_acct_class, is_slip_date, il_slip_no, 3) <> 0 then return -1

	// 전표 Delete
	delete	from	fndb.hfn201m
	where		acct_class	=	:ii_acct_class
	and		slip_date	=	:is_slip_date
	and		slip_no		=	:il_slip_no	;
	
	if sqlca.sqlcode	<>	0	then	return	sqlca.sqlcode
	
	// 결의서 Mast의 상태번호를 송부(2)로 수정, 전표일자, 전표번호를 reset
	update	fndb.hfn101m
	set		step_opt		=	2,
				slip_date	=	'',
				slip_no		=	0
	where		acct_class	=	:ii_acct_class
	and		slip_date	=	:is_slip_date
	and		slip_no		=	:il_slip_no	;

	if sqlca.sqlcode	<>	0	then	return	sqlca.sqlcode
	
	// 결의서 Detail의 상태번호를 송부(2)로 수정, 전표일자, 전표번호, 전표항을 reset
	update	fndb.hfn102m
	set		slip_date	=	'',
				slip_no		=	0,
				slip_seq		=	0
	where		acct_class	=	:ii_acct_class
	and		slip_date	=	:is_slip_date
	and		slip_no		=	:il_slip_no	;

	if sqlca.sqlcode	<>	0	then	return	sqlca.sqlcode
	
	il_slip_no = 0
	em_slip_no.text = string(il_slip_no)
	
end if

return	0

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
tab_sheet.tabpage_sheet01.pb_dr_insert.of_enable(ab_enabled)
tab_sheet.tabpage_sheet01.pb_dr_delete.of_enable(ab_enabled)
tab_sheet.tabpage_sheet01.pb_cr_insert.of_enable(ab_enabled)
tab_sheet.tabpage_sheet01.pb_cr_delete.of_enable(ab_enabled)
cb_1.of_enable(ab_enabled)


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

long		ll_rowcount
integer	li_step_opt

if wf_condition_chk() = 100	then	return	100

// 처리구분 = 전표분개
if	ii_stat_gbn = 1 then
	idw_list.setredraw(false)
	idw_list.retrieve(ii_acct_class, ii_slip_class, is_gwa, is_str_date, is_end_date, ii_stat_gbn)
	idw_list.setredraw(true)

	wf_dw_reset()
	
	idw_mast.object.datawindow.readonly = False
	idw_dr.object.datawindow.readonly   = False
	idw_cr.object.datawindow.readonly   = False

// 처리구분 = 분개취소 or 전표수정
elseif	ii_stat_gbn	= 2 or ii_stat_gbn	= 3 then
	if	il_slip_no	=	0 then	return	100
	
	idw_mast.setredraw(false)

	ll_rowcount	=	idw_mast.retrieve(ii_slip_acct_class, is_slip_date, il_slip_no, ii_stat_gbn)

	if ll_rowcount	<	1	then
		f_messagebox('1', '해당 전표가 없습니다.!')
		wf_pb_drcr_enabled(false)
	else
		ii_step_opt	=	idw_mast.getitemnumber(ll_rowcount, 'step_opt')

		if	ii_step_opt	=	5	then
			wf_setmsg('이미 확정처리되어 ' + is_stat_gbn_title + '를(을) 할 수 없습니다.!')
//			wf_setMenu('UPDATE',		FALSE)
		else
			wf_setmsg(is_stat_gbn_title)
//			wf_setMenu('UPDATE',		TRUE)
		end if

		wf_retrieve_detail()

		if ii_stat_gbn = 3 and ii_step_opt = 5 then
			idw_mast.object.datawindow.readonly = True
			idw_dr.object.datawindow.readonly   = True
			idw_cr.object.datawindow.readonly   = true
			wf_pb_drcr_enabled(false)
		else
			idw_mast.object.datawindow.readonly = False
			idw_dr.object.datawindow.readonly   = False
			idw_cr.object.datawindow.readonly   = False
			wf_pb_drcr_enabled(True)
		end if
	end if
	
	idw_mast.setredraw(true)
end if

return 0
end function

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
string		ls_com_drcr_class
integer		li_mana_code, li_mana_code1, li_mana_code2, li_mana_code3, li_mana_code4
string		ls_bdgt_cntl_yn, ls_drcr_class, ls_com_mi_gubun
long			ll_cnt
dec{0}		ldec_jan_amt

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
			if ii_slip_class = 1 then
				select	count(*)	into	:ll_cnt	from	acdb.hac001m
				where		acct_code	like	:as_data||'%'
				and		level_class	=		'4' ;
			else
				select	count(*)	into	:ll_cnt	from	acdb.hac001m
				where		acct_code	like	:as_data||'%'
				and		level_class		=		'4' ;
			end if
		else
			if ii_slip_class = 1 then
				select	count(*)	into	:ll_cnt	from	acdb.hac001m
				where		acct_name	like	'%'||:as_data||'%'
				and		level_class	=		'4' ;
			else
				select	count(*)	into	:ll_cnt	from	acdb.hac001m
				where		acct_name	like	'%'||:as_data||'%'
				and		level_class		=		'4' ;
			end if
		end if
		
		if ll_cnt < 1 then
			messagebox('확인', '등록된 계정이 없습니다.')
			adw_drcr.setitem(ai_row, 'acct_code', '')
			adw_drcr.setitem(ai_row, 'com_acct_name', '')
			return 1
		end if
		
		if ll_cnt = 1 then
			if as_colname = 'acct_code' then
				if ii_slip_class = 1 then
					select	acct_code, acct_iname, bdgt_cntl_yn, mana_code, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn
					into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun
					from		acdb.hac001m
					where		acct_code	like	:as_data||'%'
					and		level_class		=		'4' ;
				else
					select	acct_code, acct_iname, bdgt_cntl_yn, mana_code, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn
					into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun
					from		acdb.hac001m
					where		acct_code	like	:as_data||'%'
					and		level_class		=		'4' ;
				end if
			else
				if ii_slip_class = 1 then
					select	acct_code, acct_iname, bdgt_cntl_yn, mana_code, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn
					into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun
					from		acdb.hac001m
					where		acct_name	like	'%'||:as_data||'%'
					and		level_class		=		'4' ;
				else
					select	acct_code, acct_iname, bdgt_cntl_yn, mana_code, decode(:ls_drcr_class,'D',dr_mana_code1,cr_mana_code1), decode(:ls_drcr_class,'D',dr_mana_code2,cr_mana_code2), decode(:ls_drcr_class,'D',dr_mana_code3,cr_mana_code3), decode(:ls_drcr_class,'D',dr_mana_code4,cr_mana_code4), drcr_class, mi_acct_yn
					into		:ls_acct_code, :ls_acct_name, :ls_bdgt_cntl_yn, :li_mana_code, :li_mana_code1, :li_mana_code2, :li_mana_code3, :li_mana_code4, :ls_com_drcr_class, :ls_com_mi_gubun
					from		acdb.hac001m
					where		acct_name	like	'%'||:as_data||'%'
					and		level_class		=		'4' ;
				end if
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
			
			ls_acct_code		 = lstr_rtn.ls_item[1]
			ls_acct_name 	 	 = lstr_rtn.ls_item[2]
			ls_com_drcr_class	 = lstr_rtn.ls_item[3]
			ls_bdgt_cntl_yn 	 = lstr_rtn.ls_item[4]
			li_mana_code1	 	 = integer(lstr_rtn.ls_item[5])
			li_mana_code2	 	 = integer(lstr_rtn.ls_item[6])
			li_mana_code3	 	 = integer(lstr_rtn.ls_item[7])
			li_mana_code4	 	 = integer(lstr_rtn.ls_item[8])
			li_mana_code	 	 = integer(lstr_rtn.ls_item[9])
			ls_com_mi_gubun	 = lstr_rtn.ls_item[10]
			
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
		if adw_drcr.getitemstring(ai_row, 'com_mi_gubun') <> 'Y' then
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

public function string wf_acct_name (string as_acct_code);// ==========================================================================================
// 기    능	:	select acct_name
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_acct_name(string as_acct_code) returns string
// 인    수 :  as_acct_code(계정과목)
// 되 돌 림 :	계정과목명
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String	Ls_acct_name
integer	li_slip_class
long		ll_row

ll_row = idw_list.getrow()

li_slip_class = idw_list.getitemnumber(ll_row, 'slip_class')

Select	drcr_class||decode(:li_slip_class,1,acct_iname,2,acct_oname,acct_name)
Into		:Ls_acct_name
From		acdb.hac001m
Where		acct_code	=	:as_acct_code ;

If IsNull(Ls_acct_name) Then Ls_acct_name = ''

Ls_acct_name = Trim(Ls_acct_name)

Return Ls_acct_name
end function

public function integer wf_chk_slip_no (integer a_acct_class, string a_resol_date, integer a_resol_no);string 	ls_slip_date_no
integer	li_step_opt

//이미분개된 결의서인지 검사 : 이중전표발생 방지 (2005.03.17 : Jung Kwang Hoon)
SELECT 	STEP_OPT,   	SLIP_DATE||SLIP_NO  
INTO 		:li_step_opt,	:ls_slip_date_no
FROM 		FNDB.HFN101M  
WHERE 	ACCT_CLASS 	= 	:a_acct_class
AND  		RESOL_DATE 	=  :a_resol_date
AND  		RESOL_NO 	=  :a_resol_no ;

if li_step_opt = 4 or li_step_opt = 5 or len(ls_slip_date_no) > 8 then
	return 1
else
	return 0
end if

end function

on w_hfn303a.create
int iCurrent
call super::create
this.st_20=create st_20
this.dw_acct_class=create dw_acct_class
this.st_2=create st_2
this.dw_slip_acct_class=create dw_slip_acct_class
this.uo_slip_date=create uo_slip_date
this.st_slip_no=create st_slip_no
this.em_slip_no=create em_slip_no
this.st_5=create st_5
this.st_7=create st_7
this.dw_detail=create dw_detail
this.st_no=create st_no
this.st_no2=create st_no2
this.st_dept_code=create st_dept_code
this.dw_dept=create dw_dept
this.st_6=create st_6
this.em_fr_date=create em_fr_date
this.st_26=create st_26
this.em_to_date=create em_to_date
this.ddlb_step_opt=create ddlb_step_opt
this.ddlb_slip_class=create ddlb_slip_class
this.gb_1=create gb_1
this.dw_update1=create dw_update1
this.st_1=create st_1
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_prev=create cb_prev
this.cb_next=create cb_next
this.gb_4=create gb_4
this.dw_all=create dw_all
this.cb_preview=create cb_preview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_20
this.Control[iCurrent+2]=this.dw_acct_class
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_slip_acct_class
this.Control[iCurrent+5]=this.uo_slip_date
this.Control[iCurrent+6]=this.st_slip_no
this.Control[iCurrent+7]=this.em_slip_no
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_7
this.Control[iCurrent+10]=this.dw_detail
this.Control[iCurrent+11]=this.st_no
this.Control[iCurrent+12]=this.st_no2
this.Control[iCurrent+13]=this.st_dept_code
this.Control[iCurrent+14]=this.dw_dept
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.em_fr_date
this.Control[iCurrent+17]=this.st_26
this.Control[iCurrent+18]=this.em_to_date
this.Control[iCurrent+19]=this.ddlb_step_opt
this.Control[iCurrent+20]=this.ddlb_slip_class
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.dw_update1
this.Control[iCurrent+23]=this.st_1
this.Control[iCurrent+24]=this.st_3
this.Control[iCurrent+25]=this.cb_1
this.Control[iCurrent+26]=this.cb_prev
this.Control[iCurrent+27]=this.cb_next
this.Control[iCurrent+28]=this.gb_4
this.Control[iCurrent+29]=this.dw_all
this.Control[iCurrent+30]=this.cb_preview
end on

on w_hfn303a.destroy
call super::destroy
destroy(this.st_20)
destroy(this.dw_acct_class)
destroy(this.st_2)
destroy(this.dw_slip_acct_class)
destroy(this.uo_slip_date)
destroy(this.st_slip_no)
destroy(this.em_slip_no)
destroy(this.st_5)
destroy(this.st_7)
destroy(this.dw_detail)
destroy(this.st_no)
destroy(this.st_no2)
destroy(this.st_dept_code)
destroy(this.dw_dept)
destroy(this.st_6)
destroy(this.em_fr_date)
destroy(this.st_26)
destroy(this.em_to_date)
destroy(this.ddlb_step_opt)
destroy(this.ddlb_slip_class)
destroy(this.gb_1)
destroy(this.dw_update1)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_prev)
destroy(this.cb_next)
destroy(this.gb_4)
destroy(this.dw_all)
destroy(this.cb_preview)
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

long			ll_list_getrow, ll_resol_no, ll_rowcount, ll_detail_row
long			ll_newrow, ll_slip_seq, ll_row
string		ls_resol_date, ls_drcr_class, ls_step_opt, ls_slip_date_no
datawindow	ldw_1

long		ll_list_row



if isnull(is_bdgt_year) or trim(is_bdgt_year) = '' then

	return
end if

//ll_list_getrow	=	idw_list.getrow()  2003-12-01
ll_list_getrow	=	idw_list.getrow()
ll_list_row		=	idw_list.getrow()

if	ll_list_row	=	0	then

	f_messagebox('1', '전표분개할 결의서를 선택해 주시기 바랍니다.')
	return	
end if

if is_slip_date < idw_list.getitemstring(ll_list_row, 'resol_date') then
	messagebox('확인', '결의서일자보다 전표일자가 이전 자료로 처리할 수 없습니다.~r~r' + &
	                   '전표일자를 수정하시기 바랍니다.')

	uo_slip_date.em_date.setfocus()
	return
end if

idw_mast.object.datawindow.readonly = False
idw_dr.object.datawindow.readonly   = False
idw_cr.object.datawindow.readonly   = False
wf_pb_drcr_enabled(True)

is_mast_slip_date		=	is_slip_date
ii_mast_acct_class	=	ii_slip_acct_class
is_mast_slip_gwa		=	idw_list.getitemstring(ll_list_getrow, 'resol_gwa')
il_mast_slip_no		=	0

wf_dw_reset()

// 변경전 flag로 환원
FOR ll_row = 1 TO idw_list.rowcount()
	// 결의서 상태를 송부(2)로 지정한다.
	idw_list.setitem(ll_row, 'step_opt', 	2)
	idw_list.setitem(ll_row, 'slip_date',	'')
NEXT

ll_slip_seq		=	0

if ll_list_row > 0 Then
//do while	ll_list_row	>	0
	ls_resol_date	=	idw_list.getitemstring(ll_list_row, 'resol_date')
	ll_resol_no		=	idw_list.getitemnumber(ll_list_row, 'resol_no')
	
	///////////////////////////////////////////////////////////////////////////////
	//이미분개된 결의서인지 검사 : 이중전표발생 방지 (2005.03.17 : Jung Kwang Hoon)
	if wf_chk_slip_no(ii_mast_acct_class, ls_resol_date, ll_resol_no) > 0 then
		messagebox('확인', '이미 전표분개한 결의서입니다.('+ls_resol_date+'-'+string(ll_resol_no)+')~r~r' + &
								 '결의서목록을 다시 조회하시기 바랍니다.')

		idw_list.setfocus()
		return
	end if
	///////////////////////////////////////////////////////////////////////////////
	
	ll_rowcount	=	dw_detail.retrieve(ii_acct_class, ls_resol_date, ll_resol_no)
	
	for	ll_detail_row	=	1	to	ll_rowcount
		ls_drcr_class	=	dw_detail.getitemstring(ll_detail_row, 'drcr_class')
		
		if ls_drcr_class	=	'D'	then
			ldw_1	=	idw_dr
		else
			ldw_1	=	idw_cr
		end if
		
		ll_slip_seq ++				// 전표항
		
		ll_newrow	=	ldw_1.insertrow(0)
		ldw_1.setitem(ll_newrow, 'acct_class',		ii_mast_acct_class)
		ldw_1.setitem(ll_newrow, 'slip_date',		is_mast_slip_date)
		ldw_1.setitem(ll_newrow, 'slip_seq',		ll_slip_seq)
		ldw_1.setitem(ll_newrow, 'acct_code',		dw_detail.getitemstring(ll_detail_row, 'acct_code'))
		ldw_1.setitem(ll_newrow, 'com_drcr_class',mid(wf_acct_name(dw_detail.getitemstring(ll_detail_row, 'acct_code')),1,1))
		ldw_1.setitem(ll_newrow, 'com_acct_name',	mid(wf_acct_name(dw_detail.getitemstring(ll_detail_row, 'acct_code')),2))
		ldw_1.setitem(ll_newrow, 'drcr_class',		ls_drcr_class)
		ldw_1.setitem(ll_newrow, 'used_gwa',		dw_detail.getitemstring(ll_detail_row, 'resol_gwa'))
		ldw_1.setitem(ll_newrow, 'proof_gubun',	dw_detail.getitemnumber(ll_detail_row, 'proof_gubun'))
		ldw_1.setitem(ll_newrow, 'proof_date',		dw_detail.getitemstring(ll_detail_row, 'proof_date'))
		ldw_1.setitem(ll_newrow, 'slip_amt',		dw_detail.getitemnumber(ll_detail_row, 'resol_amt'))
		ldw_1.setitem(ll_newrow, 'mana_code1',		dw_detail.getitemnumber(ll_detail_row, 'mana_code1'))
		ldw_1.setitem(ll_newrow, 'mana_data1',		dw_detail.getitemstring(ll_detail_row, 'mana_data1'))
		ldw_1.setitem(ll_newrow, 'com_mana1_name',f_mana_data_name_proc(dw_detail.getitemnumber(ll_detail_row, 'mana_code1'),dw_detail.getitemstring(ll_detail_row, 'mana_data1')))
		ldw_1.setitem(ll_newrow, 'mana_code2',		dw_detail.getitemnumber(ll_detail_row, 'mana_code2'))
		ldw_1.setitem(ll_newrow, 'mana_data2',		dw_detail.getitemstring(ll_detail_row, 'mana_data2'))
		ldw_1.setitem(ll_newrow, 'com_mana2_name',f_mana_data_name_proc(dw_detail.getitemnumber(ll_detail_row, 'mana_code2'),dw_detail.getitemstring(ll_detail_row, 'mana_data2')))
		ldw_1.setitem(ll_newrow, 'mana_code3',		dw_detail.getitemnumber(ll_detail_row, 'mana_code3'))
		ldw_1.setitem(ll_newrow, 'mana_data3',		dw_detail.getitemstring(ll_detail_row, 'mana_data3'))
		ldw_1.setitem(ll_newrow, 'com_mana3_name',f_mana_data_name_proc(dw_detail.getitemnumber(ll_detail_row, 'mana_code3'),dw_detail.getitemstring(ll_detail_row, 'mana_data3')))
		ldw_1.setitem(ll_newrow, 'mana_code4',		dw_detail.getitemnumber(ll_detail_row, 'mana_code4'))
		ldw_1.setitem(ll_newrow, 'mana_data4',		dw_detail.getitemstring(ll_detail_row, 'mana_data4'))
		ldw_1.setitem(ll_newrow, 'com_mana4_name',f_mana_data_name_proc(dw_detail.getitemnumber(ll_detail_row, 'mana_code4'),dw_detail.getitemstring(ll_detail_row, 'mana_data4')))
		ldw_1.setitem(ll_newrow, 'remark',			dw_detail.getitemstring(ll_detail_row, 'remark'))
		ldw_1.setitem(ll_newrow, 'resol_date',		dw_detail.getitemstring(ll_detail_row, 'resol_date'))
		ldw_1.setitem(ll_newrow, 'resol_no',		dw_detail.getitemnumber(ll_detail_row, 'resol_no'))
		ldw_1.setitem(ll_newrow, 'resol_seq',		dw_detail.getitemnumber(ll_detail_row, 'resol_seq'))
		ldw_1.setitem(ll_newrow, 'assn_used_amt',	dw_detail.getitemnumber(ll_detail_row, 'assn_used_amt'))
		ldw_1.setitem(ll_newrow, 'assn_temp_amt',	dw_detail.getitemnumber(ll_detail_row, 'assn_temp_amt'))
		ldw_1.setitem(ll_newrow, 'assn_real_amt',	dw_detail.getitemnumber(ll_detail_row, 'assn_real_amt'))
		ldw_1.setitem(ll_newrow, 'bdgt_year',		is_bdgt_year)
		ldw_1.setitem(ll_newrow, 'worker',			gs_empcode)
		ldw_1.setitem(ll_newrow, 'ipaddr',			gs_ip)
		ldw_1.setitem(ll_newrow, 'work_date',		f_sysdate())
		ldw_1.setitem(ll_newrow, 'job_uid',			gs_empcode)
		ldw_1.setitem(ll_newrow, 'job_add',			gs_ip)
		ldw_1.setitem(ll_newrow, 'job_date',		f_sysdate())
	next	
	
	// 결의서 상태를 전표접수(4)로 지정한다.
	idw_list.setitem(ll_list_row, 'step_opt', 	ii_step_opt)
	idw_list.setitem(ll_list_row, 'slip_date',	is_mast_slip_date)
	
//	ll_list_row	=	idw_list.getrow()
//loop
End If

ll_newrow	=	1
idw_mast.insertrow(ll_newrow)
idw_mast.scrolltorow(ll_newrow)
idw_mast.setrow(ll_newrow)

idw_mast.setitem(ll_newrow, 'acct_class',	ii_mast_acct_class)
idw_mast.setitem(ll_newrow, 'slip_date',	is_mast_slip_date)
idw_mast.setitem(ll_newrow, 'slip_gwa',	is_mast_slip_gwa) 
idw_mast.setitem(ll_newrow, 'slip_class', ii_slip_class)  
//idw_mast.setitem(ll_newrow, 'slip_class', idw_list.getitemnumber(ll_list_getrow, 'slip_class'))  
idw_mast.setitem(ll_newrow, 'genesis_gb', idw_list.getitemnumber(ll_list_getrow, 'genesis_gb')) 
idw_mast.setitem(ll_newrow, 'remark',		idw_list.getitemstring(ll_list_getrow, 'remark'))  
idw_mast.setitem(ll_newrow, 'step_opt',	ii_step_opt)
idw_mast.setitem(ll_newrow, 'resol_date',	idw_list.getitemstring(ll_list_getrow, 'resol_date')) 
idw_mast.setitem(ll_newrow, 'resol_no',	idw_list.getitemnumber(ll_list_getrow, 'resol_no'))  

//messagebox('확인', 'resol_date')
//idw_mast.setitem(ll_newrow, 'resol_date',	idw_list.getitemstring(ll_list_row, 'resol_date'))
//idw_mast.setitem(ll_newrow, 'resol_no',	idw_list.getitemnumber(ll_list_row, 'resol_no'))

idw_mast.setitem(ll_newrow, 'job_uid',		gs_empcode)
idw_mast.setitem(ll_newrow, 'job_add',		gs_ip)
idw_mast.setitem(ll_newrow, 'job_date',	f_sysdate())
idw_mast.setitem(ll_newrow, 'worker',		gs_empcode)
idw_mast.setitem(ll_newrow, 'ipaddr',		gs_ip)
idw_mast.setitem(ll_newrow, 'work_date',	f_sysdate())

idw_mast.TRIGGER EVENT itemchanged(1,idw_mast.Object.slip_date,is_mast_slip_date)

idw_mast.setcolumn('remark')

idw_mast.setfocus()

wf_pb_drcr_enabled(true)



//계산서
if ib_tax_proc then
	if ldw_1.RowCount() < 1 then return
	
	if ldw_1.getItemNumber(1, 'proof_gubun') = 1 or ldw_1.getItemNumber(1, 'proof_gubun') = 2 then
		if ldw_1 = idw_dr then
			tab_sheet.tabpage_sheet01.pb_dr_tax.of_enable( true)
			tab_sheet.tabpage_sheet01.pb_cr_tax.of_enable( false)
		elseif ldw_1 = idw_cr then
			tab_sheet.tabpage_sheet01.pb_dr_tax.of_enable( false)
			tab_sheet.tabpage_sheet01.pb_cr_tax.of_enable( true)
		end if
	else
		tab_sheet.tabpage_sheet01.pb_dr_tax.of_enable( false)
		tab_sheet.tabpage_sheet01.pb_cr_tax.of_enable( false)
	end if
end if





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
//ist_back		=	tab_sheet.tabpage_sheet03.st_back
//
//ipb_dr_insert	=	tab_sheet.tabpage_sheet01.pb_dr_insert
//ipb_cr_insert	=	tab_sheet.tabpage_sheet01.pb_cr_insert
//ipb_dr_delete	=	tab_sheet.tabpage_sheet01.pb_dr_delete
//ipb_cr_delete	=	tab_sheet.tabpage_sheet01.pb_cr_delete
//
//ii_stat_gbn	=	0
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
////	조회조건	Clear
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
//dw_dept.setitem(1, 'code', '')
//is_gwa			=	''
//is_str_date		=	left(f_today(), 6) + '01'
//is_end_date		=	f_today()
//
//em_fr_date.text	=	string(is_str_date, '@@@@/@@/@@')
//em_to_date.text	=	string(is_end_date, '@@@@/@@/@@')
//
//// 전표조회/입력조건 Clear
//dw_slip_acct_class.getchild('code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('acct_class', 1) < 1 then
//	idw_child.insertrow(0)
//end if
//dw_slip_acct_class.reset()
//dw_slip_acct_class.insertrow(0)
//
//idw_child.scrolltorow(1)
//idw_child.setrow(1)
//ii_slip_acct_class	=	idw_child.getitemnumber(1, 'code')
//
//uo_slip_date.st_title.text	=	'전표일자'
//is_slip_date					=	f_today()
//uo_slip_date.em_date.text	=	string(is_slip_date, '@@@@/@@/@@')
//il_slip_no						=	0
//is_bdgt_year					=	f_getbdgtyear(is_slip_date)
//
//ddlb_step_opt.selectitem(1)
//ddlb_step_opt.triggerevent(selectionchanged!)
//
////계산서
//ib_tax_proc = true
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

long		ll_row
integer	li_rtn

idw_mast.accepttext()
idw_dr.accepttext()
idw_cr.accepttext()



li_rtn	=	wf_save()

if li_rtn < 0 then
	ROLLBACK;
	f_messagebox('3', is_stat_gbn_title + '를(을) 실패했습니다.!~n' + sqlca.sqlerrtext)
elseif li_rtn = 0 then
	COMMIT	;
	
	wf_setmsg(is_stat_gbn_title + '를(을) 완료했습니다.!')

	idw_mast.setredraw(true)
	idw_dr.setredraw(true)
	idw_cr.setredraw(true)
	
	triggerevent('ue_retrieve')

	// 전표 접수 처리 후 해당자료는 남겨둔다.
	if ii_stat_gbn = 1 then
		idw_mast.retrieve(ii_acct_class, is_mast_slip_date, il_mast_slip_no, ii_stat_gbn)
		idw_dr.retrieve(ii_acct_class, is_mast_slip_date, il_mast_slip_no, 'D')
		idw_cr.retrieve(ii_acct_class, is_mast_slip_date, il_mast_slip_no, 'C')
		idw_preview.retrieve(ii_acct_class, is_mast_slip_date, il_mast_slip_no)
		if idw_print.retrieve(ii_acct_class, is_mast_slip_date, il_mast_slip_no) > 0 then
			dw_all.retrieve(ii_acct_class, is_mast_slip_date, il_mast_slip_no)

		end if
		idw_mast.object.datawindow.readonly = True
		idw_dr.object.datawindow.readonly   = True
		idw_cr.object.datawindow.readonly   = true
		wf_pb_drcr_enabled(false)
	end if
END IF



return 1

end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow


wf_setMsg('삭제중')

if idw_list.getrow() < 1 then
	f_messagebox('3', '삭제할 자료가 존재하지 않습니다.!')
else
	// 마스타 자료를 삭제하면 디테일 자료도 같이 삭제된다.(trigger)
	if f_messagebox('2', '자료를 삭제하면 차대변 자료도 모두 삭제됩니다.~n~n' + string(is_mast_slip_date, '@@@@년 @@월 @@일') + '의 전표번호 [' + string(il_mast_slip_no) + ']의 자료를 삭제하시겠습니까?')	=	1	then
	
		li_deleterow	=	idw_mast.deleterow(0)
	
		idw_dr.reset()
		idw_cr.reset()
	end if
end if

wf_setMsg('.')

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

event ue_init;call super::ue_init;// ------------------------------------------------------------------------------------------
// 초기화
// ------------------------------------------------------------------------------------------
ddlb_slip_class.selectitem(2)
ii_slip_class	=	2

// 처리구분 = 전표분개
if ii_stat_gbn	=	1	then
	// 결의서 조회조건
	ddlb_slip_class.enabled						=	true
	dw_dept.enabled            				=	true
	dw_dept.object.code.background.color	=	rgb(255, 255, 255)
	em_fr_date.enabled							=	true
	em_to_date.enabled							=	true

	// 결의서 DW
	idw_list.enabled				=	true
	
	// 전표조회조건
	uo_slip_date.uf_enabled(false)
	em_slip_no.enabled			=	false
	
	// 전표 DW
	idw_mast.enabled				=	true
	
	// 항추가삭제버튼
	wf_pb_drcr_enabled(false)
	
	// 전표내역 DW
	idw_dr.enabled					=	true
	idw_cr.enabled					=	true
	
	// 이전전표, 다음전표
	cb_prev.visible = False
	cb_next.visible = False
	
// 처리구분 = 분개취소
elseif ii_stat_gbn	=	2	then
	// 결의서 조회조건
	dw_dept.enabled            				=	false
	dw_dept.object.code.background.color	=	78682240
	em_fr_date.enabled							=	false
	em_to_date.enabled							=	false

	// 결의서 DW
	idw_list.enabled				=	false
	
	// 전표조회조건
	uo_slip_date.uf_enabled(true)
	em_slip_no.enabled			=	true

	// 전표 DW
	idw_mast.enabled				=	true
	
	// 항추가삭제버튼
	wf_pb_drcr_enabled(false)
	
	// 전표내역 DW
	idw_dr.enabled					=	true
	idw_cr.enabled					=	true

	// 이전전표, 다음전표
	cb_prev.visible = true
	cb_next.visible = true

// 처리구분 = 전표수정
elseif ii_stat_gbn	=	3	then
	// 결의서 조회조건
	ddlb_slip_class.enabled						=	false
	dw_dept.object.code.background.color	=	78682240
	em_fr_date.enabled							=	false
	em_to_date.enabled							=	false

	// 결의서 DW
	idw_list.enabled				=	false
	
	// 전표조회조건
	uo_slip_date.uf_enabled(true)
	em_slip_no.enabled			=	true

	// 전표 DW
	idw_mast.enabled				=	true
	
	// 항추가삭제버튼
	wf_pb_drcr_enabled(false)
	
	// 전표내역 DW
	idw_dr.enabled					=	true
	idw_cr.enabled					=	true

	// 이전전표, 다음전표
	cb_prev.visible = True
	cb_next.visible = True
end if

il_slip_no	=	0
em_slip_no.text	=	string(il_slip_no)

idw_list.reset()
wf_dw_reset()

if ii_stat_gbn = 3 or ii_stat_gbn = 5 then
	uo_slip_date.em_date.setfocus()
else
	idw_list.setfocus()
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


ipb_dr_insert	=	tab_sheet.tabpage_sheet01.pb_dr_insert
ipb_cr_insert	=	tab_sheet.tabpage_sheet01.pb_cr_insert
ipb_dr_delete	=	tab_sheet.tabpage_sheet01.pb_dr_delete
ipb_cr_delete	=	tab_sheet.tabpage_sheet01.pb_cr_delete

ii_stat_gbn	=	0

triggerevent('ue_init')

// 전표 구분(1=수입전표, 2=지출전표, 3=대체전표)
ddlb_slip_class.selectitem(2)
ii_slip_class	=	2

wf_getchild()

idt_sysdate		=	f_sysdate()

//	조회조건	Clear
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

dw_dept.setitem(1, 'code', '')
is_gwa			=	''
is_str_date		=	left(f_today(), 6) + '01'
is_end_date		=	f_today()

em_fr_date.text	=	string(is_str_date, '@@@@/@@/@@')
em_to_date.text	=	string(is_end_date, '@@@@/@@/@@')

// 전표조회/입력조건 Clear
dw_slip_acct_class.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('acct_class', 1) < 1 then
	idw_child.insertrow(0)
end if
dw_slip_acct_class.reset()
dw_slip_acct_class.insertrow(0)

idw_child.scrolltorow(1)
idw_child.setrow(1)
ii_slip_acct_class	=	idw_child.getitemnumber(1, 'code')

uo_slip_date.st_title.text	=	'전표일자'
is_slip_date					=	f_today()
uo_slip_date.em_date.text	=	string(is_slip_date, '@@@@/@@/@@')
il_slip_no						=	0
is_bdgt_year					=	f_getbdgtyear(is_slip_date)

ddlb_step_opt.selectitem(1)
ddlb_step_opt.triggerevent(selectionchanged!)

//계산서
ib_tax_proc = true

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = cb_prev.x

	cb_prev.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + cb_prev.Width + 16

	
	cb_next.X			= ll_stnd_pos 
	ll_stnd_pos			= ll_stnd_pos + cb_next.Width +200


ll_stnd_pos = gb_4.x + gb_4.width - 16
	cb_1.X			= ll_stnd_pos - cb_1.width
	cb_preview.X			= ll_stnd_pos - cb_preview.width


ll_stnd_pos = tab_sheet.tabpage_sheet01.gb_2.x + 16

ipb_dr_insert.x = ll_stnd_pos
ll_stnd_pos			= ll_stnd_pos + ipb_dr_insert.Width +16
ipb_dr_delete.x = ll_stnd_pos
ll_stnd_pos = tab_sheet.tabpage_sheet01.gb_2.x +  tab_sheet.tabpage_sheet01.gb_2.width - 16
 tab_sheet.tabpage_sheet01.pb_dr_tax.x = ll_stnd_pos -  tab_sheet.tabpage_sheet01.pb_dr_tax.width
 
 ll_stnd_pos = tab_sheet.tabpage_sheet01.gb_3.x + 16

ipb_cr_insert.x = ll_stnd_pos
ll_stnd_pos			= ll_stnd_pos + ipb_cr_insert.Width +16
ipb_cr_delete.x = ll_stnd_pos
ll_stnd_pos = tab_sheet.tabpage_sheet01.gb_3.x +  tab_sheet.tabpage_sheet01.gb_3.width - 16
 tab_sheet.tabpage_sheet01.pb_cr_tax.x = ll_stnd_pos -  tab_sheet.tabpage_sheet01.pb_cr_tax.width
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
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

type ln_templeft from w_tabsheet`ln_templeft within w_hfn303a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hfn303a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hfn303a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hfn303a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hfn303a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hfn303a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hfn303a
end type

type uc_insert from w_tabsheet`uc_insert within w_hfn303a
end type

type uc_delete from w_tabsheet`uc_delete within w_hfn303a
end type

type uc_save from w_tabsheet`uc_save within w_hfn303a
end type

type uc_excel from w_tabsheet`uc_excel within w_hfn303a
end type

type uc_print from w_tabsheet`uc_print within w_hfn303a
end type

type st_line1 from w_tabsheet`st_line1 within w_hfn303a
end type

type st_line2 from w_tabsheet`st_line2 within w_hfn303a
end type

type st_line3 from w_tabsheet`st_line3 within w_hfn303a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hfn303a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hfn303a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hfn303a
integer y = 1080
integer width = 4384
integer height = 1208
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

event tab_sheet::selectionchanged;call super::selectionchanged;//wf_setMenu('DELETE',		FALSE)

choose case newindex
	case	1
//		wf_setMenu('PRINT',		FALSE)
//		if ii_stat_gbn	=	1	then
//			wf_setMenu('INSERT',		TRUE)
//			wf_setMenu('RETRIEVE',	TRUE)
//			wf_setMenu('UPDATE',		TRUE)
//		elseif ii_stat_gbn	>=	2	and	ii_stat_gbn	<=	3	then
//			wf_setMenu('INSERT',		FALSE)
//			wf_setMenu('RETRIEVE',	TRUE)
//			wf_setMenu('UPDATE',		TRUE)
//		end if
		cb_preview.visible = false
	case	2
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		FALSE)
		cb_preview.visible = false
	case	else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
		if idw_print.rowcount() > 0 then cb_preview.visible = true
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
integer width = 4347
integer height = 1088
long backcolor = 1073741824
string text = "전표관리"
gb_2 gb_2
gb_3 gb_3
dw_update3 dw_update3
pb_dr_insert pb_dr_insert
pb_dr_delete pb_dr_delete
pb_cr_insert pb_cr_insert
pb_cr_delete pb_cr_delete
dw_update2 dw_update2
pb_dr_tax pb_dr_tax
pb_cr_tax pb_cr_tax
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_update3=create dw_update3
this.pb_dr_insert=create pb_dr_insert
this.pb_dr_delete=create pb_dr_delete
this.pb_cr_insert=create pb_cr_insert
this.pb_cr_delete=create pb_cr_delete
this.dw_update2=create dw_update2
this.pb_dr_tax=create pb_dr_tax
this.pb_cr_tax=create pb_cr_tax
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.dw_update3
this.Control[iCurrent+4]=this.pb_dr_insert
this.Control[iCurrent+5]=this.pb_dr_delete
this.Control[iCurrent+6]=this.pb_cr_insert
this.Control[iCurrent+7]=this.pb_cr_delete
this.Control[iCurrent+8]=this.dw_update2
this.Control[iCurrent+9]=this.pb_dr_tax
this.Control[iCurrent+10]=this.pb_cr_tax
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_update3)
destroy(this.pb_dr_insert)
destroy(this.pb_dr_delete)
destroy(this.pb_cr_insert)
destroy(this.pb_cr_delete)
destroy(this.dw_update2)
destroy(this.pb_dr_tax)
destroy(this.pb_cr_tax)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
integer y = 4
integer width = 3840
integer height = 224
string dataobject = "d_hfn303a_2"
boolean vscrollbar = false
boolean border = false
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if isnull(currentrow) or currentrow < 1 then 
	wf_dw_reset()
	wf_pb_drcr_enabled(false)
	return
end if

if ii_stat_gbn = 1 or ii_stat_gbn = 5 then
	wf_pb_drcr_enabled(true)
end if

end event

event dw_list001::retrieveend;call super::retrieveend;string	ls_name, ls_job_uid

if rowcount < 1 then 
	wf_dw_reset()
	wf_pb_drcr_enabled(false)
	return
end if

ii_mast_acct_class	=	getitemnumber(1, 'acct_class')
is_mast_slip_date		=	getitemstring(1, 'slip_date')
il_mast_slip_no		=	getitemnumber(1, 'slip_no')
is_mast_slip_gwa		=	getitemstring(1, 'slip_gwa')

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(False)
end event

event dw_list001::itemchanged;call super::itemchanged;long	ll_cnt, ll_tot_cnt

if dwo.name = 'slip_date' then
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
	is_mast_slip_date		=	data

	ll_tot_cnt = idw_dr.rowcount()
	for ll_cnt = 1 to ll_tot_cnt
		idw_dr.setitem(ll_cnt, 'slip_date', is_mast_slip_date)
		idw_dr.setitem(ll_cnt, 'bdgt_year', is_bdgt_year)
	next

	ll_tot_cnt = idw_cr.rowcount()
	for ll_cnt = 1 to ll_tot_cnt
		idw_cr.setitem(ll_cnt, 'slip_date', is_mast_slip_date)
		idw_cr.setitem(ll_cnt, 'bdgt_year', is_bdgt_year)
	next
end if

ii_mast_acct_class	=	getitemnumber(row, 'acct_class')
il_mast_slip_no		=	getitemnumber(row, 'slip_no')
is_mast_slip_gwa		=	getitemstring(row, 'slip_gwa')

setitem(row, 'job_uid', gs_empcode)
setitem(row, 'job_add', gs_ip)
setitem(row, 'job_date',f_sysdate())


end event

event dw_list001::itemerror;call super::itemerror;return 1
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
boolean visible = false
integer y = 580
integer width = 3840
integer height = 484
end type

type uo_tab from w_tabsheet`uo_tab within w_hfn303a
integer x = 1175
integer y = 1076
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hfn303a
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hfn303a
boolean visible = false
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

type dw_update3 from datawindow within tabpage_sheet01
event ue_dwnkey pbm_dwnkey
integer x = 1925
integer y = 356
integer width = 1920
integer height = 716
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hfn303a_3"
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

event retrieveend;integer		li_row

if rowcount < 1 then	return

for li_row = 1 to	rowcount
	setitem(li_row, 'ai_stat_gbn', ii_stat_gbn)
	setitem(li_row, 'com_mana1_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code1'), trim(getitemstring(li_row, 'mana_data1'))))
	setitem(li_row, 'com_mana2_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code2'), trim(getitemstring(li_row, 'mana_data2'))))
	setitem(li_row, 'com_mana3_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code3'), trim(getitemstring(li_row, 'mana_data3'))))
	setitem(li_row, 'com_mana4_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code4'), trim(getitemstring(li_row, 'mana_data4'))))
next


//계산서
if ib_tax_proc then
	if getItemNumber(1, 'proof_gubun') = 1 or getItemNumber(1, 'proof_gubun') = 2 then
		pb_cr_tax.of_enable( true)
	else
		pb_cr_tax.of_enable( false)
	end if
end if


resetupdate()

end event

event doubleclicked;// 관리항목 도움말 정보 조회
choose case dwo.name
	case 'mana_data1', 'mana_data2', 'mana_data3', 'mana_data4'
		f_mana_data_help(this, row, dwo.name)
end choose

end event

event rowfocuschanged;//계산서
if ib_tax_proc then
	if currentrow < 1 then return
	
	if getItemNumber(currentrow, 'proof_gubun') = 1 or getItemNumber(currentrow, 'proof_gubun') = 2 then
		pb_cr_tax.of_enable( true)
	else
		pb_cr_tax.of_enable( false)
	end if
end if

end event

type pb_dr_insert from uo_imgbtn within tabpage_sheet01
event destroy ( )
integer x = 32
integer y = 252
integer taborder = 100
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
integer taborder = 110
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
integer taborder = 110
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
integer taborder = 110
boolean bringtotop = true
boolean enabled = false
string btnname = "항삭제"
end type

on pb_cr_delete.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;wf_delete_drcr(idw_cr)
end event

type dw_update2 from datawindow within tabpage_sheet01
event ue_dwnkey pbm_dwnkey
integer y = 356
integer width = 1920
integer height = 716
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_hfn303a_3"
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

event retrieveend;integer		li_row

if rowcount < 1 then	return

for li_row = 1 to	rowcount
	setitem(li_row, 'ai_stat_gbn', ii_stat_gbn)
	setitem(li_row, 'com_mana1_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code1'), trim(getitemstring(li_row, 'mana_data1'))))
	setitem(li_row, 'com_mana2_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code2'), trim(getitemstring(li_row, 'mana_data2'))))
	setitem(li_row, 'com_mana3_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code3'), trim(getitemstring(li_row, 'mana_data3'))))
	setitem(li_row, 'com_mana4_name', f_mana_data_name_proc(getitemnumber(li_row, 'mana_code4'), trim(getitemstring(li_row, 'mana_data4'))))
next

//계산서
if ib_tax_proc then
	if getItemNumber(1, 'proof_gubun') = 1 or getItemNumber(1, 'proof_gubun') = 2 then
		pb_dr_tax.of_enable( true)
	else
		pb_dr_tax.of_enable( false)
	end if
end if

resetupdate()

end event

event doubleclicked;// 관리항목 도움말 정보 조회
choose case dwo.name
	case 'mana_data1', 'mana_data2', 'mana_data3', 'mana_data4'
		if getitemnumber(row, 'resol_no') <> 0 then return
		f_mana_data_help(this, row, dwo.name)
end choose

end event

event rowfocuschanged;//계산서
if ib_tax_proc then
	if currentrow < 1 then return
	
	if getItemNumber(currentrow, 'proof_gubun') = 1 or getItemNumber(currentrow, 'proof_gubun') = 2 then
		pb_dr_tax.of_enable( true)
	else
		pb_dr_tax.of_enable( false)
	end if
end if

end event

type pb_dr_tax from uo_imgbtn within tabpage_sheet01
integer x = 1573
integer y = 252
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
string btnname = "계산서"
end type

event clicked;call super::clicked;string			ls_resol_date, ls_tax_type, ls_tax_gubun
integer			li_slip_class, li_proof_gubun, li_resol_no, li_resol_seq
s_tax				str_tax							//structure

if dw_update2.rowcount() = 0 then return

li_proof_gubun = dw_update2.getItemNumber(dw_update2.getRow(), 'proof_gubun')

if ii_stat_gbn = 1 then	//전표분개 
	li_slip_class 	= dw_update1.getItemNumber(dw_update1.getRow(), 'slip_class')
else
	li_slip_class 	= dw_update2.getItemNumber(dw_update2.getRow(), 'slip_class')
end if

ls_resol_date 	= dw_update2.getItemString(dw_update2.getRow(), 'resol_date')
li_resol_no 	= dw_update2.getItemNumber(dw_update2.getRow(), 'resol_no')
li_resol_seq 	= dw_update2.getItemNumber(dw_update2.getRow(), 'resol_seq')

if li_proof_gubun = 1 then			//세금계산서일 경우...
	ls_tax_type = '2'
elseif li_proof_gubun = 2 then 	//계산서일 경우...
	ls_tax_type = '1'
end if

if ii_slip_class = 1 then			//수입
	ls_tax_gubun = '2'	//매출
elseif ii_slip_class = 2 then		//지출
	ls_tax_gubun = '1'	//매입
end if

str_tax.tax_type 		= 	ls_tax_type
str_tax.tax_gubun 		= 	ls_tax_gubun
str_tax.resol_no		=	ls_resol_date + string(li_resol_no)
str_tax.resol_seq		=	integer(li_resol_seq)
//str_tax.dw_tax		=	dw_tax

OpenWithParm(w_hfn201a_tax, str_tax)


end event

on pb_dr_tax.destroy
call uo_imgbtn::destroy
end on

type pb_cr_tax from uo_imgbtn within tabpage_sheet01
integer x = 3131
integer y = 252
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
string btnname = "계산서"
end type

event clicked;call super::clicked;string			ls_resol_date, ls_tax_type, ls_tax_gubun
integer			li_slip_class, li_proof_gubun, li_resol_no, li_resol_seq
s_tax				str_tax							//structure

if dw_update3.rowcount() = 0 then return

li_proof_gubun 	= dw_update3.getItemNumber(dw_update3.getRow(), 'proof_gubun')

if ii_stat_gbn = 1 then	//전표분개 
	li_slip_class 	= dw_update1.getItemNumber(dw_update1.getRow(), 'slip_class')
else
	li_slip_class 	= dw_update3.getItemNumber(dw_update3.getRow(), 'slip_class')
end if

ls_resol_date 	= dw_update3.getItemString(dw_update3.getRow(), 'resol_date')
li_resol_no 	= dw_update3.getItemNumber(dw_update3.getRow(), 'resol_no')
li_resol_seq 	= dw_update3.getItemNumber(dw_update3.getRow(), 'resol_seq')

if li_proof_gubun = 1 then			//세금계산서일 경우...
	ls_tax_type = '2'
elseif li_proof_gubun = 2 then 	//계산서일 경우...
	ls_tax_type = '1'
end if

if ii_slip_class = 1 then			//수입
	ls_tax_gubun = '2'	//매출
elseif ii_slip_class = 2 then		//지출
	ls_tax_gubun = '1'	//매입
end if

str_tax.tax_type 		= 	ls_tax_type
str_tax.tax_gubun 	= 	ls_tax_gubun
str_tax.resol_no		=	ls_resol_date + string(li_resol_no)
str_tax.resol_seq		=	integer(li_resol_seq)
//str_tax.dw_tax		=	dw_tax

OpenWithParm(w_hfn201a_tax, str_tax)


end event

on pb_cr_tax.destroy
call uo_imgbtn::destroy
end on

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1088
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
integer y = 4
integer width = 4347
integer height = 1080
integer taborder = 30
string dataobject = "d_hfn303a_5"
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
integer width = 4347
integer height = 1088
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
integer width = 4357
integer height = 1084
integer taborder = 10
string dataobject = "d_hfn303a_6"
boolean vscrollbar = true
boolean border = false
end type

type st_20 from statictext within w_hfn303a
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

type dw_acct_class from datawindow within w_hfn303a
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

type st_2 from statictext within w_hfn303a
boolean visible = false
integer x = 87
integer y = 816
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

type dw_slip_acct_class from datawindow within w_hfn303a
boolean visible = false
integer x = 393
integer y = 800
integer width = 809
integer height = 80
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_slip_acct_class	=	integer(data)

end event

type uo_slip_date from cuo_date within w_hfn303a
integer x = 91
integer y = 932
integer taborder = 70
boolean bringtotop = true
boolean border = false
long backcolor = 1073741824
end type

on uo_slip_date.destroy
call cuo_date::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_slip_date		=	uf_getdate()
is_bdgt_year		=	f_getbdgtyear(is_slip_date)

end event

type st_slip_no from statictext within w_hfn303a
integer x = 1061
integer y = 948
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
string text = "전표번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_slip_no from editmask within w_hfn303a
integer x = 1376
integer y = 932
integer width = 430
integer height = 80
integer taborder = 80
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
string mask = "#####0"
end type

event modified;il_slip_no	=	long(this.text)

end event

event getfocus;selecttext(1, len(this.text))
end event

type st_5 from statictext within w_hfn303a
integer x = 814
integer y = 224
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
string text = "결의구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_hfn303a
integer x = 18
integer y = 224
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
string text = "처리구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_detail from datawindow within w_hfn303a
boolean visible = false
integer x = 1317
integer width = 2560
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

type st_no from statictext within w_hfn303a
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

type st_no2 from statictext within w_hfn303a
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

type st_dept_code from statictext within w_hfn303a
integer x = 1504
integer y = 224
integer width = 302
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "결의부서"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_dept from datawindow within w_hfn303a
integer x = 1815
integer y = 208
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

type st_6 from statictext within w_hfn303a
integer x = 3003
integer y = 224
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
string text = "결의기간"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fr_date from editmask within w_hfn303a
integer x = 3291
integer y = 212
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

type st_26 from statictext within w_hfn303a
integer x = 3749
integer y = 224
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

type em_to_date from editmask within w_hfn303a
integer x = 3813
integer y = 212
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

type ddlb_step_opt from dropdownlistbox within w_hfn303a
integer x = 311
integer y = 208
integer width = 425
integer height = 264
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"1.전표분개                                        42","2.분개취소                                         24","3.전표수정                                         44"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_stat_gbn			=	finditem(text, 0)
is_stat_gbn_title	=	trim(mid(this.text, 3, len(this.text) - 4))
ii_step_opt			=	integer(left(right(this.text, 2), 1))
ii_retrieve_step	=	integer(right(this.text, 1))

parent.triggerevent('ue_init')
tab_sheet.trigger event selectionchanged(tab_sheet.selectedtab, tab_sheet.selectedtab)

end event

type ddlb_slip_class from dropdownlistbox within w_hfn303a
integer x = 1097
integer y = 212
integer width = 379
integer height = 212
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"1.수입","2.지출"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_slip_class	=	index

end event

type gb_1 from groupbox within w_hfn303a
integer x = 800
integer y = 152
integer width = 3634
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

type dw_update1 from uo_dwgrid within w_hfn303a
integer x = 50
integer y = 340
integer width = 4384
integer height = 540
integer taborder = 50
string dataobject = "d_hfn303a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event losefocus;call super::losefocus;accepttext()
end event

event rowfocuschanging;call super::rowfocuschanging;il_list_currentrow	=	currentrow
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return
end event

type st_1 from statictext within w_hfn303a
integer x = 78
integer y = 932
integer width = 343
integer height = 96
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean focusrectangle = false
end type

type st_3 from statictext within w_hfn303a
integer x = 137
integer y = 948
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
string text = "전표일자"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from uo_imgbtn within w_hfn303a
event destroy ( )
integer x = 3890
integer y = 928
integer taborder = 90
boolean bringtotop = true
string btnname = "계산서입력"
end type

on cb_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;//open(w_hfn801a_help)
in_open.opensheetwithparm('w_hfn801a_help', '', w_pf_main)
end event

type cb_prev from uo_imgbtn within w_hfn303a
boolean visible = false
integer x = 2057
integer y = 928
integer taborder = 100
boolean bringtotop = true
string btnname = "이전전표"
end type

event clicked;call super::clicked;long	ll_no, ll_slip_no

ll_no = long(em_slip_no.text)

select	max(slip_no)
into		:ll_slip_no
from		fndb.hfn201m
where		acct_class	=	:ii_acct_class
and		slip_date	=	:is_slip_date
and		slip_no		<	:ll_no
and		genesis_gb  in (0,1,2)
and		resol_date	is	not	null	;

if isnull(ll_slip_no) or ll_slip_no = 0 then
	parent.triggerevent('ue_init')
	messagebox('확인', string(is_slip_date,'@@@@/@@/@@') + ' 일자에는 더이상 전표가 없습니다.')
	return
end if

em_slip_no.text = string(ll_slip_no)
il_slip_no      = ll_slip_no

parent.triggerevent('ue_retrieve')
end event

on cb_prev.destroy
call uo_imgbtn::destroy
end on

type cb_next from uo_imgbtn within w_hfn303a
boolean visible = false
integer x = 2382
integer y = 928
integer taborder = 90
boolean bringtotop = true
string btnname = "다음전표"
end type

event clicked;call super::clicked;long	ll_no, ll_slip_no

ll_no = long(em_slip_no.text)

select	min(slip_no)
into		:ll_slip_no
from		fndb.hfn201m
where		acct_class	=	:ii_acct_class
and		slip_date	=	:is_slip_date
and		slip_no		>	:ll_no
and		genesis_gb  in (0, 1, 2)
and		resol_date	is	not	null	;

if isnull(ll_slip_no) or ll_slip_no = 0 then
	parent.triggerevent('ue_init')
	messagebox('확인', string(is_slip_date,'@@@@/@@/@@') + ' 일자에는 더이상 전표가 없습니다.')
	return
end if

em_slip_no.text = string(ll_slip_no)
il_slip_no      = ll_slip_no

parent.triggerevent('ue_retrieve')
end event

on cb_next.destroy
call uo_imgbtn::destroy
end on

type gb_4 from groupbox within w_hfn303a
integer x = 50
integer y = 880
integer width = 4384
integer height = 156
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전표조회"
end type

type dw_all from datawindow within w_hfn303a
boolean visible = false
integer x = 50
integer y = 340
integer width = 4384
integer height = 1940
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

type cb_preview from uo_imgbtn within w_hfn303a
boolean visible = false
integer x = 3909
integer y = 1036
integer taborder = 110
boolean bringtotop = true
string btnname = "출력전체보기"
end type

event clicked;call super::clicked;dw_all.bringtotop = true
dw_all.visible = true
end event

on cb_preview.destroy
call uo_imgbtn::destroy
end on

