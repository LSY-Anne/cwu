$PBExportHeader$w_hfn203a.srw
$PBExportComments$결의서송부취소
forward
global type w_hfn203a from w_msheet
end type
type dw_update from cuo_dwwindow_one_hin within w_hfn203a
end type
type cb_preview from commandbutton within w_hfn203a
end type
type dw_con from uo_dwfree within w_hfn203a
end type
type cb_all from uo_imgbtn within w_hfn203a
end type
type cb_can from uo_imgbtn within w_hfn203a
end type
end forward

global type w_hfn203a from w_msheet
string title = "결의서송부취소"
event type boolean ue_chk_condition ( )
dw_update dw_update
cb_preview cb_preview
dw_con dw_con
cb_all cb_all
cb_can cb_can
end type
global w_hfn203a w_hfn203a

type variables

end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

event type boolean ue_chk_condition();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_chk_condition
//	기 능 설 명: 조회조건체크처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
date 		ld_date
String ls_resoldept, ls_frdate, ls_todate


// 조회조건 체크
wf_SetMsg('조회조건 체크 중입니다...')

dw_con.accepttext()
// 결의부서 입력여부 체크
ls_resoldept = dw_con.object.code[1]
IF LEN(ls_resoldept) = 0 OR isNull(ls_resoldept) OR ls_resoldept = '0' THEN
	ls_Msg = '결의부서를 선택하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	dw_con.SetFocus()
	dw_con.setcolumn('code')
	RETURN FALSE
END IF

