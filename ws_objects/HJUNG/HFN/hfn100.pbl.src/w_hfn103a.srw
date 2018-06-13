$PBExportHeader$w_hfn103a.srw
$PBExportComments$관리항목코드 등록/출력
forward
global type w_hfn103a from w_msheet
end type
type tab_1 from tab within w_hfn103a
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
type tab_1 from tab within w_hfn103a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_tab from u_tab within w_hfn103a
end type
end forward

global type w_hfn103a from w_msheet
integer width = 4480
integer height = 2512
boolean titlebar = false
string title = ""
boolean resizable = false
boolean border = false
tab_1 tab_1
uo_tab uo_tab
end type
global w_hfn103a w_hfn103a

type variables

end variables

forward prototypes
public function integer wf_dup_chk (long al_row, long al_code)
end prototypes

public function integer wf_dup_chk (long al_row, long al_code);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dup_chk(long al_row, long al_code) return integer
// 인    수 :	al_row : 현재행, al_code : 현재 은행코드
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long	ll_row

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	CDDB.KCH001M
WHERE		CODE = :AL_CODE
AND		TYPE = 'bank_code' ;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 은행코드입니다.')
	return 1
end if

ll_row = idw_update[1].find("code = " + string(al_code), 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 은행코드입니다.')
	return 1
end if

ll_row = idw_update[1].find("code = " + string(al_code), al_row + 1, idw_update[1].rowcount())

if ll_row > 0 then
	messagebox('확인', '이미 등록된 은행코드입니다.')
	return 1
end if

return 0
end function

on w_hfn103a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_tab=create uo_tab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_tab
end on

on w_hfn103a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_tab)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 관리항목자료를 관리한다.
////	작 성 인 : 이현수
////	작성일자 : 2002.11
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//idw_update[1] = tab_1.tabpage_1.dw_update
//idw_print  = tab_1.tabpage_2.dw_print
//
//idw_update[1].reset()
//idw_update[1].sharedata(idw_print)
//idw_print.object.datawindow.print.preview = true
//
//triggerevent('ue_retrieve')
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////



idw_update[1].retrieve() 

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
long	ll_row

ll_row = idw_update[1].getrow()

ll_row = idw_update[1].insertrow(ll_row + 1)

idw_update[1].setitem(ll_row, 'type', 'bank_code')
idw_update[1].setitem(ll_row, 'type_gubun', 'comm')
idw_update[1].setitem(ll_row, 'code_label', 0)
idw_update[1].setitem(ll_row, 'use_gubun', 'Y')
idw_update[1].setitem(ll_row, 'job_uid', gs_empcode)
idw_update[1].setitem(ll_row, 'job_add', gs_ip)
idw_update[1].setitem(ll_row, 'job_date', f_sysdate())

wf_SetMsg('자료가 추가되었습니다.')

idw_update[1].setcolumn('code')
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

ls_null[1] = 'code/은행코드'
ls_null[2] = 'fname/은행명'

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
//	작성목적 : 관리항목자료를 관리한다.
//	작 성 인 : 이현수
//	작성일자 : 2002.11
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
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

type ln_templeft from w_msheet`ln_templeft within w_hfn103a
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn103a
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn103a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn103a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn103a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn103a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn103a
end type

type uc_insert from w_msheet`uc_insert within w_hfn103a
end type

type uc_delete from w_msheet`uc_delete within w_hfn103a
end type

type uc_save from w_msheet`uc_save within w_hfn103a
end type

type uc_excel from w_msheet`uc_excel within w_hfn103a
end type

type uc_print from w_msheet`uc_print within w_hfn103a
end type

type st_line1 from w_msheet`st_line1 within w_hfn103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn103a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn103a
end type

type tab_1 from tab within w_hfn103a
integer x = 59
integer y = 160
integer width = 4384
integer height = 2448
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
integer height = 2328
string text = "은행코드 관리"
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
integer width = 4352
integer height = 1988
integer taborder = 30
string dataobject = "d_hfn103a_1"
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
if dwo.name = 'code' then
	if wf_dup_chk(row, long(data)) > 0 then
		setitem(row, 'code', '')
		return 1
	end if
end if

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
integer height = 2328
string text = "은행코드 리스트"
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
integer x = 9
integer y = 16
integer width = 4334
integer height = 2012
integer taborder = 30
string dataobject = "d_hfn103a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type uo_tab from u_tab within w_hfn103a
event destroy ( )
integer x = 1582
integer y = 140
integer taborder = 120
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

