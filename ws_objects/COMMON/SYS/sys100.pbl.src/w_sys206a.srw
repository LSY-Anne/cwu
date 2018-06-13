$PBExportHeader$w_sys206a.srw
$PBExportComments$학사일정내역
forward
global type w_sys206a from w_ancresponse
end type
type st_main from statictext within w_sys206a
end type
type p_1 from picture within w_sys206a
end type
type dw_main from uo_grid within w_sys206a
end type
type p_msg from picture within w_sys206a
end type
type st_msg from statictext within w_sys206a
end type
type uc_printpreview from u_picture within w_sys206a
end type
type uc_cancel from u_picture within w_sys206a
end type
type uc_ok from u_picture within w_sys206a
end type
type uc_excelroad from u_picture within w_sys206a
end type
type uc_excel from u_picture within w_sys206a
end type
type uc_save from u_picture within w_sys206a
end type
type uc_delete from u_picture within w_sys206a
end type
type uc_insert from u_picture within w_sys206a
end type
type uc_retrieve from u_picture within w_sys206a
end type
type ln_temptop from line within w_sys206a
end type
type ln_1 from line within w_sys206a
end type
type ln_2 from line within w_sys206a
end type
type ln_3 from line within w_sys206a
end type
type r_backline1 from rectangle within w_sys206a
end type
type r_backline2 from rectangle within w_sys206a
end type
type r_backline3 from rectangle within w_sys206a
end type
type uc_print from u_picture within w_sys206a
end type
end forward

global type w_sys206a from w_ancresponse
integer width = 3319
integer height = 1848
string title = "학사일정내역"
event type long ue_inquiry ( )
event ue_insert ( )
event ue_delete ( )
event type integer ue_save ( )
event ue_resize_dw ( ref rectangle ar,  datawindow adw )
event ue_closecheck ( ref integer ai_rtn )
event type long ue_updatequery ( )
event ue_button_set ( )
event ue_excel ( )
event type long ue_excelload ( )
event type long ue_preview ( )
event type integer ue_saveend ( )
event type integer ue_savestart ( )
event type integer ue_sp_call ( )
event ue_print ( )
event type long ue_excelload_strt ( )
event ue_close ( )
event ue_ok ( )
event ue_cancel ( )
st_main st_main
p_1 p_1
dw_main dw_main
p_msg p_msg
st_msg st_msg
uc_printpreview uc_printpreview
uc_cancel uc_cancel
uc_ok uc_ok
uc_excelroad uc_excelroad
uc_excel uc_excel
uc_save uc_save
uc_delete uc_delete
uc_insert uc_insert
uc_retrieve uc_retrieve
ln_temptop ln_temptop
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
r_backline1 r_backline1
r_backline2 r_backline2
r_backline3 r_backline3
uc_print uc_print
end type
global w_sys206a w_sys206a

type variables
window			parentwin

DataWindow	idw_update[]
DataWindow	idw_toexcel[]
DataWindow	idw_print[]
DataWindow	idw_modified[]
DataWindow	idw_excelload
Boolean			ib_updatequery_resetupdate = TRUE
String				is_file_name
String				is_col_name[]

Boolean			ib_excl_yn	=	False

Vector			ivc

Boolean			ib_save_wait		= FALSE
Boolean			ib_retrieve_wait	= FALSE
Boolean			ib_excel_wait		= FALSE
Boolean			ib_excelload_wait	= FALSE
Boolean			ib_spcall_wait		= FALSE
String				is_code_name

end variables

forward prototypes
public function integer wf_validall ()
public function integer wf_upd_date_set ()
end prototypes

event type long ue_inquiry();Long ll_rv
String	ls_str_dt, ls_end_dt

ls_str_dt = ivc.GetProperty("schedule_sdt")
ls_end_dt =  ivc.GetProperty("schedule_edt")

ll_rv = dw_main.Retrieve(ls_str_dt,ls_end_dt)

RETURN ll_rv

end event

event type integer ue_save();DataWindow		ldw_modified[]
Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id
	
If upperBound(idw_modified) = 0 Then
	ldw_modified	= idw_update
Else
	ldw_modified	= idw_modified
End If
//	lstr_user 	= dw_main.istr_user
//	

ll_dw_cnt = UpperBound(ldw_modified)

ll_totmodcont = 0	
For ll_i = 1 To ll_dw_cnt
	If ldw_modified[ll_i].AcceptText() <> 1 Then
		ldw_modified[ll_i].SetFocus()
		RETURN -1
	End If
	ll_totmodcont += (ldw_modified[ll_i].ModifiedCount() + ldw_modified[ll_i].DeletedCount())
//	ll_totmodcont += ldw_modified[ll_i].uf_ModifiedCount()
Next

