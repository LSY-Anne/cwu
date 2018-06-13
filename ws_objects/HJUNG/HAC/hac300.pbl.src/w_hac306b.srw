$PBExportHeader$w_hac306b.srw
$PBExportComments$주관부서 자료이관(주관부서용)
forward
global type w_hac306b from w_tabsheet
end type
type cb_1 from commandbutton within w_hac306b
end type
type st_3 from statictext within w_hac306b
end type
type gb_3 from groupbox within w_hac306b
end type
type uo_acct_class from cuo_acct_class within w_hac306b
end type
type uo_1 from cuo_search within w_hac306b
end type
type pb_create from uo_imgbtn within w_hac306b
end type
type pb_delete from uo_imgbtn within w_hac306b
end type
type dw_list002 from uo_dwgrid within w_hac306b
end type
end forward

global type w_hac306b from w_tabsheet
integer height = 2616
string title = "주관부서 자료 이관(주관부서용)"
cb_1 cb_1
st_3 st_3
gb_3 gb_3
uo_acct_class uo_acct_class
uo_1 uo_1
pb_create pb_create
pb_delete pb_delete
dw_list002 dw_list002
end type
global w_hac306b w_hac306b

type variables
datawindowchild	idw_child
datawindow			idw_mast, idw_data, idw_preview, idw_unit_dept

string	is_bdgt_year, is_unit_dept
integer	ii_bdgt_class	=	0			// 예산구분
integer	ii_acct_class					//	회계단위
integer	ii_stat			=	22			// 상태구분(22 주관부서 접수)
integer	ii_stat_class					// 상태구분

string	is_mgr_dept						// 로긴 주관부서

end variables

forward prototypes
public function integer wf_delete ()
public subroutine wf_retrieve ()
public function integer wf_create ()
public subroutine wf_button_control ()
public subroutine wf_getchild ()
end prototypes

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
from		acdb.hac011h
where		bdgt_year	=	:is_bdgt_year
and		mgr_gwa		=	:is_mgr_dept
and		acct_class	=	:ii_acct_class
and		bdgt_class	=	:ii_bdgt_class
and		work_gbn		=	'C'
and		stat_class	<>	:ii_stat_class	;

if li_cnt > 0 then
	f_messagebox('1', '부서의 주관접수 이외의 자료가 존재하므로, 자료를 삭제할 수 없습니다.!')
	return	100
end if

if f_messagebox('2', '예산부서로 이관된 자료를 모두 삭제합니다.~n~n삭제 하시겠습니까?') = 2 then return	100

// Delete
delete	from	acdb.hac011h
where		bdgt_year	=	:is_bdgt_year
and		mgr_gwa		=	:is_mgr_dept
and		acct_class	=	:ii_acct_class
and		bdgt_class	=	:ii_bdgt_class
and		work_gbn		=	'C'
and		stat_class	=	:ii_stat_class	;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

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

if f_chkterm(is_bdgt_year, ii_bdgt_class, ii_stat) < 0 then
	ii_stat_class = -1
else
	ii_stat_class = ii_stat
end if

wf_button_control()

idw_data.retrieve(is_bdgt_year, is_mgr_dept, ii_acct_class, ii_bdgt_class)

end subroutine

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	자료생성
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_cnt
integer	li_sort

// -------------------------------------------------------------------------------------------
// 주관부서에서 접수처리(22) 했는지의 여부
// -------------------------------------------------------------------------------------------
select 	count(*)
into		:li_cnt
from		acdb.hac009h
where		bdgt_year		=	:is_bdgt_year
and		mgr_gwa			=	:is_mgr_dept
and		acct_class		=	:ii_acct_class
and		bdgt_class		=	:ii_bdgt_class
and		stat_class 		=	:ii_stat_class	;

if li_cnt < 1 then
	f_messagebox('1', '생성할 자료가 존재하지 않습니다.~n~n확인 후 다시 처리하여 주십시오.!')
	return	100
end if

select 	count(*)
into		:li_cnt
from		acdb.hac009h
where		bdgt_year		=	:is_bdgt_year
and		mgr_gwa			=	:is_mgr_dept
and		acct_class		=	:ii_acct_class
and		bdgt_class		=	:ii_bdgt_class
and		stat_class 		<>	:ii_stat_class	;

if li_cnt > 0 then
	f_messagebox('1', '주관부서 이외의 자료가 존재합니다.~n~n확인 후 다시 처리하여 주십시오.!')
	return	100
end if
// -------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------
// 해당테이블의 중복 자료 체크
// 자료를 삭제할 수 없는 자료를 찾아낸다.
// -------------------------------------------------------------------------------------------
select 	count(*)
into		:li_cnt
from		acdb.hac011h
where		bdgt_year		=	:is_bdgt_year
and		mgr_gwa			=	:is_mgr_dept
and		acct_class		=	:ii_acct_class
and		bdgt_class		=	:ii_bdgt_class
and		stat_class 		=	:ii_stat_class
and		work_gbn			=	'C'	;

