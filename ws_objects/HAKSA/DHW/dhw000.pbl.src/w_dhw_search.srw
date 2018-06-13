$PBExportHeader$w_dhw_search.srw
$PBExportComments$[대학원] 학생조회용Popup
forward
global type w_dhw_search from w_popup
end type
type dw_1 from uo_input_dwc within w_dhw_search
end type
end forward

global type w_dhw_search from w_popup
integer width = 2249
integer height = 1196
string title = "학생조회"
dw_1 dw_1
end type
global w_dhw_search w_dhw_search

on w_dhw_search.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_dhw_search.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;string ls_name

ls_name = Message.StringParm

dw_1.retrieve(ls_name)
end event

type p_msg from w_popup`p_msg within w_dhw_search
integer y = 1020
end type

type st_msg from w_popup`st_msg within w_dhw_search
integer y = 1020
integer width = 2039
end type

type uc_printpreview from w_popup`uc_printpreview within w_dhw_search
end type

type uc_cancel from w_popup`uc_cancel within w_dhw_search
end type

type uc_ok from w_popup`uc_ok within w_dhw_search
end type

type uc_excelroad from w_popup`uc_excelroad within w_dhw_search
end type

type uc_excel from w_popup`uc_excel within w_dhw_search
end type

type uc_save from w_popup`uc_save within w_dhw_search
end type

type uc_delete from w_popup`uc_delete within w_dhw_search
end type

type uc_insert from w_popup`uc_insert within w_dhw_search
end type

type uc_retrieve from w_popup`uc_retrieve within w_dhw_search
end type

type ln_temptop from w_popup`ln_temptop within w_dhw_search
integer endx = 2231
end type

type ln_1 from w_popup`ln_1 within w_dhw_search
integer beginy = 1080
integer endx = 2231
integer endy = 1080
end type

type ln_2 from w_popup`ln_2 within w_dhw_search
integer endy = 1120
end type

type ln_3 from w_popup`ln_3 within w_dhw_search
integer beginx = 2199
integer endx = 2199
integer endy = 1120
end type

type r_backline1 from w_popup`r_backline1 within w_dhw_search
end type

type r_backline2 from w_popup`r_backline2 within w_dhw_search
end type

type r_backline3 from w_popup`r_backline3 within w_dhw_search
end type

type uc_print from w_popup`uc_print within w_dhw_search
end type

type dw_1 from uo_input_dwc within w_dhw_search
integer x = 69
integer y = 72
integer width = 2126
integer height = 924
integer taborder = 10
string dataobject = "d_dhw_search"
end type

event doubleclicked;string	ls_hakbun

if row <= 0 then return

ls_hakbun = this.getitemstring(row, 'hakbun')
CloseWithReturn(Parent, ls_hakbun)

end event

