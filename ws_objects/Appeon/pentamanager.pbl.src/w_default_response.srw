$PBExportHeader$w_default_response.srw
$PBExportComments$기본 윈도우 Response
forward
global type w_default_response from w_ancresponse
end type
type st_1 from statictext within w_default_response
end type
type uc_insert from u_picture within w_default_response
end type
type uc_cancel from u_picture within w_default_response
end type
type uc_close from u_picture within w_default_response
end type
type uc_delete from u_picture within w_default_response
end type
type uc_excel from u_picture within w_default_response
end type
type uc_ok from u_picture within w_default_response
end type
type uc_print from u_picture within w_default_response
end type
type uc_run from u_picture within w_default_response
end type
type uc_save from u_picture within w_default_response
end type
type uc_retrieve from u_picture within w_default_response
end type
type dw_multi from uo_dwlv within w_default_response
end type
type ln_templeft from line within w_default_response
end type
type ln_tempright from line within w_default_response
end type
type ln_tempstart from line within w_default_response
end type
type ln_4 from line within w_default_response
end type
type ln_temptop from line within w_default_response
end type
type ln_tempbutton from line within w_default_response
end type
end forward

global type w_default_response from w_ancresponse
integer width = 3918
integer height = 1668
string title = "BASE Screen  2 -> Response"
string icon = "..\img\icon\windowIcon1.ico"
event ue_save pbm_custom01
event ue_new pbm_custom02
event ue_retrieve pbm_custom03
event ue_delete pbm_custom04
event ue_cancel pbm_custom05
event ue_modify pbm_custom06
event ue_close pbm_custom07
event ue_print pbm_custom08
event ue_first pbm_custom09
event ue_prior pbm_custom10
event ue_next pbm_custom11
event ue_last pbm_custom12
event ue_postevent pbm_custom13
st_1 st_1
uc_insert uc_insert
uc_cancel uc_cancel
uc_close uc_close
uc_delete uc_delete
uc_excel uc_excel
uc_ok uc_ok
uc_print uc_print
uc_run uc_run
uc_save uc_save
uc_retrieve uc_retrieve
dw_multi dw_multi
ln_templeft ln_templeft
ln_tempright ln_tempright
ln_tempstart ln_tempstart
ln_4 ln_4
ln_temptop ln_temptop
ln_tempbutton ln_tempbutton
end type
global w_default_response w_default_response

type prototypes

end prototypes

type variables
//
// Error 관련
long			ilErrorRow	= 0
int				iiErrorCode	= 0
string       is_sort, is_sort_order
end variables

event ue_first;dw_multi.ScrollToRow(1)
end event

event ue_prior;dw_multi.ScrollPriorPage()
end event

event ue_next;dw_multi.ScrollNextPage()
end event

event ue_last;dw_multi.ScrollToRow(dw_multi.RowCount())
end event

on w_default_response.create
int iCurrent
call super::create
this.st_1=create st_1
this.uc_insert=create uc_insert
this.uc_cancel=create uc_cancel
this.uc_close=create uc_close
this.uc_delete=create uc_delete
this.uc_excel=create uc_excel
this.uc_ok=create uc_ok
this.uc_print=create uc_print
this.uc_run=create uc_run
this.uc_save=create uc_save
this.uc_retrieve=create uc_retrieve
this.dw_multi=create dw_multi
this.ln_templeft=create ln_templeft
this.ln_tempright=create ln_tempright
this.ln_tempstart=create ln_tempstart
this.ln_4=create ln_4
this.ln_temptop=create ln_temptop
this.ln_tempbutton=create ln_tempbutton
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uc_insert
this.Control[iCurrent+3]=this.uc_cancel
this.Control[iCurrent+4]=this.uc_close
this.Control[iCurrent+5]=this.uc_delete
this.Control[iCurrent+6]=this.uc_excel
this.Control[iCurrent+7]=this.uc_ok
this.Control[iCurrent+8]=this.uc_print
this.Control[iCurrent+9]=this.uc_run
this.Control[iCurrent+10]=this.uc_save
this.Control[iCurrent+11]=this.uc_retrieve
this.Control[iCurrent+12]=this.dw_multi
this.Control[iCurrent+13]=this.ln_templeft
this.Control[iCurrent+14]=this.ln_tempright
this.Control[iCurrent+15]=this.ln_tempstart
this.Control[iCurrent+16]=this.ln_4
this.Control[iCurrent+17]=this.ln_temptop
this.Control[iCurrent+18]=this.ln_tempbutton
end on

