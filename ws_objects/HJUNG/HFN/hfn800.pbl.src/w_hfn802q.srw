$PBExportHeader$w_hfn802q.srw
$PBExportComments$세금계산서내역조회
forward
global type w_hfn802q from w_msheet
end type
type uo_acct_class from cuo_acct_class within w_hfn802q
end type
type tab_1 from tab within w_hfn802q
end type
type tabpage_1 from userobject within tab_1
end type
type dw_list from uo_dwgrid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_list dw_list
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hfn802q
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_con from uo_dwfree within w_hfn802q
end type
type uo_tab from u_tab within w_hfn802q
end type
end forward

global type w_hfn802q from w_msheet
string title = "보증금 등록/출력"
uo_acct_class uo_acct_class
tab_1 tab_1
dw_con dw_con
uo_tab uo_tab
end type
global w_hfn802q w_hfn802q

type variables
datawindow	idw_list


end variables

on w_hfn802q.create
int iCurrent
call super::create
this.uo_acct_class=create uo_acct_class
this.tab_1=create tab_1
this.dw_con=create dw_con
this.uo_tab=create uo_tab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_acct_class
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_tab
end on

on w_hfn802q.destroy
call super::destroy
destroy(this.uo_acct_class)
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_tab)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 계산서 자료를 조회한다.
////	작 성 인 : 이현수
////	작성일자 : 2002.12
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//string	ls_sys_date
//
//ls_sys_date = f_today()
//
//ii_acct_class = uo_acct_class.uf_getcode()
//
//idw_list  = tab_1.tabpage_1.dw_list
//idw_print = tab_1.tabpage_2.dw_print
//
//em_fr_date.text = string(ls_sys_date, '@@@@/@@') + '/01'
//em_to_date.text = string(ls_sys_date, '@@@@/@@/@@')
//
//ddlb_tax_type.selectitem(2)
//ddlb_tax_gubun.selectitem(1)
//
//idw_print.object.datawindow.print.preview = true
//
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
string	ls_tax_type, ls_tax_gubun
string	ls_from_date, ls_to_date
date		ld_date

dw_con.accepttext()

ls_tax_type  = dw_con.object.tax_type[1]
ls_tax_gubun = dw_con.object.tax_gubun[1]

ls_from_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date = string(dw_con.object.to_Date[1], 'yyyymmdd')

