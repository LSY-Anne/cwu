$PBExportHeader$w_hac103a.srw
$PBExportComments$요구기간 관리/출력
forward
global type w_hac103a from w_tabsheet
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
type st_mes1 from statictext within w_hac103a
end type
type st_mes2 from statictext within w_hac103a
end type
end forward

global type w_hac103a from w_tabsheet
integer height = 2616
string title = "요구기간 관리/출력"
st_mes1 st_mes1
st_mes2 st_mes2
end type
global w_hac103a w_hac103a

type variables
datawindowchild	idw_child
datawindow			idw_data


string				is_bdgt_year

end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

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

// 예산구분
idw_data.getchild('bdgt_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bdgt_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('bdgt_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bdgt_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 상태구분
idw_data.getchild('stat_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('stat_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('stat_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('stat_class', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
end subroutine

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

li_tab  = tab_sheet.selectedtab



dw_con.accepttext()
is_bdgt_year = string(dw_con.object.year[1], 'yyyy')
if idw_data.retrieve(is_bdgt_year) > 0 then
	idw_print.retrieve(is_bdgt_year)

else
	idw_print.reset()
end if

return 0
end function

on w_hac103a.create
int iCurrent
call super::create
this.st_mes1=create st_mes1
this.st_mes2=create st_mes2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_mes1
this.Control[iCurrent+2]=this.st_mes2
end on

on w_hac103a.destroy
call super::destroy
destroy(this.st_mes1)
destroy(this.st_mes2)
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

event ue_insert;call super::ue_insert;// ==========================================================================================
// 작성목정 : data insert
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

String s_name,s_max_no  
int    i_tab,i_newrow
long   l_max_no

integer	li_newrow



//idw_data.Selectrow(0, false)	

dw_con.accepttext()
is_bdgt_year = string(dw_con.object.year[dw_con.getrow()], 'yyyy')


idw_data.setfocus()

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)
if li_newrow < 2 then
	idw_data.setitem(li_newrow, 'bdgt_year',  is_bdgt_year)
	idw_data.setitem(li_newrow, 'bdgt_class', 0)
	idw_data.setcolumn('bdgt_year')
else
	idw_data.setitem(li_newrow, 'bdgt_year',  idw_data.getitemstring(li_newrow - 1, 'bdgt_year'))
	idw_data.setitem(li_newrow, 'bdgt_class', idw_data.getitemnumber(li_newrow - 1, 'bdgt_class'))
	idw_data.setcolumn('bdgt_class')
end if

idw_data.setitem(li_newrow, 'worker',		gs_empcode)  // gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip)   // gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setfocus()



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
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//
//wf_getchild()
//
//is_bdgt_year = left(f_today(), 4)
//em_year.text = is_bdgt_year
//
//tab_sheet.selectedtab = 1
//
end event

event ue_save;call super::ue_save;// ==========================================================================================
// 작성목정 : data save
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

cuo_dwwindow	dw_name
integer	li_findrow



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

IF dw_name.Update(true) = 1 THEN
	COMMIT;
	triggerevent('ue_retrieve')
ELSE
  ROLLBACK;
END IF


return 1

end event

event ue_delete;call super::ue_delete;// ==========================================================================================
// 작성목정 : data delete
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

integer		li_deleterow


wf_setMsg('삭제중')

li_deleterow	=	idw_data.deleterow(0)

wf_setMsg('.')

return 

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

idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_print	=	tab_sheet.tabpage_sheet02.dw_print


wf_getchild()

is_bdgt_year = left(f_today(), 4)
//em_year.text = is_bdgt_year
//dw_con.object.year[1] = date(f_today())
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

type ln_templeft from w_tabsheet`ln_templeft within w_hac103a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac103a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac103a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac103a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac103a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac103a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac103a
end type

type uc_insert from w_tabsheet`uc_insert within w_hac103a
end type

type uc_delete from w_tabsheet`uc_delete within w_hac103a
end type

type uc_save from w_tabsheet`uc_save within w_hac103a
end type

type uc_excel from w_tabsheet`uc_excel within w_hac103a
end type

type uc_print from w_tabsheet`uc_print within w_hac103a
end type

type st_line1 from w_tabsheet`st_line1 within w_hac103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hac103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hac103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac103a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac103a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac103a
integer y = 324
integer width = 4379
integer height = 2016
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
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
integer height = 1896
string text = "요구기간관리"
dw_update dw_update
end type

on tabpage_sheet01.create
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
string dataobject = "d_hac103a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;string	ls_colname, ls_befdata
string	ls_date

ls_colname = dwo.name

if (dwo.name = 'from_date' or dwo.name = 'to_date') and trim(data) = '' then	return

if dwo.name = 'from_date' and (isnull(getitemstring(row, 'to_date')) or trim(getitemstring(row, 'to_date')) = '') then
	setitem(row, 'to_date', data)
end if

if dwo.name = 'from_date' or dwo.name = 'to_date' then
	ls_befdata = getitemstring(row, ls_colname)
	accepttext()
end if

if dwo.name = 'form_dt' then
	if isdate(string(data, '@@@@/@@/@@')) = false then
		f_messagebox('3', '일자를 정확히 입력해 주세요.!')
		setitem(row, ls_colname, ls_befdata)
		return 1
	end if
	ls_date	= getitemstring(row, 'to_date')
	if isnull(ls_date) or trim(ls_date) = '' or data > ls_date then
		setitem(row, 'to_date', data)
	end if
elseif dwo.name = 'to_date' then
	if isdate(string(data, '@@@@/@@/@@')) = false then
		f_messagebox('3', '일자를 정확히 입력해 주세요.!')
		setitem(row, ls_colname, ls_befdata)
		return 1
	end if
	ls_date	= getitemstring(row, 'from_date')
	if isnull(ls_date) or trim(ls_date) = '' then
		setitem(row, 'from_date', data)
	elseif data < ls_date then
		f_messagebox('3', '일자를 정확히 입력해 주세요.!')
		setitem(row, ls_colname, ls_befdata)
		return 1
	end if
end if

setitem(row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())

end event

event dw_update_tab::itemerror;call super::itemerror;return 1
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then
	dw_con.setfocus()
else
	setfocus()
end if
end event

type uo_tab from w_tabsheet`uo_tab within w_hac103a
integer y = 344
end type

type dw_con from w_tabsheet`dw_con within w_hac103a
string dataobject = "d_hac103a_con"
end type

event dw_con::itemchanged;call super::itemchanged;accepttext()
If dwo.name = 'year' Then
	is_bdgt_year = string(date(data), 'yyyy')
End If
RETURN 1
end event

event dw_con::constructor;call super::constructor;this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
st_mes1.setposition(totop!)
st_mes2.setposition(totop!)
end event

type st_con from w_tabsheet`st_con within w_hac103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer width = 101
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hac103a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;string	ls_colname, ls_befdata
string	ls_date

ls_colname = dwo.name

if (dwo.name = 'from_date' or dwo.name = 'to_date') and trim(data) = '' then	return

if dwo.name = 'from_date' and (isnull(getitemstring(row, 'to_date')) or trim(getitemstring(row, 'to_date')) = '') then
	setitem(row, 'to_date', data)
end if

if dwo.name = 'from_date' or dwo.name = 'to_date' then
	ls_befdata = getitemstring(row, ls_colname)
	accepttext()
end if

if dwo.name = 'form_dt' then
	if isdate(string(data, '@@@@/@@/@@')) = false then
		f_messagebox('3', '일자를 정확히 입력해 주세요.!')
		setitem(row, ls_colname, ls_befdata)
		return 1
	end if
	ls_date	= getitemstring(row, 'to_date')
	if isnull(ls_date) or trim(ls_date) = '' or data > ls_date then
		setitem(row, 'to_date', data)
	end if
elseif dwo.name = 'to_date' then
	if isdate(string(data, '@@@@/@@/@@')) = false then
		f_messagebox('3', '일자를 정확히 입력해 주세요.!')
		setitem(row, ls_colname, ls_befdata)
		return 1
	end if
	ls_date	= getitemstring(row, 'from_date')
	if isnull(ls_date) or trim(ls_date) = '' then
		setitem(row, 'from_date', data)
	elseif data < ls_date then
		f_messagebox('3', '일자를 정확히 입력해 주세요.!')
		setitem(row, ls_colname, ls_befdata)
		return 1
	end if
end if

setitem(row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())

end event

event retrieveend;call super::retrieveend;if rowcount < 1 then
	dw_con.setfocus()
else
	setfocus()
end if
end event

event losefocus;call super::losefocus;accepttext()
end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4343
integer height = 1896
long backcolor = 16777215
string text = "요구기간내역"
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
integer x = 5
integer width = 4338
integer height = 1900
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac103a_2"
boolean vscrollbar = true
boolean border = false
end type

type st_mes1 from statictext within w_hac103a
integer x = 1015
integer y = 164
integer width = 2738
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
string text = "※ 요구년도에 해당하는 자료가 조회됩니다."
boolean focusrectangle = false
end type

type st_mes2 from statictext within w_hac103a
integer x = 1015
integer y = 224
integer width = 2738
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
string text = "   요구년도를 삭제한 후 조회하면 전체 자료가 조회됩니다."
boolean focusrectangle = false
end type

