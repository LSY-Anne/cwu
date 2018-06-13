$PBExportHeader$w_hin220i.srw
$PBExportComments$연구/학회관리_교무처
forward
global type w_hin220i from w_msheet
end type
type tab_1 from tab within w_hin220i
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update1 from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_update1 dw_update1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_update2 from cuo_dwwindow_one_hin within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_update2 dw_update2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_update3 from cuo_dwwindow_one_hin within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_update3 dw_update3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_update4 from cuo_dwwindow_one_hin within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_update4 dw_update4
end type
type tab_1 from tab within w_hin220i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type dw_list1 from cuo_dwwindow_one_hin within w_hin220i
end type
type dw_con from uo_dwfree within w_hin220i
end type
type uo_member from cuo_insa_member within w_hin220i
end type
type uo_1 from u_tab within w_hin220i
end type
end forward

global type w_hin220i from w_msheet
string title = "학회/논문/저서/연구비 관리"
tab_1 tab_1
dw_list1 dw_list1
dw_con dw_con
uo_member uo_member
uo_1 uo_1
end type
global w_hin220i w_hin220i

type variables
DataWindowChild	idwc_DutyCode	//직급코드 DDDW
DataWindowChild	idwc_SalClass	//호봉코드 DDDW
//DataWindow			idw_update[]		//
//세부사항명들
String				is_SubTitle[] = {'[학회임원관리]',&
											  '[저서관리]',&
											  '[논문관리]',&
											  '[연구비수혜]'}


end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

public subroutine wf_setmenubtn (string as_type);////입력
////저장
////삭제
////조회
////검색
//
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
//		CASE 'I' ; ib_insert   = lb_Value
//		CASE 'S' ; ib_update   = lb_Value
//		CASE 'D' ; ib_delete   = lb_Value
//		CASE 'R' ; ib_retrieve = lb_Value
//		CASE 'P' ; ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

on w_hin220i.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_list1=create dw_list1
this.dw_con=create dw_con
this.uo_member=create uo_member
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_list1
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_member
this.Control[iCurrent+5]=this.uo_1
end on

on w_hin220i.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_list1)
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.uo_1)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////////
//////	작성목적 : 인사기본정보를 관리한다.
//////	작 성 인 : 전희열
//////	작성일자 : 2002.03
//////	변 경 인 : 
//////	변경일자 : 
////// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////////
////// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////////
////// 1.1 조회조건 - 부서명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp,ldwc_Temp1
//Long					ll_InsRow
//dw_dept_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('%') = 0 THEN
//	wf_setmsg('부서코드 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'gwa','9999')
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_dept_code.InsertRow(0)
//
//ddlb_gubn.Text = "1. 교원"
//ddlb_gubn.item[1] = "1. 교원"
////////////////////////////////////////////////////////////////////////////////////////
////// 1.2 조회조건 - 직급명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////////
//dw_duty_code.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve() = 0 THEN
//	wf_setmsg('직급코드를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code','0')
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_duty_code.InsertRow(0)
//dw_duty_code.Object.code.dddw.PercentWidth = 100
//
////////////////////////////////////////////////////////////////////////////////////////
////// 1.3 조회조건 - 재직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////////
//dw_jaejik_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
//	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code','0')
//	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_jaejik_opt.InsertRow(0)
//dw_jaejik_opt.Object.code[1] = '1'
//dw_jaejik_opt.Object.code.dddw.PercentWidth = 100
//
//idw_update[01] = tab_1.tabpage_1.dw_update1
//idw_update[02] = tab_1.tabpage_2.dw_update2
//idw_update[03] = tab_1.tabpage_3.dw_update3
//idw_update[04] = tab_1.tabpage_4.dw_update4
//
//wf_SetMsg('인사기본정보를 초기화 중입니다...')
//
///////////////////////////////////////////////////////////////////////////////////////////
////// 13.  초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
//////////////////////////////////////////////////////////////////////////////////////////////
//////	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_retrieve
////	기 능 설 명: 자료조회 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
//////////////////////////////////////////////////////////////////////////////////////
//// 1.1 부서명 입력여부 체크
//////////////////////////////////////////////////////////////////////////////////////
String	ls_DeptCode
dw_con.accepttext()

