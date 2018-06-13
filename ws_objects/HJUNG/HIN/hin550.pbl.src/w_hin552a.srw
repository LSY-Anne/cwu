$PBExportHeader$w_hin552a.srw
$PBExportComments$개인별년가사용 등록/출력
forward
global type w_hin552a from w_msheet
end type
type em_yearmonth from editmask within w_hin552a
end type
type st_2 from statictext within w_hin552a
end type
type uo_member from cuo_insa_member within w_hin552a
end type
type dw_update from cuo_dwwindow_one_hin within w_hin552a
end type
type gb_1 from groupbox within w_hin552a
end type
end forward

global type w_hin552a from w_msheet
string title = "개인별년가사용 등록/출력"
em_yearmonth em_yearmonth
st_2 st_2
uo_member uo_member
dw_update dw_update
gb_1 gb_1
end type
global w_hin552a w_hin552a

type variables
DataWindowChild	idw_JikJong
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

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

on w_hin552a.create
int iCurrent
call super::create
this.em_yearmonth=create em_yearmonth
this.st_2=create st_2
this.uo_member=create uo_member
this.dw_update=create dw_update
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_yearmonth
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.uo_member
this.Control[iCurrent+4]=this.dw_update
this.Control[iCurrent+5]=this.gb_1
end on

on w_hin552a.destroy
call super::destroy
destroy(this.em_yearmonth)
destroy(this.st_2)
destroy(this.uo_member)
destroy(this.dw_update)
destroy(this.gb_1)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 개인별로 연가자료를 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
em_yearmonth.Text = MID(gstru_uid_uname.current_day,1,6)
dw_update.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)//조회버튼 활성화

uo_member.sle_kname.SetFocus()
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
// 1.1 기준년도 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_YearMonth
em_yearmonth.GetData(ls_YearMonth)
ls_YearMonth = TRIM(ls_YearMonth)
IF LEN(ls_YearMonth) = 0 THEN
	MessageBox('확인','기준년월을 입력하시기 바랍니다.')
	em_yearmonth.SetFocus()
	RETURN -1
END IF
String	ls_Year
String	ls_Month
ls_Year  = MID(ls_YearMonth,1,4)
ls_Month = MID(ls_YearMonth,5,2)

////////////////////////////////////////////////////////////////////////////////////
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(ls_Year,ls_Month,ls_KName)
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('S',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	em_yearmonth.Enabled = TRUE
	uo_member.sle_kname.SetFocus()
ELSE
//	wf_SetMenu('S',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	em_yearmonth.Enabled = FALSE
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
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 필수입력항목 CHECK
///////////////////////////////////////////////////////////////////////////////////////
String	ls_YearMonth
em_yearmonth.GetData(ls_YearMonth)
ls_YearMonth = TRIM(ls_YearMonth)
IF LEN(ls_YearMonth) = 0 THEN
	MessageBox('확인','기준년월을 입력하시기 바랍니다.')
	em_yearmonth.SetFocus()
	RETURN -1
END IF
String	ls_Year				//년도
String	ls_Month				//월
ls_Year  = MID(ls_YearMonth,1,4)
ls_Month = MID(ls_YearMonth,5,2)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 변경여부 CHECK
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
// 3. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'com_member_no/개인번호'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 4. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_Row				//변경된 행
DateTime	ldt_WorkDate		//등록일자
String	ls_Worker			//등록자
String	ls_IPAddr			//등록단말기

String	ls_MemberNo			//개인번호
Integer	li_UseDay			//년가사용
Integer	li_MonDay			//월차일수
Integer	li_MenseDay			//생리일수
Integer	li_DatDay			//토요일수
Integer	li_LateDay			//지참일수
Integer	li_CutDay			//조퇴일수
Integer	li_AbsentDay		//결근일수
Integer	li_OutDay			//출장일수
Integer	li_SpaceDay			//공가일수
Integer	li_SpecialDay		//특휴일수
Integer	li_SeakDay			//병가일수
Integer	li_Etc1Day			//기타1일수
Integer	li_Etc2Day			//기타2일수
String	ls_Remark			//비고

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gstru_uid_uname.uid			//등록자
	ls_IPAddr    = gstru_uid_uname.address		//등록단말기
END IF
END IF
DO WHILE ll_Row > 0
	ls_MemberNo    = dw_update.Object.com_member_no[ll_Row]	//개인번호
	li_UseDay      = dw_update.Object.use_day      [ll_Row]	//년가사용
	li_MonDay      = dw_update.Object.mon_day      [ll_Row]	//월차일수
	li_MenseDay    = dw_update.Object.mense_day    [ll_Row]	//생리일수
	li_DatDay      = dw_update.Object.dat_day      [ll_Row]	//토요일수
	li_LateDay     = dw_update.Object.late_day     [ll_Row]	//지참일수
	li_CutDay      = dw_update.Object.cut_day      [ll_Row]	//조퇴일수
	li_AbsentDay   = dw_update.Object.absent_day   [ll_Row]	//결근일수
	li_OutDay      = dw_update.Object.out_day      [ll_Row]	//출장일수
	li_SpaceDay    = dw_update.Object.space_day    [ll_Row]	//공가일수
	li_SpecialDay  = dw_update.Object.special_day  [ll_Row]	//특휴일수
	li_SeakDay     = dw_update.Object.seak_day     [ll_Row]	//병가일수
	li_Etc1Day     = dw_update.Object.etc1_day     [ll_Row]	//기타1일수
	li_Etc2Day     = dw_update.Object.etc2_day     [ll_Row]	//기타2일수
	ls_Remark      = dw_update.Object.remark       [ll_Row]	//비고

	INSERT	INTO	INDB.HIN027H
	VALUES	(	:ls_MemberNo,
					:ls_Year,
					:ls_Month,
					:li_UseDay,
					:li_MonDay,
					:li_MenseDay,
					:li_DatDay,
					:li_LateDay,
					:li_CutDay,
					:li_AbsentDay,
					:li_OutDay,
					:li_SpaceDay,
					:li_SpecialDay,
					:li_SeakDay,
					:li_Etc1Day,
					:li_Etc2Day,
					:ls_Remark,
					:ls_Worker,
					:ldt_WorkDate,
					:ls_IPAddr,
					:ls_Worker,
					:ls_IPAddr,
					:ldt_WorkDate	);
	IF SQLCA.SQLCODE <> 0 THEN
		UPDATE	INDB.HIN027H
		SET		USE_DAY     = :li_UseDay,
					MON_DAY     = :li_MonDay,
					MENSE_DAY   = :li_MenseDay,
					DAT_DAY     = :li_DatDay,
					LATE_DAY    = :li_LateDay,
					CUT_DAY     = :li_CutDay,
					ABSENT_DAY  = :li_AbsentDay,
					OUT_DAY     = :li_OutDay,
					SPACE_DAY   = :li_SpaceDay,
					SPECIAL_DAY = :li_SpecialDay,
					SEAK_DAY    = :li_SeakDay,
					ETC1_DAY    = :li_Etc1Day,
					ETC2_DAY    = :li_Etc2Day,
					REMARK      = :ls_Remark,
					JOB_UID     = :ls_Worker,
					JOB_ADD     = :ls_IpAddr,
					JOB_DATE    = :ldt_WorkDate
		WHERE		MEMBER_NO   = :ls_MemberNo
		AND		YEAR        = :ls_Year
		AND		MONTH       = :ls_Month;
		IF SQLCA.SQLCODE <> 0 THEN EXIT
	END IF
	
	ll_Row = dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 5. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF SQLCA.SQLCODE = 0 THEN
	COMMIT;
	dw_update.ResetUpdate()
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText + '~r~n' + &
							'해당로우 : ' + String(ll_Row))
	ROLLBACK;
	return -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 6. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
