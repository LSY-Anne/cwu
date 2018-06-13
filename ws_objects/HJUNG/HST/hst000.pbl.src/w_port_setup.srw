$PBExportHeader$w_port_setup.srw
$PBExportComments$portsetup및 기타 [샘플예제 || 삭제불가]
forward
global type w_port_setup from window
end type
type cb_1 from commandbutton within w_port_setup
end type
type rb_stb2 from radiobutton within w_port_setup
end type
type rb_stb15 from radiobutton within w_port_setup
end type
type rb_stb1 from radiobutton within w_port_setup
end type
type rb_prot_none from radiobutton within w_port_setup
end type
type rb_prot_rts_cts from radiobutton within w_port_setup
end type
type rb_prot_xon_xoff from radiobutton within w_port_setup
end type
type rb_space from radiobutton within w_port_setup
end type
type rb_mark from radiobutton within w_port_setup
end type
type rb_even from radiobutton within w_port_setup
end type
type rb_odd from radiobutton within w_port_setup
end type
type rb_no from radiobutton within w_port_setup
end type
type rb_d8 from radiobutton within w_port_setup
end type
type rb_d7 from radiobutton within w_port_setup
end type
type rb_d6 from radiobutton within w_port_setup
end type
type rb_d5 from radiobutton within w_port_setup
end type
type gb_5 from groupbox within w_port_setup
end type
type gb_4 from groupbox within w_port_setup
end type
type gb_3 from groupbox within w_port_setup
end type
type gb_2 from groupbox within w_port_setup
end type
type ddlb_port from dropdownlistbox within w_port_setup
end type
type ddlb_baudrate from dropdownlistbox within w_port_setup
end type
type st_1 from statictext within w_port_setup
end type
type st_2 from statictext within w_port_setup
end type
end forward

global type w_port_setup from window
integer width = 1280
integer height = 1284
boolean titlebar = true
string title = "RS232 - Setup"
boolean controlmenu = true
windowtype windowtype = response!
cb_1 cb_1
rb_stb2 rb_stb2
rb_stb15 rb_stb15
rb_stb1 rb_stb1
rb_prot_none rb_prot_none
rb_prot_rts_cts rb_prot_rts_cts
rb_prot_xon_xoff rb_prot_xon_xoff
rb_space rb_space
rb_mark rb_mark
rb_even rb_even
rb_odd rb_odd
rb_no rb_no
rb_d8 rb_d8
rb_d7 rb_d7
rb_d6 rb_d6
rb_d5 rb_d5
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
ddlb_port ddlb_port
ddlb_baudrate ddlb_baudrate
st_1 st_1
st_2 st_2
end type
global w_port_setup w_port_setup

type variables
n_tty  u_tty

end variables

forward prototypes
public subroutine get_v24 ()
public subroutine set_v24 ()
end prototypes

public subroutine get_v24 ();
// GET Commport
IF u_tty.commport = "" THEN 
	 ddlb_port.text = "COM1"
ELSE
 	 ddlb_port.text = u_tty.commport
END IF


// Get Bauderate
ddlb_baudrate.text = string(u_tty.baudrate)

// Get Stopbits
CHOOSE CASE u_tty.stopbits
	CASE "1"
		rb_stb1.checked = TRUE
      rb_d5.enabled = FALSE
      rb_d6.enabled = TRUE
      rb_d7.enabled = TRUE
      rb_d8.enabled = TRUE
	CASE "1,5"
		rb_stb15.checked = TRUE
      rb_d5.enabled = TRUE
      rb_d6.enabled = FALSE
      rb_d7.enabled = FALSE
      rb_d8.enabled = FALSE
	CASE "2"
		rb_stb2.checked = TRUE
      rb_d5.enabled = FALSE
      rb_d6.enabled = TRUE
      rb_d7.enabled = TRUE
      rb_d8.enabled = TRUE
END CHOOSE

// Get Databits
CHOOSE CASE u_tty.bytesize
	CASE 5
		rb_d5.checked = TRUE
	CASE 6
		rb_d6.checked = TRUE
	CASE 7
		rb_d7.checked = TRUE
	CASE 8
		rb_d8.checked = TRUE
END CHOOSE

