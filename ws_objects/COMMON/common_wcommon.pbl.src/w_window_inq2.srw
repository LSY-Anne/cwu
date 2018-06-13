$PBExportHeader$w_window_inq2.srw
$PBExportComments$메인 상속윈도우(조회,출력만 사용:조회, 출력 모두 같은 DatWindow인 경우사용)
forward
global type w_window_inq2 from w_ancsheet
end type
type uc_retrieve from u_picture within w_window_inq2
end type
type uc_printpreview from u_picture within w_window_inq2
end type
type uc_confirmpreview from u_picture within w_window_inq2
end type
type uc_confirm from u_picture within w_window_inq2
end type
type st_line1 from statictext within w_window_inq2
end type
type st_line2 from statictext within w_window_inq2
end type
type st_line3 from statictext within w_window_inq2
end type
type uc_autoadd from u_picture within w_window_inq2
end type
type uc_pcsave from u_picture within w_window_inq2
end type
type uc_excel from u_picture within w_window_inq2
end type
type dw_con from uo_dw within w_window_inq2
end type
type uc_close from u_picture within w_window_inq2
end type
type uc_fullview from u_picture within w_window_inq2
end type
type dw_main from u_dw within w_window_inq2
end type
end forward

global type w_window_inq2 from w_ancsheet
event type long ue_inquiry ( )
event ue_insert ( )
event ue_delete ( )
event type long ue_save ( )
event type long ue_preview ( )
event ue_print ( )
event ue_resize_dw ( ref statictext ast,  datawindow adw )
event ue_excel ( )
event type long ue_excelload ( )
event type long ue_confirm ( )
event type long ue_confirmpreview ( )
event ue_button_set ( )
event type long ue_updatequery ( )
event type long ue_update ( )
event type integer ue_sp_call ( )
event type integer ue_savestart ( )
event type integer ue_saveend ( )
event type long ue_autoadd ( )
event type long ue_pcsave ( )
event ue_close ( )
event ue_fullview ( )
uc_retrieve uc_retrieve
uc_printpreview uc_printpreview
uc_confirmpreview uc_confirmpreview
uc_confirm uc_confirm
st_line1 st_line1
st_line2 st_line2
st_line3 st_line3
uc_autoadd uc_autoadd
uc_pcsave uc_pcsave
uc_excel uc_excel
dw_con dw_con
uc_close uc_close
uc_fullview uc_fullview
dw_main dw_main
end type
global w_window_inq2 w_window_inq2

type variables
window							parentwin

Boolean	ib_help				=	FALSE
Boolean	ib_pcsave			=	FALSE
Boolean	ib_autoadd		=	FALSE
Boolean	ib_confirm			=	FALSE
Boolean	ib_confirmpreview	=	FALSE
Boolean	ib_printpreview	=	FALSE
Boolean	ib_fullview			=	FALSE
Boolean	ib_excel				=	FALSE
Boolean	ib_retrieve			=	FALSE
Boolean	ib_close				=	FALSE
String		is_disp_kind			=	'R'
String		is_mrd_name

Boolean	ib_retrieve_wait	= FALSE
Boolean	ib_preview_wait	= FALSE
String		is_code_name

end variables

forward prototypes
public subroutine wf_button_set ()
end prototypes

event type long ue_inquiry();Long		ll_rv

SetPointer(HourGlass!)
If ib_retrieve_wait Then
	gf_openwait()
End If

//ll_rv = uo_report.Event ue_Retrieve()
If ll_rv > 0 Then
	f_set_message("[조회] " + String(ll_rv) + '페이지의 자료가 조회되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	f_set_message("[조회] " + '자료가 없습니다.', '', parentwin)
Else
	f_set_message("[조회] " + '오류가 발생했습니다.', '', parentwin)
End If

If ib_retrieve_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)

RETURN ll_rv

end event

event type long ue_preview();//If uo_report.Ole_RD.Object.IsNoData() Then
//	gf_message(parentwin, 2, '9999', '알림', '데이터를 먼저 조회하신 후 실행하십시요.')
//	RETURN -1
//End If

SetPointer(HourGlass!)
If ib_preview_wait Then
	gf_openwait()
End If

is_disp_kind = 'P'
wf_button_set()

If ib_preview_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)

RETURN 1

end event

event ue_resize_dw(ref statictext ast, datawindow adw);// uo_dwlv inherit 시 dw 위,아래 라인 표시 
Long	ll_x
Long	ll_y
Long	ll_width
Long	ll_height

ast.Visible		= TRUE

ll_x				= adw.X
ll_y				= adw.Y
ll_width			= adw.Width
ll_height			= adw.height

ll_y				= ll_y - 4
ll_height			= ll_height + 8

ast.X				= ll_x
ast.Y				= ll_y
ast.Width		= ll_width
ast.Height		= ll_height

ast.BringToTop	= FALSE

This.setredraw(TRUE)


end event

event type long ue_confirm();RETURN 1

