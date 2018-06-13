$PBExportHeader$w_msheet.srw
$PBExportComments$shett메인 모듈
forward
global type w_msheet from w_ancsheet
end type
type uc_retrieve from u_picture within w_msheet
end type
type uc_insert from u_picture within w_msheet
end type
type uc_delete from u_picture within w_msheet
end type
type uc_save from u_picture within w_msheet
end type
type uc_excel from u_picture within w_msheet
end type
type uc_print from u_picture within w_msheet
end type
type st_line1 from statictext within w_msheet
end type
type st_line2 from statictext within w_msheet
end type
type st_line3 from statictext within w_msheet
end type
type uc_excelroad from u_picture within w_msheet
end type
type ln_dwcon from line within w_msheet
end type
end forward

global type w_msheet from w_ancsheet
integer height = 2408
event type long ue_retrieve ( )
event ue_insert ( )
event ue_delete ( )
event type long ue_save ( )
event ue_print ( )
event ue_resize_dw ( ref statictext ast,  datawindow adw )
event ue_excel ( )
event ue_button_set ( )
event type long ue_updatequery ( )
event type long ue_update ( )
event type integer ue_sp_call ( )
event type integer ue_savestart ( )
event type integer ue_saveend ( )
event ue_pb_save ( )
event uf_setpreview pbm_custom72
event ue_prior pbm_custom09
event ue_next pbm_custom08
event ue_last pbm_custom07
event ue_first pbm_custom06
event type long ue_excelload_strt ( )
event type long ue_excelload ( )
event ue_open pbm_custom01
event ue_init ( )
event type integer ue_printstart ( ref vector avc_data )
uc_retrieve uc_retrieve
uc_insert uc_insert
uc_delete uc_delete
uc_save uc_save
uc_excel uc_excel
uc_print uc_print
st_line1 st_line1
st_line2 st_line2
st_line3 st_line3
uc_excelroad uc_excelroad
ln_dwcon ln_dwcon
end type
global w_msheet w_msheet

type variables
window			parentwin
Boolean			ib_updated

DataWindow	idw_update[]
DataWindow	idw_toexcel[]
DataWindow	idw_print
DataWindow	idw_modified[]
DataWindow	idw_excelload
Boolean			ib_updatequery_resetupdate = TRUE
String				is_file_name
String				is_col_name[]
Boolean			ib_excl_yn	=	FALSE

Boolean			ib_save_wait		= FALSE
Boolean			ib_retrieve_wait	= FALSE
Boolean			ib_excel_wait		= FALSE
Boolean			ib_excelload_wait	= FALSE
Boolean			ib_spcall_wait		= FALSE
String			is_code_name

end variables

forward prototypes
public function integer wf_validall ()
public function integer wf_upd_date_set ()
public subroutine wf_chk_auth ()
public function integer wf_setmenu (string as_flag, boolean ab_boolean)
public subroutine wf_setmenubtn (string as_type)
public function integer wf_setmsg (string as_message)
public function integer wf_setrowcount (string as_message)
end prototypes

event type long ue_retrieve();
RETURN 1

end event

event type long ue_save();DataWindow		ldw_modified[]
Long					ll_dw_cnt
Long					ll_i
Long					ll_totmodcont
String					ls_dw_id
	
If upperBound(idw_modified) = 0 Then
	ldw_modified	= idw_update
Else
	ldw_modified	= idw_modified
End If

ll_dw_cnt = UpperBound(ldw_modified)

ll_totmodcont = 0	
For ll_i = 1 To ll_dw_cnt
	If ldw_modified[ll_i].AcceptText() <> 1 Then
		ldw_modified[ll_i].SetFocus()
		RETURN -1
	End If
	ll_totmodcont += (ldw_modified[ll_i].ModifiedCount() + ldw_modified[ll_i].DeletedCount())
Next

