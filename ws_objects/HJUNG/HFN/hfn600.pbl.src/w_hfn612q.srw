$PBExportHeader$w_hfn612q.srw
$PBExportComments$[산학협력단]기타/사업소득 지급조서
forward
global type w_hfn612q from w_tabsheet
end type
type gb_6 from groupbox within tabpage_sheet01
end type
type uo_3 from cuo_search within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type gb_2 from groupbox within tabpage_sheet02
end type
type dw_list002 from cuo_dwwindow within tabpage_sheet02
end type
type rb_1 from radiobutton within tabpage_sheet02
end type
type rb_2 from radiobutton within tabpage_sheet02
end type
type sle_name from singlelineedit within tabpage_sheet02
end type
type st_name from statictext within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
gb_2 gb_2
dw_list002 dw_list002
rb_1 rb_1
rb_2 rb_2
sle_name sle_name
st_name st_name
end type
end forward

global type w_hfn612q from w_tabsheet
string title = "사업소득자 등록/출력"
end type
global w_hfn612q w_hfn612q

type variables
datawindowchild	idw_child
datawindow			idw_list


end variables

forward prototypes
public function integer wf_retrieve ()
end prototypes

public function integer wf_retrieve ();// ==========================================================================================
// 기    능	:	Retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_retrieve()	returns	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String ls_from_yyyymm, ls_to_yyyymm
dw_con.accepttext()

ls_from_yyyymm = String(dw_con.object.from_yyyymm[1], 'yyyymm')
ls_to_yyyymm = String(dw_con.object.to_yyyymm[1], 'yyyymm')

idw_list.setredraw(false)

if idw_list.retrieve(ls_from_yyyymm, ls_to_yyyymm) > 0 then
//	if idw_print.retrieve(is_from_yyyymm, is_to_yyyymm, '%') > 0 then
//		ist_back.bringtotop = false
//	end if
else
	idw_list.reset()
	idw_print.reset()
end if

idw_list.setredraw(true)

return 0

end function

on w_hfn612q.create
int iCurrent
call super::create
end on

on w_hfn612q.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 12                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////
String ls_from_yyyymm, ls_to_yyyymm
dw_con.accepttext()

ls_from_yyyymm = String(dw_con.object.from_yyyymm[1], 'yyyymm')
ls_to_yyyymm = String(dw_con.object.to_yyyymm[1], 'yyyymm')

if not isdate(string(ls_from_yyyymm,'@@@@/@@')+'/01') then
	messagebox('확인', '소득년월(From)을 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('from_yyyymm')
	return -1
end if

if not isdate(string(ls_to_yyyymm,'@@@@/@@')+'/01') then
	messagebox('확인', '소득년월(To)을 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_yyyymm')
	return -1
end if

if ls_from_yyyymm > ls_to_yyyymm then
	messagebox('확인', '소득년월의 범위가 올바르지 않습니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_yyyymm')
	return -1
end if


wf_retrieve()
return 1
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.12
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//string	ls_sysdate
//
//idw_list		  =	tab_sheet.tabpage_sheet01.dw_list001
//idw_print	  =	tab_sheet.tabpage_sheet02.dw_list002
//
//
//idw_print.Modify("DataWindow.Print.Preview='yes'")
//
//ls_sysdate	  =	f_today()
//
//ddlb_gubun.selectitem(1)
//
//em_from_yyyymm.text = string(ls_sysdate, '@@@@/@@')
//em_to_yyyymm.text   = string(ls_sysdate, '@@@@/@@')
//is_from_yyyymm      = mid(ls_sysdate,1,6)
//is_to_yyyymm    	  = mid(ls_sysdate,1,6)
//
//tab_sheet.tabpage_sheet01.uo_3.st_remark.text = '소득자명으로 자료를 조회합니다.'
//tab_sheet.tabpage_sheet01.uo_3.rb_1.text		 =	'소득자명'
//tab_sheet.tabpage_sheet01.uo_3.rb_2.visible	 =	false
//tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'income_name', 'income_name')
//
//tab_sheet.tabpage_sheet02.sle_name.enabled = false
//tab_sheet.tabpage_sheet02.st_name.TextColor = RGB(128,128,128)
//
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF idw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, idw_print)
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
string	ls_sysdate

