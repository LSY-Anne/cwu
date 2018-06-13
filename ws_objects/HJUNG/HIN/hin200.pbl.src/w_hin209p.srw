$PBExportHeader$w_hin209p.srw
$PBExportComments$인사기록카드일괄출력
forward
global type w_hin209p from w_msheet
end type
type dw_print from cuo_dwprint within w_hin209p
end type
type dw_list1 from cuo_dwwindow_one_hin within w_hin209p
end type
type dw_con from uo_dwfree within w_hin209p
end type
type uo_member from cuo_insa_member within w_hin209p
end type
end forward

global type w_hin209p from w_msheet
integer height = 2616
string title = "인사기본정보관리"
dw_print dw_print
dw_list1 dw_list1
dw_con dw_con
uo_member uo_member
end type
global w_hin209p w_hin209p

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

on w_hin209p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.dw_list1=create dw_list1
this.dw_con=create dw_con
this.uo_member=create uo_member
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.dw_list1
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_member
end on

on w_hin209p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.dw_list1)
destroy(this.dw_con)
destroy(this.uo_member)
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
//////////////////////////////////////////////////////////////////////////////////////
//// 1.1 성별코드 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//////f_dis_msg(1,'공통코드[인사기본정보_성별구분]를 초기화 중입니다...','')
////idw_update[01].GetChild('sex_code',ldwc_Temp)
////ldwc_Temp.SetTransObject(SQLCA)
////IF ldwc_Temp.Retrieve('sex_code',0) = 0 THEN
////	wf_setmsg('공통코드[성별]를 입력하시기 바랍니다.')
////	ldwc_Temp.InsertRow(0)
////END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 1.4 조직코드 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.14 병과DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_병과코드]를 초기화 중입니다...','')
//dw_print.GetChild('byungkwa',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('byungkwa',0) = 0 THEN
//	wf_setmsg('공통코드[계급]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.14 계급DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_계급코드]를 초기화 중입니다...','')
//dw_print.GetChild('army_rank',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('gegub_code',0) = 0 THEN
//	wf_setmsg('공통코드[계급]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.14 주특기DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_미필사유]를 초기화 중입니다...','')
//dw_print.GetChild('speciality',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('speciality',0) = 0 THEN
//	wf_setmsg('공통코드[미필사유]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 2.1 종교 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[신상상세정보_종교코드]를 초기화 중입니다...','')
//dw_print.GetChild('jonggyo_code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jonggyo_code',0) = 0 THEN
//	wf_setmsg('공통코드[종교]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 2.5 특기 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[신상상세정보_특기구분]를 초기화 중입니다...','')
//dw_print.GetChild('specialty',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('specialty_opt',0) = 0 THEN
//	wf_setmsg('공통코드[특기]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//
//////////////////////////////////////////////////////////////////////////////////////
//// 2.7 주거 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[신상상세정보_주거구분]를 초기화 중입니다...','')
//dw_print.GetChild('house_code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('house_code',0) = 0 THEN
//	wf_setmsg('공통코드[주거]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 1.10 최종학력DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_학력구분]를 초기화 중입니다...','')
//dw_print.GetChild('last_school_code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('last_school_code',0) = 0 THEN
//	wf_setmsg('공통코드[학력]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 1.4 조직코드 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'인사기본정보_조직코드를 초기화 중입니다...','')
//dw_print.GetChild('gwa',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('%') = 0 THEN
//	wf_setmsg('조직코드를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.5 직위구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_직위코드]를 초기화 중입니다...','')
//dw_print.GetChild('jikwi_code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('jikwi_code',0) = 0 THEN
//	wf_setmsg('공통코드[직위]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 1.12 역종DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_역종코드]를 초기화 중입니다...','')
//dw_print.GetChild('military_kind',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('yukjong_code',0) = 0 THEN
//	wf_setmsg('공통코드[역종]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//
//END IF
//////////////////////////////////////////////////////////////////////////////////////
//// 1.13 군별DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_군별코드]를 초기화 중입니다...','')
//dw_print.GetChild('army_kind',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('isarmy_code',0) = 0 THEN
//	wf_setmsg('공통코드[군별]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.14 미필사유DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_미필사유]를 초기화 중입니다...','')
//dw_print.GetChild('none_remark',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('none_remark',0) = 0 THEN
//	wf_setmsg('공통코드[미필사유]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//
//////////////////////////////////////////////////////////////////////////////////////
//// 1.14  체격등급DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_체겨등급]를 초기화 중입니다...','')
//dw_print.GetChild('physical_grade',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('physical_grade',0) = 0 THEN
//	wf_setmsg('공통코드[미필사유]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_list1.GetChild('duty_code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve() = 0 THEN
//	wf_setmsg('직급코드를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//end if
//
//dw_list1.sharedata(dw_print)
/////////////////////////////////////////////////////////////////////////////////////////
//// 11.  초기화 이벤트 호출
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_retrieve
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
ls_JikJongCode = dw_con.object.gubn[1]// MID(ddlb_gubn.Text,1,1)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_list1.SetReDraw(FALSE)
ll_RowCnt = dw_list1.Retrieve(ls_DeptCode,ls_DutyCode,ls_KName,ls_JaejikOpt,ls_JikJongCode)
dw_list1.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN
//	wf_SetMenuBtn('IRP')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
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
// 1.1 자료추가전 필수입력사항 체크
////////////////////////////////////////////////////////////////////////////////////
Integer	li_SelectedTab
////////////////////////////////////////////////////////////////////////////////////
// 1.2 입력조건 체크
////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회조건 체크 중입니다...')
/////////////////////////////////////////////////////////////////////////////////
// 1.2.1 직종명 입력여부 체크
/////////////////////////////////////////////////////////////////////////////////
dw_con.accepttext()
String	ls_DutyCode
ls_DutyCode = TRIM(dw_con.Object.duty_code[1])
IF LEN(ls_DutyCode) = 0 OR isNull(ls_DutyCode) OR ls_DutyCode = '0' THEN &
	ls_DutyCode = ''
