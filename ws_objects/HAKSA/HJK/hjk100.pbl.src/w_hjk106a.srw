$PBExportHeader$w_hjk106a.srw
$PBExportComments$[청운대]역종관리
forward
global type w_hjk106a from w_condition_window
end type
type dw_main from uo_input_dwc within w_hjk106a
end type
type dw_con from uo_dwfree within w_hjk106a
end type
end forward

global type w_hjk106a from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hjk106a w_hjk106a

on w_hjk106a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk106a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string ls_gwa, ls_hakbun, ls_hakyun
int li_ans

dw_con.AcceptText()

//조회조건
ls_hakyun	= func.of_nvl(dw_con.Object.hakgi[1], '%')
ls_gwa		= func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun 	= func.of_nvl(dw_con.Object.hakbun[1], '%')

li_ans = dw_main.retrieve(ls_hakbun, ls_gwa, ls_hakyun)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_main.setfocus()
end if
end event

event open;call super::open;idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk106a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk106a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk106a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk106a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk106a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk106a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk106a
end type

type uc_insert from w_condition_window`uc_insert within w_hjk106a
end type

type uc_delete from w_condition_window`uc_delete within w_hjk106a
end type

type uc_save from w_condition_window`uc_save within w_hjk106a
end type

type uc_excel from w_condition_window`uc_excel within w_hjk106a
end type

type uc_print from w_condition_window`uc_print within w_hjk106a
end type

type st_line1 from w_condition_window`st_line1 within w_hjk106a
end type

type st_line2 from w_condition_window`st_line2 within w_hjk106a
end type

type st_line3 from w_condition_window`st_line3 within w_hjk106a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk106a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk106a
end type

type gb_1 from w_condition_window`gb_1 within w_hjk106a
end type

type gb_2 from w_condition_window`gb_2 within w_hjk106a
end type

type dw_main from uo_input_dwc within w_hjk106a
integer x = 55
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk106a_1"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type dw_con from uo_dwfree within w_hjk106a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk106a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

