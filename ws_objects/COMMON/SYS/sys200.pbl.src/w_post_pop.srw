$PBExportHeader$w_post_pop.srw
$PBExportComments$우편번호 조회 popup
forward
global type w_post_pop from w_popup
end type
type dw_main from uo_grid within w_post_pop
end type
type dw_con from uo_dw within w_post_pop
end type
end forward

global type w_post_pop from w_popup
string title = "우편번호"
event ue_cancel ( )
event ue_ok ( )
dw_main dw_main
dw_con dw_con
end type
global w_post_pop w_post_pop

event ue_cancel();CloseWithReturn(This, ivc)

end event

event ue_ok;Long		ll_row

ll_row = dw_main.GetRow()

ivc.Removeall()

ivc.setProperty("parm_str01", func.of_nvl(dw_main.Object.post_no[ll_row], ''))
ivc.setProperty("parm_str02", func.of_nvl(dw_main.Object.detail_address[ll_row], ''))
ivc.setProperty("parm_str03", func.of_nvl(dw_main.Object.sd_nm[ll_row], '') + ' ' + func.of_nvl(dw_main.Object.sgg_nm[ll_row], '') + ' ' + func.of_nvl(dw_main.Object.emd_nm[ll_row], '') )

ivc.setProperty("parm_cnt", "1")

CloseWithReturn(This, ivc)


end event

on w_post_pop.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_post_pop.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_postopen;call super::ue_postopen;Vector			vc

vc = Create Vector

func.of_design_dw( dw_con )
This.Event ue_resize_dw( r_backline1, dw_main )

dw_con.InsertRow(0)

vc = Message.PowerObjectParm

If IsValid(vc) Then
	If Long(vc.GetProperty("parm_cnt")) > 0 Then
		dw_con.Object.arg_str[dw_con.GetRow()]	= vc.GetProperty("parm_str01")
		If Trim(func.of_nvl(dw_con.Object.arg_str[dw_con.GetRow()], '')) <> '' Then
			Post Event ue_inquiry()
		End If
	End If
End If

Destroy vc

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

SetPointer(HourGlass!)
If ib_retrieve_wait Then
	gf_openwait()
End If
ll_rv = dw_main.Event ue_Retrieve()
If ll_rv > 0 Then
	st_msg.Text = "[조회] " + String(ll_rv) + '건의 자료가 조회되었습니다.'
ElseIf ll_rv = 0 Then
	st_msg.Text = "[조회] " + '자료가 없습니다.'
Else
	st_msg.Text = "[조회] " + '오류가 발생했습니다.'
End If
If ib_retrieve_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)
ib_excl_yn = FALSE

RETURN ll_rv

end event

event close;call super::close;CloseWithReturn(This, ivc)

end event

type p_msg from w_popup`p_msg within w_post_pop
end type

type st_msg from w_popup`st_msg within w_post_pop
end type

type uc_printpreview from w_popup`uc_printpreview within w_post_pop
end type

type uc_cancel from w_popup`uc_cancel within w_post_pop
end type

type uc_ok from w_popup`uc_ok within w_post_pop
end type

type uc_excelroad from w_popup`uc_excelroad within w_post_pop
end type

type uc_excel from w_popup`uc_excel within w_post_pop
end type

type uc_save from w_popup`uc_save within w_post_pop
end type

type uc_delete from w_popup`uc_delete within w_post_pop
end type

type uc_insert from w_popup`uc_insert within w_post_pop
end type

type uc_retrieve from w_popup`uc_retrieve within w_post_pop
end type

type ln_temptop from w_popup`ln_temptop within w_post_pop
end type

type ln_1 from w_popup`ln_1 within w_post_pop
end type

type ln_2 from w_popup`ln_2 within w_post_pop
end type

type ln_3 from w_popup`ln_3 within w_post_pop
end type

type r_backline1 from w_popup`r_backline1 within w_post_pop
end type

type r_backline2 from w_popup`r_backline2 within w_post_pop
end type

type r_backline3 from w_popup`r_backline3 within w_post_pop
end type

type uc_print from w_popup`uc_print within w_post_pop
end type

type dw_main from uo_grid within w_post_pop
event type long ue_retrieve ( )
integer x = 50
integer y = 344
integer width = 3483
integer height = 1076
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_post_pop_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_arg
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	Return -1
End If

ls_arg	= dw_con.object.arg_str[dw_con.GetRow()]
If IsNull(ls_arg) or Len(Trim(ls_arg)) = 0 Then
	gf_message(parentwin, 2, '9999', '알림', '데이터건수가 많기 때문에 조건을 입력하셔야만 합니다.')
	func.of_setfocus(dw_con, dw_con.GetRow(), 'arg_str')
	Return -1
End If

ls_arg = func.of_inq_str_set(ls_arg)

ll_rv = THIS.Retrieve(ls_arg)

RETURN ll_rv

end event

event doubleclicked;call super::doubleclicked;If row <= 0 Then RETURN -1

Parent.PostEvent ("ue_ok")

end event

type dw_con from uo_dw within w_post_pop
integer x = 50
integer y = 180
integer width = 3483
integer height = 140
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_post_pop_1"
boolean border = false
end type

