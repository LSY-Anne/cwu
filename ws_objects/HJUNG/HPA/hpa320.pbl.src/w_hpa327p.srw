$PBExportHeader$w_hpa327p.srw
$PBExportComments$코드별 항목 집계표(직급별)
forward
global type w_hpa327p from w_print_form2
end type
type dw_display_title from cuo_display_title within w_hpa327p
end type
type st_5 from statictext within w_hpa327p
end type
type st_9 from statictext within w_hpa327p
end type
type ddlb_chasu_back from dropdownlistbox within w_hpa327p
end type
type st_6 from statictext within w_hpa327p
end type
type ddlb_gubun_back from dropdownlistbox within w_hpa327p
end type
end forward

global type w_hpa327p from w_print_form2
integer height = 2668
string title = "급여 대장 출력"
dw_display_title dw_display_title
st_5 st_5
st_9 st_9
ddlb_chasu_back ddlb_chasu_back
st_6 st_6
ddlb_gubun_back ddlb_gubun_back
end type
global w_hpa327p w_hpa327p

type variables
String		is_GrpCode
String		is_Chasu
end variables

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 주의사항 :
// 수정사항 :
// ==========================================================================================

dw_con.accepttext()
is_yearMonth	=	String(dw_con.object.yearmonth[1], 'yyyymm')//uo_yearmonth.uf_getyearmonth()
if  is_yearMonth	=	'' or isnull(is_yearmonth)	then
	wf_setmsg('년월을 입력하세요!')
	return -1
end if

is_chasu = dw_con.object.chasu[1]
IF  is_chasu = 	'' OR isnull(is_chasu)	THEN is_chasu = '5'
is_GrpCode = trim(dw_con.object.gubun[1])
st_back.visible = false
dw_print.visible = true
dw_print.retrieve(is_yearmonth, is_GrpCode, is_chasu)

return	0

end event

on w_hpa327p.create
int iCurrent
call super::create
this.dw_display_title=create dw_display_title
this.st_5=create st_5
this.st_9=create st_9
this.ddlb_chasu_back=create ddlb_chasu_back
this.st_6=create st_6
this.ddlb_gubun_back=create ddlb_gubun_back
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_display_title
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_9
this.Control[iCurrent+4]=this.ddlb_chasu_back
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.ddlb_gubun_back
end on

on w_hpa327p.destroy
call super::destroy
destroy(this.dw_display_title)
destroy(this.st_5)
destroy(this.st_9)
destroy(this.ddlb_chasu_back)
destroy(this.st_6)
destroy(this.ddlb_gubun_back)
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
//dw_print.object.datawindow.print.preview = 'yes'
//dw_print.visible = false
//
//ddlb_chasu.Text = '5'
//ddlb_gubun.Text = '전임교원'
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

dw_print.object.datawindow.print.preview = 'yes'
dw_print.visible = false
idw_print = dw_print
//
////ddlb_chasu.Text = '5'
//ddlb_gubun.Text = '전임교원'
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

type ln_templeft from w_print_form2`ln_templeft within w_hpa327p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa327p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa327p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa327p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa327p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa327p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa327p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa327p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa327p
end type

type uc_save from w_print_form2`uc_save within w_hpa327p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa327p
end type

type uc_print from w_print_form2`uc_print within w_hpa327p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa327p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa327p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa327p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa327p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa327p
end type

type st_back from w_print_form2`st_back within w_hpa327p
boolean visible = false
integer y = 288
integer height = 2184
end type

type dw_print from w_print_form2`dw_print within w_hpa327p
integer y = 288
integer taborder = 0
string dataobject = "d_hpa327p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_print::retrieveend;call super::retrieveend;dw_display_title.uf_display_title(this, 0)

end event

type st_1 from w_print_form2`st_1 within w_hpa327p
boolean visible = false
integer x = 2423
integer y = 72
end type

type dw_head from w_print_form2`dw_head within w_hpa327p
boolean visible = false
integer x = 2629
integer y = 56
integer width = 818
integer taborder = 50
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa327p
boolean visible = false
integer x = 101
integer y = 52
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa327p
boolean visible = false
integer x = 773
integer taborder = 40
end type

type st_2 from w_print_form2`st_2 within w_hpa327p
boolean visible = false
end type

type st_3 from w_print_form2`st_3 within w_hpa327p
boolean visible = false
end type

type st_con from w_print_form2`st_con within w_hpa327p
boolean visible = false
end type

type dw_con from w_print_form2`dw_con within w_hpa327p
string dataobject = "d_hpa327p_con"
end type

event dw_con::itemchanged;call super::itemchanged;This.accepttext()
Choose case dwo.name
	case 'chasu'
		is_Chasu	=	data
	Case 'yearmonth'
		is_yearmonth = string(date(data), 'yyyymm')
	Case 'gubun'
		is_GrpCode = data
END CHOOSE

end event

event dw_con::constructor;call super::constructor;this.object.yearmonth[1] = date(string(f_today(), '@@@@/@@/@@'))


dw_con.object.chasu[1] = '5'
dw_con.object.gubun[1] = '10'
end event

type dw_display_title from cuo_display_title within w_hpa327p
boolean visible = false
integer x = 1673
integer y = 1024
integer taborder = 60
boolean bringtotop = true
end type

event constructor;call super::constructor;settransobject(sqlca)

end event

type st_5 from statictext within w_hpa327p
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

type st_9 from statictext within w_hpa327p
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

type ddlb_chasu_back from dropdownlistbox within w_hpa327p
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
boolean allowedit = true
boolean sorted = false
integer limit = 5
string item[] = {"2","3","5",""}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE index
	CASE 1
		is_Chasu	=	'2'
	CASE 2
		is_Chasu	=	'3'
	CASE ELSE
		is_Chasu	=	'5'
END CHOOSE

end event

type st_6 from statictext within w_hpa327p
boolean visible = false
integer x = 1362
integer y = 64
integer width = 229
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "구분별"
boolean focusrectangle = false
end type

type ddlb_gubun_back from dropdownlistbox within w_hpa327p
boolean visible = false
integer x = 1600
integer y = 52
integer width = 562
integer height = 616
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"전임교원","겸임교원","초빙교원","강의전담교원","조교","일반직","기능직","기술직","연봉직","기타직"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE index
	CASE 1
		is_GrpCode	=	'10'		//전임
	CASE 2
		is_GrpCode	=	'111'		//겸임
	CASE 3
		is_GrpCode	=	'112'		//초빙
	CASE 4
		is_GrpCode	=	'115'		//강의전담
	CASE 5
		is_GrpCode	=	'20'		//조교
	CASE 6
		is_GrpCode	=	'40'		//일반
	CASE 7
		is_GrpCode	=	'50'		//기능
	CASE 8
		is_GrpCode	=	'60'		//기술
	CASE 9
		is_GrpCode	=	'80'		//연봉
	CASE ELSE
END CHOOSE

end event

