$PBExportHeader$w_hfn801a_help.srw
$PBExportComments$세금계산서관리/출력
forward
global type w_hfn801a_help from w_msheet
end type
type cb_4 from commandbutton within w_hfn801a_help
end type
type cb_3 from commandbutton within w_hfn801a_help
end type
type cb_2 from commandbutton within w_hfn801a_help
end type
type cb_1 from commandbutton within w_hfn801a_help
end type
type ddlb_tax_gubun from dropdownlistbox within w_hfn801a_help
end type
type st_4 from statictext within w_hfn801a_help
end type
type ddlb_tax_type from dropdownlistbox within w_hfn801a_help
end type
type st_3 from statictext within w_hfn801a_help
end type
type em_year from editmask within w_hfn801a_help
end type
type st_1 from statictext within w_hfn801a_help
end type
type gb_1 from groupbox within w_hfn801a_help
end type
type tab_1 from tab within w_hfn801a_help
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update from uo_dwgrid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_update dw_update
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hfn801a_help
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_tab from u_tab within w_hfn801a_help
end type
type uo_acct_class from cuo_acct_class within w_hfn801a_help
end type
end forward

global type w_hfn801a_help from w_msheet
string title = "보증금 등록/출력"
boolean controlmenu = true
boolean resizable = false
windowtype windowtype = response!
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
ddlb_tax_gubun ddlb_tax_gubun
st_4 st_4
ddlb_tax_type ddlb_tax_type
st_3 st_3
em_year em_year
st_1 st_1
gb_1 gb_1
tab_1 tab_1
uo_tab uo_tab
uo_acct_class uo_acct_class
end type
global w_hfn801a_help w_hfn801a_help

type variables

integer		ii_acct_class
end variables

on w_hfn801a_help.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_tax_gubun=create ddlb_tax_gubun
this.st_4=create st_4
this.ddlb_tax_type=create ddlb_tax_type
this.st_3=create st_3
this.em_year=create em_year
this.st_1=create st_1
this.gb_1=create gb_1
this.tab_1=create tab_1
this.uo_tab=create uo_tab
this.uo_acct_class=create uo_acct_class
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.ddlb_tax_gubun
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.ddlb_tax_type
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.em_year
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.tab_1
this.Control[iCurrent+13]=this.uo_tab
this.Control[iCurrent+14]=this.uo_acct_class
end on

on w_hfn801a_help.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_tax_gubun)
destroy(this.st_4)
destroy(this.ddlb_tax_type)
destroy(this.st_3)
destroy(this.em_year)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.tab_1)
destroy(this.uo_tab)
destroy(this.uo_acct_class)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 계산서 자료를 관리한다.
////	작 성 인 : 이현수
////	작성일자 : 2002.12
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//ii_acct_class = uo_acct_class.uf_getcode()
//
//idw_update[1] = tab_1.tabpage_1.dw_update
//idw_print  = tab_1.tabpage_2.dw_print
//
//em_year.text = left(f_today(),4)
//
//ddlb_tax_type.selectitem(2)
//ddlb_tax_gubun.selectitem(1)
//
//this.title = '계산서(세금계산서) 처리'
//
//idw_update[1].reset()
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

ls_tax_type  = string(ddlb_tax_type.finditem(ddlb_tax_type.text,0))
ls_tax_gubun = string(ddlb_tax_gubun.finditem(ddlb_tax_gubun.text,0))

idw_update[1].retrieve(ii_acct_class, ls_tax_type, ls_tax_gubun, em_year.text)

return 1

end event

event ue_delete;call super::ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
long	ll_row

ll_row = idw_update[1].getrow()

if ll_row < 1 then
	messagebox('확인', '삭제할 데이터를 선택하시기 바랍니다.')
	return
end if

idw_update[1].deleterow(ll_row)

wf_SetMsg('자료가 삭제되었습니다. 저장으로 자료 삭제를 완료하시기 바랍니다.')

end event

event ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
long		ll_row
string	ls_tax_type, ls_tax_gubun

idw_update[1].setfocus()

ls_tax_type  = string(ddlb_tax_type.finditem(ddlb_tax_type.text,0))
ls_tax_gubun = string(ddlb_tax_gubun.finditem(ddlb_tax_gubun.text,0))

ll_row = idw_update[1].getrow()

ll_row = idw_update[1].insertrow(ll_row + 1)

idw_update[1].setitem(ll_row, 'acct_class',	ii_acct_class)
idw_update[1].setitem(ll_row, 'tax_type',		ls_tax_type)
idw_update[1].setitem(ll_row, 'tax_gubun',	ls_tax_gubun)
idw_update[1].setitem(ll_row, 'tax_date',		f_today())
idw_update[1].setitem(ll_row, 'worker', 		gs_empcode)
idw_update[1].setitem(ll_row, 'ipaddr', 		gs_ip)
idw_update[1].setitem(ll_row, 'work_date', 	f_sysdate())

