$PBExportHeader$w_hpa622p.srw
$PBExportComments$소득금액증명원
forward
global type w_hpa622p from w_msheet
end type
type em_from from editmask within w_hpa622p
end type
type st_1 from statictext within w_hpa622p
end type
type em_to from editmask within w_hpa622p
end type
type ddlb_gubn from dropdownlistbox within w_hpa622p
end type
type st_21 from statictext within w_hpa622p
end type
type cbx_seq from checkbox within w_hpa622p
end type
type st_5 from statictext within w_hpa622p
end type
type cb_help from commandbutton within w_hpa622p
end type
type sle_apply_name from singlelineedit within w_hpa622p
end type
type st_2 from statictext within w_hpa622p
end type
type st_4 from statictext within w_hpa622p
end type
type em_to_date from editmask within w_hpa622p
end type
type em_fr_date from editmask within w_hpa622p
end type
type st_3 from statictext within w_hpa622p
end type
type st_6 from statictext within w_hpa622p
end type
type tab_1 from tab within w_hpa622p
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_update dw_update
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from cuo_dwwindow_one_hin within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hpa622p
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type gb_1 from groupbox within w_hpa622p
end type
end forward

global type w_hpa622p from w_msheet
integer width = 3936
string title = "재직증명서신청"
event type boolean ue_chk_condition ( )
event ue_retrieve_print ( )
em_from em_from
st_1 st_1
em_to em_to
ddlb_gubn ddlb_gubn
st_21 st_21
cbx_seq cbx_seq
st_5 st_5
cb_help cb_help
sle_apply_name sle_apply_name
st_2 st_2
st_4 st_4
em_to_date em_to_date
em_fr_date em_fr_date
st_3 st_3
st_6 st_6
tab_1 tab_1
gb_1 gb_1
end type
global w_hpa622p w_hpa622p

type variables
Integer	ii_JikJongCode		//직종구분
String	is_FrDate			//신청일자FROM
String	is_ToDate			//신청일자TO
String	is_ApplyName		//신청자
Integer	ii_PrintOpt			//증명서구분
Integer	ii_LangOpt			//국영문구분
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
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
ii_JikJongCode = Integer(MID(ddlb_gubn.Text,1,1))

///////////////////////////////////////////////////////////////////////////////////////
// 2. 신청일자 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
em_fr_date.GetData(is_FrDate)
is_FrDate = TRIM(is_FrDate)
IF NOT f_isDate(is_FrDate) THEN
	MessageBox('확인','신청일자FROM 입력오류입니다.')
	em_fr_date.SetFocus()
	RETURN FALSE
END IF
em_to_date.GetData(is_ToDate)
is_ToDate = TRIM(is_ToDate)
IF NOT f_isDate(is_ToDate) THEN
	MessageBox('확인','신청일자TO를 입력오류입니다.')
	em_to_date.SetFocus()
	RETURN FALSE
END IF
IF is_FrDate > is_ToDate THEN
	MessageBox('확인','신청기간 오류입니다.')
	em_to_date.SetFocus()
	RETURN FALSE
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 신청자 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
is_ApplyName = TRIM(sle_apply_name.Text)

///////////////////////////////////////////////////////////////////////////////////////
// 6. 제증명출력 오브젝트변경 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_DataObject = 'd_hpa622p'
//CHOOSE CASE ii_PrintOpt
//	CASE 1
//		ls_DataObject += String(ii_PrintOpt)
//		ls_DataObject += String(ii_LangOpt)
//	CASE 2
//		ls_DataObject += String(ii_PrintOpt)
//		ls_DataObject += '1'
//	CASE 5
//		ls_DataObject += String(ii_PrintOpt)
//		ls_DataObject += '1'
//	CASE ELSE
//		RETURN FALSE
//END CHOOSE
//
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

