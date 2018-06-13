$PBExportHeader$w_hfn109a.srw
$PBExportComments$차입금 관리/출력
forward
global type w_hfn109a from w_tabsheet
end type
type gb_6 from groupbox within tabpage_sheet01
end type
type uo_3 from cuo_search within tabpage_sheet01
end type
type dw_update from uo_dwfree within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_list002 from uo_dwgrid within tabpage_sheet02
end type
type gb_5 from groupbox within tabpage_sheet02
end type
type uo_4 from cuo_search within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_list002 dw_list002
gb_5 gb_5
uo_4 uo_4
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_print dw_print
end type
end forward

global type w_hfn109a from w_tabsheet
string title = "어음 등록/출력"
end type
global w_hfn109a w_hfn109a

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data, idw_preview,  idw_list_3, idw_list_4



end variables

forward prototypes
public function integer wf_dup_chk (long al_row, string as_loan_no)
public subroutine wf_dwcopy ()
public function integer wf_retrieve ()
public subroutine wf_setitem (string as_colname, string as_data)
public subroutine wf_getchild ()
end prototypes

public function integer wf_dup_chk (long al_row, string as_loan_no);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dup_chk(long al_row, string as_notes_no) return integer
// 인    수 :	al_row : 현재행, as_notes_no : 현재 수표어음번호
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long	ll_row

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	FNDB.HFN005M
WHERE		LOAN_NO = :AS_LOAN_NO ;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 차입번호입니다.')
	return 1
end if