If ll_totmodcont <= 0 Then
	f_set_message("[저장] " + '변경된 내용이 없습니다.', '', parentwin)
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
		
	If (idw_update[ll_i].ModifiedCount() + idw_update[ll_i].DeletedCount()) = 0 Then Continue

	// Update Property check
	If idw_update[ll_i].Describe("DataWindow.Table.UpdateTable") = "?" Then
		ls_dw_id = idw_update[ll_i].DataObject
		If ib_save_wait Then
			gf_closewait()
		End If
		SetPointer(Arrow!)
//		gf_message(parentwin, 2, '9999', 'ERROR', 'DataWindow = ' + ls_dw_id + '의 Update속성이 지정되지 않았습니다.')
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
	If idw_update[ll_i].Update(TRUE, FALSE) = 1 Then
	Else
		ROLLBACK USING SQLCA;
		If ib_save_wait Then
			gf_closewait()
		End If
		SetPointer(Arrow!)
		f_set_message("[저장] " + '오류가 발생했습니다.', '', parentwin)
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

ib_excl_yn = FALSE

For ll_i=1 To ll_dw_cnt
	idw_update[ll_i].ResetUpdate()
Next

ll_dw_cnt = UpperBound(idw_modified)
For ll_i=1 to ll_dw_cnt
	idw_modified[ll_i].ResetUpdate()
Next

f_set_message("[저장] " + '성공적으로 저장되었습니다.', '', parentwin)
If ib_save_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)

RETURN 1

end event

event ue_print();Datawindow 	ldw
Vector			lvc_print

lvc_print = Create Vector

If UpperBound(idw_toexcel) = 0 And idw_print = ldw Then
	MessageBox("알림", "출력할 자료가 없습니다.")
Else
	If This.Event ue_printStart(lvc_print) = -1 Then
		Return
	Else
		// 인쇄를 하기전에 해당 인쇄를 하고자 하는 사유를 확인한다.
		OpenWithParm(w_print_reason, gs_pgmid)
		If Message.Doubleparm < 0 Then
			Return
		Else
				OpenWithParm(w_print_preview, lvc_print)
		End If
	End If
End If


end event

event ue_resize_dw(ref statictext ast, datawindow adw);// uo_dwlv inherit 시 dw 위,아래 라인 표시 
Long	ll_x
Long	ll_y
Long	ll_width
Long	ll_height

ast.Visible	= TRUE

ll_x			= adw.X
ll_y			= adw.Y
ll_width		= adw.Width
ll_height		= adw.height

ll_y			= ll_y - 4
ll_height		= ll_height + 8

ast.X			= ll_x
ast.Y			= ll_y
ast.Width	= ll_width
ast.Height	= ll_height

ast.BringToTop	= FALSE

This.SetRedraw(TRUE)

end event