event ue_retrieve_print();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_retrieve_print
//	기 능 설 명: 제증명신청 출력자료 조회처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 제증명신청관리 자료조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
ll_GetRow = tab_1.tabpage_1.dw_update.GetRow()
IF ll_GetRow = 0 THEN
	wf_SetMsg('소득금액증명원 자료를 조회후 사용하시기 바랍니다.')
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 제증명신청 출력자료 조회처리
///////////////////////////////////////////////////////////////////////////////////////
//제증명신청 TABLE LAYOUT===
String	ls_ApplyDate		//신청일자
Integer	li_MemberOpt		//교직원구분
Integer	li_ApplyNo			//신청번호
String	ls_MemberNo			//개인번호
Integer	li_PrintOpt			//증명서구분
Integer	li_PrintNum			//매수
String	ls_UnivName			//학교명
Long		ll_RowCnt			//
string	ls_frdt,ls_todt

ls_ApplyDate     = tab_1.tabpage_1.dw_update.Object.apply_date    [ll_GetRow]	//신청일자
li_MemberOpt     = tab_1.tabpage_1.dw_update.Object.member_opt    [ll_GetRow]	//교직원구분
li_ApplyNo       = tab_1.tabpage_1.dw_update.Object.apply_no      [ll_GetRow]	//신청번호
ls_MemberNo      = tab_1.tabpage_1.dw_update.Object.member_no     [ll_GetRow]	//개인번호
li_PrintOpt      = tab_1.tabpage_1.dw_update.Object.print_opt     [ll_GetRow]	//증명서구분
ls_UnivName      = GF_GLOBAL_VALUE(2)											//학교명

ls_todt 			  = em_to.text
ls_frdt			  = em_from.text


if (isnull(em_to.text) or em_to.text = '')  then
	messagebox("확 인", "기준년월를 입력한 후 조회하십시요 !")
	return
end if

//dw_d1.retrieve(is_sabun)
//
//li_rowcnt = dw_d1.rowcount()
//
//if li_rowcnt < 1 then
//	messagebox("확 인","조회하고자하는 자료가 없습니다.!")
//   return
//end if
//

li_PrintNum      = tab_1.tabpage_1.dw_update.Object.print_num     [ll_GetRow]	//매수
IF isNull(li_PrintNum) OR li_PrintNum = 0 THEN 
	wf_SetMsg('매수를 입력하시기 바랍니다.')
	tab_1.tabpage_2.dw_print.InsertRow(0)
END IF

tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
tab_1.tabpage_2.dw_print.Reset()


///--------------------------------------
//DECLARE cur2 CURSOR FOR
//
//  SELECT mpayment.mpay_yymm,   
//         mpayment.mpay_pay_tot,   
//         mpayment.mpay_gabgun  
//    FROM mpayment  
//   WHERE ( mpayment.mpay_sabun = :is_sabun ) AND 
//         ( mpayment.mpay_yymm between :ls_sday and :ls_eday )    
//	order by	mpayment.mpay_yymm ;
//	
//OPEN cur2;
//	



//	DO WHILE TRUE
//		FETCH NEXT cur2
//		INTO 	:ls_yymm,:ld_pay, :ld_vat ;
//	
////	messagebox('111',is_sabun+'/'+ls_yymm+'/'+ string(ld_pay) +'/'+ string(ld_vat))
//		if sqlca.sqlcode <> 0 then
//			dw_d1.setitem(1,'atot',ld_spay)
//			dw_d1.setitem(1,'btot',ld_svat)
//			exit
//		else
//			ls_yymmdd = string(relativedate(date(left(ls_yymm ,4)+'/'+right(ls_yymm,2)+'/'+'10'),30),'yyyy/mm/10')
//			
//			dw_d1.setitem(1,i,left(ls_yymm,4) + '/'+ mid(ls_yymm,5,2))
//			dw_d1.setitem(1,i+1,ld_pay)
//			dw_d1.setitem(1,i+2,ld_vat)
//			dw_d1.setitem(1,i+3,ls_yymmdd)
//			ld_spay = ld_spay + ld_pay
//			ld_svat = ld_svat + ld_vat
//			i = i + 4			
//		end if	
//	LOOP
//
//CLOSE cur2;
//
//If i > 7 then
//	dw_d1.setitem(1,'num',sle_no.text)
//	dw_d1.setitem(1,'y1',sle_1.text)
//	dw_d1.setitem(1,'y2',sle_2.text)
//	dw_d1.setitem(1,'y3',em_1.text)
//end if			
//
//uo_1.sle_message.text = " 조회를 완료하였습니다. !"
//

