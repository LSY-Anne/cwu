$PBExportHeader$w_hfn110a.srw
$PBExportComments$보증금 등록/출력
forward
global type w_hfn110a from w_msheet
end type
type tab_1 from tab within w_hfn110a
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
type dw_print from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hfn110a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_tab from u_tab within w_hfn110a
end type
type dw_con from uo_dwfree within w_hfn110a
end type
end forward

global type w_hfn110a from w_msheet
integer height = 2616
string title = "보증금 등록/출력"
tab_1 tab_1
uo_tab uo_tab
dw_con dw_con
end type
global w_hfn110a w_hfn110a

type variables

end variables

forward prototypes
public function integer wf_dup_chk (long al_row, string as_bo_gubun, long al_seq_no)
end prototypes

public function integer wf_dup_chk (long al_row, string as_bo_gubun, long al_seq_no);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dup_chk(long al_row, string as_bo_gubun, long al_seq_no) return integer
// 인    수 :	al_row : 현재행, as_bo_gubun : 현재 보증금구분, al_seq_no : 현재 순번
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long	ll_row

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	FNDB.HFN008M
WHERE		BO_GUBUN = :AS_BO_GUBUN
AND		SEQ_NO = :AL_SEQ_NO;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 보증금 자료입니다.')
	return 1
end if

ll_row = idw_update[1].find("bo_gubun = '" + as_bo_gubun + "' and " + &
                         "seq_no = " + string(al_seq_no), 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 보증금 자료입니다.')
	return 1
end if

//2010.04.05 해당 row가 마지막 row 임에도 로직을 태워 에러 발생하여 수정함.
If al_row <>  idw_update[1].rowcount() Then

	ll_row = idw_update[1].find("bo_gubun = '" + as_bo_gubun + "' and " + &
			     "seq_no = " + string(al_seq_no), al_row + 1, idw_update[1].rowcount())
	
	if ll_row > 0 then
		messagebox('확인', '이미 등록된 보증금 자료입니다.')
		return 1
	end if
	
End If

return 0
end function

on w_hfn110a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_tab=create uo_tab
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_tab
this.Control[iCurrent+3]=this.dw_con
end on

on w_hfn110a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_tab)
destroy(this.dw_con)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 법인카드자료를 관리한다.
////	작 성 인 : 이현수
////	작성일자 : 2002.11
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//ddlb_bo_gubun.selectitem(1)
//
//
//idw_update[1] = tab_1.tabpage_1.dw_update
//idw_print  = tab_1.tabpage_2.dw_print
//
//idw_update[1].reset()
//idw_update[1].sharedata(idw_print)
//idw_print.object.datawindow.print.preview = true
//
//triggerevent('ue_retrieve')
//
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
string	ls_bo_gubun

dw_con.accepttext()

ls_bo_gubun = dw_con.object.bo_gubun[1]

idw_update[1].retrieve(gi_acct_class, ls_bo_gubun) 

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
string	ls_bo_gubun

dw_con.accepttext()
ls_bo_gubun = dw_con.object.bo_gubun[1]

ll_row = idw_update[1].getrow()

ll_row = idw_update[1].insertrow(ll_row + 1)

if ls_bo_gubun <> '0' then
	idw_update[1].setitem(ll_row, 'bo_gubun', ls_bo_gubun)
end if
idw_update[1].setitem(ll_row, 'acct_class',	gi_acct_class)
idw_update[1].setitem(ll_row, 'worker', 		gs_empcode)
idw_update[1].setitem(ll_row, 'ipaddr', 		gs_ip)
idw_update[1].setitem(ll_row, 'work_date', 	f_sysdate())

wf_SetMsg('자료가 추가되었습니다.')

idw_update[1].setcolumn('bo_gubun')
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
string	ls_null[]

idw_update[1].accepttext()