wf_SetMsg('자료가 추가되었습니다.')

idw_update[1].setcolumn('tax_date')
idw_update[1].scrolltorow(ll_row)
idw_update[1].setfocus()

end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
dwitemstatus	ldw_status
string			ls_null[]
string			ls_tax_no
long				ll_tax_no, ll_row

idw_update[1].accepttext()

if idw_update[1].modifiedcount() < 1 and idw_update[1].deletedcount() < 1 then
	wf_SetMsg('변경된 자료가 없습니다.')
	return -1
end if

ls_null[1] = 'tax_date/계산서일자'
ls_null[2] = 'tax_cust_no/거래처'
ls_null[3] = 'tax_amt/공급가액'

if f_chk_null(idw_update[1], ls_null) = -1 then return -1



select	nvl(max(substr(tax_no,5,6)),0)
into		:ll_tax_no
from		fndb.hfn007m
where		acct_class = :ii_acct_class
and		substr(tax_no,1,4) = :em_year.text	;

if isnull(ll_tax_no) then ll_tax_no = 0

ll_row = idw_update[1].getnextmodified(0,primary!)

do	while ll_row > 0
	ldw_status = idw_update[1].getitemstatus(ll_row, 0, primary!)
	
	if ldw_status = new! or ldw_status = newmodified! then
		ll_tax_no ++
		idw_update[1].setitem(ll_row, 'tax_no', em_year.text + string(ll_tax_no,'000000'))
	end if
	
	ll_row = idw_update[1].getnextmodified(ll_row,primary!)
loop

if idw_update[1].update() <> 1 then
	rollback ;
	return -1
end if

commit ;
wf_SetMsg('자료가 저장되었습니다.')

triggerevent('ue_retrieve')



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

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "세금계산서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 계산서 자료를 관리한다.
//	작 성 인 : 이현수
//	작성일자 : 2002.12
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
ii_acct_class = uo_acct_class.uf_getcode()

idw_update[1] = tab_1.tabpage_1.dw_update
idw_print  = tab_1.tabpage_2.dw_print

em_year.text = left(f_today(),4)

ddlb_tax_type.selectitem(2)
ddlb_tax_gubun.selectitem(1)

this.title = '계산서(세금계산서) 처리'

idw_update[1].reset()
idw_print.object.datawindow.print.preview = true

end event

type ln_templeft from w_msheet`ln_templeft within w_hfn801a_help
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn801a_help
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn801a_help
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn801a_help
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn801a_help
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn801a_help
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn801a_help
end type

type uc_insert from w_msheet`uc_insert within w_hfn801a_help
end type

type uc_delete from w_msheet`uc_delete within w_hfn801a_help
end type

type uc_save from w_msheet`uc_save within w_hfn801a_help
end type

type uc_excel from w_msheet`uc_excel within w_hfn801a_help
end type

type uc_print from w_msheet`uc_print within w_hfn801a_help
end type

