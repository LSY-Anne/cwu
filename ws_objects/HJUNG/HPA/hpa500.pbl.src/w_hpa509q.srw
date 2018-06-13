$PBExportHeader$w_hpa509q.srw
$PBExportComments$이체 은행계좌 관리/출력
forward
global type w_hpa509q from w_tabsheet
end type
type gb_41 from groupbox within tabpage_sheet01
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_2 from cuo_search_insa within tabpage_sheet01
end type
type rb_all from radiobutton within tabpage_sheet01
end type
type rb_1 from radiobutton within tabpage_sheet01
end type
type rb_2 from radiobutton within tabpage_sheet01
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_list002 from uo_dwgrid within tabpage_sheet02
end type
type gb_5 from groupbox within tabpage_sheet02
end type
type uo_3 from cuo_search_insa within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_list002 dw_list002
gb_5 gb_5
uo_3 uo_3
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_print dw_print
end type
type tabpage_sheet04 from userobject within tab_sheet
end type
type dw_print2 from cuo_dwprint within tabpage_sheet04
end type
type tabpage_sheet04 from userobject within tab_sheet
dw_print2 dw_print2
end type
type dw_head from datawindow within w_hpa509q
end type
type st_1 from statictext within w_hpa509q
end type
type rb_3 from radiobutton within w_hpa509q
end type
type rb_4 from radiobutton within w_hpa509q
end type
type rb_5 from radiobutton within w_hpa509q
end type
type uo_gwa from cuo_dept within w_hpa509q
end type
end forward

global type w_hpa509q from w_tabsheet
string title = "이체 은행계좌 조회/출력"
dw_head dw_head
st_1 st_1
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
uo_gwa uo_gwa
end type
global w_hpa509q w_hpa509q

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data,  idw_preview, idw_print2



string	is_yy, is_hakgi, is_member_no, is_dept
integer	ii_jikjong

integer	ii_month, ii_str_jikjong, ii_end_jikjong, ii_maxcode
Boolean  ib_RowSelect, Ib_RowSingle, Ib_SortGubn, Ib_EnterChk

end variables

forward prototypes
public subroutine wf_retrieve_detail (long al_row)
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_retrieve_detail (long al_row);// ==========================================================================================
// 기    능 : 	retrieve detail
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve_detail(long al_row)
// 인    수 :	al_row	-	row
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_member_no

if al_row < 1 then 
	idw_data.reset()
	return
end if

ls_member_no = idw_list.getitemstring(al_row, 'member_no')

idw_data.retrieve(ls_member_no)
	
end subroutine

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

