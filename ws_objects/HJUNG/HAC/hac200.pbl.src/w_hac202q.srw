$PBExportHeader$w_hac202q.srw
$PBExportComments$단위부서예산배정현황/출력
forward
global type w_hac202q from w_tabsheet
end type
type uo_1 from cuo_search within tabpage_sheet01
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
type uo_acct_class from cuo_acct_class within w_hac202q
end type
end forward

global type w_hac202q from w_tabsheet
string title = "요구기간 관리/출력"
uo_acct_class uo_acct_class
end type
global w_hac202q w_hac202q

type variables
datawindow	idw_list

string		is_bdgt_year
string		is_gwa
integer		ii_acct_class
end variables

forward prototypes
public function integer wf_retrieve ()
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
string   ls_gwa_name
integer	li_tab

li_tab  = tab_sheet.selectedtab


dw_con.accepttext()
is_bdgt_year = string(dw_con.object.year[1], 'yyyy')
is_gwa = dw_con.object.code[1]

if idw_list.retrieve(is_bdgt_year, is_gwa, ii_acct_class) > 0 then
	idw_print.retrieve(is_bdgt_year, is_gwa, ii_acct_class)
	ls_gwa_name = dw_con.Describe("Evaluate('LookUpDisplay(code)', 1)")
	idw_print.modify("unit_gwa.text = '" + ls_gwa_name + "'")

else
	idw_print.reset()
end if

return 0
end function

on w_hac202q.create
int iCurrent
call super::create
this.uo_acct_class=create uo_acct_class
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_acct_class
end on

on w_hac202q.destroy
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
//datawindowchild	ldw_child
//
//idw_list		=	tab_sheet.tabpage_sheet01.dw_list001
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//
//tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_list, 'com_acct_code', 'com_acct_name')
//
//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
//ii_acct_class 	= 	uo_acct_class.uf_getcode()
//
//// 요구부서
//dw_gwa.getchild('code', ldw_child)
//ldw_child.settransobject(sqlca)
//if ldw_child.retrieve(1,3) < 1 then
//	ldw_child.insertrow(0)
//end if
//dw_gwa.insertrow(0)
//
//uo_bdgt_year.st_title.text = '예산년도'
//
//if  gi_dept_opt <> 1 and gs_empcode  <> 'F0018' and gs_empcode  <> 'F0083' then
//	dw_gwa.enabled = False
//end if
//
//dw_gwa.setitem(1, 'code', gs_deptcode)
//is_gwa = gs_deptcode
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
//IF idw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, idw_print)
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
datawindowchild	ldw_child

idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_print	=	tab_sheet.tabpage_sheet02.dw_print


tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_list, 'com_acct_code', 'com_acct_name')

//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
ii_acct_class 	= 	uo_acct_class.uf_getcode()

// 요구부서
dw_con.getchild('code', ldw_child)
ldw_child.settransobject(sqlca)
if ldw_child.retrieve(1,3) < 1 then
	ldw_child.insertrow(0)
end if




if  gi_dept_opt <> 1 and gs_empcode  <> 'F0018' and gs_empcode  <> 'F0083' then
	dw_con.object.code.protect = 1
end if

dw_con.setitem(1, 'code', gs_deptcode)
is_gwa = gs_deptcode

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

type ln_templeft from w_tabsheet`ln_templeft within w_hac202q
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac202q
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac202q
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac202q
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac202q
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac202q
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac202q
end type

type uc_insert from w_tabsheet`uc_insert within w_hac202q
end type

type uc_delete from w_tabsheet`uc_delete within w_hac202q
end type

type uc_save from w_tabsheet`uc_save within w_hac202q
end type

type uc_excel from w_tabsheet`uc_excel within w_hac202q
end type

type uc_print from w_tabsheet`uc_print within w_hac202q
end type

type st_line1 from w_tabsheet`st_line1 within w_hac202q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac202q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac202q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac202q
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac202q
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac202q
integer y = 320
integer width = 4384
integer height = 1948
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		FALSE)
//	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
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
integer height = 1828
long backcolor = 1073741824
string text = "예산배정현황"
uo_1 uo_1
gb_4 gb_4
end type

on tabpage_sheet01.create
this.uo_1=create uo_1
this.gb_4=create gb_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.gb_4
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.gb_4)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 164
integer width = 101
integer height = 100
string dataobject = "d_hac202q_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return
//
//selectrow(0, false)
//selectrow(currentrow, true)
//
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer y = 168
integer height = 1664
string dataobject = "d_hac202q_1"
end type

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)
//
end event

type uo_tab from w_tabsheet`uo_tab within w_hac202q
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac202q
string dataobject = "d_hac104a_con"
end type

event dw_con::constructor;call super::constructor;this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
is_bdgt_year = left(f_today(), 4)
This.object.code_t.text = '요구부서'
This.object.slip_class.visible = false

end event

event dw_con::itemchanged;call super::itemchanged;dw_con.accepttext()
Choose Case dwo.name
	Case 'year'
		is_bdgt_year = left(data, 4)
	Case 'code'
		is_gwa = trim(data)
	

End Choose
end event

type st_con from w_tabsheet`st_con within w_hac202q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uo_1 from cuo_search within tabpage_sheet01
integer x = 114
integer y = 32
integer width = 3438
integer taborder = 50
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_search::destroy
end on

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

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
string text = "예산배정내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_sheet02.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_sheet02.destroy
destroy(this.dw_print)
end on

type dw_print from cuo_dwprint within tabpage_sheet02
integer width = 4343
integer height = 1824
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac202q_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type uo_acct_class from cuo_acct_class within w_hac202q
event destroy ( )
boolean visible = false
integer x = 27
integer y = 56
integer taborder = 100
boolean bringtotop = true
long backcolor = 1073741824
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;ii_acct_class	=	uf_getcode()

end event