/////////////////////////////////////////////////////////////////////////////////
// 1.2.2 성명 입력여부 체크
/////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)


///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_InsRow
Long		ll_idx
////////////////////////////////////////////////////////////////////////////////////
// 2.1 개인번호 자동생성여부 체크
////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_SysDate
Integer	li_ChangeOpt
String	ls_ColName
Integer	li_NationCode

ls_SysDate = f_today()
///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우로 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 추가되었습니다.')
//wf_SetMenuBtn('IDSR')
idw_update[li_SelectedTab].SetColumn(ls_ColName)
idw_update[li_SelectedTab].SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 현재선택된 데이타원도우의 체크.
///////////////////////////////////////////////////////////////////////////////////////
Integer	li_SelectedTab

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
IF li_SelectedTab > 2 THEN
	IF li_SelectedTab = 9 OR li_SelectedTab = 10 OR li_SelectedTab = 11 THEN
		wf_SetMsg('이력자료는 조회만 가능합니다.')
		MessageBox('확인','이력자료는 조회만 가능합니다.')
		RETURN
	END IF
	
	ll_GetRow = idw_update[li_SelectedTab].getrow()

	IF ll_GetRow = 0 THEN
		wf_SetMsg('삭제할 자료가 없습니다.')
		RETURN
	END IF
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn

String	ls_MemberNo		//개인번호
String	ls_KName			//성명
String	ls_JuminNo		//주민번호
String	ls_FromDate		//시작일자
String	ls_CertifyNo	//자격번호
String	ls_PrizeCode	//상벌코드
String	ls_AppointCode	//보직코드
Integer	li_SeqNo			//순번

