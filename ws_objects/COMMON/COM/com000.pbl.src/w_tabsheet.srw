$PBExportHeader$w_tabsheet.srw
$PBExportComments$shett메인 모듈(Tab을 가지는 Sheet)
forward
global type w_tabsheet from w_msheet
end type
type tab_sheet from tab within w_tabsheet
end type
type tabpage_sheet01 from userobject within tab_sheet
end type
type dw_list001 from cuo_dwwindow within tabpage_sheet01
end type
type dw_update_tab from uo_dwgrid within tabpage_sheet01
end type
type tabpage_sheet01 from userobject within tab_sheet
dw_list001 dw_list001
dw_update_tab dw_update_tab
end type
type tab_sheet from tab within w_tabsheet
tabpage_sheet01 tabpage_sheet01
end type
type uo_tab from u_tab within w_tabsheet
end type
type dw_con from uo_dwfree within w_tabsheet
end type
type st_con from statictext within w_tabsheet
end type
end forward

global type w_tabsheet from w_msheet
tab_sheet tab_sheet
uo_tab uo_tab
dw_con dw_con
st_con st_con
end type
global w_tabsheet w_tabsheet

type variables
cuo_dwwindow idw_name //share datawindow
end variables

on w_tabsheet.create
int iCurrent
call super::create
this.tab_sheet=create tab_sheet
this.uo_tab=create uo_tab
this.dw_con=create dw_con
this.st_con=create st_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_sheet
this.Control[iCurrent+2]=this.uo_tab
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.st_con
end on

on w_tabsheet.destroy
call super::destroy
destroy(this.tab_sheet)
destroy(this.uo_tab)
destroy(this.dw_con)
destroy(this.st_con)
end on

type ln_templeft from w_msheet`ln_templeft within w_tabsheet
end type

type ln_tempright from w_msheet`ln_tempright within w_tabsheet
end type

type ln_temptop from w_msheet`ln_temptop within w_tabsheet
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_tabsheet
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_tabsheet
end type

type ln_tempstart from w_msheet`ln_tempstart within w_tabsheet
end type

type uc_retrieve from w_msheet`uc_retrieve within w_tabsheet
end type

type uc_insert from w_msheet`uc_insert within w_tabsheet
end type

type uc_delete from w_msheet`uc_delete within w_tabsheet
end type

type uc_save from w_msheet`uc_save within w_tabsheet
end type

type uc_excel from w_msheet`uc_excel within w_tabsheet
end type

type uc_print from w_msheet`uc_print within w_tabsheet
end type

type st_line1 from w_msheet`st_line1 within w_tabsheet
end type

type st_line2 from w_msheet`st_line2 within w_tabsheet
end type

type st_line3 from w_msheet`st_line3 within w_tabsheet
end type

type uc_excelroad from w_msheet`uc_excelroad within w_tabsheet
end type

type ln_dwcon from w_msheet`ln_dwcon within w_tabsheet
end type

type tab_sheet from tab within w_tabsheet
integer x = 50
integer y = 312
integer width = 4375
integer height = 1952
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean raggedright = true
integer selectedtab = 1
tabpage_sheet01 tabpage_sheet01
end type

event selectionchanged;IF oldindex > 0 then
	control[oldindex].TabTextColor = RGB(0, 0, 0)
end IF

control[newindex].TabTextColor = RGB(0, 0, 255)	

end event

on tab_sheet.create
this.tabpage_sheet01=create tabpage_sheet01
this.Control[]={this.tabpage_sheet01}
end on

on tab_sheet.destroy
destroy(this.tabpage_sheet01)
end on

type tabpage_sheet01 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 4338
integer height = 1836
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list001 dw_list001
dw_update_tab dw_update_tab
end type

on tabpage_sheet01.create
this.dw_list001=create dw_list001
this.dw_update_tab=create dw_update_tab
this.Control[]={this.dw_list001,&
this.dw_update_tab}
end on

on tabpage_sheet01.destroy
destroy(this.dw_list001)
destroy(this.dw_update_tab)
end on

type dw_list001 from cuo_dwwindow within tabpage_sheet01
integer width = 4334
integer height = 1836
integer taborder = 10
boolean vscrollbar = true
end type

type dw_update_tab from uo_dwgrid within tabpage_sheet01
integer x = 5
integer y = 4
integer width = 4329
integer height = 1828
integer taborder = 20
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type uo_tab from u_tab within w_tabsheet
event destroy ( )
integer x = 1056
integer y = 332
integer taborder = 100
boolean bringtotop = true
string selecttabobject = "tab_sheet"
end type

on uo_tab.destroy
call u_tab::destroy
end on

type dw_con from uo_dwfree within w_tabsheet
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 20
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
This.insertrow(0)
end event

type st_con from statictext within w_tabsheet
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31112622
boolean focusrectangle = false
end type

