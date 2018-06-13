$PBExportHeader$w_hin206a.srw
$PBExportComments$교원업적평가관리
forward
global type w_hin206a from w_msheet
end type
type tab_1 from tab within w_hin206a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update from cuo_dwwindow_one_hin within tabpage_1
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
type tabpage_3 from userobject within tab_1
end type
type dw_print_2 from uo_dwfree within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_print_2 dw_print_2
end type
type tab_1 from tab within w_hin206a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_1 from u_tab within w_hin206a
end type
type dw_con from uo_dwfree within w_hin206a
end type
end forward

global type w_hin206a from w_msheet
integer width = 4526
string title = "교원업적평가"
tab_1 tab_1
uo_1 uo_1
dw_con dw_con
end type
global w_hin206a w_hin206a

type variables
String	is_JikJongCode 
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
public function integer wf_dup_chk (long al_row, string as_from_date, string as_member_no)
end prototypes

public subroutine wf_setmenubtn (string as_type);////입력
////저장
////삭제
////조회
////검색
//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN
//		CHOOSE CASE ls_Flag[li_idx]
//			CASE 'I' ; IF is_Auth[1] = 'Y' THEN lb_Value = TRUE
//			CASE 'S' ; IF is_Auth[3] = 'Y' THEN lb_Value = TRUE
//			CASE 'D' ; IF is_Auth[2] = 'Y' THEN lb_Value = TRUE
//			CASE 'R' ; IF is_Auth[4] = 'Y' THEN lb_Value = TRUE
//			CASE 'P' ; IF is_Auth[5] = 'Y' THEN lb_Value = TRUE
//		END CHOOSE
//	END IF
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE ls_Flag[li_idx]
//		CASE 'I' ;ib_insert   = lb_Value
//		CASE 'S' ;ib_update   = lb_Value
//		CASE 'D' ;ib_delete   = lb_Value
//		CASE 'R' ;ib_retrieve = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//		CASE 'P' ;ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

public function integer wf_dup_chk (long al_row, string as_from_date, string as_member_no);// ==========================================================================================
// 기    능 : 	중복자료 체크
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_dup_chk(long al_row, long al_mana_code) return integer
// 인    수 :	al_row : 현재행, as_from_date : 현재기준일자, as_member_no : 현재교원번호
// 되 돌 림 :  중복 : 1, 없으면 : 0
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long	ll_row

SELECT	COUNT(*)	INTO	:LL_ROW	FROM	INDB.HFN800M
WHERE		FROM_DATE = :AS_FROM_DATE
AND		MEMBER_NO = :AS_MEMBER_NO	;

if ll_row > 0 then
	messagebox('확인', '이미 등록된 교원입니다.')
	return 1
end if

ll_row = tab_1.tabpage_1.dw_update.find("from_date = '" + as_from_date + "' and " + &
													 "member_no = '" + as_member_no + "'", 1, al_row - 1)

if ll_row > 0 then
	messagebox('확인', '이미 등록된 교원입니다.')
	return 1
end if

ll_row = tab_1.tabpage_1.dw_update.find("from_date = '" + as_from_date + "' and " + &
													 "member_no = '" + as_member_no + "'", al_row + 1, tab_1.tabpage_1.dw_update.rowcount())

if ll_row > 0 then
	messagebox('확인', '이미 등록된 교원입니다.')
	return 1
end if

return 0
end function

on w_hin206a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_con
end on

on w_hin206a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.dw_con)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 교직원조건별 검색용을 사용한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 부서명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//
//tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
////tab_1.tabpage_2.dw_print.Object.DataWindow.Zoom = 75
//tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
//
//tab_1.tabpage_3.dw_print_2.Object.DataWindow.Print.Preview = 'YES'
//
//THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')

dw_con.accepttext()
String	ls_year_mon
ls_year_mon = string(dw_con.object.year[1], 'yyyy')   + dw_con.object.month[1]//em_year.text + left(ddlb_month.text,2)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

Long	ll_RowCnt
tab_1.tabpage_1.dw_update.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_update.Retrieve(ls_year_mon)
tab_1.tabpage_1.dw_update.SetReDraw(TRUE)

DateTime	ldt_SysDateTime
ldt_SysDateTime = f_sysdate()	//시스템일자
tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

tab_1.tabpage_3.dw_print_2.Retrieve(ls_year_mon)
tab_1.tabpage_3.dw_print_2.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
tab_1.tabpage_3.dw_print_2.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE


//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	tab_1.tabpage_1.dw_update.SetFocus()
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
//em_year.text = 
dw_con.object.year[1] = today() //left(f_today(),4)
dw_con.object.month[1] = '04'
//ddlb_month.selectitem(1)

tab_1.tabpage_1.dw_update.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)//조회버튼 활성화
//wf_setMenu('I',TRUE)//삽입버튼 활성화
//wf_setMenu('D',TRUE)//삭제버튼 활성화
//wf_setMenu('P',TRUE)//출력버튼 활성화
//wf_setMenu('S',TRUE)//저장버튼 활성화

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//CHOOSE CASE tab_1.SelectedTab
//	CASE 2;f_print(tab_1.tabpage_2.dw_print)
//
//END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_insert;call super::ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long	 ll_InsRow