idw_list		  =	tab_sheet.tabpage_sheet01.dw_update_tab
idw_print	  =	tab_sheet.tabpage_sheet02.dw_list002


idw_print.Modify("DataWindow.Print.Preview='yes'")

ls_sysdate	  =	f_today()

dw_con.object.gubun[1] = '1'

dw_con.object.from_yyyymm[1] = date(string(ls_sysdate, '@@@@/@@/@@'))
dw_con.object.to_yyyymm[1]  = date(string(ls_sysdate, '@@@@/@@/@@'))


tab_sheet.tabpage_sheet01.uo_3.st_remark.text = '소득자명으로 자료를 조회합니다.'
tab_sheet.tabpage_sheet01.uo_3.rb_1.text		 =	'소득자명'
tab_sheet.tabpage_sheet01.uo_3.rb_2.visible	 =	false
tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'income_name', 'income_name')

tab_sheet.tabpage_sheet02.sle_name.enabled = false
tab_sheet.tabpage_sheet02.st_name.TextColor = RGB(128,128,128)

end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "기타소득 원천징수영수증")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hfn612q
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hfn612q
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hfn612q
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hfn612q
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hfn612q
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hfn612q
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hfn612q
end type

type uc_insert from w_tabsheet`uc_insert within w_hfn612q
end type

type uc_delete from w_tabsheet`uc_delete within w_hfn612q
end type

type uc_save from w_tabsheet`uc_save within w_hfn612q
end type

type uc_excel from w_tabsheet`uc_excel within w_hfn612q
end type

type uc_print from w_tabsheet`uc_print within w_hfn612q
end type

type st_line1 from w_tabsheet`st_line1 within w_hfn612q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hfn612q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hfn612q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hfn612q
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hfn612q
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hfn612q
integer y = 316
integer width = 4384
integer height = 1980
integer taborder = 40
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case	1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
//	case	else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
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
integer y = 104
integer width = 4347
integer height = 1860
long backcolor = 1073741824
string text = "기타소득자 내역"
gb_6 gb_6
uo_3 uo_3
end type

on tabpage_sheet01.create
this.gb_6=create gb_6
this.uo_3=create uo_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_6
this.Control[iCurrent+2]=this.uo_3
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_6)
destroy(this.uo_3)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 164
integer width = 101
integer height = 100
string dataobject = "d_hfn612q_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;string ls_name

if currentrow < 1 then	return

//selectrow(0, false)
//selectrow(currentrow, true)

//2005.03.31 추가 (Jung Kwang Hoon)
ls_name = getItemString(currentrow, 'income_name')

tab_sheet.tabpage_sheet02.rb_1.checked = false
tab_sheet.tabpage_sheet02.rb_2.checked = true

tab_sheet.tabpage_sheet02.sle_name.text = ls_name
tab_sheet.tabpage_sheet02.rb_2.triggerevent(clicked!)

end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount() > 0 then
	trigger event rowfocuschanged(1)
end if


end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 164
integer width = 4343
integer height = 1692
string dataobject = "d_hfn612q_1"
boolean hsplitscroll = true
end type

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount() > 0 then
	trigger event rowfocuschanged(1)
end if


end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;string ls_name

if currentrow < 1 then	return

//selectrow(0, false)
//selectrow(currentrow, true)

//2005.03.31 추가 (Jung Kwang Hoon)
ls_name = getItemString(currentrow, 'income_name')

tab_sheet.tabpage_sheet02.rb_1.checked = false
tab_sheet.tabpage_sheet02.rb_2.checked = true

tab_sheet.tabpage_sheet02.sle_name.text = ls_name
tab_sheet.tabpage_sheet02.rb_2.triggerevent(clicked!)

end event

