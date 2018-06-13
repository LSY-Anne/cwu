$PBExportHeader$w_hac301b.srw
$PBExportComments$주관부서 접수/취합(주관부서용)
forward
global type w_hac301b from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type st_31 from statictext within tabpage_sheet01
end type
type st_1 from statictext within tabpage_sheet01
end type
type pb_process from uo_imgbtn within tabpage_sheet01
end type
type pb_1 from uo_imgbtn within tabpage_sheet01
end type
type dw_update from uo_dwgrid within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_list002 from uo_dwgrid within tabpage_sheet02
end type
type gb_5 from groupbox within tabpage_sheet02
end type
type gb_3 from groupbox within tabpage_sheet02
end type
type st_3 from statictext within tabpage_sheet02
end type
type uo_2 from cuo_search within tabpage_sheet02
end type
type st_2 from statictext within tabpage_sheet02
end type
type pb_create from uo_imgbtn within tabpage_sheet02
end type
type pb_delete from uo_imgbtn within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_list002 dw_list002
gb_5 gb_5
gb_3 gb_3
st_3 st_3
uo_2 uo_2
st_2 st_2
pb_create pb_create
pb_delete pb_delete
end type
type st_32 from statictext within w_hac301b
end type
type dw_list003 from cuo_dw_hac007h_search within w_hac301b
end type
type uo_acct_class from cuo_acct_class within w_hac301b
end type
end forward

global type w_hac301b from w_tabsheet
string title = "주관부서 접수/취합(주관부서용)"
st_32 st_32
dw_list003 dw_list003
uo_acct_class uo_acct_class
end type
global w_hac301b w_hac301b

type variables
datawindowchild	idw_child
datawindow			idw_mast, idw_data, idw_preview, idw_unit_dept, idw_search

string				is_bdgt_year
integer				ii_acct_class					// 회계단위
integer				ii_bdgt_class	=	0			// 예산구분
integer				ii_stat_1		=	11			// 상태구분(11 단위부서 신청)
integer				ii_stat_2		=	22			// 상태구분(22 주관부서 접수)
integer				ii_stat_class_1, ii_stat_class_2

string				is_mgr_gwa						// 주관부서
string				is_gwa							// 요구부서

end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_retrieve_2 ()
public function integer wf_process (string as_gubun)
public function integer wf_create ()
public function integer wf_delete ()
public subroutine wf_button_control ()
public subroutine wf_retrieve ()
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

// 단위부서
idw_unit_dept.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
else
	idw_child.insertrow(1)
	idw_child.setitem(1, 'dept_code', '%')
	idw_child.setitem(1, 'dept_name', '전체')
end if

idw_unit_dept.reset()
idw_unit_dept.insertrow(0)
is_gwa	=	'%'
idw_unit_dept.setitem(1, 'code', is_gwa)

