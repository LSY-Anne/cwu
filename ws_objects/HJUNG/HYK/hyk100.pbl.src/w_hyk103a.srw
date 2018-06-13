$PBExportHeader$w_hyk103a.srw
$PBExportComments$[w_list_master] 평가항목별 기준배점 등록
forward
global type w_hyk103a from w_window
end type
type dw_list from uo_grid within w_hyk103a
end type
type dw_con from uo_dw within w_hyk103a
end type
type dw_main from uo_grid within w_hyk103a
end type
type uc_row_insert from u_picture within w_hyk103a
end type
type uc_row_delete from u_picture within w_hyk103a
end type
type st_main from statictext within w_hyk103a
end type
type p_1 from picture within w_hyk103a
end type
type p_2 from picture within w_hyk103a
end type
type st_detail from statictext within w_hyk103a
end type
type uc_down from u_picture within w_hyk103a
end type
end forward

global type w_hyk103a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
dw_main dw_main
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
st_main st_main
p_1 p_1
p_2 p_2
st_detail st_detail
uc_down uc_down
end type
global w_hyk103a w_hyk103a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE

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

on w_hyk103a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.st_main=create st_main
this.p_1=create p_1
this.p_2=create p_2
this.st_detail=create st_detail
this.uc_down=create uc_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.uc_row_insert
this.Control[iCurrent+5]=this.uc_row_delete
this.Control[iCurrent+6]=this.st_main
this.Control[iCurrent+7]=this.p_1
this.Control[iCurrent+8]=this.p_2
this.Control[iCurrent+9]=this.st_detail
this.Control[iCurrent+10]=this.uc_down
end on

on w_hyk103a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.st_main)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.uc_down)
end on

event ue_postopen;call super::ue_postopen;string ls_std_ym,ls_appoint_gb
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_list )
This.Event ue_resize_dw( st_line2, dw_main )

dw_con.insertrow(0)

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'appoint_gb')  //임용구분
lvc_data.setProperty('key1', 'HYK02')
lvc_data.setProperty('column2', 'evl_area')  //평가영역
lvc_data.setProperty('key2', 'HYK01')
func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_list,lvc_data)
func.of_dddw( dw_main,lvc_data)

SELECT MAX(STD_YM)
INTO :ls_std_ym
FROM YGDB.HYK103T
USING SQLCA ;

dw_con.object.std_ym[dw_con.getrow()] = ls_std_ym

SELECT MIN(appoint_gb)
INTO :ls_appoint_gb
FROM YGDB.HYK103T
WHERE STD_YM = :ls_std_ym
USING SQLCA ;

dw_con.object.appoint_gb[dw_con.getrow()] = ls_appoint_gb

//idw_update[1]	= dw_list
idw_update[1]	= dw_main
dw_list.Event ue_Retrieve()
this.post event ue_inquiry()	
dw_list.setfocus()

//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main

//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

end event

event ue_insert;call super::ue_insert;Long		ll_rv
String		ls_txt

ll_rv = dw_list.Event ue_InsertRow()

ls_txt = "[신규] "
If ll_rv = 1 Then
	f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

end event

event ue_delete;call super::ue_delete;Long		ll_rv
String		ls_txt

ll_rv = dw_list.Event ue_DeleteRow()

ls_txt = "[삭제] "
If ll_rv = 1 Then
	If Trigger Event ue_save() <> 1 Then
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	Else
		f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
	End If
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

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

type ln_templeft from w_window`ln_templeft within w_hyk103a
end type

type ln_tempright from w_window`ln_tempright within w_hyk103a
end type

type ln_temptop from w_window`ln_temptop within w_hyk103a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyk103a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyk103a
end type

type ln_tempstart from w_window`ln_tempstart within w_hyk103a
end type

type uc_retrieve from w_window`uc_retrieve within w_hyk103a
end type

type uc_insert from w_window`uc_insert within w_hyk103a
end type

type uc_delete from w_window`uc_delete within w_hyk103a
end type

type uc_save from w_window`uc_save within w_hyk103a
end type

type uc_excel from w_window`uc_excel within w_hyk103a
end type

type uc_print from w_window`uc_print within w_hyk103a
end type

type st_line1 from w_window`st_line1 within w_hyk103a
end type

type st_line2 from w_window`st_line2 within w_hyk103a
end type

