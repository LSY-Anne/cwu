$PBExportHeader$w_hin351i.srw
$PBExportComments$보직발령등록
forward
global type w_hin351i from w_msheet
end type
type dw_list from cuo_dwwindow_one_hin within w_hin351i
end type
type dw_con from uo_dwfree within w_hin351i
end type
type uo_member from cuo_insa_member within w_hin351i
end type
type dw_update from uo_dwfree within w_hin351i
end type
end forward

global type w_hin351i from w_msheet
string title = "보직발령등록"
dw_list dw_list
dw_con dw_con
uo_member uo_member
dw_update dw_update
end type
global w_hin351i w_hin351i

type variables
DataWindowChild	idwc_DutyCode	//직급코드 DDDW

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

on w_hin351i.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.uo_member=create uo_member
this.dw_update=create dw_update
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_member
this.Control[iCurrent+4]=this.dw_update
end on

on w_hin351i.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.dw_update)
end on

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 보직발령사항을 관리한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 보직코드 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_BoJikCodeMain
//dw_update.GetChild('bojik_code',ldwc_BoJikCodeMain)
//ldwc_BoJikCodeMain.SetTransObject(SQLCA)
//IF ldwc_BoJikCodeMain.Retrieve(1) = 0 THEN
//	wf_setmsg('보직코드를 입력하시기 바랍니다.')
//	ldwc_BoJikCodeMain.InsertRow(0)
//END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조직코드 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_DeptCode
//dw_update.GetChild('gwa',ldwc_DeptCode)
//ldwc_DeptCode.SetTransObject(SQLCA)
//IF ldwc_DeptCode.Retrieve('%') = 0 THEN
//	wf_setmsg('조직코드를 입력하시기 바랍니다.')
//	ldwc_DeptCode.InsertRow(0)
//END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 구조직코드 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_OldDept
//dw_update.GetChild('old_gwa',ldwc_OldDept)
//ldwc_OldDept.SetTransObject(SQLCA)
//IF ldwc_OldDept.Retrieve('%') = 0 THEN
//	wf_setmsg('조직코드를 입력하시기 바랍니다.')
//	ldwc_OldDept.InsertRow(0)
//END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 1.4 결재구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_SignOpt
//dw_update.GetChild('sign_opt',ldwc_SignOpt)
//ldwc_SignOpt.SetTransObject(SQLCA)
//IF ldwc_SignOpt.Retrieve('sign_opt',0) = 0 THEN
//	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
//	ldwc_SignOpt.InsertRow(0)
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화이벤트 콜
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
wf_SetMsg('조회조건 체크 중입니다...')
dw_con.accepttext()
////////////////////////////////////////////////////////////////////////////////////
// 1.1 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JikJongCode

ls_JikJongCode = dw_con.object.gubn[1]// MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.3 개인번호 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo
ls_MemberNo = TRIM(uo_member.sle_member_no.Text)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_list.SetReDraw(FALSE)
ll_RowCnt = dw_list.Retrieve(ls_KName,ls_JikJongCode)
dw_list.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('IR')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_insert;call super::ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 자료추가전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 자료추가전 필수입력사항 체크
////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
String	ls_MemberNo			//개인번호
String	ls_KName				//성명
String	ls_BojikCode		//보직코드
String	ls_DeptCode			//조직명
String	ls_OldDeptCode		//구조직명
Integer	li_DayOpt = 1		//주야구분(1:주간,2:야간)
Long		ll_AppointFee = 0	//보직수당
Long		ll_PayGrp1 = 0		//수당그룹1
Long		ll_PayGrp2 = 0		//수당그룹2
Long		ll_PayGrp3 = 0		//수당그룹3

