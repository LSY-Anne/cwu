$PBExportHeader$w_hpa507p.srw
$PBExportComments$월 강사료 지급 현황/명세서 출력
forward
global type w_hpa507p from w_tabsheet
end type
type dw_print1 from cuo_dwprint within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type gb_3 from groupbox within tabpage_sheet02
end type
type st_3 from statictext within tabpage_sheet02
end type
type dw_print2 from cuo_dwprint within tabpage_sheet02
end type
type st_5 from statictext within tabpage_sheet02
end type
type uo_member_no from cuo_member_fromto within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
gb_3 gb_3
st_3 st_3
dw_print2 dw_print2
st_5 st_5
uo_member_no uo_member_no
end type
type uo_yearhakgi from cuo_yyhakgi within w_hpa507p
end type
type rb_prof from radiobutton within w_hpa507p
end type
type rb_gang from radiobutton within w_hpa507p
end type
type uo_month from cuo_month within w_hpa507p
end type
type rb_4 from radiobutton within w_hpa507p
end type
type rb_5 from radiobutton within w_hpa507p
end type
type rb_lect from radiobutton within w_hpa507p
end type
type rb_1 from radiobutton within w_hpa507p
end type
end forward

global type w_hpa507p from w_tabsheet
string title = "월 강사료 지급 현황/명세서 출력"
uo_yearhakgi uo_yearhakgi
rb_prof rb_prof
rb_gang rb_gang
uo_month uo_month
rb_4 rb_4
rb_5 rb_5
rb_lect rb_lect
rb_1 rb_1
end type
global w_hpa507p w_hpa507p

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data,  idw_print2
datawindow			idw_str_member, idw_end_member

statictext			ist_back, ist_back2, ist_back3

string	is_yy, is_hakgi, is_duty_code
integer	ii_str_jikjong = 1, ii_end_jikjong = 3, ii_month
string	is_str_member, is_end_member


end variables

forward prototypes
public function integer wf_member_chk ()
public subroutine wf_getchild2 ()
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

public function integer wf_member_chk ();// ==========================================================================================
// 기    능 : 	member check
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_member_chk()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상/-1 - 실패
// 주의사항 :
// 수정사항 :
// ==========================================================================================

if (is_str_member > is_end_member) or (len(is_str_member) > len(is_end_member)) then
	f_messagebox('1', '개인번호를 정확히 선택해 주세요.!')
	return	-1
end if

return	0
end function

public subroutine wf_getchild2 ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild2()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

tab_sheet.tabpage_sheet02.uo_member_no.uf_getchild(ii_str_jikjong, ii_end_jikjong, '', 0)

end subroutine

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

// 보직구분
idw_print.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if



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

integer	li_tab

li_tab  = tab_sheet.selectedtab

is_yy 	= uo_yearhakgi.uf_getyy()
is_hakgi	= uo_yearhakgi.uf_gethakgi()
ii_month	= integer(uo_month.uf_getmm())

if li_tab	=	1	then
	
	if idw_print.retrieve(is_yy, is_hakgi, ii_month, is_duty_code) > 0 then
		if rb_4.checked then
		else
		end if
		
		idw_print.setfocus()
	else
		uo_yearhakgi.em_yy.setfocus()
	end if
else
	if wf_member_chk() < 0 then	return	0
	
	if idw_print2.retrieve(is_yy, is_hakgi, ii_month, is_duty_code, is_str_member, is_end_member) > 0 then
		idw_print2.setfocus()
	else
		uo_yearhakgi.em_yy.setfocus()
	end if
end if

return 0

end function

on w_hpa507p.create
int iCurrent
call super::create
this.uo_yearhakgi=create uo_yearhakgi
this.rb_prof=create rb_prof
this.rb_gang=create rb_gang
this.uo_month=create uo_month
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_lect=create rb_lect
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yearhakgi
this.Control[iCurrent+2]=this.rb_prof
this.Control[iCurrent+3]=this.rb_gang
this.Control[iCurrent+4]=this.uo_month
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.rb_5
this.Control[iCurrent+7]=this.rb_lect
this.Control[iCurrent+8]=this.rb_1
end on

