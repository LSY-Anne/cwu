$PBExportHeader$uo_dddw_dwc.sru
$PBExportComments$[청운대]검색조건에 사용되는 dddw용 dwc의 최고위 조상
forward
global type uo_dddw_dwc from datawindow
end type
end forward

global type uo_dddw_dwc from datawindow
integer width = 741
integer height = 84
integer taborder = 1
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global uo_dddw_dwc uo_dddw_dwc

event constructor;this.settransobject(sqlca)
this.retrieve()
this.setitem(1,1,'')


end event

on uo_dddw_dwc.create
end on

on uo_dddw_dwc.destroy
end on

