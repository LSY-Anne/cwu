$PBExportHeader$uo_ds.sru
$PBExportComments$DataStore
forward
global type uo_ds from u_ds
end type
end forward

global type uo_ds from u_ds
event ue_constructor ( )
end type
global uo_ds uo_ds

type variables
window 			iw_parent

end variables

forward prototypes
public function long uf_deleteall ()
public function long uf_modifiedcount ()
end prototypes

event ue_constructor();
iw_parent = Parent

This.Post SetTransObject(SQLCA)


end event

public function long uf_deleteall ();/*
┌────────────────────────────────────
│	. NAME   : uf_DeleteAll																													
│	. RETURN : Long ( Deleted Row Count )                         
│	. DESC   : Delete Entire Row
│	. VER    : 1.1 
└────────────────────────────────────
*/
Long				li_RowCount, i

li_RowCount = This.RowCount()

For i = li_RowCount To 1 Step -1
	This.DeleteRow(i)
Next

RETURN li_RowCount

end function

public function long uf_modifiedcount ();RETURN This.ModIFiedCount() + THIS.DeletedCount()

end function

on uo_ds.create
call super::create
end on

on uo_ds.destroy
call super::destroy
end on

event constructor;call super::constructor;// DataWindow Object와 Transaction Object를 연결한다
Post Event ue_constructor()

end event

event dberror;call super::dberror;gf_dberr_msg(Parent.ClassName(), THIS.ClassName(), sqldbcode, sqlerrtext)

Return 1

end event

