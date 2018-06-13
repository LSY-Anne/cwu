$PBExportHeader$w_hsg212p.srw
$PBExportComments$[청운대]행사지도비 지원현황
forward
global type w_hsg212p from w_condition_window
end type
type st_5 from statictext within w_hsg212p
end type
type dw_2 from uo_dddw_dwc within w_hsg212p
end type
type em_from_year from editmask within w_hsg212p
end type
type st_2 from statictext within w_hsg212p
end type
type st_4 from statictext within w_hsg212p
end type
type dw_1 from datawindow within w_hsg212p
end type
end forward

global type w_hsg212p from w_condition_window
st_5 st_5
dw_2 dw_2
em_from_year em_from_year
st_2 st_2
st_4 st_4
dw_1 dw_1
end type
global w_hsg212p w_hsg212p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hsg212p.create
int iCurrent
call super::create
this.st_5=create st_5
this.dw_2=create dw_2
this.em_from_year=create em_from_year
this.st_2=create st_2
this.st_4=create st_4
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.em_from_year
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.dw_1
end on

on w_hsg212p.destroy
call super::destroy
destroy(this.st_5)
destroy(this.dw_2)
destroy(this.em_from_year)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.dw_1)
end on

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	FALSE)
//wf_setmenu('DELETE', 	FALSE)
//wf_setmenu('SAVE', 		FALSE)
//wf_setmenu('PRINT', 		TRUE)
end event

event ue_retrieve;call super::ue_retrieve;int		li_row
string 	ls_prof_id, ls_from_year

ls_prof_id	=	dw_2.gettext() + '%'
ls_from_year 		=	em_from_year.text


li_row = dw_1.retrieve(ls_prof_id, ls_from_year)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_1.setfocus()
return 1
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

event ue_postopen;call super::ue_postopen;idw_print = dw_1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsg212p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsg212p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsg212p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsg212p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsg212p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsg212p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsg212p
end type

type uc_insert from w_condition_window`uc_insert within w_hsg212p
end type

type uc_delete from w_condition_window`uc_delete within w_hsg212p
end type

type uc_save from w_condition_window`uc_save within w_hsg212p
end type

type uc_excel from w_condition_window`uc_excel within w_hsg212p
end type

type uc_print from w_condition_window`uc_print within w_hsg212p
end type

type st_line1 from w_condition_window`st_line1 within w_hsg212p
end type

type st_line2 from w_condition_window`st_line2 within w_hsg212p
end type

type st_line3 from w_condition_window`st_line3 within w_hsg212p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsg212p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsg212p
end type

type gb_1 from w_condition_window`gb_1 within w_hsg212p
integer x = 0
end type

type gb_2 from w_condition_window`gb_2 within w_hsg212p
integer x = 0
end type

type st_5 from statictext within w_hsg212p
integer x = 567
integer y = 200
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

type dw_2 from uo_dddw_dwc within w_hsg212p
integer x = 741
integer y = 184
integer width = 571
integer height = 80
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_list_prof"
end type

type em_from_year from editmask within w_hsg212p
integer x = 1737
integer y = 184
integer width = 325
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean autoskip = true
boolean spin = true
string displaydata = "~t/"
double increment = 1
boolean usecodetable = true
end type

type st_2 from statictext within w_hsg212p
integer x = 1458
integer y = 200
integer width = 270
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
string text = "시작년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_hsg212p
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
long textcolor = 16777215
long backcolor = 31112622
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_hsg212p
integer x = 55
integer y = 292
integer width = 4375
integer height = 1968
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_hsg212p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

