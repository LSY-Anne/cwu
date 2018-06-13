$PBExportHeader$u_dwgrid.sru
forward
global type u_dwgrid from u_dw
end type
end forward

global type u_dwgrid from u_dw
event lbuttonup pbm_dwnlbuttonup
event columnmoving ( )
event lbuttondown pbm_lbuttondown
event columnmove pbm_dwnmousemove
end type
global u_dwgrid u_dwgrid

type variables
CONSTANT string SORT 							= "Datawindow.Table.Sort"

CONSTANT String 	ARROW_SUB					= "_arrow"   //화살표

CONSTANT string 	ARROW_ASCENDING 		= "t"				
CONSTANT string 	ARROW_DESCENDING 	= "u"
CONSTANT Long	ARROWGABX					= PixelsToUnits(2, XPixelsToUnits!)
CONSTANT Long 	ARROWGABY					= PixelsToUnits(2, YPixelsToUnits!)	
CONSTANT string 	TEXTSUB 						= "_t"

protected:
	String				RowSelectColor 					= '230,230,230'
	String				HotBackColor 					= '238,243,249'
	String				NoBackColor 						= '180,215,245'
	String				GraySepColor1					= '100,150,195'
	String				GraySepColor2					= '245,245,240'
	String				HotLineColor						= '155,184,216'
	String				NomalLineColor					= '187,187,187'
	String				NoFontColor						= '60,60,60'
	String				HotFontColor						= '60,60,60'	
	String				AlternateFirstColor				= '245,245,245'
	String				AlternateSecondColor			= '255,255,255'
	String				CheckBoxName
	
	Boolean 			AlternateRowColors = true
	Boolean 			SortVisible = true
	Boolean				RowSelect = true
	//V1.9.9.015  data가 없으면 alternate row가 안나왔으면 하는 요청... 옵션으로 처리.
	Boolean				EnableRowDataAlternate = true
	//==================================================
Private:
	String 				is_objectarray[]
	String				is_destroyobj[]

	Boolean				ib_multsort = False
	
	String				is_maxobj
	String				is_destroy
	Boolean				ib_mousedown = false
	Boolean				ib_columnmove = false
end variables

forward prototypes
public subroutine setdataobject (string as_dataobject)
private function integer of_adjustseparators ()
private function integer of_destroystyle ()
private function integer of_getgridwidth ()
private function integer of_getobjects (ref string as_objlist[])
private function integer of_setstyle ()
private subroutine of_sort (dwobject dwo)
protected subroutine of_alternaterow (integer rowcount)
public subroutine createalternaterow (long rowcount)
public subroutine destroyalternaterow ()
public function integer reset ()
public function integer deleterow (long r)
end prototypes

event lbuttonup;
end event

event columnmoving();
end event

event lbuttondown;ib_mousedown = true
end event

event columnmove;IF ib_mousedown THEN
	ib_columnmove = true
END IF
end event

public subroutine setdataobject (string as_dataobject);
end subroutine

private function integer of_adjustseparators ();
RETURN 1
end function

private function integer of_destroystyle ();
RETURN 1
end function

private function integer of_getgridwidth ();
RETURN 1
end function

private function integer of_getobjects (ref string as_objlist[]);
Return 1
end function

private function integer of_setstyle ();
RETURN 1
end function

private subroutine of_sort (dwobject dwo);
end subroutine

protected subroutine of_alternaterow (integer rowcount);
end subroutine

public subroutine destroyalternaterow ();
end subroutine

public function integer reset ();
return 1
end function

public function integer deleterow (long r);
return 1
end function

on u_dwgrid.create
call super::create
end on

on u_dwgrid.destroy
call super::destroy
end on

event constructor;call super::constructor;
end event

event retrieveend;call super::retrieveend;
end event

event clicked;call super::clicked;
end event

