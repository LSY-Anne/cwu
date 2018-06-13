$PBExportHeader$w_hin109a.srw
$PBExportComments$경력년수가감표 등록/출력
forward
global type w_hin109a from w_msheet
end type
type tab_1 from tab within w_hin109a
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
type dw_print from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hin109a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_hin109a
end type
end forward

global type w_hin109a from w_msheet
integer height = 2616
string title = "경력년수가감표등록/출력"
tab_1 tab_1
uo_1 uo_1
end type
global w_hin109a w_hin109a

type variables

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

on w_hin109a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_hin109a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 경력년수가감표 자료를 관리한다.
////					호봉획정시 참조하기 위함.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//tab_1.tabpage_1.dw_update.Reset()
//tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
//tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_setMenuBtn('R')
//
//THIS.Trigger Event ue_retrieve(0,0)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
//
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

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
tab_1.tabpage_1.dw_update.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_update.Retrieve()
tab_1.tabpage_1.dw_update.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
DateTime	ldt_SysDateTime
ldt_SysDateTime = f_sysdate()	//시스템일자
tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_setMenuBtn('')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_setMenuBtn('SP')
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
ls_NotNullCol[1] = 'hin003m_jikjong_code/직종코드'
ls_NotNullCol[2] = 'hin003m_duty_code/직급코드'
IF f_chk_null(tab_1.tabpage_1.dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기

String	ls_CampCode = '1'	//캠퍼스코드
Integer	li_JikJongCode		//직종코드
String	ls_DutyCode			//직급코드
Integer	li_UnivYear			//대학졸업자
Integer	li_CollYear			//초대졸졸업자
Integer	li_ProfYear			//교수인정졸업자
Integer	li_Edu2Year			//2년교육대졸업자
Integer	li_Tea2Year			//2년사범대졸업자
Integer	li_Tea4Tear			//사범대졸업자
Integer	li_GivenSal			//기산호봉
Integer	li_LimitSal			//경력한계년수

ll_Row = tab_1.tabpage_1.dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gs_empcode //gstru_uid_uname.uid			//등록자
	ls_IPAddr    = gs_ip //gstru_uid_uname.address		//등록단말기
END IF
DO WHILE ll_Row > 0
	li_JikJongCode = tab_1.tabpage_1.dw_update.Object.hin003m_jikjong_code[ll_Row]	//직종코드
	ls_DutyCode    = tab_1.tabpage_1.dw_update.Object.hin003m_duty_code   [ll_Row]	//직급코드
	li_UnivYear    = tab_1.tabpage_1.dw_update.Object.univ_year           [ll_Row]	//대학졸업자
	li_CollYear    = tab_1.tabpage_1.dw_update.Object.coll_year           [ll_Row]	//초대졸졸업자
	li_ProfYear    = tab_1.tabpage_1.dw_update.Object.prof_year           [ll_Row]	//교수인정졸업자
	li_Edu2Year    = tab_1.tabpage_1.dw_update.Object.edu2_year           [ll_Row]	//2년교육대졸업자
	li_Tea2Year    = tab_1.tabpage_1.dw_update.Object.tea2_year           [ll_Row]	//2년사범대졸업자
	li_Tea4Tear    = tab_1.tabpage_1.dw_update.Object.tea4_year           [ll_Row]	//사범대졸업자
	li_GivenSal    = tab_1.tabpage_1.dw_update.Object.given_sal           [ll_Row]	//기산호봉
	li_LimitSal    = tab_1.tabpage_1.dw_update.Object.limit_sal           [ll_Row]	//경력한계년수
	
	INSERT	INTO	INDB.HIN018M
	VALUES	(	:ls_CampCode,
					:li_JikJongCode,
					:ls_DutyCode,
					:li_UnivYear,
					:li_CollYear,
					:li_ProfYear,
					:li_Edu2Year,
					:li_Tea2Year,
					:li_Tea4Tear,
					:li_GivenSal,
					:li_LimitSal,
					:ls_Worker,
					:ldt_WorkDate,
					:ls_IPAddr,
					:ls_Worker,
					:ls_IPAddr,
					:ldt_WorkDate	);
	IF SQLCA.SQLCODE <> 0 THEN
		UPDATE	INDB.HIN018M
		SET		UNIV_YEAR    = :li_UnivYear,
					COLL_YEAR    = :li_CollYear,
					PROF_YEAR    = :li_ProfYear,
					EDU2_YEAR    = :li_Edu2Year,
					TEA2_YEAR    = :li_Tea2Year,
					TEA4_YEAR    = :li_Tea4Tear,
					GIVEN_SAL    = :li_GivenSal,
					LIMIT_SAL    = :li_LimitSal,
					JOB_UID      = :ls_Worker,
					JOB_ADD      = :ls_IpAddr,
					JOB_DATE     = :ldt_WorkDate
		WHERE		CAMPUS_CODE    = :ls_CampCode
		AND		JIKJONG_CODE = :li_JikJongCode
		AND		DUTY_CODE    = :ls_DutyCode;
		IF SQLCA.SQLCODE <> 0 THEN EXIT
	END IF
	
	ll_Row = tab_1.tabpage_1.dw_update.GetNextModified(ll_Row,primary!)
LOOP


///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF SQLCA.SQLCODE = 0 THEN
	COMMIT;
	tab_1.tabpage_1.dw_update.ResetUpdate()
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText + '~r~n' + &
							'해당로우 : ' + String(ll_Row))
	ROLLBACK;
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_setMenuBtn('SP')
tab_1.tabpage_1.dw_update.SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//tab_1.SelectTab(2)
//f_print(tab_1.tabpage_2.dw_print)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_init();call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.SelectTab(1)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 경력년수가감표 자료를 관리한다.
//					호봉획정시 참조하기 위함.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_update.Reset()
tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print
///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenuBtn('R')

THIS.Trigger Event ue_retrieve()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

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

type ln_templeft from w_msheet`ln_templeft within w_hin109a
end type

type ln_tempright from w_msheet`ln_tempright within w_hin109a
end type

type ln_temptop from w_msheet`ln_temptop within w_hin109a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin109a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin109a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin109a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin109a
end type

type uc_insert from w_msheet`uc_insert within w_hin109a
end type

type uc_delete from w_msheet`uc_delete within w_hin109a
end type

type uc_save from w_msheet`uc_save within w_hin109a
end type

type uc_excel from w_msheet`uc_excel within w_hin109a
end type

type uc_print from w_msheet`uc_print within w_hin109a
end type

type st_line1 from w_msheet`st_line1 within w_hin109a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hin109a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hin109a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin109a
integer x = 3781
integer y = 144
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin109a
end type

type tab_1 from tab within w_hin109a
integer x = 50
integer y = 160
integer width = 4384
integer height = 2136
integer taborder = 20
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

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2016
string text = "경력년수가감표 관리"
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
integer x = 9
integer y = 16
integer width = 4334
integer height = 1984
integer taborder = 20
string dataobject = "d_hin109a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
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

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2016
string text = "경력년수가감표 리스트"
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
integer y = 12
integer width = 4347
integer height = 2008
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hin109a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from u_tab within w_hin109a
event destroy ( )
integer x = 1435
integer y = 128
integer taborder = 50
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

