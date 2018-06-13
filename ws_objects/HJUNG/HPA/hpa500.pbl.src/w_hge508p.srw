$PBExportHeader$w_hge508p.srw
$PBExportComments$직급별강사료지급현황(월 강사료 이체내역서 출력)
forward
global type w_hge508p from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type st_back2 from statictext within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
st_back2 st_back2
end type
type uo_yearhakgi from cuo_yyhakgi within w_hge508p
end type
type rb_1 from radiobutton within w_hge508p
end type
type rb_2 from radiobutton within w_hge508p
end type
type rb_3 from radiobutton within w_hge508p
end type
type uo_month from cuo_month within w_hge508p
end type
type dw_print from cuo_dwprint within w_hge508p
end type
type rb_5 from radiobutton within w_hge508p
end type
type rb_4 from radiobutton within w_hge508p
end type
end forward

global type w_hge508p from w_tabsheet
integer height = 2672
string title = "직급별강사료지급현황 출력"
uo_yearhakgi uo_yearhakgi
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
uo_month uo_month
dw_print dw_print
rb_5 rb_5
rb_4 rb_4
end type
global w_hge508p w_hge508p

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data,  idw_print2, idw_print3
datawindow			idw_str_member, idw_end_member

statictext			ist_back, ist_back2, ist_back3

string	is_yy, is_hakgi
integer	ii_str_jikjong = 1, ii_end_jikjong = 3, ii_month
string	is_str_member, is_end_member


end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_getchild ();
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
string ls_duty_code
is_yy 	= uo_yearhakgi.uf_getyy()
is_hakgi	= uo_yearhakgi.uf_gethakgi()
ii_month	= integer(uo_month.uf_getmm())

if rb_1.checked = true then
	ls_duty_code = '%'
elseif rb_2.checked = true then
	ls_duty_code ='10'
elseif rb_5.checked = true then
	ls_duty_code ='115'
elseif rb_3.checked = true then
	ls_duty_code ='301'
elseif rb_4.checked = true then
	ls_duty_code ='111'
end if

if dw_print.retrieve(is_yy, is_hakgi, ii_month, ls_duty_code) > 0 then
	dw_print.setfocus()
else
	uo_yearhakgi.em_yy.setfocus()
end if

return 0

end function

on w_hge508p.create
int iCurrent
call super::create
this.uo_yearhakgi=create uo_yearhakgi
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.uo_month=create uo_month
this.dw_print=create dw_print
this.rb_5=create rb_5
this.rb_4=create rb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yearhakgi
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.uo_month
this.Control[iCurrent+6]=this.dw_print
this.Control[iCurrent+7]=this.rb_5
this.Control[iCurrent+8]=this.rb_4
end on

on w_hge508p.destroy
call super::destroy
destroy(this.uo_yearhakgi)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.uo_month)
destroy(this.dw_print)
destroy(this.rb_5)
destroy(this.rb_4)
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

is_yy 	= uo_yearhakgi.uf_getyy()
is_hakgi	= uo_yearhakgi.uf_gethakgi()
ii_month	= integer(uo_month.uf_getmm())
IF ii_month < 8 then
	is_hakgi = '1'
	uo_yearhakgi.em_hakgi.text ='1'
else 
	is_hakgi ='2'
	uo_yearhakgi.em_hakgi.text ='2'
end if

idw_print = dw_print
wf_getchild()

end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF dw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, dw_print)
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

type ln_templeft from w_tabsheet`ln_templeft within w_hge508p
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hge508p
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hge508p
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hge508p
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hge508p
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hge508p
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hge508p
end type

type uc_insert from w_tabsheet`uc_insert within w_hge508p
end type

type uc_delete from w_tabsheet`uc_delete within w_hge508p
end type

type uc_save from w_tabsheet`uc_save within w_hge508p
end type

type uc_excel from w_tabsheet`uc_excel within w_hge508p
end type

type uc_print from w_tabsheet`uc_print within w_hge508p
end type

type st_line1 from w_tabsheet`st_line1 within w_hge508p
end type

type st_line2 from w_tabsheet`st_line2 within w_hge508p
end type

type st_line3 from w_tabsheet`st_line3 within w_hge508p
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hge508p
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hge508p
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hge508p
boolean visible = false
integer x = 1065
integer y = 632
integer width = 3881
integer height = 2296
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;if newindex < 0 then return

//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	true)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		true)
//
//choose case newindex
//	case 3
//		wf_SetMenu('FIRST', 	TRUE)
//		wf_SetMenu('NEXT', 	TRUE)
//		wf_SetMenu('PRE', 	TRUE)
//		wf_SetMenu('LAST', 	TRUE)
//	case else
//		wf_SetMenu('FIRST', 	FALSE)
//		wf_SetMenu('NEXT', 	FALSE)
//		wf_SetMenu('PRE', 	FALSE)
//		wf_SetMenu('LAST', 	FALSE)
//end choose
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
integer width = 3845
integer height = 2180
string text = "시간강사료개인별지급내역"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer width = 983
integer height = 2180
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
end type

type uo_tab from w_tabsheet`uo_tab within w_hge508p
boolean visible = false
end type

type dw_con from w_tabsheet`dw_con within w_hge508p
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hge508p
end type

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 3845
integer height = 2180
long backcolor = 79741120
string text = "시간강사료주별지급내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_back2 st_back2
end type

on tabpage_sheet02.create
this.st_back2=create st_back2
this.Control[]={this.st_back2}
end on

on tabpage_sheet02.destroy
destroy(this.st_back2)
end on

type st_back2 from statictext within tabpage_sheet02
integer width = 3845
integer height = 2180
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 80263581
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_yearhakgi from cuo_yyhakgi within w_hge508p
integer x = 87
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

end event

type rb_1 from radiobutton within w_hge508p
integer x = 1879
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

event clicked;ii_str_jikjong = 1
ii_end_jikjong = 3

rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_2 from radiobutton within w_hge508p
integer x = 2222
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

event clicked;ii_str_jikjong = 1
ii_end_jikjong = 1

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_3 from radiobutton within w_hge508p
integer x = 3072
integer y = 188
integer width = 315
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

event clicked;ii_str_jikjong = 1
ii_end_jikjong = 1

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 255)

parent.triggerevent('ue_retrieve')

end event

type uo_month from cuo_month within w_hge508p
integer x = 1134
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

type dw_print from cuo_dwprint within w_hge508p
integer x = 50
integer y = 292
integer width = 4379
integer height = 2004
integer taborder = 50
string dataobject = "d_hGE508p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type rb_5 from radiobutton within w_hge508p
integer x = 2560
integer y = 188
integer width = 443
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

event clicked;ii_str_jikjong = 1
ii_end_jikjong = 1

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_4 from radiobutton within w_hge508p
integer x = 3415
integer y = 188
integer width = 329
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
string text = "겸임교수"
end type

event clicked;ii_str_jikjong = 1
ii_end_jikjong = 1

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 255)

parent.triggerevent('ue_retrieve')

end event

