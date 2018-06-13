$PBExportHeader$w_hss411p.srw
$PBExportComments$건물별강의실 현황
forward
global type w_hss411p from w_msheet
end type
type st_1 from statictext within w_hss411p
end type
type dw_buil_no from datawindow within w_hss411p
end type
type gb_1 from groupbox within w_hss411p
end type
type dw_print from datawindow within w_hss411p
end type
end forward

global type w_hss411p from w_msheet
integer height = 2616
st_1 st_1
dw_buil_no dw_buil_no
gb_1 gb_1
dw_print dw_print
end type
global w_hss411p w_hss411p

type variables
LONG il_getrow
end variables

on w_hss411p.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_buil_no=create dw_buil_no
this.gb_1=create gb_1
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_buil_no
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_print
end on

on w_hss411p.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_buil_no)
destroy(this.gb_1)
destroy(this.dw_print)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건의 초기화 처리.
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
dw_buil_no.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('공통코드[건물]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
else
	ldwc_temp.insertrow(1)
	ldwc_temp.setitem(1, 'buil_no', 		'')
	ldwc_temp.setitem(1, 'buil_name', 	'전체')
END IF

dw_buil_no.InsertRow(0)
dw_buil_no.Object.code.dddw.PercentWidth = 100

//tab_1.tabpage_1.dw_list.settransobject(sqlca)
//dw_2.settransobject(sqlca)


dw_print.Reset()
dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = dw_print

//////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화 이벤트 호출
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
//wf_setMenu('I',TRUE)//입력버튼 활성화
////wf_setMenu('S',TRUE)//저장버튼 활성화
//wf_setMenu('D',TRUE)//삭제버튼 활성화
//wf_setMenu('R',TRUE)//저장버튼 활성화

triggerevent('ue_retrieve')
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////


end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
String ls_buil_no
ls_buil_no = TRIM(dw_buil_no.Object.code[1])
IF LEN(ls_buil_no) = 0 OR isNull(ls_buil_no) THEN ls_buil_no = ''
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(ls_buil_no )
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	
//	IF tab_1.tabpage_1.dw_main.modifiedcount() + tab_1.tabpage_1.dw_main.deletedcount() <> 0 THEN 
//		event trigger ue_save(0,0)
//	END IF 
//	tab_1.tabpage_1.dw_main.SetFocus()
END IF
return 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;//f_print(dw_print)
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "건물별 강의실 현황")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hss411p
end type

type ln_tempright from w_msheet`ln_tempright within w_hss411p
end type

type ln_temptop from w_msheet`ln_temptop within w_hss411p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hss411p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hss411p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hss411p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hss411p
end type

type uc_insert from w_msheet`uc_insert within w_hss411p
end type

type uc_delete from w_msheet`uc_delete within w_hss411p
end type

type uc_save from w_msheet`uc_save within w_hss411p
end type

type uc_excel from w_msheet`uc_excel within w_hss411p
end type

type uc_print from w_msheet`uc_print within w_hss411p
end type

type st_line1 from w_msheet`st_line1 within w_hss411p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hss411p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hss411p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hss411p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hss411p
end type

type st_1 from statictext within w_hss411p
integer x = 288
integer y = 184
integer width = 210
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "건물명"
boolean focusrectangle = false
end type

type dw_buil_no from datawindow within w_hss411p
integer x = 494
integer y = 160
integer width = 841
integer height = 100
integer taborder = 40
string title = "none"
string dataobject = "ddw_build"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_hss411p
integer x = 50
integer y = 112
integer width = 4389
integer height = 172
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type dw_print from datawindow within w_hss411p
integer x = 50
integer y = 312
integer width = 4384
integer height = 2000
integer taborder = 50
string title = "none"
string dataobject = "d_hss411p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

