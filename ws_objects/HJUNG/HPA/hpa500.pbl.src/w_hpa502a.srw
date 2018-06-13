$PBExportHeader$w_hpa502a.srw
$PBExportComments$책임시수 관리/출력
forward
global type w_hpa502a from w_tabsheet
end type
type dw_list002 from uo_dwfree within tabpage_sheet01
end type
type dw_update_tab1 from uo_dwfree within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
type st_1 from statictext within w_hpa502a
end type
type ddlb_gb from dropdownlistbox within w_hpa502a
end type
type pb_create from picturebutton within w_hpa502a
end type
type em_time from editmask within w_hpa502a
end type
type em_limit_time from editmask within w_hpa502a
end type
type st_2 from statictext within w_hpa502a
end type
type st_3 from statictext within w_hpa502a
end type
type st_4 from statictext within w_hpa502a
end type
end forward

global type w_hpa502a from w_tabsheet
string title = "책임시수 관리"
st_1 st_1
ddlb_gb ddlb_gb
pb_create pb_create
em_time em_time
em_limit_time em_limit_time
st_2 st_2
st_3 st_3
st_4 st_4
end type
global w_hpa502a w_hpa502a

type variables
datawindowchild	idw_child
datawindow			idw_data,  idw_code


string	is_respons_gb


string	is_bdgt_year
string	is_campus

string	is_yy, is_hakgi
integer	ii_max_month

end variables

forward prototypes
public function integer wf_create ()
public function integer wf_retrieve ()
end prototypes

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	create
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long		ll_rowcount, ll_row, ll_count

wf_retrieve()

ll_rowcount	=	idw_code.retrieve()
if ll_rowcount < 0 then	return	100

for	ll_count	=	1	to	ll_rowcount
	ll_row	=	idw_data.insertrow(0)
	idw_data.setitem(ll_row, 'respons_gb',	is_respons_gb)
	idw_data.setitem(ll_row, 'respons_code',	idw_code.getitemstring(ll_count, 'code'))
	idw_data.setitem(ll_row, 'respons_time',	integer(em_time.text))
	idw_data.setitem(ll_row, 'limit_time',	integer(em_limit_time.text))
next

return	0
end function

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

idw_code.retrieve()

if idw_data.retrieve(is_respons_gb) > 0 then
	idw_print.retrieve(is_respons_gb)

else
	idw_print.reset()
end if

return 0
end function

on w_hpa502a.create
int iCurrent
call super::create
this.st_1=create st_1
this.ddlb_gb=create ddlb_gb
this.pb_create=create pb_create
this.em_time=create em_time
this.em_limit_time=create em_limit_time
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.ddlb_gb
this.Control[iCurrent+3]=this.pb_create
this.Control[iCurrent+4]=this.em_time
this.Control[iCurrent+5]=this.em_limit_time
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
end on

on w_hpa502a.destroy
call super::destroy
destroy(this.st_1)
destroy(this.ddlb_gb)
destroy(this.pb_create)
destroy(this.em_time)
destroy(this.em_limit_time)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
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

idw_data.setitem(li_newrow, 'respons_gb', is_respons_gb)

idw_data.setitem(li_newrow, 'worker',		gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setcolumn('respons_code')

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

idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab1
idw_code	=	tab_sheet.tabpage_sheet01.dw_list002
idw_print  	=	tab_sheet.tabpage_sheet02.dw_print

is_respons_gb	=	'1'
ddlb_gb.selectitem(1)
ddlb_gb.Trigger Event selectionchanged(1)

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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa502a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa502a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa502a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa502a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa502a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa502a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa502a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa502a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa502a
end type

type uc_save from w_tabsheet`uc_save within w_hpa502a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa502a
end type

type uc_print from w_tabsheet`uc_print within w_hpa502a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa502a
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa502a
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa502a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa502a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa502a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa502a
integer x = 46
integer y = 332
integer width = 4389
integer height = 1968
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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
//		em_time.enabled			=	true
//		em_limit_time.enabled	=	true
//		pb_create.enabled			=	true
//	case else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//		em_time.enabled			=	false
//		em_limit_time.enabled	=	false
//		pb_create.enabled			=	false
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
integer width = 4352
integer height = 1848
string text = "보직/직급별책임시수관리"
dw_list002 dw_list002
dw_update_tab1 dw_update_tab1
end type

on tabpage_sheet01.create
this.dw_list002=create dw_list002
this.dw_update_tab1=create dw_update_tab1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list002
this.Control[iCurrent+2]=this.dw_update_tab1
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_list002)
destroy(this.dw_update_tab1)
end on

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
integer x = 1499
integer y = 0
integer width = 2853
integer height = 1844
end type

