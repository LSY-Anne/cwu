$PBExportHeader$w_list_tab.srw
$PBExportComments$Multiple List, tab Window
forward
global type w_list_tab from w_window
end type
type dw_list from uo_grid within w_list_tab
end type
type dw_con from uo_dw within w_list_tab
end type
type tab_1 from tab within w_list_tab
end type
type tabpage_1 from userobject within tab_1
end type
type st_tab1_line from statictext within tabpage_1
end type
type dw_tab1 from uo_grid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_tab1_line st_tab1_line
dw_tab1 dw_tab1
end type
type tabpage_2 from userobject within tab_1
end type
type st_tab2_line from statictext within tabpage_2
end type
type dw_tab2 from uo_grid within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_tab2_line st_tab2_line
dw_tab2 dw_tab2
end type
type tabpage_3 from userobject within tab_1
end type
type st_tab3_line from statictext within tabpage_3
end type
type dw_tab3 from uo_grid within tabpage_3
end type
type tabpage_3 from userobject within tab_1
st_tab3_line st_tab3_line
dw_tab3 dw_tab3
end type
type tab_1 from tab within w_list_tab
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_1 from u_tab within w_list_tab
end type
type p_1 from picture within w_list_tab
end type
type st_main from statictext within w_list_tab
end type
type p_2 from picture within w_list_tab
end type
type st_detail from statictext within w_list_tab
end type
end forward

global type w_list_tab from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
tab_1 tab_1
uo_1 uo_1
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
end type
global w_list_tab w_list_tab

type variables
Long				il_rv
Long				il_ret
DataWindow	idw_tab[]
Boolean			ib_list_chk	=	FALSE

end variables

forward prototypes
public function integer wf_validall ()
end prototypes

event type long ue_row_updatequery();Long				ll_rv
Long				ll_cnt = 0
Long				ll_i
DataWindow	ldw_modified[]
Long				ll_dw_cnt

If Not uc_save.Enabled Then RETURN 1

If UpperBound(idw_modified) = 0 Then
	ldw_modified = idw_update
Else
	ldw_modified = idw_modified
End If

ll_dw_cnt = UpperBound(ldw_modified)

For ll_i = 1 To ll_dw_cnt
	If ib_list_chk	=	FALSE and ldw_modified[ll_i] = dw_list Then Continue
	ldw_modified[ll_i].AcceptText()
//	ll_cnt += ldw_modified[ll_i].uf_ModifiedCount()
	ll_cnt += (ldw_modified[ll_i].ModifiedCount() + ldw_modified[ll_i].DeletedCount())
Next

If ll_cnt > 0 Then
	ll_rv = gf_message(parentwin, 2, '0007', '', '')
	Choose Case ll_rv
		Case 1
			If This.Event ue_save() = 1 Then 
				RETURN 1
			Else
				RETURN -1
			End IF
		Case 2
			If ib_updatequery_resetupdate Then
				ll_cnt = UpperBound(idw_update)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_update[ll_i] = dw_list Then Continue
					idw_update[ll_i].resetUpdate()
				Next
				ll_cnt = UpperBound(idw_modified)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_modified[ll_i] = dw_list Then Continue
					idw_modified[ll_i].resetUpdate()
				Next
			End If
			RETURN 2			
		Case 3
			RETURN 3
	End Choose 	
Else
	RETURN 1
End If

RETURN 1

end event

public function integer wf_validall ();Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

end function

on w_list_tab.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.tab_1=create tab_1
this.uo_1=create uo_1
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.st_main
this.Control[iCurrent+7]=this.p_2
this.Control[iCurrent+8]=this.st_detail
end on

on w_list_tab.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_list )
This.Event ue_resize_dw( tab_1.tabpage_1.st_tab1_line, tab_1.tabpage_1.dw_tab1 )
This.Event ue_resize_dw( tab_1.tabpage_2.st_tab2_line, tab_1.tabpage_2.dw_tab2 )
This.Event ue_resize_dw( tab_1.tabpage_3.st_tab3_line, tab_1.tabpage_3.dw_tab3 )
//만일 dw_tab1, dw_tab2, dw_tab3가 Single Row이면 uo_dw를 사용하여
//dw_tab1, dw_tab2, dw_tab3를 만들고
//func.of_design_dw( tab_1.tabpage_1.dw_tab1 )
//func.of_design_dw( tab_1.tabpage_2.dw_tab2 )
//func.of_design_dw( tab_1.tabpage_3.dw_tab3 )

