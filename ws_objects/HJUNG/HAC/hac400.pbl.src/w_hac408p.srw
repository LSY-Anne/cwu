$PBExportHeader$w_hac408p.srw
$PBExportComments$자금예산서(산출근거포함)(예산부서용)
forward
global type w_hac408p from w_print_form1
end type
type cb_1 from commandbutton within w_hac408p
end type
end forward

global type w_hac408p from w_print_form1
string title = "자금예산서(산출내역포함)(예산부서용)"
cb_1 cb_1
end type
global w_hac408p w_hac408p

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
dw_con.accepttext()
is_bdgt_year = string(dw_con.object.year[1], 'yyyy')
is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)
is_slip_class = dw_con.object.slip_class[1]
If is_slip_class = '%' Then is_slip_class = ''
is_amt_gubun = dw_con.object.amt_gu[1]
dw_print.setfilter("")
dw_print.filter()

if dw_print.retrieve(is_bdgt_year, is_bef_bdgt_year, gi_acct_class, is_slip_class, ii_bdgt_class, is_amt_gubun) > 0	then
	dw_print.setfilter("comp_remark_len > 0")
	dw_print.filter()
	
	dw_print.sort()
	dw_print.groupcalc()
end if

end subroutine

on w_hac408p.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_hac408p.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//ii_acct_class = uo_acct_class.uf_getcode()
idw_print = dw_print
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
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

type ln_templeft from w_print_form1`ln_templeft within w_hac408p
end type

type ln_tempright from w_print_form1`ln_tempright within w_hac408p
end type

type ln_temptop from w_print_form1`ln_temptop within w_hac408p
end type

type ln_tempbuttom from w_print_form1`ln_tempbuttom within w_hac408p
end type

type ln_tempbutton from w_print_form1`ln_tempbutton within w_hac408p
end type

type ln_tempstart from w_print_form1`ln_tempstart within w_hac408p
end type

type uc_retrieve from w_print_form1`uc_retrieve within w_hac408p
end type

type uc_insert from w_print_form1`uc_insert within w_hac408p
end type

type uc_delete from w_print_form1`uc_delete within w_hac408p
end type

type uc_save from w_print_form1`uc_save within w_hac408p
end type

type uc_excel from w_print_form1`uc_excel within w_hac408p
end type

type uc_print from w_print_form1`uc_print within w_hac408p
end type

type st_line1 from w_print_form1`st_line1 within w_hac408p
end type

type st_line2 from w_print_form1`st_line2 within w_hac408p
end type

type st_line3 from w_print_form1`st_line3 within w_hac408p
end type

type uc_excelroad from w_print_form1`uc_excelroad within w_hac408p
end type

type ln_dwcon from w_print_form1`ln_dwcon within w_hac408p
end type

type uo_slip_class from w_print_form1`uo_slip_class within w_hac408p
boolean visible = false
end type

type rb_3 from w_print_form1`rb_3 within w_hac408p
boolean visible = false
end type

type rb_2 from w_print_form1`rb_2 within w_hac408p
boolean visible = false
end type

type rb_1 from w_print_form1`rb_1 within w_hac408p
boolean visible = false
end type

type gb_1 from w_print_form1`gb_1 within w_hac408p
boolean visible = false
end type

type uo_bdgt_year from w_print_form1`uo_bdgt_year within w_hac408p
boolean visible = false
integer x = 69
end type

type gb_3 from w_print_form1`gb_3 within w_hac408p
boolean visible = false
end type

type st_back from w_print_form1`st_back within w_hac408p
boolean visible = false
end type

type dw_print from w_print_form1`dw_print within w_hac408p
integer width = 3877
integer height = 2276
string dataobject = "d_hac408p_1_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_con from w_print_form1`dw_con within w_hac408p
string dataobject = "d_hac203p_con"
end type

event dw_con::constructor;call super::constructor;this.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
is_bdgt_year = left(f_today(), 4)
is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)
end event

event dw_con::itemchanged;call super::itemchanged;dw_con.accepttext()
Choose Case dwo.name
	Case 'year'
		is_bdgt_year = left(data, 4)
		is_bef_bdgt_year	=	string(integer(is_bdgt_year) - 1)
	Case 'slip_class'
		
		is_slip_class = data
	Case 'amt_gu'
		is_amt_gubun = data
End Choose

end event

type cb_1 from commandbutton within w_hac408p
boolean visible = false
integer x = 3355
integer y = 44
integer width = 457
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "none"
end type

event clicked;integer 	li_value, li_chk
string	ls_docname, ls_named


//저장할 파일명 지정
li_value = GetFileSaveName("파일선택",	ls_docname, ls_named, "XLS", "Excel Files (*.XLS), *.XLS")

IF li_value = 1 THEN
	li_chk = dw_print.SaveAs(ls_named, Excel5!, true)
	Messagebox('확인','접수데이터 Excel파일 생성을 완료하였습니다.')
end if

end event