ll_GetRow = dw_list.GetRow()
IF ll_GetRow > 0 THEN
	ls_MemberNo    = dw_list.Object.a_member_no  [ll_GetRow]	//개인번호
	ls_KName       = dw_list.Object.a_kname      [ll_GetRow]	//성명
	ls_BojikCode   = dw_list.Object.a_bojik_code1[ll_GetRow]	//보직코드
	ls_DeptCode    = dw_list.Object.c_dept_code  [ll_GetRow]	//조직명
	ls_OldDeptCode = dw_list.Object.c_old_dept   [ll_GetRow]	//구조직명
	li_DayOpt      = dw_list.Object.c_day_opt    [ll_GetRow]	//주야구분
	ll_AppointFee  = dw_list.Object.c_appoint_fee[ll_GetRow]	//보직수당
	ll_PayGrp1     = dw_list.Object.c_pay_grp1   [ll_GetRow]	//수당그룹1
	ll_PayGrp2     = dw_list.Object.c_pay_grp2   [ll_GetRow]	//수당그룹2
	ll_PayGrp3     = dw_list.Object.c_pay_grp2   [ll_GetRow]	//수당그룹3
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long	 ll_InsRow
//ll_InsRow = dw_update.TRIGGER EVENT ue_db_new()
	dw_update.Reset()
	ll_InsRow = dw_update.InsertRow(0)
	dw_update.ScrollToRow(ll_InsRow)
	dw_update.SetRow(ll_InsRow)
	dw_update.SetFocus()
	
IF ll_InsRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_SysDate
ls_SysDate = f_today()
dw_update.Object.member_no   [ll_InsRow] = ls_MemberNo		//개인번호
dw_update.Object.kname       [ll_InsRow] = ls_KName			//성명
dw_update.Object.bojik_code  [ll_InsRow] = ls_BojikCode		//보직코드
dw_update.Object.from_date   [ll_InsRow] = ls_SysDate		//보직일자
dw_update.Object.gwa         [ll_InsRow] = ls_DeptCode		//조직명
dw_update.Object.old_gwa     [ll_InsRow] = ls_OldDeptCode	//구조직명
dw_update.Object.day_opt     [ll_InsRow] = li_DayOpt			//주야구분
dw_update.Object.appoint_fee [ll_InsRow] = ll_AppointFee	//보직수당
dw_update.Object.pay_grp1    [ll_InsRow] = ll_PayGrp1		//수당그룹1
dw_update.Object.pay_grp2    [ll_InsRow] = ll_PayGrp2		//수당그룹2
dw_update.Object.pay_grp2    [ll_InsRow] = ll_PayGrp3		//수당그룹3
dw_update.Object.sign_opt    [ll_InsRow] = 1					//결재구분(1:미결)
dw_update.SetItemStatus(ll_InsRow,0,Primary!,NotModified!)
//발령근거에 보직명을 넣어주기 위해 TRIGGER 한다.
dwObject	ldwo_Col
ldwo_Col = dw_update.Object.bojik_code
dw_update.TRIGGER EVENT itemChanged(ll_InsRow,ldwo_Col,ls_BojikCode)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우호 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('IDSR')
wf_SetMsg('자료가 추가되었습니다.')
dw_update.Object.DataWindow.ReadOnly = 'NO'
dw_update.SetColumn('bojik_code')
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
IF dw_update.AcceptText() = -1 THEN
	dw_update.SetFocus()
	RETURN -1
END IF
IF dw_update.ModifiedCount() + dw_update.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'member_no/개인번호'
ls_NotNullCol[2] = 'bojik_code/보직코드'
ls_NotNullCol[3] = 'from_date/보직기간'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기
String	ls_Msg			//메세지
Integer	li_Cnt			//인사발령의 미결건수

String	ls_MemberNo		//개인번호

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gs_empcode //gstru_uid_uname.uid			//등록자
	ls_IPAddr    = gs_ip   //gstru_uid_uname.address		//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = dw_update.GetItemStatus(ll_Row,0,Primary!)
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 미결여부존재여부 처리
	/////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		ls_MemberNo = dw_update.Object.member_no[ll_Row]	//개인번호
		//////////////////////////////////////////////////////////////////////////////
		// 3.1.1 보직발령사항에 미결이 한건이라도 있으면 오류처리
		//////////////////////////////////////////////////////////////////////////////
		wf_SetMsg('보직발령사항의 미결존재여부 체크중 입니다...')
		SELECT	COUNT(*)
		INTO		:li_Cnt
		FROM		INDB.HIN008H A
		WHERE		A.MEMBER_NO = :ls_MemberNo
		AND		A.SIGN_OPT  = 1;
		IF li_Cnt > 0 THEN
			ls_Msg = '미결인 건이 있읍니다. 삭제또는 결재후 입력하시기 바랍니다.'
			wf_SetMsg(ls_Msg)
			//--나중에 코멘트해제
			//MessageBox('확인',ls_Msg)
			//RETURN
		END IF
		dw_update.Object.worker   [ll_Row] = ls_Worker		//등록일자
		dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록자
		dw_update.Object.ipaddr   [ll_Row] = ls_IPAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	dw_update.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	dw_update.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	dw_update.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 5. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
