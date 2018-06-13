$PBExportHeader$w_hin205b.srw
$PBExportComments$경력자료생성
forward
global type w_hin205b from w_msheet
end type
type dw_car_year from cuo_dwwindow_one_hin within w_hin205b
end type
type dw_list from cuo_dwwindow_one_hin within w_hin205b
end type
type dw_update from cuo_dwwindow_one_hin within w_hin205b
end type
type dw_con from uo_dwfree within w_hin205b
end type
type uo_member from cuo_insa_member within w_hin205b
end type
type cb_create from uo_imgbtn within w_hin205b
end type
end forward

global type w_hin205b from w_msheet
string title = "경력자료생성"
event type boolean ue_chk_condition ( )
dw_car_year dw_car_year
dw_list dw_list
dw_update dw_update
dw_con dw_con
uo_member uo_member
cb_create cb_create
end type
global w_hin205b w_hin205b

type variables
String	is_JikJongCode		//직종구분
String	is_KName				//성명
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
////////////////////////////////////////////////////////////////////////////////////
// 1.1 구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
dw_con.accepttext()

is_JikJongCode = dw_con.object.gubn[1] //MID(ddlb_gubn.Text,1,1)
IF is_JikJongCode = '3' THEN 
	MessageBox('확인','전체는 선택할 수 없습니다.')
	dw_con.SetFocus()
	RETURN FALSE
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.2 기준일자 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_KName = TRIM(uo_member.sle_kname.Text)

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

on w_hin205b.create
int iCurrent
call super::create
this.dw_car_year=create dw_car_year
this.dw_list=create dw_list
this.dw_update=create dw_update
this.dw_con=create dw_con
this.uo_member=create uo_member
this.cb_create=create cb_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_car_year
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.dw_update
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.uo_member
this.Control[iCurrent+6]=this.cb_create
end on

on w_hin205b.destroy
call super::destroy
destroy(this.dw_car_year)
destroy(this.dw_list)
destroy(this.dw_update)
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.cb_create)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 인사기본의 군경력, 학력사항을 경력사항으로 생성한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
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

event ue_retrieve;/////////////////////////////////////////////////////////////////////////////////////////
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
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(is_JikJongCode,is_KName)
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('R')
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
Long		ll_RowCnt
ll_RowCnt = dw_update.RowCount()
IF ll_RowCnt = 0 THEN
	wf_SetMsg('경력자료를 생성 후 저장하시기 바랍니다')
	RETURN 0
END IF
IF dw_update.AcceptText() = -1 THEN
	dw_update.SetFocus()
	RETURN -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
// 3.1 경력사항처리
////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IpAddr		//등록단말기

String	ls_MemberNo[] = {'',''}	//개인번호
Integer	li_CareerSeq				//경력순번

IF ll_RowCnt > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode //gstru_uid_uname.uid		//등록자
	ls_IpAddr    = gs_ip   // gstru_uid_uname.address	//등록단말기