// Get PARITY
CHOOSE CASE u_tty.parity
	CASE "N"
		rb_no.checked = TRUE
	CASE "O"
		rb_odd.checked = TRUE
	CASE "E"
		rb_even.checked = TRUE
	CASE "M"
		rb_mark.checked = TRUE
	CASE "S"
		rb_space.checked = TRUE
END CHOOSE


// Get Protokoll Handshake
CHOOSE CASE u_tty.handshake
	CASE "NO"
		rb_prot_none.checked = TRUE
	CASE "XON_XOFF"
		rb_prot_xon_xoff.checked = TRUE
	CASE "RTS_CTS"
		rb_prot_rts_cts.checked = TRUE
END CHOOSE




end subroutine

public subroutine set_v24 ();

// Set Commport
u_tty.commport = ddlb_port.text

// Set Bauderate
u_tty.baudrate = integer(ddlb_baudrate.text)

// Set Databits
IF rb_d5.checked THEN u_tty.bytesize = 5
IF rb_d6.checked THEN u_tty.bytesize = 6
IF rb_d7.checked THEN u_tty.bytesize = 7
IF rb_d8.checked THEN u_tty.bytesize = 8


// Set Stopbits
IF rb_stb1.checked  THEN u_tty.stopbits = "1"
IF rb_stb15.checked THEN u_tty.stopbits = "1,5"
IF rb_stb2.checked  THEN u_tty.stopbits = "2"



// Set parity
IF rb_no.checked THEN u_tty.parity = "N"
IF rb_odd.checked THEN u_tty.parity = "O"
IF rb_even.checked THEN u_tty.parity = "E"
IF rb_mark.checked THEN u_tty.parity = "M"
IF rb_space.checked THEN u_tty.parity = "S"


// Set Protokoll hanshake
IF rb_prot_none.checked THEN u_tty.handshake = "NO"
IF rb_prot_xon_xoff.checked THEN u_tty.handshake = "XON_XOFF"
IF rb_prot_rts_cts.checked THEN u_tty.handshake = "RTS_CTS"
end subroutine

event open;u_tty = message.powerobjectparm
get_v24()
end event

on w_port_setup.create
this.cb_1=create cb_1
this.rb_stb2=create rb_stb2
this.rb_stb15=create rb_stb15
this.rb_stb1=create rb_stb1
this.rb_prot_none=create rb_prot_none
this.rb_prot_rts_cts=create rb_prot_rts_cts
this.rb_prot_xon_xoff=create rb_prot_xon_xoff
this.rb_space=create rb_space
this.rb_mark=create rb_mark
this.rb_even=create rb_even
this.rb_odd=create rb_odd
this.rb_no=create rb_no
this.rb_d8=create rb_d8
this.rb_d7=create rb_d7
this.rb_d6=create rb_d6
this.rb_d5=create rb_d5
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.ddlb_port=create ddlb_port
this.ddlb_baudrate=create ddlb_baudrate
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.cb_1,&
this.rb_stb2,&
this.rb_stb15,&
this.rb_stb1,&
this.rb_prot_none,&
this.rb_prot_rts_cts,&
this.rb_prot_xon_xoff,&
this.rb_space,&
this.rb_mark,&
this.rb_even,&
this.rb_odd,&
this.rb_no,&
this.rb_d8,&
this.rb_d7,&
this.rb_d6,&
this.rb_d5,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.ddlb_port,&
this.ddlb_baudrate,&
this.st_1,&
this.st_2}
end on

on w_port_setup.destroy
destroy(this.cb_1)
destroy(this.rb_stb2)
destroy(this.rb_stb15)
destroy(this.rb_stb1)
destroy(this.rb_prot_none)
destroy(this.rb_prot_rts_cts)
destroy(this.rb_prot_xon_xoff)
destroy(this.rb_space)
destroy(this.rb_mark)
destroy(this.rb_even)
destroy(this.rb_odd)
destroy(this.rb_no)
destroy(this.rb_d8)
destroy(this.rb_d7)
destroy(this.rb_d6)
destroy(this.rb_d5)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.ddlb_port)
destroy(this.ddlb_baudrate)
destroy(this.st_1)
destroy(this.st_2)
end on