//IF NOT dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1
IF dw_update.UPDATE() = 1 THEN
	COMMIT USING SQLCA;
	//RETURN 1
ELSE
	ROLLBACK USING SQLCA;
	RETURN -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 6. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSR')
dw_update.SetFocus()
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
//IF dw_update.ib_RowSingle THEN 
ll_GetRow = dw_update.GetRow()
//IF NOT dw_update.ib_RowSingle THEN ll_GetRow = dw_update.GetSelectedRow(0)
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
Long		ll_DeleteCnt

//IF dw_update.ib_RowSingle OR dw_update.GetSelectedRow(ll_GetRow) = 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 2.1 삭제전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
	String	ls_MemberNo			//개인번호
	String	ls_KName				//성명
	String	ls_BojikCode		//보직발령코드
	String	ls_FromDate			//보직발령일자
	

	ls_MemberNo  = dw_update.Object.member_no    [ll_GetRow]	//개인번호
	ls_KName     = dw_update.Object.kname        [ll_GetRow]	//성명
	ls_BojikCode = dw_update.&
					Describe("Evaluate('LookUpDisplay(bojik_code)',"+String(ll_GetRow)+")")
	ls_FromDate  = dw_update.Object.from_date    [ll_GetRow]	//보직발령일자
	
	ls_Msg = '개인번호 : '+ls_MemberNo+'~r~n'+&
				'성      명 : '+ls_KName+'~r~n'+&
				'보직구분 : '+ls_BojikCode+'~r~n'+&
				'보직일자 : '+String(ls_FromDate,'@@@@/@@/@@')
//ELSE
////	SetNull(ls_Msg)
//END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
//ll_DeleteCnt = dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
IF dw_update.GetItemStatus(ll_GetRow,0,Primary!) <> New! THEN
		IF MessageBox('확인','자료를 삭제하시겠습니까?~r~n'+ls_Msg,&
									Question!,YesNo!,2) = 2 THEN
			RETURN 
		END IF
	END IF
	
//	THIS.SelectRow(0,FALSE)
//	ll_NextSelectRow = ll_GetRow + 1
//	THIS.ScrollToRow(ll_NextSelectRow)
//	THIS.SetRedraw(TRUE)

ll_DeleteCnt = dw_update.DeleteRow(ll_GetRow)



IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	//IF dw_update.ib_RowSingle THEN
		/////////////////////////////////////////////////////////////////////////////
		// 3.1 Single 처리인 경우.
		//			3.1.1 저장처리.
		//			3.1.2 한로우를 다시 추가.
		//			3.1.3 데이타원도우를 읽기모드로 수정.
		/////////////////////////////////////////////////////////////////////////////
		//IF dw_update.TRIGGER EVENT ue_db_save() THEN
		IF dw_update.UPDATE() = 1 THEN
			COMMIT USING SQLCA;
			//dw_update.TRIGGER EVENT ue_db_append()
				
			dw_update.Reset()


			Long	ll_InsertRow
			ll_InsertRow = dw_update.InsertRow(0)

			dw_update.SetRow(ll_InsertRow)
			dw_update.ScrollToRow(ll_InsertRow)
			dw_update.SetFocus()
//			IF ib_RowSelect THEN
//				THIS.SelectRow(0,FALSE)
//				THIS.SelectRow(ll_InsertRow,TRUE)
//			ELSE
// Appeon Deploy 시 오류나서 막음. 사용할 수 없는 Event 임.
//				dw_update.Object.DataWindow.HorizontalScrollPosition = 0
//			END IF
			
			
			dw_update.Object.DataWindow.ReadOnly = 'YES'
//			wf_SetMenuBtn('RI')
		ELSE
			ROLLBACK USING SQLCA;
			RETURN 
		END IF
		
		
			
