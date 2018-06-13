$PBExportHeader$w_list_list_detail.srw
$PBExportComments$Multiple List, Multiple Master, Multiple Detail Window
forward
global type w_list_list_detail from w_window
end type
type dw_list from uo_grid within w_list_list_detail
end type
type dw_con from uo_dw within w_list_list_detail
end type
type uc_row_insert from u_picture within w_list_list_detail
end type
type uc_row_delete from u_picture within w_list_list_detail
end type
type dw_sub from uo_grid within w_list_list_detail
end type
type dw_main from uo_grid within w_list_list_detail
end type
type p_1 from picture within w_list_list_detail
end type
type st_main from statictext within w_list_list_detail
end type
type p_2 from picture within w_list_list_detail
end type
type st_detail from statictext within w_list_list_detail
end type
type p_3 from picture within w_list_list_detail
end type
type st_sub from statictext within w_list_list_detail
end type
end forward

global type w_list_list_detail from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
dw_sub dw_sub
dw_main dw_main
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
p_3 p_3
st_sub st_sub
end type
global w_list_list_detail w_list_list_detail

type variables
Long				il_rv
Long				il_ret
DataWindow	idw_row_update[]

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

ldw_modified = idw_row_update

ll_dw_cnt = UpperBound(ldw_modified)

For ll_i = 1 To ll_dw_cnt
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
				ll_cnt = UpperBound(ldw_modified)
				For ll_i =  1 TO ll_cnt
					ldw_modified[ll_i].resetUpdate()
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

on w_list_list_detail.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.dw_sub=create dw_sub
this.dw_main=create dw_main
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
this.p_3=create p_3
this.st_sub=create st_sub
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uc_row_insert
this.Control[iCurrent+4]=this.uc_row_delete
this.Control[iCurrent+5]=this.dw_sub
this.Control[iCurrent+6]=this.dw_main
this.Control[iCurrent+7]=this.p_1
this.Control[iCurrent+8]=this.st_main
this.Control[iCurrent+9]=this.p_2
this.Control[iCurrent+10]=this.st_detail
this.Control[iCurrent+11]=this.p_3
this.Control[iCurrent+12]=this.st_sub
end on

on w_list_list_detail.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.dw_sub)
destroy(this.dw_main)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.p_3)
destroy(this.st_sub)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_list )
This.Event ue_resize_dw( st_line2, dw_main )
This.Event ue_resize_dw( st_line3, dw_sub )

dw_con.insertrow(0)

idw_update[1]	= dw_main
idw_update[2]	= dw_sub

idw_row_update = idw_update

//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main
//idw_Toexcel[3]	= dw_sub

//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

end event

event ue_insert;call super::ue_insert;Long		ll_rv
String		ls_txt

ll_rv = dw_main.Event ue_InsertRow()

ls_txt = "[신규] "
If ll_rv = 1 Then
	f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

end event

event ue_delete;call super::ue_delete;Long		ll_row
String		ls_txt

ls_txt = "[삭제] "
If dw_main.RowCount() > 0 Then
	If NOT dw_main.ib_multi_row Then
		If dw_main.Event ue_DeleteRow() > 0 Then
			dw_sub.uf_DeleteAll()
			If Trigger Event ue_save() <> 1 Then
				f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
			Else
				ll_row = dw_list.GetRow()
				If ll_row > 0 Then
					dw_list.DeleteRow(ll_row)
				End If
				f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
			End If
		Else
			f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
		End If
	Else
		ll_row = dw_main.GetRow()
		If ll_row > 0 Then
			dw_main.SetRow(ll_row)
			If dw_main.Event ue_DeleteRow() > 0 Then
				dw_sub.uf_DeleteAll()
				If Trigger Event ue_save() <> 1 Then
					f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
				Else
					ll_row = dw_list.GetRow()
					If ll_row > 0 Then
						dw_list.DeleteRow(ll_row)
					End If
					f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
				End If
			Else
				f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
			End If
		Else
			
		End If
	End If
End If

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = This.Event ue_updatequery() 
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

event ue_button_set;call super::ue_button_set;If uc_row_insert.Enabled Then
	uc_row_insert.Visible	= TRUE
Else
	uc_row_insert.Visible	= FALSE
End If

If uc_row_delete.Enabled Then
	uc_row_delete.Visible	= TRUE
Else
	uc_row_delete.Visible	= FALSE
End If

end event

type ln_templeft from w_window`ln_templeft within w_list_list_detail
end type

type ln_tempright from w_window`ln_tempright within w_list_list_detail
end type