// 요구부서
idw_mast.getchild('gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 상태
idw_mast.getchild('stat_class_1', idw_child)
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


dw_con.object.year[1] = date(string(func.of_get_sdate('yyyymmdd'), '@@@@/@@/@@'))
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

dw_con.accepttext()
is_bdgt_year = String(dw_con.object.year[dw_con.getrow()], 'yyyy')

if idw_mast.rowcount() < 1 then	return

ls_acct_code = idw_mast.getitemstring(idw_mast.getrow(), 'acct_code')
ls_dept_code = idw_mast.getitemstring(idw_mast.getrow(), 'gwa')
ls_io_gubun  = idw_mast.getitemstring(idw_mast.getrow(), 'io_gubun')

idw_data.retrieve(is_bdgt_year, ls_dept_code, ls_acct_code, ii_acct_class, ls_io_gubun, ii_bdgt_class, ii_stat_class_2)

end subroutine

public function integer wf_process (string as_gubun);// ==========================================================================================
// 기    능 : 	부서접수처리
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_process(string	as_gubun)	return	integer
// 인    수 :	as_gubun	-	'1' = 접수처리, '2' = 접수해지
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	i, li_stat_class
string	ls_create

if idw_mast.rowcount() < 1 then
	f_messagebox('1', '처리할 자료가 존재하지 않습니다.~n~n조회한 후 실행해주시기 바랍니다.!')	
	return	100
end if

if as_gubun = '1' then
	if f_messagebox('2', '일괄접수처리를 하시겠습니까?') = 2	then	return	100
else
	if f_messagebox('2', '일괄접수해지를 하시겠습니까?') = 2	then	return	100
end if

for i = 1 to idw_mast.rowcount()
	li_stat_class 	=	idw_mast.getitemnumber(i, 'stat_class')
	ls_create		=	idw_mast.getitemstring(i, 'comp_create')
	if ls_create	<>	'Y'	then
		if as_gubun = '1' then
			idw_mast.setitem(i, 'stat_class', 	ii_stat_class_2)
		else
			idw_mast.setitem(i, 'stat_class', 	ii_stat_class_1)
		end if			
		idw_mast.setitem(i, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
		idw_mast.setitem(i, 'job_add',		gs_ip)   // gstru_uid_uname.address)
		idw_mast.setitem(i, 'job_date',		f_sysdate())
	end if
next

// 접수처리후 저장한다.

wf_setMsg('저장중')

if idw_mast.update() = 1 then
	COMMIT;
else
	ROLLBACK;
end if

wf_setMsg('')


return	0

end function

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	자료생성(자료취합)
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_cnt
string	ls_main_dept	//	예산부서

// 예산부서
ls_main_dept	=	f_main_dept()
if ls_main_dept = '' then	return 100

// -------------------------------------------------------------------------------------------
// 주관부서에서 접수처리(22) 했는지의 여부
// 자료 중 하나라도 접수처리가 되지 않았으면 실행할 수 없다.
// -------------------------------------------------------------------------------------------
select 	count(*)
into		:li_cnt
from		acdb.hac007h
where		bdgt_year		=		:is_bdgt_year
and		gwa				like	:is_gwa||'%'
and		acct_class		=		:ii_acct_class
and		bdgt_class		=		:ii_bdgt_class
and		mgr_gwa			like	:is_mgr_gwa||'%'
and		stat_class 		=		:ii_stat_class_1	;

if li_cnt > 0 then
	f_messagebox('1', '접수하지 않은 자료가 존재합니다. ~n~n확인 후 다시 처리하여 주십시오.!')
	return	100
end if
// -------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------
// 해당테이블의 중복 자료 체크
// 자료를 삭제할 수 없는 자료를 찾아낸다.
// -------------------------------------------------------------------------------------------
select 	count(*)
into		:li_cnt
from		acdb.hac009h a, acdb.hac007h b
where		a.bdgt_year		=		b.bdgt_year
and		a.gwa				=		b.gwa
and		a.acct_code		=		b.acct_code
and		a.acct_class	=		b.acct_class
and		a.io_gubun		=		b.io_gubun
and		a.bdgt_class	=		b.bdgt_class
and		a.bdgt_year		=		:is_bdgt_year
and		a.gwa				like	:is_gwa||'%'
and		a.acct_class	=		:ii_acct_class
and		a.bdgt_class	=		:ii_bdgt_class
and		a.mgr_gwa		like	:is_mgr_gwa||'%' ;

if li_cnt > 0 then
	f_messagebox('1', '해당하는 자료가 존재합니다. ~n~n확인 후 다시 처리하여 주십시오.!')
	return	100
end if

select 	count(*)
into		:li_cnt
from		acdb.hac009h
where		bdgt_year		=		:is_bdgt_year
and		gwa				like	:is_gwa||'%'
and		acct_class		=		:ii_acct_class
and		bdgt_class		=		:ii_bdgt_class
and		mgr_gwa			like	:is_mgr_gwa||'%'
and		stat_class		<>		:ii_stat_class_2	;

if li_cnt > 0 then
	f_messagebox('1', '주관접수 이외의 자료가 존재합니다. ~n~n확인 후 다시 처리하여 주십시오.!')
	return	100
end if
// -------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------
// 해당 자료를 Insert한다.
// 테이블 : acdb.hac009h, acdb.hac010h
// -------------------------------------------------------------------------------------------
if f_messagebox('2', '부서의 자료를 일괄취합하시겠습니까?') = 2 then return	100

// acdb.hac009h Table에 Insert 한다.
insert	into	acdb.hac009h
		(	bdgt_year, gwa, acct_code, acct_class, io_gubun, bdgt_class, sort, req_amt, stat_class, mgr_gwa, work_gbn, 
			worker, ipaddr, work_date, job_uid, job_add, job_date	)
select	bdgt_year, gwa, acct_code, acct_class, io_gubun, bdgt_class, sort, req_amt, :ii_stat_class_2, mgr_gwa, 'C', 
			:gs_empcode, :gs_ip,	sysdate,	:gs_empcode, :gs_ip, sysdate
from		acdb.hac007h
where		bdgt_year		=		:is_bdgt_year
and		gwa				like	:is_gwa||'%'
and		acct_class		=		:ii_acct_class
and		bdgt_class		=		:ii_bdgt_class
and		mgr_gwa			like	:is_mgr_gwa||'%'
and		stat_class		=		:ii_stat_class_2;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

// acdb.hac010h Table에 Insert 한다.
insert	into	acdb.hac010h
		(	bdgt_year, gwa, acct_code, acct_class, io_gubun, bdgt_class, bdgt_seq, grp, sort, 
			calc_remark, remark, work_gbn,
			worker, ipaddr, work_date, job_uid, job_add, job_date	)
select	b.bdgt_year, b.gwa, b.acct_code, b.acct_class, b.io_gubun, b.bdgt_class, b.bdgt_seq, b.grp, b.sort, 
			b.calc_remark, b.remark, 'C',
			:gs_empcode , :gs_ip   ,	sysdate, :gs_empcode, :gs_ip,	sysdate
from		acdb.hac007h a, acdb.hac008h b
where		a.bdgt_year			=		b.bdgt_year
and		a.gwa					=		b.gwa
and		a.acct_code			=		b.acct_code
and		a.acct_class		=		b.acct_class
and		a.io_gubun			=		b.io_gubun
and		a.bdgt_class		=		b.bdgt_class
and		a.bdgt_year			=		:is_bdgt_year
and		a.gwa					like	:is_gwa||'%'
and		a.acct_class		=		:ii_acct_class
and		a.bdgt_class		=		:ii_bdgt_class
and		a.mgr_gwa			like	:is_mgr_gwa||'%'
and		a.stat_class		=		:ii_stat_class_2;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

return	0

end function

public function integer wf_delete ();// ==========================================================================================
// 기    능 : 	delete
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_delete()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_cnt

select	count(*) 
into		:li_cnt
from		acdb.hac009h
where		bdgt_year	=		:is_bdgt_year
and		gwa			like	:is_gwa||'%'
and		acct_class	=		:ii_acct_class
and		bdgt_class	=		:ii_bdgt_class
and		mgr_gwa		like	:is_mgr_gwa||'%'
and		work_gbn		=		'C'
and		stat_class	<>		:ii_stat_class_2	;

if li_cnt > 0 then
	f_messagebox('1', '부서의 주관접수 이외의 자료가 존재하므로, 자료를 삭제할 수 없습니다.!')
	return	100
end if

// hac011h에 자료가 남아있는지 확인한다.
select	count(*) 
into		:li_cnt
from		acdb.hac011h
where		bdgt_year	=		:is_bdgt_year
and		gwa			like	:is_gwa||'%'
and		acct_class	=		:ii_acct_class
and		bdgt_class	=		:ii_bdgt_class
and		mgr_gwa		like	:is_mgr_gwa||'%'
and		work_gbn		=		'C'
and		stat_class	=		:ii_stat_class_2	;

if li_cnt > 0 then
	f_messagebox('1', '자료를 삭제할 수 없습니다.~n~n~'주관접수자료이관~'에서 이관삭제를 한 후에 다시 실행해 주시기 바랍니다.!')
	return	100
end if

if f_messagebox('2', '부서의 생성된 자료를 모두 삭제합니다.~n~n삭제 하시겠습니까?') = 2 then return	100

// Delete
delete	from	acdb.hac009h
where		bdgt_year	=		:is_bdgt_year
and		gwa			like	:is_gwa||'%'
and		acct_class	=		:ii_acct_class
and		bdgt_class	=		:ii_bdgt_class
and		mgr_gwa		like	:is_mgr_gwa||'%'
and		work_gbn		=		'C'
and		stat_class	=		:ii_stat_class_2	;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

return	0

end function

public subroutine wf_button_control ();// ==========================================================================================
// 기    능 : 	button control
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_button_control(integer	ai_index)
// 인    수 :	ai_index	-	tabpage index
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
//
	tab_sheet.tabpage_sheet02.pb_create.of_enable(false)
	tab_sheet.tabpage_sheet02.pb_delete.of_enable(false)
	tab_sheet.tabpage_sheet01.pb_process.of_enable(false)
else
//	wf_setMenu('INSERT',		FALSE)
//	wf_setMenu('DELETE',		FALSE)
//	wf_setMenu('RETRIEVE',	TRUE)
//	wf_setMenu('UPDATE',		TRUE)
//	wf_setMenu('PRINT',		FALSE)

	tab_sheet.tabpage_sheet02.pb_create.of_enable(true)
	tab_sheet.tabpage_sheet02.pb_delete.of_enable(true)
	tab_sheet.tabpage_sheet01.pb_process.of_enable(true)
end if
end subroutine

public subroutine wf_retrieve ();// ==========================================================================================
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
dw_con.accepttext()
is_bdgt_year = String(dw_con.object.year[dw_con.getrow()], 'yyyy')
is_gwa = dw_con.object.code[dw_con.getrow()]


if f_chkterm(is_bdgt_year, ii_bdgt_class, ii_stat_2) < 0 then
	ii_stat_class_1 = -1
	ii_stat_class_2 = -1
else
	ii_stat_class_1 = ii_stat_1
	ii_stat_class_2 = ii_stat_2
end if

wf_button_control()

idw_mast.retrieve(is_bdgt_year, is_gwa, is_mgr_gwa, ii_acct_class, ii_bdgt_class, ii_stat_class_1, ii_stat_class_2)
idw_preview.retrieve(is_bdgt_year, is_gwa, is_mgr_gwa, ii_acct_class, ii_bdgt_class)

end subroutine

on w_hac301b.create
int iCurrent
call super::create
this.st_32=create st_32
this.dw_list003=create dw_list003
this.uo_acct_class=create uo_acct_class
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_32
this.Control[iCurrent+2]=this.dw_list003
this.Control[iCurrent+3]=this.uo_acct_class
end on

on w_hac301b.destroy
call super::destroy
destroy(this.st_32)
destroy(this.dw_list003)
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

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_mast			=	tab_sheet.tabpage_sheet01.dw_list001
//idw_data			=	tab_sheet.tabpage_sheet01.dw_update
//idw_preview		=	tab_sheet.tabpage_sheet02.dw_list002
//idw_unit_dept	=	dw_con
//idw_search		=	dw_list003
//
////is_bdgt_year	=	uo_bdgt_year.uf_getyy()
//ii_acct_class 	= 	uo_acct_class.uf_getcode()
//if gi_dept_opt	=	1	then
//	is_mgr_gwa	=	''
//else
//	is_mgr_gwa	=	gs_deptcode
//end if
//is_gwa			=	'%'
//
//wf_getchild()
//
//tab_sheet.tabpage_sheet02.uo_2.uf_reset(idw_preview, 	'acct_code', 'acct_name')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('저장중')

if idw_mast.update() = 1 then
	COMMIT;
else
	ROLLBACK;
end if

wf_setMsg('')

return 1

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_mast			=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data			=	tab_sheet.tabpage_sheet01.dw_update
idw_preview		=	tab_sheet.tabpage_sheet02.dw_list002
idw_unit_dept	=	dw_con
idw_search		=	dw_list003

//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
ii_acct_class 	= 	uo_acct_class.uf_getcode()
if gi_dept_opt	=	1	then
	is_mgr_gwa	=	''
else
	is_mgr_gwa	=	gs_deptcode
end if
is_gwa			=	'%'

wf_getchild()

tab_sheet.tabpage_sheet02.uo_2.uf_reset(idw_preview, 	'acct_code', 'acct_name')

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = tab_sheet.tabpage_sheet01.gb_4.x +16

If tab_sheet.tabpage_sheet01.pb_process.Enabled Then
	 tab_sheet.tabpage_sheet01.pb_process.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos +  tab_sheet.tabpage_sheet01.pb_process.Width + 16
Else
	 tab_sheet.tabpage_sheet01.pb_process.Visible	= FALSE
End If

If  tab_sheet.tabpage_sheet01.pb_1.Enabled Then
	 tab_sheet.tabpage_sheet01.pb_1.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos +  tab_sheet.tabpage_sheet01.pb_1.Width + 16
Else
	 tab_sheet.tabpage_sheet01.pb_1.Visible	= FALSE
End If



ll_stnd_pos    = tab_sheet.tabpage_sheet02.gb_5.x +16

If tab_sheet.tabpage_sheet02.pb_create.Enabled Then
	 tab_sheet.tabpage_sheet02.pb_create.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos +  tab_sheet.tabpage_sheet02.pb_create.Width + 16
Else
	 tab_sheet.tabpage_sheet02.pb_create.Visible	= FALSE
End If

If  tab_sheet.tabpage_sheet02.pb_delete.Enabled Then
	 tab_sheet.tabpage_sheet02.pb_delete.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos +  tab_sheet.tabpage_sheet02.pb_delete.Width + 16
Else
	 tab_sheet.tabpage_sheet02.pb_delete.Visible	= FALSE
End If
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hac301b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac301b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac301b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac301b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac301b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac301b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac301b
end type

type uc_insert from w_tabsheet`uc_insert within w_hac301b
end type

type uc_delete from w_tabsheet`uc_delete within w_hac301b
end type

type uc_save from w_tabsheet`uc_save within w_hac301b
end type

type uc_excel from w_tabsheet`uc_excel within w_hac301b
end type

type uc_print from w_tabsheet`uc_print within w_hac301b
end type

type st_line1 from w_tabsheet`st_line1 within w_hac301b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hac301b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hac301b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac301b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac301b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac301b
integer y = 320
integer width = 4384
integer height = 1972
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;wf_button_control()
end event

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
integer width = 4347
integer height = 1852
string text = "주관부서접수처리/해지"
gb_4 gb_4
st_31 st_31
st_1 st_1
pb_process pb_process
pb_1 pb_1
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.st_31=create st_31
this.st_1=create st_1
this.pb_process=create pb_process
this.pb_1=create pb_1
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.st_31
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.pb_process
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.st_31)
destroy(this.st_1)
destroy(this.pb_process)
destroy(this.pb_1)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 101
integer height = 100
string dataobject = "d_hac301b_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::clicked;call super::clicked;if row < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(row)

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

event dw_list001::doubleclicked;call super::doubleclicked;string	ls_acct_code, ls_dept_code

if isnull(row) or row < 1 then	
	idw_search.visible	=	false
else
	ls_acct_code	=	getitemstring(row, 'acct_code')
	ls_dept_code	=	getitemstring(row, 'gwa')
	if idw_search.retrieve(is_bdgt_year, ls_dept_code, ls_acct_code, ii_bdgt_class)	<	1 then
		idw_search.visible	=	false
	else
		idw_search.visible	=	true
	end if
end if
end event

event dw_list001::itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode) // gstru_uid_uname.uid)
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

