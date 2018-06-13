$PBExportHeader$w_filter.srw
$PBExportComments$filter datawindow..........choi
forward
global type w_filter from window
end type
type dw_filter from datawindow within w_filter
end type
type cb_1 from commandbutton within w_filter
end type
type cb_2 from commandbutton within w_filter
end type
type cb_3 from commandbutton within w_filter
end type
type cb_4 from commandbutton within w_filter
end type
type cb_5 from commandbutton within w_filter
end type
type cb_6 from commandbutton within w_filter
end type
type gb_1 from groupbox within w_filter
end type
end forward

global type w_filter from window
integer width = 2789
integer height = 848
boolean titlebar = true
string title = "검색"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
dw_filter dw_filter
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
gb_1 gb_1
end type
global w_filter w_filter

type variables
datawindow 		idw_1
datawindowChild idwc_col

string is_colName[]
string is_dispName[]
end variables

forward prototypes
public function string wf_buildfilterstring ()
public function integer wf_getcolname ()
public function integer wf_getdispname ()
public function integer wf_setcolname ()
end prototypes

public function string wf_buildfilterstring ();string	ls_exp_left, ls_oper, ls_value, ls_colname, ls_filter, ls_and_or
string	ls_coltype, ls_expression
integer	li_i, li_rcount, li_foundrow

// Accept the latest changes.
If dw_filter.AcceptText() <> 1 Then Return '!'

// Get the values from the filter datawindow.
li_rcount = dw_filter.RowCount ( )
FOR li_i = 1 to li_rcount

	// Construct the left side of the expression.
	ls_exp_left = dw_filter.GetItemString ( li_i, "col" ) 
	IF IsNull(ls_exp_left) THEN ls_exp_left = ""
	IF ls_exp_left <> ""  AND  li_i > 1 THEN
		ls_filter = ls_filter + " " + ls_and_or
	END IF  

	// Construct the operator.
	ls_oper = dw_filter.GetItemString ( li_i, "operator" ) 
	IF IsNull(ls_oper) THEN ls_oper = ""

	// Get the value.
	ls_value = dw_filter.GetItemString ( li_i, "value" ) 
	IF IsNull (ls_value) THEN ls_value = ""

	// Construct the "AND" or "OR" for the expression.
	ls_and_or = dw_filter.GetItemString (li_i, "logical" ) 
	IF IsNull(ls_and_or) THEN ls_and_or = ""
	
	// Get the column name.
	li_foundrow = idwc_col.Find ('display_column = "' + ls_exp_left + '"', &
								1, idwc_col.RowCount ())
	IF li_foundrow > 0 THEN 
		ls_colname = idwc_col.GetItemString(li_foundrow, "columnname") 
	ELSE
		ls_colname = ls_exp_left
	END IF 

	// Get the column type.
	ls_coltype = Left(idw_1.Describe( ls_colname + ".ColType" ), 5)
	
	// Determine the correct expression.
	Choose Case ls_coltype
		// CHARACTER DATATYPE		
		Case "char(", "char"	
			If Pos(ls_value, '~~~"') =0 And Pos(ls_value, "~~~'") =0 Then
				// No special characters found.
				If Pos(ls_value, "'") >0 Then
					// Replace single quotes with special chars single quotes.
					//ls_value = lnv_string.of_GlobalReplace(ls_value, "'", "~~~'")				
				End If
			End If
			ls_expression = "'" + ls_value + "'"			
	
		// DATE DATATYPE	
		Case "date"
			ls_expression = "Date('" + ls_value  + "')" 

		// DATETIME DATATYPE
		Case "datet"				
			ls_expression = "DateTime('" + ls_value + "')" 

		// TIME DATATYPE
		Case "time", "times"		
			ls_expression = "Time('" + ls_value + "')" 
	
		// NUMBER
		Case 	Else
			ls_expression = ls_value
	End Choose

	// Build the filter string.
	ls_filter += " " + ls_colname + " " + ls_oper + " " + ls_expression
NEXT

Return Trim(ls_filter)
end function

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

public function integer wf_setcolname ();
integer i, li_colCount
integer li_iRow

li_iRow = dw_filter.insertRow(0)

for i = 1 to upperBound(is_colName)
	idwc_col.insertRow(i)
	idwc_col.setItem(i,"columnname", is_colName[i])	
	idwc_col.setItem(i,"display_column", is_dispName[i])	
next

return 1
end function

event open;powerObject  lpo_1
f_centerme(This)
lpo_1 = message.powerObjectParm

if lpo_1.typeof() <> datawindow! then
	messagebox("invalid Object", "invalid Object....just datawindow object")
	close(this)
	return
end if

idw_1 = lpo_1

dw_filter.getChild("col", idwc_col)

wf_getColName()
wf_getdispName()
wf_setColName()
end event

on w_filter.create
this.dw_filter=create dw_filter
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.gb_1=create gb_1
this.Control[]={this.dw_filter,&
this.cb_1,&
this.cb_2,&
this.cb_3,&
this.cb_4,&
this.cb_5,&
this.cb_6,&
this.gb_1}
end on

on w_filter.destroy
destroy(this.dw_filter)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.gb_1)
end on

type dw_filter from datawindow within w_filter
integer x = 105
integer y = 132
integer width = 2149
integer height = 536
integer taborder = 20
string title = "none"
string dataobject = "d_filter"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;if dwo.name = "logical" and row = rowCount() then
	cb_1.trigger event clicked()
end if

end event

type cb_1 from commandbutton within w_filter
integer x = 2290
integer y = 88
integer width = 384
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "&Add"
end type

event clicked;dw_filter.scrollToRow(dw_filter.insertRow(0))
end event

type cb_2 from commandbutton within w_filter
integer x = 2295
integer y = 288
integer width = 384
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "&Reset"
end type

event clicked;dw_filter.reset()
cb_1.trigger event clicked()
end event

type cb_3 from commandbutton within w_filter
integer x = 2295
integer y = 588
integer width = 384
integer height = 92
integer taborder = 20
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

type cb_4 from commandbutton within w_filter
integer x = 2290
integer y = 188
integer width = 384
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "&Delete"
end type

event clicked;dw_filter.deleteRow(dw_filter.getRow())
end event

type cb_5 from commandbutton within w_filter
integer x = 2295
integer y = 388
integer width = 384
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "&Filter"
boolean default = true
end type

event clicked;idw_1.setFilter(wf_BuildFilterString())
idw_1.filter()
idw_1.GroupCalc()
end event

type cb_6 from commandbutton within w_filter
integer x = 2295
integer y = 488
integer width = 384
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "&Unfilter"
end type

event clicked;idw_1.setFilter("")
idw_1.filter()
idw_1.GroupCalc()
end event

type gb_1 from groupbox within w_filter
integer x = 41
integer y = 48
integer width = 2693
integer height = 652
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "필터"
borderstyle borderstyle = stylelowered!
end type

