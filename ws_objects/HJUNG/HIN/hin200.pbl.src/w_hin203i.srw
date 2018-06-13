$PBExportHeader$w_hin203i.srw
$PBExportComments$이미지일괄입력
forward
global type w_hin203i from w_msheet
end type
type dw_list1 from cuo_dwwindow_one_hin within w_hin203i
end type
type uo_member from cuo_insa_member within w_hin203i
end type
type dw_con from uo_dwfree within w_hin203i
end type
end forward

global type w_hin203i from w_msheet
integer height = 2616
string title = "이미지일괄입력"
dw_list1 dw_list1
uo_member uo_member
dw_con dw_con
end type
global w_hin203i w_hin203i

type variables
DataWindowChild	idwc_DutyCode	//직급코드 DDDW
DataWindowChild	idwc_SalClass	//호봉코드 DDDW
//DataWindow			idw_update[]		//
//세부사항명들
String				is_SubTitle[] = {'[인사기본정보]',&
											  '[신상정보상세]',&
											  '[가족사항]',&
											  '[학력사항]',&
											  '[경력사항]',&
											  '[자격사항]',&
											  '[포상.징계사항]',&
											  '[해외연수사항]',&
											  '[보직사항]',&
											  '[변동이력]',&
											  '[위원회이력]',&
											  '[교직원인사기록카드]'}


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

on w_hin203i.create
int iCurrent
call super::create
this.dw_list1=create dw_list1
this.uo_member=create uo_member
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list1
this.Control[iCurrent+2]=this.uo_member
this.Control[iCurrent+3]=this.dw_con
end on

on w_hin203i.destroy
call super::destroy
destroy(this.dw_list1)
destroy(this.uo_member)
destroy(this.dw_con)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 직급명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 조회조건 - 재직구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
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
//wf_setmsg('인사기본정보를 초기화 중입니다...')
//////////////////////////////////////////////////////////////////////////////////////
//// 1.1 성별코드 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_성별구분]를 초기화 중입니다...','')
////idw_update[01].GetChild('sex_code',ldwc_Temp)
////ldwc_Temp.SetTransObject(SQLCA)
////IF ldwc_Temp.Retrieve('sex_code',0) = 0 THEN
////	wf_setmsg('공통코드[성별]를 입력하시기 바랍니다.')
////	ldwc_Temp.InsertRow(0)
////END IF
//
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 재직코드 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_재직구분]를 초기화 중입니다...','')
////idw_update[01].GetChild('jaejik_opt',ldwc_Temp)
////ldwc_Temp.SetTransObject(SQLCA)
////IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
////	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
////	ldwc_Temp.InsertRow(0)
////END IF
//
//
//
//
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 11.  초기화 이벤트 호출
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_setmsg('조회조건 체크 중입니다...')
dw_con.accepttext()
////////////////////////////////////////////////////////////////////////////////////
// 1.1 부서명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_DeptCode
ls_DeptCode = TRIM(dw_con.Object.dept_code[1])
IF LEN(ls_DeptCode) = 0 OR isNull(ls_DeptCode) OR ls_DeptCode = '9999' THEN &
	ls_DeptCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.2 직급명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_DutyCode
ls_DutyCode = TRIM(dw_con.Object.duty_code[1])
IF LEN(ls_DutyCode) = 0 OR isNull(ls_DutyCode) OR ls_DutyCode = '0' THEN &
	ls_DutyCode = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.3 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.4 재직구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JaejikOpt
ls_JaejikOpt = TRIM(dw_con.Object.jaejik_opt[1])
IF LEN(ls_JaejikOpt) = 0 OR isNull(ls_JaejikOpt) OR ls_JaejikOpt = '0' THEN &
	ls_JaejikOpt = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.5 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JikJongCode
