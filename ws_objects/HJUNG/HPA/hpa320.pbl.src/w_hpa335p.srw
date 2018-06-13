$PBExportHeader$w_hpa335p.srw
$PBExportComments$학과별 월 소득내역
forward
global type w_hpa335p from w_msheet
end type
type dw_print from cuo_dwprint within w_hpa335p
end type
type dw_con from uo_dwfree within w_hpa335p
end type
end forward

global type w_hpa335p from w_msheet
string title = "급여비교표"
dw_print dw_print
dw_con dw_con
end type
global w_hpa335p w_hpa335p

type variables

end variables

on w_hpa335p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.dw_con
end on

on w_hpa335p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.dw_con)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 간접비실행예산을 관리한다.
////	작 성 인 : 전희열
////	작성일자 : 2002.09
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 : 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//string	ls_sysdate
//ls_sysdate	=	f_today()
//
//em_fr_date.text = string(ls_sysdate, '@@@@/@@')
//em_to_date.text = string(ls_sysdate, '@@@@/@@')
//
//dw_print.Object.DataWindow.Print.Preview = 'YES'
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화 이벤트 호출
/////////////////////////////////////////////////////////////////////////////////////////
//THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
//
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
// 1.1 기준년 입력체크
////////////////////////////////////////////////////////////////////////////////////
string	ls_from_date, ls_to_date
date		ld_date

dw_con.accepttext()

ld_date = dw_con.object.fr_date[1]
ls_from_date = string(ld_date, 'yyyymm')

ld_date = dw_con.object.to_date[1]
ls_to_date = string(ld_date, 'yyyymm')

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(ls_from_date,ls_to_date)
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_UnivName
ls_UnivName = GF_GLOBAL_VALUE(2) // gstru_uid_uname.univ_name

//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('R',TRUE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('R',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('fr_date')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
dw_con.SetFocus()
dw_con.setcolumn('fr_date')

//wf_setMenuBtn('IR')
wf_SetMsg('초기화되었습니다.')
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
//f_print(dw_print)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 간접비실행예산을 관리한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.09
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
//string	ls_sysdate
//ls_sysdate	=	f_today()
//
//em_fr_date.text = string(ls_sysdate, '@@@@/@@')
//em_to_date.text = string(ls_sysdate, '@@@@/@@')

dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = dw_print
///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화 이벤트 호출
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

type ln_templeft from w_msheet`ln_templeft within w_hpa335p
end type

type ln_tempright from w_msheet`ln_tempright within w_hpa335p
end type

type ln_temptop from w_msheet`ln_temptop within w_hpa335p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hpa335p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hpa335p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hpa335p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hpa335p
end type

type uc_insert from w_msheet`uc_insert within w_hpa335p
end type

type uc_delete from w_msheet`uc_delete within w_hpa335p
end type

type uc_save from w_msheet`uc_save within w_hpa335p
end type

type uc_excel from w_msheet`uc_excel within w_hpa335p
end type

type uc_print from w_msheet`uc_print within w_hpa335p
end type

type st_line1 from w_msheet`st_line1 within w_hpa335p
end type

type st_line2 from w_msheet`st_line2 within w_hpa335p
end type

type st_line3 from w_msheet`st_line3 within w_hpa335p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hpa335p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hpa335p
end type

type dw_print from cuo_dwprint within w_hpa335p
integer x = 50
integer y = 288
integer width = 4384
integer height = 1976
integer taborder = 31
string dataobject = "d_hpa335p_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type dw_con from uo_dwfree within w_hpa335p
integer x = 50
integer y = 164
integer width = 4379
integer height = 116
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hpa335p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
This.insertrow(0)

dw_con.object.fr_date[1] =  date(string(f_today(), '@@@@/@@/@@'))
dw_con.object.to_date[1] =  date(string(f_today(), '@@@@/@@/@@'))
end event