type st_line1 from w_msheet`st_line1 within w_hfn801a_help
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn801a_help
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn801a_help
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn801a_help
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn801a_help
end type

type cb_4 from commandbutton within w_hfn801a_help
boolean visible = false
integer x = 3557
integer y = 200
integer width = 297
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "저장"
end type

event clicked;parent.triggerevent('ue_save')

end event

type cb_3 from commandbutton within w_hfn801a_help
boolean visible = false
integer x = 3259
integer y = 200
integer width = 297
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "삭제"
end type

event clicked;parent.triggerevent('ue_delete')

end event

type cb_2 from commandbutton within w_hfn801a_help
boolean visible = false
integer x = 2962
integer y = 200
integer width = 297
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "입력"
end type

event clicked;parent.triggerevent('ue_insert')

end event

type cb_1 from commandbutton within w_hfn801a_help
boolean visible = false
integer x = 2665
integer y = 200
integer width = 297
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "조회"
end type

event clicked;parent.triggerevent('ue_retrieve')

end event

type ddlb_tax_gubun from dropdownlistbox within w_hfn801a_help
integer x = 1737
integer y = 208
integer width = 251
integer height = 212
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
string item[] = {"매입","매출"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;idw_update[1].reset()
idw_print.reset()

if ddlb_tax_type.finditem(ddlb_tax_type.text,0) = 1 then
	if finditem(text,0) = 1 then

	else
		idw_print.dataobject = 'd_hfn801a_3'
		idw_print.settransobject(sqlca)
		idw_print.object.datawindow.print.preview = true
	end if
else
	if finditem(text,0) = 1 then

	else
		idw_print.dataobject = 'd_hfn801a_2'
		idw_print.settransobject(sqlca)
		idw_print.object.datawindow.print.preview = true
	end if
end if
end event

type st_4 from statictext within w_hfn801a_help
integer x = 690
integer y = 224
integer width = 270
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "처리구분"
boolean focusrectangle = false
end type

type ddlb_tax_type from dropdownlistbox within w_hfn801a_help
integer x = 965
integer y = 208
integer width = 430
integer height = 208
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
string item[] = {"계산서","세금계산서"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;idw_update[1].reset()
idw_print.reset()

if finditem(text,0) = 1 then
	tab_1.tabpage_1.text = '계산서관리'
	tab_1.tabpage_2.text = '계산서출력'
else
	tab_1.tabpage_1.text = '세금계산서관리'
	tab_1.tabpage_2.text = '세금계산서출력'
end if
end event

type st_3 from statictext within w_hfn801a_help
integer x = 91
integer y = 224
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "해당년도"
boolean focusrectangle = false
end type

type em_year from editmask within w_hfn801a_help
integer x = 361
integer y = 208
integer width = 270
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
boolean autoskip = true
boolean spin = true
end type

event modified;idw_update[1].reset()
idw_print.reset()

end event

type st_1 from statictext within w_hfn801a_help
integer x = 1458
integer y = 224
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "매입매출"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hfn801a_help
integer x = 50
integer y = 136
integer width = 4384
integer height = 200
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회 및 생성조건"
end type

type tab_1 from tab within w_hfn801a_help
integer x = 50
integer y = 384
integer width = 4384
integer height = 1916
integer taborder = 40
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
integer height = 1796
string text = "세금계산서관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update dw_update
end type

on tabpage_1.create
this.dw_update=create dw_update
this.Control[]={this.dw_update}
end on

on tabpage_1.destroy
destroy(this.dw_update)
end on

type dw_update from uo_dwgrid within tabpage_1
integer y = 8
integer width = 4357
integer height = 1796
integer taborder = 170
string dataobject = "d_hfn801a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event doubleclicked;call super::doubleclicked;s_insa_com	lstr_rtn

if row < 1 then return

if dwo.name <> 'tax_cust_no' then return

open(w_hfn_cust)

lstr_rtn = message.powerobjectparm

if not isvalid(lstr_rtn) then
	setitem(row, 'tax_cust_no', '')
	setitem(row, 'cust_name', '')
	return
end if

setitem(row, 'tax_cust_no', lstr_rtn.ls_item[1])
setitem(row, 'cust_name', trim(lstr_rtn.ls_item[2]))

end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
long		ll_cnt
string	ls_cust_name

choose case dwo.name
	case 'tax_date'
		if not isnull(data) and trim(data) <> '' then
			if not isdate(string(data, '@@@@/@@/@@')) then
				messagebox('확인', '계산서일자가 올바르지 않습니다.')
				setitem(row, dwo.name, '')
				return 1
			end if
		end if
	case 'cust_no'
		if not isnull(data) and trim(data) <> '' then
			select	count(cust_no)	into	:ll_cnt
			from		stdb.hst001m
			where		cust_no = trim(:data)	;
			
			if ll_cnt < 1 then
				setitem(row, 'tax_cust_no', '')
				setitem(row, 'cust_name', '')
				messagebox('확인', '등록되지 않은 거래처입니다.')
				return 1
			elseif ll_cnt = 1 then
				select	cust_name	into	:ls_cust_name
				from		stdb.hst001m
				where		cust_no = trim(:data)	;
				
				setitem(row, 'cust_name', trim(ls_cust_name))
			end if
		end if
	case 'tax_amt'
		if getitemstring(row, 'tax_type') = '2' then
			setitem(row, 'tax_vat', round(dec(data) * 0.1,0))
		end if
end choose

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event rowfocuschanged;call super::rowfocuschanged;string	ls_tax_no

if currentrow < 1 then return

if getitemstring(currentrow, 'tax_gubun') = '1' then return

ls_tax_no = getitemstring(currentrow, 'tax_no')

// 계산서 출력

idw_print.retrieve(ii_acct_class, ls_tax_no)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1796
string text = "세금계산서출력"
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
integer width = 4334
integer height = 1780
integer taborder = 31
string title = "none"
string dataobject = "d_hfn801a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type uo_tab from u_tab within w_hfn801a_help
event destroy ( )
integer x = 1541
integer y = 332
integer taborder = 160
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

type uo_acct_class from cuo_acct_class within w_hfn801a_help
event destroy ( )
boolean visible = false
integer x = 2565
integer y = 216
integer taborder = 50
long backcolor = 1073741824
end type

on uo_acct_class.destroy
call cuo_acct_class::destroy
end on

event ue_itemchanged;call super::ue_itemchanged;//ii_acct_class	=	uf_getcode()

end event

