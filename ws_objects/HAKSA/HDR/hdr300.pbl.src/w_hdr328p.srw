$PBExportHeader$w_hdr328p.srw
$PBExportComments$[청운대]학생경비 환불자 내역
forward
global type w_hdr328p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hdr328p
end type
type dw_con from uo_dwfree within w_hdr328p
end type
end forward

global type w_hdr328p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hdr328p w_hdr328p

on w_hdr328p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hdr328p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;integer	li_row
string	ls_year, ls_hakgi, ls_gubun, ls_search

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gubun		=	dw_con.Object.gubun[1]

if ls_year = '' or isnull(ls_year) or ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","년도, 학기를 입력하세요.")
	return -1
end if

if ls_gubun = '1' Then
	dw_main.dataobject = 'd_hdr328p_1'
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes")
	li_row = dw_main.retrieve(ls_year, ls_hakgi)
elseif ls_gubun = '2' Then
	dw_main.dataobject = 'd_hdr328p_3'
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes")
	li_row = dw_main.retrieve(ls_year, ls_hakgi)
elseif ls_gubun = '3' Then
	dw_main.dataobject = 'd_hdr328p_2'
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes")
	li_row = dw_main.retrieve(ls_year, ls_hakgi)
elseif ls_gubun = '4' Then
	dw_main.dataobject = 'd_hdr328p_4'
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes")
	li_row = dw_main.retrieve(ls_year, ls_hakgi)
elseif ls_gubun = '5' Then
	dw_main.dataobject = 'd_hdr328p_5'
	dw_main.settransobject(sqlca)
	dw_main.Modify("datawindow.print.preview=yes")
	li_row = dw_main.retrieve(ls_year, ls_hakgi)
end if

if li_row = 0 then
	uf_messagebox(7)

elseif li_row = -1 then
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr328p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr328p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr328p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr328p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr328p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr328p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr328p
end type

type uc_insert from w_condition_window`uc_insert within w_hdr328p
end type

type uc_delete from w_condition_window`uc_delete within w_hdr328p
end type

type uc_save from w_condition_window`uc_save within w_hdr328p
end type

type uc_excel from w_condition_window`uc_excel within w_hdr328p
end type

type uc_print from w_condition_window`uc_print within w_hdr328p
end type

type st_line1 from w_condition_window`st_line1 within w_hdr328p
end type

type st_line2 from w_condition_window`st_line2 within w_hdr328p
end type

type st_line3 from w_condition_window`st_line3 within w_hdr328p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr328p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr328p
end type

type gb_1 from w_condition_window`gb_1 within w_hdr328p
end type

type gb_2 from w_condition_window`gb_2 within w_hdr328p
end type

type dw_main from uo_search_dwc within w_hdr328p
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hdr328p_1"
end type

type dw_con from uo_dwfree within w_hdr328p
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hdr328p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

