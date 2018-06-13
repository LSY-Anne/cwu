$PBExportHeader$w_hpa520b.srw
$PBExportComments$강사마스터복사
forward
global type w_hpa520b from w_msheet
end type
type dw_target from datawindow within w_hpa520b
end type
type st_20 from statictext within w_hpa520b
end type
type st_19 from statictext within w_hpa520b
end type
type uo_tagmm from cuo_mm within w_hpa520b
end type
type uo_srcmm from cuo_mm within w_hpa520b
end type
type dw_source from datawindow within w_hpa520b
end type
type uo_term from cuo_yearschoolterm within w_hpa520b
end type
type uo_member2 from cuo_insa_member within w_hpa520b
end type
type uo_member from cuo_insa_member within w_hpa520b
end type
type st_1 from statictext within w_hpa520b
end type
type dw_update from uo_dwgrid within w_hpa520b
end type
type cb_create from uo_imgbtn within w_hpa520b
end type
end forward

global type w_hpa520b from w_msheet
integer width = 4498
string title = "시간강사일괄퇴직처리"
event type boolean ue_chk_condition ( )
dw_target dw_target
st_20 st_20
st_19 st_19
uo_tagmm uo_tagmm
uo_srcmm uo_srcmm
dw_source dw_source
uo_term uo_term
uo_member2 uo_member2
uo_member uo_member
st_1 st_1
dw_update dw_update
cb_create cb_create
end type
global w_hpa520b w_hpa520b

type variables
String	is_Year				//년도
String	is_Term				//학기
Integer	ii_FrMonth			//Source month
Integer	ii_ToMonth			//Target month
String	is_KName				//성명
String	is_MemberNo			//개인번호
String	is_KName2			//성명
String	is_MemberNo2		//개인번호

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
// 1.1 년도학기체크
////////////////////////////////////////////////////////////////////////////////////
is_Year  	=	string(uo_term.uf_getyy())
is_Term		=	string(uo_term.uf_gethakgi())
ii_FrMonth	=	Integer(uo_srcmm.uf_getmm())
ii_ToMonth	=	Integer(uo_tagmm.uf_getmm())
////////////////////////////////////////////////////////////////////////////////////
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
is_KName     = TRIM(uo_member.sle_kname.Text)
is_MemberNo  = TRIM(uo_member.sle_member_no.Text)
is_KName2    = TRIM(uo_member.sle_kname.Text)
is_MemberNo2 = TRIM(uo_member.sle_member_no.Text)

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

on w_hpa520b.create
int iCurrent
call super::create
this.dw_target=create dw_target
this.st_20=create st_20
this.st_19=create st_19
this.uo_tagmm=create uo_tagmm
this.uo_srcmm=create uo_srcmm
this.dw_source=create dw_source
this.uo_term=create uo_term
this.uo_member2=create uo_member2
this.uo_member=create uo_member
this.st_1=create st_1
this.dw_update=create dw_update
this.cb_create=create cb_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_target
this.Control[iCurrent+2]=this.st_20
this.Control[iCurrent+3]=this.st_19
this.Control[iCurrent+4]=this.uo_tagmm
this.Control[iCurrent+5]=this.uo_srcmm
this.Control[iCurrent+6]=this.dw_source
this.Control[iCurrent+7]=this.uo_term
this.Control[iCurrent+8]=this.uo_member2
this.Control[iCurrent+9]=this.uo_member
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_update
this.Control[iCurrent+12]=this.cb_create
end on

on w_hpa520b.destroy
call super::destroy
destroy(this.dw_target)
destroy(this.st_20)
destroy(this.st_19)
destroy(this.uo_tagmm)
destroy(this.uo_srcmm)
destroy(this.dw_source)
destroy(this.uo_term)
destroy(this.uo_member2)
destroy(this.uo_member)
destroy(this.st_1)
destroy(this.dw_update)
destroy(this.cb_create)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 강사마스터 및 시수자료를 복사한다.
//	작 성 인 : 박영복
//	작성일자 : 2003.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 처리일자
////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
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
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN -1

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(is_Year,is_Term,ii_FrMonth, is_MemberNo, is_Kname)
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('SDR')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('SDR')
	wf_SetMsg('자료가 조회되었습니다.')