ls_JikJongCode = dw_con.object.gubn[1] // MID(ddlb_gubn.Text,1,1)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_setmsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_list1.SetReDraw(FALSE)
ll_RowCnt = dw_list1.Retrieve(ls_DeptCode,ls_DutyCode,ls_KName,ls_JaejikOpt,ls_JikJongCode)
dw_list1.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN
//	wf_SetMenuBtn('SR')
	wf_setmsg('해당자료가 존재하지 않습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_insert;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_insert
////	기 능 설 명: 자료추가 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 자료추가전 체크사항 기술
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 자료추가전 필수입력사항 체크
//////////////////////////////////////////////////////////////////////////////////////
//Integer	li_SelectedTab
//
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 입력조건 체크
//////////////////////////////////////////////////////////////////////////////////////
//wf_setmsg('조회조건 체크 중입니다...')
///////////////////////////////////////////////////////////////////////////////////
//// 1.2.1 직종명 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////
//String	ls_DutyCode
//ls_DutyCode = TRIM(dw_duty_code.Object.code[1])
//IF LEN(ls_DutyCode) = 0 OR isNull(ls_DutyCode) OR ls_DutyCode = '0' THEN &
//	ls_DutyCode = ''
///////////////////////////////////////////////////////////////////////////////////
//// 1.2.2 성명 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////
//String	ls_KName
//ls_KName = TRIM(uo_member.sle_kname.Text)
//
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료추가
/////////////////////////////////////////////////////////////////////////////////////////
//Long		ll_InsRow
//Long		ll_idx
//IF li_SelectedTab = 1 THEN
//	FOR ll_idx = 1 TO UpperBound(idw_update)
//		idw_update[ll_idx].Reset()
//	NEXT
//	Blob	lbo_Image
//	SetNull(lbo_Image)
//	tab_1.tabpage_1.p_image.picturename = "../bmp/blank.bmp"
//	tab_1.tabpage_1.p_image.SetPicture(lbo_Image)
//	
//	idw_update[2].InsertRow(0)
//	idw_update[2].Object.DataWindow.ReadOnly = 'YES'
//END IF
//IF li_SelectedTab = 2 THEN idw_update[li_SelectedTab].Reset()
//
//ll_InsRow = idw_update[li_SelectedTab].InsertRow(0)
//IF ll_InsRow = 0 THEN RETURN
//idw_update[li_SelectedTab].ScrollToRow(ll_InsRow)
//idw_update[li_SelectedTab].Object.DataWindow.HorizontalScrollPosition = 0
//////////////////////////////////////////////////////////////////////////////////////
//// 2.1 개인번호 자동생성여부 체크
//////////////////////////////////////////////////////////////////////////////////////
//Boolean	lb_Chk
//lb_Chk = cbx_seq.Checked
//IF lb_Chk THEN
//	idw_update[1].Object.member_no.protect = '1'
//	idw_update[1].Object.member_no.background.color = 536870912
//ELSE
//	idw_update[1].Object.member_no.protect = '0'
//	idw_update[1].Object.member_no.background.color = RGB(255,255,255)
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
////			사용하지 안을경우는 커맨트 처리
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_SysDate
//Integer	li_ChangeOpt
//String	ls_ColName
//Integer	li_NationCode
//
//ls_SysDate = f_today()
//CHOOSE CASE UPPER(SQLCA.ServerName)
//	CASE 'SEWC','KDUC','KPU9'
//		li_ChangeOpt  = 11	//발령구분(11:신규임용)
//		li_NationCode = 118	//국적코드(118:대한민국)
//	CASE 'ORA9'
//		li_ChangeOpt  = 1		//발령구분(1:수습)
//		li_NationCode = 1		//국적코드(1:대한민국)
//END CHOOSE
//
//CHOOSE CASE li_SelectedTab
//	CASE 1	//인사기본정보	
//		idw_update[li_SelectedTab].Object.name           [ll_InsRow] = ls_KName					//성명
//		idw_update[li_SelectedTab].Object.jaejik_opt     [ll_InsRow] = 1							//재직구분(1:재직)
//		idw_update[li_SelectedTab].Object.nation_code    [ll_InsRow] = li_NationCode			//국적코드
//		idw_update[li_SelectedTab].Object.change_opt     [ll_InsRow] = li_ChangeOpt			//발령구분
//		idw_update[li_SelectedTab].Object.sal_year       [ll_InsRow] = MID(ls_SysDate,1,4)	//호봉년도
//		
//		//당년도 3월부터 9월까지이면 9월1일로 셋팅
//		//전년도 9월부터 12월까지, 당년도 1월부터 2월 까지이면 3월1일로 셋팅한다 
//		Integer	li_Year
//		Integer	li_Month
//		li_Year  = Integer(MID(ls_SysDate,1,4))	//년도
//		li_Month = Integer(MID(ls_SysDate,5,2))	//월
//		CHOOSE CASE li_Month
//			CASE IS > 2	
//				IF li_Month < 9 THEN
//					ls_SysDate = String(li_Year,'0000') + '0901'
//				ELSE
//					ls_SysDate = String(li_Year + 1,'0000') + '0301'
//				END IF
//			CASE IS < 3
//				ls_SysDate = String(li_Year,'0000') + '0301'
//		END CHOOSE
//		idw_update[li_SelectedTab].Object.firsthire_date [ll_InsRow] = ls_SysDate	//대학임용일자
//		idw_update[li_SelectedTab].Object.hakwonhire_date[ll_InsRow] = ls_SysDate	//학원임용일자
//		idw_update[li_SelectedTab].Object.sosok_date     [ll_InsRow] = ls_SysDate	//소속일자
//		
//		//직급코드가 시간강사인 경우는 소속은 교양과, 직급은 시간강사로 SETTING한다.
//		IF ls_DutyCode = '301' THEN
//			idw_update[li_SelectedTab].Object.gwa         [ll_InsRow] = '5200'		//소속코드
//			idw_update[li_SelectedTab].Object.duty_code   [ll_InsRow] = '301'			//직급코드
//		END IF
//		
//		IF lb_Chk THEN
//			ls_ColName = 'name'
//		ELSE
//			ls_ColName = 'member_no'
//		END IF
//		idw_update[li_SelectedTab].Object.DataWindow.ReadOnly = 'NO'
//	CASE 2	//신상상세정보
//		ls_ColName = 'working'
//		idw_update[li_SelectedTab].Object.DataWindow.ReadOnly = 'NO'
//	CASE 3	//가족사항
//		idw_update[li_SelectedTab].Object.sudang_yn      [ll_InsRow] = '0'				//수당여부
//		idw_update[li_SelectedTab].Object.gongje_yn      [ll_InsRow] = '0'				//공제여부
//		ls_ColName = 'jumin_no'
//	CASE 4	//학력사항
//		idw_update[li_SelectedTab].Object.from_date      [ll_InsRow] = ls_SysDate		//시작일자
//		idw_update[li_SelectedTab].Object.sign_opt       [ll_InsRow] = 3					//결재구분
//		idw_update[li_SelectedTab].Object.graduate_opt   [ll_InsRow] = 1					//졸업여부
//		idw_update[li_SelectedTab].Object.hakwi_nation   [ll_InsRow] = li_NationCode	//국적코드
//		ls_ColName = 'from_date'
//	CASE 5	//경력사항
//		idw_update[li_SelectedTab].Object.career_gbn     [ll_InsRow] = 1					//교외구분
//		idw_update[li_SelectedTab].Object.career_opt     [ll_InsRow] = 11					//경력구분		
//		idw_update[li_SelectedTab].Object.sign_opt       [ll_InsRow] = 3					//결재구분
//		ls_ColName = 'proces_opt'
//	CASE 6	//자격사항
//		idw_update[li_SelectedTab].Object.decision_opt   [ll_InsRow] = '1'				//인정구분
//		ls_ColName = 'certify_no'
//	CASE 7	//포상.징계사항
//		String	ls_gwa, ls_memberno
//		Integer 	li_jikwi_code
//		ls_MemberNo = idw_update[1].Object.member_no[1]	//개인번호
//		SELECT	GWA, JIKWI_CODE
//		INTO		:ls_gwa, :li_jikwi_code
//		FROM		INDB.HIN001M
//		WHERE		MEMBER_NO	=	:ls_MemberNo;
//
//		idw_update[li_SelectedTab].Object.from_date      [ll_InsRow] = ls_SysDate		//시작일자
//		idw_update[li_SelectedTab].Object.gwa		       [ll_InsRow] = ls_gwa			//부서
//		idw_update[li_SelectedTab].Object.jikwi_code     [ll_InsRow] = li_jikwi_code	//직위코드		
//		ls_ColName = 'prize_code'
//	CASE 8	//해외연수사항
//		idw_update[li_SelectedTab].Object.from_date      [ll_InsRow] = ls_SysDate		//시작일자
//		idw_update[li_SelectedTab].Object.country_opt    [ll_InsRow] = '1'				//국내외구분
//		ls_ColName = 'from_date'
//END CHOOSE
//idw_update[li_SelectedTab].SetItemStatus(ll_InsRow,0,Primary!,NotModified!)
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우로 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_setmsg('자료가 추가되었습니다.')
//wf_SetMenuBtn('IDSR')
//idw_update[li_SelectedTab].SetColumn(ls_ColName)
//idw_update[li_SelectedTab].SetFocus()
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
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
Integer	li_idx,i
Integer	li_ChgDw[]	//변경된사항만 저장
Integer	li_Arr
String	ls_fullName
Blob	lbo_Image	//인사이미지

	IF dw_list1.AcceptText() = -1 THEN
		dw_list1.SetFocus()
		RETURN -1
	END IF
	IF dw_list1.ModifiedCount() + &
		dw_list1.DeletedCount() > 0 THEN 
		li_Arr++
	END IF

IF li_Arr = 0 THEN
	wf_setmsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

		FOR	i = 1	TO	dw_list1.rowcount()
		
		ls_fullName	=	dw_list1.object.folder_name[i]
		IF	isnull(ls_fullname) OR ls_fullName = '' 	THEN	continue
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.3 저장하고자하는 이미지화일을 BLOB에 읽어온다.
		/////////////////////////////////////////////////////////////////////////////////

		lbo_Image = f_blob_read(ls_FullName)
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.4 이미지 정보 추가 및 수정처리
		/////////////////////////////////////////////////////////////////////////////////
		wf_setmsg('이미지 정보를 저장 중입니다.')
		String	ls_MemberNo	//개인번호
		Integer	li_rtn
		Long		ll_psize
		
		ls_MemberNo = dw_list1.Object.hin001m_member_no[i]
		Ll_psize	=	Long(filelength(ls_FullName))
		SELECT	1
		INTO		:li_Rtn
		FROM		INDB.HIN026M A
		WHERE		A.MEMBER_NO = :ls_MemberNo;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
			CASE 100
				INSERT	INTO	INDB.HIN026M(MEMBER_NO, P_SIZE)
				VALUES	(	:ls_MemberNo,:Ll_psize	);
			CASE ELSE
				MessageBox('오류',&
								'인사기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'인사번호 : ' + String(ls_MemberNo) + '~r~n' + &								
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
				RETURN -1
		END CHOOSE
			
		UPDATEBLOB	INDB.HIN026M
		SET			MEMBER_IMG = :lbo_Image
		WHERE			MEMBER_NO  = :ls_MemberNo;
		IF SQLCA.SQLCODE = 0 THEN
				UPDATE	INDB.HIN026M
				SET		P_SIZE = :Ll_psize	
				WHERE		MEMBER_NO  = :ls_MemberNo;
				IF SQLCA.SQLCODE = 0 THEN
					COMMIT;
				ELSE
			MessageBox('오류',&
							'인사기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'인사번호 : ' + String(ls_MemberNo) + '~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK;
			RETURN -1
		END IF
			wf_setmsg('이미지 정보가 저장되었습니다.')
		ELSE
			MessageBox('오류',&
							'인사기본이미지 처리 중 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'인사번호 : ' + String(ls_MemberNo) + '~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK;
			RETURN -1
		END IF
		
	NEXT
		
//	CASE ELSE
//END CHOOSE
///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_setmsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('SR')
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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
//Integer	li_SelectedTab
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 삭제할 데이타원도우의 선택여부 체크.
/////////////////////////////////////////////////////////////////////////////////////////
//Long		ll_GetRow
//IF li_SelectedTab > 2 THEN
//	IF li_SelectedTab = 9 OR li_SelectedTab = 10 OR li_SelectedTab = 11 THEN
//		wf_setmsg('이력자료는 조회만 가능합니다.')
//		MessageBox('확인','이력자료는 조회만 가능합니다.')
//		RETURN
//	END IF
//	
//	ll_GetRow = idw_update[li_SelectedTab].GetSelectedRow(0)
//
//	IF ll_GetRow = 0 THEN
//		wf_setmsg('삭제할 자료가 없습니다.')
//		RETURN
//	END IF
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 삭제메세지 처리.
////		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_Msg
//Integer	li_Rtn
//
//String	ls_MemberNo		//개인번호
//String	ls_KName			//성명
//String	ls_JuminNo		//주민번호
//String	ls_FromDate		//시작일자
//String	ls_CertifyNo	//자격번호
//String	ls_PrizeCode	//상벌코드
//String	ls_AppointCode	//보직코드
//Integer	li_SeqNo			//순번
//
//ls_MemberNo = TRIM(idw_update[1].Object.member_no[1])	//개인번호
//ls_KName    = TRIM(idw_update[1].Object.name     [1])	//성명
//IF LEN(ls_MemberNo) = 0 OR isNull(ls_MemberNo) THEN RETURN
//IF LEN(ls_KName) = 0 OR isNull(ls_KName) THEN ls_KName = ''
//
//ls_Msg = is_SubTitle[li_SelectedTab]+' 자료를 삭제하시겠습니까?'
//
//CHOOSE CASE li_SelectedTab
//	CASE 1
//		ls_Msg += '~r~n~r~n'+&
//					 '개인번호 : '+ls_MemberNo+'~r~n'+&
//					 '성      명 : '+ls_KName+'~r~n~r~n'+&
//					 '인사기본정보 삭제시 관련된 모든자료가 삭제됩니다.~r~n'+&
//					 '삭제후 저장하시기 바랍니다.'
//	CASE 2			
//		ls_Msg += '~r~n~r~n'+&
//					 '개인번호 : '+ls_MemberNo+'~r~n'+&
//					 '성      명 : '+ls_KName
//	CASE ELSE
//		IF idw_update[li_SelectedTab].GetSelectedRow(ll_GetRow) = 0 THEN
//			//////////////////////////////////////////////////////////////////////////////
//			// 2.1 삭제전 체크사항 기술
//			//////////////////////////////////////////////////////////////////////////////
//			//////////////////////////////////////////////////////////////////////////////
//			// 2.2 삭제메세지 처리부분
//			//////////////////////////////////////////////////////////////////////////////
//			ls_Msg += '~r~n~r~n'+&
//						 '개인번호 : '+ls_MemberNo+'~r~n'+&
//						 '성      명 : '+ls_KName+'~r~n'
//			CHOOSE CASE li_SelectedTab
//				CASE 3
//					////////////////////////////////////////////////////////////////////////
//					// 2.2.2 가족사항
//					////////////////////////////////////////////////////////////////////////
//					ls_JuminNo = idw_update[li_SelectedTab].Object.jumin_no[ll_GetRow]
//					ls_Msg += '주민번호 : ' + String(ls_JuminNo,'@@@@@@-@@@@@@@')
//				CASE 4
//					////////////////////////////////////////////////////////////////////////
//					// 2.2.3 학력사항
//					////////////////////////////////////////////////////////////////////////
//					ls_FromDate = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
//					ls_Msg += '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')
//				CASE 5
//					////////////////////////////////////////////////////////////////////////
//					// 2.2.4 경력사항
//					////////////////////////////////////////////////////////////////////////
//					li_SeqNo = idw_update[li_SelectedTab].Object.career_seq[ll_GetRow]
//					ls_Msg += '순      번 : ' + String(li_SeqNo)
//				CASE 6
//					////////////////////////////////////////////////////////////////////////
//					// 2.2.5 자격사항
//					////////////////////////////////////////////////////////////////////////
//					ls_CertifyNo = idw_update[li_SelectedTab].Object.certify_no[ll_GetRow]
//					ls_Msg += '자격번호 : ' + ls_CertifyNo
//				CASE 7
//					////////////////////////////////////////////////////////////////////////
//					// 2.2.6 포상.징계사항
//					////////////////////////////////////////////////////////////////////////
//					ls_PrizeCode = idw_update[li_SelectedTab].&
//						Describe("Evaluate('LookUpDisplay(prize_code)',"+String(ll_GetRow)+")")
//					ls_FromDate  = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
//					ls_Msg += '상벌구분 : ' + ls_PrizeCode+'~r~n'+&
//								 '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')
//				CASE 8
//					////////////////////////////////////////////////////////////////////////
//					// 2.2.7 해외연수사항
//					////////////////////////////////////////////////////////////////////////
//					ls_FromDate = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
//					ls_Msg += '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')
//			END CHOOSE
//		ELSE
//			ls_Msg = is_SubTitle[li_SelectedTab]+' 자료를 삭제하시겠습니까?'
//		END IF
//END CHOOSE
//
//li_Rtn = MessageBox('확인',ls_Msg,Question!,YesNo!,2)
//IF li_Rtn = 2 THEN RETURN
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 삭제처리.
/////////////////////////////////////////////////////////////////////////////////////////
//Long	ll_idx
//
//		/////////////////////////////////////////////////////////////////////////////////
//		// 3.1 인사기본정보 삭제처리
//		/////////////////////////////////////////////////////////////////////////////////
//		// 3.1.1 신상상세정보 및 세부항목 삭제처리
//		//////////////////////////////////////////////////////////////////////////////
//		wf_setmsg(is_SubTitle[02]+' 자료를 삭제처리 중입니다.')
//		idw_update[02].SetReDraw(FALSE)
//		idw_update[02].DeleteRow(1)
//		idw_update[02].InsertRow(0)
//		idw_update[02].Object.DataWindow.ReadOnly = 'YES'
//		idw_update[02].SetReDraw(TRUE)
//		
//		Integer	li_Arr
//		Long		ll_RowCnt
//		FOR li_Arr = 8 TO 3 STEP -1
//			wf_setmsg(is_SubTitle[li_Arr]+' 자료를 삭제처리 중입니다.')
//			
//			idw_update[li_Arr].SetReDraw(FALSE)
//			ll_RowCnt = idw_update[li_Arr].RowCount()
//			FOR ll_idx = ll_RowCnt TO 1 STEP -1
//				idw_update[li_Arr].DeleteRow(ll_idx)
//			NEXT
//			idw_update[li_Arr].SetReDraw(TRUE)
//		NEXT
//		//////////////////////////////////////////////////////////////////////////////
//		// 3.1.2 인사이미지 및 인사기본정보 삭제처리
//		//////////////////////////////////////////////////////////////////////////////
//		Blob	lbo_Image
//		SetNull(lbo_Image)
//		wf_setmsg(is_SubTitle[01]+' 자료를 삭제하였습니다. 저장하시기 바랍니다.')
//		wf_SetMenuBtn('ISR')
//
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
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
wf_setmsg('')
//wf_SetMenuBtn('SR')
uo_member.sle_kname.SetFocus()



dw_list1.Reset()


//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 인사기본정보를 관리한다.
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
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 직급명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////
// 1.3 조회조건 - 재직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
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

wf_setmsg('인사기본정보를 초기화 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 1.1 성별코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_성별구분]를 초기화 중입니다...','')
//idw_update[01].GetChild('sex_code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('sex_code',0) = 0 THEN
//	wf_setmsg('공통코드[성별]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF


////////////////////////////////////////////////////////////////////////////////////
// 1.3 재직코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_재직구분]를 초기화 중입니다...','')
//idw_update[01].GetChild('jaejik_opt',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jaejik_opt',0) = 0 THEN
//	wf_setmsg('공통코드[재직]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF





///////////////////////////////////////////////////////////////////////////////////////
// 11.  초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin203i
end type

type ln_tempright from w_msheet`ln_tempright within w_hin203i
end type

type ln_temptop from w_msheet`ln_temptop within w_hin203i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin203i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin203i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin203i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin203i
end type

type uc_insert from w_msheet`uc_insert within w_hin203i
end type

type uc_delete from w_msheet`uc_delete within w_hin203i
end type

type uc_save from w_msheet`uc_save within w_hin203i
end type

type uc_excel from w_msheet`uc_excel within w_hin203i
end type

type uc_print from w_msheet`uc_print within w_hin203i
end type

type st_line1 from w_msheet`st_line1 within w_hin203i
end type

type st_line2 from w_msheet`st_line2 within w_hin203i
end type

type st_line3 from w_msheet`st_line3 within w_hin203i
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin203i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin203i
integer beginy = 344
integer endy = 344
end type

type dw_list1 from cuo_dwwindow_one_hin within w_hin203i
integer x = 55
integer y = 360
integer width = 4379
integer height = 1912
integer taborder = 70
string dataobject = "d_hin203i_01"
boolean border = false
borderstyle borderstyle = stylebox!
end type

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

event buttonclicked;call super::buttonclicked;



IF		dwo.name = 'b_file'	THEN
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1.2 화일열기 화면 오픈
		/////////////////////////////////////////////////////////////////////////////////
		Integer	li_Rtn
		String	ls_FullName
		String	ls_FileName

		
		li_Rtn = GetFileOpenName("", + ls_FullName,&
									ls_FileName, "BMP",&
									"BMP Files (*.BMP),*.BMP," + &
									"ALL Files (*.*), *.*")
		IF li_Rtn <> 1 THEN RETURN
		IF LEN(ls_FullName) = 0 THEN RETURN
		This.object.folder_name[row]	=	ls_FullName



END IF
end event

type uo_member from cuo_insa_member within w_hin203i
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

type dw_con from uo_dwfree within w_hin203i
integer x = 55
integer y = 164
integer width = 4379
integer height = 180
integer taborder = 10
string dataobject = "d_hin202a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

