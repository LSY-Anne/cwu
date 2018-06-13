$PBExportHeader$w_default_templet.srw
$PBExportComments$기본 윈도우 템플릿(데이터윈도우 2개)
forward
global type w_default_templet from w_rolesheet
end type
type dw_tran from uo_dwfree within w_default_templet
end type
type dw_view from uo_dwlv within w_default_templet
end type
end forward

global type w_default_templet from w_rolesheet
event ue_first pbm_custom01
event ue_prior pbm_custom02
event ue_next pbm_custom03
event ue_last pbm_custom04
event ue_new pbm_custom05
event ue_delete pbm_custom06
event ue_retrieve pbm_custom07
event ue_save pbm_custom08
event ue_cancel pbm_custom09
dw_tran dw_tran
dw_view dw_view
end type
global w_default_templet w_default_templet

type variables
string is_sort, is_sort_order
string is_param[]
integer ii_param
end variables

event ue_first;dw_view.ScrollToRow(1)

end event

event ue_prior;//dw_view.ScrollPriorPage()
IF dw_View.GetRow() > 1 THEN
	dw_view.ScrollToRow(dw_view.GetRow() - 1)
ELSE
	Return
END IF
end event

event ue_next;//dw_view.ScrollNextPage()
IF dw_View.GetRow() < dw_View.RowCount() THEN
	dw_view.ScrollToRow(dw_view.GetRow() + 1)
ELSE
	Return
END IF
end event

event ue_last;dw_view.ScrollToRow(dw_view.RowCount())
end event

on w_default_templet.create
int iCurrent
call super::create
this.dw_tran=create dw_tran
this.dw_view=create dw_view
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tran
this.Control[iCurrent+2]=this.dw_view
end on

on w_default_templet.destroy
call super::destroy
destroy(this.dw_tran)
destroy(this.dw_view)
end on

type ln_templeft from w_rolesheet`ln_templeft within w_default_templet
end type

type ln_tempright from w_rolesheet`ln_tempright within w_default_templet
end type

type ln_temptop from w_rolesheet`ln_temptop within w_default_templet
end type

type ln_tempbuttom from w_rolesheet`ln_tempbuttom within w_default_templet
end type

type ln_tempbutton from w_rolesheet`ln_tempbutton within w_default_templet
end type

type ln_tempstart from w_rolesheet`ln_tempstart within w_default_templet
end type

type uc_retrieve from w_rolesheet`uc_retrieve within w_default_templet
integer x = 2679
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_save from w_rolesheet`uc_save within w_default_templet
integer x = 3872
integer y = 40
integer width = 274
integer height = 84
end type

type uc_run from w_rolesheet`uc_run within w_default_templet
integer x = 2007
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_print from w_rolesheet`uc_print within w_default_templet
integer x = 3351
integer y = 40
boolean originalsize = true
end type

type uc_ok from w_rolesheet`uc_ok within w_default_templet
integer x = 2231
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_excel from w_rolesheet`uc_excel within w_default_templet
integer x = 3584
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_delete from w_rolesheet`uc_delete within w_default_templet
integer x = 3127
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_close from w_rolesheet`uc_close within w_default_templet
integer x = 4160
integer y = 40
integer width = 274
integer height = 84
end type

type uc_cancel from w_rolesheet`uc_cancel within w_default_templet
integer x = 2455
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_insert from w_rolesheet`uc_insert within w_default_templet
integer x = 2903
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type dw_tran from uo_dwfree within w_default_templet
event ue_enter pbm_dwnprocessenter
integer x = 50
integer y = 856
integer width = 3511
integer height = 772
integer taborder = 10
boolean border = false
end type

event ue_enter;String ls_Col1, ls_Col2

If This.AcceptText() < 0 Then
  Return 1
End If

ls_Col1 = GetColumnName()
Send(Handle(this), 256, 9, Long(0, 0))
ls_Col2 = GetColumnName()

IF GetFocus() <> This OR ls_Col1 = ls_Col2 THEN
	This.SetFocus()
	This.SetColumn(1)
END IF

return 1
end event

type dw_view from uo_dwlv within w_default_templet
event ue_keydown pbm_keydown
integer x = 41
integer y = 336
integer width = 3529
integer height = 472
boolean bringtotop = true
end type

event doubleclicked;/*
integer i,j
string ls_ColumnName, band

band = This.GetBandAtPointer()
IF row < 1  and LeftA(band,6) = 'header' THEN
	
	ls_ColumnName = This.GetObjectAtPointer()
	IF ls_columnName = "" OR isnull(ls_columnName) THEN return
	j = LenA(ls_ColumnName)
	FOR i = j TO 1 Step -1
	    IF MidA(ls_ColumnName,i,1) = "_" THEN Exit
   NEXT
  	IF is_Sort = LeftA(ls_ColumnName, i - 1 ) THEN
		IF is_Sort_Order = "A" THEN
			is_Sort_Order = "D"
		ELSE 
		   is_Sort_Order = "A"
		END IF
   ELSE		
		Is_Sort_Order = "A"
	END IF
	This.SetSort(LeftA(ls_ColumnName, i - 1 ) + " " + is_Sort_Order)
	is_Sort = LeftA(ls_ColumnName, i - 1 )
  	This.Sort( )
ELSE
	this.ScrollToRow(row)
END IF
*/
end event

event clicked;call super::clicked;/*   //2006-11-20 분산전환에 따른 수정 --송상철
Int		i,j
String	ls_ColumnName, ls_band
ls_band = This.GetBandAtPointer()

IF row < 1 and LeftA(ls_band,6) = 'header' THEN
	ls_ColumnName = This.GetObjectAtPointer()
	IF ls_columnName = "" OR IsNull(ls_columnName) THEN Return
	j = LenA(ls_ColumnName)
	FOR i = j TO 1 Step -1
	    IF MidA(ls_ColumnName,i,1) = "_" THEN Exit
   NEXT
   IF is_Sort = LeftA(ls_ColumnName, i - 1 ) THEN
		IF is_Sort_Order = "A" THEN
			is_Sort_Order = "D"
		ELSE 
		   is_Sort_Order = "A"
		END IF
   ELSE		
		is_Sort_Order = "A"
	END IF
  	This.SetSort(LeftA(ls_ColumnName, i - 1 ) + " " + is_Sort_Order)
	is_Sort = LeftA(ls_ColumnName, i - 1 )
   THis.Sort( )
ELSE
  This.ScrollToRow(row)
END IF
*/
end event

