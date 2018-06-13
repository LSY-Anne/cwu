$PBExportHeader$dw_ancestor.sru
$PBExportComments$DataWindow의 Title을 Click하는 항목으로 Sort시켜주기 위한 DataWindow Ancestor (Window에서 Inherit 하여 사용한다.)
forward
global type dw_ancestor from datawindow
end type
end forward

global type dw_ancestor from datawindow
int Width=494
int Height=361
int TabOrder=1
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
event tabout pbm_dwntabout
event key pbm_dwnkey
end type
global dw_ancestor dw_ancestor

type variables
string	is_primarysort

end variables

event dberror;return 1
end event

event clicked;string	dwobject, oldsort, newsort, band
string	ls_columnname
integer  li_pos

this.setredraw(false)

////////// Clumnm명 + _t + 차순(오름차순:a, 내림차순:d) + d(DDDW를 사용해야할 경우)
dwobject = GetObjectAtPointer()
band 		= this.GetBandAtPointer()

if Match(dwobject, "[_t0-9]$") and left(band, 6) = 'header' then
	li_pos  = Pos(dwobject, "_t")
	
	if mid(dwobject, li_pos + 3, 1) = 'd' then	// DDDW (lookupdisplay를 사용해야할 경우)
		ls_columnname = 'lookupdisplay(' + mid(dwobject, 1, li_pos - 1) + ')'
	else
		ls_columnname = mid(dwobject, 1, li_pos - 1)
	end if

	if is_primarysort = '' or isnull(is_primarysort) then
		newsort = ls_columnname + ' ' + upper(mid(dwobject, li_pos + 2, 1))
	else
		newsort = ls_columnname + ' ' + upper(mid(dwobject, li_pos + 2, 1)) + ', ' + is_primarysort
	end if

	SetSort(newsort)
	Sort()
	GroupCalc()
end if

this.setredraw(true)

end event

event constructor;is_primarysort = this.object.datawindow.table.sort
end event

