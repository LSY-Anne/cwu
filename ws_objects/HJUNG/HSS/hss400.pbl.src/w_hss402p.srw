$PBExportHeader$w_hss402p.srw
$PBExportComments$교사 및 교지기준면적 산출조서
forward
global type w_hss402p from w_msheet
end type
type em_1 from editmask within w_hss402p
end type
type st_1 from statictext within w_hss402p
end type
type dw_print from cuo_dwprint within w_hss402p
end type
type gb_1 from groupbox within w_hss402p
end type
type st_3 from statictext within w_hss402p
end type
end forward

global type w_hss402p from w_msheet
integer height = 2616
string title = "교사 및 교지기준면적 산출조서"
em_1 em_1
st_1 st_1
dw_print dw_print
gb_1 gb_1
st_3 st_3
end type
global w_hss402p w_hss402p

type variables


end variables

on w_hss402p.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.dw_print=create dw_print
this.gb_1=create gb_1
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_print
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.st_3
end on

on w_hss402p.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.st_3)
end on

event ue_print;call super::ue_print;//IF dw_print.rowcount() <> 0 THEN f_print(dw_print)


end event

event ue_init;call super::ue_init;dw_print.reset()

//wf_setMenu('R',TRUE)
//wf_setMenu('P',FALSE)
end event

event ue_retrieve;call super::ue_retrieve;long ll_row

if em_1.text = '' or isnull(em_1.text) then
	f_set_message("[알림] " + '기준년도를 입력하여 주십시요', '', parentwin)
//	f_dis_msg(1,'기준년도를 입력하여 주십시요','')
	em_1.setfocus()
	return -1
end if



ll_row = dw_print.retrieve(em_1.text)



IF ll_row = 0 THEN 
	messagebox("알림",'조회된 내용이 없습니다')
//	wf_setMenu('P',FALSE)
ELSE
	messagebox("알림",string(ll_row) + '건의 데이타가 조회되었습니다')
//	wf_setMenu('P',TRUE)
END IF
end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 교사 및 교지기준면적 산출조서
//    적 성 인 : 윤하영
//		작성일자 : 2002.04.15
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//wf_setMenu('R',TRUE)

em_1.text = left(f_today(),4)
em_1.setfocus()

idw_print = dw_print
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "교사 및 교지기준면적 산출조서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hss402p
end type

type ln_tempright from w_msheet`ln_tempright within w_hss402p
end type

type ln_temptop from w_msheet`ln_temptop within w_hss402p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hss402p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hss402p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hss402p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hss402p
end type

type uc_insert from w_msheet`uc_insert within w_hss402p
end type

type uc_delete from w_msheet`uc_delete within w_hss402p
end type

type uc_save from w_msheet`uc_save within w_hss402p
end type

type uc_excel from w_msheet`uc_excel within w_hss402p
end type

type uc_print from w_msheet`uc_print within w_hss402p
end type

type st_line1 from w_msheet`st_line1 within w_hss402p
end type

type st_line2 from w_msheet`st_line2 within w_hss402p
end type

type st_line3 from w_msheet`st_line3 within w_hss402p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hss402p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hss402p
end type

type em_1 from editmask within w_hss402p
integer x = 448
integer y = 176
integer width = 306
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean spin = true
end type

type st_1 from statictext within w_hss402p
integer x = 91
integer y = 192
integer width = 325
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "기준년도"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_print from cuo_dwprint within w_hss402p
integer x = 50
integer y = 300
integer width = 4384
integer height = 1988
integer taborder = 11
boolean titlebar = true
string title = "교사 및 교지기준면적 산출조서"
string dataobject = "d_hss402p_1"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from groupbox within w_hss402p
integer x = 50
integer y = 120
integer width = 4389
integer height = 176
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type st_3 from statictext within w_hss402p
boolean visible = false
integer x = 3950
integer y = 192
integer width = 462
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "금액단위: 천원"
boolean focusrectangle = false
end type

