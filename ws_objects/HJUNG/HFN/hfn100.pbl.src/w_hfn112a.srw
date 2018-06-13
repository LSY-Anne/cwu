$PBExportHeader$w_hfn112a.srw
$PBExportComments$양식코드 관리/출력
forward
global type w_hfn112a from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
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
type rb_all from radiobutton within w_hfn112a
end type
type rb_hab from radiobutton within w_hfn112a
end type
type rb_un from radiobutton within w_hfn112a
end type
type rb_dae from radiobutton within w_hfn112a
end type
type rb_ja from radiobutton within w_hfn112a
end type
end forward

global type w_hfn112a from w_tabsheet
string title = "재무코드 관리/출력"
rb_all rb_all
rb_hab rb_hab
rb_un rb_un
rb_dae rb_dae
rb_ja rb_ja
end type
global w_hfn112a w_hfn112a

type variables
datawindowchild	idw_child, idw_child2
datawindow			idw_list, idw_data, idw_preview,  idw_list_3, idw_list_4



end variables

forward prototypes
public subroutine wf_dwcopy ()
public subroutine wf_filter (string as_filter)
public subroutine wf_getchild ()
public function integer wf_retrieve ()
public subroutine wf_setitem (string as_colname, string as_data)
end prototypes

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

public subroutine wf_filter (string as_filter);// ==========================================================================================
// 기    능	:	Datawindow Filter
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dwcopy(string as_filter)
// 인    수 :  as_filter
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

idw_preview.setfilter(as_filter)
idw_preview.filter()
idw_preview.setsort('form_code a')
idw_preview.sort()

