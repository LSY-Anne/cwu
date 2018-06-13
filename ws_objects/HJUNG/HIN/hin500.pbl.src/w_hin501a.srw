$PBExportHeader$w_hin501a.srw
$PBExportComments$제증명발급관리
forward
global type w_hin501a from w_msheet
end type
type tab_1 from tab within w_hin501a
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hin501a
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_hin501a
end type
type dw_con from uo_dwfree within w_hin501a
end type
type cbx_seq from checkbox within w_hin501a
end type
type uo_member from cuo_insa_member within w_hin501a
end type
end forward

global type w_hin501a from w_msheet
string title = "재직증명서신청"
event type boolean ue_chk_condition ( )
event ue_retrieve_print ( )
tab_1 tab_1
uo_1 uo_1
dw_con dw_con
cbx_seq cbx_seq
uo_member uo_member
end type
global w_hin501a w_hin501a

type variables
Integer	ii_JikJongCode		//직종구분
STRING	is_JikJongCode		//직종구분
String	is_FrDate			//신청일자FROM
String	is_ToDate			//신청일자TO
String	is_ApplyNo			//신청자
Integer	ii_PrintOpt			//증명서구분
Integer	ii_LangOpt			//국영문구분
STRING	iS_REMARK			//용도
Dec{0}	id_price				//단가
Dec{0}	id_num				//매수
STRING	is_NAME_HAN			//한자명
STRING	is_ADDR1				//주소
STRING	is_ADDR2				//주소

String	is_change_date, is_jumin_no,is_name, is_dept_name, is_duty_name, is_sysdate			
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
public subroutine wf_basic_print (integer li_member_opt, string ls_applydate, integer apply_no)
public subroutine wf_career_print (integer li_member_opt, string ls_applydate, integer li_apply_no)
public subroutine wf_prize_print (integer li_member_opt, string ls_applydate, integer li_apply_no)
public subroutine wf_crime_print (integer li_member_opt, string ls_applydate, integer li_apply_no)
end prototypes

event type boolean ue_chk_condition();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_chk_condition
//	기 능 설 명: 조회조건 체크
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
///////////////////////////////////////////////////////////////////////////////////////
// 1. 교직원구분 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
dw_con.accepttext()