end event

event type long ue_confirmpreview();RETURN 1

end event

event ue_button_set();ib_pcsave			=	uc_pcsave.Enabled
ib_autoadd			=	uc_autoadd.Enabled
ib_confirm			=	uc_confirm.Enabled
ib_confirmpreview	=	uc_confirmpreview.Enabled
ib_printpreview	=	uc_printpreview.Enabled
ib_fullview			=	uc_fullview.Enabled
ib_excel				=	uc_excel.Enabled
ib_retrieve			=	uc_retrieve.Enabled
ib_close				=	uc_close.Enabled

wf_button_set()

end event

event ue_autoadd;RETURN 1

end event

event ue_pcsave;RETURN 1

end event

event ue_close();
is_disp_kind = 'R'
wf_button_set()

end event

public subroutine wf_button_set ();Long			ll_stnd_pos

//ll_stnd_pos	=	This.width - 50
ll_stnd_pos = ln_tempright.beginx

If ib_close And is_disp_kind = 'P' Then
	uc_close.X			= ll_stnd_pos - uc_close.Width
	ll_stnd_pos			= ll_stnd_pos - uc_close.Width - 16
	uc_close.Visible	= TRUE
Else
	uc_close.Visible	= FALSE
End If

If ib_pcsave And is_disp_kind = 'P' Then
	uc_pcsave.X			= ll_stnd_pos - uc_pcsave.Width
	ll_stnd_pos			= ll_stnd_pos - uc_pcsave.Width - 16
	uc_pcsave.Visible	= TRUE
Else
	uc_pcsave.Visible	= FALSE
End If

If ib_autoadd And is_disp_kind = 'P' Then
	uc_autoadd.X			= ll_stnd_pos - uc_autoadd.Width
	ll_stnd_pos				= ll_stnd_pos - uc_autoadd.Width - 16
	uc_autoadd.Visible		= TRUE
Else
	uc_autoadd.Visible		= FALSE
End If

If ib_confirm And is_disp_kind = 'R' Then
	uc_confirm.X		= ll_stnd_pos - uc_confirm.Width
	ll_stnd_pos			= ll_stnd_pos - uc_confirm.Width - 16
	uc_confirm.Visible	= TRUE
Else
	uc_confirm.Visible	= FALSE
End If

If ib_confirmpreview And is_disp_kind = 'R' Then
	uc_confirmpreview.X			= ll_stnd_pos - uc_confirmpreview.Width
	ll_stnd_pos						= ll_stnd_pos - uc_confirmpreview.Width - 16
	uc_confirmpreview.Visible	= TRUE
Else
	uc_confirmpreview.Visible	= FALSE
End If

If ib_printpreview And is_disp_kind = 'R' Then
	uc_printpreview.X			= ll_stnd_pos - uc_printpreview.Width
	ll_stnd_pos					= ll_stnd_pos - uc_printpreview.Width - 16
	uc_printpreview.Visible	= TRUE
Else
	uc_printpreview.Visible	= FALSE
End If

If ib_fullview And is_disp_kind = 'R' Then
	uc_fullview.X			= ll_stnd_pos - uc_fullview.Width
	ll_stnd_pos				= ll_stnd_pos - uc_fullview.Width - 16
	uc_fullview.Visible	= TRUE
Else
	uc_fullview.Visible	= FALSE
End If

If ib_excel And is_disp_kind = 'R' Then
	uc_excel.X			= ll_stnd_pos - uc_excel.Width
	ll_stnd_pos			= ll_stnd_pos - uc_excel.Width - 16
	uc_excel.Visible	= TRUE
Else
	uc_excel.Visible	= FALSE
End If

If ib_retrieve And is_disp_kind = 'R' Then
	uc_retrieve.X		= ll_stnd_pos - uc_retrieve.Width
	ll_stnd_pos			= ll_stnd_pos - uc_retrieve.Width - 16
	uc_retrieve.Visible	= TRUE
Else
	uc_retrieve.Visible	= FALSE
End If

If is_disp_kind = 'R' Then
//	uo_report.Ole_RD.Object.HideToolbar();                  //Hide of Toolbar
//	uo_report.y					= 352
//	uo_report.height			= 1696
//	uo_report.Ole_RD.height	= 1596
Else
//	uo_report.Ole_RD.Object.ShowToolbar();                //Hide of Toolbar
//	uo_report.y					= 176
//	uo_report.height			= 1872
//	uo_report.Ole_RD.height	= 1772
End If

end subroutine

