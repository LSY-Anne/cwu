$PBExportHeader$w_hge809p.srw
$PBExportComments$시간강사통계현황
forward
global type w_hge809p from w_tabsheet
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
type uo_yearhakgi from cuo_yyhakgi within w_hge809p
end type
type uo_2 from cuo_month within w_hge809p
end type
type rb_1 from radiobutton within w_hge809p
end type
type rb_2 from radiobutton within w_hge809p
end type
type rb_5 from radiobutton within w_hge809p
end type
type rb_4 from radiobutton within w_hge809p
end type
type uo_month from cuo_month within w_hge809p
end type
end forward

global type w_hge809p from w_tabsheet
integer width = 4498
integer height = 2420
string title = "년학기 강사료 지급 내역서 출력"
uo_yearhakgi uo_yearhakgi
uo_2 uo_2
rb_1 rb_1
rb_2 rb_2
rb_5 rb_5
rb_4 rb_4
uo_month uo_month
end type
global w_hge809p w_hge809p

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data,  idw_print2
datawindow			idw_str_member, idw_end_member


string	is_yy, is_hakgi, is_duty
integer	ii_month



end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

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
if idw_child.retrieve('sec_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

//// 개인번호
//idw_str_member.reset()
//idw_str_member.insertrow(0)
//
//idw_str_member.getchild('code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//idw_child.setsort('member_no')
//idw_child.sort()
//
//idw_end_member.reset()
//idw_end_member.insertrow(0)
//
//idw_end_member.getchild('code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//idw_child.setsort('member_no')
//idw_child.sort()
end subroutine

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
ii_month	= integer(uo_month.uf_getmm())

if idw_print.retrieve(is_yy, is_hakgi, ii_month, is_duty) > 0 then
	idw_print2.retrieve(is_yy, is_hakgi, ii_month, is_duty)
else
	uo_yearhakgi.em_yy.setfocus()
end if

return 0
end function

on w_hge809p.create
int iCurrent
call super::create
this.uo_yearhakgi=create uo_yearhakgi
this.uo_2=create uo_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_5=create rb_5
this.rb_4=create rb_4
this.uo_month=create uo_month
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yearhakgi
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_5
this.Control[iCurrent+6]=this.rb_4
this.Control[iCurrent+7]=this.uo_month
end on

on w_hge809p.destroy
call super::destroy
destroy(this.uo_yearhakgi)
destroy(this.uo_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.uo_month)
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
ii_month	= integer(uo_2.uf_getmm())

wf_getchild()

end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//datawindow	ldw
//
//choose case	tab_sheet.selectedtab
//	case	1
//		ldw	=	idw_print
//	case	2
//		ldw	=	idw_print2
//end choose		
//
//IF ldw.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, ldw)
//
//
//
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

type ln_templeft from w_tabsheet`ln_templeft within w_hge809p
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hge809p
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hge809p
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hge809p
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hge809p
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hge809p
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hge809p
end type

type uc_insert from w_tabsheet`uc_insert within w_hge809p
end type

type uc_delete from w_tabsheet`uc_delete within w_hge809p
end type

type uc_save from w_tabsheet`uc_save within w_hge809p
end type

type uc_excel from w_tabsheet`uc_excel within w_hge809p
end type

type uc_print from w_tabsheet`uc_print within w_hge809p
end type

type st_line1 from w_tabsheet`st_line1 within w_hge809p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hge809p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hge809p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hge809p
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hge809p
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hge809p
integer y = 332
integer width = 4384
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;if newindex < 0 then return

//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	true)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		true)
//
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
integer width = 4347
integer height = 1832
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

type uo_tab from w_tabsheet`uo_tab within w_hge809p
end type

type dw_con from w_tabsheet`dw_con within w_hge809p
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hge809p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_print1 from cuo_dwprint within tabpage_sheet01
integer width = 4343
integer height = 1832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hGE809p_1"
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1832
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
integer width = 4352
integer height = 1832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hGE809p_3"
boolean vscrollbar = true
boolean border = false
end type

type uo_yearhakgi from cuo_yyhakgi within w_hge809p
integer x = 78
integer y = 172
integer width = 1047
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

on uo_yearhakgi.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yy 	= uf_getyy()
is_hakgi	= uf_gethakgi()

parent.triggerevent('ue_retrieve')
end event

type uo_2 from cuo_month within w_hge809p
boolean visible = false
integer x = 1134
integer y = 88
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;ii_month	= integer(uf_getmm())

parent.triggerevent('ue_retrieve')
end event

on uo_2.destroy
call cuo_month::destroy
end on

type rb_1 from radiobutton within w_hge809p
integer x = 1957
integer y = 188
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
rb_5.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_2 from radiobutton within w_hge809p
integer x = 2304
integer y = 188
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
rb_5.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_5 from radiobutton within w_hge809p
integer x = 2661
integer y = 188
integer width = 480
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
string text = "강의전담교수"
end type

event clicked;is_duty	=	'115'

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_5.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_4 from radiobutton within w_hge809p
integer x = 3355
integer y = 188
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

event clicked;is_duty	=	'301'

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_5.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 255)

parent.triggerevent('ue_retrieve')

end event

type uo_month from cuo_month within w_hge809p
integer x = 1170
integer y = 172
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;ii_month	= integer(uf_getmm())


end event

on uo_month.destroy
call cuo_month::destroy
end on

