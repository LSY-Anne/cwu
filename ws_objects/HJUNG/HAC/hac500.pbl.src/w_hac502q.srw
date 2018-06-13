$PBExportHeader$w_hac502q.srw
$PBExportComments$부서별 예산사용 현황 조회
forward
global type w_hac502q from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
end forward

global type w_hac502q from w_tabsheet
string title = "요구기간 관리/출력"
end type
global w_hac502q w_hac502q

type variables
datawindow	idw_list






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
string   ls_gwa_name, ls_bdgt_year, ls_gwa
integer	li_tab

li_tab  = tab_sheet.selectedtab



dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1],'yyyy')
ls_gwa = dw_con.object.code[1]

if idw_list.retrieve(ls_bdgt_year, ls_gwa, gi_acct_class) > 0 then
	idw_print.retrieve(ls_bdgt_year, ls_gwa, gi_acct_class)
	ls_gwa_name = dw_con.Describe("Evaluate('LookUpDisplay(code)', 1)")
	idw_print.modify("unit_gwa.text = '" + ls_gwa_name + "'")

else
	idw_print.reset()
end if

return 0
end function

on w_hac502q.create
int iCurrent
call super::create
end on

on w_hac502q.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;// ==========================================================================================
// 작성목정 : data retrieve
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

//f_setpointer('START')
wf_retrieve()
//f_setpointer('END')
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
//
//
//
//// 요구부서
//dw_con.getchild('code', ldw_child)
//ldw_child.settransobject(sqlca)
//if ldw_child.retrieve(1,3) < 1 then
//	ldw_child.insertrow(0)
//end if
//
//
//
//
//dw_con.setitem(1, 'code', gs_deptcode)
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



// 요구부서
dw_con.getchild('code', ldw_child)
ldw_child.settransobject(sqlca)
if ldw_child.retrieve(1,3) < 1 then
	ldw_child.insertrow(0)
end if




dw_con.setitem(1, 'code', gs_deptcode)


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

type ln_templeft from w_tabsheet`ln_templeft within w_hac502q
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac502q
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac502q
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac502q
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac502q
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac502q
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac502q
end type

type uc_insert from w_tabsheet`uc_insert within w_hac502q
end type

type uc_delete from w_tabsheet`uc_delete within w_hac502q
end type

type uc_save from w_tabsheet`uc_save within w_hac502q
end type

type uc_excel from w_tabsheet`uc_excel within w_hac502q
end type

type uc_print from w_tabsheet`uc_print within w_hac502q
end type

type st_line1 from w_tabsheet`st_line1 within w_hac502q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac502q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac502q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac502q
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac502q
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac502q
integer y = 320
integer width = 4379
integer height = 2244
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
integer width = 4343
integer height = 2124
long backcolor = 1073741824
string text = "예산배정현황"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer width = 101
integer height = 100
string dataobject = "d_hac502q_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 0
integer width = 4343
integer height = 1852
string dataobject = "d_hac502q_1"
end type

type uo_tab from w_tabsheet`uo_tab within w_hac502q
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac502q
string dataobject = "d_hac501a_con"
end type

event dw_con::constructor;call super::constructor;this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
This.object.year_t.text = '예산년도'
This.object.slip_class.visible = false

end event

type st_con from w_tabsheet`st_con within w_hac502q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4343
integer height = 2124
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
integer height = 1836
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac502q_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

