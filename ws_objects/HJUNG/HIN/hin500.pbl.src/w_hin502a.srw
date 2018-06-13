$PBExportHeader$w_hin502a.srw
$PBExportComments$제증명발급관리(외래교수증명서)
forward
global type w_hin502a from w_msheet
end type
type cb_1 from commandbutton within w_hin502a
end type
type tab_1 from tab within w_hin502a
end type
type tabpage_2 from userobject within tab_1
end type
type dw_data from cuo_dwwindow_one_hin within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_data dw_data
end type
type tabpage_1 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hin502a
tabpage_2 tabpage_2
tabpage_1 tabpage_1
end type
type dw_con from uo_dwfree within w_hin502a
end type
type uo_member from cuo_insa_member within w_hin502a
end type
type cb_process from uo_imgbtn within w_hin502a
end type
type uo_1 from u_tab within w_hin502a
end type
end forward

global type w_hin502a from w_msheet
string title = "재직증명서신청"
event type boolean ue_chk_condition ( )
event ue_retrieve_print ( )
cb_1 cb_1
tab_1 tab_1
dw_con dw_con
uo_member uo_member
cb_process cb_process
uo_1 uo_1
end type
global w_hin502a w_hin502a

type variables
Integer	ii_JikJongCode		//직종구분
STRING	is_JikJongCode		//직종구분
String	is_FrDate			//신청일자FROM
String	is_ToDate			//신청일자TO
String	is_ApplyNo			//신청자
Integer	ii_PrintOpt			//증명서구분
Integer	ii_LangOpt			//국영문구분
sTRING	is_num				//매수
STRING	iS_REMARK			//용도
Integer	ii_price
String	is_change_date, is_jumin_no,is_name, is_Numb
String   is_name_e, is_dept_name, is_duty_name, is_sysdate	
String	is_chk = '0'
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

event type boolean ue_chk_condition();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_chk_condition
//	기 능 설 명: 조회조건 체크
//	작성/수정자: //
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
is_FrDate = dw_con.object.fr_date[1]//TRIM(is_FrDate)
IF NOT f_isDate(is_FrDate) THEN
	MessageBox('확인','일자 입력오류입니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('fr_date')
	RETURN FALSE
END IF
////////////////////////////////////////////////////////////
// 3. 매수체크 및 단가 체크
///////////////////////////////////////////////////////////
ii_printopt = integer(dw_con.object.page[1])
ii_price    = integer(dw_con.object.price[1])
//if ii_printopt < 1 then 
//	messageBox('확인','매수를 입력하세요!')
//	em_page.SetFocus()
//end if
//if ii_price < 1 then 
//	messageBox('확인','단가를 입력하세요!')
//	em_price.SetFocus()
//end if
///////////////////////////////////////////////////////////////////////////////////////
// 3. 신청자 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
is_ApplyNo = TRIM(uo_member.sle_member_no.Text)
IF ISNULL(is_ApplyNo) OR is_ApplyNo = "" THEN
	wf_setmsg("신청자를 입력하세요")
	RETURN	false
END IF	

tab_1.tabpage_1.dw_print.SetTransObject(SQLCA)

tab_1.tabpage_1.dw_print.SetReDraw(FALSE)
tab_1.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
tab_1.tabpage_1.dw_print.Reset()
tab_1.tabpage_1.dw_print.SetReDraw(TRUE)
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

on w_hin502a.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.tab_1=create tab_1
this.dw_con=create dw_con
this.uo_member=create uo_member
this.cb_process=create cb_process
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_member
this.Control[iCurrent+5]=this.cb_process
this.Control[iCurrent+6]=this.uo_1
end on

on w_hin502a.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.cb_process)
destroy(this.uo_1)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 제증명 자료를 관리한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//em_fr_date.Text = f_today()
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
//tab_1.SelectTab(1)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_retrieve
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
String ls_career_gb

IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN -1

ls_career_gb = dw_con.Object.career_gb[1]