////-------------------


ll_RowCnt = tab_1.tabpage_2.dw_print.Retrieve(ls_MemberNo,ls_frdt,ls_todt)


//	CASE '52'	//급여지급확인서-영문
//	CASE ELSE
//		RETURN
//END CHOOSE
tab_1.tabpage_2.dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
	wf_SetMsg('소득금액증명원이 조회되었습니다.')
//	wf_SetMenu('P',TRUE)
ELSE
	wf_SetMsg('소득금액증명원이 존재하지 않습니다.')
//	wf_SetMenu('P',FALSE)
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

public subroutine wf_setmenubtn (string as_type);//입력
//저장
//삭제
//조회
//검색
//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
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

on w_hpa622p.create
int iCurrent
call super::create
this.em_from=create em_from
this.st_1=create st_1
this.em_to=create em_to
this.ddlb_gubn=create ddlb_gubn
this.st_21=create st_21
this.cbx_seq=create cbx_seq
this.st_5=create st_5
this.cb_help=create cb_help
this.sle_apply_name=create sle_apply_name
this.st_2=create st_2
this.st_4=create st_4
this.em_to_date=create em_to_date
this.em_fr_date=create em_fr_date
this.st_3=create st_3
this.st_6=create st_6
this.tab_1=create tab_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_from
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_to
this.Control[iCurrent+4]=this.ddlb_gubn
this.Control[iCurrent+5]=this.st_21
this.Control[iCurrent+6]=this.cbx_seq
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.cb_help
this.Control[iCurrent+9]=this.sle_apply_name
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.em_to_date
this.Control[iCurrent+13]=this.em_fr_date
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.tab_1
this.Control[iCurrent+17]=this.gb_1
end on

on w_hpa622p.destroy
call super::destroy
destroy(this.em_from)
destroy(this.st_1)
destroy(this.em_to)
destroy(this.ddlb_gubn)
destroy(this.st_21)
destroy(this.cbx_seq)
destroy(this.st_5)
destroy(this.cb_help)
destroy(this.sle_apply_name)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.em_to_date)
destroy(this.em_fr_date)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.tab_1)
destroy(this.gb_1)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 제증명 자료를 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1  조회조건 - 신청기간
////////////////////////////////////////////////////////////////////////////////////
em_fr_date.Text = f_today()
em_to_date.Text = f_lastdate(f_today())

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
tab_1.tabpage_1.dw_update.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_update.Retrieve(ii_JikJongCode,is_FrDate,is_ToDate,&
										is_ApplyName,ii_PrintOpt,ii_LangOpt)
tab_1.tabpage_1.dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('IR')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	sle_apply_name.SetFocus()
	
ELSE
//	tab_1.tabpage_1.dw_update.Object.apply_no.protect = '1'
	tab_1.tabpage_1.dw_update.Object.apply_no.background.color = 536870912
	
//	wf_SetMenuBtn('IDSR')
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
IF tab_1.tabpage_1.dw_update.AcceptText() = -1 THEN
	tab_1.tabpage_1.dw_update.SetFocus()
	RETURN -1
END IF
IF tab_1.tabpage_1.dw_update.ModifiedCount() + &
	tab_1.tabpage_1.dw_update.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
IF cbx_seq.Checked THEN
	ls_NotNullCol[1] = 'apply_date/신청일자'
	ls_NotNullCol[2] = 'member_opt/교직원구분'
	ls_NotNullCol[3] = 'apply_name/신청자'