dw_con.insertrow(0)

idw_update[1]	= tab_1.tabpage_1.dw_tab1
idw_update[2]	= tab_1.tabpage_2.dw_tab2
idw_update[3]	= tab_1.tabpage_3.dw_tab3
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= tab_1.tabpage_1.dw_tab1
//idw_Toexcel[3]	= tab_1.tabpage_2.dw_tab2
//idw_Toexcel[4]	= tab_1.tabpage_3.dw_tab3

idw_tab[1] = tab_1.tabpage_1.dw_tab1
idw_tab[2] = tab_1.tabpage_2.dw_tab2
idw_tab[3] = tab_1.tabpage_3.dw_tab3

tab_1.tabpage_1.dw_tab1.iw_parent = This
tab_1.tabpage_2.dw_tab2.iw_parent = This
tab_1.tabpage_3.dw_tab3.iw_parent = This

tab_1.tabpage_1.dw_tab1.Width	= tab_1.Width	- 60
tab_1.tabpage_2.dw_tab2.Width	= tab_1.Width	- 60
tab_1.tabpage_3.dw_tab3.Width	= tab_1.Width	- 60
tab_1.tabpage_1.dw_tab1.Height	= tab_1.Height	- 144
tab_1.tabpage_2.dw_tab2.Height	= tab_1.Height	- 144
tab_1.tabpage_3.dw_tab3.Height	= tab_1.Height	- 144

//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

end event

event ue_insert;call super::ue_insert;tab_1.tabpage_1.dw_tab1.PostEvent("ue_InsertRow")
tab_1.tabpage_2.dw_tab2.PostEvent("ue_InsertRow")
tab_1.tabpage_3.dw_tab3.PostEvent("ue_InsertRow")

end event

event ue_delete;call super::ue_delete;Long		ll_row
String		ls_txt

ls_txt = "[삭제] "
tab_1.tabpage_1.dw_tab1.uf_DeleteAll()
tab_1.tabpage_2.dw_tab2.uf_DeleteAll()
tab_1.tabpage_3.dw_tab3.uf_DeleteAll()

If Trigger Event ue_save() <> 1 Then
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
Else
	ll_row = dw_list.GetRow()
	If ll_row > 0 Then
		dw_list.DeleteRow(ll_row)
	End If
	f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
End If

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = THIS.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)
If ib_retrieve_wait Then
	gf_openwait()
End If
ll_rv = dw_list.Event ue_Retrieve()
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

type ln_templeft from w_window`ln_templeft within w_list_tab
end type

type ln_tempright from w_window`ln_tempright within w_list_tab
end type

type ln_temptop from w_window`ln_temptop within w_list_tab
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_list_tab
end type

type ln_tempbutton from w_window`ln_tempbutton within w_list_tab
end type

type ln_tempstart from w_window`ln_tempstart within w_list_tab
end type

type uc_retrieve from w_window`uc_retrieve within w_list_tab
integer width = 274
end type

type uc_insert from w_window`uc_insert within w_list_tab
integer width = 274
end type

type uc_delete from w_window`uc_delete within w_list_tab
integer width = 274
end type

type uc_save from w_window`uc_save within w_list_tab
integer width = 274
end type

type uc_excel from w_window`uc_excel within w_list_tab
integer width = 274
end type

type uc_print from w_window`uc_print within w_list_tab
integer width = 274
end type

type st_line1 from w_window`st_line1 within w_list_tab
end type

type st_line2 from w_window`st_line2 within w_list_tab
end type

type st_line3 from w_window`st_line3 within w_list_tab
end type

