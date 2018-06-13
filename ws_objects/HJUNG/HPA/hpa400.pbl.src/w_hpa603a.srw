$PBExportHeader$w_hpa603a.srw
$PBExportComments$연말정산결과조회
forward
global type w_hpa603a from w_window
end type
type dw_list from uo_grid within w_hpa603a
end type
type dw_con from uo_dw within w_hpa603a
end type
type dw_main from uo_grid within w_hpa603a
end type
type uc_row_insert from u_picture within w_hpa603a
end type
type uc_row_delete from u_picture within w_hpa603a
end type
type st_main from statictext within w_hpa603a
end type
type p_1 from picture within w_hpa603a
end type
type p_2 from picture within w_hpa603a
end type
type st_detail from statictext within w_hpa603a
end type
end forward

global type w_hpa603a from w_window
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
global w_hpa603a w_hpa603a

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

on w_hpa603a.create
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

on w_hpa603a.destroy
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

This.Event ue_resize_dw( st_line1, dw_list )
This.Event ue_resize_dw( st_line2, dw_main )



idw_update[1]	= dw_list
idw_update[2]	= dw_main
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


DataWindowChild	ldwc_Temp
long 		ll_insrow

//uo_year.st_title.text = '기준년도'
//is_year	=	uo_year.uf_getyy()

dw_con.object.year[1] = String(long(left(f_today(),4)) - 1)
//

