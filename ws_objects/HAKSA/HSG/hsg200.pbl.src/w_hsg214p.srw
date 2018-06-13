$PBExportHeader$w_hsg214p.srw
$PBExportComments$[청운대]동아리 지도교수 관리 현황표
forward
global type w_hsg214p from w_condition_window
end type
type em_1 from uo_em_year within w_hsg214p
end type
type st_1 from statictext within w_hsg214p
end type
type st_2 from statictext within w_hsg214p
end type
type dw_main from datawindow within w_hsg214p
end type
end forward

global type w_hsg214p from w_condition_window
integer width = 4617
em_1 em_1
st_1 st_1
st_2 st_2
dw_main dw_main
end type
global w_hsg214p w_hsg214p

type variables

end variables

on w_hsg214p.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.st_2=create st_2
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_main
end on

on w_hsg214p.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_main)
end on

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	FALSE)
//wf_setmenu('DELETE', 	FALSE)
//wf_setmenu('SAVE', 		FALSE)
//wf_setmenu('PRINT', 		TRUE)
//


end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakyun, ls_hakgwa, ls_gubun,  ls_serial,  ls_prof,  ls_string
String ls_name
long   ll_row,  ii,        kk

ls_year    = em_1.text

ll_row     = dw_main.retrieve(ls_year)

if ll_row = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)

elseif ll_row = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

dw_main.modify("DataWindow.Print.Preview = no")

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

event ue_postopen;call super::ue_postopen;idw_print = dw_main
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsg214p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsg214p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsg214p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsg214p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsg214p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsg214p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsg214p
end type

type uc_insert from w_condition_window`uc_insert within w_hsg214p
end type

type uc_delete from w_condition_window`uc_delete within w_hsg214p
end type

type uc_save from w_condition_window`uc_save within w_hsg214p
end type

type uc_excel from w_condition_window`uc_excel within w_hsg214p
end type

type uc_print from w_condition_window`uc_print within w_hsg214p
end type

type st_line1 from w_condition_window`st_line1 within w_hsg214p
end type

type st_line2 from w_condition_window`st_line2 within w_hsg214p
end type

type st_line3 from w_condition_window`st_line3 within w_hsg214p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsg214p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsg214p
end type

type gb_1 from w_condition_window`gb_1 within w_hsg214p
boolean underline = true
end type

type gb_2 from w_condition_window`gb_2 within w_hsg214p
integer taborder = 90
end type

type em_1 from uo_em_year within w_hsg214p
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

type st_1 from statictext within w_hsg214p
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
long textcolor = 18751006
long backcolor = 31112622
string text = "년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_hsg214p
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

type dw_main from datawindow within w_hsg214p
integer x = 55
integer y = 292
integer width = 4375
integer height = 1968
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hsg214p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

