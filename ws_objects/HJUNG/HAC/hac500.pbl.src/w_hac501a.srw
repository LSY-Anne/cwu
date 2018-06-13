$PBExportHeader$w_hac501a.srw
$PBExportComments$배정예산 편성 관리(예산부서용)
forward
global type w_hac501a from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_1 from cuo_search within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
end forward

global type w_hac501a from w_tabsheet
string title = "배정예산 편성 관리(예산/주관부서용)"
end type
global w_hac501a w_hac501a

type variables
datawindowchild	idw_child, idw_child2
datawindow			idw_mast
datawindow			idw_1



integer	ii_stat_class	=	41					// 상태(41 = 예산편성)
integer	ii_bdgt_class	=	0					// 예산차수
integer	ii_work_seq

string	is_pay_date								// 배정예산일

long		il_currentrow
string	is_dept_name							// 로긴부서명
string	is_gwa									// 조회용 학과
end variables

forward prototypes
public subroutine wf_delete ()
public subroutine wf_save ()
public subroutine wf_getchild ()
public function integer wf_retrieve ()
public subroutine wf_retrieve_preview ()
public subroutine wf_insert ()
public function integer wf_dup_chk (string as_bdgt_year, string as_gwa, string as_acct_code, integer ai_acct_class, string as_io_gubun, long al_row)
public subroutine wf_button_control (integer ai_index)
end prototypes

public subroutine wf_delete ();// ==========================================================================================
// 기    능 : 	delete
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_delete()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer		li_deleterow

if il_currentrow = 0 or idw_mast.rowcount() = 0 then	return

if idw_mast.getitemnumber(il_currentrow, 'assn_temp_amt') <> 0 or	&
	idw_mast.getitemnumber(il_currentrow, 'assn_real_amt') <> 0 or &
	idw_mast.getitemnumber(il_currentrow, 'assn_1st_amt') <> 0	or &
	idw_mast.getitemnumber(il_currentrow, 'assn_2nd_amt') <> 0	or &
	idw_mast.getitemnumber(il_currentrow, 'assn_3rd_amt') <> 0	or &
	idw_mast.getitemnumber(il_currentrow, 'assn_tran_amt') <> 0	then
	f_messagebox('3', '자료를 삭제할 수 없습니다.!')
	return
end if

li_deleterow	=	idw_mast.deleterow(0)

end subroutine

public subroutine wf_save ();// ==========================================================================================
// 기    능 : 	save
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_save()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

if idw_mast.update() = 1 then
	COMMIT;
	return
end if

ROLLBACK;

end subroutine

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
// 요구부서
dw_con.getchild('code', idw_child)
idw_child.settransobject(sqlca)
idw_child.retrieve(1,3)
idw_child.insertrow(1)
idw_child.setitem(1,'dept_code','')
idw_child.setitem(1,'dept_name','전체')

dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
//is_bdgt_year = left(f_today(), 4)
//is_slip_class = '2'
//
// 단위부서
idw_mast.getchild('gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_name, ls_bdgt_year, ls_gwa, ls_slip_class
integer	li_tab

li_tab  = tab_sheet.selectedtab
wf_button_control(li_tab)



dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1] , 'yyyy')
ls_gwa = dw_con.object.code[1]
ls_slip_class = dw_con.object.slip_class[1]


if idw_mast.retrieve(ls_bdgt_year, ls_gwa, gi_acct_class, ls_slip_class) > 0 then
	wf_retrieve_preview()
else
	idw_print.reset()
	
	dw_con.setfocus()
	dw_con.setcolumn('year')
end if

return 0
end function

public subroutine wf_retrieve_preview ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve_preview()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String ls_bdgt_year, ls_gwa, ls_slip_class
dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1] , 'yyyy')
ls_gwa = dw_con.object.code[1]
ls_slip_class = dw_con.object.slip_class[1]
If ls_slip_class = '%' Then ls_slip_class = ''
if idw_print.retrieve(ls_bdgt_year, ls_gwa, gi_acct_class, ls_slip_class) < 1 then

