$PBExportHeader$w_hgm601p.srw
$PBExportComments$물품관리 대장(출력)
forward
global type w_hgm601p from w_msheet
end type
type dw_re_opt from datawindow within w_hgm601p
end type
type st_8 from statictext within w_hgm601p
end type
type dw_dept_code from datawindow within w_hgm601p
end type
type st_7 from statictext within w_hgm601p
end type
type dw_cust_code from datawindow within w_hgm601p
end type
type st_6 from statictext within w_hgm601p
end type
type dw_acct_code from datawindow within w_hgm601p
end type
type st_5 from statictext within w_hgm601p
end type
type sle_item_name from singlelineedit within w_hgm601p
end type
type st_4 from statictext within w_hgm601p
end type
type ddlb_gubun from dropdownlistbox within w_hgm601p
end type
type st_3 from statictext within w_hgm601p
end type
type st_2 from statictext within w_hgm601p
end type
type em_to_date from editmask within w_hgm601p
end type
type em_fr_date from editmask within w_hgm601p
end type
type st_1 from statictext within w_hgm601p
end type
type dw_print from datawindow within w_hgm601p
end type
type gb_1 from groupbox within w_hgm601p
end type
end forward

global type w_hgm601p from w_msheet
string title = "위원회현황출력(부서별)"
event type boolean ue_chk_condition ( )
dw_re_opt dw_re_opt
st_8 st_8
dw_dept_code dw_dept_code
st_7 st_7
dw_cust_code dw_cust_code
st_6 st_6
dw_acct_code dw_acct_code
st_5 st_5
sle_item_name sle_item_name
st_4 st_4
ddlb_gubun ddlb_gubun
st_3 st_3
st_2 st_2
em_to_date em_to_date
em_fr_date em_fr_date
st_1 st_1
dw_print dw_print
gb_1 gb_1
end type
global w_hgm601p w_hgm601p

type variables
String	is_DeptCode	//부서코드
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

on w_hgm601p.create
int iCurrent
call super::create
this.dw_re_opt=create dw_re_opt
this.st_8=create st_8
this.dw_dept_code=create dw_dept_code
this.st_7=create st_7
this.dw_cust_code=create dw_cust_code
this.st_6=create st_6
this.dw_acct_code=create dw_acct_code
this.st_5=create st_5
this.sle_item_name=create sle_item_name
this.st_4=create st_4
this.ddlb_gubun=create ddlb_gubun
this.st_3=create st_3
this.st_2=create st_2
this.em_to_date=create em_to_date
this.em_fr_date=create em_fr_date
this.st_1=create st_1
this.dw_print=create dw_print
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_re_opt
this.Control[iCurrent+2]=this.st_8
this.Control[iCurrent+3]=this.dw_dept_code
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.dw_cust_code
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.dw_acct_code
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.sle_item_name
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.ddlb_gubun
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.em_to_date
this.Control[iCurrent+15]=this.em_fr_date
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.dw_print
this.Control[iCurrent+18]=this.gb_1
end on

on w_hgm601p.destroy
call super::destroy
destroy(this.dw_re_opt)
destroy(this.st_8)
destroy(this.dw_dept_code)
destroy(this.st_7)
destroy(this.dw_cust_code)
destroy(this.st_6)
destroy(this.dw_acct_code)
destroy(this.st_5)
destroy(this.sle_item_name)
destroy(this.st_4)
destroy(this.ddlb_gubun)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.em_to_date)
destroy(this.em_fr_date)
destroy(this.st_1)
destroy(this.dw_print)
destroy(this.gb_1)
end on

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
String ls_DeptCode, ls_AcctCode, ls_Cust_No, ls_gubun, ls_FrDate, ls_ToDate, ls_ItemNo
Long ll_revenue_opt 
ls_FrDate = left(em_fr_date.text,4) + mid(em_fr_date.text,6,2) + mid(em_fr_date.text,9,2)                       //기간
IF isNull(ls_FrDate) OR ls_FrDate = '0' OR ls_FrDate = '' THEN
	ls_FrDate = '00000000'
ELSE
	dw_print.object.t_name.text = '년월일별 대장'
END IF