//		END IF
//	ELSE
//		/////////////////////////////////////////////////////////////////////////////
//		//	3.2 Multi 처리인 경우.
//		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
//		/////////////////////////////////////////////////////////////////////////////
//		IF dw_update.RowCount() > 0 THEN
//			wf_SetMenuBtn('IDSR')
//		ELSE
//			wf_SetMenuBtn('RIS')
//		END IF
//	END IF
ELSE
END IF
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
// 1. 초기화처리
///////////////////////////////////////////////////////////////////////////////////////
dw_list.Reset()

dw_update.SetReDraw(FALSE)
dw_update.Reset()
dw_update.InsertRow(0)
dw_update.Object.DataWindow.ReadOnly = 'YES'
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenuBtn('IR')
uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 보직발령사항을 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 보직코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.insertrow(0)
func.of_design_dw(dw_update)


DataWindowChild	ldwc_BoJikCodeMain
dw_update.GetChild('bojik_code',ldwc_BoJikCodeMain)
ldwc_BoJikCodeMain.SetTransObject(SQLCA)
IF ldwc_BoJikCodeMain.Retrieve(1) = 0 THEN
	wf_setmsg('보직코드를 입력하시기 바랍니다.')
	ldwc_BoJikCodeMain.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조직코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_DeptCode
dw_update.GetChild('gwa',ldwc_DeptCode)
ldwc_DeptCode.SetTransObject(SQLCA)
IF ldwc_DeptCode.Retrieve('%') = 0 THEN
	wf_setmsg('조직코드를 입력하시기 바랍니다.')
	ldwc_DeptCode.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.3 구조직코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_OldDept
dw_update.GetChild('old_gwa',ldwc_OldDept)
ldwc_OldDept.SetTransObject(SQLCA)
IF ldwc_OldDept.Retrieve('%') = 0 THEN
	wf_setmsg('조직코드를 입력하시기 바랍니다.')
	ldwc_OldDept.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.4 결재구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_SignOpt
dw_update.GetChild('sign_opt',ldwc_SignOpt)
ldwc_SignOpt.SetTransObject(SQLCA)
IF ldwc_SignOpt.Retrieve('sign_opt',0) = 0 THEN
	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
	ldwc_SignOpt.InsertRow(0)
END IF

dw_update.settransobject(sqlca)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화이벤트 콜
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin351i
end type

type ln_tempright from w_msheet`ln_tempright within w_hin351i
end type

type ln_temptop from w_msheet`ln_temptop within w_hin351i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin351i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin351i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin351i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin351i
end type

type uc_insert from w_msheet`uc_insert within w_hin351i
end type

type uc_delete from w_msheet`uc_delete within w_hin351i
end type

type uc_save from w_msheet`uc_save within w_hin351i
end type

type uc_excel from w_msheet`uc_excel within w_hin351i
end type

type uc_print from w_msheet`uc_print within w_hin351i
end type

type st_line1 from w_msheet`st_line1 within w_hin351i
end type

type st_line2 from w_msheet`st_line2 within w_hin351i
end type

type st_line3 from w_msheet`st_line3 within w_hin351i
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin351i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin351i
end type

type dw_list from cuo_dwwindow_one_hin within w_hin351i
integer x = 50
integer y = 296
integer width = 4384
integer height = 1356
integer taborder = 30
string dataobject = "d_hin351i_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanging;/////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
ll_GetRow = newrow
IF ll_GetRow = 0 THEN RETURN
ll_RowCnt = THIS.RowCount()
IF ll_RowCnt = 0 THEN
	dw_update.SetReDraw(FALSE)
	dw_update.Reset()
	dw_update.InsertRow(0)
	dw_update.Object.DataWindow.ReadOnly = 'YES'
	dw_update.SetReDraw(TRUE)
	RETURN
END IF
///////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo			//개인번호
String	ls_AppointCode		//보직발령코드
String	ls_AppointDate		//보직발령일자
ls_MemberNo    = dw_list.Object.a_member_no   [ll_GetRow]
ls_AppointCode = dw_list.Object.c_appoint_code[ll_GetRow]
ls_AppointDate = dw_list.Object.c_appoint_date[ll_GetRow]


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
dw_update.SetReDraw(FALSE)
dw_update.Reset()
ll_RowCnt = dw_update.Retrieve(ls_MemberNo,ls_AppointCode,ls_AppointDate)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
	////////////////////////////////////////////////////////////////////////////////////
	// 3.1 결재구분이 미결인 경우만 저장가능
	////////////////////////////////////////////////////////////////////////////////////
	Integer	li_SignOpt	//결재구분(0:없음,1:미결,2:학(총)장결재,3:이사장결재)
	li_SignOpt = dw_list.Object.c_sign_opt[ll_GetRow]
	IF li_SignOpt > 1 THEN