on w_hpa507p.destroy
call super::destroy
destroy(this.uo_yearhakgi)
destroy(this.rb_prof)
destroy(this.rb_gang)
destroy(this.uo_month)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_lect)
destroy(this.rb_1)
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



wf_getchild2()
//rb_2.triggerevent(clicked!)
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
is_str_member = 'A0000'
is_end_member = 'Z9999'

wf_getchild()

triggerevent('ue_retrieve')

tab_sheet.selectedtab = 1


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

event ue_first;call super::ue_first;idw_print2.scrolltorow(1)
end event

event ue_last;call super::ue_last;idw_print2.scrolltorow(idw_print2.rowcount())
end event

event ue_next;call super::ue_next;idw_print2.scrollpriorpage()
end event

event ue_prior;call super::ue_prior;idw_print2.scrollnextpage()
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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa507p
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa507p
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa507p
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa507p
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa507p
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa507p
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa507p
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa507p
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa507p
end type

type uc_save from w_tabsheet`uc_save within w_hpa507p
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa507p
end type

type uc_print from w_tabsheet`uc_print within w_hpa507p
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa507p
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa507p
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa507p
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa507p
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa507p
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa507p
integer y = 332
integer width = 4384
integer height = 1956
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

choose case newindex
	case 1
		idw_print	=	tab_sheet.tabpage_sheet01.dw_print1
	case 2
		
		idw_print	=	tab_sheet.tabpage_sheet02.dw_print2
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
string text = "시간강사료개인별지급현황"
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

type uo_tab from w_tabsheet`uo_tab within w_hpa507p
integer x = 1989
integer y = 304
end type

type dw_con from w_tabsheet`dw_con within w_hpa507p
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hpa507p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_print1 from cuo_dwprint within tabpage_sheet01
integer y = 12
integer width = 4338
integer height = 1824
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa507p_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event retrieveend;call super::retrieveend;IF rb_prof.checked THEN
	this.object.t_head.Text = '전임교수'
ELSEIF rb_lect.checked THEN
	this.object.t_head.Text = '강의전담/겸임/초빙교수'
ELSE
	this.Object.t_head.Text = '외래교수'
END IF
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1836
string text = "개인별강사료지급명세서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_3 gb_3
st_3 st_3
dw_print2 dw_print2
st_5 st_5
uo_member_no uo_member_no
end type

on tabpage_sheet02.create
this.gb_3=create gb_3
this.st_3=create st_3
this.dw_print2=create dw_print2
this.st_5=create st_5
this.uo_member_no=create uo_member_no
this.Control[]={this.gb_3,&
this.st_3,&
this.dw_print2,&
this.st_5,&
this.uo_member_no}
end on

on tabpage_sheet02.destroy
destroy(this.gb_3)
destroy(this.st_3)
destroy(this.dw_print2)
destroy(this.st_5)
destroy(this.uo_member_no)
end on

type gb_3 from groupbox within tabpage_sheet02
integer y = -20
integer width = 4347
integer height = 200
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type st_3 from statictext within tabpage_sheet02
integer x = 96
integer y = 72
integer width = 334
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "개인번호별"
boolean focusrectangle = false
end type

type dw_print2 from cuo_dwprint within tabpage_sheet02
integer y = 192
integer width = 4352
integer height = 1632
integer taborder = 10
string dataobject = "d_hpa507p_2"
boolean vscrollbar = true
boolean border = false
end type

event retrieveend;call super::retrieveend;//this.object.univ_name_t.text = gstru_uid_uname.univ_name

end event

type st_5 from statictext within tabpage_sheet02
integer x = 2647
integer y = 72
integer width = 1115
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "※ 개인번호를 지우면 전체가 조회됩니다."
boolean focusrectangle = false
end type

type uo_member_no from cuo_member_fromto within tabpage_sheet02
integer x = 443
integer y = 52
integer taborder = 110
boolean bringtotop = true
end type

