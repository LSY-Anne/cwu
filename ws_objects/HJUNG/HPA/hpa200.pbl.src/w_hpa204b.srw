$PBExportHeader$w_hpa204b.srw
$PBExportComments$건강보험료 생성/관리
forward
global type w_hpa204b from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type st_2 from statictext within tabpage_sheet01
end type
type sle_filename from singlelineedit within tabpage_sheet01
end type
type st_message from statictext within tabpage_sheet01
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type st_status from statictext within tabpage_sheet01
end type
type hpb_1 from hprogressbar within tabpage_sheet01
end type
type pb_fileupload from uo_imgbtn within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_update from uo_dwgrid within tabpage_sheet02
end type
type dw_update_back from cuo_dwwindow within tabpage_sheet02
end type
type gb_5 from groupbox within tabpage_sheet02
end type
type uo_3 from cuo_search_insa within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_update dw_update
dw_update_back dw_update_back
gb_5 gb_5
uo_3 uo_3
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type st_back from statictext within tabpage_sheet03
end type
type dw_print from cuo_dwprint within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
st_back st_back
dw_print dw_print
end type
type uo_yearmonth from cuo_yearmonth within w_hpa204b
end type
end forward

global type w_hpa204b from w_tabsheet
string title = "건강보험료 생성/관리"
uo_yearmonth uo_yearmonth
end type
global w_hpa204b w_hpa204b

type variables
datawindowchild	idw_child, idw_kname_child
datawindow			idw_preview, idw_data

statictext			ist_back

string		is_yearmonth

end variables

forward prototypes
public subroutine wf_retrieve2 ()
public function integer wf_retrieve ()
public subroutine wf_getchild ()
public function integer wf_fileupload ()
end prototypes

public subroutine wf_retrieve2 ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve2()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

idw_preview.retrieve(is_yearmonth)
idw_print.retrieve(is_yearmonth)

end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_name
integer	li_tab

ist_back.bringtotop = true

if idw_data.retrieve(is_yearmonth) > 0 then
	wf_retrieve2()
	ist_back.bringtotop = false
else
	idw_preview.reset()
	idw_print.reset()
end if

