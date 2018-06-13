$PBExportHeader$w_hpa307a.srw
$PBExportComments$개인별 급여지급 수정
forward
global type w_hpa307a from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_3 from cuo_search_insa within tabpage_sheet01
end type
type st_count1 from statictext within tabpage_sheet01
end type
type cbx_1 from checkbox within tabpage_sheet01
end type
type dw_list002 from cuo_dwwindow within tabpage_sheet01
end type
type dw_list003 from cuo_dwwindow within tabpage_sheet01
end type
type dw_list004 from cuo_dwwindow within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_list005 from cuo_dwwindow within tabpage_sheet02
end type
type gb_5 from groupbox within tabpage_sheet02
end type
type uo_4 from cuo_search_insa within tabpage_sheet02
end type
type st_count from statictext within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_list005 dw_list005
gb_5 gb_5
uo_4 uo_4
st_count st_count
end type
type uo_dept_code from cuo_dept within w_hpa307a
end type
type uo_yearmonth from cuo_yearmonth within w_hpa307a
end type
type dw_head from datawindow within w_hpa307a
end type
type st_1 from statictext within w_hpa307a
end type
type dw_display_title from cuo_display_title within w_hpa307a
end type
type dw_etc from datawindow within w_hpa307a
end type
type ddlb_chasu from dropdownlistbox within w_hpa307a
end type
type st_2 from statictext within w_hpa307a
end type
end forward

global type w_hpa307a from w_tabsheet
integer height = 2724
string title = "개인별 급여지급 수정"
uo_dept_code uo_dept_code
uo_yearmonth uo_yearmonth
dw_head dw_head
st_1 st_1
dw_display_title dw_display_title
dw_etc dw_etc
ddlb_chasu ddlb_chasu
st_2 st_2
end type
global w_hpa307a w_hpa307a

type variables
datawindowchild	idw_child, idw_child2
datawindow			idw_list, idw_data,  idw_list_3, idw_list_4
datawindow			idw_preview
datawindow			idw_sudang, idw_gongje

string	is_yearmonth, is_dept_code, is_Chasu
integer	ii_str_jikjong, ii_end_jikjong

long		il_confirm_gbn

end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_retrieve2 (datawindow adw_1)
public subroutine wf_chain_amt ()
public subroutine wf_confirm_gbn ()
public function integer wf_retrieve ()
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

// 직종코드
idw_preview.getchild('jikjong_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikjong_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 직위코드
idw_data.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 보직코드
idw_data.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public subroutine wf_retrieve2 (datawindow adw_1);// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve2(datawindow	adw_1, long al_member_row)
// 인    수 :	adw_1				-	datawindow
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

dw_display_title.uf_display_title(idw_data, 0)

end subroutine

public subroutine wf_chain_amt ();// ==========================================================================================
// 기    능 : 	수당/공제 합계와 차인지급액을 구한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_chain_amt()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long		ll_rowcount
dec{0}	ldb_sudang, ldb_gongje

ll_rowcount	=	idw_sudang.rowcount()
if ll_rowcount > 0 then
	ldb_sudang	=	idw_sudang.getitemnumber(1, 'sum_amt')
else
	ldb_sudang	=	0
end if
	
ll_rowcount	=	idw_gongje.rowcount()
if ll_rowcount > 0 then
	ldb_gongje	=	idw_gongje.getitemnumber(1, 'sum_amt')
else
	ldb_gongje	=	0
end if

idw_data.object.t_amt.text = string(ldb_sudang - ldb_gongje, '#,##0')

end subroutine

public subroutine wf_confirm_gbn ();// 급여의 확정상태를 확인한다.
// 확정된 상태이면 자료를 입력, 수정, 삭제할 수 없다.
//if is_Chasu = '' or isnull(is_Chasu) then
//	MessageBox('확인','차수를 확인하세요!!!')
//	return 
//end if

il_confirm_gbn	=	f_getconfirm(is_chasu, is_yearmonth, 'N')

//if il_confirm_gbn	=	0	then
//	wf_setMenu('INSERT',		TRUE)
//	wf_setMenu('DELETE',		TRUE)
//	wf_setMenu('UPDATE',		TRUE)
//else
//	wf_setMenu('INSERT',		FALSE)
//	wf_setMenu('DELETE',		FALSE)
//	wf_setMenu('UPDATE',		FALSE)
//end if			
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

integer	li_tab

li_tab  = tab_sheet.selectedtab
//if is_Chasu = '' or isnull(is_Chasu) then
//	MessageBox('확인','차수를 확인하세요!!!')
//	return 2
//end if
if idw_list.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, is_Chasu) > 0 then
	idw_preview.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong, is_Chasu)
