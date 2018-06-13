$PBExportHeader$w_hfn901a.srw
$PBExportComments$자금집행계획관리
forward
global type w_hfn901a from w_msheet
end type
type tab_1 from tab within w_hfn901a
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
type tab_1 from tab within w_hfn901a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_con from uo_dwfree within w_hfn901a
end type
type uo_tab from u_tab within w_hfn901a
end type
end forward

global type w_hfn901a from w_msheet
string title = "보증금 등록/출력"
tab_1 tab_1
dw_con dw_con
uo_tab uo_tab
end type
global w_hfn901a w_hfn901a

forward prototypes
public function integer wf_dup_chk (long al_row, string as_week, string as_acct_code)
end prototypes

public function integer wf_dup_chk (long al_row, string as_week, string as_acct_code);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_dup_chk(long al_row, string as_week, string as_acct_code) return integer
// 인    수 :	al_row : 현재행, as_week : 주간, as_acct_code : 계정코드
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
string	ls_yyyymm, ls_gwa
long		ll_row

ls_yyyymm = idw_update[1].getitemstring(al_row, 'yyyymm')
ls_gwa    = idw_update[1].getitemstring(al_row, 'gwa')

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	FNDB.HFN401H
WHERE		ACCT_CLASS = :GI_ACCT_CLASS
AND		YYYYMM = :LS_YYYYMM
AND		WEEK = :AS_WEEK
AND		GWA = :LS_GWA
AND		ACCT_CODE = :AS_ACCT_CODE	;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 자료입니다.')
	return 1
end if

