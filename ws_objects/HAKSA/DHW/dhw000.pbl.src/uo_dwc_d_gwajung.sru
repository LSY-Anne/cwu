$PBExportHeader$uo_dwc_d_gwajung.sru
$PBExportComments$[대학원] dwc - 과정구분
forward
global type uo_dwc_d_gwajung from datawindow
end type
end forward

global type uo_dwc_d_gwajung from datawindow
integer width = 311
integer height = 72
string dataobject = "d_list_d_gwajung"
boolean border = false
boolean livescroll = true
end type
global uo_dwc_d_gwajung uo_dwc_d_gwajung

on uo_dwc_d_gwajung.create
end on

on uo_dwc_d_gwajung.destroy
end on

event constructor;this.settransobject(sqlca)
this.retrieve()
this.SetItem(1,1,"1")


end event