If ll_totmodcont <= 0 Then
	st_msg.Text = "[저장] " + '변경된 내용이 없습니다.'
	RETURN -1
End If

SetPointer(HourGlass!)
If ib_save_wait Then
	gf_openwait()
End If
If This.Event ue_SaveStart() <> 1 Then
	If ib_save_wait Then
		gf_closewait()
	End If
	SetPointer(Arrow!)
	RETURN -1
End If

ll_dw_cnt = UpperBound(idw_update)
For ll_i=1 To ll_dw_cnt
		
//	If idw_update[ll_i].uf_ModifiedCount() = 0 Then CONTINUE
	If (idw_update[ll_i].ModifiedCount() + idw_update[ll_i].DeletedCount()) = 0 Then Continue

	// Update Property check
	If idw_update[ll_i].Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = idw_update[ll_i].DataObject
		If ib_save_wait Then
			gf_closewait()
		End If
		SetPointer(Arrow!)
		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
		RETURN -1
	End If
	
	// NULL Check
	If func.of_checknull(idw_update[ll_i]) <> 0 Then 
		If ib_save_wait Then
			gf_closewait()
		End If
		SetPointer(Arrow!)
		RETURN -1
	End If
		
Next

For ll_i=1 To ll_dw_cnt
		
	If (idw_update[ll_i].ModifiedCount() + idw_update[ll_i].DeletedCount()) = 0 Then Continue
//	If idw_update[ll_i].uf_ModifiedCount() = 0 Then Continue
	If idw_update[ll_i].Update(TRUE, FALSE) = 1 Then
	Else
		ROLLBACK USING SQLCA;
		If ib_save_wait Then
			gf_closewait()
		End If
		SetPointer(Arrow!)
		st_msg.Text = "[저장] " + '오류가 발생했습니다.'
		RETURN -1
	End If
		
Next

If This.Event ue_SaveEnd() <> 1 Then
	If ib_save_wait Then
		gf_closewait()
	End If
	SetPointer(Arrow!)
	RETURN -1
End If

COMMIT USING SQLCA;

For ll_i=1 To ll_dw_cnt
	idw_update[ll_i].ResetUpdate()
Next

ll_dw_cnt = UpperBound(idw_modified)
For ll_i=1 To ll_dw_cnt
	idw_modified[ll_i].ResetUpdate()
Next

ib_excl_yn = FALSE

st_msg.Text = "[저장] " + '성공적으로 저장되었습니다.'
If ib_save_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)

RETURN 1

end event

event ue_resize_dw(ref rectangle ar, datawindow adw);Long	ll_x
Long	ll_y
Long	ll_width
Long	ll_height

ar.Visible	= TRUE

ll_x		= adw.X
ll_y		= adw.Y
ll_width	= adw.Width
ll_height	= adw.height

ll_y		= ll_y - 4
ll_height	= ll_height + 8

ar.X		= ll_x
ar.Y		= ll_y
ar.Width	= ll_width
ar.Height	= ll_height

This.SetRedraw(TRUE)

end event

event ue_closecheck(ref integer ai_rtn);Long				ll_rv

If uc_save.Enabled Then

	ll_rv = This.Event ue_updatequery()  //저장여부 Check
	
	If ll_rv = 1 or ll_rv = 2 Then
	Else
		ai_rtn = -1
	End If

End If

end event

event type long ue_updatequery();Long				ll_rv
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
	ldw_modified[ll_i].AcceptText()
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
				For ll_i =  1 To ll_cnt
					idw_update[ll_i].resetUpdate()
				Next
				ll_cnt = UpperBound(idw_modified)
				For ll_i =  1 To ll_cnt
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

event ue_button_set();Long			ll_stnd_pos

ll_stnd_pos		= This.width - 50
//ll_stnd_pos = ln_3.beginx

st_msg.Width	= This.width - 210
//If uc_help.Enabled Then
//	uc_help.X		= ll_stnd_pos - uc_help.Width
//	ll_stnd_pos		= ll_stnd_pos - uc_help.Width - 16
//Else
//	uc_help.Visible = FALSE
//End If
//
//If uc_confirm.Enabled Then
//	uc_confirm.X		= ll_stnd_pos - uc_confirm.Width
//	ll_stnd_pos			= ll_stnd_pos - uc_confirm.Width - 16
//Else
//	uc_confirm.Visible	= FALSE
//End If
//
//If uc_confirmpreview.Enabled Then
//	uc_confirmpreview.X			= ll_stnd_pos - uc_confirmpreview.Width
//	ll_stnd_pos						= ll_stnd_pos - uc_confirmpreview.Width - 16
//Else
//	uc_confirmpreview.Visible	= FALSE
//End If

