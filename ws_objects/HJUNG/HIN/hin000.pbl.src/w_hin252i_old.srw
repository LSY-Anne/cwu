$PBExportHeader$w_hin252i_old.srw
$PBExportComments$인사발령결재
forward
global type w_hin252i_old from w_msheet
end type
type dw_cancel from datawindow within w_hin252i_old
end type
type ddlb_gubn from dropdownlistbox within w_hin252i_old
end type
type st_19 from statictext within w_hin252i_old
end type
type dw_car_year from cuo_dwwindow_one_hin within w_hin252i_old
end type
type cb_cancel from commandbutton within w_hin252i_old
end type
type st_6 from statictext within w_hin252i_old
end type
type st_5 from statictext within w_hin252i_old
end type
type dw_sign_opt from datawindow within w_hin252i_old
end type
type st_2 from statictext within w_hin252i_old
end type
type dw_update from cuo_dwwindow_one_hin within w_hin252i_old
end type
type uo_member from cuo_insa_member within w_hin252i_old
end type
type gb_1 from groupbox within w_hin252i_old
end type
type dw_change_opt from datawindow within w_hin252i_old
end type
type cb_hakjang from commandbutton within w_hin252i_old
end type
type cb_esajang from commandbutton within w_hin252i_old
end type
end forward

global type w_hin252i_old from w_msheet
integer height = 2616
string title = "인사발령결재"
event type boolean ue_save_01 ( long al_getrow )
event type boolean ue_save_02 ( long al_getrow )
event type boolean ue_save_11 ( long al_getrow )
event type boolean ue_save_12 ( long al_getrow )
event type boolean ue_save_21 ( long al_getrow )
event type boolean ue_save_22 ( long al_getrow )
event type boolean ue_save_23 ( long al_getrow )
event type boolean ue_save_31 ( long al_getrow )
event type boolean ue_save_41 ( long al_getrow )
event type boolean ue_save_42 ( long al_getrow )
event type boolean ue_save_51 ( long al_getrow )
event type boolean ue_save_61 ( long al_getrow )
event type boolean ue_save_62 ( long al_getrow )
event type boolean ue_save_63 ( long al_getrow )
event type boolean ue_save_64 ( long al_getrow )
event type boolean ue_save_65 ( long al_getrow )
event type boolean ue_save_66 ( long al_getrow )
event type boolean ue_save_71 ( long al_getrow )
event type boolean ue_save_72 ( long al_getrow )
event type boolean ue_save_81 ( long al_getrow )
event type boolean ue_save_82 ( long al_getrow )
event type boolean ue_save_83 ( long al_getrow )
event type boolean ue_save_84 ( long al_getrow )
event type boolean ue_chk_sal_confirm ( long al_getrow,  decimal adc_careerym,  ref string as_salclass,  ref string as_saldate,  ref integer ai_salleftmonth )
event type boolean ue_save_91 ( long al_getrow )
event type boolean ue_save_00 ( long al_getrow )
dw_cancel dw_cancel
ddlb_gubn ddlb_gubn
st_19 st_19
dw_car_year dw_car_year
cb_cancel cb_cancel
st_6 st_6
st_5 st_5
dw_sign_opt dw_sign_opt
st_2 st_2
dw_update dw_update
uo_member uo_member
gb_1 gb_1
dw_change_opt dw_change_opt
cb_hakjang cb_hakjang
cb_esajang cb_esajang
end type
global w_hin252i_old w_hin252i_old

type variables
String	is_Worker		//등록자
DateTime	idt_WorkDate	//등록일자
String	is_IpAddr		//등록단말기
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