ls_ToDate = left(em_to_date.text,4) + mid(em_to_date.text,6,2) + mid(em_to_date.text,9,2)
IF isNull(ls_ToDate) OR ls_ToDate = '0' OR ls_ToDate = '' THEN
	ls_ToDate = '99999999'
END IF

IF ls_FrDate > ls_ToDate THEN
	messagebox('확인','기간입력이 잘못되었습니다..!')
END IF

ls_ItemNo = trim(sle_item_name.text) + '%'       //품명
IF isNull(ls_ItemNo) OR ls_ItemNo = '0' OR ls_ItemNo = '' THEN
	ls_ItemNo = '%'
ELSE
	dw_print.object.t_name.text = '품명별 대장'
END IF
if ls_ItemNo = '%' then
	dw_print.object.t_name.text = '물품 관리 대장'
end if 

ls_DeptCode = TRIM(dw_dept_code.Object.code[1])   //부서체크
IF isNull(ls_DeptCode) OR ls_DeptCode = '0' OR ls_DeptCode = '' THEN
	ls_DeptCode = '%'
ELSE
	dw_print.object.t_name.text = '요구처별 대장'
END IF

ls_AcctCode = TRIM(dw_acct_code.Object.code[1])  //계정과목
IF isNull(ls_AcctCode) OR ls_AcctCode = '0' OR ls_AcctCode = '' THEN
	ls_AcctCode = '%'
ELSE
	dw_print.object.t_name.text = '계정코드별 대장'
END IF

ls_Cust_No = TRIM(dw_cust_code.Object.code[1])   //거래처
IF isNull(ls_Cust_No) OR ls_Cust_No = '0' OR ls_Cust_No = '' THEN
	ls_Cust_No = '%'
ELSE
	dw_print.object.t_name.text = '공급처별 대장'
END IF

ls_gubun = left(ddlb_gubun.text,1)               //사용구분
IF isNull(ls_gubun) OR  ls_gubun = 'n' OR ls_gubun = ''  THEN
	ls_gubun = '%'
ELSE
	dw_print.object.t_name.text = '사용구분별 대장'
END IF

ll_revenue_opt = dw_re_opt.Object.code[1]  //구입재원 
IF isNull(ll_revenue_opt) OR  ll_revenue_opt = 0   THEN
//	ll_revenue_opt = '%'
ELSE
	dw_print.object.t_name.text = '구입재원별 대장'
END IF

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////

wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(ls_FrDate, ls_ToDate, ls_gubun, ls_ItemNo, ls_AcctCode, ls_Cust_No, ls_DeptCode, ll_revenue_opt)
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UnivName
ls_UnivName = gstru_uid_uname.univ_name

