$PBExportHeader$w_hpa602a.srw
$PBExportComments$전근무지 상황 관리/출력
forward
global type w_hpa602a from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_3 from cuo_search_insa within tabpage_sheet01
end type
type dw_update_back from cuo_dwwindow within tabpage_sheet01
end type
type rb_1 from radiobutton within tabpage_sheet01
end type
type rb_2 from radiobutton within tabpage_sheet01
end type
type rb_all from radiobutton within tabpage_sheet01
end type
type dw_update from uo_dwgrid within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
type st_2 from statictext within w_hpa602a
end type
end forward

global type w_hpa602a from w_tabsheet
string title = "전근무지 상황 관리/출력"
st_2 st_2
end type
global w_hpa602a w_hpa602a

type variables
datawindowchild	idw_child, idw_child2
datawindow			idw_list, idw_data,  idw_list_3, idw_list_4
datawindow			idw_1



//string	is_yearmonth,  is_today




end variables

forward prototypes
public subroutine wf_setitem (string as_colname, string as_data)
public subroutine wf_retrieve_data ()
public function integer wf_retrieve ()
public subroutine wf_retrieve_save ()
end prototypes

public subroutine wf_setitem (string as_colname, string as_data);// ==========================================================================================
// 기    능 : 	datawindow setitem
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_setitem(string as_colname, string as_data)
// 인    수 :	as_colname	-	column name
//					as_data		-	data
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

public subroutine wf_retrieve_data ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve_data()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

if idw_list.getrow() < 1 then	
	idw_data.reset()
	return
end if

//f_setpointer('START')

idw_data.retrieve(idw_list.getitemstring(idw_list.getrow(), 'member_no'))

//f_setpointer('END')
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

String	ls_name
integer	li_tab
String	ls_dept_code, ls_year, ls_jikjong
Integer	li_str_jikjong, li_end_jikjong

dw_con.accepttext()
ls_dept_code = trim(dw_con.object.dept_code[1])
If ls_dept_code = '' Or isnull(ls_dept_code) Then ls_dept_code = '%'
ls_year = String(dw_con.object.year[1], 'yyyy')
ls_jikjong	= trim(dw_con.object.jikjong_code[1])
If ls_jikjong = '' or isnull(ls_jikjong) or ls_jikjong = '0' Then
	li_str_jikjong = 0
	li_end_jikjong = 9
Else
	li_str_jikjong = Integer(ls_jikjong)
	li_end_jikjong = Integer(ls_jikjong)
End If
li_tab  = tab_sheet.selectedtab



idw_list.setfilter("")
idw_list.filter()

if idw_list.retrieve(ls_dept_code, li_str_jikjong, li_end_jikjong, ls_year) > 0 then
	if tab_sheet.tabpage_sheet01.rb_1.checked then
		idw_list.setfilter("gubun = '생성'")
	elseif tab_sheet.tabpage_sheet01.rb_2.checked then
		idw_list.setfilter("gubun = ''")
	end if
	idw_list.filter()

	idw_list.sort()
	

	idw_print.retrieve(ls_dept_code, li_str_jikjong, li_end_jikjong, ls_year) 

else
	idw_print.reset()
end if

return 0
end function

public subroutine wf_retrieve_save ();// ==========================================================================================
// 기    능 : 	save after retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve_save()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_name
integer	li_tab
long		ll_row
String	ls_dept_code, ls_year, ls_jikjong
Integer	li_str_jikjong, li_end_jikjong

dw_con.accepttext()
ls_dept_code = trim(dw_con.object.dept_code[1])
If ls_dept_code = '' Or isnull(ls_dept_code) Then ls_dept_code = '%'
ls_year = String(dw_con.object.year[1], 'yyyy')
ls_jikjong	= trim(dw_con.object.jikjong_code[1])
If ls_jikjong = '' or isnull(ls_jikjong) or ls_jikjong = '0' Then
	li_str_jikjong = 0
	li_end_jikjong = 9
Else
	li_str_jikjong = Integer(ls_jikjong)
	li_end_jikjong = Integer(ls_jikjong)
End If

li_tab  = tab_sheet.selectedtab

ll_row	=	idw_list.getrow()


idw_list.setredraw(false)

idw_list.setfilter("")
idw_list.filter()

if idw_list.retrieve(ls_dept_code, li_str_jikjong, li_end_jikjong) > 0 then
	if tab_sheet.tabpage_sheet01.rb_1.checked then
		idw_list.setfilter("gubun = '생성'")
	elseif tab_sheet.tabpage_sheet01.rb_2.checked then
		idw_list.setfilter("gubun = ''")
	end if
	idw_list.filter()
	idw_list.sort()

	idw_list.scrolltorow(ll_row)
	
	if idw_print.retrieve(ls_dept_code, li_str_jikjong, li_end_jikjong, ls_year) > 0 then	

	else
		idw_print.reset()
	end if
end if

idw_list.setredraw(true)

end subroutine

