$PBExportHeader$w_response.srw
$PBExportComments$리리폰스 원도우의 폼을 parentwindow
forward
global type w_response from window
end type
type pb_cancel from u_picture within w_response
end type
type pb_ok from u_picture within w_response
end type
type st_sttitle00001 from statictext within w_response
end type
type dw_responst from uo_dwgrid within w_response
end type
end forward

global type w_response from window
integer x = 690
integer y = 348
integer width = 2775
integer height = 1316
boolean titlebar = true
string title = "레스포스 원도우"
windowtype windowtype = response!
event ue_open pbm_custom01
pb_cancel pb_cancel
pb_ok pb_ok
st_sttitle00001 st_sttitle00001
dw_responst dw_responst
end type
global w_response w_response

type prototypes
FUNCTION Boolean  AnimateWindow(Ulong hwnd,ulong dwtime,ulong dwflag)  LIBRARY "user32.dll"
end prototypes

type variables
string i_req_cd, i_req_name


end variables

event ue_open;f_centerme(this)

pb_ok.of_enable(true)
pb_cancel.of_enable(true)
end event

on w_response.create
this.pb_cancel=create pb_cancel
this.pb_ok=create pb_ok
this.st_sttitle00001=create st_sttitle00001
this.dw_responst=create dw_responst
this.Control[]={this.pb_cancel,&
this.pb_ok,&
this.st_sttitle00001,&
this.dw_responst}
end on

on w_response.destroy
destroy(this.pb_cancel)
destroy(this.pb_ok)
destroy(this.st_sttitle00001)
destroy(this.dw_responst)
end on

event open;Triggerevent('ue_open')
end event

event show;AnimateWindow(handle(this),500,30)
setredraw(TRUE)
end event

type pb_cancel from u_picture within w_response
integer x = 2482
integer y = 1128
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_cancel.gif"
end type

event clicked;call super::clicked;CloseWithReturn(parent,"")	
end event

type pb_ok from u_picture within w_response
integer x = 2199
integer y = 1128
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_ok.gif"
end type

type st_sttitle00001 from statictext within w_response
integer y = 1104
integer width = 2181
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
boolean focusrectangle = false
end type

type dw_responst from uo_dwgrid within w_response
event key_enter pbm_dwnprocessenter
integer y = 32
integer width = 2757
integer height = 1072
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
this.SettransObject(sqlca)
end event

event retrieveend;call super::retrieveend;IF rowcount > 0 then
	this.setrow(1)
//	this.Uf_selectrow(1)
end IF
end event

