$PBExportHeader$w_hin352i.srw
$PBExportComments$보직발령결재
forward
global type w_hin352i from w_msheet
end type
type cb_hakjang from commandbutton within w_hin352i
end type
type cb_cancel from commandbutton within w_hin352i
end type
type dw_update from cuo_dwwindow_one_hin within w_hin352i
end type
type dw_con from uo_dwfree within w_hin352i
end type
type uo_member from cuo_insa_member within w_hin352i
end type
type cb_esajang from uo_imgbtn within w_hin352i
end type
end forward

global type w_hin352i from w_msheet
string title = "보직발령결재"
cb_hakjang cb_hakjang
cb_cancel cb_cancel
dw_update dw_update
dw_con dw_con
uo_member uo_member
cb_esajang cb_esajang
end type
global w_hin352i w_hin352i

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

on w_hin352i.create
int iCurrent
call super::create
this.cb_hakjang=create cb_hakjang
this.cb_cancel=create cb_cancel
this.dw_update=create dw_update
this.dw_con=create dw_con
this.uo_member=create uo_member
this.cb_esajang=create cb_esajang
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_hakjang
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.dw_update
this.Control[iCurrent+4]=this.dw_con
this.Control[iCurrent+5]=this.uo_member
this.Control[iCurrent+6]=this.cb_esajang
end on

on w_hin352i.destroy
call super::destroy
destroy(this.cb_hakjang)
destroy(this.cb_cancel)
destroy(this.dw_update)
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.cb_esajang)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 보직발령된 자료를 가지고 결재처리를 한다.
////					이사장결재가 되어야만 인사기본에 반영이 됨.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 결재구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//dw_sign_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('sign_opt',0) = 0 THEN
//	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_sign_opt.InsertRow(0)
//dw_sign_opt.Object.code.dddw.PercentWidth	= 100
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 보직구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_bojik_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve(9) = 0 THEN
//	wf_setmsg('보직코드를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	Long	ll_InsRow
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'appoint_code','0')
//	ldwc_Temp.SetItem(ll_InsRow,'appoint_name','')
//	ldwc_Temp.SetSort('appoint_code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_bojik_opt.InsertRow(0)
//dw_bojik_opt.Object.code.dddw.PercentWidth	= 130
//////////////////////////////////////////////////////////////////////////////////////
//// 1.3 결재구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//dw_update.GetChild('sign_opt',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('sign_opt',0) = 0 THEN
//	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화 이벤트 콜
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
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
////////////////////////////////////////////////////////////////////////////////////
// 1.1 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
dw_con.insertrow(0)

String	ls_JikJongCode
ls_JikJongCode =  dw_con.object.gubn[1]//MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.3 결재구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_SignOpt
ls_SignOpt = TRIM(dw_con.Object.sign_opt[1])
IF LEN(ls_SignOpt) = 0 OR isNull(ls_SignOpt) OR ls_SignOpt = '0' THEN ls_SignOpt = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.4 보직구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_BojikOpt
ls_BojikOpt = TRIM(dw_con.Object.bojik_opt[1])
IF LEN(ls_BojikOpt) = 0 OR isNull(ls_BojikOpt) OR ls_BojikOpt = '0' THEN ls_BojikOpt = ''


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(ls_KName,ls_SignOpt,ls_BojikOpt,ls_JikJongCode)
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
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
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
ls_NotNullCol[2] = 'bojik_code/보직구분'
ls_NotNullCol[3] = 'from_date/보직기간'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IpAddr		//등록단말기