ls_DeptCode = TRIM(dw_con.Object.dept_code[1])
IF LEN(ls_DeptCode) = 0 OR isNull(ls_DeptCode) OR ls_DeptCode = '9999' THEN &
	ls_DeptCode = ''
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 직급명 입력여부 체크
//////////////////////////////////////////////////////////////////////////////////////
String	ls_DutyCode
ls_DutyCode = TRIM(dw_con.Object.duty_code[1])
IF LEN(ls_DutyCode) = 0 OR isNull(ls_DutyCode) OR ls_DutyCode = '0' THEN &
	ls_DutyCode = ''
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 성명 입력여부 체크
//////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
//////////////////////////////////////////////////////////////////////////////////////
//// 1.4 재직구분 입력여부 체크
//////////////////////////////////////////////////////////////////////////////////////
String	ls_JaejikOpt
ls_JaejikOpt = TRIM(dw_con.Object.jaejik_opt[1])
IF LEN(ls_JaejikOpt) = 0 OR isNull(ls_JaejikOpt) OR ls_JaejikOpt = '0' THEN &
	ls_JaejikOpt = ''
//////////////////////////////////////////////////////////////////////////////////////
//// 1.5 교직원구분 입력여부 체크
//////////////////////////////////////////////////////////////////////////////////////
String	ls_JikJongCode
ls_JikJongCode = dw_con.object.gubn[1]//MID(ddlb_gubn.Text,1,1)

SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_list1.SetReDraw(FALSE)
ll_RowCnt = dw_list1.Retrieve(ls_DeptCode,ls_DutyCode,ls_KName,ls_JaejikOpt,ls_JikJongCode)
dw_list1.SetReDraw(TRUE)
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
/////////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN
//	wf_SetMenuBtn('IRP')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
END IF
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_insert;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_insert
////	기 능 설 명: 자료추가 처리
////////////////////////////////////////////////////////////////////////////////////////////
Integer	li_SelectedTab
li_SelectedTab = tab_1.SelectedTab
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 입력조건 체크
//////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
///////////////////////////////////////////////////////////////////////////////////
//// 1.2.2 성명 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료추가
/////////////////////////////////////////////////////////////////////////////////////////
Long		ll_InsRow

ll_InsRow = idw_update[li_SelectedTab].InsertRow(0)

IF ll_InsRow = 0 THEN RETURN
idw_update[li_SelectedTab].ScrollToRow(ll_InsRow)
// Appeon Deploy 시 오류나서 막음. 사용할 수 없는 Event 임.
//idw_update[li_SelectedTab].Object.DataWindow.HorizontalScrollPosition = 0

/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
////			사용하지 안을경우는 커맨트 처리
/////////////////////////////////////////////////////////////////////////////////////////
String	ls_SysDate
String	ls_ColName

ls_SysDate = f_today()

CHOOSE CASE li_SelectedTab
	CASE 1	//학회관리
		idw_update[li_SelectedTab].Object.from_date[ll_InsRow] 	= ls_SysDate				
		ls_ColName = 'from_date'
	CASE 2	//논문
		idw_update[li_SelectedTab].Object.nonmun_date[ll_InsRow] = ls_SysDate				
		ls_ColName = 'nonmun_date'
	CASE 3	//저서
		idw_update[li_SelectedTab].Object.jeoseo_date[ll_InsRow] = ls_SysDate				
		ls_ColName = 'jeoseo_date'
	CASE 4	//연구비
		idw_update[li_SelectedTab].Object.yeongu_year[ll_InsRow] = ls_SysDate		
		ls_ColName = 'yeongu_year'
