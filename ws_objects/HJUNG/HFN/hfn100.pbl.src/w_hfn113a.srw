$PBExportHeader$w_hfn113a.srw
$PBExportComments$기초잔액관리
forward
global type w_hfn113a from w_msheet
end type
type tab_1 from tab within w_hfn113a
end type
type tabpage_1 from userobject within tab_1
end type
type uo_3 from cuo_search within tabpage_1
end type
type dw_update from cuo_dwwindow_one_hin within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
uo_3 uo_3
dw_update dw_update
gb_4 gb_4
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
type dw_print1 from uo_dwfree within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_print1 dw_print1
end type
type tab_1 from tab within w_hfn113a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type dw_con from uo_dwfree within w_hfn113a
end type
type uo_tab from u_tab within w_hfn113a
end type
end forward

global type w_hfn113a from w_msheet
tab_1 tab_1
dw_con dw_con
uo_tab uo_tab
end type
global w_hfn113a w_hfn113a

type variables
DataWindow  idw_print1, idw_print2

end variables

forward prototypes
public function integer wf_duplicate_chk (long al_row, string as_acct_code, long al_mana_code, string as_mana_data)
public function boolean wf_update (integer ai_acct_class, string as_bdgt_year, string as_worker, string as_ipaddr, datetime adt_workdate)
end prototypes

public function integer wf_duplicate_chk (long al_row, string as_acct_code, long al_mana_code, string as_mana_data);// =============================================================================================================
// 기    능 : 	Data Duplicate Check
// 작 성 인 : 	이현수
// 작성일자 : 	2002.11
// 함수원형 : 	wf_duplicate_chk(long	al_row, string	as_acct_code, integer	ai_mana_code, string	as_mana_date)
// 인    수 :	al_row			-	Row
//					as_acct_code	-	계정과목코드
//					ai_mana_code	-	관리항목코드
//					as_mana_data	-	관리항목Data
// 되 돌 림 :	integer
// 주의사항 :
// 수정사항 :
// =============================================================================================================

long		ll_rowcount, ll_row

ll_rowcount	=	idw_update[1].rowcount()

if ll_rowcount	=	1	then	return	0

ll_row	=	idw_update[1].find("hfn501h_acct_code	=	'"	+	as_acct_code	+	&
									 "'	and	string(hfn501h_mana_code)	=	'"	+	string(al_mana_code)	+	&
									 "'	and	trim(hfn501h_mana_data) = 	'"	+	trim(as_mana_data)	+	"'", 1, ll_rowcount)

if ll_row	=	al_row	then	
	if ll_row	=	ll_rowcount	then	return	0
	
	ll_row	=	idw_update[1].find("hfn501h_acct_code	=	'"	+	as_acct_code	+	&
										 "'	and	string(hfn501h_mana_code)	=	'"	+	string(al_mana_code)	+	&
										 "'	and	trim(hfn501h_mana_data) = 	'"	+	trim(as_mana_data)	+	"'", 1, ll_rowcount)
end if

if ll_row	>	0	then
	f_messagebox('1', '자료가 중복되었습니다.~n~n확인 후 다시 입력해 주시기 바랍니다.!')
	return	1
end if

Return 0

end function

