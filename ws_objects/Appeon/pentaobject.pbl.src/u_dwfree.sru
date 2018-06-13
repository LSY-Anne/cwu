$PBExportHeader$u_dwfree.sru
forward
global type u_dwfree from u_dw
end type
end forward

global type u_dwfree from u_dw
end type
global u_dwfree u_dwfree

type prototypes
FUNCTION BOOLEAN gettextsize( Long hWnd, String lpszText, int sizeoffont, String lpszFace,ref str_size lpSize) LIBRARY "pentalib.dll" ALIAS FOR "gettextsize;ansi"
end prototypes

type variables
constant string OBJECTS          = "DataWindow.Objects"
constant string PROCESSING       = "Datawindow.Processing"
constant string TAG_SEPARATOR    = ";"

protected:
   string      linecolor   = "255,255,255"
   string      _BackColor  = "255,255,255"
   integer     linethink   = 1
   
private:
   statictext     st_size
end variables

forward prototypes
public subroutine of_init ()
private function boolean of_checkprocess ()
private function str_size of_getcolumnwidth (string as_text, string objname)
public subroutine setdataobject (string as_dataobject)
private function boolean of_modify (string as_syntax)
end prototypes

public subroutine of_init ();
end subroutine

private function boolean of_checkprocess ();
RETURN true

end function

private function str_size of_getcolumnwidth (string as_text, string objname);
str_size lstr_Size
Return lstr_Size
end function

public subroutine setdataobject (string as_dataobject);
end subroutine

private function boolean of_modify (string as_syntax);
return true
end function

on u_dwfree.create
call super::create
end on

on u_dwfree.destroy
call super::destroy
end on

event constructor;call super::constructor;
end event

