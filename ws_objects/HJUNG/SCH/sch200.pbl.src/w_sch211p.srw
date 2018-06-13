$PBExportHeader$w_sch211p.srw
$PBExportComments$[w_print]중도퇴사신청서출력
forward
global type w_sch211p from w_window
end type
type dw_con from uo_dwfree within w_sch211p
end type
type dw_main from datawindow within w_sch211p
end type
end forward

global type w_sch211p from w_window
dw_con dw_con
dw_main dw_main
end type
global w_sch211p w_sch211p

event ue_postopen;call super::ue_postopen;This.Event ue_resize_dw( st_line1, dw_main )

// 공통코드 Setup
Vector lvc_data

lvc_data = Create Vector
lvc_data.setProperty('column1', 'door_gb')  //실구분
lvc_data.setProperty('key1', 'SAZ27')
lvc_data.setProperty('column2', 'enter_term')  //입사기간
lvc_data.setProperty('key2', 'SAZ29')

func.of_dddw( dw_main,lvc_data)

dw_main.Modify("DataWindow.Print.Preview=Yes")

ib_retrieve_wait = True

idw_print = dw_main

gs_empcode = '20080101'
gs_empname = '강송이'
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
	f_set_message("[조회] " + '중도퇴사 신청서를 출력할 수 있는 사생이 아닙니다.', '', parentwin)
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

on w_sch211p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_sch211p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', "d_sch211p_1")
avc_data.SetProperty('datawindow', dw_main)

//label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

type ln_templeft from w_window`ln_templeft within w_sch211p
end type

type ln_tempright from w_window`ln_tempright within w_sch211p
end type

type ln_temptop from w_window`ln_temptop within w_sch211p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch211p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch211p
end type

type ln_tempstart from w_window`ln_tempstart within w_sch211p
end type

type uc_retrieve from w_window`uc_retrieve within w_sch211p
end type

type uc_insert from w_window`uc_insert within w_sch211p
end type

type uc_delete from w_window`uc_delete within w_sch211p
end type

type uc_save from w_window`uc_save within w_sch211p
end type

type uc_excel from w_window`uc_excel within w_sch211p
end type

type uc_print from w_window`uc_print within w_sch211p
end type

type st_line1 from w_window`st_line1 within w_sch211p
end type

type st_line2 from w_window`st_line2 within w_sch211p
end type

type st_line3 from w_window`st_line3 within w_sch211p
end type

type uc_excelroad from w_window`uc_excelroad within w_sch211p
end type

type dw_con from uo_dwfree within w_sch211p
boolean visible = false
integer x = 50
integer y = 176
integer width = 4379
integer height = 120
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from datawindow within w_sch211p
event type long ue_retrieve ( )
integer x = 50
integer y = 168
integer width = 4379
integer height = 2084
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_sch211p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();uo_hjfunc 	hjfunc
Vector		lvc_data
String			ls_data[], ls_name
Integer		li_rtn, i
Long			ll_rv

hjfunc		= Create uo_hjfunc
lvc_data = Create Vector

li_rtn = hjfunc.of_search_house(lvc_data)
If li_rtn = 1 Then
	ls_data[1]	= lvc_data.GetProperty('house_gb')
	ls_data[2]	= lvc_data.GetProperty('std_year')
	ls_data[3]	= lvc_data.GetProperty('allcate_no')
	ls_data[4]	= ''
	ls_data[5]	= lvc_data.GetProperty('house_req_no')
	ls_data[6]	= lvc_data.GetProperty('house_cd')
	ls_data[7]	= lvc_data.GetProperty('room_cd')
	ls_data[8]	= lvc_data.GetProperty('door_gb')
	ls_data[9]	= lvc_data.GetProperty('door_no')
	
//	If hjfunc.of_get_roomname(ls_data[1], ls_data[2], ls_data[6], ls_data[7], ls_data[8], ls_data[9], 4, ls_name)  < 0 Then
//		ll_rv = 0
//	Else
//		ll_rv = This.Retrieve(ls_data[1], ls_data[2], ls_data[5], ls_name)
//	End If
Else
	ll_rv = 0
End If

Destroy lvc_data

Return ll_rv
end event

event constructor;this.SetTransObject(Sqlca)
end event