ls_MemberNo = TRIM(idw_update[1].Object.member_no[1])	//개인번호
ls_KName    = TRIM(idw_update[1].Object.name     [1])	//성명
IF LEN(ls_MemberNo) = 0 OR isNull(ls_MemberNo) THEN RETURN
IF LEN(ls_KName) = 0 OR isNull(ls_KName) THEN ls_KName = ''

ls_Msg = is_SubTitle[li_SelectedTab]+' 자료를 삭제하시겠습니까?'

CHOOSE CASE li_SelectedTab
	CASE 1
		ls_Msg += '~r~n~r~n'+&
					 '개인번호 : '+ls_MemberNo+'~r~n'+&
					 '성      명 : '+ls_KName+'~r~n~r~n'+&
					 '인사기본정보 삭제시 관련된 모든자료가 삭제됩니다.~r~n'+&
					 '삭제후 저장하시기 바랍니다.'
	CASE 2			
		ls_Msg += '~r~n~r~n'+&
					 '개인번호 : '+ls_MemberNo+'~r~n'+&
					 '성      명 : '+ls_KName
	CASE ELSE
		IF idw_update[li_SelectedTab].getrow() = 0 THEN
			//////////////////////////////////////////////////////////////////////////////
			// 2.1 삭제전 체크사항 기술
			//////////////////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////////////////
			// 2.2 삭제메세지 처리부분
			//////////////////////////////////////////////////////////////////////////////
			ls_Msg += '~r~n~r~n'+&
						 '개인번호 : '+ls_MemberNo+'~r~n'+&
						 '성      명 : '+ls_KName+'~r~n'
			CHOOSE CASE li_SelectedTab
				CASE 3
					////////////////////////////////////////////////////////////////////////
					// 2.2.2 가족사항
					////////////////////////////////////////////////////////////////////////
					ls_JuminNo = idw_update[li_SelectedTab].Object.jumin_no[ll_GetRow]
					ls_Msg += '주민번호 : ' + String(ls_JuminNo,'@@@@@@-@@@@@@@')
				CASE 4
					////////////////////////////////////////////////////////////////////////
					// 2.2.3 학력사항
					////////////////////////////////////////////////////////////////////////
					ls_FromDate = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
					ls_Msg += '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')
				CASE 5
					////////////////////////////////////////////////////////////////////////
					// 2.2.4 경력사항
					////////////////////////////////////////////////////////////////////////
					li_SeqNo = idw_update[li_SelectedTab].Object.career_seq[ll_GetRow]
					ls_Msg += '순      번 : ' + String(li_SeqNo)
				CASE 6
					////////////////////////////////////////////////////////////////////////
					// 2.2.5 자격사항
					////////////////////////////////////////////////////////////////////////
					ls_CertifyNo = idw_update[li_SelectedTab].Object.certify_no[ll_GetRow]
					ls_Msg += '자격번호 : ' + ls_CertifyNo
				CASE 7
					////////////////////////////////////////////////////////////////////////
					// 2.2.6 포상.징계사항
					////////////////////////////////////////////////////////////////////////
					ls_PrizeCode = idw_update[li_SelectedTab].&
						Describe("Evaluate('LookUpDisplay(prize_code)',"+String(ll_GetRow)+")")
					ls_FromDate  = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
					ls_Msg += '상벌구분 : ' + ls_PrizeCode+'~r~n'+&
								 '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')
				CASE 8
					////////////////////////////////////////////////////////////////////////
					// 2.2.7 해외연수사항
					////////////////////////////////////////////////////////////////////////
					ls_FromDate = idw_update[li_SelectedTab].Object.from_date[ll_GetRow]
					ls_Msg += '시작일자 : ' + String(ls_FromDate,'@@@@/@@/@@')
			END CHOOSE
		ELSE
			ls_Msg = is_SubTitle[li_SelectedTab]+' 자료를 삭제하시겠습니까?'
		END IF
END CHOOSE

li_Rtn = MessageBox('확인',ls_Msg,Question!,YesNo!,2)
IF li_Rtn = 2 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
Long	ll_idx

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
wf_SetMsg('')
//wf_SetMenuBtn('IRP')
uo_member.sle_kname.SetFocus()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_print;call super::ue_print;


