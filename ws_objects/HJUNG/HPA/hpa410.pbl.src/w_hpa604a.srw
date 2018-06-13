$PBExportHeader$w_hpa604a.srw
$PBExportComments$연말정산관리
forward
global type w_hpa604a from w_msheet
end type
type dw_jikjong_code from datawindow within w_hpa604a
end type
type st_1 from statictext within w_hpa604a
end type
type uo_year from cuo_year within w_hpa604a
end type
type dw_update from cuo_dwwindow_one_hin within w_hpa604a
end type
type dw_list from cuo_dwwindow_one_hin within w_hpa604a
end type
type uo_member from cuo_insa_member within w_hpa604a
end type
type gb_1 from groupbox within w_hpa604a
end type
type gb_2 from groupbox within w_hpa604a
end type
end forward

global type w_hpa604a from w_msheet
string title = "인사발령등록"
dw_jikjong_code dw_jikjong_code
st_1 st_1
uo_year uo_year
dw_update dw_update
dw_list dw_list
uo_member uo_member
gb_1 gb_1
gb_2 gb_2
end type
global w_hpa604a w_hpa604a

type variables
DataWindowChild	idwc_CommCode	//공통코드(직종)
DataWindowChild	idwc_SalClass	//호봉코드 DDDW
String	ls_jikjong_Code
String   is_Year
end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

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

on w_hpa604a.create
int iCurrent
call super::create
this.dw_jikjong_code=create dw_jikjong_code
this.st_1=create st_1
this.uo_year=create uo_year
this.dw_update=create dw_update
this.dw_list=create dw_list
this.uo_member=create uo_member
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_jikjong_code
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_year
this.Control[iCurrent+4]=this.dw_update
this.Control[iCurrent+5]=this.dw_list
this.Control[iCurrent+6]=this.uo_member
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
end on

on w_hpa604a.destroy
call super::destroy
destroy(this.dw_jikjong_code)
destroy(this.st_1)
destroy(this.uo_year)
destroy(this.dw_update)
destroy(this.dw_list)
destroy(this.uo_member)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 연말정산의 내역을 수정 및 삭제한다.
//	작 성 인 : 박영복
//	작성일자 : 2004.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 직종코드 및 년도 추출
////////////////////////////////////////////////////////////////////////////////////
is_year	=	uo_year.uf_getyy()

f_getdwcommon(dw_JIKJONG_CODE, 'jikjong_code', 0, 750)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화이벤트 콜
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
// 1.1 
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.3 개인번호 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo
ls_MemberNo = TRIM(uo_member.sle_member_no.Text)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_list.SetReDraw(FALSE)
ll_RowCnt = dw_list.Retrieve(is_Year,ls_KName,ls_jikjong_Code)
dw_list.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('SR')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
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
//Long		ll_ChangeOpt
//wf_SetMsg('필수입력항목 체크 중입니다.')
//String	ls_NotNullCol[]
//ls_NotNullCol[1] = 'member_no/개인번호'
//ls_NotNullCol[2] = 'change_opt/발령구분'
//ls_NotNullCol[3] = 'from_date/발령기간'
//ll_ChangeOpt = dw_update.object.change_opt[1]
//IF ll_ChangeOpt = 83 OR ll_ChangeOpt = 84 OR ll_ChangeOpt = 12 THEN
//	ls_NotNullCol[4] = 'retire_date/퇴직일자'			
//END IF	
//
//IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF NOT dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//THIS.TRIGGEREVENT('ue_retrieve')
//wf_SetMenuBtn('DSR')
dw_update.SetFocus()
RETURN 1
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
//IF dw_update.ib_RowSingle THEN 
	ll_GetRow = dw_update.GetRow()
//IF NOT dw_update.ib_RowSingle THEN ll_GetRow = dw_update.GetSelectedRow(0)
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
Long		ll_DeleteCnt

IF dw_update.ib_RowSingle OR dw_update.getrow() = 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 2.1 삭제전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
	SetNull(ls_Msg)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
ll_DeleteCnt = dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	IF dw_update.ib_RowSingle THEN
		/////////////////////////////////////////////////////////////////////////////
		// 3.1 Single 처리인 경우.
		//			3.1.1 저장처리.
		//			3.1.2 한로우를 다시 추가.
		//			3.1.3 데이타원도우를 읽기모드로 수정.
		/////////////////////////////////////////////////////////////////////////////
		IF dw_update.TRIGGER EVENT ue_db_save() THEN
			dw_update.TRIGGER EVENT ue_db_append()
			dw_update.Object.DataWindow.ReadOnly = 'YES'