type uc_excelroad from w_window`uc_excelroad within w_list_tab
integer width = 393
end type

type dw_list from uo_grid within w_list_tab
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 700
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_Retrieve();String		ls_arg1
String		ls_arg2
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_arg1 = dw_con.object.arg1[dw_con.GetRow()]
ls_arg2 = dw_con.object.arg2[dw_con.GetRow()]

tab_1.tabpage_1.dw_tab1.Reset()
tab_1.tabpage_2.dw_tab2.Reset()
tab_1.tabpage_3.dw_tab3.Reset()

ll_rv = This.Retrieve(ls_arg1, ls_arg2)

RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv
String		ls_arg1
String		ls_arg2

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 And (ll_rv = 1 or ll_rv = 2) Then
	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! Then
		ls_arg1 = This.Object.arg_key1[currentrow]
		ls_arg2 = This.Object.arg_key2[currentrow]
		tab_1.tabpage_1.dw_tab1.Post Retrieve(ls_arg1, ls_arg2)
		tab_1.tabpage_2.dw_tab2.Post Retrieve(ls_arg1, ls_arg2)
		tab_1.tabpage_3.dw_tab3.Post Retrieve(ls_arg1, ls_arg2)
	Else
		//dw_main.Post Event ue_InsertRow()
	End If
End If

il_rv = 0

end event

event rowfocuschanging;call super::rowfocuschanging;If newrow > 0 Then
	If il_rv = 0 Then
		il_ret = Parent.Event ue_row_updatequery()
		Choose Case il_ret
			Case 3, -1
				il_rv ++
				If il_rv > 1 Then
					il_rv = 0
				End If
				RETURN 1
			Case 2
				il_rv = 0
				RETURN 0
			Case Else
				il_rv = 0
				RETURN 0
		End Choose
	Else
		Choose Case il_ret
			Case 3, -1
				il_rv ++
				If il_rv > 1 Then
					il_rv = 0
				End If
				RETURN 1
			Case 2
				il_rv = 0
				RETURN 0
			Case Else
				il_rv = 0
				RETURN 0
		End Choose
	End If
Else
	il_rv = 0
	RETURN 0
End If

end event

type dw_con from uo_dw within w_list_tab
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type tab_1 from tab within w_list_tab
integer x = 50
integer y = 1236
integer width = 4389
integer height = 1028
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean raggedright = true
boolean showpicture = false
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4352
integer height = 916
long backcolor = 16777215
string text = "tab1"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_tab1_line st_tab1_line
dw_tab1 dw_tab1
end type

on tabpage_1.create
this.st_tab1_line=create st_tab1_line
this.dw_tab1=create dw_tab1
this.Control[]={this.st_tab1_line,&
this.dw_tab1}
end on

on tabpage_1.destroy
destroy(this.st_tab1_line)
destroy(this.dw_tab1)
end on

type st_tab1_line from statictext within tabpage_1
boolean visible = false
integer x = 137
integer y = 28
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_tab1 from uo_grid within tabpage_1
integer x = 9
integer y = 36
integer width = 4325
integer height = 876
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event ue_constructor;call super::ue_constructor;iw_parent = Parent.GetParent().GetParent()

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4352
integer height = 916
long backcolor = 16777215
string text = "tab2"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_tab2_line st_tab2_line
dw_tab2 dw_tab2
end type

on tabpage_2.create
this.st_tab2_line=create st_tab2_line
this.dw_tab2=create dw_tab2
this.Control[]={this.st_tab2_line,&
this.dw_tab2}
end on

on tabpage_2.destroy
destroy(this.st_tab2_line)
destroy(this.dw_tab2)
end on

type st_tab2_line from statictext within tabpage_2
boolean visible = false
integer x = 187
integer y = 32
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_tab2 from uo_grid within tabpage_2
integer x = 9
integer y = 20
integer width = 4325
integer height = 732
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event ue_constructor;call super::ue_constructor;iw_parent = Parent.GetParent().GetParent()

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4352
integer height = 916
long backcolor = 16777215
string text = "tab3"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_tab3_line st_tab3_line
dw_tab3 dw_tab3
end type

on tabpage_3.create
this.st_tab3_line=create st_tab3_line
this.dw_tab3=create dw_tab3
this.Control[]={this.st_tab3_line,&
this.dw_tab3}
end on

on tabpage_3.destroy
destroy(this.st_tab3_line)
destroy(this.dw_tab3)
end on

type st_tab3_line from statictext within tabpage_3
boolean visible = false
integer x = 155
integer y = 20
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_tab3 from uo_grid within tabpage_3
integer x = 9
integer y = 20
integer width = 4325
integer height = 732
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event ue_constructor;call super::ue_constructor;iw_parent = Parent.GetParent().GetParent()

end event

type uo_1 from u_tab within w_list_tab
integer x = 411
integer y = 1152
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call u_tab::destroy
end on

type p_1 from picture within w_list_tab
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_list_tab
integer x = 114
integer y = 312
integer width = 1051
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "main desc"
boolean focusrectangle = false
end type

type p_2 from picture within w_list_tab
integer x = 50
integer y = 1144
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_list_tab
integer x = 114
integer y = 1132
integer width = 1051
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "detail desc"
boolean focusrectangle = false
end type

