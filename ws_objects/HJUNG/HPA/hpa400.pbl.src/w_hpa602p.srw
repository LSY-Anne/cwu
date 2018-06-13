$PBExportHeader$w_hpa602p.srw
$PBExportComments$전근무지 상황 출력
forward
global type w_hpa602p from w_window
end type
type dw_con from uo_dwfree within w_hpa602p
end type
type dw_main from datawindow within w_hpa602p
end type
end forward

global type w_hpa602p from w_window
dw_con dw_con
dw_main dw_main
end type
global w_hpa602p w_hpa602p

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)
dw_main.Modify("DataWindow.Print.Preview=Yes")

ib_retrieve_wait = True

idw_print = dw_main

dw_con.object.year[1] = date(string( f_today(), '@@@@/@@/@@'))

datawindowchild ldw_child
Long ll_insRow
dw_con.GetChild('dept_code',ldw_child)
ldw_child.SetTransObject(SQLCA)
IF ldw_child.Retrieve('%') = 0 THEN
	messagebox('알림', '부서코드 입력하시기 바랍니다.')
	ldw_child.InsertRow(0)
ELSE
	ll_InsRow = ldw_child.InsertRow(0)
	ldw_child.SetItem(ll_InsRow,'gwa','9999')
	ldw_child.SetItem(ll_InsRow,'fname','없음')
	ldw_child.SetSort('code ASC')
	ldw_child.Sort()
END IF

dw_con.GetChild('jikjong_code',ldw_child)
ldw_child.SetTransObject(SQLCA)
IF ldw_child.Retrieve('jikjong_code',0) = 0 THEN
	messagebox('알림', '공통코드[직종]를 입력하시기 바랍니다.')
	ldw_child.InsertRow(0)
ELSE
	 ldw_child.InsertRow(0)
	ldw_child.SetSort('code ASC')
	ldw_child.Sort()
END IF


dw_con.Object.jikjong_code[1] = ''
dw_con.Object.jikjong_code.dddw.PercentWidth = 100
end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = This.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)

If ib_retrieve_wait Then
	gf_openwait()
End If

ll_rv = dw_main.Event ue_Retrieve()

If ll_rv > 0 Then
	f_set_message("[조회] " + String(ll_rv) + '건의 자료가 조회되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	f_set_message("[조회] " + '자료가 없습니다.', '', parentwin)
Else
	f_set_message("[조회] " + '오류가 발생했습니다.', '', parentwin)
End If

If ib_retrieve_wait Then
	gf_closewait()
End If

SetPointer(Arrow!)
ib_excl_yn = FALSE

RETURN ll_rv

end event

on w_hpa602p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hpa602p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "전근무지 상황내역")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_window`ln_templeft within w_hpa602p
end type

type ln_tempright from w_window`ln_tempright within w_hpa602p
end type

type ln_temptop from w_window`ln_temptop within w_hpa602p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hpa602p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hpa602p
end type

type ln_tempstart from w_window`ln_tempstart within w_hpa602p
end type

type uc_retrieve from w_window`uc_retrieve within w_hpa602p
end type

type uc_insert from w_window`uc_insert within w_hpa602p
end type

type uc_delete from w_window`uc_delete within w_hpa602p
end type

type uc_save from w_window`uc_save within w_hpa602p
end type

type uc_excel from w_window`uc_excel within w_hpa602p
end type

type uc_print from w_window`uc_print within w_hpa602p
end type

type st_line1 from w_window`st_line1 within w_hpa602p
end type

type st_line2 from w_window`st_line2 within w_hpa602p
end type

type st_line3 from w_window`st_line3 within w_hpa602p
end type

type uc_excelroad from w_window`uc_excelroad within w_hpa602p
end type

type dw_con from uo_dwfree within w_hpa602p
integer x = 50
integer y = 176
integer width = 4379
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa601a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.object.jaejik_opt.visible = false
this.object.jaejik_opt_t.visible = false


end event

type dw_main from datawindow within w_hpa602p
event type long ue_retrieve ( )
integer x = 50
integer y = 368
integer width = 4379
integer height = 1884
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa602p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();Long ll_rv
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

ll_rv = idw_print.retrieve(ls_dept_code, li_str_jikjong, li_end_jikjong, ls_year) 
return ll_rv
end event

event constructor;this.SetTransObject(Sqlca)
end event

