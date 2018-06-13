$PBExportHeader$w_hac601a.srw
$PBExportComments$부서간 예산 전용 신청/출력(예산/주관부서용)
forward
global type w_hac601a from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
end forward

global type w_hac601a from w_tabsheet
string title = "부서간 예산 전용 신청/출력(예산/주관부서용)"
end type
global w_hac601a w_hac601a

type variables
datawindowchild	idw_child, idw_child2
datawindow			idw_data


//string	is_bdgt_year, is_slip_class		// 요구년도, 수입/지출구분
//string	is_req_date								// 요구일자
//string	is_req_name, is_req_jikwi_name
//integer	ii_acct_class							// 회계단위
integer	ii_req_jikwi_code
integer	ii_bdgt_class	=	0					// 예산차수
integer	ii_seq
integer	ii_spacerow = 6

long		il_currentrow
string	is_dept_name							// 로긴부서명
end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_insert ()
public function integer wf_retrieve ()
public subroutine wf_retrieve_preview ()
public subroutine wf_button_control (integer ai_index)
end prototypes

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
// 요구자
idw_data.getchild('req_member_no', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0, 9, '') < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
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
string	ls_dept_code, ls_acct_code, ls_bdgt_year, ls_slip_class, ls_req_date, ls_req_jikwi_name
dw_con.accepttext()
ls_bdgt_year = String(dw_con.object.year[1], 'yyyy')
ls_slip_class = dw_con.object.slip_class[1]
ls_req_date = string(dw_con.object.req_date[1], 'yyyymmdd')


if trim(ls_bdgt_year) = '' or trim(ls_bdgt_year) = '0000' then
	f_messagebox('1', '요구년도를 정확히 입력하시기 바랍니다.!')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	return
end if

li_newrow	=	idw_data.getrow() + 1

idw_data.insertrow(li_newrow)
idw_data.setrow(li_newrow)
idw_data.scrolltorow(li_newrow)

idw_data.setitem(li_newrow, 'bdgt_year',			ls_bdgt_year)
idw_data.setitem(li_newrow, 'gwa',					gs_deptcode)
idw_data.setitem(li_newrow, 'acct_class',			gi_acct_class)
idw_data.setitem(li_newrow, 'io_gubun',			ls_slip_class)
idw_data.setitem(li_newrow, 'req_date',			ls_req_date)
idw_data.setitem(li_newrow, 'req_member_no',		gs_empcode)
idw_data.setitem(li_newrow, 'req_posi',			ls_req_jikwi_name)
idw_data.setitem(li_newrow, 'tran_gwa',			'')

select	nvl(max(seq), 0)
into		:ii_seq
from		acdb.hac014h
where		req_date	=	:ls_req_date
and		gwa		=	:gs_deptcode	;
	
idw_data.setitem(li_newrow, 'seq', 	ii_seq + li_newrow)

idw_data.setitem(li_newrow, 'worker',		gs_empcode)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setrow(li_newrow)
idw_data.setcolumn('acct_code')
idw_data.scrolltorow(li_newrow)
idw_data.setfocus()


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

String	ls_name, ls_bdgt_year, ls_slip_class
integer	li_tab

dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.year[1], 'yyyy')
ls_slip_class = dw_con.object.slip_class[1]

li_tab  = tab_sheet.selectedtab
wf_button_control(li_tab)



if idw_data.retrieve(ls_bdgt_year, gs_deptcode, gi_acct_class, ls_slip_class) > 0 then
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
String ls_bdgt_year, ls_slip_class
dw_con.accepttext()
ls_bdgt_year = String(dw_con.object.year[1] ,'yyyy')
ls_slip_class = dw_con.object.slip_class[1]

if idw_print.retrieve(ls_bdgt_year, gs_deptcode, gi_acct_class, ls_slip_class) < 1 then

else

end if

end subroutine

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
//if ai_index < 1 then	return
//
//choose case ai_index
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
end subroutine