event dw_update_tab::dragdrop;call super::dragdrop;long			ll_row
datawindow	ldw_from, ldw_to

this.Drag(End!)

if source <> this then
	ldw_from	=	source
	ldw_to	=	this

	if ldw_from.getrow() < 1 then return
	
	ll_row = ldw_to.insertrow(0)
//   if ldw_to.dataobject <> 'd_hpa502a_2' then 
		ldw_to.setitem(ll_row, 'respons_code', 	ldw_from.getitemstring(ldw_from.getrow(), 'code'))
		ldw_to.setitem(ll_row, 'respons_gb',	is_respons_gb)
		ldw_to.setitem(ll_row, 'respons_time',	integer(em_time.text))
		ldw_to.setitem(ll_row, 'limit_time',		integer(em_limit_time.text))
//	else 
//		ldw_to.setitem(ll_row,
//		ldw_to.setitem(ll_row,
//		ldw_to.setitem(ll_row,
//		ldw_to.setitem(ll_row,
		
//	end if

	ldw_to.sort()
//	ldw_from.deleterow(0)
end if	

end event

event dw_update_tab::itemchanged;call super::itemchanged;
setitem(row, 'job_uid',		gstru_uid_uname.uid)
setitem(row, 'job_add',		gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())

end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()

end event

type uo_tab from w_tabsheet`uo_tab within w_hpa502a
integer x = 1413
integer y = 280
end type

type dw_con from w_tabsheet`dw_con within w_hpa502a
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hpa502a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_list002 from uo_dwfree within tabpage_sheet01
integer x = 5
integer width = 1477
integer height = 1844
integer taborder = 30
boolean bringtotop = true
string title = "전체 단위부서"
string dataobject = "d_hpa502a_5"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event doubleclicked;call super::doubleclicked;long			ll_row
datawindow	ldw_1

ldw_1 = idw_data

if getrow() < 1 then return

ll_row = ldw_1.insertrow(0)

ldw_1.setitem(ll_row, 'respons_code', 	this.getitemstring(row, 'code'))
ldw_1.setitem(ll_row, 'respons_gb', 	is_respons_gb)
ldw_1.setitem(ll_row, 'respons_time',		integer(em_time.text))
ldw_1.setitem(ll_row, 'limit_time',		integer(em_limit_time.text))

this.deleterow(row)

end event

event clicked;call super::clicked;//This.setrow(row)
This.Drag(Begin!)
end event

event constructor;call super::constructor;This.settransobject(sqlca)
end event

type dw_update_tab1 from uo_dwfree within tabpage_sheet01
integer x = 1499
integer width = 2853
integer height = 1844
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hpa502a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
setitem(row, 'job_uid',		gstru_uid_uname.uid)
setitem(row, 'job_add',		gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())

end event

event dragdrop;call super::dragdrop;long			ll_row
datawindow	ldw_from, ldw_to

this.Drag(End!)

if source <> this then
	ldw_from	=	source
	ldw_to	=	this

	if ldw_from.getrow() < 1 then return
	
	ll_row = ldw_to.insertrow(0)
//   if ldw_to.dataobject <> 'd_hpa502a_2' then 
		ldw_to.setitem(ll_row, 'respons_code', 	ldw_from.getitemstring(ldw_from.getrow(), 'code'))
		ldw_to.setitem(ll_row, 'respons_gb',	is_respons_gb)
		ldw_to.setitem(ll_row, 'respons_time',	integer(em_time.text))
		ldw_to.setitem(ll_row, 'limit_time',		integer(em_limit_time.text))