//	ls_NotNullCol[4] = 'print_opt/증명서종류'
//	ls_NotNullCol[5] = 'print_num/매수'
ELSE
	ls_NotNullCol[1] = 'apply_no/신청번호'
	ls_NotNullCol[2] = 'apply_date/신청일자'
	ls_NotNullCol[3] = 'member_opt/교직원구분'
	ls_NotNullCol[4] = 'apply_name/신청자'
//	ls_NotNullCol[5] = 'print_opt/증명서종류'
//	ls_NotNullCol[6] = 'print_num/매수'
END IF
IF f_chk_null(tab_1.tabpage_1.dw_update,ls_NotNullCol) = -1 THEN RETURN -1

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

ll_Row = tab_1.tabpage_1.dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode		//등록자
	ls_IpAddr    = gs_ip	//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = tab_1.tabpage_1.dw_update.GetItemStatus(ll_Row,0,Primary!)
	////////////////////////////////////////////////////////////////////////////////////
	// 3.1 제증명발급대장 신청번호생성
	////////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified!  AND cbx_seq.Checked THEN
		ls_ApplyDate[2] = tab_1.tabpage_1.dw_update.Object.apply_date[ll_Row]	//신청일자NEW
		li_MemberOpt[2] = tab_1.tabpage_1.dw_update.Object.member_opt[ll_Row]	//교직원구분NEW
		
		IF ls_ApplyDate[1] <> ls_ApplyDate[2] OR &
			li_MemberOpt[1] <> li_MemberOpt[2] THEN
			li_ApplyNo = 0
			ls_ApplyDate[1] = ls_ApplyDate[2]
			li_MemberOpt[1] = li_MemberOpt[2]
			
			wf_SetMsg('소득금액증명원 발급번호 생성중 입니다.')
			SELECT	NVL(MAX(A.APPLY_NO),0) + 1
			INTO		:li_ApplyNo
			FROM		padb.hpa021H A
			WHERE		substr(A.APPLY_DATE,1,4) = substr(:ls_ApplyDate[2]),1,4)
			AND		A.MEMBER_OPT = :li_MemberOpt[2];
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
		ELSE
			li_ApplyNo++
		END IF
		
		tab_1.tabpage_1.dw_update.Object.apply_no [ll_Row] = li_ApplyNo	//요구순번
		tab_1.tabpage_1.dw_update.Object.worker   [ll_Row] = ls_Worker		//등록자
		tab_1.tabpage_1.dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
		tab_1.tabpage_1.dw_update.Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	tab_1.tabpage_1.dw_update.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	tab_1.tabpage_1.dw_update.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	tab_1.tabpage_1.dw_update.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = tab_1.tabpage_1.dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF NOT tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_update.Object.apply_no.protect = '1'
tab_1.tabpage_1.dw_update.Object.apply_no.background.color = 536870912

wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSR')
tab_1.tabpage_1.dw_update.SetFocus()
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
tab_1.tabpage_1.dw_update.Reset()

tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
tab_1.tabpage_2.dw_print.Reset()
tab_1.tabpage_2.dw_print.InsertRow(0)
tab_1.tabpage_2.dw_print.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('IR')
sle_apply_name.SetFocus()
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
// 1. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
//IF tab_1.tabpage_1.dw_update.ib_RowSingle THEN
	ll_GetRow = tab_1.tabpage_1.dw_update.GetRow()
//IF NOT tab_1.tabpage_1.dw_update.ib_RowSingle THEN ll_GetRow = tab_1.tabpage_1.dw_update.GetSelectedRow(0)
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
Long		ll_DeleteCnt