on w_hpa602a.create
int iCurrent
call super::create
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
end on

on w_hpa602a.destroy
call super::destroy
destroy(this.st_2)
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

if idw_list.rowcount() < 1 then	return 



li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

idw_data.setitem(li_newrow, 'member_no', 		idw_list.getitemstring(idw_list.getrow(), 'member_no'))
if li_newrow = 1 then
	idw_data.setitem(li_newrow, 'seq_no',		1)
else
	idw_data.setitem(li_newrow, 'seq_no',		integer(idw_data.describe("evaluate('max(seq_no) + 1', 1)")))
end if
idw_data.setitem(li_newrow, 'register_no',	'          ')
idw_data.setitem(li_newrow, 'worker',			gs_empcode)
idw_data.setitem(li_newrow, 'ipaddr',			gs_ip)
idw_data.setitem(li_newrow, 'work_date',		f_sysdate())

idw_data.setcolumn('year')
idw_data.scrolltorow(li_newrow)
idw_data.setfocus()



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
//idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//
//
//
//dw_con.object.year[1] = date(string( f_today(), '@@@@/@@/@@'))
//dw_con.object.dept_code[1] = '%'
//
//f_getdwcommon2(dw_con, 'jikjong_code', 0, 'jikjong_code', 750, 100)
//
//tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'member_no', 'name')
//
//triggerevent('ue_retrieve')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
IF dw_name.Update(true) = 1  THEN
	COMMIT;
	wf_retrieve_save()
ELSE
  ROLLBACK;
END IF


return 1







///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타를 저장한다.		                       //
//// 작성일자 : 2001. 8                                      //
//// 작 성 인 : 						                             //
///////////////////////////////////////////////////////////////
//
//int    i_tab,i_findrow,i_code,i_row = 1,i_rowcount,i,i_process,i_oldprocess,i_gbn
//String s_type,s_fname,s_sname,s_ename,s_processID,s_uid,s_programuser,s_address,s_biscode
//String s_member_no, s_k_name
//cuo_dwwindow dw_name
//
//f_setpointer('START')
//i_tab     = tab_sheet.Selectedtab
//s_uid     = gstru_uid_uname.uid         //사용자 명
//s_address = gstru_uid_uname.address     //사용자 IP
//
//
//choose case i_tab
//	case 1
//
//		  dw_name   = tab_sheet.tabpage_sheet01.dw_update101                   //저장하고자하는 데이타 원도우
//		  i_findrow = tab_sheet.tabpage_sheet01.dw_list001.GetSelectedrow(0)   //현재 저장하고자하는 행번호
//		  IF dw_name.Update(true) = 1 THEN
//			  COMMIT;
//			  s_k_name     = dw_name.GetItemString(i_row,'name')			  
//			  IF i_findrow < 1 then
//			  	  s_member_no  = dw_name.GetItemString(i_row,'member_no')
//				  i_findrow    = tab_sheet.tabpage_sheet01.dw_list001.Insertrow(0)
//				  tab_sheet.tabpage_sheet01.dw_list001.uf_selectrow(i_findrow)
//				  tab_sheet.tabpage_sheet01.dw_list001.SetItem(i_findrow,'member_no',s_member_no) //관리번호
//			  END IF
//           tab_sheet.tabpage_sheet01.dw_list001.SetItem(i_findrow,'name',s_k_name) //성명
//		  ELSE
//			  ROLLBACK;
//		  END IF
//
//END CHOOSE		
//
//f_setpointer('END')
//return 1
end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		i
string		ls_member_no
long			ll_rowcount


wf_setMsg('삭제중')

if idw_1 = idw_list then
	if idw_data.rowcount() > 0 then
		ls_member_no	=	idw_1.getitemstring(idw_1.getrow(), 'member_no')
		if f_messagebox('2', '[' + ls_member_no + ']의 모든 전근무지가 삭제됩니다.~n~n삭제하시겠습니까?') = 1 then
			ll_rowcount	=	idw_data.rowcount()
			for i = 1 to ll_rowcount
				idw_data.deleterow(0)
			next
		end if
	end if
else
	idw_data.deleterow(0)
end if

wf_setMsg('.')

return 

end event

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력 처리
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

IF idw_print.RowCount() < 1 THEN	return

OpenWithParm(w_printoption, idw_print)

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
Long	ll_InsRow
idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_print	=	tab_sheet.tabpage_sheet02.dw_print



dw_con.object.year[1] = date(string( f_today(), '@@@@/@@/@@'))


dw_con.GetChild('dept_code',idw_child)
idw_child.SetTransObject(SQLCA)
IF idw_child.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드 입력하시기 바랍니다.')
	idw_child.InsertRow(0)
ELSE
	ll_InsRow = idw_child.InsertRow(0)
	idw_child.SetItem(ll_InsRow,'gwa','9999')
	idw_child.SetItem(ll_InsRow,'fname','없음')
	idw_child.SetSort('code ASC')
	idw_child.Sort()
