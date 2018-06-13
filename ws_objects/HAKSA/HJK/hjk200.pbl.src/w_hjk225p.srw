$PBExportHeader$w_hjk225p.srw
$PBExportComments$[청운대]학적변동명단
forward
global type w_hjk225p from w_window
end type
type dw_main from datawindow within w_hjk225p
end type
type dw_con from uo_dw within w_hjk225p
end type
end forward

global type w_hjk225p from w_window
dw_main dw_main
dw_con dw_con
end type
global w_hjk225p w_hjk225p

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )
dw_con.SetTransObject(sqlca)
dw_con.insertrow(0)

dw_con.Object.from_dt[1] = func.of_get_sdate('YYYYMMDD')
dw_con.Object.to_dt[1]     = func.of_get_sdate('YYYYMMDD')

idw_print = dw_main
end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

SetPointer(HourGlass!)

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

RETURN ll_rv

end event

on w_hjk225p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk225p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

Return 1
end event

type ln_templeft from w_window`ln_templeft within w_hjk225p
end type

type ln_tempright from w_window`ln_tempright within w_hjk225p
end type

type ln_temptop from w_window`ln_temptop within w_hjk225p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hjk225p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hjk225p
end type

type ln_tempstart from w_window`ln_tempstart within w_hjk225p
end type

type uc_retrieve from w_window`uc_retrieve within w_hjk225p
end type

type uc_insert from w_window`uc_insert within w_hjk225p
end type

type uc_delete from w_window`uc_delete within w_hjk225p
end type

type uc_save from w_window`uc_save within w_hjk225p
end type

type uc_excel from w_window`uc_excel within w_hjk225p
end type

type uc_print from w_window`uc_print within w_hjk225p
end type

type st_line1 from w_window`st_line1 within w_hjk225p
end type

type st_line2 from w_window`st_line2 within w_hjk225p
end type

type st_line3 from w_window`st_line3 within w_hjk225p
end type

type uc_excelroad from w_window`uc_excelroad within w_hjk225p
end type

type dw_main from datawindow within w_hjk225p
event type long ue_retrieve ( )
integer x = 50
integer y = 324
integer width = 4379
integer height = 1936
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hjk225p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();String		ls_fdt, ls_tdt, ls_hjmod_gb, ls_sign_status, ls_gwa
Long		ll_rv,   ll_row

dw_con.AcceptText()

ll_row = dw_con.Getrow()

ls_fdt = dw_con.Object.from_dt[ll_row]
ls_tdt = dw_con.Object.to_dt[ll_row]
ls_hjmod_gb   = func.of_nvl(dw_con.Object.hjmod_gb[ll_row], '%')
ls_sign_status = func.of_nvl(dw_con.Object.sign_gb[ll_row], '%')
ls_gwa           = func.of_nvl(dw_con.Object.gwa[ll_row], '%')

ll_rv = THIS.Retrieve(ls_fdt, ls_tdt, ls_hjmod_gb, ls_sign_status, ls_gwa)

dw_main.Object.t_cond1.text = func.of_nvl(dw_con.describe("Evaluate('lookupDisplay(gwa)',1)"), '전체')

RETURN ll_rv

end event

event constructor;this.SetTransObject(Sqlca)
end event

type dw_con from uo_dw within w_hjk225p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hjk225p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;String ls_from_dt, ls_to_dt

Choose Case dwo.name
	Case 'p_from_dt'
		ls_from_dt 	= String(This.Object.from_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'from_dt' , ls_from_dt)
		
		ls_from_dt 	= left(ls_from_dt, 4) + mid(ls_from_dt, 6, 2) + right(ls_from_dt, 2)
		This.SetItem(row, 'from_dt',  ls_from_dt)
		
	Case 'p_to_dt'
		ls_to_dt 	= String(This.Object.to_dt[row], '@@@@.@@.@@')
		
		gf_dwsetdate(This,'to_dt' , ls_to_dt)
		
		ls_to_dt 	= left(ls_to_dt, 4) + mid(ls_to_dt, 6, 2) + right(ls_to_dt, 2)
		This.SetItem(row, 'to_dt',  ls_to_dt)
End Choose
end event

