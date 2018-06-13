$PBExportHeader$w_response_ancestor.srw
$PBExportComments$팝업 상속윈도우
forward
global type w_response_ancestor from w_ancresponse
end type
type uc_cancel from u_picture within w_response_ancestor
end type
type uc_ok from u_picture within w_response_ancestor
end type
type uc_save from u_picture within w_response_ancestor
end type
type uc_delete from u_picture within w_response_ancestor
end type
type uc_insert from u_picture within w_response_ancestor
end type
type uc_retrieve from u_picture within w_response_ancestor
end type
type ln_temptop from line within w_response_ancestor
end type
type ln_tempbuttom from line within w_response_ancestor
end type
type ln_temleft from line within w_response_ancestor
end type
type ln_tempright from line within w_response_ancestor
end type
type r_backline1 from rectangle within w_response_ancestor
end type
type r_backline2 from rectangle within w_response_ancestor
end type
type r_backline3 from rectangle within w_response_ancestor
end type
end forward

global type w_response_ancestor from w_ancresponse
event type long ue_inquiry ( )
event ue_insert ( )
event type long ue_delete ( )
event type long ue_save ( )
event ue_resize_dw ( ref rectangle ar,  datawindow adw )
event ue_button_set ( )
uc_cancel uc_cancel
uc_ok uc_ok
uc_save uc_save
uc_delete uc_delete
uc_insert uc_insert
uc_retrieve uc_retrieve
ln_temptop ln_temptop
ln_tempbuttom ln_tempbuttom
ln_temleft ln_temleft
ln_tempright ln_tempright
r_backline1 r_backline1
r_backline2 r_backline2
r_backline3 r_backline3
end type
global w_response_ancestor w_response_ancestor

type variables


end variables

forward prototypes
public function integer wf_validall ()
end prototypes

event type long ue_inquiry();Return 0
end event

event type long ue_save();If wf_validall( ) < 0 THen Return -1
end event

event ue_resize_dw(ref rectangle ar, datawindow adw);Long	ll_x, ll_y, ll_width, ll_height

ar.Visible = True

ll_x = adw.X
ll_y = adw.Y
ll_width = adw.Width
ll_height = adw.height

ll_y = ll_y - 4
ll_height = ll_height + 8

ar.X = ll_x
ar.Y = ll_y
ar.Width = ll_width
ar.Height = ll_height

this.setredraw(true)

end event

event ue_button_set();Long			ll_stnd_pos

ll_stnd_pos    = ln_tempright.beginx

If uc_cancel.Enabled Then
	uc_cancel.X		= ll_stnd_pos - uc_cancel.Width
	ll_stnd_pos		= ll_stnd_pos - uc_cancel.Width - 16
Else
	uc_cancel.Visible	= FALSE
End If

If uc_ok.Enabled Then
	uc_ok.X			= ll_stnd_pos - uc_ok.Width
	ll_stnd_pos			= ll_stnd_pos - uc_ok.Width - 16
Else
	uc_ok.Visible	= FALSE
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

public function integer wf_validall ();Return 0
end function

on w_response_ancestor.create
int iCurrent
call super::create
this.uc_cancel=create uc_cancel
this.uc_ok=create uc_ok
this.uc_save=create uc_save
this.uc_delete=create uc_delete
this.uc_insert=create uc_insert
this.uc_retrieve=create uc_retrieve
this.ln_temptop=create ln_temptop
this.ln_tempbuttom=create ln_tempbuttom
this.ln_temleft=create ln_temleft
this.ln_tempright=create ln_tempright
this.r_backline1=create r_backline1
this.r_backline2=create r_backline2
this.r_backline3=create r_backline3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uc_cancel
this.Control[iCurrent+2]=this.uc_ok
this.Control[iCurrent+3]=this.uc_save
this.Control[iCurrent+4]=this.uc_delete
this.Control[iCurrent+5]=this.uc_insert
this.Control[iCurrent+6]=this.uc_retrieve
this.Control[iCurrent+7]=this.ln_temptop
this.Control[iCurrent+8]=this.ln_tempbuttom
this.Control[iCurrent+9]=this.ln_temleft
this.Control[iCurrent+10]=this.ln_tempright
this.Control[iCurrent+11]=this.r_backline1
this.Control[iCurrent+12]=this.r_backline2
this.Control[iCurrent+13]=this.r_backline3
end on

on w_response_ancestor.destroy
call super::destroy
destroy(this.uc_cancel)
destroy(this.uc_ok)
destroy(this.uc_save)
destroy(this.uc_delete)
destroy(this.uc_insert)
destroy(this.uc_retrieve)
destroy(this.ln_temptop)
destroy(this.ln_tempbuttom)
destroy(this.ln_temleft)
destroy(this.ln_tempright)
destroy(this.r_backline1)
destroy(this.r_backline2)
destroy(this.r_backline3)
end on

event ue_postopen;call super::ue_postopen;This.Post Event ue_button_set()
end event

type uc_cancel from u_picture within w_response_ancestor
integer x = 2990
integer y = 44
integer width = 265
integer height = 84
string picturename = "..\img\button\topBtn_cancel.gif"
end type

type uc_ok from u_picture within w_response_ancestor
integer x = 2711
integer y = 44
integer width = 265
integer height = 84
string picturename = "..\img\button\topBtn_ok.gif"
end type

type uc_save from u_picture within w_response_ancestor
integer x = 2432
integer y = 44
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_save.gif"
string is_event = "ue_save"
end type

type uc_delete from u_picture within w_response_ancestor
integer x = 2153
integer y = 44
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
string is_event = "ue_delete"
end type

type uc_insert from u_picture within w_response_ancestor
integer x = 1874
integer y = 44
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_input.gif"
string is_event = "ue_insert"
end type

type uc_retrieve from u_picture within w_response_ancestor
integer x = 1595
integer y = 44
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_retrieve.gif"
string is_event = "ue_inquiry"
end type

type ln_temptop from line within w_response_ancestor
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 172
integer endx = 3305
integer endy = 172
end type

type ln_tempbuttom from line within w_response_ancestor
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 1516
integer endx = 3305
integer endy = 1516
end type

type ln_temleft from line within w_response_ancestor
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 46
integer endx = 46
integer endy = 1572
end type

type ln_tempright from line within w_response_ancestor
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 3255
integer endx = 3255
integer endy = 1572
end type

type r_backline1 from rectangle within w_response_ancestor
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 87
integer y = 60
integer width = 55
integer height = 48
end type

type r_backline2 from rectangle within w_response_ancestor
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 151
integer y = 60
integer width = 55
integer height = 48
end type

type r_backline3 from rectangle within w_response_ancestor
boolean visible = false
long linecolor = 29738437
integer linethickness = 4
long fillcolor = 16777215
integer x = 215
integer y = 60
integer width = 55
integer height = 48
end type