on w_default_response.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uc_insert)
destroy(this.uc_cancel)
destroy(this.uc_close)
destroy(this.uc_delete)
destroy(this.uc_excel)
destroy(this.uc_ok)
destroy(this.uc_print)
destroy(this.uc_run)
destroy(this.uc_save)
destroy(this.uc_retrieve)
destroy(this.dw_multi)
destroy(this.ln_templeft)
destroy(this.ln_tempright)
destroy(this.ln_tempstart)
destroy(this.ln_4)
destroy(this.ln_temptop)
destroy(this.ln_tempbutton)
end on

type st_1 from statictext within w_default_response
boolean visible = false
integer x = 27
integer y = 200
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type uc_insert from u_picture within w_default_response
integer x = 2464
integer y = 36
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_add.gif"
end type

type uc_cancel from u_picture within w_default_response
integer x = 2016
integer y = 36
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_cancel.gif"
end type

type uc_close from u_picture within w_default_response
integer x = 3593
integer y = 36
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_close.gif"
end type

type uc_delete from u_picture within w_default_response
integer x = 2688
integer y = 36
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_delete.gif"
end type

type uc_excel from u_picture within w_default_response
integer x = 3145
integer y = 36
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_excel.gif"
end type

type uc_ok from u_picture within w_default_response
integer x = 1792
integer y = 36
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_ok.gif"
end type

type uc_print from u_picture within w_default_response
integer x = 2912
integer y = 36
integer width = 215
integer height = 72
string picturename = "..\img\button\topBtn_print01.gif"
end type

type uc_run from u_picture within w_default_response
integer x = 1568
integer y = 36
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_execu.gif"
end type

type uc_save from u_picture within w_default_response
integer x = 3369
integer y = 36
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_save.gif"
end type

type uc_retrieve from u_picture within w_default_response
integer x = 2240
integer y = 36
integer width = 274
integer height = 84
string picturename = "..\img\button\topBtn_retrieve.gif"
end type

type dw_multi from uo_dwlv within w_default_response
event ue_enter pbm_dwnprocessenter
integer x = 46
integer y = 160
integer width = 3822
integer height = 1392
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_enter;If This.AcceptText() < 0 Then
  Return 1
End If

//If this.GetColumnName() = gsLastCol Then
  If This.GetRow() = This.RowCount() Then
		This.InsertRow(0)
		This.ScrollToRow(This.RowCount())
		This.SetRow(This.RowCount())
		This.SetColumn(1)
		This.SetFocus()	
     	Return 1
  End If
//End If

Send(Handle(this),256,9,Long(0,0))

return 1
end event

event dberror;choose case sqldbcode
	case	1		// Duplicate Error
		MessageBox("데이타베이스 오류", String(sqldbcode) + " - 번째 ROW에 중복된 자료가 있습니다.", StopSign!)

	case	1400	// Mandantory Error
		MessageBox("데이타베이스 오류", String(sqldbcode) + " - 번째 ROW에 입력되지 않은 자료가 있습니다.", StopSign!)

	case	2291	// Parent Record Not Found
		MessageBox("데이타베이스 오류", String(sqldbcode) + " - 번째 ROW에 Constraint 상 상위 자료가 없습니다.", StopSign!)

	case	2292	// Child Record Found
		MessageBox("데이타베이스 오류","삭제된 ROW 중" + String(sqldbcode) + " - 번째 ROW에 Constraint 상 하위 자료가 있습니다.", StopSign!)

	case else
		if (ilErrorRow <> 0) then 
			MessageBox("데이타베이스 오류", String(sqldbcode) + " - 번째 ROW에 다음과 같은 Error가 발생했습니다~r~n" + &
						sqlerrtext, StopSign!)
		else
			MessageBox("데이타베이스 오류", "다음과 같은 Error가 발생했습니다~r~n" + &
						sqlerrtext, StopSign!)
		end if
end choose


return 1
end event

event sqlpreview;//
//dwBuffer	BufferType
//
//ilErrorRow = 0
//this.GetUpdateStatus(ilErrorRow, BufferType)
//
end event

type ln_templeft from line within w_default_response
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginx = 46
integer beginy = 24
integer endx = 46
integer endy = 2272
end type

type ln_tempright from line within w_default_response
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginx = 3863
integer beginy = 24
integer endx = 3863
integer endy = 2272
end type

type ln_tempstart from line within w_default_response
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 160
integer endx = 3863
integer endy = 160
end type

type ln_4 from line within w_default_response
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 1548
integer endx = 4471
integer endy = 1548
end type

type ln_temptop from line within w_default_response
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 36
integer endx = 3863
integer endy = 36
end type

type ln_tempbutton from line within w_default_response
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 120
integer endx = 3863
integer endy = 120
end type