event dw_list001::rowfocuschanged;call super::rowfocuschanged;idw_search.visible = false

if currentrow < 1 then
	idw_data.reset()
	return
end if

setrow(currentrow)

//selectrow(0, false)
//selectrow(currentrow, true)

wf_retrieve_2()


end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer y = 168
integer height = 772
string dataobject = "d_hac301b_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode) // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event dw_update_tab::clicked;call super::clicked;if row < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(row)

end event

event dw_update_tab::doubleclicked;call super::doubleclicked;string	ls_acct_code, ls_dept_code

if isnull(row) or row < 1 then	
	idw_search.visible	=	false
else
	ls_acct_code	=	getitemstring(row, 'acct_code')
	ls_dept_code	=	getitemstring(row, 'gwa')
	if idw_search.retrieve(is_bdgt_year, ls_dept_code, ls_acct_code, ii_bdgt_class)	<	1 then
		idw_search.visible	=	false
	else
		idw_search.visible	=	true
	end if
end if
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())
end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;idw_search.visible = false

if currentrow < 1 then
	idw_data.reset()
	return
end if

setrow(currentrow)

//selectrow(0, false)
//selectrow(currentrow, true)

wf_retrieve_2()


end event

type uo_tab from w_tabsheet`uo_tab within w_hac301b
integer x = 1070
integer y = 288
end type

type dw_con from w_tabsheet`dw_con within w_hac301b
string dataobject = "d_hac104a_con"
end type

