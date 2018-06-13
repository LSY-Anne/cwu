$PBExportHeader$w_hsu505p.srw
$PBExportComments$[청운대]교수별출석부
forward
global type w_hsu505p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hsu505p
end type
type dw_con from uo_dwfree within w_hsu505p
end type
end forward

global type w_hsu505p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hsu505p w_hsu505p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsu505p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hsu505p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

//사용자가 교수이면 검색조건의 교수를 ENABLED
if f_enabled_chk(gs_empcode) = 1 then
	dw_con.Object.prof_no[1] = gs_empcode
    dw_con.Object.prof_no.Protect = 0
	
end if

//if gs_empcode	=	'A0002' then
//	dw_con.Object.prof_no.Protect = 1
//end if
end event

event ue_retrieve;call super::ue_retrieve;int		li_row
string 	ls_year,	ls_hakgi, ls_member, ls_gwamok, ls_no

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_member	=	func.of_nvl(dw_con.Object.prof_no[1], '%')
ls_gwamok	=	func.of_nvl(dw_con.Object.gwamok[1], '%')
ls_no	         =	func.of_nvl(dw_con.Object.seq_no[1], '%')

li_row = dw_main.retrieve(ls_year, ls_hakgi, ls_member, ls_gwamok, ls_no)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu505p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu505p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu505p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu505p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu505p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu505p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu505p
end type

type uc_insert from w_condition_window`uc_insert within w_hsu505p
end type

type uc_delete from w_condition_window`uc_delete within w_hsu505p
end type

type uc_save from w_condition_window`uc_save within w_hsu505p
end type

type uc_excel from w_condition_window`uc_excel within w_hsu505p
end type

type uc_print from w_condition_window`uc_print within w_hsu505p
end type

type st_line1 from w_condition_window`st_line1 within w_hsu505p
end type

type st_line2 from w_condition_window`st_line2 within w_hsu505p
end type

type st_line3 from w_condition_window`st_line3 within w_hsu505p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu505p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu505p
end type

type gb_1 from w_condition_window`gb_1 within w_hsu505p
end type

type gb_2 from w_condition_window`gb_2 within w_hsu505p
end type

type dw_main from uo_search_dwc within w_hsu505p
integer x = 50
integer y = 296
integer width = 4384
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu500p_5"
end type

type dw_con from uo_dwfree within w_hsu505p
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hsu505p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