else
	idw_preview.reset()
end if


return 0

end function

on w_hpa307a.create
int iCurrent
call super::create
this.uo_dept_code=create uo_dept_code
this.uo_yearmonth=create uo_yearmonth
this.dw_head=create dw_head
this.st_1=create st_1
this.dw_display_title=create dw_display_title
this.dw_etc=create dw_etc
this.ddlb_chasu=create ddlb_chasu
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_dept_code
this.Control[iCurrent+2]=this.uo_yearmonth
this.Control[iCurrent+3]=this.dw_head
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_display_title
this.Control[iCurrent+6]=this.dw_etc
this.Control[iCurrent+7]=this.ddlb_chasu
this.Control[iCurrent+8]=this.st_2
end on

on w_hpa307a.destroy
call super::destroy
destroy(this.uo_dept_code)
destroy(this.uo_yearmonth)
destroy(this.dw_head)
destroy(this.st_1)
destroy(this.dw_display_title)
destroy(this.dw_etc)
destroy(this.ddlb_chasu)
destroy(this.st_2)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


if wf_retrieve() <> 0 then
	wf_setmsg('조회조건을 정확하게 입력하세요!')
	return -1
end if
return 1
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//wf_setMenu('INSERT',		fALSE)
//wf_setMenu('DELETE',		fALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		TRUE)
//wf_setMenu('PRINT',		fALSE)
//
//idw_list		=	tab_sheet.tabpage_sheet01.dw_list001
//idw_data		=	tab_sheet.tabpage_sheet01.dw_list002
//idw_sudang	=	tab_sheet.tabpage_sheet01.dw_list003
//idw_gongje	=	tab_sheet.tabpage_sheet01.dw_list004
//
//idw_preview	=	tab_sheet.tabpage_sheet02.dw_list005
//
//// 직종코드
////uo_1.uf_setType('jikjong_code', '직 종 명')
//// 화면 상단의 DataWindow 표현
//f_getdwcommon(dw_head, 'jikjong_code', 0, 750)
//
//uo_yearmonth.uf_settitle('지급년월')
//is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
////ddlb_chasu.text = '5'
//
//uo_dept_code.uf_setdept('', '소속명')
//is_dept_code	=	uo_dept_code.uf_getcode()
//
//tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 		'member_no', 'name')
//tab_sheet.tabpage_sheet02.uo_4.uf_reset(idw_preview, 	'member_no', 'name')
//
//wf_getchild()
//
//wf_confirm_gbn()
//
//
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer	li_findrow, li_excepte_gbn
long		ll_rowcount, ll_row
string	ls_pay_opt, ls_colname, ls_sql, ls_member_no, ls_Chasu



//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
if idw_sudang.update() = 1 and idw_gongje.update() = 1	then
	COMMIT;

	ls_member_no	=	idw_list.getitemstring(idw_list.getrow(), 'member_no')
	ls_Chasu			=	idw_list.getitemstring(idw_list.getrow(), 'chasu')

	DECLARE sp_proc1 PROCEDURE FOR padb.usp_hpa015m_ud1(:is_yearmonth, :ls_member_no, :ls_Chasu)	;
	EXECUTE sp_proc1	;

//	idw_list.update()
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText + '~r~n' )
  ROLLBACK;
END IF


return 1

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

//wf_setMenu('INSERT',		fALSE)
//wf_setMenu('DELETE',		fALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		TRUE)
//wf_setMenu('PRINT',		fALSE)

idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet01.dw_list002
idw_sudang	=	tab_sheet.tabpage_sheet01.dw_list003
idw_gongje	=	tab_sheet.tabpage_sheet01.dw_list004

idw_preview	=	tab_sheet.tabpage_sheet02.dw_list005

// 직종코드
//uo_1.uf_setType('jikjong_code', '직 종 명')
// 화면 상단의 DataWindow 표현
f_getdwcommon(dw_head, 'jikjong_code', 0, 750)

uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
//ddlb_chasu.text = '5'

uo_dept_code.uf_setdept('', '소속명')
is_dept_code	=	uo_dept_code.uf_getcode()

tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 		'member_no', 'name')
tab_sheet.tabpage_sheet02.uo_4.uf_reset(idw_preview, 	'member_no', 'name')

wf_getchild()

wf_confirm_gbn()



end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa307a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa307a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa307a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa307a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa307a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa307a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa307a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa307a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa307a
end type

type uc_save from w_tabsheet`uc_save within w_hpa307a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa307a
end type

type uc_print from w_tabsheet`uc_print within w_hpa307a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa307a
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa307a
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa307a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa307a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa307a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa307a
integer y = 328
integer width = 4384
integer height = 1984
integer taborder = 0
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;////if oldindex	< 0 or newindex < 0	then	return
//
//choose case newindex
//	case	1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case	else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
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
integer height = 1864
string text = "개인별월급여지급수정"
gb_4 gb_4
uo_3 uo_3
st_count1 st_count1
cbx_1 cbx_1
dw_list002 dw_list002
dw_list003 dw_list003
dw_list004 dw_list004
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.uo_3=create uo_3
this.st_count1=create st_count1
this.cbx_1=create cbx_1
this.dw_list002=create dw_list002
this.dw_list003=create dw_list003
this.dw_list004=create dw_list004
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_3
this.Control[iCurrent+3]=this.st_count1
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.dw_list002
this.Control[iCurrent+6]=this.dw_list003
this.Control[iCurrent+7]=this.dw_list004
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_3)
destroy(this.st_count1)
destroy(this.cbx_1)
destroy(this.dw_list002)
destroy(this.dw_list003)
destroy(this.dw_list004)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 5
integer y = 168
integer width = 101
integer height = 100
string dataobject = "d_hpa305a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;selectrow(0, false)
selectrow(currentrow, true)

if currentrow < 1 then	
	idw_data.reset()
	return
end if

idw_data.retrieve(is_yearmonth, getitemstring(currentrow, 'member_no'), getitemstring(currentrow, 'chasu')) 


end event

event dw_list001::retrieveend;call super::retrieveend;st_count1.text = '건수 : ' + string(rowcount, '#,##0')

if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer y = 164
integer width = 2002
integer height = 1684
string dataobject = "d_hpa305a_1"
end type

event dw_update_tab::retrieveend;call super::retrieveend;st_count1.text = '건수 : ' + string(rowcount, '#,##0')

if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)

if currentrow < 1 then	
	idw_data.reset()
	return
end if

idw_data.retrieve(is_yearmonth, getitemstring(currentrow, 'member_no'), getitemstring(currentrow, 'chasu')) 


end event

