$PBExportHeader$w_sort.srw
$PBExportComments$sort datawindow..........choi
forward
global type w_sort from window
end type
type dw_sort from datawindow within w_sort
end type
type dw_list from datawindow within w_sort
end type
type cb_3 from commandbutton within w_sort
end type
type cb_5 from commandbutton within w_sort
end type
end forward

global type w_sort from window
integer width = 2441
integer height = 1080
boolean titlebar = true
string title = "SORT"
boolean controlmenu = true
windowtype windowtype = response!
dw_sort dw_sort
dw_list dw_list
cb_3 cb_3
cb_5 cb_5
end type
global w_sort w_sort

type variables
datawindow 		idw_1
datawindowChild idwc_col

string is_colName[]
string is_dispName[]
end variables

forward prototypes
public function integer wf_getcolname ()
public function integer wf_getdispname ()
public function integer wf_setcolname ()
public function string wf_buildsortstring ()
end prototypes

public function integer wf_getcolname ();string ls_colCount
integer i, li_colCount
string ls_null[]

is_colName = ls_null

ls_colcount = idw_1.Object.DataWindow.Column.Count
li_colCount = integer(ls_colCount)

string ls_colname
int j

for i = 1 to li_colCount
	ls_colName = idw_1.Describe("#" + string(i) + ".Name")
	
	if  idw_1.Describe(ls_colName + ".Visible") = "1" then 
		j++
		is_colName[j] = ls_colName
	end if	
next

return upperBound(is_colName)
end function

public function integer wf_getdispname ();/*실제로 사용자에게 보여질 타이틀명(한글)을 구한다.
칼럼의 실제명이 먼저 구해져야(of_getColname()) 하며 칼럼명 끝에 "_t"가 붙을 것을 
타일틀로 본다. 
*/

integer i, li_colCount
string ls_null[]

is_dispName = ls_null

li_colCount = upperBound(is_colName)

string ls_dispname
int j

for i = 1 to li_colCount
	ls_dispName = idw_1.Describe(is_ColName[i] + "_t.Text")
	
	//메치되는 타이틀이 없으면 칼럼명을 넣어준다.
	if ls_dispName = "!" then	ls_dispName = is_ColName[i]
		
	is_dispName[i] = ls_dispName	
next

return 1
end function

public function integer wf_setcolname ();integer i, li_colCount
integer li_iRow

for i = 1 to upperBound(is_colName)
	dw_list.insertRow(i)
	dw_list.SetItem(i,'col_name',is_dispName[i])
	dw_list.SetItem(i,'col',is_colName[i])
next
return 1
end function

public function string wf_buildsortstring ();integer	li_i, li_rcount
string ls_colName, ls_sort, ls_sortSyn

If dw_sort.AcceptText() <> 1 Then Return '!'


li_rcount = dw_sort.RowCount ( )
FOR li_i = 1 to li_rcount
	ls_colname = dw_sort.GetItemString ( li_i, "col" ) 
	ls_sort = dw_sort.GetItemString ( li_i, "sort" ) 
	if isnull(ls_colName) then ls_colName = ""
	if isnull(ls_sort) then ls_sort = "D"
	
	if ls_colName <> "" then
		if li_i = 1 then 
			ls_sortSyn += ls_colName + " " + ls_sort 
		else
			ls_sortSyn += ", " + ls_colName + " " + ls_sort 
		end if
	end if
NEXT

Return Trim(ls_sortSyn)
end function

event open;f_centerme(This)
powerObject  lpo_1
lpo_1 = message.powerObjectParm

if lpo_1.typeof() <> datawindow! then
	messagebox("invalid Object", "invalid Object....just datawindow object")
	close(this)
	return
end if
idw_1 = lpo_1
wf_getColName()
wf_getdispName()
wf_setColName()
end event

on w_sort.create
this.dw_sort=create dw_sort
this.dw_list=create dw_list
this.cb_3=create cb_3
this.cb_5=create cb_5
this.Control[]={this.dw_sort,&
this.dw_list,&
this.cb_3,&
this.cb_5}
end on

on w_sort.destroy
destroy(this.dw_sort)
destroy(this.dw_list)
destroy(this.cb_3)
destroy(this.cb_5)
end on

