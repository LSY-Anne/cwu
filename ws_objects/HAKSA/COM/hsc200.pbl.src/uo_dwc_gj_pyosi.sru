$PBExportHeader$uo_dwc_gj_pyosi.sru
$PBExportComments$[청운대]dwc - 교원자격(표시과목)
forward
global type uo_dwc_gj_pyosi from datawindow
end type
end forward

global type uo_dwc_gj_pyosi from datawindow
integer width = 571
integer height = 72
string dataobject = "d_list_gj_pyosi"
boolean border = false
boolean livescroll = true
end type
global uo_dwc_gj_pyosi uo_dwc_gj_pyosi

on uo_dwc_gj_pyosi.create
end on

on uo_dwc_gj_pyosi.destroy
end on

event constructor;this.settransobject(sqlca)
this.retrieve()
this.SetItem( 1, 1, "")


end event

