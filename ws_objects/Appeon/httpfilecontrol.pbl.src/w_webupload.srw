$PBExportHeader$w_webupload.srw
forward
global type w_webupload from window
end type
type cb_1 from commandbutton within w_webupload
end type
type st_file from statictext within w_webupload
end type
type st_total from statictext within w_webupload
end type
type hpb_fileper from hprogressbar within w_webupload
end type
type st_fileup from statictext within w_webupload
end type
type st_7 from statictext within w_webupload
end type
type st_filetotup from statictext within w_webupload
end type
type st_fileper from statictext within w_webupload
end type
type dw_filecontrol from datawindow within w_webupload
end type
type st_status from statictext within w_webupload
end type
type st_url from statictext within w_webupload
end type
type st_close from statictext within w_webupload
end type
type st_click from statictext within w_webupload
end type
type st_per from statictext within w_webupload
end type
type st_4 from statictext within w_webupload
end type
type st_totup from statictext within w_webupload
end type
type st_1 from statictext within w_webupload
end type
type st_up from statictext within w_webupload
end type
type hpb_per from hprogressbar within w_webupload
end type
type rr_1 from roundrectangle within w_webupload
end type
type rr_2 from roundrectangle within w_webupload
end type
end forward

global type w_webupload from window
integer width = 2405
integer height = 884
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event ue_postopen ( )
cb_1 cb_1
st_file st_file
st_total st_total
hpb_fileper hpb_fileper
st_fileup st_fileup
st_7 st_7
st_filetotup st_filetotup
st_fileper st_fileper
dw_filecontrol dw_filecontrol
st_status st_status
st_url st_url
st_close st_close
st_click st_click
st_per st_per
st_4 st_4
st_totup st_totup
st_1 st_1
st_up st_up
hpb_per hpb_per
rr_1 rr_1
rr_2 rr_2
end type
global w_webupload w_webupload

type variables
parameters		istr_file
nvo_inet  			in_inet
end variables

forward prototypes
public subroutine wf_fileupload ()
public subroutine wf_settext (integer row)
end prototypes

event ue_postopen();istr_file = Message.PowerObjectParm
st_url.text = istr_file.serverurl


st_click.PostEvent(Clicked!)
end event

public subroutine wf_fileupload ();String		ls_null
Long			ll_rtn

in_inet = Create nvo_inet

IF UpperBound(istr_file.parameter) > 0 THEN
	ll_rtn = in_inet.of_uploadfileex_progress(istr_file, This)
END IF

Destroy in_inet

CloseWithReturn(This, ll_rtn)

end subroutine

public subroutine wf_settext (integer row);String ls_file

ls_file = dw_filecontrol.getItemString(row, 'filename')

ls_file = Mid(ls_file,LastPos(ls_file, "\") + Len("\"))

st_file.text = ls_file
end subroutine

on w_webupload.create
this.cb_1=create cb_1
this.st_file=create st_file
this.st_total=create st_total
this.hpb_fileper=create hpb_fileper
this.st_fileup=create st_fileup
this.st_7=create st_7
this.st_filetotup=create st_filetotup
this.st_fileper=create st_fileper
this.dw_filecontrol=create dw_filecontrol
this.st_status=create st_status
this.st_url=create st_url
this.st_close=create st_close
this.st_click=create st_click
this.st_per=create st_per
this.st_4=create st_4
this.st_totup=create st_totup
this.st_1=create st_1
this.st_up=create st_up
this.hpb_per=create hpb_per
this.rr_1=create rr_1
this.rr_2=create rr_2
this.Control[]={this.cb_1,&
this.st_file,&
this.st_total,&
this.hpb_fileper,&
this.st_fileup,&
this.st_7,&
this.st_filetotup,&
this.st_fileper,&
this.dw_filecontrol,&
this.st_status,&
this.st_url,&
this.st_close,&
this.st_click,&
this.st_per,&
this.st_4,&
this.st_totup,&
this.st_1,&
this.st_up,&
this.hpb_per,&
this.rr_1,&
this.rr_2}
end on

on w_webupload.destroy
destroy(this.cb_1)
destroy(this.st_file)
destroy(this.st_total)
destroy(this.hpb_fileper)
destroy(this.st_fileup)
destroy(this.st_7)
destroy(this.st_filetotup)
destroy(this.st_fileper)
destroy(this.dw_filecontrol)
destroy(this.st_status)
destroy(this.st_url)
destroy(this.st_close)
destroy(this.st_click)
destroy(this.st_per)
destroy(this.st_4)
destroy(this.st_totup)
destroy(this.st_1)
destroy(this.st_up)
destroy(this.hpb_per)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;Post Event ue_postopen()
end event

type cb_1 from commandbutton within w_webupload
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

type st_file from statictext within w_webupload
integer x = 37
integer y = 340
integer width = 1029
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Filel Size"
boolean focusrectangle = false
end type

type st_total from statictext within w_webupload
integer x = 41
integer y = 200
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
string text = "Total Size"
boolean focusrectangle = false
end type

type hpb_fileper from hprogressbar within w_webupload
integer x = 27
integer y = 404
integer width = 2341
integer height = 56
unsignedinteger maxposition = 100
integer setstep = 1
boolean smoothscroll = true
end type

type st_fileup from statictext within w_webupload
integer x = 1746
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

type st_7 from statictext within w_webupload
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
long backcolor = 16777215
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_filetotup from statictext within w_webupload
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
long backcolor = 16777215
string text = "0 Bytes"
boolean focusrectangle = false
end type

type st_fileper from statictext within w_webupload
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

type dw_filecontrol from datawindow within w_webupload
integer x = 27
integer y = 476
integer width = 2341
integer height = 372
integer taborder = 10
string title = "none"
string dataobject = "d_filecontrol"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_status from statictext within w_webupload
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

type st_url from statictext within w_webupload
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

type st_close from statictext within w_webupload
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

type st_click from statictext within w_webupload
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

event clicked;wf_fileupload()



end event

type st_per from statictext within w_webupload
integer x = 1079
integer y = 200
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

type st_4 from statictext within w_webupload
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
string text = "File Upload "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_totup from statictext within w_webupload
integer x = 2089
integer y = 200
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
boolean focusrectangle = false
end type

type st_1 from statictext within w_webupload
integer x = 2021
integer y = 200
integer width = 59
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_up from statictext within w_webupload
integer x = 1742
integer y = 200
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

type hpb_per from hprogressbar within w_webupload
integer x = 27
integer y = 268
integer width = 2341
integer height = 56
unsignedinteger maxposition = 100
integer setstep = 1
boolean smoothscroll = true
end type

type rr_1 from roundrectangle within w_webupload
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

type rr_2 from roundrectangle within w_webupload
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