tab_1.tabpage_2.dw_data.Retrieve(is_ApplyNo, ls_career_gb)
tab_1.tabpage_1.dw_print.Retrieve(is_ApplyNo,is_FrDate, ls_career_gb)

////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
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

is_remark    = dw_con.object.sle_etc[1]
ldt_WorkDate = f_sysdate()					//등록일자
ls_Worker    = gs_empcode //gstru_uid_uname.uid		//등록자
ls_IpAddr    = gs_ip   // gstru_uid_uname.address	//등록단말기
is_Name	    = TRIM(uo_member.sle_kname.Text)

ii_printopt = integer(dw_con.object.page[1])

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////

wf_SetMsg('제증명발급대장 신청번호 생성 중입니다.')
SELECT	NVL(MAX(A.APPLY_NO),0) + 1
INTO		:li_ApplyNo
FROM		INDB.HIN013H A
WHERE		A.APPLY_DATE LIKE SUBSTR(:is_frdate,1,4) || '%'
// AND		A.MEMBER_OPT = :ii_jikjongcode                 /* 2004-01-05 */
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
INSERT INTO INDB.HIN013H(APPLY_DATE, MEMBER_OPT, APPLY_NO, 	
				MEMBER_NO, 	APPLY_NAME, PRINT_OPT, 	LANG_OPT, 	PRINT_NUM, 		
				USE_OPT, 	NAME_ENG, PRICE,TOTAL_AMT,WORKER, 	WORK_DATE, 	IPADDR, 	
				JOB_UID,    JOB_ADD,  JOB_DATE)			
	VALUES   (:is_frdate,:is_jikjongcode,:li_ApplyNo,
			   :is_applyno,:is_name, 	2,	:ii_langopt, :ii_printOpt,
			   :is_remark,' ',:ii_price, :ii_printopt * :ii_price,:ls_Worker,:ldt_WorkDate,:ls_IpAddr,
				:ls_Worker,:ls_IpAddr,:ldt_WorkDate);
			
IF		SQLCA.SQLCODE  <> 0		THEN
		ROLLBACK;
		tab_1.tabpage_2.dw_data.Reset()
		wf_setmsg("저장중 오류가 발생하였습니다.")
		RETURN -1
END IF	
	
///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
Long	ll_cnt
//SELECT COUNT(*) 
//  INTO :ll_cnt
//  FROM INDB.HIN040H
// WHERE MEMBER_NO = :is_applyno;
//IF	is_chk = '1' and ll_cnt  >  0 	THEN
//	DELETE	FROM	INDB.HIN040H 
//	 WHERE 	MEMBER_NO 	=	:is_applyno;
//END IF	 

IF NOT tab_1.tabpage_2.dw_data.TRIGGER EVENT ue_db_save() THEN RETURN -1

wf_SetMsg('자료가 저장되었습니다.')
wf_SetMenuBtn('SRP')

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
//tab_1.tabpage_1.dw_update.Reset()
//
dw_con.object.gubn[1] = '7'
tab_1.tabpage_1.dw_print.SetReDraw(FALSE)
tab_1.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
tab_1.tabpage_1.dw_print.Reset()
tab_1.tabpage_1.dw_print.InsertRow(0)
tab_1.tabpage_1.dw_print.SetReDraw(TRUE)


/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMenuBtn('SDRP')
dw_con.SetFocus()
dw_con.setcolumn('gubn')
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////

tab_1.SelectTab(2)

ii_printopt = integer(dw_con.object.page[1])
tab_1.tabpage_1.dw_print.tag = string(ii_printopt)

f_print(tab_1.tabpage_1.dw_print)

////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
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
ll_GetRow = tab_1.tabpage_2.dw_data.GetRow()
IF ll_GetRow = 0 THEN RETURN

tab_1.tabpage_2.dw_data.DeleteRow(0)

end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 제증명 자료를 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
//em_fr_date.Text = f_today()
dw_con.object.fr_date[1] = f_today()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
tab_1.SelectTab(1)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin502a
end type

type ln_tempright from w_msheet`ln_tempright within w_hin502a
end type

type ln_temptop from w_msheet`ln_temptop within w_hin502a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin502a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin502a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin502a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin502a
end type

