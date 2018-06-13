$PBExportHeader$w_hgm201p.srw
$PBExportComments$소모품관리/출력
forward
global type w_hgm201p from w_msheet
end type
type st_3 from statictext within w_hgm201p
end type
type gian_no from singlelineedit within w_hgm201p
end type
type dw_dept_code from datawindow within w_hgm201p
end type
type st_7 from statictext within w_hgm201p
end type
type st_2 from statictext within w_hgm201p
end type
type em_to_date from editmask within w_hgm201p
end type
type em_fr_date from editmask within w_hgm201p
end type
type st_1 from statictext within w_hgm201p
end type
type dw_print from datawindow within w_hgm201p
end type
type gb_1 from groupbox within w_hgm201p
end type
end forward

global type w_hgm201p from w_msheet
event type boolean ue_chk_condition ( )
st_3 st_3
gian_no gian_no
dw_dept_code dw_dept_code
st_7 st_7
st_2 st_2
em_to_date em_to_date
em_fr_date em_fr_date
st_1 st_1
dw_print dw_print
gb_1 gb_1
end type
global w_hgm201p w_hgm201p

type variables
String	is_DeptCode	//부서코드
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

on w_hgm201p.create
int iCurrent
call super::create
this.st_3=create st_3
this.gian_no=create gian_no
this.dw_dept_code=create dw_dept_code
this.st_7=create st_7
this.st_2=create st_2
this.em_to_date=create em_to_date
this.em_fr_date=create em_fr_date
this.st_1=create st_1
this.dw_print=create dw_print
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.gian_no
this.Control[iCurrent+3]=this.dw_dept_code
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_to_date
this.Control[iCurrent+7]=this.em_fr_date
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_print
this.Control[iCurrent+10]=this.gb_1
end on

on w_hgm201p.destroy
call super::destroy
destroy(this.st_3)
destroy(this.gian_no)
destroy(this.dw_dept_code)
destroy(this.st_7)
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
String ls_DeptCode, ls_FrDate, ls_ToDate
integer li_item_gian_no

ls_FrDate = left(em_fr_date.text,4) + mid(em_fr_date.text,6,2) + mid(em_fr_date.text,9,2)                       //기간

IF isNull(ls_FrDate) OR ls_FrDate = '0' OR ls_FrDate = '' THEN
	ls_FrDate = '00000000'
END IF

ls_ToDate = left(em_to_date.text,4) + mid(em_to_date.text,6,2) + mid(em_to_date.text,9,2)
IF isNull(ls_ToDate) OR ls_ToDate = '0' OR ls_ToDate = '' THEN
	ls_ToDate = '99999999'
END IF

IF ls_FrDate > ls_ToDate THEN
	messagebox('확인','기간입력이 잘못되었습니다..!')
END IF

ls_DeptCode = TRIM(dw_dept_code.Object.code[1])   //부서체크
IF isNull(ls_DeptCode) OR ls_DeptCode = '0' OR ls_DeptCode = '' THEN
	ls_DeptCode = '%'
END IF

li_item_gian_no = integer(gian_no.text)

//IF isNull(li_item_gian_no) OR li_item_gian_no = '' THEN
//	li_item_gian_no = '%'
//END IF
//messagebox('', ls_FrDate+':'+ls_ToDate+':'+ls_DeptCode)
      
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(ls_FrDate, ls_ToDate, ls_DeptCode, li_item_gian_no)
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UnivName
ls_UnivName = GF_GLOBAL_VALUE(2)

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

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 구매관리 부서별로 출력을 한다.
//	작 성 인 : 이인갑
//	작성일자 : 2006.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 부서명
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
dw_dept_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)

em_fr_date.Text = left(f_today(),6) + '01'
em_to_date.Text = f_today()

dw_dept_code.object.code[1]	=	gs_DeptCode

if gs_empcode = 'F0009'or gs_empcode = 'F0044'or gs_empcode = 'F0057' then
	dw_dept_code.Object.code.Background.mode = 0
	dw_dept_code.enabled = true
else
	dw_dept_code.Object.code.Background.mode = 1
	dw_dept_code.enabled = false
end if

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
dw_dept_code.Object.code[1] = gs_DeptCode


///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 계정과목
////////////////////////////////////////////////////////////////////////////////////

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
dw_print.Object.DataWindow.zoom = 100
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
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "소모품 대장")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1


end event

type ln_templeft from w_msheet`ln_templeft within w_hgm201p
end type

type ln_tempright from w_msheet`ln_tempright within w_hgm201p
end type

type ln_temptop from w_msheet`ln_temptop within w_hgm201p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hgm201p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hgm201p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hgm201p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hgm201p
end type

type uc_insert from w_msheet`uc_insert within w_hgm201p
end type

type uc_delete from w_msheet`uc_delete within w_hgm201p
end type

type uc_save from w_msheet`uc_save within w_hgm201p
end type

type uc_excel from w_msheet`uc_excel within w_hgm201p
end type

type uc_print from w_msheet`uc_print within w_hgm201p
end type

type st_line1 from w_msheet`st_line1 within w_hgm201p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hgm201p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hgm201p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hgm201p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hgm201p
end type

type st_3 from statictext within w_hgm201p
integer x = 2738
integer y = 232
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "구매번호"
boolean focusrectangle = false
end type

type gian_no from singlelineedit within w_hgm201p
integer x = 3022
integer y = 212
integer width = 457
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_dept_code from datawindow within w_hgm201p
integer x = 1710
integer y = 208
integer width = 773
integer height = 84
integer taborder = 70
string dataobject = "ddw_gwa_code"
boolean border = false
boolean livescroll = true
end type

type st_7 from statictext within w_hgm201p
integer x = 1449
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

type st_2 from statictext within w_hgm201p
integer x = 745
integer y = 204
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

type em_to_date from editmask within w_hgm201p
integer x = 814
integer y = 208
integer width = 357
integer height = 92
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

type em_fr_date from editmask within w_hgm201p
integer x = 379
integer y = 208
integer width = 357
integer height = 92
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

type st_1 from statictext within w_hgm201p
integer x = 105
integer y = 232
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청기간"
boolean focusrectangle = false
end type

type dw_print from datawindow within w_hgm201p
integer x = 55
integer y = 352
integer width = 4375
integer height = 1920
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm201p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type gb_1 from groupbox within w_hgm201p
integer x = 50
integer y = 140
integer width = 4379
integer height = 192
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