If uc_cancel.Enabled Then
	uc_cancel.X		= ll_stnd_pos - uc_cancel.Width
	ll_stnd_pos		= ll_stnd_pos - uc_cancel.Width - 16
Else
	uc_cancel.Visible	= FALSE
End If

If uc_ok.Enabled Then
	uc_ok.X		= ll_stnd_pos - uc_ok.Width
	ll_stnd_pos	= ll_stnd_pos - uc_ok.Width - 16
Else
	uc_ok.Visible	= FALSE
End If

If uc_print.Enabled Then
	uc_print.X	= ll_stnd_pos - uc_print.Width
	ll_stnd_pos	= ll_stnd_pos - uc_print.Width - 16
Else
	uc_print.Visible	= FALSE
End If

If uc_printpreview.Enabled Then
	uc_printpreview.X			= ll_stnd_pos - uc_printpreview.Width
	ll_stnd_pos					= ll_stnd_pos - uc_printpreview.Width - 16
Else
	uc_printpreview.Visible	= FALSE
End If

If uc_excelroad.Enabled Then
	uc_excelroad.X			= ll_stnd_pos - uc_excelroad.Width
	ll_stnd_pos				= ll_stnd_pos - uc_excelroad.Width - 16
Else
	uc_excelroad.Visible	= FALSE
End If

If uc_excel.Enabled Then
	uc_excel.X			= ll_stnd_pos - uc_excel.Width
	ll_stnd_pos			= ll_stnd_pos - uc_excel.Width - 16
Else
	uc_excel.Visible	= FALSE
End If

If uc_save.Enabled Then
	uc_save.X		= ll_stnd_pos - uc_save.Width
	ll_stnd_pos		= ll_stnd_pos - uc_save.Width - 16
Else
	uc_save.Visible	= FALSE
End If

If uc_delete.Enabled Then
	uc_delete.X			= ll_stnd_pos - uc_delete.Width
	ll_stnd_pos			= ll_stnd_pos - uc_delete.Width - 16
Else
	uc_delete.Visible	= FALSE
End If

If uc_insert.Enabled Then
	uc_insert.X			= ll_stnd_pos - uc_insert.Width
	ll_stnd_pos			= ll_stnd_pos - uc_insert.Width - 16
Else
	uc_insert.Visible	= FALSE
End If

If uc_retrieve.Enabled Then
	uc_retrieve.X		= ll_stnd_pos - uc_retrieve.Width
	ll_stnd_pos			= ll_stnd_pos - uc_retrieve.Width - 16
Else
	uc_retrieve.Visible	= FALSE
End If

end event

event ue_excel();Integer						li_ret
Integer						i
Integer						cnt
String  						ls_filepath
String  						ls_filename
String  						ls_docname
String							ls_cur_directory
String							ls_path
String							ls_root
Vector						vc

cnt = UpperBound(idw_toexcel)
If cnt <= 0 Then
	vc = Create Vector
	vc.setProperty("err_win",	This.ClassName())
	vc.setProperty("err_plce",	'ue_excel Event')
	vc.setProperty("err_line",	'20')
	vc.setProperty("err_no",		'0000')
	vc.setProperty("err_detl",	'idw_Toexcel 변수에 Excel File로 저장할 DataWindow를 지정하지 않았습니다. ~r~nue_postopen event에 Excel File로 저장할 DataWindow를 idw_Toexcel 변수에 지정하십시요.')
	OpenWithParm(w_system_error, vc)
	Destroy vc
	RETURN
End If

ls_cur_directory = GetCurrentDirectory ( )

li_ret = GetFileSaveName("Set Save File Name." , ls_filepath , ls_filename , "xls" , "Excel Files (*.xls),*.xls")

ChangeDirectory ( ls_cur_directory )
												
If li_ret = 1 Then
	ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + '_' + Trim(gs_empcode) + '.xls'
	If FileExists(ls_filename) Then
		li_ret = MessageBox('확인', '이미 존재하는 파일 입니다. 바꾸시겠습니까?', Question!, YesNo!)
		If li_ret = 2 Then
			RETURN
		End If
	End If
Else
	RETURN
End If

SetPointer(HourGlass!)
If ib_excel_wait Then
	gf_openwait()
