$PBExportHeader$w_sch_student_pop.srw
$PBExportComments$기숙사생 조회 popup
forward
global type w_sch_student_pop from w_popup
end type
type dw_main from uo_grid within w_sch_student_pop
end type
type dw_con from uo_dw within w_sch_student_pop
end type
end forward

global type w_sch_student_pop from w_popup
string title = "기숙사생조회"
event ue_cancel ( )
event ue_ok ( )
dw_main dw_main
dw_con dw_con
end type
global w_sch_student_pop w_sch_student_pop

event ue_cancel();CloseWithReturn(This, ivc)

end event

event ue_ok;Long		ll_row

ll_row = dw_main.GetRow()

ivc.Removeall()

ivc.setProperty("hakbun", func.of_nvl(dw_main.Object.hakbun[ll_row], ''))
ivc.setProperty("hname", func.of_nvl(dw_main.Object.hname[ll_row], ''))
ivc.setProperty("sex", func.of_nvl(dw_main.Object.sex[ll_row], ''))
ivc.setProperty("gwa", func.of_nvl(dw_main.Object.gwa[ll_row], ''))
ivc.setProperty("fname", func.of_nvl(dw_main.Object.fname[ll_row], ''))
ivc.setProperty("hakyun", func.of_nvl(dw_main.Object.hakyun[ll_row], ''))
ivc.setProperty("jumin_no", func.of_nvl(dw_main.Object.jumin_no[ll_row], ''))
ivc.setProperty("cell_no", func.of_nvl(dw_main.Object.cell_no[ll_row], ''))

ivc.setProperty("parm_cnt", "1")

CloseWithReturn(This, ivc)


end event

on w_sch_student_pop.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_sch_student_pop.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_postopen;call super::ue_postopen;Vector			vc

vc = Create Vector

func.of_design_dw( dw_con )
This.Event ue_resize_dw( r_backline1, dw_main )

dw_con.InsertRow(0)

// 공통코드 Setup
Vector lvc_data

lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')

func.of_dddw( dw_con,lvc_data)

vc = Message.PowerObjectParm

If IsValid(vc) Then
	If Long(vc.GetProperty("parm_cnt")) > 0 Then
		dw_con.Object.house_gb[dw_con.GetRow()]	= vc.GetProperty("house_gb")
		If vc.GetProperty("std_year") = '1900' Then
			dw_con.Object.std_year[dw_con.GetRow()] = '전체'
		Else
			dw_con.Object.std_year[dw_con.GetRow()]	= vc.GetProperty("std_year")
		End If
		dw_con.Object.hakbun[dw_con.GetRow()]	= vc.GetProperty("hakbun")
		dw_con.Object.hname[dw_con.GetRow()]	= vc.GetProperty("hname")
		Post Event ue_inquiry()
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

type p_msg from w_popup`p_msg within w_sch_student_pop
end type

type st_msg from w_popup`st_msg within w_sch_student_pop
end type

type uc_printpreview from w_popup`uc_printpreview within w_sch_student_pop
end type

type uc_cancel from w_popup`uc_cancel within w_sch_student_pop
end type

type uc_ok from w_popup`uc_ok within w_sch_student_pop
end type

type uc_excelroad from w_popup`uc_excelroad within w_sch_student_pop
end type

type uc_excel from w_popup`uc_excel within w_sch_student_pop
end type

type uc_save from w_popup`uc_save within w_sch_student_pop
end type

type uc_delete from w_popup`uc_delete within w_sch_student_pop
end type

type uc_insert from w_popup`uc_insert within w_sch_student_pop
end type

type uc_retrieve from w_popup`uc_retrieve within w_sch_student_pop
end type

type ln_temptop from w_popup`ln_temptop within w_sch_student_pop
end type

type ln_1 from w_popup`ln_1 within w_sch_student_pop
end type

type ln_2 from w_popup`ln_2 within w_sch_student_pop
end type

type ln_3 from w_popup`ln_3 within w_sch_student_pop
end type

type r_backline1 from w_popup`r_backline1 within w_sch_student_pop
end type

type r_backline2 from w_popup`r_backline2 within w_sch_student_pop
end type

type r_backline3 from w_popup`r_backline3 within w_sch_student_pop
end type

type uc_print from w_popup`uc_print within w_sch_student_pop
end type

type dw_main from uo_grid within w_sch_student_pop
event type long ue_retrieve ( )
integer x = 50
integer y = 344
integer width = 3483
integer height = 1076
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sch_student_pop_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_house_gb, ls_std_year, ls_hakbun, ls_hname, ls_cell_no
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	Return -1
End If

ls_house_gb	= dw_con.object.house_gb[dw_con.GetRow()]
ls_std_year	= dw_con.object.std_year[dw_con.GetRow()]
ls_hakbun	= dw_con.object.hakbun[dw_con.GetRow()]
ls_hname	= dw_con.object.hname[dw_con.GetRow()]
ls_cell_no	= dw_con.object.cell_no[dw_con.GetRow()]

If ls_std_year = '전체' Then ls_std_year = '%'
If ls_hakbun = '' Or IsNull(ls_hakbun) Then
	ls_hakbun = '%'
End If
If ls_hname = '' Or IsNull(ls_hname) Then
	ls_hname = '%'
End If
If ls_cell_no = '' Or IsNull(ls_cell_no) Then
	ls_cell_no = '%'
End If

ll_rv = THIS.Retrieve(ls_house_gb, ls_std_year, ls_hakbun, ls_hname, ls_cell_no)

RETURN ll_rv

end event

event doubleclicked;call super::doubleclicked;If row <= 0 Then RETURN -1

Parent.PostEvent ("ue_ok")

end event

type dw_con from uo_dw within w_sch_student_pop
integer x = 50
integer y = 180
integer width = 3483
integer height = 140
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch_student_pop_1"
boolean border = false
end type

