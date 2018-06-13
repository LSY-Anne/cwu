$PBExportHeader$w_hac602b.srw
$PBExportComments$예산 전용 승인(예산부서용)
forward
global type w_hac602b from w_tabsheet
end type
type rb_6 from radiobutton within w_hac602b
end type
type rb_7 from radiobutton within w_hac602b
end type
type uo_1 from cuo_search within w_hac602b
end type
type dw_update from uo_dwgrid within w_hac602b
end type
type pb_process from uo_imgbtn within w_hac602b
end type
type gb_5 from groupbox within w_hac602b
end type
type gb_4 from groupbox within w_hac602b
end type
end forward

global type w_hac602b from w_tabsheet
string title = "예산 전용 승인(예산부서용)"
rb_6 rb_6
rb_7 rb_7
uo_1 uo_1
dw_update dw_update
pb_process pb_process
gb_5 gb_5
gb_4 gb_4
end type
global w_hac602b w_hac602b

type variables
datawindowchild	idw_child
datawindow			idw_mast



end variables

forward prototypes
public subroutine wf_retrieve_2 ()
public subroutine wf_getchild ()
public subroutine wf_retrieve ()
public function integer wf_update_hac012m ()
end prototypes

public subroutine wf_retrieve_2 ();
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
String ls_bdgt_year, ls_slip_class
dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1], 'yyyy')
ls_slip_class = dw_con.object.slip_class[1]

// 전용요구부서
dw_con.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(ls_bdgt_year, ls_slip_class) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
else
	idw_child.insertrow(1)
	idw_child.setitem(1, 'dept_code', '%')
	idw_child.setitem(1, 'dept_name', '전체')
end if


idw_child.scrolltorow(1)


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
String ls_bdgt_year, ls_dept_code, ls_slip_class

dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1], 'yyyy')
ls_dept_code = dw_con.object.code[1]
If ls_dept_code = '' or isnull(ls_dept_code) Then ls_dept_code = '%'
ls_slip_class = dw_con.object.slip_class[1]

idw_mast.retrieve(ls_bdgt_year, ls_dept_code, gi_acct_class, ls_slip_class)

end subroutine

public function integer wf_update_hac012m ();// ==========================================================================================
// 기    능 : 	배정예산테이블(hac012m)에 자료가 있으면 전용금액만 update
//				배정예산테이블(hac012m)에 자료가 없으면 Insert
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_update_hac012m()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_mes
integer	li_rowcnt, i
string	ls_from_ent_class, ls_from_dept

String ls_bdgt_year, ls_dept_code, ls_slip_class

dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1], 'yyyy')
ls_dept_code = dw_con.object.code[1]
If ls_dept_code = '' or isnull(ls_dept_code) Then ls_dept_code = '%'
ls_slip_class = dw_con.object.slip_class[1]


select	count(*)
into		:li_rowcnt
from		acdb.hac014h
where		bdgt_year	=		:ls_bdgt_year
and		gwa			like	:ls_dept_code||'%'
and		acct_class	=		:gi_acct_class
and		io_gubun		= 		:ls_slip_class
and		stat_class	=		2
and		work_gbn		=		'I'	;

if idw_mast.rowcount() < 1 or li_rowcnt < 1 then
	f_messagebox('1', '승인할 자료가 존재하지 않습니다.!')
	return	100
end if

if messagebox('확인', '해당하는 자료를 승인처리한 자료는 수정할 수 없습니다.~n~n일괄승인처리를 하시겠습니까?', question!, yesno!, 1) = 2 then return 100

// ------------------------------------------------------------------------------------------
// 예산배정테이블에 자료가 있으면 전용금액을 더한다(전용부서와 전용계정과목이 같은자료)(전입)
// acdb.hac012m Update
// ------------------------------------------------------------------------------------------
update	acdb.hac012m
set		job_uid			=	:gs_empcode,
			job_add			=	:gs_ip,
			job_date			=	sysdate,
		/* 예산전용 수정 (2007.05.29)
			assn_bdgt_amt	=	assn_bdgt_amt +	(	select	nvl(sum(req_amt), 0)
																from		acdb.hac014h
																where		bdgt_year		=	:ls_bdgt_year
																and		tran_gwa			=	acdb.hac012m.gwa
																and		tran_acct_code	=	acdb.hac012m.acct_code
																and		acct_class		=	:gi_acct_class
																and		io_gubun			=	:ls_slip_class
																and		stat_class		=	2
																and		work_gbn			=	'I'	)
		*/
		/* 본예산금액에 Update하지 않고 전용금액 필드 추가하여 Update */
			assn_tran_amt	=	nvl(assn_tran_amt,0) + 	(	select	nvl(sum(req_amt), 0)
																		from		acdb.hac014h
																		where		bdgt_year		=	:ls_bdgt_year
																		and		tran_gwa			=	acdb.hac012m.gwa
																		and		tran_acct_code	=	acdb.hac012m.acct_code
																		and		acct_class		=	:gi_acct_class
																		and		io_gubun			=	:ls_slip_class
																		and		stat_class		=	2
																		and		work_gbn			=	'I'	),
			assn_tran_date	=	(	select	distinct req_date
										from		acdb.hac014h
										where		bdgt_year		=	:ls_bdgt_year
										and		tran_gwa			=	acdb.hac012m.gwa
										and		tran_acct_code	=	acdb.hac012m.acct_code
										and		acct_class		=	:gi_acct_class
										and		io_gubun			=	:ls_slip_class
										and		stat_class		=	2
										and		work_gbn			=	'I'	)
		/*============================================================*/
