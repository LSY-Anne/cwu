$PBExportHeader$w_hfn402b.srw
$PBExportComments$년마감관리
forward
global type w_hfn402b from w_msheet
end type
type tab_1 from tab within w_hfn402b
end type
type tabpage_1 from userobject within tab_1
end type
type dw_list from cuo_dwwindow_one_hin within tabpage_1
end type
type dw_update from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_list dw_list
dw_update dw_update
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hfn402b
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_con from uo_dwfree within w_hfn402b
end type
type uo_tab from u_tab within w_hfn402b
end type
type cb_create from uo_imgbtn within w_hfn402b
end type
end forward

global type w_hfn402b from w_msheet
tab_1 tab_1
dw_con dw_con
uo_tab uo_tab
cb_create cb_create
end type
global w_hfn402b w_hfn402b

type variables
datawindowchild	idw_child

DataWindow			idw_list




end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
public function boolean wf_update (string as_bdgt_year, string as_worker, string as_ipaddr, datetime adt_workdate)
public subroutine wf_data_proc ()
end prototypes

public subroutine wf_setmenubtn (string as_type);////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: wf_setmenubtn
////	기 능 설 명: 메뉴의 기능을 활성화/비활성화 처리
////	기 능 설 명: 
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE li_idx
//		CASE 1;ib_insert   = lb_Value
//		CASE 2;ib_update   = lb_Value
//		CASE 3;ib_delete   = lb_Value
//		CASE 4;ib_retrieve = lb_Value
//		CASE 5;ib_print    = lb_Value
//		CASE 6;ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

public function boolean wf_update (string as_bdgt_year, string as_worker, string as_ipaddr, datetime adt_workdate);//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: wf_update
//	기 능 설 명: 총계정관리 테이블에 자료저장
//	기 능 설 명: 
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 총계정관리 저장
String ls_bdgt_year
dw_con.accepttext()

ls_bdgt_year = String(dw_con.object.bdgt_year[1], 'yyyy')

INSERT	INTO	FNDB.HFN502H
SELECT	A.ACCT_CLASS,
			A.BDGT_YEAR,
			A.ACCT_DATE,
			A.ACCT_CODE,
			NVL(SUM(A.DR_ALT_AMT),0),
			NVL(SUM(A.DR_CASH_AMT),0),
			NVL(SUM(A.CR_ALT_AMT),0),
			NVL(SUM(A.CR_CASH_AMT),0),
			:AS_WORKER,
			:AS_IPADDR,
			:ADT_WORKDATE,
			:AS_WORKER,
			:AS_IPADDR,
			:ADT_WORKDATE
FROM		FNDB.HFN501H A
WHERE 	A.ACCT_CLASS = :GI_ACCT_CLASS
AND		A.BDGT_YEAR  = :AS_BDGT_YEAR
AND		A.ACCT_DATE  = :AS_BDGT_YEAR||'0000'
GROUP BY	A.ACCT_CLASS, A.BDGT_YEAR, A.ACCT_DATE, A.ACCT_CODE ;
			
IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('년마감자료 저장처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN FALSE
END IF

// 결산마감정보 저장
INSERT	INTO	FNDB.HFN011M
SELECT	:GI_ACCT_CLASS,
			A.BDGT_YEAR,
			A.FROM_DATE,
			A.TO_DATE,
			'N',
			:AS_WORKER,
			:AS_IPADDR,
			:ADT_WORKDATE,
			:AS_WORKER,
			:AS_IPADDR,
			:ADT_WORKDATE
FROM		ACDB.HAC003M A
WHERE		A.BDGT_YEAR = :ls_bdgt_year
AND		BDGT_CLASS = 0
AND		STAT_CLASS = 0	;

IF SQLCA.SQLCODE <> 0 THEN
	wf_SetMsg('일마감자료 저장처리 중 에러가 발생하였습니다.')
	MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText)
	RETURN FALSE
END IF

Return True
end function

public subroutine wf_data_proc ();// 당기의 운영차액을 계산하여 삽입한다.
// 당기운영차액 = 수익합계 - 지출합계 - 기본금대체액합계
String  Ls_FrCode[] = {'5000', '4000', '6000'}
String  Ls_ToCode[] = {'5999', '4999', '6999'}
Long    Ll_Row
Dec{0}  Ldc_Dr_Cash[], Ldc_Dr_Alt[], Ldc_Cr_Cash[], Ldc_Cr_Alt[]
Dec{0}  Ldc_Dr_Cash_Amt, Ldc_Dr_Alt_Amt, Ldc_Cr_Cash_Amt, Ldc_Cr_Alt_Amt
Integer Li_Num
String  ls_bdgt_year
dw_con.accepttext()