END CHOOSE
idw_update[li_SelectedTab].SetItemStatus(ll_InsRow,0,Primary!,NotModified!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우로 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 추가되었습니다.')
//wf_SetMenuBtn('IDSR')
idw_update[li_SelectedTab].SetColumn(ls_ColName)
idw_update[li_SelectedTab].SetFocus()
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_save
////	기 능 설 명: 자료저장 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 1. 변경여부 CHECK
/////////////////////////////////////////////////////////////////////////////////////////
Integer	li_idx
Integer	li_ChgDw[]	//변경된사항만 저장
Integer	li_Arr

FOR li_idx = 1 TO UpperBound(idw_update)
	IF idw_update[li_idx].AcceptText() = -1 THEN
		idw_update[li_idx].SetFocus()
		RETURN -1
	END IF
	IF idw_update[li_idx].ModifiedCount() + &
		idw_update[li_idx].DeletedCount() > 0 THEN 
		li_Arr++
		li_ChgDw[li_Arr] = li_idx
	END IF
NEXT
IF li_Arr = 0 THEN
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 필수입력항목 체크
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMsg('필수입력항목 체크 중입니다...')
//String	ls_NotNullCol[]
//String	ls_Null[]
//FOR li_Arr 	= 1 TO UpperBound(li_ChgDw)
//	 li_idx 	= li_ChgDw[li_Arr]
//	 ls_NotNullCol = ls_Null
//	CHOOSE CASE li_idx
//		CASE 1	//학회정보
//			ls_NotNullCol[1] = 'member_no/사번'
//			ls_NotNullCol[2] = 'ach_no/순번'
//		CASE 2	//논문
//			ls_NotNullCol[1] = 'member_no/사번'
//			ls_NotNullCol[2] = 'ach_no/순번'
//		CASE 3	//저서
//			ls_NotNullCol[1] = 'member_no/사번'
//			ls_NotNullCol[2] = 'ach_no/순번'
//		CASE 4	//연구비
//			ls_NotNullCol[1] = 'member_no/사번'
//			ls_NotNullCol[2] = 'ach_no/순번'
//	END CHOOSE
//	IF f_chk_null(idw_update[li_idx],ls_NotNullCol) = -1 THEN
//		tab_1.SelectedTab = li_idx
//		RETURN -1
//	END IF
//NEXT

/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 저장처리전 체크사항 기술
/////////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row				//변경된행
Long		ll_RowCnt
Long		ll_ach_no			//순번

DateTime	ldt_WorkDate		//등록일자
String	ls_Worker			//등록자
String	ls_IpAddr			//등록단말기

String	ls_MemberNo			//개인번호

Boolean	lb_Start

FOR li_Arr = 1 TO UpperBound(li_ChgDw)
	ll_ach_no    = 0
	lb_Start  = TRUE
	li_idx    = li_ChgDw[li_Arr]
	ll_Row    = idw_update[li_idx].GetNextModified(0,primary!)
	
	ls_MemberNo = TRIM(dw_list1.Object.hin001m_member_no[dw_list1.getrow()])	//개인번호
	
	IF ll_Row > 0 THEN
		ldt_WorkDate = f_sysdate()						//등록일자
		ls_Worker    = gs_empcode //gstru_uid_uname.uid			//등록자
		ls_IpAddr    = gs_ip   //gstru_uid_uname.address		//등록단말기
	END IF
	DO WHILE ll_Row > 0
		ldis_Status = idw_update[li_idx].GetItemStatus(ll_Row,0,Primary!)
		/////////////////////////////////////////////////////////////////////////////////
		// 3.1 항목체크
		/////////////////////////////////////////////////////////////////////////////////
		CHOOSE CASE li_idx
			CASE 1	//학회임원
				idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo		//개인번호
				// 4.1 순번처리
				IF ldis_Status = New! OR ldis_Status = NewModified! THEN
					wf_SetMsg('학회임원 순번 생성 중 입니다...')
					IF lb_Start THEN
						lb_Start = FALSE
						SELECT	NVL(MAX(A.ach_no),0) + 1
						INTO		:ll_ach_no
						FROM		INDB.HIN804M A
						WHERE		A.MEMBER_NO = :ls_MemberNo;
						CHOOSE CASE SQLCA.SQLCODE
							CASE 0
							CASE 100
								ll_ach_no = 1
							CASE ELSE
								wf_SetMsg('학회임원 순번 생성 중 오류가 발생하였습니다.')
								MessageBox('오류',&
												'학회임원 순번 생성시 전산장애가 발생되었습니다.~r~n' + &
												'하단의 장애번호와 장애내역을~r~n' + &
												'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
												'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
												'장애내역 : ' + SQLCA.SqlErrText)
								ROLLBACK USING SQLCA;
								RETURN -1
						END CHOOSE
					ELSE
						ll_ach_no++
					END IF
					idw_update[li_idx].Object.ach_no[ll_Row] = ll_ach_no
				END IF
			CASE 2	//논문
				idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo		//개인번호
				// 2.1 순번처리
				IF ldis_Status = New! OR ldis_Status = NewModified! THEN
					wf_SetMsg('논문 순번 생성 중 입니다...')
					IF lb_Start THEN
						lb_Start = FALSE
						SELECT	NVL(MAX(A.ach_no),0) + 1
						INTO		:ll_ach_no
						FROM		INDB.HIN801M A
						WHERE		A.MEMBER_NO = :ls_MemberNo;
						CHOOSE CASE SQLCA.SQLCODE
							CASE 0
							CASE 100
								ll_ach_no = 1
							CASE ELSE
								wf_SetMsg('논문 순번 생성 중 오류가 발생하였습니다.')
								MessageBox('오류',&
												'논문 순번 생성시 전산장애가 발생되었습니다.~r~n' + &
												'하단의 장애번호와 장애내역을~r~n' + &
												'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
												'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
												'장애내역 : ' + SQLCA.SqlErrText)
								ROLLBACK USING SQLCA;
								RETURN -1
						END CHOOSE
					ELSE
						ll_ach_no++
					END IF
					idw_update[li_idx].Object.ach_no[ll_Row] = ll_ach_no
				END IF
			CASE 3	//저서
				idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo		//개인번호
				// 2.1 순번처리
				IF ldis_Status = New! OR ldis_Status = NewModified! THEN
					wf_SetMsg('저서 순번 생성 중 입니다...')
					IF lb_Start THEN
						lb_Start = FALSE
						SELECT	NVL(MAX(A.ach_no),0) + 1
						INTO		:ll_ach_no
						FROM		INDB.HIN802M A
						WHERE		A.MEMBER_NO = :ls_MemberNo;
						CHOOSE CASE SQLCA.SQLCODE
							CASE 0
							CASE 100
								ll_ach_no = 1
							CASE ELSE
								wf_SetMsg('저서 순번 생성 중 오류가 발생하였습니다.')
								MessageBox('오류',&
												'저서 순번 생성시 전산장애가 발생되었습니다.~r~n' + &
												'하단의 장애번호와 장애내역을~r~n' + &
												'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
												'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
												'장애내역 : ' + SQLCA.SqlErrText)
								ROLLBACK USING SQLCA;
								RETURN -1
						END CHOOSE
					ELSE
						ll_ach_no++
					END IF
					idw_update[li_idx].Object.ach_no[ll_Row] = ll_ach_no
				END IF
			CASE 4	//연구비수혜
				idw_update[li_idx].Object.member_no[ll_Row] = ls_MemberNo		//개인번호
				///////////////////////////////////////////////////////////////////////////
				// 4.1 순번처리
				/////////////////////////////////////////////////////////////////////////
				IF ldis_Status = New! OR ldis_Status = NewModified! THEN
					wf_SetMsg('연구비수혜 순번 생성 중 입니다...')
					IF lb_Start THEN
						lb_Start = FALSE
						SELECT	NVL(MAX(A.ach_no),0) + 1
						INTO		:ll_ach_no
						FROM		INDB.HIN803M A
						WHERE		A.MEMBER_NO = :ls_MemberNo;
						CHOOSE CASE SQLCA.SQLCODE
							CASE 0
							CASE 100
								ll_ach_no = 1
							CASE ELSE
								wf_SetMsg('연구비수혜 순번 생성 중 오류가 발생하였습니다.')
								MessageBox('오류',&
												'연구비수혜 순번 생성시 전산장애가 발생되었습니다.~r~n' + &
												'하단의 장애번호와 장애내역을~r~n' + &
												'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
												'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
												'장애내역 : ' + SQLCA.SqlErrText)
								ROLLBACK USING SQLCA;
								RETURN -1
						END CHOOSE
					ELSE
						ll_ach_no++
					END IF
					idw_update[li_idx].Object.ach_no[ll_Row] = ll_ach_no
				END IF
			
		END CHOOSE
		
		/////////////////////////////////////////////////////////////////////////////////
		// 3.2 수정항목 처리
		/////////////////////////////////////////////////////////////////////////////////
		idw_update[li_idx].Object.worker   [ll_Row] = ls_Worker		//등록자
		idw_update[li_idx].Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
		idw_update[li_idx].Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
		idw_update[li_idx].Object.job_uid  [ll_Row] = ls_Worker		//등록자
		idw_update[li_idx].Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
		idw_update[li_idx].Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
		
		ll_Row = idw_update[li_idx].GetNextModified(ll_Row,primary!)
	LOOP
NEXT
/////////////////////////////////////////////////////////////////////////////////////////
//// 4. 자료저장처리
/////////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
FOR li_Arr = 1 TO UpperBound(li_ChgDw)
	li_idx = li_ChgDw[li_Arr]
	ls_Msg = is_SubTitle[li_idx]
	wf_SetMsg(ls_Msg + ' 변경된 자료를 저장 중 입니다...')
	li_Rtn = idw_update[li_idx].UPDATE()
	IF li_Rtn <> 1 THEN EXIT
NEXT

IF li_Rtn = 1 THEN
	COMMIT USING SQLCA;
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;
	RETURN -1
END IF

/////////////////////////////////////////////////////////////////////////////////////////
//// 5. 메세지, 메뉴버튼 활성/비활성화 처리
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSR')
Integer	li_SelectedTab
li_SelectedTab = tab_1.SelectedTab
idw_update[li_SelectedTab].SetFocus()
RETURN 1
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_delete
////	기 능 설 명: 자료삭제 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 현재선택된 데이타원도우의 체크.
/////////////////////////////////////////////////////////////////////////////////////////
Integer	li_SelectedTab
li_SelectedTab = tab_1.SelectedTab
IF li_SelectedTab = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////////
////// 2. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
	ll_GetRow = idw_update[li_SelectedTab].getrow()

	IF ll_GetRow = 0 THEN
		wf_SetMsg('삭제할 자료가 없습니다.')
		RETURN
	END IF
///////////////////////////////////////////////////////////////////////////////////////////
////// 3. 삭제메세지 처리.
//////		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn,li_SeqNo

String	ls_MemberNo		//개인번호
String	ls_KName			//성명
String	ls_FromDate		//시작일자
String	ls_hakhoe_nm	//학회명
String	ls_nonmun_nm	//논문명
String	ls_jeoseo_nm	//저서명
String	ls_yeongu_year	//연구년도
String	ls_yeongu_nm	//연구과제명
String	ls_nonmun_date
String	ls_jeoseo_date

ls_MemberNo = TRIM(dw_list1.Object.hin001m_member_no[dw_list1.getrow()])
ls_KName    = TRIM(dw_list1.Object.hin001m_name[dw_list1.getrow()])	//성명
IF LEN(ls_MemberNo) = 0 OR isNull(ls_MemberNo) THEN RETURN
IF LEN(ls_KName) = 0 OR isNull(ls_KName) THEN ls_KName = ''

ls_Msg = is_SubTitle[li_SelectedTab]+' 자료를 삭제하시겠습니까?'


IF idw_update[li_SelectedTab].getrow() = 0 THEN
			//////////////////////////////////////////////////////////////////////////////
			// 2.2 삭제메세지 처리부분
			//////////////////////////////////////////////////////////////////////////////
			ls_Msg += '~r~n~r~n'+&
						 '개인번호 : '+ls_MemberNo+'~r~n'+&
						 '성    명 : '+ls_KName+'~r~n'
	 CHOOSE CASE li_SelectedTab
				CASE 1
					////////////////////////////////////////////////////////////////////////
					// 2.2.2 가족사항
					////////////////////////////////////////////////////////////////////////
					ls_fromdate = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
					ls_hakhoe_nm = idw_update[li_SelectedTab].Object.hakhoe_nm[ll_GetRow]
					ls_Msg += '시작일자 : ' + String(ls_fromdate,'@@@@/@@/@@')+'~r~n'+&
								 '학 회 명 : ' + ls_hakhoe_nm
				CASE 2
					////////////////////////////////////////////////////////////////////////
					// 2.2.3 학력사항
					////////////////////////////////////////////////////////////////////////
					ls_nonmun_date = idw_update[li_SelectedTab].Object.nonmun_date[ll_GetRow]
					ls_nonmun_nm= idw_update[li_SelectedTab].Object.nonmun_nm[ll_GetRow]
					li_SeqNo = idw_update[li_SelectedTab].Object.ach_no[ll_GetRow]
					ls_Msg += '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')+'~r~n'+&
								 '논 문 명 : ' + ls_nonmun_nm+'~r~n'+&
								 '순    번 : ' + String(li_SeqNo)
				CASE 3
					////////////////////////////////////////////////////////////////////////
					// 2.2.4 경력사항
					////////////////////////////////////////////////////////////////////////
					ls_jeoseo_date = idw_update[li_SelectedTab].Object.jeoseo_date[ll_GetRow]
					ls_jeoseo_nm= idw_update[li_SelectedTab].Object.jeoseo_nm[ll_GetRow]
					li_SeqNo = idw_update[li_SelectedTab].Object.ach_no[ll_GetRow]
					
					ls_Msg += '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')+'~r~n'+&
								 '저 서 명 : ' + ls_jeoseo_nm+'~r~n'+&
								 '순    번 : ' + String(li_SeqNo)
				CASE 4
					////////////////////////////////////////////////////////////////////////
					// 2.2.5 자격사항
					////////////////////////////////////////////////////////////////////////
					ls_yeongu_year = idw_update[li_SelectedTab].Object.yeongu_year[ll_GetRow]
					ls_yeongu_nm= idw_update[li_SelectedTab].Object.yeongu_nm[ll_GetRow]
					li_SeqNo = idw_update[li_SelectedTab].Object.ach_no[ll_GetRow]
					
					ls_Msg += '연구년도 : ' + String(ls_yeongu_year,'@@@@/@@/@@')+'~r~n'+&
								 '과 제 명 : ' + ls_yeongu_nm+'~r~n'+&
								 '순    번 : ' + String(li_SeqNo)
		END CHOOSE
