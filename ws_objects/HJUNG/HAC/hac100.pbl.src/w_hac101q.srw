$PBExportHeader$w_hac101q.srw
$PBExportComments$계정과목 조회/출력
forward
global type w_hac101q from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_1 from cuo_search within tabpage_sheet01
end type
type dw_list003 from cuo_dwwindow within tabpage_sheet01
end type
type dw_update from uo_dwfree within tabpage_sheet01
end type
type dw_list004 from uo_dwgrid within tabpage_sheet01
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
type dw_print1 from cuo_dwprint within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_print1 dw_print1
end type
type tabpage_sheet04 from userobject within tab_sheet
end type
type dw_print2 from cuo_dwprint within tabpage_sheet04
end type
type tabpage_sheet04 from userobject within tab_sheet
dw_print2 dw_print2
end type
type uo_acct_class from cuo_acct_class within w_hac101q
end type
end forward

global type w_hac101q from w_tabsheet
integer height = 2616
string title = "계정과목 조회/출력"
uo_acct_class uo_acct_class
end type
global w_hac101q w_hac101q

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data, idw_list2, idw_print3, idw_print4
datawindow			idw_remark1, idw_remark2

integer				ii_acct_class

end variables

forward prototypes
public function integer wf_retrieve ()
public subroutine wf_setitem (string as_colname, string as_data)
public subroutine wf_dwcopy ()
public subroutine wf_find ()
public subroutine wf_getchild ()
end prototypes

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

//f_setpointer('START')

li_tab  = tab_sheet.selectedtab


if idw_list.retrieve(ii_acct_class) > 0 then
	idw_list2.retrieve(ii_acct_class)

	idw_print3.retrieve(ii_acct_class)

	
	idw_print4.retrieve(ii_acct_class)

	
	tab_sheet.tabpage_sheet01.uo_1.sle_name.setfocus()
else
	idw_list2.reset()
	idw_print3.reset()
	idw_print4.reset()
	
	uo_acct_class.dw_commcode.setfocus()
end if

return 0
end function

public subroutine wf_setitem (string as_colname, string as_data);// ==========================================================================================
// 기    능 :	datawindow setitem
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_setitem(string as_colname, string as_data)
// 인    수 : 	as_colname 	- 	column name
//				  	as_data		-	data
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

public subroutine wf_dwcopy ();// ==========================================================================================
// 기    능 : 	데이타윈도우에 값을 넣는다.
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
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

ll_row = idw_list.rowscopy(ll_row, ll_row, primary!, idw_data, 1, primary!) 

end subroutine

public subroutine wf_find ();// ==========================================================================================
// 기    능 : 	Find
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_find()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long		ll_row
string	ls_acct_code

if idw_list.rowcount() < 1 then	return

ls_acct_code = idw_list.getitemstring(idw_list.getrow(), 'acct_code')

ll_row = idw_remark1.find("acct_code = '" + ls_acct_code + "'	", 1, idw_remark1.rowcount())

if ll_row < 1 then
	ll_row = idw_remark1.insertrow(0)
	idw_remark1.scrolltorow(ll_row)
	idw_remark1.setitem(ll_row, 'acct_code', ls_acct_code)
	
	idw_remark2.reset()
	idw_remark2.insertrow(0)
	idw_remark2.setitem(1, 'acct_code', ls_acct_code)
else
	idw_remark1.scrolltorow(ll_row)
	idw_remark2.reset()
	idw_remark2.insertrow(0)
	idw_remark2.setitem(1, 'acct_code', 	ls_acct_code)
	idw_remark2.setitem(1, 'acct_explain',	idw_remark1.getitemstring(ll_row, 'acct_explain'))
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

