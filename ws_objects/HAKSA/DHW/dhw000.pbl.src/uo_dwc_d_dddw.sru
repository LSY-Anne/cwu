$PBExportHeader$uo_dwc_d_dddw.sru
$PBExportComments$[대학원] dwc - 검색조건에 사용되는 공통dwc
forward
global type uo_dwc_d_dddw from datawindow
end type
end forward

global type uo_dwc_d_dddw from datawindow
integer width = 695
integer height = 74
boolean border = false
boolean livescroll = true
end type
global uo_dwc_d_dddw uo_dwc_d_dddw

on uo_dwc_d_dddw.create
end on

on uo_dwc_d_dddw.destroy
end on

event constructor;this.settransobject(sqlca)
this.retrieve()
this.SetItem(1, 1, "")


end event

