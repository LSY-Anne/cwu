$PBExportHeader$w_hpa320p.srw
$PBExportComments$원천징수이행상황신고서 출력
forward
global type w_hpa320p from w_print_form2
end type
type uo_printdate from cuo_date within w_hpa320p
end type
type pb_print from uo_imgbtn within w_hpa320p
end type
type cb_insert from uo_imgbtn within w_hpa320p
end type
type cb_ignore from uo_imgbtn within w_hpa320p
end type
end forward

global type w_hpa320p from w_print_form2
string title = "원천징수이행상황신고서 출력"
uo_printdate uo_printdate
pb_print pb_print
cb_insert cb_insert
cb_ignore cb_ignore
end type
global w_hpa320p w_hpa320p

type variables
string	is_printdate

end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_getchild ();//// ==========================================================================================
//// 기    능 : 	getchild
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 함수원형 : 	wf_getchild()
//// 인    수 :
//// 되 돌 림 :
//// 주의사항 :
//// 수정사항 :
//// ==========================================================================================
//
//// 직종명
//dw_print.getchild('jikjong_code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve('jikjong_code', 0) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//

end subroutine

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

st_back.bringtotop = true
cb_insert.visible = false
cb_ignore.visible = false
//pb_print.enabled	=	false

//pb_print.text	=	'     금액 입력'
dw_print.object.datawindow.print.preview = 'yes'


	is_yearmonth = string(dw_con.object.yearmonth[1], 'yyyymm')
	is_printdate = string(dw_con.object.em_date[1], 'yyyymmdd')

if dw_print.retrieve(is_yearmonth, is_printdate) > 0 then
	st_back.bringtotop = false
	//pb_print.enabled	=	true
	cb_insert.visible	=	true
end if

return 0

end function

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()

return 1
end event

on w_hpa320p.create
int iCurrent
call super::create
this.uo_printdate=create uo_printdate
this.pb_print=create pb_print
this.cb_insert=create cb_insert
this.cb_ignore=create cb_ignore
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_printdate
this.Control[iCurrent+2]=this.pb_print
this.Control[iCurrent+3]=this.cb_insert
this.Control[iCurrent+4]=this.cb_ignore
end on

on w_hpa320p.destroy
call super::destroy
destroy(this.uo_printdate)
destroy(this.pb_print)
destroy(this.cb_insert)
destroy(this.cb_ignore)
end on

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF dw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, dw_print)
//
end event

event ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//uo_printdate.st_title.text = '출력일자'
//is_printdate	=	uo_printdate.uf_getdate()
//idw_print = dw_print
//
////wf_getchild()
//
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

event ue_postopen;call super::ue_postopen;idw_print = dw_print

uc_retrieve.of_enable(true)
uc_print.of_enable(true)
end event

type ln_templeft from w_print_form2`ln_templeft within w_hpa320p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa320p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa320p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa320p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa320p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa320p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa320p
integer taborder = 10
end type

type uc_insert from w_print_form2`uc_insert within w_hpa320p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa320p
end type

type uc_save from w_print_form2`uc_save within w_hpa320p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa320p
end type

type uc_print from w_print_form2`uc_print within w_hpa320p
integer taborder = 20
end type

type st_line1 from w_print_form2`st_line1 within w_hpa320p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa320p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa320p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa320p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa320p
end type

type st_back from w_print_form2`st_back within w_hpa320p
boolean visible = false
end type

type dw_print from w_print_form2`dw_print within w_hpa320p
integer taborder = 50
string dataobject = "d_hpa425p_1_2009"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_1 from w_print_form2`st_1 within w_hpa320p
boolean visible = false
end type

type dw_head from w_print_form2`dw_head within w_hpa320p
boolean visible = false
integer taborder = 40
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa320p
boolean visible = false
integer x = 178
integer y = 0
integer taborder = 30
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa320p
boolean visible = false
end type

type st_2 from w_print_form2`st_2 within w_hpa320p
boolean visible = false
integer x = 2016
integer y = 196
integer width = 937
integer height = 60
string text = "※ 반드시 조회를 하시기 바랍니다."
end type

type st_3 from w_print_form2`st_3 within w_hpa320p
boolean visible = false
end type

type st_con from w_print_form2`st_con within w_hpa320p
boolean visible = false
integer x = 0
integer y = 0
end type

type dw_con from w_print_form2`dw_con within w_hpa320p
integer x = 46
integer y = 168
integer taborder = 60
string dataobject = "d_hpa320p_con"
end type

event dw_con::constructor;call super::constructor;
this.object.yearmonth[1] = date(string(f_today(), '@@@@/@@/@@'))
this.object.em_date[1] = date(string(f_today(), '@@@@/@@/@@'))

is_printdate	=	f_today()

end event

event dw_con::itemchanged;call super::itemchanged;this.accepttext()

Choose case dwo.name
	Case 'yearmonth'
		is_yearmonth = string(date(data), 'yyyymm')
	Case 'em_date'
		is_printdate = string(date(data), 'yyyymmdd')
End Choose
end event

type uo_printdate from cuo_date within w_hpa320p
boolean visible = false
integer x = 1125
integer y = 8
integer taborder = 70
boolean bringtotop = true
boolean border = false
end type

on uo_printdate.destroy
call cuo_date::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_printdate	=	this.uf_getdate()
end event

type pb_print from uo_imgbtn within w_hpa320p
event destroy ( )
boolean visible = false
integer x = 672
integer y = 36
integer taborder = 100
boolean bringtotop = true
string btnname = "금액 입력"
end type

on pb_print.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;if this.btnname	=	'금액 입력'	then
	dw_print.object.datawindow.print.preview	=	'no'
	this.btnname	=	'금액 조회'
else
	dw_print.object.datawindow.print.preview	=	'yes'
	this.btnname	=	'금액 입력'
end if

end event

type cb_insert from uo_imgbtn within w_hpa320p
event destroy ( )
integer x = 50
integer y = 36
integer taborder = 80
boolean bringtotop = true
string btnname = "금액입력"
end type

on cb_insert.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;cb_insert.visible = false
cb_ignore.visible = true
dw_print.Object.DataWindow.Print.Preview = 'No'

end event

type cb_ignore from uo_imgbtn within w_hpa320p
integer x = 50
integer y = 36
integer taborder = 90
string btnname = "입력해제"
end type

event clicked;call super::clicked;cb_insert.visible = true
cb_ignore.visible = false
dw_print.Object.DataWindow.Print.Preview = 'Yes'

end event

on cb_ignore.destroy
call uo_imgbtn::destroy
end on