type uc_insert from w_msheet`uc_insert within w_hin502a
end type

type uc_delete from w_msheet`uc_delete within w_hin502a
end type

type uc_save from w_msheet`uc_save within w_hin502a
end type

type uc_excel from w_msheet`uc_excel within w_hin502a
end type

type uc_print from w_msheet`uc_print within w_hin502a
end type

type st_line1 from w_msheet`st_line1 within w_hin502a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_msheet`st_line2 within w_hin502a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_msheet`st_line3 within w_hin502a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin502a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin502a
integer beginy = 356
integer endy = 356
end type

type cb_1 from commandbutton within w_hin502a
boolean visible = false
integer x = 1696
integer y = 36
integer width = 517
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;string ls_gwamok_name, ls_gwa_name, ls_year, ls_hakgi, ls_gwa, ls_gwamok, ls_gwa_name_t
long ll_count

 DECLARE hin040h_cur CURSOR FOR  
  SELECT GWAMOK_NAME,   GWA_NAME,   YEAR,   HAKGI  
    FROM INDB.HIN040H  
	WHERE GWA IS NULL and year is not null
ORDER BY YEAR ASC,   HAKGI ASC,   GWAMOK_NAME ASC  ;
open hin040h_cur ;
do while true
	fetch next hin040h_cur into :ls_gwamok_name, :ls_gwa_name, :ls_year, :ls_hakgi ;
	if sqlca.sqlcode <> 0 then exit
	
	ls_gwa_name_t = ls_gwa_name
	if ls_gwa_name = '방송산업학과(주간)' then ls_gwa_name_t = '방송영상산업학과(주간)'
	if ls_gwa_name = '방송산업학과(야간)' then ls_gwa_name_t = '방송영상산업학과(야간)'
	
	if isnull(ls_year) or trim(ls_year) = '' then
		SELECT distinct A.GWA_1, A.GWAMOK_ID
		into   :ls_gwa, :ls_gwamok
		FROM 	HAKSA.VIEW_GAESUL  A
		WHERE FU_DEPT_NM(A.GWA_1,'K') = :ls_gwa_name_t
		and   FU_GWAMOK_NM(A.GWAMOK_ID,'K') = :ls_gwamok_name ;
	else
		SELECT distinct A.GWA_1, A.GWAMOK_ID
		into   :ls_gwa, :ls_gwamok
		FROM 	HAKSA.VIEW_GAESUL  A
		WHERE FU_DEPT_NM(A.GWA_1,'K') = :ls_gwa_name_t
		and   FU_GWAMOK_NM(A.GWAMOK_ID,'K') = :ls_gwamok_name
		and   A.YEAR = :ls_year
		and   A.HAKGI = :ls_hakgi ;
	end if
	
	if sqlca.sqlcode = 100 then
		ls_gwa = ''
		ls_gwamok = ''
	end if
	
	if isnull(ls_year) or trim(ls_year) = '' then
		UPDATE INDB.HIN040H  
			SET GWA = :ls_gwa,   GWAMOK_ID = :ls_gwamok
		WHERE ( GWAMOK_NAME =  :ls_gwamok_name ) AND  
				( GWA_NAME = :ls_gwa_name ) AND  
				( YEAR is null ) AND  
				( HAKGI is null ) AND
				GWA IS NULL;
	else
		UPDATE INDB.HIN040H  
			SET GWA = :ls_gwa,   GWAMOK_ID = :ls_gwamok
		WHERE ( GWAMOK_NAME =  :ls_gwamok_name ) AND  
				( GWA_NAME = :ls_gwa_name ) AND  
				( YEAR = :ls_year ) AND  
				( HAKGI = :ls_hakgi ) AND
				GWA IS NULL;
	end if
			
	if sqlca.sqlcode <> 0 then
		rollback;
		messagebox('error', sqlca.sqlerrtext)
		return
	end if
	
	ll_count ++
	wf_SetMsg(string(ll_count) + ':' + ls_gwa + ':' + ls_gwamok)