if not isdate(string(ls_from_date, '@@@@/@@/@@')) then
	messagebox('확인', '조회일자(From)를 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('fr_date')
	return -1
end if

if not isdate(string(ls_to_date, '@@@@/@@/@@')) then
	messagebox('확인', '조회일자(To)를 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return -1
end if

if ls_from_Date > ls_to_Date then
	messagebox('확인', '조회일자의 범위가 올바르지 않습니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return -1
end if


if idw_list.retrieve(gi_acct_class, ls_tax_type, ls_tax_gubun, ls_from_date, ls_to_date) > 0 then
	idw_print.retrieve(gi_acct_class, ls_tax_type, ls_tax_gubun, ls_from_date, ls_to_date)
end if



end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//f_print(idw_print)
//
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 계산서 자료를 조회한다.
//	작 성 인 : 이현수
//	작성일자 : 2002.12
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
string	ls_sys_date

ls_sys_date = f_today()


idw_list  = tab_1.tabpage_1.dw_list
idw_print = tab_1.tabpage_2.dw_print

dw_con.object.fr_date[1] = date(string(ls_sys_date, '@@@@/@@') + '/01')
dw_con.object.to_Date[1] = date(string(ls_sys_date, '@@@@/@@/@@'))

dw_con.object.tax_type[1] = '2'
dw_con.object.tax_gubun[1] = '1'

idw_print.object.datawindow.print.preview = true

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
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

type ln_templeft from w_msheet`ln_templeft within w_hfn802q
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn802q
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn802q
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn802q
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn802q
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn802q
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn802q
end type

type uc_insert from w_msheet`uc_insert within w_hfn802q
end type

type uc_delete from w_msheet`uc_delete within w_hfn802q
end type

type uc_save from w_msheet`uc_save within w_hfn802q
end type

type uc_excel from w_msheet`uc_excel within w_hfn802q
end type

type uc_print from w_msheet`uc_print within w_hfn802q
end type

type st_line1 from w_msheet`st_line1 within w_hfn802q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn802q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn802q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn802q
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn802q
end type

type uo_acct_class from cuo_acct_class within w_hfn802q
event destroy ( )
boolean visible = false
integer x = 2501
integer y = 220
integer taborder = 60
boolean bringtotop = true
long backcolor = 1073741824
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;//ii_acct_class	=	uf_getcode()

end event

type tab_1 from tab within w_hfn802q
integer x = 50
integer y = 328
integer width = 4384
integer height = 1952
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
//	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1832
string text = "계산서내역"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list dw_list
end type

on tabpage_1.create
this.dw_list=create dw_list
this.Control[]={this.dw_list}
end on

on tabpage_1.destroy
destroy(this.dw_list)
end on

type dw_list from uo_dwgrid within tabpage_1
integer x = 9
integer y = 16
integer width = 4338
integer height = 1816
integer taborder = 30
string dataobject = "d_hfn802q_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;string	ls_tax_no

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1832
string text = "계산서내역출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from datawindow within tabpage_2
integer x = 9
integer y = 16
integer width = 4343
integer height = 1816
integer taborder = 70
string title = "none"
string dataobject = "d_hfn802q_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_con from uo_dwfree within w_hfn802q
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hfn802q_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
end event

event itemchanged;call super::itemchanged;Accepttext()
Choose Case dwo.name
	Case 'year'
		idw_update[1].reset()
		idw_print.reset()
	Case 'tax_type'
		idw_update[1].reset()
		idw_print.reset()
		idw_list.reset()
		
		if data = '1' then
			tab_1.tabpage_1.text = '계산서관리'
			tab_1.tabpage_2.text = '계산서출력'
			if dw_con.object.tax_gubun[1] = '1' then
		
			else
				idw_print.dataobject = 'd_hfn801a_3'
				idw_print.settransobject(sqlca)
				idw_print.object.datawindow.print.preview = true
			end if
		else
			tab_1.tabpage_1.text = '세금계산서관리'
			tab_1.tabpage_2.text = '세금계산서출력'
			if dw_con.object.tax_gubun[1] = '1' then
		
			else
				idw_print.dataobject = 'd_hfn801a_2'
				idw_print.settransobject(sqlca)
				idw_print.object.datawindow.print.preview = true
			end if
		end if
		
		
		
	Case 'tax_gubun'
		idw_update[1].reset()
		idw_print.reset()
		idw_list.reset()
		
		if dw_con.object.tax_type[1] = '1' then
			if data = '1' then
		
			else
				idw_print.dataobject = 'd_hfn801a_3'
				idw_print.settransobject(sqlca)
				idw_print.object.datawindow.print.preview = true
			end if
		else
			if data = '1' then
		
			else
				idw_print.dataobject = 'd_hfn801a_2'
				idw_print.settransobject(sqlca)
				idw_print.object.datawindow.print.preview = true
			end if
		end if
		
		
		if dw_con.object.tax_type[1] = '1' then		//계산서
			dw_con.object.per_yn.protect = 1
			dw_con.object.per_yn.visible = 0
			idw_update[1].dataobject = 'd_hfn801a_1_1'
			//idw_update[1].settransobject(sqlca)
		else		//세금계산서
			if data = '1' then	//매입
				dw_con.object.per_yn.protect = 1
				dw_con.object.per_yn.visible = 0
				idw_update[1].dataobject = 'd_hfn801a_1_1'
				//idw_update[1].settransobject(sqlca)
				
		
			else		//매출
				if tab_1.SelectedTab = 2 then 
					dw_con.object.per_yn.protect = 1
					dw_con.object.per_yn.visible = 0
				else
					dw_con.object.per_yn.protect = 0
					dw_con.object.per_yn.visible = 1
				end if
				
				if This.object.per_yn[1] = 'Y' then	//개인(주민등록번호분) 입력
					idw_update[1].dataobject = 'd_hfn801a_1_2'
					//idw_update[1].settransobject(sqlca)
				else
					idw_update[1].dataobject = 'd_hfn801a_1_1'
					//idw_update[1].settransobject(sqlca)
				end if
			end if
		end if
		idw_update[1].triggerevent(constructor!)	
	Case 'per_yn'
		if data = 'Y' then	//개인(주민등록번호분) 입력
			idw_update[1].dataobject = 'd_hfn801a_1_2'
		else
			idw_update[1].dataobject = 'd_hfn801a_1_1'
		end if
			idw_update[1].triggerevent(constructor!)	
End Choose

end event

type uo_tab from u_tab within w_hfn802q
event destroy ( )
integer x = 1582
integer y = 312
integer taborder = 150
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