END IF
return 1
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
dw_source.Reset()
dw_target.Reset()
///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('RSD')
uo_term.SetFocus()
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
//IF dw_update.ib_RowSingle THEN &
	ll_GetRow = dw_update.GetRow()
//IF NOT dw_update.ib_RowSingle THEN &
//	ll_GetRow = dw_update.GetSelectedRow(0)
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
Long		ll_DeleteCnt

//IF dw_update.ib_RowSingle OR &
//	dw_update.GetSelectedRow(ll_GetRow) = 0 THEN
//	/////////////////////////////////////////////////////////////////////////////////
//	// 2.1 삭제전 체크사항 기술
//	/////////////////////////////////////////////////////////////////////////////////
//	
//	/////////////////////////////////////////////////////////////////////////////////
//	// 2.2 삭제메세지 처리부분
//	/////////////////////////////////////////////////////////////////////////////////
//ELSE
////	SetNull(ls_Msg)
//END IF
//
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

	dw_update.DeleteRow(ll_GetRow)
	ll_DeleteCnt =  1

//IF NOT dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1
IF dw_update.UPDATE() = 1 THEN
	COMMIT USING SQLCA;
	//RETURN 1
ELSE
	ROLLBACK USING SQLCA;
	RETURN 
END IF

IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	////////////////////////////////////////////////////////////////////////////////////
	//	3.2 Multi 처리인 경우.
	//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
	////////////////////////////////////////////////////////////////////////////////////
	IF dw_update.RowCount() > 0 THEN
//		wf_SetMenuBtn('RDS')
	ELSE
//		wf_SetMenuBtn('RSD')
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
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
IF dw_target.AcceptText() = -1 THEN
	dw_target.SetFocus()
	RETURN -1
END IF

IF dw_target.ModifiedCount() + dw_target.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'year/년도'
ls_NotNullCol[2] = 'hakgi/학기'
ls_NotNullCol[3] = 'month/월'
ls_NotNullCol[4] = 'week_weekend/주'
ls_NotNullCol[5] = 'member_no/교원번호'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
// 3.1 저장처리
////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IpAddr		//등록단말기

String	ls_MemberNo		//개인번호
Integer	li_SeqNo			//인사변동순번
Integer	li_ChagneOpt	//변동코드

ll_Row = dw_target.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gstru_uid_uname.uid		//등록자
	ls_IpAddr    = gstru_uid_uname.address	//등록단말기
END IF
DO WHILE ll_Row > 0
	ls_MemberNo = dw_target.Object.member_no[ll_Row]
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	dw_target.Object.worker   [ll_Row] = ls_Worker		//등록자
	dw_target.Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
	dw_target.Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
	dw_target.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	dw_target.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	dw_target.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = dw_target.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF NOT dw_target.TRIGGER EVENT ue_db_save() THEN RETURN -1
///////////////////////////////////////////////////////////////////////////////////////
// 4.2 강사월별마스터를 갱신한다.
///////////////////////////////////////////////
long 	ll_cnt

SELECT COUNT(*) INTO :ll_cnt
FROM	PADB.HPA111H
WHERE A.YEAR	=	:is_year
AND	A.HAKGI	=	:is_Term
AND	A.MONTH	=	:ii_ToMonth;

