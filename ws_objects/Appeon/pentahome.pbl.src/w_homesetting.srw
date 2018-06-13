$PBExportHeader$w_homesetting.srw
forward
global type w_homesetting from window
end type
type st_2 from statictext within w_homesetting
end type
type st_1 from statictext within w_homesetting
end type
type p_cancel from u_picture within w_homesetting
end type
type p_ok from u_picture within w_homesetting
end type
type dw_1 from datawindow within w_homesetting
end type
end forward

global type w_homesetting from window
integer width = 1125
integer height = 1004
boolean titlebar = true
string title = "Home Setting"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "..\img\icon\icon_logo.ico"
boolean center = true
event ue_postopen ( )
st_2 st_2
st_1 st_1
p_cancel p_cancel
p_ok p_ok
dw_1 dw_1
end type
global w_homesetting w_homesetting

event ue_postopen();p_ok.of_enable(true)
p_cancel.of_enable(true)

vector   vc
vc = Create vector

vc.importfile('fulldatasetting.props')

String key
long	ll_row, ll_cnt
key = vc.getfirstproperty()
do while key <> ''
	ll_row = dw_1.insertrow(0)
	dw_1.setitem(ll_row, 'keyname', key)
	dw_1.setitem(ll_row, 'values', vc.getproperty(key))
	key = vc.getnextproperty( )
loop

vc.removeall()
vc.importfile('setting.props')
key = vc.getfirstproperty()
ll_row = 1
ll_cnt = dw_1.rowcount()

do while key <> ''
	ll_row = dw_1.find("keyname = '" + key + "'", ll_row, ll_cnt)
	if ll_row > 0 then
		dw_1.setitem(ll_row, 'checkyn', 'Y')
	else
		exit
	end if
	ll_row++
	IF ll_row > ll_cnt THEN exit
	key = vc.getnextproperty( )
loop
end event

on w_homesetting.create
this.st_2=create st_2
this.st_1=create st_1
this.p_cancel=create p_cancel
this.p_ok=create p_ok
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.st_1,&
this.p_cancel,&
this.p_ok,&
this.dw_1}
end on

on w_homesetting.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_cancel)
destroy(this.p_ok)
destroy(this.dw_1)
end on

event open;Post event ue_postopen()
end event

type st_2 from statictext within w_homesetting
integer x = 178
integer y = 824
integer width = 96
integer height = 68
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 134217730
long backcolor = 16777215
string text = "▼"
boolean focusrectangle = false
end type

event clicked;long		ll_row
ll_row = dw_1.getrow()
if dw_1.rowcount() + 1 >= ll_row + 2 then
	dw_1.rowsmove(ll_row , ll_row , primary!, dw_1, ll_row + 2, primary!)
	dw_1.setrow(ll_row + 1)
end if
end event

type st_1 from statictext within w_homesetting
integer x = 69
integer y = 828
integer width = 96
integer height = 68
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 134217730
long backcolor = 16777215
string text = "▲"
alignment alignment = right!
boolean focusrectangle = false
end type

event clicked;long		ll_row
ll_row = dw_1.getrow()
if ll_row - 1 >= 0 then
	dw_1.rowsmove(ll_row , ll_row , primary!, dw_1, ll_row - 1, primary!)
	ll_row --
	if ll_row = 0 then
		ll_row = 1
	end if
	dw_1.setrow(ll_row)
	dw_1.selectrow(0, false)
	dw_1.selectrow(ll_row, true)
end if
end event

type p_cancel from u_picture within w_homesetting
integer x = 827
integer y = 816
integer width = 206
integer height = 72
string picturename = "..\img\button\topBtn_cancel.gif"
end type

event clicked;call super::clicked;closewithreturn(parent, 0)
end event

type p_ok from u_picture within w_homesetting
integer x = 603
integer y = 816
integer width = 206
integer height = 72
string picturename = "..\img\button\topBtn_ok.gif"
end type

event clicked;call super::clicked;long		ll_row, ll_cnt
vector  vc
vc = create vector

ll_row = 1
dw_1.accepttext( )
ll_cnt	 = dw_1.rowcount()
do while true
	ll_row = dw_1.find("checkyn = '" + 'Y' + "'", ll_row, ll_cnt)
	if ll_row > 0 then
		vc.setproperty( dw_1.getitemstring(ll_row, 'keyname'), dw_1.getitemstring(ll_row, 'values'))
	else
		exit
	end if
	ll_row++
	if ll_row > ll_cnt then exit
loop

vc.exportfile('setting.props')
vc.removeall()

for ll_row = 1 to ll_cnt
	vc.setproperty( dw_1.getitemstring(ll_row, 'keyname'), dw_1.getitemstring(ll_row, 'values'))
next
vc.exportfile('fulldatasetting.props')
Destroy vc

messagebox('INFO', '프로그램을 재시작 하셔야 적용이 됩니다.')
closewithreturn(parent, 1)
end event

type dw_1 from datawindow within w_homesetting
integer width = 1097
integer height = 772
integer taborder = 10
string title = "none"
string dataobject = "d_homesetting"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;if currentrow > 0 then
	this.selectrow(0,false)
	this.selectrow(currentrow, true)
end if
end event

event clicked;if row > 0 then
	this.setrow(row)
end if
end event