event ue_excel();//Integer						li_ret
//Integer						i
//Integer						cnt
//String  						ls_filepath
//String  						ls_filename
//String  						ls_docname
//String							ls_cur_directory
//String							ls_path
//String							ls_root
//Vector						vc
//
//cnt = UpperBound(idw_toexcel)
//If cnt <= 0 Then
//	vc = Create Vector
//	vc.setProperty("err_win",	This.ClassName())
//	vc.setProperty("err_plce",	'ue_excel Event')
//	vc.setProperty("err_line",	'20')
//	vc.setProperty("err_no",		'0000')
//	vc.setProperty("err_detl",	'idw_Toexcel 변수에 Excel File로 저장할 DataWindow를 지정하지 않았습니다. ~r~nue_postopen event에 Excel File로 저장할 DataWindow를 idw_Toexcel 변수에 지정하십시요.')
//	OpenWithParm(w_system_error, vc)
//	Destroy vc
//	RETURN
//End If
//
//ls_cur_directory = GetCurrentDirectory ( )
//
//li_ret = GetFileSaveName("Set Save File Name." , ls_filepath , ls_filename , "xls" , "Excel Files (*.xls),*.xls")
//
//ChangeDirectory ( ls_cur_directory )
//												
//If li_ret = 1 Then
//	ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + '_' + Trim(gs_emp_no) + '.xls'
//	If FileExists(ls_filename) Then
//		li_ret = MessageBox('확인', '이미 존재하는 파일 입니다. 바꾸시겠습니까?', Question!, YesNo!)
//		If li_ret = 2 Then
//			RETURN
//		End If
//	End If
//Else
//	RETURN
//End If
//
//SetPointer(HourGlass!)
//If ib_excel_wait Then
//	gf_openwait()
//End If
//If li_ret = 1 Then
//	For i = 1 To cnt
//		If i = 1 Then
//			ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + '_' + Trim(gs_emp_no) + '.xls'
//		Else
//			ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + String(i, '00') + '_' + Trim(gs_emp_no) + '.xls'
//		End If
//		If idw_toexcel[i].SaveAsAscii(ls_filename, "~t", "") <> 1 Then
//			gf_message(parentwin, 2, '9999', 'ERROR', 'FILE 생성에 실패했습니다.')
//			If ib_excel_wait Then
//				gf_closewait()
//			End If
//			SetPointer(Arrow!)
//			RETURN
//		End If
//	Next
//	If MessageBox("알림", "저장된 엑셀파일을 실행하시겠습니까?",Question!, YesNo!) = 1 Then                
//		RegistryGet("HKEY_CLASSES_ROOT\ExcelWorkSheet\protocol\StdFileEditing\server", "", RegString!,ls_root)
//		ls_path = ls_root + " /e "
//		For i = 1 To cnt
//			If i = 1 Then
//				ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + '_' + Trim(gs_emp_no) + '.xls'
//			Else
//				ls_filename = Left(ls_filepath, LenA(ls_filepath) - 4) + String(i, '00') + '_' + Trim(gs_emp_no) + '.xls'
//			End If
//			If Run(ls_path + ls_filename , Maximized!) <> 1 Then
//				If ib_excel_wait Then
//					gf_closewait()
//				End If
//				SetPointer(Arrow!)
//				gf_message(parentwin, 2, '9999', 'ERROR', 'Excel 실행중 Error 가 발생했습니다!')
//				RETURN
//			End If
//		Next
//	End If                                                                                                        
//End If
//If ib_excel_wait Then
//	gf_closewait()
//End If
//SetPointer(Arrow!)
//
end event

event ue_button_set();Long			ll_stnd_pos

ll_stnd_pos    = ln_tempright.beginx

If uc_print.Enabled Then
	uc_print.X		= ll_stnd_pos - uc_print.Width
	ll_stnd_pos		= ll_stnd_pos - uc_print.Width - 16
Else
	uc_print.Visible	= FALSE
End If

If uc_excelroad.Enabled Then
	uc_excelroad.X			= ll_stnd_pos - uc_excelroad.Width
	ll_stnd_pos			= ll_stnd_pos - uc_excelroad.Width - 16
