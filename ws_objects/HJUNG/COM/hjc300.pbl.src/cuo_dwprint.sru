$PBExportHeader$cuo_dwprint.sru
$PBExportComments$Print 용 데이타윈도우
forward
global type cuo_dwprint from datawindow
end type
end forward

global type cuo_dwprint from datawindow
integer width = 494
integer height = 360
integer taborder = 1
boolean livescroll = true
event un_unmove pbm_tcndragwithin
event key_enter pbm_dwnprocessenter
event key_press pbm_dwnkey
event key_enterpress pbm_custom01
event key_arrow pbm_custom02
event ue_nextpage pbm_custom37
event ue_priorpage pbm_custom24
end type
global cuo_dwprint cuo_dwprint

type variables
private :
  Boolean   ib_clicked = true,ib_keyBorde = False,ib_Sort = True
  Boolean   ib_multiselect = False
  Boolean   ib_scroll  = false //스크로여부

end variables

event constructor;this.SettransObject(sqlca)
this.Modify("DataWindow.Print.Preview='yes'")
//this.object.datawindow.print.preview = 'yes'

end event

on cuo_dwprint.create
end on

on cuo_dwprint.destroy
end on