event dw_con::constructor;call super::constructor;
is_bdgt_year = func.of_get_sdate('yyyy')
This.object.year_t.text = '요구년도'
This.object.code_t.text = '요구부서'
This.object.slip_class.visible = false
st_32.setposition(totop!)
end event

event dw_con::itemchanged;call super::itemchanged;dw_con.accepttext()
Choose Case dwo.name
	Case 'year'
		is_bdgt_year = left(data, 4)
	Case 'code'
		is_gwa = trim(data)
	

End Choose
end event

type st_con from w_tabsheet`st_con within w_hac301b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type gb_4 from groupbox within tabpage_sheet01
integer y = -20
integer width = 4338
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type st_31 from statictext within tabpage_sheet01
integer x = 1234
integer y = 32
integer width = 1851
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "※ 일괄접수처리 또는 일괄접수해지를 한 후 자동적으로 저장이 됩니다."
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_sheet01
integer x = 1234
integer y = 96
integer width = 2043
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "   개별접수처리 또는 개별접수해지를 한 후에는 반드시 저장을 하셔야 합니다."
boolean focusrectangle = false
end type

type pb_process from uo_imgbtn within tabpage_sheet01
integer x = 27
integer y = 44
integer taborder = 30
boolean bringtotop = true
string btnname = "일괄접수처리"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2001. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('접수 처리중')

wf_process('1')

wf_setMsg('')


end event

on pb_process.destroy
call uo_imgbtn::destroy
end on

type pb_1 from uo_imgbtn within tabpage_sheet01
integer x = 366
integer y = 44
integer taborder = 60
boolean bringtotop = true
string btnname = "일괄접수해지"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('접수 해지중')

wf_process('2')

wf_setMsg('')


end event

on pb_1.destroy
call uo_imgbtn::destroy
end on

type dw_update from uo_dwgrid within tabpage_sheet01
integer x = 5
integer y = 948
integer width = 4329
integer height = 912
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hac301b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1852
long backcolor = 16777215
string text = "접수된자료취합/해지"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list002 dw_list002
gb_5 gb_5
gb_3 gb_3
st_3 st_3
uo_2 uo_2
st_2 st_2
pb_create pb_create
pb_delete pb_delete
end type

on tabpage_sheet02.create
this.dw_list002=create dw_list002
this.gb_5=create gb_5
this.gb_3=create gb_3
this.st_3=create st_3
this.uo_2=create uo_2
this.st_2=create st_2
this.pb_create=create pb_create
this.pb_delete=create pb_delete
this.Control[]={this.dw_list002,&
this.gb_5,&
this.gb_3,&
this.st_3,&
this.uo_2,&
this.st_2,&
this.pb_create,&
this.pb_delete}
end on

on tabpage_sheet02.destroy
destroy(this.dw_list002)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.st_3)
destroy(this.uo_2)
destroy(this.st_2)
destroy(this.pb_create)
destroy(this.pb_delete)
end on

type dw_list002 from uo_dwgrid within tabpage_sheet02
integer y = 332
integer width = 4343
integer height = 1520
integer taborder = 30
string dataobject = "d_hac301b_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_5 from groupbox within tabpage_sheet02
integer y = -20
integer width = 4343
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_3 from groupbox within tabpage_sheet02
integer y = 144
integer width = 4343
integer height = 184
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type st_3 from statictext within tabpage_sheet02
integer x = 1234
integer y = 32
integer width = 1522
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "※ 접수처리를 먼저 하신 후 자료를 취합하시기 바랍니다."
boolean focusrectangle = false
end type

type uo_2 from cuo_search within tabpage_sheet02
event destroy ( )
integer x = 114
integer y = 204
integer width = 3575
integer taborder = 50
boolean bringtotop = true
end type

on uo_2.destroy
call cuo_search::destroy
end on

type st_2 from statictext within tabpage_sheet02
integer x = 1234
integer y = 96
integer width = 2592
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "   자료취합 후에는 접수를 할 수 없습니다. 부득이한 경우는 취합해지 후 접수를 하시기 바랍니다."
boolean focusrectangle = false
end type

type pb_create from uo_imgbtn within tabpage_sheet02
integer x = 27
integer y = 44
integer taborder = 40
boolean bringtotop = true
string btnname = "일괄자료취합"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 생성한다.                             //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer	li_cnt, li_rtn


wf_setMsg('자료 취합 생성중')

li_rtn	=	wf_create()

if li_rtn = 0 then
	commit	;
	
	select	count(*)
	into		:li_cnt
	from		acdb.hac009h
	where		bdgt_year		=		:is_bdgt_year
	and		gwa				like	:is_gwa		||	'%'
	and		mgr_gwa			like	:is_mgr_gwa	||	'%'
	and		bdgt_class		=		:ii_bdgt_class
	and		stat_class		=		:ii_stat_class_2	
	and		work_gbn			=		'C'	;
	
	f_messagebox('1', string(li_cnt) + '건의 자료를 성공적으로 취합하였습니다.!')
	wf_retrieve()
elseif li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
end if

wf_setMsg('')

end event

on pb_create.destroy
call uo_imgbtn::destroy
end on

type pb_delete from uo_imgbtn within tabpage_sheet02
integer x = 366
integer y = 44
integer taborder = 110
boolean bringtotop = true
string btnname = "일괄취합해지"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer	li_rtn


wf_setMsg('자료 삭제중')

li_rtn	=	wf_delete()

if li_rtn = 0 then
	commit	;
	f_messagebox('1', '자료를 성공적으로 삭제했습니다.!')	
	wf_retrieve()
elseif li_rtn < 1 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
end if

wf_setMsg('')


end event

on pb_delete.destroy
call uo_imgbtn::destroy
end on

type st_32 from statictext within w_hac301b
integer x = 2208
integer y = 192
integer width = 1509
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 접수처리를 먼저 하신 후 자료를 취합하시기 바랍니다."
boolean focusrectangle = false
end type

type dw_list003 from cuo_dw_hac007h_search within w_hac301b
integer x = 421
integer y = 588
integer height = 1848
integer taborder = 21
end type

type uo_acct_class from cuo_acct_class within w_hac301b
event destroy ( )
boolean visible = false
integer x = 169
integer y = 44
integer taborder = 100
boolean bringtotop = true
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

end event