ll_row = idw_update[1].find("yyyymm = '" + ls_yyyymm + "' and " + &
								 "gwa = '" + ls_gwa + "' and " + &
								 "week = '" + as_week + "' and " + &
                         "acct_code = '" + as_acct_code + "'", 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 자료입니다.')
	return 1
end if

ll_row = idw_update[1].find("yyyymm = '" + ls_yyyymm + "' and " + &
								 "gwa = '" + ls_gwa + "' and " + &
								 "week = '" + as_week + "' and " + &
                         "acct_code = '" + as_acct_code + "'", al_row + 1, idw_update[1].rowcount())

if ll_row > 0 then
	messagebox('확인', '이미 등록된 자료입니다.')
	return 1
end if

return 0
end function

on w_hfn901a.create
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

on w_hfn901a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_tab)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 자금집행계획 자료를 관리한다.
////	작 성 인 : 이현수
////	작성일자 : 2002.12
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//datawindowchild	ldwc_temp
//
//GI_ACCT_CLASS = uo_acct_class.uf_getcode()
//
//dw_resol_dept.Object.code.Background.mode = 1
//dw_resol_dept.enabled = false
//
//dw_resol_dept.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve(1, 3) = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_resol_dept.InsertRow(0)
//dw_resol_dept.Object.code[1] = gs_DeptCode
//
//idw_update[1] = tab_1.tabpage_1.dw_update
//idw_print  = tab_1.tabpage_2.dw_print
//
//em_yyyymm.text = string(f_today(), '@@@@/@@')
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
String ls_yyyymm
dw_con.accepttext()
ls_yyyymm = String(dw_con.object.yyyymm[1], 'yyyymm')
if not isdate(string(ls_yyyymm + '01', '@@@@/@@/@@')) then
	messagebox('확인', '처리년월을 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('yyyymm')
	return -1
end if


if idw_update[1].retrieve(GI_ACCT_CLASS, ls_yyyymm, dw_con.Object.code[1]) > 0 then
	idw_print.retrieve(GI_ACCT_CLASS, ls_yyyymm, dw_con.Object.code[1])
end if


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
String ls_yyyymm

dw_con.accepttext()
ls_yyyymm = String(dw_con.object.yyyymm[1], 'yyyymm')

if not isdate(String(dw_con.object.yyyymm[1], 'yyyy/mm') + '/01') then
	messagebox('확인', '처리년월을 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('yyyymm')
	return
end if

idw_update[1].setfocus()

ll_row = idw_update[1].getrow()

ll_row = idw_update[1].insertrow(ll_row + 1)
//dw_con.Object.code[1]

idw_update[1].setitem(ll_row, 'acct_class',	GI_ACCT_CLASS)
idw_update[1].setitem(ll_row, 'yyyymm',		ls_yyyymm)
idw_update[1].setitem(ll_row, 'gwa',			dw_con.Object.code[1])
idw_update[1].setitem(ll_row, 'worker', 		gs_empcode)
idw_update[1].setitem(ll_row, 'ipaddr', 		gs_ip)
idw_update[1].setitem(ll_row, 'work_date', 	f_sysdate())

wf_SetMsg('자료가 추가되었습니다.')

idw_update[1].setcolumn('week')
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

ls_null[1] = 'week/주간'
ls_null[2] = 'acct_code/계정코드'
ls_null[3] = 'acct_amt/계획금액'

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
//	작성목적 : 자금집행계획 자료를 관리한다.
//	작 성 인 : 이현수
//	작성일자 : 2002.12
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
datawindowchild	ldwc_temp


dw_con.Object.code.Background.mode = 1
dw_con.object.code.protect = 1

dw_con.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve(1, 3) = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF

dw_con.Object.code[1] = gs_DeptCode

idw_update[1] = tab_1.tabpage_1.dw_update
idw_print  = tab_1.tabpage_2.dw_print

dw_con.object.yyyymm[1] = date(string(f_today(), '@@@@/@@/@@'))

idw_print.object.datawindow.print.preview = true

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "부서 자금집행 계획서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hfn901a
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn901a
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn901a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn901a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn901a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn901a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn901a
end type

type uc_insert from w_msheet`uc_insert within w_hfn901a
end type

type uc_delete from w_msheet`uc_delete within w_hfn901a
end type

type uc_save from w_msheet`uc_save within w_hfn901a
end type

type uc_excel from w_msheet`uc_excel within w_hfn901a
end type

type uc_print from w_msheet`uc_print within w_hfn901a
end type

type st_line1 from w_msheet`st_line1 within w_hfn901a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn901a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn901a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn901a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn901a
end type

type tab_1 from tab within w_hfn901a
integer x = 50
integer y = 328
integer width = 4384
integer height = 2248
integer taborder = 30
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
integer height = 2128
string text = "자금집행계획관리"
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
integer width = 4347
integer height = 1832
integer taborder = 30
string dataobject = "d_hfn901a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com, lstr_Rtn
long			ll_cnt
string		ls_data, ls_acct_code, ls_acct_name

choose case dwo.name
	case 'week'
		if wf_dup_chk(row, data, getitemstring(row, 'acct_code')) > 0 then
			setitem(row, 'week', '')
			return 1
		end if
	case 'acct_code', 'acct_name'
		ls_data = trim(data)
		
		if dwo.name = 'acct_code' then
			select	count(*)	into	:ll_cnt	from	acdb.hac001m
			where		acct_code	like	:ls_data||'%'
			and		jg_gubun = 'Y'	;
		else
			select	count(*)	into	:ll_cnt	from	acdb.hac001m
			where		acct_name	like	:ls_data||'%'
			and		jg_gubun = 'Y'	;
		end if
		
		if ll_cnt < 1 then
			messagebox('확인', '등록된 계정이 없습니다.')
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			return 1
		end if
		
		if ll_cnt = 1 then
			if dwo.name = 'acct_code' then
				select	acct_code, acct_name
				into		:ls_acct_code, :ls_acct_name
				from		acdb.hac001m
				where		acct_code	like	:ls_data||'%'
				and		jg_gubun		=		'Y'	;
			else
				select	acct_code, acct_name
				into		:ls_acct_code, :ls_acct_name
				from		acdb.hac001m
				where		acct_name	like	:ls_data||'%'
				and		jg_gubun		=		'Y'	;
			end if
			
			if wf_dup_chk(row, getitemstring(row, 'week'), ls_acct_code) > 0 then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				return 1
			end if

			setitem(row, 'acct_code', ls_acct_code)
			setitem(row, 'acct_name', ls_acct_name)
			
			return 1
		else
			if dwo.name = 'acct_code' then
				lstr_com.ls_item[1] = trim(data)
				lstr_com.ls_item[2] = ''
				lstr_com.ls_item[3] = string(GI_ACCT_CLASS)
				lstr_com.ls_item[4] = ''
				lstr_com.ls_item[5] = ''
			else
				lstr_com.ls_item[1] = ''
				lstr_com.ls_item[2] = trim(data)
				lstr_com.ls_item[3] = string(GI_ACCT_CLASS)
				lstr_com.ls_item[4] = ''
				lstr_com.ls_item[5] = ''
			end if
			
			openwithparm(w_hfn002h, lstr_com)
			
			lstr_rtn = message.powerobjectparm
			
			if not isvalid(lstr_rtn) then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				return 1
			end if
			
			ls_acct_code	   = lstr_rtn.ls_item[1]
			ls_acct_name 	   = lstr_rtn.ls_item[2]
			
			if wf_dup_chk(row, getitemstring(row, 'week'), ls_acct_code) > 0 then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				return 1
			end if

			setitem(row, 'acct_code', ls_acct_code)
			setitem(row, 'acct_name', ls_acct_name)
		end if
		return 1
end choose

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2128
string text = "자금집행계획서"
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
integer y = 4
integer width = 4347
integer height = 1836
integer taborder = 170
string title = "none"
string dataobject = "d_hfn901a_2"
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_con from uo_dwfree within w_hfn901a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hfn901a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
end event

event itemchanged;call super::itemchanged;Accepttext()
Choose Case dwo.name
	Case 'yyyymm'
		idw_update[1].reset()
		idw_print.reset()
End Choose

end event

type uo_tab from u_tab within w_hfn901a
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