Else
	uc_excel.Visible	= FALSE
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
//	ll_rv = gf_message(parentwin, 2, '0007', '', '')
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
					idw_update[ll_i].resetUpdate()
				Next
				ll_cnt = UpperBound(idw_modified)
				For ll_i =  1 TO ll_cnt
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
//	vc.setProperty("err_win",	func.of_nvl(THIS.ClassName(), ''))
//	vc.setProperty("err_plce",	'SP_CALL_TEST')
//	vc.setProperty("err_line",	'Stored Procedure Execute')
//	vc.setProperty("err_no",		func.of_nvl(String(SQLCA.SQLDBCode, '00000'), ''))
//	vc.setProperty("err_detl",	func.of_nvl(SQLCA.SQLErrText, ''))
//	ROLLBACK USING SQLCA;
//	f_set_message("[Procedure 실행] " + '오류가 발생했습니다.', '', parentwin)
//	If ib_spcall_wait Then
//		gf_closewait()
//	End If
//	SetPointer(Arrow!)
//	OpenWithParm(w_system_error, vc)
//	Destroy vc
//	RETURN -1
//End If
//
//FETCH	sp_call_cur1
//INTO		:li_rtn,	:ls_err_plce,	:ls_err_code,	:ls_err_msg;
//If li_rtn = -1 Then
//	vc.setProperty("err_win",	func.of_nvl(THIS.ClassName(), ''))
//	vc.setProperty("err_plce",	'SP_CALL_TEST')
//	vc.setProperty("err_line",	func.of_nvl(ls_err_plce, ''))
//	vc.setProperty("err_no",		func.of_nvl(ls_err_code, ''))
//	vc.setProperty("err_detl",	func.of_nvl(ls_err_msg, ''))
//	CLOSE sp_call_cur1;
//	ROLLBACK USING SQLCA;
//	f_set_message("[Procedure 실행] " + '오류가 발생했습니다.', '', parentwin)
//	If ib_spcall_wait Then
//		gf_closewait()
//	End If
//	SetPointer(Arrow!)
//	OpenWithParm(w_system_error, vc)
//	Destroy vc
//	RETURN -1
//Else
//	CLOSE sp_call_cur1;
//	COMMIT USING SQLCA;
//	If ib_spcall_wait Then
//		gf_closewait()
//	End If
//	SetPointer(Arrow!)
//	f_set_message("[Procedure 실행] " + '정상적으로 처리되었습니다.', '', parentwin)
//End If
//
//Destroy vc

RETURN 1

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
////데이터 윈도우 저장 처리 전에 테이블의 직접 변경, 신규 등록, 삭제해야 하는 내용을 기술하십시요.
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
//	RETURN -1
//End If

li_rtn = wf_upd_date_set()
If li_rtn = -1 Then
	RETURN -1
End If

RETURN 1

end event

event type integer ue_saveend();//DataWindow 저장 후에 처리해야 할 내용을 기술하십시요.
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
//	RETURN -1
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
//		RETURN -1
//	End If
//End If

RETURN 1

end event

event type long ue_excelload_strt();RETURN 1
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

If li_cnt = 1 then
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
			f_set_message(String(ll_impt_rtn) + '개의 데이터를 성공적으로 입력하였습니다. 데이터 확인 후 저장 버튼을 클릭하십시요.','',parentwin)
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
			f_set_message(String(ll_impt_rtn) + '개의 데이터를 성공적으로 입력하였습니다. 데이터 확인 후 저장 버튼을 클릭하십시요.','',parentwin)
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

event ue_open;RETURN 0
end event

event type integer ue_printstart(ref vector avc_data);//// 출력물 설정
//avc_data.SetProperty('title', "출력물 Title")
//avc_data.SetProperty('dataobject', "d_print")
//avc_data.SetProperty('datawindow', dw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

public function integer wf_validall ();RETURN 1

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

public subroutine wf_chk_auth ();
end subroutine

public function integer wf_setmenu (string as_flag, boolean ab_boolean);RETURN 1
end function

public subroutine wf_setmenubtn (string as_type);
end subroutine

public function integer wf_setmsg (string as_message);f_set_message(as_message,'', parentwin)
RETURN 1
end function

public function integer wf_setrowcount (string as_message);RETURN 1
end function

