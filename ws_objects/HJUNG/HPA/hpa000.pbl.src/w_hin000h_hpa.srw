$PBExportHeader$w_hin000h_hpa.srw
$PBExportComments$인사기본정보도움말(성명,개인번호)
forward
global type w_hin000h_hpa from window
end type
type cb_cancel from u_picture within w_hin000h_hpa
end type
type cb_ok from u_picture within w_hin000h_hpa
end type
type cb_retrieve from u_picture within w_hin000h_hpa
end type
type dw_main from cuo_dwwindow_one_hin within w_hin000h_hpa
end type
type sle_member_no from singlelineedit within w_hin000h_hpa
end type
type st_8 from statictext within w_hin000h_hpa
end type
type sle_kname from singlelineedit within w_hin000h_hpa
end type
type st_1 from statictext within w_hin000h_hpa
end type
type gb_1 from groupbox within w_hin000h_hpa
end type
end forward

global type w_hin000h_hpa from window
integer width = 2734
integer height = 1628
boolean titlebar = true
string title = "인사기본정보도움말"
boolean controlmenu = true
windowtype windowtype = response!
event ue_db_retrieve ( )
cb_cancel cb_cancel
cb_ok cb_ok
cb_retrieve cb_retrieve
dw_main dw_main
sle_member_no sle_member_no
st_8 st_8
sle_kname sle_kname
st_1 st_1
gb_1 gb_1
end type
global w_hin000h_hpa w_hin000h_hpa

event ue_db_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
/// 1.1 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(sle_kname.Text)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 개인번호 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo
ls_MemberNo = TRIM(sle_member_no.Text)


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_RowCnt
dw_main.SetReDraw(FALSE)
ll_RowCnt = dw_main.Retrieve(ls_KName,ls_MemberNo)
dw_main.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 고정버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt > 0 THEN
	dw_main.SetFocus()
ELSE
	sle_kname.SetFocus()
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on w_hin000h_hpa.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_retrieve=create cb_retrieve
this.dw_main=create dw_main
this.sle_member_no=create sle_member_no
this.st_8=create st_8
this.sle_kname=create sle_kname
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.cb_retrieve,&
this.dw_main,&
this.sle_member_no,&
this.st_8,&
this.sle_kname,&
this.st_1,&
this.gb_1}
end on

on w_hin000h_hpa.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_retrieve)
destroy(this.dw_main)
destroy(this.sle_member_no)
destroy(this.st_8)
destroy(this.sle_kname)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 인사기본정보 도움말
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
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

ls_KName    = lstr_com.ls_item[01]	//성명
ls_MemberNo = lstr_com.ls_item[02]	//개인번호

sle_kname.Text = ls_KName
sle_member_no.Text = ls_MemberNo

cb_retrieve.of_enable(true)
cb_ok.of_enable(true)
cb_cancel.of_enable(true)


THIS.TRIGGER EVENT ue_db_retrieve()
//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event key;CHOOSE CASE key
	CASE KeyEnter!
		cb_retrieve.POST EVENT clicked()
	CASE KeyEscape!
		cb_cancel.POST EVENT clicked()
END CHOOSE
end event

type cb_cancel from u_picture within w_hin000h_hpa
integer x = 2418
integer y = 212
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_cancel.gif"
end type

event clicked;call super::clicked;IF NOT THIS.Enabled THEN RETURN
CLOSE(PARENT)
end event

type cb_ok from u_picture within w_hin000h_hpa
integer x = 2418
integer y = 124
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_ok.gif"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: cb_ok::clicked
//	기 능 설 명: 확인
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
IF NOT THIS.Enabled THEN RETURN
////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
////////////////////////////////////////////////////////////////////////////////
// 1.1 자료조회 유무체크
////////////////////////////////////////////////////////////////////////////////
IF dw_main.RowCount() = 0 THEN
	MessageBox('확인','자료를 조회 후 사용하시기 바랍니다')
	RETURN
END IF
////////////////////////////////////////////////////////////////////////////////
// 1.2 자료선택 유무체크
////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
ll_GetRow = dw_main.getrow()
IF ll_GetRow = 0 THEN
	MessageBox('확인','자료를 선택 후 사용하시기 바랍니다')
	RETURN
END IF

////////////////////////////////////////////////////////////////////////////////
// 2. 자료처리
////////////////////////////////////////////////////////////////////////////////
String	ls_KName
String	ls_MemberNo
String	ls_JuminNo
String	ls_DeptCode
String	ls_JikJongCode
Integer	li_JikWiCode
String	ls_DutyCode
Integer	li_JikMuCode
String	ls_FirstHireDate
String	ls_HakwonHireDate
String	ls_SalClass
String	ls_ComDeptNm
String	ls_ComJikJongNm
String	ls_ComJikWiNm
String	ls_ComDutyNm
String	ls_ComJikMuNm

