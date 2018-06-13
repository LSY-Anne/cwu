$PBExportHeader$w_hgm304p.srw
$PBExportComments$물품재고 리스트
forward
global type w_hgm304p from w_msheet
end type
type dw_print from cuo_dwwindow_one_hin within w_hgm304p
end type
type em_fr_date from editmask within w_hgm304p
end type
type st_1 from statictext within w_hgm304p
end type
type gb_1 from groupbox within w_hgm304p
end type
end forward

global type w_hgm304p from w_msheet
integer height = 2616
dw_print dw_print
em_fr_date em_fr_date
st_1 st_1
gb_1 gb_1
end type
global w_hgm304p w_hgm304p

type variables

end variables

on w_hgm304p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.em_fr_date=create em_fr_date
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.em_fr_date
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_hgm304p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.em_fr_date)
destroy(this.st_1)
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
dw_print.Object.DataWindow.Zoom = 100
dw_print.Object.DataWindow.Print.Preview = 'YES'

em_fr_date.Text = left(f_today(),4)

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

//wf_setMenu('I',FALSE)//입력버튼 활성화
//wf_setMenu('S',FALSE)//저장버튼 활성화
//wf_setMenu('D',FALSE)//삭제버튼 활성화
//wf_setMenu('R',TRUE)//저장버튼 활성화

em_fr_date.Text =  left(f_today(),4) 

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
String	ls_fr_Date
ls_fr_date = string(em_fr_date.text)
IF isNull(ls_fr_Date) OR LEN(ls_fr_Date) = 0 THEN
	messagebox("알림",'년/월를 입력하시기 바랍니다.')
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
ll_RowCnt = dw_print.Retrieve(ls_fr_date)
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
//	wf_SetMenu('S',true)
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF
return 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;f_print(dw_print)
end event

type ln_templeft from w_msheet`ln_templeft within w_hgm304p
end type

type ln_tempright from w_msheet`ln_tempright within w_hgm304p
end type

type ln_temptop from w_msheet`ln_temptop within w_hgm304p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hgm304p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hgm304p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hgm304p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hgm304p
end type

type uc_insert from w_msheet`uc_insert within w_hgm304p
end type

type uc_delete from w_msheet`uc_delete within w_hgm304p
end type

type uc_save from w_msheet`uc_save within w_hgm304p
end type

type uc_excel from w_msheet`uc_excel within w_hgm304p
end type

type uc_print from w_msheet`uc_print within w_hgm304p
end type

type st_line1 from w_msheet`st_line1 within w_hgm304p
end type

type st_line2 from w_msheet`st_line2 within w_hgm304p
end type

type st_line3 from w_msheet`st_line3 within w_hgm304p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hgm304p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hgm304p
end type

type dw_print from cuo_dwwindow_one_hin within w_hgm304p
integer x = 27
integer y = 252
integer width = 3817
integer height = 2232
integer taborder = 20
string dataobject = "d_hgm304a_1"
end type

type em_fr_date from editmask within w_hgm304p
integer x = 439
integer y = 88
integer width = 274
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
boolean spin = true
end type

type st_1 from statictext within w_hgm304p
integer x = 256
integer y = 116
integer width = 174
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "년 도"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hgm304p
integer x = 27
integer y = 4
integer width = 3822
integer height = 236
integer taborder = 30
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

