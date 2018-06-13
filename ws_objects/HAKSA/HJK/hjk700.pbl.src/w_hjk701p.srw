$PBExportHeader$w_hjk701p.srw
$PBExportComments$[청운대]재적학생수현황출력(한국교육개발원)
forward
global type w_hjk701p from w_no_condition_window
end type
type dw_1 from uo_search_dwc within w_hjk701p
end type
end forward

global type w_hjk701p from w_no_condition_window
dw_1 dw_1
end type
global w_hjk701p w_hjk701p

on w_hjk701p.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_hjk701p.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;idw_print = dw_1

This.Event ue_retrieve()
end event

event ue_retrieve;int		li_row
string	ls_year

ls_year = f_haksa_iljung_year()

li_row = dw_1.retrieve(ls_year)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_1.setfocus()

Return 1

end event

type ln_templeft from w_no_condition_window`ln_templeft within w_hjk701p
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_hjk701p
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_hjk701p
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_hjk701p
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_hjk701p
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_hjk701p
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_hjk701p
end type

type uc_insert from w_no_condition_window`uc_insert within w_hjk701p
end type

type uc_delete from w_no_condition_window`uc_delete within w_hjk701p
end type

type uc_save from w_no_condition_window`uc_save within w_hjk701p
end type

type uc_excel from w_no_condition_window`uc_excel within w_hjk701p
end type

type uc_print from w_no_condition_window`uc_print within w_hjk701p
end type

type st_line1 from w_no_condition_window`st_line1 within w_hjk701p
end type

type st_line2 from w_no_condition_window`st_line2 within w_hjk701p
end type

type st_line3 from w_no_condition_window`st_line3 within w_hjk701p
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_hjk701p
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_hjk701p
end type

type gb_1 from w_no_condition_window`gb_1 within w_hjk701p
integer width = 101
integer height = 56
end type

type dw_1 from uo_search_dwc within w_hjk701p
integer x = 59
integer y = 176
integer width = 4370
integer height = 2272
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk701p_1"
end type

