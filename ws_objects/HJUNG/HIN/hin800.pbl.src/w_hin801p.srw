$PBExportHeader$w_hin801p.srw
$PBExportComments$교원현황(계열별)
forward
global type w_hin801p from w_msheet
end type
type dw_print from cuo_dwwindow within w_hin801p
end type
type em_yy from editmask within w_hin801p
end type
type st_1 from statictext within w_hin801p
end type
type gb_1 from groupbox within w_hin801p
end type
end forward

global type w_hin801p from w_msheet
integer height = 2616
string title = "인사발령장"
dw_print dw_print
em_yy em_yy
st_1 st_1
gb_1 gb_1
end type
global w_hin801p w_hin801p

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
//	IF POS(as_Type,ls_Flag[li_idx],1) > 0 THEN lb_Value = TRUE
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

on w_hin801p.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.em_yy=create em_yy
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.em_yy
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_hin801p.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.em_yy)
destroy(this.st_1)
destroy(this.gb_1)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 교원현황(계열별)로 출력한다.
//	작 성 인 : 전희열
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건
////////////////////////////////////////////////////////////////////////////////////
em_yy.text = MID(f_today(),1,4)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
THIS.TRIGGER EVENT ue_retrieve()

/////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////////
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
// 1. 조회조건 입력여부 체크
///////////////////////////////////////////////////////////////////////////////////////
string ls_yy
ls_yy = trim(em_yy.TEXT)
if isnull(ls_yy) or len(ls_yy) <> 4 then
	Messagebox("확인","년도를 입력하세요")
	return -1
end if

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
Long	ll_RowCnt
dw_print.SetReDraw(FALSE) 
ll_RowCnt = dw_print.retrieve(ls_yy,'숭의여대')
dw_print.SetReDraw(TRUE) 

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
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
return 1
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
dw_print.Object.DataWindow.Zoom = 70
dw_print.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenuBtn('R')
em_yy.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_msheet`ln_templeft within w_hin801p
end type

type ln_tempright from w_msheet`ln_tempright within w_hin801p
end type

type ln_temptop from w_msheet`ln_temptop within w_hin801p
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hin801p
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hin801p
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hin801p
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hin801p
end type

type uc_insert from w_msheet`uc_insert within w_hin801p
end type

type uc_delete from w_msheet`uc_delete within w_hin801p
end type

type uc_save from w_msheet`uc_save within w_hin801p
end type

type uc_excel from w_msheet`uc_excel within w_hin801p
end type

type uc_print from w_msheet`uc_print within w_hin801p
end type

type st_line1 from w_msheet`st_line1 within w_hin801p
end type

type st_line2 from w_msheet`st_line2 within w_hin801p
end type

type st_line3 from w_msheet`st_line3 within w_hin801p
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hin801p
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hin801p
end type

type dw_print from cuo_dwwindow within w_hin801p
integer x = 18
integer y = 240
integer width = 3840
integer height = 2264
integer taborder = 80
string dataobject = "d_hin801p_1"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type em_yy from editmask within w_hin801p
integer x = 635
integer y = 88
integer width = 219
integer height = 76
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXX"
end type

event modified;parent.postevent('ue_retrieve')
end event

type st_1 from statictext within w_hin801p
integer x = 338
integer y = 96
integer width = 288
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회년도"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hin801p
integer x = 14
integer width = 3845
integer height = 228
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

