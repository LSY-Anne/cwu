$PBExportHeader$w_hsg205a.srw
$PBExportComments$[청운대]동아리 지도실적 평가 출력
forward
global type w_hsg205a from w_condition_window
end type
type em_year from uo_em_year within w_hsg205a
end type
type st_3 from statictext within w_hsg205a
end type
type ddlb_hakgi from uo_ddlb_hakgi within w_hsg205a
end type
type st_4 from statictext within w_hsg205a
end type
type st_5 from statictext within w_hsg205a
end type
type dw_2 from uo_dddw_dwc within w_hsg205a
end type
type st_1 from statictext within w_hsg205a
end type
type dw_1 from datawindow within w_hsg205a
end type
end forward

global type w_hsg205a from w_condition_window
em_year em_year
st_3 st_3
ddlb_hakgi ddlb_hakgi
st_4 st_4
st_5 st_5
dw_2 dw_2
st_1 st_1
dw_1 dw_1
end type
global w_hsg205a w_hsg205a

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsg205a.create
int iCurrent
call super::create
this.em_year=create em_year
this.st_3=create st_3
this.ddlb_hakgi=create ddlb_hakgi
this.st_4=create st_4
this.st_5=create st_5
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_year
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.ddlb_hakgi
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.dw_1
end on

on w_hsg205a.destroy
call super::destroy
destroy(this.em_year)
destroy(this.st_3)
destroy(this.ddlb_hakgi)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	FALSE)
//wf_setmenu('DELETE', 	FALSE)
//wf_setmenu('SAVE', 		FALSE)
//wf_setmenu('PRINT', 		TRUE)
//
end event

event ue_retrieve;call super::ue_retrieve;int		li_row
string 	ls_year,	ls_hakgi, ls_prof_id

ls_year 	= em_year.text + '%'
ls_hakgi	= ddlb_hakgi.text + '%'
ls_prof_id = dw_2.gettext() + '%'
	
li_row = dw_1.retrieve(ls_year, ls_hakgi, ls_prof_id)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_1.setfocus()

return 1

end event

event ue_postopen;call super::ue_postopen;idw_print = dw_1
end event

event ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsg205a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsg205a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsg205a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsg205a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsg205a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsg205a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsg205a
end type

type uc_insert from w_condition_window`uc_insert within w_hsg205a
end type

type uc_delete from w_condition_window`uc_delete within w_hsg205a
end type

type uc_save from w_condition_window`uc_save within w_hsg205a
end type

type uc_excel from w_condition_window`uc_excel within w_hsg205a
end type

type uc_print from w_condition_window`uc_print within w_hsg205a
end type

type st_line1 from w_condition_window`st_line1 within w_hsg205a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_condition_window`st_line2 within w_hsg205a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_condition_window`st_line3 within w_hsg205a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsg205a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsg205a
end type

type gb_1 from w_condition_window`gb_1 within w_hsg205a
integer y = 8
integer height = 268
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Tahoma"
end type

type gb_2 from w_condition_window`gb_2 within w_hsg205a
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Tahoma"
end type

type em_year from uo_em_year within w_hsg205a
integer x = 398
integer y = 180
integer width = 242
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_3 from statictext within w_hsg205a
integer x = 219
integer y = 192
integer width = 174
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_hakgi from uo_ddlb_hakgi within w_hsg205a
integer x = 933
integer y = 180
integer height = 444
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_4 from statictext within w_hsg205a
integer x = 754
integer y = 192
integer width = 174
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hsg205a
integer x = 1221
integer y = 192
integer width = 187
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "교수"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from uo_dddw_dwc within w_hsg205a
integer x = 1408
integer y = 180
integer width = 571
integer height = 80
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_list_prof"
end type

type st_1 from statictext within w_hsg205a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 31112622
long backcolor = 31112622
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_hsg205a
integer x = 55
integer y = 292
integer width = 4375
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsg205a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

