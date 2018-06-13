$PBExportHeader$w_hge501a.srw
$PBExportComments$강사료지급주관리/출력
forward
global type w_hge501a from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
type uo_yearhakgi from cuo_yyhakgi within w_hge501a
end type
type st_3 from statictext within w_hge501a
end type
end forward

global type w_hge501a from w_tabsheet
string title = "강사료지급주관리/출력"
uo_yearhakgi uo_yearhakgi
st_3 st_3
end type
global w_hge501a w_hge501a

type variables
datawindowchild	idw_child
datawindow			idw_data


string	is_bdgt_year
string	is_campus

string	is_yy, is_hakgi
integer	ii_max_month

end variables

forward prototypes
public function integer wf_retrieve ()
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
integer	li_tab

li_tab  = tab_sheet.selectedtab


if idw_data.retrieve(is_yy, is_hakgi) > 0 then
	idw_print.retrieve(is_yy, is_hakgi)

else
	idw_print.reset()
end if

return 0
end function

on w_hge501a.create
int iCurrent
call super::create
this.uo_yearhakgi=create uo_yearhakgi
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yearhakgi
this.Control[iCurrent+2]=this.st_3
end on

on w_hge501a.destroy
call super::destroy
destroy(this.uo_yearhakgi)
destroy(this.st_3)
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

String s_name,s_max_no  
int    i_tab,i_newrow
long   l_max_no

integer	li_newrow
string	ls_strdate, ls_enddate



//idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)


idw_data.setitem(li_newrow, 'year',		is_yy)
idw_data.setitem(li_newrow, 'hakgi',	is_hakgi)
idw_data.setitem(li_newrow, 'month',	ii_max_month)

ls_strdate	=	is_yy + string(ii_max_month, '00') + '01'

ls_enddate	=	f_lastdate(is_yy + string(ii_max_month, '00'))
idw_data.setitem(li_newrow, 'from_date', ls_strdate)
idw_data.setitem(li_newrow, 'to_date', ls_enddate)

