$PBExportHeader$w_sch104a.srw
$PBExportComments$[w_list_list]관리비기준정보등록
forward
global type w_sch104a from w_window
end type
type dw_list from uo_grid within w_sch104a
end type
type dw_con from uo_dw within w_sch104a
end type
type dw_main from uo_grid within w_sch104a
end type
type uc_row_insert from u_picture within w_sch104a
end type
type uc_row_delete from u_picture within w_sch104a
end type
type st_main from statictext within w_sch104a
end type
type p_1 from picture within w_sch104a
end type
type p_2 from picture within w_sch104a
end type
type st_detail from statictext within w_sch104a
end type
end forward

global type w_sch104a from w_window
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
end type
global w_sch104a w_sch104a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE

end variables

forward prototypes
public function integer wf_validall ()
public function integer wf_dup_check (string as_gb, string as_house_gb, string as_std_year, string as_enter_term, string as_door_gb, integer ai_week)
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

public function integer wf_dup_check (string as_gb, string as_house_gb, string as_std_year, string as_enter_term, string as_door_gb, integer ai_week);Integer	li_cnt

If as_gb = '1' Then
	SELECT 	Count(*)
	INTO		:li_cnt
	FROM		SCH.SAZ130M
	WHERE	HOUSE_GB 	= :as_house_gb
	AND		STD_YEAR	= :as_std_year
	AND		ENTER_TERM	= :as_enter_term
	AND		DOOR_GB	= :as_door_gb
	USING SQLCA ;
Else
	SELECT 	Count(*)
	INTO		:li_cnt
	FROM		SCH.SAZ140M
	WHERE	HOUSE_GB 	= :as_house_gb
	AND		STD_YEAR	= :as_std_year
	AND		ENTER_TERM	= :as_enter_term
	AND		OUT_STD_WEEK	= :ai_week
	USING SQLCA ;
End If

If li_cnt > 0 Then
	Return -1
Else
	Return 1
End If
end function

on w_sch104a.create
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
end on

on w_sch104a.destroy
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
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_list )
This.Event ue_resize_dw( st_line2, dw_main )

dw_con.insertrow(0)

idw_update[1]	= dw_list
idw_update[2]	= dw_main

//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main

// 공통코드 Setup
Vector lvc_data

lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
lvc_data.setProperty('column2', 'enter_term')  //입사기간구분
lvc_data.setProperty('key2', 'SAZ29')
lvc_data.setProperty('column3', 'door_gb')  //실구분
lvc_data.setProperty('key3', 'SAZ36')
//lvc_data.setProperty('key3', 'SAZ27')

func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_list,lvc_data)
func.of_dddw( dw_main,lvc_data)

// 초기값 Setup
dw_con.Object.std_year[dw_con.GetRow()] = func.of_get_sdate( 'yyyy')

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

type ln_templeft from w_window`ln_templeft within w_sch104a
end type

type ln_tempright from w_window`ln_tempright within w_sch104a
end type

type ln_temptop from w_window`ln_temptop within w_sch104a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch104a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch104a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch104a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch104a
end type

type uc_insert from w_window`uc_insert within w_sch104a
end type

type uc_delete from w_window`uc_delete within w_sch104a
end type

type uc_save from w_window`uc_save within w_sch104a
end type

type uc_excel from w_window`uc_excel within w_sch104a
end type

type uc_print from w_window`uc_print within w_sch104a
end type

type st_line1 from w_window`st_line1 within w_sch104a
end type

type st_line2 from w_window`st_line2 within w_sch104a
end type

