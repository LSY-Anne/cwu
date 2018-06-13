$PBExportHeader$w_ancestor.srw
forward
global type w_ancestor from window
end type
end forward

global type w_ancestor from window
integer x = 5
integer y = 188
integer width = 3598
integer height = 1840
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
event ue_postopen ( )
event ue_close ( )
event ue_retrieve ( )
event ue_insert ( )
event ue_delete ( )
event ue_save ( )
event ue_help ( )
event ue_print ( )
event ue_first ( )
event ue_prior ( )
event ue_next ( )
event ue_last ( )
event ue_search ( )
event ue_preview ( )
event ue_sort_and_filter ( )
event ue_saveas ( )
event ue_clear ( )
end type
global w_ancestor w_ancestor

type variables
string is_dept_cd
end variables

forward prototypes
public function boolean wf_setcolumn (datawindow adw_control, long al_row, string as_column)
end prototypes

event ue_close;//f_set_msg(99,"K")
close(this)
end event

public function boolean wf_setcolumn (datawindow adw_control, long al_row, string as_column);
// 지정한 datawindow control의 해당 row와 column에 focus setting

adw_control.SetRow(al_row)
adw_control.SetColumn(as_column)
adw_control.SetFocus()

RETURN TRUE
end function

on w_ancestor.create
end on

on w_ancestor.destroy
end on

event open;this.postevent("ue_postopen")
end event

event mousemove;//w_main.st_msg.visible = false
end event

event rbuttondown;//openWithParm(w_zaa050h, 'MENU')

end event