dw_con.GetChild('dept_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	messagebox('알림', '부서코드 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa','9999')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF


//f_getdwcommon(dw_con, 'jikjong_code', 0, 750)

dw_con.GetChild('jikjong_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	messagebox('알림','공통코드[직종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF


dw_con.Object.jikjong_code[1] = ''
dw_con.Object.jikjong_code.dddw.PercentWidth = 100


////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 재직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('jaejik_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
	messagebox('알림','공통코드[재직]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	//ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.setfilter("code = '1' or code = '2'" )
	ldwc_Temp.filter()
//	ldwc_Temp.SetItem(ll_InsRow,'code','1')
//	ldwc_Temp.SetItem(ll_InsRow,'fname','재직')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
END IF

//dw_con.Object.jaejik_opt[1] = ''
dw_con.Object.jaejik_opt.dddw.PercentWidth = 100

func.of_design_con( dw_con )
dw_con.insertrow(0)
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

type ln_templeft from w_window`ln_templeft within w_hpa603a
end type

type ln_tempright from w_window`ln_tempright within w_hpa603a
end type

type ln_temptop from w_window`ln_temptop within w_hpa603a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hpa603a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hpa603a
end type

type ln_tempstart from w_window`ln_tempstart within w_hpa603a
end type

type uc_retrieve from w_window`uc_retrieve within w_hpa603a
end type

type uc_insert from w_window`uc_insert within w_hpa603a
end type

type uc_delete from w_window`uc_delete within w_hpa603a
end type

type uc_save from w_window`uc_save within w_hpa603a
end type

type uc_excel from w_window`uc_excel within w_hpa603a
end type

type uc_print from w_window`uc_print within w_hpa603a
end type

type st_line1 from w_window`st_line1 within w_hpa603a
end type

type st_line2 from w_window`st_line2 within w_hpa603a
end type

type st_line3 from w_window`st_line3 within w_hpa603a
end type

type uc_excelroad from w_window`uc_excelroad within w_hpa603a
end type

type dw_list from uo_grid within w_hpa603a
event type long ue_retrieve ( )
integer x = 50
integer y = 380
integer width = 4389
integer height = 732
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa603a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event type long ue_retrieve();String ls_year, ls_dept_code, ls_jikjong, ls_jaejik_opt, ls_gu
Integer	li_str_jikjong, li_end_jikjong
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If


ls_year = func.of_nvl(left(dw_con.object.year[1], 4), '')
ls_dept_code = func.of_nvl(dw_con.object.dept_code[1], '')
If ls_dept_code = '' Or isnull(ls_dept_code) Then ls_dept_code = '%'
ls_jikjong = trim(dw_con.object.jikjong_code[1])

if isnull(ls_jikjong) or trim(ls_jikjong) = '0' or trim(ls_jikjong) = '' then	
	li_str_jikjong	=	0
	li_end_jikjong	=	9
else
	li_str_jikjong = integer(trim(ls_jikjong))
	li_end_jikjong = integer(trim(ls_jikjong))
end if

ls_jaejik_opt = func.of_nvl(dw_con.object.jaejik_opt[1], '0')
If ls_jaejik_opt = '' or isnull(ls_jaejik_opt) then ls_jaejik_opt = '0'
ls_gu = func.of_nvl(dw_con.object.gu[1], '%')

dw_main.Reset()
ll_rv = THIS.retrieve(ls_year, ls_dept_code, li_str_jikjong, li_end_jikjong, ls_jaejik_opt, ls_gu)
If ll_rv > 0 Then
	dw_main.retrieve(ls_year, ls_dept_code, li_str_jikjong, li_end_jikjong,  ls_jaejik_opt,  ls_gu)
End If



RETURN ll_rv

end event

event rowfocuschanged;call super::rowfocuschanged;//Long		ll_rv
//
//This.AcceptText()
//
//ll_rv = Parent.Event ue_row_updatequery() 
//
//If currentrow > 0 and (ll_rv = 1 or ll_rv = 2) Then
//	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! Then
//		dw_main.Post Event ue_Retrieve()
//	Else
//		//dw_main.Post Event ue_InsertRow()
//	End If
//End If
//
//
//il_rv = 0
//
end event

event rowfocuschanging;call super::rowfocuschanging;//If newrow > 0 Then
//	If il_rv = 0 Then
//		il_ret = Parent.Event ue_row_updatequery()
//		Choose Case il_ret
//			Case 3, -1
//				il_rv ++
//				If il_rv > 1 Then
//					il_rv = 0
//				End If
//				RETURN 1
//			Case 2
//				il_rv = 0
//				RETURN 0
//			Case Else
//				il_rv = 0
//				RETURN 0
//		End Choose
//	Else
//		Choose Case il_ret
//			Case 3, -1
//				il_rv ++
//				If il_rv > 1 Then
//					il_rv = 0
//				End If
//				RETURN 1
//			Case 2
//				il_rv = 0
//				RETURN 0
//			Case Else
//				il_rv = 0
//				RETURN 0
//		End Choose
//	End If
//Else
//	il_rv = 0
//	RETURN 0
//End If
//
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

event clicked;call super::clicked;If row > 0 Then
	Long ll_find
	String ls_member
	
	ls_member = This.object.member_no[row]
	
	ll_find = dw_main.find("member_no = '" + ls_member + "'" , 1, dw_main.rowcount())
	If ll_find > 0 Then
		dw_main.scrolltorow(ll_find)
	End if
End If
end event

type dw_con from uo_dw within w_hpa603a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa603a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_grid within w_hpa603a
event type long ue_retrieve ( )
integer x = 50
integer y = 1192
integer width = 4389
integer height = 1072
integer taborder = 20
string dataobject = "d_hpa603a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event type long ue_Retrieve();Long		ll_row
String		ls_arg1
String		ls_arg2
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_arg1 = dw_list.object.arg1[ll_row]
ls_arg2 = dw_list.object.arg2[ll_row]

ll_rv = dw_main.Retrieve(ls_arg1, ls_arg2)

RETURN ll_rv

end event

event clicked;call super::clicked;If row > 0 Then
	Long ll_find
	String ls_member
	
	ls_member = This.object.member_no[row]
	
	ll_find = dw_list.find("member_no = '" + ls_member + "'" , 1, dw_list.rowcount())
	If ll_find > 0 Then
		dw_list.scrolltorow(ll_find)
	End if
End If
end event

event retrieveend;call super::retrieveend;If rowcount > 0 Then
	Long ll_find
	String ls_member
	
	ls_member = This.object.member_no[1]
	
	ll_find = dw_list.find("member_no = '" + ls_member + "'" , 1, dw_list.rowcount())
	If ll_find > 0 Then
		dw_list.scrolltorow(ll_find)
	End if
End If
end event

type uc_row_insert from u_picture within w_hpa603a
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

type uc_row_delete from u_picture within w_hpa603a
integer x = 4174
integer y = 1124
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_main.PostEvent("ue_DeleteRow")

end event

type st_main from statictext within w_hpa603a
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
string text = "연말정산 대상자 기초사항"
boolean focusrectangle = false
end type

type p_1 from picture within w_hpa603a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_hpa603a
integer x = 50
integer y = 1136
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hpa603a
integer x = 114
integer y = 1128
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
string text = "연말정산 내역"
boolean focusrectangle = false
end type

