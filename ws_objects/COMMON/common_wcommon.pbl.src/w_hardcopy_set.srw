$PBExportHeader$w_hardcopy_set.srw
$PBExportComments$화면인쇄 Popup 윈도우 ( response )
forward
global type w_hardcopy_set from w_response_ancestor_r
end type
type p_close from u_picture within w_hardcopy_set
end type
type p_print from u_picture within w_hardcopy_set
end type
type p_1 from picture within w_hardcopy_set
end type
type st_1 from statictext within w_hardcopy_set
end type
type uc_printersetup from uo_imgbtn within w_hardcopy_set
end type
type st_2 from statictext within w_hardcopy_set
end type
type st_printer from statictext within w_hardcopy_set
end type
type em_prt from editmask within w_hardcopy_set
end type
type st_3 from statictext within w_hardcopy_set
end type
type vsb_1 from vscrollbar within w_hardcopy_set
end type
type gb_1 from groupbox within w_hardcopy_set
end type
end forward

global type w_hardcopy_set from w_response_ancestor_r
integer width = 2199
integer height = 904
string title = "화면인쇄"
event uc_copy ( )
p_close p_close
p_print p_print
p_1 p_1
st_1 st_1
uc_printersetup uc_printersetup
st_2 st_2
st_printer st_printer
em_prt em_prt
st_3 st_3
vsb_1 vsb_1
gb_1 gb_1
end type
global w_hardcopy_set w_hardcopy_set

type variables
Vector	ivc

end variables

on w_hardcopy_set.create
int iCurrent
call super::create
this.p_close=create p_close
this.p_print=create p_print
this.p_1=create p_1
this.st_1=create st_1
this.uc_printersetup=create uc_printersetup
this.st_2=create st_2
this.st_printer=create st_printer
this.em_prt=create em_prt
this.st_3=create st_3
this.vsb_1=create vsb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_close
this.Control[iCurrent+2]=this.p_print
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.uc_printersetup
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_printer
this.Control[iCurrent+8]=this.em_prt
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.vsb_1
this.Control[iCurrent+11]=this.gb_1
end on

on w_hardcopy_set.destroy
call super::destroy
destroy(this.p_close)
destroy(this.p_print)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.uc_printersetup)
destroy(this.st_2)
destroy(this.st_printer)
destroy(this.em_prt)
destroy(this.st_3)
destroy(this.vsb_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;This.Center = True

st_printer.Text	= PrintGetPrinter()
em_prt.Text		= '1'

ivc	=Create Vector
ivc.Removeall()
ivc.setProperty("parm_cnt", "1")
ivc.setProperty("parm_str",	"0")

end event

event close;call super::close;CloseWithReturn(This, ivc)

end event

type uc_retrieve from w_response_ancestor_r`uc_retrieve within w_hardcopy_set
boolean visible = false
end type

type uc_ok from w_response_ancestor_r`uc_ok within w_hardcopy_set
boolean visible = false
end type

type uc_cancel from w_response_ancestor_r`uc_cancel within w_hardcopy_set
boolean visible = false
end type

type ln_temptop from w_response_ancestor_r`ln_temptop within w_hardcopy_set
end type

type ln_1 from w_response_ancestor_r`ln_1 within w_hardcopy_set
end type

type ln_2 from w_response_ancestor_r`ln_2 within w_hardcopy_set
end type

type ln_3 from w_response_ancestor_r`ln_3 within w_hardcopy_set
integer beginx = 2149
integer endx = 2149
end type

type p_close from u_picture within w_hardcopy_set
integer x = 1847
integer y = 708
integer width = 306
integer height = 96
boolean bringtotop = true
string picturename = "..\img\topBtn_close.gif"
boolean #callevent = true
end type

event clicked;//Override Ancestor Script

ivc.setProperty("parm_cnt",	"1")
ivc.setProperty("parm_str",	"0")

Close(Parent)

end event

type p_print from u_picture within w_hardcopy_set
integer x = 1522
integer y = 708
integer width = 306
integer height = 96
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\topBtn_print.gif"
boolean #callevent = true
end type

event clicked;//Override Ancestor Script

ivc.setProperty("parm_cnt",	"1")
ivc.setProperty("parm_str",	func.of_nvl(String(em_prt.Text), ''))

Close(Parent)

end event

type p_1 from picture within w_hardcopy_set
integer x = 59
integer y = 80
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\front_title_img.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within w_hardcopy_set
integer x = 119
integer y = 76
integer width = 672
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 20286463
long backcolor = 16777215
string text = "장애내역 화면인쇄"
boolean focusrectangle = false
end type

event clicked;//Parent.uc_retrieve.PictureName = "C:\SIM\IMG\topBtn_retrieve.gif"
//Parent.uc_retrieve.enabled = True
//
//
//func.of_pb_enable('retrieve', uc_retrieve, True)
//func.of_pb_enable('input', p_insert, True)
//
end event

type uc_printersetup from uo_imgbtn within w_hardcopy_set
event destroy ( )
integer x = 1486
integer y = 308
integer width = 622
integer height = 84
integer taborder = 80
boolean bringtotop = true
string #btnname = "    Printer Setup    "
end type

on uc_printersetup.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;printsetup()
st_printer.Text = PrintGetPrinter()

end event

type st_2 from statictext within w_hardcopy_set
integer x = 114
integer y = 324
integer width = 137
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long backcolor = 16777215
string text = "이름"
boolean focusrectangle = false
end type

type st_printer from statictext within w_hardcopy_set
integer x = 251
integer y = 324
integer width = 1202
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long backcolor = 16777215
boolean focusrectangle = false
end type

type em_prt from editmask within w_hardcopy_set
integer x = 987
integer y = 472
integer width = 247
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#0"
end type

event modified;If Long(THIS.Text) <= 0 Then
	MessageBox('확인', '인쇄매수는 양수를 입력해야 합니다.')
	THIS.Text = '1'
End If

end event

type st_3 from statictext within w_hardcopy_set
integer x = 736
integer y = 492
integer width = 242
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long backcolor = 16777215
string text = "인쇄매수"
boolean focusrectangle = false
end type

type vsb_1 from vscrollbar within w_hardcopy_set
integer x = 1239
integer y = 460
integer width = 78
integer height = 108
boolean bringtotop = true
end type

event linedown;long l_temp

l_temp = long(em_prt.Text)

if l_temp > 1 then
	l_temp --
	em_prt.Text = string(l_temp,'###0')
end if

em_prt.SelectText(1,Len(em_prt.Text))

end event

event lineup;long l_temp

l_temp = long(em_prt.Text)

if l_temp = 9999 Then Return

l_temp ++
em_prt.Text = string(l_temp,'###0')

em_prt.SelectText(1,Len(em_prt.Text))

end event

type gb_1 from groupbox within w_hardcopy_set
integer x = 46
integer y = 176
integer width = 2107
integer height = 508
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long backcolor = 16777215
string text = "프린터"
end type