// 결의기간 입력여부 체크
ls_frdate = String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_todate = String(dw_con.object.to_date[1], 'yyyymmdd')
IF ls_FrDate > ls_ToDate THEN
	MessageBox('확인','결의일자의 범위 오류입니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('to_Date')
	RETURN FALSE
END IF

RETURN TRUE

end event

public subroutine wf_setmenubtn (string as_type);//Boolean	lb_Value
//String	ls_Flag[] = {'I','S','D','R','P'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
//	m_main_menu.mf_menuuser(ls_Flag[li_idx],lb_Value)		
//	
//	CHOOSE CASE ls_Flag[li_idx]
//		CASE 'I' ; ib_insert   = lb_Value
//		CASE 'S' ; ib_update   = lb_Value
//		CASE 'D' ; ib_delete   = lb_Value
//		CASE 'R' ; ib_retrieve = lb_Value
//		CASE 'P' ; ib_print    = lb_Value
//		CASE 'P' ; ib_print    = lb_Value
//	END CHOOSE
//NEXT
end subroutine

on w_hfn203a.create
int iCurrent
call super::create
this.dw_update=create dw_update
this.cb_preview=create cb_preview
this.dw_con=create dw_con
this.cb_all=create cb_all
this.cb_can=create cb_can
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update
this.Control[iCurrent+2]=this.cb_preview
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.cb_all
this.Control[iCurrent+5]=this.cb_can
end on

on w_hfn203a.destroy
call super::destroy
destroy(this.dw_update)
destroy(this.cb_preview)
destroy(this.dw_con)
destroy(this.cb_all)
destroy(this.cb_can)
end on

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 결의서 송부취소
////	작 성 인 : 이현수
////	작성일자 : 2002.11
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//string				ls_fr_date, ls_to_date
//
//// 초기값처리
//// 조회조건 - 회계구분명 DDDW초기화
//dw_acct_class.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('acct_class',1) = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//dw_acct_class.InsertRow(0)
//dw_acct_class.Object.code[1] = '1'
//
//// 조회조건 - 결의부서명 DDDW초기화
//dw_resol_dept.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve(1, 3) = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//dw_resol_dept.InsertRow(0)
//dw_resol_dept.Object.code[1] = gstru_uid_uname.dept_code
//
//// 조회조건 - 결의구분
//ddlb_slip_class.SelectItem(1)
//ddlb_slip_class.TRIGGER EVENT SelectionChanged(1)
//
//// 조회조건 - 발의기간 초기화
//ls_fr_date = mid(f_getacctyear(f_getbdgtyear(f_today())), 2, 8)
////ls_fr_date = f_today()
//ls_to_date = f_lastdate(f_today())
//em_fr_date.Text = left(ls_fr_date,4) + '/' + mid(ls_fr_date,5,2) + '/' + right(ls_fr_date,2)
//em_to_date.Text = left(ls_to_date,4) + '/' + mid(ls_to_date,5,2) + '/' + right(ls_to_date,2)
//
//// 초기화
//THIS.TRIGGER EVENT ue_init()
//
end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
//wf_SetMenuBtn('SR')
dw_con.SetFocus()
dw_con.setcolumn('fr_date')

dw_update.Reset()

end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long	ll_RowCnt
String ls_resoldept, ls_frdate, ls_todate, ls_SlipClass = ''

dw_con.accepttext()
ls_resoldept = dw_con.object.code[1]
ls_frdate = String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_todate = String(dw_con.object.to_date[1], 'yyyymmdd')

// 조회조건 체크
IF NOT THIS.TRIGGER EVENT ue_chk_condition() THEN RETURN -1



// 자료조회
wf_SetMsg('조회 처리 중입니다...')
dw_update.SetReDraw(FALSE)

ll_RowCnt = dw_update.Retrieve(gi_acct_class, ls_ResolDept, ls_SlipClass, ls_FrDate, ls_ToDate )
dw_update.SetReDraw(TRUE)

// 메뉴버튼 활성/비활성화 처리 및 메세지 처리
IF ll_RowCnt > 0 THEN 
	wf_SetMsg('해당자료가 조회되었습니다.')
ELSE
	wf_SetMsg('해당자료가 존재하지 않습니다.')
END IF



end event

event ue_save;call super::ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
DwItemStatus	ldis_Status
String			ls_Msg
Integer			li_Rtn
Long				ll_Row			//변경된 행
DateTime			ldt_WorkDate	//등록일자
String			ls_Worker		//등록자
String			ls_IPAddr		//등록단말기
Integer			li_AcctClass	//회계구분
String			ls_ResolDate	//결의일자
Integer			li_ResolNo		//결의번호
Integer			li_Chk			//선택여부
String			ls_PassDt		//송부일자
Integer			li_StepOpt		//결의상태
String			ls_StepOptNm	//결의상태명
String			ls_Null

// 송부취소할 자료가 선택되었는지 체크
If dw_update.find("com_chk = 1",1,dw_update.rowcount()) < 1 Then
	wf_setmsg('자료를 선택 후 저장하시기 바랍니다.')
	Return -1
End If

ls_Msg = '송부된 결의서를 취소처리 하시겠습니까?'
li_Rtn = MessageBox('확인',ls_Msg,Question!,YesNo!,1)

IF li_Rtn = 2 THEN RETURN -1



// 저장처리전 체크사항 기술
SetNull(ls_Null)

ldt_WorkDate = f_sysdate()						//등록일자
ls_Worker    = gs_empcode			//등록자
ls_IPAddr    = gs_ip		//등록단말기
ls_PassDt    = ls_Null							//송부일자
li_StepOpt   = 1									//결의상태
ls_StepOptNm = '결의서작성'					//결의상태명

ll_Row = dw_update.GetNextModified(0,primary!)

DO WHILE ll_Row > 0
	li_Chk       = dw_update.Object.com_chk   [ll_row]	//선택여부
	
	IF li_Chk = 1 THEN
	   dw_update.Object.pass_dt        [ll_row] = ls_PassDt		//송부일자
	   dw_update.Object.step_opt       [ll_row] = li_StepOpt		//결의상태
	   dw_update.Object.com_step_opt_nm[ll_row] = ls_StepOptNm	//결의상태명
	   dw_update.Object.job_uid        [ll_Row] = ls_Worker		//등록자
	   dw_update.Object.job_add        [ll_Row] = ls_IpAddr		//등록단말기
	   dw_update.Object.job_date       [ll_Row] = ldt_WorkDate	//등록일자
	END IF
	
	ll_Row = dw_update.GetNextModified(ll_Row,primary!)
LOOP

// 자료저장처리
wf_SetMsg('변경된 자료를 저장 중 입니다...')

IF NOT dw_update.TRIGGER EVENT ue_db_save() THEN

	RETURN -1
END IF

// 메세지, 메뉴버튼 활성/비활성화 처리
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
dw_update.SetFocus()



RETURN 1

end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 결의서 송부취소
//	작 성 인 : 이현수
//	작성일자 : 2002.11
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
string				ls_fr_date, ls_to_date


// 조회조건 - 결의부서명 DDDW초기화
dw_con.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve(1, 3) = 0 THEN
	ldwc_Temp.InsertRow(0)
END IF
dw_con.Object.code[1] = gs_DeptCode


// 조회조건 - 발의기간 초기화
ls_fr_date = mid(f_getacctyear(f_getbdgtyear(f_today())), 2, 8)
//ls_fr_date = f_today()
ls_to_date = f_lastdate(f_today())
dw_con.object.fr_date[1] = date(left(ls_fr_date,4) + '/' + mid(ls_fr_date,5,2) + '/' + right(ls_fr_date,2))
dw_con.object.to_Date[1] = date(left(ls_to_date,4) + '/' + mid(ls_to_date,5,2) + '/' + right(ls_to_date,2))

// 초기화
THIS.TRIGGER EVENT ue_init()

end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = ln_templeft.beginx

If cb_all.Enabled Then
	cb_all.X		= ll_stnd_pos
	ll_stnd_pos		= ll_stnd_pos + cb_all.Width + 16
Else
	cb_all.Visible	= FALSE
End If

If cb_can.Enabled Then
	cb_can.X		= ll_stnd_pos
	ll_stnd_pos		= ll_stnd_pos + cb_can.Width + 16
Else
	cb_can.Visible	= FALSE
End If
end event

type ln_templeft from w_msheet`ln_templeft within w_hfn203a
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn203a
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn203a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn203a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn203a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn203a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn203a
end type

type uc_insert from w_msheet`uc_insert within w_hfn203a
end type

type uc_delete from w_msheet`uc_delete within w_hfn203a
end type

type uc_save from w_msheet`uc_save within w_hfn203a
end type

type uc_excel from w_msheet`uc_excel within w_hfn203a
end type

type uc_print from w_msheet`uc_print within w_hfn203a
end type

type st_line1 from w_msheet`st_line1 within w_hfn203a
end type

type st_line2 from w_msheet`st_line2 within w_hfn203a
end type

type st_line3 from w_msheet`st_line3 within w_hfn203a
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn203a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn203a
end type

type dw_update from cuo_dwwindow_one_hin within w_hfn203a
integer x = 50
integer y = 296
integer width = 4384
integer height = 2000
integer taborder = 80
string dataobject = "d_hfn203a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = TRUE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

event itemchanged;//// 발의상태가 송부인 자료만 취소할 수 있다.
//If Dwo.Name = 'com_chk' Then
//	If Data = '1' And GetItemNumber(Row, 'step_opt') > 2 Then
//		SetItem(Row, 'com_chk', '0')
//		Messagebox('확인', '발의상태가 발의서송부인 자료만 취소할 수 있습니다.')
//	End If
//End If
end event

type cb_preview from commandbutton within w_hfn203a
boolean visible = false
integer x = 1856
integer y = 8
integer width = 293
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "상세보기"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_preview
//	기 능 설 명: 상세보기 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상세보기처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Long		ll_RowCnt
ll_RowCnt = dw_update.RowCount()
IF ll_RowCnt = 0 THEN
	ls_Msg = '결의서 송부자료를 조회 후 사용하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	RETURN
END IF

Long		ll_GetRow
ll_GetRow = dw_update.getrow()
IF ll_GetRow = 0 THEN
	ls_Msg = '결의서 송부자료를 선택 후 사용하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	RETURN
END IF

Integer	li_AcctClass	//회계단위
String	ls_ResolDate	//결의일자
Integer	li_ResolNo		//결의번호
Integer	li_SlipClass	//전표구분
//String	is_FrDate			//발의기간
//String	is_ToDate			//발의기간
s_insa_com	lstr_com, lstr_rtn

li_AcctClass = dw_update.Object.acct_class[ll_GetRow]	//회계단위
ls_ResolDate = dw_update.Object.resol_date[ll_GetRow]	//결의일자
li_ResolNo   = dw_update.Object.resol_no  [ll_GetRow]	//결의번호
li_SlipClass = dw_update.Object.slip_class[ll_GetRow]	//전표구분

lstr_com.ll_item[1] = li_AcctClass							//회계단위
lstr_com.ls_item[2] = ls_ResolDate							//결의일자
lstr_com.ll_item[3] = li_ResolNo								//결의번호
lstr_com.ls_item[4] = String(li_SlipClass)				//전표구분

//OpenWithParm(w_hfn201a,lstr_com)
//OpenSheetWithParm(w_hfn201a,lstr_com, w_frame, 2, Original!)
lstr_rtn = Message.PowerObjectParm
IF NOT isValid(lstr_rtn) THEN RETURN 1


//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type dw_con from uo_dwfree within w_hfn203a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hfn202a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
end event

event itemchanged;call super::itemchanged;parent.triggerevent('ue_retrieve')
end event

type cb_all from uo_imgbtn within w_hfn203a
integer x = 55
integer y = 36
integer taborder = 80
boolean bringtotop = true
string btnname = "전체선택"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_all
//	기 능 설 명: 전체선택 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Long		ll_RowCnt
Long		ll_Row
Integer	li_Chk

// 전체선택처리
ll_RowCnt = dw_update.RowCount()

IF ll_RowCnt = 0 THEN
	ls_Msg = '결의서 송부자료를 조회 후 사용하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	RETURN
END IF

FOR ll_Row = 1 TO ll_RowCnt
	li_Chk = dw_update.Object.com_chk[ll_Row]
	IF li_Chk = 0 THEN
		dw_update.Object.com_chk[ll_Row] = 1
	END IF
NEXT

end event

on cb_all.destroy
call uo_imgbtn::destroy
end on

type cb_can from uo_imgbtn within w_hfn203a
integer x = 480
integer y = 36
integer taborder = 90
boolean bringtotop = true
string btnname = "전체취소"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_all
//	기 능 설 명: 전체선택 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Long		ll_RowCnt
Long		ll_Row
Integer	li_Chk

// 전체선택처리
ll_RowCnt = dw_update.RowCount()
IF ll_RowCnt = 0 THEN
	ls_Msg = '결의서 송부자료를 조회 후 사용하시기 바랍니다.'
	wf_SetMsg(ls_Msg)
	MessageBox('확인',ls_Msg)
	RETURN
END IF

FOR ll_Row = 1 TO ll_RowCnt
	li_Chk = dw_update.Object.com_chk[ll_Row]
	IF li_Chk = 1 THEN
		dw_update.Object.com_chk[ll_Row] = 0
	END IF
NEXT

end event

on cb_can.destroy
call uo_imgbtn::destroy
end on