ELSE
			ls_Msg = is_SubTitle[li_SelectedTab]+' 자료를 삭제하시겠습니까?'
END IF


li_Rtn = MessageBox('확인',ls_Msg,Question!,YesNo!,2)
IF li_Rtn = 2 THEN RETURN

/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 삭제처리.
/////////////////////////////////////////////////////////////////////////////////////////
Long	ll_idx

	/////////////////////////////////////////////////////////////////////////////////
	// 3.3 각세부사항 삭제처리
	//			선택된 행 만 찾아 삭제처리한다.
	/////////////////////////////////////////////////////////////////////////////////
		Long	ll_SelectRow
		Long	ll_DeleteCnt
		Long	ll_DeleteRow[]
		ll_SelectRow = idw_update[li_SelectedTab].getrow()
		IF ll_SelectRow = 0 THEN RETURN 
		DO WHILE ll_SelectRow > 0 
			ll_DeleteCnt++
			ll_DeleteRow[ll_DeleteCnt] = ll_SelectRow
			
			ll_SelectRow = idw_update[li_SelectedTab].getrow()
		LOOP
		
		idw_update[li_SelectedTab].SetRedraw(FALSE)
		FOR ll_idx = ll_DeleteCnt TO 1 STEP -1
			IF idw_update[li_SelectedTab].DeleteRow(ll_DeleteRow[ll_idx]) = 1 THEN
			END IF
		NEXT
		idw_update[li_SelectedTab].SetRedraw(TRUE)


