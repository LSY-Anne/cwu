$PBExportHeader$uo_dwc_di_jongbyul.sru
$PBExportComments$[대학원입시] dwc - 종별
forward
global type uo_dwc_di_jongbyul from datawindow
end type
end forward

global type uo_dwc_di_jongbyul from datawindow
integer width = 311
integer height = 80
string dataobject = "d_list_di_jongbyul"
boolean border = false
boolean livescroll = true
end type
global uo_dwc_di_jongbyul uo_dwc_di_jongbyul

on uo_dwc_di_jongbyul.create
end on

on uo_dwc_di_jongbyul.destroy
end on

event constructor;this.settransobject(sqlca)
this.retrieve()
this.SetItem(1,1,'')


end event

