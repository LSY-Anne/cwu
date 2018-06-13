$PBExportHeader$w_sch103a.srw
$PBExportComments$[w_list_list]기숙사호실정보등록
forward
global type w_sch103a from w_window
end type
type dw_list from uo_grid within w_sch103a
end type
type dw_con from uo_dw within w_sch103a
end type
type dw_main from uo_grid within w_sch103a
end type
type uc_row_insert from u_picture within w_sch103a
end type
type uc_row_delete from u_picture within w_sch103a
end type
type st_main from statictext within w_sch103a
end type
type p_1 from picture within w_sch103a
end type
type p_2 from picture within w_sch103a
end type
type st_detail from statictext within w_sch103a
end type
type uo_create from uo_imgbtn within w_sch103a
end type
end forward

global type w_sch103a from w_window
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
uo_create uo_create
end type
global w_sch103a w_sch103a

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

public function integer wf_validall ();Integer	I, li_row
dwItemStatus 	l_status
String	ls_house_gb, ls_year, ls_house_cd

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

// 해당 등록된 자료를 확인하여 신규입력된 자료인 경우, 해당 관련된 Key를 Setup 한다.
li_row			= dw_list.GetRow()
ls_house_gb	= dw_list.Object.house_gb[li_row]
ls_year		= dw_con.Object.std_year[dw_con.GetRow()]
ls_house_cd	= dw_list.Object.house_cd[li_row]

For I = 1 To dw_main.RowCount()
	l_status = func.of_getrowstatus(dw_main, I)
	
	If l_status = NewModified! Then
		dw_main.Object.house_gb[i] 	= ls_house_gb
		dw_main.Object.std_year[i] 	= ls_year
		dw_main.Object.house_cd[i] 	= ls_house_cd
	End If
Next

Return 1
end function

on w_sch103a.create
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
this.uo_create=create uo_create
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
this.Control[iCurrent+10]=this.uo_create
end on

on w_sch103a.destroy
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
destroy(this.uo_create)
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
lvc_data.setProperty('column1', 'house_gb')  	//기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
lvc_data.setProperty('column2', 'std_sex')  		//성별
lvc_data.setProperty('key2', 'sex_code')
lvc_data.setProperty('column3', 'door_gb')  		//실구분
lvc_data.setProperty('key3', 'SAZ27')
lvc_data.setProperty('column4', 'door_ty')  		//지원실
lvc_data.setProperty('key4', 'SAZ36')

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

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_tempright.beginx

If uc_row_delete.Enabled Then
	uc_row_delete.X		= ll_stnd_pos - uc_row_delete.Width
	ll_stnd_pos		= ll_stnd_pos - uc_row_delete.Width - 16
	uc_row_delete.Visible	= TRUE
Else
	uc_row_delete.Visible	= FALSE
End If

If uc_row_insert.Enabled Then
	uc_row_insert.X		= ll_stnd_pos - uc_row_insert.Width
	ll_stnd_pos		= ll_stnd_pos - uc_row_insert.Width - 16
	uc_row_insert.Visible	= TRUE
Else
	uc_row_insert.Visible	= FALSE
End If

If uo_create.Enabled Then
	uo_create.X		= ll_stnd_pos - uo_create.Width
	ll_stnd_pos		= ll_stnd_pos - uo_create.Width - 16
	uo_create.Visible = TRUE
Else
	uo_create.Visible	= FALSE
End If


end event

type ln_templeft from w_window`ln_templeft within w_sch103a
end type

type ln_tempright from w_window`ln_tempright within w_sch103a
end type

type ln_temptop from w_window`ln_temptop within w_sch103a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch103a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch103a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch103a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch103a
end type

type uc_insert from w_window`uc_insert within w_sch103a
end type

type uc_delete from w_window`uc_delete within w_sch103a
end type

type uc_save from w_window`uc_save within w_sch103a
end type

type uc_excel from w_window`uc_excel within w_sch103a
end type

type uc_print from w_window`uc_print within w_sch103a
end type

type st_line1 from w_window`st_line1 within w_sch103a
end type

type st_line2 from w_window`st_line2 within w_sch103a
end type