ll_InsRow = tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_new()

IF ll_InsRow = 0 THEN RETURN

String	ls_yyyymm

dw_con.accepttext()
ls_yyyymm = string(dw_con.object.year[1], 'yyyy') + dw_con.object.month[1]//em_year.text + left(ddlb_month.text,2)

tab_1.tabpage_1.dw_update.setitem(ll_insrow, 'from_date', ls_yyyymm)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우호 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
wf_SetMsg('자료가 추가되었습니다.')
tab_1.tabpage_1.dw_update.SetColumn('member_no')
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
IF tab_1.tabpage_1.dw_update.AcceptText() = -1 THEN
	tab_1.tabpage_1.dw_update.SetFocus()
	RETURN -1
END IF
IF tab_1.tabpage_1.dw_update.ModifiedCount() + tab_1.tabpage_1.dw_update.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'member_no/교원번호'

IF f_chk_null(tab_1.tabpage_1.dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기

ll_Row = tab_1.tabpage_1.dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gs_empcode //gstru_uid_uname.uid			//등록자
	ls_IPAddr    =  gs_ip   // gstru_uid_uname.address		//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = tab_1.tabpage_1.dw_update.GetItemStatus(ll_Row,0,Primary!)
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 저장처리전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		tab_1.tabpage_1.dw_update.Object.worker   [ll_Row] = ls_Worker		//등록일자
		tab_1.tabpage_1.dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록자
		tab_1.tabpage_1.dw_update.Object.ipaddr   [ll_Row] = ls_IPAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	tab_1.tabpage_1.dw_update.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	tab_1.tabpage_1.dw_update.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	tab_1.tabpage_1.dw_update.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = tab_1.tabpage_1.dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF NOT tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSRP')
tab_1.tabpage_1.dw_update.SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;call super::ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
//IF tab_1.tabpage_1.dw_update.ib_RowSingle THEN
	ll_GetRow = tab_1.tabpage_1.dw_update.GetRow()

//IF NOT tab_1.tabpage_1.dw_update.ib_RowSingle THEN ll_GetRow = tab_1.tabpage_1.dw_update.GetSelectedRow(0)

IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
string	ls_msg
Long		ll_DeleteCnt

ll_DeleteCnt = tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	IF tab_1.tabpage_1.dw_update.ib_RowSingle THEN
		/////////////////////////////////////////////////////////////////////////////
		// 3.1 Single 처리인 경우.
		//			3.1.1 저장처리.
		//			3.1.2 한로우를 다시 추가.
		//			3.1.3 데이타원도우를 읽기모드로 수정.
		/////////////////////////////////////////////////////////////////////////////
		IF tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_save() THEN
			tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_append()
			tab_1.tabpage_1.dw_update.Object.DataWindow.ReadOnly = 'YES'
//			wf_SetMenuBtn('RIP')
		END IF
	ELSE
		/////////////////////////////////////////////////////////////////////////////
		//	3.2 Multi 처리인 경우.
		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
		/////////////////////////////////////////////////////////////////////////////
		IF tab_1.tabpage_1.dw_update.RowCount() > 0 THEN
//			wf_SetMenuBtn('RIDSP')
		ELSE
//			wf_SetMenuBtn('RISP')
		END IF
	END IF
ELSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 교직원조건별 검색용을 사용한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 부서명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
dw_con.insertrow(0)

tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
//tab_1.tabpage_2.dw_print.Object.DataWindow.Zoom = 75
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print

tab_1.tabpage_3.dw_print_2.Object.DataWindow.Print.Preview = 'YES'

THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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

type ln_templeft from w_msheet`ln_templeft within w_hin206a
end type

type ln_tempright from w_msheet`ln_tempright within w_hin206a
end type

type ln_temptop from w_msheet`ln_temptop within w_hin206a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin206a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin206a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin206a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin206a
end type

type uc_insert from w_msheet`uc_insert within w_hin206a
end type

type uc_delete from w_msheet`uc_delete within w_hin206a
end type

type uc_save from w_msheet`uc_save within w_hin206a
end type

type uc_excel from w_msheet`uc_excel within w_hin206a
end type

type uc_print from w_msheet`uc_print within w_hin206a
end type

type st_line1 from w_msheet`st_line1 within w_hin206a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hin206a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hin206a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin206a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin206a
end type

type tab_1 from tab within w_hin206a
integer x = 50
integer y = 336
integer width = 4384
integer height = 1968
integer taborder = 120
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
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;
CHOOSE CASE newindex
	CASE 1, 2
		idw_print = tab_1.tabpage_2.dw_print
	Case 3
		idw_print = tab_1.tabpage_3.dw_print_2

END CHOOSE

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1848
string text = "교원업적평가관리"
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

type dw_update from cuo_dwwindow_one_hin within tabpage_1
integer width = 4347
integer height = 1852
integer taborder = 10
string dataobject = "d_hin206a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = FALSE
//ib_SortGubn  = TRUE
//ib_EnterChk  = TRUE
end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
string	ls_member_no, ls_name, ls_gwa, ls_jikwi, ls_jikjong, ls_duty_name
string	ls_yyyymm

ls_yyyymm = getitemstring(row, 'from_date')

choose case dwo.name
	case 'member_no'
		if isnull(data) or trim(data) = '' then return
		
		select	a.name, a.gwa, FU_CODE_NM('HAENG','JIKWI_CODE',a.JIKWI_CODE,'K'),
					FU_CODE_NM('HAENG','JIKJONG_CODE',b.JIKJONG_CODE,'K'), b.duty_name
		into		:ls_name, :ls_gwa, :ls_jikwi, :ls_jikjong, :ls_duty_name
		from		indb.hin001m a, indb.hin003m b
		where		a.duty_code = b.duty_code (+)
		and		substr(a.member_no,1,1) <> 'F'
		and		a.member_no = :data	;
		
		if sqlca.sqlcode <> 0 then
			messagebox('확인', '등록된 교원이 아닙니다.')
			return 1
		end if
		
		if wf_dup_chk(row, ls_yyyymm, data) > 0 then return 1
		
		setitem(row, 'name', ls_name)
		setitem(row, 'gwa', ls_gwa)
		setitem(row, 'com_jikwi_nm', ls_jikwi)
		setitem(row, 'com_jikjong_nm', ls_jikjong)
		setitem(row, 'duty_name', ls_duty_name)
	case 'name'
		if isnull(data) or trim(data) = '' then return
		
		select	a.member_no, a.gwa, FU_CODE_NM('HAENG','JIKWI_CODE',a.JIKWI_CODE,'K'),
					FU_CODE_NM('HAENG','JIKJONG_CODE',b.JIKJONG_CODE,'K'), b.duty_name
		into		:ls_member_no, :ls_gwa, :ls_jikwi, :ls_jikjong, :ls_duty_name
		from		indb.hin001m a, indb.hin003m b
		where		a.duty_code = b.duty_code (+)
		and		substr(a.member_no,1,1) <> 'F'
		and		trim(a.name) = trim(:data)	;
		
		if sqlca.sqlcode <> 0 then
			messagebox('확인', '등록된 교원이 아닙니다.')
			return 1
		end if
		
		if wf_dup_chk(row, ls_yyyymm, ls_member_no) > 0 then return 1

		setitem(row, 'member_no', ls_member_no)
		setitem(row, 'gwa', ls_gwa)
		setitem(row, 'com_jikwi_nm', ls_jikwi)
		setitem(row, 'com_jikjong_nm', ls_jikjong)
		setitem(row, 'duty_name', ls_duty_name)
end choose
end event

event clicked;call super::clicked;String	ls_ColName
ls_ColName = UPPER(dwo.name)
IF ls_ColName = 'DATAWINDOW' THEN RETURN
IF THIS.RowCount() > 0 AND UPPER(RIGHT(ls_ColName,2)) = '_T' AND ib_SortGubn THEN
	Long		ll_RowCnt
	ll_RowCnt = THIS.RowCount()
END IF

end event

event doubleclicked;call super::doubleclicked;string		ls_yyyymm, ls_member_no
s_insa_com	lstr_com, lstr_rtn

if row < 1 then return

if dwo.name <> 'member_no' and dwo.name <> 'name' then return

lstr_com.ls_item[1] = ''				//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = '1'				//교직원구분

OpenWithParm(w_hin000h,lstr_com)

lstr_rtn = Message.PowerObjectParm

IF NOT isValid(lstr_rtn) THEN RETURN

ls_yyyymm = getitemstring(row, 'from_date')

if wf_dup_chk(row, ls_yyyymm, lstr_rtn.ls_item[02]) > 0 then return

setitem(row, 'member_no', lstr_rtn.ls_item[02])
setitem(row, 'name', lstr_rtn.ls_item[01])
setitem(row, 'gwa', lstr_rtn.ls_item[04])
setitem(row, 'com_jikwi_nm', lstr_rtn.ls_item[14])
setitem(row, 'com_jikjong_nm', lstr_rtn.ls_item[13])
setitem(row, 'duty_name', lstr_rtn.ls_item[15])

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1848
string text = "교원업적평가출력"
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
integer height = 1844
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hin206a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1848
string text = "교원업적평가출력(년도별)"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print_2 dw_print_2
end type

on tabpage_3.create
this.dw_print_2=create dw_print_2
this.Control[]={this.dw_print_2}
end on

on tabpage_3.destroy
destroy(this.dw_print_2)
end on

type dw_print_2 from uo_dwfree within tabpage_3
integer width = 4338
integer height = 1844
integer taborder = 150
string dataobject = "d_hin206a_4"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type uo_1 from u_tab within w_hin206a
event destroy ( )
integer x = 1207
integer y = 460
integer taborder = 60
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type dw_con from uo_dwfree within w_hin206a
integer x = 55
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_hin206a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

