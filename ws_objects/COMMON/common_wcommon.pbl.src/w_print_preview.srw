$PBExportHeader$w_print_preview.srw
$PBExportComments$미리보기 윈도우
forward
global type w_print_preview from w_ancresponse
end type
type p_last from u_picture within w_print_preview
end type
type p_next from u_picture within w_print_preview
end type
type p_pre from u_picture within w_print_preview
end type
type p_first from u_picture within w_print_preview
end type
type st_currentpage2 from statictext within w_print_preview
end type
type st_lastpage2 from statictext within w_print_preview
end type
type st_copies from statictext within w_print_preview
end type
type sle_printer from statictext within w_print_preview
end type
type rb_even from radiobutton within w_print_preview
end type
type rb_current from radiobutton within w_print_preview
end type
type rb_odd from radiobutton within w_print_preview
end type
type rb_all from radiobutton within w_print_preview
end type
type sle_range from singlelineedit within w_print_preview
end type
type st_currentpage from statictext within w_print_preview
end type
type st_lastpage from statictext within w_print_preview
end type
type sle_copies from singlelineedit within w_print_preview
end type
type rb_landscape from radiobutton within w_print_preview
end type
type rb_potrait from radiobutton within w_print_preview
end type
type ddlb_scale from dropdownlistbox within w_print_preview
end type
type rb_printer from radiobutton within w_print_preview
end type
type rb_file from radiobutton within w_print_preview
end type
type ddlb_size from dropdownlistbox within w_print_preview
end type
type ddlb_zoom from dropdownlistbox within w_print_preview
end type
type pb_5 from picturebutton within w_print_preview
end type
type rb_excel from radiobutton within w_print_preview
end type
type uc_ok from u_picture within w_print_preview
end type
type uc_cancel from u_picture within w_print_preview
end type
type gb_6 from groupbox within w_print_preview
end type
type gb_5 from groupbox within w_print_preview
end type
type gb_4 from groupbox within w_print_preview
end type
type gb_3 from groupbox within w_print_preview
end type
type gb_1 from groupbox within w_print_preview
end type
type gb_2 from groupbox within w_print_preview
end type
type ln_temptop from line within w_print_preview
end type
type ln_1 from line within w_print_preview
end type
type ln_templeft from line within w_print_preview
end type
type ln_tempright from line within w_print_preview
end type
type dw_1 from u_dw within w_print_preview
end type
end forward

global type w_print_preview from w_ancresponse
integer width = 3479
integer height = 2260
string title = "인쇄 미리보기"
p_last p_last
p_next p_next
p_pre p_pre
p_first p_first
st_currentpage2 st_currentpage2
st_lastpage2 st_lastpage2
st_copies st_copies
sle_printer sle_printer
rb_even rb_even
rb_current rb_current
rb_odd rb_odd
rb_all rb_all
sle_range sle_range
st_currentpage st_currentpage
st_lastpage st_lastpage
sle_copies sle_copies
rb_landscape rb_landscape
rb_potrait rb_potrait
ddlb_scale ddlb_scale
rb_printer rb_printer
rb_file rb_file
ddlb_size ddlb_size
ddlb_zoom ddlb_zoom
pb_5 pb_5
rb_excel rb_excel
uc_ok uc_ok
uc_cancel uc_cancel
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_1 gb_1
gb_2 gb_2
ln_temptop ln_temptop
ln_1 ln_1
ln_templeft ln_templeft
ln_tempright ln_tempright
dw_1 dw_1
end type
global w_print_preview w_print_preview