// 보조부관리항목
idw_data.getchild('mana_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 차변관리항목1
idw_data.getchild('dr_mana_code1', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 차변관리항목2
idw_data.getchild('dr_mana_code2', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 차변관리항목3
idw_data.getchild('dr_mana_code3', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 차변관리항목4
idw_data.getchild('dr_mana_code4', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 대변관리항목1
idw_data.getchild('cr_mana_code1', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 대변관리항목2
idw_data.getchild('cr_mana_code2', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 대변관리항목3
idw_data.getchild('cr_mana_code3', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 대변관리항목4
idw_data.getchild('cr_mana_code4', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

end subroutine

on w_hac101q.create
int iCurrent
call super::create
this.uo_acct_class=create uo_acct_class
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_acct_class
end on

on w_hac101q.destroy
call super::destroy
destroy(this.uo_acct_class)
end on

event ue_retrieve;call super::ue_retrieve;// ==========================================================================================
// 작성목정 : data retrieve
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================


wf_retrieve()

return 1
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 : window open
//// 작 성 인 : 이현수
//// 작성일자 : 2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_list		=	tab_sheet.tabpage_sheet01.dw_list001
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_list2	=	tab_sheet.tabpage_sheet02.dw_list002
//idw_print3	=	tab_sheet.tabpage_sheet03.dw_print1
//ist_back3	=	tab_sheet.tabpage_sheet03.st_back1
//idw_print4	=	tab_sheet.tabpage_sheet04.dw_print2
//ist_back4	=	tab_sheet.tabpage_sheet04.st_back2
//
//idw_remark1	=	tab_sheet.tabpage_sheet01.dw_list003
//idw_remark2	=	tab_sheet.tabpage_sheet01.dw_list004
//
//ii_acct_class = uo_acct_class.uf_getcode()
//
//wf_getchild()
//
//tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_list, 'acct_code', 'acct_name')
//tab_sheet.tabpage_sheet02.uo_2.uf_reset(idw_list2, 'acct_code', 'acct_name')
//
//tab_sheet.selectedtab = 1
//
end event

event ue_print;call super::ue_print;//// ==========================================================================================
//// 작성목정 : data print
//// 작 성 인 : 이현수
//// 작성일자 : 2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//choose	case	tab_sheet.selectedtab
//	case	3
//		IF idw_print3.RowCount() < 1 THEN	return
//
//		OpenWithParm(w_printoption, idw_print3)
//	case else
//		IF idw_print4.RowCount() < 1 THEN	return
//
//		OpenWithParm(w_printoption, idw_print4)
//end choose			
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 : window open
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_list2	=	tab_sheet.tabpage_sheet02.dw_list002
idw_print3	=	tab_sheet.tabpage_sheet03.dw_print1
idw_print = idw_print3

idw_print4	=	tab_sheet.tabpage_sheet04.dw_print2


idw_remark1	=	tab_sheet.tabpage_sheet01.dw_list003
idw_remark2	=	tab_sheet.tabpage_sheet01.dw_list004

ii_acct_class = uo_acct_class.uf_getcode()

wf_getchild()

tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_list, 'acct_code', 'acct_name')
tab_sheet.tabpage_sheet02.uo_2.uf_reset(idw_list2, 'acct_code', 'acct_name')

tab_sheet.selectedtab = 1

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

type ln_templeft from w_tabsheet`ln_templeft within w_hac101q
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac101q
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac101q
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac101q
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac101q
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac101q
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac101q
end type

type uc_insert from w_tabsheet`uc_insert within w_hac101q
end type

type uc_delete from w_tabsheet`uc_delete within w_hac101q
end type

type uc_save from w_tabsheet`uc_save within w_hac101q
end type

type uc_excel from w_tabsheet`uc_excel within w_hac101q
end type

type uc_print from w_tabsheet`uc_print within w_hac101q
end type

type st_line1 from w_tabsheet`st_line1 within w_hac101q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hac101q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hac101q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac101q
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac101q
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac101q
integer y = 188
integer width = 4384
integer height = 2156
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
tabpage_sheet04 tabpage_sheet04
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//
choose case newindex
	case 1
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('PRINT',		FALSE)
		idw_print = idw_print3
		
	case 2
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('PRINT',		FALSE)
		idw_print = idw_print3
	case else
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('PRINT',		TRUE)
		If newindex = 3 Then
			idw_print = idw_print3
		Else
			idw_print = idw_print4
		End If
end choose
end event

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
this.tabpage_sheet03=create tabpage_sheet03
this.tabpage_sheet04=create tabpage_sheet04
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
this.Control[iCurrent+2]=this.tabpage_sheet03
this.Control[iCurrent+3]=this.tabpage_sheet04
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
destroy(this.tabpage_sheet03)
destroy(this.tabpage_sheet04)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 2036
string text = "계정과목관리"
gb_4 gb_4
uo_1 uo_1
dw_list003 dw_list003
dw_update dw_update
dw_list004 dw_list004
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.uo_1=create uo_1
this.dw_list003=create dw_list003
this.dw_update=create dw_update
this.dw_list004=create dw_list004
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_list003
this.Control[iCurrent+4]=this.dw_update
this.Control[iCurrent+5]=this.dw_list004
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_1)
destroy(this.dw_list003)
destroy(this.dw_update)
destroy(this.dw_list004)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 101
integer height = 100
string dataobject = "d_hac101q_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)
//
wf_dwcopy()
wf_find()


end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	idw_remark2.reset()
	return
end if

idw_remark1.retrieve(ii_acct_class)

trigger event rowfocuschanged(getrow())

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 168
integer width = 1627
integer height = 1832
string dataobject = "d_hac101q_1"
end type

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	idw_remark2.reset()
	return
end if

idw_remark1.retrieve(ii_acct_class)

trigger event rowfocuschanged(getrow())

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)

wf_dwcopy()
wf_find()


end event

type uo_tab from w_tabsheet`uo_tab within w_hac101q
integer x = 1838
integer y = 168
end type

type dw_con from w_tabsheet`dw_con within w_hac101q
boolean visible = false
integer x = 37
integer y = 32
integer width = 498
end type

type st_con from w_tabsheet`st_con within w_hac101q
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type gb_4 from groupbox within tabpage_sheet01
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

type uo_1 from cuo_search within tabpage_sheet01
integer x = 114
integer y = 40
integer width = 3392
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_search::destroy
end on

type dw_list003 from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 2565
integer y = 1916
integer width = 512
integer height = 224
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hac101q_4"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 1641
integer y = 168
integer width = 2706
integer height = 1676
integer taborder = 20
string dataobject = "d_hac101q_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_dw(dw_update)
this.settransobject(sqlca)
end event

type dw_list004 from uo_dwgrid within tabpage_sheet01
integer x = 1641
integer y = 1844
integer width = 2706
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hac101q_4"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;accepttext()

idw_remark1.setitem(idw_remark1.getrow(), 'acct_explain', trim(data))

end event

event losefocus;call super::losefocus;accepttext()
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 2036
long backcolor = 16777215
string text = "계정과목행별조회"
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
integer y = 168
integer width = 4347
integer height = 1824
integer taborder = 20
string dataobject = "d_hac101q_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type gb_5 from groupbox within tabpage_sheet02
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

type uo_2 from cuo_search within tabpage_sheet02
event destroy ( )
integer x = 114
integer y = 40
integer width = 3483
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
integer height = 2036
long backcolor = 16777215
string text = "계정과목약식내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print1 dw_print1
end type

on tabpage_sheet03.create
this.dw_print1=create dw_print1
this.Control[]={this.dw_print1}
end on

on tabpage_sheet03.destroy
destroy(this.dw_print1)
end on

type dw_print1 from cuo_dwprint within tabpage_sheet03
integer y = 12
integer width = 4347
integer height = 2028
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac101q_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet04 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2036
long backcolor = 16777215
string text = "계정과목상세내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print2 dw_print2
end type

on tabpage_sheet04.create
this.dw_print2=create dw_print2
this.Control[]={this.dw_print2}
end on

on tabpage_sheet04.destroy
destroy(this.dw_print2)
end on

type dw_print2 from cuo_dwprint within tabpage_sheet04
integer width = 4347
integer height = 2016
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hac101q_6"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type uo_acct_class from cuo_acct_class within w_hac101q
boolean visible = false
integer x = 55
integer y = 48
integer taborder = 70
boolean bringtotop = true
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

//parent.triggerevent('ue_retrieve')
end event

