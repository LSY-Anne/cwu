$PBExportHeader$w_hin204p.srw
$PBExportComments$경력년수 검색및출력
forward
global type w_hin204p from w_msheet
end type
type tab_1 from tab within w_hin204p
end type
type tabpage_1 from userobject within tab_1
end type
type dw_update from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_update dw_update
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hin204p
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_hin204p
end type
type dw_con from uo_dwfree within w_hin204p
end type
end forward

global type w_hin204p from w_msheet
integer height = 2616
string title = "경력년수 검색및출력"
tab_1 tab_1
uo_1 uo_1
dw_con dw_con
end type
global w_hin204p w_hin204p

type variables

end variables

forward prototypes
public subroutine wf_setmenubtn (string as_type)
end prototypes

public subroutine wf_setmenubtn (string as_type);////입력
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

on w_hin204p.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_con
end on

on w_hin204p.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.dw_con)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 경력년수를 조회한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 조회조건 - 경력구분 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//DataWindowChild	ldwc_Temp
//Long		ll_InsRow
//dw_proces_opt.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('proces_opt',0) = 0 THEN
//	wf_setmsg('공통코드[처리구분]를 입력하시기 바랍니다.')
//	ldwc_Temp.InsertRow(0)
//ELSE
//	ll_InsRow = ldwc_Temp.InsertRow(0)
//	ldwc_Temp.SetItem(ll_InsRow,'code',0)
//	ldwc_Temp.SetItem(ll_InsRow,'fname','총경력')
//	ldwc_Temp.SetSort('code ASC')
//	ldwc_Temp.Sort()
//END IF
//dw_proces_opt.InsertRow(0)
//dw_proces_opt.Object.code.dddw.PercentWidth	= 100
//////////////////////////////////////////////////////////////////////////////////////
//// 1.2 조회조건 - 경력년월 초기화
//////////////////////////////////////////////////////////////////////////////////////
//em_career_ym.Text = '0'
//
//tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
//tab_1.tabpage_2.dw_print.Object.DataWindow.Zoom = 75
//tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화
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
// 1.1 교직원구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_JikJongCode

dw_con.accepttext()
ls_JikJongCode =  dw_con.object.gubn[1] // MID(ddlb_gubn.Text,1,1)
////////////////////////////////////////////////////////////////////////////////////
// 1.2 경력구분 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_ProcesOpt
ls_ProcesOpt = TRIM(dw_con.Object.proces_opt[1])
IF LEN(ls_ProcesOpt) = 0 OR isNull(ls_ProcesOpt) OR ls_ProcesOpt = '0' THEN ls_ProcesOpt = ''
////////////////////////////////////////////////////////////////////////////////////
// 1.3 경력년월 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
Decimal{2}	ldc_CareerYm
ldc_CareerYm = dw_con.object.career_ym[1]   //em_career_ym.GetData(ldc_CareerYm)
IF isNull(ldc_CareerYm) THEN
	MessageBox('확인','경력년월을 입력하시기 바랍니다.')
	dw_con.SetFocus()
	RETURN -1
END IF


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

Long	ll_RowCnt
tab_1.tabpage_1.dw_update.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_update.Retrieve(ls_JikJongCode,ls_ProcesOpt,ldc_CareerYm)
tab_1.tabpage_1.dw_update.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
ls_JikJongCode =  dw_con.object.gubn[1] // TRIM(ddlb_gubn.Text)
ls_ProcesOpt   = TRIM(dw_con.Object.proces_opt[1])

tab_1.tabpage_2.dw_print.Object.t_jikjong_nm.Text    = ls_JikJongCode
tab_1.tabpage_2.dw_print.Object.t_proces_opt_nm.Text = ls_ProcesOpt
tab_1.tabpage_2.dw_print.Object.t_career_ym_nm.Text  = String(ldc_CareerYm)+'이상'

DateTime	ldt_SysDateTime
ldt_SysDateTime = f_sysdate()	//시스템일자
tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	tab_1.tabpage_1.dw_update.SetFocus()
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
tab_1.tabpage_1.dw_update.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)//조회버튼 활성화
dw_con.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//tab_1.SelectTab(2)
//f_print(tab_1.tabpage_2.dw_print)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 경력년수를 조회한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 경력구분 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
Long		ll_InsRow
dw_con.insertrow(0)

dw_con.GetChild('proces_opt',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('proces_opt',0) = 0 THEN
	wf_setmsg('공통코드[처리구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','총경력')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
//dw_proces_opt.InsertRow(0)
dw_con.Object.proces_opt.dddw.PercentWidth	= 100
////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 경력년월 초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.object.career_ym[1] = 0
//em_career_ym.Text = '0'

tab_1.tabpage_1.dw_update.ShareData(tab_1.tabpage_2.dw_print)
tab_1.tabpage_2.dw_print.Object.DataWindow.Zoom = 75
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print
///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hin204p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin204p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin204p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin204p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin204p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin204p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin204p
end type

type uc_insert from w_msheet`uc_insert within w_hin204p
end type

type uc_delete from w_msheet`uc_delete within w_hin204p
end type

type uc_save from w_msheet`uc_save within w_hin204p
end type

type uc_excel from w_msheet`uc_excel within w_hin204p
end type

type uc_print from w_msheet`uc_print within w_hin204p
end type

type st_line1 from w_msheet`st_line1 within w_hin204p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_msheet`st_line2 within w_hin204p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_msheet`st_line3 within w_hin204p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin204p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin204p
end type

type tab_1 from tab within w_hin204p
integer x = 50
integer y = 316
integer width = 4384
integer height = 1948
integer taborder = 130
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "경력년수 검색"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_update dw_update
end type

on tabpage_1.create
this.dw_update=create dw_update
this.Control[]={this.dw_update}
end on

on tabpage_1.destroy
destroy(this.dw_update)
end on

type dw_update from cuo_dwwindow_one_hin within tabpage_1
integer width = 4352
integer height = 1836
integer taborder = 10
string dataobject = "d_hin204p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;////ib_RowSelect = TRUE
//ib_RowSingle = FALSE
//ib_SortGubn  = TRUE
//ib_EnterChk  = TRUE
end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update
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
	CASE ''
		///////////////////////////////////////////////////////////////////////////////// 
		//	
		///////////////////////////////////////////////////////////////////////////////// 
	CASE ELSE
		
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "경력년수 출력"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from uo_dwfree within tabpage_2
integer width = 4343
integer height = 1828
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_hin204p_9"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from u_tab within w_hin204p
event destroy ( )
integer x = 1266
integer y = 312
integer taborder = 60
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type dw_con from uo_dwfree within w_hin204p
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_hin204p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
end event

