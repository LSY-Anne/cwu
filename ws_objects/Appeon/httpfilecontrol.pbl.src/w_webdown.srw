$PBExportHeader$w_webdown.srw
forward
global type w_webdown from window
end type
type cb_1 from commandbutton within w_webdown
end type
type st_status from statictext within w_webdown
end type
type st_url from statictext within w_webdown
end type
type st_close from statictext within w_webdown
end type
type st_click from statictext within w_webdown
end type
type st_local from statictext within w_webdown
end type
type st_3 from statictext within w_webdown
end type
type st_per from statictext within w_webdown
end type
type st_4 from statictext within w_webdown
end type
type st_filename from statictext within w_webdown
end type
type st_2 from statictext within w_webdown
end type
type st_tot from statictext within w_webdown
end type
type st_1 from statictext within w_webdown
end type
type st_down from statictext within w_webdown
end type
type hpb_per from hprogressbar within w_webdown
end type
type rr_1 from roundrectangle within w_webdown
end type
type rr_2 from roundrectangle within w_webdown
end type
end forward

global type w_webdown from window
integer width = 2405
integer height = 492
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event ue_postopen ( )
cb_1 cb_1
st_status st_status
st_url st_url
st_close st_close
st_click st_click
st_local st_local
st_3 st_3
st_per st_per
st_4 st_4
st_filename st_filename
st_2 st_2
st_tot st_tot
st_1 st_1
st_down st_down
hpb_per hpb_per
rr_1 rr_1
rr_2 rr_2
end type
global w_webdown w_webdown

type variables
parameters		istr_file
nvo_inet  			in_inet
end variables

forward prototypes
public subroutine wf_filedown ()
end prototypes

event ue_postopen();istr_file = Message.PowerObjectParm
st_url.text = istr_file.serverurl


st_click.PostEvent(Clicked!)
end event

public subroutine wf_filedown ();String		ls_null
Long			ll_rtn

in_inet = Create nvo_inet

IF UpperBound(istr_file.parameter) > 0 THEN
	ll_rtn = in_inet.of_downloadprogress(This, istr_file)
END IF

Destroy in_inet

CloseWithReturn(This, ll_rtn)

end subroutine

on w_webdown.create
this.cb_1=create cb_1
this.st_status=create st_status
this.st_url=create st_url
this.st_close=create st_close
this.st_click=create st_click
this.st_local=create st_local
this.st_3=create st_3
this.st_per=create st_per
this.st_4=create st_4
this.st_filename=create st_filename
this.st_2=create st_2
this.st_tot=create st_tot
this.st_1=create st_1
this.st_down=create st_down
this.hpb_per=create hpb_per
this.rr_1=create rr_1
this.rr_2=create rr_2
this.Control[]={this.cb_1,&
this.st_status,&
this.st_url,&
this.st_close,&
this.st_click,&
this.st_local,&
this.st_3,&
this.st_per,&
this.st_4,&
this.st_filename,&
this.st_2,&
this.st_tot,&
this.st_1,&
this.st_down,&
this.hpb_per,&
this.rr_1,&
this.rr_2}
end on

on w_webdown.destroy
destroy(this.cb_1)
destroy(this.st_status)
destroy(this.st_url)
destroy(this.st_close)
destroy(this.st_click)
destroy(this.st_local)
destroy(this.st_3)
destroy(this.st_per)
destroy(this.st_4)
destroy(this.st_filename)
destroy(this.st_2)
destroy(this.st_tot)
destroy(this.st_1)
destroy(this.st_down)
destroy(this.hpb_per)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;Post Event ue_postopen()
end event

type cb_1 from commandbutton within w_webdown
integer x = 2194
integer y = 20
integer width = 174
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
end type

event clicked;IF IsValid(in_inet) THEN
	in_inet.canceldata(true)
END IF
end event

type st_status from statictext within w_webdown
integer x = 27
integer y = 1104
integer width = 2336
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_url from statictext within w_webdown
integer x = 9
integer y = 124
integer width = 2373
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 16777215
alignment alignment = center!
boolean focusrectangle = false
end type

type st_close from statictext within w_webdown
boolean visible = false
integer x = 1938
integer y = 520
integer width = 411
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 128
long backcolor = 15780518
string text = "Cancle"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;Close(parent)
end event

type st_click from statictext within w_webdown
boolean visible = false
integer x = 1522
integer y = 520
integer width = 384
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 128
long backcolor = 15780518
string text = "Down Load"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;wf_filedown()



end event

type st_local from statictext within w_webdown
integer x = 325
integer y = 260
integer width = 2048
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_3 from statictext within w_webdown
integer x = 23
integer y = 260
integer width = 306
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Local File : "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_per from statictext within w_webdown
integer x = 1079
integer y = 340
integer width = 210
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 16777215
string text = "0%"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_webdown
integer x = 9
integer y = 4
integer width = 2373
integer height = 104
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217731
string text = "File Download"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_filename from statictext within w_webdown
integer x = 325
integer y = 192
integer width = 2048
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_2 from statictext within w_webdown
integer x = 23
integer y = 192
integer width = 306
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Web File : "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_tot from statictext within w_webdown
integer x = 2085
integer y = 340
integer width = 279
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217729
long backcolor = 15793151
string text = "0 Bytes"
boolean focusrectangle = false
end type

type st_1 from statictext within w_webdown
integer x = 2021
integer y = 340
integer width = 59
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_down from statictext within w_webdown
integer x = 1742
integer y = 340
integer width = 279
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217729
long backcolor = 16777215
string text = "0 Bytes"
alignment alignment = right!
boolean focusrectangle = false
end type

type hpb_per from hprogressbar within w_webdown
integer x = 27
integer y = 408
integer width = 2341
integer height = 56
unsignedinteger maxposition = 100
integer setstep = 1
boolean smoothscroll = true
end type

type rr_1 from roundrectangle within w_webdown
boolean visible = false
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15780518
integer x = 1504
integer y = 508
integer width = 421
integer height = 88
integer cornerheight = 40
integer cornerwidth = 55
end type

type rr_2 from roundrectangle within w_webdown
boolean visible = false
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15780518
integer x = 1934
integer y = 508
integer width = 421
integer height = 88
integer cornerheight = 40
integer cornerwidth = 55
end type