on w_print_preview.create
int iCurrent
call super::create
this.p_last=create p_last
this.p_next=create p_next
this.p_pre=create p_pre
this.p_first=create p_first
this.st_currentpage2=create st_currentpage2
this.st_lastpage2=create st_lastpage2
this.st_copies=create st_copies
this.sle_printer=create sle_printer
this.rb_even=create rb_even
this.rb_current=create rb_current
this.rb_odd=create rb_odd
this.rb_all=create rb_all
this.sle_range=create sle_range
this.st_currentpage=create st_currentpage
this.st_lastpage=create st_lastpage
this.sle_copies=create sle_copies
this.rb_landscape=create rb_landscape
this.rb_potrait=create rb_potrait
this.ddlb_scale=create ddlb_scale
this.rb_printer=create rb_printer
this.rb_file=create rb_file
this.ddlb_size=create ddlb_size
this.ddlb_zoom=create ddlb_zoom
this.pb_5=create pb_5
this.rb_excel=create rb_excel
this.uc_ok=create uc_ok
this.uc_cancel=create uc_cancel
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.ln_temptop=create ln_temptop
this.ln_1=create ln_1
this.ln_templeft=create ln_templeft
this.ln_tempright=create ln_tempright
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_last
this.Control[iCurrent+2]=this.p_next
this.Control[iCurrent+3]=this.p_pre
this.Control[iCurrent+4]=this.p_first
this.Control[iCurrent+5]=this.st_currentpage2
this.Control[iCurrent+6]=this.st_lastpage2
this.Control[iCurrent+7]=this.st_copies
this.Control[iCurrent+8]=this.sle_printer
this.Control[iCurrent+9]=this.rb_even
this.Control[iCurrent+10]=this.rb_current
this.Control[iCurrent+11]=this.rb_odd
this.Control[iCurrent+12]=this.rb_all
this.Control[iCurrent+13]=this.sle_range
this.Control[iCurrent+14]=this.st_currentpage
this.Control[iCurrent+15]=this.st_lastpage
this.Control[iCurrent+16]=this.sle_copies
this.Control[iCurrent+17]=this.rb_landscape
this.Control[iCurrent+18]=this.rb_potrait
this.Control[iCurrent+19]=this.ddlb_scale
this.Control[iCurrent+20]=this.rb_printer
this.Control[iCurrent+21]=this.rb_file
this.Control[iCurrent+22]=this.ddlb_size
this.Control[iCurrent+23]=this.ddlb_zoom
this.Control[iCurrent+24]=this.pb_5
this.Control[iCurrent+25]=this.rb_excel
this.Control[iCurrent+26]=this.uc_ok
this.Control[iCurrent+27]=this.uc_cancel
this.Control[iCurrent+28]=this.gb_6
this.Control[iCurrent+29]=this.gb_5
this.Control[iCurrent+30]=this.gb_4
this.Control[iCurrent+31]=this.gb_3
this.Control[iCurrent+32]=this.gb_1
this.Control[iCurrent+33]=this.gb_2
this.Control[iCurrent+34]=this.ln_temptop
this.Control[iCurrent+35]=this.ln_1
this.Control[iCurrent+36]=this.ln_templeft
this.Control[iCurrent+37]=this.ln_tempright
this.Control[iCurrent+38]=this.dw_1
end on

on w_print_preview.destroy
call super::destroy
destroy(this.p_last)
destroy(this.p_next)
destroy(this.p_pre)
destroy(this.p_first)
destroy(this.st_currentpage2)
destroy(this.st_lastpage2)
destroy(this.st_copies)
destroy(this.sle_printer)
destroy(this.rb_even)
destroy(this.rb_current)
destroy(this.rb_odd)
destroy(this.rb_all)
destroy(this.sle_range)
destroy(this.st_currentpage)
destroy(this.st_lastpage)
destroy(this.sle_copies)
destroy(this.rb_landscape)
destroy(this.rb_potrait)
destroy(this.ddlb_scale)
destroy(this.rb_printer)
destroy(this.rb_file)
destroy(this.ddlb_size)
destroy(this.ddlb_zoom)
destroy(this.pb_5)
destroy(this.rb_excel)
destroy(this.uc_ok)
destroy(this.uc_cancel)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.ln_temptop)
destroy(this.ln_1)
destroy(this.ln_templeft)
destroy(this.ln_tempright)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;String					ls_Syntax, ls_col_Syntax, ls_zoom
String					ls_flag, ls_column
Blob					lb_data
Vector				lvc_print
DataWindow 		ldw_1
DataWindowChild 	ldw_dddw_from, ldw_dddw_to
Long					ll_column_pos = 0, ll_col_pos_tail, ll_pos, ll_name_to

lvc_print = Create Vector

This.Center = True

lvc_print = Message.PowerObjectParm
If Not IsValid(lvc_print) Then Return

String	ls_temp

ls_temp = lvc_print.GetProperty('datawindow', ldw_1)
dw_1.DataObject = ldw_1.DataObject

ldw_1.getFullState(lb_data)
dw_1.setfullstate(lb_data)

SetPointer(HourGlass!)

/***************************************************************************************
	child datawindow를 찿아서 share 시킨다.
***************************************************************************************/
ll_column_pos = pos(ls_Syntax,'column(',ll_column_pos + 1)
If isnull(ll_column_pos) Then ll_column_pos = 0