where		bdgt_year	=		:ls_bdgt_year
and		gwa			in	(	select	distinct tran_gwa
									from		acdb.hac014h
									where		bdgt_year	=		:ls_bdgt_year
									and		gwa			like	:ls_dept_code||'%'
									and		acct_class	=		:gi_acct_class
									and		io_gubun		=		:ls_slip_class
									and		stat_class	=		2
									and		work_gbn		=		'I'	)	
and		acct_code	in	(	select	distinct	tran_acct_code
									from		acdb.hac014h
									where		bdgt_year	=		:ls_bdgt_year
									and		gwa			like	:ls_dept_code||'%'
									and		acct_class	=		:gi_acct_class
									and		io_gubun		=		:ls_slip_class
									and		stat_class	=		2
									and		work_gbn		=		'I'	)
and		acct_class	=		:gi_acct_class
and		io_gubun		= 		:ls_slip_class ;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

// ------------------------------------------------------------------------------------------
// 예산배정테이블에 자료가 있으면 전용금액을 제한다(요구부서와 전출계정과목이 같은자료)(전출)
// acdb.hac012m Update
// ------------------------------------------------------------------------------------------
update	acdb.hac012m
set		job_uid			=	:gs_empcode,
			job_add			=	:gs_ip,
			job_date			=	sysdate,
		/* 예산전용 수정 (2007.05.29)
			assn_bdgt_amt	=	assn_bdgt_amt -	(	select	nvl(sum(req_amt), 0)
																from		acdb.hac014h
																where		bdgt_year		=	:ls_bdgt_year
																and		gwa				=	acdb.hac012m.gwa
																and		acct_code		=	acdb.hac012m.acct_code
																and		acct_class		=	:gi_acct_class
																and		io_gubun			=	:ls_slip_class
																and		stat_class		=	2
																and		work_gbn			=	'I'	)
		*/
		/* 본예산금액에 Update하지 않고 전용금액 필드 추가하여 Update */
			assn_tran_amt	=	nvl(assn_tran_amt,0) - 	(	select	nvl(sum(req_amt), 0)
																		from		acdb.hac014h
																		where		bdgt_year		=	:ls_bdgt_year
																		and		gwa				=	acdb.hac012m.gwa
																		and		acct_code		=	acdb.hac012m.acct_code
																		and		acct_class		=	:gi_acct_class
																		and		io_gubun			=	:ls_slip_class
																		and		stat_class		=	2
																		and		work_gbn			=	'I'	),
			assn_tran_date	=	(	select	distinct req_date
										from		acdb.hac014h
										where		bdgt_year		=	:ls_bdgt_year
										and		gwa				=	acdb.hac012m.gwa
										and		acct_code		=	acdb.hac012m.acct_code
										and		acct_class		=	:gi_acct_class
										and		io_gubun			=	:ls_slip_class
										and		stat_class		=	2
										and		work_gbn			=	'I'	)
		/*============================================================*/
where		bdgt_year	=		:ls_bdgt_year
and		gwa			like	:ls_dept_code||'%'
and		acct_code	in		(	select	distinct	acct_code
										from		acdb.hac014h
										where		bdgt_year	=		:ls_bdgt_year
										and		gwa			like	:ls_dept_code||'%'
										and		acct_class	=		:gi_acct_class
										and		io_gubun		=		:ls_slip_class
										and		stat_class	=		2
										and		work_gbn		=		'I'	)
and		acct_class	=		:gi_acct_class
and		io_gubun		= 		:ls_slip_class	;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

