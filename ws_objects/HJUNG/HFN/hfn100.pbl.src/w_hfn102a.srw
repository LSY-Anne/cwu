$PBExportHeader$w_hfn102a.srw
$PBExportComments$계정과목 조회/출력
forward
global type w_hfn102a from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_1 from cuo_search within tabpage_sheet01
end type
type dw_list003 from cuo_dwwindow within tabpage_sheet01
end type
type dw_list004 from uo_dwgrid within tabpage_sheet01
end type
type dw_update from uo_dwfree within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_list002 from uo_dwgrid within tabpage_sheet02
end type
type gb_5 from groupbox within tabpage_sheet02
end type
type uo_2 from cuo_search within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_list002 dw_list002
gb_5 gb_5
uo_2 uo_2
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type dw_print1 from cuo_dwprint within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_print1 dw_print1
end type
type tabpage_sheet04 from userobject within tab_sheet
end type
type dw_print2 from cuo_dwprint within tabpage_sheet04
end type
type tabpage_sheet04 from userobject within tab_sheet
dw_print2 dw_print2
end type
end forward

global type w_hfn102a from w_tabsheet
integer height = 2472
string title = "계정과목 조회/출력"
end type
global w_hfn102a w_hfn102a

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data, idw_list2, idw_print3, idw_print4
datawindow			idw_remark1, idw_remark2





end variables

forward prototypes
public subroutine wf_dwcopy ()
public function integer wf_retrieve ()
public subroutine wf_getchild ()
public subroutine wf_setitem (string as_colname, string as_data)
public function integer wf_dup_chk (long al_row, string as_acct_code)
public subroutine wf_find ()
end prototypes

public subroutine wf_dwcopy ();// ==========================================================================================
// 기    능 : 	데이타윈도우에 값을 넣는다.
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dwcopy()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_val[]
long		ll_row

ll_row	=	idw_list.getrow()

idw_data.reset()

if ll_row < 1 then	return

ll_row = idw_list.rowscopy(ll_row, ll_row, primary!, idw_data, 1, primary!) 

end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_name
integer	li_tab

li_tab  = tab_sheet.selectedtab


if idw_list.retrieve(gi_acct_class) > 0 then
	idw_list2.retrieve(gi_acct_class)

	idw_print3.retrieve(gi_acct_class)

	
	idw_print4.retrieve(gi_acct_class)

	
	tab_sheet.tabpage_sheet01.uo_1.sle_name.setfocus()
else
	idw_list2.reset()
	idw_print3.reset()
	idw_print4.reset()
	
	
end if

