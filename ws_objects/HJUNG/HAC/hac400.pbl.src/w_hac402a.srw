$PBExportHeader$w_hac402a.srw
$PBExportComments$예산 편성 관리/출력(예산부서용)
forward
global type w_hac402a from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_1 from cuo_search within tabpage_sheet01
end type
type pb_insert from uo_imgbtn within tabpage_sheet01
end type
type pb_delete from uo_imgbtn within tabpage_sheet01
end type
type dw_update from uo_dwgrid within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_list002 from uo_dwgrid within tabpage_sheet02
end type
type gb_5 from groupbox within tabpage_sheet02
end type
type uo_2 from cuo_search within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_list002 dw_list002
gb_5 gb_5
uo_2 uo_2
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_print dw_print
end type
type cb_1 from commandbutton within w_hac402a
end type
type cb_cal from cuo_cal within w_hac402a
end type
type uo_acct_class from cuo_acct_class within w_hac402a
end type
end forward

global type w_hac402a from w_tabsheet
string title = "예산 편성 등록/출력(예산부서용)"
cb_1 cb_1
cb_cal cb_cal
uo_acct_class uo_acct_class
end type
global w_hac402a w_hac402a

type variables
datawindowchild	idw_child, idw_child2, idw_child_acct_code
datawindow			idw_mast, idw_data, idw_preview

datawindow			idw_1

string	is_bdgt_year, is_slip_class		// 요구년도, 수입/지출구분
integer	ii_acct_class							//	회계단위
integer	ii_stat	=	23							// 상태(예산부서접수)
integer	ii_stat_class							// 상태
integer	ii_bdgt_class	=	0					// 예산차수
string	is_mgr_dept								// 상위부서코드
string	is_gwa									// 로긴부서가 	예산부서면 is_gwa = '', 
														//					주관,단위부서이면 is_gwa = gstru_uid_uname.dept_code

long		il_currentrow
integer	ii_mast_stat_class
string	is_mast_work_gbn

string	is_group11_code						// 로긴부서의 구분(1=예산부서)

end variables

forward prototypes
public subroutine wf_calc ()
public subroutine wf_delete ()
public subroutine wf_delete_remark ()
public function integer wf_duplicate_chk (long al_row, string as_gwa, string as_acct_code)
public subroutine wf_getchild ()
public subroutine wf_retrieve_preview ()
public subroutine wf_insert_remark ()
public function integer wf_retrieve ()
public subroutine wf_insert ()
public function integer wf_retrieve_2 ()
public subroutine wf_button_control (integer ai_index)
public function integer wf_save ()
end prototypes

public subroutine wf_calc ();long		ll_row, ll_rowcount
string	ls_data
integer	li_str_tab, li_end_tab, li_tab
dec{0}	ld_val, ld_total_amt

integer	li_cnt
string	ls_data2

// ":" 앞은 계산식에서 제외
// cb_cal : User Object
li_tab	= 0
ld_val	= 0
ld_total_amt = 0

ll_rowcount	=	idw_data.rowcount()
	
// 맨마지막 산출근거의 자료만 체크한다.
for ll_row = 1 to ll_rowcount
	ls_data			=	idw_data.getitemstring(ll_row, 'calc_remark')
	li_str_tab   	=	Pos(ls_data, ":", 1)
	ls_data			=	mid(ls_data, li_str_tab, len(ls_data))
	li_str_tab		=	0
	if li_str_tab 	= len(trim(ls_data))	then	continue
	if len(trim(ls_data)) > 0 and left(trim(ls_data), 1) <> ':' then continue

	li_cnt			=	1
	ls_data2		=	ls_data
	li_end_tab		=	len(ls_data)
	do	while	li_end_tab <>	0
		li_end_tab		=	pos(ls_data2, "=", li_cnt)
		if li_end_tab	=	0	then	exit
		li_cnt			=	li_end_tab + 1
		ld_total_amt	=	0
	loop
	
	li_end_tab	=	li_cnt - 1
	
	if li_end_tab	=	0	or li_end_tab = len(trim(ls_data))	then	
		li_tab	=	li_str_tab
	else
		li_tab	=	li_end_tab
	end if
	
	ls_data2	=	Mid(ls_data, li_tab + 1, len(ls_data))

	if pos(ls_data2, '--', 1) > 0	or	pos(ls_data2, '**', 1) > 0 or pos(ls_data2, '//', 1) > 0 or pos(ls_data2, '==', 1) > 0 then	continue
	
	ld_val   = cb_cal.in_fix_compute(Mid(ls_data, li_tab + 1, len(ls_data))) 

	if ld_val = 0 then	continue
	
	ld_total_amt += ld_val
next

if isnumber(string(ld_total_amt)) then	idw_mast.SetItem(idw_mast.getrow(), 'adjust_amt',   	ld_total_amt)

end subroutine