IF		ll_cnt < 1 OR isnull(ll_cnt) THEN
	INSERT INTO PADB.HPA111H (YEAR,           HAKGI,         MEMBER_NO ,   MONTH ,
									  NAME ,				GWA             ,
									  JIKJONG_CODE,   DUTY_CODE,     BOJIK_CODE,   TRANS_MEMBER_NO, 
									  TRANS_NAME,     TRANS_REMARK,  SEC_CODE,     SAL_CLASS ,      
									  BANK_CODE,      ACCT_NO ,      NUM_OF_TIME,  NUM_OF_GENERAL,  
									  NUM_OF_MIDDLE,  NUM_OF_LARGE,  NUM_OF_ETC1,  NUM_OF_NIGENERAL,
									  NUM_OF_NIMIDDLE,NUM_OF_NILARGE,NUM_OF_NIETC1,LIMIT_TIME,      
									  HOLIDAY_OPT)
							SELECT  :is_Year,			:is_Term,		MEMBER_NO,    :ii_ToMonth, 
									  name,				gwa,
									  JIKJONG_CODE,   DUTY_CODE,     BOJIK_CODE,   TRANS_MEMBER_NO, 
									  TRANS_NAME,     TRANS_REMARK,  SEC_CODE,     SAL_CLASS ,      
									  BANK_CODE,      ACCT_NO ,      NUM_OF_TIME,  NUM_OF_GENERAL,  
									  NUM_OF_MIDDLE,  NUM_OF_LARGE,  NUM_OF_ETC1,  NUM_OF_NIGENERAL,
									  NUM_OF_NIMIDDLE,NUM_OF_NILARGE,NUM_OF_NIETC1,LIMIT_TIME,      
									  HOLIDAY_OPT
							 FROM	  PADB.HPA111H
							 WHERE  YEAR	=	:is_Year
							 AND	  HAKGI	=	:is_Term
							 AND	  MONTH  =	:ii_FrMonth;
		IF	SQLCA.SQLCODE <> 0	THEN	RETURN -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('SDR')
dw_target.SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

type ln_templeft from w_msheet`ln_templeft within w_hpa520b
end type

type ln_tempright from w_msheet`ln_tempright within w_hpa520b
end type

type ln_temptop from w_msheet`ln_temptop within w_hpa520b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hpa520b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hpa520b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hpa520b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hpa520b
end type

type uc_insert from w_msheet`uc_insert within w_hpa520b
end type

type uc_delete from w_msheet`uc_delete within w_hpa520b
end type

type uc_save from w_msheet`uc_save within w_hpa520b
end type

type uc_excel from w_msheet`uc_excel within w_hpa520b
end type

type uc_print from w_msheet`uc_print within w_hpa520b
end type

type st_line1 from w_msheet`st_line1 within w_hpa520b
end type

type st_line2 from w_msheet`st_line2 within w_hpa520b
end type

