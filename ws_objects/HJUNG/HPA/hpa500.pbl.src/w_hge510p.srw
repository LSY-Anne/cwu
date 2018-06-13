$PBExportHeader$w_hge510p.srw
$PBExportComments$년학기 강사료 지급 내역서 출력---old
forward
global type w_hge510p from w_tabsheet
end type
type dw_print1 from cuo_dwprint within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print2 from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print2 dw_print2
end type
type uo_yearhakgi from cuo_yyhakgi within w_hge510p
end type
type rb_1 from radiobutton within w_hge510p
end type
type rb_2 from radiobutton within w_hge510p
end type
type rb_4 from radiobutton within w_hge510p
end type
type uo_mm from cuo_month within w_hge510p
end type
type rb_3 from radiobutton within w_hge510p
end type
type rb_5 from radiobutton within w_hge510p
end type
end forward

global type w_hge510p from w_tabsheet
integer height = 2664
string title = "년학기 강사료 지급 내역서 출력"
uo_yearhakgi uo_yearhakgi
rb_1 rb_1
rb_2 rb_2
rb_4 rb_4
uo_mm uo_mm
rb_3 rb_3
rb_5 rb_5
end type
global w_hge510p w_hge510p

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data,  idw_print2
datawindow			idw_str_member, idw_end_member


string	is_yy, is_hakgi, is_duty
integer	ii_month



end variables

forward prototypes
public function integer wf_retrieve ()
public subroutine wf_getchild ()
end prototypes

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

is_yy 	= uo_yearhakgi.uf_getyy()
is_hakgi	= uo_yearhakgi.uf_gethakgi()
ii_month	= integer(uo_mm.uf_getmm())
if idw_print.retrieve(is_yy, is_hakgi, is_duty, ii_month) > 0 then
//	idw_print.object.comp_cnt.expression = 'cumulativeSum( comp_member_cnt for group 1 )'
	idw_print2.retrieve(is_yy, is_hakgi, is_duty, ii_month)
else
	uo_yearhakgi.em_yy.setfocus()
end if

return 0

end function

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 강사료구분
idw_print.getchild('sec_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if


end subroutine

on w_hge510p.create
int iCurrent
call super::create
this.uo_yearhakgi=create uo_yearhakgi
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_4=create rb_4
this.uo_mm=create uo_mm
this.rb_3=create rb_3
this.rb_5=create rb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yearhakgi
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_4
this.Control[iCurrent+5]=this.uo_mm
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.rb_5
end on

on w_hge510p.destroy
call super::destroy
destroy(this.uo_yearhakgi)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_4)
destroy(this.uo_mm)
destroy(this.rb_3)
destroy(this.rb_5)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_print	=	tab_sheet.tabpage_sheet01.dw_print1
idw_print2	=	tab_sheet.tabpage_sheet02.dw_print2

is_duty	=	''

is_yy 	= uo_yearhakgi.uf_getyy()
is_hakgi	= uo_yearhakgi.uf_gethakgi()
ii_month	= integer(uo_mm.uf_getmm())

IF ii_month < 8 then
	is_hakgi = '1'
	uo_yearhakgi.em_hakgi.text ='1'
else 
	is_hakgi ='2'
	uo_yearhakgi.em_hakgi.text ='2'
end if

wf_getchild()

//triggerevent('ue_retrieve')


end event

event ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 자료출력 처리
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
//

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
				If tab_sheet.selectedtab = 1 Then
					idw_print.print()
				Else
					OpenWithParm(w_print_preview, lvc_print)
				End If
		End If
	End If
End If



end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
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

type ln_templeft from w_tabsheet`ln_templeft within w_hge510p
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hge510p
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hge510p
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hge510p
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hge510p
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hge510p
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hge510p
end type

type uc_insert from w_tabsheet`uc_insert within w_hge510p
end type

type uc_delete from w_tabsheet`uc_delete within w_hge510p
end type

type uc_save from w_tabsheet`uc_save within w_hge510p
end type

