$PBExportHeader$w_hfn801a.srw
$PBExportComments$세금계산서관리/출력
forward
global type w_hfn801a from w_msheet
end type
type tab_1 from tab within w_hfn801a
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
type dw_print_list from uo_dwgrid within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
dw_print_list dw_print_list
end type
type tab_1 from tab within w_hfn801a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_con from uo_dwfree within w_hfn801a
end type
type uo_tab from u_tab within w_hfn801a
end type
end forward

global type w_hfn801a from w_msheet
string title = "보증금 등록/출력"
tab_1 tab_1
dw_con dw_con
uo_tab uo_tab
end type
global w_hfn801a w_hfn801a

type variables
datawindow	 idw_list


end variables

on w_hfn801a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_con=create dw_con
this.uo_tab=create uo_tab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_tab
end on

on w_hfn801a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_tab)
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
//idw_update[1] 	= tab_1.tabpage_1.dw_update
//idw_print  	= tab_1.tabpage_2.dw_print
//idw_list  	= tab_1.tabpage_2.dw_print_list
//
//em_year.text = left(f_today(),4)
//
//ddlb_tax_type.selectitem(2)
//ddlb_tax_gubun.selectitem(1)
//
//idw_update[1].reset()
//idw_list.reset()
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
string	ls_tax_type, ls_tax_gubun, ls_year

dw_con.accepttext()
ls_year = String(dw_con.object.year[1], 'yyyy')

ls_tax_type  = dw_con.object.tax_type[1]
ls_tax_gubun = dw_con.object.tax_gubun[1]



if tab_1.SelectedTab = 1 then
	idw_update[1].retrieve(gi_acct_class, ls_tax_type, ls_tax_gubun, ls_year)
elseif tab_1.SelectedTab = 2 then
	if ls_tax_gubun = '2' then	
		idw_list.retrieve(gi_acct_class, ls_tax_type, ls_tax_gubun, ls_year)
	else
		idw_list.reset()
		idw_print.reset()
	end if
end if

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

dw_con.accepttext()
ls_tax_type  = dw_con.object.tax_type[1]
ls_tax_gubun = dw_con.object.tax_gubun[1]

ll_row = idw_update[1].getrow()

ll_row = idw_update[1].insertrow(ll_row + 1)

idw_update[1].setitem(ll_row, 'acct_class',	gi_acct_class)
idw_update[1].setitem(ll_row, 'tax_type',		ls_tax_type)
idw_update[1].setitem(ll_row, 'tax_gubun',		ls_tax_gubun)
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
String	 ls_year

dw_con.accepttext()
ls_year = String(dw_con.object.year[1], 'yyyy')
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
where		acct_class = :gi_acct_class
and		substr(tax_no,1,4) = :ls_year	;
	
if isnull(ll_tax_no) then ll_tax_no = 0

ll_row = idw_update[1].getnextmodified(0,primary!)

do	while ll_row > 0
	ldw_status = idw_update[1].getitemstatus(ll_row, 0, primary!)
	
	if ldw_status = new! or ldw_status = newmodified! then
		ll_tax_no ++
		idw_update[1].setitem(ll_row, 'tax_no', ls_year + string(ll_tax_no,'000000'))
		
		if idw_update[1].dataobject = 'd_hfn801a_1_2' then	//주민등록번호 발행분...
			idw_update[1].setitem(ll_row, 'jumin_gbn', 'Y')
		end if
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

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 계산서 자료를 관리한다.
//	작 성 인 : 이현수
//	작성일자 : 2002.12
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////

idw_update[1] 	= tab_1.tabpage_1.dw_update
idw_print  	= tab_1.tabpage_2.dw_print
idw_list  	= tab_1.tabpage_2.dw_print_list

dw_con.object.year[1] = date(string(f_today(),'@@@@/@@/@@'))
dw_con.object.tax_type[1] = '2'
dw_con.object.tax_gubun[1] = '1'
dw_con.object.per_yn.visible = 0

idw_update[1].reset()
idw_list.reset()
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

type ln_templeft from w_msheet`ln_templeft within w_hfn801a
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn801a
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn801a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn801a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn801a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn801a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn801a
end type

type uc_insert from w_msheet`uc_insert within w_hfn801a
end type

type uc_delete from w_msheet`uc_delete within w_hfn801a
end type

type uc_save from w_msheet`uc_save within w_hfn801a
end type

type uc_excel from w_msheet`uc_excel within w_hfn801a
end type

type uc_print from w_msheet`uc_print within w_hfn801a
end type