END IF

dw_con.GetChild('jikjong_code',idw_child)
idw_child.SetTransObject(SQLCA)
IF idw_child.Retrieve('jikjong_code',0) = 0 THEN
	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
	idw_child.InsertRow(0)
ELSE
	 idw_child.InsertRow(0)
	idw_child.SetSort('code ASC')
	idw_child.Sort()
END IF


dw_con.Object.jikjong_code[1] = ''
dw_con.Object.jikjong_code.dddw.PercentWidth = 100

tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'member_no', 'name')

triggerevent('ue_retrieve')

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa602a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa602a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa602a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa602a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa602a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa602a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa602a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa602a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa602a
end type

type uc_save from w_tabsheet`uc_save within w_hpa602a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa602a
end type

type uc_print from w_tabsheet`uc_print within w_hpa602a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa602a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa602a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa602a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa602a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa602a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa602a
integer y = 316
integer width = 4384
integer height = 1992
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
integer height = 1872
long backcolor = 1073741824
string text = "전근무지상황관리"
gb_4 gb_4
uo_3 uo_3
dw_update_back dw_update_back
rb_1 rb_1
rb_2 rb_2
rb_all rb_all
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.uo_3=create uo_3
this.dw_update_back=create dw_update_back
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_all=create rb_all
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_3
this.Control[iCurrent+3]=this.dw_update_back
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.rb_all
this.Control[iCurrent+7]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_3)
destroy(this.dw_update_back)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_all)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 101
integer height = 100
string dataobject = "d_hpa602a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then	return

//selectrow(0, false)
//selectrow(currentrow, true)

wf_retrieve_data()

end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

event dw_list001::getfocus;call super::getfocus;idw_1 = this
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 168
integer width = 4347
integer height = 940
string dataobject = "d_hpa602a_1"
end type

event dw_update_tab::getfocus;call super::getfocus;idw_1 = this
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then	return

//selectrow(0, false)
//selectrow(currentrow, true)
////
wf_retrieve_data()

end event

type uo_tab from w_tabsheet`uo_tab within w_hpa602a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hpa602a
string dataobject = "d_hpa601a_con"
end type

event dw_con::constructor;call super::constructor;this.object.jaejik_opt.visible = false
this.object.jaejik_opt_t.visible = false



end event

type st_con from w_tabsheet`st_con within w_hpa602a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_4 from groupbox within tabpage_sheet01
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

type uo_3 from cuo_search_insa within tabpage_sheet01
integer x = 114
integer y = 40
integer width = 1687
integer taborder = 50
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type dw_update_back from cuo_dwwindow within tabpage_sheet01
integer y = 1120
integer width = 101
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa602a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())



end event

event losefocus;call super::losefocus;accepttext()
end event

event getfocus;call super::getfocus;idw_1 = this
end event

type rb_1 from radiobutton within tabpage_sheet01
integer x = 2661
integer y = 60
integer width = 357
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "생성된자료"
end type

event clicked;rb_all.textcolor 	=	rgb(0, 0, 0)
rb_1.textcolor 	=	rgb(0, 0, 255)
rb_2.textcolor 	=	rgb(0, 0, 0)

//rb_all.underline	=	false
//rb_1.underline		=	true
//rb_2.underline		=	false

idw_list.setfilter("gubun = '생성'")
idw_list.filter()

end event

type rb_2 from radiobutton within tabpage_sheet01
integer x = 3131
integer y = 60
integer width = 357
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "미생성자료"
end type

event clicked;rb_all.textcolor 	=	rgb(0, 0, 0)
rb_1.textcolor 	=	rgb(0, 0, 0)
rb_2.textcolor 	=	rgb(0, 0, 255)

//rb_all.underline	=	false
//rb_1.underline		=	false
//rb_2.underline		=	true

idw_list.setfilter("gubun = ''")
idw_list.filter()
end event

type rb_all from radiobutton within tabpage_sheet01
integer x = 2245
integer y = 60
integer width = 302
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "전체자료"
boolean checked = true
end type

event clicked;rb_all.textcolor 	=	rgb(0, 0, 255)
rb_1.textcolor 	=	rgb(0, 0, 0)
rb_2.textcolor 	=	rgb(0, 0, 0)

//rb_all.underline	=	true
//rb_1.underline		=	false
//rb_2.underline		=	false

idw_list.setfilter("")
idw_list.filter()

end event

type dw_update from uo_dwgrid within tabpage_sheet01
integer y = 1120
integer width = 4352
integer height = 740
integer taborder = 30
string dataobject = "d_hpa602a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())
end event

event getfocus;call super::getfocus;idw_1 = this
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
string text = "전근무지상황내역"
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
integer height = 1872
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa602a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type st_2 from statictext within w_hpa602a
integer x = 2482
integer y = 296
integer width = 1303
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "※ 입력, 삭제 후 반드시 저장을 하시기 바랍니다."
boolean focusrectangle = false
end type

