$PBExportHeader$w_hac401b.srw
$PBExportComments$예산부서 접수(예산부서용)
forward
global type w_hac401b from w_tabsheet
end type
type cb_1 from commandbutton within w_hac401b
end type
type uo_1 from cuo_search within w_hac401b
end type
type gb_3 from groupbox within w_hac401b
end type
type st_31 from statictext within w_hac401b
end type
type uo_acct_class from cuo_acct_class within w_hac401b
end type
type dw_list002 from uo_dwgrid within w_hac401b
end type
type dw_list003 from uo_dwgrid within w_hac401b
end type
type pb_process from uo_imgbtn within w_hac401b
end type
type pb_1 from uo_imgbtn within w_hac401b
end type
end forward

global type w_hac401b from w_tabsheet
integer height = 2616
string title = "예산부서 접수(예산부서용)"
cb_1 cb_1
uo_1 uo_1
gb_3 gb_3
st_31 st_31
uo_acct_class uo_acct_class
dw_list002 dw_list002
dw_list003 dw_list003
pb_process pb_process
pb_1 pb_1
end type
global w_hac401b w_hac401b

type variables
datawindowchild	idw_child
datawindow			idw_mast, idw_data, idw_mgr_dept

string	is_bdgt_year, is_unit_dept
integer	ii_bdgt_class	=	0			// 예산구분
integer	ii_acct_class					// 회계단위
integer	ii_stat_1		=	22			// 상태구분(22 주관부서 접수)
integer	ii_stat_2		=	23			// 상태구분(23 예산부서 접수)
integer	ii_stat_class_1, ii_stat_class_2

string	is_mgr_dept						// 주관부서
string	is_main_dept					// 로긴 예산부서
end variables

forward prototypes
public subroutine wf_button_control ()
public subroutine wf_getchild ()
public function integer wf_process (string as_gubun)
public subroutine wf_retrieve ()
public subroutine wf_retrieve_2 ()
end prototypes

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

// 예산부서, 주관부서
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

// 요구부서(주관부서, 단위부서)
idw_mast.getchild('gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 주관부서(주관부서)
idw_mast.getchild('mgr_gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 2) < 1 then
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

end subroutine

public function integer wf_process (string as_gubun);// ==========================================================================================
// 기    능 : 	부서접수처리
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_process(string	as_gubun)	return	integer
// 인    수 :	as_gubun		:	1=접수, 2=접수취소
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	i, li_stat_class

if trim(is_mgr_dept) = '' then
	f_messagebox('1', '주관부서를 선택해 주세요.!')
	idw_mgr_dept.setfocus()
	return	100
end if

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
	li_stat_class = idw_mast.getitemnumber(i, 'stat_class')
	if as_gubun = '1' and li_stat_class = ii_stat_class_1	then
		idw_mast.setitem(i, 'stat_class', 	ii_stat_class_2)
		idw_mast.setitem(i, 'adjust_amt', 	idw_mast.getitemnumber(i, 'req_amt'))
		idw_mast.setitem(i, 'job_uid',		gs_empcode)
		idw_mast.setitem(i, 'job_add',		gs_ip)
		idw_mast.setitem(i, 'job_date',		f_sysdate())
	elseif as_gubun <> '1' and li_stat_class = ii_stat_class_2	then
		idw_mast.setitem(i, 'stat_class', 	ii_stat_class_1)
		idw_mast.setitem(i, 'adjust_amt', 	0)
		idw_mast.setitem(i, 'job_uid',		gs_empcode)
		idw_mast.setitem(i, 'job_add',		gs_ip)
		idw_mast.setitem(i, 'job_date',		f_sysdate())
	end if
next

// 처리 후 저장
if idw_mast.update() = 1 then
	COMMIT;
else
	ROLLBACK;
end if

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

if f_chkterm(is_bdgt_year, ii_bdgt_class, ii_stat_2) < 0 then
	ii_stat_class_1 = -1
	ii_stat_class_2 = -1
else
	ii_stat_class_1 = ii_stat_1
	ii_stat_class_2 = ii_stat_2
end if

wf_button_control()

idw_mast.retrieve(is_bdgt_year, is_mgr_dept, ii_acct_class, ii_bdgt_class, ii_stat_class_1, ii_stat_class_2)

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

if idw_mast.rowcount() < 1 then	return

ls_bdgt_year = idw_mast.getitemstring(idw_mast.getrow(), 'bdgt_year')
ls_gwa		 = idw_mast.getitemstring(idw_mast.getrow(), 'gwa')
ls_acct_code = idw_mast.getitemstring(idw_mast.getrow(), 'acct_code')
ls_io_gubun	 = idw_mast.getitemstring(idw_mast.getrow(), 'io_gubun')

idw_data.retrieve(is_bdgt_year, ls_gwa, ls_acct_code, ii_acct_class, ls_io_gubun, ii_bdgt_class, ii_stat_class_2)

end subroutine

on w_hac401b.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.uo_1=create uo_1
this.gb_3=create gb_3
this.st_31=create st_31
this.uo_acct_class=create uo_acct_class
this.dw_list002=create dw_list002
this.dw_list003=create dw_list003
this.pb_process=create pb_process
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.st_31
this.Control[iCurrent+5]=this.uo_acct_class
this.Control[iCurrent+6]=this.dw_list002
this.Control[iCurrent+7]=this.dw_list003
this.Control[iCurrent+8]=this.pb_process
this.Control[iCurrent+9]=this.pb_1
end on

on w_hac401b.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.gb_3)
destroy(this.st_31)
destroy(this.uo_acct_class)
destroy(this.dw_list002)
destroy(this.dw_list003)
destroy(this.pb_process)
destroy(this.pb_1)
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
//idw_mgr_dept	=	dw_head
//
//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
//ii_acct_class	=	uo_acct_class.uf_getcode()
//is_main_dept	=	gs_deptcode
//is_mgr_dept		=	'%'
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

idw_mast			=	dw_list002
idw_data			=	dw_list003
idw_mgr_dept	=	dw_con

//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
ii_acct_class	=	uo_acct_class.uf_getcode()
is_main_dept	=	gs_deptcode
is_mgr_dept		=	'%'

wf_getchild()

dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))

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

