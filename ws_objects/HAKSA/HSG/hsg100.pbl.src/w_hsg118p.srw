$PBExportHeader$w_hsg118p.srw
$PBExportComments$[w_list] 집단프로그램 실시 현황(통계)
forward
global type w_hsg118p from w_window
end type
type dw_con from uo_dwfree within w_hsg118p
end type
type dw_main from datawindow within w_hsg118p
end type
end forward

global type w_hsg118p from w_window
dw_con dw_con
dw_main dw_main
end type
global w_hsg118p w_hsg118p

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)
dw_main.Modify("DataWindow.Print.Preview=Yes")

ib_retrieve_wait = True

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'hakgi')  //학기
lvc_data.setProperty('key1', 'HSG01')
lvc_data.setProperty('column2', 'pgm_tp')  //프로그램구분
lvc_data.setProperty('key2', 'SUM11')
func.of_dddw( dw_con,lvc_data)

String ls_year, ls_hakgi, ls_str, ls_end
uo_hsfunc hsfunc

hsfunc = Create uo_hsfunc
// 초기 Value Setup - 해당 상담관리에서 사용하는 최종 연도및학기를 확인한다.
hsfunc.of_get_yearhakgi('SUM', lvc_data)

ls_year = lvc_data.GetProperty('year')
ls_hakgi = lvc_data.GetProperty('hakgi')
ls_str = lvc_data.GetProperty('hakgi_str')
ls_end = lvc_data.GetProperty('hakgi_end')

If ls_year = '' Or IsNull(ls_year) Then
	dw_con.object.year[dw_con.getrow()] = func.of_get_sdate('yyyy')
	dw_con.object.fr_dt[dw_con.getrow()] = func.of_get_sdate('yyyymm') + '01'
	dw_con.object.to_dt[dw_con.getrow()] = func.of_get_sdate('yyyymmdd')
Else
	dw_con.object.year[dw_con.getrow()] = ls_year
	dw_con.Object.hakgi[dw_con.getrow()] = ls_hakgi
	dw_con.object.fr_dt[dw_con.getrow()] = ls_str
	dw_con.object.to_dt[dw_con.getrow()] = ls_end
End If

idw_print = dw_main
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

on w_hsg118p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_hsg118p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

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

type ln_templeft from w_window`ln_templeft within w_hsg118p
end type

type ln_tempright from w_window`ln_tempright within w_hsg118p
end type

type ln_temptop from w_window`ln_temptop within w_hsg118p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hsg118p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hsg118p
end type

type ln_tempstart from w_window`ln_tempstart within w_hsg118p
end type

type uc_retrieve from w_window`uc_retrieve within w_hsg118p
end type

type uc_insert from w_window`uc_insert within w_hsg118p
end type

type uc_delete from w_window`uc_delete within w_hsg118p
end type

type uc_save from w_window`uc_save within w_hsg118p
end type

type uc_excel from w_window`uc_excel within w_hsg118p
end type

type uc_print from w_window`uc_print within w_hsg118p
end type

type st_line1 from w_window`st_line1 within w_hsg118p
end type

type st_line2 from w_window`st_line2 within w_hsg118p
end type

type st_line3 from w_window`st_line3 within w_hsg118p
end type

type uc_excelroad from w_window`uc_excelroad within w_hsg118p
end type

type dw_con from uo_dwfree within w_hsg118p
integer x = 50
integer y = 176
integer width = 4379
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsg118P_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from datawindow within w_hsg118p
event type long ue_retrieve ( )
integer x = 41
integer y = 368
integer width = 4379
integer height = 1884
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hsg118p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();String		ls_year, ls_hakgi, ls_pgm_tp, ls_fr_dt, ls_to_dt
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_year = dw_con.object.year[dw_con.GetRow()]
ls_hakgi = dw_con.object.hakgi[dw_con.GetRow()]
ls_pgm_tp = dw_con.object.pgm_tp[dw_con.getrow()]
ls_fr_dt =  dw_con.object.fr_dt[dw_con.getrow()]
ls_to_dt =  dw_con.object.to_dt[dw_con.getrow()]

IF isnull(ls_year) OR ls_year = '' THEN
	messagebox("조회", '년도를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

IF isnull(ls_hakgi) OR ls_hakgi = '' THEN
	messagebox("조회", '학기를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

IF isnull(ls_pgm_tp) OR ls_pgm_tp = '' THEN
	messagebox("조회", '프로그램구분을 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

IF isnull(ls_fr_dt) OR ls_fr_dt = '' THEN
	messagebox("조회", '실시일자(fr)을 입력한 후  조회하시기 바랍니다.')
	return -1
END IF

IF isnull(ls_to_dt) OR ls_to_dt = '' THEN
	messagebox("조회", '실시일자(to)을 입력한 후  조회하시기 바랍니다.')
	return -1
END IF

IF ls_fr_dt > ls_to_dt THEN
	messagebox("조회", '실시일자 범위를 확인하세요.')
	return -1
END IF


ll_rv = THIS.Retrieve(ls_year, ls_hakgi, ls_pgm_tp, ls_fr_dt, ls_to_dt)

RETURN ll_rv

end event

event constructor;this.SetTransObject(Sqlca)
end event

