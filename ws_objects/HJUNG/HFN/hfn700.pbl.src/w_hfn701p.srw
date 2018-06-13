$PBExportHeader$w_hfn701p.srw
$PBExportComments$예탁금명세서
forward
global type w_hfn701p from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_list002 from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_list002 dw_list002
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type dw_list003 from cuo_dwprint within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_list003 dw_list003
end type
type tabpage_sheet04 from userobject within tab_sheet
end type
type dw_list004 from cuo_dwprint within tabpage_sheet04
end type
type tabpage_sheet04 from userobject within tab_sheet
dw_list004 dw_list004
end type
end forward

global type w_hfn701p from w_tabsheet
string title = "어음 등록/출력"
end type
global w_hfn701p w_hfn701p

type variables
datawindowchild	idw_child
datawindow			idw_print1, idw_print2, idw_print3, idw_print4





end variables

forward prototypes
public function integer wf_retrieve ()
public subroutine wf_getchild ()
end prototypes

public function integer wf_retrieve ();// ==========================================================================================
// 기    능	:	Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_retrieve()	returns	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_year, ls_date

dw_con.accepttext()
ls_date = string(dw_con.object.date[1], 'yyyymmdd')

select	bdgt_year
into		:ls_year
from		acdb.hac003m
where		:ls_date between from_date and to_date
and		bdgt_class = 0
and		stat_class = 0	;


if idw_print1.retrieve(gi_acct_class, ls_year, ls_date) > 0 then
	idw_print2.retrieve(gi_acct_class, ls_year, ls_date)
	idw_print3.retrieve(gi_acct_class, ls_year, ls_date)
	idw_print4.retrieve(gi_acct_class, ls_year, ls_date)
	

else
	idw_print1.reset()
	idw_print2.reset()
	idw_print3.reset()
	idw_print4.reset()
end if

return 0
end function

public subroutine wf_getchild ();// ==========================================================================================
// 기    능	:	DatawindowChild Getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
// 은행명
idw_print1.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
idw_print2.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
idw_print3.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
idw_print4.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 회계구분
idw_print4.getchild('acct_gubun', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('acct_gubun', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 자금구분
idw_print1.getchild('jagum_gubun', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jagum_gubun', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 예금종류
idw_print1.getchild('depo_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('depo_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
idw_print2.getchild('depo_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('depo_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
idw_print3.getchild('depo_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('depo_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
idw_print4.getchild('depo_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('depo_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

on w_hfn701p.create
int iCurrent
call super::create
end on

on w_hfn701p.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////
String ls_date
dw_con.accepttext()
ls_date = String(dw_con.object.date[1], 'yyyymmdd')
if not isdate(String(ls_date, '@@@@/@@/@@')) then
	messagebox('확인', '조회일자를 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('date')
	return -1
end if


wf_retrieve()
return 1
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
//
//idw_print1	  =	tab_sheet.tabpage_sheet01.dw_list001
//idw_print2	  =	tab_sheet.tabpage_sheet02.dw_list002
//idw_print3	  =	tab_sheet.tabpage_sheet03.dw_list003
//idw_print4	  =	tab_sheet.tabpage_sheet04.dw_list004
//
//
////ii_acct_class =	uo_acct_class.uf_getcode()
//
//ls_sysdate = f_today()
//
//dw_con.object.date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))
//
//wf_getchild()
//
//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		TRUE)
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

idw_print1	  =	tab_sheet.tabpage_sheet01.dw_list001
idw_print2	  =	tab_sheet.tabpage_sheet02.dw_list002
idw_print3	  =	tab_sheet.tabpage_sheet03.dw_list003
idw_print4	  =	tab_sheet.tabpage_sheet04.dw_list004

idw_print = idw_print1

//ii_acct_class =	uo_acct_class.uf_getcode()

ls_sysdate = f_today()

dw_con.object.date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))

wf_getchild()

//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		TRUE)

end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
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

type ln_templeft from w_tabsheet`ln_templeft within w_hfn701p
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hfn701p
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hfn701p
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hfn701p
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hfn701p
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hfn701p
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hfn701p
end type

type uc_insert from w_tabsheet`uc_insert within w_hfn701p
end type

type uc_delete from w_tabsheet`uc_delete within w_hfn701p
end type

type uc_save from w_tabsheet`uc_save within w_hfn701p
end type

type uc_excel from w_tabsheet`uc_excel within w_hfn701p
end type

type uc_print from w_tabsheet`uc_print within w_hfn701p
end type

type st_line1 from w_tabsheet`st_line1 within w_hfn701p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hfn701p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hfn701p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hfn701p
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hfn701p
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hfn701p
integer y = 332
integer width = 4384
integer height = 2244
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

event tab_sheet::selectionchanged;call super::selectionchanged;If newindex = 1 Then
	idw_print = idw_print1
Elseif newindex = 2 Then
	idw_print = idw_print2
Elseif newindex = 3 Then
	idw_print = idw_print3
Else
	idw_print = idw_print4
End If
end event

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
integer y = 104
integer width = 4347
integer height = 2124
long backcolor = 1073741824
string text = "자금종류별"
gb_4 gb_4
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
integer width = 4343
integer height = 1840
string dataobject = "d_hfn701p_2"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event dw_list001::constructor;call super::constructor;this.Modify("DataWindow.Print.Preview='yes'")

end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
boolean visible = false
integer y = 1048
integer width = 288
integer height = 784
end type

type uo_tab from w_tabsheet`uo_tab within w_hfn701p
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hfn701p
string dataobject = "d_hfn701p_con"
end type

type st_con from w_tabsheet`st_con within w_hfn701p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_4 from groupbox within tabpage_sheet01
boolean visible = false
integer y = -20
integer width = 3845
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
integer height = 2124
string text = "만기(월)별"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list002 dw_list002
end type

on tabpage_sheet02.create
this.dw_list002=create dw_list002
this.Control[]={this.dw_list002}
end on

on tabpage_sheet02.destroy
destroy(this.dw_list002)
end on

type dw_list002 from cuo_dwprint within tabpage_sheet02
integer width = 4343
integer height = 1836
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hfn701p_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet03 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2124
string text = "예금종류별"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list003 dw_list003
end type

on tabpage_sheet03.create
this.dw_list003=create dw_list003
this.Control[]={this.dw_list003}
end on

on tabpage_sheet03.destroy
destroy(this.dw_list003)
end on

type dw_list003 from cuo_dwprint within tabpage_sheet03
integer width = 4338
integer height = 1836
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hfn701p_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet04 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2124
string text = "예치기관별"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list004 dw_list004
end type

on tabpage_sheet04.create
this.dw_list004=create dw_list004
this.Control[]={this.dw_list004}
end on

on tabpage_sheet04.destroy
destroy(this.dw_list004)
end on

type dw_list004 from cuo_dwprint within tabpage_sheet04
integer width = 4357
integer height = 1836
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hfn701p_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

