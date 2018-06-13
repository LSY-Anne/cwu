$PBExportHeader$uo_dwc_d_jungong.sru
$PBExportComments$[대학원] dwc - 전공
forward
global type uo_dwc_d_jungong from datawindow
end type
end forward

global type uo_dwc_d_jungong from datawindow
integer width = 809
integer height = 72
string dataobject = "d_list_d_jungong"
boolean border = false
boolean livescroll = true
end type
global uo_dwc_d_jungong uo_dwc_d_jungong

on uo_dwc_d_jungong.create
end on

on uo_dwc_d_jungong.destroy
end on

event constructor;this.settransobject(sqlca)
this.retrieve()
this.SetItem( 1, 1, "")


end event

