$PBExportHeader$w_hfn311q.srw
$PBExportComments$전표내역(회계일자)조회/출력
forward
global type w_hfn311q from w_msheet
end type
type dw_con from uo_dwfree within w_hfn311q
end type
type dw_print from cuo_dwprint within w_hfn311q
end type
type dw_list from uo_dwgrid within w_hfn311q
end type
type cb_2 from uo_imgbtn within w_hfn311q
end type
type cb_1 from uo_imgbtn within w_hfn311q
end type
end forward

global type w_hfn311q from w_msheet
integer height = 2616
dw_con dw_con
dw_print dw_print
dw_list dw_list
cb_2 cb_2
cb_1 cb_1
end type
global w_hfn311q w_hfn311q

type variables
datawindowchild	idw_child


end variables

forward prototypes
public subroutine wf_button_control ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_button_control ();//// ------------------------------------------------------------------------------------------
//// Function Name	:	wf_button_control
//// Function 설명	:	버튼을 Control 한다.
//// Argument			:	
//// Return			:	
//// ------------------------------------------------------------------------------------------
//wf_setMenu('INSERT',		FALSE)
//wf_setMenu('DELETE',		FALSE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		FALSE)
//wf_setMenu('PRINT',		FALSE)
//
end subroutine

public subroutine wf_retrieve ();// ------------------------------------------------------------------------------------------
// Function Name	:	wf_retrieve(List Datawindow Retrieve)
// Function 설명	:	조회를 한다.
// Argument			:	
//	Return			:	sqlca.sqlcode
// ------------------------------------------------------------------------------------------
integer	li_slip_class
string	ls_from_date, ls_to_date
//datetime ldt_sysdatetime
date		ld_date

dw_con.accepttext()
li_slip_class = Integer(dw_con.object.slip_class[1]) - 1

ls_from_date = string(dw_con.object.fr_date[1], 'yyyymmdd')

ls_to_date = string(dw_con.object.to_date[1], 'yyyymmdd')

dw_list.setredraw(false)
dw_print.setredraw(false)
dw_print.reset()
dw_list.reset()
if dw_print.retrieve(gi_acct_class, li_slip_class, ls_from_date, ls_to_date) > 0 then
   dw_print.Object.t_slip_date.Text = string(dw_con.object.fr_date[1], 'yyyy/mm/dd') + ' ∼ ' + string(dw_con.object.to_date[1], 'yyyy/mm/dd')

//   ldt_SysDateTime = f_sysdate()
//   dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//   dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
end if
dw_list.retrieve(gi_acct_class, li_slip_class, ls_from_date, ls_to_date)
dw_print.setredraw(true)
dw_list.setredraw(true)
end subroutine

on w_hfn311q.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_print=create dw_print
this.dw_list=create dw_list
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_print
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
end on

on w_hfn311q.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_print)
destroy(this.dw_list)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event ue_open;call super::ue_open;//string	ls_sysdate
//
//wf_button_control()
//
//ls_sysdate	=	f_today()
//
//dw_con.object.fr_date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))
//dw_con.object.to_date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))
//
//// 전표 구분(1=수입전표, 2=지출전표, 3=대체전표)
//
//dw_con.object.slip_class[1] = '1'
end event

event ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2002. 11                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////
String ls_fr_date, ls_to_date

dw_con.accepttext()
ls_fr_date = String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date = String(dw_con.object.to_date[1], 'yyyymmdd')
if ls_fr_date > ls_to_date then
	messagebox('확인', '전표기간을 올바르게 입력하시기 바랍니다.')
	dw_con.setfocus()
	dw_con.setcolumn('to_date')
	return -1
end if


wf_retrieve()

return 1
end event

event ue_print;call super::ue_print;//IF dw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, dw_print)
//
end event

event ue_postopen;call super::ue_postopen;string	ls_sysdate

wf_button_control()

ls_sysdate	=	f_today()

dw_con.object.fr_date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))

// 전표 구분(1=수입전표, 2=지출전표, 3=대체전표)

dw_con.object.slip_class[1] = '1'

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

type ln_templeft from w_msheet`ln_templeft within w_hfn311q
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn311q
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn311q
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn311q
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn311q
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn311q
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn311q
end type

type uc_insert from w_msheet`uc_insert within w_hfn311q
end type

type uc_delete from w_msheet`uc_delete within w_hfn311q
end type

type uc_save from w_msheet`uc_save within w_hfn311q
end type

type uc_excel from w_msheet`uc_excel within w_hfn311q
end type

type uc_print from w_msheet`uc_print within w_hfn311q
end type

type st_line1 from w_msheet`st_line1 within w_hfn311q
end type

type st_line2 from w_msheet`st_line2 within w_hfn311q
end type

type st_line3 from w_msheet`st_line3 within w_hfn311q
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn311q
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn311q
end type

type dw_con from uo_dwfree within w_hfn311q
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 190
boolean bringtotop = true
string dataobject = "d_hfn309q_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
dw_con.object.acct_code.visible = false
dw_con.object.acct_code_t.visible = false
dw_con.object.fr_date_t.text = '회계기간'


end event

event itemchanged;call super::itemchanged;parent.triggerevent('ue_retrieve')
end event

type dw_print from cuo_dwprint within w_hfn311q
boolean visible = false
integer x = 50
integer y = 288
integer width = 4384
integer height = 1980
integer taborder = 70
string dataobject = "d_hfn311q_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_list from uo_dwgrid within w_hfn311q
integer x = 50
integer y = 288
integer width = 4384
integer height = 1980
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_hfn311q_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type cb_2 from uo_imgbtn within w_hfn311q
boolean visible = false
integer x = 50
integer y = 36
integer taborder = 80
boolean bringtotop = true
string btnname = "출력감추기"
end type

event clicked;call super::clicked;	cb_1.visible = true
	cb_2.visible = false
	
	dw_print.visible = False
//	wf_setMenu('PRINT',FALSE)

end event

on cb_2.destroy
call uo_imgbtn::destroy
end on

type cb_1 from uo_imgbtn within w_hfn311q
integer x = 50
integer y = 36
integer taborder = 90
boolean bringtotop = true
string btnname = "출력보기"
end type

event clicked;call super::clicked;
	cb_1.visible = false
	cb_2.visible = true
	dw_print.BringToTop = TRUE
	dw_print.visible = true
//	wf_setMenu('PRINT',TRUE)

end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