if li_cnt > 0 then
	f_messagebox('1', '해당하는 자료가 존재합니다. ~n~n확인 후 다시 처리하여 주십시오.!')
	return	100
end if
// -------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------
// 해당 자료를 Insert한다.
// 테이블 : acdb.hac009h, acdb.hac010h
// -------------------------------------------------------------------------------------------
if f_messagebox('2', '자료를 예산부서로 이관하시겠습니까?') = 2 then return	100

select	nvl(max(sort), 0)
into		:li_sort
from		acdb.hac011h
where		bdgt_year		=	:is_bdgt_year
and		mgr_gwa			=	:is_mgr_dept
and		acct_class		=	:ii_acct_class
and		bdgt_class		=	:ii_bdgt_class
and		stat_class		=	:ii_stat_class	;

if sqlca.sqlcode <> 0 then	li_sort = 0

// acdb.hac011h Table에 Insert 한다.
insert	into	acdb.hac011h
		(	bdgt_year, gwa, acct_code, acct_class, io_gubun, bdgt_class, sort,
			req_amt, adjust_amt, confirm_amt, control_yn, stat_class, mgr_gwa, work_gbn,
			worker, ipaddr, work_date, job_uid, job_add, job_date	)
select	bdgt_year, gwa, acct_code, acct_class, io_gubun, bdgt_class, sort,
			req_amt, 0, 0, 'Y', :ii_stat_class, :is_mgr_dept, 'C',
			:gs_empcode, :gs_ip,	sysdate,
			:gs_empcode, :gs_ip,	sysdate
from		acdb.hac009h
where		bdgt_year	=	:is_bdgt_year
and		mgr_gwa		=	:is_mgr_dept
and		acct_class	=	:ii_acct_class
and		bdgt_class	=	:ii_bdgt_class
and		stat_class	=	:ii_stat_class
order by	sort, acct_code ;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

//(sort - sort) + :li_sort + rownum, 

// acdb.hac012h Table에 Insert 한다.
insert	into	acdb.hac012h
		(	bdgt_year, gwa, acct_code, acct_class, io_gubun, bdgt_class, bdgt_seq, grp, sort,
			calc_remark, remark, work_gbn,
			worker, ipaddr, work_date, job_uid, job_add, job_date	)
select	b.bdgt_year, b.gwa, b.acct_code, b.acct_class, b.io_gubun, b.bdgt_class, b.bdgt_seq, b.grp, b.sort, 
			b.calc_remark, b.remark, 'C',
			:gs_empcode, :gs_ip,	sysdate, 
			:gs_empcode, :gs_ip,	sysdate
from		acdb.hac009h a, acdb.hac010h b
where		b.bdgt_year		=	a.bdgt_year
and		b.gwa				=	a.gwa
and		b.acct_code		=	a.acct_code
and		b.acct_class	=	a.acct_class
and		b.io_gubun		=	a.io_gubun
and		b.bdgt_class	=	a.bdgt_class
and		a.bdgt_year		=	:is_bdgt_year
and		a.mgr_gwa		=	:is_mgr_dept
and		a.acct_class	=	:ii_acct_class
and		a.bdgt_class	=	:ii_bdgt_class
and		a.stat_class	=	:ii_stat_class
order by a.sort, b.sort	;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

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

if ii_stat_class < 0 then
//	wf_setMenu('INSERT',		FALSE)
//	wf_setMenu('DELETE',		FALSE)
//	wf_setMenu('RETRIEVE',	TRUE)
//	wf_setMenu('UPDATE',		FALSE)
//	wf_setMenu('PRINT',		FALSE)

	pb_create.of_enable(false)
	pb_delete.of_enable(false)
else
//	wf_setMenu('INSERT',		FALSE)
//	wf_setMenu('DELETE',		FALSE)
//	wf_setMenu('RETRIEVE',	TRUE)
//	wf_setMenu('UPDATE',		FALSE)
//	wf_setMenu('PRINT',		FALSE)
//
	pb_create.of_enable(true)
	pb_delete.of_enable(true)
end if
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

