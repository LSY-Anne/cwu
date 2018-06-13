$PBExportHeader$n_timing.sru
forward
global type n_timing from timing
end type
end forward

global type n_timing from timing
event ke_setparent ( readonly powerobject apo_parent,  readonly string as_event )
end type
global n_timing n_timing

type variables
Protected:

powerobject ipo
string is_event
end variables

event ke_setparent(readonly powerobject apo_parent, readonly string as_event);ipo = apo_parent
is_event = as_event
end event

on n_timing.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_timing.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;IF ISVALID(ipo) THEN
	ipo.TriggerEvent(is_event)
END IF
end event