type st_line3 from w_window`st_line3 within w_sch104a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch104a
end type

type dw_list from uo_grid within w_sch104a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 684
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch104a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean ib_end_add = true
end type

event type long ue_retrieve();String		ls_house_gb, ls_year
Long			ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_house_gb = dw_con.object.house_gb[dw_con.GetRow()]
ls_year = dw_con.object.std_year[dw_con.GetRow()]

If ls_year = '' Or IsNull(ls_year) Then
	MessageBox("확인","학년도를 선택하셔야 합니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('std_year')
	Return 0
End If

dw_list.Reset()
dw_main.Reset()
ll_rv = This.Retrieve(ls_house_gb, ls_year)
dw_main.Retrieve(ls_house_gb, ls_year)

RETURN ll_rv

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

event itemchanged;call super::itemchanged;String		ls_house_gb, ls_std_year, ls_enter_term, ls_door_gb
Integer		li_find

Choose Case dwo.Name
	Case 'house_gb', 'std_year', 'enter_term', 'door_gb'
		ls_house_gb = This.Object.house_gb[row]
		ls_std_year = This.Object.std_year[row]
		ls_enter_term = This.Object.enter_term[row]
		ls_door_gb = This.Object.door_gb[row]
				
		If (ls_house_gb = '' Or IsNull(ls_house_gb)) Or (ls_std_year = '' Or IsNull(ls_std_year)) Or (ls_enter_term = '' Or IsNull(ls_enter_term)) Or (ls_door_gb = '' Or IsNull(ls_door_gb)) Then
		Else
			li_find = This.Find("house_gb = '" + ls_house_gb + "' and std_year = '" + ls_std_year + "' and enter_term = '" + ls_enter_term + "' and door_gb = '" + ls_door_gb + "'", 1, row - 1)
			If li_find > 0 Then
				MessageBox("확인","해당 입사기간에 대한 기 등록된 기숙사비가 존재합니다. 조회후, 정보를 수정하십시요.")
				Data = ''
				If dwo.Name = 'enter_term' Then
					This.Object.enter_term[row] = ''
				ElseIf dwo.Name = 'door_gb' Then
					This.Object.door_gb[row] = ''
				End If
				Return 2
			End If
			
			If wf_dup_check('1', ls_house_gb, ls_std_year, ls_enter_term, ls_door_gb, 0) < 0 Then
				MessageBox("확인","해당 입사기간에 대한 기 등록된 기숙사비가 존재합니다. 조회후, 정보를 수정하십시요.")
				Return 2
			End If
		End If
End Choose

end event

event ue_insertend;call super::ue_insertend;String	ls_house_gb, ls_std_year

ls_house_gb = dw_con.Object.house_gb[dw_con.GetRow()]
ls_std_year = dw_con.Object.std_year[dw_con.GetRow()]

This.Object.house_gb[al_row] = ls_house_gb
This.Object.std_year[al_row] = ls_std_year

Return 1
end event

type dw_con from uo_dw within w_sch104a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch101a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_grid within w_sch104a
event type long ue_retrieve ( )
integer x = 50
integer y = 1236
integer width = 4389
integer height = 1028
integer taborder = 20
string dataobject = "d_sch104a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

event itemchanged;call super::itemchanged;String		ls_house_gb, ls_std_year, ls_enter_term
Integer		li_find, li_week

Choose Case dwo.Name
	Case 'house_gb', 'std_year', 'enter_term', 'out_std_week'
		ls_house_gb = This.Object.house_gb[row]
		ls_std_year = This.Object.std_year[row]
		ls_enter_term = This.Object.enter_term[row]
		li_week = This.Object.out_std_week[row]
				
		If (ls_house_gb = '' Or IsNull(ls_house_gb)) Or (ls_std_year = '' Or IsNull(ls_std_year)) Or (ls_enter_term = '' Or IsNull(ls_enter_term)) Or (li_week = 0 Or IsNull(li_week)) Then
		Else
			li_find = This.Find("house_gb = '" + ls_house_gb + "' and std_year = '" + ls_std_year + "' and enter_term = '" + ls_enter_term + "' and out_std_week = " + String(li_week) + "", 1, row - 1)
			If li_find > 0 Then
				MessageBox("확인","해당 입사기간에 대한 기 등록된 반환기숙사비가 존재합니다. 조회후, 정보를 수정하십시요.")
				Data = ''
				If dwo.Name = 'enter_term' Then
					This.Object.enter_term[row] = ''
				ElseIf dwo.Name = 'out_std_week' Then
					This.Object.out_std_week[row] = 0
				End If
				Return 2
			End If
			
			If wf_dup_check('2', ls_house_gb, ls_std_year, ls_enter_term, '', li_week) < 0 Then
				MessageBox("확인","해당 입사기간에 대한 기 등록된 반환기숙사비가 존재합니다. 조회후, 정보를 수정하십시요.")
				Return 2
			End If
		End If
End Choose

end event

event ue_insertend;call super::ue_insertend;String	ls_house_gb, ls_std_year

ls_house_gb = dw_con.Object.house_gb[dw_con.GetRow()]
ls_std_year = dw_con.Object.std_year[dw_con.GetRow()]

This.Object.house_gb[al_row] = ls_house_gb
This.Object.std_year[al_row] = ls_std_year

Return 1
end event

type uc_row_insert from u_picture within w_sch104a
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

type uc_row_delete from u_picture within w_sch104a
integer x = 4174
integer y = 1124
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_main.PostEvent("ue_DeleteRow")

end event

type st_main from statictext within w_sch104a
integer x = 114
integer y = 340
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
string text = "입사 관리비 기준"
boolean focusrectangle = false
end type

type p_1 from picture within w_sch104a
integer x = 50
integer y = 356
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_sch104a
integer x = 50
integer y = 1172
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_sch104a
integer x = 114
integer y = 1160
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
string text = "중도퇴사 관리비 환불기준"
boolean focusrectangle = false
end type