return 0
end function

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 급여구분
idw_data.getchild('confirm_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('confirm_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('confirm_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('confirm_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('confirm_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('confirm_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if


end subroutine

public function integer wf_fileupload ();// ==========================================================================================
// 기    능 : 	file upload
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_fileupload()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// Upload File Open
Integer	li_Rtn, li_err, li_cnt
String	ls_FullName
String	ls_FileName
String	ls_message
string	ls_kname

tab_sheet.tabpage_sheet01.st_status.text = '생성 준비중입니다...'

if trim(tab_sheet.tabpage_sheet01.sle_filename.text) = '' then
	ls_fullname = f_getfileopen('TXT')
	if ls_fullname = '' then	return	100
else
	ls_fullname = trim(tab_sheet.tabpage_sheet01.sle_filename.text)
end if

if FileExists(ls_fullname) = false then
	if f_messagebox('2', ls_fullname + '~n화일이 존재하지 않습니다.~n~n다시 선택하시려면 [예]를 누르세요.!') = 2 then	
		return 100
	else
		ls_fullname = f_getfileopen('TXT')
		if ls_fullname = '' then	return	100
	end if
end if

tab_sheet.tabpage_sheet01.sle_filename.Text = trim(ls_FullName)

li_rtn =	messagebox('확인', ls_fullname + '~n화일의 자료를 생성하시려면 [예]를 누르시고,'	+	&
														'~n화일의 자료를 생성하지 않으시려면 [아니오]를 누르시고,'	+	&
														'~n화일을 다시 선택하시려면 [취소]를 누르세요.!', question!, yesnocancel!)

if li_rtn = 3 then
	ls_fullname = f_getfileopen('TXT')
	if ls_fullname = '' then	return	100
elseif li_rtn = 2 then
	return	100
end if

// 자료가 있는지 체크한다.
long   	ll_count

select	count(*)
into		:ll_count
from		padb.hpa007h
where		year_month	=	:is_yearmonth	;

if ll_count > 0 then
	if f_messagebox('2', '이미 생성된 자료가 있습니다.~n~n다시 생성하시려면 [예]를 누르세요.!') = 2 then 
		return	100
	else
		// 이미 생성된 자료 삭제
		delete	from	padb.hpa007h
		where		year_month	=	:is_yearmonth	;
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
		
		idw_preview.reset()
	end if
end if

// 화일 열기
Integer		li_FileOpen

li_FileOpen = FileOpen(ls_fullname, LineMode!, Read!, LockWrite!, Replace!)

if li_FileOpen = -1 then
	f_messagebox('3', '대상파일을 열지 못했습니다.!')
	return	100
end if

// 대상파일 길이체크 
Long		ll_FileLen

ll_FileLen = FileLength(ls_fullname)

if ll_filelen = -1 then
	f_messagebox('3', '대상파일 길이 체크 중 오류가 발생하였습니다.!')
	return	100
end if

SetPointer(HourGlass!)

ls_message	=	ls_fullname + '의 자료를 생성 중입니다...'

tab_sheet.tabpage_sheet01.st_status.text = ls_message

String	ls_FileRead, ls_member_no, ls_jumin_no, ls_type
Long		ll_FileRead, ll_row
integer	li_find, i, li_column, li_start
/////////////////////////////////////////////////////////////////////////////
// 건강보험의 양식에 근거한다. 데이타윈도우의 내용은 변동하지 않아야 한다.
/////////////////////////////////////////////////////////////////////////////
//decimal {0} li_col_len[] = {8,3,2,11,16,13,2,2,5,10,8,2,6,6,8,8,8,8,8,8,2}
//decimal {0} li_col_len[] = {6,8,3,1,2,11,14,13,2,2,5,11,8,2,8,8,6,6,8,9,9}
//2009.05.18
decimal {0} li_col_len[] = {6,11,3,1,2,11,16,13,2,2,5,13,10,2,6,6,10,10,10,8,8,10,2,6,6,10,10,10,10,10,10,10,10,10,10}

// 전체 Count를 미리 센다.
ll_FileLen  = 0
ll_FileRead = FileRead(li_FileOpen, ls_FileRead)
ll_row		= 0
ll_count		= 0

li_err		=	0
li_cnt		=	0

DO UNTIL ll_FileRead = -100
	ll_FileLen = LEN(ls_FileRead)
	IF ll_FileLen = 0 THEN
		ll_FileRead = FileRead(li_FileOpen, ls_FileRead)
		continue
	END IF
	
	ll_count ++
	ll_FileRead = FileRead(li_FileOpen, ls_FileRead)
LOOP

// Process Bar Setting
tab_sheet.tabpage_sheet01.hpb_1.setrange(1, ll_count + 1)
tab_sheet.tabpage_sheet01.hpb_1.setstep 	= 1
tab_sheet.tabpage_sheet01.hpb_1.position	= 0

li_FileOpen = FileOpen(ls_fullname, LineMode!, Read!, LockWrite!, Replace!)

ll_FileLen  = 0
ll_FileRead = FileRead(li_FileOpen, ls_FileRead)
ll_row		= 0
//11개는 버려야 되는 항목이다.(데이타윈도우의 내용상:작성자외 5, 년월, 사번, 그외 여분금액)
//li_column	= integer(idw_preview.object.datawindow.column.count) - 11
li_column	= integer(idw_preview.object.datawindow.column.count) - 7
DO UNTIL ll_FileRead = -100
	ll_FileLen = LEN(ls_FileRead)
	IF ll_FileLen = 0 THEN
		ll_FileRead = FileRead(li_FileOpen, ls_FileRead)
		continue
	END IF

	li_start	=	1
	
	ll_row	=	idw_preview.insertrow(0)
	
	FOR i	= 1 TO li_column 
		ls_type 	= idw_preview.describe("#" + string(i) + ".coltype")
		
		if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
			idw_preview.setitem(ll_row, i, dec(mid(ls_fileread, li_start, li_col_len[i])))
		else
			idw_preview.setitem(ll_row, i, trim(mid(ls_fileread, li_start, li_col_len[i])))
		end if
		
		li_start += li_col_len[i]
	NEXT

	ls_jumin_no = 	idw_preview.getitemstring(ll_row, 'jumin_no')
	ls_kname		=	idw_preview.getitemstring(ll_row, 'name')
	
	select	nvl(member_no, '')
	into		:ls_member_no
	from		indb.hin001m
	where		jumin_no		=	:ls_jumin_no	
	and		jaejik_opt	in	(1, 2, 4)
	and		member_no	in		
				(	select	member_no
					from	(	select	member_no, jumin_no
								from		indb.hin001m a
								where		(jaejik_opt in	(1, 2, 4) or retire_date like :is_yearmonth || '%') 
								order by	jaejik_opt, 
											decode(substr(duty_code, 1, 1), '3', 'z' || duty_code, '0' || duty_code),
											firsthire_date	DESC,
											decode(substr(member_no, 1, 1), '0', 'z' || member_no, '0' || member_no) )
					where		jumin_no	=	:ls_jumin_no
					and		rownum	=	1	)	;
	
	if sqlca.sqlcode <> 0 then
		idw_preview.setitem(ll_row, 'year_month',	is_yearmonth)
		f_messagebox('3', '[' + ls_kname + '][' + string(ls_jumin_no, '@@@@@@-@@@@@@@') + ']의 개인번호가 정확하지 않습니다.~n~n확인하시기 바랍니다.!')

		li_err ++
	else
		idw_preview.setitem(ll_row, 'year_month',	is_yearmonth)
		idw_preview.setitem(ll_row, 'member_no',	ls_member_no)
		
		idw_preview.setitem(ll_row, 'worker',		gs_empcode)  // gstru_uid_uname.uid)
		idw_preview.setitem(ll_row, 'ipaddr',		gs_ip)   // gstru_uid_uname.address)
		idw_preview.setitem(ll_row, 'work_date',	f_sysdate())
	
		idw_preview.setitem(ll_row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
		idw_preview.setitem(ll_row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
		idw_preview.setitem(ll_row, 'job_date',	f_sysdate())
		
		li_cnt ++
	end if
//	for i = 1 to 6
//		li_find = pos(ls_fileread, '	')
//		idw_data.setitem(ll_row, ls_col[i], dec(mid(ls_fileread, 1, li_find - 1)))
//		ls_fileread = mid(ls_fileread, li_find + 1, len(ls_fileread))
//	next

	tab_sheet.tabpage_sheet01.hpb_1.position ++
	ll_FileRead = FileRead(li_FileOpen, ls_FileRead)
LOOP

tab_sheet.tabpage_sheet01.hpb_1.position ++
FileClose(li_FileOpen)

if li_err > 0 then
	f_messagebox('1', string(li_cnt) + '건의 자료를 생성했습니다.!~n~n' + string(li_err) + '건의 자료는 정확하지 않은 자료입니다. 확인하시기 바랍니다.!')
else
	f_messagebox('1', string(li_cnt) + '건의 자료를 생성했습니다.!')
end if

return	0

end function

on w_hpa204b.create
int iCurrent
call super::create
this.uo_yearmonth=create uo_yearmonth
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yearmonth
end on

on w_hpa204b.destroy
call super::destroy
destroy(this.uo_yearmonth)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()

return 1
end event

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

integer	li_newrow, li_rank




li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)
idw_data.Selectrow(0, false)	
idw_data.Selectrow(0, TRUE)	
idw_data.ScrollToRow(li_newrow)
idw_data.setcolumn(1)
idw_data.setfocus()



end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_preview	=	tab_sheet.tabpage_sheet01.dw_list001
//idw_data		=	tab_sheet.tabpage_sheet02.dw_update
//idw_print	=	tab_sheet.tabpage_sheet03.dw_print
//ist_back		=	tab_sheet.tabpage_sheet03.st_back
//
//uo_yearmonth.uf_settitle('생성년월')
//is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
//
//// 개인번호
//idw_data.getchild('member_no', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(0, 9, '%' , is_yearmonth) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//idw_data.getchild('name', idw_kname_child)
//idw_kname_child.settransobject(sqlca)
//if idw_kname_child.retrieve(0, 9, '%' , is_yearmonth) < 1 then
//	idw_kname_child.reset()
//	idw_kname_child.insertrow(0)
//end if
//
//tab_sheet.tabpage_sheet02.uo_3.uf_reset(idw_data, 'member_no', 'name')
//
//triggerevent('ue_retrieve')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow
long		ll_currentrow



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
IF dw_name.Update(true) = 1 THEN
	COMMIT;
	wf_retrieve()
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText + '~r~n' )
  ROLLBACK;
END IF


return 1

end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow


wf_setMsg('삭제중')

li_deleterow	=	idw_data.deleterow(0)

wf_setMsg('.')


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
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_preview	=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet02.dw_update
idw_print	=	tab_sheet.tabpage_sheet03.dw_print
ist_back		=	tab_sheet.tabpage_sheet03.st_back

uo_yearmonth.uf_settitle('생성년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

// 개인번호
idw_data.getchild('member_no', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0, 9, '%' , is_yearmonth) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
idw_data.getchild('name', idw_kname_child)
idw_kname_child.settransobject(sqlca)
if idw_kname_child.retrieve(0, 9, '%' , is_yearmonth) < 1 then
	idw_kname_child.reset()
	idw_kname_child.insertrow(0)
end if

tab_sheet.tabpage_sheet02.uo_3.uf_reset(idw_data, 'member_no', 'name')

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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa204b
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa204b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa204b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa204b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa204b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa204b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa204b
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa204b
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa204b
end type

type uc_save from w_tabsheet`uc_save within w_hpa204b
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa204b
end type

type uc_print from w_tabsheet`uc_print within w_hpa204b
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa204b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa204b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa204b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa204b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa204b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa204b
integer y = 324
integer width = 4379
integer height = 1968
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		fALSE)
//	case 2
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
end event

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
this.tabpage_sheet03=create tabpage_sheet03
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
this.Control[iCurrent+2]=this.tabpage_sheet03
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
destroy(this.tabpage_sheet03)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
event create ( )
event destroy ( )
string tag = "N"
integer y = 104
integer width = 4343
integer height = 1848
string text = "건강보험료생성"
gb_2 gb_2
st_2 st_2
sle_filename sle_filename
st_message st_message
gb_4 gb_4
st_status st_status
hpb_1 hpb_1
pb_fileupload pb_fileupload
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.st_2=create st_2
this.sle_filename=create sle_filename
this.st_message=create st_message
this.gb_4=create gb_4
this.st_status=create st_status
this.hpb_1=create hpb_1
this.pb_fileupload=create pb_fileupload
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_filename
this.Control[iCurrent+4]=this.st_message
this.Control[iCurrent+5]=this.gb_4
this.Control[iCurrent+6]=this.st_status
this.Control[iCurrent+7]=this.hpb_1
this.Control[iCurrent+8]=this.pb_fileupload
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.st_2)
destroy(this.sle_filename)
destroy(this.st_message)
destroy(this.gb_4)
destroy(this.st_status)
destroy(this.hpb_1)
destroy(this.pb_fileupload)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 540
integer width = 0
integer height = 0
string dataobject = "d_hpa204b_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::constructor;call super::constructor;this.uf_setClick(true)
end event

event dw_list001::retrieveend;call super::retrieveend;selectrow(0, false)
selectrow(1, true)

end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 540
integer width = 4338
integer height = 1308
string dataobject = "d_hpa204b_1"
end type

type uo_tab from w_tabsheet`uo_tab within w_hpa204b
end type

type dw_con from w_tabsheet`dw_con within w_hpa204b
boolean visible = false
integer width = 0
integer height = 0
end type

type st_con from w_tabsheet`st_con within w_hpa204b
end type

type gb_2 from groupbox within tabpage_sheet01
integer y = 20
integer width = 4347
integer height = 200
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "화일 업로드"
end type

type st_2 from statictext within tabpage_sheet01
integer x = 137
integer y = 100
integer width = 375
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "업로드화일명"
boolean focusrectangle = false
end type

type sle_filename from singlelineedit within tabpage_sheet01
integer x = 530
integer y = 88
integer width = 1445
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_message from statictext within tabpage_sheet01
integer x = 2565
integer y = 100
integer width = 1134
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "※ 업로드화일은 Text파일이어야 합니다."
boolean focusrectangle = false
end type

type gb_4 from groupbox within tabpage_sheet01
integer y = 248
integer width = 4347
integer height = 288
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "진행상태"
end type

type st_status from statictext within tabpage_sheet01
integer x = 64
integer y = 328
integer width = 3749
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "진행 상태..."
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within tabpage_sheet01
integer x = 50
integer y = 408
integer width = 4256
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type pb_fileupload from uo_imgbtn within tabpage_sheet01
event destroy ( )
integer x = 2002
integer y = 92
integer taborder = 50
boolean bringtotop = true
string btnname = "화일업로드"
end type

on pb_fileupload.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;// 자료를 생성한다.

integer	li_rtn

setpointer(hourglass!)

li_rtn = wf_fileupload()

setpointer(arrow!)

if li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
elseif li_rtn = 0 then
	if idw_preview.update() = 1 then
		commit	;
		wf_retrieve()
		tab_sheet.tabpage_sheet01.st_status.text = '진행 상태...'
//		parent.triggerevent('ue_retrieve')
	else
		rollback	;
	end if
end if

end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4343
integer height = 1848
long backcolor = 16777215
string text = "건강보험료관리"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_update dw_update
dw_update_back dw_update_back
gb_5 gb_5
uo_3 uo_3
end type

on tabpage_sheet02.create
this.dw_update=create dw_update
this.dw_update_back=create dw_update_back
this.gb_5=create gb_5
this.uo_3=create uo_3
this.Control[]={this.dw_update,&
this.dw_update_back,&
this.gb_5,&
this.uo_3}
end on

on tabpage_sheet02.destroy
destroy(this.dw_update)
destroy(this.dw_update_back)
destroy(this.gb_5)
destroy(this.uo_3)
end on

type dw_update from uo_dwgrid within tabpage_sheet02
integer x = 5
integer y = 192
integer width = 4343
integer height = 1648
integer taborder = 30
string dataobject = "d_hpa204b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;long ll_row
if dwo.name = 'member_no' then
	ll_row	=	idw_child.find("member_no = '" + data + "'	", 1, idw_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'name', idw_child.getitemstring(idw_child.getrow(), 'name'))
	else
		setitem(row, 'name', '')
	end if
elseif dwo.name = 'name' then
	ll_row	=	idw_kname_child.find("name = '" + data + "'	", 1, idw_kname_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'member_no',	idw_child.getitemstring(idw_kname_child.getrow(), 'member_no'))
	else
		setitem(row, 'member_no',	'')
	end if
end if
setitem(row, 'job_uid',		gs_empcode ) //gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   //gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())
end event

event losefocus;call super::losefocus;accepttext()
end event

type dw_update_back from cuo_dwwindow within tabpage_sheet02
boolean visible = false
integer x = 457
integer y = 152
integer width = 0
integer height = 0
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa204b_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event losefocus;call super::losefocus;accepttext()
end event

event itemchanged;call super::itemchanged;long ll_row
if dwo.name = 'member_no' then
	ll_row	=	idw_child.find("member_no = '" + data + "'	", 1, idw_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'name', idw_child.getitemstring(idw_child.getrow(), 'name'))
	else
		setitem(row, 'name', '')
	end if
elseif dwo.name = 'name' then
	ll_row	=	idw_kname_child.find("name = '" + data + "'	", 1, idw_kname_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'member_no',	idw_child.getitemstring(idw_kname_child.getrow(), 'member_no'))
	else
		setitem(row, 'member_no',	'')
	end if
end if
setitem(row, 'job_uid',		gs_empcode ) //gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   //gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())
end event

type gb_5 from groupbox within tabpage_sheet02
integer width = 4338
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

type uo_3 from cuo_search_insa within tabpage_sheet02
integer x = 114
integer y = 40
integer width = 3566
integer taborder = 60
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type tabpage_sheet03 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4343
integer height = 1848
long backcolor = 16777215
string text = "건강보험료내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_back st_back
dw_print dw_print
end type

on tabpage_sheet03.create
this.st_back=create st_back
this.dw_print=create dw_print
this.Control[]={this.st_back,&
this.dw_print}
end on

on tabpage_sheet03.destroy
destroy(this.st_back)
destroy(this.dw_print)
end on

type st_back from statictext within tabpage_sheet03
integer width = 4334
integer height = 1848
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_print from cuo_dwprint within tabpage_sheet03
integer width = 4338
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa204b_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type uo_yearmonth from cuo_yearmonth within w_hpa204b
integer x = 128
integer y = 176
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;is_yearmonth	=	uf_getyearmonth()

parent.triggerevent('ue_retrieve')

end event

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

