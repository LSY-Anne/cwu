$PBExportHeader$w_sch101a.srw
$PBExportComments$[w_master_detail]연도초기환경설정
forward
global type w_sch101a from w_window
end type
type dw_con from uo_dw within w_sch101a
end type
type dw_main from uo_dw within w_sch101a
end type
type dw_sub from uo_grid within w_sch101a
end type
type uc_row_insert from u_picture within w_sch101a
end type
type uc_row_delete from u_picture within w_sch101a
end type
type p_1 from picture within w_sch101a
end type
type st_main from statictext within w_sch101a
end type
type p_2 from picture within w_sch101a
end type
type st_detail from statictext within w_sch101a
end type
type uo_copy from uo_imgbtn within w_sch101a
end type
end forward

global type w_sch101a from w_window
dw_con dw_con
dw_main dw_main
dw_sub dw_sub
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
uo_copy uo_copy
end type
global w_sch101a w_sch101a

forward prototypes
public function integer wf_validall ()
public function integer wf_dup_check (string as_house_gb, string as_std_year)
end prototypes

public function integer wf_validall ();dwItemStatus 	l_status
String 	ls_house_gb, ls_std_year
Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

l_status 			= dw_main.GetItemStatus(i, 0, Primary!)
ls_house_gb 	= dw_main.Object.house_gb[dw_main.GetRow()]
ls_std_year 		= dw_main.Object.std_year[dw_main.GetRow()]

If (ls_house_gb = '' Or IsNull(ls_house_gb)) Or (ls_std_year = '' Or IsNull(ls_std_year)) Then
Else
	If l_status = NewModified! THEN
		If wf_dup_check(ls_house_gb, ls_std_year) < 0 Then
			MessageBox("확인","해당 연도 관련자료가 존재합니다. 조회후, 정보를 수정하십시요.")
			Return -1
		End If
	End If
End If

end function

public function integer wf_dup_check (string as_house_gb, string as_std_year);Integer	li_cnt

SELECT 	Count(*)
INTO		:li_cnt
FROM		CDDB.KCH102D
WHERE	CODE_GB = 'SAZ00'
AND		CODE = :as_house_gb||:as_std_year
USING SQLCA ;

If li_cnt > 0 Then
	Return -1
Else
	Return 1
End If
end function

on w_sch101a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.dw_sub=create dw_sub
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
this.uo_copy=create uo_copy
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.dw_sub
this.Control[iCurrent+4]=this.uc_row_insert
this.Control[iCurrent+5]=this.uc_row_delete
this.Control[iCurrent+6]=this.p_1
this.Control[iCurrent+7]=this.st_main
this.Control[iCurrent+8]=this.p_2
this.Control[iCurrent+9]=this.st_detail
this.Control[iCurrent+10]=this.uo_copy
end on

on w_sch101a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.dw_sub)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.uo_copy)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_sub )

dw_con.insertrow(0)
dw_main.InsertRow(0)

idw_update[1]	= dw_main
idw_update[2]	= dw_sub

//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_main
//idw_Toexcel[2]	= dw_sub

// 공통코드 Setup
Vector lvc_data

lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')

func.of_dddw( dw_con,lvc_data)
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

ll_rv = dw_main.Event ue_InsertRow()

ls_txt = "[신규] "
If ll_rv = 1 Then
	f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

end event

event ue_delete;call super::ue_delete;String		ls_txt

ls_txt = "[삭제] "
If dw_main.RowCount() > 0 Then
	If dw_main.Event ue_DeleteRow() > 0 Then
		dw_sub.uf_deleteAll()
		If Trigger Event ue_save() <> 1 Then
			f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
		Else
			f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
		End If
	Else
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
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

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_tempright.beginx

If uo_copy.Enabled Then
	uo_copy.X		= ll_stnd_pos - uo_copy.Width
	ll_stnd_pos		= ll_stnd_pos - uo_copy.Width - 16
	uo_copy.Visible = TRUE
Else
	uo_copy.Visible	= FALSE
End If

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


end event

type ln_templeft from w_window`ln_templeft within w_sch101a
end type

type ln_tempright from w_window`ln_tempright within w_sch101a
end type

type ln_temptop from w_window`ln_temptop within w_sch101a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch101a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch101a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch101a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch101a
end type

type uc_insert from w_window`uc_insert within w_sch101a
end type

type uc_delete from w_window`uc_delete within w_sch101a
end type

type uc_save from w_window`uc_save within w_sch101a
end type

type uc_excel from w_window`uc_excel within w_sch101a
end type

type uc_print from w_window`uc_print within w_sch101a
end type

type st_line1 from w_window`st_line1 within w_sch101a
end type

type st_line2 from w_window`st_line2 within w_sch101a
end type

