$PBExportHeader$w_hgj316p.srw
$PBExportComments$[청운대]심사내역표
forward
global type w_hgj316p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hgj316p
end type
type dw_con from uo_dwfree within w_hgj316p
end type
end forward

global type w_hgj316p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hgj316p w_hgj316p

on w_hgj316p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hgj316p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string	ls_year, ls_junhugi
long ll_ans

dw_con.AcceptText()

ls_year		= dw_con.Object.year[1]
ls_junhugi   = dw_con.Object.junhugi[1]

if trim(ls_year) = '' Or Isnull(ls_year) then
	messagebox("확인","사정년도를 입력하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return	 -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_junhugi)

if ll_ans = 0 then
	uf_messagebox(7)
	
elseif ll_ans = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1
end event

event open;call super::open;String ls_year

idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

ls_year	= f_haksa_iljung_year()

dw_con.Object.year[1]  = ls_year

end event

type ln_templeft from w_condition_window`ln_templeft within w_hgj316p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hgj316p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hgj316p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hgj316p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hgj316p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hgj316p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hgj316p
end type

type uc_insert from w_condition_window`uc_insert within w_hgj316p
end type

type uc_delete from w_condition_window`uc_delete within w_hgj316p
end type

type uc_save from w_condition_window`uc_save within w_hgj316p
end type

type uc_excel from w_condition_window`uc_excel within w_hgj316p
end type

type uc_print from w_condition_window`uc_print within w_hgj316p
end type

type st_line1 from w_condition_window`st_line1 within w_hgj316p
end type

type st_line2 from w_condition_window`st_line2 within w_hgj316p
end type

type st_line3 from w_condition_window`st_line3 within w_hgj316p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hgj316p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hgj316p
end type

type gb_1 from w_condition_window`gb_1 within w_hgj316p
end type

type gb_2 from w_condition_window`gb_2 within w_hgj316p
end type

type dw_main from uo_search_dwc within w_hgj316p
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hgj316p"
end type

type dw_con from uo_dwfree within w_hgj316p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 190
boolean bringtotop = true
string dataobject = "d_hgj316p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

