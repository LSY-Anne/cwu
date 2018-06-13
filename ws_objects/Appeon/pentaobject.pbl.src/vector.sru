$PBExportHeader$vector.sru
forward
global type vector from nonvisualobject
end type
end forward

global type vector from nonvisualobject
end type
global vector vector

type variables
CONSTANT INTEGER  TYPE_DEFAULT	= 0
CONSTANT INTEGER	TYPE_KEY 		= 1
CONSTANT INTEGER  TYPE_VALUE 	= 2
Private:
	DataStore		ids_data
	PowerObject	po[]
	Long				il_row
	String				is_syntax =   ''
										 
	String 	PoTypeString[] = {"APPLICATION","DATASTORE"	,"CONNECTION" 	,"CORBAOBJECT"	,"DATAWINDOWCHILD"	,"DRAGOBJECT" 	,"DWOBJECT" 	,"DYNAMICSTAGINGAREA" 	,"DYNAMICDESCRIPTIONAREA" ,"ENVIRONMENT"	,"GRAPHICOBJECT"	,"GRAPH"		,"GRAXIS" 	,"GRDISPATTR" 	,"INET" 	,"INTERNETRESULT" 	,"LISTVIEWITEM" 	,"MENUCASCADE"	,"MAILFILEDESCRIPTION","MAILMESSAGE"	,"MAILRECIPIENT"	,"MAILSESSION"	,"MDICLIENT"	,"MENU" 	,"MESSAGE"	,"NONVISUALOBJECT"	,"OLEOBJECT"	,"POWEROBJECT"	,"TIMING" 	,"TRANSACTION"	,"TREEVIEWITEM" ,"USEROBJECT" 	,"WINDOW" 	,"WINDOWOBJECT" 	,"CHECKBOX" 	,"COMMANDBUTTON"	,"DATAWINDOW" 	,"DROPDOWNLISTBOX"	,"DROPDOWNPICTURELISTBOX" 	,"EDITMASK" 	,"GROUPBOX" 	,"LINE" 	,"LISTBOX"	,"LISTVIEW" 	,"MULTILINEEDIT"	,"PICTURE"	,"PICTUREBUTTON"	,"PICTUREHYPERLINK" 	,"PICTURELISTBOX" 	,"RADIOBUTTON"	,"RECTANGLE"	,"SINGLELINEEDIT" 	,"STATICHYPERLINK"	,"STATICTEXT" 	,"TAB"	,"TREEVIEW"	} 
	object  	PoType[] 		= {APPLICATION! ,DATASTORE! 	,CONNECTION!  	,CORBAOBJECT! 	,DATAWINDOWCHILD! 	,DRAGOBJECT!  	,DWOBJECT! 	,DYNAMICSTAGINGAREA!  	,DYNAMICDESCRIPTIONAREA!  	,ENVIRONMENT! 	,GRAPHICOBJECT! 		,GRAPH! 		,GRAXIS!  	,GRDISPATTR!  	,INET!  	,INTERNETRESULT!  	,LISTVIEWITEM!  	,MENUCASCADE! 	,MAILFILEDESCRIPTION! 	,MAILMESSAGE! 	,MAILRECIPIENT! 	,MAILSESSION! 	,MDICLIENT! 	,MENU!  	,MESSAGE! 	,NONVISUALOBJECT! 	,OLEOBJECT! 	,POWEROBJECT! 	,TIMING!  	,TRANSACTION! 	,TREEVIEWITEM!  	,USEROBJECT!  	,WINDOW!  	,WINDOWOBJECT!  	,CHECKBOX!  	,COMMANDBUTTON! 	,DATAWINDOW!  	,DROPDOWNLISTBOX! 	,DROPDOWNPICTURELISTBOX!  	,EDITMASK!  	,GROUPBOX!  	,LINE!  	,LISTBOX! 	,LISTVIEW!  	,MULTILINEEDIT! 	,PICTURE! 	,PICTUREBUTTON! 	,PICTUREHYPERLINK!  	,PICTURELISTBOX!  	,RADIOBUTTON! 	,RECTANGLE! 	,SINGLELINEEDIT!  	,STATICHYPERLINK! 	,STATICTEXT!  	,TAB! 		,TREEVIEW!		}
	String	ls_arrayc		= "_arraybound_"
end variables

forward prototypes
public function string getfirstproperty ()
public function string getnextproperty ()
public subroutine removeall ()
public subroutine removeproperty (string key)
public function long getkeycount ()
public function integer exportfile (string filename)
public function integer importfile (string filename)
public function integer getfindkeycount (string key)
public subroutine setproperty (string key, powerobject value)
public function string getproperty (string key, ref powerobject apo)
public subroutine setproperty (string key, dragobject value)
public function string getproperty (string key, ref dragobject apo)
private function string gettypetostring (object typeof)
private function object getstringtotype (string typeof)
public subroutine sort (integer sortnum)
public function string getkey (integer row)
public function any getproperty (string key)
public subroutine setproperty (string key, any value)
end prototypes

public function string getfirstproperty ();
return ''
end function

public function string getnextproperty ();
return ''
end function

public subroutine removeall ();
end subroutine

public subroutine removeproperty (string key);
end subroutine

public function long getkeycount ();return 0
end function

public function integer exportfile (string filename);
return 0
end function

public function integer importfile (string filename);
return 0
end function

public function integer getfindkeycount (string key);
return 0
end function

public subroutine setproperty (string key, powerobject value);
end subroutine

public function string getproperty (string key, ref powerobject apo);
return ''
end function

public subroutine setproperty (string key, dragobject value);
end subroutine

public function string getproperty (string key, ref dragobject apo);
return ''
end function

private function string gettypetostring (object typeof);
return ''
end function

private function object getstringtotype (string typeof);
object		lo_typeof
return lo_typeof
end function

public subroutine sort (integer sortnum);
end subroutine

public function string getkey (integer row);
return ''
end function

public function any getproperty (string key);
any la_rtn
return la_rtn
end function

public subroutine setproperty (string key, any value);
end subroutine

event constructor;
end event

on vector.create
call super::create
TriggerEvent( this, "constructor" )
end on

on vector.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;
end event

