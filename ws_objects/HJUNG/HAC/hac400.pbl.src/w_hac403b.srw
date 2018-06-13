$PBExportHeader$w_hac403b.srw
$PBExportComments$예산편성 확정(예산부서용)
forward
global type w_hac403b from w_tabsheet
end type
type cb_1 from commandbutton within w_hac403b
end type
type uo_1 from cuo_search within w_hac403b
end type
type st_31 from statictext within w_hac403b
end type
type st_pay_date from statictext within w_hac403b
end type
type em_pay_date from editmask within w_hac403b
end type
type st_2 from statictext within w_hac403b
end type
type dw_list002 from uo_dwgrid within w_hac403b
end type
type gb_2 from groupbox within w_hac403b
end type
type gb_3 from groupbox within w_hac403b
end type
type dw_list003 from uo_dwgrid within w_hac403b
end type
type pb_process from uo_imgbtn within w_hac403b
end type
type pb_delete from uo_imgbtn within w_hac403b
end type
end forward

global type w_hac403b from w_tabsheet
integer height = 2616
string title = "예산편성 확정(예산부서용)"
cb_1 cb_1
uo_1 uo_1
st_31 st_31
st_pay_date st_pay_date
em_pay_date em_pay_date
st_2 st_2
dw_list002 dw_list002
gb_2 gb_2
gb_3 gb_3
dw_list003 dw_list003
pb_process pb_process
pb_delete pb_delete
end type
global w_hac403b w_hac403b

type variables
datawindowchild	idw_child
datawindow			idw_mast, idw_data, idw_mgr_dept

string	is_bdgt_year, is_unit_dept
integer	ii_bdgt_class	=	0			// 예산구분
//integer	ii_acct_class					// 회계단위 -> gi_acct_class 로 변환
integer	ii_stat_1		=	23			// 상태구분(23 예산부서 접수)
integer	ii_stat_2		=	41			// 상태구분(41 예산부서 확정)
integer	ii_stat_class_1, ii_stat_class_2

string	is_mgr_dept						// 주관부서
string	is_main_dept					// 로긴 예산부서
string	is_pay_date						// 배정예산일

string	is_process
end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_retrieve ()
public subroutine wf_retrieve_2 ()
public function integer wf_process ()
public function integer wf_delete ()
public subroutine wf_button_control ()
public function integer wf_create ()
end prototypes

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

idw_mgr_dept.reset()
idw_mgr_dept.insertrow(0)
is_mgr_dept	=	'%'
idw_mgr_dept.setitem(1, 'code', is_mgr_dept)

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

dw_con.accepttext()
is_bdgt_year = string(dw_con.object.year[1], 'yyyy')
is_mgr_dept = dw_con.object.code[1]

if f_chkterm(is_bdgt_year, ii_bdgt_class, ii_stat_2) < 0 then
	ii_stat_class_1 = -1
	ii_stat_class_2 = -1
else
	ii_stat_class_1 = ii_stat_1
	ii_stat_class_2 = ii_stat_2
end if

wf_button_control()

idw_mast.retrieve(is_bdgt_year, is_mgr_dept, gi_acct_class, ii_bdgt_class, ii_stat_class_1, ii_stat_class_2)

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
String	ls_bdgt_year, ls_gwa, ls_acct_code, ls_io_gubun
integer	li_acct_class

if idw_mast.rowcount() < 1 then	return

ls_bdgt_year 	= 	idw_mast.getitemstring(idw_mast.getrow(), 'bdgt_year')
ls_gwa		 	= 	idw_mast.getitemstring(idw_mast.getrow(), 'gwa')
ls_acct_code 	= 	idw_mast.getitemstring(idw_mast.getrow(), 'acct_code')
li_acct_class	=	idw_mast.getitemnumber(idw_mast.getrow(), 'acct_class')
ls_io_gubun 	= 	idw_mast.getitemstring(idw_mast.getrow(), 'io_gubun')

