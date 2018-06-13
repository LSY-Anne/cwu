$PBExportHeader$w_hpa304a.srw
$PBExportComments$개인별급여지급수정
forward
global type w_hpa304a from w_msheet
end type
type cbx_tae from checkbox within w_hpa304a
end type
type cbx_jae from checkbox within w_hpa304a
end type
type cbx_5 from checkbox within w_hpa304a
end type
type cbx_4 from checkbox within w_hpa304a
end type
type cbx_3 from checkbox within w_hpa304a
end type
type cbx_2 from checkbox within w_hpa304a
end type
type cbx_1 from checkbox within w_hpa304a
end type
type uo_yearmonth from cuo_yearmonth within w_hpa304a
end type
type dw_list_back from cuo_dwwindow_one_hin within w_hpa304a
end type
type uo_member from cuo_insa_member within w_hpa304a
end type
type st_con from statictext within w_hpa304a
end type
type dw_list from uo_dwgrid within w_hpa304a
end type
type dw_update from uo_dwgrid within w_hpa304a
end type
end forward

global type w_hpa304a from w_msheet
string title = "인사발령등록"
cbx_tae cbx_tae
cbx_jae cbx_jae
cbx_5 cbx_5
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
uo_yearmonth uo_yearmonth
dw_list_back dw_list_back
uo_member uo_member
st_con st_con
dw_list dw_list
dw_update dw_update
end type
global w_hpa304a w_hpa304a

type variables
DataWindowChild	idwc_DutyCode	//직급코드 DDDW
DataWindowChild	idwc_SalClass	//호봉코드 DDDW

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
//			CASE 'I' ; lb_Value = TRUE
//			CASE 'S' ; lb_Value = TRUE
//			CASE 'D' ; lb_Value = TRUE
//			CASE 'R' ; lb_Value = TRUE
//			CASE 'P' ; lb_Value = TRUE
//		END CHOOSE
//	END IF
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE ls_Flag[li_idx]
//		CASE 'I' ; ib_insert   = lb_Value
//		CASE 'S' ; ib_update   = lb_Value
//		CASE 'D' ; ib_delete   = lb_Value
//		CASE 'R' ; ib_retrieve = lb_Value
//		CASE 'P' ; ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

on w_hpa304a.create
int iCurrent
call super::create
this.cbx_tae=create cbx_tae
this.cbx_jae=create cbx_jae
this.cbx_5=create cbx_5
this.cbx_4=create cbx_4
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.uo_yearmonth=create uo_yearmonth
this.dw_list_back=create dw_list_back
this.uo_member=create uo_member
this.st_con=create st_con
this.dw_list=create dw_list
this.dw_update=create dw_update
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_tae
this.Control[iCurrent+2]=this.cbx_jae
this.Control[iCurrent+3]=this.cbx_5
this.Control[iCurrent+4]=this.cbx_4
this.Control[iCurrent+5]=this.cbx_3
this.Control[iCurrent+6]=this.cbx_2
this.Control[iCurrent+7]=this.cbx_1
this.Control[iCurrent+8]=this.uo_yearmonth
this.Control[iCurrent+9]=this.dw_list_back
this.Control[iCurrent+10]=this.uo_member
this.Control[iCurrent+11]=this.st_con
this.Control[iCurrent+12]=this.dw_list
this.Control[iCurrent+13]=this.dw_update
end on