return 0
end function

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 보조부관리항목
idw_data.getchild('mana_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 차변관리항목1
idw_data.getchild('dr_mana_code1', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 차변관리항목2
idw_data.getchild('dr_mana_code2', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 차변관리항목3
idw_data.getchild('dr_mana_code3', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 차변관리항목4
idw_data.getchild('dr_mana_code4', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 대변관리항목1
idw_data.getchild('cr_mana_code1', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 대변관리항목2
idw_data.getchild('cr_mana_code2', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 대변관리항목3
idw_data.getchild('cr_mana_code3', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

// 대변관리항목4
idw_data.getchild('cr_mana_code4', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.insertrow(1)
	idw_child.setitem(1, 'mana_code', 0)
	idw_child.setitem(1, 'mana_name', '없음')
end if

end subroutine

public subroutine wf_setitem (string as_colname, string as_data);// ==========================================================================================
// 기    능 :	datawindow setitem
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_setitem(string as_colname, string as_data)
// 인    수 : 	as_colname 	- 	column name
//				  	as_data		-	data
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_type

ls_type 	= idw_data.describe(as_colname + ".coltype")

idw_data.accepttext()

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(idw_list.getrow(), as_colname, dec(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, dec(as_data))
elseif ls_type = 'date' then
	idw_list.setitem(idw_list.getrow(), as_colname, date(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, date(as_data))
elseif ls_type = 'datetime' then
	idw_list.setitem(idw_list.getrow(), as_colname, datetime(date(left(as_data, 10)), time(right(as_data, 8))))
	idw_data.setitem(idw_data.getrow(), as_colname, datetime(date(left(as_data, 10)), time(right(as_data, 8))))
else	
	idw_list.setitem(idw_list.getrow(), as_colname, trim(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, trim(as_data))
end if

end subroutine

public function integer wf_dup_chk (long al_row, string as_acct_code);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dup_chk(long al_row, long as_acct_code) return integer
// 인    수 :	al_row : 현재행, as_acct_code : 현재 계정코드
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long	ll_row

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	ACDB.HAC001M
WHERE		ACCT_CODE = :AS_ACCT_CODE ;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 계정코드입니다.')
	return 1
end if

ll_row = idw_list.find("acct_code = '" + as_acct_code + "'", 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 계정코드입니다.')
	return 1
end if

ll_row = idw_list.find("acct_code = '" + as_acct_code + "'", al_row + 1, idw_list.rowcount())

if ll_row > 0 then
	messagebox('확인', '이미 등록된 계정코드입니다.')
	return 1
end if

return 0
end function

public subroutine wf_find ();// ==========================================================================================
// 기    능 : 	Find
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_find()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

long		ll_row
string	ls_acct_code

if idw_list.rowcount() < 1 then	return

ls_acct_code = idw_list.getitemstring(idw_list.getrow(), 'acct_code')

ll_row = idw_remark1.find("acct_code = '" + ls_acct_code + "'	", 1, idw_remark1.rowcount())

if ll_row < 1 then
	ll_row = idw_remark1.insertrow(0)
	idw_remark1.scrolltorow(ll_row)
	idw_remark1.setitem(ll_row, 'acct_code', ls_acct_code)
	
	idw_remark2.reset()
	idw_remark2.insertrow(0)
	idw_remark2.setitem(1, 'acct_code', ls_acct_code)
else
	idw_remark1.scrolltorow(ll_row)
	idw_remark2.reset()
	idw_remark2.insertrow(0)
	idw_remark2.setitem(1, 'acct_code', 	ls_acct_code)
	idw_remark2.setitem(1, 'acct_explain',	idw_remark1.getitemstring(ll_row, 'acct_explain'))
end if
end subroutine

on w_hfn102a.create
int iCurrent
call super::create
end on

on w_hfn102a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;// ==========================================================================================
// 작성목정 : data retrieve
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

wf_retrieve()
return 1
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 : window open
//// 작 성 인 : 이현수
//// 작성일자 : 2002.11
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_list		=	tab_sheet.tabpage_sheet01.dw_list001
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_list2	=	tab_sheet.tabpage_sheet02.dw_list002
//idw_print3	=	tab_sheet.tabpage_sheet03.dw_print1
//ist_back3	=	tab_sheet.tabpage_sheet03.st_back1
//idw_print4	=	tab_sheet.tabpage_sheet04.dw_print2
//ist_back4	=	tab_sheet.tabpage_sheet04.st_back2
//
//idw_remark1	=	tab_sheet.tabpage_sheet01.dw_list003
//idw_remark2	=	tab_sheet.tabpage_sheet01.dw_list004
//
//
//
//wf_getchild()
//
//tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_list, 'acct_code', 'acct_name')
//tab_sheet.tabpage_sheet02.uo_2.uf_reset(idw_list2, 'acct_code', 'acct_name')
//
//tab_sheet.selectedtab = 1
//
end event

event ue_print;call super::ue_print;//// ==========================================================================================
//// 작성목정 : data print
//// 작 성 인 : 이현수
//// 작성일자 : 2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//choose	case	tab_sheet.selectedtab
//	case	3
//		IF idw_print3.RowCount() < 1 THEN	return
//
//		OpenWithParm(w_printoption, idw_print3)
//	case else
//		IF idw_print4.RowCount() < 1 THEN	return
//
//		OpenWithParm(w_printoption, idw_print4)
//end choose			
//
end event

event ue_delete;call super::ue_delete;// ==========================================================================================
// 작성목정 : data delete
// 작 성 인 : 이현수
// 작성일자 : 2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

integer		li_deleterow
string		ls_acct_code


wf_setMsg('삭제중')

ls_acct_code	=	idw_list.getitemstring(idw_list.getrow(), 'acct_code')

li_deleterow	=	idw_list.deleterow(0)

li_deleterow	=	idw_remark1.find("acct_code = '" + ls_acct_code + "'	", 1, idw_remark1.rowcount())
if li_deleterow > 0 then
	idw_remark1.deleterow(li_deleterow)
end if

wf_dwcopy()

wf_setMsg('')



end event

event ue_insert;call super::ue_insert;// ==========================================================================================
// 작성목정 : data insert
// 작 성 인 : 이현수
// 작성일자 : 2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

integer	li_newrow, li_newrow2, li_befrow, i
string	ls_slip_class, ls_acct, ls_acct_class, ls_level_class
long		ll_row



//idw_data.Selectrow(0, false)	

idw_data.reset()
li_newrow	=	1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

li_newrow2 	=	idw_list.getrow() + 1
idw_list.insertrow(li_newrow2)
idw_list.setrow(li_newrow2)
idw_list.scrolltorow(li_newrow2)

if li_newrow2 > 0 then
	idw_data.setitem(li_newrow, 'acct_class_gbn', '99999')
	idw_data.setitem(li_newrow, 'drcr_class', 'D')
	idw_data.setitem(li_newrow, 'bdgt_cntl_yn', 'Y')
	idw_data.setitem(li_newrow, 'bs_gubun', 'N')
	idw_data.setitem(li_newrow, 'is_gubun', 'N')
	idw_data.setitem(li_newrow, 'jg_gubun', 'N')
	idw_data.setitem(li_newrow, 'wonga_gubun', 'N')
	idw_data.setitem(li_newrow, 'suip_gubun', 'Y')
	idw_data.setitem(li_newrow, 'jichul_gubun', 'Y')
	idw_data.setitem(li_newrow, 'acct_use_opt', 'Y')
	idw_data.setitem(li_newrow, 'mi_acct_yn', 'N')
	idw_data.setitem(li_newrow, 'mana_code', 0)
	idw_data.setitem(li_newrow, 'dr_mana_code1', 0)
	idw_data.setitem(li_newrow, 'dr_mana_code2', 0)
	idw_data.setitem(li_newrow, 'dr_mana_code3', 0)
	idw_data.setitem(li_newrow, 'dr_mana_code4', 0)
	idw_data.setitem(li_newrow, 'cr_mana_code1', 0)
	idw_data.setitem(li_newrow, 'cr_mana_code2', 0)
	idw_data.setitem(li_newrow, 'cr_mana_code3', 0)
	idw_data.setitem(li_newrow, 'cr_mana_code4', 0)
	
	idw_list.setitem(li_newrow2, 'acct_class_gbn', '99999')
	idw_list.setitem(li_newrow2, 'drcr_class', 'D')
	idw_list.setitem(li_newrow2, 'bdgt_cntl_yn', 'Y')
	idw_list.setitem(li_newrow2, 'bs_gubun', 'N')
	idw_list.setitem(li_newrow2, 'is_gubun', 'N')
	idw_list.setitem(li_newrow2, 'jg_gubun', 'N')
	idw_list.setitem(li_newrow2, 'wonga_gubun', 'N')
	idw_list.setitem(li_newrow2, 'suip_gubun', 'Y')
	idw_list.setitem(li_newrow2, 'jichul_gubun', 'Y')
	idw_list.setitem(li_newrow2, 'acct_use_opt', 'Y')
	idw_list.setitem(li_newrow2, 'mana_code', 0)
	idw_list.setitem(li_newrow2, 'dr_mana_code1', 0)
	idw_list.setitem(li_newrow2, 'dr_mana_code2', 0)
	idw_list.setitem(li_newrow2, 'dr_mana_code3', 0)
	idw_list.setitem(li_newrow2, 'dr_mana_code4', 0)
	idw_list.setitem(li_newrow2, 'cr_mana_code1', 0)
	idw_list.setitem(li_newrow2, 'cr_mana_code2', 0)
	idw_list.setitem(li_newrow2, 'cr_mana_code3', 0)
	idw_list.setitem(li_newrow2, 'cr_mana_code4', 0)
end if

wf_find()

idw_list.setitem(li_newrow2, 'worker',		gs_empcode)
idw_list.setitem(li_newrow2, 'ipaddr',		gs_ip)
idw_list.setitem(li_newrow2, 'work_date',	f_sysdate())

idw_data.setcolumn('acct_code')
idw_data.setfocus()



end event

event ue_save;call super::ue_save;// ==========================================================================================
// 작성목정 : data save
// 작 성 인 : 이현수
// 작성일자 : 2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

cuo_dwwindow	dw_name
integer	li_findrow
string	ls_null[]

idw_data.accepttext()
idw_list.accepttext()

if idw_list.modifiedcount() < 1 and idw_list.deletedcount() < 1 then
	wf_SetMsg('변경된 자료가 없습니다.')
	return -1
end if

ls_null[1] = 'acct_code/계정코드'
ls_null[2] = 'acct_name/계정코드명'
ls_null[3] = 'acct_iname/수입계정코드명'
ls_null[2] = 'acct_oname/지출계정코드명'

if f_chk_null(idw_list, ls_null) = -1 then return -1



dw_name   = idw_list  	                 		//저장하고자하는 데이타 원도우

IF dw_name.Update(true) = 1 or idw_remark1.update() = 1 THEN
	delete	from	acdb.hac002m
	where		acct_explain	is null 
	or 		rtrim(acct_explain) = ''	;
	
	COMMIT;
	
	idw_remark1.retrieve(gi_acct_class)
	triggerevent('ue_retrieve')
ELSE
  ROLLBACK;
END IF



end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 : window open
// 작 성 인 : 이현수
// 작성일자 : 2002.11
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_list2	=	tab_sheet.tabpage_sheet02.dw_list002
idw_print3	=	tab_sheet.tabpage_sheet03.dw_print1
idw_print = idw_print3

idw_print4	=	tab_sheet.tabpage_sheet04.dw_print2


idw_remark1	=	tab_sheet.tabpage_sheet01.dw_list003
idw_remark2	=	tab_sheet.tabpage_sheet01.dw_list004



wf_getchild()

tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_list, 'acct_code', 'acct_name')
tab_sheet.tabpage_sheet02.uo_2.uf_reset(idw_list2, 'acct_code', 'acct_name')

tab_sheet.selectedtab = 1

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

type ln_templeft from w_tabsheet`ln_templeft within w_hfn102a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hfn102a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hfn102a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hfn102a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hfn102a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hfn102a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hfn102a
end type

type uc_insert from w_tabsheet`uc_insert within w_hfn102a
end type

type uc_delete from w_tabsheet`uc_delete within w_hfn102a
end type

type uc_save from w_tabsheet`uc_save within w_hfn102a
end type

type uc_excel from w_tabsheet`uc_excel within w_hfn102a
end type

type uc_print from w_tabsheet`uc_print within w_hfn102a
end type

type st_line1 from w_tabsheet`st_line1 within w_hfn102a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hfn102a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hfn102a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hfn102a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hfn102a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hfn102a
integer y = 188
integer width = 4384
integer height = 2176
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
tabpage_sheet04 tabpage_sheet04
end type

event tab_sheet::selectionchanged;call super::selectionchanged;choose case newindex
	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
		idw_print = idw_print3
	case 2
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		FALSE)
		idw_print = idw_print3
	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
		If newindex = 3 Then
			idw_print = idw_print3
		Else
			idw_print = idw_print4
		End If
end choose
end event

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
this.tabpage_sheet03=create tabpage_sheet03
this.tabpage_sheet04=create tabpage_sheet04
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
this.Control[iCurrent+2]=this.tabpage_sheet03
this.Control[iCurrent+3]=this.tabpage_sheet04
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
destroy(this.tabpage_sheet03)
destroy(this.tabpage_sheet04)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 2056
long backcolor = 1073741824
string text = "계정과목관리"
gb_4 gb_4
uo_1 uo_1
dw_list003 dw_list003
dw_list004 dw_list004
dw_update dw_update
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.uo_1=create uo_1
this.dw_list003=create dw_list003
this.dw_list004=create dw_list004
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_list003
this.Control[iCurrent+4]=this.dw_list004
this.Control[iCurrent+5]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_1)
destroy(this.dw_list003)
destroy(this.dw_list004)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 101
integer height = 100
string dataobject = "d_hfn102a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)

wf_dwcopy()
wf_find()


end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	idw_remark2.reset()
	return
end if

idw_remark1.retrieve(gi_acct_class)

trigger event rowfocuschanged(getrow())

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 168
integer width = 1934
integer height = 1856
string dataobject = "d_hfn102a_1"
end type

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	idw_remark2.reset()
	return
end if

idw_remark1.retrieve(gi_acct_class)

trigger event rowfocuschanged(getrow())

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)

wf_dwcopy()
wf_find()


end event

type uo_tab from w_tabsheet`uo_tab within w_hfn102a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hfn102a
boolean visible = false
integer width = 101
integer height = 100
end type

type st_con from w_tabsheet`st_con within w_hfn102a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_4 from groupbox within tabpage_sheet01
integer x = -73
integer y = -296
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type uo_1 from cuo_search within tabpage_sheet01
integer x = 114
integer y = 40
integer width = 3392
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_search::destroy
end on

type dw_list003 from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 2565
integer y = 1916
integer width = 512
integer height = 224
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hfn102a_4"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_list004 from uo_dwgrid within tabpage_sheet01
integer x = 1952
integer y = 1624
integer width = 2395
integer height = 392
integer taborder = 110
string dataobject = "d_hfn102a_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;accepttext()

idw_remark1.setitem(idw_remark1.getrow(), 'acct_explain', trim(data))

end event

event losefocus;call super::losefocus;accepttext()
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 1952
integer y = 168
integer width = 2395
integer height = 1448
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_hfn102a_2"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long		ll_row
string	ls_col, ls_type

ll_row = idw_list.getrow()

choose case dwo.name
	case 'acct_code'
		if not isnull(data) and trim(data) <> '' then
			if len(trim(data)) <> 6 then
				messagebox('확인', '계정코드는 6자리로 입력하시기 바랍니다.')
				return 1
			end if
		end if
		
		// 자료 중복 Check
		if wf_dup_chk(ll_row, data) > 0 then
			idw_data.setitem(row, 'acct_code', '')
			return 1
		end if
		
		// 관항목 정리
		if mid(data,3,4) = '0000' then
			setitem(row, 'level_class', '1')
			setitem(row, 'large_acct', '')
			setitem(row, 'middle_acct', '')
			setitem(row, 'mok_acct', '')
			idw_list.setitem(ll_row, 'level_class', '1')
			idw_list.setitem(ll_row, 'large_acct', '')
			idw_list.setitem(ll_row, 'middle_acct', '')
			idw_list.setitem(ll_row, 'mok_acct', '')
		elseif mid(data,4,3) = '000' then
			setitem(row, 'level_class', '2')
			setitem(row, 'large_acct', mid(data,1,2)+'00')
			setitem(row, 'middle_acct', '')
			setitem(row, 'mok_acct', '')
			idw_list.setitem(ll_row, 'level_class', '2')
			idw_list.setitem(ll_row, 'large_acct', mid(data,1,2)+'00')
			idw_list.setitem(ll_row, 'middle_acct', '')
			idw_list.setitem(ll_row, 'mok_acct', '')
		elseif mid(data,5,2) = '00' then
			setitem(row, 'level_class', '3')
			setitem(row, 'large_acct', mid(data,1,2)+'00')
			setitem(row, 'middle_acct', mid(data,1,3)+'0')
			setitem(row, 'mok_acct', '')
			idw_list.setitem(ll_row, 'level_class', '3')
			idw_list.setitem(ll_row, 'large_acct', mid(data,1,2)+'00')
			idw_list.setitem(ll_row, 'middle_acct', mid(data,1,3)+'0')
			idw_list.setitem(ll_row, 'mok_acct', '')
		else
			setitem(row, 'level_class', '4')
			setitem(row, 'large_acct', mid(data,1,2)+'00')
			setitem(row, 'middle_acct', mid(data,1,3)+'0')
			setitem(row, 'mok_acct', mid(data,1,4))
			idw_list.setitem(ll_row, 'level_class', '4')
			idw_list.setitem(ll_row, 'large_acct', mid(data,1,2)+'00')
			idw_list.setitem(ll_row, 'middle_acct', mid(data,1,3)+'0')
			idw_list.setitem(ll_row, 'mok_acct', mid(data,1,4))
		end if
	case 'mana_code'
		if data <> '0' then
			setitem(row, 'dr_mana_code1', integer(data))
			setitem(row, 'cr_mana_code1', integer(data))
			idw_list.setitem(ll_row, 'dr_mana_code1', integer(data))
			idw_list.setitem(ll_row, 'cr_mana_code1', integer(data))
		end if
	case 'dr_mana_code1'
		if getitemnumber(row, 'mana_code') <> 0 then
			if integer(data) <> getitemnumber(row, 'mana_code') then
				messagebox('확인', '차변의 관리항목1과 보조부관리항목이 일치하지 않습니다.')
				setitem(row, 'dr_mana_code1', getitemnumber(row, 'mana_code'))
				return 1
			end if
		end if
	case 'cr_mana_code1'
		if getitemnumber(row, 'mana_code') <> 0 then
			if integer(data) <> getitemnumber(row, 'mana_code') then
				messagebox('확인', '대변의 관리항목1과 보조부관리항목이 일치하지 않습니다.')
				setitem(row, 'cr_mana_code1', getitemnumber(row, 'mana_code'))
				return 1
			end if
		end if
end choose

ls_col 	= dwo.name
ls_type 	= describe(ls_col + ".coltype")

// 변경 자료 옮기기
if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(ll_row, ls_col, dec(data))
elseif ls_type = 'date' then
	idw_list.setitem(ll_row, ls_col, date(data))
else
	idw_list.setitem(ll_row, ls_col, data)
end if

wf_find()

wf_setitem('job_uid',	gs_empcode)
wf_setitem('job_add',	gs_ip)
wf_setitem('job_date',	string(f_sysdate(), 'yyyy/mm/dd hh:mm:ss'))

end event

event itemerror;call super::itemerror;return 1
end event

event losefocus;call super::losefocus;accepttext()
end event

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_dw(dw_update)
This.insertrow(0)
end event

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 2056
string text = "계정과목행별조회"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list002 dw_list002
gb_5 gb_5
uo_2 uo_2
end type

on tabpage_sheet02.create
this.dw_list002=create dw_list002
this.gb_5=create gb_5
this.uo_2=create uo_2
this.Control[]={this.dw_list002,&
this.gb_5,&
this.uo_2}
end on

on tabpage_sheet02.destroy
destroy(this.dw_list002)
destroy(this.gb_5)
destroy(this.uo_2)
end on

type dw_list002 from uo_dwgrid within tabpage_sheet02
integer y = 172
integer width = 4347
integer height = 1868
integer taborder = 20
string dataobject = "d_hfn102a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_5 from groupbox within tabpage_sheet02
integer y = -20
integer width = 4347
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

type uo_2 from cuo_search within tabpage_sheet02
event destroy ( )
integer x = 114
integer y = 40
integer width = 3483
integer taborder = 50
boolean bringtotop = true
end type

on uo_2.destroy
call cuo_search::destroy
end on

type tabpage_sheet03 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2056
string text = "계정과목약식내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print1 dw_print1
end type

on tabpage_sheet03.create
this.dw_print1=create dw_print1
this.Control[]={this.dw_print1}
end on

on tabpage_sheet03.destroy
destroy(this.dw_print1)
end on

type dw_print1 from cuo_dwprint within tabpage_sheet03
integer width = 4347
integer height = 2056
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hfn102a_5"
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet04 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2056
string text = "계정과목상세내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print2 dw_print2
end type

on tabpage_sheet04.create
this.dw_print2=create dw_print2
this.Control[]={this.dw_print2}
end on

on tabpage_sheet04.destroy
destroy(this.dw_print2)
end on

type dw_print2 from cuo_dwprint within tabpage_sheet04
integer width = 4343
integer height = 2056
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hfn102a_6"
boolean vscrollbar = true
boolean border = false
end type