type uo_tab from w_tabsheet`uo_tab within w_hpa307a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hpa307a
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hpa307a
end type

type gb_4 from groupbox within tabpage_sheet01
integer y = -20
integer width = 4347
integer height = 184
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
end type

type uo_3 from cuo_search_insa within tabpage_sheet01
integer x = 114
integer y = 40
integer width = 3566
integer taborder = 50
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type st_count1 from statictext within tabpage_sheet01
boolean visible = false
integer x = 2688
integer y = 112
integer width = 530
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "건수 : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within tabpage_sheet01
boolean visible = false
integer x = 3200
integer y = 60
integer width = 576
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "예외지급 포함 조회"
boolean checked = true
end type

event clicked;idw_sudang.setredraw(false)
if this.checked then
	this.text = '예외지급 포함 조회'
	idw_sudang.setfilter("")
	idw_sudang.filter()
else
	this.text = '예외지급 제외 조회'
	idw_sudang.setfilter("excepte_gbn <> 1")
	idw_sudang.filter()
end if
idw_sudang.setredraw(true)

wf_chain_amt()
end event

type dw_list002 from cuo_dwwindow within tabpage_sheet01
integer x = 2016
integer y = 168
integer width = 2336
integer height = 1684
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa307a_2"
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event losefocus;call super::losefocus;accepttext()
end event

event retrieveend;call super::retrieveend;long	ll_rowcount
dec{0}	ldb_sudang, ldb_gongje

if rowcount < 1 then	return

wf_retrieve2(this)

idw_sudang.setredraw(false)
if cbx_1.checked then
	idw_sudang.setfilter("")
	idw_sudang.filter()
else
	idw_sudang.setfilter("hpa003m_excepte_gbn <> 1")
	idw_sudang.filter()
end if
idw_sudang.setredraw(true)

idw_sudang.retrieve(is_yearmonth, getitemstring(getrow(), 'member_no'), '1', il_confirm_gbn, is_Chasu)
idw_sudang.visible	=	true

idw_gongje.retrieve(is_yearmonth, getitemstring(getrow(), 'member_no'), '2', il_confirm_gbn, is_Chasu)
idw_gongje.visible	=	true

//if idw_sudang.retrieve(is_yearmonth, getitemstring(getrow(), 'hpa015m_member_no'), '1') < 1 then
//	idw_sudang.visible = false
//else
//	idw_sudang.visible = true
//end if
//
//if idw_gongje.retrieve(is_yearmonth, getitemstring(getrow(), 'hpa015m_member_no'), '2') < 1 then
//	idw_gongje.visible = false
//else
//	idw_gongje.visible = true
//end if	

wf_chain_amt()

end event

type dw_list003 from cuo_dwwindow within tabpage_sheet01
integer x = 2025
integer y = 728
integer width = 1326
integer height = 1076
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hpa307a_4"
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

type dw_list004 from cuo_dwwindow within tabpage_sheet01
integer x = 3323
integer y = 728
integer width = 1019
integer height = 1076
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hpa307a_4"
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1864
string text = "월급여지급조회"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list005 dw_list005
gb_5 gb_5
uo_4 uo_4
st_count st_count
end type

on tabpage_sheet02.create
this.dw_list005=create dw_list005
this.gb_5=create gb_5
this.uo_4=create uo_4
this.st_count=create st_count
this.Control[]={this.dw_list005,&
this.gb_5,&
this.uo_4,&
this.st_count}
end on

on tabpage_sheet02.destroy
destroy(this.dw_list005)
destroy(this.gb_5)
destroy(this.uo_4)
destroy(this.st_count)
end on

type dw_list005 from cuo_dwwindow within tabpage_sheet02
integer y = 168
integer width = 4338
integer height = 1696
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa305a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event retrieveend;call super::retrieveend;integer	li_cnt

dw_display_title.uf_display_title(this, 0)

st_count.text = '건수 : 0'

for li_cnt = 1 to rowcount
	st_count.text = '건수 : ' + string(li_cnt, '#,##0')
next

//integer	li_cnt, li_subcnt, li_pay_opt, li_jikjong, li_rtn
//long		ll_rowcount
//string	ls_member_no, ls_pay_opt, ls_title[] = {'sudang', 'gongje'}
//string	ls_suname1[18], ls_suname2[18], ls_suname3[18], ls_filter
//string	ls_goname1[18], ls_goname2[18], ls_goname3[18]
//long		ll_row
//
//st_count.text = '건수 : 0'
//
//for li_cnt = 1 to rowcount
//	for li_pay_opt = 1 to 2
//		if getitemnumber(li_cnt, 'group_cnt') = 1 then
//			dw_item.setfilter('')
//			dw_item.filter()
//			

//			li_jikjong	=	getitemnumber(li_cnt, 'jikjong_code')
//			dw_item.retrieve(li_jikjong, string(li_pay_opt))
//	
//			if li_jikjong = 4 then
//				dw_item.setfilter("gubun = 2 or count = 1")
//			elseif li_jikjong = 5 then
//				dw_item.setfilter("gubun = 3 or count = 1")
//			else
//				dw_item.setfilter("gubun = 1")
//			end if
//			dw_item.filter()
//			ll_rowcount	= dw_item.rowcount()
//
//			for li_subcnt = 1 to ll_rowcount
//				if li_pay_opt = 1 then
//					if li_jikjong = 4 then
//						ls_suname1[li_subcnt] = dw_item.getitemstring(li_subcnt, 'item_name')
//					elseif li_jikjong = 5 then
//						ls_suname2[li_subcnt] = dw_item.getitemstring(li_subcnt, 'item_name')
//					else					
//						ls_suname3[li_subcnt] = dw_item.getitemstring(li_subcnt, 'item_name')
//					end if
//					ls_filter = "if ( jikjong_code = 4, '" + ls_suname1[li_subcnt] + "', if ( jikjong_code = 5, '" + ls_suname2[li_subcnt] + "', '" + ls_suname3[li_subcnt] + "'))	"
//				else
//					if li_jikjong = 4 then
//						ls_goname1[li_subcnt] = dw_item.getitemstring(li_subcnt, 'item_name')
//					elseif li_jikjong = 5 then
//						ls_goname2[li_subcnt] = dw_item.getitemstring(li_subcnt, 'item_name')
//					else					
//						ls_goname3[li_subcnt] = dw_item.getitemstring(li_subcnt, 'item_name')
//					end if
//					ls_filter = "if ( jikjong_code = 4, '" + ls_goname1[li_subcnt] + "', if ( jikjong_code = 5, '" + ls_goname2[li_subcnt] + "', '" + ls_goname3[li_subcnt] + "'))	"
//				end if					
//				modify(ls_title[li_pay_opt] + '_' + string(li_subcnt) + "_t.expression = ~"" + ls_filter + "~"	")
////				modify(ls_title[li_pay_opt] + '_' + string(li_subcnt) + "_t.expression = ~"'" + dw_item.getitemstring(li_subcnt, 'item_name') + "'~"	")
//			next
//		end if
////		ls_member_no = getitemstring(li_cnt, 'member_no')
////		
////		ll_rowcount	=	dw_amt.retrieve(is_yearmonth, ls_member_no, string(li_pay_opt))
////		
////		for li_subcnt = 1 to ll_rowcount
////			if dw_amt.getitemstring(li_subcnt, 'code') = '03' then
////				setitem(li_cnt, 'sang_amt', dw_amt.getitemnumber(li_subcnt, 'amt'))
////			end if
////			setitem(li_cnt, ls_title[li_pay_opt] + '_' + string(dw_amt.getitemnumber(li_subcnt, 'sort')), dw_amt.getitemnumber(li_subcnt, 'amt'))
////		next
//	next
//	st_count.text = '건수 : ' + string(li_cnt, '#,##0')
//next
//
end event

event constructor;call super::constructor;this.uf_setClick(false)
end event

type gb_5 from groupbox within tabpage_sheet02
integer y = -20
integer width = 4343
integer height = 184
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
end type

type uo_4 from cuo_search_insa within tabpage_sheet02
integer x = 114
integer y = 40
integer width = 3566
integer taborder = 60
boolean bringtotop = true
end type

on uo_4.destroy
call cuo_search_insa::destroy
end on

type st_count from statictext within tabpage_sheet02
integer x = 3264
integer y = 52
integer width = 530
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "건수 : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_dept_code from cuo_dept within w_hpa307a
event destroy ( )
integer x = 1554
integer y = 176
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

on uo_dept_code.destroy
call cuo_dept::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_dept_code = uf_getcode()


end event

type uo_yearmonth from cuo_yearmonth within w_hpa307a
integer x = 119
integer y = 180
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yearmonth	=	uf_getyearmonth()

wf_confirm_gbn()


end event

type dw_head from datawindow within w_hpa307a
integer x = 3058
integer y = 180
integer width = 699
integer height = 80
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) or trim(data) = '0' or trim(data) = '' then	
	ii_str_jikjong	=	0
	ii_end_jikjong	=	9
else
	ii_str_jikjong = integer(trim(data))
	ii_end_jikjong = integer(trim(data))
end if



end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type st_1 from statictext within w_hpa307a
integer x = 2821
integer y = 192
integer width = 206
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "직종명"
boolean focusrectangle = false
end type

type dw_display_title from cuo_display_title within w_hpa307a
boolean visible = false
integer x = 2098
integer y = 144
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;settransobject(sqlca)

end event

type dw_etc from datawindow within w_hpa307a
boolean visible = false
integer x = 1541
integer y = 148
integer width = 411
integer height = 432
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa307a_1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type ddlb_chasu from dropdownlistbox within w_hpa307a
integer x = 1157
integer y = 180
integer width = 311
integer height = 484
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "none"
string item[] = {"1차","2차","3차","4차","5차"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;is_Chasu = string(index)
end event

type st_2 from statictext within w_hpa307a
integer x = 965
integer y = 192
integer width = 169
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "차수"
alignment alignment = right!
boolean focusrectangle = false
end type

