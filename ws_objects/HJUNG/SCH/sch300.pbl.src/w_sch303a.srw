$PBExportHeader$w_sch303a.srw
$PBExportComments$늦은귀사신청내역등록
forward
global type w_sch303a from w_window
end type
type dw_list from uo_grid within w_sch303a
end type
type dw_con from uo_dw within w_sch303a
end type
type dw_main from uo_dw within w_sch303a
end type
type p_1 from picture within w_sch303a
end type
type st_main from statictext within w_sch303a
end type
type p_2 from picture within w_sch303a
end type
type st_detail from statictext within w_sch303a
end type
end forward

global type w_sch303a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
dw_main dw_main
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
end type
global w_sch303a w_sch303a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE
String		is_data[]

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

public function integer wf_validall ();Integer	li_rtn, i, li_req_no
String		ls_req_dt

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

// 신청순번을 최종번호 확인하여 Setting 한다.
ls_req_dt = dw_main.Object.req_dt[dw_main.GetRow()]

SELECT 	NVL(MAX(REQ_NO), 0) + 1
INTO		:li_req_no
FROM		SCH.SAZ310T
WHERE	HOUSE_GB	= :is_data[1]
AND		REQ_DT		= :ls_req_dt
USING SQLCA ;

If isNull(li_req_no) Then li_req_no = 1

end function

on w_sch303a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.dw_main=create dw_main
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.st_main
this.Control[iCurrent+6]=this.p_2
this.Control[iCurrent+7]=this.st_detail
end on

on w_sch303a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_list )

dw_con.InsertRow(0)
dw_main.InsertRow(0)

idw_update[1]	= dw_main
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main

// 사용자에 대한 정보를 확인
uo_hjfunc 	hjfunc
Vector		lvc_data
Integer		li_rtn, i

hjfunc		= Create uo_hjfunc
lvc_data = Create Vector

lvc_data.setProperty('column1', 'process_gb')  //처리상태
lvc_data.setProperty('key1', 'SAZ31')
lvc_data.setProperty('column1', 'reason_gb')  //늦은귀사사유
lvc_data.setProperty('key1', 'SAZ33')

func.of_dddw( dw_list,lvc_data)
func.of_dddw( dw_main,lvc_data)

// 초기값 Setup
dw_con.Object.from_date[dw_con.GetRow()] 	= func.of_get_sdate('yyyy') + '0101'
dw_con.Object.to_date[dw_con.GetRow()] 	= func.of_get_sdate('yyyymmdd')

li_rtn = hjfunc.of_search_house(lvc_data)

If li_rtn = 1 Then
	is_data[1]	= lvc_data.GetProperty('house_gb')
	is_data[2]	= lvc_data.GetProperty('std_year')
	is_data[3]	= lvc_data.GetProperty('allcate_no')
	is_data[4]	= lvc_data.GetProperty('recruit_no')
	is_data[5]	= lvc_data.GetProperty('house_req_no')
	is_data[6]	= lvc_data.GetProperty('house_cd')
	is_data[7]	= lvc_data.GetProperty('room_cd')
	is_data[8]	= lvc_data.GetProperty('door_gb')
	is_data[9]	= lvc_data.GetProperty('door_no')
Else
	For i = 1 To 9
		is_data[1]	= ''
	Next
	uc_insert.of_enable(False)
	uc_delete.of_enable(False)
	uc_save.of_enable(False)
	f_set_message("[확인] " + '늦은귀사신청을 할 수 있는 사생이 아닙니다. 기존자료가 존재한다면 조회만 가능합니다', '', parentwin)	
End If

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

event ue_delete;call super::ue_delete;Long		ll_rv
String		ls_txt
Long		ll_row

ll_rv = dw_main.Event ue_DeleteRow()

ls_txt = "[삭제] "
If ll_rv = 1 Then
	If Trigger Event ue_save() <> 1 Then
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	Else
		ll_row = dw_list.GetRow()
		If ll_row > 0 Then
			dw_list.DeleteRow(ll_row)
		End If
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

type ln_templeft from w_window`ln_templeft within w_sch303a
end type

type ln_tempright from w_window`ln_tempright within w_sch303a
end type

type ln_temptop from w_window`ln_temptop within w_sch303a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch303a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch303a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch303a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch303a
end type

type uc_insert from w_window`uc_insert within w_sch303a
end type

type uc_delete from w_window`uc_delete within w_sch303a
end type

type uc_save from w_window`uc_save within w_sch303a
end type

type uc_excel from w_window`uc_excel within w_sch303a
end type

type uc_print from w_window`uc_print within w_sch303a
end type

type st_line1 from w_window`st_line1 within w_sch303a
end type

type st_line2 from w_window`st_line2 within w_sch303a
end type

type st_line3 from w_window`st_line3 within w_sch303a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch303a
end type

type dw_list from uo_grid within w_sch303a
event type long ue_retrieve ( )
integer x = 50
integer y = 400
integer width = 4389
integer height = 912
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch303a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_fr_dt, ls_to_dt
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_fr_dt = dw_con.Object.from_date[dw_con.GetRow()]
ls_to_dt = dw_con.Object.to_date[dw_con.GetRow()]

dw_list.SetRedraw(False)
dw_list.Reset()
dw_main.Reset()
ll_rv = This.Retrieve(gs_empcode, ls_fr_dt, ls_to_dt)
dw_list.SetRedraw(True)

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

type dw_con from uo_dw within w_sch303a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch301a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dw within w_sch303a
event type long ue_retrieve ( )
integer x = 50
integer y = 1440
integer width = 4389
integer height = 824
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch303a_3"
boolean controlmenu = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row, ll_req_no
String		ls_house_gb, ls_req_dt
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_house_gb 	= dw_list.Object.house_gb[ll_row]
ls_req_dt 		= dw_list.Object.req_dt[ll_row]
ll_req_no 		= dw_list.Object.req_no[ll_row]

ll_rv = dw_main.Retrieve(ls_house_gb, ls_req_dt, ll_req_no)

RETURN ll_rv

end event

event ue_insertend;call super::ue_insertend;// 초기 Value Setting

This.Object.house_gb[al_row] 		= is_data[1]
This.Object.req_dt[al_row] 			= func.of_get_sdate('yyyymmdd')
This.Object.std_year[al_row] 		= is_data[2]
This.Object.allocate_no[al_row] 	= is_data[3]
This.Object.hakbun[al_row] 		= gs_empcode
This.Object.hname[al_row] 			= gs_empname
This.Object.process_gb[al_row] 	= '01'

Return 1

end event

type p_1 from picture within w_sch303a
integer x = 50
integer y = 336
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_sch303a
integer x = 114
integer y = 320
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
string text = "늦은귀사신청내역"
boolean focusrectangle = false
end type

type p_2 from picture within w_sch303a
integer x = 50
integer y = 1356
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_sch303a
integer x = 114
integer y = 1344
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
string text = "늦은귀사신청등록"
boolean focusrectangle = false
end type