type st_line3 from w_window`st_line3 within w_sch101a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch101a
end type

type dw_con from uo_dw within w_sch101a
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

type dw_main from uo_dw within w_sch101a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4384
integer height = 352
integer taborder = 11
string dataobject = "d_sch101a_1"
boolean border = false
end type

event type long ue_retrieve();String		ls_house_gb, ls_year
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_house_gb = dw_con.object.house_gb[dw_con.GetRow()]
ls_year = dw_con.object.std_year[dw_con.GetRow()]

If ls_house_gb = '' Or IsNull(ls_house_gb) Then
	MessageBox("확인","기숙사를 선택하셔야 합니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('house_gb')
	Return 0
End If
	
If ls_year = '' Or IsNull(ls_year) Then
	MessageBox("확인","학년도를 선택하셔야 합니다.")
	dw_con.SetFocus()
	dw_con.SetColumn('std_year')
	Return 0
End If

dw_main.SetRedraw(False)
dw_main.Reset()
ll_rv = This.Retrieve(ls_house_gb + ls_year)
If ll_rv <= 0 Then
	This.Event ue_insertrow()
End If
dw_sub.Retrieve()
dw_main.SetRedraw(True)

RETURN ll_rv

end event

event ue_deleteend;call super::ue_deleteend;If dw_sub.uf_DeleteAll() >= 0 Then
	RETURN 1
Else
	RETURN -1
End If

end event

event ue_insertstart;call super::ue_insertstart;If AncestorReturnValue = 1 Then
	dw_sub.Reset()
End If

RETURN AncestorReturnValue

end event

event itemchanged;call super::itemchanged;String ls_chk, ls_house_gb, ls_std_year

This.AcceptText()

Choose Case dwo.Name
	Case 'house_gb', 'std_year'
		ls_house_gb = This.Object.house_gb[row]
		ls_std_year = This.Object.std_year[row]
		
		If (ls_house_gb = '' Or IsNull(ls_house_gb)) Or (ls_std_year = '' Or IsNull(ls_std_year)) Then
		Else
			If wf_dup_check(ls_house_gb, ls_std_year) < 0 Then
				MessageBox("확인","해당 연도 관련자료가 존재합니다. 조회후, 정보를 수정하십시요.")
				Return 1
			End If
			This.Object.code[row] = ls_std_year + ls_house_gb
		End If
	Case 'etc_cd1'
		ls_chk = This.Object.etc_cd2[row]
		If ls_chk = '' Or IsNull(ls_chk) Then
		Else
			If Date(String(data, '@@@@.@@.@@')) > Date(String(ls_chk, '@@@@.@@.@@')) Then
				MessageBox("확인","종료일자보다 큰 시작일자를 선택할 수 없습니다.")
				Return 1
			End If
		End If
	Case 'etc_cd2'
		ls_chk = This.Object.etc_cd1[row]
		If ls_chk = '' Or IsNull(ls_chk) Then
		Else
			If Date(String(data, '@@@@.@@.@@')) < Date(String(ls_chk, '@@@@.@@.@@')) Then
				MessageBox("확인","시작일자보다 종료일자를 작게 선택할 수 없습니다.")
				Return 1
			End If
		End If
End Choose
end event

event ue_insertend;call super::ue_insertend;String ls_std_year, ls_house_gb

ls_std_year = dw_con.Object.std_year[dw_con.GetRow()]
ls_house_gb = dw_con.Object.house_gb[dw_con.GetRow()]

This.Object.std_year[al_row] = ls_std_year
This.Object.house_gb[al_row] = ls_house_gb
This.Object.code[al_row] = ls_std_year + ls_house_gb

Return 1
end event

type dw_sub from uo_grid within w_sch101a
integer x = 50
integer y = 896
integer width = 4389
integer height = 1368
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sch101a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type uc_row_insert from u_picture within w_sch101a
integer x = 3890
integer y = 788
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;If dw_main.RowCount() > 0 Then
	dw_sub.PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_sch101a
integer x = 4169
integer y = 788
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_sub.PostEvent("ue_DeleteRow")

end event

type p_1 from picture within w_sch101a
integer x = 50
integer y = 340
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_sch101a
integer x = 114
integer y = 324
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
string text = "연도정의"
boolean focusrectangle = false
end type

type p_2 from picture within w_sch101a
integer x = 50
integer y = 824
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_sch101a
integer x = 114
integer y = 812
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
string text = "초기환경작업"
boolean focusrectangle = false
end type

type uo_copy from uo_imgbtn within w_sch101a
integer x = 4142
integer y = 788
integer taborder = 21
boolean bringtotop = true
string btnname = "기초자료처리"
end type

on uo_copy.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;Integer	I, li_row
String		ls_house_gb, ls_std_year

uo_hjfunc hjfunc

hjfunc = Create uo_hjfunc

li_row 			= dw_sub.RowCount()
ls_house_gb		= dw_main.Object.house_gb[dw_main.GetRow()]
ls_std_year		= dw_main.Object.std_year[dw_main.GetRow()]

For I = 1 To li_row
	dw_sub.ScrollToRow(i)
	dw_sub.SetRow(i)
	If hjfunc.of_house_base_setup(ls_house_gb, ls_std_year, i) < 0 Then
		dw_sub.Object.process_gb[i] = '오류'
		Return
	Else
		dw_sub.Object.process_gb[i] = '처리완료'
	End If
Next

MessageBox("확인",ls_std_year + "년도의 기초자료가 생성되었습니다.")
Return
end event