type st_line3 from w_msheet`st_line3 within w_hpa520b
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hpa520b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hpa520b
end type

type dw_target from datawindow within w_hpa520b
event type boolean ue_db_save ( )
boolean visible = false
integer x = 32
integer y = 1364
integer width = 3817
integer height = 1092
integer taborder = 70
boolean titlebar = true
string title = "Target"
string dataobject = "d_hpa520b_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type boolean ue_db_save();////////////////////////////////////////////////////////////////////////////////////////// 
//	이벤트  명 : ue_db_save
//	작성/수정자 : 전희열
//	작성/수정일 : 1999.08.03 (화)
//	기 능 설 명: 자료를 저장한다.
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
THIS.AcceptText()

IF THIS.UPDATE() = 1 THEN
	COMMIT USING SQLCA;
	RETURN TRUE
ELSE
	ROLLBACK USING SQLCA;
	RETURN FALSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event constructor;This.SetTransObject(sqlca)
end event

type st_20 from statictext within w_hpa520b
integer x = 1879
integer y = 188
integer width = 329
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "Target월"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_19 from statictext within w_hpa520b
integer x = 1275
integer y = 188
integer width = 329
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "Source월"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_tagmm from cuo_mm within w_hpa520b
integer x = 2089
integer y = 176
integer height = 100
integer taborder = 50
end type

on uo_tagmm.destroy
call cuo_mm::destroy
end on

type uo_srcmm from cuo_mm within w_hpa520b
integer x = 1481
integer y = 176
integer height = 100
integer taborder = 40
end type

on uo_srcmm.destroy
call cuo_mm::destroy
end on

type dw_source from datawindow within w_hpa520b
boolean visible = false
integer x = 256
integer y = 700
integer width = 3817
integer height = 948
integer taborder = 60
boolean titlebar = true
string title = "Source"
string dataobject = "d_hpa520b_1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
end event

type uo_term from cuo_yearschoolterm within w_hpa520b
integer x = 105
integer y = 180
integer taborder = 10
end type

on uo_term.destroy
call cuo_yearschoolterm::destroy
end on

type uo_member2 from cuo_insa_member within w_hpa520b
integer x = 1376
integer y = 268
integer height = 76
integer taborder = 30
end type

on uo_member2.destroy
call cuo_insa_member::destroy
end on

type uo_member from cuo_insa_member within w_hpa520b
integer x = 101
integer y = 272
integer height = 76
integer taborder = 20
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type st_1 from statictext within w_hpa520b
integer x = 50
integer y = 164
integer width = 4393
integer height = 192
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_update from uo_dwgrid within w_hpa520b
integer x = 46
integer y = 368
integer width = 4393
integer height = 1900
integer taborder = 60
string dataobject = "d_hpa520b"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type cb_create from uo_imgbtn within w_hpa520b
integer x = 50
integer y = 36
integer taborder = 20
boolean bringtotop = true
string btnname = "시수마스터복사"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_create
//	기 능 설 명: copy function
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
IF NOT PARENT.TRIGGER EVENT ue_chk_condition() THEN RETURN

dw_target.Reset()
///////////////////////////////////////////////////////////////////////////////////////
// 2. 호봉사정 생성용 자료 조회
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt, li_FrWeek, li_ToWeek, li_Week, li_OldWeek
dw_source.SetReDraw(FALSE)
dw_source.Reset()
ll_RowCnt = dw_source.Retrieve(is_Year, is_Term, ii_FrMonth, is_MemberNo, is_MemberNo2)
dw_source.SetReDraw(TRUE)
//////////////////////////////////////////////////////
// 2.2 주차관리에서 주를 가져온다.
//////////////////////////////////////////////////////
SELECT A.FROM_WEEKEND, A.TO_WEEKEND 
  INTO :li_FrWeek, :li_ToWeek
  FROM PADB.HPA101M A
 WHERE A.YEAR 	=	:is_year
   AND A.MONTH =  :ii_ToMonth
	AND A.HAKGI =	:is_Term;
IF li_FrWeek = 0 THEN RETURN
///////////////////////////////////////////////////////////////////////////////////////
// 3. 호봉사정 추가
///////////////////////////////////////////////////////////////////////////////////////
STRING		ls_YEAR            
STRING		ls_HAKGI           
STRING		ls_MEMBER_NO       
DECIMAL{0}	li_WEEK_WEEKEND 
DECIMAL{0}	li_MONTH           
DECIMAL{0}	li_NUM_OF_TIME     
DECIMAL{0}	li_NUM_OF_GENERAL  
DECIMAL{0}	li_NUM_OF_MIDDLE   
DECIMAL{0}	li_NUM_OF_LARGE    
DECIMAL{0}	li_NUM_OF_ETC1     
DECIMAL{0}	li_NUM_OF_NIGENERAL
DECIMAL{0}	li_NUM_OF_NIMIDDLE 
DECIMAL{0}	li_NUM_OF_NILARGE  
DECIMAL{0}	li_NUM_OF_NIETC1   
DECIMAL{0}	li_LIMIT_TIME      
DECIMAL{0}	li_TIME_OF_PAUSE1  
DECIMAL{0}	li_TIME_OF_PAUSE2  
DECIMAL{0}	li_TIME_OF_PAUSE3  
DECIMAL{0}	li_TIME_OF_PAUSE4  
DECIMAL{0}	li_BOGANG_SISU_1   
DECIMAL{0}	li_BOGANG_SISU_2   
DECIMAL{0}	li_BOGANG_SISU_3   
DECIMAL{0}	li_BOGANG_SISU_4   
DECIMAL{0}	li_NUM_OF_OVERTIME1
DECIMAL{0}	li_NUM_OF_OVERTIME2
DECIMAL{0}	li_NUM_OF_OVERTIME3
DECIMAL{0}	li_NUM_OF_OVERTIME4
DECIMAL{0}	li_MISAN_SISU_1    
DECIMAL{0}	li_MISAN_SISU_2    
DECIMAL{0}	li_MISAN_SISU_3    
DECIMAL{0}	li_MISAN_SISU_4  
Long			ll_Row, ll_InsRow

dw_target.SetReDraw(FALSE)
dw_target.Reset()
li_Week = li_FrWeek		//초기에 대상의 주를 준다.
FOR ll_Row = 1 TO ll_RowCnt
	ls_YEAR         		= dw_source.Object.YEAR        		[ll_Row]	//년도
	ls_HAKGI       		= dw_source.Object.HAKGI				[ll_Row]	//학기
	ls_MEMBER_NO         = dw_source.Object.MEMBER_NO        [ll_Row]	//시번
	li_WEEK_WEEKEND      = dw_source.Object.WEEK_WEEKEND     [ll_Row]	//주
	if  ll_Row = 1	 then	li_OldWeek = li_WEEK_WEEKEND
	li_MONTH      			= dw_source.Object.MONTH     			[ll_Row]	//월
	li_NUM_OF_TIME       = dw_source.Object.NUM_OF_TIME      [ll_Row]	//책임시수
	li_NUM_OF_GENERAL    = dw_source.Object.NUM_OF_GENERAL   [ll_Row]	//초과120일반
	li_NUM_OF_NIMIDDLE   = dw_source.Object.NUM_OF_NIMIDDLE  [ll_Row]	//초과120분반
	li_NUM_OF_NILARGE    = dw_source.Object.NUM_OF_NILARGE   [ll_Row]	//초과120합반
	li_NUM_OF_NIETC1     = dw_source.Object.NUM_OF_NIETC1    [ll_Row]	//초과기타
	li_LIMIT_TIME        = dw_source.Object.LIMIT_TIME       [ll_Row]	//한계
	li_TIME_OF_PAUSE1    = dw_source.Object.TIME_OF_PAUSE1   [ll_Row]	//휴강일반
	li_TIME_OF_PAUSE2    = dw_source.Object.TIME_OF_PAUSE2   [ll_Row]	//휴강분반
	li_TIME_OF_PAUSE3    = dw_source.Object.TIME_OF_PAUSE3   [ll_Row]	//휴강합반
	li_TIME_OF_PAUSE4    = dw_source.Object.TIME_OF_PAUSE4   [ll_Row]	//휴강여분
	li_BOGANG_SISU_1     = dw_source.Object.BOGANG_SISU_1    [ll_Row]	//보강일반
	li_BOGANG_SISU_2     = dw_source.Object.BOGANG_SISU_2		[ll_Row]	//보강분반
	li_BOGANG_SISU_3     = dw_source.Object.BOGANG_SISU_3    [ll_Row]	//보강합반
	li_BOGANG_SISU_4     = dw_source.Object.BOGANG_SISU_4    [ll_Row]	//보강기타
	li_NUM_OF_OVERTIME1  = dw_source.Object.NUM_OF_OVERTIME1 [ll_Row]	//초과일반
	li_NUM_OF_OVERTIME2  = dw_source.Object.NUM_OF_OVERTIME2 [ll_Row]	//초과분반
	li_NUM_OF_OVERTIME3  = dw_source.Object.NUM_OF_OVERTIME3 [ll_Row]	//초과합반
	li_NUM_OF_OVERTIME4  = dw_source.Object.NUM_OF_OVERTIME4	[ll_Row]	//초과여분
	li_MISAN_SISU_1		= dw_source.Object.MISAN_SISU_1     [ll_Row]	//미산시수
	li_MISAN_SISU_2		= dw_source.Object.MISAN_SISU_2		[ll_Row]	//미산분반
	li_MISAN_SISU_3		= dw_source.Object.MISAN_SISU_3		[ll_Row]	//미산합반
	li_MISAN_SISU_4		= dw_source.Object.MISAN_SISU_4		[ll_Row]	//미산기타
	
	ll_InsRow = dw_target.InsertRow(0)
	IF ll_InsRow = 0 THEN EXIT
	dw_target.Object.YEAR             [ll_InsRow] = ls_YEAR			
	dw_target.Object.HAKGI            [ll_InsRow] = ls_HAKGI			
	dw_target.Object.MEMBER_NO        [ll_InsRow] = ls_MEMBER_NO
	if	li_OldWeek <> li_WEEK_WEEKEND then
		li_FrWeek ++
		li_Week		=	li_FrWeek
		li_OldWeek 	= li_Week_Weekend
	end if
	dw_target.Object.WEEK_WEEKEND     [ll_InsRow] = li_Week		
	dw_target.Object.MONTH            [ll_InsRow] = ii_ToMonth				
	dw_target.Object.NUM_OF_TIME      [ll_InsRow] = li_NUM_OF_TIME				
	dw_target.Object.NUM_OF_GENERAL   [ll_InsRow] = li_NUM_OF_GENERAL				
	dw_target.Object.NUM_OF_NIMIDDLE  [ll_InsRow] = li_NUM_OF_NIMIDDLE			
	dw_target.Object.NUM_OF_NILARGE   [ll_InsRow] = li_NUM_OF_NILARGE			
	dw_target.Object.NUM_OF_NIETC1    [ll_InsRow] = li_NUM_OF_NIETC1			
	dw_target.Object.LIMIT_TIME       [ll_InsRow] = li_LIMIT_TIME			
	dw_target.Object.TIME_OF_PAUSE1   [ll_InsRow] = li_TIME_OF_PAUSE1			
	dw_target.Object.TIME_OF_PAUSE2   [ll_InsRow] = li_TIME_OF_PAUSE2			
	dw_target.Object.TIME_OF_PAUSE3   [ll_InsRow] = li_TIME_OF_PAUSE3			
	dw_target.Object.TIME_OF_PAUSE4   [ll_InsRow] = li_TIME_OF_PAUSE4			
	dw_target.Object.BOGANG_SISU_1    [ll_InsRow] = li_BOGANG_SISU_1		
	dw_target.Object.BOGANG_SISU_2    [ll_InsRow] = li_BOGANG_SISU_2		
	dw_target.Object.BOGANG_SISU_3    [ll_InsRow] = li_BOGANG_SISU_3			
	dw_target.Object.BOGANG_SISU_4    [ll_InsRow] = li_BOGANG_SISU_4				
	dw_target.Object.NUM_OF_OVERTIME1 [ll_InsRow] = li_NUM_OF_OVERTIME1			
	dw_target.Object.NUM_OF_OVERTIME2 [ll_InsRow] = li_NUM_OF_OVERTIME2			
	dw_target.Object.NUM_OF_OVERTIME3 [ll_InsRow] = li_NUM_OF_OVERTIME3		
	dw_target.Object.NUM_OF_OVERTIME4 [ll_InsRow] = li_NUM_OF_OVERTIME4			
	dw_target.Object.MISAN_SISU_1     [ll_InsRow] = li_MISAN_SISU_1			
	dw_target.Object.MISAN_SISU_2     [ll_InsRow] = li_MISAN_SISU_2			
	dw_target.Object.MISAN_SISU_3     [ll_InsRow] = li_MISAN_SISU_3				
	dw_target.Object.MISAN_SISU_4     [ll_InsRow] = li_MISAN_SISU_4			
NEXT
dw_target.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_InsRow > 0 THEN
//	wf_SetMenuBtn('SDR')
	wf_SetMsg('자료가 생성되었습니다. 확인 후 자료를 저장하시기 바랍니다.')
ELSE
//	wf_SetMenuBtn('R')
	wf_SetMsg('처리 할 대상자가 없습니다.')
END IF

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cb_create.destroy
call uo_imgbtn::destroy
end on