public subroutine wf_delete ();// ==========================================================================================
// 기    능 : 	Mast delete
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_delete()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer		li_deleterow
long			ll_row, ll_rowcount

if idw_1 <> idw_mast then
	f_messagebox('3', '삭제하려는 항목을 선택하신 후 삭제하시기 바랍니다.!')
	return
end if

if idw_mast.getitemnumber(il_currentrow, 'stat_class') <> ii_stat_class then
	f_messagebox('3', '삭제할 수 없습니다.!')
	return
end if

if idw_data.rowcount() > 0 then
	if f_messagebox('2', '입력사항이 삭제됩니다.~n~n삭제하시겠습니까?') = 2 then	return
	
	li_deleterow	=	idw_mast.deleterow(0)
	ll_rowcount		=	idw_data.rowcount()
	for ll_row = ll_rowcount to 1 step -1
		idw_data.deleterow(ll_row)
	next
	idw_mast.trigger event rowfocuschanged(idw_mast.getrow())
end if

end subroutine

public subroutine wf_delete_remark ();// ==========================================================================================
// 기    능 : 	산출근거 delete
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_delete_remark()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer		li_deleterow
long			ll_row, ll_rowcount

if idw_mast.getitemnumber(il_currentrow, 'stat_class') <> ii_stat_class then
	f_messagebox('3', '삭제할 수 없습니다.!')
	return
end if

li_deleterow	=	idw_data.deleterow(0)

end subroutine

public function integer wf_duplicate_chk (long al_row, string as_gwa, string as_acct_code);// ==========================================================================================
// 기    능 : 	Data Duplicate Check
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_duplicate_chk(long	al_row, string	as_gwa, string	as_acct_code)
// 인    수 :	al_row			-	Row
//					as_gwa			-	학과
//					as_acct_code	-	계정과목코드
// 되 돌 림 :	integer
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_bdgt_year, ls_io_gubun
integer	li_acct_class, li_bdgt_class
long		ll_row

ls_bdgt_year  = idw_mast.getitemstring(al_row, 'bdgt_year')
li_acct_class = idw_mast.getitemnumber(al_row, 'acct_class')
ls_io_gubun   = idw_mast.getitemstring(al_row, 'io_gubun')
li_bdgt_class = idw_mast.getitemnumber(al_row, 'bdgt_class')

select	count(*)	into	:ll_row
from		acdb.hac011h
where		bdgt_year = :ls_bdgt_year
and		gwa = :as_gwa
and		acct_code = :as_acct_code
and		acct_class = :li_acct_class
and		io_gubun = :ls_io_gubun
and		bdgt_class = :li_bdgt_class ;

if ll_row	>	0	then
	f_messagebox('1', '자료가 중복되었습니다.~n~n확인 후 다시 입력해 주시기 바랍니다.!')
	idw_mast.setcolumn('acct_code')
	return	1
end if

ll_row = idw_mast.find("bdgt_year = '" + ls_bdgt_year + "' and " + &
							  "gwa = '" + as_gwa + "' and " + &
							  "acct_code = '" + as_acct_code + "' and " + &
							  "acct_class = " + string(li_acct_class) + " and " + &
							  "io_gubun = '" + ls_io_gubun + "' and " + &
							  "bdgt_class = " + string(li_bdgt_class), 1, al_row - 1)

if ll_row	>	0	then
	f_messagebox('1', '자료가 중복되었습니다.~n~n확인 후 다시 입력해 주시기 바랍니다.!')
	idw_mast.setcolumn('acct_code')
	return	1
end if

ll_row = idw_mast.find("bdgt_year = '" + ls_bdgt_year + "' and " + &
							  "gwa = '" + as_gwa + "' and " + &
							  "acct_code = '" + as_acct_code + "' and " + &
							  "acct_class = " + string(li_acct_class) + " and " + &
							  "io_gubun = '" + ls_io_gubun + "' and " + &
							  "bdgt_class = " + string(li_bdgt_class), al_row + 1, idw_mast.rowcount())

if ll_row	>	0	then
	f_messagebox('1', '자료가 중복되었습니다.~n~n확인 후 다시 입력해 주시기 바랍니다.!')
	idw_mast.setcolumn('acct_code')
	return	1
end if

return	0

end function

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
// 요구부서
dw_con.getchild('code', idw_child)
idw_child.settransobject(sqlca)
idw_child.retrieve(1,3)
idw_child.insertrow(1)
idw_child.setitem(1,'dept_code','')
idw_child.setitem(1,'dept_name','전체')
//dw_gwa.insertrow(0)