// ------------------------------------------------------------------------------------------
// 예산배정테이블에 자료가 없으면 Insert
// acdb.hac014h Insert
// ------------------------------------------------------------------------------------------
insert	into	acdb.hac012m
/* 예산전용 수정 (2007.05.29)
select	bdgt_year, 					tran_gwa, 		tran_acct_code, 	acct_class, 				io_gubun, 
			nvl(sum(req_amt), 0), 	0, 				0, 					0, 							req_date, 
			'', 							'', 				'',					nvl(sum(req_amt), 0), 	0, 
			0, 							'C', 			
			:gs_empcode, 	:gs_ip, 			sysdate,				
			:gs_empcode, 	:gs_ip, 			sysdate
*/
select	bdgt_year, 					tran_gwa, 		tran_acct_code, 	acct_class, 				io_gubun, 
			0, 							0, 				0, 					0, 							'', 
			'', 							'', 				'',					nvl(sum(req_amt), 0), 	0, 
			0, 							'C', 			
			:gs_empcode, 	:gs_ip, 			sysdate,				
			:gs_empcode, 	:gs_ip, 			sysdate,
			nvl(sum(req_amt), 0),	req_date
from		acdb.hac014h
where		bdgt_year		=		:ls_bdgt_year
and		gwa				like	:ls_dept_code||'%'
and		acct_class		=		:gi_acct_class
and		io_gubun			= 		:ls_slip_class
and		stat_class		=		2
and		work_gbn			=		'I'
and		bdgt_year||tran_gwa||tran_acct_code||acct_class||io_gubun  not in 
		(
			select	bdgt_year||gwa||acct_code||acct_class||io_gubun
			from		acdb.hac012m
			where		bdgt_year	=	:ls_bdgt_year
			and		acct_class	=	:gi_acct_class
			and		io_gubun		= 	:ls_slip_class	
		)
group by bdgt_year, tran_gwa, tran_acct_code, acct_class, io_gubun, req_date	;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

// ------------------------------------------------------------------------------------------
// 예산배정테이블의 배정예산 합계를 Update한다.
// acdb.hac012m Insert
// ------------------------------------------------------------------------------------------
update	acdb.hac012m 
set		job_uid			=	:gs_empcode,
			job_add			=	:gs_ip,
			job_date			=	sysdate,
		/* 예산전용 수정 (2007.05.29)
			assn_used_amt	=	nvl(assn_bdgt_amt + assn_1st_amt + assn_2nd_amt + assn_3rd_amt, 0)
		*/
			assn_used_amt	=	nvl(assn_bdgt_amt,0) + nvl(assn_1st_amt,0) + nvl(assn_2nd_amt,0) + nvl(assn_3rd_amt,0) + nvl(assn_tran_amt,0)
where		bdgt_year		=	:ls_bdgt_year
and		(	gwa			like	:ls_dept_code||'%'
or				gwa			in		(	select	tran_gwa
											from		acdb.hac014h
											where		bdgt_year	=		:ls_bdgt_year
											and		gwa			like	:ls_dept_code||'%'
											and		acct_class	=		:gi_acct_class
											and		io_gubun		=		:ls_slip_class	)	)
and		acct_class		=	:gi_acct_class
and		io_gubun			=	:ls_slip_class ;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

return 0

end function

on w_hac602b.create
int iCurrent
call super::create
this.rb_6=create rb_6
this.rb_7=create rb_7
this.uo_1=create uo_1
this.dw_update=create dw_update
this.pb_process=create pb_process
this.gb_5=create gb_5
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_6
this.Control[iCurrent+2]=this.rb_7
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.dw_update
this.Control[iCurrent+5]=this.pb_process
this.Control[iCurrent+6]=this.gb_5
this.Control[iCurrent+7]=this.gb_4
end on

on w_hac602b.destroy
call super::destroy
destroy(this.rb_6)
destroy(this.rb_7)
destroy(this.uo_1)
destroy(this.dw_update)
destroy(this.pb_process)
destroy(this.gb_5)
destroy(this.gb_4)
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
//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		FALSE)
//
//pb_process.of_enable(false)
//
//idw_mast	=	dw_update
//
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
String ls_bdgt_year, ls_dept_code, ls_slip_class

dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1], 'yyyy')
ls_dept_code = dw_con.object.code[1]
If ls_dept_code = '' or isnull(ls_dept_code) Then ls_dept_code = '%'
ls_slip_class = dw_con.object.slip_class[1]

//f_setpointer('START')
wf_setMsg('저장중')

if idw_mast.update() = 1 then
	li_rtn	=	wf_update_hac012m()
	
	if li_rtn = 0 then
		update	acdb.hac014h
		set		work_gbn	=	'S',
					job_uid		=	:gs_empcode,
					job_add		=	:gs_ip,
					job_date		=	sysdate
		where		bdgt_year	=		:ls_bdgt_year
		and		gwa			like	:ls_dept_code||'%'
		and		acct_class	=		:gi_acct_class
		and		io_gubun		=		:ls_slip_class	
		and		stat_class	=	2	;
		
		if sqlca.sqlcode = 0 then
			commit	;
			wf_setMsg('')

			triggerevent('ue_retrieve')
			return 1
		end if
	elseif li_rtn = 100 then
		rollback	;
		wf_setMsg('')
	
		return -1
	end if
