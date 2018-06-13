$PBExportHeader$uo_dddw_dwc_hjmodsayu.sru
$PBExportComments$[청운대]dwc - 학적변동/사유
forward
global type uo_dddw_dwc_hjmodsayu from datawindow
end type
end forward

global type uo_dddw_dwc_hjmodsayu from datawindow
integer width = 1733
integer height = 96
string title = "none"
string dataobject = "d_list_hjmod_sayu"
boolean border = false
boolean livescroll = true
end type
global uo_dddw_dwc_hjmodsayu uo_dddw_dwc_hjmodsayu

type variables
DataWindowChild idwc_sayu
end variables

on uo_dddw_dwc_hjmodsayu.create
end on

on uo_dddw_dwc_hjmodsayu.destroy
end on

event constructor;this.settransobject(sqlca)

this.getchild('sayu_id',idwc_sayu)
idwc_sayu.settransobject(sqlca)	
idwc_sayu.retrieve('%')

this.retrieve()

this.SetItem(1, 'hjmod_id',"")
this.SetItem(1, 'sayu_id',"")
end event

event itemchanged;choose case dwo.name	
	
	case	"hjmod_id"
		
		this.SetItem(row, 'sayu_id',"")
end choose

end event

event itemfocuschanged;string	ls_hjmod	,&
			ls_jaguk
choose case dwo.name
	case	"sayu_id"
				
		ls_hjmod = this.getitemstring(row,'hjmod_id')
		
		if isnull(ls_hjmod) or trim(ls_hjmod) = '' then
			messagebox("확인", "학적변동코드를 선택하세요!")
			this.setcolumn(1)
			this.setfocus()
		end if
		
		this.getchild('sayu_id',idwc_sayu)
		idwc_sayu.settransobject(sqlca)	
		idwc_sayu.retrieve(ls_hjmod)
		
		this.SetItem(row, 'sayu_id',"")
end choose
end event

