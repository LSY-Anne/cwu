$PBExportHeader$w_hin202p.srw
$PBExportComments$인사기본정보관리_경력사항상세관리
forward
global type w_hin202p from window
end type
type cb_close from uo_imgbtn within w_hin202p
end type
type cb_init from uo_imgbtn within w_hin202p
end type
type cb_update from uo_imgbtn within w_hin202p
end type
type cb_delete from uo_imgbtn within w_hin202p
end type
type cb_insert from uo_imgbtn within w_hin202p
end type
type cb_retrieve from uo_imgbtn within w_hin202p
end type
type sle_career_seq from singlelineedit within w_hin202p
end type
type st_3 from statictext within w_hin202p
end type
type dw_update from cuo_dwwindow_one_hin within w_hin202p
end type
type sle_member_no from singlelineedit within w_hin202p
end type
type st_8 from statictext within w_hin202p
end type
type sle_kname from singlelineedit within w_hin202p
end type
type st_1 from statictext within w_hin202p
end type
type gb_1 from groupbox within w_hin202p
end type
end forward

global type w_hin202p from window
integer width = 3077
integer height = 1628
boolean titlebar = true
string title = "경력사항상세관리"
boolean controlmenu = true
windowtype windowtype = response!
event ue_open ( )
event ue_delete ( )
event ue_retrieve ( )
event ue_update ( )
event ue_insert ( )
event ue_init ( )
cb_close cb_close
cb_init cb_init
cb_update cb_update
cb_delete cb_delete
cb_insert cb_insert
cb_retrieve cb_retrieve
sle_career_seq sle_career_seq
st_3 st_3
dw_update dw_update
sle_member_no sle_member_no
st_8 st_8
sle_kname sle_kname
st_1 st_1
gb_1 gb_1
end type
global w_hin202p w_hin202p

forward prototypes
public function integer wf_setmsg (string as_message)
public subroutine wf_setmenubtn (string as_type)
end prototypes

event ue_open();//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 경력사항중 경력상세 자료를 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_retrieve()
//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
IF dw_update.ib_RowSingle THEN ll_GetRow = dw_update.GetRow()
IF NOT dw_update.ib_RowSingle THEN ll_GetRow = dw_update.getrow()
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
	String	ls_MemberNo			//개인번호
	String	ls_KName				//성명
	Long		ll_CareerSeq		//순번
	Long		ll_SeqNo				//발령구분
	
	ls_MemberNo  = TRIM(sle_member_no.Text)				//개인번호
	ls_KName     = TRIM(sle_kname.Text)						//성명
	ll_CareerSeq = Integer(TRIM(sle_career_seq.Text))	//순번
	ll_SeqNo     = dw_update.Object.seq_no[ll_GetRow]
	
	ls_Msg = '개인번호 : '+ls_MemberNo+'~r~n'+&
				'성      명 : '+ls_KName+'~r~n'+&
				'순      번 : '+String(ll_CareerSeq)+'~r~n'+&
				'         항 : '+String(ll_SeqNo)
ELSE
//	SetNull(ls_Msg)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
ll_DeleteCnt = dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	/////////////////////////////////////////////////////////////////////////////
	//	3.1 Multi 처리인 경우.
	//			3.1.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
	/////////////////////////////////////////////////////////////////////////////
	IF dw_update.RowCount() > 0 THEN
//		wf_SetMenuBtn('IDSR')
	ELSE
//		wf_SetMenuBtn('RIS')
	END IF