type ln_temptop from w_window`ln_temptop within w_list_list_detail
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_list_list_detail
end type

type ln_tempbutton from w_window`ln_tempbutton within w_list_list_detail
end type

type ln_tempstart from w_window`ln_tempstart within w_list_list_detail
end type

type uc_retrieve from w_window`uc_retrieve within w_list_list_detail
integer width = 274
end type

type uc_insert from w_window`uc_insert within w_list_list_detail
integer width = 274
end type

type uc_delete from w_window`uc_delete within w_list_list_detail
integer width = 274
end type

type uc_save from w_window`uc_save within w_list_list_detail
integer width = 274
end type

type uc_excel from w_window`uc_excel within w_list_list_detail
integer width = 274
end type

type uc_print from w_window`uc_print within w_list_list_detail
integer width = 274
end type

type st_line1 from w_window`st_line1 within w_list_list_detail
end type

type st_line2 from w_window`st_line2 within w_list_list_detail
end type

type st_line3 from w_window`st_line3 within w_list_list_detail
end type

type uc_excelroad from w_window`uc_excelroad within w_list_list_detail
integer width = 393
end type

type dw_list from uo_grid within w_list_list_detail
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 1285
integer height = 1844
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

dw_main.Reset()
dw_sub.Reset()
ll_rv = This.Retrieve(ls_arg1, ls_arg2)

RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 And (ll_rv = 1 or ll_rv = 2) Then
	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! THEN 
		dw_main.Post Event ue_Retrieve()
	Else
		//dw_main.Post Event ue_InsertRow()
	End If
End If

il_rv = 0

end event

event rowfocuschanging;call super::rowfocuschanging;func.of_ResetArray(idw_row_update[])
idw_row_update[1] = dw_main
idw_row_update[2] = dw_sub

If newrow > 0 Then
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

event ue_deleteend;call super::ue_deleteend;If dw_sub.uf_DeleteAll() >= 0 Then
	RETURN 1
Else
	RETURN -1
End If

end event

type dw_con from uo_dw within w_list_list_detail
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uc_row_insert from u_picture within w_list_list_detail
integer x = 3890
integer y = 1288
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;If dw_main.RowCount() > 0 Then
	dw_sub.PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_list_list_detail
integer x = 4169
integer y = 1288
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_sub.PostEvent("ue_DeleteRow")

end event

type dw_sub from uo_grid within w_list_list_detail
event type long ue_retrieve ( )
integer x = 1358
integer y = 1404
integer width = 3067
integer height = 860
integer taborder = 20
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_arg1
String		ls_arg2
Long		ll_rv

ll_row = dw_main.GetRow()
If ll_row <= 0 Then RETURN -1

ls_arg1 = dw_main.object.arg1[ll_row]
ls_arg2 = dw_main.object.arg2[ll_row]

ll_rv = dw_sub.Retrieve(ls_arg1, ls_arg2)

RETURN ll_rv

end event

type dw_main from uo_grid within w_list_list_detail
event type long ue_retrieve ( )
integer x = 1358
integer y = 416
integer width = 3067
integer height = 836
integer taborder = 30
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_arg1
String		ls_arg2
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_arg1 = dw_list.object.arg1[ll_row]
ls_arg2 = dw_list.object.arg2[ll_row]

ll_rv = dw_main.Retrieve(ls_arg1, ls_arg2)
dw_sub.Reset()

RETURN ll_rv

end event

event ue_insertrow;call super::ue_insertrow;
If AncestorReturnValue = 1 Then dw_sub.Reset()

RETURN AncestorReturnValue

end event

event rowfocuschanging;call super::rowfocuschanging;func.of_ResetArray(idw_row_update[])
idw_row_update[1] = dw_sub

If newrow > 0 Then
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

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 And (ll_rv = 1 or ll_rv = 2) Then
	If dw_main.GetItemStatus(currentrow, 0, Primary!) <> New! THEN 
		dw_sub.Post Event ue_Retrieve()
	Else
		//dw_sub.Post Event ue_InsertRow()
	End If
End If

il_rv = 0

end event

type p_1 from picture within w_list_list_detail
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_list_list_detail
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

type p_2 from picture within w_list_list_detail
integer x = 1353
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_list_list_detail
integer x = 1417
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
string text = "detail desc"
boolean focusrectangle = false
end type

type p_3 from picture within w_list_list_detail
integer x = 1353
integer y = 1312
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_sub from statictext within w_list_list_detail
integer x = 1417
integer y = 1300
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
string text = "subl desc"
boolean focusrectangle = false
end type