String	ls_MemberNo		//개인번호
String	ls_BojikCode	//보직코드
String	ls_FromDate		//보직일자
String	ls_LastFromDate//최종보직일자
Integer	li_OLDSignOpt	//결재구분
Integer	li_NEWSignOpt	//결재구분

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode //gstru_uid_uname.uid		//등록자
	ls_IpAddr    = gs_ip   //gstru_uid_uname.address	//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status   = dw_update.GetItemStatus(ll_Row,0,Primary!)
	ls_MemberNo   = dw_update.Object.member_no [ll_Row]	//개인번호
	ls_BojikCode  = dw_update.Object.bojik_code[ll_Row]	//보직코드
	ls_FromDate   = dw_update.Object.from_date [ll_Row]	//보직일자
	li_NEWSignOpt = dw_update.Object.sign_opt.primary [ll_Row]	//결재구분
	li_OLDSignOpt = dw_update.Object.sign_opt.original[ll_Row]	//결재구분
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 결재구분이 내부결재에서 미결로 바뀐경우
	//			인사기본정보의 보직코드, 보직일자 변경처리
	/////////////////////////////////////////////////////////////////////////////////
	
	/*IF li_OLDSignOpt = 2 AND li_NEWSignOpt = 1 THEN
		SELECT	A.BOJIK_CODE,
					A.FROM_DATE
		INTO		:ls_BojikCode,
					:ls_FromDate
		FROM		INDB.HIN008H A
		WHERE		A.MEMBER_NO = :ls_MemberNo
		AND		A.FROM_DATE = :ls_FromDate	;

		IF SQLCA.SQLCODE <> 0 THEN
			wf_SetMsg('보직코드를 읽어 오는중 오류가 발생하였습니다.')
			MessageBox('확인','보직코드를 읽어 오는중 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF
	END IF
	*/

	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 결재구분이 내부결재의  경우만 인사기본정보(indb.hin001m) 보직코드,보직일자 수정처리
	/////////////////////////////////////////////////////////////////////////////////
	IF (li_NEWSignOpt = 2) OR (li_OLDSignOpt = 2 AND li_NEWSignOpt = 1) THEN
		UPDATE	INDB.HIN001M
		SET		BOJIK_CODE1 = :ls_BojikCode,
					BOJIK_DATE1 = :ls_FromDate,
					WORKER      = :ls_Worker,
					WORK_DATE   = :ldt_WorkDate,
					IPADDR      = :ls_IPAddr, 
					JOB_UID     = :ls_Worker,
					JOB_ADD     = :ls_IPAddr,
					JOB_DATE    = :ldt_WorkDate
		WHERE		MEMBER_NO   = :ls_MemberNo;
		IF SQLCA.SQLCODE <> 0 THEN
			wf_SetMsg('인사기본사항 변경시 오류가 발생하였습니다.')
			MessageBox('확인','인사기본사항 변경시 전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF
	END IF
	
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
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
//	작성목적 : 보직발령된 자료를 가지고 결재처리를 한다.
//					이사장결재가 되어야만 인사기본에 반영이 됨.
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
dw_con.insertrow(0)

dw_con.GetChild('sign_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('sign_opt',0) = 0 THEN
	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
//dw_sign_opt.InsertRow(0)
dw_con.Object.sign_opt.dddw.PercentWidth	= 100
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 보직구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('bojik_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve(9) = 0 THEN
	wf_setmsg('보직코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	Long	ll_InsRow
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'appoint_code','0')
	ldwc_Temp.SetItem(ll_InsRow,'appoint_name','')
	ldwc_Temp.SetSort('appoint_code ASC')
	ldwc_Temp.Sort()
END IF
//dw_bojik_opt.InsertRow(0)
dw_con.Object.bojik_opt.dddw.PercentWidth	= 130
////////////////////////////////////////////////////////////////////////////////////
// 1.3 결재구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_update.GetChild('sign_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('sign_opt',0) = 0 THEN
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

type ln_templeft from w_msheet`ln_templeft within w_hin352i
end type

type ln_tempright from w_msheet`ln_tempright within w_hin352i
end type

type ln_temptop from w_msheet`ln_temptop within w_hin352i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin352i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin352i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin352i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin352i
end type

type uc_insert from w_msheet`uc_insert within w_hin352i
end type

type uc_delete from w_msheet`uc_delete within w_hin352i
end type

type uc_save from w_msheet`uc_save within w_hin352i
end type

type uc_excel from w_msheet`uc_excel within w_hin352i
integer x = 3529
end type

type uc_print from w_msheet`uc_print within w_hin352i
end type

type st_line1 from w_msheet`st_line1 within w_hin352i
end type

type st_line2 from w_msheet`st_line2 within w_hin352i
end type

type st_line3 from w_msheet`st_line3 within w_hin352i
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin352i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin352i
integer beginy = 352
integer endy = 352
end type

type cb_hakjang from commandbutton within w_hin352i
boolean visible = false
integer x = 1769
integer y = 16
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

type cb_cancel from commandbutton within w_hin352i
boolean visible = false
integer x = 2875
integer width = 475
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "미결처리"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_cancel
//	기 능 설 명: 미결재처리
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

type dw_update from cuo_dwwindow_one_hin within w_hin352i
integer x = 50
integer y = 388
integer width = 4384
integer height = 1876
integer taborder = 70
string dataobject = "d_hin352i_1"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = FALSE
//ib_SortGubn  = TRUE
//ib_EnterChk  = TRUE
end event

type dw_con from uo_dwfree within w_hin352i
integer x = 50
integer y = 164
integer width = 4379
integer height = 188
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hin352i_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
uo_member.setposition(totop!)
end event

type uo_member from cuo_insa_member within w_hin352i
event destroy ( )
integer x = 1490
integer y = 172
integer taborder = 90
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type cb_esajang from uo_imgbtn within w_hin352i
event destroy ( )
integer x = 59
integer y = 36
integer taborder = 61
boolean bringtotop = true
string btnname = "내부결재"
end type

on cb_esajang.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
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
Integer	li_SignOpt = 2	//결재구분(0:없음,1:미결,2:학(총)장결재,3:이사장결재)
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

