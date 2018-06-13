﻿$PBExportHeader$w_hst606p.srw
$PBExportComments$실험실습 기자재 보유현황
forward
global type w_hst606p from w_msheet
end type
type em_1 from editmask within w_hst606p
end type
type st_1 from statictext within w_hst606p
end type
type dw_print from cuo_dwprint within w_hst606p
end type
type st_3 from statictext within w_hst606p
end type
type gb_1 from groupbox within w_hst606p
end type
end forward

global type w_hst606p from w_msheet
string title = "실험실습 기자재 보유현황"
em_1 em_1
st_1 st_1
dw_print dw_print
st_3 st_3
gb_1 gb_1
end type
global w_hst606p w_hst606p

type variables


end variables

on w_hst606p.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.dw_print=create dw_print
this.st_3=create st_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_print
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.gb_1
end on

on w_hst606p.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.dw_print)
destroy(this.st_3)
destroy(this.gb_1)
end on

event resize;call super::resize;//dw_1.resize(this.width - ii_width, this.height - ii_height)

end event

event ue_print;call super::ue_print;//IF dw_print.rowcount() <> 0 THEN f_print(dw_print)


end event

event ue_init();call super::ue_init;dw_print.reset()
em_1.text = left(f_today(),4)
//wf_setmenu('R',TRUE)
//wf_setmenu('P',FALSE)
end event

event ue_retrieve;call super::ue_retrieve;date  ld_end_date
long ll_row
string ls_begin_date, ls_end_date, ls_date



ls_date = string(long(em_1.text + '0301') -1)

ll_row = dw_print.retrieve(ls_date)



dw_print.object.t_head.text = "'" + right(em_1.text,2) + ". 3. 1 현재"

IF ll_row = 0 THEN 
	messagebox("알림",'조회된 내용이 없습니다')
	//wf_setmenu('P',FALSE)
ELSE
	messagebox("알림",string(ll_row) + '건의 데이타가 조회되었습니다')
	//wf_setmenu('P',TRUE)
END IF
return 1
end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 실험실습 기자재 보유현황
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//wf_setmenu('R',TRUE)

em_1.text = left(f_today(),4)
idw_print = dw_print
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "실험실습 기자재 보유현황")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hst606p
end type

type ln_tempright from w_msheet`ln_tempright within w_hst606p
end type

type ln_temptop from w_msheet`ln_temptop within w_hst606p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst606p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst606p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst606p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst606p
end type

type uc_insert from w_msheet`uc_insert within w_hst606p
end type

type uc_delete from w_msheet`uc_delete within w_hst606p
end type

type uc_save from w_msheet`uc_save within w_hst606p
end type

type uc_excel from w_msheet`uc_excel within w_hst606p
end type

type uc_print from w_msheet`uc_print within w_hst606p
end type

type st_line1 from w_msheet`st_line1 within w_hst606p
end type

type st_line2 from w_msheet`st_line2 within w_hst606p
end type

type st_line3 from w_msheet`st_line3 within w_hst606p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst606p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst606p
end type

type em_1 from editmask within w_hst606p
integer x = 398
integer y = 208
integer width = 320
integer height = 80
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

type st_1 from statictext within w_hst606p
integer x = 105
integer y = 216
integer width = 283
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "기준년도"
boolean focusrectangle = false
end type

type dw_print from cuo_dwprint within w_hst606p
integer x = 50
integer y = 340
integer width = 4389
integer height = 1956
integer taborder = 11
boolean titlebar = true
string title = "실험실습 기자재 보유현황"
string dataobject = "d_hst606p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type st_3 from statictext within w_hst606p
boolean visible = false
integer x = 3223
integer y = 40
integer width = 462
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 67108864
string text = "금액단위: 천원"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hst606p
integer x = 50
integer y = 144
integer width = 4389
integer height = 180
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

