$PBExportHeader$w_hin105a.srw
$PBExportComments$호봉코드관리(정규직)
forward
global type w_hin105a from w_msheet
end type
type tab_1 from tab within w_hin105a
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
type tab_1 from tab within w_hin105a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_hin105a
end type
type dw_con from uo_dwfree within w_hin105a
end type
type cb_sal_class_create from uo_imgbtn within w_hin105a
end type
end forward

global type w_hin105a from w_msheet
string title = "호봉코드관리(정규직)"
tab_1 tab_1
uo_1 uo_1
dw_con dw_con
cb_sal_class_create cb_sal_class_create
end type
global w_hin105a w_hin105a

type variables

end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
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

on w_hin105a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
this.dw_con=create dw_con
this.cb_sal_class_create=create cb_sal_class_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.cb_sal_class_create
end on

on w_hin105a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.dw_con)
destroy(this.cb_sal_class_create)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 호봉코드(정규직)를 관리한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회용 - 호봉년도 초기화처리
//////////////////////////////////////////////////////////////////////////////////////
//String	ls_SalYear
//ls_SalYear = MID(f_today(),1,4)
//sle_sal_year.Text = ls_SalYear
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회용 - 직종명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//dw_jikjong_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
//	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ldwc_Temp.SetFilter("code in (0,1,2,4,5,6,9)")
//	ldwc_Temp.Filter()
//END IF
//dw_jikjong_code.InsertRow(0)
//dw_jikjong_code.Object.code.dddw.PercentWidth = 100
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 등록용 - 직급명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//tab_1.tabpage_1.dw_update.GetChild('duty_code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve() = 0 THEN
//	wf_setmsg('직급코드를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ldwc_Temp.SetFilter("MID(code,1,1) in ('2','4','5','6','9') OR "+&
//									"(MID(code,1,1) = '1' AND MID(code,2,1) = '0')")
//	ldwc_Temp.Filter()
//END IF
//
//tab_1.tabpage_1.dw_update.Reset()
//tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
//tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_setMenuBtn('IR')
//
//THIS.Trigger Event ue_retrieve(0,0)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
//
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
// 1.1 호봉년도 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_SalYear
dw_con.accepttext()

ls_SalYear = dw_con.object.sal_year[1]//Trim(sle_sal_year.Text)
IF LEN(ls_SalYear) = 0 OR isNull(ls_SalYear) THEN
	f_set_message("[알림] " + '호봉년도를 입력하시기 바랍니다.', '', parentwin)
	Messagebox("알림", '호봉년도를 입력하시기 바랍니다.')