type st_line3 from w_window`st_line3 within w_sch103a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch103a
end type

type dw_list from uo_grid within w_sch103a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 460
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch102a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
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

dw_list.SetRedraw(False)
dw_list.Reset()
dw_main.Reset()
ll_rv = This.Retrieve(ls_house_gb)

dw_list.SetRedraw(True)

RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 and (ll_rv = 1 or ll_rv = 2) Then
	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! Then
		dw_main.Post Event ue_Retrieve()
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

type dw_con from uo_dw within w_sch103a
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

type dw_main from uo_grid within w_sch103a
event type long ue_retrieve ( )
integer x = 50
integer y = 1012
integer width = 4389
integer height = 1252
integer taborder = 20
string dataobject = "d_sch103a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String	ls_house_gb, ls_year, ls_house_cd
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_house_gb 	= dw_list.Object.house_gb[ll_row]
ls_year 			= dw_con.Object.std_year[dw_con.GetRow()]
ls_house_cd 	= dw_list.Object.house_cd[ll_row]

ll_rv = dw_main.Retrieve(ls_house_gb, ls_year, ls_house_cd)

RETURN ll_rv

end event

type uc_row_insert from u_picture within w_sch103a
integer x = 3895
integer y = 900
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;If dw_list.GetRow() > 0 Then
	dw_main.PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_sch103a
integer x = 4174
integer y = 900
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_main.PostEvent("ue_DeleteRow")

end event

type st_main from statictext within w_sch103a
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
string text = "기숙사 건물정보"
boolean focusrectangle = false
end type

type p_1 from picture within w_sch103a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_sch103a
integer x = 50
integer y = 920
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_sch103a
integer x = 114
integer y = 908
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
string text = "기숙사 호실정보 등록"
boolean focusrectangle = false
end type

type uo_create from uo_imgbtn within w_sch103a
integer x = 3589
integer y = 900
integer taborder = 31
boolean bringtotop = true
string btnname = "기초자료생성"
end type

event clicked;call super::clicked;String		ls_house_gb, ls_std_year, ls_house_cd, ls_sex, ls_room_cd, ls_use_yn
Integer	li_cnt, rtn, li_row
Integer	I, J, li_tot_fl, li_fl_room

li_row = dw_list.GetRow()
ls_house_gb	= dw_list.Object.house_gb[li_row]
ls_std_year	= dw_con.Object.std_year[dw_con.GetRow()]
ls_house_cd	= dw_list.Object.house_cd[li_row]

li_tot_fl		= dw_list.Object.tot_fl[li_row]
li_fl_room	= dw_list.Object.fl_room[li_row]
ls_sex			= dw_list.Object.std_sex[li_row]
ls_use_yn	= dw_list.Object.use_yn[li_row]

If ls_use_yn = 'N' Then
	MessageBox("확인","해당 선택한 기숙사는 사용하지 않는 기숙사이므로 기초호실정보를 생성할 수 없습니다.")
	Return
End If

If MessageBox("확인","선택한 기숙사코드에 대한 기초 호실정보를 생성하시겠습니까?") = 1 Then
	// 현재 생성된 자료여부 확인
	SELECT 	Count(*)
	INTO		:li_cnt
	FROM		SCH.SAZ120D
	WHERE	HOUSE_GB	= :ls_house_gb
	AND		STD_YEAR	= :ls_std_year
	AND		HOUSE_CD	= :ls_house_cd
	USING	SQLCA ;
	
	If li_cnt > 0 Then
		rtn = MessageBox("확인","해당 선택한 기숙사에 대한 기초호실정보가 존재합니다. 재생성할까요?", Question!, YesNo!)
		If rtn = 2 Then
			Return
		End If
		
		DELETE FROM SCH.SAZ120D
		WHERE	HOUSE_GB	= :ls_house_gb
		AND		STD_YEAR	= :ls_std_year
		AND		HOUSE_CD	= :ls_house_cd
		USING	SQLCA ;
		
		If Sqlca.SqlCode < 0 Then
			MessageBox("오류","해당 기숙사 호실정보에 대한 자료를 삭세시 오류" + Sqlca.SqlErrText)
			RollBack Using Sqlca ;
			Return
		End If
	End If
	
	// 해당 기숙사 코드에 대한 층수별 호실수 만큼 자동 생성한다.
	For I = 1 To li_tot_fl
		For J = 1 To li_fl_room
			ls_room_cd = String(I, '00') + String(J, '00')
			
			INSERT INTO SCH.SAZ120D
			(HOUSE_GB, STD_YEAR, HOUSE_CD, ROOM_CD, DOOR_GB, ROOM_NM, FLOOR, SEX, DOOR_TY, AVL_PER, REMARK, WORKER, IPADDR, WORK_DATE, JOB_UID, JOB_ADD, JOB_DATE)
			SELECT	 :ls_house_gb
						,:ls_std_year
						,:ls_house_cd
						,:ls_room_cd
						,CODE
						,FNAME
						,:i
						,:ls_sex
						,Decode(ETC_QTY1,2,'A2',4,'A4')
						,ETC_QTY1
						,Null
						,:gs_empcode
						,Null
						,SYSDATE
						,:gs_empcode
						,Null
						,SYSDATE
			FROM 	CDDB.KCH102D
			WHERE	CODE_GB = 'SAZ27'
			AND		ETC_CD1 = :ls_house_gb
			AND		USE_YN = 'Y'
			USING	SQLCA ;
			
			If Sqlca.Sqlcode < 0 Then
				MessageBox("오류","해당 기숙사에 대한 호실정보를 생성시 오류" + Sqlca.SqlerrText)
				RollBack Using Sqlca ;
				Return 
			End If
		Next
	Next
Else
	Return
End If

Commit Using Sqlca ;

MessageBox("확인",ls_std_year + "년도의 기초자료가 생성되었습니다.")

dw_main.Event ue_retrieve()

Return
end event

on uo_create.destroy
call uo_imgbtn::destroy
end on

