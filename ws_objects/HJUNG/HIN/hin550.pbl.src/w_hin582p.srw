$PBExportHeader$w_hin582p.srw
$PBExportComments$근무상황 집계표
forward
global type w_hin582p from w_msheet
end type
type em_yymm from editmask within w_hin582p
end type
type st_24 from statictext within w_hin582p
end type
type dw_dept_code from datawindow within w_hin582p
end type
type st_19 from statictext within w_hin582p
end type
type dw_print from cuo_dwwindow_one_hin within w_hin582p
end type
type gb_1 from groupbox within w_hin582p
end type
end forward

global type w_hin582p from w_msheet
string title = "교직원조건별검색및출력"
em_yymm em_yymm
st_24 st_24
dw_dept_code dw_dept_code
st_19 st_19
dw_print dw_print
gb_1 gb_1
end type
global w_hin582p w_hin582p

type variables

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

on w_hin582p.create
int iCurrent
call super::create
this.em_yymm=create em_yymm
this.st_24=create st_24
this.dw_dept_code=create dw_dept_code
this.st_19=create st_19
this.dw_print=create dw_print
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_yymm
this.Control[iCurrent+2]=this.st_24
this.Control[iCurrent+3]=this.dw_dept_code
this.Control[iCurrent+4]=this.st_19
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.gb_1
end on

on w_hin582p.destroy
call super::destroy
destroy(this.em_yymm)
destroy(this.st_24)
destroy(this.dw_dept_code)
destroy(this.st_19)
destroy(this.dw_print)
destroy(this.gb_1)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 근무상황집계표를 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
//////////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 부서명 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
Long					ll_InsRow

dw_dept_code.GetChild('code',ldwc_Temp)
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
dw_dept_code.InsertRow(0)

dw_print.Object.DataWindow.Zoom = 100
dw_print.Object.DataWindow.Print.Preview = 'YES'

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
wf_SetMsg('조회조건 체크 중입니다...')
////////////////////////////////////////////////////////////////////////////////////
// 1.1 년월 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_Yymm, ls_yy, ls_mm
em_Yymm.GetData(ls_Yymm)
IF LEN(ls_Yymm) > 0 THEN
	IF NOT f_isDate(ls_Yymm+'01') THEN
		MessageBox('확인','년월 입력오류입니다.')
		em_Yymm.SetFocus()
		RETURN -1
	END IF
END IF
ls_Yymm = Trim(ls_Yymm)
ls_yy = mid(ls_Yymm, 1, 4)
ls_mm = mid(ls_Yymm, 5, 2)
ls_Yymm = ls_yy + ls_mm

////////////////////////////////////////////////////////////////////////////////////
// 1.2 부서명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_DeptCode
String	ls_DeptName
ls_DeptCode = TRIM(dw_dept_code.Object.code     [1])
ls_DeptName = TRIM(dw_dept_code.Object.code_name[1])
IF LEN(ls_DeptCode) = 0 OR isNull(ls_DeptCode) OR &
	ls_DeptCode = '0000' OR ls_DeptCode = '9999' THEN 
	ls_DeptCode = ''
	ls_DeptName= '전체'
END IF

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

Long	ll_RowCnt
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(ls_yy, ls_mm, ls_DeptCode)
dw_print.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
dw_print.Object.t_yymm.Text    = String(ls_Yymm, '@@@@/@@')
dw_print.Object.t_dept_nm.Text = ls_DeptName
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	dw_print.SetFocus()
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
dw_print.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)//조회버튼 활성화

em_yymm.Text = f_today()
em_yymm.SetFocus()
//String	ls_DeptCode
dw_dept_code.Object.code [1] = ''
dw_print.object.t_yymm.text = ''
dw_print.object.t_dept_nm.text = ''
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
f_print(dw_print)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin582p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin582p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin582p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin582p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin582p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin582p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin582p
end type

type uc_insert from w_msheet`uc_insert within w_hin582p
end type

type uc_delete from w_msheet`uc_delete within w_hin582p
end type

type uc_save from w_msheet`uc_save within w_hin582p
end type

type uc_excel from w_msheet`uc_excel within w_hin582p
end type

type uc_print from w_msheet`uc_print within w_hin582p
end type

type st_line1 from w_msheet`st_line1 within w_hin582p
end type

type st_line2 from w_msheet`st_line2 within w_hin582p
end type

type st_line3 from w_msheet`st_line3 within w_hin582p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin582p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin582p
end type

type em_yymm from editmask within w_hin582p
integer x = 357
integer y = 104
integer width = 297
integer height = 76
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
string mask = "####/##"
boolean autoskip = true
end type

type st_24 from statictext within w_hin582p
integer x = 187
integer y = 116
integer width = 169
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "년월"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_dept_code from datawindow within w_hin582p
integer x = 919
integer y = 100
integer width = 896
integer height = 80
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_dept_code"
boolean border = false
boolean livescroll = true
end type

type st_19 from statictext within w_hin582p
integer x = 713
integer y = 116
integer width = 206
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "부서명"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_print from cuo_dwwindow_one_hin within w_hin582p
integer x = 14
integer y = 252
integer width = 3845
integer height = 2352
integer taborder = 20
string dataobject = "d_hin582p_1"
end type

