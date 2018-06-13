$PBExportHeader$w_common_tab.srw
$PBExportComments$학사용 조회(등록) 상속윈도우(Tab용)
forward
global type w_common_tab from w_msheet
end type
type tab_1 from tab within w_common_tab
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_1 from userobject within tab_1
end type
type tab_1 from tab within w_common_tab
tabpage_1 tabpage_1
end type
type uo_1 from u_tab within w_common_tab
end type
type dw_con from uo_dwfree within w_common_tab
end type
end forward

global type w_common_tab from w_msheet
integer height = 2448
tab_1 tab_1
uo_1 uo_1
dw_con dw_con
end type
global w_common_tab w_common_tab

on w_common_tab.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_con
end on

on w_common_tab.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.dw_con)
end on

type ln_templeft from w_msheet`ln_templeft within w_common_tab
integer endy = 2316
end type

type ln_tempright from w_msheet`ln_tempright within w_common_tab
integer endy = 2316
end type

type ln_temptop from w_msheet`ln_temptop within w_common_tab
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_common_tab
integer beginy = 2280
integer endy = 2280
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_common_tab
end type

type ln_tempstart from w_msheet`ln_tempstart within w_common_tab
end type

type uc_retrieve from w_msheet`uc_retrieve within w_common_tab
end type

type uc_insert from w_msheet`uc_insert within w_common_tab
end type

type uc_delete from w_msheet`uc_delete within w_common_tab
end type

type uc_save from w_msheet`uc_save within w_common_tab
end type

type uc_excel from w_msheet`uc_excel within w_common_tab
end type

type uc_print from w_msheet`uc_print within w_common_tab
end type

type st_line1 from w_msheet`st_line1 within w_common_tab
end type

type st_line2 from w_msheet`st_line2 within w_common_tab
end type

type st_line3 from w_msheet`st_line3 within w_common_tab
end type

type uc_excelroad from w_msheet`uc_excelroad within w_common_tab
end type

type tab_1 from tab within w_common_tab
integer x = 55
integer y = 364
integer width = 4379
integer height = 1912
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 1792
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
end type

type uo_1 from u_tab within w_common_tab
integer x = 55
integer y = 312
integer taborder = 20
boolean bringtotop = true
string fontcolor = "53,122,177"
string selectfontcolor = "255,255,255"
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type dw_con from uo_dwfree within w_common_tab
integer x = 59
integer y = 172
integer width = 4375
integer height = 116
integer taborder = 20
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)
This.InsertRow(0)
end event