on w_hpa304a.destroy
call super::destroy
destroy(this.cbx_tae)
destroy(this.cbx_jae)
destroy(this.cbx_5)
destroy(this.cbx_4)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.uo_yearmonth)
destroy(this.dw_list_back)
destroy(this.uo_member)
destroy(this.st_con)
destroy(this.dw_list)
destroy(this.dw_update)
end on

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 인사발령자료를 관리한다.
////	작 성 인 : 
////	작성일자 : 
////	변 경 인 : PYB
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화이벤트 콜
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
// 1.2 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.3 개인번호 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo
ls_MemberNo = TRIM(uo_member.sle_member_no.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.4 년월
////////////////////////////////////////////////////////////////////////////////////
String	ls_yymm
ls_yymm = uo_yearmonth.uf_getyearmonth()
////////////////////////////////////////////////////////////////////////////////////
// 1.5 차수
////////////////////////////////////////////////////////////////////////////////////
String	ls_chasu[5]
ls_chasu[1] = ''
ls_chasu[2] = ''
ls_chasu[3] = ''
ls_chasu[4] = ''
ls_chasu[5] = ''
if cbx_1.checked = true then ls_chasu[1] = '1'
if cbx_2.checked = true then ls_chasu[2] = '2'
if cbx_3.checked = true then ls_chasu[3] = '3'
if cbx_4.checked = true then ls_chasu[4] = '4'
if cbx_5.checked = true then ls_chasu[5] = '5'
////////////////////////////////////////////////////////////////////////////////////
// 1.6 재직구분
////////////////////////////////////////////////////////////////////////////////////
Integer	li_jaejik[4]
SetNull(li_jaejik[1])
SetNull(li_jaejik[2])
SetNull(li_jaejik[3])
SetNull(li_jaejik[4])
if cbx_jae.checked = true then li_jaejik[1] = 1
if cbx_tae.checked = true then li_jaejik[2] = 2
if cbx_jae.checked = true and cbx_tae.checked = true then 
	li_jaejik[1] = 1; li_jaejik[2] = 2; li_jaejik[3] = 3; li_jaejik[4] = 4
end if

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_list.SetReDraw(FALSE)
ll_RowCnt = dw_list.Retrieve(ls_KName, li_jaejik[])
dw_list.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('DSR')
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
//wf_SetMsg('필수입력항목 체크 중입니다.')
//String	ls_NotNullCol[]
//ls_NotNullCol[1] = 'member_no/개인번호'
//ls_NotNullCol[2] = 'term_opt/임기구분'
//ls_NotNullCol[3] = 'syymmdd/임기시작일'
//IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row				//변경된 행
Boolean	lb_Start = TRUE

DateTime	ldt_WorkDate		//등록일자
String	ls_Worker			//등록자
String	ls_IpAddr			//등록단말기

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//등록일자
	ls_Worker    = gs_empcode		//등록자
	ls_IpAddr    = gs_ip	//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = dw_update.GetItemStatus(ll_Row,0,Primary!)
	////////////////////////////////////////////////////////////////////////////////////
	// 3.1 수정항목 처리
	////////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		dw_update.Object.worker   [ll_Row] = ls_Worker		//등록자
		dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
		dw_update.Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
	END IF
	dw_update.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	dw_update.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	dw_update.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
//IF NOT dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1

IF dw_update.UPDATE() = 1 THEN
	COMMIT USING SQLCA;
	//RETURN 1
ELSE
	ROLLBACK USING SQLCA;
	RETURN -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
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

//IF dw_update.ib_RowSingle OR dw_update.GetSelectedRow(ll_GetRow) = 0 THEN
	/////////////////////////////////////////////////////////////////////////////////
	// 2.1 삭제전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
	String	ls_MemberNo			//개인번호
	String	ls_KName				//성명
	String	ls_chasu				//차수
	String	ls_yymm				//급여지급년월
	
	ls_MemberNo     = dw_update.Object.member_no	[ll_GetRow]	//개인번호
	ls_KName        = dw_update.Object.kname		[ll_GetRow]	//성명
	ls_chasu        = dw_update.Object.chasu   	[ll_GetRow]	//차수
	ls_yymm         = dw_update.Object.year_month[ll_GetRow]	//년월
	ls_Msg = '개인번호 : '+ls_MemberNo+'~r~n'+&
				'성    명 : '+ls_KName+'~r~n'+&
				'차    수 : '+ls_chasu+'~r~n'+&
				'지급년월 : '+ls_yymm
//ELSE
//	SetNull(ls_Msg)
//END IF

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
	
	ll_deletecnt = 1
//	RETURN 1

IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	//IF dw_update.ib_RowSingle THEN
		/////////////////////////////////////////////////////////////////////////////
		// 3.1 Single 처리인 경우.
		//			3.1.1 저장처리.
		//			3.1.2 한로우를 다시 추가.
		//			3.1.3 데이타원도우를 읽기모드로 수정.
		/////////////////////////////////////////////////////////////////////////////
		//IF dw_update.TRIGGER EVENT ue_db_save() THEN
			IF dw_update.UPDATE() = 1 THEN
				COMMIT USING SQLCA;
				
				//dw_update.TRIGGER EVENT ue_db_append()
				
				//IF ib_RowSingle THEN
				//	IF f_chk_update(THIS,'') = 3 THEN RETURN 0
					dw_update.Reset()
				//END IF
				
				Long	ll_InsertRow
				ll_InsertRow = dw_update.InsertRow(0)
				
				dw_update.SetRow(ll_InsertRow)
				dw_update.ScrollToRow(ll_InsertRow)
				dw_update.SetFocus()
				//IF ib_RowSelect THEN
					dw_update.SelectRow(0,FALSE)
					dw_update.SelectRow(ll_InsertRow,TRUE)
//				ELSE
//					THIS.Object.DataWindow.HorizontalScrollPosition = 0
//				END IF
				
				
				dw_update.Object.DataWindow.ReadOnly = 'YES'
//				wf_SetMenuBtn('SRD')
				//RETURN 1
			ELSE
				ROLLBACK USING SQLCA;
				//RETURN -1
			END IF
			
			
	//	END IF
		
//	ELSE
//		/////////////////////////////////////////////////////////////////////////////
//		//	3.2 Multi 처리인 경우.
//		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
//		/////////////////////////////////////////////////////////////////////////////
//		IF dw_update.RowCount() > 0 THEN
//			wf_SetMenuBtn('DSR')
//		ELSE
//			wf_SetMenuBtn('RS')
//		END IF
//	END IF
//	dw_update.TRIGGER EVENT ue_db_save()

	IF dw_update.UPDATE() = 1 THEN
		COMMIT USING SQLCA;
	//	RETURN 1
	ELSE
		ROLLBACK USING SQLCA;
		RETURN 
	END IF

//   THIS.TRIGGEREVENT('ue_retrieve')		
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
dw_update.Object.DataWindow.ReadOnly = 'NO'
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////

// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenuBtn('UDR')
uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 인사발령자료를 관리한다.
//	작 성 인 : 
//	작성일자 : 
//	변 경 인 : PYB
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화이벤트 콜
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hpa304a
end type

type ln_tempright from w_msheet`ln_tempright within w_hpa304a
end type

type ln_temptop from w_msheet`ln_temptop within w_hpa304a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hpa304a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hpa304a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hpa304a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hpa304a
end type

type uc_insert from w_msheet`uc_insert within w_hpa304a
end type

type uc_delete from w_msheet`uc_delete within w_hpa304a
end type

type uc_save from w_msheet`uc_save within w_hpa304a
end type

type uc_excel from w_msheet`uc_excel within w_hpa304a
end type

type uc_print from w_msheet`uc_print within w_hpa304a
end type

type st_line1 from w_msheet`st_line1 within w_hpa304a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_msheet`st_line2 within w_hpa304a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_msheet`st_line3 within w_hpa304a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hpa304a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hpa304a
end type

type cbx_tae from checkbox within w_hpa304a
integer x = 2085
integer y = 256
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "퇴직자"
end type

type cbx_jae from checkbox within w_hpa304a
integer x = 2085
integer y = 176
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "재직중"
boolean checked = true
end type

type cbx_5 from checkbox within w_hpa304a
integer x = 3493
integer y = 204
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "5차"
boolean checked = true
end type

type cbx_4 from checkbox within w_hpa304a
integer x = 3090
integer y = 252
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "4차"
end type

type cbx_3 from checkbox within w_hpa304a
integer x = 3086
integer y = 172
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "3차"
end type

type cbx_2 from checkbox within w_hpa304a
integer x = 2615
integer y = 252
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "2차"
end type

type cbx_1 from checkbox within w_hpa304a
integer x = 2610
integer y = 172
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "1차"
end type

type uo_yearmonth from cuo_yearmonth within w_hpa304a
event destroy ( )
integer x = 78
integer y = 200
integer taborder = 20
boolean border = false
end type

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

type dw_list_back from cuo_dwwindow_one_hin within w_hpa304a
boolean visible = false
integer x = 50
integer y = 332
integer width = 101
integer height = 100
integer taborder = 30
string dataobject = "d_hpa304a_1"
end type

event rowfocuschanging;/////////////////////////////////////////////////////////////////////////////////////////
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
	dw_update.SetReDraw(FALSE)
	dw_update.Reset()
	dw_update.InsertRow(0)
	dw_update.Object.DataWindow.ReadOnly = 'YES'
	dw_update.SetReDraw(TRUE)
	RETURN
END IF
///////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Kname		//성명
String	ls_yymm		//년월
ls_Kname		= dw_list.Object.kname [ll_GetRow]
ls_yymm 		= uo_yearmonth.uf_getyearmonth()
////////////////////////////////////////////////////////////////////////////////////
// 1.1 차수
////////////////////////////////////////////////////////////////////////////////////
String	ls_chasu[5]
ls_chasu[1] = ''
ls_chasu[2] = ''
ls_chasu[3] = ''
ls_chasu[4] = ''
ls_chasu[5] = ''
if cbx_1.checked = true then ls_chasu[1] = '1'
if cbx_2.checked = true then ls_chasu[2] = '2'
if cbx_3.checked = true then ls_chasu[3] = '3'
if cbx_4.checked = true then ls_chasu[4] = '4'
if cbx_5.checked = true then ls_chasu[5] = '5'

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
dw_update.SetReDraw(FALSE)
dw_update.Reset()
ll_RowCnt = dw_update.Retrieve(ls_kname,ls_yymm,ls_chasu[])
dw_update.SetReDraw(true)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

type uo_member from cuo_insa_member within w_hpa304a
integer x = 827
integer y = 200
integer taborder = 10
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type st_con from statictext within w_hpa304a
integer x = 50
integer y = 164
integer width = 4384
integer height = 156
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
boolean focusrectangle = false
end type

type dw_list from uo_dwgrid within w_hpa304a
integer x = 50
integer y = 332
integer width = 4384
integer height = 752
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hpa304a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event clicked;call super::clicked;////Override
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
	dw_update.SetReDraw(FALSE)
	dw_update.Reset()
	dw_update.InsertRow(0)
	dw_update.Object.DataWindow.ReadOnly = 'YES'
	dw_update.SetReDraw(TRUE)
	RETURN
END IF
///////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Kname		//성명
String	ls_yymm		//년월
ls_Kname		= dw_list.Object.kname [ll_GetRow]
ls_yymm 		= uo_yearmonth.uf_getyearmonth()
////////////////////////////////////////////////////////////////////////////////////
// 1.1 차수
////////////////////////////////////////////////////////////////////////////////////
String	ls_chasu[5]
ls_chasu[1] = ''
ls_chasu[2] = ''
ls_chasu[3] = ''
ls_chasu[4] = ''
ls_chasu[5] = ''
if cbx_1.checked = true then ls_chasu[1] = '1'
if cbx_2.checked = true then ls_chasu[2] = '2'
if cbx_3.checked = true then ls_chasu[3] = '3'
if cbx_4.checked = true then ls_chasu[4] = '4'
if cbx_5.checked = true then ls_chasu[5] = '5'

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
dw_update.SetReDraw(FALSE)
dw_update.Reset()
ll_RowCnt = dw_update.Retrieve(ls_kname,ls_yymm,ls_chasu[])
dw_update.SetReDraw(true)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type dw_update from uo_dwgrid within w_hpa304a
integer x = 50
integer y = 1092
integer width = 4384
integer height = 1172
integer taborder = 50
string dataobject = "d_hpa304a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