event close;set_v24()
end event

type cb_1 from commandbutton within w_port_setup
integer x = 727
integer y = 1048
integer width = 389
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean default = true
end type

event clicked;Close(Parent)
end event

type rb_stb2 from radiobutton within w_port_setup
integer x = 421
integer y = 468
integer width = 137
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "2"
end type

event clicked;rb_d5.enabled = FALSE
rb_d6.enabled = TRUE
rb_d7.enabled = TRUE
rb_d8.enabled = TRUE
rb_d8.checked = TRUE

end event

type rb_stb15 from radiobutton within w_port_setup
integer x = 224
integer y = 468
integer width = 174
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "1,5"
end type

event clicked;rb_d5.enabled = TRUE
rb_d6.enabled = FALSE
rb_d7.enabled = FALSE
rb_d8.enabled = FALSE
rb_d5.checked = TRUE
end event

type rb_stb1 from radiobutton within w_port_setup
integer x = 78
integer y = 468
integer width = 137
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "1"
end type

event clicked;rb_d5.enabled = FALSE
rb_d6.enabled = TRUE
rb_d7.enabled = TRUE
rb_d8.enabled = TRUE
rb_d8.checked = TRUE

end event

type rb_prot_none from radiobutton within w_port_setup
integer x = 105
integer y = 872
integer width = 357
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Keine"
end type

type rb_prot_rts_cts from radiobutton within w_port_setup
integer x = 105
integer y = 788
integer width = 393
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Hardware"
end type

type rb_prot_xon_xoff from radiobutton within w_port_setup
integer x = 105
integer y = 700
integer width = 384
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Xon/Xoff"
end type

type rb_space from radiobutton within w_port_setup
integer x = 667
integer y = 856
integer width = 489
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Leerzeichen"
end type

type rb_mark from radiobutton within w_port_setup
integer x = 667
integer y = 768
integer width = 457
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Markierung"
end type

type rb_even from radiobutton within w_port_setup
integer x = 667
integer y = 684
integer width = 430
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Gerade"
end type

type rb_odd from radiobutton within w_port_setup
integer x = 667
integer y = 600
integer width = 439
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ungerade"
end type

type rb_no from radiobutton within w_port_setup
integer x = 667
integer y = 516
integer width = 357
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Keine"
end type

type rb_d8 from radiobutton within w_port_setup
integer x = 544
integer y = 276
integer width = 137
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "8"
end type

type rb_d7 from radiobutton within w_port_setup
integer x = 393
integer y = 276
integer width = 137
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "7"
end type

type rb_d6 from radiobutton within w_port_setup
integer x = 233
integer y = 276
integer width = 137
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "6"
end type

type rb_d5 from radiobutton within w_port_setup
integer x = 82
integer y = 276
integer width = 137
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "5"
end type

type gb_5 from groupbox within w_port_setup
integer x = 46
integer y = 388
integer width = 530
integer height = 192
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Stopbits"
end type

type gb_4 from groupbox within w_port_setup
integer x = 46
integer y = 628
integer width = 462
integer height = 336
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Pr&otokoll"
end type

type gb_3 from groupbox within w_port_setup
integer x = 608
integer y = 424
integer width = 585
integer height = 524
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Parity"
end type

type gb_2 from groupbox within w_port_setup
integer x = 41
integer y = 176
integer width = 672
integer height = 192
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Datenbits"
end type

type ddlb_port from dropdownlistbox within w_port_setup
integer x = 320
integer y = 24
integer width = 453
integer height = 416
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "COM1"
boolean vscrollbar = true
string item[] = {"COM1","COM2","COM3","COM4"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_baudrate from dropdownlistbox within w_port_setup
integer x = 741
integer y = 208
integer width = 434
integer height = 520
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "110"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"110","300","600","1200","2400","4800","9600","19200","38400","56000","128000","256000"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;/*
19200 
38400 
56000 
128000 
256000 
*/
end event

type st_1 from statictext within w_port_setup
integer x = 14
integer y = 36
integer width = 274
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "COMPORT:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_port_setup
integer x = 745
integer y = 120
integer width = 288
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Bauderate:"
alignment alignment = right!
boolean focusrectangle = false
end type

