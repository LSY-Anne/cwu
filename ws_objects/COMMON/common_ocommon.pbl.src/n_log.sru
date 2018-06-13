$PBExportHeader$n_log.sru
forward
global type n_log from nonvisualobject
end type
end forward

global type n_log from nonvisualobject autoinstantiate
end type

type variables
Private:
	Boolean		debuglog		=    false
	integer		filenum
end variables

forward prototypes
public subroutine createfile (string as_file)
public subroutine createfile ()
public subroutine log (string as_msg)
end prototypes

public subroutine createfile (string as_file);String		ls_file

ls_file = getcurrentdir()

ls_file += "\plugin\debuglog"

IF Not DirectoryExists(ls_file) THEN
	CreateDirectory(ls_file)
END IF

ls_file += "\" + as_file

filenum = FileOpen(ls_file, LineMode!, Write!, LockWrite!, Append!)

end subroutine

public subroutine createfile ();String		ls_file

ls_file = getcurrentdir()

ls_file = "\plugin\debuglog"

IF Not DirectoryExists(ls_file) THEN
	CreateDirectory(ls_file)
END IF

ls_file += "\debug.log"

filenum = FileOpen(ls_file, LineMode!, Write!, LockWrite!, Append!)


end subroutine

public subroutine log (string as_msg);String		ls_msg, ls_fill

ls_fill = Fill("=", 20)
ls_msg = ls_fill  + String(DateTime(today(), now()), 'yyyy-mm-dd hh:mm:ss') + ls_fill 
FileWrite(filenum, ls_msg)
FileWrite(filenum, as_msg)
FileWrite(filenum, ls_fill + ls_fill + ls_fill)

end subroutine

on n_log.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_log.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;FileClose(filenum)
end event

event constructor;IF debuglog THEN
	CreateFile()
END IF
end event

