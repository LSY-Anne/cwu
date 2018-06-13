$PBExportHeader$u_ds.sru
forward
global type u_ds from datastore
end type
end forward

global type u_ds from datastore
end type
global u_ds u_ds

type variables
Long		dberrcode
String		dberrtext
String		dberrsyntax

String		paramcolumn
end variables

forward prototypes
public function string getevaluate (string syntax, long row)
end prototypes

public function string getevaluate (string syntax, long row);
return ''
end function

on u_ds.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_ds.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;dberrcode 	= sqldbcode
dberrtext		= sqlerrtext
dberrsyntax	= sqlsyntax
end event

