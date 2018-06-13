$PBExportHeader$w_hfn111a.srw
$PBExportComments$유가증권 등록/출력
forward
global type w_hfn111a from w_msheet
end type
type tab_1 from tab within w_hfn111a
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
type tab_1 from tab within w_hfn111a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_con from uo_dwfree within w_hfn111a
end type
type uo_tab from u_tab within w_hfn111a
end type
type cb_1 from uo_imgbtn within w_hfn111a
end type
end forward

global type w_hfn111a from w_msheet
integer height = 2616
string title = "보증금 등록/출력"
tab_1 tab_1
dw_con dw_con
uo_tab uo_tab
cb_1 cb_1
end type
global w_hfn111a w_hfn111a

type variables

end variables

forward prototypes
public function integer wf_dup_chk (long al_row, string as_sec_no)
public subroutine wf_getchild ()
end prototypes

public function integer wf_dup_chk (long al_row, string as_sec_no);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dup_chk(long al_row, string as_sec_no) return integer
// 인    수 :	al_row : 현재행, as_sec_no : 현재 증권번호
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long	ll_row

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	FNDB.HFN006M
WHERE		SEC_NO = :AS_SEC_NO ;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 증권번호입니다.')
	return 1
end if

ll_row = idw_update[1].find("sec_no = '" + as_sec_no + "'", 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 증권번호입니다.')
	return 1
end if

ll_row = idw_update[1].find("sec_no = '" + as_sec_no + "'", al_row + 1, idw_update[1].rowcount())

if ll_row > 0 then
	messagebox('확인', '이미 등록된 증권번호입니다.')
	return 1
end if

return 0
end function

public subroutine wf_getchild ();// ==========================================================================================
// 기    능	:	DatawindowChild Getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
datawindowchild	ldw_child

// 증권종류
idw_update[1].getchild('sec_opt', ldw_child)
ldw_child.settransobject(sqlca)
if ldw_child.retrieve('sec_opt', 1) < 1 then
	ldw_child.reset()
	ldw_child.insertrow(0)
end if

idw_print.getchild('sec_opt', ldw_child)
ldw_child.settransobject(sqlca)
if ldw_child.retrieve('sec_opt', 1) < 1 then
	ldw_child.reset()
	ldw_child.insertrow(0)
end if

end subroutine

on w_hfn111a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_con=create dw_con
this.uo_tab=create uo_tab
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_tab
this.Control[iCurrent+4]=this.cb_1
end on

on w_hfn111a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_tab)
destroy(this.cb_1)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 법인카드자료를 관리한다.
////	작 성 인 : 이현수
////	작성일자 : 2002.11
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//
//idw_update[1] = tab_1.tabpage_1.dw_update
//idw_print  = tab_1.tabpage_2.dw_print
//
//wf_getchild()
//
//idw_update[1].reset()
//idw_update[1].sharedata(idw_print)
//idw_print.object.datawindow.print.preview = true
//
//f_getdwcommon(dw_con, 'sec_opt', 0, 730)
//dw_con.setitem(1, 'code', '0')
//
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
Integer li_sec_opt

dw_con.accepttext()
li_sec_opt = Integer(dw_con.object.code[1])

wf_getchild()


idw_update[1].retrieve(gi_acct_class, li_sec_opt) 

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
Integer li_sec_opt

dw_con.accepttext()
li_sec_opt = Integer(dw_con.object.code[1])


ll_row = idw_update[1].getrow()

ll_row = idw_update[1].insertrow(ll_row + 1)

if li_sec_opt <> 0 then
	idw_update[1].setitem(ll_row, 'sec_opt', li_sec_opt)
end if
idw_update[1].setitem(ll_row, 'acct_class',	gi_acct_class)
idw_update[1].setitem(ll_row, 'stat_class',	'Y')
idw_update[1].setitem(ll_row, 'worker', 		gs_empcode)
idw_update[1].setitem(ll_row, 'ipaddr', 		gs_ip)
idw_update[1].setitem(ll_row, 'work_date', 	f_sysdate())

wf_SetMsg('자료가 추가되었습니다.')

idw_update[1].setcolumn('sec_opt')
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

ls_null[1] = 'sec_opt/증권구분'
ls_null[2] = 'sec_no/증권번호'

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

idw_update[1] = tab_1.tabpage_1.dw_update
idw_print  = tab_1.tabpage_2.dw_print

wf_getchild()

idw_update[1].reset()
idw_update[1].sharedata(idw_print)
idw_print.object.datawindow.print.preview = true

f_getdwcommon(dw_con, 'sec_opt', 0, 730)
dw_con.setitem(1, 'code', '0')


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

type ln_templeft from w_msheet`ln_templeft within w_hfn111a
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn111a
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn111a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn111a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn111a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn111a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn111a
end type

type uc_insert from w_msheet`uc_insert within w_hfn111a
end type

type uc_delete from w_msheet`uc_delete within w_hfn111a
end type

type uc_save from w_msheet`uc_save within w_hfn111a
end type

type uc_excel from w_msheet`uc_excel within w_hfn111a
end type

type uc_print from w_msheet`uc_print within w_hfn111a
end type

type st_line1 from w_msheet`st_line1 within w_hfn111a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn111a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn111a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn111a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn111a
end type

type tab_1 from tab within w_hfn111a
integer x = 50
integer y = 324
integer width = 4384
integer height = 2096
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
integer height = 1976
string text = "유가증권 관리"
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
integer width = 4347
integer height = 1912
integer taborder = 50
string dataobject = "d_hfn111a_1"
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
string	ls_bo_gubun
long		ll_seq_no

choose case dwo.name
	case 'sec_no'
		if wf_dup_chk(row, data) > 0 then
			setitem(row, 'sec_no', '')
			return 1
		end if
	case 'open_date', 'close_date', 'disp_date'
		if not isnull(data) and trim(data) <> '' then
			if not isdate(mid(data,1,4) + '/' + mid(data,5,2) + '/' + mid(data,7,2)) then
				messagebox('확인', '일자가 올바르지 않습니다.')
				setitem(row, dwo.name, '')
				return 1
			end if
		end if
end choose

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1976
string text = "유가증권 내역"
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
integer width = 4352
integer height = 1944
integer taborder = 50
string dataobject = "d_hfn111a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_con from uo_dwfree within w_hfn111a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hfn104a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)

This.object.code_t.text = '증권구분'
end event

type uo_tab from u_tab within w_hfn111a
event destroy ( )
integer x = 1582
integer y = 312
integer taborder = 130
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

type cb_1 from uo_imgbtn within w_hfn111a
integer x = 50
integer y = 36
integer taborder = 50
boolean bringtotop = true
string btnname = "유가증권일괄생성"
end type

event clicked;call super::clicked;open(w_hfn111a_help)
end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

