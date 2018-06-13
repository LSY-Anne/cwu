$PBExportHeader$uo_dwc_di_mojip.sru
$PBExportComments$[대학원입시] dwc - 모집구분
forward
global type uo_dwc_di_mojip from datawindow
end type
end forward

global type uo_dwc_di_mojip from datawindow
integer width = 352
integer height = 80
string dataobject = "d_list_di_mojip"
boolean border = false
boolean livescroll = true
end type
global uo_dwc_di_mojip uo_dwc_di_mojip

on uo_dwc_di_mojip.create
end on

on uo_dwc_di_mojip.destroy
end on

event constructor;this.settransobject(sqlca)
this.retrieve()
this.SetItem(1,1,"01")


end event