type st_line1 from w_msheet`st_line1 within w_hfn801a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn801a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn801a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn801a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn801a
end type

type tab_1 from tab within w_hfn801a
integer x = 50
integer y = 348
integer width = 4384
integer height = 1924
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

event selectionchanged;dw_con.accepttext()
choose case newindex
	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
		
		if dw_con.object.tax_type[1] = '2' and &
			dw_con.object.tax_gubun[1] = '2' then	//세금계산서,매출
			dw_con.object.per_yn.protect = 0
		end if
	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
		
		dw_con.object.per_yn.protect = 1
end choose


end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1804
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
integer taborder = 160
string dataobject = "d_hfn801a_1_1"
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

if this.dataobject = 'd_hfn801a_1_2' then		//개인(주민등록번호분) 입력
	open(w_hfn_cust_jumin)
	
	lstr_rtn = message.powerobjectparm
	
	if not isvalid(lstr_rtn) then
		setitem(row, 'tax_cust_no', '')
		setitem(row, 'cust_name',	 '')
		setitem(row, 'jumin_no', 	 '')
		return
	end if
	
	setitem(row, 'tax_cust_no', lstr_rtn.ls_item[1])
	setitem(row, 'cust_name', 	 trim(lstr_rtn.ls_item[2]))
	setitem(row, 'jumin_no', 	 trim(lstr_rtn.ls_item[6]))
else
	open(w_hfn_cust)
	
	lstr_rtn = message.powerobjectparm
	
	if not isvalid(lstr_rtn) then
		setitem(row, 'tax_cust_no', '')
		setitem(row, 'cust_name', 	 '')
		setitem(row, 'business_no', '')
		return
	end if
	
	setitem(row, 'tax_cust_no', lstr_rtn.ls_item[1])
	setitem(row, 'cust_name', 	 trim(lstr_rtn.ls_item[2]))
	setitem(row, 'business_no', trim(lstr_rtn.ls_item[6]))
end if

end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
long		ll_cnt
string	ls_cust_name, ls_business_no

choose case dwo.name
	case 'tax_date'
		if not isnull(data) and trim(data) <> '' then
			if not isdate(string(data, '@@@@/@@/@@')) then
				messagebox('확인', '계산서일자가 올바르지 않습니다.')
				setitem(row, dwo.name, '')
				return 1
			end if
		end if
	case 'tax_cust_no'
		if this.dataobject = 'd_hfn801a_1_2' then		//개인(주민등록번호분) 입력
			if not isnull(data) and trim(data) <> '' then
				select	count(cust_no)	into	:ll_cnt
				from		fndb.hfn603h
				where		cust_no = trim(:data)	;
				
				if ll_cnt < 1 then
					setitem(row, 'tax_cust_no', '')
					setitem(row, 'cust_name', '')
					setitem(row, 'jumin_no', '')
					messagebox('확인', '등록되지 않은 거래처입니다.')
					return 1
				elseif ll_cnt = 1 then
					select	cust_name, 		jumin_no	
					into		:ls_cust_name, :ls_business_no
					from		fndb.hfn603h
					where		cust_no = trim(:data)	;
					
					setitem(row, 'cust_name', trim(ls_cust_name))
					setitem(row, 'jumin_no', trim(ls_business_no))
				end if
			end if
		else
			if not isnull(data) and trim(data) <> '' then
				select	count(cust_no)	into	:ll_cnt
				from		stdb.hst001m
				where		cust_no = trim(:data)	;
				
				if ll_cnt < 1 then
					setitem(row, 'tax_cust_no', '')
					setitem(row, 'cust_name', '')
					setitem(row, 'business_no', '')
					messagebox('확인', '등록되지 않은 거래처입니다.')
					return 1
				elseif ll_cnt = 1 then
					select	cust_name,		business_no
					into		:ls_cust_name, :ls_business_no
					from		stdb.hst001m
					where		cust_no = trim(:data)	;
					
					setitem(row, 'cust_name', trim(ls_cust_name))
					setitem(row, 'business_no', trim(ls_business_no))
				end if
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

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1804
string text = "세금계산서출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
dw_print_list dw_print_list
end type

on tabpage_2.create
this.dw_print=create dw_print
this.dw_print_list=create dw_print_list
this.Control[]={this.dw_print,&
this.dw_print_list}
end on

on tabpage_2.destroy
destroy(this.dw_print)
destroy(this.dw_print_list)
end on

type dw_print from datawindow within tabpage_2
integer x = 9
integer y = 872
integer width = 4334
integer height = 932
integer taborder = 21
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

type dw_print_list from uo_dwgrid within tabpage_2
integer x = 9
integer y = 16
integer width = 4338
integer height = 844
integer taborder = 160
string dataobject = "d_hfn801a_2_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;string	ls_tax_type, ls_tax_gubun, ls_tax_no, ls_jumin_gbn

//this.selectrow(0, false)
if currentrow < 1 then return
//this.selectrow(currentrow, true)


ls_tax_type 	= getitemstring(currentrow, 'tax_type')
ls_tax_gubun 	= getitemstring(currentrow, 'tax_gubun')
ls_tax_no 		= getitemstring(currentrow, 'tax_no')
ls_jumin_gbn 	= getitemstring(currentrow, 'jumin_gbn')

if ls_tax_gubun = '1' then return

if ls_tax_type = '1' then		//계산서
	idw_print.dataobject = 'd_hfn801a_3'
else		//세금계산서
	if ls_jumin_gbn = 'Y' then		//개인(주민등록번호분) 입력
		idw_print.dataobject = 'd_hfn801a_2_j'
	else
		idw_print.dataobject = 'd_hfn801a_2'
	end if
end if

idw_print.settransobject(sqlca)
idw_print.object.datawindow.print.preview = true

// 계산서 출력
idw_print.retrieve(gi_acct_class, ls_tax_no)

//일련번호 출력...(20040106)
if idw_print.rowcount() > 0 then
	idw_print.setitem(1, 'seq_no', string(currentrow, '0 0 0'))
end if

end event

type dw_con from uo_dwfree within w_hfn801a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_hfn801a_con"
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

type uo_tab from u_tab within w_hfn801a
event destroy ( )
integer x = 1582
integer y = 312
integer taborder = 140
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

