$PBExportHeader$w_hpa503a.srw
$PBExportComments$강사료 지급항목 관리/출력
forward
global type w_hpa503a from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
end forward

global type w_hpa503a from w_tabsheet
integer height = 2724
string title = "강사료 지급항목 관리/출력"
end type
global w_hpa503a w_hpa503a

type variables
datawindowchild	idw_child, idw_child2
datawindow			idw_data

statictext			ist_back

string	is_pay_opt = '1'
string	is_code, is_name
integer	ii_jikjong_code = 0, ii_maxcode = 0

end variables

forward prototypes
public function integer wf_retrieve ()
public subroutine wf_getchild ()
end prototypes

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

String	ls_name
integer	li_tab, i

li_tab  = tab_sheet.selectedtab

//ist_back.bringtotop = true

if idw_data.retrieve() > 0 then
	idw_print.retrieve()
//	ist_back.bringtotop = false
else
	idw_print.reset()
end if

return 0
end function

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

// 강사료구분
idw_data.getchild('sec_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('sec_code', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('sec_code', idw_child2)
idw_child2.settransobject(sqlca)
if idw_child2.retrieve('sec_code', 1) < 1 then
	idw_child2.reset()
	idw_child2.insertrow(0)
end if

// 반구분
//idw_data.getchild('ban_gbn', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('ban_gbn', 1) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//
idw_print.getchild('ban_gbn', idw_child2)
idw_child2.settransobject(sqlca)
if idw_child2.retrieve('ban_gbn', 1) < 1 then
	idw_child2.reset()
	idw_child2.insertrow(0)
end if
end subroutine

on w_hpa503a.create
int iCurrent
call super::create
end on

on w_hpa503a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

integer	li_newrow



//idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)
if ii_maxcode = 0 then
	select	nvl(max(pay_item_code) + 1, 1)
	into		:ii_maxcode
	from		padb.hpa102m	;

	if sqlca.sqlcode <> 0 then	ii_maxcode = 1
else
	ii_maxcode	= integer(idw_data.describe("evaluate('max(pay_item_code)', 1)"))
	ii_maxcode ++
end if

idw_data.setitem(li_newrow, 'pay_item_code', 	ii_maxcode)

idw_data.setitem(li_newrow, 'worker',		gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setcolumn('pay_item_code')
idw_data.setfocus()



end event

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_print	=	tab_sheet.tabpage_sheet02.dw_print


wf_getchild()

tab_sheet.selectedtab = 1

triggerevent('ue_retrieve')
end event

event ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow



//dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
IF idw_data.Update(true) = 1 THEN
	COMMIT;
	triggerevent('ue_retrieve')
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

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow


wf_setMsg('삭제중')

li_deleterow	=	idw_data.deleterow(0)

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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa503a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa503a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa503a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa503a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa503a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa503a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa503a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa503a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa503a
end type

type uc_save from w_tabsheet`uc_save within w_hpa503a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa503a
end type

type uc_print from w_tabsheet`uc_print within w_hpa503a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa503a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa503a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa503a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa503a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa503a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa503a
integer y = 196
integer width = 4384
integer height = 2092
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;if newindex < 0 then	return

//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
//
//
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
integer height = 1972
long backcolor = 1073741824
string text = "강사료 지급항목 관리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

event dw_list001::clicked;call super::clicked;//String s_memberno
//IF row > 0 then
//	s_memberno = dw_list001.getItemString(row,'member_no')
//	dw_update101.retrieve(s_memberno)
//end IF
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer height = 1964
string dataobject = "d_hpa503a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;String ls_name

ls_name = idw_child.GetItemString(idw_child.GetRow(),'fname')

setitem(row, 'pay_item_name', ls_name)
setitem(row, 'job_uid',		gstru_uid_uname.uid)
setitem(row, 'job_add',		gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())	

end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;ii_maxcode = 0

this.setfocus()
end event

event dw_update_tab::updateend;call super::updateend;ii_maxcode = 0
end event

type uo_tab from w_tabsheet`uo_tab within w_hpa503a
integer x = 1362
integer y = 148
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hpa503a
boolean visible = false
integer x = 59
integer y = 8
end type

type st_con from w_tabsheet`st_con within w_hpa503a
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1972
string text = "강사료 지급항목 내역"
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
integer y = 12
integer width = 4343
integer height = 1960
integer taborder = 10
string dataobject = "d_hpa503a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