ll_row = idw_list.find("loan_no = '" + as_loan_no + "'", 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 차입번호입니다.')
	return 1
end if

ll_row = idw_list.find("loan_no = '" + as_loan_no + "'", al_row + 1, idw_list.rowcount())

if ll_row > 0 then
	messagebox('확인', '이미 등록된 차입번호입니다.')
	return 1
end if

return 0
end function

public subroutine wf_dwcopy ();// ==========================================================================================
// 기    능	:	Datawindow Copy
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dwcopy()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_val[]
long		ll_row

ll_row	=	idw_list.getrow()

idw_data.reset()

if ll_row < 1 then	return

idw_list.rowscopy(ll_row, ll_row, primary!, idw_data, 1, primary!) 

end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능	:	Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_retrieve()	returns	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_name
integer	li_tab
long		ll_row
Integer 	li_loan_class

li_tab  = tab_sheet.selectedtab

wf_getchild()

dw_con.accepttext()

li_loan_class = Integer(dw_con.object.code[1])

idw_list.setredraw(false)

ll_row	=	idw_list.getrow()
if idw_list.retrieve(gi_acct_class, li_loan_class) > 0 then
	idw_list.scrolltorow(ll_row)
	idw_preview.retrieve(gi_acct_class, li_loan_class)
	if idw_print.retrieve(gi_acct_class, li_loan_class) > 0 then
//		DateTime	ldt_SysDateTime
//		ldt_SysDateTime = f_sysdate()	//시스템일자
//		idw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//		idw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

	end if
else
	idw_preview.reset()
	idw_print.reset()
end if

idw_list.setredraw(true)

return 0
end function

public subroutine wf_setitem (string as_colname, string as_data);// ==========================================================================================
// 기    능	:	Datawindow Setitem
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_setitem(string as_colname, string as_data)
// 인    수 :	as_colname	-	Column Name
//					as_data		-	Data Value
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_type

ls_type 	= idw_data.describe(as_colname + ".coltype")

idw_data.accepttext()

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(idw_list.getrow(), as_colname, dec(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, dec(as_data))
elseif ls_type = 'date' then
	idw_list.setitem(idw_list.getrow(), as_colname, date(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, date(as_data))
elseif ls_type = 'datetime' then
	idw_list.setitem(idw_list.getrow(), as_colname, datetime(date(left(as_data, 10)), time(right(as_data, 8))))
	idw_data.setitem(idw_data.getrow(), as_colname, datetime(date(left(as_data, 10)), time(right(as_data, 8))))
else	
	idw_list.setitem(idw_list.getrow(), as_colname, trim(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, trim(as_data))
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
// 차입구분
idw_list.getchild('loan_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('loan_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_data.getchild('loan_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('loan_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('loan_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('loan_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('loan_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('loan_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 차입은행
idw_data.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
idw_child.setsort('code')
idw_child.sort()

idw_preview.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

on w_hfn109a.create
int iCurrent
call super::create
end on

on w_hfn109a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

integer	li_newrow, li_newrow2
Integer 	li_loan_class

dw_con.accepttext()
li_loan_class = Integer(dw_con.object.code[1])

//idw_data.Selectrow(0, false)	

idw_data.reset()
li_newrow	=	1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

li_newrow2 	=	idw_list.getrow() + 1
idw_list.insertrow(li_newrow2)
idw_list.setrow(li_newrow2)

idw_data.setitem(li_newrow, 'acct_class',		gi_acct_class)
if li_loan_class <> 0 then
	idw_data.setitem(li_newrow, 'loan_class',	li_loan_class)
end if
idw_data.setitem(li_newrow, 'use_yn',		'N')
idw_data.setitem(li_newrow, 'worker',			gs_empcode)
idw_data.setitem(li_newrow, 'ipaddr',			gs_ip)
idw_data.setitem(li_newrow, 'work_date',		f_sysdate())

idw_list.setitem(li_newrow2, 'acct_class',		gi_acct_class)
if li_loan_class <> 0 then
	idw_list.setitem(li_newrow2, 'loan_class',	li_loan_class)
end if
idw_list.setitem(li_newrow2, 'use_yn',		'N')
idw_list.setitem(li_newrow2, 'worker',			gs_empcode)
idw_list.setitem(li_newrow2, 'ipaddr',			gs_ip)
idw_list.setitem(li_newrow2, 'work_date',		f_sysdate())

idw_data.setcolumn('loan_no')
idw_data.setfocus()


end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.11
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//string	ls_sysdate
//Integer 	li_loan_class
//
//dw_con.accepttext()
//li_loan_class = Integer(dw_con.object.code[1])
//
//idw_list		  =	tab_sheet.tabpage_sheet01.dw_list001
//idw_data		  =	tab_sheet.tabpage_sheet01.dw_update
//idw_preview	  =	tab_sheet.tabpage_sheet02.dw_list002
//idw_print	  =	tab_sheet.tabpage_sheet03.dw_print
//ist_back		  =	tab_sheet.tabpage_sheet03.st_back
//
//gi_acct_class =	uo_acct_class.uf_getcode()
//
//wf_getchild()
//
//f_getdwcommon(dw_head, 'loan_class', 0, 730)
//dw_head.setitem(1, 'code', '0')
//li_loan_class = 0
//
//tab_sheet.tabpage_sheet01.uo_3.st_remark.text = '차입번호 또는 차입금명으로 자료를 조회합니다.'
//tab_sheet.tabpage_sheet01.uo_3.rb_1.text		 =	'차입번호'
//tab_sheet.tabpage_sheet01.uo_3.rb_2.text		 =	'차입금명'
//tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'loan_no', 'loan_name')
//
//tab_sheet.tabpage_sheet02.uo_4.st_remark.text = '차입번호 또는 차입금명으로 자료를 조회합니다.'
//tab_sheet.tabpage_sheet02.uo_4.rb_1.text		 =	'차입번호'
//tab_sheet.tabpage_sheet02.uo_4.rb_2.text		 =	'차입금명'
//tab_sheet.tabpage_sheet02.uo_4.uf_reset(idw_preview, 'loan_no', 'loan_name')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

cuo_dwwindow	dw_name
integer	li_findrow
string	ls_null[]
long		ll_row

idw_list.accepttext()

if idw_list.modifiedcount() < 1 and idw_list.deletedcount() < 1 then
	wf_SetMsg('변경된 자료가 없습니다.')
	return -1
end if

ls_null[1] = 'loan_no/차입번호'
ls_null[2] = 'loan_class/차입구분'

if f_chk_null(idw_list, ls_null) = -1 then	return -1



dw_name   = idw_list  	                 		//저장하고자하는 데이타 원도우

IF dw_name.Update(true) = 1 THEN
 	COMMIT;
	triggerevent('ue_retrieve')
ELSE
  ROLLBACK;
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

li_deleterow	=	idw_list.deleterow(0)
wf_dwcopy()

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

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
string	ls_sysdate

idw_list		  =	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		  =	tab_sheet.tabpage_sheet01.dw_update
idw_preview	  =	tab_sheet.tabpage_sheet02.dw_list002
idw_print	  =	tab_sheet.tabpage_sheet03.dw_print


wf_getchild()
func.of_design_dw(idw_data)
idw_data.insertrow(0)


f_getdwcommon(dw_con, 'loan_class', 0, 730)
dw_con.setitem(1, 'code', '0')


tab_sheet.tabpage_sheet01.uo_3.st_remark.text = '차입번호 또는 차입금명으로 자료를 조회합니다.'
tab_sheet.tabpage_sheet01.uo_3.rb_1.text		 =	'차입번호'
tab_sheet.tabpage_sheet01.uo_3.rb_2.text		 =	'차입금명'
tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'loan_no', 'loan_name')

tab_sheet.tabpage_sheet02.uo_4.st_remark.text = '차입번호 또는 차입금명으로 자료를 조회합니다.'
tab_sheet.tabpage_sheet02.uo_4.rb_1.text		 =	'차입번호'
tab_sheet.tabpage_sheet02.uo_4.rb_2.text		 =	'차입금명'
tab_sheet.tabpage_sheet02.uo_4.uf_reset(idw_preview, 'loan_no', 'loan_name')

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

type ln_templeft from w_tabsheet`ln_templeft within w_hfn109a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hfn109a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hfn109a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hfn109a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hfn109a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hfn109a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hfn109a
end type

type uc_insert from w_tabsheet`uc_insert within w_hfn109a
end type

type uc_delete from w_tabsheet`uc_delete within w_hfn109a
end type

type uc_save from w_tabsheet`uc_save within w_hfn109a
end type

type uc_excel from w_tabsheet`uc_excel within w_hfn109a
end type

type uc_print from w_tabsheet`uc_print within w_hfn109a
end type

type st_line1 from w_tabsheet`st_line1 within w_hfn109a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hfn109a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hfn109a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hfn109a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hfn109a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hfn109a
integer y = 324
integer width = 4384
integer height = 1992
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
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
	case	else
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
integer width = 4347
integer height = 1872
long backcolor = 1073741824
string text = "차입금 관리"
gb_6 gb_6
uo_3 uo_3
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_6=create gb_6
this.uo_3=create uo_3
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_6
this.Control[iCurrent+2]=this.uo_3
this.Control[iCurrent+3]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_6)
destroy(this.uo_3)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 164
integer width = 101
integer height = 100
string dataobject = "d_hfn109a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;if currentrow < 1 then	return

//selectrow(0, false)
//selectrow(currentrow, true)

wf_dwcopy()


end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(1)

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 164
integer width = 2167
integer height = 1708
string dataobject = "d_hfn109a_1"
boolean hsplitscroll = true
end type

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	idw_data.insertrow(0)
	return
end if

trigger event rowfocuschanged(1)
end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then	return

//selectrow(0, false)
//selectrow(currentrow, true)
//
wf_dwcopy()


end event

type uo_tab from w_tabsheet`uo_tab within w_hfn109a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hfn109a
string dataobject = "d_hfn104a_con"
end type

event dw_con::constructor;call super::constructor;This.object.code_t.text = '차입구분'
end event

event dw_con::itemchanged;call super::itemchanged;//parent.triggerevent('ue_retrieve')

end event

event dw_con::itemfocuschanged;call super::itemfocuschanged;//triggerevent(itemchanged!)
end event

type st_con from w_tabsheet`st_con within w_hfn109a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_6 from groupbox within tabpage_sheet01
integer y = -20
integer width = 4347
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

type uo_3 from cuo_search within tabpage_sheet01
event destroy ( )
integer x = 114
integer y = 40
integer width = 3566
integer taborder = 80
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search::destroy
end on

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 2181
integer y = 164
integer width = 2167
integer height = 1708
integer taborder = 30
string dataobject = "d_hfn109a_2"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;s_insa_com	lstr_com
string		ls_col, ls_type
string		ls_jumin_no, ls_income_name, ls_income_juso, ls_data
long			ll_row, ll_cnt

ll_row	=	idw_list.getrow()

choose case dwo.name
	case 'loan_no'
		if wf_dup_chk(row, data) > 0 then
			setitem(row, 'loan_no', '')
			return 1
		end if
end choose

ls_col 	= dwo.name
ls_type 	= describe(ls_col + ".coltype")

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(ll_row, ls_col, dec(data))
elseif ls_type = 'datetime' then
	idw_list.setitem(ll_row, ls_col, date(left(data,10)))
else	
	idw_list.setitem(ll_row, ls_col, data)
end if

idw_list.setitem(ll_row, 'job_uid',		gs_empcode)
idw_list.setitem(ll_row, 'job_add',		gs_ip)
idw_list.setitem(ll_row, 'job_date',	f_sysdate())

end event

event itemerror;call super::itemerror;return 1
end event

event losefocus;call super::losefocus;accepttext()
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
string text = "차입금 조회"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list002 dw_list002
gb_5 gb_5
uo_4 uo_4
end type

on tabpage_sheet02.create
this.dw_list002=create dw_list002
this.gb_5=create gb_5
this.uo_4=create uo_4
this.Control[]={this.dw_list002,&
this.gb_5,&
this.uo_4}
end on

on tabpage_sheet02.destroy
destroy(this.dw_list002)
destroy(this.gb_5)
destroy(this.uo_4)
end on

type dw_list002 from uo_dwgrid within tabpage_sheet02
integer y = 168
integer width = 4347
integer height = 1708
integer taborder = 30
string dataobject = "d_hfn109a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_5 from groupbox within tabpage_sheet02
integer y = -20
integer width = 4352
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

type uo_4 from cuo_search within tabpage_sheet02
event destroy ( )
integer x = 114
integer y = 40
integer width = 3566
integer taborder = 90
boolean bringtotop = true
end type

on uo_4.destroy
call cuo_search::destroy
end on

type tabpage_sheet03 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1872
string text = "차입금 내역"
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
integer height = 1876
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hfn109a_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