ls_bdgt_year  = String(dw_con.object.bdgt_year[1], 'yyyy')

// 수익, 지출, 기본금대체액 합계
// 1:수익, 2:지출, 3:기본금대체액
FOR Li_Num = 1 TO 3
	 // 변수금액 초기화
	 Ldc_Dr_Cash[Li_Num] = 0
	 Ldc_Dr_Alt[Li_Num]  = 0
	 Ldc_Cr_Cash[Li_Num] = 0
	 Ldc_Cr_Alt[Li_Num]  = 0
	 
	 SELECT	DECODE(B.DRCR_CLASS,'D',NVL(SUM(A.DR_CASH_AMT),0),NVL(SUM(A.CR_CASH_AMT),0)),
	 			DECODE(B.DRCR_CLASS,'D',NVL(SUM(A.DR_ALT_AMT),0),NVL(SUM(A.CR_ALT_AMT),0)),
				DECODE(B.DRCR_CLASS,'D',NVL(SUM(A.CR_CASH_AMT),0),NVL(SUM(A.DR_CASH_AMT),0)),
				DECODE(B.DRCR_CLASS,'D',NVL(SUM(A.CR_ALT_AMT),0),NVL(SUM(A.DR_ALT_AMT),0))
	 INTO		:LDC_DR_CASH[LI_NUM],
	 			:LDC_DR_ALT[LI_NUM],
				:LDC_CR_CASH[LI_NUM],
				:LDC_CR_ALT[LI_NUM]
	 FROM		FNDB.HFN502H A, ACDB.HAC001M B
	 WHERE	A.ACCT_CLASS = :GI_ACCT_CLASS
	 AND		A.BDGT_YEAR  = :ls_bdgt_year
	 AND		SUBSTR(A.ACCT_CODE,1,4) BETWEEN :LS_FRCODE[LI_NUM] AND :LS_TOCODE[LI_NUM]
	 AND		SUBSTR(A.ACCT_CODE,1,4)||'00' = B.ACCT_CODE (+)
	 GROUP BY B.DRCR_CLASS ;
NEXT

Ldc_Cr_Cash_Amt = Ldc_Dr_Cash[1] - Ldc_Dr_Cash[2] - Ldc_Dr_Cash[3]
Ldc_Cr_Alt_Amt  = Ldc_Dr_Alt[1] - Ldc_Dr_Alt[2] - Ldc_Dr_Alt[3]
Ldc_Dr_Cash_Amt = Ldc_Cr_Cash[1] - Ldc_Cr_Cash[2] - Ldc_Cr_Cash[3]
Ldc_Dr_Alt_Amt  = Ldc_Cr_Alt[1] - Ldc_Cr_Alt[2] - Ldc_Cr_Alt[3]

// 당기운영차액 삽입
Ll_Row = idw_list.insertrow(0)
idw_list.setitem(ll_row, 'com_acct_class', 1)	
idw_list.setitem(ll_row, 'com_acct_class_nm', '교비')	
idw_list.setitem(ll_row, 'com_acct_code', '313301')	
idw_list.setitem(ll_row, 'com_acct_name', '당기운영차액')	
idw_list.setitem(ll_row, 'com_drcr_class', 'C')	
idw_list.setitem(ll_row, 'com_mana_code', 0)	
idw_list.setitem(ll_row, 'com_mana_data', ' ')	
idw_list.setitem(ll_row, 'com_dr_alt_amt', Ldc_Dr_Alt_Amt)
idw_list.setitem(ll_row, 'com_dr_cash_amt', Ldc_Dr_Cash_Amt)
idw_list.setitem(ll_row, 'com_cr_alt_amt', Ldc_Cr_Alt_Amt)
idw_list.setitem(ll_row, 'com_cr_cash_amt', Ldc_Cr_Cash_Amt)

// 다음 년도의 전기이월운영차액 = 운영차액
// 운영차액 = 당기의 전년도 운영차액 +
//            당기의 운영차액대체 +
//            당기의 운영차액

