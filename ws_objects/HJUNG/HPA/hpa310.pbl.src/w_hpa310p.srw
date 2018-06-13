$PBExportHeader$w_hpa310p.srw
$PBExportComments$급여 대장 출력
forward
global type w_hpa310p from w_print_form2
end type
type dw_display_title from cuo_display_title within w_hpa310p
end type
type st_5 from statictext within w_hpa310p
end type
type st_9 from statictext within w_hpa310p
end type
type dw_print2 from datawindow within w_hpa310p
end type
type pb_print from picturebutton within w_hpa310p
end type
type em_zoom from editmask within w_hpa310p
end type
type st_4 from statictext within w_hpa310p
end type
end forward

global type w_hpa310p from w_print_form2
string title = "급여 대장 출력"
dw_display_title dw_display_title
st_5 st_5
st_9 st_9
dw_print2 dw_print2
pb_print pb_print
em_zoom em_zoom
st_4 st_4
end type
global w_hpa310p w_hpa310p

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

// 보직코드
//dw_print.getchild('bojik_code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(0) < 1 then
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

integer	li_tab
string	ls_jikjong_code

dw_con.accepttext()
is_yearmonth = string(dw_con.object.yearmonth[1], 'yyyymm')

if ii_str_jikjong = 0 then
	ls_jikjong_code = ''
else
	ls_jikjong_code = string(ii_str_jikjong)
end if

dw_print2.visible		=	false
pb_print.text			=	'   표지보이기'
st_back.bringtotop 	=	true

if dw_con.object.chasu[1]  <> '1' then 
	if  dw_con.object.chasu[1]  = '5' then
		
		dw_print.dataobject ='d_hpa310p_1'
	
	elseif dw_con.object.chasu[1]  = '4' then
		
		dw_print.dataobject ='d_hpa311p_14'
	
	elseif dw_con.object.chasu[1]  = '3' then
		
		dw_print.dataobject ='d_hpa311p_1'
	
	elseif dw_con.object.chasu[1]  = '2' then
		
		dw_print.dataobject ='d_hpa311p_12'
	
	//elseif ddlb_1.text = '1' then
	//	
	//	dw_print.dataobject ='d_hpa311p_11'
	//
	
	elseif dw_con.object.chasu[1]  = '%' then
		
		dw_print.dataobject ='d_hpa321p_1'
	end if
	
	dw_print.SettransObject(sqlca)
	dw_print.Modify("DataWindow.Print.Preview='yes'")
	
	ii_str_jikjong	=	0
	ii_end_jikjong	=	9
	is_dept_code = '%'
	
	if dw_print.retrieve(is_yearmonth, is_dept_code, ii_str_jikjong, ii_end_jikjong) > 0 then
		//dw_print2.retrieve(is_yearmonth, is_dept_code, ls_jikjong_code, '22')
		st_back.bringtotop 	= 	false
		pb_print.enabled		=	true
	else
		dw_print.reset()
		//dw_print2.reset()
		pb_print.enabled		=	false
	end if
else 
	dw_print.dataobject ='d_hpa310p_11'
	dw_print.SettransObject(sqlca)
	dw_print.Modify("DataWindow.Print.Preview='yes'")
	
	if dw_print.retrieve(is_yearmonth) > 0 then
		
		st_back.bringtotop 	= 	false
		pb_print.enabled		=	true
	else
		dw_print.reset()
		
		pb_print.enabled		=	false
	end if
end if

return	0
end function

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()

return 1
end event

on w_hpa310p.create
int iCurrent
call super::create
this.dw_display_title=create dw_display_title
this.st_5=create st_5
this.st_9=create st_9
this.dw_print2=create dw_print2
this.pb_print=create pb_print
this.em_zoom=create em_zoom
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_display_title
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_9
this.Control[iCurrent+4]=this.dw_print2
this.Control[iCurrent+5]=this.pb_print
this.Control[iCurrent+6]=this.em_zoom
this.Control[iCurrent+7]=this.st_4
end on

on w_hpa310p.destroy
call super::destroy
destroy(this.dw_display_title)
destroy(this.st_5)
destroy(this.st_9)
destroy(this.dw_print2)
destroy(this.pb_print)
destroy(this.em_zoom)
destroy(this.st_4)
end on

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//if dw_print2.visible then
//	IF dw_print2.RowCount() < 1 THEN	return
//
//	OpenWithParm(w_printoption, dw_print2)
//else
//	IF dw_print.RowCount() < 1 THEN	return
//
//	OpenWithParm(w_printoption, dw_print)
//end if
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
////wf_getchild()
//ddlb_1.text = '%'
//
////dw_print2.object.datawindow.print.preview = 'yes'
//dw_print2.visible = false
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

//wf_getchild()
//ddlb_1.text = '%'

//dw_print2.object.datawindow.print.preview = 'yes'
dw_print2.visible = false
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