idw_print.setfilter(as_filter)
idw_print.filter()
idw_print.setsort('hac006m_form_code a')
idw_print.sort()

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
// 출력위치
idw_data.getchild('location', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('location', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('location', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('location', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('location', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('location', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 계산구분
idw_data.getchild('calc_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('calc_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('calc_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('calc_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('calc_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('calc_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

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

tab_sheet.selecttab(1)

rb_all.checked = true
wf_filter("")


idw_list.setredraw(false)

ll_row	=	idw_list.getrow()
if idw_list.retrieve(0) > 0 then
	idw_list.scrolltorow(ll_row)
	idw_preview.retrieve(0)
	if idw_print.retrieve(0) > 0 then
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
// 기    능	:	Data Setitem
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

on w_hfn112a.create
int iCurrent
call super::create
this.rb_all=create rb_all
this.rb_hab=create rb_hab
this.rb_un=create rb_un
this.rb_dae=create rb_dae
this.rb_ja=create rb_ja
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_all
this.Control[iCurrent+2]=this.rb_hab
this.Control[iCurrent+3]=this.rb_un
this.Control[iCurrent+4]=this.rb_dae
this.Control[iCurrent+5]=this.rb_ja
end on

on w_hfn112a.destroy
call super::destroy
destroy(this.rb_all)
destroy(this.rb_hab)
destroy(this.rb_un)
destroy(this.rb_dae)
destroy(this.rb_ja)
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
string	ls_camp_code



//idw_data.Selectrow(0, false)	

idw_data.reset()
li_newrow	=	1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

li_newrow2 	=	idw_list.getrow() + 1
idw_list.insertrow(li_newrow2)
idw_list.setrow(li_newrow2)

wf_setitem('acct', '')
wf_setitem('acct_code', '1')

idw_data.setcolumn('form_code')
idw_data.setfocus()

idw_list.setitem(li_newrow2, 'worker',		gs_empcode)
idw_list.setitem(li_newrow2, 'ipaddr',		gs_ip)
idw_list.setitem(li_newrow2, 'work_date',	f_sysdate())



end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.11
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_list		=	tab_sheet.tabpage_sheet01.dw_list001
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_preview	=	tab_sheet.tabpage_sheet02.dw_list002
//idw_print	=	tab_sheet.tabpage_sheet03.dw_print
//
//wf_getchild()
//
//
////gi_acct_class	=	0
//
//tab_sheet.tabpage_sheet01.uo_3.st_remark.text = '재무코드 또는 재무명으로 자료를 조회합니다.'
//tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'from_code', 'form_name')
//
//tab_sheet.tabpage_sheet02.uo_4.st_remark.text = '재무코드 또는 재무명으로 자료를 조회합니다.'
//tab_sheet.tabpage_sheet02.uo_4.uf_reset(idw_preview, 'from_code', 'form_name')
//
//triggerevent('ue_retrieve')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow



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

idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_preview	=	tab_sheet.tabpage_sheet02.dw_list002
idw_print	=	tab_sheet.tabpage_sheet03.dw_print

func.of_design_dw(idw_data)

wf_getchild()
idw_data.settransobject(sqlca)
idw_data.insertrow(0)

//gi_acct_class	=	0

tab_sheet.tabpage_sheet01.uo_3.st_remark.text = '재무코드 또는 재무명으로 자료를 조회합니다.'
tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'from_code', 'form_name')

tab_sheet.tabpage_sheet02.uo_4.st_remark.text = '재무코드 또는 재무명으로 자료를 조회합니다.'
tab_sheet.tabpage_sheet02.uo_4.uf_reset(idw_preview, 'from_code', 'form_name')

triggerevent('ue_retrieve')

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

type ln_templeft from w_tabsheet`ln_templeft within w_hfn112a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hfn112a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hfn112a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hfn112a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hfn112a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hfn112a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hfn112a
end type

type uc_insert from w_tabsheet`uc_insert within w_hfn112a
end type

type uc_delete from w_tabsheet`uc_delete within w_hfn112a
end type

type uc_save from w_tabsheet`uc_save within w_hfn112a
end type

type uc_excel from w_tabsheet`uc_excel within w_hfn112a
end type

type uc_print from w_tabsheet`uc_print within w_hfn112a
end type

type st_line1 from w_tabsheet`st_line1 within w_hfn112a
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hfn112a
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hfn112a
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hfn112a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hfn112a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hfn112a
integer y = 176
integer width = 4384
integer height = 2152
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//if oldindex	< 0 or newindex < 0	then	return

choose case newindex
	case	1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
		rb_all.visible = false
		rb_hab.visible = false
		rb_un.visible  = false
		rb_dae.visible = false
		rb_ja.visible  = false
	case	else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
		rb_all.visible = true
		rb_hab.visible = true
		rb_un.visible  = true
		rb_dae.visible = true
		rb_ja.visible  = true
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
integer height = 2032
long backcolor = 1073741824
string text = "재무코드관리"
gb_4 gb_4
uo_3 uo_3
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.uo_3=create uo_3
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_3
this.Control[iCurrent+3]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_3)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 101
integer height = 100
string dataobject = "d_hfn112a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then	return

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
integer y = 168
integer width = 1851
integer height = 1856
string dataobject = "d_hfn112a_1"
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

wf_dwcopy()

end event

type uo_tab from w_tabsheet`uo_tab within w_hfn112a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hfn112a
boolean visible = false
integer width = 101
integer height = 12
end type

type st_con from w_tabsheet`st_con within w_hfn112a
long backcolor = 1073741824
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
integer x = 1874
integer y = 168
integer width = 2473
integer height = 1856
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_hfn112a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
string	ls_col, ls_type, ls_used_gbn
long		ll_row
integer	i

ls_col 	= dwo.name
ls_type 	= describe(ls_col + ".coltype")

data	=	trim(data)

ll_row	=	idw_list.getrow()
accepttext()

if dwo.name = 'acct' then
	wf_setitem('acct_code', getitemstring(row, 'acct'))
elseif dwo.name = 'used_gbn_1' or dwo.name = 'used_gbn_2' or dwo.name = 'used_gbn_3' or dwo.name = 'used_gbn_4' or dwo.name = 'used_gbn_5' then
	ls_used_gbn = getitemstring(row, 'used_gbn')
	ls_used_gbn = Replace(ls_used_gbn, integer(right(dwo.name, 1)), 1, data)
	wf_setitem('used_gbn', ls_used_gbn)
end if

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(ll_row, ls_col, dec(data))
elseif ls_type = 'date' then
	idw_list.setitem(ll_row, ls_col, date(data))
else	
	idw_list.setitem(ll_row, ls_col, data)
end if

idw_list.setitem(ll_row, 'job_uid',		gs_empcode)
idw_list.setitem(ll_row, 'job_add',		gs_ip)
idw_list.setitem(ll_row, 'job_date',	f_sysdate())

end event

event losefocus;call super::losefocus;accepttext()
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2032
string text = "재무코드조회"
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
integer height = 1864
integer taborder = 110
string dataobject = "d_hfn112a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_5 from groupbox within tabpage_sheet02
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
integer height = 2032
string text = "재무코드내역"
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
integer width = 4347
integer height = 2032
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hfn112a_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type rb_all from radiobutton within w_hfn112a
integer x = 2066
integer y = 148
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전체"
boolean checked = true
end type

event clicked;idw_print.object.t_name.text = '출력구분 : 전체'
wf_filter("")
end event

type rb_hab from radiobutton within w_hfn112a
integer x = 2313
integer y = 148
integer width = 544
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "합계잔액시산표"
end type

event clicked;idw_print.object.t_name.text = '출력구분 : 합계잔액시산표'
wf_filter("mid(hac006m_used_gbn,1,1) = '9'")

end event

type rb_un from radiobutton within w_hfn112a
integer x = 2889
integer y = 148
integer width = 425
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "운영계산서"
end type

event clicked;idw_print.object.t_name.text = '출력구분 : 운영계산서'
wf_filter("mid(hac006m_used_gbn,2,1) = '9'")
end event

type rb_dae from radiobutton within w_hfn112a
integer x = 3342
integer y = 148
integer width = 425
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "대차대조표"
end type

event clicked;idw_print.object.t_name.text = '출력구분 : 대차대조표'
wf_filter("mid(hac006m_used_gbn,3,1) = '9'")
end event

type rb_ja from radiobutton within w_hfn112a
integer x = 3790
integer y = 148
integer width = 425
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "자금계산서"
end type

event clicked;idw_print.object.t_name.text = '출력구분 : 자금계산서'
wf_filter("mid(hac006m_used_gbn,4,1) = '9'")
end event