//	f_dis_msg(3,'호봉년도를 입력하시기 바랍니다.','')
	dw_con.SetFocus()
	RETURN -1
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.2 직종명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JikJongCode
ls_JikJongCode = TRIM(dw_con.Object.jikjong_code[1])
IF LEN(ls_JikJongCode) = 0 OR isNull(ls_JikJongCode) OR ls_JikJongCode = '0' THEN &
	ls_JikJongCode = ''

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
tab_1.tabpage_1.dw_update.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_update.Retrieve(ls_SalYear,ls_JikJongCode)
tab_1.tabpage_1.dw_update.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
DateTime	ldt_SysDateTime
ldt_SysDateTime = f_sysdate()	//시스템일자
tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('IR')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('IDSRP')
	wf_SetMsg('자료가 조회되었습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
RETURN 1
end event

event ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
//IF tab_1.tabpage_1.dw_update.ib_RowSingle THEN &
	ll_GetRow = tab_1.tabpage_1.dw_update.GetRow()
//IF NOT tab_1.tabpage_1.dw_update.ib_RowSingle THEN &
//	ll_GetRow = tab_1.tabpage_1.dw_update.GetSelectedRow(0)
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
Long		ll_DeleteCnt

//IF tab_1.tabpage_1.dw_update.ib_RowSingle OR &
//	tab_1.tabpage_1.dw_update.GetSelectedRow(ll_GetRow) = 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 2.1 삭제전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
	String	ls_SalYear		//호봉년도
	String	ls_DutyNm		//직급명
	String	ls_SalClass		//호봉코드
	
	ls_SalYear  = tab_1.tabpage_1.dw_update.Object.sal_year [ll_GetRow]					//호봉년도
//	ls_DutyNm   = tab_1.tabpage_1.dw_update.Object.Describe(& 
//						"Evaluate('LookUpDisplay(duty_code)'," + String(ll_GetRow) + ")")	//직급명
	ls_SalClass = tab_1.tabpage_1.dw_update.Object.sal_class[ll_GetRow]					//호봉코드
	
	ls_Msg = '자료를 삭제하기겠습니까?~r~n~r~n' + &
				'호봉년도 : ' + ls_SalYear + '~r~n' + &
				'   직급명 : ' + ls_DutyNm + '~r~n' + &
				'호봉코드 : ' + ls_SalClass
//ELSE
////	SetNull(ls_Msg)
//END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
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
//			wf_SetMenuBtn('RI')
		END IF
	ELSE
		/////////////////////////////////////////////////////////////////////////////
		//	3.2 Multi 처리인 경우.
		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
		/////////////////////////////////////////////////////////////////////////////
		IF tab_1.tabpage_1.dw_update.RowCount() > 0 THEN
//			wf_SetMenuBtn('RIDS')
		ELSE
//			wf_SetMenuBtn('RIS')
		END IF
	END IF
ELSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 자료추가전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
////////////////////////////////////////////////////////////////////////////////////
// 1.1 호봉년도 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_SalYear
dw_con.accepttext()
ls_SalYear =  dw_con.object.sal_year[1]// Trim(sle_sal_year.Text)
IF LEN(ls_SalYear) = 0 OR isNull(ls_SalYear) THEN
	f_set_message("[알림] " + '호봉년도를 입력하시기 바랍니다.', '', parentwin)
	Messagebox("알림", '호봉년도를 입력하시기 바랍니다.')
//	f_dis_msg(3,'호봉년도를 입력하시기 바랍니다.','')
	dw_con.SetFocus()
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long	 ll_InsRow
ll_InsRow = tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_new()
IF ll_InsRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_update.Object.sal_year[ll_InsRow] = ls_SalYear
tab_1.tabpage_1.dw_update.Object.sal_amt [ll_InsRow] = 0
tab_1.tabpage_1.dw_update.SetItemStatus(ll_InsRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우호 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('IDSR')
wf_SetMsg('자료가 추가되었습니다.')
tab_1.tabpage_1.dw_update.SetColumn('duty_code')
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
IF tab_1.tabpage_1.dw_update.ModifiedCount() + &
	tab_1.tabpage_1.dw_update.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'sal_year/호봉년도'
ls_NotNullCol[2] = 'duty_code/직급코드'
ls_NotNullCol[3] = 'sal_code/호봉코드'
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
	ls_Worker    = gs_empcode // gstru_uid_uname.uid			//등록자
	ls_IPAddr    = gs_ip  //gstru_uid_uname.address		//등록단말기
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

event ue_init();call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.SelectTab(1)

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
//tab_1.SelectTab(2)
//f_print(tab_1.tabpage_2.dw_print)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 호봉코드(정규직)를 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회용 - 호봉년도 초기화처리
////////////////////////////////////////////////////////////////////////////////////
func.of_design_con( dw_con )
String	ls_SalYear

dw_con.settransobject(sqlca)
dw_con.InsertRow(0)
dw_con.Object.jikjong_code.dddw.PercentWidth = 100

ls_SalYear = MID(f_today(),1,4)
dw_con.object.sal_year[1] = ls_SalYear
//sle_sal_year.Text = ls_SalYear
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회용 - 직종명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////



DataWindowChild	ldwc_Temp
dw_con.GetChild('jikjong_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikjong_code',0) = 0 THEN
	wf_setmsg('공통코드[직종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ldwc_Temp.SetFilter("code in (0,1,2,4,5,6,9)")
	ldwc_Temp.Filter()
END IF
//dw_con.InsertRow(0)
//dw_con.Object.jikjong_code.dddw.PercentWidth = 100
//////////////////////////////////////////////////////////////////////////////////////
// 1.3 등록용 - 직급명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_update.GetChild('duty_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('직급코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ldwc_Temp.SetFilter("MID(code,1,1) in ('2','4','5','6','9') OR "+&
									"(MID(code,1,1) = '1' AND MID(code,2,1) = '0')")
	ldwc_Temp.Filter()
END IF

tab_1.tabpage_1.dw_update.Reset()
tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print
///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenuBtn('IR')

THIS.Trigger Event ue_retrieve()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_templeft.beginx

If cb_sal_class_create.Enabled Then
	cb_sal_class_create.X		= ll_stnd_pos
	ll_stnd_pos		= ll_stnd_pos - cb_sal_class_create.Width - 16
Else
	cb_sal_class_create.Visible	= FALSE
End If
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "직급별 호봉코드 리스트")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hin105a
end type

type ln_tempright from w_msheet`ln_tempright within w_hin105a
end type

type ln_temptop from w_msheet`ln_temptop within w_hin105a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin105a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin105a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin105a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin105a
end type

type uc_insert from w_msheet`uc_insert within w_hin105a
end type

type uc_delete from w_msheet`uc_delete within w_hin105a
end type

type uc_save from w_msheet`uc_save within w_hin105a
end type

type uc_excel from w_msheet`uc_excel within w_hin105a
end type

type uc_print from w_msheet`uc_print within w_hin105a
end type

type st_line1 from w_msheet`st_line1 within w_hin105a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hin105a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hin105a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin105a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin105a
boolean visible = true
end type

type tab_1 from tab within w_hin105a
integer x = 23
integer y = 324
integer width = 4411
integer height = 1972
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

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4375
integer height = 1852
string text = "호봉코드 관리"
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
integer y = 8
integer width = 4375
integer height = 1844
integer taborder = 20
string dataobject = "d_hin105a_1"
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
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
String	ls_Null
Integer	li_Null

ls_ColName = STRING(dwo.name)
ls_ColData = TRIM(data)
SetNull(ls_Null)
SetNull(li_Null)

String	ls_Find
Long		ll_Find

CHOOSE CASE ls_ColName
	CASE ''
		///////////////////////////////////////////////////////////////////////////////// 
		//	
		///////////////////////////////////////////////////////////////////////////////// 
	CASE ELSE
		
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4375
integer height = 1852
string text = "호봉코드 리스트"
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
integer y = 4
integer width = 4375
integer height = 1848
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hin105a_9"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_sal_class_create
//	기 능 설 명: 호봉코드를 생성한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 호봉년도 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_SalYear
dw_con.accepttext()
ls_SalYear = dw_con.object.sal_year[1]//Trim(sle_sal_year.Text)
IF LEN(ls_SalYear) = 0 OR isNull(ls_SalYear) THEN
	f_set_message("[알림] " + '호봉년도를 입력하시기 바랍니다.', '', parentwin)
	Messagebox("알림", '호봉년도를 입력하시기 바랍니다.')
//	f_dis_msg(3,'호봉년도를 입력하시기 바랍니다.','')
	dw_con.SetFocus()
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 생성여부확인
///////////////////////////////////////////////////////////////////////////////////////
Integer	li_Rtn
li_Rtn = Messagebox("알림", '호봉코드를 호봉년도('+ls_SalYear+')로 생성하시겠습니까' , Exclamation!, OKCancel!, 2)

IF li_Rtn = 2 THEN
	f_set_message("[알림] " + '호봉코드 생성작업을 취소하셨습니다.', '', parentwin)
//	f_dis_msg(1,'호봉코드 생성작업을 취소하셨습니다.','')
	RETURN
END IF

long ll_cnt
select count(*)
  into :ll_cnt
  from INDB.HIN004M
 where SAL_YEAR = :ls_SalYear;

if ll_cnt > 0 then
	li_Rtn = Messagebox("알림",'호봉년도('+ls_SalYear+')에 이미 생성된 호봉이 있습니다. 재 생성하시겠습니까' , Exclamation!, OKCancel!, 2)
	IF li_Rtn = 2 THEN
		f_set_message("[알림] " + '호봉코드 생성작업을 취소하셨습니다.' , '', parentwin)
//		f_dis_msg(1,'호봉코드 생성작업을 취소하셨습니다.','')
		RETURN
	END IF
	
	Delete 
	  from INDB.HIN004M
    where SAL_YEAR = :ls_SalYear;
	 
end if	 
///////////////////////////////////////////////////////////////////////////////////////
// 3. 호봉코드 생성작업 및 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '호봉코드를 생성중입니다...', '', parentwin)
//f_dis_msg(1,'호봉코드를 생성중입니다...','')
INSERT	INTO	INDB.HIN004M (SAL_YEAR, DUTY_CODE, SAL_CLASS, SAL_AMT, REMARK, SAL_CLASS_NM)
SELECT	:ls_SalYear,
			A.DUTY_CODE,
			A.SAL_CLASS,
			A.SAL_AMT,
			A.REMARK,
			A.SAL_CLASS_NM
FROM		INDB.HIN004M A
WHERE SAL_YEAR = TO_CHAR(TO_NUMBER(:LS_SALYEAR)-1);

CHOOSE CASE SQLCA.SQLCODE
	CASE 0
		COMMIT;
		Messagebox('',ls_SalYear+'년도 호봉코드를 생성하였습니다.')
		wf_SetMsg('호봉코드를 생성하였습니다.')
		THIS.TRIGGEREVENT('ue_retrieve')
	CASE ELSE
		wf_SetMsg('호봉코드 생성 중 오류 발생하였습니다.')
		MessageBox('오류',&
						'호봉코드 생성 중 전산장애가 발생되었습니다.~r~n' + &
						'하단의 장애번호와 장애내역을~r~n' + &
						'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
						'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
						'장애내역 : ' + SQLCA.SqlErrText)
		ROLLBACK USING SQLCA;
END CHOOSE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type uo_1 from u_tab within w_hin105a
event destroy ( )
integer x = 791
integer y = 324
integer taborder = 40
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type dw_con from uo_dwfree within w_hin105a
integer x = 46
integer y = 164
integer width = 4393
integer height = 108
integer taborder = 70
string dataobject = "d_hin105a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_sal_class_create from uo_imgbtn within w_hin105a
integer x = 1047
integer y = 40
integer taborder = 60
boolean bringtotop = true
long backcolor = 1073741824
string btnname = "호봉코드생성"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_sal_class_create
//	기 능 설 명: 호봉코드를 생성한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 호봉년도 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_SalYear
dw_con.accepttext()
ls_SalYear = dw_con.object.sal_year[1]//Trim(sle_sal_year.Text)
IF LEN(ls_SalYear) = 0 OR isNull(ls_SalYear) THEN
	f_set_message("[알림] " + '호봉년도를 입력하시기 바랍니다.' , '', parentwin)
	Messagebox("알림", '호봉년도를 입력하시기 바랍니다.')
//	f_dis_msg(3,'호봉년도를 입력하시기 바랍니다.','')
	dw_con.SetFocus()
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 생성여부확인
///////////////////////////////////////////////////////////////////////////////////////
Integer	li_Rtn
li_Rtn = Messagebox("알림", '호봉코드를 호봉년도('+ls_SalYear+')로 생성하시겠습니까', Exclamation!, OKCancel!, 2)
//f_dis_msg(2,'호봉코드를 호봉년도('+ls_SalYear+')로 생성하시겠습니까','IY1')
IF li_Rtn = 2 THEN
	f_set_message("[알림] " + '호봉코드 생성작업을 취소하셨습니다.', '', parentwin)
//	f_dis_msg(1,'호봉코드 생성작업을 취소하셨습니다.','')
	RETURN
END IF

long ll_cnt
select count(*)
  into :ll_cnt
  from INDB.HIN004M
 where SAL_YEAR = :ls_SalYear;

if ll_cnt > 0 then
	li_Rtn = Messagebox("알림", '호봉년도('+ls_SalYear+')에 이미 생성된 호봉이 있습니다. 재 생성하시겠습니까', Exclamation!, OKCancel!, 2)
	IF li_Rtn = 2 THEN
		f_set_message("[알림] " + '호봉코드 생성작업을 취소하셨습니다.', '', parentwin)
//		f_dis_msg(1,'호봉코드 생성작업을 취소하셨습니다.','')
		RETURN
	END IF
	
	Delete 
	  from INDB.HIN004M
    where SAL_YEAR = :ls_SalYear;
	 
end if	 
///////////////////////////////////////////////////////////////////////////////////////
// 3. 호봉코드 생성작업 및 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
f_set_message("[알림] " + '호봉코드를 생성중입니다...', '', parentwin)
//f_dis_msg(1,'호봉코드를 생성중입니다...','')
INSERT	INTO	INDB.HIN004M (SAL_YEAR, DUTY_CODE, SAL_CLASS, SAL_AMT, REMARK, SAL_CLASS_NM)
SELECT	:ls_SalYear,
			A.DUTY_CODE,
			A.SAL_CLASS,
			A.SAL_AMT,
			A.REMARK,
			A.SAL_CLASS_NM
FROM		INDB.HIN004M A
WHERE SAL_YEAR = TO_CHAR(TO_NUMBER(:LS_SALYEAR)-1);

CHOOSE CASE SQLCA.SQLCODE
	CASE 0
		COMMIT;
		Messagebox('',ls_SalYear+'년도 호봉코드를 생성하였습니다.')
		wf_SetMsg('호봉코드를 생성하였습니다.')
		THIS.TRIGGEREVENT('ue_retrieve')
	CASE ELSE
		wf_SetMsg('호봉코드 생성 중 오류 발생하였습니다.')
		MessageBox('오류',&
						'호봉코드 생성 중 전산장애가 발생되었습니다.~r~n' + &
						'하단의 장애번호와 장애내역을~r~n' + &
						'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
						'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
						'장애내역 : ' + SQLCA.SqlErrText)
		ROLLBACK USING SQLCA;
END CHOOSE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cb_sal_class_create.destroy
call uo_imgbtn::destroy
end on

