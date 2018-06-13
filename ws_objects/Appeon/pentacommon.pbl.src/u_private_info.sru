$PBExportHeader$u_private_info.sru
forward
global type u_private_info from userobject
end type
type dw_private from datawindow within u_private_info
end type
end forward

global type u_private_info from userobject
integer width = 2715
integer height = 128
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_logout ( )
event ue_setcount ( )
event ue_home ( )
dw_private dw_private
end type
global u_private_info u_private_info

type variables
Private:
	n_timing		in_timer
end variables

forward prototypes
public subroutine of_setname (string as_name)
public subroutine wf_fax ()
public subroutine wf_memo ()
public subroutine wf_sms ()
public subroutine wf_changepwd ()
public subroutine wf_inout ()
end prototypes

public subroutine of_setname (string as_name);dw_private.setItem(dw_private.insertrow(0), 'name', as_name)
end subroutine

public subroutine wf_fax ();
end subroutine

public subroutine wf_memo ();
end subroutine

public subroutine wf_sms ();
end subroutine

public subroutine wf_changepwd ();
end subroutine

public subroutine wf_inout ();
end subroutine

on u_private_info.destroy
destroy(this.dw_private)
end on

on u_private_info.create
this.dw_private=create dw_private
this.Control[]={this.dw_private}
end on

event constructor;in_timer = Create n_timing
in_timer.event ke_setparent(this, "ue_setcount")
in_timer.Start(10)
end event

event destructor;in_timer.Stop()
end event

type dw_private from datawindow within u_private_info
integer width = 1403
integer height = 400
integer taborder = 10
boolean enabled = false
string title = "none"
string dataobject = "d_private"
boolean border = false
boolean livescroll = true
end type