if idw_update[1].modifiedcount() < 1 and idw_update[1].deletedcount() < 1 then
	wf_SetMsg('변경된 자료가 없습니다.')
	return -1
end if

ls_null[1] = 'bo_gubun/보증금구분'
ls_null[2] = 'seq_no/순번'
ls_null[2] = 'acct_code/계정코드'

if f_chk_null(idw_update[1], ls_null) = -1 then return -1


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
//	작성목적 : 법인카드자료를 관리한다.
//	작 성 인 : 이현수
//	작성일자 : 2002.11
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
dw_con.object.bo_gubun[1] = '0'


idw_update[1] = tab_1.tabpage_1.dw_update
idw_print  = tab_1.tabpage_2.dw_print

idw_update[1].reset()
idw_update[1].sharedata(idw_print)
idw_print.object.datawindow.print.preview = true

triggerevent('ue_retrieve')

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

type ln_templeft from w_msheet`ln_templeft within w_hfn110a
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn110a
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn110a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn110a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn110a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn110a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn110a
end type

type uc_insert from w_msheet`uc_insert within w_hfn110a
end type

type uc_delete from w_msheet`uc_delete within w_hfn110a
end type

type uc_save from w_msheet`uc_save within w_hfn110a
end type

type uc_excel from w_msheet`uc_excel within w_hfn110a
end type

type uc_print from w_msheet`uc_print within w_hfn110a
end type

type st_line1 from w_msheet`st_line1 within w_hfn110a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn110a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn110a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn110a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn110a
end type

type tab_1 from tab within w_hfn110a
integer x = 50
integer y = 324
integer width = 4384
integer height = 2248
integer taborder = 10
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

event selectionchanged;choose case newindex
	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
end choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2128
string text = "보증금 관리"
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
integer y = 4
integer width = 4352
integer height = 1920
integer taborder = 21
string dataobject = "d_hfn110a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
string	ls_bo_gubun, ls_cust_name
long		ll_seq_no, ll_cnt
this.accepttext()
choose case dwo.name
	case 'bo_gubun'
		ll_seq_no = getitemnumber(row, 'seq_no')
		
		If isnull(ll_seq_no ) Then return 1
		
		if wf_dup_chk(row, data, ll_seq_no) > 0 then
			this.post setitem(row, 'bo_gubun', '')
			return 1
		end if
	case 'seq_no'
		ls_bo_gubun = getitemstring(row, 'bo_gubun')
		
		if wf_dup_chk(row, ls_bo_gubun, long(data)) > 0 then
			setitem(row, 'seq_no', 0)
			return 1
		end if
	case 'open_date', 'disp_date'
		if not isnull(data) and trim(data) <> '' then
			if not isdate(mid(data,1,4) + '/' + mid(data,5,2) + '/' + mid(data,7,2)) then
				messagebox('확인', '일자가 올바르지 않습니다.')
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
				setitem(row, 'cust_no', '')
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
end choose

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event doubleclicked;call super::doubleclicked;s_insa_com	lstr_rtn

if row < 1 then return

if dwo.name <> 'cust_no' then return

open(w_hfn_cust)

lstr_rtn = message.powerobjectparm

if not isvalid(lstr_rtn) then
	setitem(row, 'cust_no', '')
	setitem(row, 'cust_name', '')
	return
end if

setitem(row, 'cust_no', lstr_rtn.ls_item[1])
setitem(row, 'cust_name', trim(lstr_rtn.ls_item[2]))

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2128
string text = "보증금 내역"
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

type dw_print from uo_dwfree within tabpage_2
integer width = 4347
integer height = 1952
integer taborder = 130
string dataobject = "d_hfn110a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type uo_tab from u_tab within w_hfn110a
event destroy ( )
integer x = 1582
integer y = 312
integer taborder = 120
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

type dw_con from uo_dwfree within w_hfn110a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_hfn110a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
end event

event itemchanged;call super::itemchanged;parent.triggerevent('ue_retrieve')
end event

