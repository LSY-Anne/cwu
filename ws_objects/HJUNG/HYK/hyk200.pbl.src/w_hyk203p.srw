$PBExportHeader$w_hyk203p.srw
$PBExportComments$[w_print] 재임용 대상자 명단
forward
global type w_hyk203p from w_window
end type
type dw_con from uo_dwfree within w_hyk203p
end type
type dw_main from datawindow within w_hyk203p
end type
end forward

global type w_hyk203p from w_window
dw_con dw_con
dw_main dw_main
end type
global w_hyk203p w_hyk203p

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)
dw_main.Modify("DataWindow.Print.Preview=Yes")

ib_retrieve_wait = True

idw_print = dw_main
idw_Toexcel[1]	= dw_main

dw_con.object.evl_ym[dw_con.getrow()] = func.of_get_sdate('yyyymm')
end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = This.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)

If ib_retrieve_wait Then
	gf_openwait()
End If

ll_rv = dw_main.Event ue_Retrieve()

If ll_rv > 0 Then
	f_set_message("[조회] " + String(ll_rv) + '건의 자료가 조회되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	f_set_message("[조회] " + '자료가 없습니다.', '', parentwin)
Else
	f_set_message("[조회] " + '오류가 발생했습니다.', '', parentwin)
End If

If ib_retrieve_wait Then
	gf_closewait()
End If

SetPointer(Arrow!)
ib_excl_yn = FALSE

RETURN ll_rv

end event

on w_hyk203p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hyk203p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_printstart;call super::ue_printstart; //출력물 설정
avc_data.SetProperty('title', "재임용 대상자 명단")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_window`ln_templeft within w_hyk203p
end type

type ln_tempright from w_window`ln_tempright within w_hyk203p
end type

type ln_temptop from w_window`ln_temptop within w_hyk203p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyk203p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyk203p
end type

type ln_tempstart from w_window`ln_tempstart within w_hyk203p
end type

type uc_retrieve from w_window`uc_retrieve within w_hyk203p
end type

type uc_insert from w_window`uc_insert within w_hyk203p
end type

type uc_delete from w_window`uc_delete within w_hyk203p
end type

type uc_save from w_window`uc_save within w_hyk203p
end type

type uc_excel from w_window`uc_excel within w_hyk203p
end type

type uc_print from w_window`uc_print within w_hyk203p
end type

type st_line1 from w_window`st_line1 within w_hyk203p
end type

type st_line2 from w_window`st_line2 within w_hyk203p
end type

type st_line3 from w_window`st_line3 within w_hyk203p
end type

type uc_excelroad from w_window`uc_excelroad within w_hyk203p
end type

type dw_con from uo_dwfree within w_hyk203p
integer x = 50
integer y = 176
integer width = 4379
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyk202p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from datawindow within w_hyk203p
event type long ue_retrieve ( )
integer x = 50
integer y = 368
integer width = 4379
integer height = 1884
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hyk203p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();Long ll_rv
String ls_ym

dw_con.accepttext()

ls_ym= dw_con.object.evl_ym[1]

If ls_ym = '' or isnull(ls_ym) Then
	Messagebox("알림", "승진년월을 입력하세요!")
	RETURN -1
End If

ll_rv = This.retrieve(ls_ym)

RETURN ll_rv
end event

event constructor;this.SetTransObject(Sqlca)
end event

