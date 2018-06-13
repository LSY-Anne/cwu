$PBExportHeader$w_hst204p.srw
$PBExportComments$비용 입고내역 리스트
forward
global type w_hst204p from w_msheet
end type
type st_2 from statictext within w_hst204p
end type
type em_to_date from editmask within w_hst204p
end type
type em_fr_date from editmask within w_hst204p
end type
type st_1 from statictext within w_hst204p
end type
type dw_print from datawindow within w_hst204p
end type
type gb_1 from groupbox within w_hst204p
end type
end forward

global type w_hst204p from w_msheet
integer height = 2616
st_2 st_2
em_to_date em_to_date
em_fr_date em_fr_date
st_1 st_1
dw_print dw_print
gb_1 gb_1
end type
global w_hst204p w_hst204p

type variables
LONG il_getrow
end variables

on w_hst204p.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_to_date=create em_to_date
this.em_fr_date=create em_fr_date
this.st_1=create st_1
this.dw_print=create dw_print
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_to_date
this.Control[iCurrent+3]=this.em_fr_date
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.gb_1
end on

on w_hst204p.destroy
call super::destroy
destroy(this.st_2)
destroy(this.em_to_date)
destroy(this.em_fr_date)
destroy(this.st_1)
destroy(this.dw_print)
destroy(this.gb_1)
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
dw_print.Reset()
dw_print.Object.DataWindow.Print.Preview = 'YES'

String	ls_Today
ls_Today = String(Today(),'YYYYMMDD')
em_fr_date.Text = MID(ls_Today,1,6)+'01'
em_to_date.Text = ls_Today

f_childretrieve(dw_print,"hst109h_item_class","item_class")			//물품구분

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
dw_print.Reset()
//wf_setmenu('R',TRUE)//저장버튼 활성화
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
String	ls_fr_Date, lsc_fr_Date
em_fr_date.GetData(ls_fr_Date)
ls_fr_Date = TRIM(ls_fr_Date)
IF isNull(ls_fr_Date) OR LEN(ls_fr_Date) = 0 THEN
	messagebox('알림','시작일자를 입력하시기 바랍니다.')
	em_fr_date.SetFocus()
	RETURN -1
END IF
lsc_fr_Date = String(ls_fr_Date,'@@@@/@@/@@')


String	ls_to_Date,lsc_to_Date
em_to_date.GetData(ls_to_Date)
ls_to_Date = TRIM(ls_to_Date)
IF isNull(ls_to_Date) OR LEN(ls_to_Date) = 0 THEN
	messagebox('알림','종료일자를 입력하시기 바랍니다.')
	em_to_date.SetFocus()
	RETURN -1
END IF
lsc_to_Date = String(ls_to_Date,'@@@@/@@/@@')
STring  ls_date
ls_date = lsc_fr_Date + " - " + lsc_to_Date

IF ls_fr_Date > ls_to_Date THEN
	messagebox('알림','조회일자 입력오류입니다.')
	em_fr_date.SetFocus()
	RETURN -1
END IF

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt

dw_print.SetReDraw(FALSE)
ll_RowCnt = dw_print.Retrieve(ls_fr_date, ls_to_date)
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
	//wf_setmenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
	//wf_setmenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
return 1
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;//f_print(dw_print)
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "비용 입고내역")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hst204p
end type

type ln_tempright from w_msheet`ln_tempright within w_hst204p
end type

type ln_temptop from w_msheet`ln_temptop within w_hst204p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst204p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst204p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst204p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst204p
end type

type uc_insert from w_msheet`uc_insert within w_hst204p
end type

type uc_delete from w_msheet`uc_delete within w_hst204p
end type

type uc_save from w_msheet`uc_save within w_hst204p
end type

type uc_excel from w_msheet`uc_excel within w_hst204p
end type

type uc_print from w_msheet`uc_print within w_hst204p
end type

type st_line1 from w_msheet`st_line1 within w_hst204p
end type

type st_line2 from w_msheet`st_line2 within w_hst204p
end type

type st_line3 from w_msheet`st_line3 within w_hst204p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst204p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst204p
end type

type st_2 from statictext within w_hst204p
integer x = 837
integer y = 204
integer width = 73
integer height = 96
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

type em_to_date from editmask within w_hst204p
integer x = 905
integer y = 204
integer width = 361
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

type em_fr_date from editmask within w_hst204p
integer x = 462
integer y = 204
integer width = 361
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

type st_1 from statictext within w_hst204p
integer x = 279
integer y = 232
integer width = 169
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "기간"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_print from datawindow within w_hst204p
integer x = 50
integer y = 372
integer width = 4384
integer height = 1900
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst201P_45"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type gb_1 from groupbox within w_hst204p
integer x = 50
integer y = 128
integer width = 4389
integer height = 236
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