idw_data.retrieve(ls_bdgt_year, ls_gwa, ls_acct_code, li_acct_class, ls_io_gubun, ii_bdgt_class, ii_stat_class_2)

end subroutine

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

if trim(is_bdgt_year) = '' or trim(is_bdgt_year) = '0000' then
	f_messagebox('1', '요구년도를 정확히 입력해 해주시기 바랍니다.!')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	return	100
end if

if is_mgr_dept <> '%' then
	if trim(is_mgr_dept) = '' then
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
from		acdb.hac012h
where		bdgt_year	=		:is_bdgt_year
and		gwa			like	:is_mgr_dept||'%'
and		acct_class	=		:gi_acct_class
and		bdgt_class	=		:ii_bdgt_class	
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

public function integer wf_delete ();// ==========================================================================================
// 기    능 : 	부서확정취소
// 작 성 인 : 	이현수
// 작성일자 : 	2002.04
// 함수원형 : 	wf_delete()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	i, li_stat_class, li_cnt

if trim(is_bdgt_year) = '' or trim(is_bdgt_year) = '0000' then
	f_messagebox('1', '요구년도를 정확히 입력해 해주시기 바랍니다.!')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	return	100
end if

if is_mgr_dept <> '%' then
	if trim(is_mgr_dept) = '' then
		f_messagebox('1', '확정취소 처리할 주관부서를 선택해 주세요.!')
		idw_mgr_dept.setfocus()
		return	100
	end if
end if

if idw_mast.rowcount() < 1 then
	f_messagebox('1', '접수취소 처리할 자료가 존재하지 않습니다.~n~n조회한 후 실행해주시기 바랍니다.!')	
	return	100
end if

select	count(*)
into		:li_cnt
from		acdb.hac012h
where		bdgt_year	=		:is_bdgt_year
and		gwa			like	:is_mgr_dept||'%'
and		acct_class	=		:gi_acct_class
and		bdgt_class	=		:ii_bdgt_class	
and		stat_class	not in (:ii_stat_class_1, :ii_stat_class_2)	
and		work_gbn		=		'C'	;

if li_cnt > 0 then
	f_messagebox('1', '확정취소할 자료 이외의 자료가 존재합니다.~n~n확인한 후 실행해주시기 바랍니다.!')	
	return	100
end if
	
for i = 1 to idw_mast.rowcount()
	li_stat_class = idw_mast.getitemnumber(i, 'stat_class')
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
//	wf_setMenu('UPDATE',		FALSE)
//	wf_setMenu('PRINT',		FALSE)

	pb_process.of_enable(true)
end if
end subroutine

public function integer wf_create ();// ==========================================================================================
// 기    능 :	배정예산 생성
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_process()	return	integet
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	i, li_stat_class
integer	li_dept_cnt, li_row, li_dept_row
integer	li_per
string	ls_dept_code
long		ll_row

wf_retrieve()

if trim(is_bdgt_year) = '' or trim(is_bdgt_year) = '0000' then
	f_messagebox('1', '요구년도를 정확히 입력해 해주시기 바랍니다.!')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	return	100
end if

if idw_mast.rowcount() < 1 then
	f_messagebox('1', '생성할 자료가 존재하지 않습니다.!')
	return	100
end if

// 자료존재여부 확인
select	count(*)
into		:ll_row
from		acdb.hac012m
where		bdgt_year	=		:is_bdgt_year
and		gwa			like	:is_mgr_dept||'%'
and		acct_class	=		:gi_acct_class
and		work_gbn		=		'C'	;
									
if ll_row > 0 then
	if f_messagebox('2', '배정예산 자료가 이미 존재합니다.~n~n삭제 후 다시 생성하시겠습니까?') = 2 then	return 100

	delete	from	acdb.hac012m
	where		bdgt_year	=		:is_bdgt_year
	and		gwa			like	:is_mgr_dept||'%'
	and		acct_class	=		:gi_acct_class
	and		work_gbn		=		'C'	;
										
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode 
end if	

