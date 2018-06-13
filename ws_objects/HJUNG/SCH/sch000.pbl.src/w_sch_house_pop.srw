$PBExportHeader$w_sch_house_pop.srw
$PBExportComments$기숙사호실검색 POP
forward
global type w_sch_house_pop from w_popup
end type
type dw_main from uo_grid within w_sch_house_pop
end type
type dw_con from uo_dw within w_sch_house_pop
end type
end forward

global type w_sch_house_pop from w_popup
string title = "기숙사생조회"
event ue_cancel ( )
event ue_ok ( )
dw_main dw_main
dw_con dw_con
end type
global w_sch_house_pop w_sch_house_pop

event ue_cancel();CloseWithReturn(This, ivc)

end event

event ue_ok;Long		ll_row

ll_row = dw_main.GetRow()

ivc.Removeall()

ivc.setProperty("house_cd", func.of_nvl(dw_main.Object.house_cd[ll_row], ''))
ivc.setProperty("house_nm", func.of_nvl(dw_main.Object.house_nm[ll_row], ''))
ivc.setProperty("room_cd", func.of_nvl(dw_main.Object.room_cd[ll_row], ''))
ivc.setProperty("door_gb", func.of_nvl(dw_main.Object.door_gb[ll_row], ''))
ivc.setProperty("floor", func.of_nvl(String(dw_main.Object.floor[ll_row]), ''))
ivc.setProperty("door_ty", func.of_nvl(dw_main.Object.door_ty[ll_row], ''))
ivc.setProperty("avl_per", func.of_nvl(String(dw_main.Object.avl_per[ll_row]), ''))

ivc.setProperty("parm_cnt", "1")

CloseWithReturn(This, ivc)


end event

on w_sch_house_pop.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_sch_house_pop.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_postopen;call super::ue_postopen;func.of_design_dw( dw_con )
This.Event ue_resize_dw( r_backline1, dw_main )

dw_con.InsertRow(0)

// 공통코드 Setup
Vector lvc_data

lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
lvc_data.setProperty('column2', 'door_ty')  //지원실
lvc_data.setProperty('key2', 'SAZ36')

func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_main,lvc_data)

Post Event ue_inquiry()


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

type p_msg from w_popup`p_msg within w_sch_house_pop
end type

type st_msg from w_popup`st_msg within w_sch_house_pop
end type

type uc_printpreview from w_popup`uc_printpreview within w_sch_house_pop
end type

type uc_cancel from w_popup`uc_cancel within w_sch_house_pop
end type

type uc_ok from w_popup`uc_ok within w_sch_house_pop
end type

type uc_excelroad from w_popup`uc_excelroad within w_sch_house_pop
end type

type uc_excel from w_popup`uc_excel within w_sch_house_pop
end type

type uc_save from w_popup`uc_save within w_sch_house_pop
end type

type uc_delete from w_popup`uc_delete within w_sch_house_pop
end type

type uc_insert from w_popup`uc_insert within w_sch_house_pop
end type

type uc_retrieve from w_popup`uc_retrieve within w_sch_house_pop
end type

type ln_temptop from w_popup`ln_temptop within w_sch_house_pop
end type

type ln_1 from w_popup`ln_1 within w_sch_house_pop
end type

type ln_2 from w_popup`ln_2 within w_sch_house_pop
end type

type ln_3 from w_popup`ln_3 within w_sch_house_pop
end type

type r_backline1 from w_popup`r_backline1 within w_sch_house_pop
end type

type r_backline2 from w_popup`r_backline2 within w_sch_house_pop
end type

type r_backline3 from w_popup`r_backline3 within w_sch_house_pop
end type

type uc_print from w_popup`uc_print within w_sch_house_pop
end type

type dw_main from uo_grid within w_sch_house_pop
event type long ue_retrieve ( )
integer x = 50
integer y = 176
integer width = 3483
integer height = 1244
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sch_house_pop"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();Long		ll_rv

ll_rv = THIS.Retrieve()

RETURN ll_rv

end event

event doubleclicked;call super::doubleclicked;If row <= 0 Then RETURN -1

Parent.PostEvent ("ue_ok")

end event

type dw_con from uo_dw within w_sch_house_pop
boolean visible = false
integer x = 50
integer y = 180
integer width = 3483
integer height = 140
integer taborder = 10
string dataobject = "d_sch_student_pop_1"
boolean border = false
end type

