$PBExportHeader$w_hpa402a.srw
$PBExportComments$외래교수 라벨주소록
forward
global type w_hpa402a from w_condition_window
end type
type dw_1 from uo_search_dwc within w_hpa402a
end type
type dw_con from uo_dwfree within w_hpa402a
end type
end forward

global type w_hpa402a from w_condition_window
dw_1 dw_1
dw_con dw_con
end type
global w_hpa402a w_hpa402a

type variables
datawindowchild ldwc_hjmod
end variables

on w_hpa402a.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_con
end on

on w_hpa402a.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_con)
end on

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	FALSE)
//wf_setmenu('DELETE', 	FALSE)
//wf_setmenu('SAVE', 		FALSE)
//wf_setmenu('PRINT', 		TRUE)
//
end event

event ue_retrieve;int		li_row
string 	ls_year, ls_duty
dw_con.accepttext()

ls_year 	= dw_con.object.year[1]
ls_duty = dw_con.object.duty_code[1]
If ls_year = '' or isnull(ls_year) then
	Messagebox("알림", "정산년도를 입력하세요!")
	RETURN -1
End If

If ls_duty = '' or isnull(ls_duty) then
	Messagebox("알림", "직급명을 입력하세요!")
	RETURN -1
End If
	li_row = dw_1.retrieve(ls_year,ls_duty)	

IF li_row = 0 THEN 
	setmicrohelp('조회된 내용이 없습니다')
//	wf_setMenu('P',FALSE)
ELSE
	SetMicroHelp( '데이타가 조회되었습니다')
//	wf_setMenu('P',TRUE)
END IF
dw_1.setfocus()
return 1

end event

event ue_postopen;call super::ue_postopen;idw_print = dw_1
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "라벨출력")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

event ue_print;//
Datawindow 	ldw
Vector			lvc_print

lvc_print = Create Vector

If UpperBound(idw_toexcel) = 0 And idw_print = ldw Then
	MessageBox("알림", "출력할 자료가 없습니다.")
Else
	If This.Event ue_printStart(lvc_print) = -1 Then
		Return
	Else
		// 인쇄를 하기전에 해당 인쇄를 하고자 하는 사유를 확인한다.
		OpenWithParm(w_print_reason, gs_pgmid)
		If Message.Doubleparm < 0 Then
			Return
		Else
				OpenWithParm(w_print_preview, lvc_print)
		End If
	End If
End If


end event

type ln_templeft from w_condition_window`ln_templeft within w_hpa402a
end type

type ln_tempright from w_condition_window`ln_tempright within w_hpa402a
end type

type ln_temptop from w_condition_window`ln_temptop within w_hpa402a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hpa402a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hpa402a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hpa402a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hpa402a
end type

type uc_insert from w_condition_window`uc_insert within w_hpa402a
end type

type uc_delete from w_condition_window`uc_delete within w_hpa402a
end type

type uc_save from w_condition_window`uc_save within w_hpa402a
end type

type uc_excel from w_condition_window`uc_excel within w_hpa402a
end type

type uc_print from w_condition_window`uc_print within w_hpa402a
end type

type st_line1 from w_condition_window`st_line1 within w_hpa402a
end type

type st_line2 from w_condition_window`st_line2 within w_hpa402a
end type

type st_line3 from w_condition_window`st_line3 within w_hpa402a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hpa402a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hpa402a
end type

type gb_1 from w_condition_window`gb_1 within w_hpa402a
integer x = 55
integer y = 364
integer width = 4384
integer height = 176
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 16777215
end type

type gb_2 from w_condition_window`gb_2 within w_hpa402a
boolean visible = true
integer x = 50
integer y = 288
integer width = 4384
integer height = 2000
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 16777215
end type

type dw_1 from uo_search_dwc within w_hpa402a
integer x = 69
integer y = 340
integer width = 4347
integer height = 1920
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hpa402a_1_2009"
end type

type dw_con from uo_dwfree within w_hpa402a
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 10
string dataobject = "d_hpa402a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con( dw_con )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)

String ls_year
ls_year = left(f_today(), 4)
ls_year = STring(long(ls_year) - 1)
dw_con.object.year[1] = ls_year
end event