type uc_excel from w_tabsheet`uc_excel within w_hge510p
end type

type uc_print from w_tabsheet`uc_print within w_hge510p
end type

type st_line1 from w_tabsheet`st_line1 within w_hge510p
end type

type st_line2 from w_tabsheet`st_line2 within w_hge510p
end type

type st_line3 from w_tabsheet`st_line3 within w_hge510p
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hge510p
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hge510p
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hge510p
integer x = 46
integer y = 304
integer height = 1988
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;if newindex < 0 then return

//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	true)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		true)

choose case newindex
	case 1
		idw_print	=	tab_sheet.tabpage_sheet01.dw_print1
	case 2 
		idw_print	=	tab_sheet.tabpage_sheet02.dw_print2
	case 3
//		wf_SetMenu('FIRST', 	TRUE)
//		wf_SetMenu('NEXT', 	TRUE)
//		wf_SetMenu('PRE', 	TRUE)
//		wf_SetMenu('LAST', 	TRUE)
	case else
//		wf_SetMenu('FIRST', 	FALSE)
//		wf_SetMenu('NEXT', 	FALSE)
//		wf_SetMenu('PRE', 	FALSE)
//		wf_SetMenu('LAST', 	FALSE)
end choose
end event

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer height = 1868
long backcolor = 1073741824
string text = "학기별강사료지급내역서"
dw_print1 dw_print1
end type

on tabpage_sheet01.create
this.dw_print1=create dw_print1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print1
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_print1)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer width = 983
integer height = 2180
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
boolean visible = false
end type

type uo_tab from w_tabsheet`uo_tab within w_hge510p
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hge510p
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hge510p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_print1 from cuo_dwprint within tabpage_sheet01
integer width = 4343
integer height = 1868
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hGE510p_1"
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4338
integer height = 1868
string text = "학기별강사료통계서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print2 dw_print2
end type

on tabpage_sheet02.create
this.dw_print2=create dw_print2
this.Control[]={this.dw_print2}
end on

on tabpage_sheet02.destroy
destroy(this.dw_print2)
end on

type dw_print2 from cuo_dwprint within tabpage_sheet02
integer y = 12
integer width = 4343
integer height = 1856
integer taborder = 10
string dataobject = "d_hGE510p_3"
boolean vscrollbar = true
boolean border = false
end type

type uo_yearhakgi from cuo_yyhakgi within w_hge510p
integer x = 192
integer y = 172
integer width = 1047
integer height = 104
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

on uo_yearhakgi.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yy 	= uf_getyy()
is_hakgi	= uf_gethakgi()
if is_hakgi =' ' then
	is_hakgi ='1'
end if

//parent.triggerevent('ue_retrieve')
end event

type rb_1 from radiobutton within w_hge510p
integer x = 1957
integer y = 196
integer width = 238
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 31112622
string text = "전체"
boolean checked = true
end type

event clicked;is_duty	=	''

rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_2 from radiobutton within w_hge510p
integer x = 2304
integer y = 196
integer width = 238
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "전임"
end type

event clicked;is_duty	=	'10'

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_4 from radiobutton within w_hge510p
integer x = 3355
integer y = 196
integer width = 352
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "외래교수"
end type

event clicked;is_duty	=	'121'

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type uo_mm from cuo_month within w_hge510p
boolean visible = false
integer x = 1061
integer y = 88
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;ii_month	= integer(uf_getmm())

//parent.triggerevent('ue_retrieve')
end event

on uo_mm.destroy
call cuo_month::destroy
end on

type rb_3 from radiobutton within w_hge510p
integer x = 3013
integer y = 196
integer width = 238
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "초빙"
end type

event clicked;is_duty	=	'112' //112,113,114를 DECODE해야한다.

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_5 from radiobutton within w_hge510p
integer x = 2661
integer y = 196
integer width = 238
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "겸임"
end type

event clicked;is_duty	=	'111'

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