on w_hac601a.create
int iCurrent
call super::create
end on

on w_hac601a.destroy
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
return 1
end event

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////


wf_setMsg('입력중')

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
//idw_data			=	tab_sheet.tabpage_sheet01.dw_list001
//idw_print		=	tab_sheet.tabpage_sheet02.dw_print
//ist_back			=	tab_sheet.tabpage_sheet02.st_back
//
//uo_slip_class.rb_1.visible = false
//
//uo_req_date.st_title.text = '요구일자'
//
//// 로긴자 성명 과직위를 구한다.
//select	rtrim(a.name), a.jikwi_code, rtrim(b.fname)
//into		:is_req_name, :ii_req_jikwi_code, :is_req_jikwi_name
//from		indb.hin001m a, 
//			(	select	code, nvl(fname, ' ') fname
//				from		cddb.kch001m
//				where		type	=	'jikwi_code'	) b
//where		a.member_no		=	:gs_empcode	
//and		a.jikwi_code	=	b.code (+)	;
//
//if sqlca.sqlcode <> 0 then
//	is_req_name			=	''
//	ii_req_jikwi_code	=	0
//	is_req_jikwi_name	=	''
//end if
//
//st_req.text = 	'  [' + f_getdeptname(gs_deptcode) + '] ' +	&
//					trim(gs_empcode) + ' ' + is_req_name
//
//is_bdgt_year	=	uo_bdgt_year.uf_getyy()
//is_req_date		=	uo_req_date.uf_getdate()
//ii_acct_class 	= 	uo_acct_class.uf_getcode()
//is_slip_class 	= 	uo_slip_class.uf_getcode()
//
//wf_getchild()
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2002. 10                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_setMsg('저장중')

if idw_data.update() = 1 then
	commit	;
	wf_retrieve_preview()
else
	rollback	;
end if

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

if idw_data.rowcount() <= 0 then return

if idw_data.getitemnumber(il_currentrow, 'stat_class') <> 1 then
	f_messagebox('3', '자료를 삭제할 수 없습니다.!')
	return
end if

idw_data.deleterow(0)

wf_setMsg('')
//f_setpointer('END')

return 

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_data			=	tab_sheet.tabpage_sheet01.dw_list001
idw_print		=	tab_sheet.tabpage_sheet02.dw_print

String ls_req_name, ls_req_jikwi_name
Int li_req_jikwi_code


// 로긴자 성명 과직위를 구한다.
select	rtrim(a.name), a.jikwi_code, rtrim(b.fname)
into		:ls_req_name, :li_req_jikwi_code, :ls_req_jikwi_name
from		indb.hin001m a, 
			(	select	code, nvl(fname, ' ') fname
				from		cddb.kch001m
				where		type	=	'jikwi_code'	) b
where		a.member_no		=	:gs_empcode	
and		a.jikwi_code	=	b.code (+)	;

if sqlca.sqlcode <> 0 then
	ls_req_name			=	''
	li_req_jikwi_code	=	0
	ls_req_jikwi_name	=	''
end if

wf_getchild()

dw_con.object.st_req[1] = 	'  [' + f_getdeptname(gs_deptcode) + '] ' +	&
					trim(gs_empcode) + ' ' + ls_req_name

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

type ln_templeft from w_tabsheet`ln_templeft within w_hac601a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac601a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac601a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac601a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac601a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac601a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac601a
end type

type uc_insert from w_tabsheet`uc_insert within w_hac601a
end type

type uc_delete from w_tabsheet`uc_delete within w_hac601a
end type

type uc_save from w_tabsheet`uc_save within w_hac601a
end type

type uc_excel from w_tabsheet`uc_excel within w_hac601a
end type

type uc_print from w_tabsheet`uc_print within w_hac601a
end type

