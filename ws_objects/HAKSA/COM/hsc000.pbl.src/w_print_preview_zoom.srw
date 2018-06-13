$PBExportHeader$w_print_preview_zoom.srw
$PBExportComments$[공통]zoom percent
forward
global type w_print_preview_zoom from window
end type
type st_1 from statictext within w_print_preview_zoom
end type
type em_zoom from editmask within w_print_preview_zoom
end type
type hsb_zoom from hscrollbar within w_print_preview_zoom
end type
type cb_cancel from commandbutton within w_print_preview_zoom
end type
type cb_ok from commandbutton within w_print_preview_zoom
end type
type rb_custom from radiobutton within w_print_preview_zoom
end type
type rb_30 from radiobutton within w_print_preview_zoom
end type
type rb_65 from radiobutton within w_print_preview_zoom
end type
type rb_100 from radiobutton within w_print_preview_zoom
end type
type rb_200 from radiobutton within w_print_preview_zoom
end type
type gb_magnification from groupbox within w_print_preview_zoom
end type
end forward

global type w_print_preview_zoom from window
integer x = 645
integer y = 1076
integer width = 1367
integer height = 944
boolean titlebar = true
string title = "미리보기창"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
string icon = ".\Tutorial.ico"
toolbaralignment toolbaralignment = alignatleft!
st_1 st_1
em_zoom em_zoom
hsb_zoom hsb_zoom
cb_cancel cb_cancel
cb_ok cb_ok
rb_custom rb_custom
rb_30 rb_30
rb_65 rb_65
rb_100 rb_100
rb_200 rb_200
gb_magnification gb_magnification
end type
global w_print_preview_zoom w_print_preview_zoom

type variables

end variables

event open;/*------------------------------------------------------------------------------------
	This response window expects to be opened using OpenWithParm and
	looks for a zoom percentage to be passed.
	
	It uses CloseWithReturn to return the user-specified 
	zoom % if user clicks OK button.
	It returns a -1 if user clicks Cancel.
----------------------------------------------------------------------------------*/
INTEGER	zoom_pct

zoom_pct = Message.Doubleparm
//zoom_pct = 30

IF zoom_pct < 1 THEN zoom_pct = 100

CHOOSE CASE zoom_pct
  CASE 200
    rb_200.checked = TRUE
  CASE 100
    rb_100.checked = TRUE
  CASE 65
    rb_65.checked  = TRUE
  CASE 30
    rb_30.checked  = TRUE
  CASE ELSE
    rb_custom.checked	=	TRUE
    em_zoom.text	=	String(zoom_pct)
    hsb_zoom.position	=	zoom_pct
END CHOOSE
end event

on w_print_preview_zoom.create
this.st_1=create st_1
this.em_zoom=create em_zoom
this.hsb_zoom=create hsb_zoom
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.rb_custom=create rb_custom
this.rb_30=create rb_30
this.rb_65=create rb_65
this.rb_100=create rb_100
this.rb_200=create rb_200
this.gb_magnification=create gb_magnification
this.Control[]={this.st_1,&
this.em_zoom,&
this.hsb_zoom,&
this.cb_cancel,&
this.cb_ok,&
this.rb_custom,&
this.rb_30,&
this.rb_65,&
this.rb_100,&
this.rb_200,&
this.gb_magnification}
end on

on w_print_preview_zoom.destroy
destroy(this.st_1)
destroy(this.em_zoom)
destroy(this.hsb_zoom)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.rb_custom)
destroy(this.rb_30)
destroy(this.rb_65)
destroy(this.rb_100)
destroy(this.rb_200)
destroy(this.gb_magnification)
end on

type st_1 from statictext within w_print_preview_zoom
integer x = 699
integer y = 424
integer width = 50
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "%"
boolean focusrectangle = false
end type

type em_zoom from editmask within w_print_preview_zoom
integer x = 521
integer y = 412
integer width = 165
integer height = 76
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
string mask = "###"
end type

on modified;hsb_zoom.position = integer(this.text)
end on

event getfocus;rb_custom.checked	=	true
em_zoom.text	=	String(hsb_zoom.Position)
end event

type hsb_zoom from hscrollbar within w_print_preview_zoom
integer x = 133
integer y = 504
integer width = 645
integer height = 64
integer minposition = 10
integer maxposition = 200
integer position = 100
end type

event moved;em_zoom.Text = string(This.position)
rb_custom.Checked = TRUE
end event

event lineright;this.position = this.position + 1
This.TriggerEvent(moved!)

end event

event pageleft;this.position = this.position - 10
This.TriggerEvent(moved!)

end event

event pageright;this.position = this.position + 10
This.TriggerEvent(moved!)
end event

event lineleft;this.position = this.position - 1
This.TriggerEvent(moved!)

end event

type cb_cancel from commandbutton within w_print_preview_zoom
integer x = 654
integer y = 684
integer width = 425
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취소(&N)"
boolean cancel = true
end type

on clicked;CloseWithReturn(parent,-1)
end on

type cb_ok from commandbutton within w_print_preview_zoom
integer x = 210
integer y = 680
integer width = 425
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "확인(&Y)"
end type

event clicked;int zoom_pct

CHOOSE CASE true
CASE rb_200.checked
	zoom_pct	=	200
CASE rb_100.checked
	zoom_pct	=	100
CASE rb_65.checked
	zoom_pct	=	65
CASE rb_30.checked
	zoom_pct	=	30
CASE rb_custom.checked
	zoom_pct	=	integer(em_zoom.text)
END CHOOSE

//CloseWithReturn(parent,zoom_pct)
CloseWithReturn(parent,zoom_pct)
//CloseWithReturn(w_su_sugang_inwonsu,zoom_pct)
end event

type rb_custom from radiobutton within w_print_preview_zoom
integer x = 119
integer y = 424
integer width = 402
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
string text = "사용자정의"
borderstyle borderstyle = stylelowered!
end type

event clicked;em_zoom.text = String(hsb_zoom.Position)
end event

type rb_30 from radiobutton within w_print_preview_zoom
integer x = 119
integer y = 356
integer width = 274
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
string text = "&30%"
borderstyle borderstyle = stylelowered!
end type

type rb_65 from radiobutton within w_print_preview_zoom
integer x = 119
integer y = 288
integer width = 274
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
string text = "&65%"
borderstyle borderstyle = stylelowered!
end type

type rb_100 from radiobutton within w_print_preview_zoom
integer x = 119
integer y = 220
integer width = 274
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
string text = "&100%"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_200 from radiobutton within w_print_preview_zoom
integer x = 119
integer y = 152
integer width = 274
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
string text = "&200%"
borderstyle borderstyle = stylelowered!
end type

type gb_magnification from groupbox within w_print_preview_zoom
integer x = 55
integer y = 72
integer width = 1193
integer height = 548
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
string text = "크기비율"
borderstyle borderstyle = stylelowered!
end type