type dw_sort from datawindow within w_sort
integer x = 1061
integer width = 1330
integer height = 832
integer taborder = 90
string dragicon = "Rectangle!"
boolean titlebar = true
string title = "Column sort"
string dataobject = "d_sort2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;String ls_col_name,ls_col
long ll_row
If row > 0 Then
	ls_col_name = Trim(This.GetItemString(row,'col_name'))
	ls_col      = Trim(This.GetItemString(row,'col'))
	This.DeleteRow(row)
	ll_row = dw_list.InsertRow(0)
	dw_list.SetItem(ll_row,'col_name',ls_col_name)
	dw_list.SetItem(ll_row,'col',ls_col)
End if
end event

event dragdrop;String ls_col_name,ls_col,ls_object,ls_sort
long ll_row,ll_newrow

ls_object = source.ClassName()
dw_list.Drag(end!)
If ls_object = 'dw_list' Then
	ll_row = dw_list.GetRow()
	If ll_row > 0 Then
		ls_col_name = Trim(dw_list.GetItemString(ll_row,'col_name'))
		ls_col      = Trim(dw_list.GetItemString(ll_row,'col'))
		dw_list.DeleteRow(ll_row)
		ll_newrow = dw_sort.InsertRow(row)
		dw_sort.SetItem(ll_newrow,'col_name',ls_col_name)
		dw_sort.SetItem(ll_newrow,'col',ls_col)
		dw_sort.SetItem(ll_newrow,'sort','A')
	End if
ElseIf ls_object = 'dw_sort' Then
   ls_col_name = Trim(This.GetItemString(This.Getrow(),'col_name'))
	ls_col      = Trim(This.GetItemString(This.Getrow(),'col'))
	ls_sort     = Trim(This.GetItemString(This.Getrow(),'sort'))
	This.Deleterow(This.Getrow())
   ll_row = This.insertrow(row)
	This.SetItem(ll_row,'col_name',ls_col_name)
	This.SetItem(ll_row,'col',ls_col)
	This.SetItem(ll_row,'sort',ls_sort)	
End if
end event

event clicked;If row > 0 Then
	This.setrow(row)
	This.Drag(Begin!)
End if
end event

type dw_list from datawindow within w_sort
integer width = 1061
integer height = 832
integer taborder = 90
string dragicon = "Rectangle!"
boolean titlebar = true
string title = "Column list"
string dataobject = "d_sort1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;String ls_col_name,ls_col
long ll_row
If row > 0 Then
	ls_col_name = Trim(This.GetItemString(row,'col_name'))
	ls_col      = Trim(This.GetItemString(row,'col'))
	This.DeleteRow(row)
	ll_row = dw_sort.InsertRow(0)
	dw_sort.SetItem(ll_row,'col_name',ls_col_name)
	dw_sort.SetItem(ll_row,'col',ls_col)
	dw_sort.SetItem(ll_row,'sort','A')
End if
end event

event clicked;This.setrow(row)
This.Drag(Begin!)
end event

event dragdrop;String ls_col_name,ls_col,ls_object
long ll_row,ll_newrow

dw_sort.Drag(end!)
ls_object = source.ClassName()

If ls_object = 'dw_sort' Then
	ll_row = dw_sort.GetRow()
	If ll_row > 0 Then
		ls_col_name = Trim(dw_sort.GetItemString(ll_row,'col_name'))
		ls_col      = Trim(dw_sort.GetItemString(ll_row,'col'))
		dw_sort.DeleteRow(ll_row)
		ll_newrow = dw_list.InsertRow(row)
		dw_list.SetItem(ll_newrow,'col_name',ls_col_name)
		dw_list.SetItem(ll_newrow,'col',ls_col)
		dw_list.SetItem(ll_newrow,'sort','A')
	End if
ElseIf ls_object = 'dw_list' Then
   ls_col_name = Trim(This.GetItemString(This.Getrow(),'col_name'))
	ls_col      = Trim(This.GetItemString(This.Getrow(),'col'))
	This.Deleterow(This.Getrow())
   ll_row = This.insertrow(row)
	dw_list.SetItem(ll_row,'col_name',ls_col_name)
	dw_list.SetItem(ll_row,'col',ls_col)
	dw_list.SetItem(ll_row,'sort','A')
End if
end event

type cb_3 from commandbutton within w_sort
integer x = 1998
integer y = 848
integer width = 384
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_5 from commandbutton within w_sort
integer x = 1614
integer y = 848
integer width = 384
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "&Sort"
boolean default = true
end type

event clicked;idw_1.setSort(wf_BuildSortString())
idw_1.sort()
idw_1.GroupCalc()
end event