// 은행코드
idw_data.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print2.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print2.getchild('bank_cd1', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 지급구분
idw_data.getchild('pay_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('pay_class2', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('pay_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('pay_class2', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('pay_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('pay_class2', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print2.getchild('pay_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('pay_class2', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if


//// 직종코드
//uo_1.uf_setType('jikjong_code', '직 종 명')

//// 개인번호
//idw_data.getchild('member_no', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(ii_str_jikjong, ii_end_jikjong) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
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

string	ls_filter, ls_filter2



idw_preview.setfilter("")
idw_preview.filter()
if idw_preview.retrieve(ii_str_jikjong, ii_end_jikjong, is_dept) > 0 then
	idw_print.setfilter("")
	idw_print.filter()
	if idw_print.retrieve(ii_str_jikjong, ii_end_jikjong, is_dept) > 0 then

	else

	end if
	
	ls_filter2 = "(isnull ( bank_code ) or bank_code = 0 or isnull ( bank_cd1 ) or bank_cd1 = 0 or isnull ( acct_no ) or trim ( acct_no ) = '' or isnull ( acct_no1 ) or trim ( acct_no1 ) = '' or bank_code <> bank_cd1 or acct_no <> acct_no1)"
	idw_print2.setfilter(ls_filter2)
	idw_print2.filter()
	if idw_print2.retrieve(ii_str_jikjong, ii_end_jikjong, is_dept) > 0 then

	else

	end if
	
	if rb_4.checked	then
		ls_filter	=	'hin001m_jaejik_opt in (1, 2)'

		idw_preview.setfilter(ls_filter)
		idw_preview.filter()
		idw_print.setfilter(ls_filter)
		idw_print.filter()
		idw_print2.setfilter(ls_filter + ' and ' + ls_filter2)
		idw_print2.filter()
	elseif	rb_5.checked	then
		ls_filter	=	'hin001m_jaejik_opt not in (1, 2)'
		
		idw_preview.setfilter(ls_filter)
		idw_preview.filter()
		idw_print.setfilter(ls_filter)
		idw_print.filter()
		idw_print2.setfilter(ls_filter + ' and ' + ls_filter2)
		idw_print2.filter()
	end if
	
	idw_preview.sort()
	idw_print.sort()
	idw_print2.sort()
	
	idw_preview.groupcalc()
	idw_print.groupcalc()
	idw_print2.groupcalc()
else
	idw_print.reset()
	idw_print2.reset()
end if

return 0
end function

on w_hpa509q.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.st_1=create st_1
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.uo_gwa=create uo_gwa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_3
this.Control[iCurrent+4]=this.rb_4
this.Control[iCurrent+5]=this.rb_5
this.Control[iCurrent+6]=this.uo_gwa
end on

on w_hpa509q.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.st_1)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.uo_gwa)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

event ue_insert;call super::ue_insert;///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타를 입력한다.                           //
//// 작성일자 : 2001. 08                                     //
//// 작 성 인 : 								                       //
///////////////////////////////////////////////////////////////
//
//integer	li_newrow
//
//if idw_list.rowcount() < 1 then
//	f_messagebox('1', '입력할 개인이 존재하지 않습니다.~n~n확인 후 다시 실행해 주시기 바랍니다.!')
//	return
//end if
//
//if idw_list.getrow() < 1 then
//	f_messagebox('1', '입력할 개인을 선택해 주세요.!')
//	idw_list.setfocus()
//	return
//end if
//
//f_setpointer('START')
//
//li_newrow	=	idw_data.getrow() + 1
//idw_data.insertrow(li_newrow)
//idw_data.scrolltorow(li_newrow)
//idw_data.setrow(li_newrow)
//idw_data.setitem(li_newrow, 'member_no',	idw_list.getitemstring(idw_list.getrow(), 'member_no'))
//idw_data.setitem(li_newrow, 'depositor',	idw_list.getitemstring(idw_list.getrow(), 'kname'))
//idw_data.setitem(li_newrow, 'worker',		gstru_uid_uname.uid)
//idw_data.setitem(li_newrow, 'ipaddr',		gstru_uid_uname.address)
//idw_data.setitem(li_newrow, 'work_date',	f_sysdate())
//
//idw_data.setcolumn('bank_code')
//
//idw_data.setfocus()
//
//f_setpointer('END')
//
end event

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_list		=	tab_sheet.tabpage_sheet01.dw_list001
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_preview	=	tab_sheet.tabpage_sheet02.dw_list002
idw_print	=	tab_sheet.tabpage_sheet03.dw_print

idw_print2	=	tab_sheet.tabpage_sheet04.dw_print2


wf_getchild()

f_getdwcommon2(dw_head, 'jikjong_code', 0, 'code', 750, 100)

uo_gwa.uf_setdept('1', '학과명')
is_dept	=	uo_gwa.uf_getcode()

tab_sheet.tabpage_sheet01.uo_2.uf_reset(idw_list, 'member_no', 'kname')
tab_sheet.tabpage_sheet02.uo_3.uf_reset(idw_preview, 'member_no', 'kname')

triggerevent('ue_retrieve')


end event

event ue_save;call super::ue_save;///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타를 저장한다.		                       //
//// 작성일자 : 2001. 8                                      //
//// 작 성 인 : 						                             //
///////////////////////////////////////////////////////////////
//
//cuo_dwwindow	dw_name
//integer	li_findrow
//
//f_setpointer('START')
//
//dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우
//
//IF dw_name.Update(true) = 1 THEN
//	COMMIT;
////	triggerevent('ue_retrieve')
//ELSE
//	ROLLBACK;
//END IF
//
//f_setpointer('END')
return 1
//
end event

event ue_delete;call super::ue_delete;///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타를 삭제한다.                           //
//// 작성일자 : 2001. 08                                     //
//// 작 성 인 : 						                             //
///////////////////////////////////////////////////////////////
//
//integer		li_deleterow
//
//f_setpointer('START')
//wf_setMsg('삭제중')
//
//li_deleterow	=	idw_data.deleterow(0)
////wf_retrieve_detail(idw_list.getrow())
//
//wf_setMsg('.')
//f_setpointer('END')
//return 0
//
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
//
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa509q
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa509q
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa509q
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa509q
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa509q
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa509q
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa509q
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa509q
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa509q
end type

type uc_save from w_tabsheet`uc_save within w_hpa509q
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa509q
end type

type uc_print from w_tabsheet`uc_print within w_hpa509q
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa509q
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa509q
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa509q
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa509q
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa509q
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa509q
integer x = 46
integer y = 324
integer width = 4389
integer height = 1968
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
integer selectedtab = 2
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
tabpage_sheet04 tabpage_sheet04
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
boolean visible = false
integer y = 104
integer width = 4352
integer height = 1848
string text = "이체은행계좌관리"
gb_41 gb_41
gb_4 gb_4
uo_2 uo_2
rb_all rb_all
rb_1 rb_1
rb_2 rb_2
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_41=create gb_41
this.gb_4=create gb_4
this.uo_2=create uo_2
this.rb_all=create rb_all
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_41
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.rb_all
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_41)
destroy(this.gb_4)
destroy(this.uo_2)
destroy(this.rb_all)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
integer y = 168
integer width = 1664
integer height = 2012
string dataobject = "d_hpa104a_1"
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if isnull(currentrow) or currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

wf_retrieve_detail(currentrow)
end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(1)
end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(False)
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
boolean visible = false
end type

type uo_tab from w_tabsheet`uo_tab within w_hpa509q
end type

type dw_con from w_tabsheet`dw_con within w_hpa509q
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hpa509q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type gb_41 from groupbox within tabpage_sheet01
integer y = -20
integer width = 855
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within tabpage_sheet01
integer x = 859
integer y = -20
integer width = 2985
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_2 from cuo_search_insa within tabpage_sheet01
integer x = 891
integer y = 36
integer width = 2935
integer taborder = 60
boolean bringtotop = true
end type

on uo_2.destroy
call cuo_search_insa::destroy
end on

type rb_all from radiobutton within tabpage_sheet01
integer x = 59
integer y = 60
integer width = 215
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
string text = "전체"
boolean checked = true
end type

event clicked;rb_all.textcolor 	=	rgb(0, 0, 255)
rb_1.textcolor 	=	rgb(0, 0, 0)
rb_2.textcolor 	=	rgb(0, 0, 0)

rb_all.underline	=	true
rb_1.underline		=	false
rb_2.underline		=	false

idw_list.setfilter("")
idw_list.filter()

idw_list.sort()

idw_list.trigger event rowfocuschanged(idw_list.getrow())
end event

type rb_1 from radiobutton within tabpage_sheet01
integer x = 302
integer y = 60
integer width = 215
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "생성"
end type

event clicked;rb_all.textcolor 	=	rgb(0, 0, 0)
rb_1.textcolor 	=	rgb(0, 0, 255)
rb_2.textcolor 	=	rgb(0, 0, 0)

rb_all.underline	=	false
rb_1.underline		=	true
rb_2.underline		=	false

idw_list.setfilter("gubun = 'Y'")
idw_list.filter()

idw_list.sort()

idw_list.trigger event rowfocuschanged(idw_list.getrow())
end event

type rb_2 from radiobutton within tabpage_sheet01
integer x = 544
integer y = 60
integer width = 261
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "미생성"
end type

event clicked;rb_all.textcolor 	=	rgb(0, 0, 0)
rb_1.textcolor 	=	rgb(0, 0, 0)
rb_2.textcolor 	=	rgb(0, 0, 255)

rb_all.underline	=	false
rb_1.underline		=	false
rb_2.underline		=	true

idw_list.setfilter("gubun = 'N'")
idw_list.filter()

idw_list.sort()

idw_list.trigger event rowfocuschanged(idw_list.getrow())
end event

type dw_update from cuo_dwwindow within tabpage_sheet01
integer x = 1669
integer y = 168
integer width = 2176
integer height = 2012
integer taborder = 20
string dataobject = "d_hpa104a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
accepttext()

if dwo.name = 'member_no' then
	setitem(row, 'depositor',	idw_child.getitemstring(idw_child.getrow(), 'kname'))
end if

setitem(row, 'job_uid',		gstru_uid_uname.uid)
setitem(row, 'job_add',		gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())



end event

event losefocus;call super::losefocus;accepttext()
end event

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4352
integer height = 1848
string text = "이체은행계좌조회"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list002 dw_list002
gb_5 gb_5
uo_3 uo_3
end type

on tabpage_sheet02.create
this.dw_list002=create dw_list002
this.gb_5=create gb_5
this.uo_3=create uo_3
this.Control[]={this.dw_list002,&
this.gb_5,&
this.uo_3}
end on

on tabpage_sheet02.destroy
destroy(this.dw_list002)
destroy(this.gb_5)
destroy(this.uo_3)
end on

type dw_list002 from uo_dwgrid within tabpage_sheet02
integer y = 168
integer width = 4352
integer height = 1676
integer taborder = 110
string dataobject = "d_hpa509q_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
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

type uo_3 from cuo_search_insa within tabpage_sheet02
event destroy ( )
integer x = 119
integer y = 40
integer width = 3566
integer taborder = 70
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type tabpage_sheet03 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4352
integer height = 1848
string text = "이체은행계좌내역"
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
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa509q_4"
boolean vscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

type tabpage_sheet04 from userobject within tab_sheet
boolean visible = false
integer x = 18
integer y = 104
integer width = 4352
integer height = 1848
long backcolor = 79741120
string text = "이체은행계좌내역(미제출자)"
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
integer width = 3845
integer height = 2180
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa509q_5"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

type dw_head from datawindow within w_hpa509q
integer x = 379
integer y = 184
integer width = 681
integer height = 76
integer taborder = 60
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

parent.triggerevent('ue_retrieve')


end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type st_1 from statictext within w_hpa509q
integer x = 146
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

type rb_3 from radiobutton within w_hpa509q
integer x = 2693
integer y = 192
integer width = 238
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
string text = "전체"
boolean checked = true
end type

event clicked;rb_3.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)
rb_5.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_4 from radiobutton within w_hpa509q
integer x = 3067
integer y = 192
integer width = 288
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
string text = "재직자"
end type

event clicked;rb_4.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)
rb_5.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')
end event

type rb_5 from radiobutton within w_hpa509q
integer x = 3493
integer y = 192
integer width = 288
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
string text = "퇴직자"
end type

event clicked;rb_5.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')
end event

type uo_gwa from cuo_dept within w_hpa509q
integer x = 1344
integer y = 180
integer taborder = 60
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;is_dept = uf_getcode()

parent.triggerevent('ue_retrieve')
end event

on uo_gwa.destroy
call cuo_dept::destroy
end on

