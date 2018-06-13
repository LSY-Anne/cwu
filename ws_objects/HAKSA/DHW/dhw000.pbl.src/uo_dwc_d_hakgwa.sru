$PBExportHeader$uo_dwc_d_hakgwa.sru
$PBExportComments$[대학원] dwc - 학과
forward
global type uo_dwc_d_hakgwa from datawindow
end type
end forward

global type uo_dwc_d_hakgwa from datawindow
integer width = 1038
integer height = 72
string dataobject = "d_list_d_hakgwa"
boolean border = false
boolean livescroll = true
end type
global uo_dwc_d_hakgwa uo_dwc_d_hakgwa

on uo_dwc_d_hakgwa.create
end on

on uo_dwc_d_hakgwa.destroy
end on

event constructor;this.settransobject(sqlca)
this.retrieve()
this.SetItem( 1, 1, "")


end event