//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenuBtn('R')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenuBtn('RP')
	wf_SetMsg('자료가 조회되었습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_print;call super::ue_print;//f_print(dw_print)
end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 위원회명단 중 부서별로 출력을 한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 부서명
////////////////////////////////////////////////////////////////////////////////////
em_fr_date.Text = left(f_today(),6) + '01'
em_to_date.Text = f_today()


DataWindowChild	ldwc_Temp
dw_dept_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	Long	ll_InsRow
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa','0000')
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
	ldwc_Temp.SetSort('gwa ASC')
	ldwc_Temp.Sort()
END IF
dw_dept_code.InsertRow(0)
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 계정과목
////////////////////////////////////////////////////////////////////////////////////
dw_acct_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('계정코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','000000')
	ldwc_Temp.SetItem(ll_InsRow,'name','전체')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
dw_acct_code.InsertRow(0)
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 거래처명
////////////////////////////////////////////////////////////////////////////////////
dw_cust_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('계정코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'cust_no','0000000')
	ldwc_Temp.SetItem(ll_InsRow,'cust_name','전체')
	ldwc_Temp.SetSort('cust_no ASC')
	ldwc_Temp.Sort()
END IF
dw_cust_code.InsertRow(0)
////////////구입재원///////////////////////////////////////////////////
dw_re_opt.insertrow(0)
f_childretrieve(dw_re_opt,"code","asset_opt")			//구입재원
/////////////////////////////////////////////////////////////////////////

dw_print.object.datawindow.zoom = 100
dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = dw_print
///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

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
dw_print.Object.DataWindow.zoom = 74
dw_print.Object.DataWindow.Print.Preview = 'YES'
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
if idw_print.rowcount() = 0 Then RETURN -1
avc_data.SetProperty('title', "대장")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hgm601p
end type

type ln_tempright from w_msheet`ln_tempright within w_hgm601p
end type

type ln_temptop from w_msheet`ln_temptop within w_hgm601p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hgm601p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hgm601p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hgm601p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hgm601p
end type

type uc_insert from w_msheet`uc_insert within w_hgm601p
end type

type uc_delete from w_msheet`uc_delete within w_hgm601p
end type

type uc_save from w_msheet`uc_save within w_hgm601p
end type

type uc_excel from w_msheet`uc_excel within w_hgm601p
end type

type uc_print from w_msheet`uc_print within w_hgm601p
end type

type st_line1 from w_msheet`st_line1 within w_hgm601p
end type

type st_line2 from w_msheet`st_line2 within w_hgm601p
end type

type st_line3 from w_msheet`st_line3 within w_hgm601p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hgm601p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hgm601p
end type

type dw_re_opt from datawindow within w_hgm601p
integer x = 2249
integer y = 336
integer width = 393
integer height = 84
integer taborder = 70
string title = "none"
string dataobject = "ddw_revenue_opt"
boolean border = false
boolean livescroll = true
end type

type st_8 from statictext within w_hgm601p
integer x = 1998
integer y = 352
integer width = 265
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "구입재원"
boolean focusrectangle = false
end type

type dw_dept_code from datawindow within w_hgm601p
integer x = 2971
integer y = 212
integer width = 768
integer height = 84
integer taborder = 70
string dataobject = "ddw_gwa_code"
boolean border = false
boolean livescroll = true
end type

type st_7 from statictext within w_hgm601p
integer x = 2711
integer y = 232
integer width = 283
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "요구부서"
boolean focusrectangle = false
end type

type dw_cust_code from datawindow within w_hgm601p
integer x = 2921
integer y = 324
integer width = 951
integer height = 88
integer taborder = 60
string dataobject = "ddw_cust_name"
boolean border = false
boolean livescroll = true
end type

type st_6 from statictext within w_hgm601p
integer x = 2693
integer y = 340
integer width = 215
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "공급처"
boolean focusrectangle = false
end type

type dw_acct_code from datawindow within w_hgm601p
integer x = 1307
integer y = 332
integer width = 603
integer height = 88
integer taborder = 50
string dataobject = "ddw_acct_code_hgm"
boolean border = false
boolean livescroll = true
end type

type st_5 from statictext within w_hgm601p
integer x = 1024
integer y = 344
integer width = 265
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "계정코드"
boolean focusrectangle = false
end type

type sle_item_name from singlelineedit within w_hgm601p
integer x = 1312
integer y = 216
integer width = 594
integer height = 80
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event constructor;f_pro_toggle('k',handle(parent))
end event

type st_4 from statictext within w_hgm601p
integer x = 1106
integer y = 228
integer width = 206
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "품  명"
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_hgm601p
integer x = 2249
integer y = 224
integer width = 398
integer height = 304
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
string item[] = {"1.비품","2.소모품",""}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_hgm601p
integer x = 1993
integer y = 236
integer width = 283
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "사용구분"
boolean focusrectangle = false
end type

type st_2 from statictext within w_hgm601p
integer x = 635
integer y = 212
integer width = 59
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "~~"
boolean focusrectangle = false
end type

type em_to_date from editmask within w_hgm601p
integer x = 704
integer y = 216
integer width = 357
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type em_fr_date from editmask within w_hgm601p
integer x = 270
integer y = 216
integer width = 357
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_1 from statictext within w_hgm601p
integer x = 123
integer y = 240
integer width = 160
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "기간"
boolean focusrectangle = false
end type

type dw_print from datawindow within w_hgm601p
integer x = 50
integer y = 444
integer width = 4384
integer height = 1848
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm601p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type gb_1 from groupbox within w_hgm601p
integer x = 50
integer y = 152
integer width = 4389
integer height = 288
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