ELSE
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
/// 1.1 개인번호 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo
ls_MemberNo = TRIM(sle_member_no.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 순번 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
Long		ll_CareerSeq
ll_CareerSeq = Integer(TRIM(sle_career_seq.Text))


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt
dw_update.SetReDraw(FALSE)
ll_RowCnt = dw_update.Retrieve(ls_MemberNo,ll_CareerSeq)
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
	wf_SetMsg('자료가 조회되었습니다.')
//	wf_SetMenuBtn('RIDS')
	dw_update.SetFocus()
ELSE
	wf_SetMsg('해당자료가 존재하지 않습니다.')
//	wf_SetMenuBtn('RI')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_update();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_update
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1.변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
IF dw_update.AcceptText() = -1 THEN
	dw_update.SetFocus()
	RETURN
END IF
IF dw_update.ModifiedCount() + dw_update.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'member_no/개인번호'
ls_NotNullCol[1] = 'career_seq/순번'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기

String	ls_MemberNo		//개인번호
Long		ll_CareerSeq	//순번
Long		ll_SeqNo			//항번

ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gstru_uid_uname.uid			//등록자
	ls_IPAddr    = gstru_uid_uname.address		//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = dw_update.GetItemStatus(ll_Row,0,Primary!)
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 경력사항상세 항번처리
	/////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		ls_MemberNo  = dw_update.Object.member_no [ll_Row]	//개인번호
		ll_CareerSeq = dw_update.Object.career_seq[ll_Row]	//순번
		//////////////////////////////////////////////////////////////////////////////
		// 3.1.1 경력사항상세 항번처리
		//////////////////////////////////////////////////////////////////////////////
		wf_SetMsg('경력사항상세 항번 생성 중 입니다...')
		SELECT	NVL(MAX(A.SEQ_NO),0) + 1
		INTO		:ll_SeqNo
		FROM		INDB.HIN010H A
		WHERE		A.MEMBER_NO  = :ls_MemberNo
		AND		A.CAREER_SEQ = :ll_CareerSeq;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
			CASE 100
				ll_SeqNo = 1
			CASE ELSE
				MessageBox('오류',&
								'경력사항상세 항번 생성시 전산장애가 발생되었습니다.~r~n' + &
								'하단의 장애번호와 장애내역을~r~n' + &
								'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
								'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
								'장애내역 : ' + SQLCA.SqlErrText)
		END CHOOSE
		dw_update.Object.seq_no   [ll_Row] = ll_SeqNo
		
		dw_update.Object.worker   [ll_Row] = ls_Worker		//등록자
		dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록일자
		dw_update.Object.ipaddr   [ll_Row] = ls_IpAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	dw_update.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	dw_update.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	dw_update.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF NOT dw_update.TRIGGER EVENT ue_db_save() THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('RIDS')
dw_update.SetFocus()
RETURN
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_insert();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 자료추가전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 자료추가전 필수입력사항 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo		//개인번호
Long		ll_CareerSeq	//순번

ls_MemberNo  = TRIM(sle_member_no.Text)				//개인번호
ll_CareerSeq = Integer(TRIM(sle_career_seq.Text))	//순번

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long	 ll_InsRow
ll_InsRow = dw_update.TRIGGER EVENT ue_db_new()
IF ll_InsRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_SysDate
ls_SysDate = f_today()
dw_update.Object.member_no [ll_InsRow] = ls_MemberNo			//개인번호
dw_update.Object.career_seq[ll_InsRow] = ll_CareerSeq		//순번
dw_update.SetItemStatus(ll_InsRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우호 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('RIDS')
wf_SetMsg('자료가 추가되었습니다.')
dw_update.SetColumn('hakyear')
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_init();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')//조회버튼 활성화

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

public function integer wf_setmsg (string as_message);//w_frame w
//w = this.ParentWindow ( )
//w.wf_setmsg(as_message)
setmicrohelp(as_message)

return 1
end function

public subroutine wf_setmenubtn (string as_type);////조회
////입력
////삭제
////저장
//Boolean	lb_Value
//String	ls_Flag[] = {'R','I','D','S'}
//Integer	li_idx
//
//FOR li_idx = 1 TO UpperBound(ls_Flag)
//	lb_Value = FALSE
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
//	
//	CHOOSE CASE ls_Flag[li_idx]
//		CASE 'R';cb_retrieve.Enabled = lb_Value
//		CASE 'I';cb_insert.Enabled   = lb_Value
//		CASE 'D';cb_delete.Enabled   = lb_Value
//		CASE 'S';cb_update.of_enable   = lb_Value
//	END CHOOSE
//NEXT
//
end subroutine

on w_hin202p.create
this.cb_close=create cb_close
this.cb_init=create cb_init
this.cb_update=create cb_update
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.cb_retrieve=create cb_retrieve
this.sle_career_seq=create sle_career_seq
this.st_3=create st_3
this.dw_update=create dw_update
this.sle_member_no=create sle_member_no
this.st_8=create st_8
this.sle_kname=create sle_kname
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_close,&
this.cb_init,&
this.cb_update,&
this.cb_delete,&
this.cb_insert,&
this.cb_retrieve,&
this.sle_career_seq,&
this.st_3,&
this.dw_update,&
this.sle_member_no,&
this.st_8,&
this.sle_kname,&
this.st_1,&
this.gb_1}
end on

on w_hin202p.destroy
destroy(this.cb_close)
destroy(this.cb_init)
destroy(this.cb_update)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.cb_retrieve)
destroy(this.sle_career_seq)
destroy(this.st_3)
destroy(this.dw_update)
destroy(this.sle_member_no)
destroy(this.st_8)
destroy(this.sle_kname)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: open
//	기 능 설 명: 경력사항상세관리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
f_centerme(this)

