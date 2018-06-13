$PBExportHeader$w_hin208p.srw
$PBExportComments$인사기본정보출력
forward
global type w_hin208p from w_msheet
end type
type tab_1 from tab within w_hin208p
end type
type tabpage_1 from userobject within tab_1
end type
type dw_list from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_list dw_list
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hin208p
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_con from uo_dwfree within w_hin208p
end type
type uo_member from cuo_insa_member within w_hin208p
end type
type uo_1 from u_tab within w_hin208p
end type
end forward

global type w_hin208p from w_msheet
integer height = 2616
string title = "인사기본정보출력"
tab_1 tab_1
dw_con dw_con
uo_member uo_member
uo_1 uo_1
end type
global w_hin208p w_hin208p

type variables
DataWindowChild	idwc_DutyCode	//직급코드 DDDW
DataWindowChild	idwc_SalClass	//호봉코드 DDDW
DataWindow			idw_main[]		//
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
											  '[신상변동이력]'}


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

on w_hin208p.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_con=create dw_con
this.uo_member=create uo_member
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_member
this.Control[iCurrent+4]=this.uo_1
end on

on w_hin208p.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_con)
destroy(this.uo_member)
destroy(this.uo_1)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 인사기본정보를 출력한다.
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
//DataWindowChild	ldwc_Temp
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
//tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
//tab_1.tabpage_2.dw_print.Object.DataWindow.zoom = 100
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2.  초기화 이벤트 호출
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
//
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
// 1.1 부서명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_DeptCode
dw_con.accepttext()

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
tab_1.tabpage_1.dw_list.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_list.Retrieve(ls_DeptCode,ls_DutyCode,ls_KName,&
																ls_JaejikOpt,ls_JikJongCode)
tab_1.tabpage_1.dw_list.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
DateTime	ldt_SysDateTime
ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('IR')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
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
tab_1.SelectTab(1)
tab_1.tabpage_1.dw_list.Reset()
tab_1.tabpage_2.dw_print.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
//wf_setMenuBtn('R')
uo_member.sle_kname.SetFocus()
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

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 인사기본정보를 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 부서명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
Long					ll_InsRow

dw_con.insertrow(0)

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

tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
tab_1.tabpage_2.dw_print.Object.DataWindow.zoom = 100

///////////////////////////////////////////////////////////////////////////////////////
// 2.  초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin208p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin208p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin208p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin208p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin208p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin208p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin208p
end type

type uc_insert from w_msheet`uc_insert within w_hin208p
end type

type uc_delete from w_msheet`uc_delete within w_hin208p
end type

type uc_save from w_msheet`uc_save within w_hin208p
end type

type uc_excel from w_msheet`uc_excel within w_hin208p
end type

type uc_print from w_msheet`uc_print within w_hin208p
end type

type st_line1 from w_msheet`st_line1 within w_hin208p
end type

type st_line2 from w_msheet`st_line2 within w_hin208p
end type

type st_line3 from w_msheet`st_line3 within w_hin208p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin208p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin208p
integer beginy = 348
integer endy = 348
end type

type tab_1 from tab within w_hin208p
integer x = 50
integer y = 388
integer width = 4384
integer height = 1980
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
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
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4347
integer height = 1864
long backcolor = 16777215
string text = "인사기본정보 조회"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list dw_list
end type

on tabpage_1.create
this.dw_list=create dw_list
this.Control[]={this.dw_list}
end on

on tabpage_1.destroy
destroy(this.dw_list)
end on

type dw_list from cuo_dwwindow_one_hin within tabpage_1
integer y = 12
integer width = 4343
integer height = 1852
integer taborder = 30
string dataobject = "d_hin202i_01"
boolean hsplitscroll = true
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
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

event rowfocuschanging;call super::rowfocuschanging;/////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
ll_GetRow = newrow
IF ll_GetRow = 0 THEN RETURN
ll_RowCnt = THIS.RowCount()
IF ll_RowCnt = 0 THEN
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo	//개인번호
ls_MemberNo  = tab_1.tabpage_1.dw_list.Object.hin001m_member_no[ll_GetRow]


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
tab_1.tabpage_2.dw_print.Reset()
ll_RowCnt = tab_1.tabpage_2.dw_print.Retrieve(ls_MemberNo)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
//	wf_SetMenuBtn('RP')
	wf_SetMsg('자료가 조회되었습니다.')
ELSE
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
END IF
tab_1.tabpage_2.dw_print.SetReDraw(TRUE)
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4347
integer height = 1864
long backcolor = 16777215
string text = "인사기본정보 출력"
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
integer y = 16
integer width = 4343
integer height = 1816
integer taborder = 150
string dataobject = "d_hin208p_91"
boolean vscrollbar = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_con from uo_dwfree within w_hin208p
integer x = 55
integer y = 164
integer width = 4379
integer height = 180
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_hin202a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

type uo_member from cuo_insa_member within w_hin208p
event destroy ( )
integer x = 1531
integer y = 256
integer taborder = 60
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

event constructor;call super::constructor;setposition(totop!)
end event

type uo_1 from u_tab within w_hin208p
event destroy ( )
integer x = 1257
integer y = 388
integer taborder = 60
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