idw_data.setitem(li_newrow, 'worker',		gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setcolumn('month')

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
int li_month
idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_print	=	tab_sheet.tabpage_sheet02.dw_print


is_yy 	= uo_yearhakgi.uf_getyy()
is_hakgi	= uo_yearhakgi.uf_gethakgi()

select to_number(to_char(sysdate,'mm'))
  into:li_month
 from dual;

IF li_month < 8 then
	is_hakgi = '1'
	uo_yearhakgi.em_hakgi.text ='1'
else 
	is_hakgi ='2'
	uo_yearhakgi.em_hakgi.text ='2'
end if
triggerevent('ue_retrieve')

tab_sheet.selectedtab = 1

end event

event ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
IF dw_name.Update(true) = 1 THEN
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

type ln_templeft from w_tabsheet`ln_templeft within w_hge501a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hge501a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hge501a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hge501a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hge501a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hge501a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hge501a
end type

type uc_insert from w_tabsheet`uc_insert within w_hge501a
end type

type uc_delete from w_tabsheet`uc_delete within w_hge501a
end type

type uc_save from w_tabsheet`uc_save within w_hge501a
end type

type uc_excel from w_tabsheet`uc_excel within w_hge501a
end type

type uc_print from w_tabsheet`uc_print within w_hge501a
end type

type st_line1 from w_tabsheet`st_line1 within w_hge501a
end type

type st_line2 from w_tabsheet`st_line2 within w_hge501a
end type

type st_line3 from w_tabsheet`st_line3 within w_hge501a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hge501a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hge501a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hge501a
integer y = 308
integer width = 4384
integer height = 1960
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;if newindex < 1 then	return

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
integer height = 1840
long backcolor = 1073741824
string text = "강사료지급주관리"
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
string dataobject = "d_hge501a_1"
boolean hsplitscroll = true
end type

event dw_update_tab::buttonclicked;call super::buttonclicked;string		ls_date, ls_colname
dwobject		ldwo_col

if isnull(row) or row < 1 then return

if dwo.name = 'b_from_dt' then
	ls_colname = 'from_date'
	ldwo_col = this.object.from_date
else
	ls_colname = 'to_date'
	ldwo_col = this.object.to_date
end if
//
//if isnull(getitemstring(row, ls_colname)) or trim(getitemstring(row, ls_colname)) = '' then
//	Openwithparm(w_calendar, f_today())
//else
//	Openwithparm(w_calendar, getitemstring(row, ls_colname))
//end if
//
ls_date	=	message.stringparm

if trim(ls_date) = '' then return

setitem(row, ls_colname, ls_date)

trigger event itemchanged (row, ldwo_col, ls_date)

end event

event dw_update_tab::itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화

string	ls_colname, ls_befdata, ls_date, ls_strdate, ls_enddate
integer	li_befdata

ls_colname = dwo.name

if (dwo.name = 'from_date' or dwo.name = 'to_date') and trim(data) = '' then	return

if dwo.name = 'month' then
	li_befdata = getitemnumber(row, ls_colname)
	if integer(data) < 1 or integer(data) > 12 then
		f_messagebox('3', '월을 정확히 입력해 주세요.!')
		setitem(row, ls_colname, li_befdata)
		return 1
	end if
	ls_strdate	=	is_yy + string(integer(data), '00') + '01'
	ls_enddate	=	f_lastdate(is_yy + string(integer(data), '00'))
	setitem(row, 'from_date', ls_strdate)
	setitem(row, 'to_date', ls_enddate)
elseif dwo.name = 'from_weekend' then
	li_befdata = getitemnumber(row, ls_colname)
	accepttext()
	if not isnumber(data) or integer(data) = 0 then
		f_messagebox('3', '주차를 정확히 입력해 주세요.!')
		setitem(row, ls_colname, li_befdata)
		return 1
	end if
	if getitemnumber(row, 'from_weekend') > getitemnumber(row, 'to_weekend') then
		setitem(row, 'to_weekend', getitemnumber(row, 'from_weekend') + 3)
	end if
elseif dwo.name = 'to_weekend' then
	li_befdata = getitemnumber(row, ls_colname)
	accepttext()
	if not isnumber(data) or integer(data) = 0 then
		f_messagebox('3', '주차를 정확히 입력해 주세요.!')
		setitem(row, ls_colname, li_befdata)
		return 1
	end if
	if getitemnumber(row, 'from_weekend') > getitemnumber(row, 'to_weekend') then
		f_messagebox('3', '주차를 정확히 입력해 주세요.!')
		setitem(row, ls_colname, li_befdata)
		return 1
	end if
elseif dwo.name = 'from_date' then
	ls_befdata = getitemstring(row, ls_colname)
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
	ls_befdata = getitemstring(row, ls_colname)
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
	
//elseif dwo.name = 'from_date' then
//	ls_befdata = getitemstring(row, ls_colname)
//	accepttext()
//	if isdate(string(data, '@@@@/@@/@@')) = false then
//		f_messagebox('3', '일자를 정확히 입력해 주세요.!')
//		setitem(row, ls_colname, ls_befdata)
//		return 1
//	end if
//if isnull(getitemstring(row, 'to_date')) or trim(getitemstring(row, 'to_date')) = '' or getitemstring(row, 'from_date') > getitemstring(row, 'to_date') then
//		setitem(row, 'to_date', getitemstring(row, 'from_date'))
//	end if
//elseif dwo.name = 'to_date' then
//	ls_befdata = getitemstring(row, ls_colname)
//	accepttext()
//	if isdate(string(data, '@@@@/@@/@@')) = false then
//		f_messagebox('3', '일자를 정확히 입력해 주세요.!')
//		setitem(row, ls_colname, ls_befdata)
//		return 1
//	end if
//	if getitemstring(row, 'from_date') > getitemstring(row, 'to_date') then
//		f_messagebox('3', '일자를 정확히 입력해 주세요.!')
//		setitem(row, ls_colname, ls_befdata)
//		return 1
//	end if
//end if

setitem(row, 'job_uid',		gstru_uid_uname.uid)
setitem(row, 'job_add',		gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())

end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then
	uo_yearhakgi.em_yy.setfocus()
else
	setfocus()
end if

end event

type uo_tab from w_tabsheet`uo_tab within w_hge501a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hge501a
boolean visible = false
integer x = 59
integer y = 0
end type

type st_con from w_tabsheet`st_con within w_hge501a
integer x = 55
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1840
string text = "강사료지급주내역"
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
integer width = 3845
integer height = 2180
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hge501a_2"
boolean vscrollbar = true
boolean border = false
end type

type uo_yearhakgi from cuo_yyhakgi within w_hge501a
integer x = 229
integer y = 172
integer width = 1047
integer height = 104
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;is_yy 	= uf_getyy()
is_hakgi	= uf_gethakgi()
if is_hakgi = ' ' then
	is_hakgi = '1'
end if

parent.triggerevent('ue_retrieve')
end event

on uo_yearhakgi.destroy
call cuo_yyhakgi::destroy
end on

type st_3 from statictext within w_hge501a
integer x = 1431
integer y = 180
integer width = 1248
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
string text = "※ 조회시 년도와 학기는 반드시 입력해 주세요."
boolean focusrectangle = false
end type