//		wf_SetMenuBtn('IR')
		wf_SetMsg('결재처리되어 변경이 불가능합니다.')
		dw_update.Object.DataWindow.ReadOnly = 'YES'
	ELSE
//		wf_SetMenuBtn('IDSR')
		wf_SetMsg('자료가 조회되었습니다.')
		dw_update.Object.DataWindow.ReadOnly = 'NO'
		dw_update.SetFocus()
	END IF
ELSE
	dw_update.InsertRow(0)
//	wf_SetMenuBtn('IR')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	dw_update.Object.DataWindow.ReadOnly = 'YES'
END IF
dw_update.SetReDraw(TRUE)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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

type dw_con from uo_dwfree within w_hin351i
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hin205b_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin351i
event destroy ( )
integer x = 1152
integer y = 180
integer taborder = 70
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type dw_update from uo_dwfree within w_hin351i
event type long ue_postitemchanged ( long row,  dwobject dwo,  string data )
integer x = 50
integer y = 1660
integer width = 4384
integer height = 604
integer taborder = 40
string dataobject = "d_hin351i_2"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_postitemchanged(long row, dwobject dwo, string data);////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: ue_postitemchanged::dw_update
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
	CASE 'bojik_code'
		///////////////////////////////////////////////////////////////////////////////// 
		//	발령구분변경시 발령사유가 없으면 발령구분명을 발령사유에 넣어준다.
		/////////////////////////////////////////////////////////////////////////////////
		String	ls_ChangeOpt
		ls_ChangeOpt = THIS.Describe("Evaluate('LookUpDisplay(bojik_code)',"+String(row)+")")
		THIS.Object.announce_reason[row] = ls_ChangeOpt
	CASE ELSE
END CHOOSE
RETURN 0
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event buttonclicked;call super::buttonclicked;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: buttonclikced::dw_update
//	기 능 설 명: 인사정보코드 도움말 버튼 선택시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
IF row = 0 THEN RETURN
IF UPPER(THIS.Object.DataWindow.ReadOnly) = 'YES' THEN RETURN

////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
ls_ColName = STRING(dwo.name)

CHOOSE CASE ls_ColName
	CASE 'btn_member_no'
		//////////////////////////////////////////////////////////////////////////
		// 조회조건 체크
		//////////////////////////////////////////////////////////////////////////
		String	ls_JikJongCode
		String	ls_KName
		ls_JikJongCode = dw_con.object.gubn[1] // MID(ddlb_gubn.Text,1,1)
		ls_KName       = ''//TRIM(uo_member.sle_kname.Text)
		
		s_insa_com	lstr_com
		
		lstr_com.ls_item[1] = ls_KName			//성명
		lstr_com.ls_item[2] = ''					//개인번호
		lstr_com.ls_item[3] = ls_JikJongCode	//교직원구분
		
		OpenWithParm(w_hin000h,lstr_com)
		
		lstr_com = Message.PowerObjectParm
		IF NOT isValid(lstr_com) THEN
			MessageBox('오류','개인번호를 선택하시기 바랍니다.')
			RETURN -1
		END IF
		
		dw_update.Object.kname    [row] = lstr_com.ls_item[1]
		dw_update.Object.member_no[row] = lstr_com.ls_item[2]
		
	CASE ELSE
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event constructor;call super::constructor;
//ib_RowSelect = FALSE
//ib_RowSingle = TRUE
//ib_SortGubn  = FALSE
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
	CASE 'bojik_code'
		///////////////////////////////////////////////////////////////////////////////// 
		//	발령구분변경시 미결인경우만 발령구분명을 발령사유에 넣어준다.
		/////////////////////////////////////////////////////////////////////////////////
		Integer	li_SignOpt
		li_SignOpt = dw_update.Object.sign_opt[row]
		IF li_SignOpt < 2 THEN
			THIS.POST EVENT ue_PostItemChanged(row,dwo,data)
		END IF
		
	CASE ELSE
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