on w_window_inq2.create
int iCurrent
call super::create
this.uc_retrieve=create uc_retrieve
this.uc_printpreview=create uc_printpreview
this.uc_confirmpreview=create uc_confirmpreview
this.uc_confirm=create uc_confirm
this.st_line1=create st_line1
this.st_line2=create st_line2
this.st_line3=create st_line3
this.uc_autoadd=create uc_autoadd
this.uc_pcsave=create uc_pcsave
this.uc_excel=create uc_excel
this.dw_con=create dw_con
this.uc_close=create uc_close
this.uc_fullview=create uc_fullview
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uc_retrieve
this.Control[iCurrent+2]=this.uc_printpreview
this.Control[iCurrent+3]=this.uc_confirmpreview
this.Control[iCurrent+4]=this.uc_confirm
this.Control[iCurrent+5]=this.st_line1
this.Control[iCurrent+6]=this.st_line2
this.Control[iCurrent+7]=this.st_line3
this.Control[iCurrent+8]=this.uc_autoadd
this.Control[iCurrent+9]=this.uc_pcsave
this.Control[iCurrent+10]=this.uc_excel
this.Control[iCurrent+11]=this.dw_con
this.Control[iCurrent+12]=this.uc_close
this.Control[iCurrent+13]=this.uc_fullview
this.Control[iCurrent+14]=this.dw_main
end on

on w_window_inq2.destroy
call super::destroy
destroy(this.uc_retrieve)
destroy(this.uc_printpreview)
destroy(this.uc_confirmpreview)
destroy(this.uc_confirm)
destroy(this.st_line1)
destroy(this.st_line2)
destroy(this.st_line3)
destroy(this.uc_autoadd)
destroy(this.uc_pcsave)
destroy(this.uc_excel)
destroy(this.dw_con)
destroy(this.uc_close)
destroy(this.uc_fullview)
destroy(this.dw_main)
end on

event ue_postopen;call super::ue_postopen;parentwin = This.Parentwindow()

func.of_design_dw( dw_con )

dw_con.insertrow(0)

This.Post Event ue_button_set()

f_set_message("[OPEN] " + '준비되었습니다.', '', parentwin)

end event

event activate;//Ancestor Script Override
parentwin = This.Parentwindow()
If IsValid(parentwin) Then
	If This.windowtype = MAIN! Then parentwin.Dynamic wf_select(This.ClassName())
	
	gs_PgmId			= Upper(This.ClassName())
	gs_activewindow	= This
	
//	f_set_message('', '', parentwin)			// 메세지 초기화
	f_set_PgmId(gs_PgmId, parentwin)	// 프로그램 ID Setting
	
	This.x			= 0
	This.y			= 0
	This.width	= parentwin.Dynamic wf_getmdiwidth()
	This.height	= parentwin.Dynamic wf_getmdiheight()
End If

end event

type ln_templeft from w_ancsheet`ln_templeft within w_window_inq2
end type

type ln_tempright from w_ancsheet`ln_tempright within w_window_inq2
end type

type ln_temptop from w_ancsheet`ln_temptop within w_window_inq2
end type

type ln_tempbuttom from w_ancsheet`ln_tempbuttom within w_window_inq2
end type

type ln_tempbutton from w_ancsheet`ln_tempbutton within w_window_inq2
end type

type ln_tempstart from w_ancsheet`ln_tempstart within w_window_inq2
end type

type uc_retrieve from u_picture within w_window_inq2
integer x = 1189
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_retrieve.gif"
string is_event = "ue_inquiry"
end type

type uc_printpreview from u_picture within w_window_inq2
integer x = 2162
integer y = 40
integer width = 393
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_preview.gif"
string is_event = "ue_preview"
end type

type uc_confirmpreview from u_picture within w_window_inq2
integer x = 2542
integer y = 40
integer width = 366
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_setview.gif"
string is_event = "ue_confirmpreviw"
end type

type uc_confirm from u_picture within w_window_inq2
integer x = 2921
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_set.gif"
string is_event = "ue_confirm"
end type

type st_line1 from statictext within w_window_inq2
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

type st_line2 from statictext within w_window_inq2
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

type st_line3 from statictext within w_window_inq2
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

type uc_autoadd from u_picture within w_window_inq2
integer x = 3301
integer y = 40
integer width = 480
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_autoadd.gif"
string is_event = "ue_autoadd"
end type

type uc_pcsave from u_picture within w_window_inq2
integer x = 3794
integer y = 40
integer width = 366
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_pcsave.gif"
string is_event = "ue_pcsave"
end type

type uc_excel from u_picture within w_window_inq2
integer x = 1467
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_excel.gif"
string is_event = "ue_excel"
end type

type dw_con from uo_dw within w_window_inq2
integer x = 50
integer y = 176
integer width = 4389
integer height = 140
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uc_close from u_picture within w_window_inq2
integer x = 4174
integer y = 40
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_close.gif"
string is_event = "ue_close"
end type

type uc_fullview from u_picture within w_window_inq2
integer x = 1746
integer y = 40
integer width = 402
integer height = 96
boolean bringtotop = true
string picturename = "..\img\button\topBtn_zoom.gif"
string is_event = "ue_fullview"
end type

type dw_main from u_dw within w_window_inq2
integer x = 50
integer y = 352
integer width = 4389
integer height = 1696
integer taborder = 20
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

