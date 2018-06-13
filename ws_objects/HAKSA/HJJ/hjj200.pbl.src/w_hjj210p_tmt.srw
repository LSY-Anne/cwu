$PBExportHeader$w_hjj210p_tmt.srw
$PBExportComments$[청운대]학과별 학점이수 현황표
forward
global type w_hjj210p_tmt from w_condition_window
end type
type dw_con from uo_dwfree within w_hjj210p_tmt
end type
type dw_main from uo_search_dwc within w_hjj210p_tmt
end type
end forward

global type w_hjj210p_tmt from w_condition_window
dw_con dw_con
dw_main dw_main
end type
global w_hjj210p_tmt w_hjj210p_tmt

on w_hjj210p_tmt.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hjj210p_tmt.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_retrieve;string 	ls_hakbun, ls_name,  ls_jumin, ls_year, ls_hakgi,  ls_hakgwa
integer 	li_ans,    li_hakjum

dw_con.AcceptText()

ls_hakgwa	= func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
li_hakjum    = dw_con.Object.hakjum[1]

li_ans    = dw_main.retrieve(ls_hakgwa, li_hakjum) 

IF li_ans < 1 THEN
	uf_messagebox(7)
	dw_main.reset()
END IF
		
Return 1
end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjj210p_tmt
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjj210p_tmt
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjj210p_tmt
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjj210p_tmt
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjj210p_tmt
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjj210p_tmt
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjj210p_tmt
end type

type uc_insert from w_condition_window`uc_insert within w_hjj210p_tmt
end type

type uc_delete from w_condition_window`uc_delete within w_hjj210p_tmt
end type

type uc_save from w_condition_window`uc_save within w_hjj210p_tmt
end type

type uc_excel from w_condition_window`uc_excel within w_hjj210p_tmt
end type

type uc_print from w_condition_window`uc_print within w_hjj210p_tmt
end type

type st_line1 from w_condition_window`st_line1 within w_hjj210p_tmt
end type

type st_line2 from w_condition_window`st_line2 within w_hjj210p_tmt
end type

type st_line3 from w_condition_window`st_line3 within w_hjj210p_tmt
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjj210p_tmt
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjj210p_tmt
end type

type gb_1 from w_condition_window`gb_1 within w_hjj210p_tmt
end type

type gb_2 from w_condition_window`gb_2 within w_hjj210p_tmt
end type

type dw_con from uo_dwfree within w_hjj210p_tmt
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 210
boolean bringtotop = true
string dataobject = "d_hjj210p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_search_dwc within w_hjj210p_tmt
integer x = 50
integer y = 304
integer width = 4384
integer height = 1960
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjj210p_1"
end type