event ue_itemchanged();call super::ue_itemchanged;is_str_member	=	uf_str_member()
is_end_member	=	uf_end_member()

end event

on uo_member_no.destroy
call cuo_member_fromto::destroy
end on

type uo_yearhakgi from cuo_yyhakgi within w_hpa507p
integer x = 87
integer y = 168
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
IF IS_HAKGI = '3' OR IS_HAKGI = '4' THEN
	is_duty_code ='%'
	ii_str_jikjong = 1
	ii_end_jikjong = 3
	
	idw_print.dataobject ='d_hpa507p_5'
	idw_print.settransobject(sqlca)
	idw_print.Modify("DataWindow.Print.Preview='yes'")
END IF

end event

type rb_prof from radiobutton within w_hpa507p
integer x = 1705
integer y = 184
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
boolean checked = true
end type

event clicked;is_duty_code ='10' 
ii_str_jikjong = 1
ii_end_jikjong = 1

idw_print.dataobject ='d_hpa507p_3'
idw_print.settransobject(sqlca)
idw_print.Modify("DataWindow.Print.Preview='yes'")
idw_print2.dataobject ='d_hpa507p_2'
idw_print2.settransobject(sqlca)
idw_print2.Modify("DataWindow.Print.Preview='yes'")
wf_getchild2()
wf_getchild()

parent.triggerevent('ue_retrieve')

end event

type rb_gang from radiobutton within w_hpa507p
integer x = 2363
integer y = 184
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

event clicked;is_duty_code ='301'
ii_str_jikjong = 3
ii_end_jikjong = 3

idw_print.dataobject ='d_hpa507p_1'
idw_print.settransobject(sqlca)
idw_print.Modify("DataWindow.Print.Preview='yes'")
idw_print2.dataobject ='d_hpa507p_4'
idw_print2.settransobject(sqlca)
idw_print2.Modify("DataWindow.Print.Preview='yes'")
//wf_getchild2()
wf_getchild()

parent.triggerevent('ue_retrieve')

end event

type uo_month from cuo_month within w_hpa507p
integer x = 1134
integer y = 168
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;ii_month	= integer(uf_getmm())

end event

on uo_month.destroy
call cuo_month::destroy
end on

type rb_4 from radiobutton within w_hpa507p
integer x = 3273
integer y = 184
integer width = 416
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
string text = "개인번호순"
boolean checked = true
end type

event clicked;rb_4.textcolor = rgb(0, 0, 255)
rb_5.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_5 from radiobutton within w_hpa507p
integer x = 3803
integer y = 184
integer width = 288
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
string text = "성명순"
end type

event clicked;rb_5.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_lect from radiobutton within w_hpa507p
integer x = 1975
integer y = 184
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
string text = "강의전담"
end type

event clicked;is_duty_code ='11' 
ii_str_jikjong = 1
ii_end_jikjong = 1

idw_print.dataobject ='d_hpa507p_6'
idw_print.settransobject(sqlca)
idw_print.Modify("DataWindow.Print.Preview='yes'")
idw_print2.dataobject ='d_hpa507p_2'
idw_print2.settransobject(sqlca)
idw_print2.Modify("DataWindow.Print.Preview='yes'")
wf_getchild2()
wf_getchild()

parent.triggerevent('ue_retrieve')

end event

type rb_1 from radiobutton within w_hpa507p
integer x = 2734
integer y = 184
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
string text = "겸임교수"
end type

event clicked;is_duty_code ='111' 
ii_str_jikjong = 1
ii_end_jikjong = 1

idw_print.dataobject ='d_hpa507p_7'
idw_print.settransobject(sqlca)
idw_print.Modify("DataWindow.Print.Preview='yes'")
idw_print2.dataobject ='d_hpa507p_2'
idw_print2.settransobject(sqlca)
idw_print2.Modify("DataWindow.Print.Preview='yes'")
wf_getchild2()
wf_getchild()

parent.triggerevent('ue_retrieve')

end event