event type boolean ue_save_01(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_01
//	기 능 설 명: 수습인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
RETURN THIS.TRIGGER EVENT ue_save_11(al_GetRow)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save_02;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_02
//	기 능 설 명: 수습해제인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_11(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_11
//	기 능 설 명: 신규임용인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
String	ls_DeptCode			//조직코드
String	ls_SosokDate		//소속일자
String	ls_JikJongDate		//직종일자
Integer	li_JikWiCode		//직위코드
String	ls_DutyCode			//직급코드
String	ls_DutyDate			//직급일자
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_JaeImYongStart	//재임용시작일자
String	ls_JaeImYongEnd	//재임용종료일자
Integer	li_JikMuCode		//직무코드
String	ls_JunimDate		//전임임용일
String	ls_JoGyoSuDate		//조교수임용일
String	ls_BuGyoSuDate		//부교수임용일
String	ls_GyoSuDate		//교수임용일
String	ls_SalYear			//호봉년도
String	ls_SalClass			//호봉코드
String	ls_SalDate			//호봉일자
Integer	li_SalLeftMonth	//호봉잔여월수

ls_MemberNo       = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_DeptCode       = dw_update.Object.gwa            [al_GetRow]	//조직코드
ls_SosokDate      = dw_update.Object.sosok_date     [al_GetRow]	//소속일자
ls_JikJongDate    = dw_update.Object.jikjong_date   [al_GetRow]	//직종일자
li_JikWiCode      = dw_update.Object.jikwi_code     [al_GetRow]	//직위코드
ls_DutyCode       = dw_update.Object.duty_code      [al_GetRow]	//직급코드
ls_DutyDate       = dw_update.Object.duty_date      [al_GetRow]	//직급일자
li_ChangeOpt      = dw_update.Object.change_opt     [al_GetRow]	//발령코드
ls_ChangeDate     = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_JaeImYongStart = dw_update.Object.jaeimyong_start[al_GetRow]	//재임용시작일자
ls_JaeImYongEnd   = dw_update.Object.jaeimyong_end  [al_GetRow]	//재임용종료일자
li_JikMuCode      = dw_update.Object.jikmu_code     [al_GetRow]	//직무코드
ls_JunimDate      = dw_update.Object.junim_date     [al_GetRow]	//전임임용일
ls_JoGyoSuDate    = dw_update.Object.jogyosu_date   [al_GetRow]	//조교수임용일
ls_BuGyoSuDate    = dw_update.Object.bugyosu_date   [al_GetRow]	//부교수임용일
ls_GyoSuDate      = dw_update.Object.gyosu_date     [al_GetRow]	//교수임용일
ls_SalYear        = dw_update.Object.sal_year       [al_GetRow]	//호봉년도
ls_SalClass       = dw_update.Object.sal_class      [al_GetRow]	//호봉코드
ls_SalDate        = dw_update.Object.sal_date       [al_GetRow]	//호봉일자
li_SalLeftMonth   = dw_update.Object.sal_leftmonth  [al_GetRow]	//호봉잔여월수
CHOOSE CASE ls_DutyCode
	CASE '101' ; ls_GyoSuDate   = ls_ChangeDate	//교수임용일
	CASE '102' ; ls_BuGyoSuDate = ls_ChangeDate	//부교수임용일
	CASE '103' ; ls_JoGyoSuDate = ls_ChangeDate	//조교수임용일
	CASE '104' ; ls_JunimDate   = ls_ChangeDate	//전임임용일
END CHOOSE

UPDATE	INDB.HIN001M
SET		GWA             = :ls_DeptCode,
			SOSOK_DATE      = :ls_SosokDate,
			JIKJONG_DATE    = :ls_JikJongDate,
			JIKWI_CODE      = :li_JikWiCode,
			DUTY_CODE       = :ls_DutyCode,
			DUTY_DATE       = :ls_DutyDate,
			CHANGE_OPT      = :li_ChangeOpt,
			CHANGE_DATE     = :ls_ChangeDate,
			JAEIMYONG_START = :ls_JaeImYongStart,
			JAEIMYONG_END   = :ls_JaeImYongEnd,
			JIKMU_CODE      = :li_JikMuCode,
			SAL_YEAR        = :ls_SalYear,
			SAL_CLASS       = :ls_SalClass,
			SAL_DATE        = :ls_SalDate,
			SAL_LEFTMONTH   = :li_SalLeftMonth,
			JUNIM_DATE      = :ls_JunimDate,
			JOGYOSU_DATE    = :ls_JoGyoSuDate,
			BUGYOSU_DATE    = :ls_BuGyoSuDate,
			GYOSU_DATE      = :ls_GyoSuDate,
			JOB_UID         = :is_Worker,
			JOB_ADD         = :is_IPAddr,
			JOB_DATE        = :idt_WorkDate
WHERE		MEMBER_NO       = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('신규임용 처리가 완료되었습니다.')
RETURN TRUE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_12(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_12
//	기 능 설 명: 해임인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M), 포상·징계사항(HIN016H) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_RetireDate		//퇴직일자
ls_MemberNo   = dw_update.Object.member_no    [al_GetRow]	//개인번호
li_JaeJikOpt  = 3															//재직구분(3:퇴직)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드
ls_ChangeDate = dw_update.Object.from_date    [al_GetRow]	//최종발령일자
ls_RetireDate = dw_update.Object.retire_date  [al_GetRow]	//퇴직일자

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			RETIRE_DATE = :ls_RetireDate,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 포상·징계사항(HIN016H)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('포상·징계사항 변동처리 중입니다...')
Integer	li_PrizeCode		//상벌코드
String	ls_FromDate			//시작일자
String	ls_ToDate			//종료일자
String	ls_Content			//상벌내용
String	ls_OrganName		//기관명
ls_FromDate   = ls_ChangeDate											//시작일자
ls_ToDate     = dw_update.Object.to_date        [al_GetRow]	//종료일자
li_PrizeCode  = 5005														//상벌코드(5005:정직)
ls_Content    = dw_update.Object.change_reason  [al_GetRow]	//상벌내용
ls_OrganName  = ''														//기관명

INSERT	INTO	INDB.HIN016H
VALUES	(	:ls_MemberNo,
				:li_PrizeCode,
				:ls_FromDate,
				:ls_ToDate,
				:ls_Content,
				:ls_OrganName,
				:is_Worker,
				:idt_WorkDate,
				:is_IPAddr,
				:is_Worker,
				:is_IPAddr,
				:idt_WorkDate	);
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('포상·징계사항 변동시 오류가 발생하였습니다.')
	MessageBox('확인','포상·징계사항 변동시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('의원면직 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_21(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_21
//	기 능 설 명: 정기승진인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 경력사항(HIN009H), 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 경력사항(HIN009H)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('경력사항 변동처리 중입니다...')
//인사기본 TABLE LAYOUT================================================================
String		ls_MemberNo			//개인번호
String		ls_SalYear			//호봉년도
String		ls_SalClass			//호봉코드
String		ls_SalDate			//호봉일자
Integer		li_SalLeftMonth	//호봉잔여월수
String		ls_FrDate			//발령시작일자
String		ls_ToDate			//발령종료일자
Decimal{2}	ldc_CareerYm		//총경력인정년수
//경력사항 TABLE LAYOUT================================================================
Integer		li_CareerSeq		//경력사항순번
Integer		li_CareerOpt		//경력구분
Integer		li_ProcesOpt		//처리구분(1:군경력,2,학력경력)
Integer		li_CarrerGbn 		//내외구분
String		ls_CarrerCon		//자격내용
Decimal{2}	ldc_WorkYear		//근무년월
Decimal{2}	ldc_DecisionYear	//인정년월
Decimal{2}	ldc_CarYear			//경력누계

//인사변동사항 TABLE LAYOUT============================================================
Integer		li_SingOpt			//결재구분
//기타=================================================================================
String		ls_Null				//
Integer		li_Null				//
SetNull(ls_Null)
SetNull(li_Null)
////////////////////////////////////////////////////////////////////////////////////
// 1.1 경력사항(HIN009H)변경처리
////////////////////////////////////////////////////////////////////////////////////
ls_MemberNo     = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_ToDate       = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_SalYear      = dw_update.Object.sal_year       [al_GetRow]	//호봉년도
ls_SalClass     = dw_update.Object.sal_class      [al_GetRow]	//호봉코드
ls_SalDate      = dw_update.Object.sal_date       [al_GetRow]	//호봉일자
li_SalLeftMonth = dw_update.Object.sal_leftmonth  [al_GetRow]	//호봉잔여월수
li_CareerOpt    = 11															//승진100% 경력인정
li_ProcesOpt    = 3															//처리구분(승진경력)
li_CarrerGbn    = 1															//내외구분(1:국내,2:국외)
ls_CarrerCon    = '정기승진시경력'										//자격내용
li_SingOpt      = 3															//결재구분(이사장결재)
ls_ToDate = String(RelativeDate(Date(String(ls_ToDate,'@@@@/@@/@@')), - 1),'YYYYMMDD')
////////////////////////////////////////////////////////////////////////////////////
// 1.2 경력사항 추가시 시작일자와 종료일자를 처리방법
//				경력사항에 자료가 한건도 없는 경우와
//				승진경력이 한건도 없는 경우
//					시작일자 = 학원임용일자
//					종료일자 = 발령일자
//				승진경력이 있는 경우
//					시작일자 = 이전승진경력의 종료일자
//					종료일자 = 발령일자
////////////////////////////////////////////////////////////////////////////////////
SELECT	DECODE(SIGN(NVL(B.COM_CNT,0) - 1),
				-1,NVL(C.HAKWONHIRE_DATE,:ls_ToDate),
				DECODE(SIGN(NVL(D.COM_CNT,0) - 1),
					-1,NVL(C.HAKWONHIRE_DATE,:ls_ToDate),
					TO_CHAR(TO_DATE(B.COM_TO_DATE) + 1,'YYYYMMDD') ))
INTO		:ls_FrDate
FROM		INDB.HIN001M A,
			/************************************************************************/
			/* 경력사항건수 SELECT																	*/
			/************************************************************************/
			(	SELECT	A.MEMBER_NO,
							MAX(A.TO_DATE)	COM_TO_DATE,
							COUNT(*)			COM_CNT
				FROM		INDB.HIN009H A
				WHERE		A.MEMBER_NO  = :ls_MemberNo
				AND		A.TO_DATE    < :ls_ToDate
				AND		A.PROCES_OPT = 3
				GROUP	BY	A.MEMBER_NO ) B,
			/************************************************************************/
			/*	인사기본에 학원임용일 SELECT														*/
			/************************************************************************/
			(	SELECT	A.MEMBER_NO,
							A.HAKWONHIRE_DATE
				FROM		INDB.HIN001M A
				WHERE		A.MEMBER_NO = :ls_MemberNo ) C,
			/************************************************************************/
			/*	인사변동에 정기승진,특별승진 건수 SELECT										*/
			/************************************************************************/
			(	SELECT	A.MEMBER_NO,
							MAX(A.TO_DATE)	COM_TO_DATE,
							COUNT(*)			COM_CNT
				FROM		INDB.HIN007H A
				WHERE		A.MEMBER_NO  = :ls_MemberNo
				AND		A.CHANGE_OPT IN (21,22)
				GROUP	BY	A.MEMBER_NO ) D
WHERE		A.MEMBER_NO  = B.MEMBER_NO(+)
AND		A.MEMBER_NO  = C.MEMBER_NO(+)
AND		A.MEMBER_NO  = D.MEMBER_NO(+)
AND		A.MEMBER_NO  = :ls_MemberNo;
IF ls_FrDate < ls_ToDate AND &
	NOT isNull(ls_FrDate) AND &
	LEN(TRIM(ls_FrDate)) > 0 THEN
	//////////////////////////////////////////////////////////////////////////////////
	// 1.3 경력사항에 승진경력사항 삭제처리
	/////////////////////////////////////////////////////////////////////////////////
	wf_SetMsg('경력사항에 승진경력사항 삭제처리 중 입니다...')
	DELETE	FROM	INDB.HIN009H
	WHERE		MEMBER_NO  = :ls_MemberNo
	AND		TO_DATE    = :ls_ToDate
	AND		PROCES_OPT = :li_ProcesOpt;
	/////////////////////////////////////////////////////////////////////////////////
	// 1.4 경력사항 순번생성
	/////////////////////////////////////////////////////////////////////////////////
	wf_SetMsg('승진경력사항을 경력사항으로 처리 중 입니다...')
	SELECT	NVL(MAX(A.CAREER_SEQ),0)+1
	INTO		:li_CareerSeq
	FROM		INDB.HIN009H A
	WHERE		A.MEMBER_NO = :ls_MemberNo;
	CHOOSE CASE SQLCA.SQLCODE
		CASE 0
		CASE 100
			li_CareerSeq = 1
		CASE ELSE
			MessageBox('오류',&
							'[승진]경력사항 순번 생성시 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN FALSE
	END CHOOSE
	/////////////////////////////////////////////////////////////////////////////////
	// 1.5 경력사항 추가
	/////////////////////////////////////////////////////////////////////////////////
	SELECT	FU_RTN_YEAR_MONTH(:ls_FrDate,:ls_ToDate)
	INTO		:ldc_WorkYear
	FROM		DUAL;
	INSERT	INTO	INDB.HIN009H
	VALUES	(		:ls_MemberNo,
						:li_CareerSeq,
						:li_CareerOpt,
						:li_ProcesOpt,
						:ls_FrDate,
						:ls_ToDate,
						:li_CarrerGbn,
						:ls_CarrerCon,
						:ls_Null,:ls_Null,:ls_Null,:ls_Null,:ls_Null,
						:ldc_WorkYear,:ldc_WorkYear,100,:ldc_WorkYear,:li_Null,
						:ls_SalYear,:ls_SalClass,:ls_SalDate,:li_SalLeftMonth,
						:li_SingOpt,
						:is_Worker,
						:idt_WorkDate,
						:is_IPAddr,
						:is_Worker,
						:is_IPAddr,
						:idt_WorkDate	);
	CHOOSE CASE SQLCA.SQLCODE
		CASE 0
		CASE 100
		CASE ELSE
			MessageBox('오류',&
							'[승진]경력사항 추가시 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN FALSE
	END CHOOSE
	/////////////////////////////////////////////////////////////////////////////////
	// 1.6 경력사항에 경력누계 UPDATE 처리
	//		인사기본마스터에 총경력년월 UPDATE 처리
	/////////////////////////////////////////////////////////////////////////////////
	Long			ll_CarRow
	Long			ll_CarRowCnt
	Decimal{2}	ldc_HwanYear
	String		ls_Str
	dw_car_year.Reset()
	ll_CarRowCnt = dw_car_year.Retrieve(ls_MemberNo)
	FOR ll_CarRow = 1 TO ll_CarRowCnt
		//////////////////////////////////////////////////////////////////////////////
		// 1.6.1 총경력년월누계
		//////////////////////////////////////////////////////////////////////////////
		ls_Str = "Evaluate('cumulativeSum(hwan_year for all)',"+&
					String(ll_CarRow)+")"
		ldc_HwanYear = Double(dw_car_year.Describe(ls_Str))
		IF isNull(ldc_HwanYear) OR ldc_HwanYear = 0 THEN CONTINUE
		SELECT	FU_RTN_HWAN_YEAR(:ldc_HwanYear,100)
		INTO		:ldc_CarYear
		FROM		DUAL;
		dw_car_year.Object.car_year[ll_CarRow] = ldc_CarYear
		//////////////////////////////////////////////////////////////////////////////
		// 1.6.2 근속인정년월누계
		//////////////////////////////////////////////////////////////////////////////
		ls_Str = "Evaluate('cumulativeSum(if(career_gbn = 9,hwan_year,0) for all)',"+&
					String(ll_CarRow)+")"
		ldc_HwanYear = Double(dw_car_year.Describe(ls_Str))
		IF NOT ( isNull(ldc_HwanYear) OR ldc_HwanYear = 0 ) THEN
			SELECT	FU_RTN_HWAN_YEAR(:ldc_HwanYear,100)
			INTO		:ldc_CareerYm
			FROM		DUAL;
		ELSE
			ldc_CareerYm = 0
		END IF
		dw_car_year.Object.com_career_ym[ll_CarRow] = ldc_CareerYm
	NEXT
	IF dw_car_year.Update() <> 1 THEN RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_DeptCode			//조직코드
String	ls_SosokDate		//소속일자
String	ls_JikJongDate		//직종일자
Integer	li_JikWiCode		//직위코드
String	ls_DutyCode			//직급코드
String	ls_DutyDate			//직급일자
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_JaeImYongStart	//재임용시작일자
String	ls_JaeImYongEnd	//재임용종료일자
Integer	li_JikMuCode		//직무코드
String	ls_JunimDate		//전임임용일
String	ls_JoGyoSuDate		//조교수임용일
String	ls_BuGyoSuDate		//부교수임용일
String	ls_GyoSuDate		//교수임용일

ls_DeptCode       = dw_update.Object.gwa            [al_GetRow]	//조직코드
ls_SosokDate      = dw_update.Object.sosok_date     [al_GetRow]	//소속일자
ls_JikJongDate    = dw_update.Object.jikjong_date   [al_GetRow]	//직종일자
li_JikWiCode      = dw_update.Object.jikwi_code     [al_GetRow]	//직위코드
ls_DutyCode       = dw_update.Object.duty_code      [al_GetRow]	//직급코드
ls_DutyDate       = dw_update.Object.duty_date      [al_GetRow]	//직급일자
li_ChangeOpt      = dw_update.Object.change_opt     [al_GetRow]	//발령코드
ls_ChangeDate     = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_JaeImYongStart = dw_update.Object.jaeimyong_start[al_GetRow]	//재임용시작일자
ls_JaeImYongEnd   = dw_update.Object.jaeimyong_end  [al_GetRow]	//재임용종료일자
li_JikMuCode      = dw_update.Object.jikmu_code     [al_GetRow]	//직무코드
ls_JunimDate      = dw_update.Object.junim_date     [al_GetRow]	//전임임용일
ls_JoGyoSuDate    = dw_update.Object.jogyosu_date   [al_GetRow]	//조교수임용일
ls_BuGyoSuDate    = dw_update.Object.bugyosu_date   [al_GetRow]	//부교수임용일
ls_GyoSuDate      = dw_update.Object.gyosu_date     [al_GetRow]	//교수임용일
CHOOSE CASE ls_DutyCode
	CASE '101' ; ls_GyoSuDate   = ls_ChangeDate	//교수임용일
	CASE '102' ; ls_BuGyoSuDate = ls_ChangeDate	//부교수임용일
	CASE '103' ; ls_JoGyoSuDate = ls_ChangeDate	//조교수임용일
	CASE '104' ; ls_JunimDate   = ls_ChangeDate	//전임임용일
END CHOOSE

UPDATE	INDB.HIN001M
SET		GWA             = :ls_DeptCode,
			SOSOK_DATE      = :ls_SosokDate,
			JIKJONG_DATE    = :ls_JikJongDate,
			JIKWI_CODE      = :li_JikWiCode,
			DUTY_CODE       = :ls_DutyCode,
			DUTY_DATE       = :ls_ChangeDate,
			CHANGE_OPT      = :li_ChangeOpt,
			CHANGE_DATE     = :ls_ChangeDate,
			JAEIMYONG_START = :ls_JaeImYongStart,
			JAEIMYONG_END   = :ls_JaeImYongEnd,
			JIKMU_CODE      = :li_JikMuCode,
			SAL_YEAR        = :ls_SalYear,
			SAL_CLASS       = :ls_SalClass,
			SAL_DATE        = :ls_SalDate,
			SAL_LEFTMONTH   = :li_SalLeftMonth,
			JUNIM_DATE      = :ls_JunimDate,
			JOGYOSU_DATE    = :ls_JoGyoSuDate,
			BUGYOSU_DATE    = :ls_BuGyoSuDate,
			GYOSU_DATE      = :ls_GyoSuDate,
			CAREER_YM       = :ldc_CareerYm,
			CAR_YEAR        = :ldc_CarYear,
			JOB_UID         = :is_Worker,
			JOB_ADD         = :is_IPAddr,
			JOB_DATE        = :idt_WorkDate
WHERE		MEMBER_NO       = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('정기승진 처리가 완료되었습니다.')
RETURN TRUE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_22(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_22
//	기 능 설 명: 특별승진인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 경력사항(HIN009H), 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 경력사항(HIN009H)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('경력사항 변동처리 중입니다...')
//인사기본 TABLE LAYOUT================================================================
String		ls_MemberNo			//개인번호
String		ls_SalYear			//호봉년도
String		ls_SalClass			//호봉코드
String		ls_SalDate			//호봉일자
Integer		li_SalLeftMonth	//호봉잔여월수
String		ls_FrDate			//발령시작일자
String		ls_ToDate			//발령종료일자
Decimal{2}	ldc_CareerYm		//총경력인정년수
//경력사항 TABLE LAYOUT================================================================
Integer		li_CareerSeq		//경력사항순번
Integer		li_CareerOpt		//경력구분
Integer		li_ProcesOpt		//처리구분(1:군경력,2,학력경력)
Integer		li_CarrerGbn 		//내외구분
String		ls_CarrerCon		//자격내용
Decimal{2}	ldc_WorkYear		//근무년월
Decimal{2}	ldc_DecisionYear	//인정년월
Decimal{2}	ldc_CarYear			//경력누계

//인사변동사항 TABLE LAYOUT============================================================
Integer		li_SingOpt			//결재구분
//기타=================================================================================
String		ls_Null				//
Integer		li_Null				//
SetNull(ls_Null)
SetNull(li_Null)
////////////////////////////////////////////////////////////////////////////////////
// 1.1 경력사항(HIN009H)변경처리
////////////////////////////////////////////////////////////////////////////////////
ls_MemberNo     = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_ToDate       = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_SalYear      = dw_update.Object.sal_year       [al_GetRow]	//호봉년도
ls_SalClass     = dw_update.Object.sal_class      [al_GetRow]	//호봉코드
ls_SalDate      = dw_update.Object.sal_date       [al_GetRow]	//호봉일자
li_SalLeftMonth = dw_update.Object.sal_leftmonth  [al_GetRow]	//호봉잔여월수
li_CareerOpt    = 11															//승진100% 경력인정
li_ProcesOpt    = 3															//처리구분(승진경력)
li_CarrerGbn    = 1															//내외구분(1:국내,2:국외)
ls_CarrerCon    = '특별승진시경력'										//자격내용
li_SingOpt      = 3															//결재구분(이사장결재)
ls_ToDate = String(RelativeDate(Date(String(ls_ToDate,'@@@@/@@/@@')), - 1),'YYYYMMDD')
////////////////////////////////////////////////////////////////////////////////////
// 1.2 경력사항 추가시 시작일자와 종료일자를 처리방법
//				경력사항에 자료가 한건도 없는 경우와
//				승진경력이 한건도 없는 경우
//					시작일자 = 학원임용일자
//					종료일자 = 발령일자
//				승진경력이 있는 경우
//					시작일자 = 이전승진경력의 종료일자
//					종료일자 = 발령일자
////////////////////////////////////////////////////////////////////////////////////
SELECT	DECODE(SIGN(NVL(B.COM_CNT,0) - 1),
				-1,NVL(C.HAKWONHIRE_DATE,:ls_ToDate),
				DECODE(SIGN(NVL(D.COM_CNT,0) - 1),
					-1,NVL(C.HAKWONHIRE_DATE,:ls_ToDate),
					TO_CHAR(TO_DATE(B.COM_TO_DATE) + 1,'YYYYMMDD') ))
INTO		:ls_FrDate
FROM		INDB.HIN001M A,
			/************************************************************************/
			/* 경력사항건수 SELECT																	*/
			/************************************************************************/
			(	SELECT	A.MEMBER_NO,
							MAX(A.TO_DATE)	COM_TO_DATE,
							COUNT(*)			COM_CNT
				FROM		INDB.HIN009H A
				WHERE		A.MEMBER_NO  = :ls_MemberNo
				AND		A.TO_DATE    < :ls_ToDate
				AND		A.PROCES_OPT = 3
				GROUP	BY	A.MEMBER_NO ) B,
			/************************************************************************/
			/*	인사기본에 학원임용일 SELECT														*/
			/************************************************************************/
			(	SELECT	A.MEMBER_NO,
							A.HAKWONHIRE_DATE
				FROM		INDB.HIN001M A
				WHERE		A.MEMBER_NO = :ls_MemberNo ) C,
			/************************************************************************/
			/*	인사변동에 정기승진,특별승진 건수 SELECT										*/
			/************************************************************************/
			(	SELECT	A.MEMBER_NO,
							MAX(A.TO_DATE)	COM_TO_DATE,
							COUNT(*)			COM_CNT
				FROM		INDB.HIN007H A
				WHERE		A.MEMBER_NO  = :ls_MemberNo
				AND		A.CHANGE_OPT IN (21,22)
				GROUP	BY	A.MEMBER_NO ) D
WHERE		A.MEMBER_NO  = B.MEMBER_NO(+)
AND		A.MEMBER_NO  = C.MEMBER_NO(+)
AND		A.MEMBER_NO  = D.MEMBER_NO(+)
AND		A.MEMBER_NO  = :ls_MemberNo;
IF ls_FrDate < ls_ToDate AND &
	NOT isNull(ls_FrDate) AND &
	LEN(TRIM(ls_FrDate)) > 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 1.3 경력사항에 승진경력사항 삭제처리
	/////////////////////////////////////////////////////////////////////////////////
	wf_SetMsg('경력사항에 승진경력사항 삭제처리 중 입니다...')
	DELETE	FROM	INDB.HIN009H
	WHERE		MEMBER_NO  = :ls_MemberNo
	AND		TO_DATE    = :ls_ToDate
	AND		PROCES_OPT = :li_ProcesOpt;
	/////////////////////////////////////////////////////////////////////////////////
	// 1.4 경력사항 순번생성
	/////////////////////////////////////////////////////////////////////////////////
	wf_SetMsg('승진경력사항을 경력사항으로 처리 중 입니다...')
	SELECT	NVL(MAX(A.CAREER_SEQ),0)+1
	INTO		:li_CareerSeq
	FROM		INDB.HIN009H A
	WHERE		A.MEMBER_NO = :ls_MemberNo;
	CHOOSE CASE SQLCA.SQLCODE
		CASE 0
		CASE 100
			li_CareerSeq = 1
		CASE ELSE
			MessageBox('오류',&
							'[승진]경력사항 순번 생성시 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN FALSE
	END CHOOSE
	/////////////////////////////////////////////////////////////////////////////////
	// 1.5 경력사항 추가
	/////////////////////////////////////////////////////////////////////////////////
	SELECT	FU_RTN_YEAR_MONTH(:ls_FrDate,:ls_ToDate)
	INTO		:ldc_WorkYear
	FROM		DUAL;
	INSERT	INTO	INDB.HIN009H
	VALUES	(		:ls_MemberNo,
						:li_CareerSeq,
						:li_CareerOpt,
						:li_ProcesOpt,
						:ls_FrDate,
						:ls_ToDate,
						:li_CarrerGbn,
						:ls_CarrerCon,
						:ls_Null,:ls_Null,:ls_Null,:ls_Null,:ls_Null,
						:ldc_WorkYear,:ldc_WorkYear,100,:ldc_WorkYear,:li_Null,
						:ls_SalYear,:ls_SalClass,:ls_SalDate,:li_SalLeftMonth,
						:li_SingOpt,
						:is_Worker,
						:idt_WorkDate,
						:is_IPAddr,
						:is_Worker,
						:is_IPAddr,
						:idt_WorkDate	);
	CHOOSE CASE SQLCA.SQLCODE
		CASE 0
		CASE 100
		CASE ELSE
			MessageBox('오류',&
							'[승진]경력사항 추가시 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN FALSE
	END CHOOSE
	/////////////////////////////////////////////////////////////////////////////////
	// 1.6 경력사항에 경력누계 UPDATE 처리
	//		인사기본마스터에 총경력년월 UPDATE 처리
	/////////////////////////////////////////////////////////////////////////////////
	Long			ll_CarRow
	Long			ll_CarRowCnt
	Decimal{2}	ldc_HwanYear
	String		ls_Str
	dw_car_year.Reset()
	ll_CarRowCnt = dw_car_year.Retrieve(ls_MemberNo)
	FOR ll_CarRow = 1 TO ll_CarRowCnt
		//////////////////////////////////////////////////////////////////////////////
		// 1.6.1 총경력년월누계
		//////////////////////////////////////////////////////////////////////////////
		ls_Str = "Evaluate('cumulativeSum(hwan_year for all)',"+&
					String(ll_CarRow)+")"
		ldc_HwanYear = Double(dw_car_year.Describe(ls_Str))
		IF isNull(ldc_HwanYear) OR ldc_HwanYear = 0 THEN CONTINUE
		SELECT	FU_RTN_HWAN_YEAR(:ldc_HwanYear,100)
		INTO		:ldc_CarYear
		FROM		DUAL;
		dw_car_year.Object.car_year[ll_CarRow] = ldc_CarYear
		//////////////////////////////////////////////////////////////////////////////
		// 1.6.2 근속인정년월누계
		//////////////////////////////////////////////////////////////////////////////
		ls_Str = "Evaluate('cumulativeSum(if(career_gbn = 9,hwan_year,0) for all)',"+&
					String(ll_CarRow)+")"
		ldc_HwanYear = Double(dw_car_year.Describe(ls_Str))
		IF NOT ( isNull(ldc_HwanYear) OR ldc_HwanYear = 0 ) THEN
			SELECT	FU_RTN_HWAN_YEAR(:ldc_HwanYear,100)
			INTO		:ldc_CareerYm
			FROM		DUAL;
		ELSE
			ldc_CareerYm = 0
		END IF
		dw_car_year.Object.com_career_ym[ll_CarRow] = ldc_CareerYm
	NEXT
	IF dw_car_year.Update() <> 1 THEN RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_DeptCode			//조직코드
String	ls_SosokDate		//소속일자
String	ls_JikJongDate		//직종일자
Integer	li_JikWiCode		//직위코드
String	ls_DutyCode			//직급코드
String	ls_DutyDate			//직급일자
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_JaeImYongStart	//재임용시작일자
String	ls_JaeImYongEnd	//재임용종료일자
Integer	li_JikMuCode		//직무코드
String	ls_JunimDate		//전임임용일
String	ls_JoGyoSuDate		//조교수임용일
String	ls_BuGyoSuDate		//부교수임용일
String	ls_GyoSuDate		//교수임용일

ls_DeptCode       = dw_update.Object.gwa            [al_GetRow]	//조직코드
ls_SosokDate      = dw_update.Object.sosok_date     [al_GetRow]	//소속일자
ls_JikJongDate    = dw_update.Object.jikjong_date   [al_GetRow]	//직종일자
li_JikWiCode      = dw_update.Object.jikwi_code     [al_GetRow]	//직위코드
ls_DutyCode       = dw_update.Object.duty_code      [al_GetRow]	//직급코드
ls_DutyDate       = dw_update.Object.duty_date      [al_GetRow]	//직급일자
li_ChangeOpt      = dw_update.Object.change_opt     [al_GetRow]	//발령코드
ls_ChangeDate     = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_JaeImYongStart = dw_update.Object.jaeimyong_start[al_GetRow]	//재임용시작일자
ls_JaeImYongEnd   = dw_update.Object.jaeimyong_end  [al_GetRow]	//재임용종료일자
li_JikMuCode      = dw_update.Object.jikmu_code     [al_GetRow]	//직무코드
ls_JunimDate      = dw_update.Object.junim_date     [al_GetRow]	//전임임용일
ls_JoGyoSuDate    = dw_update.Object.jogyosu_date   [al_GetRow]	//조교수임용일
ls_BuGyoSuDate    = dw_update.Object.bugyosu_date   [al_GetRow]	//부교수임용일
ls_GyoSuDate      = dw_update.Object.gyosu_date     [al_GetRow]	//교수임용일
//CHOOSE CASE ls_DutyCode
//	CASE '101' ; ls_GyoSuDate   = ls_ChangeDate	//교수임용일
//	CASE '102' ; ls_BuGyoSuDate = ls_ChangeDate	//부교수임용일
//	CASE '103' ; ls_JoGyoSuDate = ls_ChangeDate	//조교수임용일
//	CASE '104' ; ls_JunimDate   = ls_ChangeDate	//전임임용일
//END CHOOSE

UPDATE	INDB.HIN001M
SET		GWA             = :ls_DeptCode,
			SOSOK_DATE      = :ls_SosokDate,
			JIKJONG_DATE    = :ls_JikJongDate,
			JIKWI_CODE      = :li_JikWiCode,
			DUTY_CODE       = :ls_DutyCode,
			DUTY_DATE       = :ls_ChangeDate,
			CHANGE_OPT      = :li_ChangeOpt,
			CHANGE_DATE     = :ls_ChangeDate,
			JAEIMYONG_START = :ls_JaeImYongStart,
			JAEIMYONG_END   = :ls_JaeImYongEnd,
			JIKMU_CODE      = :li_JikMuCode,
			SAL_YEAR        = :ls_SalYear,
			SAL_CLASS       = :ls_SalClass,
			SAL_DATE        = :ls_SalDate,
			SAL_LEFTMONTH   = :li_SalLeftMonth,
			JUNIM_DATE      = :ls_JunimDate,
			JOGYOSU_DATE    = :ls_JoGyoSuDate,
			BUGYOSU_DATE    = :ls_BuGyoSuDate,
			GYOSU_DATE      = :ls_GyoSuDate,
			CAREER_YM       = :ldc_CareerYm,
			CAR_YEAR        = :ldc_CarYear,
			JOB_UID         = :is_Worker,
			JOB_ADD         = :is_IPAddr,
			JOB_DATE        = :idt_WorkDate
WHERE		MEMBER_NO       = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('특별승진 처리가 완료되었습니다.')
RETURN TRUE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_23(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_23
//	기 능 설 명: 승급인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
String	ls_DeptCode			//조직코드
String	ls_SosokDate		//소속일자
String	ls_JikJongDate		//직종일자
Integer	li_JikWiCode		//직위코드
String	ls_DutyCode			//직급코드
String	ls_DutyDate			//직급일자
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_JaeImYongStart	//재임용시작일자
String	ls_JaeImYongEnd	//재임용종료일자
Integer	li_JikMuCode		//직무코드
String	ls_SalYear			//호봉년도
String	ls_SalClass			//호봉코드
String	ls_SalDate			//호봉일자
Integer	li_SalLeftMonth	//호봉잔여월수
String	ls_JunimDate		//전임임용일
String	ls_JoGyoSuDate		//조교수임용일
String	ls_BuGyoSuDate		//부교수임용일
String	ls_GyoSuDate		//교수임용일
ls_MemberNo       = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_DeptCode       = dw_update.Object.gwa            [al_GetRow]	//조직코드
ls_SosokDate      = dw_update.Object.sosok_date     [al_GetRow]	//소속일자
ls_JikJongDate    = dw_update.Object.jikjong_date   [al_GetRow]	//직종일자
li_JikWiCode      = dw_update.Object.jikwi_code     [al_GetRow]	//직위코드
ls_DutyCode       = dw_update.Object.duty_code      [al_GetRow]	//직급코드
ls_DutyDate       = dw_update.Object.duty_date      [al_GetRow]	//직급일자
li_ChangeOpt      = dw_update.Object.change_opt     [al_GetRow]	//발령코드
ls_ChangeDate     = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_JaeImYongStart = dw_update.Object.jaeimyong_start[al_GetRow]	//재임용시작일자
ls_JaeImYongEnd   = dw_update.Object.jaeimyong_end  [al_GetRow]	//재임용종료일자
li_JikMuCode      = dw_update.Object.jikmu_code     [al_GetRow]	//직무코드
ls_SalYear        = dw_update.Object.sal_year       [al_GetRow]	//호봉년도
ls_SalClass       = dw_update.Object.sal_class      [al_GetRow]	//호봉코드
ls_SalDate        = dw_update.Object.sal_date       [al_GetRow]	//호봉일자
li_SalLeftMonth   = dw_update.Object.sal_leftmonth  [al_GetRow]	//호봉잔여월수
ls_JunimDate      = dw_update.Object.junim_date     [al_GetRow]	//전임임용일
ls_JoGyoSuDate    = dw_update.Object.jogyosu_date   [al_GetRow]	//조교수임용일
ls_BuGyoSuDate    = dw_update.Object.bugyosu_date   [al_GetRow]	//부교수임용일
ls_GyoSuDate      = dw_update.Object.gyosu_date     [al_GetRow]	//교수임용일
//CHOOSE CASE ls_DutyCode
//	CASE '101' ; ls_GyoSuDate   = ls_ChangeDate	//교수임용일
//	CASE '102' ; ls_BuGyoSuDate = ls_ChangeDate	//부교수임용일
//	CASE '103' ; ls_JoGyoSuDate = ls_ChangeDate	//조교수임용일
//	CASE '104' ; ls_JunimDate   = ls_ChangeDate	//전임임용일
//END CHOOSE

UPDATE	INDB.HIN001M
SET		GWA             = :ls_DeptCode,
			SOSOK_DATE      = :ls_SosokDate,
			JIKJONG_DATE    = :ls_JikJongDate,
			JIKWI_CODE      = :li_JikWiCode,
			DUTY_CODE       = :ls_DutyCode,
			DUTY_DATE       = :ls_DutyDate,
			CHANGE_OPT      = :li_ChangeOpt,
			CHANGE_DATE     = :ls_ChangeDate,
			JAEIMYONG_START = :ls_JaeImYongStart,
			JAEIMYONG_END   = :ls_JaeImYongEnd,
			JIKMU_CODE      = :li_JikMuCode,
			SAL_YEAR        = :ls_SalYear,
			SAL_CLASS       = :ls_SalClass,
			SAL_DATE        = :ls_SalDate,
			SAL_LEFTMONTH   = :li_SalLeftMonth,
			JOB_UID         = :is_Worker,
			JOB_ADD         = :is_IPAddr,
			JOB_DATE        = :idt_WorkDate
WHERE		MEMBER_NO       = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('승급 처리가 완료되었습니다.')
RETURN TRUE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_31(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_31
//	기 능 설 명: 재임용인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
String	ls_DeptCode			//조직코드
String	ls_SosokDate		//소속일자
String	ls_JikJongDate		//직종일자
Integer	li_JikWiCode		//직위코드
String	ls_DutyCode			//직급코드
String	ls_DutyDate			//직급일자
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_JaeImYongStart	//재임용시작일자
String	ls_JaeImYongEnd	//재임용종료일자
Integer	li_JikMuCode		//직무코드
String	ls_SalYear			//호봉년도
String	ls_SalClass			//호봉코드
String	ls_SalDate			//호봉일자
Integer	li_SalLeftMonth	//호봉잔여월수
ls_MemberNo       = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_DeptCode       = dw_update.Object.gwa            [al_GetRow]	//조직코드
ls_SosokDate      = dw_update.Object.sosok_date     [al_GetRow]	//소속일자
ls_JikJongDate    = dw_update.Object.jikjong_date   [al_GetRow]	//직종일자
li_JikWiCode      = dw_update.Object.jikwi_code     [al_GetRow]	//직위코드
ls_DutyCode       = dw_update.Object.duty_code      [al_GetRow]	//직급코드
ls_DutyDate       = dw_update.Object.duty_date      [al_GetRow]	//직급일자
li_ChangeOpt      = dw_update.Object.change_opt     [al_GetRow]	//발령코드
ls_ChangeDate     = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_JaeImYongStart = dw_update.Object.jaeimyong_start[al_GetRow]	//재임용시작일자
ls_JaeImYongEnd   = dw_update.Object.jaeimyong_end  [al_GetRow]	//재임용종료일자
li_JikMuCode      = dw_update.Object.jikmu_code     [al_GetRow]	//직무코드
ls_SalYear        = dw_update.Object.sal_year       [al_GetRow]	//호봉년도
ls_SalClass       = dw_update.Object.sal_class      [al_GetRow]	//호봉코드
ls_SalDate        = dw_update.Object.sal_date       [al_GetRow]	//호봉일자
li_SalLeftMonth   = dw_update.Object.sal_leftmonth  [al_GetRow]	//호봉잔여월수

UPDATE	INDB.HIN001M
SET		GWA             = :ls_DeptCode,
			SOSOK_DATE      = :ls_SosokDate,
			JIKJONG_DATE    = :ls_JikJongDate,
			JIKWI_CODE      = :li_JikWiCode,
			DUTY_CODE       = :ls_DutyCode,
			DUTY_DATE       = :ls_DutyDate,
			CHANGE_OPT      = :li_ChangeOpt,
			CHANGE_DATE     = :ls_ChangeDate,
			JAEIMYONG_START = :ls_JaeImYongStart,
			JAEIMYONG_END   = :ls_JaeImYongEnd,
			JIKMU_CODE      = :li_JikMuCode,
			SAL_YEAR        = :ls_SalYear,
			SAL_CLASS       = :ls_SalClass,
			SAL_DATE        = :ls_SalDate,
			SAL_LEFTMONTH   = :li_SalLeftMonth,
			JOB_UID         = :is_Worker,
			JOB_ADD         = :is_IPAddr,
			JOB_DATE        = :idt_WorkDate
WHERE		MEMBER_NO       = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('재임용 처리가 완료되었습니다.')
RETURN TRUE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_41(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_41
//	기 능 설 명: 전보(보직변경)인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
String	ls_DeptCode			//조직코드
String	ls_SosokDate		//소속일자
String	ls_JikJongDate		//직종일자
Integer	li_JikWiCode		//직위코드
String	ls_DutyCode			//직급코드
String	ls_DutyDate			//직급일자
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_JaeImYongStart	//재임용시작일자
String	ls_JaeImYongEnd	//재임용종료일자
Integer	li_JikMuCode		//직무코드
String	ls_SalYear			//호봉년도
String	ls_SalClass			//호봉코드
String	ls_SalDate			//호봉일자
Integer	li_SalLeftMonth	//호봉잔여월수
ls_MemberNo       = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_DeptCode       = dw_update.Object.gwa            [al_GetRow]	//조직코드
ls_SosokDate      = dw_update.Object.sosok_date     [al_GetRow]	//소속일자
ls_JikJongDate    = dw_update.Object.jikjong_date   [al_GetRow]	//직종일자
li_JikWiCode      = dw_update.Object.jikwi_code     [al_GetRow]	//직위코드
ls_DutyCode       = dw_update.Object.duty_code      [al_GetRow]	//직급코드
ls_DutyDate       = dw_update.Object.duty_date      [al_GetRow]	//직급일자
li_ChangeOpt      = dw_update.Object.change_opt     [al_GetRow]	//발령코드
ls_ChangeDate     = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_JaeImYongStart = dw_update.Object.jaeimyong_start[al_GetRow]	//재임용시작일자
ls_JaeImYongEnd   = dw_update.Object.jaeimyong_end  [al_GetRow]	//재임용종료일자
li_JikMuCode      = dw_update.Object.jikmu_code     [al_GetRow]	//직무코드
ls_SalYear        = dw_update.Object.sal_year       [al_GetRow]	//호봉년도
ls_SalClass       = dw_update.Object.sal_class      [al_GetRow]	//호봉코드
ls_SalDate        = dw_update.Object.sal_date       [al_GetRow]	//호봉일자
li_SalLeftMonth   = dw_update.Object.sal_leftmonth  [al_GetRow]	//호봉잔여월수

UPDATE	INDB.HIN001M
SET		GWA             = :ls_DeptCode,
			SOSOK_DATE      = :ls_SosokDate,
			JIKJONG_DATE    = :ls_JikJongDate,
			JIKWI_CODE      = :li_JikWiCode,
			DUTY_CODE       = :ls_DutyCode,
			DUTY_DATE       = :ls_DutyDate,
			CHANGE_OPT      = :li_ChangeOpt,
			CHANGE_DATE     = :ls_ChangeDate,
			JAEIMYONG_START = :ls_JaeImYongStart,
			JAEIMYONG_END   = :ls_JaeImYongEnd,
			JIKMU_CODE      = :li_JikMuCode,
			SAL_YEAR        = :ls_SalYear,
			SAL_CLASS       = :ls_SalClass,
			SAL_DATE        = :ls_SalDate,
			SAL_LEFTMONTH   = :li_SalLeftMonth,
			JOB_UID         = :is_Worker,
			JOB_ADD         = :is_IPAddr,
			JOB_DATE        = :idt_WorkDate
WHERE		MEMBER_NO       = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('전보 처리가 완료되었습니다.')
RETURN TRUE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_42(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_42
//	기 능 설 명: 전출,입인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
String	ls_DeptCode			//조직코드
String	ls_SosokDate		//소속일자
String	ls_JikJongDate		//직종일자
Integer	li_JikWiCode		//직위코드
String	ls_DutyCode			//직급코드
String	ls_DutyDate			//직급일자
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_JaeImYongStart	//재임용시작일자
String	ls_JaeImYongEnd	//재임용종료일자
Integer	li_JikMuCode		//직무코드
String	ls_SalYear			//호봉년도
String	ls_SalClass			//호봉코드
String	ls_SalDate			//호봉일자
Integer	li_SalLeftMonth	//호봉잔여월수
ls_MemberNo       = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_DeptCode       = dw_update.Object.gwa            [al_GetRow]	//조직코드
ls_SosokDate      = dw_update.Object.sosok_date     [al_GetRow]	//소속일자
ls_JikJongDate    = dw_update.Object.jikjong_date   [al_GetRow]	//직종일자
li_JikWiCode      = dw_update.Object.jikwi_code     [al_GetRow]	//직위코드
ls_DutyCode       = dw_update.Object.duty_code      [al_GetRow]	//직급코드
ls_DutyDate       = dw_update.Object.duty_date      [al_GetRow]	//직급일자
li_ChangeOpt      = dw_update.Object.change_opt     [al_GetRow]	//발령코드
ls_ChangeDate     = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_JaeImYongStart = dw_update.Object.jaeimyong_start[al_GetRow]	//재임용시작일자
ls_JaeImYongEnd   = dw_update.Object.jaeimyong_end  [al_GetRow]	//재임용종료일자
li_JikMuCode      = dw_update.Object.jikmu_code     [al_GetRow]	//직무코드
ls_SalYear        = dw_update.Object.sal_year       [al_GetRow]	//호봉년도
ls_SalClass       = dw_update.Object.sal_class      [al_GetRow]	//호봉코드
ls_SalDate        = dw_update.Object.sal_date       [al_GetRow]	//호봉일자
li_SalLeftMonth   = dw_update.Object.sal_leftmonth  [al_GetRow]	//호봉잔여월수

UPDATE	INDB.HIN001M
SET		GWA             = :ls_DeptCode,
			SOSOK_DATE      = :ls_SosokDate,
			JIKJONG_DATE    = :ls_JikJongDate,
			JIKWI_CODE      = :li_JikWiCode,
			DUTY_CODE       = :ls_DutyCode,
			DUTY_DATE       = :ls_DutyDate,
			CHANGE_OPT      = :li_ChangeOpt,
			CHANGE_DATE     = :ls_ChangeDate,
			JAEIMYONG_START = :ls_JaeImYongStart,
			JAEIMYONG_END   = :ls_JaeImYongEnd,
			JIKMU_CODE      = :li_JikMuCode,
			SAL_YEAR        = :ls_SalYear,
			SAL_CLASS       = :ls_SalClass,
			SAL_DATE        = :ls_SalDate,
			SAL_LEFTMONTH   = :li_SalLeftMonth,
			JOB_UID         = :is_Worker,
			JOB_ADD         = :is_IPAddr,
			JOB_DATE        = :idt_WorkDate
WHERE		MEMBER_NO       = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('전출,입 처리가 완료되었습니다.')
RETURN TRUE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save_51;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_51
//	기 능 설 명: 직종변경인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save_61;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_61
//	기 능 설 명: 파견인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save_62;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_62
//	기 능 설 명: 파견복귀인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_63(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_63
//	기 능 설 명: 해외연수인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 해외연수사항(HIN015H), 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 해외연수사항(HIN015H)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('해외연수사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
String	ls_ChangeDate		//최종발령일자
String	ls_FromDate			//시작일자
String	ls_ToDate			//종료일자
String	ls_Gubun				//국내외구분
Integer	li_MasterOpt		//연수구분
String	ls_Purpose			//목적
Integer	li_NationCode		//국가코드
String	ls_OrganName		//기관명
ls_MemberNo   = dw_update.Object.member_no    [al_GetRow]	//개인번호
ls_ChangeDate = dw_update.Object.from_date    [al_GetRow]	//최종발령일자
ls_FromDate   = ls_ChangeDate											//시작일자
ls_ToDate     = dw_update.Object.to_date      [al_GetRow]	//종료일자
ls_Gubun      = '2'														//국내외구분(1:국내,2:국외)
li_MasterOpt  = 3															//연수구분(3:학교계획에 따른 연수)
ls_Purpose    = dw_update.Object.change_reason[al_GetRow]	//목적
li_NationCode = 1															//국가코드
ls_OrganName  = ''														//기관명

INSERT	INTO	INDB.HIN015H
VALUES	(	:ls_MemberNo,
				:ls_FromDate,
				:ls_ToDate,
				:ls_Gubun,
				:li_MasterOpt,
				:ls_Purpose,
				:li_NationCode,
				:ls_OrganName,
				:is_Worker,
				:idt_WorkDate,
				:is_IPAddr,
				:is_Worker,
				:is_IPAddr,
				:idt_WorkDate	);
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('해외연수사항 변동시 오류가 발생하였습니다.')
	MessageBox('확인','해외연수사항 변동시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
li_JaeJikOpt  = 5														//재직구분(5:해외연수)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('해외연수 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_64(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_64
//	기 능 설 명: 해외연수복귀인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
ls_MemberNo   = dw_update.Object.member_no    [al_GetRow]	//개인번호
li_JaeJikOpt  = 1															//재직구분(1:재직)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드
ls_ChangeDate = dw_update.Object.from_date    [al_GetRow]	//최종발령일자

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('해외연수복귀 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_65(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_65
//	기 능 설 명: 연구년인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 해외연수사항(HIN015H), 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 해외연수사항(HIN015H)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('해외연수사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
String	ls_ChangeDate		//최종발령일자
String	ls_FromDate			//시작일자
String	ls_ToDate			//종료일자
String	ls_Gubun				//국내외구분
Integer	li_MasterOpt		//연수구분
String	ls_Purpose			//목적
Integer	li_NationCode		//국가코드
String	ls_OrganName		//기관명
ls_MemberNo   = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_ChangeDate = dw_update.Object.from_date      [al_GetRow]	//최종발령일자
ls_FromDate   = ls_ChangeDate											//시작일자
ls_ToDate     = dw_update.Object.to_date        [al_GetRow]	//종료일자
ls_Gubun      = '1'														//국내외구분(1:국내,2:국외)
li_MasterOpt  = 0															//연수구분(0:없음)
ls_Purpose    = dw_update.Object.change_reason  [al_GetRow]	//목적
li_NationCode = 1															//국가코드
ls_OrganName  = ''														//기관명

INSERT	INTO	INDB.HIN015H
VALUES	(	:ls_MemberNo,
				:ls_FromDate,
				:ls_ToDate,
				:ls_Gubun,
				:li_MasterOpt,
				:ls_Purpose,
				:li_NationCode,
				:ls_OrganName,
				:is_Worker,
				:idt_WorkDate,
				:is_IPAddr,
				:is_Worker,
				:is_IPAddr,
				:idt_WorkDate	);
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('해외연수사항 변동시 오류가 발생하였습니다.')
	MessageBox('확인','해외연수사항 변동시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
li_JaeJikOpt  = 6														//재직구분(6:연수년)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('연구년 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_66(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_66
//	기 능 설 명: 연구년복귀인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
ls_MemberNo   = dw_update.Object.member_no    [al_GetRow]	//개인번호
li_JaeJikOpt  = 1															//재직구분(1:재직)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드
ls_ChangeDate = dw_update.Object.from_date    [al_GetRow]	//최종발령일자

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('연구년복귀 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_71(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_71
//	기 능 설 명: 휴직인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
Integer	li_JaeJikOpt		//재직구분
String	ls_DeptCode			//조직코드
String	ls_SosokDate		//소속일자
String	ls_JikJongDate		//직종일자
Integer	li_JikWiCode		//직위코드
String	ls_DutyCode			//직급코드
String	ls_DutyDate			//직급일자
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_JaeImYongStart	//재임용시작일자
String	ls_JaeImYongEnd	//재임용종료일자
Integer	li_JikMuCode		//직무코드
String	ls_SalYear			//호봉년도
String	ls_SalClass			//호봉코드
String	ls_SalDate			//호봉일자
Integer	li_SalLeftMonth	//호봉잔여월수
ls_MemberNo       = dw_update.Object.member_no      [al_GetRow]	//개인번호
li_JaeJikOpt      = 4														//재직구분(4:휴직)
ls_DeptCode       = dw_update.Object.gwa            [al_GetRow]	//조직코드
ls_SosokDate      = dw_update.Object.sosok_date     [al_GetRow]	//소속일자
ls_JikJongDate    = dw_update.Object.jikjong_date   [al_GetRow]	//직종일자
li_JikWiCode      = dw_update.Object.jikwi_code     [al_GetRow]	//직위코드
ls_DutyCode       = dw_update.Object.duty_code      [al_GetRow]	//직급코드
ls_DutyDate       = dw_update.Object.duty_date      [al_GetRow]	//직급일자
li_ChangeOpt      = dw_update.Object.change_opt     [al_GetRow]	//발령코드
ls_ChangeDate     = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_JaeImYongStart = dw_update.Object.jaeimyong_start[al_GetRow]	//재임용시작일자
ls_JaeImYongEnd   = dw_update.Object.jaeimyong_end  [al_GetRow]	//재임용종료일자
li_JikMuCode      = dw_update.Object.jikmu_code     [al_GetRow]	//직무코드
ls_SalYear        = dw_update.Object.sal_year       [al_GetRow]	//호봉년도
ls_SalClass       = dw_update.Object.sal_class      [al_GetRow]	//호봉코드
ls_SalDate        = dw_update.Object.sal_date       [al_GetRow]	//호봉일자
li_SalLeftMonth   = dw_update.Object.sal_leftmonth  [al_GetRow]	//호봉잔여월수

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT      = :li_JaeJikOpt,
			GWA             = :ls_DeptCode,
			SOSOK_DATE      = :ls_SosokDate,
			JIKJONG_DATE    = :ls_JikJongDate,
			JIKWI_CODE      = :li_JikWiCode,
			DUTY_CODE       = :ls_DutyCode,
			DUTY_DATE       = :ls_DutyDate,
			CHANGE_OPT      = :li_ChangeOpt,
			CHANGE_DATE     = :ls_ChangeDate,
			JAEIMYONG_START = :ls_JaeImYongStart,
			JAEIMYONG_END   = :ls_JaeImYongEnd,
			JIKMU_CODE      = :li_JikMuCode,
			SAL_YEAR        = :ls_SalYear,
			SAL_CLASS       = :ls_SalClass,
			SAL_DATE        = :ls_SalDate,
			SAL_LEFTMONTH   = :li_SalLeftMonth,
			JOB_UID         = :is_Worker,
			JOB_ADD         = :is_IPAddr,
			JOB_DATE        = :idt_WorkDate
WHERE		MEMBER_NO       = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('휴직 처리가 완료되었습니다.')
RETURN TRUE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_72(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_72
//	기 능 설 명: 복직인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M)처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_RetireDate		//퇴직일자
ls_MemberNo   = dw_update.Object.member_no    [al_GetRow]	//개인번호
li_JaeJikOpt  = 1															//재직구분(1:재직)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드
ls_ChangeDate = dw_update.Object.from_date    [al_GetRow]	//최종발령일자
ls_RetireDate = dw_update.Object.retire_date  [al_GetRow]	//퇴직일자

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			RETIRE_DATE = :ls_RetireDate,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('복직 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_81(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_81
//	기 능 설 명: 의원면직인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 포상·징계사항(HIN016H), 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 포상·징계사항(HIN016H)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('포상·징계사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
String	ls_ChangeDate		//최종발령일자
Integer	li_PrizeCode		//상벌코드
String	ls_FromDate			//시작일자
String	ls_ToDate			//종료일자
String	ls_Content			//상벌내용
String	ls_OrganName		//기관명
ls_MemberNo   = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_ChangeDate = dw_update.Object.from_date      [al_GetRow]	//최종발령일자
ls_FromDate   = ls_ChangeDate											//시작일자
ls_ToDate     = dw_update.Object.to_date        [al_GetRow]	//종료일자
li_PrizeCode  = 5008														//상벌코드(5008:파면)
ls_Content    = dw_update.Object.change_reason  [al_GetRow]	//상벌내용
ls_OrganName  = ''														//기관명

INSERT	INTO	INDB.HIN016H
VALUES	(	:ls_MemberNo,
				:li_PrizeCode,
				:ls_FromDate,
				:ls_ToDate,
				:ls_Content,
				:ls_OrganName,
				:is_Worker,
				:idt_WorkDate,
				:is_IPAddr,
				:is_Worker,
				:is_IPAddr,
				:idt_WorkDate	);
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('포상·징계사항 변동시 오류가 발생하였습니다.')
	MessageBox('확인','포상·징계사항 변동시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
String	ls_RetireDate		//퇴직일자
li_JaeJikOpt  = 3															//재직구분(3:퇴직)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드
ls_RetireDate = dw_update.Object.retire_date  [al_GetRow]	//퇴직일자

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			RETIRE_DATE = :ls_RetireDate,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('의원면직 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_82(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_82
//	기 능 설 명: 직권면직인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 포상·징계사항(HIN016H), 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 포상·징계사항(HIN016H)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('포상·징계사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
String	ls_ChangeDate		//최종발령일자
Integer	li_PrizeCode		//상벌코드
String	ls_FromDate			//시작일자
String	ls_ToDate			//종료일자
String	ls_Content			//상벌내용
String	ls_OrganName		//기관명
ls_MemberNo   = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_ChangeDate = dw_update.Object.from_date      [al_GetRow]	//최종발령일자
ls_FromDate   = ls_ChangeDate											//시작일자
ls_ToDate     = dw_update.Object.to_date        [al_GetRow]	//종료일자
li_PrizeCode  = 5008														//상벌코드(5008:파면)
ls_Content    = dw_update.Object.change_reason  [al_GetRow]	//상벌내용
ls_OrganName  = ''														//기관명

INSERT	INTO	INDB.HIN016H
VALUES	(	:ls_MemberNo,
				:li_PrizeCode,
				:ls_FromDate,
				:ls_ToDate,
				:ls_Content,
				:ls_OrganName,
				:is_Worker,
				:idt_WorkDate,
				:is_IPAddr,
				:is_Worker,
				:is_IPAddr,
				:idt_WorkDate	);
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('포상·징계사항 변동시 오류가 발생하였습니다.')
	MessageBox('확인','포상·징계사항 변동시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
String	ls_RetireDate		//퇴직일자
li_JaeJikOpt  = 3															//재직구분(3:퇴직)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드
ls_RetireDate = dw_update.Object.retire_date  [al_GetRow]	//퇴직일자

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			RETIRE_DATE = :ls_RetireDate,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('직권면직 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_83(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_83
//	기 능 설 명: 당연퇴직인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 경력사항(HIN009H), 인사기본정보(HIN001M)처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 경력사항(HIN009H)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('경력사항 변동처리 중입니다...')
//인사기본 TABLE LAYOUT================================================================
String		ls_MemberNo			//개인번호
String		ls_SalYear			//호봉년도
String		ls_SalClass			//호봉코드
String		ls_SalDate			//호봉일자
Integer		li_SalLeftMonth	//호봉잔여월수
String		ls_FrDate			//발령시작일자
String		ls_ToDate			//발령종료일자
Decimal{2}	ldc_CareerYm		//총경력인정년수
//경력사항 TABLE LAYOUT================================================================
Integer		li_CareerSeq		//경력사항순번
Integer		li_CareerOpt		//경력구분
Integer		li_ProcesOpt		//처리구분(1:군경력,2,학력경력)
Integer		li_CarrerGbn 		//내외구분
String		ls_CarrerCon		//자격내용
Decimal{2}	ldc_WorkYear		//근무년월
Decimal{2}	ldc_DecisionYear	//인정년월
Decimal{2}	ldc_CarYear			//경력누계

//인사변동사항 TABLE LAYOUT============================================================
Integer		li_SingOpt			//결재구분
//기타=================================================================================
String		ls_Null				//
Integer		li_Null				//
SetNull(ls_Null)
SetNull(li_Null)
////////////////////////////////////////////////////////////////////////////////////
// 1.1 경력사항(HIN009H)변경처리
////////////////////////////////////////////////////////////////////////////////////
ls_MemberNo     = dw_update.Object.member_no      [al_GetRow]	//개인번호
ls_ToDate       = dw_update.Object.from_date      [al_GetRow]	//발령시작일자
ls_SalYear      = dw_update.Object.sal_year       [al_GetRow]	//호봉년도
ls_SalClass     = dw_update.Object.sal_class      [al_GetRow]	//호봉코드
ls_SalDate      = dw_update.Object.sal_date       [al_GetRow]	//호봉일자
li_SalLeftMonth = dw_update.Object.sal_leftmonth  [al_GetRow]	//호봉잔여월수
li_CareerOpt    = 11														//승진100% 경력인정
li_ProcesOpt    = 9														//처리구분(기타경력)
li_CarrerGbn    = 1														//내외구분(1:국내,2:국외)
ls_CarrerCon    = '퇴직시경력'										//자격내용
li_SingOpt      = 3														//결재구분(이사장결재)
ls_ToDate = String(RelativeDate(Date(String(ls_ToDate,'@@@@/@@/@@')), - 1),'YYYYMMDD')
////////////////////////////////////////////////////////////////////////////////////
// 1.2 경력사항 추가시 시작일자와 종료일자를 처리방법
//				경력사항에 자료가 한건도 없는 경우,
//				승진경력이 한건도 없는 경우
//					시작일자 = 학원임용일자
//					종료일자 = 발령일자
//				승진경력이 있는 경우
//					시작일자 = 이전승진경력의 종료일자
//					종료일자 = 발령일자
////////////////////////////////////////////////////////////////////////////////////
SELECT	DECODE(SIGN(NVL(B.COM_CNT,0) - 1),
				-1,NVL(C.HAKWONHIRE_DATE,:ls_ToDate),
				DECODE(SIGN(NVL(D.COM_CNT,0) - 1),
					-1,NVL(C.HAKWONHIRE_DATE,:ls_ToDate),
					TO_CHAR(TO_DATE(B.COM_TO_DATE) + 1,'YYYYMMDD') ))
INTO		:ls_FrDate
FROM		INDB.HIN001M A,
			/************************************************************************/
			/* 경력사항건수 SELECT																	*/
			/************************************************************************/
			(	SELECT	A.MEMBER_NO,
							MAX(A.TO_DATE)	COM_TO_DATE,
							COUNT(*)			COM_CNT
				FROM		INDB.HIN009H A
				WHERE		A.MEMBER_NO  = :ls_MemberNo
				AND		A.TO_DATE    < :ls_ToDate
				AND		A.PROCES_OPT = 3
				GROUP	BY	A.MEMBER_NO ) B,
			/************************************************************************/
			/*	인사기본에 학원임용일 SELECT														*/
			/************************************************************************/
			(	SELECT	A.MEMBER_NO,
							A.HAKWONHIRE_DATE
				FROM		INDB.HIN001M A
				WHERE		A.MEMBER_NO = :ls_MemberNo ) C,
			/************************************************************************/
			/*	인사변동에 정기승진,특별승진 건수 SELECT										*/
			/************************************************************************/
			(	SELECT	A.MEMBER_NO,
							MAX(A.TO_DATE)	COM_TO_DATE,
							COUNT(*)			COM_CNT
				FROM		INDB.HIN007H A
				WHERE		A.MEMBER_NO  = :ls_MemberNo
				AND		A.CHANGE_OPT IN (21,22)
				GROUP	BY	A.MEMBER_NO ) D
WHERE		A.MEMBER_NO  = B.MEMBER_NO(+)
AND		A.MEMBER_NO  = C.MEMBER_NO(+)
AND		A.MEMBER_NO  = D.MEMBER_NO(+)
AND		A.MEMBER_NO  = :ls_MemberNo;
IF ls_FrDate < ls_ToDate AND &
	NOT isNull(ls_FrDate) AND &
	LEN(TRIM(ls_FrDate)) > 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 1.3 경력사항에 퇴직경력사항 삭제처리
	/////////////////////////////////////////////////////////////////////////////////
	wf_SetMsg('경력사항에 퇴직경력사항 삭제처리 중 입니다...')
	DELETE	FROM	INDB.HIN009H
	WHERE		MEMBER_NO  = :ls_MemberNo
	AND		TO_DATE    = :ls_ToDate
	AND		PROCES_OPT = :li_ProcesOpt;
	/////////////////////////////////////////////////////////////////////////////////
	// 1.4 경력사항 순번생성
	/////////////////////////////////////////////////////////////////////////////////
	wf_SetMsg('퇴직경력사항을 경력사항으로 처리 중 입니다...')
	SELECT	NVL(MAX(A.CAREER_SEQ),0)+1
	INTO		:li_CareerSeq
	FROM		INDB.HIN009H A
	WHERE		A.MEMBER_NO = :ls_MemberNo;
	CHOOSE CASE SQLCA.SQLCODE
		CASE 0
		CASE 100
			li_CareerSeq = 1
		CASE ELSE
			MessageBox('오류',&
							'[퇴직]경력사항 순번 생성시 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN FALSE
	END CHOOSE
	/////////////////////////////////////////////////////////////////////////////////
	// 1.5 경력사항 추가
	/////////////////////////////////////////////////////////////////////////////////
	SELECT	FU_RTN_YEAR_MONTH(:ls_FrDate,:ls_ToDate)
	INTO		:ldc_WorkYear
	FROM		DUAL;
	INSERT	INTO	INDB.HIN009H
	VALUES	(		:ls_MemberNo,
						:li_CareerSeq,
						:li_CareerOpt,
						:li_ProcesOpt,
						:ls_FrDate,
						:ls_ToDate,
						:li_CarrerGbn,
						:ls_CarrerCon,
						:ls_Null,:ls_Null,:ls_Null,:ls_Null,:ls_Null,
						:ldc_WorkYear,:ldc_WorkYear,100,:ldc_WorkYear,:li_Null,
						:ls_SalYear,:ls_SalClass,:ls_SalDate,:li_SalLeftMonth,
						:li_SingOpt,
						:is_Worker,
						:idt_WorkDate,
						:is_IPAddr,
						:is_Worker,
						:is_IPAddr,
						:idt_WorkDate	);
	CHOOSE CASE SQLCA.SQLCODE
		CASE 0
		CASE 100
		CASE ELSE
			MessageBox('오류',&
							'[퇴직]경력사항 추가시 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN FALSE
	END CHOOSE
	/////////////////////////////////////////////////////////////////////////////////
	// 1.6 경력사항에 경력누계 UPDATE 처리
	//		인사기본마스터에 총경력년월 UPDATE 처리
	/////////////////////////////////////////////////////////////////////////////////
	Long			ll_CarRow
	Long			ll_CarRowCnt
	Decimal{2}	ldc_HwanYear
	String		ls_Str
	dw_car_year.Reset()
	ll_CarRowCnt = dw_car_year.Retrieve(ls_MemberNo)
	FOR ll_CarRow = 1 TO ll_CarRowCnt
		//////////////////////////////////////////////////////////////////////////////
		// 1.6.1 총경력년월누계
		//////////////////////////////////////////////////////////////////////////////
		ls_Str = "Evaluate('cumulativeSum(hwan_year for all)',"+&
					String(ll_CarRow)+")"
		ldc_HwanYear = Double(dw_car_year.Describe(ls_Str))
		IF isNull(ldc_HwanYear) OR ldc_HwanYear = 0 THEN CONTINUE
		SELECT	FU_RTN_HWAN_YEAR(:ldc_HwanYear,100)
		INTO		:ldc_CarYear
		FROM		DUAL;
		dw_car_year.Object.car_year[ll_CarRow] = ldc_CarYear
		//////////////////////////////////////////////////////////////////////////////
		// 1.6.2 근속인정년월누계
		//////////////////////////////////////////////////////////////////////////////
		ls_Str = "Evaluate('cumulativeSum(if(career_gbn = 9,hwan_year,0) for all)',"+&
					String(ll_CarRow)+")"
		ldc_HwanYear = Double(dw_car_year.Describe(ls_Str))
		IF NOT ( isNull(ldc_HwanYear) OR ldc_HwanYear = 0 ) THEN
			SELECT	FU_RTN_HWAN_YEAR(:ldc_HwanYear,100)
			INTO		:ldc_CareerYm
			FROM		DUAL;
		ELSE
			ldc_CareerYm = 0
		END IF
		dw_car_year.Object.com_career_ym[ll_CarRow] = ldc_CareerYm
	NEXT
	IF dw_car_year.Update() <> 1 THEN RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_RetireDate		//퇴직일자
li_JaeJikOpt  = 3															//재직구분(3:퇴직)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드
ls_ChangeDate = dw_update.Object.from_date    [al_GetRow]	//최종발령일자
ls_RetireDate = dw_update.Object.retire_date  [al_GetRow]	//퇴직일자

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			RETIRE_DATE = :ls_RetireDate,
			CAREER_YM   = :ldc_CareerYm,
			CAR_YEAR    = :ldc_CarYear,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('당연퇴직 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_84(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_84
//	기 능 설 명: 정년퇴직인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M)처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
String	ls_MemberNo			//개인번호
Integer	li_JaeJikOpt		//재직구분
Integer	li_ChangeOpt		//발령코드
String	ls_ChangeDate		//최종발령일자
String	ls_RetireDate		//퇴직일자
ls_MemberNo   = dw_update.Object.member_no    [al_GetRow]	//개인번호
li_JaeJikOpt  = 3															//재직구분(3:퇴직)
li_ChangeOpt  = dw_update.Object.change_opt   [al_GetRow]	//발령코드
ls_ChangeDate = dw_update.Object.from_date    [al_GetRow]	//최종발령일자
ls_RetireDate = dw_update.Object.retire_date  [al_GetRow]	//퇴직일자

UPDATE	INDB.HIN001M
SET		JAEJIK_OPT  = :li_JaeJikOpt,
			CHANGE_OPT  = :li_ChangeOpt,
			CHANGE_DATE = :ls_ChangeDate,
			RETIRE_DATE = :ls_RetireDate,
			JOB_UID     = :is_Worker,
			JOB_ADD     = :is_IPAddr,
			JOB_DATE    = :idt_WorkDate
WHERE		MEMBER_NO   = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('정년퇴직 처리가 완료되었습니다.')
RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_chk_sal_confirm(long al_getrow, decimal adc_careerym, ref string as_salclass, ref string as_saldate, ref integer ai_salleftmonth);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_chk_sal_confirm
//	기 능 설 명: 호봉획정처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 호봉획정처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('호봉획정처리 중입니다...')
///////////////////////////////////////////////////////////////////////////////////////
// 1. 인사변동사항 GET
///////////////////////////////////////////////////////////////////////////////////////
String		ls_MemberNo			//개인번호
String		ls_JikjongCode		//직종코드
String		ls_DutyCode			//직급코드
String		ls_SalYear			//호봉년도
Integer		li_SalGraduate		//졸업구분
String		ls_HakWonHireDate	//학원최임용일자

ls_MemberNo    = dw_update.Object.member_no[al_GetRow]	//개인번호
ls_DutyCode    = dw_update.Object.duty_code[al_GetRow]	//직급코드
ls_SalYear     = dw_update.Object.sal_year [al_GetRow]	//호봉년도
ls_JikjongCode = MID(ls_DutyCode,1,1)							//직종코드
///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본사항 SELECT
///////////////////////////////////////////////////////////////////////////////////////
Integer	li_AnnOpt				//연봉구분
SELECT	A.ANN_OPT,
			A.SAL_GRADUATE,
			A.HAKWONHIRE_DATE
INTO		:li_AnnOpt,
			:li_SalGraduate,
			:ls_HakWonHireDate
FROM		INDB.HIN001M A
WHERE		A.MEMBER_NO  = :ls_MemberNo
AND		A.JAEJIK_OPT = 1;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox('오류',&
					'[호봉획정]인사기본자료 조회시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF
IF li_AnnOpt = 2 THEN RETURN TRUE
///////////////////////////////////////////////////////////////////////////////////////
// 3. 호봉산정일자 처리
///////////////////////////////////////////////////////////////////////////////////////
as_SalDate = f_today()
CHOOSE CASE Integer(MID(as_SalDate,5,4))
	CASE IS <  401 ; as_SalDate = MID(as_SalDate,1,4)+'0101'
	CASE IS <  701 ; as_SalDate = MID(as_SalDate,1,4)+'0401'
	CASE IS < 1001 ; as_SalDate = MID(as_SalDate,1,4)+'0701'
	CASE ELSE      ; as_SalDate = MID(as_SalDate,1,4)+'1001'
END CHOOSE
///////////////////////////////////////////////////////////////////////////////////////
// 4. 직급에 해당되는 MAX호봉코드를 가지고 온다
///////////////////////////////////////////////////////////////////////////////////////
String		ls_MaxSalClass		//직급중 최상위 호봉
String		ls_Null
Integer		li_Null
SetNull(ls_Null)
SetNull(li_Null)
SELECT	MAX(A.SAL_CLASS)	COM_MAX_SAL_CLASS
INTO		:ls_MaxSalClass
FROM		INDB.HIN004M A
WHERE		A.SAL_YEAR              = :ls_SalYear
AND		SUBSTR(A.DUTY_CODE,1,1) LIKE :ls_JikJongCode||'%';
IF SQLCA.SQLCODE = -1 THEN
	MessageBox('오류',&
					'[호봉획정]직급별 MAX호봉 조회시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF
///////////////////////////////////////////////////////////////////////////////////////
// 5. 직급이 교원, 조교가 아니면 총경력인정년수로 호봉처리
///////////////////////////////////////////////////////////////////////////////////////
Long			ll_SalAmt
IF NOT( ls_JikJongCode = '1' OR ls_JikJongCode = '2') THEN
	as_SalClass = String(Truncate(adc_CareerYm,0),'000')
	IF isNull(adc_CareerYm) OR adc_CareerYm = 0 THEN
		as_SalClass = '001'
	ELSE
		IF UPPER(SQLCA.ServerName) = 'ORA9' THEN
			as_SalClass = String(Integer(as_SalClass) + 1,'000')
		END IF
	END IF
	
	IF as_SalClass > ls_MaxSalClass THEN as_SalClass = ls_MaxSalClass
	ai_SalLeftMonth = Integer((adc_CareerYm - Truncate(adc_CareerYm,0)) * 100)
	
//	MessageBox('as_SalClass',as_SalClass)
//	MessageBox('ai_SalLeftMonth',ai_SalLeftMonth)
//	MessageBox('as_SalDate',as_SalDate)

	RETURN TRUE
END IF
///////////////////////////////////////////////////////////////////////////////////////
// 6. 졸업구분 입력여부 확인
///////////////////////////////////////////////////////////////////////////////////////
IF isNull(li_SalGraduate) OR li_SalGraduate = 0 THEN
	BEEP(1)
	wf_SetMsg('졸업구분을 입력후 사용하시기 바랍니다.')
	RETURN FALSE
END IF
///////////////////////////////////////////////////////////////////////////////////////
// 7. 총경력년월 = 총경력인정년수 + (학원임영일 ~ 기준일자)
///////////////////////////////////////////////////////////////////////////////////////
Decimal{2}	ldc_SalClass		//총경력인정년월과 학원임용일에서 시스템일자까지의 합계
Integer		ll_Year				//가감년수
Integer		li_GivenSal			//기산호봉

SELECT	FLOOR(NVL(:adc_CareerYm,0) +
				FLOOR(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0) / 12)	+
					((MOD(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0),12) * 0.01)))	+
			FLOOR(((NVL(:adc_CareerYm,0) +
				FLOOR(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0) / 12)	+
					((MOD(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0),12) * 0.01))) -
			(FLOOR(NVL(:adc_CareerYm,0) +
						FLOOR(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0) / 12)	+
							((MOD(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0),12) * 
									0.01))))) * 100/12) +
			MOD(((NVL(:adc_CareerYm,0) +
				FLOOR(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0) / 12)	+
					((MOD(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0),12) * 0.01))) -
			(FLOOR(NVL(:adc_CareerYm,0) +
						FLOOR(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0) / 12)	+
							((MOD(TRUNC(MONTHS_BETWEEN(TO_DATE(:as_SalDate) + 1,:ls_HakWonHireDate),0),12) * 
									0.01))))) * 100,12) * 0.01,
			DECODE(:li_SalGraduate,1,A.PROF_YEAR,2,COLL_YEAR,3,EDU2_YEAR,4,TEA2_YEAR,5,UNIV_YEAR,TEA4_YEAR),
			NVL(A.GIVEN_SAL,0)
INTO		:ldc_SalClass,
			:ll_Year,
			:li_GivenSal
FROM		INDB.HIN018M A
WHERE		A.CAMP_CODE    = '1'
AND		A.JIKJONG_CODE = :ls_JikJongCode
AND		A.DUTY_CODE    = :ls_DutyCode;
IF SQLCA.SQLCODE <> 0 THEN
	RETURN TRUE
END IF
/////////////////////////////////////////////////////////////////////////////////
// 호봉처리
//		직급이 교원이고 호봉코드가 35을 넘으면 G01...로처리하고 G10보다크면 G10,
//				 조교이면 넘어가면 최상호봉으로 변경한다.
/////////////////////////////////////////////////////////////////////////////////
IF Truncate(ldc_SalClass,0) > 0 THEN ldc_SalClass += 1
as_SalClass = String(Truncate(ldc_SalClass,0),'000')
IF isNull(as_SalClass) OR as_SalClass = '000' THEN
	as_SalClass = '001'
ELSE
	as_SalClass = String(Truncate(ldc_SalClass - ll_Year + li_GivenSal,0),'000')
	IF UPPER(SQLCA.ServerName) = 'ORA9' THEN
		as_SalClass = String(Integer(as_SalClass) + 1,'000')
	END IF
END IF

IF ls_JikJongCode = '1' AND as_SalClass > '035' THEN
	as_SalClass = 'G' + String(Integer(as_SalClass) - 35,'00')
	IF as_SalClass > 'G10' THEN as_SalClass = 'G10'
ELSE
	IF as_SalClass > ls_MaxSalClass THEN as_SalClass = ls_MaxSalClass
END IF
ai_SalLeftMonth = Integer((ldc_SalClass - Truncate(ldc_SalClass,0)) * 100)

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_91(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_91
//	기 능 설 명: 호봉재획정인경우 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
RETURN THIS.TRIGGER EVENT ue_save_11(al_GetRow)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event type boolean ue_save_00(long al_getrow);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save_00
//	기 능 설 명: 미결처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 인사기본정보(HIN001M) 처리
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 미결자료 조회 처리
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt
String	ls_MemberNo			//개인번호
String	ls_ChangeDate		//발령시작일자
ls_MemberNo   = dw_update.Object.member_no[al_GetRow]	//개인번호
ls_ChangeDate = dw_update.Object.from_date[al_GetRow]	//발령시작일자
ll_RowCnt = dw_cancel.Retrieve(ls_MemberNo)
IF ll_RowCnt = 0 THEN
	f_set_message('미결처리할 자료가 없습니다', '', parentwin)
	RETURN TRUE
END IF
String	ls_Find
Long		ll_Find
ls_Find = "from_date = '" + ls_ChangeDate + "'"
ll_Find = dw_cancel.Find(ls_Find,1,ll_RowCnt)
IF ll_Find = 0 THEN RETURN FALSE

///////////////////////////////////////////////////////////////////////////////////////
// 2. 경력자료(HIN009H) 삭제처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('경력자료 삭제처리 중입니다...')
Integer	li_CareerSeq		//경력자료순번
li_CareerSeq = dw_cancel.Object.career_seq[ll_Find] 			//경력자료순번
IF NOT isNull(li_CareerSeq) THEN
	DELETE	FROM	INDB.HIN009H
	WHERE		MEMBER_NO  = :ls_MemberNo
	AND		CAREER_SEQ = :li_CareerSeq;
	IF SQLCA.SQLCODE <> 0 THEN
		wf_SetMsg('경력자료 삭제시 오류가 발생하였습니다.')
		MessageBox('확인','경력자료 삭제시 전산장애가 발생되었습니다.~r~n' + &
						'하단의 장애번호와 장애내역을~r~n' + &
						'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
						'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
						'장애내역 : ' + SQLCA.SqlErrText)
		ROLLBACK USING SQLCA;	
		RETURN FALSE
	END IF
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 국내외연수(HIN015H) 삭제처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('국내외연수자료 삭제처리 중입니다...')
String	ls_FromDate015		//시작일자
ls_FromDate015 = dw_cancel.Object.from_date015[ll_Find]		//시작일자
IF NOT isNull(ls_FromDate015) THEN
	DELETE	FROM	INDB.HIN015H
	WHERE		MEMBER_NO = :ls_MemberNo
	AND		FROM_DATE = :ls_FromDate015;
	IF SQLCA.SQLCODE <> 0 THEN
		wf_SetMsg('국내외연수자료 삭제시 오류가 발생하였습니다.')
		MessageBox('확인','국내외연수자료 삭제시 전산장애가 발생되었습니다.~r~n' + &
						'하단의 장애번호와 장애내역을~r~n' + &
						'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
						'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
						'장애내역 : ' + SQLCA.SqlErrText)
		ROLLBACK USING SQLCA;	
		RETURN FALSE
	END IF
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 포상.징계테이블(HIN016H) 삭제처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('포상.징계자료 삭제처리 중입니다...')
Integer	li_PrizeCode		//징계코드
String	ls_FromDate016		//시작일자
li_PrizeCode   = dw_cancel.Object.prize_code  [ll_Find]		//징계코드
ls_FromDate016 = dw_cancel.Object.from_date016[ll_Find]		//시작일자
IF NOT isNull(ls_FromDate016) THEN
	DELETE	FROM	INDB.HIN016H
	WHERE		MEMBER_NO  = :ls_MemberNo
	AND		PRIZE_CODE = :li_PrizeCode
	AND		FROM_DATE  = :ls_FromDate016;
	IF SQLCA.SQLCODE <> 0 THEN
		wf_SetMsg('포상.징계자료 삭제시 오류가 발생하였습니다.')
		MessageBox('확인','포상.징계자료 삭제시 전산장애가 발생되었습니다.~r~n' + &
						'하단의 장애번호와 장애내역을~r~n' + &
						'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
						'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
						'장애내역 : ' + SQLCA.SqlErrText)
		ROLLBACK USING SQLCA;	
		RETURN FALSE
	END IF
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 인사기본정보(HIN001M)변경처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('인사기본사항 변동처리 중입니다...')
//변경할 인사기본(HIN001M)
Integer	li_ChangeOpt		//발령코드
String	ls_FromDate			//발령시작일자
String	ls_ToDate			//발령종료일자
String	ls_DeptCode			//조직코드
String	ls_SosokDate		//소속일자
String	ls_JikJongDate		//직종일자
Integer	li_JikWiCode		//직위코드
String	ls_DutyCode			//직급코드
String	ls_DutyDate			//직급일자
String	ls_SalYear			//호봉년도
String	ls_SalClass			//호봉코드
String	ls_SalDate			//호봉일자
Integer	li_SalLeftMonth	//호봉잔여월수
String	ls_JaeImYongStart	//재임용시작일자
String	ls_JaeImYongEnd	//재임용종료일자
String	ls_RetireDate		//퇴직일자
Integer	li_JikMuCode		//직무코드
String	ls_JunimDate		//전임임용일
String	ls_JoGyoSuDate		//조교수임용일
String	ls_BuGyoSuDate		//부교수임용일
String	ls_GyoSuDate		//교수임용일
IF ll_RowCnt > 1 THEN ll_RowCnt = ll_RowCnt - 1
li_ChangeOpt      = dw_cancel.Object.change_opt     [ll_RowCnt]	//발령코드
ls_FromDate       = dw_cancel.Object.from_date      [ll_RowCnt]	//발령시작일자
ls_ToDate         = dw_cancel.Object.to_date        [ll_RowCnt]	//발령종료일자
ls_DeptCode       = dw_cancel.Object.gwa            [ll_RowCnt]	//조직코드
ls_SosokDate      = dw_cancel.Object.sosok_date     [ll_RowCnt]	//소속일자
ls_JikJongDate    = dw_cancel.Object.jikjong_date   [ll_RowCnt]	//직종일자
li_JikWiCode      = dw_cancel.Object.jikwi_code     [ll_RowCnt]	//직위코드
ls_DutyCode       = dw_cancel.Object.duty_code      [ll_RowCnt]	//직급코드
ls_DutyDate       = dw_cancel.Object.duty_date      [ll_RowCnt]	//직급일자
ls_SalYear        = dw_cancel.Object.sal_year       [ll_RowCnt]	//호봉년도
ls_SalClass       = dw_cancel.Object.sal_class      [ll_RowCnt]	//호봉코드
ls_SalDate        = dw_cancel.Object.sal_date       [ll_RowCnt]	//호봉일자
li_SalLeftMonth   = dw_cancel.Object.sal_leftmonth  [ll_RowCnt]	//호봉잔여월수
ls_JaeImYongStart = dw_cancel.Object.jaeimyong_start[ll_RowCnt]	//재임용시작일자
ls_JaeImYongEnd   = dw_cancel.Object.jaeimyong_end  [ll_RowCnt]	//재임용종료일자
ls_RetireDate     = dw_cancel.Object.retire_date    [ll_RowCnt]	//퇴직일자
li_JikMuCode      = dw_cancel.Object.jikmu_code     [ll_RowCnt]	//직무코드
ls_JunimDate      = dw_cancel.Object.junim_date     [ll_RowCnt]	//전임임용일
ls_JoGyoSuDate    = dw_cancel.Object.jogyosu_date   [ll_RowCnt]	//조교수임용일
ls_BuGyoSuDate    = dw_cancel.Object.bugyosu_date   [ll_RowCnt]	//부교수임용일
ls_GyoSuDate      = dw_cancel.Object.gyosu_date     [ll_RowCnt]	//교수임용일
/*
IF ll_RowCnt = 1 AND li_ChangeOpt = 11 THEN
	SetNull(ls_JikJongDate)
	SetNull(ls_DutyDate)
	SetNull(ls_SalYear)
	SetNull(ls_SalClass)
	SetNull(ls_SalDate)
	SetNull(li_SalLeftMonth)
	SetNull(ls_JaeImYongStart)
	SetNull(ls_JaeImYongEnd)
	SetNull(ls_JunimDate)
	SetNull(ls_JoGyoSuDate)
	SetNull(ls_BuGyoSuDate)
	SetNull(ls_GyoSuDate)
END IF
*/

UPDATE	INDB.HIN001M
SET		CHANGE_OPT      = :li_ChangeOpt,
			CHANGE_DATE     = :ls_FromDate,
			GWA             = :ls_DeptCode,
			SOSOK_DATE      = :ls_SosokDate,
			JIKJONG_DATE    = :ls_JikJongDate,
			JIKWI_CODE      = :li_JikWiCode,
			DUTY_CODE       = :ls_DutyCode,
			DUTY_DATE       = :ls_DutyDate,
			SAL_YEAR        = :ls_SalYear,
			SAL_CLASS       = :ls_SalClass,
			SAL_DATE        = :ls_SalDate,
			SAL_LEFTMONTH   = :li_SalLeftMonth,
			JAEIMYONG_START = :ls_JaeImYongStart,
			JAEIMYONG_END   = :ls_JaeImYongEnd,
			RETIRE_DATE     = :ls_RetireDate,
			JIKMU_CODE      = :li_JikMuCode,
			JUNIM_DATE      = :ls_JunimDate,
			JOGYOSU_DATE    = :ls_JoGyoSuDate,
			BUGYOSU_DATE    = :ls_BuGyoSuDate,
			GYOSU_DATE      = :ls_GyoSuDate,
			JOB_UID         = :is_Worker,
			JOB_ADD         = :is_IPAddr,
			JOB_DATE        = :idt_WorkDate
WHERE		MEMBER_NO       = :ls_MemberNo;
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
	MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ROLLBACK USING SQLCA;	
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('미결 처리가 완료되었습니다.')
RETURN TRUE

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

public subroutine wf_setmenubtn (string as_type);//입력
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

on w_hin252i_old.create
int iCurrent
call super::create
this.dw_cancel=create dw_cancel
this.ddlb_gubn=create ddlb_gubn
this.st_19=create st_19
this.dw_car_year=create dw_car_year
this.cb_cancel=create cb_cancel
this.st_6=create st_6
this.st_5=create st_5
this.dw_sign_opt=create dw_sign_opt
this.st_2=create st_2
this.dw_update=create dw_update
this.uo_member=create uo_member
this.gb_1=create gb_1
this.dw_change_opt=create dw_change_opt
this.cb_hakjang=create cb_hakjang
this.cb_esajang=create cb_esajang
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cancel
this.Control[iCurrent+2]=this.ddlb_gubn
this.Control[iCurrent+3]=this.st_19
this.Control[iCurrent+4]=this.dw_car_year
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.dw_sign_opt
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_update
this.Control[iCurrent+11]=this.uo_member
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.dw_change_opt
this.Control[iCurrent+14]=this.cb_hakjang
this.Control[iCurrent+15]=this.cb_esajang
end on

on w_hin252i_old.destroy
call super::destroy
destroy(this.dw_cancel)
destroy(this.ddlb_gubn)
destroy(this.st_19)
destroy(this.dw_car_year)
destroy(this.cb_cancel)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.dw_sign_opt)
destroy(this.st_2)
destroy(this.dw_update)
destroy(this.uo_member)
destroy(this.gb_1)
destroy(this.dw_change_opt)
destroy(this.cb_hakjang)
destroy(this.cb_esajang)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 인사발령등록된 자료를 학장,이사장결재를 처리한다.
//					이사장결재가 되어야만 인사기본정보에 반영이 됨.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 결재구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
dw_sign_opt.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('sign_opt',0) = 0 THEN
	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
dw_sign_opt.InsertRow(0)
dw_sign_opt.Object.code.dddw.PercentWidth	= 100
dw_sign_opt.Object.code[1] = '1'
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 발령구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_change_opt.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('change_opt',0) = 0 THEN
	wf_setmsg('공통코드[발령구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	Long	ll_InsRow
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
dw_change_opt.InsertRow(0)
dw_change_opt.Object.code.dddw.PercentWidth	= 100
////////////////////////////////////////////////////////////////////////////////////
// 1.3 결재구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_update.GetChild('sign_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('sign_opt',1) = 0 THEN
	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화 이벤트 콜
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////
// 1.1 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JikJongCode
ls_JikJongCode = MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.3 결재구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_SignOpt
ls_SignOpt = TRIM(dw_sign_opt.Object.code[1])
IF LEN(ls_SignOpt) = 0 OR isNull(ls_SignOpt) OR ls_SignOpt = '0' THEN ls_SignOpt = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.4 발령구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_ChangeOpt
ls_ChangeOpt = TRIM(dw_change_opt.Object.code[1])
IF LEN(ls_ChangeOpt) = 0 OR isNull(ls_ChangeOpt) OR ls_ChangeOpt = '0' THEN ls_ChangeOpt = ''


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(ls_KName,ls_SignOpt,ls_ChangeOpt,ls_JikJongCode)
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('SR')
	wf_SetMsg('자료가 조회되었습니다.')
	dw_update.SetFocus()
END IF
return 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: ue_save_01	: 수습
//					 ue_save_02	: 수습해제 
//					 ue_save_11	: 신규임용/
//					 ue_save_12	: 해임/
//					 ue_save_21	: 정기승진 - 생성후결재/-
//					 ue_save_22	: 특별승진/
//					 ue_save_23	: 정기승급 - 생성후결재/-
//					 ue_save_31	: 기간제임용 - 생성후결재/-
//					 ue_save_41	: 전보(보직변경)/
//					 ue_save_42	: 전출,입/
//					 ue_save_51	: 직종변경
//					 ue_save_61	: 파견
//					 ue_save_62	: 파견복귀 - 생성후결재
//					 ue_save_63	: 해외연수/
//					 ue_save_64	: 해외연수복귀 - 생성후결재/
//					 ue_save_65	: 연구년/
//					 ue_save_66	: 연구년복귀 - 생성후결재/
//					 ue_save_71	: 휴직/
//					 ue_save_72	: 복직 - 생성후결재/
//					 ue_save_81	: 의원면직/
//					 ue_save_82	: 직권면직/
//					 ue_save_83	: 당연퇴직/
//					 ue_save_84	: 정년퇴직 - 생성후결재/
//					 ue_save_91	: 재호봉획정
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
ls_NotNullCol[2] = 'change_opt/발령구분'
ls_NotNullCol[3] = 'from_date/발령기간'
ls_NotNullCol[4] = 'sign_opt/결재구분'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row				//변경된 행
Boolean	lb_Rtn

Integer	li_SignOpt
Integer	li_ChangeOpt
string ls_MemberNo

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	idt_WorkDate = f_sysdate()					//등록일자
	is_Worker    = gstru_uid_uname.uid		//등록자
	is_IpAddr    = gstru_uid_uname.address	//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status  = dw_update.GetItemStatus(ll_Row,0,Primary!)
	li_SignOpt   = dw_update.Object.sign_opt  [ll_Row]	//결재구분
	li_ChangeOpt = dw_update.Object.change_opt[ll_Row]	//발령코드
	lS_MemberNo = dw_update.Object.member_no[ll_Row]	//교직원번호
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 결재구분이 이사장결재인 경우는 처리한다.
	/////////////////////////////////////////////////////////////////////////////////
	IF li_SignOpt = 2 THEN
		CHOOSE CASE li_ChangeOpt
			CASE  1	; lb_Rtn = THIS.TRIGGER EVENT ue_save_01(ll_Row)	//수습
			CASE  2 	; lb_Rtn = THIS.TRIGGER EVENT ue_save_02(ll_Row)	//수습해제 
			CASE 11	; lb_Rtn = THIS.TRIGGER EVENT ue_save_11(ll_Row)	//신규임용 
			CASE 12	; lb_Rtn = THIS.TRIGGER EVENT ue_save_12(ll_Row)	//해임
			CASE 21	; lb_Rtn = THIS.TRIGGER EVENT ue_save_21(ll_Row)	//승진
			CASE 22	; lb_Rtn = THIS.TRIGGER EVENT ue_save_22(ll_Row)	//특별승진
			CASE 23	; lb_Rtn = THIS.TRIGGER EVENT ue_save_23(ll_Row)	//승급
			CASE 31	; lb_Rtn = THIS.TRIGGER EVENT ue_save_31(ll_Row)	//기간제임용
			CASE 41	; lb_Rtn = THIS.TRIGGER EVENT ue_save_41(ll_Row)	//전보(보직변경)
			CASE 42	; lb_Rtn = THIS.TRIGGER EVENT ue_save_42(ll_Row)	//전출,입
			CASE 51	; lb_Rtn = THIS.TRIGGER EVENT ue_save_51(ll_Row)	//직종변경
			CASE 61	; lb_Rtn = THIS.TRIGGER EVENT ue_save_61(ll_Row)	//파견
			CASE 62	; lb_Rtn = THIS.TRIGGER EVENT ue_save_62(ll_Row)	//파견복귀
			CASE 63	; lb_Rtn = THIS.TRIGGER EVENT ue_save_63(ll_Row)	//해외연수
			CASE 64	; lb_Rtn = THIS.TRIGGER EVENT ue_save_64(ll_Row)	//해외연수복귀
			CASE 65	; lb_Rtn = THIS.TRIGGER EVENT ue_save_65(ll_Row)	//연구년
			CASE 66	; lb_Rtn = THIS.TRIGGER EVENT ue_save_66(ll_Row)	//연구년복귀
			CASE 71	; lb_Rtn = THIS.TRIGGER EVENT ue_save_71(ll_Row)	//휴직
			CASE 72	; lb_Rtn = THIS.TRIGGER EVENT ue_save_72(ll_Row)	//복직
			CASE 81	; lb_Rtn = THIS.TRIGGER EVENT ue_save_81(ll_Row)	//의원면직
			CASE 82	; lb_Rtn = THIS.TRIGGER EVENT ue_save_82(ll_Row)	//직권면직
			CASE 83	; lb_Rtn = THIS.TRIGGER EVENT ue_save_83(ll_Row)	//당연퇴직
			CASE 84	; lb_Rtn = THIS.TRIGGER EVENT ue_save_84(ll_Row)	//정년퇴직
			CASE 91	; lb_Rtn = THIS.TRIGGER EVENT ue_save_91(ll_Row)	//호봉재획정
			CASE ELSE; RETURN -1
				CONTINUE
		END CHOOSE
		IF NOT lb_Rtn THEN RETURN -1
		
		//////////////////////////////////////////////////////////////////////////////
      // 3.1.1 도서관 이용자정보 Update
      // 발령코드 : 12: 해임, 71: 휴직, 72:복직, 81,82: 면직, 83,84: 퇴직
		// f_doseo_check 함수 네번째 PRAMETER : '1' (재직) : 복직
		//                                      '2' (휴직) : 휴직
		//                                      '3' (퇴직) : 해임, 면직, 퇴직
		//////////////////////////////////////////////////////////////////////////////
//
//		IF li_ChangeOpt = 72 THEN // 복직
//			f_doseo_check('2', '2',ls_MemberNo,'1')
//		ELSEIF li_ChangeOpt = 71 THEN // 휴직
//			f_doseo_check('2', '2',ls_MemberNo,'2')
//		ELSEIF li_ChangeOpt = 12 OR &
//		       li_ChangeOpt = 81 OR li_ChangeOpt = 82 OR &
//		       li_ChangeOpt = 83 OR li_ChangeOpt = 84 THEN
//		   f_doseo_check('2', '2',ls_MemberNo,'3')
//	   END IF
//		
	END IF
	
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		dw_update.Object.worker   [ll_Row] = is_Worker		//등록일자
		dw_update.Object.work_date[ll_Row] = idt_WorkDate	//등록자
		dw_update.Object.ipaddr   [ll_Row] = is_IPAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	dw_update.Object.job_uid  [ll_Row] = is_Worker		//등록자
	dw_update.Object.job_add  [ll_Row] = is_IpAddr		//등록단말기
	dw_update.Object.job_date [ll_Row] = idt_WorkDate	//등록일자
	
	ll_Row = dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF NOT dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('SR')
dw_update.SetFocus()
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
// 1. 초기화처리
///////////////////////////////////////////////////////////////////////////////////////
dw_update.Reset()
dw_car_year.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')
uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin252i_old
end type

type ln_tempright from w_msheet`ln_tempright within w_hin252i_old
end type

type ln_temptop from w_msheet`ln_temptop within w_hin252i_old
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin252i_old
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin252i_old
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin252i_old
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin252i_old
end type

type uc_insert from w_msheet`uc_insert within w_hin252i_old
end type

type uc_delete from w_msheet`uc_delete within w_hin252i_old
end type

type uc_save from w_msheet`uc_save within w_hin252i_old
end type

type uc_excel from w_msheet`uc_excel within w_hin252i_old
end type

type uc_print from w_msheet`uc_print within w_hin252i_old
end type

type st_line1 from w_msheet`st_line1 within w_hin252i_old
end type

type st_line2 from w_msheet`st_line2 within w_hin252i_old
end type

type st_line3 from w_msheet`st_line3 within w_hin252i_old
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin252i_old
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin252i_old
end type

type dw_cancel from datawindow within w_hin252i_old
boolean visible = false
integer x = 82
integer y = 492
integer width = 3442
integer height = 432
integer taborder = 80
string title = "none"
string dataobject = "d_hin252i_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_gubn from dropdownlistbox within w_hin252i_old
integer x = 576
integer y = 88
integer width = 379
integer height = 324
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"1. 교원","2. 직원","3. 전체"}
borderstyle borderstyle = stylelowered!
end type

event constructor;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: constructor
//	기 능 설 명: 활성화되는 시점에 로그인한 사람의 권한그룹을 체크하여
//						교직원구분을 셋팅한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UserID		//로그인사번
Integer	li_JikJongCode	//교직원구분코드
ls_UserID = TRIM(gstru_uid_uname.uid)			//로그인사번
IF LEN(ls_UserID) = 0 THEN
	li_JikJongCode = 1
	RETURN
END IF

String 	ls_GroupID		//권한그굽코드
Boolean	lb_GroupChk = FALSE
SELECT	A.GROUP_ID
INTO		:ls_GroupID
FROM		CDDB.KCH403M A
WHERE		A.MEMBER_NO = :ls_UserID
AND		A.GROUP_ID  IN ('Hin00','Hin01','Hin02','Admin','Mnger','PGMer2')
AND		ROWNUM       = 1;

CHOOSE CASE TRIM(ls_GroupID)
	CASE 'Hin01'
		li_JikJongCode = 2	//사무처
	CASE 'Hin02'
		li_JikJongCode = 1	//교무처
	CASE ELSE
		li_JikJongCode = 3	//관리자
		lb_GroupChk    = TRUE
END CHOOSE

THIS.SelectItem(li_JikJongCode)
THIS.Enabled = lb_GroupChk

uo_member.is_JikJongCode = String(li_JikJongCode)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event selectionchanged;uo_member.is_JikJongCode = String(index)

end event

type st_19 from statictext within w_hin252i_old
integer x = 238
integer y = 108
integer width = 334
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "교직원구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_car_year from cuo_dwwindow_one_hin within w_hin252i_old
boolean visible = false
integer x = 14
integer y = 1416
integer width = 3845
integer height = 904
boolean titlebar = true
string dataobject = "d_hin205b_3"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = true
borderstyle borderstyle = styleraised!
end type

type cb_cancel from commandbutton within w_hin252i_old
boolean visible = false
integer x = 2857
integer width = 475
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "미결처리"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_cancel
//	기 능 설 명: 확정결재처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt
String	ls_Msg
ll_RowCnt = dw_update.RowCount()
IF ll_RowCnt = 0 THEN
	ls_Msg = '자료를 조회후 사용하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	RETURN
END IF

Long		ll_idx
Integer	li_SignOpt = 2	//결재구분(0:없음,1:미결,2:학(총)장결재,3:이사장결재)
FOR ll_idx = 1 TO ll_RowCnt
	li_SignOpt = dw_update.Object.sign_opt[ll_idx]
	IF li_SignOpt < 2 THEN CONTINUE
	dw_update.Object.sign_opt[ll_idx] = li_SignOpt - 1
NEXT

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('일괄 미결처리되었습니다. 자료를 저장하시기 바랍니다.')

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type st_6 from statictext within w_hin252i_old
integer x = 3374
integer y = 12
integer width = 489
integer height = 280
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hin252i_old
integer x = 1303
integer y = 188
integer width = 274
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "발령구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_sign_opt from datawindow within w_hin252i_old
integer x = 571
integer y = 172
integer width = 695
integer height = 80
integer taborder = 30
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type st_2 from statictext within w_hin252i_old
integer x = 297
integer y = 188
integer width = 270
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "결재구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_update from cuo_dwwindow_one_hin within w_hin252i_old
integer x = 14
integer y = 304
integer width = 3845
integer height = 2196
integer taborder = 70
string dataobject = "d_hin252i_1"
boolean livescroll = false
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = TRUE
end event

type uo_member from cuo_insa_member within w_hin252i_old
integer x = 1454
integer y = 96
integer height = 76
integer taborder = 20
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type gb_1 from groupbox within w_hin252i_old
integer x = 14
integer y = 12
integer width = 3351
integer height = 284
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회조건"
end type

type dw_change_opt from datawindow within w_hin252i_old
integer x = 1582
integer y = 172
integer width = 695
integer height = 80
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type cb_hakjang from commandbutton within w_hin252i_old
boolean visible = false
integer x = 3383
integer y = 20
integer width = 475
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "학(총)장결재"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_hakjang
//	기 능 설 명: 학(총)장 결재처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt
String	ls_Msg
ll_RowCnt = dw_update.RowCount()
IF ll_RowCnt = 0 THEN
	ls_Msg = '자료를 조회후 사용하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 학(총)장 결재처리
//		결재구분(0:없음,1:미결,2:학(총)장결재,3:이사장결재)
//		학(총)장결재시는 미결인 자료만 처리가능
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_idx
Integer	li_SignOpt	
FOR ll_idx = 1 TO ll_RowCnt
	li_SignOpt = dw_update.Object.sign_opt[ll_idx]
	IF li_SignOpt = 1 THEN dw_update.Object.sign_opt[ll_idx] = 2
NEXT

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('일괄 학(총)장결재 처리되었습니다. 자료를 저장하시기 바랍니다.')

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type cb_esajang from commandbutton within w_hin252i_old
integer x = 3383
integer y = 20
integer width = 475
integer height = 268
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "내부결재"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_esajang
//	기 능 설 명: 이장 결재처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt
String	ls_Msg
ll_RowCnt = dw_update.RowCount()
IF ll_RowCnt = 0 THEN
	ls_Msg = '자료를 조회후 사용하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 이사장 결재처리
//		결재구분(0:없음,1:미결,2:학(총)장결재,3:이사장결재)
//		이사장결재시는 미결이든 학(총)장결재이든 모두자료 처리가능
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_idx
Integer	li_SignOpt = 3	//결재구분(0:없음,1:미결,2:학(총)장결재,3:이사장결재)
FOR ll_idx = 1 TO ll_RowCnt
	dw_update.Object.sign_opt[ll_idx] = 2
NEXT

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('일괄 내부결재 처리되었습니다. 자료를 저장하시기 바랍니다.')

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