// 당기의 전기이월운영차액('313101')
Ll_row = idw_list.find("com_acct_code = '313101'",1,idw_list.rowcount())
If Ll_row > 0 Then
	Ldc_Dr_Cash[1] = idw_list.object.com_dr_cash_amt[Ll_row]
	Ldc_Dr_Alt[1]  = idw_list.object.com_dr_alt_amt[Ll_row]
	Ldc_Cr_Cash[1] = idw_list.object.com_cr_cash_amt[Ll_row]
	Ldc_Cr_Alt[1]  = idw_list.object.com_cr_alt_amt[Ll_row]
Else
	Ldc_Dr_Cash[1] = 0
	Ldc_Dr_Alt[1]  = 0
	Ldc_Cr_Cash[1] = 0
	Ldc_Cr_Alt[1]  = 0
End If

// 당기의 당기운영차액대체('313201')
Ll_row = idw_list.find("com_acct_code = '313201'",1,idw_list.rowcount())
If Ll_row > 0 Then
	Ldc_Dr_Cash[2] = idw_list.object.com_dr_cash_amt[Ll_row]
	Ldc_Dr_Alt[2]  = idw_list.object.com_dr_alt_amt[Ll_row]
	Ldc_Cr_Cash[2] = idw_list.object.com_cr_cash_amt[Ll_row]
	Ldc_Cr_Alt[2]  = idw_list.object.com_cr_alt_amt[Ll_row]
Else
	Ldc_Dr_Cash[2] = 0
	Ldc_Dr_Alt[2]  = 0
	Ldc_Cr_Cash[2] = 0
	Ldc_Cr_Alt[2]  = 0
End If

// 당기의 당기운영차액('313301')
Ll_row = idw_list.find("com_acct_code = '313301'",1,idw_list.rowcount())
If Ll_row > 0 Then
	Ldc_Dr_Cash[3] = idw_list.object.com_dr_cash_amt[Ll_row]
	Ldc_Dr_Alt[3]  = idw_list.object.com_dr_alt_amt[Ll_row]
	Ldc_Cr_Cash[3] = idw_list.object.com_cr_cash_amt[Ll_row]
	Ldc_Cr_Alt[3]  = idw_list.object.com_cr_alt_amt[Ll_row]
Else
	Ldc_Dr_Cash[3] = 0
	Ldc_Dr_Alt[3]  = 0
	Ldc_Cr_Cash[3] = 0
	Ldc_Cr_Alt[3]  = 0
End If

Ll_Row = idw_update[1].insertrow(0)
idw_update[1].setitem(ll_row, 'acct_class', 1)
idw_update[1].setitem(ll_row, 'bdgt_year', String(Long(ls_bdgt_year) + 1, '0000'))
idw_update[1].setitem(ll_row, 'acct_date', String(Long(ls_bdgt_year) + 1, '0000') + '0000')
idw_update[1].setitem(ll_row, 'acct_code', '313101')
idw_update[1].setitem(ll_row, 'mana_code', 0)
idw_update[1].setitem(ll_row, 'mana_data', ' ')
idw_update[1].setitem(ll_row, 'dr_alt_amt', 0)
idw_update[1].setitem(ll_row, 'dr_cash_amt', 0)
idw_update[1].setitem(ll_row, 'cr_alt_amt', (Ldc_Cr_Alt[1] + Ldc_Cr_Alt[2] + Ldc_Cr_Alt[3]) - (Ldc_Dr_Alt[1] + Ldc_Dr_Alt[2] + Ldc_Dr_Alt[3]))
idw_update[1].setitem(ll_row, 'cr_cash_amt', (Ldc_Cr_Cash[1] + Ldc_Cr_Cash[2] + Ldc_Cr_Cash[3]) - (Ldc_Dr_Cash[1] + Ldc_Dr_Cash[2] + Ldc_Dr_Cash[3]))

end subroutine

on w_hfn402b.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_con=create dw_con
this.uo_tab=create uo_tab
this.cb_create=create cb_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_tab
this.Control[iCurrent+4]=this.cb_create
end on

on w_hfn402b.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_tab)
destroy(this.cb_create)
end on

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 일마감처리
////	작 성 인 : 이현수
////	작성일자 : 2002.11
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//String Ls_Sys_Date
//
//// 초기값처리
//idw_update[1] = tab_1.tabpage_1.dw_update   // 보조부관리생성용
//idw_list   = tab_1.tabpage_1.dw_list     // 마감처리정보
//idw_print  = tab_1.tabpage_2.dw_print    // 마감처리정보출력용
//
//
//// 조회조건 - 마감년도
//Ls_Sys_date = f_today()
//
//dw_con.object.bdgt_year[1] = date(string(Ls_sys_date,'@@@@/@@/@@'))
//
//idw_list.ShareData(idw_print)
//idw_print.Object.DataWindow.Print.Preview = 'YES'
//idw_print.Object.DataWindow.zoom = 100
//
end event

event ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
DwItemStatus	ldis_Status
Long				ll_Cnt	//건수
String   		Ls_Trans_Year
Long				ll_Row			//변경된 행
DateTime			ldt_WorkDate	//등록일자
String			ls_Worker		//등록자
String			ls_IpAddr		//등록단말기
String	ls_bdgt_year
dw_con.accepttext()
ls_bdgt_year = String(dw_con.object.bdgt_year[1], 'yyyy')

// 변경여부 CHECK
IF idw_update[1].ModifiedCount() + idw_update[1].DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 생성 후 저장하시기 바랍니다')
	RETURN -1
END IF

if f_chk_magam(gi_acct_class, ls_bdgt_year) > 0 then return -1

// 저장처리전 체크사항 기술
// 년마감자료 생성 전 삭제여부체크
Ls_Trans_Year = String(Long(ls_bdgt_year) + 1, '0000')

SELECT	COUNT(*)
INTO		:ll_Cnt
FROM		FNDB.HFN011M A
WHERE		A.ACCT_CLASS = :GI_ACCT_CLASS
AND		A.BDGT_YEAR  = :ls_bdgt_year
AND		A.CLOSE_YN   = 'N' ;

IF ll_Cnt > 0 THEN
	Integer	li_Rtn
	li_Rtn = MessageBox('확인','기존에 생성된자료가 존재합니다.~r~n'+&
										'기존자료를 삭제하고 다시 생성하시겠습니까?',&
										Question!,YesNo!,1)
	IF li_Rtn = 1 THEN

		// 보조부관리 삭제
		DELETE
		FROM		FNDB.HFN501H A
		WHERE		A.ACCT_CLASS = :GI_ACCT_CLASS
		AND		A.BDGT_YEAR  = :LS_TRANS_YEAR
		AND		A.ACCT_DATE  = :LS_TRANS_YEAR||'0000' ;

		IF SQLCA.SQLCODE <> 0 THEN

			wf_SetMsg('년마감자료 삭제처리 중 에러가 발생하였습니다.')
			MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF
	
		// 총계정관리 삭제
		DELETE
		FROM		FNDB.HFN502H A
		WHERE		A.ACCT_CLASS = :GI_ACCT_CLASS
		AND		A.BDGT_YEAR  = :LS_TRANS_YEAR
		AND		A.ACCT_DATE  = :LS_TRANS_YEAR||'0000' ;

		IF SQLCA.SQLCODE <> 0 THEN

			wf_SetMsg('년마감자료 삭제처리 중 에러가 발생하였습니다.')
			MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF

		// 결산마감정보 삭제
		DELETE
		FROM		FNDB.HFN011M A
		WHERE		A.ACCT_CLASS = :GI_ACCT_CLASS
		AND		A.BDGT_YEAR  = :ls_bdgt_year
		AND		A.CLOSE_YN   = 'N';

		IF SQLCA.SQLCODE <> 0 THEN

			wf_SetMsg('년마감자료 삭제처리 중 에러가 발생하였습니다.')
			MessageBox('확인','전산장애가 발생되었습니다.~r~n' + &
									'하단의 장애번호와 장애내역을~r~n' + &
									'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
									'장애번호 : ' + String(SQLCA.SQLCODE) + '~r~n' + &
									'장애내역 : ' + SQLCA.SqlErrText)
			ROLLBACK USING SQLCA;	
			RETURN -1
		END IF
	ELSE
		wf_SetMsg('년마감자료 생성을 취소하였습니다.')
		RETURN -1
	END IF
END IF

// 저장처리
ll_Row = idw_update[1].GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode		//등록자
	ls_IpAddr    = gs_ip	//등록단말기
END IF

DO WHILE ll_Row > 0
	ldis_Status = idw_update[1].GetItemStatus(ll_Row,0,Primary!)
	// 수정항목 처리
	idw_update[1].Object.worker   [ll_Row] = ls_Worker		//등록자
	idw_update[1].Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
	idw_update[1].Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
	idw_update[1].Object.job_uid  [ll_Row] = ls_Worker		//등록자
	idw_update[1].Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	idw_update[1].Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = idw_update[1].GetNextModified(ll_Row,primary!)
