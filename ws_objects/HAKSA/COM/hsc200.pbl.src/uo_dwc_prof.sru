$PBExportHeader$uo_dwc_prof.sru
$PBExportComments$[청운대]dwc - 교수
forward
global type uo_dwc_prof from datawindow
end type
end forward

global type uo_dwc_prof from datawindow
integer width = 558
integer height = 72
string dataobject = "d_list_prof"
boolean border = false
boolean livescroll = true
end type
global uo_dwc_prof uo_dwc_prof

on uo_dwc_prof.create
end on

on uo_dwc_prof.destroy
end on

event constructor;this.settransobject(sqlca)
this.retrieve()
this.SetItem( 1, 1, "")


end event