End If
If li_ret = 1 Then
	For i = 1 To cnt
		If i = 1 Then
			ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + '_' + Trim(gs_empcode) + '.xls'
		Else
			ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + String(i, '00') + '_' + Trim(gs_empcode) + '.xls'
		End If
		If idw_toexcel[i].SaveAsAscii(ls_filename, "~t", "") <> 1 Then
			gf_message(parentwin, 2, '9999', 'ERROR', 'FILE 생성에 실패했습니다.')
			If ib_excel_wait Then
				gf_closewait()
			End If
			SetPointer(Arrow!)
			RETURN
		End If
	Next
	If MessageBox("알림", "저장된 엑셀파일을 실행하시겠습니까?",Question!, YesNo!) = 1 Then                
		RegistryGet("HKEY_CLASSES_ROOT\ExcelWorkSheet\protocol\StdFileEditing\server", "", RegString!,ls_root)
		ls_path = ls_root + " /e "
		For i = 1 To cnt
			If i = 1 Then
				ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + '_' + Trim(gs_empcode) + '.xls'
			Else
				ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + String(i, '00') + '_' + Trim(gs_empcode) + '.xls'
			End If
			If Run(ls_path + ls_filename , Maximized!) <> 1 Then
				If ib_excel_wait Then
					gf_closewait()
				End If
				SetPointer(Arrow!)
				gf_message(parentwin, 2, '9999', 'ERROR', 'Excel 실행중 Error 가 발생했습니다!')
				RETURN
			End If
		Next
	End If                                                                                                        
End If
If ib_excel_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)

end event

event type long ue_excelload();String			ls_doc_path
String			ls_doc_name[]
Integer		li_rtn
Integer		li_cnt
String			ls_file_kind
Integer		li_pos
Integer		li_i
Long			ll_impt_rtn
String			ls_msg
OLEobject	ole_excel
Integer		li_connect
Boolean 		lb_select
Long			ll_xls
String			ls_save_file 
Integer		li_col_cnt
String			ls_cur_directory
Vector		vc

If	Not IsValid(idw_excelload) Then
	vc = Create Vector
	vc.setProperty("err_win",	This.ClassName())
	vc.setProperty("err_plce",	'ue_excelload Event')
	vc.setProperty("err_line",	'19')
	vc.setProperty("err_no",		'0000')
	vc.setProperty("err_detl",	'idw_excelload 변수에 Excel File 또는 Text File로 부터 로드할 DataWindow를 지정하지 않았습니다. ~r~nue_postopen event에 Excel File 또는 Text File로 부터 로드할 DataWindow를 idw_excelload 변수에 지정하십시요.')
	OpenWithParm(w_system_error, vc)
	Destroy vc
	RETURN -1
End If

If This.Event ue_excelload_strt() = -1 Then RETURN -1

//idw_excelload	=	dw_main
//is_file_name	=	'우편번호'
//is_col_name[]	=	{'우편번호', '시도명', '시군구명', '읍면동명', '리명', '도서명', '번지', '아파트/건물명', '상세주소'}
ls_cur_directory = GetCurrentDirectory ( )

li_col_cnt			=	UpperBound(is_col_name)
ls_msg			=	'File로 부터 데이터를 입력 받을 수 있는 File은 ~r~n' + &
						'Tab으로 분리된 *.TXT File, ~r~n' + &
						'comma로 분리된 *.CSV File, ~r~n' + &
						'DBF File, ~r~n' + &
						'Excel File만 가능합니다. ~r~n' + &
						'또한, 입력 받을 File에서 제목은 삭제해야 합니다.~r~n' + &
						'LOAD 할 ' + is_file_name + ' FILE은~r~n'
						
For li_i = 1 To li_col_cnt
	If li_i = 1 Then
		ls_msg = ls_msg + is_col_name[li_i]
	Else
		ls_msg = ls_msg + ' / ' + is_col_name[li_i]
	End If
Next
ls_msg = ls_msg + '~r~n순으로 되어 있어야 합니다.'

gf_message(parentwin, 2, '9999', '알림', ls_msg)
li_rtn = GetFileOpenName("Select File", &
   ls_doc_path, ls_doc_name[], "DOC", &
   + "Text Files (*.txt),*.TXT," &
   + "CSV Files (*.csv),*.CSV," &
   + "XLS Files (*.xls),*.XLS," &
   + "All Files (*.*), *.*", &
   ls_cur_directory, 18)		

ChangeDirectory ( ls_cur_directory )

If li_rtn < 1 Then RETURN -1

li_cnt = Upperbound(ls_doc_name)

