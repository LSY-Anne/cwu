$PBExportHeader$w_hss404p.srw
$PBExportComments$지적현황
forward
global type w_hss404p from w_msheet
end type
type dw_print from cuo_dwprint within w_hss404p
end type
type st_3 from statictext within w_hss404p
end type
end forward

global type w_hss404p from w_msheet
integer height = 2616
string title = "지적현황"
dw_print dw_print
st_3 st_3
end type
global w_hss404p w_hss404p

type variables


end variables

on w_hss404p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.st_3
end on

on w_hss404p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.st_3)
end on

event resize;call super::resize;//dw_1.resize(this.width - ii_width, this.height - ii_height)

end event

event ue_print;call super::ue_print;//IF dw_print.rowcount() <> 0 THEN f_print(dw_print)


end event

event ue_init;call super::ue_init;dw_print.reset()

//wf_setMenu('R',TRUE)
//wf_setMenu('P',FALSE)
end event

event ue_retrieve;call super::ue_retrieve;date ld_begin_date, ld_end_date
long ll_row
string ls_begin_date, ls_end_date

SELECT BEGIN_DATE, END_DATE
INTO :ls_begin_date, :ls_end_date
FROM ACDB.CAMPUS;


ld_begin_date = date(string(ls_begin_date,'@@@@/@@/@@'))
ld_end_date = date(string(ls_end_date,'@@@@/@@/@@'))



ll_row = dw_print.retrieve( ld_begin_date, ld_end_date)



IF ll_row = 0 THEN 
	messagebox("알림",'조회된 내용이 없습니다')
//	wf_setMenu('P',FALSE)
ELSE
	messagebox("알림",string(ll_row) + '건의 데이타가 조회되었습니다')
//	wf_setMenu('P',TRUE)
END IF
return 1
end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 지적현황
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//wf_setMenu('R',TRUE)

idw_print = dw_print
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "지적현황")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hss404p
end type

type ln_tempright from w_msheet`ln_tempright within w_hss404p
end type

type ln_temptop from w_msheet`ln_temptop within w_hss404p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hss404p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hss404p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hss404p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hss404p
end type

type uc_insert from w_msheet`uc_insert within w_hss404p
end type

type uc_delete from w_msheet`uc_delete within w_hss404p
end type

type uc_save from w_msheet`uc_save within w_hss404p
end type

type uc_excel from w_msheet`uc_excel within w_hss404p
end type

type uc_print from w_msheet`uc_print within w_hss404p
end type

type st_line1 from w_msheet`st_line1 within w_hss404p
end type

type st_line2 from w_msheet`st_line2 within w_hss404p
end type

type st_line3 from w_msheet`st_line3 within w_hss404p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hss404p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hss404p
end type

type dw_print from cuo_dwprint within w_hss404p
integer x = 50
integer y = 164
integer width = 4384
integer height = 2136
integer taborder = 11
string title = "지적현황"
string dataobject = "d_hss404p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type st_3 from statictext within w_hss404p
boolean visible = false
integer x = 3995
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

