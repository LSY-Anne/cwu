$PBExportHeader$uo_dwc_di_gwa_jungong.sru
$PBExportComments$[대학원입시] dwc - 학과별 전공 검색
forward
global type uo_dwc_di_gwa_jungong from datawindow
end type
end forward

global type uo_dwc_di_gwa_jungong from datawindow
integer width = 1929
integer height = 76
integer taborder = 1
string dataobject = "d_list_dI_gwa_jungong"
boolean border = false
boolean livescroll = true
event ue_dwnkey pbm_dwnkey
end type
global uo_dwc_di_gwa_jungong uo_dwc_di_gwa_jungong

type variables
DataWindowChild ldwc_hjmod
end variables

event ue_dwnkey;choose case key
	case keyenter!
		send(handle(this),256,9,0)
		return 1
end choose
end event

event constructor;This.settransobject(sqlca)

this.getchild('jungong_id',ldwc_hjmod)
ldwc_hjmod.settransobject(sqlca)	
ldwc_hjmod.retrieve('%')

this.retrieve()

this.SetItem(1,'gwa_id',"")
this.SetItem(1, 'jungong_id',"")


end event

on uo_dwc_di_gwa_jungong.create
end on

on uo_dwc_di_gwa_jungong.destroy
end on

event itemfocuschanged;this.getchild('jungong_id',ldwc_hjmod)
ldwc_hjmod.settransobject(sqlca)	
ldwc_hjmod.retrieve(this.getitemstring(1,'gwa_id'))
end event