// Insert(hac012m)
insert	into	acdb.hac012m
		(	bdgt_year, gwa, acct_code, acct_class, io_gubun,
			assn_bdgt_amt, assn_1st_amt, assn_2nd_amt, assn_3rd_amt,
			assn_bdgt_date, assn_1st_date, assn_2nd_date, assn_3rd_date, 
			assn_used_amt, assn_temp_amt, assn_real_amt, work_gbn,
			worker, ipaddr, work_date, job_uid, job_add, job_date	)
select	bdgt_year, gwa, acct_code,	acct_class, io_gubun,
			sum(nvl(confirm_amt, 0)), 0, 0, 0,
			:is_pay_date, '', '', '', 
			sum(nvl(confirm_amt, 0)), 0, 0, 'C',
			:gs_empcode, :gs_ip, sysdate,
			:gs_empcode, :gs_ip, sysdate
from		acdb.hac011h
where		bdgt_year	=		:is_bdgt_year
and		gwa			like	:is_mgr_dept||'%'
and		acct_class	=		:gi_acct_class
and		bdgt_class	=		:ii_bdgt_class	
group by bdgt_year, gwa, acct_code, acct_class, io_gubun	;

if sqlca.sqlcode	<>	0	then	return	sqlca.sqlcode

return	sqlca.sqlcode


end function

on w_hac403b.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.uo_1=create uo_1
this.st_31=create st_31
this.st_pay_date=create st_pay_date
this.em_pay_date=create em_pay_date
this.st_2=create st_2
this.dw_list002=create dw_list002
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_list003=create dw_list003
this.pb_process=create pb_process
this.pb_delete=create pb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.st_31
this.Control[iCurrent+4]=this.st_pay_date
this.Control[iCurrent+5]=this.em_pay_date
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_list002
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.dw_list003
this.Control[iCurrent+11]=this.pb_process
this.Control[iCurrent+12]=this.pb_delete
end on

on w_hac403b.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.st_31)
destroy(this.st_pay_date)
destroy(this.em_pay_date)
destroy(this.st_2)
destroy(this.dw_list002)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_list003)
destroy(this.pb_process)
destroy(this.pb_delete)
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
//ii_acct_class	=	uo_acct_class.uf_getcode()
//is_main_dept	=	gs_deptcode
//is_mgr_dept		=	'%'
//
//is_pay_date = f_today()
//em_pay_date.text	=	string(is_pay_date, '@@@@/@@/@@')
//
//wf_getchild()
//
//uo_1.uf_reset(idw_mast,	'acct_code', 'acct_name')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer	li_rtn

if idw_mast.modifiedcount() < 1 and idw_mast.deletedcount() < 1 then	return -1


wf_setMsg('저장중')

if is_process	=	'C'	then
	li_rtn = f_messagebox('2', '예산편성을 최종 일괄확정합니다.~n확정 후 ' + string(is_pay_date, '@@@@년 @@월 @@일') + '자로 예산이 배정됩니다.~n~n저장 하시겠습니까?')
else	
	li_rtn = f_messagebox('2', '예산편성확정을 일괄취소합니다.~n확정취소 후 예산 배정 자료도 삭제됩니다.~n~n저장 하시겠습니까?')
end if

if li_rtn = 1 then
	if idw_mast.update() = 1 then
		
		if is_process = 'C' then
			// 배정예산 생성
			li_rtn = wf_create()
		else
			// 배정예산 삭제
			delete	from	acdb.hac012m
			where		bdgt_year	=		:is_bdgt_year
			and		gwa			like	:is_mgr_dept||'%'
			and		acct_class	=		:gi_acct_class
			and		work_gbn		=		'C'	;
			
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
is_mgr_dept		=	'%'

is_pay_date = f_today()
em_pay_date.text	=	string(is_pay_date, '@@@@/@@/@@')