type st_line3 from w_window`st_line3 within w_hyk103a
end type

type uc_excelroad from w_window`uc_excelroad within w_hyk103a
end type

type dw_list from uo_grid within w_hyk103a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 684
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyk103a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_std_ym ,ls_appoint_gb
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_std_ym = dw_con.object.std_ym[dw_con.GetRow()]
ls_appoint_gb = dw_con.object.appoint_gb[dw_con.GetRow()]

dw_main.Reset()
ll_rv = This.Retrieve(ls_std_ym, ls_appoint_gb)
If ll_rv = 0 Then
	
	dw_main.Reset()
	dw_main.event ue_insertrow()

Else

	
End If
RETURN ll_rv
end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 and (ll_rv = 1 or ll_rv = 2) Then
	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! Then
//		dw_main.Post Event ue_Retrieve()
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

event ue_deletestart;call super::ue_deletestart;Long		ll_cnt

If dw_list.GetRow() > 0 Then

	ll_cnt = dw_main.RowCount()
	
	If ll_cnt > 0 Then
//		gf_message(parentwin, 2, '9999', '알림', '해당 데이터에 대한 자식데이타가 존재합니다. 삭제할 수 없습니다.')
//		RETURN -1
		dw_main.uf_DeleteAll()
		RETURN 1
	Else
		RETURN 1
	End If

Else
	RETURN 1
End If

end event

type dw_con from uo_dw within w_hyk103a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyk103a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_grid within w_hyk103a
event type long ue_retrieve ( )
integer x = 50
integer y = 1236
integer width = 4389
integer height = 1028
integer taborder = 20
string dataobject = "d_hyk103a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event type long ue_retrieve();Long		ll_row
String		ls_std_ym, ls_appoint_gb
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_std_ym = dw_con.object.std_ym[dw_con.GetRow()]
ls_appoint_gb = dw_con.object.appoint_gb[dw_con.GetRow()]

ll_rv = dw_main.Retrieve(ls_std_ym, ls_appoint_gb)

RETURN ll_rv

end event

type uc_row_insert from u_picture within w_hyk103a
integer x = 3895
integer y = 1124
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;If dw_list.GetRow() > 0 Then
	dw_main.PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_hyk103a
integer x = 4174
integer y = 1124
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_main.PostEvent("ue_DeleteRow")

end event

type st_main from statictext within w_hyk103a
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
string text = "기준배점"
boolean focusrectangle = false
end type

type p_1 from picture within w_hyk103a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_hyk103a
integer x = 50
integer y = 1144
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hyk103a
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
string text = "평가항목별 기준배점"
boolean focusrectangle = false
end type

type uc_down from u_picture within w_hyk103a
integer x = 1600
integer y = 1112
integer width = 146
integer height = 108
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_down.GIF"
end type

event clicked;call super::clicked;Long		ll_row
String		ls_std_ym, ls_appoint_gb, ls_evl_area, ls_evl_item, ls_chk, ls_evl_nm
Long		ll_i, ll_rowcnt, ll_find

//ll_row = dw_list.GetRow()
//If ll_row <= 0 Then RETURN -1

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_std_ym = dw_con.object.std_ym[dw_con.GetRow()]
ls_appoint_gb = dw_con.object.appoint_gb[dw_con.GetRow()]

ll_rowcnt = dw_list.rowcount()
for ll_i = 1 to ll_rowcnt
	ls_chk = dw_list.object.chk[ll_i]
	ls_evl_area = dw_list.object.evl_area[ll_i]
    ls_evl_item = dw_list.object.evl_item[ll_i]
    ls_evl_nm = dw_list.object.evl_nm[ll_i]
	if ls_chk = 'Y' then 
		ll_find = dw_main.find("std_ym = '" + ls_std_ym + "' and appoint_gb = '" + ls_appoint_gb +"'" &
		+ " and evl_area = '" + ls_evl_area + "' and evl_item = '" + ls_evl_item + "'", &
        1, dw_main.RowCount())

 		if ll_find = 0 then
			ll_find = dw_main.insertrow(0)
			dw_main.object.std_ym[ll_find] = ls_std_ym
			dw_main.object.appoint_gb[ll_find] = ls_appoint_gb
			dw_main.object.evl_area[ll_find] = ls_evl_area
			dw_main.object.evl_item[ll_find] = ls_evl_item
			dw_main.object.evl_nm[ll_find] = ls_evl_nm
		end if
	end if


next 

end event

