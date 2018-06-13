$PBExportHeader$u_interface_info.sru
forward
global type u_interface_info from userobject
end type
type dw_interface from datawindow within u_interface_info
end type
end forward

global type u_interface_info from userobject
integer width = 1413
integer height = 128
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_search ( string as_cust )
event ue_logout ( )
dw_interface dw_interface
end type
global u_interface_info u_interface_info

type variables
Protected:
	pentaservice  inv_service
end variables

forward prototypes
public subroutine wf_group ()
public subroutine wf_insa ()
public subroutine wf_agent ()
public subroutine wf_cti ()
public subroutine wf_homepage ()
end prototypes

public subroutine wf_group ();String	ls_parm, ls_nulstring, ls_url

SetNull(ls_nulstring)
ls_url = 'http://eas.penta.co.kr'

IF appeongetclienttype() = "PB" THEN
	//Run Explore
	inv_service.of_ShellExecute(0, ls_nulstring, ls_url, ls_nulstring, ls_nulstring, SW_SHOWNORMAR)
ELSE
	gf_calljavascript('openwin', '', ls_url, "toolbar=yes,status=yes,directories=yes,scrollbars=yes,location=yes,resizable=yes,border=no,menubar=yes,width=1024,height=737")
END IF
end subroutine

public subroutine wf_insa ();String	ls_parm, ls_nulstring, ls_url

SetNull(ls_nulstring)
ls_url = 'http://www.tourmall.com'

//gf_calljavascript('openwin', '', ls_url, "toolbar=no,status=no,directories=no,scrollbars=no,location=no,resizable=no,border=no,menubar=no,width=1024,height=737")
IF appeongetclienttype() = "PB" THEN
	//Run Explore
	inv_service.of_ShellExecute(0, ls_nulstring, ls_url, ls_nulstring, ls_nulstring, SW_SHOWNORMAR)
ELSE
	gf_calljavascript('faxsystemopenwin'	, &
						  ''							, &
						  "user_id=faxadmin&user_pw=0000",  &
						  "toolbar=no, " + &
						  "status=no, " + &
						  "directories=no, " + &
						  "scrollbars=yes, " + &
						  "location=yes, " + &
						  "resizable=yes, " + &
						  "border=no, " + &
						  "menubar=no, " + &
						  "width=1024, " + &
						  "height=737")
						  
	//gf_calljavascript('openresponsewin', '', ls_url, "dialogHeight: 434px; dialogWidth: 747px; center: Yes; scroll: No;resizable: No; status: No;")
END IF
end subroutine

public subroutine wf_agent ();String	ls_parm, ls_nulstring, ls_url

SetNull(ls_nulstring)
ls_url = 'http://www.tourmall.com'

IF appeongetclienttype() = "PB" THEN
	//Run Explore
	inv_service.of_ShellExecute(0, ls_nulstring, ls_url, ls_nulstring, ls_nulstring, SW_SHOWNORMAR)
ELSE
	gf_calljavascript('openwin', '', ls_url, "toolbar=yes,status=yes,directories=yes,scrollbars=yes,location=yes,resizable=yes,border=no,menubar=yes,width=1024,height=737")
END IF
end subroutine

public subroutine wf_cti ();String	ls_parm, ls_nulstring, ls_url

SetNull(ls_nulstring)
ls_url = 'http://www.tourmall.com'

IF appeongetclienttype() = "PB" THEN
	//Run Explore
	inv_service.of_ShellExecute(0, ls_nulstring, ls_url, ls_nulstring, ls_nulstring, SW_SHOWNORMAR)
ELSE
	gf_calljavascript('openwin', '', ls_url, "toolbar=yes,status=yes,directories=yes,scrollbars=yes,location=yes,resizable=yes,border=no,menubar=yes,width=1024,height=737")
END IF
end subroutine

public subroutine wf_homepage ();String	ls_parm, ls_nulstring, ls_url

SetNull(ls_nulstring)
ls_url = 'http://www.penta.co.kr'

IF appeongetclienttype() = "PB" THEN
	//Run Explore
	inv_service.of_ShellExecute(0, ls_nulstring, ls_url, ls_nulstring, ls_nulstring, SW_SHOWNORMAR)
ELSE
	gf_calljavascript('openwin', '', ls_url, "toolbar=yes,status=yes,directories=yes,scrollbars=yes,location=yes,resizable=yes,border=no,menubar=yes,width=1024,height=737")
END IF
end subroutine

on u_interface_info.create
this.dw_interface=create dw_interface
this.Control[]={this.dw_interface}
end on

on u_interface_info.destroy
destroy(this.dw_interface)
end on

type dw_interface from datawindow within u_interface_info
integer width = 1417
integer height = 124
integer taborder = 10
string title = "none"
string dataobject = "d_interface"
boolean border = false
boolean livescroll = true
end type

event constructor;this.insertrow(0)
end event

event clicked;Choose Case dwo.name 
	Case 't_logout'
		parent.Event ue_logout()
	Case 't_changeinfo'
	Case 't_changedept'
	Case 'p_remote'
	Case 'p_2'
		Parent.Event ue_logout()
End CHoose
end event