em_yearmonth.Enabled = TRUE
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenu('S',TRUE)
dw_update.SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin552a
end type

type ln_tempright from w_msheet`ln_tempright within w_hin552a
end type

type ln_temptop from w_msheet`ln_temptop within w_hin552a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin552a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin552a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin552a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin552a
end type

type uc_insert from w_msheet`uc_insert within w_hin552a
end type

type uc_delete from w_msheet`uc_delete within w_hin552a
end type

type uc_save from w_msheet`uc_save within w_hin552a
end type

type uc_excel from w_msheet`uc_excel within w_hin552a
end type

type uc_print from w_msheet`uc_print within w_hin552a
end type

type st_line1 from w_msheet`st_line1 within w_hin552a
end type

type st_line2 from w_msheet`st_line2 within w_hin552a
end type

type st_line3 from w_msheet`st_line3 within w_hin552a
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin552a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin552a
end type

type em_yearmonth from editmask within w_hin552a
integer x = 558
integer y = 104
integer width = 279
integer height = 76
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##"
end type

type st_2 from statictext within w_hin552a
integer x = 293
integer y = 116
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
string text = "기준년월"
boolean focusrectangle = false
end type

type uo_member from cuo_insa_member within w_hin552a
integer x = 914
integer y = 104
integer height = 76
integer taborder = 20
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type dw_update from cuo_dwwindow_one_hin within w_hin552a
integer x = 18
integer y = 252
integer width = 3840
integer height = 2352
integer taborder = 40
string dataobject = "d_hin552a_1"
boolean hsplitscroll = true
end type

event constructor;call super::constructor;ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = TRUE
THIS.Object.DataWindow.HorizontalScrollSplit = Long(THIS.Object.jumin_no.x)
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
	CASE 'com_duty_seq'
		///////////////////////////////////////////////////////////////////////////////// 
		//	직급순번 변경시 직급코드 처리
		//		직급코드 = 직종코드 + 직급순번
		///////////////////////////////////////////////////////////////////////////////// 
		IF isNull(ls_ColData) OR LEN(ls_ColData) = 0 THEN
			THIS.Object.duty_code[row] = ls_Null
			RETURN
		END IF
		
		String	ls_JikJongCode	//직종코드
		ls_JikJongCode = TRIM(String(THIS.Object.jikjong_code[row],'0'))
		IF isNull(ls_JikJongCode) OR LEN(ls_JikJongCode) = 0 THEN
			MessageBox('확인','직종코드를 선택하시기 바랍니다.')
			RETURN -1
		END IF
		
		//직급코드
		THIS.Object.duty_code[row] = ls_JikJongCode + ls_ColData
		
	CASE ELSE
		
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type gb_1 from groupbox within w_hin552a
integer x = 14
integer y = 12
integer width = 3845
integer height = 228
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