ls_KName          = dw_main.Object.name           [ll_GetRow]
ls_MemberNo       = dw_main.Object.member_no      [ll_GetRow]
ls_JuminNo        = dw_main.Object.jumin_no       [ll_GetRow]
ls_DeptCode       = dw_main.Object.gwa            [ll_GetRow]
ls_JikJongCode    = dw_main.Object.jikjong_code   [ll_GetRow]
li_JikWiCode      = dw_main.Object.jikwi_code     [ll_GetRow]
ls_DutyCode       = dw_main.Object.duty_code      [ll_GetRow]
li_JikMuCode      = dw_main.Object.jikmu_code     [ll_GetRow]
ls_FirstHireDate  = dw_main.Object.firsthire_date [ll_GetRow]
ls_HakwonHireDate = dw_main.Object.hakwonhire_date[ll_GetRow]
ls_SalClass       = dw_main.Object.sal_class      [ll_GetRow]
ls_ComDeptNm      = dw_main.Object.com_dept_nm    [ll_GetRow]
ls_ComJikJongNm   = dw_main.Object.com_jikjong_nm [ll_GetRow]
ls_ComJikWiNm     = dw_main.Object.com_jikwi_nm   [ll_GetRow]
ls_ComDutyNm      = dw_main.Object.com_duty_nm    [ll_GetRow]
ls_ComJikMuNm     = dw_main.Object.com_jikmu_nm   [ll_GetRow]

s_insa_com	lstr_com
lstr_com.ls_item[01] = ls_KName				//성명
lstr_com.ls_item[02] = ls_MemberNo			//개인번호
lstr_com.ls_item[03] = ls_JuminNo			//주민번호
lstr_com.ls_item[04] = ls_DeptCode			//조직코드
lstr_com.ls_item[05] = ls_JikJongCode		//직종코드
lstr_com.ll_item[06] = li_JikWiCode			//직위코드
lstr_com.ls_item[07] = ls_DutyCode			//직급코드
lstr_com.ll_item[08] = li_JikMuCode			//직무코드
lstr_com.ls_item[09] = ls_FirstHireDate	//최초임용일
lstr_com.ls_item[10] = ls_HakwonHireDate	//학원임용일
lstr_com.ls_item[11] = ls_SalClass			//호봉코드
lstr_com.ls_item[12] = ls_ComDeptNm			//조직명
lstr_com.ls_item[13] = ls_ComJikJongNm		//직종명
lstr_com.ls_item[14] = ls_ComJikWiNm		//직위명
lstr_com.ls_item[15] = ls_ComDutyNm			//직급명
lstr_com.ls_item[16] = ls_ComJikMuNm		//직무명

CloseWithReturn(PARENT,lstr_com)
//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type cb_retrieve from u_picture within w_hin000h_hpa
integer x = 2418
integer y = 36
integer width = 274
integer height = 84
boolean originalsize = false
string picturename = "..\img\button\topBtn_retrieve.gif"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: p_retrieve::clicked
//	기 능 설 명: 조회처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
PARENT.TRIGGER EVENT ue_db_retrieve()
//////////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type dw_main from cuo_dwwindow_one_hin within w_hin000h_hpa
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 304
integer width = 2697
integer height = 1208
integer taborder = 20
string dataobject = "d_hin000h_hpa_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_dwnkey;IF KeyDown(KeyEnter!) THEN
	cb_ok.TRIGGER EVENT clicked()
END IF
end event

event constructor;call super::constructor;//ib_RowSelect = TRUE
//ib_RowSingle = TRUE
//ib_SortGubn  = TRUE
//ib_EnterChk  = FALSE
end event

event doubleclicked;call super::doubleclicked;IF row = 0 THEN RETURN
cb_ok.TRIGGER EVENT clicked()
end event

type sle_member_no from singlelineedit within w_hin000h_hpa
integer x = 507
integer y = 172
integer width = 457
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_hin000h_hpa
integer x = 233
integer y = 188
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "개인번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_kname from singlelineedit within w_hin000h_hpa
integer x = 507
integer y = 92
integer width = 457
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_hin000h_hpa
integer x = 233
integer y = 104
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "성명"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hin000h_hpa
integer x = 14
integer y = 12
integer width = 2386
integer height = 284
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
string text = "조회조건"
end type

