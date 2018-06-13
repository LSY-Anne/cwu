$PBExportHeader$w_hac801a_help.srw
$PBExportComments$산출내역 조회
forward
global type w_hac801a_help from w_ancresponse
end type
type dw_1 from uo_dwgrid within w_hac801a_help
end type
type p_msg from picture within w_hac801a_help
end type
type st_msg from statictext within w_hac801a_help
end type
type uc_printpreview from u_picture within w_hac801a_help
end type
type uc_cancel from u_picture within w_hac801a_help
end type
type uc_ok from u_picture within w_hac801a_help
end type
type uc_excel from u_picture within w_hac801a_help
end type
type uc_retrieve from u_picture within w_hac801a_help
end type
type ln_temptop from line within w_hac801a_help
end type
type ln_1 from line within w_hac801a_help
end type
type ln_2 from line within w_hac801a_help
end type
type ln_3 from line within w_hac801a_help
end type
type r_backline1 from rectangle within w_hac801a_help
end type
type r_backline2 from rectangle within w_hac801a_help
end type
type r_backline3 from rectangle within w_hac801a_help
end type
type uc_print from u_picture within w_hac801a_help
end type
end forward

global type w_hac801a_help from w_ancresponse
integer width = 3593
event type long ue_inquiry ( )
event ue_resize_dw ( ref rectangle ar,  datawindow adw )
event ue_button_set ( )
event ue_excel ( )
event type long ue_preview ( )
event ue_print ( )
event ue_close ( )
dw_1 dw_1
p_msg p_msg
st_msg st_msg
uc_printpreview uc_printpreview
uc_cancel uc_cancel
uc_ok uc_ok
uc_excel uc_excel
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
global w_hac801a_help w_hac801a_help

type variables
window			parentwin

DataWindow	idw_toexcel[]

Vector			ivc

Boolean			ib_excel_wait		= FALSE
Boolean			ib_retrieve_wait	= FALSE
String				is_code_name

end variables

event type long ue_inquiry();RETURN 1
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

This.setredraw(TRUE)

end event

event ue_button_set();Long			ll_stnd_pos

ll_stnd_pos	=	This.width - 50
//ll_stnd_pos = ln_3.beginx

st_msg.Width = This.width - 210
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

If uc_excel.Enabled Then
	uc_excel.X			= ll_stnd_pos - uc_excel.Width
	ll_stnd_pos			= ll_stnd_pos - uc_excel.Width - 16
Else
	uc_excel.Visible	= FALSE
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

event type long ue_preview();RETURN 1

end event

event ue_close();
Close(This)

end event

on w_hac801a_help.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.p_msg=create p_msg
this.st_msg=create st_msg
this.uc_printpreview=create uc_printpreview
this.uc_cancel=create uc_cancel
this.uc_ok=create uc_ok
this.uc_excel=create uc_excel
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
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.p_msg
this.Control[iCurrent+3]=this.st_msg
this.Control[iCurrent+4]=this.uc_printpreview
this.Control[iCurrent+5]=this.uc_cancel
this.Control[iCurrent+6]=this.uc_ok
this.Control[iCurrent+7]=this.uc_excel
this.Control[iCurrent+8]=this.uc_retrieve
this.Control[iCurrent+9]=this.ln_temptop
this.Control[iCurrent+10]=this.ln_1
this.Control[iCurrent+11]=this.ln_2
this.Control[iCurrent+12]=this.ln_3
this.Control[iCurrent+13]=this.r_backline1
this.Control[iCurrent+14]=this.r_backline2
this.Control[iCurrent+15]=this.r_backline3
this.Control[iCurrent+16]=this.uc_print
end on

on w_hac801a_help.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.p_msg)
destroy(this.st_msg)
destroy(this.uc_printpreview)
destroy(this.uc_cancel)
destroy(this.uc_ok)
destroy(this.uc_excel)
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

event ue_postopen;call super::ue_postopen;This.Center = True

parentwin = This.Parentwindow()

This.Post Event ue_button_set()

ivc	=Create Vector
ivc.Removeall()
ivc.setProperty("parm_cnt", "0")




s_insa_com	lstr_com
string		ls_bdgt_year, ls_gwa, ls_acct_code

lstr_com = message.powerobjectparm

ls_bdgt_year = lstr_com.ls_item[1]
ls_gwa       = lstr_com.ls_item[2]
ls_acct_code = lstr_com.ls_item[3]

dw_1.retrieve(ls_bdgt_year, ls_gwa, ls_acct_code, 1, '2', 0, 41)

end event

type dw_1 from uo_dwgrid within w_hac801a_help
integer x = 50
integer y = 176
integer width = 3483
integer height = 1260
integer taborder = 10
string dataobject = "d_hac801a_help"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type p_msg from picture within w_hac801a_help
integer x = 64
integer y = 1456
integer width = 59
integer height = 48
boolean originalsize = true
string picturename = "..\img\message_ico.gif"
boolean focusrectangle = false
end type

type st_msg from statictext within w_hac801a_help
integer x = 146
integer y = 1456
integer width = 3374
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

type uc_printpreview from u_picture within w_hac801a_help
integer x = 2331
integer y = 44
integer width = 366
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_preview.gif"
boolean callevent = true
string is_event = "ue_preview"
end type

type uc_cancel from u_picture within w_hac801a_help
integer x = 3269
integer y = 44
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_cancel.gif"
boolean callevent = true
string is_event = "ue_cancel"
end type

type uc_ok from u_picture within w_hac801a_help
integer x = 2990
integer y = 44
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_ok.gif"
boolean callevent = true
string is_event = "ue_close"
end type

type uc_excel from u_picture within w_hac801a_help
integer x = 2053
integer y = 44
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_excel.gif"
boolean callevent = true
string is_event = "ue_excel"
end type

type uc_retrieve from u_picture within w_hac801a_help
integer x = 1774
integer y = 44
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_retrieve.gif"
boolean callevent = true
string is_event = "ue_inquiry"
end type

type ln_temptop from line within w_hac801a_help
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 172
integer endx = 3566
integer endy = 172
end type

type ln_1 from line within w_hac801a_help
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 1516
integer endx = 3566
integer endy = 1516
end type

type ln_2 from line within w_hac801a_help
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 46
integer endx = 46
integer endy = 1572
end type

type ln_3 from line within w_hac801a_help
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 3534
integer endx = 3534
integer endy = 1572
end type

type r_backline1 from rectangle within w_hac801a_help
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 87
integer y = 60
integer width = 55
integer height = 48
end type

type r_backline2 from rectangle within w_hac801a_help
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 151
integer y = 60
integer width = 55
integer height = 48
end type

type r_backline3 from rectangle within w_hac801a_help
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 215
integer y = 60
integer width = 55
integer height = 48
end type

type uc_print from u_picture within w_hac801a_help
integer x = 2711
integer y = 44
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_print.gif"
boolean callevent = true
string is_event = "ue_print"
end type

