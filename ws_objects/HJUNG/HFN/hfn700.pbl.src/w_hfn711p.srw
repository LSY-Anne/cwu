$PBExportHeader$w_hfn711p.srw
$PBExportComments$유가증권보유잔액내역
forward
global type w_hfn711p from w_hfn_print_form5
end type
end forward

global type w_hfn711p from w_hfn_print_form5
end type
global w_hfn711p w_hfn711p

type variables
integer	ii_sec_opt

end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_getchild ();// ==========================================================================================
// 기    능	:	DatawindowChild Getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.12
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
// 유가증권종류
dw_print.getchild('sec_opt', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('sec_opt', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public subroutine wf_retrieve ();String ls_code
Integer	li_sec_opt

dw_con.accepttext()
ls_code = dw_con.object.code[1]
If ls_code = '' or isnull(ls_code) Then ls_code = '0'
li_sec_opt = Integer(ls_code)

dw_print.Reset()

wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(gi_acct_class, li_sec_opt)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true
end if

wf_setMsg('')

end subroutine

on w_hfn711p.create
int iCurrent
call super::create
end on

on w_hfn711p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//
//f_getdwcommon(dw_con, 'sec_opt', 0, 730)
//dw_con.setitem(1, 'code', '0')
//idw_print = dw_print
//
//wf_getchild()
//
end event

event ue_postopen;call super::ue_postopen;
f_getdwcommon(dw_con, 'sec_opt', 0, 730)
dw_con.setitem(1, 'code', '0')
idw_print = dw_print

wf_getchild()

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "유가증권 보유잔액 내역")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn711p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn711p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn711p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn711p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn711p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn711p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn711p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn711p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn711p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn711p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn711p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn711p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn711p
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn711p
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn711p
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn711p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn711p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn711p
boolean visible = false
integer x = 1275
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn711p
boolean visible = false
integer x = 2190
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn711p
integer taborder = 30
string dataobject = "d_hfn711p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn711p
string dataobject = "d_hfn704p_con"
end type

event dw_con::constructor;call super::constructor;This.object.code_t.text = '유가증권종류 '
end event