type uo_tab from w_tabsheet`uo_tab within w_hfn612q
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hfn612q
string dataobject = "d_hfn603q_con"
end type

event dw_con::itemchanged;call super::itemchanged;accepttext()
Choose case dwo.name
	Case 'gubun'
		If data = '1' Then
			tab_sheet.tabpage_sheet01.text = '기타소득자 내역'
			tab_sheet.tabpage_sheet02.text = '기타소득 원천징수영수증'
			idw_list.dataobject 	= 'd_hfn612q_1'
			idw_print.dataobject = 'd_hfn612q_2'
		Else
	//		tab_sheet.tabpage_sheet01.text = '사업소득자 내역'
	//		tab_sheet.tabpage_sheet02.text = '사업소득 원천징수영수증'
	//		idw_list.dataobject 	= 'd_hfn603q_3'
	//		idw_print.dataobject = 'd_hfn603q_4'
		End If



		//idw_list.settransobject(sqlca)
		idw_list.triggerevent(constructor!)
		idw_print.settransobject(sqlca)
		idw_print.modify("datawindow.zoom = 90")
		idw_print.Modify("DataWindow.Print.Preview='yes'")
End Choose

end event

type st_con from w_tabsheet`st_con within w_hfn612q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_6 from groupbox within tabpage_sheet01
integer y = -20
integer width = 4352
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type uo_3 from cuo_search within tabpage_sheet01
event destroy ( )
integer x = 114
integer y = 40
integer width = 3566
integer taborder = 80
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search::destroy
end on

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1860
string text = "기타소득 원천징수영수증"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_2 gb_2
dw_list002 dw_list002
rb_1 rb_1
rb_2 rb_2
sle_name sle_name
st_name st_name
end type

on tabpage_sheet02.create
this.gb_2=create gb_2
this.dw_list002=create dw_list002
this.rb_1=create rb_1
this.rb_2=create rb_2
this.sle_name=create sle_name
this.st_name=create st_name
this.Control[]={this.gb_2,&
this.dw_list002,&
this.rb_1,&
this.rb_2,&
this.sle_name,&
this.st_name}
end on

on tabpage_sheet02.destroy
destroy(this.gb_2)
destroy(this.dw_list002)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.sle_name)
destroy(this.st_name)
end on

type gb_2 from groupbox within tabpage_sheet02
integer y = -12
integer width = 4347
integer height = 176
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type dw_list002 from cuo_dwwindow within tabpage_sheet02
integer y = 164
integer width = 4347
integer height = 1700
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hfn612q_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;//this.uf_setClick(true)
end event

event retrieveend;call super::retrieveend;//selectrow(0, false)
//selectrow(1, true)
end event

type rb_1 from radiobutton within tabpage_sheet02
integer x = 151
integer y = 60
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전체조회"
boolean checked = true
end type

event clicked;String ls_from_yyyymm, ls_to_yyyymm
dw_con.accepttext()

ls_from_yyyymm = String(dw_con.object.from_yyyymm[1], 'yyyymm')
ls_to_yyyymm = String(dw_con.object.to_yyyymm[1], 'yyyymm')

sle_name.enabled = false
st_name.TextColor = RGB(128,128,128)



idw_print.retrieve(ls_from_yyyymm, ls_to_yyyymm, '%') 



end event

type rb_2 from radiobutton within tabpage_sheet02
integer x = 745
integer y = 60
integer width = 512
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "성명으로조회"
end type

event clicked;String ls_from_yyyymm, ls_to_yyyymm
dw_con.accepttext()

ls_from_yyyymm = String(dw_con.object.from_yyyymm[1], 'yyyymm')
ls_to_yyyymm = String(dw_con.object.to_yyyymm[1], 'yyyymm')

sle_name.enabled = true
st_name.TextColor = RGB(0,0,128)

 idw_print.retrieve(ls_from_yyyymm, ls_to_yyyymm, sle_name.text+'%') 



end event

type sle_name from singlelineedit within tabpage_sheet02
integer x = 1275
integer y = 44
integer width = 750
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;rb_2.triggerevent(clicked!)

end event

type st_name from statictext within tabpage_sheet02
integer x = 2075
integer y = 68
integer width = 1659
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "※ 성명을 입력한 후 엔터키를 누르면 자료가 조회됩니다."
boolean focusrectangle = false
end type

