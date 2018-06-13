$PBExportHeader$w_hjk410p.srw
$PBExportComments$[청운대]학적부출력
forward
global type w_hjk410p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjk410p
end type
type dw_1 from uo_search_dwc within w_hjk410p
end type
type dw_con from uo_dwfree within w_hjk410p
end type
end forward

global type w_hjk410p from w_condition_window
dw_main dw_main
dw_1 dw_1
dw_con dw_con
end type
global w_hjk410p w_hjk410p

type variables
string is_hakbun
end variables

on w_hjk410p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_1=create dw_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_con
end on

on w_hjk410p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_1)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

event ue_retrieve;call super::ue_retrieve;string	ls_hakgwa, 	ls_hakyun, ls_gubun
int		li_row

Blob lb_bitmap, lb_pic
string ls_path
long ll_file_out, ll_length
int li_loops, i

dw_con.AcceptText()

 //조회조건
ls_hakgwa   = func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakyun	= func.of_nvl(dw_con.Object.hakgi[1], '%')
is_hakbun	= func.of_nvl(dw_con.Object.hakbun[1], '%')
ls_gubun  	= dw_con.Object.hakbun[1]

if ls_gubun = '1' Then
	dw_1.dataobject = 'd_hjk410p_1'
	dw_1.Event constructor()
	dw_1.settransobject(sqlca)
elseif ls_gubun = '2' Then
	dw_1.dataobject = 'd_hjk410p_3'
	dw_1.Event constructor()
	dw_1.settransobject(sqlca)
end if

li_row = dw_1.retrieve(ls_hakgwa, ls_hakyun, is_hakbun + '%')

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
elseif li_row > 0 then
	dw_1.setfocus()
	dw_1.setrow(1)
	dw_1.scrolltorow(1)
//	dw_1.selectrow(1,true)
	
	is_hakbun = dw_1.getitemstring(1, "hakbun")
		
	dw_main.retrieve(is_hakbun)
	
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk410p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk410p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk410p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk410p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk410p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk410p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk410p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk410p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk410p
end type

type uc_save from w_condition_window`uc_save within w_hjk410p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk410p
end type

type uc_print from w_condition_window`uc_print within w_hjk410p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk410p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk410p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk410p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk410p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk410p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk410p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk410p
end type

type dw_main from uo_search_dwc within w_hjk410p
integer x = 1061
integer y = 296
integer width = 3374
integer height = 1968
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_hjk410p_2"
end type

type dw_1 from uo_search_dwc within w_hjk410p
integer x = 55
integer y = 296
integer width = 992
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk410p_1"
end type

event clicked;call super::clicked;Blob lb_bitmap, lb_pic
string ls_path
long ll_file_out, ll_length
int li_loops, i

if row > 0 then
		
	is_hakbun = this.getitemstring(row, "hakbun")
		
	dw_main.retrieve(is_hakbun)
	
end if
end event

event constructor;this.settransobject(sqlca)

end event

type dw_con from uo_dwfree within w_hjk410p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk410p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