IF 	dw_print.rowcount() > 0		then
		F_PRINT(dw_print)
END IF 	

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
dw_con.insertrow(0)
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 부서명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp,ldwc_Temp1
Long					ll_InsRow
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

////////////////////////////////////////////////////////////////////////////////////
// 1.1 성별코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
////f_dis_msg(1,'공통코드[인사기본정보_성별구분]를 초기화 중입니다...','')
//idw_update[01].GetChild('sex_code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('sex_code',0) = 0 THEN
//	wf_setmsg('공통코드[성별]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.4 조직코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////
// 1.14 병과DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_병과코드]를 초기화 중입니다...','')
dw_print.GetChild('byungkwa',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('byungkwa',0) = 0 THEN
	wf_setmsg('공통코드[계급]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

////////////////////////////////////////////////////////////////////////////////////
// 1.14 계급DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_계급코드]를 초기화 중입니다...','')
dw_print.GetChild('army_rank',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('gegub_code',0) = 0 THEN
	wf_setmsg('공통코드[계급]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

////////////////////////////////////////////////////////////////////////////////////
// 1.14 주특기DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_미필사유]를 초기화 중입니다...','')
dw_print.GetChild('speciality',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('speciality',0) = 0 THEN
	wf_setmsg('공통코드[미필사유]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 2.1 종교 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[신상상세정보_종교코드]를 초기화 중입니다...','')
dw_print.GetChild('jonggyo_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jonggyo_code',0) = 0 THEN
	wf_setmsg('공통코드[종교]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 2.5 특기 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[신상상세정보_특기구분]를 초기화 중입니다...','')
dw_print.GetChild('specialty',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('specialty_opt',0) = 0 THEN
	wf_setmsg('공통코드[특기]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

////////////////////////////////////////////////////////////////////////////////////
// 2.7 주거 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[신상상세정보_주거구분]를 초기화 중입니다...','')
dw_print.GetChild('house_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('house_code',0) = 0 THEN
	wf_setmsg('공통코드[주거]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.10 최종학력DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_학력구분]를 초기화 중입니다...','')
dw_print.GetChild('last_school_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('last_school_code',0) = 0 THEN
	wf_setmsg('공통코드[학력]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.4 조직코드 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'인사기본정보_조직코드를 초기화 중입니다...','')
dw_print.GetChild('gwa',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('조직코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

////////////////////////////////////////////////////////////////////////////////////
// 1.5 직위구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_직위코드]를 초기화 중입니다...','')
dw_print.GetChild('jikwi_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('jikwi_code',0) = 0 THEN
	wf_setmsg('공통코드[직위]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.12 역종DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_역종코드]를 초기화 중입니다...','')
dw_print.GetChild('military_kind',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('yukjong_code',0) = 0 THEN
	wf_setmsg('공통코드[역종]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)

END IF
////////////////////////////////////////////////////////////////////////////////////
// 1.13 군별DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_군별코드]를 초기화 중입니다...','')
dw_print.GetChild('army_kind',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('isarmy_code',0) = 0 THEN
	wf_setmsg('공통코드[군별]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

////////////////////////////////////////////////////////////////////////////////////
// 1.14 미필사유DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_미필사유]를 초기화 중입니다...','')
dw_print.GetChild('none_remark',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('none_remark',0) = 0 THEN
	wf_setmsg('공통코드[미필사유]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

////////////////////////////////////////////////////////////////////////////////////
// 1.14  체격등급DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
//f_dis_msg(1,'공통코드[인사기본정보_체겨등급]를 초기화 중입니다...','')
dw_print.GetChild('physical_grade',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('physical_grade',0) = 0 THEN
	wf_setmsg('공통코드[미필사유]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
dw_list1.GetChild('duty_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('직급코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
end if

dw_list1.sharedata(dw_print)
///////////////////////////////////////////////////////////////////////////////////////
// 11.  초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin209p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin209p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin209p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin209p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin209p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin209p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin209p
end type

type uc_insert from w_msheet`uc_insert within w_hin209p
end type

type uc_delete from w_msheet`uc_delete within w_hin209p
end type

type uc_save from w_msheet`uc_save within w_hin209p
end type

type uc_excel from w_msheet`uc_excel within w_hin209p
end type

type uc_print from w_msheet`uc_print within w_hin209p
end type

type st_line1 from w_msheet`st_line1 within w_hin209p
end type

type st_line2 from w_msheet`st_line2 within w_hin209p
end type

type st_line3 from w_msheet`st_line3 within w_hin209p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin209p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin209p
integer beginy = 344
integer endy = 344
end type

type dw_print from cuo_dwprint within w_hin209p
boolean visible = false
integer x = 3310
integer y = 80
integer width = 178
integer height = 140
integer taborder = 80
string dataobject = "d_hin209p_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_list1 from cuo_dwwindow_one_hin within w_hin209p
integer x = 55
integer y = 360
integer width = 4379
integer height = 1908
integer taborder = 70
string dataobject = "d_hin209p_01"
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
//Long		ll_GetRow
//Long		ll_RowCnt
//ll_GetRow = newrow
//IF ll_GetRow = 0 THEN RETURN
//ll_RowCnt = THIS.RowCount()
//IF ll_RowCnt = 0 THEN
//	idw_update[01].SetReDraw(FALSE)
//	idw_update[01].Reset()
//	idw_update[01].InsertRow(0)
//	idw_update[01].Object.DataWindow.ReadOnly = 'YES'
//	idw_update[01].SetReDraw(TRUE)
//
//	idw_update[02].SetReDraw(FALSE)
//	idw_update[02].Reset()
//	idw_update[02].InsertRow(0)
//	idw_update[02].Object.DataWindow.ReadOnly = 'YES'
//	idw_update[02].SetReDraw(TRUE)
//	RETURN
//END IF
/////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_MemberNo			//개인번호
//ls_MemberNo = dw_list1.Object.hin001m_member_no[ll_GetRow]
//
//
//SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMsg('[인사기본정보] 조회중입니다...')
//idw_update[01].SetReDraw(FALSE)
//idw_update[01].Reset()
//ll_RowCnt = idw_update[01].Retrieve(ls_MemberNo)
//		
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
/////////////////////////////////////////////////////////////////////////////////////////
//IF ll_RowCnt > 0 THEN
//	////////////////////////////////////////////////////////////////////////////////////
//	//	3.1 호봉코드DDDW 초기화 처리
//	////////////////////////////////////////////////////////////////////////////////////
//	String	ls_SalYear		//호봉년도
//	String	ls_DutyCode		//직급코드
//	Integer	li_AnnOpt		//연봉구분
//	
//	ls_SalYear  = idw_update[01].Object.sal_year [1]
//	ls_DutyCode = idw_update[01].Object.duty_code[1]
//	li_AnnOpt   = idw_update[01].Object.ann_opt  [1]
//	IF MID(ls_DutyCode,1,1) = '1' THEN ls_DutyCode = '100'
//	IF li_AnnOpt = 2 THEN ls_DutyCode = '801'
//	idwc_SalClass.Reset()
//	IF idwc_SalClass.Retrieve(ls_SalYear,ls_DutyCode) = 0 THEN
//		wf_setmsg('호봉코드를 입력하시기 바랍니다.')
//		idwc_SalClass.InsertRow(0)
//	END IF
//	////////////////////////////////////////////////////////////////////////////////////
//	// 3.2 인사이미지정보 조회처리
//	////////////////////////////////////////////////////////////////////////////////////
//	Blob	lbo_Image
//	SELECTBLOB	A.MEMBER_IMG
//	INTO			:lbo_Image
//	FROM			INDB.HIN026M A
//	WHERE			A.MEMBER_NO = :ls_MemberNo;
//	IF SQLCA.SQLCODE <> 0 THEN
//		SetNull(lbo_Image)
//		tab_1.tabpage_1.p_image.picturename = "../bmp/blank.bmp"
//	END IF
//	tab_1.tabpage_1.p_image.SetPicture(lbo_Image)
//	////////////////////////////////////////////////////////////////////////////////////
//	// 3.3 신상상제정보 조회처리
//	////////////////////////////////////////////////////////////////////////////////////
//	idw_update[02].SetReDraw(FALSE)
//	idw_update[02].Reset()
//	ll_RowCnt = idw_update[02].Retrieve(ls_MemberNo)
//	IF ll_RowCnt > 0 THEN
//		idw_update[02].Object.DataWindow.ReadOnly = 'NO'
//	ELSE
//		idw_update[02].InsertRow(0)
//		idw_update[02].Object.DataWindow.ReadOnly = 'YES'
//	END IF
//	idw_update[02].SetReDraw(TRUE)
//	////////////////////////////////////////////////////////////////////////////////////
//	// 3.4 각세부자료 조회처리
//	////////////////////////////////////////////////////////////////////////////////////
//	Integer	li_idx
//	String	ls_Msg
//	FOR li_idx = 3 TO UpperBound(idw_update)
//		ls_Msg = is_SubTitle[li_idx]
//		wf_SetMsg(ls_Msg + ' 조회중입니다...')
//		idw_update[li_idx].SetReDraw(FALSE)
//		ll_RowCnt = idw_update[li_idx].Retrieve(ls_MemberNo)
//		idw_update[li_idx].SetReDraw(TRUE)
//	NEXT
//	////////////////////////////////////////////////////////////////////////////////////
//	// 3.5 인사발령사항에 결재건수 한건이라도 있으면 변경불가처리
//	////////////////////////////////////////////////////////////////////////////////////
//	Integer	li_Cnt	//결재건수
//	SELECT	COUNT(A.SEQ_NO)
//	INTO		:li_Cnt
//	FROM		INDB.HIN007H A
//	WHERE		A.MEMBER_NO = :ls_MemberNo
//	AND		A.SIGN_OPT  > 1;
//	IF li_Cnt > 0 THEN
//		wf_SetMsg('결재처리되어 변경할 수가 없습니다.')
//		idw_update[01].Object.DataWindow.ReadOnly = 'YES'
//		wf_SetMenuBtn('R')
////////나중에 삭제처리========================================
//		wf_SetMenuBtn('IDSRP')
//		idw_update[01].Object.DataWindow.ReadOnly = 'NO'
//	ELSE
//		wf_SetMsg('[인사기본정보] 자료가 조회되었습니다.')
//		idw_update[01].Object.DataWindow.ReadOnly = 'NO'
//		wf_SetMenuBtn('IDSRP')
//	END IF
//ELSE
//	idw_update[01].InsertRow(0)
//	idw_update[01].Object.DataWindow.ReadOnly = 'YES'
//	
//	idw_update[02].SetReDraw(FALSE)
//	idw_update[02].InsertRow(0)
//	idw_update[02].Object.DataWindow.ReadOnly = 'YES'
//	idw_update[02].SetReDraw(TRUE)
//
//	wf_SetMenuBtn('R')	
//	wf_SetMsg('[인사기본정보] 해당 자료가 존재하지 않습니다.')
//END IF
//idw_update[01].SetReDraw(TRUE)
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

event constructor;call super::constructor;////ib_RowSelect = false
//ib_RowSingle = TRUE
//ib_SortGubn  = TRUE
//ib_EnterChk  = FALSE
end event

type dw_con from uo_dwfree within w_hin209p
integer x = 55
integer y = 164
integer width = 4379
integer height = 180
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hin202a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin209p
event destroy ( )
integer x = 1531
integer y = 256
integer taborder = 70
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

