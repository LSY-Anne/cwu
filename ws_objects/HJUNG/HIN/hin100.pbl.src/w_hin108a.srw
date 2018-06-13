$PBExportHeader$w_hin108a.srw
$PBExportComments$승진소요년수 등록/출력
forward
global type w_hin108a from w_msheet
end type
type tab_1 from tab within w_hin108a
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
type tab_1 from tab within w_hin108a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_con from uo_dwfree within w_hin108a
end type
type uo_1 from u_tab within w_hin108a
end type
end forward

global type w_hin108a from w_msheet
integer height = 2616
string title = "승진소요년수등록/출력"
tab_1 tab_1
dw_con dw_con
uo_1 uo_1
end type
global w_hin108a w_hin108a

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

on w_hin108a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_hin108a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 승진소요년수를 관리한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//ddlb_upgrade_opt.SelectItem(1)
//tab_1.tabpage_1.dw_update.Reset()
//tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
//tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화 이벤트 호출
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
//
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
// 1.1 구분
////////////////////////////////////////////////////////////////////////////////////
Integer	li_UpgradeOpt	//구분
dw_con.accepttext()
//li_UpgradeOpt = Integer(MID(ddlb_upgrade_opt.Text,1,1))
li_UpgradeOpt = Integer( dw_con.object.upgrade_opt[1])

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
tab_1.tabpage_1.dw_update.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_update.Retrieve(li_UpgradeOpt)
tab_1.tabpage_1.dw_update.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Title
IF li_UpgradeOpt = 1 THEN

	ls_Title = '직급별 승진 소요년수'
ELSE
	ls_Title = '기간제임용 소요년수'
END IF
tab_1.tabpage_2.dw_print.Object.t_title.Text = ls_Title

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
	dw_con.object.datawindow.readonly = 'No'
	dw_con.SetFocus()
ELSE
//	wf_setMenuBtn('SP')
	wf_SetMsg('자료가 조회되었습니다.')
	dw_con.object.datawindow.readonly = 'Yes'
	tab_1.tabpage_1.dw_update.SetFocus()
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

RETURN 1
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
// 1. 필수입력항목 CHECK
///////////////////////////////////////////////////////////////////////////////////////
Integer	li_UpgradeOpt	//구분
dw_con.accepttext()
//li_UpgradeOpt = Integer(MID(ddlb_upgrade_opt.Text,1,1))
li_UpgradeOpt = Integer( dw_con.object.upgrade_opt[1])


///////////////////////////////////////////////////////////////////////////////////////
// 2. 변경여부 CHECK
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
// 3. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'hin003m_duty_code/현직급코드'
IF f_chk_null(tab_1.tabpage_1.dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 4. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기

String		ls_DutyCode		//현직급
String		ls_UpDutyCode	//상위직급
Decimal{2}	ldc_SpendYear	//소요년수

ll_Row = tab_1.tabpage_1.dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gs_empcode//gstru_uid_uname.uid			//등록자
	ls_IPAddr    = gs_ip  //gstru_uid_uname.address		//등록단말기
END IF
DO WHILE ll_Row > 0
	ls_DutyCode   = tab_1.tabpage_1.dw_update.Object.hin003m_duty_code   [ll_Row]	//현직급
	ls_UpDutyCode = tab_1.tabpage_1.dw_update.Object.hin024m_up_duty_code[ll_Row]	//상위직급
	ldc_SpendYear = tab_1.tabpage_1.dw_update.Object.hin024m_spend_year  [ll_Row]	//소요년수

	INSERT	INTO	INDB.HIN024M
	VALUES	(	:ls_DutyCode,
					:li_UpgradeOpt,
					:ls_UpDutyCode,
					:ldc_SpendYear,
					:ls_Worker,
					:ldt_WorkDate,
					:ls_IPAddr,
					:ls_Worker,
					:ls_IPAddr,
					:ldt_WorkDate	);
	IF SQLCA.SQLCODE <> 0 THEN
		UPDATE	INDB.HIN024M
		SET		UP_DUTY_CODE = :ls_UpDutyCode,
					SPEND_YEAR   = :ldc_SpendYear,
					JOB_UID      = :ls_Worker,
					JOB_ADD      = :ls_IpAddr,
					JOB_DATE     = :ldt_WorkDate
		WHERE		DUTY_CODE    = :ls_DutyCode
		AND		UPGRADE_OPT  = :li_UpgradeOpt;
		IF SQLCA.SQLCODE <> 0 THEN EXIT
	END IF
	
	ll_Row = tab_1.tabpage_1.dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 5. 자료저장처리
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
// 6. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
dw_con.object.datawindow.readonly = 'No' 
wf_SetMsg('자료가 저장되었습니다.')
//wf_setMenuBtn('SP')
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
//wf_setMenuBtn('R')
dw_con.object.datawindow.readonly = 'No'
//ddlb_upgrade_opt.Enabled = TRUE
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

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 승진소요년수를 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
func.of_design_con(dw_con)
dw_con.settransobject(sqlca)
dw_con.insertrow(0)
tab_1.tabpage_1.dw_update.Reset()
tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print
///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

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

type ln_templeft from w_msheet`ln_templeft within w_hin108a
end type

type ln_tempright from w_msheet`ln_tempright within w_hin108a
end type

type ln_temptop from w_msheet`ln_temptop within w_hin108a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin108a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin108a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin108a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin108a
end type

type uc_insert from w_msheet`uc_insert within w_hin108a
end type

type uc_delete from w_msheet`uc_delete within w_hin108a
end type

type uc_save from w_msheet`uc_save within w_hin108a
end type

type uc_excel from w_msheet`uc_excel within w_hin108a
end type

type uc_print from w_msheet`uc_print within w_hin108a
end type

type st_line1 from w_msheet`st_line1 within w_hin108a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hin108a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hin108a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin108a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin108a
end type

type tab_1 from tab within w_hin108a
integer x = 50
integer y = 316
integer width = 4384
integer height = 2004
integer taborder = 10
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
integer height = 1884
string text = "승진소요년수 관리"
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
integer width = 4343
integer height = 1880
integer taborder = 10
string dataobject = "d_hin108a_1"
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
integer height = 1884
string text = "승진소요년수 리스트"
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
integer width = 4357
integer height = 1884
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_hin108a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_con from uo_dwfree within w_hin108a
integer x = 50
integer y = 164
integer width = 4384
integer height = 108
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_hin108a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from u_tab within w_hin108a
event destroy ( )
integer x = 773
integer y = 320
integer taborder = 60
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