////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_init;call super::ue_init;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_init
////	기 능 설 명: 초기화 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
//wf_SetMenuBtn('IRP')
uo_member.sle_kname.SetFocus()

tab_1.SelectTab(1)

dw_list1.Reset()

Integer	li_idx
FOR li_idx = 3 TO UpperBound(idw_update)
	idw_update[li_idx].Reset()
NEXT
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_print;call super::ue_print;//Integer	li_SelectedTab
//li_SelectedTab = tab_1.SelectedTab
//IF li_SelectedTab = 0 THEN RETURN
//
//IF 	li_SelectedTab = 12	AND	TAB_1.TABPAGE_12.dw_print.rowcount() > 0		then
//		F_PRINT(TAB_1.TABPAGE_12.dw_print)
//END IF 	

end event

event ue_postopen;call super::ue_postopen;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 인사기본정보를 관리한다.
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
DataWindowChild	ldwc_Temp,ldwc_Temp1
Long					ll_InsRow
dw_con.insertrow(0)

dw_con.GetChild('dept_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa','9999')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_dept_code.InsertRow(0)

//ddlb_gubn.Text = "1. 교원"
//ddlb_gubn.item[1] = "1. 교원"
dw_con.object.gubn[1] = '1'
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 직급명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('duty_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('직급코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_duty_code.InsertRow(0)
dw_con.Object.duty_code.dddw.PercentWidth = 100

//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 조회조건 - 재직구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('jaejik_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','없음')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_jaejik_opt.InsertRow(0)
dw_con.Object.jaejik_opt[1] = '1'
dw_con.Object.jaejik_opt.dddw.PercentWidth = 100

idw_update[01] = tab_1.tabpage_1.dw_update1
idw_update[02] = tab_1.tabpage_2.dw_update2
idw_update[03] = tab_1.tabpage_3.dw_update3
idw_update[04] = tab_1.tabpage_4.dw_update4

Long ll_i
For ll_i = 01 To 04
	idw_update[ll_i].settransobject(sqlca)
Next

wf_SetMsg('인사기본정보를 초기화 중입니다...')

/////////////////////////////////////////////////////////////////////////////////////////
//// 13.  초기화 이벤트 호출
/////////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin220i
end type

type ln_tempright from w_msheet`ln_tempright within w_hin220i
end type

type ln_temptop from w_msheet`ln_temptop within w_hin220i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin220i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin220i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin220i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin220i
end type

type uc_insert from w_msheet`uc_insert within w_hin220i
end type

type uc_delete from w_msheet`uc_delete within w_hin220i
end type

type uc_save from w_msheet`uc_save within w_hin220i
end type

type uc_excel from w_msheet`uc_excel within w_hin220i
end type

type uc_print from w_msheet`uc_print within w_hin220i
end type

type st_line1 from w_msheet`st_line1 within w_hin220i
end type

type st_line2 from w_msheet`st_line2 within w_hin220i
end type

type st_line3 from w_msheet`st_line3 within w_hin220i
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin220i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin220i
integer beginy = 344
integer endy = 344
end type

type tab_1 from tab within w_hin220i
integer x = 55
integer y = 964
integer width = 4384
integer height = 1340
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 4347
integer height = 1228
long backcolor = 16777215
string text = "학회임원"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update1 dw_update1
end type

on tabpage_1.create
this.dw_update1=create dw_update1
this.Control[]={this.dw_update1}
end on

on tabpage_1.destroy
destroy(this.dw_update1)
end on

type dw_update1 from cuo_dwwindow_one_hin within tabpage_1
integer x = 9
integer y = 12
integer width = 4329
integer height = 1208
integer taborder = 11
string dataobject = "d_hin220i_02"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = TRUE
//ib_SortGubn  = FALSE
//ib_EnterChk  = TRUE
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 4347
integer height = 1228
long backcolor = 16777215
string text = "논문발표"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update2 dw_update2
end type

on tabpage_2.create
this.dw_update2=create dw_update2
this.Control[]={this.dw_update2}
end on

on tabpage_2.destroy
destroy(this.dw_update2)
end on

type dw_update2 from cuo_dwwindow_one_hin within tabpage_2
integer x = 9
integer y = 12
integer width = 4338
integer height = 1204
integer taborder = 11
string dataobject = "d_hin220i_03"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 4347
integer height = 1228
long backcolor = 16777215
string text = "저서발간"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update3 dw_update3
end type

on tabpage_3.create
this.dw_update3=create dw_update3
this.Control[]={this.dw_update3}
end on

on tabpage_3.destroy
destroy(this.dw_update3)
end on

type dw_update3 from cuo_dwwindow_one_hin within tabpage_3
integer x = 9
integer y = 12
integer width = 4329
integer height = 1200
integer taborder = 21
string dataobject = "d_hin220i_04"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = TRUE
//ib_SortGubn  = FALSE
//ib_EnterChk  = TRUE
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4347
integer height = 1228
long backcolor = 16777215
string text = "연구비수혜"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update4 dw_update4
end type

on tabpage_4.create
this.dw_update4=create dw_update4
this.Control[]={this.dw_update4}
end on

on tabpage_4.destroy
destroy(this.dw_update4)
end on

type dw_update4 from cuo_dwwindow_one_hin within tabpage_4
integer x = 9
integer y = 12
integer width = 4329
integer height = 1208
integer taborder = 11
string dataobject = "d_hin220i_05"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = TRUE
//ib_SortGubn  = FALSE
//ib_EnterChk  = TRUE
end event

type dw_list1 from cuo_dwwindow_one_hin within w_hin220i
integer x = 50
integer y = 352
integer width = 4384
integer height = 560
integer taborder = 70
string dataobject = "d_hin220i_01"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanging;///////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: rowfocuschanging
////	기 능 설 명: 자료조회 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
ll_GetRow = newrow
IF ll_GetRow = 0 THEN RETURN
ll_RowCnt = THIS.RowCount()
IF ll_RowCnt = 0 THEN
	idw_update[01].SetReDraw(FALSE)
	idw_update[01].Reset()
	idw_update[01].InsertRow(0)
	idw_update[01].Object.DataWindow.ReadOnly = 'YES'
	idw_update[01].SetReDraw(TRUE)

	idw_update[02].SetReDraw(FALSE)
	idw_update[02].Reset()
	idw_update[02].InsertRow(0)
	idw_update[02].Object.DataWindow.ReadOnly = 'YES'
	idw_update[02].SetReDraw(TRUE)
	RETURN
END IF
/////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo			//개인번호
ls_MemberNo = dw_list1.Object.hin001m_member_no[ll_GetRow]


SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('[인사기본정보] 조회중입니다...')
idw_update[01].SetReDraw(FALSE)
idw_update[01].Reset()
ll_RowCnt = idw_update[01].Retrieve(ls_MemberNo)
ll_RowCnt = idw_update[02].Retrieve(ls_MemberNo)
ll_RowCnt = idw_update[03].Retrieve(ls_MemberNo)
ll_RowCnt = idw_update[04].Retrieve(ls_MemberNo)

/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
/////////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
	////////////////////////////////////////////////////////////////////////////////////
	// 3.4 각세부자료 조회처리
	////////////////////////////////////////////////////////////////////////////////////
	Integer	li_idx
	String	ls_Msg
	FOR li_idx = 1 TO UpperBound(idw_update)
		ls_Msg = is_SubTitle[li_idx]
		wf_SetMsg(ls_Msg + ' 조회중입니다...')
		idw_update[li_idx].SetReDraw(FALSE)
		ll_RowCnt = idw_update[li_idx].Retrieve(ls_MemberNo)
		idw_update[li_idx].SetReDraw(TRUE)
	NEXT
ELSE
	idw_update[01].InsertRow(0)
	idw_update[01].Object.DataWindow.ReadOnly = 'YES'
	
	idw_update[02].SetReDraw(FALSE)
	idw_update[02].InsertRow(0)
	idw_update[02].Object.DataWindow.ReadOnly = 'YES'
	idw_update[02].SetReDraw(TRUE)

//	wf_SetMenuBtn('R')	
	wf_SetMsg('[인사기본정보] 해당 자료가 존재하지 않습니다.')
END IF
idw_update[01].SetReDraw(TRUE)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event clicked;//Override
String	ls_ColName
ls_ColName = UPPER(dwo.name)
IF ls_ColName = 'DATAWINDOW' THEN RETURN

IF THIS.RowCount() > 0 AND UPPER(RIGHT(ls_ColName,2)) = '_T' AND ib_SortGubn THEN
	THIS.TRIGGER EVENT ue_et_sort()
	
	Long	ll_SelectRow
	ll_SelectRow = THIS.getrow()
	THIS.SetRedraw(FALSE)
	IF ll_SelectRow = 0 THEN ll_SelectRow = 1
	THIS.ScrollToRow(ll_SelectRow)
	THIS.SetRedraw(TRUE)
	RETURN 1
END IF

end event

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = TRUE
//ib_SortGubn  = TRUE
//ib_EnterChk  = FALSE
end event

type dw_con from uo_dwfree within w_hin220i
integer x = 55
integer y = 164
integer width = 4379
integer height = 180
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_hin202a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin220i
event destroy ( )
integer x = 1531
integer y = 256
integer taborder = 60
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type uo_1 from u_tab within w_hin220i
event destroy ( )
integer x = 1344
integer y = 964
integer taborder = 60
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