If li_cnt = 1 Then
	For li_i = LenA(ls_doc_name[1]) To 1 Step -1
		If MidA(ls_doc_name[1], li_i, 1) = '.' Then
			li_pos = li_i
			Exit
		End If
	Next
	ls_file_kind = Upper(MidA(ls_doc_name[1], li_i + 1))
	If ls_file_kind = 'XLS' Then

		SetPointer(HourGlass!)
		If ib_excelload_wait Then
			gf_openwait()
		End If
		ole_excel		= Create OLEobject
		li_connect	= ole_excel.ConnectToObject("","excel.application") 
		If li_connect = -5 Then
			// -5 Can't connect to the currently active object 
			li_connect	=	ole_excel.ConnectToNewObject("excel.application") 
		End If 
		
		If li_connect <> 0 Then
			Destroy	ole_excel 
			If ib_excelload_wait Then
				gf_closewait()
			End If
			SetPointer(Arrow!)
			gf_message(parentwin, 2, '9999', 'ERROR', '엑셀 프로그램을 실행할 수 없습니다.')
			RETURN -1 
		End If
		
		ole_excel.WorkBooks.Open(ls_doc_path)
		ole_excel.Application.Visible = FALSE
		
		lb_select = ole_excel.WorkSheets(1).Activate
		
		ll_xls = pos(ls_doc_path, 'xls')
		
		ls_save_file = mid(ls_doc_path, 1, ll_xls -2) + String(now(),'hhmmss') + ".txt"
		
		ole_excel.Application.Workbooks(1).SaveAs(ls_save_file, -4158)
		ole_excel.WorkBooks(1).Saved = TRUE
		ole_excel.WorkBooks.Close()
		
		ole_excel.Application.Quit
		ole_excel.DisConnectObject()
		
		Destroy	ole_excel

		idw_excelload.SetReDraw(FALSE)
		idw_excelload.Reset()
		ll_impt_rtn = idw_excelload.ImportFile(ls_save_file)
		If NOT FileDelete(ls_save_file) Then
			gf_message(parentwin, 2, '9999', 'ERROR', "Import 처리를 위한 임시파일 삭제에 실패 하였습니다.(" + ls_save_file + ")")
		End If
		If ll_impt_rtn > 0 Then
			If ib_excelload_wait Then
				gf_closewait()
			End If
			SetPointer(Arrow!)
			st_msg.Text = String(ll_impt_rtn) + '개의 데이터를 성공적으로 입력하였습니다. 데이터 확인 후 저장 버튼을 클릭하십시요.'
		Else
			If ib_excelload_wait Then
				gf_closewait()
			End If
			SetPointer(Arrow!)
			gf_message(parentwin, 2, '9999', 'ERROR',	'데이터 입력 오류!!!! ~r~n' + &
																		'입력 받을 수 있는 File은 ~r~n' + &
																		'Tab으로 분리된 *.TXT File, ~r~n' + &
																		'comma로 분리된 *.CSV File, ~r~n' + &
																		'DBF File, ~r~n' + &
																		'Excel File만 가능합니다. ~r~n' + &
																		'또한, 입력 받을 File에서 제목은 삭제해야 합니다.')
			idw_excelload.SetReDraw(TRUE)
			RETURN -1
		End If
		ib_excl_yn = TRUE
		idw_excelload.SetReDraw(TRUE)
	Else
		SetPointer(HourGlass!)
		If ib_excelload_wait Then
			gf_openwait()
		End If
		idw_excelload.SetReDraw(FALSE)
		idw_excelload.Reset()
		ll_impt_rtn = idw_excelload.ImportFile(ls_doc_path)
		If ll_impt_rtn > 0 Then
			If ib_excelload_wait Then
				gf_closewait()
			End If
			SetPointer(Arrow!)
			st_msg.Text = String(ll_impt_rtn) + '개의 데이터를 성공적으로 입력하였습니다. 데이터 확인 후 저장 버튼을 클릭하십시요.'
		Else
			If ib_excelload_wait Then
				gf_closewait()
			End If
			SetPointer(Arrow!)
			gf_message(parentwin, 2, '9999', 'ERROR',	'데이터 입력 오류!!!! ~r~n' + &
																		'입력 받을 수 있는 File은 ~r~n' + &
																		'Tab으로 분리된 *.TXT File, ~r~n' + &
																		'comma로 분리된 *.CSV File, ~r~n' + &
																		'DBF File, ~r~n' + &
																		'Excel File만 가능합니다. ~r~n' + &
																		'또한, 입력 받을 File에서 제목은 삭제해야 합니다.')
			idw_excelload.SetReDraw(TRUE)
			RETURN -1
		End If
		ib_excl_yn = TRUE
		idw_excelload.SetReDraw(TRUE)
	End If
Else
	gf_message(parentwin, 2, '9999', '알림', '데이터를 입력할 File을 하나만 선택하십시요.')
	RETURN -1
End If

RETURN 1

end event

event type long ue_preview();RETURN 1

end event