If pb_1.Enabled Then
	 pb_1.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + pb_1.Width + 16
Else
	 pb_1.Visible	= FALSE
End If
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hac401b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac401b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac401b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac401b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac401b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac401b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac401b
end type

type uc_insert from w_tabsheet`uc_insert within w_hac401b
end type

type uc_delete from w_tabsheet`uc_delete within w_hac401b
end type

type uc_save from w_tabsheet`uc_save within w_hac401b
end type

type uc_excel from w_tabsheet`uc_excel within w_hac401b
end type

type uc_print from w_tabsheet`uc_print within w_hac401b
end type

type st_line1 from w_tabsheet`st_line1 within w_hac401b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac401b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac401b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac401b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac401b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac401b
boolean visible = false
integer y = 2072
integer width = 3749
integer height = 448
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
integer width = 3712
integer height = 328
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
end type

type uo_tab from w_tabsheet`uo_tab within w_hac401b
integer x = 2203
integer y = 1828
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac401b
string dataobject = "d_hac104a_con"
end type

event dw_con::constructor;call super::constructor;
is_bdgt_year = left(f_today(), 4)

This.object.year_t.text = '요구년도'
This.object.slip_class.visible = false
st_31.setposition(totop!)
end event

event dw_con::itemchanged;call super::itemchanged;dw_con.accepttext()
Choose Case dwo.name
	Case 'year'
		is_bdgt_year = left(data, 4)
	
	

End Choose
end event

type st_con from w_tabsheet`st_con within w_hac401b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type cb_1 from commandbutton within w_hac401b
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

type uo_1 from cuo_search within w_hac401b
event destroy ( )
integer x = 201
integer y = 336
integer width = 3575
integer taborder = 60
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_search::destroy
end on

type gb_3 from groupbox within w_hac401b
integer x = 55
integer y = 268
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

type st_31 from statictext within w_hac401b
integer x = 2254
integer y = 188
integer width = 1047
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
string text = "※ 처리 후 자동으로  저장이 됩니다."
boolean focusrectangle = false
end type

type uo_acct_class from cuo_acct_class within w_hac401b
event destroy ( )
boolean visible = false
integer x = 2537
integer y = 92
integer taborder = 70
boolean bringtotop = true
long backcolor = 1073741824
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

end event

type dw_list002 from uo_dwgrid within w_hac401b
integer x = 55
integer y = 468
integer width = 4379
integer height = 868
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hac401b_1"
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

type dw_list003 from uo_dwgrid within w_hac401b
integer x = 55
integer y = 1344
integer width = 4379
integer height = 992
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hac401b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type pb_process from uo_imgbtn within w_hac401b
integer x = 155
integer y = 36
integer taborder = 30
boolean bringtotop = true
string btnname = "일괄접수처리"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('부서접수 처리중')
setpointer(hourglass!)

wf_process('1')

setpointer(arrow!)
wf_setMsg('')


end event

on pb_process.destroy
call uo_imgbtn::destroy
end on

type pb_1 from uo_imgbtn within w_hac401b
integer x = 530
integer y = 36
integer taborder = 40
boolean bringtotop = true
string btnname = "일괄접수해지"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////
// 작성목적 : 자료를 삭제한다.                             //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('부서접수 처리중')
setpointer(hourglass!)

wf_process('2')

setpointer(arrow!)
wf_setMsg('')


end event

on pb_1.destroy
call uo_imgbtn::destroy
end on

