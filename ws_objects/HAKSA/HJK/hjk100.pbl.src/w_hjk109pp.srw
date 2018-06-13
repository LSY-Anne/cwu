$PBExportHeader$w_hjk109pp.srw
$PBExportComments$[청운대]학생조회popup
forward
global type w_hjk109pp from window
end type
type dw_1 from uo_input_dwc within w_hjk109pp
end type
end forward

global type w_hjk109pp from window
integer width = 2551
integer height = 1212
boolean titlebar = true
string title = "학생조회"
boolean controlmenu = true
windowtype windowtype = response!
boolean center = true
dw_1 dw_1
end type
global w_hjk109pp w_hjk109pp

on w_hjk109pp.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_hjk109pp.destroy
destroy(this.dw_1)
end on

type dw_1 from uo_input_dwc within w_hjk109pp
integer width = 2537
integer height = 1120
integer taborder = 20
string dataobject = "d_hjk109q_1"
end type

event constructor;call super::constructor;this.retrieve(Message.StringParm)
end event

event doubleclicked;call super::doubleclicked;string	ls_hakbun
int		li_row

if row > 0 then
	li_row = this.getrow()
	
	ls_hakbun = this.getitemstring(li_row, 'hakbun')
	
	CloseWithReturn(Parent, ls_hakbun)
end if
end event

