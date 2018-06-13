$PBExportHeader$w_hfn903p.srw
$PBExportComments$부서별자금집행계획서
forward
global type w_hfn903p from w_hfn_print_form5
end type
end forward

global type w_hfn903p from w_hfn_print_form5
end type
global w_hfn903p w_hfn903p

type variables

end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();dw_print.Reset()

wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(gi_acct_class, String(dw_con.object.yyyymm[1], 'yyyymm'))
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true
end if

wf_setMsg('')

end subroutine

on w_hfn903p.create
int iCurrent
call super::create
end on

on w_hfn903p.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//
//
//em_yyyymm.text = string(f_today(), '@@@@/@@')
end event

event ue_postopen;call super::ue_postopen;
dw_con.object.yyyymm[1] = date(string(f_today(), '@@@@/@@/@@'))
idw_print = dW_print
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "자금집행 계획서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn903p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn903p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn903p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn903p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn903p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn903p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn903p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn903p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn903p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn903p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn903p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn903p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn903p
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn903p
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn903p
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn903p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn903p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn903p
boolean visible = false
integer x = 855
integer y = 108
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn903p
boolean visible = false
integer x = 2190
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn903p
integer taborder = 20
string dataobject = "d_hfn903p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn903p
string dataobject = "d_hfn903p_con"
end type