//	else 
//		ldw_to.setitem(ll_row,
//		ldw_to.setitem(ll_row,
//		ldw_to.setitem(ll_row,
//		ldw_to.setitem(ll_row,
		
//	end if

	ldw_to.sort()
//	ldw_from.deleterow(0)
end if	

end event

event losefocus;call super::losefocus;accepttext()

end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4352
integer height = 1848
string text = "보직/직급별책임시수내역"
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
integer width = 4352
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa502a_3"
boolean vscrollbar = true
boolean border = false
end type

type st_1 from statictext within w_hpa502a
integer x = 201
integer y = 196
integer width = 416
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "선택구분"
boolean focusrectangle = false
end type

type ddlb_gb from dropdownlistbox within w_hpa502a
integer x = 535
integer y = 180
integer width = 549
integer height = 316
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
string item[] = {"1. 보직","2. 직급"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;is_respons_gb	=	string(index)

if is_respons_gb = '1' then
	idw_code.dataobject	=	'd_hpa502a_5'
	
	idw_data.dataobject	=	'd_hpa502a_1'
	
	idw_data.getchild('respons_code', idw_child)
	idw_child.settransobject(sqlca)
	if idw_child.retrieve(0) < 1 then
		idw_child.reset()
		idw_child.insertrow(0)
	end if

	idw_print.dataobject	=	'd_hpa502a_3'
	
	idw_print.getchild('respons_code', idw_child)
	idw_child.settransobject(sqlca)
	if idw_child.retrieve(0) < 1 then
		idw_child.reset()
		idw_child.insertrow(0)
	end if
else
	idw_code.dataobject	=	'd_hpa502a_6'
	idw_data.dataobject	=	'd_hpa502a_2'
	idw_print.dataobject	=	'd_hpa502a_4'
end if
idw_code.settransobject(sqlca)
idw_data.settransobject(sqlca)
idw_print.settransobject(sqlca)

idw_print.object.datawindow.print.preview = 'yes'

parent.triggerevent('ue_retrieve')
end event

type pb_create from picturebutton within w_hpa502a
integer x = 101
integer y = 4
integer width = 480
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "   전체삽입"
string picturename = "..\bmp\INSERT_E.BMP"
string disabledname = "..\bmp\INSERT_D.BMP"
vtextalign vtextalign = vcenter!
end type

event clicked;integer	li_rtn



li_rtn	=	wf_create()

if li_rtn = 0 then
	idw_data.sort()
end if






//integer	li_rtn
//
//f_setpointer('S')
//
//li_rtn	=	wf_create()
//
//if li_rtn	=	0	then
//	commit;
//	wf_setmsg('전체생성 완료')
//	f_messagebox('1', '전체 생성을 완료했습니다.!')
//	wf_retrieve()
//elseif li_rtn	< 0	then
//	commit;
//	wf_setmsg('전체생성 오류 발생')
//	f_messagebox('3', '전체 생성을 실패했습니다. 전산소에 문의하시기 바랍니다.!~n~n' + sqlca.sqlerrtext)
//elseif li_rtn	=	100	then
//	wf_setmsg('')
//end if
//
//f_setpointer('E')
end event

type em_time from editmask within w_hpa502a
integer x = 1774
integer y = 184
integer width = 160
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#0"
end type

type em_limit_time from editmask within w_hpa502a
integer x = 2258
integer y = 184
integer width = 160
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#0"
end type

type st_2 from statictext within w_hpa502a
integer x = 1509
integer y = 196
integer width = 265
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "책임시수"
boolean focusrectangle = false
end type

type st_3 from statictext within w_hpa502a
integer x = 1993
integer y = 196
integer width = 265
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "한계시수"
boolean focusrectangle = false
end type

type st_4 from statictext within w_hpa502a
integer x = 654
integer y = 24
integer width = 1307
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "※ 전체삽입을 한 후에 반드시 저장을 하셔야 합니다."
boolean focusrectangle = false
end type