event type integer ue_saveend();//DataWindow 후에 처리해야 할 내용을 기술하십시요.
//table의 데이터를 직접 수정, 등록, 삭제 등
//List, Master형태의 window에서 Master를 변경, 신규 등록하였을 때 List, Master의 동기화 등
//String			ls_key
//Integer		li_err_code
//String			ls_err_text
//
//UPDATE		TABLE_TEMP
//SET			STATUS	=	'99'
//WHERE		TAB_KEY	=	:ls_key
//USING		SQLCA;
//If SQLCA.SQLCODE <> 0 Then
//	li_err_code	= SQLCA.SQLDBCode
//	ls_err_text	= SQLCA.SQLErrText
//	ROLLBACK USING SQLCA;
//	gf_sqlerr_msg(THIS.Classname(), 'ue_saveend event', String(8), 'UPDATE TABLE_TEMP', li_err_code, ls_err_text)
//	Return -1
//End If
//
//If SQLCA.sqlnrows = 0 Then
//	INSERT	INTO	TABLE_TEMP
//				(
//						TAB_KEY	
//					,	.......
//					,	STATUS
//					,	INS_DT
//					,	INS_ID
//					,	UPD_DT
//					,	UPD_ID
//				)
//	VALUES	(
//						:ls_key
//					,	.......
//					,	'99'
//					,	SYSDATE
//					,	:gs_emp_no
//					,	SYSDATE
//					,	:gs_emp_no
//				)
//	USING	SQLCA;
//	If SQLCA.SQLCODE <> 0 Then
//		li_err_code	= SQLCA.SQLDBCode
//		ls_err_text	= SQLCA.SQLErrText
//		ROLLBACK USING SQLCA;
//		gf_sqlerr_msg(THIS.Classname(), 'ue_saveend event', String(21), 'INSERT TABLE_TEMP', li_err_code, ls_err_text)
//		Return -1
//	End If
//End If

Return 1

end event

event type integer ue_savestart();Integer		li_rtn
Long			ll_seq
Integer		li_err_code
String			ls_err_text

//DataWindow의 Tag에 의해 Null 이나 ''를 check 할 수 없는 Column에 대한 Check 기술하십시요.

//입력 데이터에 대한 각종 Validation Check를 기술하십시요.
li_rtn = wf_validall()
If li_rtn = -1 Then
	RETURN -1
End If

////자동으로 Set해야 되는 Key 값 들의 Setting 또는 
////데이터 윈도우 처리 전에 테이블의 직접 변경, 신규 등록, 삭제해야 하는 내용을 기술하십시요.
////만일 SQLCA.SQLCODE = 100인 경우에는 업무 처리 기준에 따라 에러 처리하거나 정상처리하십시요.
//SELECT		NVL(MAX(SEQ),	0)	+	1
//INTO			:ll_seq
//FROM			ZA110
//USING		SQLCA;
//
//If	SQLCA.SQLCODE <> 0 Then
//	li_err_code	= SQLCA.SQLDBCode
//	ls_err_text	= SQLCA.SQLErrText
//	ROLLBACK USING SQLCA;
//	gf_sqlerr_msg(THIS.Classname(), 'ue_savestart event', String(14), 'SELECT ZA110', li_err_code, ls_err_text)
//	Return -1
//End If

li_rtn = wf_upd_date_set()
If li_rtn = -1 Then
	RETURN -1
End If

RETURN 1

end event

event type integer ue_sp_call();//Integer	li_rtn
//String		ls_err_plce
//String		ls_err_code
//String		ls_err_msg
//
//Vector	vc
//vc = Create	Vector
//
//SetPointer(HourGlass!)
//If ib_spcall_wait Then
//	gf_openwait()
//End If
//DECLARE sp_call_cur1 PROCEDURE FOR 
//	SP_CALL_TEST ( 50000,      '000000',       '시도',      &
//						 '시군구',    '읍면동',      '리' )
//USING SQLCA ;
//
//EXECUTE sp_call_cur1;
//If SQLCA.SQLCODE <> 0 Then
//	vc.setProperty("err_win",	func.of_nvl(THIS.ClassName(),''))
//	vc.setProperty("err_plce",	'SP_CALL_TEST')
//	vc.setProperty("err_line",	'Stored Procedure Execute')
//	vc.setProperty("err_no",		func.of_nvl(String(SQLCA.SQLDBCode, '00000'), ''))
//	vc.setProperty("err_detl",	func.of_nvl(SQLCA.SQLErrText, ''))
//	ROLLBACK USING SQLCA;
//	st_msg.Text = "[Procedure 실행] " + '오류가 발생했습니다.'
//	If ib_spcall_wait Then
//		gf_closewait()
//	End If
//	SetPointer(Arrow!)
//	OpenWithParm(w_system_error, vc)
//	Destroy vc
//	Return -1
//End If
//
//FETCH	sp_call_cur1
//INTO		:li_rtn,	:ls_err_plce,	:ls_err_code,	:ls_err_msg;
//If li_rtn = -1 Then
//	vc.setProperty("err_win",	THIS.ClassName())
//	vc.setProperty("err_plce",	'SP_CALL_TEST')
//	vc.setProperty("err_line",	ls_err_plce)
//	vc.setProperty("err_no",		ls_err_code)
//	vc.setProperty("err_detl",	ls_err_msg)
//	CLOSE sp_call_cur1;
//	ROLLBACK USING SQLCA;
//	st_msg.Text = "[Procedure 실행] " + '오류가 발생했습니다.'
//	If ib_spcall_wait Then
//		gf_closewait()
//	End If
//	SetPointer(Arrow!)
//	OpenWithParm(w_system_error, vc)
//	Destroy vc
//	Return -1
//Else
//	CLOSE sp_call_cur1;
//	COMMIT USING SQLCA;
//	If ib_spcall_wait Then
//		gf_closewait()
//	End If
//	SetPointer(Arrow!)
//	st_msg.Text = "[Procedure 실행] " + '정상적으로 처리되었습니다.'
//End If
//
//Destroy vc

