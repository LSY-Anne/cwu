$PBExportHeader$w_hfn309q.srw
$PBExportComments$전표(회계일자) 조회/출력
forward
global type w_hfn309q from w_msheet
end type
type dw_con from uo_dwfree within w_hfn309q
end type
type dw_list from uo_dwgrid within w_hfn309q
end type
type dw_detail1 from uo_dwgrid within w_hfn309q
end type
end forward

global type w_hfn309q from w_msheet
integer height = 2616
dw_con dw_con
dw_list dw_list
dw_detail1 dw_detail1
end type
global w_hfn309q w_hfn309q

type variables


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
string	ls_from_date, ls_to_date, ls_acct_code
date		ld_date
dw_con.accepttext()

li_slip_class = Integer(dw_con.object.slip_class[1]) - 1


ls_from_date = string(dw_con.object.fr_date[1], 'yyyymmdd')

ls_to_date = string(dw_con.object.to_date[1], 'yyyymmdd')

ls_acct_code = dw_con.getitemstring(1, 'acct_code')

dw_list.setredraw(false)
dw_list.reset()
if dw_list.retrieve(gi_acct_class, li_slip_class, ls_from_date, ls_to_date, ls_acct_code) < 1 then
	dw_detail1.reset()
end if
dw_list.setredraw(true)
end subroutine

on w_hfn309q.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_list=create dw_list
this.dw_detail1=create dw_detail1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.dw_detail1
end on

on w_hfn309q.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_list)
destroy(this.dw_detail1)
end on

event ue_open;call super::ue_open;//datawindowchild	ldw_child
//string				ls_sysdate
//
//// 조회조건 Clear(회계단위)
//dw_head.getchild('code', ldw_child)
//ldw_child.settransobject(sqlca)
//if ldw_child.retrieve('acct_class', 1) < 1 then
//	ldw_child.reset()
//	ldw_child.insertrow(0)
//end if
//dw_head.reset()
//dw_head.insertrow(0)
//
//ldw_child.scrolltorow(1)
//ldw_child.setrow(1)
//ii_acct_class	=	ldw_child.getitemnumber(1, 'code')
//
//dw_acct_code.SetItem(1, 'acct_code', '%')
//
//wf_button_control()
//
//ls_sysdate	=	f_today()
//
//ddlb_slip_class.selectitem(1)
//
//em_fr_date.text = string(ls_sysdate, '@@@@/@@/@@')
//em_to_date.text = string(ls_sysdate, '@@@@/@@/@@')
//
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

event ue_postopen;call super::ue_postopen;datawindowchild	ldw_child
string				ls_sysdate


dw_con.SetItem(1, 'acct_code', '%')

wf_button_control()

ls_sysdate	=	f_today()

dw_con.object.slip_class[1] = '1'


dw_con.object.fr_date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))

end event

type ln_templeft from w_msheet`ln_templeft within w_hfn309q
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn309q
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn309q
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn309q
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn309q
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn309q
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn309q
end type

type uc_insert from w_msheet`uc_insert within w_hfn309q
end type

type uc_delete from w_msheet`uc_delete within w_hfn309q
end type

type uc_save from w_msheet`uc_save within w_hfn309q
end type

type uc_excel from w_msheet`uc_excel within w_hfn309q
end type

type uc_print from w_msheet`uc_print within w_hfn309q
end type

type st_line1 from w_msheet`st_line1 within w_hfn309q
end type

type st_line2 from w_msheet`st_line2 within w_hfn309q
end type

type st_line3 from w_msheet`st_line3 within w_hfn309q
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn309q
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn309q
end type

type dw_con from uo_dwfree within w_hfn309q
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hfn309q_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)

DatawindowChild Ldw_Temp

This.GetChild('acct_code', Ldw_Temp)
Ldw_Temp.SetTransObject(SQLCA)
Ldw_Temp.Retrieve()
Ldw_Temp.InsertRow(1)
Ldw_Temp.SetItem(1,'com_code','%')
Ldw_Temp.SetItem(1,'com_name','계정전체')

end event

event itemchanged;call super::itemchanged;parent.triggerevent('ue_retrieve')
end event

type dw_list from uo_dwgrid within w_hfn309q
integer x = 50
integer y = 292
integer width = 4384
integer height = 1480
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_hfn309q_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;string	ls_slip_date
long		ll_slip_no

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

// 전표내역 조회
ls_slip_date	=	getitemstring(currentrow, 'slip_date')
ll_slip_no		=	getitemnumber(currentrow, 'slip_no')

dw_detail1.setredraw(false)
dw_detail1.reset()
dw_detail1.retrieve(gi_acct_class, ls_slip_date, ll_slip_no)
dw_detail1.setredraw(true)
end event

type dw_detail1 from uo_dwgrid within w_hfn309q
integer x = 50
integer y = 1780
integer width = 4384
integer height = 504
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hfn309q_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