else
	ROLLBACK;
	f_messagebox('3', sqlca.sqlerrtext)
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

//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		FALSE)

pb_process.of_enable(false)

idw_mast	=	dw_update

dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))

wf_getchild()

uo_1.uf_reset(idw_mast,	'acct_code', 'acct_name')

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hac602b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac602b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac602b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac602b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac602b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac602b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac602b
end type

type uc_insert from w_tabsheet`uc_insert within w_hac602b
end type

type uc_delete from w_tabsheet`uc_delete within w_hac602b
end type

type uc_save from w_tabsheet`uc_save within w_hac602b
end type

type uc_excel from w_tabsheet`uc_excel within w_hac602b
end type

type uc_print from w_tabsheet`uc_print within w_hac602b
end type

type st_line1 from w_tabsheet`st_line1 within w_hac602b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac602b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac602b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac602b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac602b
integer beginy = 280
integer endy = 280
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac602b
boolean visible = false
integer x = 187
integer y = 1632
integer width = 3963
integer height = 888
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 3927
integer height = 768
long backcolor = 1073741824
string text = "주관부서접수처리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 3845
integer height = 988
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer width = 3840
end type

type uo_tab from w_tabsheet`uo_tab within w_hac602b
integer x = 2843
integer y = 1676
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac602b
string dataobject = "d_hac602b_con"
end type

event dw_con::itemchanged;call super::itemchanged;wf_getchild()
end event

type st_con from w_tabsheet`st_con within w_hac602b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type rb_6 from radiobutton within w_hac602b
integer x = 96
integer y = 348
integer width = 215
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전출"
boolean checked = true
end type

event clicked;uo_1.uf_reset(idw_mast,	'acct_code', 'acct_name')

end event

type rb_7 from radiobutton within w_hac602b
integer x = 320
integer y = 348
integer width = 215
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전입"
end type

event clicked;uo_1.uf_reset(idw_mast,	'tran_acct_code', 'tran_acct_name')

end event

type uo_1 from cuo_search within w_hac602b
event destroy ( )
integer x = 599
integer y = 328
integer width = 3301
integer taborder = 80
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_search::destroy
end on

type dw_update from uo_dwgrid within w_hac602b
integer x = 50
integer y = 464
integer width = 4384
integer height = 1804
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_hac602b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event retrieveend;call super::retrieveend;if rowcount < 1 then	return

trigger event rowfocuschanged(1)

integer	li_rowcnt
String ls_bdgt_year, ls_dept_code, ls_slip_class

dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1], 'yyyy')
ls_dept_code = dw_con.object.code[1]
If ls_dept_code = '' or isnull(ls_dept_code) Then ls_dept_code = '%'
ls_slip_class = dw_con.object.slip_class[1]


select	count(*)
into		:li_rowcnt
from		acdb.hac014h
where		bdgt_year		=		:ls_bdgt_year
and		gwa		like	:ls_dept_code || '%'
and		substr(acct_code, 1, 1)	= :ls_slip_class
and		((stat_class	=		2
and		work_gbn			=		'I'))
or			stat_class		=		1	;

if rowcount < 1 or li_rowcnt < 1 then
	pb_process.of_enable(false)
//	wf_setMenu('UPDATE',	false)
else
	pb_process.of_enable(true)
//	wf_setMenu('UPDATE',	true)
end if



end event

event itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event losefocus;call super::losefocus;accepttext()
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then	return

//selectrow(0, false)
//selectrow(currentrow, true)
//
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type pb_process from uo_imgbtn within w_hac602b
integer x = 50
integer y = 36
integer taborder = 80
boolean bringtotop = true
string btnname = "부서승인처리"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

long		ll_row


wf_setMsg('부서승인 처리중')
setpointer(hourglass!)

for ll_row = 1 to idw_mast.rowcount()
	if idw_mast.getitemnumber(ll_row, 'stat_class') = 1 then
		idw_mast.setitem(ll_row, 'stat_class', 2)
	end if
next

setpointer(arrow!)
wf_setMsg('')


end event

on pb_process.destroy
call uo_imgbtn::destroy
end on

type gb_5 from groupbox within w_hac602b
integer x = 50
integer y = 260
integer width = 512
integer height = 200
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_4 from groupbox within w_hac602b
integer x = 567
integer y = 260
integer width = 3867
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