event clicked;////Override
//String	ls_ColName
//ls_ColName = UPPER(dwo.name)
//IF ls_ColName = 'DATAWINDOW' THEN RETURN
//
//IF THIS.RowCount() > 0 AND UPPER(RIGHT(ls_ColName,2)) = '_T' AND ib_SortGubn THEN
//	THIS.TRIGGER EVENT ue_et_sort()
//	
//	Long	ll_SelectRow
//	ll_SelectRow = THIS.GetSelectedRow(0)
//	THIS.SetRedraw(FALSE)
//	IF ll_SelectRow = 0 THEN ll_SelectRow = 1
//	THIS.ScrollToRow(ll_SelectRow)
//	THIS.SetRedraw(TRUE)
//	RETURN 1
//END IF
//
end event

event constructor;call super::constructor;//ib_RowSelect = TRUE
//ib_RowSingle = TRUE
//ib_SortGubn  = TRUE
//ib_EnterChk  = FALSE
end event

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
//	idw_print[01].SetReDraw(FALSE)
//	idw_print[01].Reset()
//	idw_print[01].InsertRow(0)
//	idw_print[01].Object.DataWindow.ReadOnly = 'YES'
//	idw_print[01].SetReDraw(TRUE)
//
//	idw_print[02].SetReDraw(FALSE)
//	idw_print[02].Reset()
//	idw_print[02].InsertRow(0)
//	idw_print[02].Object.DataWindow.ReadOnly = 'YES'
//	idw_print[02].SetReDraw(TRUE)
//	RETURN
//END IF
/////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_MemberNo			//개인번호
//ls_MemberNo = dw_print.Object.hin001m_member_no[ll_GetRow]
//
//
//SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMsg('[인사기본정보] 조회중입니다...')
//idw_print[01].SetReDraw(FALSE)
//idw_print[01].Reset()
//ll_RowCnt = idw_print[01].Retrieve(ls_MemberNo)
//		
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
/////////////////////////////////////////////////////////////////////////////////////////
//IF ll_RowCnt > 0 THEN
//	////////////////////////////////////////////////////////////////////////////////////
//	//	3.1 호봉코드DDDW 초기화 처리
//	////////////////////////////////////////////////////////////////////////////////////
//	String	ls_DutyCode		//직급코드
//	Integer	li_AnnOpt		//연봉구분
//	
//	ls_DutyCode = idw_print[01].Object.duty_code[1]
//	li_AnnOpt   = idw_print[01].Object.ann_opt  [1]
//	IF MID(ls_DutyCode,1,1) = '1' THEN ls_DutyCode = '100'
//	IF li_AnnOpt = 2 THEN ls_DutyCode = '801'
//	idwc_SalClass.Reset()
//	IF idwc_SalClass.Retrieve(ls_DutyCode) = 0 THEN
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
//	idw_print[02].SetReDraw(FALSE)
//	idw_print[02].Reset()
//	ll_RowCnt = idw_print[02].Retrieve(ls_MemberNo)
//	IF ll_RowCnt > 0 THEN
//		idw_print[02].Object.DataWindow.ReadOnly = 'NO'
//	ELSE
//		idw_print[02].InsertRow(0)
//		idw_print[02].Object.DataWindow.ReadOnly = 'YES'
//	END IF
//	idw_print[02].SetReDraw(TRUE)
//	////////////////////////////////////////////////////////////////////////////////////
//	// 3.4 각세부자료 조회처리
//	////////////////////////////////////////////////////////////////////////////////////
//	Integer	li_idx
//	String	ls_Msg
//	FOR li_idx = 3 TO UpperBound(idw_print)
//		ls_Msg = is_SubTitle[li_idx]
//		wf_SetMsg(ls_Msg + ' 조회중입니다...')
//		idw_print[li_idx].SetReDraw(FALSE)
//		ll_RowCnt = idw_print[li_idx].Retrieve(ls_MemberNo)
//		idw_print[li_idx].SetReDraw(TRUE)
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
//		idw_print[01].Object.DataWindow.ReadOnly = 'YES'
//		wf_SetMenuBtn('R')
////////나중에 삭제처리========================================
//		wf_SetMenuBtn('IDSR')
//		idw_print[01].Object.DataWindow.ReadOnly = 'NO'
//	ELSE
//		wf_SetMsg('[인사기본정보] 자료가 조회되었습니다.')
//		idw_print[01].Object.DataWindow.ReadOnly = 'NO'
//		wf_SetMenuBtn('IDSR')
//	END IF
//ELSE
//	idw_print[01].InsertRow(0)
//	idw_print[01].Object.DataWindow.ReadOnly = 'YES'
//	
//	idw_print[02].SetReDraw(FALSE)
//	idw_print[02].InsertRow(0)
//	idw_print[02].Object.DataWindow.ReadOnly = 'YES'
//	idw_print[02].SetReDraw(TRUE)
//
//	wf_SetMenuBtn('R')	
//	wf_SetMsg('[인사기본정보] 해당 자료가 존재하지 않습니다.')
//END IF
//idw_print[01].SetReDraw(TRUE)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

type gb_1 from groupbox within w_hin582p
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

