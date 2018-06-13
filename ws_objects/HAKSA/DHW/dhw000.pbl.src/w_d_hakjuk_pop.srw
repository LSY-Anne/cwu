$PBExportHeader$w_d_hakjuk_pop.srw
$PBExportComments$[대학원] 학생조회 popup-신규
forward
global type w_d_hakjuk_pop from w_popup_inq
end type
type dw_main from uo_input_dwc within w_d_hakjuk_pop
end type
type dw_con from uo_dwfree within w_d_hakjuk_pop
end type
end forward

global type w_d_hakjuk_pop from w_popup_inq
integer width = 2587
string title = "[대학원]학생조회"
event type integer ue_ok ( )
event ue_cancel ( )
dw_main dw_main
dw_con dw_con
end type
global w_d_hakjuk_pop w_d_hakjuk_pop

event type integer ue_ok();Long		ll_row, ll_rowcnt

dw_main.accepttext()

ll_row     = dw_main.GetRow()
ll_rowcnt = dw_main.Rowcount()

If ll_row <= 0 Then RETURN -1 ;

ivc.Removeall()

ivc.setproperty("hakbun1" ,		func.of_nvl(dw_main.Object.hakbun[ll_row], ''))
ivc.setproperty("hname1" ,		func.of_nvl(dw_main.Object.hname[ll_row], ''))

ivc.setproperty("parm_cnt" , '1')

CloseWithReturn(This, ivc)

end event

event ue_cancel();CloseWithReturn(This, ivc)

end event

on w_d_hakjuk_pop.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_d_hakjuk_pop.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_postopen;call super::ue_postopen;Int          li_row
Vector	vc

vc = Create Vector

dw_con.SetTransObject(sqlca)
li_row= dw_con.insertrow(0)

vc = Message.powerobjectparm

If IsValid(vc) = True Then
	If Long(vc.GetProperty("parm_cnt")) > 0 Then
		dw_con.Object.hakbun[dw_con.GetRow()]	= vc.GetProperty("hakbun")
		dw_con.Object.hname[dw_con.GetRow()]	= vc.GetProperty("hname")
	End If
End If

Post Event ue_inquiry()

Destroy vc




end event

event ue_inquiry;call super::ue_inquiry;String		ls_hakbun, ls_hname
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_hakbun = func.of_nvl(dw_con.object.hakbun[dw_con.GetRow()], '%') + '%'
ls_hname = func.of_nvl(dw_con.object.hname[dw_con.GetRow()], '%') + '%'

ll_rv = dw_main.Retrieve( ls_hakbun, ls_hname)

If ll_rv > 0 Then
	st_msg.Text = "[조회] " + String(ll_rv) + '건의 자료가 조회되었습니다.'
ElseIf ll_rv = 0 Then
	st_msg.Text = "[조회] " + '자료가 없습니다.'
Else
	st_msg.Text = "[조회] " + '오류가 발생했습니다.'
End If

dw_con.SetFocus()
dw_con.SetColumn("hname")

RETURN 1

end event

event close;call super::close;CloseWithReturn(This, ivc)
end event

type p_msg from w_popup_inq`p_msg within w_d_hakjuk_pop
end type

type st_msg from w_popup_inq`st_msg within w_d_hakjuk_pop
integer width = 2386
end type

type uc_printpreview from w_popup_inq`uc_printpreview within w_d_hakjuk_pop
end type

type uc_cancel from w_popup_inq`uc_cancel within w_d_hakjuk_pop
end type

type uc_ok from w_popup_inq`uc_ok within w_d_hakjuk_pop
end type

type uc_excel from w_popup_inq`uc_excel within w_d_hakjuk_pop
end type

type uc_retrieve from w_popup_inq`uc_retrieve within w_d_hakjuk_pop
end type

type ln_temptop from w_popup_inq`ln_temptop within w_d_hakjuk_pop
integer endx = 2578
end type

type ln_1 from w_popup_inq`ln_1 within w_d_hakjuk_pop
integer endx = 2578
end type

type ln_2 from w_popup_inq`ln_2 within w_d_hakjuk_pop
end type

type ln_3 from w_popup_inq`ln_3 within w_d_hakjuk_pop
integer beginx = 2537
integer endx = 2537
end type

type r_backline1 from w_popup_inq`r_backline1 within w_d_hakjuk_pop
end type

type r_backline2 from w_popup_inq`r_backline2 within w_d_hakjuk_pop
end type

type r_backline3 from w_popup_inq`r_backline3 within w_d_hakjuk_pop
end type

type uc_print from w_popup_inq`uc_print within w_d_hakjuk_pop
end type

type dw_main from uo_input_dwc within w_d_hakjuk_pop
integer x = 59
integer y = 304
integer width = 2478
integer height = 1124
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_d_hakjuk_pop"
end type

event doubleclicked;call super::doubleclicked;If row <= 0 Then RETURN -1 ;

Parent.PostEvent ("ue_ok")

end event

type dw_con from uo_dwfree within w_d_hakjuk_pop
integer x = 55
integer y = 176
integer width = 2482
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_d_hakjuk_pop_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