type st_line1 from w_tabsheet`st_line1 within w_hac601a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hac601a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hac601a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac601a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac601a
integer beginy = 352
integer endy = 352
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac601a
integer y = 400
integer width = 4384
integer height = 1852
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;wf_button_control(newindex)
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
integer height = 1732
long backcolor = 1073741824
string text = "부서간예산전용신청"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
integer width = 4338
integer height = 1728
string dataobject = "d_hac601a_1"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event dw_list001::constructor;call super::constructor;this.uf_setClick(False)
end event

event dw_list001::itemchanged;call super::itemchanged;string		ls_acct_code, ls_acct_name, ls_bdgt_year, ls_io_gubun, ls_gwa
integer		li_acct_class
long			ll_cnt
dec			ld_jan_amt, ld_req_amt
s_insa_com	lstr_com, lstr_Rtn
String ls_slip_class

dw_con.accepttext()
ls_slip_class = dw_con.object.slip_class[1]



if	dwo.name = 'acct_code' or dwo.name = 'tran_acct_code' then
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
		if dwo.name = 'acct_code' then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
		else
			setitem(row, 'tran_acct_code', '')
			setitem(row, 'tran_acct_name', '')
		end if
		messagebox('확인', '등록되지 않은 자금계정코드입니다.')
		return 1
	end if
		
	if dwo.name = 'acct_code' then
		if not isnull(data) and trim(data) <> '' and &
		   not isnull(getitemstring(row, 'tran_acct_code')) and trim(getitemstring(row, 'tran_acct_code')) <> '' then
			if mid(data,1,2) <> mid(getitemstring(row, 'tran_acct_code'),1,2) then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				messagebox('확인', '전출계정과 전입계정은 관내에서만 전용가능합니다.')
				return 1
			end if
		end if
	else
		if not isnull(data) and trim(data) <> '' and &
		   not isnull(getitemstring(row, 'acct_code')) and trim(getitemstring(row, 'acct_code')) <> '' then
			if mid(data,1,2) <> mid(getitemstring(row, 'acct_code'),1,2) then
				setitem(row, 'tran_acct_code', '')
				setitem(row, 'tran_acct_name', '')
				messagebox('확인', '전출계정과 전입계정은 관내에서만 전용가능합니다.')
				return 1
			end if
		end if
	end if

	if ll_cnt = 1 then
		select	decode(:ls_slip_class,'1',acct_iname,'2',acct_oname,acct_name)	into	:ls_acct_name
		from		acdb.hac001m
		where		acct_code	like	:ls_acct_code
		and		jg_gubun = 'Y'
		and		level_class = '4'
		and		decode(:ls_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
			
		if dwo.name = 'acct_code' then
			setitem(row, 'acct_code', trim(data))
			setitem(row, 'acct_name', trim(ls_acct_name))
		else
			setitem(row, 'tran_acct_code', trim(data))
			setitem(row, 'tran_acct_name', trim(ls_acct_name))
		end if
		return 1
	else
		lstr_com.ls_item[1]	=	trim(data)
		lstr_com.ls_item[2]	=	''
		lstr_com.ls_item[3]	=	string(li_acct_class)
		lstr_com.ls_item[4]	=	ls_io_gubun

		OpenWithParm(w_hac001h, lstr_com)

		lstr_Rtn = Message.PowerObjectParm

		if not isvalid(lstr_rtn) then
			if dwo.name = 'acct_code' then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
			else
				setitem(row, 'tran_acct_code', '')
				setitem(row, 'tran_acct_name', '')
			end if
			return 1
		end if

		if dwo.name = 'acct_code' then
			if not isnull(lstr_Rtn.ls_item[1]) and trim(lstr_Rtn.ls_item[1]) <> '' and &
			   not isnull(getitemstring(row, 'tran_acct_code')) and trim(getitemstring(row, 'tran_acct_code')) <> '' then
				if mid(lstr_Rtn.ls_item[1],1,2) <> mid(getitemstring(row, 'tran_acct_code'),1,2) then
					setitem(row, 'acct_code', '')
					setitem(row, 'acct_name', '')
					messagebox('확인', '전출계정과 전입계정은 관내에서만 전용가능합니다.')
					return 1
				end if
			end if
		else
			if not isnull(lstr_Rtn.ls_item[1]) and trim(lstr_Rtn.ls_item[1]) <> '' and &
		   	not isnull(getitemstring(row, 'acct_code')) and trim(getitemstring(row, 'acct_code')) <> '' then
				if mid(lstr_Rtn.ls_item[1],1,2) <> mid(getitemstring(row, 'acct_code'),1,2) then
					setitem(row, 'tran_acct_code', '')
					setitem(row, 'tran_acct_name', '')
					messagebox('확인', '전출계정과 전입계정은 관내에서만 전용가능합니다.')
					return 1
				end if
			end if
		end if

		if dwo.name = 'acct_code' then
			setitem(row, 'acct_code', lstr_Rtn.ls_item[1])
			setitem(row, 'acct_name', lstr_Rtn.ls_item[2])
		else
			setitem(row, 'tran_acct_code', lstr_Rtn.ls_item[1])
			setitem(row, 'tran_acct_name', lstr_Rtn.ls_item[2])
		end if
		return 1
	end if
end if

if dwo.name = 'acct_code' or dwo.name = 'req_amt' then
	ls_bdgt_year  = getitemstring(row, 'bdgt_year')
	ls_gwa        = getitemstring(row, 'gwa')
	li_acct_class = getitemnumber(row, 'acct_class')
	ls_io_gubun   = getitemstring(row, 'io_gubun')

	choose case dwo.name
		case 'acct_code'
			ls_acct_code = data
			ld_req_amt   = getitemnumber(row, 'req_amt')
		case 'req_amt'
			ls_acct_code = getitemstring(row, 'acct_code')
			ld_req_amt   = dec(data)
	end choose

	if not isnull(ls_acct_code) and trim(ls_acct_code) <> '' and not isnull(ld_req_amt) and ld_req_amt <> 0 then
		// 배정예산 자료가 있는지 Check
		SELECT	NVL(ASSN_USED_AMT,0) - NVL(ASSN_TEMP_AMT,0) - NVL(ASSN_REAL_AMT,0)	INTO	:LD_JAN_AMT
		FROM		ACDB.HAC012M
		WHERE		BDGT_YEAR = :LS_BDGT_YEAR
		AND		GWA = :LS_GWA
		AND		ACCT_CODE = :LS_ACCT_CODE
		AND		ACCT_CLASS = :LI_ACCT_CLASS
		AND		IO_GUBUN = :LS_IO_GUBUN ;
	
		if ld_req_amt > ld_jan_amt then
			messagebox('확인', '예산의 잔액보다 전용금액이 클 수 없습니다.~r~r' + &
			                   '예산잔액 : ' + string(ld_jan_amt,'#,##0') + ' 원입니다.')
			if dwo.name = 'acct_code' then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				return 1
			else
				setitem(row, 'req_amt', 0)
				return 1
			end if
		end if
	end if
end if

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event dw_list001::losefocus;call super::losefocus;accepttext()
end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then	return

trigger event rowfocuschanged(1)

end event

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then	return

il_currentrow = currentrow

end event

event dw_list001::clicked;call super::clicked;if isnull(row) or row < 1 then return

trigger event rowfocuschanged(row)
end event

event dw_list001::itemerror;call super::itemerror;return 1
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
boolean visible = false
integer x = 0
integer width = 10
integer height = 1728
end type

event dw_update_tab::itemchanged;call super::itemchanged;string		ls_acct_code, ls_acct_name, ls_bdgt_year, ls_io_gubun, ls_gwa
integer		li_acct_class
long			ll_cnt
dec			ld_jan_amt, ld_req_amt
s_insa_com	lstr_com, lstr_Rtn
String ls_slip_class

dw_con.accepttext()
ls_slip_class = dw_con.object.slip_class[1]



if	dwo.name = 'acct_code' or dwo.name = 'tran_acct_code' then
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
		if dwo.name = 'acct_code' then
			setitem(row, 'acct_code', '')
			setitem(row, 'acct_name', '')
		else
			setitem(row, 'tran_acct_code', '')
			setitem(row, 'tran_acct_name', '')
		end if
		messagebox('확인', '등록되지 않은 자금계정코드입니다.')
		return 1
	end if
		
	if dwo.name = 'acct_code' then
		if not isnull(data) and trim(data) <> '' and &
		   not isnull(getitemstring(row, 'tran_acct_code')) and trim(getitemstring(row, 'tran_acct_code')) <> '' then
			if mid(data,1,2) <> mid(getitemstring(row, 'tran_acct_code'),1,2) then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				messagebox('확인', '전출계정과 전입계정은 관내에서만 전용가능합니다.')
				return 1
			end if
		end if
	else
		if not isnull(data) and trim(data) <> '' and &
		   not isnull(getitemstring(row, 'acct_code')) and trim(getitemstring(row, 'acct_code')) <> '' then
			if mid(data,1,2) <> mid(getitemstring(row, 'acct_code'),1,2) then
				setitem(row, 'tran_acct_code', '')
				setitem(row, 'tran_acct_name', '')
				messagebox('확인', '전출계정과 전입계정은 관내에서만 전용가능합니다.')
				return 1
			end if
		end if
	end if

	if ll_cnt = 1 then
		select	decode(:ls_slip_class,'1',acct_iname,'2',acct_oname,acct_name)	into	:ls_acct_name
		from		acdb.hac001m
		where		acct_code	like	:ls_acct_code
		and		jg_gubun = 'Y'
		and		level_class = '4'
		and		decode(:ls_slip_class,'1',suip_gubun,'2',jichul_gubun,'') = 'Y' ;
			
		if dwo.name = 'acct_code' then
			setitem(row, 'acct_code', trim(data))
			setitem(row, 'acct_name', trim(ls_acct_name))
		else
			setitem(row, 'tran_acct_code', trim(data))
			setitem(row, 'tran_acct_name', trim(ls_acct_name))
		end if
		return 1
	else
		lstr_com.ls_item[1]	=	trim(data)
		lstr_com.ls_item[2]	=	''
		lstr_com.ls_item[3]	=	string(li_acct_class)
		lstr_com.ls_item[4]	=	ls_io_gubun

		OpenWithParm(w_hac001h, lstr_com)

		lstr_Rtn = Message.PowerObjectParm

		if not isvalid(lstr_rtn) then
			if dwo.name = 'acct_code' then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
			else
				setitem(row, 'tran_acct_code', '')
				setitem(row, 'tran_acct_name', '')
			end if
			return 1
		end if

		if dwo.name = 'acct_code' then
			if not isnull(lstr_Rtn.ls_item[1]) and trim(lstr_Rtn.ls_item[1]) <> '' and &
			   not isnull(getitemstring(row, 'tran_acct_code')) and trim(getitemstring(row, 'tran_acct_code')) <> '' then
				if mid(lstr_Rtn.ls_item[1],1,2) <> mid(getitemstring(row, 'tran_acct_code'),1,2) then
					setitem(row, 'acct_code', '')
					setitem(row, 'acct_name', '')
					messagebox('확인', '전출계정과 전입계정은 관내에서만 전용가능합니다.')
					return 1
				end if
			end if
		else
			if not isnull(lstr_Rtn.ls_item[1]) and trim(lstr_Rtn.ls_item[1]) <> '' and &
		   	not isnull(getitemstring(row, 'acct_code')) and trim(getitemstring(row, 'acct_code')) <> '' then
				if mid(lstr_Rtn.ls_item[1],1,2) <> mid(getitemstring(row, 'acct_code'),1,2) then
					setitem(row, 'tran_acct_code', '')
					setitem(row, 'tran_acct_name', '')
					messagebox('확인', '전출계정과 전입계정은 관내에서만 전용가능합니다.')
					return 1
				end if
			end if
		end if

		if dwo.name = 'acct_code' then
			setitem(row, 'acct_code', lstr_Rtn.ls_item[1])
			setitem(row, 'acct_name', lstr_Rtn.ls_item[2])
		else
			setitem(row, 'tran_acct_code', lstr_Rtn.ls_item[1])
			setitem(row, 'tran_acct_name', lstr_Rtn.ls_item[2])
		end if
		return 1
	end if
end if

if dwo.name = 'acct_code' or dwo.name = 'req_amt' then
	ls_bdgt_year  = getitemstring(row, 'bdgt_year')
	ls_gwa        = getitemstring(row, 'gwa')
	li_acct_class = getitemnumber(row, 'acct_class')
	ls_io_gubun   = getitemstring(row, 'io_gubun')

	choose case dwo.name
		case 'acct_code'
			ls_acct_code = data
			ld_req_amt   = getitemnumber(row, 'req_amt')
		case 'req_amt'
			ls_acct_code = getitemstring(row, 'acct_code')
			ld_req_amt   = dec(data)
	end choose

	if not isnull(ls_acct_code) and trim(ls_acct_code) <> '' and not isnull(ld_req_amt) and ld_req_amt <> 0 then
		// 배정예산 자료가 있는지 Check
		SELECT	NVL(ASSN_USED_AMT,0) - NVL(ASSN_TEMP_AMT,0) - NVL(ASSN_REAL_AMT,0)	INTO	:LD_JAN_AMT
		FROM		ACDB.HAC012M
		WHERE		BDGT_YEAR = :LS_BDGT_YEAR
		AND		GWA = :LS_GWA
		AND		ACCT_CODE = :LS_ACCT_CODE
		AND		ACCT_CLASS = :LI_ACCT_CLASS
		AND		IO_GUBUN = :LS_IO_GUBUN ;
	
		if ld_req_amt > ld_jan_amt then
			messagebox('확인', '예산의 잔액보다 전용금액이 클 수 없습니다.~r~r' + &
			                   '예산잔액 : ' + string(ld_jan_amt,'#,##0') + ' 원입니다.')
			if dwo.name = 'acct_code' then
				setitem(row, 'acct_code', '')
				setitem(row, 'acct_name', '')
				return 1
			else
				setitem(row, 'req_amt', 0)
				return 1
			end if
		end if
	end if
end if

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event dw_update_tab::clicked;call super::clicked;if isnull(row) or row < 1 then return

trigger event rowfocuschanged(row)
end event

event dw_update_tab::itemerror;call super::itemerror;return 1
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then	return

trigger event rowfocuschanged(1)

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then	return

il_currentrow = currentrow

end event

type uo_tab from w_tabsheet`uo_tab within w_hac601a
integer y = 408
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hac601a
integer height = 188
string dataobject = "d_hac601a_con"
end type