END IF
FOR ll_Row = 1 TO ll_RowCnt
	ls_MemberNo[1] = dw_update.Object.member_no[ll_Row]
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1.1 개인번호가 바뀐 경우 처리
	/////////////////////////////////////////////////////////////////////////////////
	IF ls_MemberNo[1] = ls_MemberNo[2] THEN
		li_CareerSeq++
	ELSE
		//////////////////////////////////////////////////////////////////////////////
		// 3.1.1.1 개인번호가 바뀌면 각개인에 군경력,학력자료 삭제처리
		//				경력의 순번MAX + 1을 SELECT
		//				인사기본마스터에 총경력년월 UPDATE 처리
		//////////////////////////////////////////////////////////////////////////////
		ls_MemberNo[2] = ls_MemberNo[1]
		DELETE	
		FROM		INDB.HIN009H A
		WHERE		A.MEMBER_NO  = :ls_MemberNo[1]
		AND		A.PROCES_OPT IN (1,2);
		IF SQLCA.SQLCODE <> 0 THEN
			wf_SetMsg('경력사항자료 중 군경력,학력자료 삭제처리 중 에러가 발생하였습니다.')
			MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF
		
		SELECT	NVL(MAX(A.CAREER_SEQ),0) + 1
		INTO		:li_CareerSeq
		FROM		INDB.HIN009H A
		WHERE		A.MEMBER_NO = :ls_MemberNo[1];
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
			CASE 100
				li_CareerSeq = 1
			CASE ELSE
				wf_SetMsg('경력사항에 순번 처리 중 오류가 발생하였습니다.')
				MessageBox('오류',&
								'경력사항에 순번 처리 중 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
				ROLLBACK USING SQLCA;
				RETURN -1
		END CHOOSE
	END IF
	dw_update.Object.career_seq[ll_Row] = li_CareerSeq
	
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2.1 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	dw_update.Object.worker   [ll_Row] = ls_Worker		//등록자
	dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
	dw_update.Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
	dw_update.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	dw_update.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	dw_update.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
NEXT

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF NOT dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 5. 경력사항에 경력누계 UPDATE 처리
//		인사기본마스터에 총경력년월 UPDATE 처리
///////////////////////////////////////////////////////////////////////////////////////
Long			ll_CarRow
Long			ll_CarRowCnt
Decimal{2}	ldc_HwanYear
Decimal{2}	ldc_CarYear
Decimal{2}	ldc_CareerYm
String		ls_Str

ls_MemberNo[1] = ''
ls_MemberNo[2] = ''

FOR ll_Row = 1 TO ll_RowCnt
	ls_MemberNo[1] = dw_update.Object.member_no[ll_Row]
	IF ls_MemberNo[1] = ls_MemberNo[2] THEN CONTINUE
	ldc_CarYear  = 0
	ldc_CareerYm = 0
	ls_MemberNo[2] = ls_MemberNo[1]
	
	////////////////////////////////////////////////////////////////////////////////////
	// 5.1 경력사항에 총경력년월누계,근속인정년월누계 UPDATE 처리
	////////////////////////////////////////////////////////////////////////////////////
	ll_CarRowCnt = dw_car_year.Retrieve(ls_MemberNo[1])
	FOR ll_CarRow = 1 TO ll_CarRowCnt
		/////////////////////////////////////////////////////////////////////////////////
		// 5.1.1 총경력년월누계
		/////////////////////////////////////////////////////////////////////////////////
		ls_Str = "Evaluate('cumulativeSum(hwan_year for all)',"+&
					String(ll_CarRow)+")"
		ldc_HwanYear = Double(dw_car_year.Describe(ls_Str))
		IF isNull(ldc_HwanYear) OR ldc_HwanYear = 0 THEN CONTINUE
		SELECT	FU_RTN_HWAN_YEAR(:ldc_HwanYear,100)
		INTO		:ldc_CarYear
		FROM		DUAL;
		dw_car_year.Object.car_year[ll_CarRow] = ldc_CarYear
		/////////////////////////////////////////////////////////////////////////////////
		// 5.1.2 근속인정년월누계
		/////////////////////////////////////////////////////////////////////////////////
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
	////////////////////////////////////////////////////////////////////////////////////
	// 5.2 인사기본마스터에 총경력년월누계,근속인정년월누계 UPDATE 처리
	////////////////////////////////////////////////////////////////////////////////////
	IF ldc_CarYear > 0 OR ldc_CareerYm > 0 THEN
		UPDATE	INDB.HIN001M
		SET		CAREER_YM = :ldc_CareerYm,
					CAR_YEAR  = :ldc_CarYear
		WHERE		MEMBER_NO = :ls_MemberNo[1];
		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
		ELSE
			wf_SetMsg('인사기본마스터에 총경력년월 처리 중 오류가 발생하였습니다.')
			MessageBox('오류',&
							'인사기본마스터에 총경력년월 처리 중 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;
			RETURN -1
		END IF
	END IF
	IF NOT dw_car_year.TRIGGER EVENT ue_db_save() THEN RETURN -1
NEXT

///////////////////////////////////////////////////////////////////////////////////////
// 6. 메세지, 메뉴버튼 활성/비활성화 처리
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
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
dw_update.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')

uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 인사기본의 군경력, 학력사항을 경력사항으로 생성한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
dw_con.insertrow(0)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////


THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin205b
end type

type ln_tempright from w_msheet`ln_tempright within w_hin205b
end type

type ln_temptop from w_msheet`ln_temptop within w_hin205b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin205b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin205b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin205b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin205b
end type

type uc_insert from w_msheet`uc_insert within w_hin205b
end type

type uc_delete from w_msheet`uc_delete within w_hin205b
end type

type uc_save from w_msheet`uc_save within w_hin205b
end type

type uc_excel from w_msheet`uc_excel within w_hin205b
end type

type uc_print from w_msheet`uc_print within w_hin205b
end type

type st_line1 from w_msheet`st_line1 within w_hin205b
end type

type st_line2 from w_msheet`st_line2 within w_hin205b
end type

type st_line3 from w_msheet`st_line3 within w_hin205b
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin205b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin205b
end type

type dw_car_year from cuo_dwwindow_one_hin within w_hin205b
boolean visible = false
integer y = 1764
integer width = 3835
integer height = 764
boolean titlebar = true
string dataobject = "d_hin205b_3"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = true
borderstyle borderstyle = styleraised!
boolean righttoleft = true
end type

type dw_list from cuo_dwwindow_one_hin within w_hin205b
boolean visible = false
integer y = 1124
integer width = 3835
integer height = 640
boolean titlebar = true
string dataobject = "d_hin205b_2"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = true
end type

type dw_update from cuo_dwwindow_one_hin within w_hin205b
integer x = 50
integer y = 300
integer width = 4384
integer height = 2008
integer taborder = 40
string dataobject = "d_hin205b_1"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
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
String	ls_Msg
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

type dw_con from uo_dwfree within w_hin205b
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hin205b_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin205b
event destroy ( )
integer x = 1152
integer y = 180
integer taborder = 60
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type cb_create from uo_imgbtn within w_hin205b
integer x = 59
integer y = 36
integer taborder = 41
boolean bringtotop = true
string btnname = "경력자료생성"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_create
//	기 능 설 명: 경력자료 생성
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
IF NOT PARENT.TRIGGER EVENT ue_chk_condition() THEN RETURN
////
dw_update.Reset()
///////////////////////////////////////////////////////////////////////////////////////
// 2. 호봉획정 생성
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt			//총건수
dw_list.SetReDraw(FALSE)
dw_list.Reset()
ll_RowCnt = dw_list.Retrieve(is_JikJongCode,is_KName)
dw_list.SetReDraw(TRUE)

////////////////////////////////////////////////////////////////////////////////////
// 2.2 경력자료 추가
////////////////////////////////////////////////////////////////////////////////////
Long			ll_InsRow				//추가된행
Long			ll_Row					//현재행
//경력사항LAYOUT
String		ls_MemberNo				//개인번호
Integer		li_CareerSeq			//순번
Integer		li_CareerOpt			//경력구분
Integer		li_ProcesOpt			//처리구분
String		ls_FromDate				//시작일
String		ls_ToDate				//종료일
Integer		li_CareerGbn			//근속구분
String		ls_CareerCon			//경력내용
Decimal{2}	ldc_WorkYear			//경력년월
Decimal{2}	ldc_DecisionYear		//인정년월
Decimal{1}	ldc_HwanRate			//환산율
Decimal{2}	ldc_HwanYear			//환산년월
Decimal{2}	ldc_CarYear				//경력누계
Integer		li_SignOpt				//결재구분

String		ls_KName					//성명
String		ls_CareerOptNm			//부서명
String		ls_ProcesOptNm			//직위명
String		ls_CareerGbnNm			//직급명	
String		ls_SignOptNm			//직무명

dw_update.SetReDraw(FALSE)
dw_update.Reset()
FOR ll_Row = 1 TO ll_RowCnt
	ls_MemberNo       = dw_list.Object.com_member_no      [ll_Row]	//개인번호
	li_CareerSeq      = 0
	li_CareerOpt      = dw_list.Object.com_career_opt     [ll_Row]	//경력구분
	li_ProcesOpt      = dw_list.Object.com_proces_opt     [ll_Row]	//처리구분
	ls_FromDate       = dw_list.Object.com_from_date      [ll_Row]	//시작일
	ls_ToDate         = dw_list.Object.com_to_date        [ll_Row]	//종료일
	/////////////////////////////////////////////////////////////////////////////////
	//	근속구분처리
	//		처리구분이 학력이면 근속인정처리
	/////////////////////////////////////////////////////////////////////////////////
	IF li_ProcesOpt = 2 THEN
		li_CareerGbn   = 9
		ls_CareerGbnNm = '인정'
	ELSE
		li_CareerGbn   = 0
		ls_CareerGbnNm = ''
	END IF
	ls_CareerCon      = dw_list.Object.com_career_con     [ll_Row]	//경력내용
	ldc_WorkYear      = dw_list.Object.com_decision_career[ll_Row]	//경력년월
	ldc_DecisionYear  = dw_list.Object.com_decision_career[ll_Row]	//인정년월
	ldc_HwanRate      = dw_list.Object.com_hwan_rate      [ll_Row]	//환산율
	ldc_HwanYear      = dw_list.Object.com_hwan_career    [ll_Row]	//환산년월
	ldc_CarYear       = 0														//경력누계
	li_SignOpt        = 2														//결재구분
	
	ls_KName          = dw_list.Object.com_kname          [ll_Row]	//성명
	ls_CareerOptNm    = dw_list.Object.com_career_opt_nm  [ll_Row]	//경력구분명
	ls_ProcesOptNm    = dw_list.Object.com_proces_opt_nm  [ll_Row]	//처리구분명
	ls_SignOptNm      = '내부결재'											//결재구분명
	
	ll_InsRow = dw_update.InsertRow(0)
	IF ll_InsRow = 0 THEN EXIT
	dw_update.Object.member_no        [ll_InsRow] = ls_MemberNo		//개인번호
	dw_update.Object.career_seq       [ll_InsRow] = li_CareerSeq		//순번
	dw_update.Object.career_opt       [ll_InsRow] = li_CareerOpt		//경력구분
	dw_update.Object.proces_opt       [ll_InsRow] = li_ProcesOpt		//처리구분
	dw_update.Object.from_date        [ll_InsRow] = ls_FromDate		//시작일
	dw_update.Object.to_date          [ll_InsRow] = ls_ToDate			//종료일
	dw_update.Object.career_gbn       [ll_InsRow] = li_CareerGbn		//근속구분
	dw_update.Object.career_con       [ll_InsRow] = ls_CareerCon		//경력내용
	dw_update.Object.work_year        [ll_InsRow] = ldc_WorkYear		//경력년월
	dw_update.Object.decision_year    [ll_InsRow] = ldc_DecisionYear	//인정년월
	dw_update.Object.hwan_rate        [ll_InsRow] = ldc_HwanRate		//환산율
	dw_update.Object.hwan_year        [ll_InsRow] = ldc_HwanYear		//환산년월
	dw_update.Object.sign_opt         [ll_InsRow] = li_SignOpt			//결재구분
	
	dw_update.Object.kname            [ll_InsRow] = ls_KName			//성명
	dw_update.Object.com_career_opt_nm[ll_InsRow] = ls_CareerOptNm	//경력구분명
	dw_update.Object.com_proces_opt_nm[ll_InsRow] = ls_ProcesOptNm	//처리구분명
	dw_update.Object.com_career_gbn_nm[ll_InsRow] = ls_CareerGbnNm	//근속구분명
	dw_update.Object.com_sign_opt_nm  [ll_InsRow] = ls_SignOptNm		//결재구분명	
NEXT
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_InsRow > 0 THEN
//	wf_SetMenuBtn('SR')
	wf_SetMsg('경력자료가 생성되었습니다. 확인 후 자료를 저장하시기 바랍니다.')
ELSE
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 없습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cb_create.destroy
call uo_imgbtn::destroy
end on

