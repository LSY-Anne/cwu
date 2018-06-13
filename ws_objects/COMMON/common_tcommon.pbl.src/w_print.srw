$PBExportHeader$w_print.srw
$PBExportComments$View & Print Window
forward
global type w_print from w_window
end type
type dw_con from uo_dwfree within w_print
end type
type dw_main from datawindow within w_print
end type
end forward

global type w_print from w_window
dw_con dw_con
dw_main dw_main
end type
global w_print w_print

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.insertrow(0)
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

on w_print.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_print.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

type ln_templeft from w_window`ln_templeft within w_print
end type

type ln_tempright from w_window`ln_tempright within w_print
end type

type ln_temptop from w_window`ln_temptop within w_print
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_print
end type

type ln_tempbutton from w_window`ln_tempbutton within w_print
end type

type ln_tempstart from w_window`ln_tempstart within w_print
end type

type uc_retrieve from w_window`uc_retrieve within w_print
integer width = 274
end type

type uc_insert from w_window`uc_insert within w_print
integer width = 274
end type

type uc_delete from w_window`uc_delete within w_print
integer width = 274
end type

type uc_save from w_window`uc_save within w_print
integer width = 274
end type

type uc_excel from w_window`uc_excel within w_print
integer width = 274
end type

type uc_print from w_window`uc_print within w_print
integer width = 274
end type

type st_line1 from w_window`st_line1 within w_print
end type

type st_line2 from w_window`st_line2 within w_print
end type

type st_line3 from w_window`st_line3 within w_print
end type

type uc_excelroad from w_window`uc_excelroad within w_print
integer width = 393
end type

type dw_con from uo_dwfree within w_print
integer x = 50
integer y = 176
integer width = 4379
integer height = 120
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from datawindow within w_print
event type long ue_retrieve ( )
integer x = 50
integer y = 368
integer width = 4379
integer height = 1884
integer taborder = 50
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();Return 1
end event

event constructor;this.SetTransObject(Sqlca)
end event