else

end if

end subroutine

public subroutine wf_insert ();// ==========================================================================================
// 기    능 : 	insert
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_insert()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_newrow
string	ls_dept_code, ls_acct_code, ls_gwa, ls_bdgt_year, ls_slip_class

dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1] , 'yyyy')
ls_gwa = dw_con.object.code[1]
ls_slip_class = dw_con.object.slip_class[1]


if len(trim(ls_bdgt_year)) < 4 or trim(ls_bdgt_year) = '0000' then
	f_messagebox('1', '예산년도를 정확히 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	return
end if

if isnull(ls_gwa) or trim(ls_gwa) = '' then
	f_messagebox('1', '요구부서를 정확히 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('code')
	return
end if

li_newrow	=	idw_mast.getrow() + 1

idw_mast.insertrow(li_newrow)

idw_mast.setitem(li_newrow, 'bdgt_year',	ls_bdgt_year)
idw_mast.setitem(li_newrow, 'gwa',	ls_gwa)
idw_mast.setitem(li_newrow, 'acct_class',	gi_acct_class)
idw_mast.setitem(li_newrow, 'io_gubun',	ls_slip_class)
idw_mast.setitem(li_newrow, 'assn_bdgt_date',	f_today())
idw_mast.setitem(li_newrow, 'worker',		gs_empcode)
idw_mast.setitem(li_newrow, 'ipaddr',		gs_ip)
idw_mast.setitem(li_newrow, 'work_date',	f_sysdate())

idw_mast.setrow(li_newrow)
idw_mast.scrolltorow(li_newrow)
idw_mast.setcolumn('acct_code')
idw_mast.setfocus()
end subroutine

public function integer wf_dup_chk (string as_bdgt_year, string as_gwa, string as_acct_code, integer ai_acct_class, string as_io_gubun, long al_row);// ==========================================================================================
// 기    능 : 	Data Duplicate Check
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_duplicate_chk(string	as_bdgt_year, string	as_gwa, string	as_acct_code, integer ai_acct_class, string as_io_gubun, long al_row)
// 인    수 :	as_bdgt_year	-	예산년도
//					as_gwa			-	부서
//					as_acct_code	-	계정과목코드
//					ai_acct_class	-	회계단위
//					as_io_gubun		-	수입/지출구분
//					al_row			-	해당행
// 되 돌 림 :	integer
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long		ll_row

select	count(*)	into	:ll_row
from		acdb.hac012m
where		bdgt_year 	= :as_bdgt_year
and		gwa 			= :as_gwa
and		acct_code 	= :as_acct_code
and		acct_class 	= :ai_acct_class
and		io_gubun 	= :as_io_gubun ;

if ll_row	>	0	then
	f_messagebox('1', '자료가 중복되었습니다.~n~n확인 후 다시 입력해 주시기 바랍니다.!')
	idw_mast.setcolumn('acct_code')
	return	1
end if

ll_row = idw_mast.find("bdgt_year = '" + as_bdgt_year + "' and " + &
							  "gwa = '" 		+ as_gwa + "' and " + &
							  "acct_code = '" + as_acct_code + "' and " + &
							  "acct_class = " + string(ai_acct_class) + " and " + &
							  "io_gubun = '" 	+ as_io_gubun + "'", 1, al_row - 1)

if ll_row	>	0	then
	f_messagebox('1', '자료가 중복되었습니다.~n~n확인 후 다시 입력해 주시기 바랍니다.!')
	idw_mast.setcolumn('acct_code')
	return	1
end if

ll_row = idw_mast.find("bdgt_year = '" + as_bdgt_year + "' and " + &
							  "gwa = '" 		+ as_gwa + "' and " + &
							  "acct_code = '" + as_acct_code + "' and " + &
							  "acct_class = " + string(ai_acct_class) + " and " + &
							  "io_gubun = '" 	+ as_io_gubun + "'", al_row + 1, idw_mast.rowcount())

if ll_row	>	0	then
	f_messagebox('1', '자료가 중복되었습니다.~n~n확인 후 다시 입력해 주시기 바랍니다.!')
	idw_mast.setcolumn('acct_code')
	return	1
end if

return	0

end function

public subroutine wf_button_control (integer ai_index);//// ==========================================================================================
//// 기    능 : 	button control
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.10
//// 함수원형 : 	wf_button_control(integer	ai_index)
//// 인    수 :	ai_index	-	tabpage index
//// 되 돌 림 :
//// 주의사항 :
//// 수정사항 :
//// ==========================================================================================
//
//choose case ai_index
//	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		FALSE)
//	case 2
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
//	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		FALSE)
//end choose
end subroutine

on w_hac501a.create
int iCurrent
call super::create
end on

on w_hac501a.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
wf_setMsg('조회중')

wf_retrieve()

wf_setMsg('')
//f_setpointer('END')
RETURN 1
end event

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////



wf_insert()

wf_setMsg('')


end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_mast			=	tab_sheet.tabpage_sheet01.dw_list001
//idw_print		=	tab_sheet.tabpage_sheet02.dw_print
//ist_back			=	tab_sheet.tabpage_sheet02.st_back
//
//
//
//wf_getchild()
//
//
//
//
//is_gwa			=	gs_deptcode	
//dw_con.setitem(1, 'code', gs_deptcode)
//
//idw_1 = idw_mast
//
//tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_mast, 'acct_code', 'acct_name')
//
//is_pay_date = f_today()
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('저장중')

wf_save()
wf_retrieve_preview()

wf_setMsg('')

return 1

end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
wf_setMsg('삭제중')

wf_delete()

wf_setMsg('')
//f_setpointer('END')

return 

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
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_mast			=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_print		=	tab_sheet.tabpage_sheet02.dw_print

wf_getchild()

is_gwa			=	gs_deptcode	
dw_con.setitem(1, 'code', gs_deptcode)

idw_1 = idw_mast

tab_sheet.tabpage_sheet01.uo_1.uf_reset(idw_mast, 'acct_code', 'acct_name')

is_pay_date = f_today()

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

type ln_templeft from w_tabsheet`ln_templeft within w_hac501a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac501a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac501a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac501a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac501a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac501a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac501a
end type

type uc_insert from w_tabsheet`uc_insert within w_hac501a
end type

type uc_delete from w_tabsheet`uc_delete within w_hac501a
end type

type uc_save from w_tabsheet`uc_save within w_hac501a
end type

type uc_excel from w_tabsheet`uc_excel within w_hac501a
end type

type uc_print from w_tabsheet`uc_print within w_hac501a
end type

type st_line1 from w_tabsheet`st_line1 within w_hac501a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac501a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac501a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac501a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac501a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac501a
integer y = 316
integer width = 4384
integer height = 1956
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;if newindex < 1 then	return

wf_button_control(newindex)
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
long backcolor = 1073741824
string text = "배정예산등록/관리"
gb_4 gb_4
uo_1 uo_1
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.uo_1=create uo_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_1
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_1)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 101
integer height = 100
string dataobject = "d_hac501a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::getfocus;call super::getfocus;idw_1 = this
end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(False)
end event

event dw_list001::itemchanged;call super::itemchanged;string		ls_acct_code, ls_acct_name, ls_bdgt_year, ls_io_gubun, ls_gwa,ls_slip_class
integer		li_acct_class
long			ll_cnt
s_insa_com	lstr_com, lstr_Rtn

dw_con.accepttext()
ls_slip_class = dw_con.object.slip_class[1]

if	dwo.name = 'acct_code' then
	ls_bdgt_year  = getitemstring(row, 'bdgt_year')
	ls_gwa        = getitemstring(row, 'gwa')
	ls_acct_code  = trim(data) + '%'
	li_acct_class = getitemnumber(row, 'acct_class')
	ls_io_gubun   = getitemstring(row, 'io_gubun')
		
	select	count(*)	into	:ll_cnt
	from		acdb.hac001m
	where		acct_code	like	:ls_acct_code
	and		jg_gubun = 'Y'
	and		level_class = '4'
	and		decode(:ls_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
		
	if ll_cnt < 1 then
		setitem(row, 'acct_code', '')
		setitem(row, 'acct_name', '')
		messagebox('확인', '등록되지 않은 자금계정코드입니다.')
		return 1
	end if
		
	if ll_cnt = 1 then
		if wf_dup_chk(ls_bdgt_year, ls_gwa, data, li_acct_class, ls_io_gubun, row)	=	1	then	
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			return	1
		end if

		select	decode(:ls_slip_class,'1',acct_iname,'2',acct_oname,acct_name)	into	:ls_acct_name
		from		acdb.hac001m
		where		acct_code	like	:ls_acct_code
		and		jg_gubun = 'Y'
		and		level_class = '4'
		and		decode(:ls_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
			
		setitem(row, 'acct_code', trim(data))
		setitem(row, 'acct_name', trim(ls_acct_name))
	else
		lstr_com.ls_item[1]	=	trim(data)
		lstr_com.ls_item[2]	=	''
		lstr_com.ls_item[3]	=	string(li_acct_class)
		lstr_com.ls_item[4]	=	ls_io_gubun

		OpenWithParm(w_hac001h, lstr_com)

		lstr_Rtn = Message.PowerObjectParm

		if not isvalid(lstr_rtn) then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			return 1
		end if

		if wf_dup_chk(ls_bdgt_year, ls_gwa, lstr_Rtn.ls_item[1], li_acct_class, ls_io_gubun, row)	=	1	then	
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			return	1
		end if

		setitem(row, 'acct_code', lstr_Rtn.ls_item[1])
		setitem(row, 'acct_name', lstr_Rtn.ls_item[2])
		return 1
	end if
/* 2007.05.31
elseif dwo.name = 'assn_bdgt_amt' then
	setitem(row, 'assn_used_amt', dec(data))
*/
elseif dwo.name = 'assn_bdgt_amt' or dwo.name = 'assn_1st_amt' or &
		 dwo.name = 'assn_2nd_amt'  or dwo.name = 'assn_3rd_amt' or dwo.name = 'assn_tran_amt' then

	decimal	ldec_bdgt_amt, ldec_1st_amt, ldec_2nd_amt, ldec_3rd_amt, ldec_tran_amt, ldec_used_amt
	decimal	ldec_temp_amt, ldec_real_amt
	
	if dwo.name = 'assn_bdgt_amt' then
		ldec_bdgt_amt = dec(data)
	else
		ldec_bdgt_amt = getitemdecimal(row, 'assn_bdgt_amt')
	end if
	
	if dwo.name = 'assn_1st_amt' then
		ldec_1st_amt = dec(data)
	else
		ldec_1st_amt = getitemdecimal(row, 'assn_1st_amt')
	end if
	
	if dwo.name = 'assn_2nd_amt' then
		ldec_2nd_amt = dec(data)
	else
		ldec_2nd_amt = getitemdecimal(row, 'assn_2nd_amt')
	end if

	if dwo.name = 'assn_3rd_amt' then
		ldec_3rd_amt = dec(data)
	else
		ldec_3rd_amt = getitemdecimal(row, 'assn_3rd_amt')
	end if

	if dwo.name = 'assn_tran_amt' then
		ldec_tran_amt = dec(data)
	else
		ldec_tran_amt = getitemdecimal(row, 'assn_tran_amt')
	end if

	if isnull(ldec_bdgt_amt) then ldec_bdgt_amt = 0
	if isnull(ldec_1st_amt)  then ldec_1st_amt = 0
	if isnull(ldec_2nd_amt)  then ldec_2nd_amt = 0
	if isnull(ldec_3rd_amt)  then ldec_3rd_amt = 0
	if isnull(ldec_tran_amt) then ldec_tran_amt = 0
	
	ldec_used_amt = ldec_bdgt_amt + ldec_1st_amt + ldec_2nd_amt + ldec_3rd_amt + ldec_tran_amt
	
	setitem(row, 'assn_used_amt', ldec_used_amt)
	
	ldec_temp_amt = getitemdecimal(row, 'assn_temp_amt')
	ldec_real_amt = getitemdecimal(row, 'assn_real_amt')
	
	if isnull(ldec_temp_amt) then ldec_temp_amt = 0
	if isnull(ldec_real_amt) then ldec_real_amt = 0
	
	setitem(row, 'remain_amt', ldec_used_amt - ldec_temp_amt - ldec_real_amt)
end if

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event dw_list001::losefocus;call super::losefocus;accepttext()
end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then return

trigger event rowfocuschanged(getrow())

end event

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then
	return
end if

il_currentrow = currentrow


end event

event dw_list001::clicked;call super::clicked;if isnull(row) or row < 1 then return

trigger event rowfocuschanged(row)
end event

event dw_list001::itemerror;call super::itemerror;return 1
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 168
integer width = 4338
integer height = 1652
string dataobject = "d_hac501a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;string		ls_acct_code, ls_acct_name, ls_bdgt_year, ls_io_gubun, ls_gwa,ls_slip_class
integer		li_acct_class
long			ll_cnt
s_insa_com	lstr_com, lstr_Rtn

dw_con.accepttext()
ls_slip_class = dw_con.object.slip_class[1]

if	dwo.name = 'acct_code' then
	ls_bdgt_year  = getitemstring(row, 'bdgt_year')
	ls_gwa        = getitemstring(row, 'gwa')
	ls_acct_code  = trim(data) + '%'
	li_acct_class = getitemnumber(row, 'acct_class')
	ls_io_gubun   = getitemstring(row, 'io_gubun')
		
	select	count(*)	into	:ll_cnt
	from		acdb.hac001m
	where		acct_code	like	:ls_acct_code
	and		jg_gubun = 'Y'
	and		level_class = '4'
	and		decode(:ls_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
		
	if ll_cnt < 1 then
		setitem(row, 'acct_code', '')
		setitem(row, 'acct_name', '')
		messagebox('확인', '등록되지 않은 자금계정코드입니다.')
		return 1
	end if
		
	if ll_cnt = 1 then
		if wf_dup_chk(ls_bdgt_year, ls_gwa, data, li_acct_class, ls_io_gubun, row)	=	1	then	
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			return	1
		end if

		select	decode(:ls_slip_class,'1',acct_iname,'2',acct_oname,acct_name)	into	:ls_acct_name
		from		acdb.hac001m
		where		acct_code	like	:ls_acct_code
		and		jg_gubun = 'Y'
		and		level_class = '4'
		and		decode(:ls_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
			
		setitem(row, 'acct_code', trim(data))
		setitem(row, 'acct_name', trim(ls_acct_name))
	else
		lstr_com.ls_item[1]	=	trim(data)
		lstr_com.ls_item[2]	=	''
		lstr_com.ls_item[3]	=	string(li_acct_class)
		lstr_com.ls_item[4]	=	ls_io_gubun

		OpenWithParm(w_hac001h, lstr_com)

		lstr_Rtn = Message.PowerObjectParm

		if not isvalid(lstr_rtn) then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			return 1
		end if

		if wf_dup_chk(ls_bdgt_year, ls_gwa, lstr_Rtn.ls_item[1], li_acct_class, ls_io_gubun, row)	=	1	then	
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
			return	1
		end if

		setitem(row, 'acct_code', lstr_Rtn.ls_item[1])
		setitem(row, 'acct_name', lstr_Rtn.ls_item[2])
		return 1
	end if
/* 2007.05.31
elseif dwo.name = 'assn_bdgt_amt' then
	setitem(row, 'assn_used_amt', dec(data))
*/
elseif dwo.name = 'assn_bdgt_amt' or dwo.name = 'assn_1st_amt' or &
		 dwo.name = 'assn_2nd_amt'  or dwo.name = 'assn_3rd_amt' or dwo.name = 'assn_tran_amt' then

	decimal	ldec_bdgt_amt, ldec_1st_amt, ldec_2nd_amt, ldec_3rd_amt, ldec_tran_amt, ldec_used_amt
	decimal	ldec_temp_amt, ldec_real_amt
	
	if dwo.name = 'assn_bdgt_amt' then
		ldec_bdgt_amt = dec(data)
	else
		ldec_bdgt_amt = getitemdecimal(row, 'assn_bdgt_amt')
	end if
	
	if dwo.name = 'assn_1st_amt' then
		ldec_1st_amt = dec(data)
	else
		ldec_1st_amt = getitemdecimal(row, 'assn_1st_amt')
	end if
	
	if dwo.name = 'assn_2nd_amt' then
		ldec_2nd_amt = dec(data)
	else
		ldec_2nd_amt = getitemdecimal(row, 'assn_2nd_amt')
	end if

	if dwo.name = 'assn_3rd_amt' then
		ldec_3rd_amt = dec(data)
	else
		ldec_3rd_amt = getitemdecimal(row, 'assn_3rd_amt')
	end if

	if dwo.name = 'assn_tran_amt' then
		ldec_tran_amt = dec(data)
	else
		ldec_tran_amt = getitemdecimal(row, 'assn_tran_amt')
	end if

	if isnull(ldec_bdgt_amt) then ldec_bdgt_amt = 0
	if isnull(ldec_1st_amt)  then ldec_1st_amt = 0
	if isnull(ldec_2nd_amt)  then ldec_2nd_amt = 0
	if isnull(ldec_3rd_amt)  then ldec_3rd_amt = 0
	if isnull(ldec_tran_amt) then ldec_tran_amt = 0
	
	ldec_used_amt = ldec_bdgt_amt + ldec_1st_amt + ldec_2nd_amt + ldec_3rd_amt + ldec_tran_amt
	
	setitem(row, 'assn_used_amt', ldec_used_amt)
	
	ldec_temp_amt = getitemdecimal(row, 'assn_temp_amt')
	ldec_real_amt = getitemdecimal(row, 'assn_real_amt')
	
	if isnull(ldec_temp_amt) then ldec_temp_amt = 0
	if isnull(ldec_real_amt) then ldec_real_amt = 0
	
	setitem(row, 'remain_amt', ldec_used_amt - ldec_temp_amt - ldec_real_amt)
end if

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event dw_update_tab::clicked;call super::clicked;if isnull(row) or row < 1 then return

trigger event rowfocuschanged(row)
end event

event dw_update_tab::getfocus;call super::getfocus;idw_1 = this
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then return

trigger event rowfocuschanged(getrow())

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then
	return
end if

il_currentrow = currentrow


end event

type uo_tab from w_tabsheet`uo_tab within w_hac501a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac501a
string dataobject = "d_hac501a_con"
end type

type st_con from w_tabsheet`st_con within w_hac501a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_4 from groupbox within tabpage_sheet01
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

type uo_1 from cuo_search within tabpage_sheet01
integer x = 114
integer y = 40
integer width = 3438
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call cuo_search::destroy
end on

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1836
string text = "배정예산서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_sheet02.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_sheet02.destroy
destroy(this.dw_print)
end on

type dw_print from cuo_dwprint within tabpage_sheet02
integer width = 4352
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hac501a_6"
boolean vscrollbar = true
boolean border = false
end type