RETURN 1

end event

event type long ue_excelload_strt();RETURN 1

end event

event ue_close();
Close(This)

end event

event ue_ok();ivc.Removeall()

CloseWithReturn(This, ivc)


end event

event ue_cancel();Close(This)
end event

public function integer wf_validall ();Integer	I, li_row, li_rtn, li_dseq, li_make_seq
dwItemStatus 	l_status
String	ls_board_gb, ls_make_dt, ls_house_cd

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

RETURN 0
end function

public function integer wf_upd_date_set ();Long			ll_dw_cnt
Long			ll_i
Integer		li_rv

ll_dw_cnt = UpperBound(idw_update)
For ll_i = 1 To ll_dw_cnt
	
	// 최초입력일, 최초입력자 N: 신규 일때  set 0: 전체 row Loop하면서 NewModified 인것만 set한다. 
	li_rv = func.of_setsysdate	(idw_update[ll_i],	0,	'work_date',	'N')
	If li_rv <> 1 Then
		RETURN -1
	End If
	li_rv = func.of_setvalue	(idw_update[ll_i],	0,	'worker',	gs_empCode, 'N') 
	If li_rv <> 1 Then
		RETURN -1
	End If
	// 최종수정일, 최종수정자 N: 신규 일때  M: Modify일때 set 0: 전체 row Loop하면서 DataModified인것만 set한다. 
	li_rv = func.of_setsysdate	(idw_update[ll_i],	0,	'job_date',	'N')
	If li_rv <> 1 Then
		RETURN -1
	End If
	li_rv = func.of_setvalue	(idw_update[ll_i],	0,	'job_uid',	gs_empCode, 'N') 
	If li_rv <> 1 Then
		RETURN -1
	End If
	li_rv = func.of_setsysdate	(idw_update[ll_i],	0,	'job_date',	'M')
	If li_rv <> 1 Then
		RETURN -1
	End If
	li_rv = func.of_setvalue	(idw_update[ll_i],	0,	'job_uid',	gs_empCode, 'M') 
	If li_rv <> 1 Then
		RETURN -1
	End If
	
Next

RETURN 1

end function

on w_sys206a.create
int iCurrent
call super::create
this.st_main=create st_main
this.p_1=create p_1
this.dw_main=create dw_main
this.p_msg=create p_msg
this.st_msg=create st_msg
this.uc_printpreview=create uc_printpreview
this.uc_cancel=create uc_cancel
this.uc_ok=create uc_ok
this.uc_excelroad=create uc_excelroad
this.uc_excel=create uc_excel
this.uc_save=create uc_save
this.uc_delete=create uc_delete
this.uc_insert=create uc_insert
this.uc_retrieve=create uc_retrieve
this.ln_temptop=create ln_temptop
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.r_backline1=create r_backline1
this.r_backline2=create r_backline2
this.r_backline3=create r_backline3
this.uc_print=create uc_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_main
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.p_msg
this.Control[iCurrent+5]=this.st_msg
this.Control[iCurrent+6]=this.uc_printpreview
this.Control[iCurrent+7]=this.uc_cancel
this.Control[iCurrent+8]=this.uc_ok
this.Control[iCurrent+9]=this.uc_excelroad
this.Control[iCurrent+10]=this.uc_excel
this.Control[iCurrent+11]=this.uc_save
this.Control[iCurrent+12]=this.uc_delete
this.Control[iCurrent+13]=this.uc_insert
this.Control[iCurrent+14]=this.uc_retrieve
this.Control[iCurrent+15]=this.ln_temptop
this.Control[iCurrent+16]=this.ln_1
this.Control[iCurrent+17]=this.ln_2
this.Control[iCurrent+18]=this.ln_3
this.Control[iCurrent+19]=this.r_backline1
this.Control[iCurrent+20]=this.r_backline2
this.Control[iCurrent+21]=this.r_backline3
this.Control[iCurrent+22]=this.uc_print
end on