IF tab_1.tabpage_1.dw_update.ib_RowSingle OR tab_1.tabpage_1.dw_update.getrow() = 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 2.1 삭제전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
	String	ls_ApplyDate		//신청일자
	String	ls_MemberOpt		//구분
	Integer	li_ApplyNo			//신청번호
	
	ls_ApplyDate = tab_1.tabpage_1.dw_update.Object.apply_date[ll_GetRow]	//신청일자
	ls_MemberOpt = tab_1.tabpage_1.dw_update.&
					Describe("Evaluate('LookUpDisplay(member_opt)',"+String(ll_GetRow)+")")
	li_ApplyNo   = tab_1.tabpage_1.dw_update.Object.apply_no  [ll_GetRow]	//신청번호
	
	ls_Msg = '개인번호 : '+String(ls_ApplyDate,'@@@@/@@/@@')+'~r~n'+&
				'구      분 : '+ls_MemberOpt+'~r~n'+&
				'신청번호 : '+String(li_ApplyNo)
ELSE
//	SetNull(ls_Msg)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
ll_DeleteCnt = tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	IF tab_1.tabpage_1.dw_update.ib_RowSingle THEN
		/////////////////////////////////////////////////////////////////////////////
		// 3.1 Single 처리인 경우.
		//			3.1.1 저장처리.
		//			3.1.2 한로우를 다시 추가.
		//			3.1.3 데이타원도우를 읽기모드로 수정.
		/////////////////////////////////////////////////////////////////////////////
		IF tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_save() THEN
			tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_append()
			tab_1.tabpage_1.dw_update.Object.DataWindow.ReadOnly = 'YES'
//			wf_SetMenuBtn('IR')
		END IF
	ELSE
		/////////////////////////////////////////////////////////////////////////////
		//	3.2 Multi 처리인 경우.
		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
		/////////////////////////////////////////////////////////////////////////////
		IF tab_1.tabpage_1.dw_update.RowCount() > 0 THEN
//			wf_SetMenuBtn('IDSR')
		ELSE
//			wf_SetMenuBtn('ISR')
		END IF
	END IF
ELSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long	 ll_InsRow
ll_InsRow = tab_1.tabpage_1.dw_update.TRIGGER EVENT ue_db_new()
IF ll_InsRow = 0 THEN RETURN
////////////////////////////////////////////////////////////////////////////////////
// 2.1 개인번호 자동생성여부 체크
////////////////////////////////////////////////////////////////////////////////////
Boolean	lb_Chk
lb_Chk = cbx_seq.Checked
IF lb_Chk THEN
	tab_1.tabpage_1.dw_update.Object.apply_no.protect = '1'
	tab_1.tabpage_1.dw_update.Object.apply_no.background.color = 536870912
ELSE
	tab_1.tabpage_1.dw_update.Object.apply_no.protect = '0'
	tab_1.tabpage_1.dw_update.Object.apply_no.background.color = RGB(255,255,255)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_SysDate
