$PBExportHeader$w_hin302b.srw
$PBExportComments$기간제임용 대상자생성
forward
global type w_hin302b from w_msheet
end type
type tab_1 from tab within w_hin302b
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
type tab_1 from tab within w_hin302b
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_list from cuo_dwwindow_one_hin within w_hin302b
end type
type dw_con from uo_dwfree within w_hin302b
end type
type uo_member from cuo_insa_member within w_hin302b
end type
type uo_2 from u_tab within w_hin302b
end type
type cb_create from uo_imgbtn within w_hin302b
end type
end forward

global type w_hin302b from w_msheet
string title = "재임용 대상자생성"
event type boolean ue_chk_condition ( )
tab_1 tab_1
dw_list dw_list
dw_con dw_con
uo_member uo_member
uo_2 uo_2
cb_create cb_create
end type
global w_hin302b w_hin302b

type variables
String	is_JikJongCode		//직종구분
String	is_AnnounceDate	//기준일자
String	is_KName				//성명

//DataWindow	idw_update
//DataWindow	idw_print
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

event type boolean ue_chk_condition();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_chk_condition
//	기 능 설 명: 조회조건체크처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
dw_con.accepttext()
////////////////////////////////////////////////////////////////////////////////////
// 1.1 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_JikJongCode =  dw_con.object.gubn[1]// MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 기준일자 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_Year
//em_year.GetData(ls_Year)
ls_Year = String(dw_con.object.year[1], 'yyyy')//TRIM(ls_Year)
IF LEN(ls_Year) = 0 OR isNull(ls_Year) THEN
	MessageBox('확인','기준년도를 입력하시기 바랍니다.')
	dw_con.SetFocus()
	RETURN FALSE
END IF
String	ls_Date
String	ls_DateGb
//ls_DateGb = MID(ddlb_date.Text,1,1)	//1. 04월01일
ls_Date   =  dw_con.object.date[1]//MID(ddlb_date.Text,4)
IF LEN(ls_Year) = 0 OR isNull(ls_Year) THEN
	MessageBox('확인','기준일자를 선택하시기 바랍니다.')
	dw_con.SetFocus()
	RETURN FALSE
END IF
/////////////////////////////////////////////////////////////////////////////////
// 1.2.1 기준일자에서 숫자만을 가지고 온다(예 : 04월01일 -> 0401)
/////////////////////////////////////////////////////////////////////////////////
Long		ll_idx
Long		ll_Len
String	ls_Tmp
String	ls_Rtn
ll_Len = LEN(ls_Date)
FOR ll_idx = 1 TO ll_Len
	ls_Tmp = MID(ls_Date,ll_idx,1)
	IF Pos('1234567890',ls_Tmp) = 0 THEN CONTINUE
	ls_Rtn = ls_Rtn + ls_Tmp
NEXT
is_AnnounceDate = ls_Year + ls_Rtn
////////////////////////////////////////////////////////////////////////////////////
// 1.3 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_KName = TRIM(uo_member.sle_kname.Text)
IF ISNULL(is_KName) THEN is_KName = '%'

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

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

on w_hin302b.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_list=create dw_list
this.dw_con=create dw_con
this.uo_member=create uo_member
this.uo_2=create uo_2
this.cb_create=create cb_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_member
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.cb_create
end on

