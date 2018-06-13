$PBExportHeader$u_dw.sru
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event type integer ue_updateend ( )
event type integer ue_insert_check ( long al_row )
end type
global u_dw u_dw

type variables
public String paramcolumn
end variables

forward prototypes
public function string getevaluate (string syntax, long row)
end prototypes

event type integer ue_updateend();
return 1
end event

event type integer ue_insert_check(long al_row);//return 성공(1), 실패(-1)

return 1
end event

public function string getevaluate (string syntax, long row);
return ''
end function

on u_dw.create
end on

on u_dw.destroy
end on

event updatestart;
end event

