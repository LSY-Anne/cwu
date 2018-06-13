$PBExportHeader$w_hin282p.srw
$PBExportComments$인사발령장
forward
global type w_hin282p from w_msheet
end type
type dw_print from cuo_dwwindow_one_hin within w_hin282p
end type
type dw_change_opt from datawindow within w_hin282p
end type
type st_5 from statictext within w_hin282p
end type
type dw_sign_opt from datawindow within w_hin282p
end type
type st_2 from statictext within w_hin282p
end type
type uo_member from cuo_insa_member_print within w_hin282p
end type
type st_3 from statictext within w_hin282p
end type
type em_fr_date from editmask within w_hin282p
end type
type st_4 from statictext within w_hin282p
end type
type em_to_date from editmask within w_hin282p
end type
type gb_1 from groupbox within w_hin282p
end type
end forward

global type w_hin282p from w_msheet
string title = "인사발령장"
dw_print dw_print
dw_change_opt dw_change_opt
st_5 st_5
dw_sign_opt dw_sign_opt
st_2 st_2
uo_member uo_member
st_3 st_3
em_fr_date em_fr_date
st_4 st_4
em_to_date em_to_date
gb_1 gb_1
end type
global w_hin282p w_hin282p

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

on w_hin282p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.dw_change_opt=create dw_change_opt
this.st_5=create st_5
this.dw_sign_opt=create dw_sign_opt
this.st_2=create st_2
this.uo_member=create uo_member
this.st_3=create st_3
this.em_fr_date=create em_fr_date
this.st_4=create st_4
this.em_to_date=create em_to_date
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.dw_change_opt
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.dw_sign_opt
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.uo_member
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.em_fr_date
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.em_to_date
this.Control[iCurrent+11]=this.gb_1
end on

on w_hin282p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.dw_change_opt)
destroy(this.st_5)
destroy(this.dw_sign_opt)
destroy(this.st_2)
destroy(this.uo_member)
destroy(this.st_3)
destroy(this.em_fr_date)
destroy(this.st_4)
destroy(this.em_to_date)
destroy(this.gb_1)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 인사발령장을 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 결재구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
dw_sign_opt.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('sign_opt',0) = 0 THEN
	wf_setmsg('공통코드[결재구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
dw_sign_opt.InsertRow(0)
dw_sign_opt.Object.code.dddw.PercentWidth	= 100
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 발령구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_change_opt.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('change_opt',0) = 0 THEN
	wf_setmsg('공통코드[발령구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	Long	ll_InsRow
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
dw_change_opt.InsertRow(0)
dw_change_opt.Object.code.dddw.PercentWidth	= 100
////////////////////////////////////////////////////////////////////////////////////
// 1.3 조회조건 - 발령기간
////////////////////////////////////////////////////////////////////////////////////
em_fr_date.Text = f_today()
em_to_date.Text = f_lastdate(f_today())

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;//////////////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////
// 1.2 결재구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_SignOpt
ls_SignOpt = TRIM(dw_sign_opt.Object.code[1])
IF LEN(ls_SignOpt) = 0 OR isNull(ls_SignOpt) OR ls_SignOpt = '0' THEN ls_SignOpt = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.3 발령구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_ChangeOpt
ls_ChangeOpt = TRIM(dw_change_opt.Object.code[1])
IF LEN(ls_ChangeOpt) = 0 OR isNull(ls_ChangeOpt) OR ls_ChangeOpt = '0' THEN ls_ChangeOpt = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.4 발령기간 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_FrDate
em_fr_date.GetData(ls_FrDate)
ls_FrDate = TRIM(ls_FrDate)
IF NOT f_isDate(ls_FrDate) THEN
	MessageBox('확인','발령기간FROM 입력오류입니다.')
	em_fr_date.SetFocus()
	RETURN -1
END IF
String	ls_ToDate
em_to_date.GetData(ls_ToDate)
ls_ToDate = TRIM(ls_ToDate)
IF NOT f_isDate(ls_ToDate) THEN
	MessageBox('확인','발령기간TO를 입력오류입니다.')
	em_to_date.SetFocus()
	RETURN -1
END IF
IF ls_FrDate > ls_ToDate THEN
	MessageBox('확인','발령기간 오류입니다.')
	em_to_date.SetFocus()
	RETURN -1
END IF


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(ls_KName,ls_SignOpt,ls_ChangeOpt,ls_FrDate,ls_ToDate)
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UnivName
ls_UnivName = GF_GLOBAL_VALUE(2)

dw_print.Object.t_campus.Text      = ls_UnivName
dw_print.Object.t_campus_jang.Text = ls_UnivName+'장'


//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('RP')
	wf_SetMsg('자료가 조회되었습니다.')
	dw_print.SetFocus()
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
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
dw_print.SetReDraw(FALSE)
dw_print.Reset()
dw_print.Object.DataWindow.Print.Preview = 'YES'
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')
uo_member.sle_kname.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin282p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin282p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin282p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin282p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin282p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin282p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin282p
end type

type uc_insert from w_msheet`uc_insert within w_hin282p
end type

type uc_delete from w_msheet`uc_delete within w_hin282p
end type

type uc_save from w_msheet`uc_save within w_hin282p
end type

type uc_excel from w_msheet`uc_excel within w_hin282p
end type

type uc_print from w_msheet`uc_print within w_hin282p
end type

type st_line1 from w_msheet`st_line1 within w_hin282p
end type

type st_line2 from w_msheet`st_line2 within w_hin282p
end type

type st_line3 from w_msheet`st_line3 within w_hin282p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin282p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin282p
end type

type dw_print from cuo_dwwindow_one_hin within w_hin282p
integer x = 14
integer y = 352
integer width = 3845
integer height = 2252
integer taborder = 70
string dataobject = "d_hin282p_1"
end type

type dw_change_opt from datawindow within w_hin282p
integer x = 1573
integer y = 224
integer width = 695
integer height = 80
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type st_5 from statictext within w_hin282p
integer x = 1294
integer y = 240
integer width = 274
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "발령구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_sign_opt from datawindow within w_hin282p
integer x = 562
integer y = 224
integer width = 695
integer height = 80
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type st_2 from statictext within w_hin282p
integer x = 288
integer y = 240
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "결재구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_member from cuo_insa_member_print within w_hin282p
integer x = 343
integer y = 68
integer taborder = 10
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member_print::destroy
end on

type st_3 from statictext within w_hin282p
integer x = 2313
integer y = 240
integer width = 270
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "신청기간"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fr_date from editmask within w_hin282p
integer x = 2592
integer y = 228
integer width = 366
integer height = 76
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

type st_4 from statictext within w_hin282p
integer x = 2958
integer y = 240
integer width = 46
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "∼"
boolean focusrectangle = false
end type

type em_to_date from editmask within w_hin282p
integer x = 3008
integer y = 228
integer width = 366
integer height = 76
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

type gb_1 from groupbox within w_hin282p
integer x = 14
integer y = 12
integer width = 3845
integer height = 328
integer taborder = 60
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