// 요구부서
idw_data.getchild('hac011h_gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 상태
idw_data.getchild('stat_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('stat_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

on w_hac306b.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_3=create st_3
this.gb_3=create gb_3
this.uo_acct_class=create uo_acct_class
this.uo_1=create uo_1
this.pb_create=create pb_create
this.pb_delete=create pb_delete
this.dw_list002=create dw_list002
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.uo_acct_class
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.pb_create
this.Control[iCurrent+7]=this.pb_delete
this.Control[iCurrent+8]=this.dw_list002
end on

on w_hac306b.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.gb_3)
destroy(this.uo_acct_class)
destroy(this.uo_1)
destroy(this.pb_create)
destroy(this.pb_delete)
destroy(this.dw_list002)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////
dw_con.accepttext()

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
//idw_data			=	dw_list002
//
//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
//ii_acct_class	=	uo_acct_class.uf_getcode()
//is_mgr_dept		=	gs_deptcode
//
//wf_getchild()
//
//uo_1.uf_reset(idw_mast,	'acct_code', 'acct_name')
//
//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		FALSE)
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

idw_data			=	dw_list002

//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
ii_acct_class	=	uo_acct_class.uf_getcode()
is_mgr_dept		=	gs_deptcode

wf_getchild()

uo_1.uf_reset(idw_mast,	'acct_code', 'acct_name')

//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		FALSE)

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_templeft.beginx

If pb_create.Enabled Then
	 pb_create.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + pb_create.Width + 16
Else
	 pb_create.Visible	= FALSE
End If

If pb_delete.Enabled Then
	 pb_delete.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + pb_delete.Width + 16
Else
	 pb_delete.Visible	= FALSE
End If
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hac306b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac306b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac306b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac306b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac306b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac306b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac306b
end type

type uc_insert from w_tabsheet`uc_insert within w_hac306b
end type

type uc_delete from w_tabsheet`uc_delete within w_hac306b
end type

type uc_save from w_tabsheet`uc_save within w_hac306b
end type

type uc_excel from w_tabsheet`uc_excel within w_hac306b
end type

type uc_print from w_tabsheet`uc_print within w_hac306b
end type

type st_line1 from w_tabsheet`st_line1 within w_hac306b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hac306b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hac306b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac306b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac306b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac306b
boolean visible = false
integer y = 1720
integer width = 3881
integer height = 1020
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 3845
integer height = 900
string text = "주관부서접수처리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 404
integer width = 3845
integer height = 988
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
end type

type uo_tab from w_tabsheet`uo_tab within w_hac306b
integer x = 1147
integer y = 1800
end type

type dw_con from w_tabsheet`dw_con within w_hac306b
string dataobject = "d_hac103a_con"
end type

event dw_con::constructor;call super::constructor;this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
is_bdgt_year = left(f_today(), 4)
st_3.setposition(totop!)

end event

event dw_con::itemchanged;call super::itemchanged;dw_con.accepttext()
If dwo.name = 'year' Then
	is_bdgt_year = Left(data, 4)
End If

RETURN 1
end event

type st_con from w_tabsheet`st_con within w_hac306b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type cb_1 from commandbutton within w_hac306b
boolean visible = false
integer x = 3035
integer y = 200
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

type st_3 from statictext within w_hac306b
integer x = 1207
integer y = 196
integer width = 1659
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
string text = "※ 일괄자료이관,일괄이관삭제를 한 후 자동으로 저장이 됩니다."
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_hac306b
integer x = 55
integer y = 276
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

type uo_acct_class from cuo_acct_class within w_hac306b
event destroy ( )
boolean visible = false
integer x = 2537
integer y = 92
integer taborder = 140
boolean bringtotop = true
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

end event

type uo_1 from cuo_search within w_hac306b
event destroy ( )
integer x = 146
integer y = 344
integer width = 3575
integer taborder = 60
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_search::destroy
end on

type pb_create from uo_imgbtn within w_hac306b
integer x = 155
integer y = 36
integer taborder = 20
boolean bringtotop = true
string btnname = "일괄자료이관"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 생성한다.                             //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer	li_cnt, li_rtn
dw_con.accepttext()


wf_setMsg('자료 생성중')
setpointer(hourglass!)

li_rtn	=	wf_create()

if li_rtn = 0 then
	commit	;
	
	select	count(*)
	into		:li_cnt
	from		acdb.hac009h
	where		bdgt_year		=	:is_bdgt_year
	and		mgr_gwa			=	:is_mgr_dept
	and		acct_class		=	:ii_acct_class
	and		bdgt_class		=	:ii_bdgt_class
	and		stat_class		=	:ii_stat_class	;
	
	f_messagebox('1', string(li_cnt) + '건의 자료를 성공적으로 생성하였습니다.!')
	wf_retrieve()
elseif li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
end if

setpointer(arrow!)
wf_setMsg('')

end event

on pb_create.destroy
call uo_imgbtn::destroy
end on

type pb_delete from uo_imgbtn within w_hac306b
integer x = 530
integer y = 36
integer taborder = 30
boolean bringtotop = true
string btnname = "일괄이관삭제"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2001. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer	li_rtn
dw_con.accepttext()

wf_setMsg('자료 삭제중')
setpointer(hourglass!)

li_rtn	=	wf_delete()

if li_rtn = 0 then
	commit	;
	f_messagebox('1', '자료를 성공적으로 삭제했습니다.!')	
	wf_retrieve()
elseif li_rtn < 1 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
end if

setpointer(arrow!)
wf_setMsg('')


end event

on pb_delete.destroy
call uo_imgbtn::destroy
end on

type dw_list002 from uo_dwgrid within w_hac306b
integer x = 55
integer y = 480
integer width = 4375
integer height = 1784
integer taborder = 40
string dataobject = "d_hac306b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

