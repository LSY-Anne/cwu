$PBExportHeader$w_hpa324p.srw
$PBExportComments$소득세 원천징수 증명서//교직원용
forward
global type w_hpa324p from w_print_form2
end type
type uo_member from cuo_insa_member within w_hpa324p
end type
type cb_insert from uo_imgbtn within w_hpa324p
end type
type cb_ignore from uo_imgbtn within w_hpa324p
end type
end forward

global type w_hpa324p from w_print_form2
string title = "갑종근로소득에 대한 원천징수 명세서"
uo_member uo_member
cb_insert cb_insert
cb_ignore cb_ignore
end type
global w_hpa324p w_hpa324p

type variables

end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

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
//is_yearmonth = mid(is_yearmonth,1,4) 
dw_con.accepttext()
is_yearmonth = string(dw_con.object.year[1], 'yyyy')
////////////////////////////////////////////////////////////////////////////////////
// 1.1 성명 입력여부 체크
////////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(uo_member.sle_kname.Text)
if dw_print.retrieve(is_yearmonth, ls_kname) > 0 then
	st_back.bringtotop = false
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

on w_hpa324p.create
int iCurrent
call super::create
this.uo_member=create uo_member
this.cb_insert=create cb_insert
this.cb_ignore=create cb_ignore
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_member
this.Control[iCurrent+2]=this.cb_insert
this.Control[iCurrent+3]=this.cb_ignore
end on

on w_hpa324p.destroy
call super::destroy
destroy(this.uo_member)
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

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//cb_insert.visible = true
//cb_ignore.visible = false
//
//
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================
cb_insert.visible = true
cb_ignore.visible = false

idw_print = dw_print

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

type ln_templeft from w_print_form2`ln_templeft within w_hpa324p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa324p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa324p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa324p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa324p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa324p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa324p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa324p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa324p
end type

type uc_save from w_print_form2`uc_save within w_hpa324p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa324p
end type

type uc_print from w_print_form2`uc_print within w_hpa324p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa324p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa324p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa324p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa324p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa324p
integer beginy = 352
integer endy = 352
end type

type st_back from w_print_form2`st_back within w_hpa324p
boolean visible = false
integer y = 368
integer height = 1968
end type

type dw_print from w_print_form2`dw_print within w_hpa324p
integer y = 368
integer height = 1968
integer taborder = 0
string dataobject = "d_hpa324p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_print::retrieveend;call super::retrieveend;long i
dw_con.accepttext()
for i = 1 to rowcount
	this.Object.purpose [i] = dw_con.object.purpose[1]
	this.Object.customer[i] =  dw_con.object.customer[1]  
	this.Object.qty[i]      = dw_con.object.page[1]  
next 
end event

type st_1 from w_print_form2`st_1 within w_hpa324p
boolean visible = false
integer x = 1339
integer y = 76
end type

type dw_head from w_print_form2`dw_head within w_hpa324p
boolean visible = false
integer x = 1065
integer y = 48
integer height = 92
integer taborder = 80
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa324p
boolean visible = false
integer x = 841
integer y = 48
integer taborder = 60
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa324p
boolean visible = false
integer x = 1673
integer y = 24
integer taborder = 70
end type

event uo_dept_code::constructor;//
end event

event uo_dept_code::ue_itemchange;//
end event

type st_2 from w_print_form2`st_2 within w_hpa324p
boolean visible = false
integer x = 2107
integer y = 8
end type

type st_3 from w_print_form2`st_3 within w_hpa324p
boolean visible = false
integer x = 2107
integer y = 60
end type

type st_con from w_print_form2`st_con within w_hpa324p
integer x = 119
integer y = 440
integer width = 4315
end type

type dw_con from w_print_form2`dw_con within w_hpa324p
integer height = 184
string dataobject = "d_hpa324p_con"
end type

event dw_con::constructor;call super::constructor;uo_member.setposition(totop!)

dw_con.object.year[1] =  date(string(f_today(), '@@@@/@@/@@'))
is_yearmonth = left( f_today(), 4)
end event

event dw_con::itemchanged;call super::itemchanged;This.accepttext()

Choose Case dwo.name
	Case 'year'
		is_yearmonth = left(data, 4)
End Choose
end event

type uo_member from cuo_insa_member within w_hpa324p
integer x = 814
integer y = 176
integer taborder = 20
boolean bringtotop = true
end type

on uo_member.destroy
call cuo_insa_member::destroy
end on

type cb_insert from uo_imgbtn within w_hpa324p
event destroy ( )
integer x = 50
integer y = 36
integer taborder = 80
string btnname = "금액입력"
end type

on cb_insert.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;cb_insert.visible = false
cb_ignore.visible = true
dw_print.Object.DataWindow.Print.Preview = 'No'
dw_print.SetFocus()
dw_print.SetColumn('year')

end event

type cb_ignore from uo_imgbtn within w_hpa324p
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