ls_SysDate = f_today()
tab_1.tabpage_1.dw_update.Object.apply_date[ll_InsRow] = ls_SysDate			//신청일자
tab_1.tabpage_1.dw_update.Object.member_opt[ll_InsRow] = ii_JikJongCode	//교직원구분
tab_1.tabpage_1.dw_update.Object.print_opt [ll_InsRow] = ii_PrintOpt		//증명서종류
tab_1.tabpage_1.dw_update.Object.lang_opt  [ll_InsRow] = ii_LangOpt			//국영문구분
tab_1.tabpage_1.dw_update.Object.print_num [ll_InsRow] = 1						//매수
tab_1.tabpage_1.dw_update.SetItemStatus(ll_InsRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우호 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('IDSR')
wf_SetMsg('자료가 추가되었습니다.')
tab_1.tabpage_1.dw_update.SetColumn('apply_date')
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_print
//	기 능 설 명: 조회된 자료를 출력한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
tab_1.SelectTab(2)
f_print(tab_1.tabpage_2.dw_print)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hpa622p
end type

type ln_tempright from w_msheet`ln_tempright within w_hpa622p
end type

type ln_temptop from w_msheet`ln_temptop within w_hpa622p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hpa622p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hpa622p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hpa622p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hpa622p
end type

type uc_insert from w_msheet`uc_insert within w_hpa622p
end type

type uc_delete from w_msheet`uc_delete within w_hpa622p
end type

type uc_save from w_msheet`uc_save within w_hpa622p
end type

type uc_excel from w_msheet`uc_excel within w_hpa622p
end type

type uc_print from w_msheet`uc_print within w_hpa622p
end type

type st_line1 from w_msheet`st_line1 within w_hpa622p
end type

type st_line2 from w_msheet`st_line2 within w_hpa622p
end type

type st_line3 from w_msheet`st_line3 within w_hpa622p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hpa622p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hpa622p
end type

type em_from from editmask within w_hpa622p
boolean visible = false
integer x = 3026
integer y = 92
integer width = 297
integer height = 84
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##"
boolean autoskip = true
end type

event modified;//date		ld_date,ld_date2
//
//if isdate(em_to.text + '/10') then
//	ld_date 		= date(em_to.text + '/10')
//	ld_date2 = RelativeDate(ld_date,-335)
//	em_from.text = string(ld_date2,'yyyymm')
//else	
//   messagebox("오 류", "정상적인 기준년월(yyyy/mm)을 입력하세요 !!!")
//   setfocus(em_to)
//end if
end event

type st_1 from statictext within w_hpa622p
integer x = 2368
integer y = 108
integer width = 306
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
alignment alignment = right!
boolean focusrectangle = false
end type

type em_to from editmask within w_hpa622p
integer x = 2683
integer y = 88
integer width = 297
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##"
boolean autoskip = true
end type

event modified;date		ld_date,ld_date2

if isdate(em_to.text + '/10') then
	ld_date 		= date(em_to.text + '/10')
	ld_date2 = RelativeDate(ld_date,-335)
	em_from.text = string(ld_date2,'yyyymm')
else	
   messagebox("오 류", "정상적인 기준년월(yyyy/mm)을 입력하세요 !!!")
   setfocus(em_to)
end if
end event

type ddlb_gubn from dropdownlistbox within w_hpa622p
integer x = 384
integer y = 96
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
ls_UserID = TRIM(gs_empcode)			//로그인사번
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
AND		A.GROUP_ID  IN ('Hin01','Hin02','Admin','Mnger','PGMer2','Hin00')
AND		ROWNUM       = 1;

CHOOSE CASE TRIM(ls_GroupID)
	CASE 'Hin01'
		li_JikJongCode = 2	//사무처
	CASE 'Hin02'
		li_JikJongCode = 1	//교무처
	CASE 'Admin','Mnger','PGMer2','Hin00'
		li_JikJongCode = 3	//관리자
		lb_GroupChk    = TRUE
	CASE ELSE
		li_JikJongCode = 1	//교무처
END CHOOSE

THIS.SelectItem(li_JikJongCode)
THIS.Enabled = lb_GroupChk

//uo_member.is_JikJongCode = String(li_JikJongCode)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event selectionchanged;//uo_member.is_JikJongCode = String(index)

end event

type st_21 from statictext within w_hpa622p
integer x = 174
integer y = 92
integer width = 201
integer height = 108
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

type cbx_seq from checkbox within w_hpa622p
integer x = 2944
integer y = 260
integer width = 896
integer height = 72
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 67108864
string text = "신청번호 자동 생성시 선택"
boolean checked = true
end type

type st_5 from statictext within w_hpa622p
integer x = 3611
integer y = 92
integer width = 192
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "Help!"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "신청자도움말"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_help from commandbutton within w_hpa622p
integer x = 3557
integer y = 44
integer width = 302
integer height = 192
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "Help!"
string text = " "
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_help
//	기 능 설 명: 신청자 도움말 원도우 오픈
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
ll_GetRow = tab_1.tabpage_1.dw_update.getrow()
IF ll_GetRow = 0 THEN
	wf_SetMsg('제증명발급자료 선택후 사용하시기 바랍니다.')
	sle_apply_name.SetFocus()
	RETURN
END IF

String	ls_KName			//성명
String	ls_NumberNo		//개인번호
String	ls_JikJongCode	//교직원구분
tab_1.tabpage_1.dw_update.AcceptText()
ls_KName       = TRIM(tab_1.tabpage_1.dw_update.Object.apply_name[ll_GetRow])	//성명
ls_JikJongCode = MID(ddlb_gubn.Text,1,1)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 신청자 도움말 원도우 오픈
///////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com
String	ls_JuminNo
String	ls_DeptCode
Integer	li_JikWiCode
String	ls_DutyCode
Integer	li_JikMuCode
String	ls_FirstHireDate
String	ls_HakwonHireDate
String	ls_SalClass
String	ls_ComDeptNm
String	ls_ComJikJongNm
String	ls_ComJikWiNm
String	ls_ComDutyNm
String	ls_ComJikMuNm

lstr_com.ls_item[1] = ls_KName			//성명
lstr_com.ls_item[2] = ''					//개인번호
lstr_com.ls_item[3] = ls_JikJongCode	//교직원구분

OpenWithParm(w_hin000h,lstr_com)

lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	SetNull(ls_KName)
	SetNull(ls_NumberNo)
	SetNull(ls_JuminNo)
	SetNull(ls_DeptCode)
	SetNull(ls_JikJongCode)
	SetNull(li_JikWiCode)
	SetNull(ls_DutyCode)
	SetNull(li_JikMuCode)
	SetNull(ls_FirstHireDate)
	SetNull(ls_HakwonHireDate)
	SetNull(ls_SalClass)
	SetNull(ls_ComDeptNm)
	SetNull(ls_ComJikJongNm)
	SetNull(ls_ComJikWiNm)
	SetNull(ls_ComDutyNm)
	SetNull(ls_ComJikMuNm)
	RETURN
ELSE
	ls_KName          = lstr_com.ls_item[01]	//성명
	ls_NumberNo       = lstr_com.ls_item[02]	//개인번호
	ls_JuminNo        = lstr_com.ls_item[03]	//주민번호
	ls_DeptCode       = lstr_com.ls_item[04]	//조직코드
	ls_JikJongCode    = lstr_com.ls_item[05]	//직종코드
	li_JikWiCode      = lstr_com.ll_item[06]	//직위코드
	ls_DutyCode       = lstr_com.ls_item[07]	//직급코드
	li_JikMuCode      = lstr_com.ll_item[08]	//직무코드
	ls_FirstHireDate  = lstr_com.ls_item[09]	//최초임용일
	ls_HakwonHireDate = lstr_com.ls_item[10]	//학원임용일
	ls_SalClass       = lstr_com.ls_item[11]	//호봉코드
	ls_ComDeptNm      = lstr_com.ls_item[12]	//조직명
	ls_ComJikJongNm   = lstr_com.ls_item[13]	//직종명
	ls_ComJikWiNm     = lstr_com.ls_item[14]	//직위명
	ls_ComDutyNm      = lstr_com.ls_item[15]	//직급명
	ls_ComJikMuNm     = lstr_com.ls_item[16]	//직무명
END IF
tab_1.tabpage_1.dw_update.Object.com_kname      [ll_GetRow] = ls_KName
tab_1.tabpage_1.dw_update.Object.apply_name     [ll_GetRow] = ls_KName
tab_1.tabpage_1.dw_update.Object.member_no      [ll_GetRow] = ls_NumberNo
tab_1.tabpage_1.dw_update.Object.jumin_no       [ll_GetRow] = ls_JuminNo
tab_1.tabpage_1.dw_update.Object.gwa            [ll_GetRow] = ls_DeptCode
tab_1.tabpage_1.dw_update.Object.jikjong_code   [ll_GetRow] = ls_JikJongCode
tab_1.tabpage_1.dw_update.Object.jikwi_code     [ll_GetRow] = li_JikWiCode
tab_1.tabpage_1.dw_update.Object.duty_code      [ll_GetRow] = ls_DutyCode
tab_1.tabpage_1.dw_update.Object.jikmu_code     [ll_GetRow] = li_JikMuCode
tab_1.tabpage_1.dw_update.Object.firsthire_date [ll_GetRow] = ls_FirstHireDate
tab_1.tabpage_1.dw_update.Object.hakwonhire_date[ll_GetRow] = ls_HakwonHireDate
tab_1.tabpage_1.dw_update.Object.sal_class      [ll_GetRow] = ls_SalClass
tab_1.tabpage_1.dw_update.Object.com_dept_nm    [ll_GetRow] = ls_ComDeptNm
tab_1.tabpage_1.dw_update.Object.com_jikjong_nm [ll_GetRow] = ls_ComJikJongNm
tab_1.tabpage_1.dw_update.Object.com_jikwi_nm   [ll_GetRow] = ls_ComJikWiNm
tab_1.tabpage_1.dw_update.Object.com_duty_nm    [ll_GetRow] = ls_ComDutyNm
tab_1.tabpage_1.dw_update.Object.com_jikmu_nm   [ll_GetRow] = ls_ComJikMuNm

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
tab_1.tabpage_1.dw_update.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type sle_apply_name from singlelineedit within w_hpa622p
integer x = 1966
integer y = 96
integer width = 306
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_hpa622p
integer x = 1755
integer y = 116
integer width = 201
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "신청자"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_hpa622p
integer x = 1294
integer y = 104
integer width = 46
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "∼"
boolean focusrectangle = false
end type

type em_to_date from editmask within w_hpa622p
integer x = 1349
integer y = 96
integer width = 366
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

type em_fr_date from editmask within w_hpa622p
integer x = 923
integer y = 96
integer width = 366
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

type st_3 from statictext within w_hpa622p
integer x = 773
integer y = 88
integer width = 142
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "신청기간"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_hpa622p
integer x = 3547
integer y = 36
integer width = 315
integer height = 204
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

type tab_1 from tab within w_hpa622p
integer x = 23
integer y = 256
integer width = 3840
integer height = 2348
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 80269524
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: selectionchanged::tab_1
//	기 능 설 명: 소득금액증명신청 출력자료 조회처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
IF oldindex = 1 AND newindex = 2 THEN PARENT.TRIGGER EVENT ue_retrieve_print()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3803
integer height = 2232
long backcolor = 80269524
string text = "소득금액증명원"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_update dw_update
end type

on tabpage_1.create
this.dw_update=create dw_update
this.Control[]={this.dw_update}
end on

on tabpage_1.destroy
destroy(this.dw_update)
end on

type dw_update from cuo_dwwindow_one_hin within tabpage_1
integer y = 4
integer width = 3785
integer height = 2208
integer taborder = 10
string dataobject = "d_hpa622p_01"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = TRUE
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
	CASE 'com_kname'
		///////////////////////////////////////////////////////////////////////////////// 
		//	신청자변경시 처리
		///////////////////////////////////////////////////////////////////////////////// 
		THIS.Object.member_no[row] = ls_Null
		
		IF isNull(ls_ColData) OR LEN(ls_ColData) = 0 THEN
			THIS.Object.apply_name[row] = ls_Null
			RETURN
		END IF
		THIS.Object.apply_name[row] = ls_ColData
		
	CASE ELSE
		
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_et_processenter;//Override
IF THIS.GetColumnName() = 'com_kname' THEN
	cb_help.TRIGGER EVENT clicked()
	RETURN 0
END IF

IF ib_EnterChk THEN 
	SEND(HANDLE(THIS),256,9,LONG(0,0))
	RETURN 1
END IF
end event

event doubleclicked;call super::doubleclicked;TRIGGER EVENT ue_retrieve_print()
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3803
integer height = 2232
long backcolor = 80269524
string text = "소득금액증명원 출력"
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

type dw_print from cuo_dwwindow_one_hin within tabpage_2
integer x = 9
integer y = 16
integer width = 3744
integer height = 2208
integer taborder = 10
string dataobject = "d_hpa622p"
end type

type gb_1 from groupbox within w_hpa622p
integer x = 23
integer y = 12
integer width = 3515
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

