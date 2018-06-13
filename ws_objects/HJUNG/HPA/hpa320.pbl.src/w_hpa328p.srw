$PBExportHeader$w_hpa328p.srw
$PBExportComments$코드별 항목 집계표
forward
global type w_hpa328p from w_print_form2
end type
type dw_display_title from cuo_display_title within w_hpa328p
end type
type st_5 from statictext within w_hpa328p
end type
type st_9 from statictext within w_hpa328p
end type
type ddlb_1_back from dropdownlistbox within w_hpa328p
end type
type st_20 from statictext within w_hpa328p
end type
type dw_duty_code_back from datawindow within w_hpa328p
end type
end forward

global type w_hpa328p from w_print_form2
integer height = 2668
string title = "급여 대장 출력"
dw_display_title dw_display_title
st_5 st_5
st_9 st_9
ddlb_1_back ddlb_1_back
st_20 st_20
dw_duty_code_back dw_duty_code_back
end type
global w_hpa328p w_hpa328p

forward prototypes
public function integer wf_retrieve ()
public subroutine wf_getchild ()
end prototypes

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_tab
string	ls_jikjong_code, ls_chasu

dw_con.accepttext()
is_yearMonth	=	string(dw_con.object.yearmonth[1], 'yyyymm')//uo_yearmonth.uf_getyearmonth()
if  is_yearMonth	=	'' or isnull(is_yearmonth)	then
	wf_setmsg('년월을 입력하세요!')
	return -1
end if

ls_jikjong_code = trim(dw_con.object.code[1])

if isnull(ls_jikjong_code) or trim(ls_jikjong_code) = '0' or trim(ls_jikjong_code) = '' then	
	ii_str_jikjong	=	0
	ii_end_jikjong	=	9
else
	ii_str_jikjong = integer(trim(ls_jikjong_code))
	ii_end_jikjong = integer(trim(ls_jikjong_code))
end if


//if ii_str_jikjong = 0 then
//	ls_jikjong_code = '%'
//else
//	
//	ls_jikjong_code = string(ii_str_jikjong)
//end if
////////////////////////////////////////////////////////////////////////////////////
// 1.2 직급명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_DutyCode
ls_DutyCode = TRIM(dw_con.Object.duty_code[1])

IF LEN(ls_DutyCode) = 0 OR isNull(ls_DutyCode) THEN ls_DutyCode = '%'

ls_chasu = dw_con.object.chasu[1]

//if ddlb_1.text = '2' then
//	ls_chasu ='2'
//elseif ddlb_1.text = '3' then
//	ls_chasu ='3'
//elseif ddlb_1.text = '4' then
//	ls_chasu ='4'
//elseif ddlb_1.text = '5' then
//	ls_chasu ='5'
//end if
st_back.visible = false
dw_print.visible = true
dw_print.retrieve(is_yearmonth, ls_DutyCode, ii_str_jikjong, ii_end_jikjong, ls_chasu)

return	0
end function

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
long ll_InsRow
// 보직코드
dw_print.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if



////////////////////////////////////////////////////////////////////////////////////
// 1.2 조회조건 - 직급명 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
dw_con.GetChild('duty_code',idw_child)
idw_child.SetTransObject(SQLCA)
IF idw_child.Retrieve() = 0 THEN
	wf_setmsg('직급코드를 입력하시기 바랍니다.')
	idw_child.InsertRow(0)
ELSE
	ll_InsRow = idw_child.InsertRow(0)
	idw_child.SetItem(ll_InsRow,'code','0')
	idw_child.SetItem(ll_InsRow,'fname','없음')
	idw_child.SetSort('code ASC')
	idw_child.Sort()
END IF
//dw_duty_code.InsertRow(0)
dw_con.Object.duty_code.dddw.PercentWidth = 100


end subroutine

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()

return 1
end event

on w_hpa328p.create
int iCurrent
call super::create
this.dw_display_title=create dw_display_title
this.st_5=create st_5
this.st_9=create st_9
this.ddlb_1_back=create ddlb_1_back
this.st_20=create st_20
this.dw_duty_code_back=create dw_duty_code_back
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_display_title
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_9
this.Control[iCurrent+4]=this.ddlb_1_back
this.Control[iCurrent+5]=this.st_20
this.Control[iCurrent+6]=this.dw_duty_code_back
end on