LOOP

// 자료저장처리
wf_SetMsg('변경된 자료를 저장 중 입니다...')

// 보조부관리 저장
If idw_update[1].Update() <> 1 Then

	wf_SetMsg('년마감자료 저장처리 중 에러가 발생하였습니다.')
	ROLLBACK USING SQLCA;	
	RETURN -1
End If

// 총계정관리 저장
If Not wf_update(Ls_Trans_Year, Ls_worker, Ls_ipaddr, Ldt_workdate) Then

	ROLLBACK USING SQLCA;	
	RETURN -1
End If

// 메세지, 메뉴버튼 활성/비활성화 처리
wf_SetMsg('자료가 저장되었습니다.')

COMMIT USING SQLCA;
//wf_SetMenuBtn('SR')
idw_list.SetFocus()

RETURN 1

end event

event ue_print;call super::ue_print;//tab_1.SelectTab(2)
//f_print(tab_1.tabpage_2.dw_print)
//
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 일마감처리
//	작 성 인 : 이현수
//	작성일자 : 2002.11
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
String Ls_Sys_Date

// 초기값처리
idw_update[1] = tab_1.tabpage_1.dw_update   // 보조부관리생성용
idw_list   = tab_1.tabpage_1.dw_list     // 마감처리정보
idw_print  = tab_1.tabpage_2.dw_print    // 마감처리정보출력용


// 조회조건 - 마감년도
Ls_Sys_date = f_today()

dw_con.object.bdgt_year[1] = date(string(Ls_sys_date,'@@@@/@@/@@'))

idw_list.ShareData(idw_print)
idw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print.Object.DataWindow.zoom = 100

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

type ln_templeft from w_msheet`ln_templeft within w_hfn402b
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn402b
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn402b
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn402b
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn402b
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn402b
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn402b
end type

type uc_insert from w_msheet`uc_insert within w_hfn402b
end type

type uc_delete from w_msheet`uc_delete within w_hfn402b
end type

type uc_save from w_msheet`uc_save within w_hfn402b
end type

type uc_excel from w_msheet`uc_excel within w_hfn402b
end type

type uc_print from w_msheet`uc_print within w_hfn402b
end type

