$PBExportHeader$w_hin914p.srw
$PBExportComments$근무년수 검색및출력
forward
global type w_hin914p from w_msheet
end type
type dw_con from uo_dwfree within w_hin914p
end type
type uo_1 from u_tab within w_hin914p
end type
type tab_1 from tab within w_hin914p
end type
type tabpage_1 from userobject within tab_1
end type
type dw_print from uo_dwfree within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hin914p
tabpage_1 tabpage_1
end type
end forward

global type w_hin914p from w_msheet
string title = "경력년수 검색및출력"
dw_con dw_con
uo_1 uo_1
tab_1 tab_1
end type
global w_hin914p w_hin914p

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

on w_hin914p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.uo_1=create uo_1
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.tab_1
end on

on w_hin914p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.uo_1)
destroy(this.tab_1)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 근무년수를 조회한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.03
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//
//em_fr_ym.Text = '0'
//em_to_ym.Text = '0'
//
//tab_1.tabpage_1.dw_print.Object.DataWindow.Zoom = 100
//tab_1.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
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

dw_con.accepttext()
String	ls_JikJongCode
date		ld_date

ls_JikJongCode = dw_con.object.gubn[1]//MID(ddlb_gubn.Text,1,1)

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

//Decimal{2}	ldc_CareerYm
//Decimal{2}	ldc_TO_CareerYm
//
//em_fr_ym.GetData(ldc_CareerYm)
//em_to_ym.GetData(ldc_TO_CareerYm)
//
//IF isNull(ldc_CareerYm) THEN
//	MessageBox('확인','근무년월을 입력하시기 바랍니다.')
//	em_fr_ym.SetFocus()
//	RETURN -1
//END IF
//
//IF isNull(ldc_TO_CareerYm) THEN
//	MessageBox('확인','근무년월을 입력하시기 바랍니다.')
//	em_fr_ym.SetFocus()
//	RETURN -1
//END IF
String  ls_fr_date, ls_to_date
		ls_fr_date = string(dw_con.object.fr_ym[1], 'yyyymmdd') //mid(em_fr_ym.text,1,4) + mid(em_fr_ym.text,6,2) + &
	          		// mid(em_fr_ym.text,9,2)
		ls_to_date = string(dw_con.object.to_ym[1], 'yyyymmdd')// mid(em_to_ym.text,1,4) + mid(em_to_ym.text,6,2) + &
	         		// mid(em_to_ym.text,9,2)

		IF ls_fr_date = '' or isnull(ls_fr_date) then
			wf_setmsg("기간from를 입력하시기바랍니다..!")
			 return -1
		END IF

		IF ls_to_date = '' or isnull(ls_to_date) then
			wf_setmsg("기간to를 입력하시기바랍니다..!")
			 return -1
		END IF
SetPointer(HourGlass!)

Long	ll_RowCnt
ll_RowCnt = tab_1.tabpage_1.dw_print.Retrieve(ls_JikJongCode, ls_fr_date, ls_to_date)
//ll_RowCnt = tab_1.tabpage_1.dw_print.Retrieve(ls_JikJongCode, ldc_CareerYm, ldc_TO_CareerYm)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////

//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_1.tabpage_1.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_1.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	tab_1.tabpage_1.dw_print.SetFocus()
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
//tab_1.tabpage_1.dw_print.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)//조회버튼 활성화
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
//f_print(tab_1.tabpage_1.dw_print)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 근무년수를 조회한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////

//em_fr_ym.Text = '0'
//em_to_ym.Text = '0'
dw_con.object.fr_ym[1] = date('0000/00/00')
dw_con.object.to_ym[1] = date('0000/00/00')
tab_1.tabpage_1.dw_print.Object.DataWindow.Zoom = 100
tab_1.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_1.dw_print
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

type ln_templeft from w_msheet`ln_templeft within w_hin914p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin914p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin914p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin914p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin914p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin914p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin914p
end type

type uc_insert from w_msheet`uc_insert within w_hin914p
end type

type uc_delete from w_msheet`uc_delete within w_hin914p
end type

type uc_save from w_msheet`uc_save within w_hin914p
end type

type uc_excel from w_msheet`uc_excel within w_hin914p
end type

type uc_print from w_msheet`uc_print within w_hin914p
end type

type st_line1 from w_msheet`st_line1 within w_hin914p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_msheet`st_line2 within w_hin914p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_msheet`st_line3 within w_hin914p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin914p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin914p
end type

type dw_con from uo_dwfree within w_hin914p
integer x = 50
integer y = 164
integer width = 4379
integer height = 120
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hin914p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
This.insertrow(0)

//	이 벤 트 명: constructor
//	기 능 설 명: 활성화되는 시점에 로그인한 사람의 권한그룹을 체크하여
//						교직원구분을 셋팅한다.
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UserID		//로그인사번
Integer	li_JikJongCode	//교직원구분코드
ls_UserID =  gs_empcode //TRIM(gstru_uid_uname.uid)			//로그인사번
IF LEN(ls_UserID) = 0 THEN
	li_JikJongCode = 1
	RETURN -1
END IF

String 	ls_GroupID		//권한그굽코드
Boolean	lb_GroupChk = FALSE
SELECT	A.GROUP_ID
INTO		:ls_GroupID
FROM		CDDB.KCH403M A
WHERE		A.MEMBER_NO = :ls_UserID
AND		A.GROUP_ID  IN ('Hin00','Hin01','Hin02','Admin','Mnger','PGMer2')
AND		ROWNUM       = 1;

CHOOSE CASE TRIM(ls_GroupID)
	CASE 'Hin01'
		li_JikJongCode = 2	//사무처
	CASE 'Hin02'
		li_JikJongCode = 1	//교무처
	CASE ELSE
		li_JikJongCode = 3	//관리자
		lb_GroupChk    = TRUE
END CHOOSE

This.object.gubn[1] = string(li_JikJongCode)
//THIS.SelectItem(li_JikJongCode)
If lb_Groupchk = FALSE  Then 
	This.object.gubn.protect = 1
Else
	This.object.gubn.protect = 0
eND iF
//THIS.Enabled = lb_GroupChk

//uo_member.is_JikJongCode = String(li_JikJongCode)

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type uo_1 from u_tab within w_hin914p
event destroy ( )
integer x = 1083
integer y = 328
integer taborder = 90
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type tab_1 from tab within w_hin914p
integer x = 46
integer y = 332
integer width = 4389
integer height = 1936
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
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4352
integer height = 1816
long backcolor = 16777215
string text = "근무년수 검색"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_1.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_1.destroy
destroy(this.dw_print)
end on

type dw_print from uo_dwfree within tabpage_1
integer y = 4
integer width = 4347
integer height = 1820
integer taborder = 60
string dataobject = "d_hin914p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

