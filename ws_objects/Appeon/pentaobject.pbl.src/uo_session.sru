$PBExportHeader$uo_session.sru
forward
global type uo_session from nonvisualobject
end type
end forward

global type uo_session from nonvisualobject autoinstantiate
end type

type variables
Constant Integer	POS 	= 1
Constant Integer	GET	= 2

Private	String	is_method[2] = {"POST", "GET"}
end variables

forward prototypes
public function boolean sessioncheck (integer methodtype, string as_url, ref string as_returnmsg)
public function boolean sessioncheck (integer methodtype, string as_url, string as_arg, ref string as_returnmsg)
end prototypes

public function boolean sessioncheck (integer methodtype, string as_url, ref string as_returnmsg);
return true
end function

public function boolean sessioncheck (integer methodtype, string as_url, string as_arg, ref string as_returnmsg);
return true
end function

on uo_session.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_session.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