DO WHILE ll_column_pos > 0
	ll_col_pos_tail = pos(ls_Syntax,'column(',ll_column_pos + 1)
	If isnull(ll_col_pos_tail) Then ll_col_pos_tail = 0
	
	If ll_col_pos_tail < 1 Then
		ll_pos = pos(ls_Syntax,'dddw',ll_column_pos)
	Else
		ls_col_Syntax = mid(ls_Syntax,ll_column_pos,ll_col_pos_tail - ll_column_pos - 1)
		ll_pos = pos(ls_col_Syntax,'dddw',1)
	End If
	If isnull(ll_pos) Then ll_pos = 0
	
	If ll_pos > 0 Then
		ls_flag = 'Y'
		ll_name_to = pos(ls_Syntax, ' ', ll_column_pos)
		If isnull(ll_name_to) Then ll_name_to = 0
		If ll_name_to > 0 Then
			ls_column = mid(ls_Syntax, ll_column_pos + 12, ll_name_to - ll_column_pos - 12 )
		Else
			ls_flag = 'N'
		End If
	Else
		ls_flag = 'N'
	End If
	If ls_flag = 'Y' Then
		ldw_1.getchild(ls_column, ldw_dddw_from)
		dw_1.getchild(ls_column, ldw_dddw_to)
		ldw_dddw_from.sharedata(ldw_dddw_to)
	End If
	
	ll_column_pos = pos(ls_Syntax,'column(',ll_column_pos + 1)
LOOP

/***************************************************************************************
	가로 세로, preview 비율, preview 를 초기화
***************************************************************************************/
ls_zoom = lvc_print.GetProperty('zoom')
If ls_zoom <> '' Then
	ddlb_scale.text = ls_zoom + '%'
	dw_1.modify("DataWindow.Zoom=" + ls_zoom)
End If
dw_1.modify ('DataWindow.print.preview = Yes')
dw_1.modify ('Datawindow.print.preview.zoom = 100')
sle_printer.text = dw_1.Describe("DataWindow.Printer")

If dw_1.Describe ("datawindow.print.orientation") = '1' Then
	// 가로
	rb_landscape.checked = TRUE
	dw_1.modify("datawindow.print.orientation=1")
ElseIf dw_1.Describe ("datawindow.print.orientation") = '2' Then
	// 세로로
	rb_potrait.checked = TRUE
	dw_1.modify("datawindow.print.orientation=2")
Else
	//default (가로)
	rb_landscape.checked = TRUE
	dw_1.modify("datawindow.print.orientation=1")
End If

/***************************************************************************************
	datawindow share
***************************************************************************************/
st_lastpage.Text = dw_1.Describe("Evaluate('PageCount()', " + String(dw_1.RowCount()) + ")")
SetPointer (Arrow!)

end event

type p_last from u_picture within w_print_preview
integer x = 2679
integer y = 280
integer width = 133
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_next.gif"
end type

event clicked;call super::clicked;st_currentpage.Text = st_lastpage.Text

If rb_current.Checked Then
	sle_range.Text = st_currentpage.Text
End If

end event

type p_next from u_picture within w_print_preview
integer x = 2537
integer y = 280
integer width = 133
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_next.gif"
end type

event clicked;call super::clicked;Integer nPage

nPage = Integer(st_lastpage.Text)
If nPage > 1 Then
	If Integer(st_currentpage.Text) < Integer(st_lastpage.Text) Then
		nPage = Integer(st_currentpage.Text)
		dw_1.ScrollNextPage()
		
		nPage ++
		st_currentpage.Text = String(nPage)
		If rb_current.Checked Then
			sle_range.Text = st_currentpage.Text
		End If
	End If
END IF

end event

type p_pre from u_picture within w_print_preview
integer x = 2395
integer y = 280
integer width = 133
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_pre.gif"
end type

event clicked;call super::clicked;Integer nPage

nPage = Integer(st_currentpage.Text)
IF nPage > 1 THEN
	
	dw_1.ScrollPriorPage()

	nPage -- 	
	st_currentpage.Text = String(nPage)
	IF rb_current.Checked THEN
		sle_range.Text = st_currentpage.Text
	END IF
END IF

end event

type p_first from u_picture within w_print_preview
integer x = 2254
integer y = 280
integer width = 133
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_pre.gif"
end type

event clicked;call super::clicked;st_currentpage.Text = "1"
IF rb_current.Checked THEN
	sle_range.Text = st_currentpage.Text
END IF

end event

type st_currentpage2 from statictext within w_print_preview
integer x = 78
integer y = 120
integer width = 361
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "현재페이지"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_lastpage2 from statictext within w_print_preview
integer x = 78
integer y = 196
integer width = 361
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "전체페이지"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_copies from statictext within w_print_preview
integer x = 78
integer y = 272
integer width = 361
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = " 출력부수"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_printer from statictext within w_print_preview
integer x = 1275
integer y = 408
integer width = 2158
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type rb_even from radiobutton within w_print_preview
integer x = 1134
integer y = 204
integer width = 320
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "짝수 쪽"
end type