public function boolean wf_update (integer ai_acct_class, string as_bdgt_year, string as_worker, string as_ipaddr, datetime adt_workdate);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: wf_update
//	기 능 설 명: 총계정원장 테이블에 자료저장
//	기 능 설 명: 
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 총계정원장 저장
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
// 1.1 총계정원장 삭제
//////////////////////////////////////////////////////////////////////////////////////////
DELETE	FROM	FNDB.HFN502H A
WHERE 	A.ACCT_CLASS = :AI_ACCT_CLASS
AND		A.BDGT_YEAR  = :AS_BDGT_YEAR
AND		A.ACCT_DATE  = :AS_BDGT_YEAR||'0000' ;
	
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('기초잔액자료 삭제처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN FALSE
END IF

//////////////////////////////////////////////////////////////////////////////////////////
// 1.2 총계정원장 저장
//////////////////////////////////////////////////////////////////////////////////////////
INSERT INTO	FNDB.HFN502H
SELECT	A.ACCT_CLASS,
			A.BDGT_YEAR,
			A.ACCT_DATE,
			A.ACCT_CODE,
			NVL(SUM(A.DR_ALT_AMT),0),
			NVL(SUM(A.DR_CASH_AMT),0),
			NVL(SUM(A.CR_ALT_AMT),0),
			NVL(SUM(A.CR_CASH_AMT),0),
			:AS_WORKER,
			:AS_IPADDR,
			:ADT_WORKDATE,
			:AS_WORKER,
			:AS_IPADDR,
			:ADT_WORKDATE
FROM		FNDB.HFN501H A
WHERE 	A.ACCT_CLASS = :AI_ACCT_CLASS
AND		A.BDGT_YEAR  = :AS_BDGT_YEAR
AND		A.ACCT_DATE  = :AS_BDGT_YEAR||'0000'
GROUP BY	A.ACCT_CLASS, A.BDGT_YEAR, A.ACCT_DATE, A.ACCT_CODE ;
			
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('기초잔액자료 저장처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN FALSE
END IF

Return True
end function

on w_hfn113a.create
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

on w_hfn113a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_tab)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 기초잔액관리.
////	작 성 인 : 이현수
////	작성일자 : 2002.11
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//
//idw_update[1] = tab_1.tabpage_1.dw_update
//idw_print  = tab_1.tabpage_2.dw_print
//idw_print1 = tab_1.tabpage_3.dw_print1
//
//idw_update[1].ShareData(idw_print)
//idw_print.Object.DataWindow.Print.Preview = 'YES'
//idw_print1.Object.DataWindow.Print.Preview = 'YES'
//
//tab_1.tabpage_1.uo_3.uf_reset(idw_update[1], 'hfn501h_acct_code', 'hac001m_acct_name')
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 회계구분명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_acct_class.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('acct_class',1) = 0 THEN
//	wf_setmsg('공통코드[회계구분]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_acct_class.InsertRow(0)
//dw_acct_class.Object.code[1] = '1'
//dw_acct_class.Object.code.width = 400
//dw_acct_class.width = 400 + 25
//dw_acct_class.Object.code.Background.mode = 1
//dw_acct_class.Object.code.dddw.PercentWidth	= 100
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.2 관리항목 - 관리항목명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//idw_update[1].GetChild('hfn501h_mana_code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//if ldwc_Temp.Retrieve() < 1 then
//	ldwc_Temp.InsertRow(1)
//end if
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 회계년도
//////////////////////////////////////////////////////////////////////////////////////
//em_bdgt_year.Text = Left(f_today(),4)
//
//em_bdgt_year.SetFocus()
//
//This.TriggerEvent('ue_retrieve')
//
end event

event ue_retrieve;string  ls_bdgt_year

// 조회조건에 해당하는 자료 조회
//li_acctclass = integer(dw_acct_class.object.code[1])
dw_con.accepttext()
ls_bdgt_year = string(dw_con.object.bdgt_year[1], 'yyyy')

wf_SetMsg('조회 처리 중입니다...')

idw_update[1].SetRedraw(False)

idw_update[1].retrieve(gi_acct_class, ls_bdgt_year)
idw_print1.retrieve(gi_acct_class, ls_bdgt_year)
idw_update[1].SetRedraw(True)

if idw_update[1].RowCount() < 1 Then
//	wf_SetMenu('I',TRUE)
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
//	wf_SetMenu('R',TRUE)
//	wf_SetMenu('P',FALSE)
   wf_SetMsg('해당하는 자료가 존재하지 않습니다.')
Else
//   if dw_acct_class.object.code[1] = '0' then
      If gi_acct_class = 0 Then 
		idw_print2.Object.t_acct_name.Text = '전체'
	else
		idw_print2.Object.t_acct_name.Text = gs_acct_name//dw_acct_class.Describe("Evaluate('LookupDisplay(code)',1)")
	end if
	
	idw_print2.Object.t_slip_date.Text = ls_bdgt_year + ' 년도'
	
//	DateTime	ldt_SysDateTime
//	ldt_SysDateTime = f_sysdate()	//시스템일자
//	idw_print2.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//	idw_print2.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')



//	wf_SetMenu('I',TRUE)
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('R',TRUE)
//	wf_SetMenu('P',TRUE)
End If

return 1

end event

event ue_insert;Integer Li_AcctClass
String  Ls_bdgt_Year
Long    Ll_Row

// 입력의 Key값 Save
Li_AcctClass =   gi_acct_class//Integer(dw_acct_class.object.code[1])
dw_con.accepttext()
Ls_Bdgt_Year = string(dw_con.object.bdgt_year[1], 'yyyy')

Ll_Row = idw_update[1].Insertrow(0)

idw_update[1].object.hfn501h_acct_class[ll_row]  = li_acctclass
idw_update[1].object.hfn501h_bdgt_year[ll_row]   = ls_bdgt_year
idw_update[1].object.hfn501h_acct_date[ll_row]   = ls_bdgt_year + '0000'
idw_update[1].object.com_dr_amt[ll_row] = 0
idw_update[1].object.com_cr_amt[ll_row] = 0

idw_update[1].Setfocus()
idw_update[1].Scrolltorow(ll_row)
idw_update[1].setcolumn('hfn501h_acct_code')

//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
wf_SetMsg('자료가 추가되었습니다.')

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
idw_update[1].AcceptText()

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
	String	Ls_acct_code		//계정코드
	String	ls_acct_Name		//계정과목명
	
	ls_acct_code = tab_1.tabpage_1.dw_update.Object.hfn501h_acct_code[ll_GetRow]			//계정과목
	ls_acct_name = TRIM(tab_1.tabpage_1.dw_update.Object.hac001m_acct_name[ll_GetRow])	//계정과목명
	
	ls_Msg = '~r~n~r~n' + &
				'계정과목코드 : ' + Ls_Acct_Code + '~r~n' + &
				'계정과목명칭 : ' + Ls_Acct_Name
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
//			wf_SetMenu('R',TRUE)
//			wf_SetMenu('I',TRUE)
//			wf_SetMenu('D',FALSE)
//			wf_SetMenu('S',FALSE)
		END IF
	ELSE
		/////////////////////////////////////////////////////////////////////////////
		//	3.2 Multi 처리인 경우.
		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
		/////////////////////////////////////////////////////////////////////////////
		IF tab_1.tabpage_1.dw_update.RowCount() > 0 THEN
//			wf_SetMenu('R',TRUE)
//			wf_SetMenu('I',TRUE)
//			wf_SetMenu('D',TRUE)
//			wf_SetMenu('S',TRUE)
		ELSE
//			wf_SetMenu('R',TRUE)
//			wf_SetMenu('I',TRUE)
//			wf_SetMenu('D',FALSE)
//			wf_SetMenu('S',TRUE)
		END IF
	END IF
ELSE
END IF
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
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
If idw_update[1].AcceptText() = -1 Then
	idw_update[1].SetFocus()
	Return -1
End If

IF idw_update[1].ModifiedCount() + &
	idw_update[1].DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')

String	ls_NotNullCol[]

ls_NotNullCol[1] = 'hfn501h_acct_code/계정과목'
IF f_chk_null(idw_update[1],ls_NotNullCol) = -1 THEN RETURN -1



///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기

ll_Row = idw_update[1].GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gs_empcode	//등록자
	ls_IPAddr    = gs_ip		//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = idw_update[1].GetItemStatus(ll_Row,0,Primary!)
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 저장처리전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	// 관리항목 Data가 Null 또는 빈 값인 경우 Space 처리
	If IsNull(idw_update[1].object.hfn501h_mana_data[ll_row]) Or &
	   Trim(idw_update[1].object.hfn501h_mana_data[ll_row]) = '' Then
		idw_update[1].object.hfn501h_mana_data[ll_row] = space(1)
	End If
	
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		idw_update[1].Object.hfn501h_worker   [ll_Row] = ls_Worker		//등록일자
		idw_update[1].Object.hfn501h_work_date[ll_Row] = ldt_WorkDate	//등록자
		idw_update[1].Object.hfn501h_ipaddr   [ll_Row] = ls_IPAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	idw_update[1].Object.hfn501h_job_uid  [ll_Row] = ls_Worker		//등록자
	idw_update[1].Object.hfn501h_job_add  [ll_Row] = ls_IpAddr		//등록단말기
	idw_update[1].Object.hfn501h_job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = idw_update[1].GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF idw_update[1].UPDATE() <> 1 THEN
	ROLLBACK USING SQLCA;	

	RETURN -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 5. 총계정원장 저장
///////////////////////////////////////////////////////////////////////////////////////
Integer	Li_acct_class
String	Ls_bdgt_year

Li_acct_class = gi_acct_class// Integer(dw_acct_class.GetItemString(1, 'code'))
dw_con.accepttext()

Ls_bdgt_year  = String(dw_con.object.bdgt_year[1], 'yyyy')

If Not wf_update(Li_acct_class, Ls_bdgt_Year, Ls_worker, Ls_ipaddr, Ldt_workdate) Then
	ROLLBACK USING SQLCA;	

	RETURN -1
End If

COMMIT USING SQLCA ;

///////////////////////////////////////////////////////////////////////////////////////
// 6. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
idw_update[1].SetFocus()


//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_print;call super::ue_print;//if tab_1.selectedtab = 1 then return
//
//choose case tab_1.selectedtab
//	case 2
//		OpenWithParm(w_printoption, idw_print)
//	case 3
//		OpenWithParm(w_printoption, idw_print1)
//end choose
//
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 기초잔액관리.
//	작 성 인 : 이현수
//	작성일자 : 2002.11
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp

idw_update[1] = tab_1.tabpage_1.dw_update
idw_print2  = tab_1.tabpage_2.dw_print
idw_print1 = tab_1.tabpage_3.dw_print1
idw_print = idw_print2
idw_update[1].ShareData(idw_print2)
idw_print2.Object.DataWindow.Print.Preview = 'YES'
idw_print1.Object.DataWindow.Print.Preview = 'YES'

tab_1.tabpage_1.uo_3.uf_reset(idw_update[1], 'hfn501h_acct_code', 'hac001m_acct_name')

///////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 회계구분명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//dw_acct_class.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('acct_class',1) = 0 THEN
//	wf_setmsg('공통코드[회계구분]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_acct_class.InsertRow(0)
//dw_acct_class.Object.code[1] = '1'
//dw_acct_class.Object.code.width = 400
//dw_acct_class.width = 400 + 25
//dw_acct_class.Object.code.Background.mode = 1
//dw_acct_class.Object.code.dddw.PercentWidth	= 100

///////////////////////////////////////////////////////////////////////////////////////
// 1.2 관리항목 - 관리항목명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
idw_update[1].GetChild('hfn501h_mana_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
if ldwc_Temp.Retrieve() < 1 then
	ldwc_Temp.InsertRow(1)
end if

////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 회계년도
////////////////////////////////////////////////////////////////////////////////////
//em_bdgt_year.Text = Left(f_today(),4)
dw_con.object.bdgt_year[1] = date(string(f_today(), '@@@@/@@/@@'))

dw_con.SetFocus()

This.TriggerEvent('ue_retrieve')

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

type ln_templeft from w_msheet`ln_templeft within w_hfn113a
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn113a
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn113a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn113a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn113a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn113a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn113a
end type

type uc_insert from w_msheet`uc_insert within w_hfn113a
end type

type uc_delete from w_msheet`uc_delete within w_hfn113a
end type

type uc_save from w_msheet`uc_save within w_hfn113a
end type

type uc_excel from w_msheet`uc_excel within w_hfn113a
end type

type uc_print from w_msheet`uc_print within w_hfn113a
end type

type st_line1 from w_msheet`st_line1 within w_hfn113a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn113a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn113a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn113a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn113a
end type

type tab_1 from tab within w_hfn113a
integer x = 50
integer y = 328
integer width = 4384
integer height = 1988
integer taborder = 40
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

event selectionchanged;//choose case newindex
//	case	1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case	else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
Choose Case newindex
	Case 1, 2 		
		idw_print  = tab_1.tabpage_2.dw_print
	Case 3
		idw_print = tab_1.tabpage_3.dw_print1
End Choose
		
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1868
string text = "기초잔액관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
uo_3 uo_3
dw_update dw_update
gb_4 gb_4
end type

on tabpage_1.create
this.uo_3=create uo_3
this.dw_update=create dw_update
this.gb_4=create gb_4
this.Control[]={this.uo_3,&
this.dw_update,&
this.gb_4}
end on

on tabpage_1.destroy
destroy(this.uo_3)
destroy(this.dw_update)
destroy(this.gb_4)
end on

type uo_3 from cuo_search within tabpage_1
event destroy ( )
integer x = 78
integer y = 40
integer width = 3566
integer taborder = 90
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search::destroy
end on

type dw_update from cuo_dwwindow_one_hin within tabpage_1
integer y = 192
integer width = 4343
integer height = 1680
integer taborder = 20
string dataobject = "d_hfn113a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = TRUE
//
end event

event itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update1
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com, lstr_Rtn
string		ls_data, ls_acct_code, ls_acct_name, ls_mana_data, ls_drcr_class
integer		li_acct_class
long			ll_cnt, ll_mana_code

li_acct_class = getitemnumber(row, 'hfn501h_acct_class')
ls_mana_data  = getitemstring(row, 'hfn501h_mana_data')

choose case dwo.name
	case 'hfn501h_acct_code', 'hac001m_acct_name'
		ls_data = trim(data)
		
		if dwo.name = 'hfn501h_acct_code' then
//			select	count(*)	into	:ll_cnt	from	acdb.hac001m
//			where		acct_code	like	:ls_data||'%'
//			and		bs_gubun		=		'Y'
//			and		level_class	=		'4' ;
			select	count(*)	into	:ll_cnt	from	acdb.hac001m
			where		acct_code	like	:ls_data||'%'
			and		level_class	=		'4' ;
		else
//			select	count(*)	into	:ll_cnt	from	acdb.hac001m
//			where		acct_name	like	:ls_data||'%'
//			and		bs_gubun		=		'Y'
//			and		level_class	=		'4' ;
			select	count(*)	into	:ll_cnt	from	acdb.hac001m
			where		acct_name	like	:ls_data||'%'
			and		level_class	=		'4' ;
		end if
		
		if ll_cnt < 1 then
			messagebox('확인', '등록된 대차대조 계정이 없습니다.')
			setitem(row, 'hfn501h_acct_code', '')
			setitem(row, 'hac001m_acct_name', '')
			return 1
		end if
		
		if ll_cnt = 1 then
			if dwo.name = 'hfn501h_acct_code' then
//				select	acct_code, acct_name, mana_code, drcr_class
//				into		:ls_acct_code, :ls_acct_name, :ll_mana_code, :ls_drcr_class
//				from		acdb.hac001m
//				where		acct_code	like	:ls_data||'%'
//				and		bs_gubun		=		'Y'
//				and		level_class	=		'4' ;
				select	acct_code, acct_name, mana_code, drcr_class
				into		:ls_acct_code, :ls_acct_name, :ll_mana_code, :ls_drcr_class
				from		acdb.hac001m
				where		acct_code	like	:ls_data||'%'
				and		level_class	=		'4' ;
			else
//				select	acct_code, acct_name, mana_code, drcr_class
//				into		:ls_acct_code, :ls_acct_name, :ll_mana_code, :ls_drcr_class
//				from		acdb.hac001m
//				where		acct_name	like	:ls_data||'%'
//				and		bs_gubun		=		'Y'
//				and		level_class	=		'4' ;
				select	acct_code, acct_name, mana_code, drcr_class
				into		:ls_acct_code, :ls_acct_name, :ll_mana_code, :ls_drcr_class
				from		acdb.hac001m
				where		acct_name	like	:ls_data||'%'
				and		level_class	=		'4' ;
			end if
			
			setitem(row, 'hfn501h_acct_code', ls_acct_code)
			setitem(row, 'hac001m_acct_name', ls_acct_name)
			setitem(row, 'hfn501h_mana_code', ll_mana_code)
			setitem(row, 'hac001m_drcr_class', ls_drcr_class)
		else
			if dwo.name = 'hfn501h_acct_code' then
				lstr_com.ls_item[1] = trim(data)
				lstr_com.ls_item[2] = ''
				lstr_com.ls_item[3] = string(li_acct_class)
			else
				lstr_com.ls_item[1] = ''
				lstr_com.ls_item[2] = trim(data)
				lstr_com.ls_item[3] = string(li_acct_class)
			end if
			
			openwithparm(w_hfn001h, lstr_com)
			
			lstr_rtn = message.powerobjectparm
			
			if not isvalid(lstr_rtn) then
				setitem(row, 'hfn501h_acct_code', '')
				setitem(row, 'hac001m_acct_name', '')
				return 1
			end if
			
			ls_acct_code  = lstr_rtn.ls_item[1]
			ls_acct_name  = lstr_rtn.ls_item[2]
			ll_mana_code  = long(lstr_rtn.ls_item[5])
			ls_drcr_class = lstr_rtn.ls_item[3]
			
			setitem(row, 'hfn501h_acct_code', ls_acct_code)
			setitem(row, 'hac001m_acct_name', ls_acct_name)
			setitem(row, 'hfn501h_mana_code', ll_mana_code)
			setitem(row, 'hac001m_drcr_class', ls_drcr_class)
		end if
		
		// 자료 중복
		if wf_duplicate_chk(row, ls_acct_code, ll_mana_code, ls_mana_data) > 0 then
			setitem(row, 'hfn501h_acct_code', '')
			setitem(row, 'hac001m_acct_name', '')
			return 1
		end if
		return 1
	case 'hfn501h_mana_data'
		ls_acct_code = getitemstring(row, 'hfn501h_acct_code')
		ll_mana_code = getitemnumber(row, 'hfn501h_mana_code')
		
		// 자료 중복
		if wf_duplicate_chk(row, ls_acct_code, ll_mana_code, trim(data)) > 0 then
			setitem(row, 'hfn501h_mana_data', '')
			return 1
		end if
	case 'com_dr_amt'
		  This.SetItem(row, 'hfn501h_dr_cash_amt', Dec(Data))
		  This.SetItem(row, 'hfn501h_dr_alt_amt', 0)
	case 'com_cr_amt'
		  This.SetItem(row, 'hfn501h_cr_cash_amt', Dec(Data))
		  This.SetItem(row, 'hfn501h_cr_alt_amt', 0)
end choose

end event

type gb_4 from groupbox within tabpage_1
integer x = 5
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

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1868
string text = "기초잔액출력"
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
integer width = 4343
integer height = 1872
integer taborder = 150
string dataobject = "d_hfn113a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1868
string text = "개시대차대조표"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print1 dw_print1
end type

on tabpage_3.create
this.dw_print1=create dw_print1
this.Control[]={this.dw_print1}
end on

on tabpage_3.destroy
destroy(this.dw_print1)
end on

type dw_print1 from uo_dwfree within tabpage_3
integer y = 4
integer width = 4343
integer height = 1872
integer taborder = 160
string dataobject = "d_hfn113a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_con from uo_dwfree within w_hfn113a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hfn113a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
end event

event itemchanged;call super::itemchanged;parent.triggerevent('ue_retrieve')
end event

type uo_tab from u_tab within w_hfn113a
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

