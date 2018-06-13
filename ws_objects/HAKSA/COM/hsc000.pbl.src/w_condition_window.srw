$PBExportHeader$w_condition_window.srw
$PBExportComments$[청운대]검색조건 있는 조상윈도우
forward
global type w_condition_window from w_basewindow
end type
type gb_1 from uo_search_groupbox within w_condition_window
end type
type gb_2 from uo_main_groupbox within w_condition_window
end type
end forward

global type w_condition_window from w_basewindow
gb_1 gb_1
gb_2 gb_2
end type
global w_condition_window w_condition_window

type variables
window		iw_window
datawindow	idw_datawindow
end variables

on w_condition_window.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_2
end on

on w_condition_window.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.gb_2)
end on

type ln_templeft from w_basewindow`ln_templeft within w_condition_window
end type

type ln_tempright from w_basewindow`ln_tempright within w_condition_window
end type

type ln_temptop from w_basewindow`ln_temptop within w_condition_window
end type

type ln_tempbuttom from w_basewindow`ln_tempbuttom within w_condition_window
end type

type ln_tempbutton from w_basewindow`ln_tempbutton within w_condition_window
end type

type ln_tempstart from w_basewindow`ln_tempstart within w_condition_window
end type

type uc_retrieve from w_basewindow`uc_retrieve within w_condition_window
end type

type uc_insert from w_basewindow`uc_insert within w_condition_window
end type

type uc_delete from w_basewindow`uc_delete within w_condition_window
end type

type uc_save from w_basewindow`uc_save within w_condition_window
end type

type uc_excel from w_basewindow`uc_excel within w_condition_window
end type

type uc_print from w_basewindow`uc_print within w_condition_window
end type

type st_line1 from w_basewindow`st_line1 within w_condition_window
end type

type st_line2 from w_basewindow`st_line2 within w_condition_window
end type

type st_line3 from w_basewindow`st_line3 within w_condition_window
end type

type uc_excelroad from w_basewindow`uc_excelroad within w_condition_window
end type

type gb_1 from uo_search_groupbox within w_condition_window
boolean visible = false
integer x = 210
integer y = 1048
integer width = 78
integer height = 68
integer taborder = 0
end type

type gb_2 from uo_main_groupbox within w_condition_window
boolean visible = false
integer x = 210
integer y = 1144
integer width = 78
integer height = 68
integer taborder = 0
end type