// 상태
idw_mast.getchild('stat_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('stat_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('stat_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('stat_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public subroutine wf_retrieve_preview ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve_preview()
// 인    수 :
// 되 돌 림 :	
// 주의사항 :
// 수정사항 :
// ==========================================================================================

idw_preview.retrieve(is_bdgt_year, is_gwa, ii_acct_class, is_slip_class, ii_bdgt_class)

if idw_print.retrieve(is_bdgt_year, is_gwa, ii_acct_class, is_slip_class, ii_bdgt_class) < 1 then

else

end if
end subroutine

public subroutine wf_insert_remark ();// ==========================================================================================
// 기    능 : 	산출근거 insert
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_insert_remark()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_bdgt_year, ls_gwa, ls_io_gubun
integer	li_newrow, li_sort, li_seq

ls_bdgt_year = idw_mast.getitemstring(idw_mast.getrow(), 'bdgt_year')
ls_gwa		 = idw_mast.getitemstring(idw_mast.getrow(), 'gwa')
ls_io_gubun	 = idw_mast.getitemstring(idw_mast.getrow(), 'io_gubun')

if len(trim(ls_bdgt_year)) < 4 or trim(ls_bdgt_year) = '' then
	f_messagebox('1', '예산년도를 정확히 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	return
end if

if isnull(ls_gwa) or trim(ls_gwa) = '' then
	f_messagebox('1', '요구부서를 정확히 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('code')
	return
end if

if isnull(ls_io_gubun) or trim(ls_io_gubun) = '' then
	f_messagebox('1', '수입지출구분을 정확히 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('slip_class')
	return
end if

if idw_mast.getitemnumber(il_currentrow, 'stat_class') <> ii_stat_class then
	f_messagebox('1', '등록할 수 없습니다.~n~n새로운 자료를 등록하시기 바랍니다.!')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	return
elseif isnull(idw_mast.getitemstring(il_currentrow, 'acct_code')) or trim(idw_mast.getitemstring(il_currentrow, 'acct_code')) = '' then
	f_messagebox('1', '계정코드를 정확히 선택하신 후 다시 등록하시기 바랍니다.!')
	idw_mast.setcolumn('acct')
	idw_mast.setfocus()
	return
end if

if	idw_data.getrow() = 0 then
	li_newrow	=	idw_data.rowcount() + 1
else
	li_newrow	=	idw_data.getrow() + 1
end if	

idw_data.insertrow(li_newrow)

idw_data.setitem(li_newrow, 'bdgt_year',	idw_mast.getitemstring(idw_mast.getrow(), 'bdgt_year'))
idw_data.setitem(li_newrow, 'gwa',			idw_mast.getitemstring(idw_mast.getrow(), 'gwa'))
idw_data.setitem(li_newrow, 'acct_code',	idw_mast.getitemstring(idw_mast.getrow(), 'acct_code'))
idw_data.setitem(li_newrow, 'acct_class',	idw_mast.getitemnumber(idw_mast.getrow(), 'acct_class'))
idw_data.setitem(li_newrow, 'io_gubun',	idw_mast.getitemstring(idw_mast.getrow(), 'io_gubun'))
idw_data.setitem(li_newrow, 'bdgt_class',	idw_mast.getitemnumber(idw_mast.getrow(), 'bdgt_class'))

li_sort = integer(idw_data.describe("evaluate('max(sort) + 1', 1)"))

idw_data.setitem(li_newrow, 'sort',	li_sort)
idw_data.setitem(li_newrow, 'stat_class',		ii_stat_class)

li_seq	=	integer(idw_data.describe("evaluate('max(bdgt_seq) + 1', 1)"))

idw_data.setitem(li_newrow, 'bdgt_seq',	li_seq)

idw_data.setitem(li_newrow, 'worker',		gs_empcode)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setrow(li_newrow)
idw_data.scrolltorow(li_newrow)
idw_data.setcolumn('calc_remark')
idw_data.setfocus()

end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_name
integer	li_tab

if f_chkterm(is_bdgt_year, ii_bdgt_class, ii_stat) < 0 then
	ii_stat_class = -1
else
	ii_stat_class = ii_stat
end if

li_tab  = tab_sheet.selectedtab
wf_button_control(li_tab)



if idw_mast.retrieve(is_bdgt_year, is_gwa, ii_acct_class, is_slip_class, ii_bdgt_class, ii_stat_class) > 0 then
	wf_retrieve_preview()
else
	idw_preview.reset()
	idw_print.reset()
	
	dw_con.setfocus()
	dw_con.setcolumn('year')
end if

return 0
end function

public subroutine wf_insert ();// ==========================================================================================
// 기    능 : 	Mast insert
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_insert()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_newrow, li_sort, li_seq

if len(trim(is_bdgt_year)) < 4 or trim(is_bdgt_year) = '0000' then
	f_messagebox('1', '예산년도를 정확히 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	return
end if

if isnull(is_gwa) or trim(is_gwa) = '' then
	f_messagebox('1', '요구부서를 정확히 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('code')
	return
end if

if isnull(is_slip_class) or trim(is_slip_class) = '' then
	f_messagebox('1', '수입지출구분을 정확히 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('slip_class')
	return
end if

if f_chkterm(is_bdgt_year, ii_bdgt_class, ii_stat) < 0 then
	return
end if

ii_stat_class = ii_stat
	
if idw_mast.rowcount() < 1 then
	// 초기화 하시 위해 강제 조회
	idw_mast.retrieve('ZZZZ', is_gwa, ii_acct_class, is_slip_class, ii_bdgt_class, ii_stat_class)
end if

li_newrow	=	idw_mast.rowcount() + 1

idw_mast.insertrow(li_newrow)

idw_mast.setitem(li_newrow, 'bdgt_year',	is_bdgt_year)
idw_mast.setitem(li_newrow, 'gwa',			is_gwa)
idw_mast.setitem(li_newrow, 'acct_class',	ii_acct_class)
idw_mast.setitem(li_newrow, 'io_gubun',	is_slip_class)
idw_mast.setitem(li_newrow, 'bdgt_class',	ii_bdgt_class)

li_sort = integer(idw_mast.describe("evaluate('max(sort for group 1) + 1', " + string(li_newrow) +	")"))

idw_mast.setitem(li_newrow, 'sort',	li_sort)
idw_mast.setitem(li_newrow, 'stat_class',		ii_stat_class)
idw_mast.setitem(li_newrow, 'worker',		gs_empcode)
idw_mast.setitem(li_newrow, 'ipaddr',		gs_ip)
idw_mast.setitem(li_newrow, 'work_date',	f_sysdate())

idw_mast.setrow(li_newrow)
idw_mast.scrolltorow(li_newrow)
idw_mast.setcolumn('acct_code')
idw_mast.setfocus()

end subroutine

public function integer wf_retrieve_2 ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve_2()
// 인    수 :
// 되 돌 림 :	
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String	ls_bdgt_year, ls_gwa, ls_acct_code, ls_io_gubun
integer	li_acct_class

if idw_mast.rowcount() < 1 or il_currentrow < 1 then	return	0

ls_bdgt_year 	= 	idw_mast.getitemstring(il_currentrow, 'bdgt_year')
ls_gwa		 	= 	idw_mast.getitemstring(il_currentrow, 'gwa')
ls_acct_code 	= 	idw_mast.getitemstring(il_currentrow, 'acct_code')
li_acct_class	=	idw_mast.getitemnumber(il_currentrow, 'acct_class')
ls_io_gubun 	= 	idw_mast.getitemstring(il_currentrow, 'io_gubun')

idw_data.retrieve(ls_bdgt_year, ls_gwa, ls_acct_code, li_acct_class, ls_io_gubun, ii_bdgt_class, ii_stat_class, is_mast_work_gbn)

return	0
end function

public subroutine wf_button_control (integer ai_index);// ==========================================================================================
// 기    능 : 	button control
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_button_control(integer	ai_index)
// 인    수 :	ai_index	-	tabpage index
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

if ii_stat_class < 0 then
//	wf_setMenu('INSERT',		FALSE)
//	wf_setMenu('DELETE',		FALSE)
//	wf_setMenu('RETRIEVE',	TRUE)
//	wf_setMenu('UPDATE',		FALSE)
//	wf_setMenu('PRINT',		TRUE)
	tab_sheet.tabpage_sheet01.pb_insert.of_enable(false)
	tab_sheet.tabpage_sheet01.pb_delete.of_enable(false)
	return
end if

choose case ai_index
	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
		tab_sheet.tabpage_sheet01.pb_insert.of_enable(true)
		tab_sheet.tabpage_sheet01.pb_delete.of_enable(true)
	case 2
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		FALSE)
	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
end choose
end subroutine

public function integer wf_save ();// ==========================================================================================
// 기    능 : 	save
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_save()
// 인    수 :
// 되 돌 림 :	
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	i
long		ll_rowcount, ll_row

if idw_mast.update() = 1 then
	if idw_data.rowcount() < 1 then
		messagebox('확인', '산출근거를 입력하시기 바랍니다.')
		return -1
	end if
	for i = 1 to idw_data.rowcount()
		idw_data.setitem(i, 'work_gbn', 'S')
		idw_data.setitem(i, 'sort',		i)
	next
	if idw_data.update() = 1 then
		COMMIT	;
		wf_retrieve_preview()
		return	0
	end if
else
	ROLLBACK	;
	return	-1
end if


end function

on w_hac402a.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_cal=create cb_cal
this.uo_acct_class=create uo_acct_class
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_cal
this.Control[iCurrent+3]=this.uo_acct_class
end on

on w_hac402a.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_cal)
destroy(this.uo_acct_class)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('조회중')

wf_retrieve()

wf_setMsg('')


return 1
end event

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
wf_setMsg('상세자료도 입력하세요!')

wf_insert()

wf_setMsg('')
//f_setpointer('END')

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
//idw_mast		=	tab_sheet.tabpage_sheet01.dw_list001
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_preview		=	tab_sheet.tabpage_sheet02.dw_list002
//idw_print		=	tab_sheet.tabpage_sheet03.dw_print
//ist_back		=	tab_sheet.tabpage_sheet03.st_back
//
//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
//ii_acct_class 	= 	uo_acct_class.uf_getcode()
//is_slip_class 	= 	uo_slip_class.uf_getcode()
//
//wf_getchild()
//
//tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_mast, 		'acct_code', 'acct_name')
//tab_sheet.tabpage_sheet02.uo_2.uf_reset(idw_preview, 	'acct_code', 'acct_name')
//
//if gi_dept_opt <> 1 and gs_empcode <> 'F0092' then
//	dw_gwa.enabled = False
//	dw_gwa.setitem(1, 'code', gs_deptcode)
//	is_gwa = gs_deptcode
//else
//	dw_gwa.setitem(1, 'code', '')
//	is_gwa = ''
//end if
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer	li_rtn

//f_setpointer('START')
wf_setMsg('저장중')

li_rtn = wf_save()

if li_rtn < 0 then
	wf_setMsg('저장을 실패했습니다.!')
else
	wf_setMsg('저장을 완료했습니다.!')
end if
//f_setpointer('END')
return 1

end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
wf_setMsg('삭제중')

wf_delete()

wf_setMsg('')
//f_setpointer('END')

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

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_mast		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_preview		=	tab_sheet.tabpage_sheet02.dw_list002
idw_print		=	tab_sheet.tabpage_sheet03.dw_print


//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
ii_acct_class 	= 	uo_acct_class.uf_getcode()
//is_slip_class 	= 	uo_slip_class.uf_getcode()

wf_getchild()

tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_mast, 		'acct_code', 'acct_name')
tab_sheet.tabpage_sheet02.uo_2.uf_reset(idw_preview, 	'acct_code', 'acct_name')

if gi_dept_opt <> 1 and gs_empcode <> 'F0092' then
	dw_con.object.code.protect = 1
	//dw_gwa.enabled = False
	dw_con.setitem(1, 'code', gs_deptcode)
	is_gwa = gs_deptcode
else
	dw_con.setitem(1, 'code', '')
	is_gwa = ''
end if

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = tab_sheet.tabpage_sheet01.dw_update.x + tab_sheet.tabpage_sheet01.dw_update.width

If tab_sheet.tabpage_sheet01.pb_delete.Enabled Then
	 tab_sheet.tabpage_sheet01.pb_delete.X		= ll_stnd_pos -  tab_sheet.tabpage_sheet01.pb_delete.Width
	ll_stnd_pos		= ll_stnd_pos -  tab_sheet.tabpage_sheet01.pb_delete.Width - 16
Else
	 tab_sheet.tabpage_sheet01.pb_delete.Visible	= FALSE
End If

If  tab_sheet.tabpage_sheet01.pb_insert.Enabled Then
	 tab_sheet.tabpage_sheet01.pb_insert.X		= ll_stnd_pos -  tab_sheet.tabpage_sheet01.pb_insert.Width
	ll_stnd_pos		= ll_stnd_pos -  tab_sheet.tabpage_sheet01.pb_insert.Width - 16
Else
	 tab_sheet.tabpage_sheet01.pb_insert.Visible	= FALSE
End If
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

type ln_templeft from w_tabsheet`ln_templeft within w_hac402a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac402a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac402a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac402a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac402a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac402a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac402a
end type

type uc_insert from w_tabsheet`uc_insert within w_hac402a
end type

type uc_delete from w_tabsheet`uc_delete within w_hac402a
end type

type uc_save from w_tabsheet`uc_save within w_hac402a
end type

type uc_excel from w_tabsheet`uc_excel within w_hac402a
end type

type uc_print from w_tabsheet`uc_print within w_hac402a
end type

type st_line1 from w_tabsheet`st_line1 within w_hac402a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac402a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac402a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac402a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac402a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac402a
integer y = 316
integer width = 4384
integer height = 1984
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
end type

event tab_sheet::selectionchanged;call super::selectionchanged;wf_button_control(newindex)

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
integer height = 1864
string text = "예산편성등록/관리"
gb_4 gb_4
uo_1 uo_1
pb_insert pb_insert
pb_delete pb_delete
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.uo_1=create uo_1
this.pb_insert=create pb_insert
this.pb_delete=create pb_delete
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.pb_insert
this.Control[iCurrent+4]=this.pb_delete
this.Control[iCurrent+5]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_1)
destroy(this.pb_insert)
destroy(this.pb_delete)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
event ue_dwntabout pbm_dwntabout
boolean visible = false
integer y = 168
integer width = 101
integer height = 100
string dataobject = "d_hac402a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::ue_dwntabout;if getcolumnname() = 'req_amt' then
	idw_data.setcolumn('calc_remark')
	idw_data.setfocus()
	return	1
end if
end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(False)
end event

event dw_list001::itemchanged;call super::itemchanged;string		ls_acct_code, ls_acct_name, ls_bdgt_year, ls_io_gubun, ls_gwa
integer		li_acct_class
long			ll_cnt, ll_count
s_insa_com	lstr_com, lstr_Rtn

if	dwo.name = 'acct_code' then
	ls_bdgt_year  = getitemstring(row, 'bdgt_year')
	ls_gwa        = getitemstring(row, 'gwa')
	ls_acct_code  = trim(data) + '%'
	li_acct_class = getitemnumber(row, 'acct_class')
	ls_io_gubun   = getitemstring(row, 'io_gubun')
		
	select	count(*)	into	:ll_cnt
	from		acdb.hac001m
	where		acct_code	like	:ls_acct_code
	and		jg_gubun = 'Y'
	and		level_class = '4'
	and		decode(:is_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
		
	if ll_cnt < 1 then
		setitem(row, 'acct_code', '')
		setitem(row, 'acct_name', '')
		setitem(row, 'mgr_gwa', '')
		messagebox('확인', '등록되지 않은 자금계정코드입니다.')
		return 1
	end if
		
	if ll_cnt = 1 then
		// 상위부서
		is_mgr_dept	=	f_mgr_dept(ls_bdgt_year, data, li_acct_class, ls_io_gubun)
		if is_mgr_dept = '' then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return	1
		end if
		setitem(row, 'mgr_gwa', is_mgr_dept)

		if wf_duplicate_chk(row, ls_gwa, data)	=	1	then	
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return	1
		end if

		select	decode(:is_slip_class,'1',acct_iname,'2',acct_oname,acct_name)	into	:ls_acct_name
		from		acdb.hac001m
		where		acct_code	like	:ls_acct_code
		and		jg_gubun = 'Y'
		and		level_class = '4'
		and		decode(:is_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
			
		setitem(row, 'acct_code', trim(data))
		setitem(row, 'acct_name', trim(ls_acct_name))

		// 산출근거 자료변경
		for ll_count = 1 to idw_data.rowcount()
			idw_data.setitem(ll_count, 'acct_code', data)
		next
	else
		lstr_com.ls_item[1]	=	trim(data)
		lstr_com.ls_item[2]	=	''
		lstr_com.ls_item[3]	=	string(li_acct_class)
		lstr_com.ls_item[4]	=	ls_io_gubun

		OpenWithParm(w_hac001h, lstr_com)

		lstr_Rtn = Message.PowerObjectParm

		if not isvalid(lstr_rtn) then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return 1
		end if

		// 상위부서
		is_mgr_dept	=	f_mgr_dept(ls_bdgt_year, lstr_Rtn.ls_item[1], li_acct_class, ls_io_gubun)
		if is_mgr_dept = '' then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return	1
		end if
		setitem(row, 'mgr_gwa', is_mgr_dept)

		if wf_duplicate_chk(row, ls_gwa, lstr_Rtn.ls_item[1])	=	1	then	
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return	1
		end if

		setitem(row, 'acct_code', lstr_Rtn.ls_item[1])
		setitem(row, 'acct_name', lstr_Rtn.ls_item[2])
		
		// 산출근거 자료변경
		for ll_count = 1 to idw_data.rowcount()
			idw_data.setitem(ll_count, 'acct_code', lstr_Rtn.ls_item[1])
		next
		return 1
	end if
end if

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event dw_list001::losefocus;call super::losefocus;accepttext()
end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then
	idw_data.reset()
	return
end if

il_currentrow = currentrow

if isnull(getitemstring(currentrow, 'work_gbn'))	then
	is_mast_work_gbn  =	''
else
	is_mast_work_gbn	=	'C'
end if
ii_mast_stat_class	=	getitemnumber(currentrow, 'stat_class')

//selectrow(0, false)
if ii_mast_stat_class <> ii_stat_class then
//	selectrow(currentrow, true)
end if

wf_retrieve_2()

end event

event dw_list001::rowfocuschanging;call super::rowfocuschanging;if currentrow < 1 or	newrow < 1 then
	idw_data.reset()
	return
end if

il_currentrow = newrow

if isnull(getitemstring(newrow, 'work_gbn'))then
	is_mast_work_gbn  =	''
else
	is_mast_work_gbn	=	'C'
end if
ii_mast_stat_class	=	getitemnumber(newrow, 'stat_class')

//selectrow(0, false)
if ii_mast_stat_class <> ii_stat_class then
//	selectrow(newrow, true)
end if

wf_retrieve_2()

end event

event dw_list001::itemerror;call super::itemerror;return	1
end event

event dw_list001::getfocus;call super::getfocus;idw_1	=	this

end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer y = 168
integer width = 4338
integer height = 984
string dataobject = "d_hac402a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;string		ls_acct_code, ls_acct_name, ls_bdgt_year, ls_io_gubun, ls_gwa
integer		li_acct_class
long			ll_cnt, ll_count
s_insa_com	lstr_com, lstr_Rtn

if	dwo.name = 'acct_code' then
	ls_bdgt_year  = getitemstring(row, 'bdgt_year')
	ls_gwa        = getitemstring(row, 'gwa')
	ls_acct_code  = trim(data) + '%'
	li_acct_class = getitemnumber(row, 'acct_class')
	ls_io_gubun   = getitemstring(row, 'io_gubun')
		
	select	count(*)	into	:ll_cnt
	from		acdb.hac001m
	where		acct_code	like	:ls_acct_code
	and		jg_gubun = 'Y'
	and		level_class = '4'
	and		decode(:is_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
		
	if ll_cnt < 1 then
		setitem(row, 'acct_code', '')
		setitem(row, 'acct_name', '')
		setitem(row, 'mgr_gwa', '')
		messagebox('확인', '등록되지 않은 자금계정코드입니다.')
		return 1
	end if
		
	if ll_cnt = 1 then
		// 상위부서
		is_mgr_dept	=	f_mgr_dept(ls_bdgt_year, data, li_acct_class, ls_io_gubun)
		if is_mgr_dept = '' then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return	1
		end if
		setitem(row, 'mgr_gwa', is_mgr_dept)

		if wf_duplicate_chk(row, ls_gwa, data)	=	1	then	
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return	1
		end if

		select	decode(:is_slip_class,'1',acct_iname,'2',acct_oname,acct_name)	into	:ls_acct_name
		from		acdb.hac001m
		where		acct_code	like	:ls_acct_code
		and		jg_gubun = 'Y'
		and		level_class = '4'
		and		decode(:is_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
			
		setitem(row, 'acct_code', trim(data))
		setitem(row, 'acct_name', trim(ls_acct_name))

		// 산출근거 자료변경
		for ll_count = 1 to idw_data.rowcount()
			idw_data.setitem(ll_count, 'acct_code', data)
		next
	else
		lstr_com.ls_item[1]	=	trim(data)
		lstr_com.ls_item[2]	=	''
		lstr_com.ls_item[3]	=	string(li_acct_class)
		lstr_com.ls_item[4]	=	ls_io_gubun

		OpenWithParm(w_hac001h, lstr_com)

		lstr_Rtn = Message.PowerObjectParm

		if not isvalid(lstr_rtn) then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return 1
		end if

		// 상위부서
		is_mgr_dept	=	f_mgr_dept(ls_bdgt_year, lstr_Rtn.ls_item[1], li_acct_class, ls_io_gubun)
		if is_mgr_dept = '' then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return	1
		end if
		setitem(row, 'mgr_gwa', is_mgr_dept)

		if wf_duplicate_chk(row, ls_gwa, lstr_Rtn.ls_item[1])	=	1	then	
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			setitem(row, 'mgr_gwa', '')
			return	1
		end if

		setitem(row, 'acct_code', lstr_Rtn.ls_item[1])
		setitem(row, 'acct_name', lstr_Rtn.ls_item[2])
		
		// 산출근거 자료변경
		for ll_count = 1 to idw_data.rowcount()
			idw_data.setitem(ll_count, 'acct_code', lstr_Rtn.ls_item[1])
		next
		return 1
	end if
end if

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event dw_update_tab::getfocus;call super::getfocus;idw_1	=	this

end event

event dw_update_tab::itemerror;call super::itemerror;return	1
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then
	idw_data.reset()
	return
end if

il_currentrow = currentrow

if isnull(getitemstring(currentrow, 'work_gbn'))	then
	is_mast_work_gbn  =	''
else
	is_mast_work_gbn	=	'C'
end if
ii_mast_stat_class	=	getitemnumber(currentrow, 'stat_class')

//selectrow(0, false)
if ii_mast_stat_class <> ii_stat_class then
//	selectrow(currentrow, true)
end if

wf_retrieve_2()

end event

event dw_update_tab::rowfocuschanging;call super::rowfocuschanging;if currentrow < 1 or	newrow < 1 then
	idw_data.reset()
	return
end if

il_currentrow = newrow

if isnull(getitemstring(newrow, 'work_gbn'))then
	is_mast_work_gbn  =	''
else
	is_mast_work_gbn	=	'C'
end if
ii_mast_stat_class	=	getitemnumber(newrow, 'stat_class')

//selectrow(0, false)
if ii_mast_stat_class <> ii_stat_class then
//	selectrow(newrow, true)
end if

wf_retrieve_2()

end event

type uo_tab from w_tabsheet`uo_tab within w_hac402a
integer x = 1211
integer y = 308
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac402a
string dataobject = "d_hac104a_con"
end type

event dw_con::constructor;call super::constructor;this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
is_bdgt_year = left(f_today(), 4)
This.object.code_t.text = '요구부서'
This.object.year_t.text = '요구년도'
is_slip_class = '2'

end event

event dw_con::itemchanged;call super::itemchanged;dw_con.accepttext()
Choose Case dwo.name
	Case 'year'
		is_bdgt_year = left(data, 4)
	Case 'code'
		is_gwa = trim(data)
	Case 'slip_class'
		is_slip_class	=	data

End Choose
end event

type st_con from w_tabsheet`st_con within w_hac402a
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
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type uo_1 from cuo_search within tabpage_sheet01
integer x = 114
integer y = 32
integer width = 3438
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_search::destroy
end on

type pb_insert from uo_imgbtn within tabpage_sheet01
integer x = 3662
integer y = 1156
integer taborder = 80
boolean bringtotop = true
string btnname = "산출근거입력"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
wf_setMsg('상세자료를 입력하세요!')

wf_insert_remark()

wf_setMsg('')
//f_setpointer('END')

end event

on pb_insert.destroy
call uo_imgbtn::destroy
end on

type pb_delete from uo_imgbtn within tabpage_sheet01
event destroy ( )
integer x = 4027
integer y = 1156
integer taborder = 90
boolean bringtotop = true
string btnname = "산출근거삭제"
end type

on pb_delete.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
wf_setMsg('산출근거 삭제중')

wf_delete_remark()

wf_calc()

wf_setMsg('')
//f_setpointer('END')

end event

type dw_update from uo_dwgrid within tabpage_sheet01
integer y = 1248
integer width = 4347
integer height = 616
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hac402a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;if dwo.name = 'calc_remark' then
	accepttext()
	
	wf_calc()
end if

setitem(row, 'work_gbn',	'I')
setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event clicked;call super::clicked;if isnull(row) or row < 1 then return

trigger event rowfocuschanged(row)

end event

event getfocus;call super::getfocus;idw_1	=	this

if rowcount() < 1	then	return

this.object.calc_remark.tabsequence	=	10
this.object.remark.tabsequence		=	20
this.object.sort.tabsequence			=	30


end event

event itemfocuschanged;call super::itemfocuschanged;if dwo.name = 'calc_remark' then
	f_pro_toggle('K', Handle(this))
end if

end event

event losefocus;call super::losefocus;accepttext()
end event

event retrieveend;call super::retrieveend;if rowcount < 1 then return

trigger event rowfocuschanged(getrow())
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return

//selectrow(0, false)

if isnull(is_mast_work_gbn) or ii_mast_stat_class <> ii_stat_class or is_mast_work_gbn <> '' then
//	selectrow(currentrow, true)
end if

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1864
long backcolor = 16777215
string text = "예산편성등록조회"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list002 dw_list002
gb_5 gb_5
uo_2 uo_2
end type

on tabpage_sheet02.create
this.dw_list002=create dw_list002
this.gb_5=create gb_5
this.uo_2=create uo_2
this.Control[]={this.dw_list002,&
this.gb_5,&
this.uo_2}
end on

on tabpage_sheet02.destroy
destroy(this.dw_list002)
destroy(this.gb_5)
destroy(this.uo_2)
end on

type dw_list002 from uo_dwgrid within tabpage_sheet02
integer y = 164
integer width = 4338
integer height = 1696
integer taborder = 110
string dataobject = "d_hac402a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_5 from groupbox within tabpage_sheet02
integer y = -20
integer width = 4347
integer height = 184
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type uo_2 from cuo_search within tabpage_sheet02
event destroy ( )
integer x = 114
integer y = 40
integer width = 3474
integer taborder = 50
boolean bringtotop = true
end type

on uo_2.destroy
call cuo_search::destroy
end on

type tabpage_sheet03 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1864
long backcolor = 16777215
string text = "예산요구서출력"
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
integer width = 4343
integer height = 1864
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac402a_4"
boolean vscrollbar = true
boolean border = false
end type

type cb_1 from commandbutton within w_hac402a
boolean visible = false
integer x = 1787
integer y = 36
integer width = 457
integer height = 128
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;//Integer ll_controls,i
//DragObject	ldo[]
//picture	lp
//
////ll_controls = UpperBound(parent.Control)
////
////FOR i = 1 TO ll_controls
////	ldo = parent.Control[i]
////	if ldo.typeof() = picture! then
////		lp = ldo
////		lp.picturename = 'C:\Sewc\sewc\HJ\JC\jikin.bmp'
////	end if
////NEXT
//
//ll_controls = UpperBound(parent.Control)
//
//FOR i = 1 TO ll_controls
//	ldo[i] = parent.Control[i]
//NEXT
//
//for i = 1 to ll_controls
//	ldo[i] = 
//	
end event

type cb_cal from cuo_cal within w_hac402a
boolean visible = false
integer x = 1659
integer y = 40
integer width = 608
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "산출내역계산(CUO)"
end type

type uo_acct_class from cuo_acct_class within w_hac402a
event destroy ( )
boolean visible = false
integer x = 910
integer y = 60
integer taborder = 110
boolean bringtotop = true
long backcolor = 1073741824
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

end event