loop
close hin040h_cur ;

commit;

end event

type tab_1 from tab within w_hin502a
integer x = 50
integer y = 396
integer width = 4384
integer height = 1868
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
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_2,&
this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_2)
destroy(this.tabpage_1)
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
integer height = 1748
long backcolor = 16777215
string text = "제증명관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_data dw_data
end type

on tabpage_2.create
this.dw_data=create dw_data
this.Control[]={this.dw_data}
end on

on tabpage_2.destroy
destroy(this.dw_data)
end on

type dw_data from cuo_dwwindow_one_hin within tabpage_2
integer x = 5
integer y = 12
integer width = 4334
integer height = 1744
integer taborder = 10
string dataobject = "d_hin502a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1748
long backcolor = 16777215
string text = "제증명출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_1.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_1.destroy
destroy(this.dw_print)
end on

type dw_print from datawindow within tabpage_1
integer x = 14
integer y = 12
integer width = 4320
integer height = 1740
integer taborder = 50
string title = "none"
string dataobject = "d_hin502a_14"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(sqlca)
end event

type dw_con from uo_dwfree within w_hin502a
integer x = 50
integer y = 164
integer width = 4379
integer height = 192
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hin502a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
This.insertrow(0)

uo_member.setposition(totop!)
//////////////////////////////////////////////////////////////////////////////////////////
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
ls_UserID = gs_empcode //TRIM(gstru_uid_uname.uid)			//로그인사번
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

type uo_member from cuo_insa_member within w_hin502a
event destroy ( )
integer x = 814
integer y = 172
integer taborder = 110
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type cb_process from uo_imgbtn within w_hin502a
event destroy ( )
integer x = 59
integer y = 36
integer taborder = 61
boolean bringtotop = true
string btnname = "자료가져오기"
end type

on cb_process.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String  ls_MemberNo
String  ls_Gwaname, ls_gwa
String  ls_GwamokName, ls_gwamok
String  ls_Year
String  ls_Hakgi, ls_career_gb, ls_gubun
Long 	  li_sisu, li_seq, li_row, ll_count, ll_rowcount
String  ls_suup_start, ls_suup_end

SetPointer(HourGlass!)
dw_con.AcceptText()

ls_career_gb = dw_con.Object.career_gb[1]

ll_rowcount = tab_1.tabpage_2.dw_data.Retrieve(is_ApplyNo, ls_career_gb)
if ll_rowcount > 0 then li_seq = tab_1.tabpage_2.dw_data.Object.Career_Seq[ll_rowcount]

is_chk = '1'

Parent.TRIGGER EVENT ue_chk_condition()

wf_SetMsg('자료를 생성 중입니다.')

ls_career_gb = dw_con.Object.career_gb[1]

ls_MemberNo = is_applyno
DECLARE cur1 CURSOR FOR  
			SELECT A.MEMBER_NO
			         ,  MAX(B.FNAME)
                      ,  MAX(C.GWAMOK_HNAME)
				    , SUM(A.SISU) / COUNT(A.YEAR)
					, A.YEAR
					, A.HAKGI
					, A.GWA
					, A.GWAMOK_ID
					, '1'
			   FROM HAKSA.GAESUL_GWAMOK  A
                        , CDDB.KCH003M B
                        , HAKSA.GWAMOK_CODE C
                WHERE :ls_career_gb IN ('1', '%')
                    AND A.GWAMOK_ID = C.GWAMOK_ID
                    AND TRIM(A.GWA)  = TRIM(B.GWA)
                    AND A.MEMBER_NO = :ls_memberNo
                    AND A.SISU > 0
                GROUP BY A.MEMBER_NO, A.YEAR, A.HAKGI, A.GWA,A.GWAMOK_ID
				
			 UNION ALL
			 
		    SELECT   A.MEMBER_NO, 
						B.GWA_HNAME,
						C.GWAMOK_HNAME,
						A.SISU,
						A.YEAR,
						A.HAKGI,
						A.GWA_ID,
						A.GWAMOK_ID,
						'2'
				 FROM HAKSA.D_GAESUL_GWAMOK  A
				        , HAKSA.D_GWA_CODE  B
				        , HAKSA.D_GWAMOK_CODE C
				WHERE :ls_career_gb IN ('2', '%')
				     AND A.GWA_ID = B.GWA_ID
					AND A.GWAMOK_ID = C.GWAMOK_ID
					AND A.MEMBER_NO = :ls_memberNo
				    AND A.GAESUL_GUBUN = '01' 
			 USING SQLCA ;