event dw_con::constructor;call super::constructor;this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
this.object.req_date[1] = date(string(f_today(), '@@@@/@@/@@'))
end event

type st_con from w_tabsheet`st_con within w_hac601a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1732
string text = "부서간예산전용결의서"
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
integer width = 4338
integer height = 1732
integer taborder = 10
string dataobject = "d_hac601a_2_new"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event retrieveend;call super::retrieveend;/* 2007.05.30 : 예산전용결의서 출력물 수정 */
integer		i, j
string		ls_ca, ls_name, ls_date, ls_tran_dept_code
datastore	lds_1
String ls_bdgt_year, ls_slip_class
dw_con.accepttext()

ls_bdgt_year = string(dw_con.object.year[1], 'yyyy')
ls_slip_class = dw_con.object.slip_class[1]

if isnull(rowcount) or rowcount < 1 then return

lds_1 = create	datastore
lds_1.dataobject = 'd_hac601a_3'
lds_1.settransobject(sqlca)

for i = 1 to rowcount
	
	ls_name				=	getitemstring(i, 'hac014h_req_member_no')
	ls_date				=	getitemstring(i, 'hac014h_req_date')
	ls_tran_dept_code	=	getitemstring(i, 'hac014h_tran_gwa')

	lds_1.retrieve(ls_bdgt_year, gs_deptcode, ls_tran_dept_code, gi_acct_class, ls_slip_class, ls_date, ls_name) 

	ls_ca = ''
	
	for j = 1 to lds_1.rowcount()
		ls_ca += string(j) + '. ' + lds_1.getitemstring(j, 'causes') + '   '
	next

	setitem(i, 'causes', ls_ca)
next

destroy	lds_1




/* backup (2007.05.30)

integer		i, j, li_row, li_chk, li_rowcnt
string		ls_ca, ls_dept, ls_posi, ls_name, ls_date, ls_kname, ls_dept_name, ls_tran_dept_code, ls_tran_dept_name
long			ll_row, ll_currentrow
datastore	lds_1

if isnull(rowcount) or rowcount < 1 then return

lds_1 = create	datastore
lds_1.dataobject = 'd_hac601a_3'
lds_1.settransobject(sqlca)

ll_currentrow = 1

for i = 1 to rowcount
	if getitemnumber(ll_currentrow, 'group') = 0 then	
		ll_currentrow ++
		continue
	end if

	li_rowcnt = getitemnumber(ll_currentrow, 'group_cnt')
	li_row = ii_spacerow - mod(li_rowcnt, ii_spacerow)

	ls_posi				=	getitemstring(ll_currentrow, 'hac014h_req_posi')
	ls_name				=	getitemstring(ll_currentrow, 'hac014h_req_member_no')
	ls_date				=	getitemstring(ll_currentrow, 'hac014h_req_date')
	ls_dept_name		=	getitemstring(ll_currentrow, 'dept_name')
	ls_kname				=	getitemstring(ll_currentrow, 'name')
	ls_tran_dept_code	=	getitemstring(ll_currentrow, 'hac014h_tran_gwa')
	ls_tran_dept_name =	getitemstring(ll_currentrow, 'tran_dept_name')
	
	for j = 1 to li_row
		ll_row = j + ll_currentrow
		insertrow(ll_row)
		setitem(ll_row, 'hac014h_req_posi', 		ls_posi)
		setitem(ll_row, 'hac014h_req_member_no', 	ls_name)
		setitem(ll_row, 'hac014h_req_date', 		ls_date)
		setitem(ll_row, 'dept_name',					ls_dept_name)
		setitem(ll_row, 'name',							ls_kname)
		setitem(ll_row, 'hac014h_tran_gwa',			ls_tran_dept_code)
		setitem(ll_row, 'tran_dept_name',			ls_tran_dept_name)
	next
	
	lds_1.retrieve(is_bdgt_year, gs_deptcode, ls_tran_dept_code, ii_acct_class, is_slip_class, ls_date, ls_name) 

	li_row = lds_1.rowcount()
	li_chk = 1
	ls_ca = ''
	
	for j = 1 to li_row
		ls_ca += string(j) + '. ' + lds_1.getitemstring(j, 'causes') + '  '
		if len(trim(ls_ca)) > 140 then
			setitem(ll_row, 'causes_' + string(li_chk), ls_ca)
			li_chk ++
			ls_ca = ''
		end if
	next

	setitem(ll_row, 'causes_' + string(li_chk), ls_ca)
	ll_currentrow = ll_row + 1
next

destroy	lds_1

*/

end event