//			wf_SetMenuBtn('R')
		END IF
		
	ELSE
		/////////////////////////////////////////////////////////////////////////////
		//	3.2 Multi 처리인 경우.
		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
		/////////////////////////////////////////////////////////////////////////////
		IF dw_update.RowCount() > 0 THEN
//			wf_SetMenuBtn('DSR')
		ELSE
//			wf_SetMenuBtn('RS')
		END IF
	END IF
   THIS.TRIGGEREVENT('ue_retrieve')		
ELSE
END IF

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
dw_list.Reset()

dw_update.SetReDraw(FALSE)
dw_update.Reset()
dw_update.InsertRow(0)
dw_update.Object.DataWindow.ReadOnly = 'No'
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////

// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenuBtn('SDR')
uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hpa604a
end type

type ln_tempright from w_msheet`ln_tempright within w_hpa604a
end type

type ln_temptop from w_msheet`ln_temptop within w_hpa604a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hpa604a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hpa604a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hpa604a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hpa604a
end type

type uc_insert from w_msheet`uc_insert within w_hpa604a
end type

type uc_delete from w_msheet`uc_delete within w_hpa604a
end type

type uc_save from w_msheet`uc_save within w_hpa604a
end type

type uc_excel from w_msheet`uc_excel within w_hpa604a
end type

type uc_print from w_msheet`uc_print within w_hpa604a
end type

type st_line1 from w_msheet`st_line1 within w_hpa604a
end type

type st_line2 from w_msheet`st_line2 within w_hpa604a
end type

type st_line3 from w_msheet`st_line3 within w_hpa604a
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hpa604a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hpa604a
end type

type dw_jikjong_code from datawindow within w_hpa604a
integer x = 2455
integer y = 100
integer width = 1248
integer height = 104
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) or trim(data) = '0' or trim(data) = '' then	
	ls_jikjong_Code =	'%'
else
	ls_jikjong_code = trim(data)
end if



end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type st_1 from statictext within w_hpa604a
integer x = 2222
integer y = 116
integer width = 206
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "직종명"
boolean focusrectangle = false
end type

type uo_year from cuo_year within w_hpa604a
integer x = 96
integer y = 100
integer taborder = 100
boolean bringtotop = true
boolean border = false
end type

event constructor;call super::constructor;em_year.text = left(f_today(), 4)

end event

event ue_itemchange;call super::ue_itemchange;is_year = uf_getyy()


end event

on uo_year.destroy
call cuo_year::destroy
end on

type dw_update from cuo_dwwindow_one_hin within w_hpa604a
event type long ue_postitemchanged ( long row,  dwobject dwo,  string data )
integer x = 91
integer y = 1040
integer width = 3662
integer height = 1468
integer taborder = 40
string dataobject = "d_hpa604a_2"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event type long ue_postitemchanged(long row, dwobject dwo, string data);////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: ue_postitemchanged::dw_update
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
	CASE 'change_opt'
		///////////////////////////////////////////////////////////////////////////////// 
		//	발령구분변경시 발령사유가 없으면 발령구분명을 발령사유에 넣어준다.
		/////////////////////////////////////////////////////////////////////////////////
		String	ls_ChangeOpt
		ls_ChangeOpt = THIS.Describe("Evaluate('LookUpDisplay(change_opt)',"+String(row)+")")
		THIS.Object.change_reason[row] = ls_ChangeOpt
	CASE ELSE
END CHOOSE
RETURN 0
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event constructor;call super::constructor;//ib_RowSelect = FALSE
ib_RowSingle = TRUE
ib_SortGubn  = FALSE
ib_EnterChk  = TRUE
end event

type dw_list from cuo_dwwindow_one_hin within w_hpa604a
integer x = 14
integer y = 252
integer width = 3845
integer height = 716
integer taborder = 30
string dataobject = "d_hpa604a_1"
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

event rowfocuschanged;call super::rowfocuschanged;String ls_MemberNo
if currentrow < 1 then return
ls_MemberNo = This.Object.member_no[currentrow]
if dw_update.Retrieve(is_Year, ls_MemberNo) < 1 then
	dw_update.Reset()
	dw_update.InsertRow(0)
end if
end event

type uo_member from cuo_insa_member within w_hpa604a
integer x = 1010
integer y = 104
integer taborder = 20
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type gb_1 from groupbox within w_hpa604a
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

type gb_2 from groupbox within w_hpa604a
integer y = 980
integer width = 3858
integer height = 1536
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "연말정산상세내역"
end type