event clicked;sle_range.Enabled = FALSE
sle_range.Text = ""
dw_1.Modify("DataWindow.Print.Page.RangeInclude=1")
end event

type rb_current from radiobutton within w_print_preview
integer x = 759
integer y = 204
integer width = 320
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "현재 쪽"
end type

event clicked;sle_range.Enabled = FALSE
dw_1.Modify("DataWindow.Print.Page.RangeInclude=0")

end event

type rb_odd from radiobutton within w_print_preview
integer x = 1134
integer y = 128
integer width = 320
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "홀수 쪽"
end type

event clicked;sle_range.Text = ""
sle_range.Enabled = FALSE
dw_1.Modify("DataWindow.Print.Page.RangeInclude=2")
end event

type rb_all from radiobutton within w_print_preview
integer x = 759
integer y = 128
integer width = 320
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "전체 쪽"
boolean checked = true
end type

event clicked;sle_range.Enabled = TRUE
dw_1.Modify("DataWindow.Print.Page.RangeInclude=0")

end event

type sle_range from singlelineedit within w_print_preview
integer x = 768
integer y = 268
integer width = 663
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;This.Enabled = TRUE
end on

type st_currentpage from statictext within w_print_preview
integer x = 443
integer y = 120
integer width = 197
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31577551
boolean enabled = false
string text = "1"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_lastpage from statictext within w_print_preview
integer x = 443
integer y = 196
integer width = 197
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31577551
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type sle_copies from singlelineedit within w_print_preview
integer x = 443
integer y = 272
integer width = 197
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "1"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_landscape from radiobutton within w_print_preview
integer x = 1568
integer y = 144
integer width = 229
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "가로"
boolean checked = true
end type

event clicked;dw_1.modify("datawindow.print.orientation=1")

end event

type rb_potrait from radiobutton within w_print_preview
integer x = 1568
integer y = 256
integer width = 229
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "세로"
end type

event clicked;dw_1.modify(" datawindow.print.orientation=2")

end event

type ddlb_scale from dropdownlistbox within w_print_preview
integer x = 2386
integer y = 112
integer width = 288
integer height = 1536
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "100%"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"10%","20%","30%","40%","50%","60%","70%","80%","90%","100%","110%","120%","130%","140%","150%","160%","170%","180%","190%","200%","250%","300%"}
borderstyle borderstyle = stylelowered!
end type

event constructor;This.text = '100%'
end event

event modified;string	ls_syntax
integer	li_len

li_len	 = len(This.Text)
ls_syntax = mid(This.Text,1, li_len - 1)
ls_syntax = "DataWindow.Zoom=" + ls_syntax
dw_1.modify(ls_syntax)

end event

type rb_printer from radiobutton within w_print_preview
integer x = 1925
integer y = 120
integer width = 256
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "PRINT"
boolean checked = true
end type

type rb_file from radiobutton within w_print_preview
integer x = 1925
integer y = 280
integer width = 256
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "TEXT"
end type

type ddlb_size from dropdownlistbox within w_print_preview
integer x = 32
integer y = 396
integer width = 1097
integer height = 1768
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "현재프린터에 설정된 용지"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"현재프린터에 설정된 용지","Letter 8 1/2 x 11 in","LetterSmall 8 1/2 x 11in","Tabloid 17 x 11 inches","Ledger 17 x 11 in","Legal 8 1/2 x 14 in","Statement 5 1/2 x 8 1/2 in","Executive 7 1/4 x 10 1/2 in","A3 297 x 420 mm","A4 210 x 297 mm","A4 Small 210 x 297 mm","A5 148 x 210 mm","B4 250 x 354","B5 182 x 257 mm","Folio 8 1/2 x 13 in","Quarto 215 x 275 mm","10x14 in","11x17 in","Note 8 1/2 x 11 in","Envelope #9 3 7/8 x 8 7/8","Envelope #10 4 1/8 x 9 1/2","Envelope #11 4 1/2 x 10 3/8","Envelope #12  4 x 11 1/276","Envelope #14 5 x 11 1/2","C size sheet","D size sheet","E size sheet","Envelope DL 110 x 220mm","Envelope C5 162 x 229 mm","Envelope C3  324 x 458 mm","Envelope C4  229 x 324 mm","Envelope C6  114 x 162 mm","Envelope C65 114 x 229 mm","Envelope B4  250 x 353 mm","Envelope B5  176 x 250 mm","Envelope B6  176 x 125 mm","Envelope 110 x 230 mm","Envelope Monarch 3.875 x 7.5 in","6 3/4 Envelope 3 5/8 x 6 1/2 in","US Std Fanfold 14 7/8 x 11 in","German Std Fanfold 8 1/2 x 12 in","German Legal Fanfold 8 1/2 x 13 in"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Int nIndex
Boolean lb_rtn