on w_hpa328p.destroy
call super::destroy
destroy(this.dw_display_title)
destroy(this.st_5)
destroy(this.st_9)
destroy(this.ddlb_1_back)
destroy(this.st_20)
destroy(this.dw_duty_code_back)
end on

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//f_print(dw_print)
//
end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//wf_getchild()
//
//dw_print.object.datawindow.print.preview = 'yes'
//dw_print.visible = false
//
//DDLB_1.TEXT = '2'
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

wf_getchild()

dw_print.object.datawindow.print.preview = 'yes'
dw_print.visible = false
idw_print = dw_print

//DDLB_1.TEXT = '2'
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

type ln_templeft from w_print_form2`ln_templeft within w_hpa328p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa328p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa328p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa328p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa328p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa328p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa328p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa328p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa328p
end type

type uc_save from w_print_form2`uc_save within w_hpa328p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa328p
end type

type uc_print from w_print_form2`uc_print within w_hpa328p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa328p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa328p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa328p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa328p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa328p
end type

type st_back from w_print_form2`st_back within w_hpa328p
boolean visible = false
integer y = 288
integer height = 2328
end type

type dw_print from w_print_form2`dw_print within w_hpa328p
integer y = 288
integer taborder = 0
string dataobject = "d_hpa328p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_print::retrieveend;call super::retrieveend;dw_display_title.uf_display_title(this, 0)

end event

type st_1 from w_print_form2`st_1 within w_hpa328p
boolean visible = false
integer x = 2423
integer y = 72
end type

type dw_head from w_print_form2`dw_head within w_hpa328p
boolean visible = false
integer x = 2629
integer y = 56
integer width = 818
integer taborder = 50
boolean enabled = false
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa328p
boolean visible = false
integer x = 567
integer y = 32
boolean enabled = false
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa328p
boolean visible = false
integer x = 782
integer y = 8
integer taborder = 40
end type

type st_2 from w_print_form2`st_2 within w_hpa328p
boolean visible = false
end type

type st_3 from w_print_form2`st_3 within w_hpa328p
boolean visible = false
end type

type st_con from w_print_form2`st_con within w_hpa328p
boolean visible = false
integer x = 421
integer y = 0
boolean enabled = false
end type

type dw_con from w_print_form2`dw_con within w_hpa328p
string dataobject = "d_hpa328p_con"
end type

event dw_con::itemchanged;call super::itemchanged;This.accepttext()
Choose case dwo.name
	Case 'yearmonth'
		is_yearmonth = string(date(data), 'yyyymm')
	Case 'code'
		if isnull(data) or trim(data) = '0' or trim(data) = '' then	
			ii_str_jikjong	=	0
			ii_end_jikjong	=	9
		else
			ii_str_jikjong = integer(trim(data))
			ii_end_jikjong = integer(trim(data))
		end if


	
END CHOOSE

end event

event dw_con::constructor;call super::constructor;f_getdwcommon2(dw_con, 'jikjong_code', 0, 'code', 750, 100)
this.object.yearmonth[1] = date(string(f_today(), '@@@@/@@/@@'))
dw_con.object.chasu[1] = '2'


end event

type dw_display_title from cuo_display_title within w_hpa328p
boolean visible = false
integer x = 1733
integer y = 736
integer taborder = 60
boolean bringtotop = true
end type

event constructor;call super::constructor;settransobject(sqlca)

end event

type st_5 from statictext within w_hpa328p
boolean visible = false
integer x = 3291
integer y = 72
integer width = 242
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "보기배율"
boolean focusrectangle = false
end type

type st_9 from statictext within w_hpa328p
boolean visible = false
integer x = 3762
integer y = 72
integer width = 59
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "%"
boolean focusrectangle = false
end type

type ddlb_1_back from dropdownlistbox within w_hpa328p
boolean visible = false
integer x = 1042
integer y = 52
integer width = 238
integer height = 288
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean enabled = false
boolean allowedit = true
integer limit = 5
string item[] = {"2","3","5",""}
borderstyle borderstyle = stylelowered!
end type

type st_20 from statictext within w_hpa328p
boolean visible = false
integer x = 1385
integer y = 72
integer width = 206
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "직급명"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_duty_code_back from datawindow within w_hpa328p
boolean visible = false
integer x = 1595
integer y = 52
integer width = 695
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "ddw_duty_code"
boolean border = false
boolean livescroll = true
end type