on w_msheet.create
int iCurrent
call super::create
this.uc_retrieve=create uc_retrieve
this.uc_insert=create uc_insert
this.uc_delete=create uc_delete
this.uc_save=create uc_save
this.uc_excel=create uc_excel
this.uc_print=create uc_print
this.st_line1=create st_line1
this.st_line2=create st_line2
this.st_line3=create st_line3
this.uc_excelroad=create uc_excelroad
this.ln_dwcon=create ln_dwcon
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uc_retrieve
this.Control[iCurrent+2]=this.uc_insert
this.Control[iCurrent+3]=this.uc_delete
this.Control[iCurrent+4]=this.uc_save
this.Control[iCurrent+5]=this.uc_excel
this.Control[iCurrent+6]=this.uc_print
this.Control[iCurrent+7]=this.st_line1
this.Control[iCurrent+8]=this.st_line2
this.Control[iCurrent+9]=this.st_line3
this.Control[iCurrent+10]=this.uc_excelroad
this.Control[iCurrent+11]=this.ln_dwcon
end on

on w_msheet.destroy
call super::destroy
destroy(this.uc_retrieve)
destroy(this.uc_insert)
destroy(this.uc_delete)
destroy(this.uc_save)
destroy(this.uc_excel)
destroy(this.uc_print)
destroy(this.st_line1)
destroy(this.st_line2)
destroy(this.st_line3)
destroy(this.uc_excelroad)
destroy(this.ln_dwcon)
end on

event ue_postopen;call super::ue_postopen;parentwin = This.Parentwindow()

This.Post Event ue_button_set()

f_set_message("[OPEN] " + '준비되었습니다.', '', parentwin)

end event

event ue_closecheck;call super::ue_closecheck;Long				ll_rv

If uc_save.Enabled Then

	ll_rv = This.Event ue_updatequery()  //저장여부 Check
	
	If ll_rv = 1 or ll_rv = 2 Then
	Else
		ai_rtn = -1
	End If

End If

end event

type ln_templeft from w_ancsheet`ln_templeft within w_msheet
integer endy = 2308
end type

type ln_tempright from w_ancsheet`ln_tempright within w_msheet
integer endy = 2308
end type

type ln_temptop from w_ancsheet`ln_temptop within w_msheet
end type

type ln_tempbuttom from w_ancsheet`ln_tempbuttom within w_msheet
integer beginy = 2264
integer endy = 2264
end type

type ln_tempbutton from w_ancsheet`ln_tempbutton within w_msheet
end type

type ln_tempstart from w_ancsheet`ln_tempstart within w_msheet
end type

type uc_retrieve from u_picture within w_msheet
integer x = 2313
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_retrieve.gif"
boolean callevent = true
string is_event = "ue_retrieve"
end type

type uc_insert from u_picture within w_msheet
integer x = 2601
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_input.gif"
boolean callevent = true
string is_event = "ue_insert"
end type

type uc_delete from u_picture within w_msheet
integer x = 2889
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
boolean callevent = true
string is_event = "ue_delete"
end type

type uc_save from u_picture within w_msheet
integer x = 3177
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_save.gif"
boolean callevent = true
string is_event = "ue_save"
end type

type uc_excel from u_picture within w_msheet
integer x = 3465
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_excel.gif"
boolean callevent = true
string is_event = "ue_excel"
end type

type uc_print from u_picture within w_msheet
integer x = 4160
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_print.gif"
boolean callevent = true
string is_event = "ue_print"
end type

type st_line1 from statictext within w_msheet
boolean visible = false
integer x = 91
integer y = 68
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 29738437
long bordercolor = 29738437
boolean focusrectangle = false
end type

type st_line2 from statictext within w_msheet
boolean visible = false
integer x = 165
integer y = 68
integer width = 55
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 29738437
long bordercolor = 29738437
boolean focusrectangle = false
end type

type st_line3 from statictext within w_msheet
boolean visible = false
integer x = 238
integer y = 68
integer width = 55
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 29738437
long bordercolor = 29738437
boolean focusrectangle = false
end type

type uc_excelroad from u_picture within w_msheet
boolean visible = false
integer x = 3753
integer y = 40
integer width = 393
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_excelroad.gif"
boolean callevent = true
string is_event = "ue_excelload"
end type

type ln_dwcon from line within w_msheet
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 284
integer endx = 4471
integer endy = 284
end type