ii_JikJongCode = Integer(MID(dw_con.object.gubn[1],1,1))
iS_JikJongCode = MID(dw_con.object.gubn[1],1,1)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 신청일자 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
//em_fr_date.GetData(is_FrDate)
is_FrDate = dw_con.object.fr_date[1]// TRIM(is_FrDate)
IF NOT f_isDate(is_FrDate) THEN
	MessageBox('확인','발급일자 입력오류입니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('fr_date')
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2.용도 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
Id_price	= dw_con.object.price[1]	//Dec(em_price.TEXT)

///////////////////////////////////////////////////////////////////////////////////////
// 2.단가 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
is_remark = dw_con.object.sle_etc[1]// sle_1.TEXT

///////////////////////////////////////////////////////////////////////////////////////
// 2.매수 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////

id_num	= dw_con.object.page[1]	//Dec(em_page.text)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 신청자 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
is_ApplyNo = TRIM(uo_member.sle_member_no.Text)

IF ISNULL(is_ApplyNo) OR is_ApplyNo = "" THEN
	wf_setmsg("신청자를 입력하세요")
	RETURN	false
END IF	

///////////////////////////////////////////////////////////////////////////////////////
// 4. 증명서구분 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
ii_PrintOpt = Integer(MID(dw_con.object.print_opt[1],1,1))
IF isNull(ii_PrintOpt) OR ii_PrintOpt = 0 THEN
	MessageBox('확인','증명서구분을 선택하시기 바랍니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('print_opt')
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 5. 국영문구분 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
ii_LangOpt = Integer(MID(dw_con.object.lang_opt[1],1,1))
IF isNull(ii_LangOpt) OR ii_LangOpt = 0 THEN
	MessageBox('확인','국영문구분을 선택하시기 바랍니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('lang_opt')
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 6. 제증명출력 오브젝트변경 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_DataObject = 'd_hin501a_'
CHOOSE CASE ii_PrintOpt
	CASE 1
		ls_DataObject += String(ii_PrintOpt)
		ls_DataObject += String(ii_LangOpt)
	CASE 2
		ls_DataObject += String(ii_PrintOpt)
		ls_DataObject += '1'
	CASE 5
		ls_DataObject += String(ii_PrintOpt)
		ls_DataObject += '1'
	CASE ELSE
		RETURN FALSE
END CHOOSE

tab_1.tabpage_2.dw_print.DataObject = ls_DataObject
tab_1.tabpage_2.dw_print.SetTransObject(SQLCA)

tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
tab_1.tabpage_2.dw_print.Reset()
tab_1.tabpage_2.dw_print.InsertRow(0)
tab_1.tabpage_2.dw_print.SetReDraw(TRUE)

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve_print();////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_retrieve_print
//	기 능 설 명: 제증명신청 출력자료 조회처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////
// 1. 제증명신청관리 자료조회여부 체크
/////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow

//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN

/////////////////////////////////////////////////////////////////////////////////////
// 2. 제증명신청 출력자료 조회처리
/////////////////////////////////////////////////////////////////////////////////////
//제증명신청 TABLE LAYOUT===
Integer	li_ApplyNo			//신청번호
Integer	li_PrintOpt			//증명서구분
Integer	li_PrintNum			//매수
String	ls_jikjong			//직종코드
String	ls_UnivName			//학교명
Long		ll_RowCnt			//
String	ls_JikwiNm

/////////////////////////////////////////////////////////////////////////////////////
// 2. 제증명신청 신청번호 생성
/////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('제증명발급대장 신청번호 생성 중입니다.')
SELECT	NVL(MAX(A.APPLY_NO),0) + 1
INTO		:li_ApplyNo
FROM		INDB.HIN013H A
WHERE		A.APPLY_DATE LIKE SUBSTR(:is_frdate,1,4) || '%'
//WHERE		A.APPLY_DATE = :is_frdate      /* 2004-01-08 */
//AND		A.MEMBER_OPT = :ii_jikjongcode   /* 2004-01-05 */
;
CHOOSE CASE SQLCA.SQLCODE
	CASE 0
	CASE 100
		li_ApplyNo = 1
	CASE ELSE
		MessageBox('오류',&
						'제증명발급대장 신청번호 생성시 전산장애가 발생되었습니다.~r~n' + &
						'하단의 장애번호와 장애내역을~r~n' + &
						'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
						'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
						'장애내역 : ' + SQLCA.SqlErrText)
		ROLLBACK USING SQLCA;
		RETURN
END CHOOSE


//////////////////////////신청자 정보 조회//////////////////////////////
SELECT	B.FIRSTHIRE_DATE,
			B.JUMIN_NO,
			B.NAME_HAN,
			A.HOME_ADDR1,
			A.HOME_ADDR2,
			B.NAME,
			FU_DEPT_NM(B.GWA,'K')			COM_DEPT_NM,
			FU_DUTY_NM(B.DUTY_CODE,'K')	COM_DUTY_NM,			
			DECODE(B.JAEJIK_OPT,1,TO_CHAR(SYSDATE,'YYYYMMDD'),B.RETIRE_DATE)	COM_SYSDATE,	
			FU_CODE_NM('COMM','JIKWI_CODE',B.JIKWI_CODE,'K')	COM_JIKWI_NM
INTO 		:is_change_date, :is_jumin_no,:is_name_han, 
			:is_addr1,:is_addr2,:is_name, :is_dept_name,:is_duty_name,:is_sysdate,:ls_JikwiNm	
FROM		INDB.HIN001M B,  INDB.HIN011M A 
WHERE		A.MEMBER_NO = B.MEMBER_NO
AND			B.MEMBER_NO = :is_applyno;
CHOOSE CASE SQLCA.SQLCODE
	CASE 0
	CASE 100
			wf_SetMsg('제증명신청 자료가 존재하지 않습니다.')
			return
	CASE ELSE
		MessageBox('오류',&
						'제증명발급대장 신청번호 생성시 전산장애가 발생되었습니다.~r~n' + &
						'하단의 장애번호와 장애내역을~r~n' + &
						'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
						'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
						'장애내역 : ' + SQLCA.SqlErrText)
		ROLLBACK USING SQLCA;
		RETURN
END CHOOSE




tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
tab_1.tabpage_2.dw_print.Reset()

CHOOSE CASE String(ii_PrintOpt)+String(ii_LangOpt)
	CASE '11', '21'	//재직증명서-국문
		tab_1.tabpage_2.dw_print.reset()
		tab_1.tabpage_2.dw_print.insertrow(0)
		tab_1.tabpage_2.dw_print.Object.com_dept_nm			[1]	=	is_dept_name
		tab_1.tabpage_2.dw_print.Object.com_duty_nm			[1]	=	is_duty_name
		tab_1.tabpage_2.dw_print.Object.hin013h_apply_name [1]	=	is_name
		tab_1.tabpage_2.dw_print.Object.hin001m_name_han	[1]	=	is_name_han
		tab_1.tabpage_2.dw_print.Object.hin011m_home_addr1	[1]	=	is_addr1
		tab_1.tabpage_2.dw_print.Object.hin011m_home_addr2	[1]	=	is_addr2
		tab_1.tabpage_2.dw_print.Object.hin013h_use_opt		[1]	=	is_remark		
		tab_1.tabpage_2.dw_print.Object.hin001m_jumin_no	[1]	=	is_jumin_no
		tab_1.tabpage_2.dw_print.Object.com_jikwi_nm       [1]	=	ls_JikwiNm
		tab_1.tabpage_2.dw_print.Object.t_1.text 						= 	sTRING(is_change_date,'@@@@/@@/@@') + "   -   " +STRING(is_sysdate,'@@@@/@@/@@') 
		tab_1.tabpage_2.dw_print.Object.t_campus_jang.Text 		= '청 운 대 학 교 총 장'
		tab_1.tabpage_2.dw_print.Object.t_2.text					 	= '제 ' + MID(is_frdate,1,4)+' - '+String(li_ApplyNo,'0000')+' 호'
		tab_1.tabpage_2.dw_print.Object.t_4.text						=	sTRING(F_TODAY(),'@@@@년 @@월 @@일')
//		wf_SetMenu('P',TRUE)
//		wf_SetMenu('S',TRUE)		

	CASE '12'	//재직증명서-영문
		ll_RowCnt = tab_1.tabpage_2.dw_print.Retrieve(ii_jikjongcode,is_frdate,li_ApplyNo)

	CASE '22'	//경력증명서-영문
	CASE '31'	//퇴직증명서-국문
	CASE '32'	//퇴직증명서-영문
	CASE '41'	//출강증명서-국문
	CASE '42'	//출강증명서-영문
	CASE '52'	//급여지급확인서-영문
	CASE ELSE
		RETURN
END CHOOSE
tab_1.tabpage_2.dw_print.SetReDraw(TRUE)

/////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
/////////////////////////////////////////////////////////////////////////////////////
//IF ll_RowCnt > 0 THEN
//	wf_SetMsg('제증명신청 자료가 조회되었습니다.')
//	wf_SetMenu('P',TRUE)
//ELSE
//	wf_SetMsg('제증명신청 자료가 존재하지 않습니다.')
//	wf_SetMenu('P',FALSE)
//END IF
////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////
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

public subroutine wf_basic_print (integer li_member_opt, string ls_applydate, integer apply_no);//  기본사항 출력

String	ls_name, ls_name_han, ls_jumin_no, ls_addr


SELECT	A.NAME,
			A.NAME_HAN,
			A.JUMIN_NO,
			C.HOME_ADDR1 || C.HOME_ADDR2 ADDR
INTO		:ls_name, :ls_name_han, :ls_jumin_no, :ls_addr
FROM		INDB.HIN001M A, INDB.HIN013H B,INDB.HIN011M C
WHERE		A.MEMBER_NO		=	B.MEMBER_NO
AND		A.MEMBER_NO		=	C.MEMBER_NO
AND		B.MEMBER_OPT	=	:li_member_opt
AND		B.APPLY_DATE	=	:ls_applydate
AND		B.APPLY_NO		=	:apply_no;


tab_1.tabpage_2.dw_print.SETITEM(1,2, ls_name)
tab_1.tabpage_2.dw_print.SETITEM(1,3, ls_name_han)
tab_1.tabpage_2.dw_print.SETITEM(1,4, ls_jumin_no)
tab_1.tabpage_2.dw_print.SETITEM(1,5, ls_addr)


end subroutine

public subroutine wf_career_print (integer li_member_opt, string ls_applydate, integer li_apply_no);// 경력사항 출력

String	ls_from_date, ls_to_date,ls_jikwi_name, ls_gwa_name
Int		i = 1

Declare	get_career	CURSOR FOR
			
//			SELECT	C.FROM_DATE,C.TO_DATE, C.JIKWI_NAME,C.GWA_NAME
//			FROM		INDB.HIN001M A, INDB.HIN013H B, INDB.HIN009H C
//			WHERE		A.MEMBER_NO		=	B.MEMBER_NO
//			AND		A.MEMBER_NO		=	C.MEMBER_NO
//			AND		B.MEMBER_OPT	=	:li_member_opt
//			AND		B.APPLY_DATE	=	:ls_applydate
//			AND		B.APPLY_NO		=	:li_apply_no;

			SELECT	C.FROM_DATE,C.TO_DATE, C.JIKWI_NAME,C.GWA_NAME
			FROM		INDB.HIN013H A, INDB.HIN009H C
			WHERE		A.MEMBER_NO		=	C.MEMBER_NO
			AND		C.PROCES_OPT	=	3
			AND		A.MEMBER_OPT	=	:li_member_opt
			AND		A.APPLY_DATE	=	:ls_applydate
			AND		A.APPLY_NO		=	:li_apply_no;


			
Open	get_career;

Fetch		get_career
INTO		:ls_from_date, :ls_to_date, :ls_jikwi_name, :ls_gwa_name;

DO	WHILE		SQLCA.SQLCODE = 0		
		
			IF		i >= 5	THEN
					RETURN	
			END IF	
					tab_1.tabpage_2.dw_print.setitem(1, (4*i)+2, ls_from_date)
					tab_1.tabpage_2.dw_print.setitem(1, (4*i)+3, ls_to_date)
					tab_1.tabpage_2.dw_print.setitem(1, (4*i)+4, ls_jikwi_name)					
					tab_1.tabpage_2.dw_print.setitem(1, (4*i)+5, ls_gwa_name)			
			I++
			

			Fetch		get_career
			INTO		:ls_from_date, :ls_to_date, :ls_jikwi_name, :ls_gwa_name;
			

LOOP


Close		get_career;

			
end subroutine

public subroutine wf_prize_print (integer li_member_opt, string ls_applydate, integer li_apply_no);// 수상경력 출력

String	ls_from_date, ls_to_date,ls_prize_code, ls_organ_name
Int		i


Declare	get_prize	CURSOR FOR
			SELECT	C.FROM_DATE,D.FNAME, C.ORGAN_NAME
			FROM		INDB.HIN001M A, INDB.HIN013H B, INDB.HIN016H C, CDDB.KCH001M D
			WHERE		A.MEMBER_NO				=	B.MEMBER_NO
			AND		D.TYPE					=	'prize_code'
			AND		C.PRIZE_CODE			=	D.CODE
			AND		LENGTH(C.PRIZE_CODE) < 4	
			AND		A.MEMBER_NO				=	C.MEMBER_NO
			AND		B.MEMBER_OPT			=	:li_member_opt
			AND		B.APPLY_DATE			=	:ls_applydate
			AND		B.APPLY_NO				=	:li_apply_no;
			
Open	get_prize;

Fetch		get_prize
INTO		:ls_from_date, :ls_prize_code, :ls_organ_name;

DO	WHILE		SQLCA.SQLCODE = 0		
		
			IF		i >= 4	THEN
					RETURN	
			END IF	
					tab_1.tabpage_2.dw_print.setitem(1, (6*(i+4))+3, ls_from_date)
					tab_1.tabpage_2.dw_print.setitem(1, (6*(i+4))+4, ls_prize_code)
					tab_1.tabpage_2.dw_print.setitem(1, (6*(i+4))+5, ls_organ_name)					

			
			Fetch		get_prize
			INTO		:ls_from_date, :ls_prize_code, :ls_organ_name;
			i++

LOOP


Close		get_prize;
end subroutine

public subroutine wf_crime_print (integer li_member_opt, string ls_applydate, integer li_apply_no);// 체벌경력 출력

String	ls_from_date, ls_to_date,ls_prize_code, ls_organ_name
Int		i


Declare	get_prize	CURSOR FOR
			SELECT	C.FROM_DATE,D.FNAME, C.ORGAN_NAME
			FROM		INDB.HIN001M A, INDB.HIN013H B, INDB.HIN016H C, CDDB.KCH001M D
			WHERE		A.MEMBER_NO				=	B.MEMBER_NO
			AND		D.TYPE					=	'prize_code'
			AND		C.PRIZE_CODE			=	D.CODE
			AND		LENGTH(C.PRIZE_CODE) >= 4	
			AND		A.MEMBER_NO				=	C.MEMBER_NO
			AND		B.MEMBER_OPT			=	:li_member_opt
			AND		B.APPLY_DATE			=	:ls_applydate
			AND		B.APPLY_NO				=	:li_apply_no;
			
Open	get_prize;

Fetch		get_prize
INTO		:ls_from_date, :ls_prize_code, :ls_organ_name;

DO	WHILE		SQLCA.SQLCODE = 0		
		
			IF		i >= 4	THEN
					RETURN	
			END IF	
					tab_1.tabpage_2.dw_print.setitem(1, (6*(i+5)), ls_from_date)
					tab_1.tabpage_2.dw_print.setitem(1, (6*(i+5))+1, ls_prize_code)
					tab_1.tabpage_2.dw_print.setitem(1, (6*(i+5))+2, ls_organ_name)					

			
			Fetch		get_prize
			INTO		:ls_from_date, :ls_prize_code, :ls_organ_name;
			i++

LOOP


Close		get_prize;
end subroutine

on w_hin501a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
this.dw_con=create dw_con
this.cbx_seq=create cbx_seq
this.uo_member=create uo_member
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.cbx_seq
this.Control[iCurrent+5]=this.uo_member
end on

on w_hin501a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.dw_con)
destroy(this.cbx_seq)
destroy(this.uo_member)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////////
//////	작성목적 : 제증명 자료를 관리한다.
//////	작 성 인 : 전희열
//////	작성일자 : 2002.03
//////	변 경 인 : 
//////	변경일자 : 
//////  변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////////
////// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////////
////// 1.1  조회조건 - 신청기간
////////////////////////////////////////////////////////////////////////////////////////
//em_fr_date.Text = f_today()
////em_to_date.Text = f_lastdate(f_today())
////////////////////////////////////////////////////////////////////////////////////////
////// 1.2 조회조건 - 증명서구분
////////////////////////////////////////////////////////////////////////////////////////
//ddlb_print_opt.Selectitem(1)
////////////////////////////////////////////////////////////////////////////////////////
////// 1.3 조회조건 - 국영문구분
////////////////////////////////////////////////////////////////////////////////////////
//ddlb_lang_opt.Selectitem(1)
////
///////////////////////////////////////////////////////////////////////////////////////////
////// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
////
//////////////////////////////////////////////////////////////////////////////////////////////
//////	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////////
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
//IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt

trigger event ue_retrieve_print()
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
/////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IpAddr		//등록단말기

String	ls_ApplyDate[]	//신청일자
Integer	li_MemberOpt[]	//교직원구분(1:교원,2:직원)
Integer	li_ApplyNo		//신청번호



	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode // gstru_uid_uname.uid		//등록자
	ls_IpAddr    = gs_ip   // gstru_uid_uname.address	//등록단말기


	
			
			
			
			wf_SetMsg('제증명발급대장 신청번호 생성 중입니다.')
			SELECT	NVL(MAX(A.APPLY_NO),0) + 1
			INTO		:li_ApplyNo
			FROM		INDB.HIN013H A
			WHERE		A.APPLY_DATE LIKE SUBSTR(:is_frdate,1,4) || '%'
//			AND		A.MEMBER_OPT = :ii_jikjongcode   /* 2004-01-05 */
			;
			CHOOSE CASE SQLCA.SQLCODE
				CASE 0
				CASE 100
					li_ApplyNo = 1
				CASE ELSE
					MessageBox('오류',&
									'제증명발급대장 신청번호 생성시 전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
					ROLLBACK USING SQLCA;
					RETURN -1
			END CHOOSE
		
///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')

			INSERT INTO INDB.HIN013H(		APPLY_DATE,		MEMBER_OPT, 	APPLY_NO, MEMBER_NO, 	
							APPLY_NAME, PRINT_OPT, 	LANG_OPT, 	PRINT_NUM, 		
							USE_OPT, 	NAME_ENG, PRICE,TOTAL_AMT,WORKER, 	WORK_DATE, 	IPADDR, 	
							JOB_UID, JOB_ADD,JOB_DATE)			
			VALUES(:is_frdate,:is_jikjongcode,:li_ApplyNo,:is_applyno,
					:is_name,:ii_printopt,	:ii_langopt, :id_num,
					:is_remark, NULL,:id_price, :id_price*:id_num,:ls_Worker,:ldt_WorkDate,:ls_IpAddr,
					:ls_Worker,:ls_IpAddr, :ldt_WorkDate);
						
IF		SQLCA.SQLCODE  = -1		THEN
		ROLLBACK;
		wf_setmsg("저장중 오류가 발생하였습니다.")
		RETURN -1
ELSE
		COMMIT;
		wf_setmsg("자료가 저장되었습니다.")
		RETURN 1		
END IF	
	


///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////

wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSRP')

RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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
tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
tab_1.tabpage_2.dw_print.Reset()
tab_1.tabpage_2.dw_print.InsertRow(0)
tab_1.tabpage_2.dw_print.SetReDraw(TRUE)
idw_print = tab_1.tabpage_2.dw_print

/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('IRP')
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
//// 1. 삭제할 데이타원도우의 선택여부 체크.
/////////////////////////////////////////////////////////////////////////////////////////
//Long		ll_GetRow
//IF tab_1.tabpage_1.dw_update.ib_RowSingle THEN ll_GetRow = tab_1.tabpage_1.dw_update.GetRow()
//IF NOT tab_1.tabpage_1.dw_update.ib_RowSingle THEN ll_GetRow = tab_1.tabpage_1.dw_update.GetSelectedRow(0)
//IF ll_GetRow = 0 THEN RETURN
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 삭제메세지 처리.
////		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_Msg
//Integer	li_Rtn
//Long		ll_DeleteCnt
//
//
//IF tab_1.tabpage_1.dw_update.ib_RowSingle OR tab_1.tabpage_1.dw_update.GetSelectedRow(ll_GetRow) = 0 THEN
//	/////////////////////////////////////////////////////////////////////////////////
//	// 2.1 삭제전 체크사항 기술
//	/////////////////////////////////////////////////////////////////////////////////
//	
//	/////////////////////////////////////////////////////////////////////////////////
//	// 2.2 삭제메세지 처리부분
//	/////////////////////////////////////////////////////////////////////////////////
//	String	ls_ApplyDate		//신청일자
//	String	ls_MemberOpt		//구분
//	Integer	li_ApplyNo			//신청번호
//	
//	ls_ApplyDate = tab_1.tabpage_1.dw_update.Object.apply_date[ll_GetRow]	//신청일자
//	ls_MemberOpt = tab_1.tabpage_1.dw_update.&
//					Describe("Evaluate('LookUpDisplay(member_opt)',"+String(ll_GetRow)+")")
//	li_ApplyNo   = tab_1.tabpage_1.dw_update.Object.apply_no  [ll_GetRow]	//신청번호
//	
//	ls_Msg = '개인번호 : '+String(ls_ApplyDate,'@@@@/@@/@@')+'~r~n'+&
//				'구      분 : '+ls_MemberOpt+'~r~n'+&
//				'신청번호 : '+String(li_ApplyNo)
//ELSE
////	SetNull(ls_Msg)
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 삭제처리.
/////////////////////////////////////////////////////////////////////////////////////////
//ll_DeleteCnt = tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
//IF ll_DeleteCnt > 0 THEN
//	wf_SetMsg('자료가 삭제되었습니다.')
//	IF tab_1.tabpage_1.dw_update.ib_RowSingle THEN
//		/////////////////////////////////////////////////////////////////////////////
//		// 3.1 Single 처리인 경우.
//		//			3.1.1 저장처리.
//		//			3.1.2 한로우를 다시 추가.
//		//			3.1.3 데이타원도우를 읽기모드로 수정.
//		/////////////////////////////////////////////////////////////////////////////
//		IF tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_save() THEN
//			tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_append()
//			tab_1.tabpage_1.dw_update.Object.DataWindow.ReadOnly = 'YES'
//			wf_SetMenuBtn('IR')
//		END IF
//	ELSE
//		/////////////////////////////////////////////////////////////////////////////
//		//	3.2 Multi 처리인 경우.
//		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
//		/////////////////////////////////////////////////////////////////////////////
//		IF tab_1.tabpage_1.dw_update.RowCount() > 0 THEN
//			wf_SetMenuBtn('IDSR')
//		ELSE
//			wf_SetMenuBtn('ISR')
//		END IF
//	END IF
//ELSE
//END IF
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
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
//IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료추가
/////////////////////////////////////////////////////////////////////////////////////////
//Long	 ll_InsRow
//ll_InsRow = tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_new()
//IF ll_InsRow = 0 THEN RETURN
//////////////////////////////////////////////////////////////////////////////////////
//// 2.1 개인번호 자동생성여부 체크
//////////////////////////////////////////////////////////////////////////////////////
//Boolean	lb_Chk
//lb_Chk = cbx_seq.Checked
//IF lb_Chk THEN
//	tab_1.tabpage_1.dw_update.Object.apply_no.protect = '1'
//	tab_1.tabpage_1.dw_update.Object.apply_no.background.color = 536870912
//ELSE
//	tab_1.tabpage_1.dw_update.Object.apply_no.protect = '0'
//	tab_1.tabpage_1.dw_update.Object.apply_no.background.color = RGB(255,255,255)
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
////			사용하지 안을경우는 커맨트 처리
//
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_SysDate
//ls_SysDate = f_today()
//tab_1.tabpage_1.dw_update.Object.apply_date[ll_InsRow] = ls_SysDate			//신청일자
//tab_1.tabpage_1.dw_update.Object.member_opt[ll_InsRow] = ii_JikJongCode	//교직원구분
//tab_1.tabpage_1.dw_update.Object.print_opt [ll_InsRow] = ii_PrintOpt		//증명서종류
//tab_1.tabpage_1.dw_update.Object.lang_opt  [ll_InsRow] = ii_LangOpt			//국영문구분
//tab_1.tabpage_1.dw_update.Object.print_num [ll_InsRow] = 1						//매수
//tab_1.tabpage_1.dw_update.SetItemStatus(ll_InsRow,0,Primary!,NotModified!)
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우호 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('IDSR')
//ddlb_print_opt.Enabled = FALSE
//ddlb_lang_opt.Enabled = FALSE
//wf_SetMsg('자료가 추가되었습니다.')
//tab_1.tabpage_1.dw_update.SetColumn('apply_date')
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 이인갑
////	작성/수정일: 2004-01-08
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//tab_1.SelectTab(2)
//f_print(tab_1.tabpage_2.dw_print)
//
///* 2004-01-06  수정  */
////Integer	i
////Long		rtn_save
////
////IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN
////
////tab_1.tabpage_2.dw_print.SETREDRAW(FALSE)
////FOR I = 1 TO id_num
////	tab_1.tabpage_2.dw_print.SETREDRAW(FALSE)
////	trigger event ue_retrieve_print()
////	
////	rtn_save	=	trigger event ue_save(0,0)
////	IF	rtn_save = 1	THEN
////		tab_1.tabpage_2.dw_print.print()
////	ELSE
////		wf_setmsg("증명신청 저장중 오류가 발생하엿습니다.")
////	END IF
////	tab_1.tabpage_2.dw_print.print()
////	tab_1.tabpage_2.dw_print.SETREDRAW(TRUE)	
////	
////NEXT
////tab_1.tabpage_2.dw_print.SETREDRAW(TRUE)
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 제증명 자료를 관리한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
////  변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1  조회조건 - 신청기간
//////////////////////////////////////////////////////////////////////////////////////
//dw_con.insertrow(0)

dw_con.object.fr_date[1] = f_today()
//em_to_date.Text = f_lastdate(f_today())
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 증명서구분
//////////////////////////////////////////////////////////////////////////////////////
//ddlb_print_opt.Selectitem(1)
dw_con.object.print_opt[1] = '1. 재직'
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 조회조건 - 국영문구분
//////////////////////////////////////////////////////////////////////////////////////
//ddlb_lang_opt.Selectitem(1)
dw_con.object.lang_opt[1] = '1. 국문'
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화
/////////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
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

type ln_templeft from w_msheet`ln_templeft within w_hin501a
end type

type ln_tempright from w_msheet`ln_tempright within w_hin501a
end type

type ln_temptop from w_msheet`ln_temptop within w_hin501a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin501a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin501a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin501a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin501a
end type

type uc_insert from w_msheet`uc_insert within w_hin501a
end type

type uc_delete from w_msheet`uc_delete within w_hin501a
end type

type uc_save from w_msheet`uc_save within w_hin501a
end type

type uc_excel from w_msheet`uc_excel within w_hin501a
end type

type uc_print from w_msheet`uc_print within w_hin501a
end type

type st_line1 from w_msheet`st_line1 within w_hin501a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_msheet`st_line2 within w_hin501a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_msheet`st_line3 within w_hin501a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin501a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin501a
integer beginy = 356
integer endy = 356
end type

type tab_1 from tab within w_hin501a
integer x = 50
integer y = 412
integer width = 4384
integer height = 1852
integer taborder = 90
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
alignment alignment = center!
integer selectedtab = 1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_2)
end on

event selectionchanged;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: selectionchanged::tab_1
//	기 능 설 명: 제증명신청 출력자료 조회처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
IF oldindex = 1 AND newindex = 2 THEN PARENT.TRIGGER EVENT ue_retrieve_print()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1732
long backcolor = 16777215
string text = "제증명신청 출력"
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
integer x = 9
integer y = 8
integer width = 4338
integer height = 1724
integer taborder = 20
string dataobject = "d_hin501a_11"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from u_tab within w_hin501a
event destroy ( )
integer x = 1079
integer y = 428
integer taborder = 80
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type dw_con from uo_dwfree within w_hin501a
integer x = 50
integer y = 164
integer width = 4379
integer height = 192
integer taborder = 20
string dataobject = "d_hin501a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
This.insertrow(0)

uo_member.setposition(totop!)
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
ls_UserID =  gs_empcode //TRIM(gstru_uid_uname.uid)			//로그인사번
IF LEN(ls_UserID) = 0 THEN
	li_JikJongCode = 1
	RETURN -1
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

This.object.gubn[1] = string(li_JikJongCode)
//THIS.SelectItem(li_JikJongCode)
If lb_Groupchk = FALSE  Then 
	This.object.gubn.protect = 1
Else
	This.object.gubn.protect = 0
eND iF
//THIS.Enabled = lb_GroupChk

//uo_member.is_JikJongCode = String(li_JikJongCode)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type cbx_seq from checkbox within w_hin501a
boolean visible = false
integer x = 2565
integer y = 276
integer width = 896
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "신청번호 자동 생성시 선택"
boolean checked = true
end type

type uo_member from cuo_insa_member within w_hin501a
event destroy ( )
integer x = 1609
integer y = 172
integer taborder = 100
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