nIndex = This.FindItem(This.Text, 1) - 1
dw_1.Object.DataWindow.Print.Paper.Size=String(nIndex)

end event

type ddlb_zoom from dropdownlistbox within w_print_preview
integer x = 2981
integer y = 112
integer width = 288
integer height = 696
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "100%"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"10%","25%","40%","50%","75%","100%","125%","150%","175%","200%"}
borderstyle borderstyle = stylelowered!
end type

event modified;string	ls_syntax
integer	li_len

li_len	 = len(This.Text)
ls_syntax = mid(This.Text,1, li_len - 1)
ls_syntax = "DataWindow.Print.Preview.Zoom=" + ls_syntax
dw_1.modify(ls_syntax)


end event

type pb_5 from picturebutton within w_print_preview
integer x = 1143
integer y = 396
integer width = 105
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean originalsize = true
string picturename = "print_i.bmp"
end type

event clicked;PrintSetup()
sle_printer.text = dw_1.Describe('datawindow.printer')

end event

type rb_excel from radiobutton within w_print_preview
integer x = 1925
integer y = 200
integer width = 256
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "EXCEL"
end type

type uc_ok from u_picture within w_print_preview
integer x = 2880
integer y = 280
integer width = 265
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_ok.gif"
end type

event clicked;call super::clicked;String 	ls_PathName, ls_KindOfFile, ls_syntax
String		ls_page

IF rb_printer.Checked THEN  													// 프린터로 출력시
	ls_syntax = "DataWindow.Print.Copies=" + sle_copies.Text
	IF rb_all.Checked THEN
		ls_syntax = ls_syntax + " DataWindow.Print.Page.Range=" + "'" + sle_range.Text + "'"
	ElseIf rb_current.Checked Then
//		ls_page = dw_1.Describe("Evaluate( 'Page()', " + String(dw_1.GetRow()) + ")")
		ls_page = Trim(st_currentpage.Text)
		dw_1.Modify("DataWindow.Print.Page.Range='" + ls_page + "'")
	END IF
	dw_1.modify(ls_syntax)														// 출력 부수
	dw_1.Print()
ELSEIF rb_excel.Checked THEN 													// EXCEL로 변환시
ELSE																					// 파일로 출력할 경우
	ls_PathName = gs_empCode + ".txt"
	dw_1.SaveAs(ls_PathName,Text!,TRUE)
END IF

Return 0
end event

type uc_cancel from u_picture within w_print_preview
integer x = 3163
integer y = 280
integer width = 265
integer height = 84
string picturename = "..\img\button\topBtn_cancel.gif"
end type

event clicked;call super::clicked;CloseWithReturn(Parent, 0)

end event

type gb_6 from groupbox within w_print_preview
integer x = 2853
integer y = 44
integer width = 581
integer height = 188
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "화면 확대축소"
end type

type gb_5 from groupbox within w_print_preview
integer x = 32
integer y = 44
integer width = 654
integer height = 336
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "출력사항"
end type

type gb_4 from groupbox within w_print_preview
integer x = 2245
integer y = 44
integer width = 581
integer height = 188
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "실 인쇄조정"
end type

type gb_3 from groupbox within w_print_preview
integer x = 1879
integer y = 44
integer width = 334
integer height = 336
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "출력형식"
end type

type gb_1 from groupbox within w_print_preview
integer x = 1513
integer y = 44
integer width = 334
integer height = 336
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "출력방향"
end type

type gb_2 from groupbox within w_print_preview
integer x = 718
integer y = 44
integer width = 763
integer height = 336
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "출력범위"
end type

type ln_temptop from line within w_print_preview
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 40
integer endx = 3552
integer endy = 40
end type

type ln_1 from line within w_print_preview
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 2140
integer endx = 3552
integer endy = 2140
end type

type ln_templeft from line within w_print_preview
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 27
integer beginy = -24
integer endx = 27
integer endy = 2244
end type

type ln_tempright from line within w_print_preview
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 3438
integer beginy = -16
integer endx = 3438
integer endy = 2264
end type

type dw_1 from u_dw within w_print_preview
integer x = 32
integer y = 496
integer width = 3406
integer height = 1644
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = true
end type