type st_line1 from w_msheet`st_line1 within w_hfn402b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn402b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn402b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn402b
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn402b
end type

type tab_1 from tab within w_hfn402b
integer x = 50
integer y = 328
integer width = 4384
integer height = 1972
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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

event selectionchanged;if tab_1.tabpage_1.dw_list.rowcount() < 1 Then Return

//if newindex = 1 then
//	wf_SetMenuBtn('S')
//else
//	wf_SetMenuBtn('P')
//end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1852
string text = "년마감 관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list dw_list
dw_update dw_update
end type

on tabpage_1.create
this.dw_list=create dw_list
this.dw_update=create dw_update
this.Control[]={this.dw_list,&
this.dw_update}
end on

on tabpage_1.destroy
destroy(this.dw_list)
destroy(this.dw_update)
end on

type dw_list from cuo_dwwindow_one_hin within tabpage_1
integer y = 8
integer width = 4352
integer height = 1844
integer taborder = 10
string dataobject = "d_hfn402b_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
end event

type dw_update from cuo_dwwindow_one_hin within tabpage_1
boolean visible = false
integer x = 1975
integer y = 444
integer width = 1586
integer height = 788
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "공통보조부생성용"
string dataobject = "d_hfn402b_2"
boolean controlmenu = true
boolean maxbox = true
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1852
string text = "년마감 리스트"
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

type dw_print from datawindow within tabpage_2
integer width = 4338
integer height = 1844
integer taborder = 20
string title = "none"
string dataobject = "d_hfn402b_9"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_con from uo_dwfree within w_hfn402b
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_hfn113a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)

This.object.bdgt_year_t.text = '마감년도'
end event

event itemchanged;call super::itemchanged;idw_list.Reset()
idw_update[1].Reset()
end event

type uo_tab from u_tab within w_hfn402b
event destroy ( )
integer x = 878
integer y = 312
integer taborder = 150
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on

type cb_create from uo_imgbtn within w_hfn402b
integer x = 50
integer y = 36
integer taborder = 20
boolean bringtotop = true
string btnname = "년마감처리"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked::cb_create
//	기 능 설 명: 년마감자료 생성
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 조회여부 체크


///////////////////////////////////////////////////////////////////////////////////////
// 2. 년마감자료 생성자료 조회
///////////////////////////////////////////////////////////////////////////////////////
String Ls_Trans_Year
Long   Ll_Row, Ll_Ins_Row
String	ls_bdgt_year

dw_con.accepttext()
ls_bdgt_year = String(dw_con.object.bdgt_year[1], 'yyyy')

Ls_Trans_Year = String(Long(ls_bdgt_year) + 1, '0000')

idw_list.SetRedraw(False)
idw_list.Reset()
idw_list.Retrieve(gi_acct_class, ls_bdgt_year)
idw_list.SetRedraw(True)

idw_update[1].Reset()
FOR Ll_Row = 1 TO idw_list.RowCount()
	 If idw_list.object.com_trans_amt[Ll_Row] <> 0 Then
		 // 저장할 Data Move
		 // 전기이월운영차액은 계산하여 삽입
		 // 계산을 위해 전기이월운영차액과 당기운영차액대체 자료는 Move 하지 않는다.
		 If idw_list.Object.com_acct_code[Ll_Row] <> '313101' And idw_list.Object.com_acct_code[Ll_Row] <> '313201' Then
		    Ll_Ins_Row = idw_update[1].InsertRow(0)
	 
		    idw_update[1].Object.acct_class [Ll_Ins_Row] = idw_list.Object.com_acct_class [Ll_Row]			// 회계단위
		    idw_update[1].Object.bdgt_year  [Ll_Ins_Row] = Ls_Trans_Year												// 회계년도
		    idw_update[1].Object.acct_date  [Ll_Ins_Row] = Ls_Trans_Year + '0000'									// 전표일자
		    idw_update[1].Object.acct_code  [Ll_Ins_Row] = idw_list.Object.com_acct_code  [Ll_Row]	// 계정과목
		    idw_update[1].Object.mana_code  [Ll_Ins_Row] = idw_list.Object.com_mana_code  [Ll_Row]			// 관리항목코드
		    idw_update[1].Object.mana_data  [Ll_Ins_Row] = idw_list.Object.com_mana_data  [Ll_Row]			// 관리항목자료
			 if idw_list.Object.com_drcr_class[Ll_Row] = 'D' then
			    idw_update[1].Object.dr_alt_amt [Ll_Ins_Row] = idw_list.Object.com_dr_alt_amt [Ll_Row] - idw_list.Object.com_cr_alt_amt [Ll_Row]			// 차변대체액
			    idw_update[1].Object.dr_cash_amt[Ll_Ins_Row] = idw_list.Object.com_dr_cash_amt[Ll_Row] - idw_list.Object.com_cr_cash_amt[Ll_Row]			// 차변현금액
			    idw_update[1].Object.cr_alt_amt [Ll_Ins_Row] = 0			// 대변대체액
		   	 idw_update[1].Object.cr_cash_amt[Ll_Ins_Row] = 0			// 대변현금액
			 else
			    idw_update[1].Object.dr_alt_amt [Ll_Ins_Row] = 0			// 차변대체액
			    idw_update[1].Object.dr_cash_amt[Ll_Ins_Row] = 0			// 차변현금액
			    idw_update[1].Object.cr_alt_amt [Ll_Ins_Row] = idw_list.Object.com_cr_alt_amt [Ll_Row] - idw_list.Object.com_dr_alt_amt [Ll_Row]			// 대변대체액
		   	 idw_update[1].Object.cr_cash_amt[Ll_Ins_Row] = idw_list.Object.com_cr_cash_amt[Ll_Row] - idw_list.Object.com_dr_cash_amt[Ll_Row]			// 대변현금액
			 end if
		 End If
	 End If
NEXT

// 전기이월운영차액을 처리한다.
// 전기이월운영차액 = 당기운영차액
wf_data_proc()

// 메세지처리
IF idw_list.RowCount() > 0 THEN
//   DateTime Ldt_sysdatetime
	idw_print.Object.t_slip_date.Text = ls_bdgt_year + ' 년도'

//   ldt_SysDateTime = f_sysdate()
//   idw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//   idw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

//	wf_SetMenuBtn('S')
	wf_SetMsg('년마감자료가 생성되었습니다. 확인 후 자료를 저장하시기 바랍니다.')
ELSE
	wf_SetMsg('생성할 자료가 없습니다.')
END IF


end event

on cb_create.destroy
call uo_imgbtn::destroy
end on

