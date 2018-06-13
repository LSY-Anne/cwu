$PBExportHeader$w_hpa550p.srw
$PBExportComments$[청운대]교수별 주소록 현황
forward
global type w_hpa550p from w_condition_window
end type
type dw_1 from uo_search_dwc within w_hpa550p
end type
type st_1 from statictext within w_hpa550p
end type
type ddlb_1 from dropdownlistbox within w_hpa550p
end type
type st_3 from statictext within w_hpa550p
end type
end forward

global type w_hpa550p from w_condition_window
dw_1 dw_1
st_1 st_1
ddlb_1 ddlb_1
st_3 st_3
end type
global w_hpa550p w_hpa550p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hpa550p.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_1
this.Control[iCurrent+4]=this.st_3
end on

on w_hpa550p.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.st_3)
end on

event open;call super::open;//wf_setmenu('RETRIEVE', 	TRUE)
//wf_setmenu('INSERT', 	FALSE)
//wf_setmenu('DELETE', 	FALSE)
//wf_setmenu('SAVE', 		FALSE)
//wf_setmenu('PRINT', 		TRUE)
//
end event

event ue_retrieve;call super::ue_retrieve;int		li_row
string 	ls_gubun

ls_gubun = Mid(ddlb_1.text, 1, 1)
IF ls_gubun = 'A' OR ls_gubun = 'B' OR ls_gubun = 'C' OR ls_gubun = 'D' THEN
ELSE
	setnull(ls_gubun)
END IF

li_row = dw_1.retrieve(ls_gubun)

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_1.setfocus()

return 1
end event

event ue_postopen;call super::ue_postopen;idw_print = dw_1
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

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hpa550p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hpa550p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hpa550p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hpa550p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hpa550p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hpa550p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hpa550p
end type

type uc_insert from w_condition_window`uc_insert within w_hpa550p
end type

type uc_delete from w_condition_window`uc_delete within w_hpa550p
end type

type uc_save from w_condition_window`uc_save within w_hpa550p
end type

type uc_excel from w_condition_window`uc_excel within w_hpa550p
end type

type uc_print from w_condition_window`uc_print within w_hpa550p
end type

type st_line1 from w_condition_window`st_line1 within w_hpa550p
end type

type st_line2 from w_condition_window`st_line2 within w_hpa550p
end type

type st_line3 from w_condition_window`st_line3 within w_hpa550p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hpa550p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hpa550p
end type

type gb_1 from w_condition_window`gb_1 within w_hpa550p
end type

type gb_2 from w_condition_window`gb_2 within w_hpa550p
end type

type dw_1 from uo_search_dwc within w_hpa550p
integer x = 50
integer y = 308
integer width = 4393
integer height = 1996
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hpa550p_1"
end type

type st_1 from statictext within w_hpa550p
integer x = 50
integer y = 164
integer width = 4393
integer height = 124
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_hpa550p
integer x = 521
integer y = 180
integer width = 841
integer height = 452
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean allowedit = true
string item[] = {"A 전임교수","B 겸임교수","C 강의전담","D 외래교수"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_hpa550p
integer x = 219
integer y = 196
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "교수구분"
alignment alignment = center!
boolean focusrectangle = false
end type