OPEN	CUR1;

FETCH CUR1 INTO :ls_MemberNo, :ls_Gwaname, :ls_GwamokName, :li_sisu, :ls_Year, :ls_Hakgi, :ls_gwa, :ls_gwamok, :ls_gubun ;

IF SQLCA.SQLCODE <> 0 THEN				
	wf_SetMsg('자료를 발견하지 못하였습니다.'+SQLCA.SQLERRTEXT)
END IF
DO WHILE SQLCA.SQLCODE = 0
	SELECT count(*)  
		INTO 	:ll_count
		FROM	INDB.HIN040H  
		WHERE MEMBER_NO 	= :ls_MemberNo 
		AND   YEAR 			= :ls_Year 
		AND   HAKGI 		= :ls_Hakgi 
		AND   GWA 			= :ls_gwa 
		AND   GWAMOK_ID 	= :ls_gwamok
		AND  CAREER_GB  LIKE :ls_career_gb || '%'
		USING SQLCA ;

	if ll_count = 0 then
		li_Row = tab_1.tabpage_2.dw_data.InsertRow(0)
		li_seq ++
		
		If ls_gubun = '1' Then
		
			SELECT SUUP_START, SUUP_END
			   INTO :ls_suup_start, :ls_suup_end
			  FROM HAKSA.HAKSA_ILJUNG
			WHERE YEAR = :ls_year
			    AND HAKGI = :ls_hakgi
			USING SQLCA;
		Else
			SELECT SUUP_START, SUUP_END
			   INTO :ls_suup_start, :ls_suup_end
			 FROM HAKSA.D_HAKSA_ILJUNG
			WHERE YEAR = :ls_year
			    AND HAKGI = :ls_hakgi
			USING SQLCA;
		End If
		
		tab_1.tabpage_2.dw_data.Object.Member_No       [li_Row] = ls_MemberNo
		tab_1.tabpage_2.dw_data.Object.Career_Seq       [li_Row] = li_Seq
		tab_1.tabpage_2.dw_data.Object.Gwa_name        [li_Row] = ls_Gwaname
		tab_1.tabpage_2.dw_data.Object.Gwamok_Name  [li_Row] = ls_GwamokName
		tab_1.tabpage_2.dw_data.Object.Time_per_Week [li_Row] = li_sisu
		tab_1.tabpage_2.dw_data.Object.Year			     [li_Row] = ls_Year
		tab_1.tabpage_2.dw_data.Object.Hakgi		          [li_Row] = ls_Hakgi
		tab_1.tabpage_2.dw_data.Object.career_gb          [li_Row] = ls_gubun
		tab_1.tabpage_2.dw_data.Object.Gwa     	          [li_Row] = ls_Gwa
		tab_1.tabpage_2.dw_data.Object.Gwamok_id        [li_Row] = ls_Gwamok
		tab_1.tabpage_2.dw_data.Object.from_date     	  [li_Row] = ls_suup_start
		tab_1.tabpage_2.dw_data.Object.to_date               [li_Row] = ls_suup_end
		
		wf_SetMsg('자료를 설정 중 입니다.')
	end if
	FETCH CUR1 INTO :ls_MemberNo, :ls_Gwaname, :ls_GwamokName, :li_sisu, :ls_Year, :ls_Hakgi, :ls_gwa, :ls_gwamok, :ls_gubun ;
LOOP
CLOSE CUR1;



end event

type uo_1 from u_tab within w_hin502a
event destroy ( )
integer x = 1079
integer y = 428
integer taborder = 90
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

