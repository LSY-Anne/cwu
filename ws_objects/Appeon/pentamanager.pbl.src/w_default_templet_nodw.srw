$PBExportHeader$w_default_templet_nodw.srw
$PBExportComments$기본 윈도우 템플릿(데이터윈도우 2개)
forward
global type w_default_templet_nodw from w_rolesheet
end type
end forward

global type w_default_templet_nodw from w_rolesheet
event ue_new pbm_custom05
event ue_delete pbm_custom06
event ue_retrieve pbm_custom07
event ue_save pbm_custom08
event ue_cancel pbm_custom09
end type
global w_default_templet_nodw w_default_templet_nodw

type variables
string is_sort, is_sort_order
string is_param[]
integer ii_param
end variables

forward prototypes
public subroutine wf_datawindow_sort ()
end prototypes

public subroutine wf_datawindow_sort ();
end subroutine

on w_default_templet_nodw.create
call super::create
end on

on w_default_templet_nodw.destroy
call super::destroy
end on

event close;//f_btnstatus('01')				// 툴바버튼 초기화
//f_set_Message('')				// 메세지라인 초기화
//f_set_PgmId('w_hanamain')	// 프로그램 ID 초기화
//
end event

type ln_templeft from w_rolesheet`ln_templeft within w_default_templet_nodw
end type

type ln_tempright from w_rolesheet`ln_tempright within w_default_templet_nodw
end type

type ln_temptop from w_rolesheet`ln_temptop within w_default_templet_nodw
end type

type ln_tempbuttom from w_rolesheet`ln_tempbuttom within w_default_templet_nodw
end type

type ln_tempbutton from w_rolesheet`ln_tempbutton within w_default_templet_nodw
end type

type ln_tempstart from w_rolesheet`ln_tempstart within w_default_templet_nodw
end type

type uc_retrieve from w_rolesheet`uc_retrieve within w_default_templet_nodw
integer x = 2807
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_save from w_rolesheet`uc_save within w_default_templet_nodw
integer x = 3936
integer y = 40
integer width = 274
integer height = 84
end type

type uc_run from w_rolesheet`uc_run within w_default_templet_nodw
integer x = 2135
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_print from w_rolesheet`uc_print within w_default_templet_nodw
integer x = 3479
integer y = 40
boolean originalsize = true
end type

type uc_ok from w_rolesheet`uc_ok within w_default_templet_nodw
integer x = 2359
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_excel from w_rolesheet`uc_excel within w_default_templet_nodw
integer x = 3712
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_delete from w_rolesheet`uc_delete within w_default_templet_nodw
integer x = 3255
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_close from w_rolesheet`uc_close within w_default_templet_nodw
integer x = 4160
integer y = 40
integer width = 274
integer height = 84
end type

type uc_cancel from w_rolesheet`uc_cancel within w_default_templet_nodw
integer x = 2583
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

type uc_insert from w_rolesheet`uc_insert within w_default_templet_nodw
integer x = 3031
integer y = 40
integer width = 274
integer height = 84
boolean originalsize = true
end type

