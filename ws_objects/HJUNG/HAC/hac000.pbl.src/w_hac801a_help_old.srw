$PBExportHeader$w_hac801a_help_old.srw
$PBExportComments$산출내역 조회
forward
global type w_hac801a_help_old from w_msheet
end type
type dw_1 from uo_dwgrid within w_hac801a_help_old
end type
end forward

global type w_hac801a_help_old from w_msheet
integer width = 2181
integer height = 1384
string title = "예산산출근거"
boolean resizable = false
windowtype windowtype = response!
dw_1 dw_1
end type
global w_hac801a_help_old w_hac801a_help_old

on w_hac801a_help_old.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_hac801a_help_old.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_open;call super::ue_open;f_centerme(this)

s_insa_com	lstr_com
string		ls_bdgt_year, ls_gwa, ls_acct_code

lstr_com = message.powerobjectparm

ls_bdgt_year = lstr_com.ls_item[1]
ls_gwa       = lstr_com.ls_item[2]
ls_acct_code = lstr_com.ls_item[3]

dw_1.retrieve(ls_bdgt_year, ls_gwa, ls_acct_code, 1, '2', 0, 41)
end event

event open;THIS.trigger EVENT ue_open(0,0)
end event

type ln_templeft from w_msheet`ln_templeft within w_hac801a_help_old
end type

type ln_tempright from w_msheet`ln_tempright within w_hac801a_help_old
end type

type ln_temptop from w_msheet`ln_temptop within w_hac801a_help_old
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hac801a_help_old
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hac801a_help_old
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hac801a_help_old
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hac801a_help_old
end type

type uc_insert from w_msheet`uc_insert within w_hac801a_help_old
end type

type uc_delete from w_msheet`uc_delete within w_hac801a_help_old
end type

type uc_save from w_msheet`uc_save within w_hac801a_help_old
end type

type uc_excel from w_msheet`uc_excel within w_hac801a_help_old
end type

type uc_print from w_msheet`uc_print within w_hac801a_help_old
end type

type st_line1 from w_msheet`st_line1 within w_hac801a_help_old
end type

type st_line2 from w_msheet`st_line2 within w_hac801a_help_old
end type

type st_line3 from w_msheet`st_line3 within w_hac801a_help_old
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hac801a_help_old
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hac801a_help_old
end type

type dw_1 from uo_dwgrid within w_hac801a_help_old
integer y = 12
integer width = 2167
integer height = 1268
integer taborder = 10
string dataobject = "d_hac801a_help"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

