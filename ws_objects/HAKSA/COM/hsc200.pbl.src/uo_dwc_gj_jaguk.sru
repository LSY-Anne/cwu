$PBExportHeader$uo_dwc_gj_jaguk.sru
$PBExportComments$[청운대]dwc - 교원자격코드
forward
global type uo_dwc_gj_jaguk from datawindow
end type
end forward

global type uo_dwc_gj_jaguk from datawindow
integer width = 731
integer height = 72
string dataobject = "d_list_gj_jagyk"
boolean border = false
boolean livescroll = true
end type
global uo_dwc_gj_jaguk uo_dwc_gj_jaguk

on uo_dwc_gj_jaguk.create
end on

on uo_dwc_gj_jaguk.destroy
end on

event constructor;this.settransobject(sqlca)
this.retrieve()
this.SetItem( 1, 1, "01")


end event