wf_getchild()

dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
is_bdgt_year = left(f_today(), 4)
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

type ln_templeft from w_tabsheet`ln_templeft within w_hac403b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac403b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac403b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac403b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac403b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac403b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac403b
end type

type uc_insert from w_tabsheet`uc_insert within w_hac403b
end type

type uc_delete from w_tabsheet`uc_delete within w_hac403b
end type

type uc_save from w_tabsheet`uc_save within w_hac403b
end type

type uc_excel from w_tabsheet`uc_excel within w_hac403b
end type

type uc_print from w_tabsheet`uc_print within w_hac403b
end type

type st_line1 from w_tabsheet`st_line1 within w_hac403b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac403b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac403b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac403b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac403b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac403b
boolean visible = false
integer y = 2048
integer width = 3881
integer height = 472
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
integer height = 352
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
end type

type uo_tab from w_tabsheet`uo_tab within w_hac403b
integer x = 1883
integer y = 1932
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac403b
string dataobject = "d_hac104a_con"
end type

event dw_con::itemchanged;call super::itemchanged;dw_con.accepttext()
Choose Case dwo.name
	Case 'year'
		is_bdgt_year = left(data, 4)
End Choose
end event

event dw_con::constructor;call super::constructor;
This.object.year_t.text = '요구년도'
This.object.slip_class.visible = false
st_31.setposition(totop!)
end event

type st_con from w_tabsheet`st_con within w_hac403b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type cb_1 from commandbutton within w_hac403b
boolean visible = false
integer x = 3086
integer y = 288
integer width = 457
integer height = 128
integer taborder = 40
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

type uo_1 from cuo_search within w_hac403b
event destroy ( )
integer x = 197
integer y = 536
integer width = 3575
integer taborder = 60
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_search::destroy
end on

type st_31 from statictext within w_hac403b
integer x = 2295
integer y = 188
integer width = 887
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
string text = "※ 처리 후 자동으로 저장이 됩니다."
boolean focusrectangle = false
end type

type st_pay_date from statictext within w_hac403b
integer x = 210
integer y = 376
integer width = 334
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "배정예산일"
boolean focusrectangle = false
end type

type em_pay_date from editmask within w_hac403b
integer x = 567
integer y = 360
integer width = 480
integer height = 84
integer taborder = 70
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

type st_2 from statictext within w_hac403b
integer x = 1129
integer y = 380
integer width = 2208
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "※ 저장시에 예산 배정이 됩니다. 배정예산일을 확인 후 저장을 하시기 바랍니다."
boolean focusrectangle = false
end type

type dw_list002 from uo_dwgrid within w_hac403b
integer x = 50
integer y = 672
integer width = 4384
integer height = 964
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hac403b_1"
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

//selectrow(0, false)
//selectrow(currentrow, true)

wf_retrieve_2()


end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_2 from groupbox within w_hac403b
integer x = 50
integer y = 288
integer width = 4389
integer height = 200
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_3 from groupbox within w_hac403b
integer x = 50
integer y = 468
integer width = 4389
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

type dw_list003 from uo_dwgrid within w_hac403b
integer x = 50
integer y = 1640
integer width = 4384
integer height = 688
integer taborder = 50
string dataobject = "d_hac403b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type pb_process from uo_imgbtn within w_hac403b
integer x = 155
integer y = 36
integer taborder = 40
boolean bringtotop = true
string btnname = "일괄확정처리"
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

type pb_delete from uo_imgbtn within w_hac403b
integer x = 530
integer y = 36
integer taborder = 50
boolean bringtotop = true
string btnname = "일괄확정취소"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2001. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('부서확정취소 처리중')
setpointer(hourglass!)

wf_delete()
parent.triggerevent('ue_save')

setpointer(arrow!)
wf_setMsg('')


end event

on pb_delete.destroy
call uo_imgbtn::destroy
end on

