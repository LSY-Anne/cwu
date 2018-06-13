$PBExportHeader$w_sch408p.srw
$PBExportComments$벌점통계표
forward
global type w_sch408p from w_window
end type
type dw_con from uo_dwfree within w_sch408p
end type
type dw_main from datawindow within w_sch408p
end type
end forward

global type w_sch408p from w_window
dw_con dw_con
dw_main dw_main
end type
global w_sch408p w_sch408p

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)

Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
func.of_dddw( dw_con,lvc_data)

dw_con.object.std_year[dw_con.getrow()] = func.of_get_sdate('yyyy')

dw_main.Modify("DataWindow.Print.Preview=Yes")

ib_retrieve_wait = True

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

on w_sch408p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_sch408p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

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

type ln_templeft from w_window`ln_templeft within w_sch408p
end type

type ln_tempright from w_window`ln_tempright within w_sch408p
end type

type ln_temptop from w_window`ln_temptop within w_sch408p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch408p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch408p
end type

type ln_tempstart from w_window`ln_tempstart within w_sch408p
end type

type uc_retrieve from w_window`uc_retrieve within w_sch408p
end type

type uc_insert from w_window`uc_insert within w_sch408p
end type

type uc_delete from w_window`uc_delete within w_sch408p
end type

type uc_save from w_window`uc_save within w_sch408p
end type

type uc_excel from w_window`uc_excel within w_sch408p
end type

type uc_print from w_window`uc_print within w_sch408p
end type

type st_line1 from w_window`st_line1 within w_sch408p
end type

type st_line2 from w_window`st_line2 within w_sch408p
end type

type st_line3 from w_window`st_line3 within w_sch408p
end type

type uc_excelroad from w_window`uc_excelroad within w_sch408p
end type

type dw_con from uo_dwfree within w_sch408p
integer x = 50
integer y = 176
integer width = 4379
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch401p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from datawindow within w_sch408p
event type long ue_retrieve ( )
integer x = 50
integer y = 368
integer width = 4379
integer height = 1884
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_sch408p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();Long		ll_rv
string     ls_house_gb, ls_std_year

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_house_gb = dw_con.object.house_gb[dw_con.GetRow()]
ls_std_year = dw_con.object.std_year[dw_con.GetRow()]

IF isnull(ls_house_gb) OR ls_house_gb = '' THEN
	messagebox("조회", ' 기숙사구분을 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

IF isnull(ls_std_year) OR ls_std_year = '' THEN
	messagebox("조회", '학년도를 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

ll_rv = THIS.Retrieve(ls_house_gb, ls_std_year)

RETURN ll_rv

end event

event constructor;this.SetTransObject(Sqlca)
end event