on w_hin302b.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.uo_2)
destroy(this.cb_create)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 기간제임용대상자를 생성한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//idw_update[1]  = tab_1.tabpage_1.dw_update
//idw_print = tab_1.tabpage_2.dw_print
//////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
//////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 기준일자
//////////////////////////////////////////////////////////////////////////////////////
//em_year.Text = MID(f_today(),1,4)
//ddlb_date.Selectitem(1)
//
//tab_1.tabpage_1.dw_update.Reset()
//tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
//tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
//tab_1.tabpage_2.dw_print.Object.DataWindow.zoom = 95
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN -1

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
idw_update[1].SetReDraw(FALSE)
ll_RowCnt = idw_update[1].Retrieve(is_AnnounceDate,is_KName,is_JikJongCode)
idw_update[1].SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('SRP')
	wf_SetMsg('자료가 조회되었습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
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
IF idw_update[1].AcceptText() = -1 THEN
	idw_update[1].SetFocus()
	RETURN -1
END IF
IF idw_update[1].ModifiedCount() + idw_update[1].DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'member_no/개인번호'
ls_NotNullCol[2] = 'sign_opt/순번'
ls_NotNullCol[3] = 'change_opt/발령구분'
ls_NotNullCol[4] = 'from_date/발령기간'
IF f_chk_null(idw_update[1],ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
// 3.1 재임용대상자 생성 전 삭제여부체크
//			직급코드가 교수는 제외, 변동구분이 정기승진
/////////////////////////////////////////////////////////////////////////////////////
Long		ll_Cnt	//건수
SELECT	COUNT(*)
INTO		:ll_Cnt
FROM		INDB.HIN007H A
WHERE		A.DUTY_CODE	BETWEEN DECODE(:is_JikJongCode,'1','000','2','200','000')
							AND	  DECODE(:is_JikJongCode,'1','199','2','999','999')
AND		A.CHANGE_OPT = 31
AND		A.FROM_DATE  = :is_AnnounceDate;
IF ll_Cnt > 0 THEN
	Integer	li_Rtn
	li_Rtn = MessageBox('확인','기존에 생성된자료가 존재합니다.~r~n'+&
										'기존자료를 삭제하고 다시 생성하시겠습니까?',&
										Question!,YesNo!,1)
	IF li_Rtn = 1 THEN
		DELETE	FROM	INDB.HIN007H
		WHERE		DUTY_CODE	BETWEEN DECODE(:is_JikJongCode,'1','000','2','200','000')
									AND	  DECODE(:is_JikJongCode,'1','199','2','999','999')
		AND		CHANGE_OPT = 31
		AND		FROM_DATE  = :is_AnnounceDate;
		IF SQLCA.SQLCODE <> 0 THEN
			wf_SetMsg('인사변동사항 삭제처리 중 에러가 발생하였습니다.')
			MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF
	ELSE
		wf_SetMsg('재임용대상자 생성을 취소하였습니다.')
		RETURN -1
	END IF
END IF
////////////////////////////////////////////////////////////////////////////////////
// 3.2 저장처리
////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IpAddr		//등록단말기

String	ls_MemberNo		//개인번호
Integer	li_SeqNo

ll_Row = idw_update[1].GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode //gstru_uid_uname.uid		//등록자
	ls_IpAddr    = gs_ip   //gstru_uid_uname.address	//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = idw_update[1].GetItemStatus(ll_Row,0,Primary!)
	ls_MemberNo = idw_update[1].Object.member_no[ll_Row]
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		wf_SetMsg('인사발령사항 순번 생성 중 입니다...')
		SELECT	NVL(MAX(A.SEQ_NO),0) + 1
		INTO		:li_SeqNo
		FROM		INDB.HIN007H A
		WHERE		A.MEMBER_NO = :ls_MemberNo;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
			CASE 100
				li_SeqNo = 1
			CASE ELSE
				wf_SetMsg('인사발령사항 순번 생성 중 오류가 발생하였습니다.')
				MessageBox('오류',&
								'인사발령사항 순번 생성시 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
				ROLLBACK USING SQLCA;
				RETURN -1
		END CHOOSE
		idw_update[1].Object.seq_no   [ll_Row] = li_SeqNo
		idw_update[1].Object.worker   [ll_Row] = ls_Worker		//등록자
		idw_update[1].Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
		idw_update[1].Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2.1 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	idw_update[1].Object.job_uid  [ll_Row] = ls_Worker		//등록자
	idw_update[1].Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	idw_update[1].Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = idw_update[1].GetNextModified(ll_Row,primary!)
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
//wf_SetMenuBtn('SR')
idw_update[1].SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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
idw_update[1].Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')
dw_con.SetFocus()
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

IF tab_1.tabpage_1.dw_update.ib_RowSingle OR &
	tab_1.tabpage_1.dw_update.getrow() = 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 2.1 삭제전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
ELSE
//	SetNull(ls_Msg)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
ll_DeleteCnt = tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	////////////////////////////////////////////////////////////////////////////////////
	//	3.2 Multi 처리인 경우.
	//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
	////////////////////////////////////////////////////////////////////////////////////
	IF tab_1.tabpage_1.dw_update.RowCount() > 0 THEN
//		wf_SetMenuBtn('RDS')
	ELSE
//		wf_SetMenuBtn('RS')
	END IF
ELSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 기간제임용대상자를 생성한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
dw_con.insertrow(0)
idw_update[1]  = tab_1.tabpage_1.dw_update
idw_print = tab_1.tabpage_2.dw_print
////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 기준일자
////////////////////////////////////////////////////////////////////////////////////
//em_year.Text = MID(f_today(),1,4)
dw_con.object.year[1] = today()
dw_con.object.date[1] = '0301'//ddlb_date.Selectitem(1)

tab_1.tabpage_1.dw_update.Reset()
tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
tab_1.tabpage_2.dw_print.Object.DataWindow.zoom = 95

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
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

type ln_templeft from w_msheet`ln_templeft within w_hin302b
end type

type ln_tempright from w_msheet`ln_tempright within w_hin302b
end type

type ln_temptop from w_msheet`ln_temptop within w_hin302b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin302b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin302b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin302b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin302b
end type

type uc_insert from w_msheet`uc_insert within w_hin302b
end type

type uc_delete from w_msheet`uc_delete within w_hin302b
end type

type uc_save from w_msheet`uc_save within w_hin302b
end type

type uc_excel from w_msheet`uc_excel within w_hin302b
end type

type uc_print from w_msheet`uc_print within w_hin302b
end type

type st_line1 from w_msheet`st_line1 within w_hin302b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_msheet`st_line2 within w_hin302b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_msheet`st_line3 within w_hin302b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin302b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin302b
end type

type tab_1 from tab within w_hin302b
integer x = 50
integer y = 336
integer width = 4379
integer height = 2260
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
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
integer width = 4343
integer height = 2140
long backcolor = 16777215
string text = "기간제임용대상자 관리"
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
integer width = 4343
integer height = 1828
integer taborder = 50
string dataobject = "d_hin302b_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = TRUE
//ib_SortGubn  = TRUE
//ib_EnterChk  = FALSE
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4343
integer height = 2140
long backcolor = 16777215
string text = "기간제임용대상자 출력"
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
integer y = 8
integer width = 4329
integer height = 1812
integer taborder = 200
string dataobject = "d_hin302b_9"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_list from cuo_dwwindow_one_hin within w_hin302b
boolean visible = false
integer x = 32
integer y = 1512
integer width = 3785
integer height = 800
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_hin302b_2"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = true
boolean righttoleft = true
end type

type dw_con from uo_dwfree within w_hin302b
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hin301b_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin302b
event destroy ( )
integer x = 2171
integer y = 176
integer taborder = 80
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type uo_2 from u_tab within w_hin302b
event destroy ( )
integer x = 1262
integer y = 340
integer taborder = 80
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_2.destroy
call u_tab::destroy
end on

type cb_create from uo_imgbtn within w_hin302b
event destroy ( )
integer x = 59
integer y = 36
integer taborder = 51
boolean bringtotop = true
string btnname = "기간제  대상자생성"
end type

on cb_create.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_create
//	기 능 설 명: 정기승진대상자 생성
//	작성/수정자: 
//	작성/수정일: 

//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
IF NOT PARENT.TRIGGER EVENT ue_chk_condition() THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 생성용데이타원도우 변경처리
///////////////////////////////////////////////////////////////////////////////////////
IF is_JikJongCode = '1' THEN
	dw_list.DataObject = 'd_hin301b_2'
ELSE
	dw_list.DataObject = 'd_hin301b_3'
END IF
dw_list.SetTransObject(SQLCA)

idw_update[1].Reset()
///////////////////////////////////////////////////////////////////////////////////////
// 3. 정기승진대상자 생성
///////////////////////////////////////////////////////////////////////////////////////
Long			ll_InsRow				//추가된행
Long			ll_Row					//현재행
Long			ll_RowCnt				//총건수

//인사변동사항LAYOUT
String		ls_MemberNo				//개인번호
String		ls_ChangeDate			//발령일자
Integer		li_ChangeOpt = 21		//변동코드(정기승진:21)
String		ls_AnnounceReason = '정기승진'	//변동사유
String		ls_AnnounceCon    = '정기승진'	//변동내용
String		ls_ToDate				//발령종료일
String		ls_DeptCode				//부서코드
String		ls_SosokDate			//소속일자
String		ls_JikJongDate			//직종일자
Integer		li_JikWiCode			//직위코드
String		ls_UpDutyCode			//직급코드
Decimal{2}	ldc_SpendYear			//소요년월
String		ls_DutyCode				//직급코드
String		ls_DutyDate				//직급일자
String		ls_SalYear				//호봉년도
String		ls_SalClass				//호봉코드
String		ls_SalDate				//호봉일자
Integer		li_SalLeftMonth		//호봉잔여월수
String		ls_JaeImYongStart		//재임용시작일
String		ls_JaeImYongEnd		//재임용종료일
String		ls_RetireDate			//퇴직일자
Integer		li_OldChangeOpt		//구발령코드
String		ls_OldDept				//구조직코드
Integer		li_JikMuCode			//직무코드
Integer		li_SignOpt = 1			//결재구분(미결:1)
Integer		li_CancelOpt			//탈락사유

String		ls_KName					//성명
String		ls_DeptNm				//부서명
String		ls_JikWiNm				//직위명
String		ls_DutyNm				//직급명	
String		ls_JikMuNm				//직무명
Long			ll_SalClass				//잔여월수
Date			ld_DutyDate				//발령일자
Integer		li_Year					//소요년월중 년
Integer		li_Month					//소요년수중 월
////////////////////////////////////////////////////////////////////////////////////
// 3.1 정기승진대상자 생성
////////////////////////////////////////////////////////////////////////////////////
dw_list.SetReDraw(FALSE)
dw_list.Reset()
ll_RowCnt = dw_list.Retrieve(is_AnnounceDate,is_KName)
dw_list.SetReDraw(TRUE)
////////////////////////////////////////////////////////////////////////////////////
// 3.2 정기승진대상자 추가
////////////////////////////////////////////////////////////////////////////////////
idw_update[1].SetReDraw(FALSE)
idw_update[1].Reset()
FOR ll_Row = 1 TO ll_RowCnt
	ls_MemberNo       = dw_list.Object.member_no      [ll_Row]	//개인번호
	SetNull(ls_ToDate)
	ls_DeptCode       = dw_list.Object.dept_code      [ll_Row]	//조직코드
	ls_SosokDate      = dw_list.Object.sosok_date     [ll_Row]	//소속일자
	ls_JikJongDate    = dw_list.Object.jikjong_date   [ll_Row]	//직종일자
	li_JikWiCode      = dw_list.Object.jikwi_code     [ll_Row]	//직위코드
	ls_UpDutyCode     = dw_list.Object.up_duty_code   [ll_Row]	//상위직급코드
	ldc_SpendYear     = dw_list.Object.spend_year     [ll_Row]	//소요년월
	ls_DutyCode       = dw_list.Object.duty_code      [ll_Row]	//직급코드
	ls_DutyDate       = dw_list.Object.duty_date      [ll_Row]	//직급일자
	ls_SalYear        = dw_list.Object.sal_year       [ll_Row]	//호봉년도
	ls_SalClass       = dw_list.Object.sal_class      [ll_Row]	//호봉코드
	ls_SalDate        = dw_list.Object.sal_date       [ll_Row]	//호봉일자
	li_SalLeftMonth   = dw_list.Object.sal_leftmonth  [ll_Row]	//호봉잔여월
	ls_JaeImYongStart = dw_list.Object.jaeimyong_start[ll_Row]	//재임용시작일
	ls_JaeImYongEnd   = dw_list.Object.jaeimyong_end  [ll_Row]	//재임용종료일
	ls_RetireDate     = dw_list.Object.retire_date    [ll_Row]	//퇴직일자
	li_JikMuCode      = dw_list.Object.jikmu_code     [ll_Row]	//직무코드
	ls_KName          = dw_list.Object.kname          [ll_Row]	//성명
	ls_DeptNm         = dw_list.Object.com_dept_nm    [ll_Row]	//부서명
	ls_JikWiNm        = dw_list.Object.com_jikwi_nm   [ll_Row]	//직위명
	ls_DutyNm         = dw_list.Object.com_duty_nm    [ll_Row]	//직급명	
	ls_JikMuNm        = dw_list.Object.com_jikmu_nm   [ll_Row]	//직무명
	
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2.1 호봉처리
	/////////////////////////////////////////////////////////////////////////////////
	ll_SalClass = Integer(MID(ls_SalClass,2,2))
	CHOOSE CASE UPPER(SQLCA.ServerName)
		CASE 'CWU'
			CHOOSE CASE ll_SalClass
				CASE IS < 20; ll_SalClass -= 1
				CASE IS < 30; ll_SalClass -= 2
				CASE IS < 40; ll_SalClass -= 3
				CASE ELSE   ; ll_SalClass = 0
			END CHOOSE
		CASE 'ORA9'
			ll_SalClass = ll_SalClass - 1
			IF ll_SalClass <= 0 THEN ll_SalClass = 1
	END CHOOSE
	IF MID(ls_SalClass,1,1) >= 'G' THEN
		ls_SalClass = MID(ls_SalClass,1,1) + String(ll_SalClass,'00')
	ELSE
		ls_SalClass = String(ll_SalClass,'000')
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2.2 추가처리
	/////////////////////////////////////////////////////////////////////////////////
		 
	ll_InsRow = idw_update[1].InsertRow(0)
	IF ll_InsRow = 0 THEN EXIT

	idw_update[1].Object.member_no        [ll_InsRow] = ls_MemberNo
	idw_update[1].Object.from_date        [ll_InsRow] = is_AnnounceDate
	idw_update[1].Object.change_opt       [ll_InsRow] = li_ChangeOpt
	idw_update[1].Object.change_reason    [ll_InsRow] = ls_AnnounceReason
	idw_update[1].Object.change_con       [ll_InsRow] = ls_AnnounceCon
	idw_update[1].Object.to_date          [ll_InsRow] = ls_ToDate
	idw_update[1].Object.gwa              [ll_InsRow] = ls_DeptCode
	idw_update[1].Object.sosok_date       [ll_InsRow] = ls_SosokDate
	idw_update[1].Object.jikjong_date     [ll_InsRow] = ls_JikJongDate
	idw_update[1].Object.jikwi_code       [ll_InsRow] = li_JikWiCode
	idw_update[1].Object.duty_code        [ll_InsRow] = ls_UpDutyCode
	idw_update[1].Object.duty_date        [ll_InsRow] = is_AnnounceDate
	idw_update[1].Object.sal_year         [ll_InsRow] = ls_SalYear
	idw_update[1].Object.sal_class        [ll_InsRow] = ls_SalClass
	idw_update[1].Object.sal_date         [ll_InsRow] = is_AnnounceDate
	idw_update[1].Object.sal_leftmonth    [ll_InsRow] = li_SalLeftMonth
	idw_update[1].Object.jaeimyong_start  [ll_InsRow] = ls_JaeImYongStart
	idw_update[1].Object.jaeimyong_end    [ll_InsRow] = ls_JaeImYongEnd
	idw_update[1].Object.retire_date      [ll_InsRow] = ls_RetireDate
	idw_update[1].Object.old_change_opt   [ll_InsRow] = li_ChangeOpt
	idw_update[1].Object.old_gwa          [ll_InsRow] = ls_DeptCode
	idw_update[1].Object.jikmu_code       [ll_InsRow] = li_JikMuCode
	idw_update[1].Object.sign_opt         [ll_InsRow] = li_SignOpt
	idw_update[1].Object.com_member_nm    [ll_InsRow] = ls_KName
	idw_update[1].Object.com_change_opt_nm[ll_InsRow] = ls_AnnounceReason
	idw_update[1].Object.com_dept_nm      [ll_InsRow] = ls_DeptNm
	idw_update[1].Object.com_jikwi_nm     [ll_InsRow] = ls_JikWiNm
	idw_update[1].Object.com_duty_nm      [ll_InsRow] = ls_DutyNm
	idw_update[1].Object.com_jikmu_nm     [ll_InsRow] = ls_JikMuNm
	idw_update[1].Object.com_sign_nm      [ll_InsRow] = '미결'
NEXT
idw_update[1].SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_InsRow > 0 THEN
//	wf_SetMenuBtn('SDRP')
	wf_SetMsg('정기승진대상자가 생성되었습니다. 확인 후 자료를 저장하시기 바랍니다.')
ELSE
//	wf_SetMenuBtn('R')
	wf_SetMsg('미결인 건이 있거나 정기승진대상자가 없습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

