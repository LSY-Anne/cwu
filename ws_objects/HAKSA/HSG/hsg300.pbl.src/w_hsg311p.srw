$PBExportHeader$w_hsg311p.srw
$PBExportComments$[청운대]학과별MT관리현황표
forward
global type w_hsg311p from w_condition_window
end type
type em_1 from uo_em_year within w_hsg311p
end type
type st_1 from statictext within w_hsg311p
end type
type st_2 from statictext within w_hsg311p
end type
type st_3 from statictext within w_hsg311p
end type
type dw_1 from uo_dddw_dwc within w_hsg311p
end type
type ddlb_1 from uo_ddlb_hakgi within w_hsg311p
end type
type st_4 from statictext within w_hsg311p
end type
type ddlb_2 from dropdownlistbox within w_hsg311p
end type
type st_5 from statictext within w_hsg311p
end type
type dw_main from datawindow within w_hsg311p
end type
end forward

global type w_hsg311p from w_condition_window
integer width = 4626
em_1 em_1
st_1 st_1
st_2 st_2
st_3 st_3
dw_1 dw_1
ddlb_1 ddlb_1
st_4 st_4
ddlb_2 ddlb_2
st_5 st_5
dw_main dw_main
end type
global w_hsg311p w_hsg311p

type variables

end variables

on w_hsg311p.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.ddlb_2=create ddlb_2
this.st_5=create st_5
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.ddlb_2
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.dw_main
end on

on w_hsg311p.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.ddlb_2)
destroy(this.st_5)
destroy(this.dw_main)
end on

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	FALSE)
//wf_setmenu('DELETE', 	FALSE)
//wf_setmenu('SAVE', 		FALSE)
//wf_setmenu('PRINT', 		TRUE)
//
//
//
end event

event ue_retrieve;call super::ue_retrieve;string	ls_year, ls_hakgi, ls_hakgwa, ls_gubun
long 		ll_row

ls_year	=	em_1.text
ls_hakgi	=	ddlb_1.text
ls_hakgwa	=	dw_1.gettext() + '%'

if ddlb_2.text = '연합' then
	ls_gubun = '1'
elseif ddlb_2.text = '학과' then
	ls_gubun = '2'
end if

ll_row = dw_main.retrieve(ls_year, ls_hakgi, ls_hakgwa, ls_gubun)

if ll_row = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)

elseif ll_row = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if
return 1
end event

event ue_postopen;call super::ue_postopen;idw_print = dw_main
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

type ln_templeft from w_condition_window`ln_templeft within w_hsg311p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsg311p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsg311p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsg311p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsg311p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsg311p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsg311p
end type

type uc_insert from w_condition_window`uc_insert within w_hsg311p
end type

type uc_delete from w_condition_window`uc_delete within w_hsg311p
end type

type uc_save from w_condition_window`uc_save within w_hsg311p
end type

type uc_excel from w_condition_window`uc_excel within w_hsg311p
end type

type uc_print from w_condition_window`uc_print within w_hsg311p
end type

type st_line1 from w_condition_window`st_line1 within w_hsg311p
end type

type st_line2 from w_condition_window`st_line2 within w_hsg311p
end type

type st_line3 from w_condition_window`st_line3 within w_hsg311p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsg311p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsg311p
end type

type gb_1 from w_condition_window`gb_1 within w_hsg311p
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsg311p
integer taborder = 90
end type

type em_1 from uo_em_year within w_hsg311p
integer x = 311
integer y = 184
integer width = 242
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_1 from statictext within w_hsg311p
integer x = 146
integer y = 200
integer width = 137
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_hsg311p
integer x = 695
integer y = 196
integer width = 197
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "학기"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_hsg311p
integer x = 1303
integer y = 196
integer width = 197
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "학과"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from uo_dddw_dwc within w_hsg311p
integer x = 1495
integer y = 180
integer width = 795
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_list_daepyogwa"
end type

type ddlb_1 from uo_ddlb_hakgi within w_hsg311p
integer x = 878
integer y = 180
integer taborder = 21
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_4 from statictext within w_hsg311p
integer x = 2523
integer y = 192
integer width = 197
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
string text = "구분"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_hsg311p
integer x = 2706
integer y = 180
integer width = 361
integer height = 324
integer taborder = 21
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
string item[] = {"연합","학과"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = '연합'
end event

type st_5 from statictext within w_hsg311p
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

type dw_main from datawindow within w_hsg311p
integer x = 55
integer y = 292
integer width = 4375
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsg311p"
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