s_insa_com	lstr_com
lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	CLOSE(THIS)
	RETURN
END IF

String	ls_KName
String	ls_MemberNo
Long		ll_CareerSeq

ls_KName     = lstr_com.ls_item[01]	//성명
ls_MemberNo  = lstr_com.ls_item[02]	//개인번호
ll_CareerSeq = lstr_com.ll_item[03]	//경력사항_순번

sle_kname.Text      = ls_KName
sle_member_no.Text  = ls_MemberNo
sle_career_seq.Text = String(ll_CareerSeq)

THIS.POST EVENT ue_open()

Long ll_pos

ll_pos = gb_1.x + gb_1.width
ll_pos = ll_pos - cb_close.width
cb_close.x = ll_pos
ll_pos = ll_pos - 16 - cb_init.width
cb_init.x = ll_pos
ll_pos = ll_pos - 16 - cb_update.width
cb_update.x = ll_pos
ll_pos = ll_pos - 16 - cb_delete.width
cb_delete.x = ll_pos
ll_pos = ll_pos - 16 - cb_insert.width
cb_insert.x = ll_pos
ll_pos = ll_pos - 16 - cb_retrieve.width
cb_retrieve.x = ll_pos



//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type cb_close from uo_imgbtn within w_hin202p
integer x = 2757
integer y = 24
integer taborder = 110
string btnname = "종료"
end type

event clicked;call super::clicked;CLOSE(PARENT)
end event

on cb_close.destroy
call uo_imgbtn::destroy
end on

type cb_init from uo_imgbtn within w_hin202p
integer x = 2446
integer y = 24
integer taborder = 100
string btnname = "초기화"
end type

event clicked;call super::clicked;PARENT.TRIGGER EVENT ue_init()
end event

on cb_init.destroy
call uo_imgbtn::destroy
end on

type cb_update from uo_imgbtn within w_hin202p
integer x = 2117
integer y = 24
integer taborder = 100
string btnname = "저장"
end type

event clicked;call super::clicked;PARENT.TRIGGER EVENT ue_update()
end event

on cb_update.destroy
call uo_imgbtn::destroy
end on

type cb_delete from uo_imgbtn within w_hin202p
integer x = 1806
integer y = 24
integer taborder = 90
string btnname = "삭제"
end type

event clicked;call super::clicked;PARENT.TRIGGER EVENT ue_delete()
end event

on cb_delete.destroy
call uo_imgbtn::destroy
end on

type cb_insert from uo_imgbtn within w_hin202p
integer x = 1490
integer y = 24
integer taborder = 80
string btnname = "추가"
end type

event clicked;call super::clicked;PARENT.TRIGGER EVENT ue_insert()
end event

on cb_insert.destroy
call uo_imgbtn::destroy
end on

type cb_retrieve from uo_imgbtn within w_hin202p
integer x = 1106
integer y = 24
integer taborder = 70
string btnname = "조회"
end type

event clicked;call super::clicked;PARENT.TRIGGER EVENT ue_retrieve()
end event

on cb_retrieve.destroy
call uo_imgbtn::destroy
end on

type sle_career_seq from singlelineedit within w_hin202p
integer x = 1874
integer y = 212
integer width = 165
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_hin202p
integer x = 1705
integer y = 224
integer width = 160
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "순번"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_update from cuo_dwwindow_one_hin within w_hin202p
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 360
integer width = 3040
integer height = 1148
integer taborder = 70
string dataobject = "d_hin202p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_member_no from singlelineedit within w_hin202p
integer x = 1225
integer y = 212
integer width = 457
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_hin202p
integer x = 951
integer y = 224
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "개인번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_kname from singlelineedit within w_hin202p
integer x = 466
integer y = 212
integer width = 457
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_hin202p
integer x = 297
integer y = 224
integer width = 160
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "성명"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hin202p
integer x = 14
integer y = 124
integer width = 3040
integer height = 228
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "입력조건"
end type