on w_sys206a.destroy
call super::destroy
destroy(this.st_main)
destroy(this.p_1)
destroy(this.dw_main)
destroy(this.p_msg)
destroy(this.st_msg)
destroy(this.uc_printpreview)
destroy(this.uc_cancel)
destroy(this.uc_ok)
destroy(this.uc_excelroad)
destroy(this.uc_excel)
destroy(this.uc_save)
destroy(this.uc_delete)
destroy(this.uc_insert)
destroy(this.uc_retrieve)
destroy(this.ln_temptop)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.r_backline1)
destroy(this.r_backline2)
destroy(this.r_backline3)
destroy(this.uc_print)
end on

event closequery;call super::closequery;Integer	li_rtn

This.Event ue_closecheck(li_rtn)
If li_rtn = -1 Then RETURN 1

end event

event ue_postopen;call super::ue_postopen;This.Center = True

parentwin = This.Parentwindow()

This.Post Event ue_button_set()

ivc	=Create Vector
ivc.Removeall()
ivc.setProperty("parm_cnt", "0")

This.Event ue_resize_dw( r_backline1, dw_main )

ivc = Message.PowerObjectParm

If IsValid(ivc) Then
	If Long(ivc.GetProperty("parm_cnt")) > 0 Then
		Post Event ue_inquiry()
	End If
End If


end event

type st_main from statictext within w_sys206a
integer x = 114
integer y = 180
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
string text = "학사일정"
boolean focusrectangle = false
end type

type p_1 from picture within w_sys206a
integer x = 50
integer y = 188
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_main from uo_grid within w_sys206a
integer x = 55
integer y = 248
integer width = 3218
integer height = 1376
integer taborder = 20
string dataobject = "d_sys206a_1"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_end_add = true
end type

type p_msg from picture within w_sys206a
integer x = 64
integer y = 1652
integer width = 69
integer height = 56
boolean originalsize = true
string picturename = "..\img\message_ico.gif"
boolean focusrectangle = false
end type

type st_msg from statictext within w_sys206a
integer x = 146
integer y = 1652
integer width = 3127
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 16777215
boolean focusrectangle = false
end type

type uc_printpreview from u_picture within w_sys206a
integer x = 2281
integer y = 44
integer width = 393
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_preview.gif"
boolean callevent = true
string is_event = "ue_preview"
end type

type uc_cancel from u_picture within w_sys206a
integer x = 3232
integer y = 44
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_cancel.gif"
boolean callevent = true
string is_event = "ue_cancel"
end type

type uc_ok from u_picture within w_sys206a
integer x = 2949
integer y = 44
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_ok.gif"
boolean callevent = true
string is_event = "ue_ok"
end type

type uc_excelroad from u_picture within w_sys206a
integer x = 1893
integer y = 44
integer width = 393
integer height = 84
string picturename = "..\img\button\topBtn_excelroad.gif"
boolean callevent = true
string is_event = "ue_excelload"
end type

type uc_excel from u_picture within w_sys206a
integer x = 1609
integer y = 44
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_excel.gif"
boolean callevent = true
string is_event = "ue_excel"
end type

type uc_save from u_picture within w_sys206a
integer x = 1326
integer y = 44
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_save.gif"
boolean callevent = true
string is_event = "ue_save"
end type

type uc_delete from u_picture within w_sys206a
integer x = 1042
integer y = 44
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_delete.gif"
boolean callevent = true
string is_event = "ue_delete"
end type

type uc_insert from u_picture within w_sys206a
integer x = 759
integer y = 44
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_input.gif"
boolean callevent = true
string is_event = "ue_insert"
end type

type uc_retrieve from u_picture within w_sys206a
integer x = 475
integer y = 44
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_retrieve.gif"
boolean callevent = true
string is_event = "ue_inquiry"
end type

type ln_temptop from line within w_sys206a
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 172
integer endx = 4503
integer endy = 172
end type

type ln_1 from line within w_sys206a
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 1740
integer endx = 4503
integer endy = 1740
end type

type ln_2 from line within w_sys206a
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 46
integer beginy = -12
integer endx = 46
integer endy = 1952
end type

type ln_3 from line within w_sys206a
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 3273
integer beginy = -16
integer endx = 3273
integer endy = 1948
end type

type r_backline1 from rectangle within w_sys206a
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 87
integer y = 60
integer width = 55
integer height = 48
end type

type r_backline2 from rectangle within w_sys206a
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 151
integer y = 60
integer width = 55
integer height = 48
end type

type r_backline3 from rectangle within w_sys206a
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 215
integer y = 60
integer width = 55
integer height = 48
end type

type uc_print from u_picture within w_sys206a
integer x = 2665
integer y = 44
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_print.gif"
boolean callevent = true
string is_event = "ue_print"
end type