type ln_templeft from w_print_form2`ln_templeft within w_hpa310p
end type

type ln_tempright from w_print_form2`ln_tempright within w_hpa310p
end type

type ln_temptop from w_print_form2`ln_temptop within w_hpa310p
end type

type ln_tempbuttom from w_print_form2`ln_tempbuttom within w_hpa310p
end type

type ln_tempbutton from w_print_form2`ln_tempbutton within w_hpa310p
end type

type ln_tempstart from w_print_form2`ln_tempstart within w_hpa310p
end type

type uc_retrieve from w_print_form2`uc_retrieve within w_hpa310p
end type

type uc_insert from w_print_form2`uc_insert within w_hpa310p
end type

type uc_delete from w_print_form2`uc_delete within w_hpa310p
end type

type uc_save from w_print_form2`uc_save within w_hpa310p
end type

type uc_excel from w_print_form2`uc_excel within w_hpa310p
end type

type uc_print from w_print_form2`uc_print within w_hpa310p
end type

type st_line1 from w_print_form2`st_line1 within w_hpa310p
end type

type st_line2 from w_print_form2`st_line2 within w_hpa310p
end type

type st_line3 from w_print_form2`st_line3 within w_hpa310p
end type

type uc_excelroad from w_print_form2`uc_excelroad within w_hpa310p
end type

type ln_dwcon from w_print_form2`ln_dwcon within w_hpa310p
end type

type st_back from w_print_form2`st_back within w_hpa310p
boolean visible = false
end type

type dw_print from w_print_form2`dw_print within w_hpa310p
string dataobject = "d_hpa310p_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_print::retrieveend;call super::retrieveend;dw_display_title.uf_display_title(this, 0)

end event

type st_1 from w_print_form2`st_1 within w_hpa310p
boolean visible = false
integer y = 72
end type

type dw_head from w_print_form2`dw_head within w_hpa310p
boolean visible = false
integer y = 56
integer width = 818
end type

type uo_yearmonth from w_print_form2`uo_yearmonth within w_hpa310p
boolean visible = false
integer x = 151
integer y = 36
end type

type uo_dept_code from w_print_form2`uo_dept_code within w_hpa310p
boolean visible = false
integer x = 960
end type

type st_2 from w_print_form2`st_2 within w_hpa310p
boolean visible = false
end type

type st_3 from w_print_form2`st_3 within w_hpa310p
boolean visible = false
end type

type st_con from w_print_form2`st_con within w_hpa310p
boolean visible = false
integer x = 91
integer y = 0
end type

type dw_con from w_print_form2`dw_con within w_hpa310p
string dataobject = "d_hpa310p_con"
end type

event dw_con::constructor;call super::constructor;
this.object.yearmonth[1] = date(string(f_today(), '@@@@/@@/@@'))
this.object.chasu[1] = '%'


end event

event dw_con::itemchanged;call super::itemchanged;This.accepttext()

Choose Case dwo.name
	Case 'yearmonth'
		is_yearmonth = trim(data)
End Choose
end event

type dw_display_title from cuo_display_title within w_hpa310p
boolean visible = false
integer x = 1257
integer y = 704
integer taborder = 40
boolean bringtotop = true
end type

event constructor;call super::constructor;settransobject(sqlca)

end event

type st_5 from statictext within w_hpa310p
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

type st_9 from statictext within w_hpa310p
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

type dw_print2 from datawindow within w_hpa310p
boolean visible = false
integer x = 46
integer y = 300
integer width = 3881
integer height = 2336
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa310p_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type pb_print from picturebutton within w_hpa310p
boolean visible = false
integer x = 3355
integer y = 44
integer width = 475
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "     표지보이기"
string picturename = "..\bmp\query_e.BMP"
string disabledname = "..\bmp\query_d.BMP"
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;if dw_print2.rowcount() < 1 then	return

if	dw_print2.visible	then
	this.text	=	'   표지보이기'
	dw_print2.visible = false
else
	this.text	=	'   표지감추기'
	dw_print2.visible = true
end if

end event

type em_zoom from editmask within w_hpa310p
boolean visible = false
integer x = 3259
integer y = 52
integer width = 233
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "100"
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean autoskip = true
boolean spin = true
double increment = 10
string minmax = "50~~400"
end type

event modified;dw_print.object.datawindow.zoom	= this.text

if this.text <= '80' then
	dw_print.object.datawindow.print.paper.size = 9
else
	dw_print.object.datawindow.print.paper.size = 8
end if	
end event

event constructor;if gs_empcode  = '0109035' then
	this.visible = true
else
	this.visible = false
end if

end event

type st_4 from statictext within w_hpa310p
boolean visible = false
integer x = 3063
integer y = 64
integer width = 160
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "ZOMM"
boolean focusrectangle = false
end type

