$PBExportHeader$w_no_condition_window.srw
$PBExportComments$[청운대]검색조건 없는 조상윈도
forward
global type w_no_condition_window from w_basewindow
end type
type gb_1 from uo_no_main_groupbox within w_no_condition_window
end type
end forward

global type w_no_condition_window from w_basewindow
gb_1 gb_1
end type
global w_no_condition_window w_no_condition_window

type variables
window		iw_window
datawindow	idw_datawindow
end variables

on w_no_condition_window.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on w_no_condition_window.destroy
call super::destroy
destroy(this.gb_1)
end on

type ln_templeft from w_basewindow`ln_templeft within w_no_condition_window
end type

type ln_tempright from w_basewindow`ln_tempright within w_no_condition_window
end type

type ln_temptop from w_basewindow`ln_temptop within w_no_condition_window
end type

type ln_tempbuttom from w_basewindow`ln_tempbuttom within w_no_condition_window
end type

type ln_tempbutton from w_basewindow`ln_tempbutton within w_no_condition_window
end type

type ln_tempstart from w_basewindow`ln_tempstart within w_no_condition_window
end type

type uc_retrieve from w_basewindow`uc_retrieve within w_no_condition_window
end type

type uc_insert from w_basewindow`uc_insert within w_no_condition_window
end type

type uc_delete from w_basewindow`uc_delete within w_no_condition_window
end type

type uc_save from w_basewindow`uc_save within w_no_condition_window
end type

type uc_excel from w_basewindow`uc_excel within w_no_condition_window
end type

type uc_print from w_basewindow`uc_print within w_no_condition_window
end type

type st_line1 from w_basewindow`st_line1 within w_no_condition_window
end type

type st_line2 from w_basewindow`st_line2 within w_no_condition_window
end type

type st_line3 from w_basewindow`st_line3 within w_no_condition_window
end type

type uc_excelroad from w_basewindow`uc_excelroad within w_no_condition_window
end type

type ln_dwcon from w_basewindow`ln_dwcon within w_no_condition_window
end type

type gb_1 from uo_no_main_groupbox within w_no_condition_window
boolean visible = false
integer x = 142
integer y = 536
integer width = 73
integer height = 72
integer taborder = 0
end type

