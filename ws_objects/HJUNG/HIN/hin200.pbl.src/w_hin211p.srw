$PBExportHeader$w_hin211p.srw
$PBExportComments$연구업적 개인별 List
forward
global type w_hin211p from w_msheet
end type
type dw_print from cuo_dwwindow_one_hin within w_hin211p
end type
type uo_member from cuo_insa_member within w_hin211p
end type
type gb_1 from groupbox within w_hin211p
end type
end forward

global type w_hin211p from w_msheet
string title = "교직원조건별검색및출력"
dw_print dw_print
uo_member uo_member
gb_1 gb_1
end type
global w_hin211p w_hin211p

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

on w_hin211p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.uo_member=create uo_member
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.uo_member
this.Control[iCurrent+3]=this.gb_1
end on

on w_hin211p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.uo_member)
destroy(this.gb_1)
end on

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 연구업적 개인별 리스트를 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
dw_print.Object.DataWindow.Zoom = 100
dw_print.Object.DataWindow.Print.Preview = 'YES'

/////////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
/////////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
//
/////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////////
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
// 1.1 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)

SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

Long	ll_RowCnt
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(ls_KName)
dw_print.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////

dw_print.Object.t_kname.Text           = ls_KName
DateTime	ldt_SysDateTime
ldt_SysDateTime = f_sysdate()	//시스템일자
dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

/////////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
/////////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	tab_1.tabpage_3.dw_print_skip.Reset()
//	tab_1.tabpage_1.dw_update.RowsCopy(1,ll_RowCnt,Primary!,tab_1.tabpage_3.dw_print_skip,1,Primary!)
//	tab_1.tabpage_3.dw_print_skip.GroupCalc()
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
//	tab_1.tabpage_1.dw_update.SetFocus()
END IF
return 1
////////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
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
uo_member.sle_kname.text = ''
uo_member.sle_kname.SetFocus()
uo_member.sle_member_no.text = ''
dw_print.object.t_kname.text = ''

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
print(dw_print)


//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin211p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin211p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin211p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin211p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin211p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin211p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin211p
end type

type uc_insert from w_msheet`uc_insert within w_hin211p
end type

type uc_delete from w_msheet`uc_delete within w_hin211p
end type

type uc_save from w_msheet`uc_save within w_hin211p
end type

type uc_excel from w_msheet`uc_excel within w_hin211p
end type

type uc_print from w_msheet`uc_print within w_hin211p
end type

type st_line1 from w_msheet`st_line1 within w_hin211p
end type

type st_line2 from w_msheet`st_line2 within w_hin211p
end type

type st_line3 from w_msheet`st_line3 within w_hin211p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin211p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin211p
end type

type dw_print from cuo_dwwindow_one_hin within w_hin211p
integer x = 14
integer y = 252
integer width = 3845
integer height = 2352
integer taborder = 20
string dataobject = "d_hin211p_1"
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
//	idw_update[01].SetReDraw(FALSE)
//	idw_update[01].Reset()
//	idw_update[01].InsertRow(0)
//	idw_update[01].Object.DataWindow.ReadOnly = 'YES'
//	idw_update[01].SetReDraw(TRUE)
//
//	idw_update[02].SetReDraw(FALSE)
//	idw_update[02].Reset()
//	idw_update[02].InsertRow(0)
//	idw_update[02].Object.DataWindow.ReadOnly = 'YES'
//	idw_update[02].SetReDraw(TRUE)
//	RETURN
//END IF
/////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_MemberNo			//개인번호
//ls_MemberNo = dw_list.Object.hin001m_member_no[ll_GetRow]
//
//
//SetPointer(HourGlass!)
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMsg('[인사기본정보] 조회중입니다...')
//idw_update[01].SetReDraw(FALSE)
//idw_update[01].Reset()
//ll_RowCnt = idw_update[01].Retrieve(ls_MemberNo)
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
//	ls_DutyCode = idw_update[01].Object.duty_code[1]
//	li_AnnOpt   = idw_update[01].Object.ann_opt  [1]
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
//	idw_update[02].SetReDraw(FALSE)
//	idw_update[02].Reset()
//	ll_RowCnt = idw_update[02].Retrieve(ls_MemberNo)
//	IF ll_RowCnt > 0 THEN
//		idw_update[02].Object.DataWindow.ReadOnly = 'NO'
//	ELSE
//		idw_update[02].InsertRow(0)
//		idw_update[02].Object.DataWindow.ReadOnly = 'YES'
//	END IF
//	idw_update[02].SetReDraw(TRUE)
//	////////////////////////////////////////////////////////////////////////////////////
//	// 3.4 각세부자료 조회처리
//	////////////////////////////////////////////////////////////////////////////////////
//	Integer	li_idx
//	String	ls_Msg
//	FOR li_idx = 3 TO UpperBound(idw_update)
//		ls_Msg = is_SubTitle[li_idx]
//		wf_SetMsg(ls_Msg + ' 조회중입니다...')
//		idw_update[li_idx].SetReDraw(FALSE)
//		ll_RowCnt = idw_update[li_idx].Retrieve(ls_MemberNo)
//		idw_update[li_idx].SetReDraw(TRUE)
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
//		idw_update[01].Object.DataWindow.ReadOnly = 'YES'
//		wf_SetMenuBtn('R')
////////나중에 삭제처리========================================
//		wf_SetMenuBtn('IDSR')
//		idw_update[01].Object.DataWindow.ReadOnly = 'NO'
//	ELSE
//		wf_SetMsg('[인사기본정보] 자료가 조회되었습니다.')
//		idw_update[01].Object.DataWindow.ReadOnly = 'NO'
//		wf_SetMenuBtn('IDSR')
//	END IF
//ELSE
//	idw_update[01].InsertRow(0)
//	idw_update[01].Object.DataWindow.ReadOnly = 'YES'
//	
//	idw_update[02].SetReDraw(FALSE)
//	idw_update[02].InsertRow(0)
//	idw_update[02].Object.DataWindow.ReadOnly = 'YES'
//	idw_update[02].SetReDraw(TRUE)
//
//	wf_SetMenuBtn('R')	
//	wf_SetMsg('[인사기본정보] 해당 자료가 존재하지 않습니다.')
//END IF
//idw_update[01].SetReDraw(TRUE)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

type uo_member from cuo_insa_member within w_hin211p
event destroy ( )
integer x = 352
integer y = 104
integer height = 76
integer taborder = 10
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type gb_1 from groupbox within w_hin211p
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

