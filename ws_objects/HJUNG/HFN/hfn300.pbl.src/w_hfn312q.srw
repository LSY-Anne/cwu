$PBExportHeader$w_hfn312q.srw
$PBExportComments$부서별집행내역 조회/출력
forward
global type w_hfn312q from w_msheet
end type
type dw_con from uo_dwfree within w_hfn312q
end type
type dw_list from uo_dwgrid within w_hfn312q
end type
type dw_print from cuo_dwprint within w_hfn312q
end type
type cb_2 from uo_imgbtn within w_hfn312q
end type
type cb_1 from uo_imgbtn within w_hfn312q
end type
end forward

global type w_hfn312q from w_msheet
dw_con dw_con
dw_list dw_list
dw_print dw_print
cb_2 cb_2
cb_1 cb_1
end type
global w_hfn312q w_hfn312q

type variables
datawindowchild	idw_child



end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_button_control ()
end prototypes

public subroutine wf_retrieve ();// ------------------------------------------------------------------------------------------
// Function Name	:	wf_retrieve(List Datawindow Retrieve)
// Function 설명	:	조회를 한다.
// Argument			:	
//	Return			:	sqlca.sqlcode
// ------------------------------------------------------------------------------------------
string	ls_used_gwa
string	ls_from_date, ls_to_date
string	ls_acct_code, ls_gubun
datetime ldt_sysdatetime
date		ld_date

dw_con.accepttext()

ls_used_gwa = dw_con.getitemstring(1, 'code')
//전표일자,결의일자 구분
ls_gubun = dw_con.object.dt_gu[1]

ls_from_date = string(dw_con.object.fr_date[1], 'yyyymmdd')
ls_to_date = string(dw_con.object.to_date[1], 'yyyymmdd')

ls_acct_code = dw_con.getitemstring(1, 'acct_code')




dw_list.setredraw(false)
dw_print.setredraw(false)
dw_print.reset()
dw_list.reset()

if dw_print.retrieve(gi_acct_class, ls_used_gwa, ls_from_date, ls_to_date, ls_acct_code, ls_gubun) > 0 then
//   dw_print.Object.t_slip_date.Text =  string(dw_con.object.fr_date[1], 'yyyy/mm/dd') + ' ∼ ' + string(dw_con.object.to_date[1], 'yyyy/mm/dd')

//   ldt_SysDateTime = f_sysdate()
//   dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//   dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
end if
dw_list.retrieve(gi_acct_class, ls_used_gwa, ls_from_date, ls_to_date, ls_acct_code, ls_gubun)

dw_print.setredraw(true)
dw_list.setredraw(true)


end subroutine

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

on w_hfn312q.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_list=create dw_list
this.dw_print=create dw_print
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.dw_print
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
end on

on w_hfn312q.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_list)
destroy(this.dw_print)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event ue_open;call super::ue_open;//string	ls_sysdate
//
//wf_button_control()
//
//
//
//// 결의부서
//dw_con.getchild('code', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(1, 3) < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//
//idw_child.insertrow(1)
//idw_child.setitem(1, 'dept_code', '%')
//idw_child.setitem(1, 'dept_name', '부서전체')
//
//dw_con.setitem(1, 'code', '%')
//
//dw_con.SetItem(1, 'acct_code', '%')
//
//ls_sysdate	=	f_today()
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
// 조회조건의 전표일자 확인
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

// 결의부서
dw_con.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(1, 3) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_child.insertrow(1)
idw_child.setitem(1, 'dept_code', '%')
idw_child.setitem(1, 'dept_name', '부서전체')

dw_con.setitem(1, 'code', '%')

dw_con.SetItem(1, 'acct_code', '%')

ls_sysdate	=	f_today()

dw_con.object.fr_date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string(ls_sysdate, '@@@@/@@/@@'))
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

type ln_templeft from w_msheet`ln_templeft within w_hfn312q
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn312q
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn312q
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn312q
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn312q
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn312q
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn312q
end type

type uc_insert from w_msheet`uc_insert within w_hfn312q
end type

type uc_delete from w_msheet`uc_delete within w_hfn312q
end type

type uc_save from w_msheet`uc_save within w_hfn312q
end type

type uc_excel from w_msheet`uc_excel within w_hfn312q
end type

type uc_print from w_msheet`uc_print within w_hfn312q
end type

type st_line1 from w_msheet`st_line1 within w_hfn312q
end type

type st_line2 from w_msheet`st_line2 within w_hfn312q
end type

type st_line3 from w_msheet`st_line3 within w_hfn312q
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn312q
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn312q
integer beginy = 356
integer endy = 356
end type

type dw_con from uo_dwfree within w_hfn312q
integer x = 50
integer y = 164
integer width = 4384
integer height = 192
integer taborder = 200
boolean bringtotop = true
string dataobject = "d_hfn312q_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)

This.GetChild('acct_code', idw_child)
idw_child.SetTransObject(SQLCA)
idw_child.Retrieve()
idw_child.InsertRow(1)
idw_child.SetItem(1,'com_code','%')
idw_child.SetItem(1,'com_name','계정전체')


end event

event itemchanged;call super::itemchanged;accepttext()	
Choose Case dwo.name
	Case 'dt_gu'
		
		parent.triggerevent('ue_retrieve')
End Choose
end event

type dw_list from uo_dwgrid within w_hfn312q
integer x = 50
integer y = 364
integer width = 4384
integer height = 1920
integer taborder = 60
string dataobject = "d_hfn312q_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)
//
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_print from cuo_dwprint within w_hfn312q
boolean visible = false
integer x = 50
integer y = 364
integer width = 4384
integer height = 1920
integer taborder = 80
string dataobject = "d_hfn312q_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type cb_2 from uo_imgbtn within w_hfn312q
boolean visible = false
integer x = 50
integer y = 36
integer taborder = 90
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

type cb_1 from uo_imgbtn within w_hfn312q
integer x = 50
integer y = 36
integer taborder = 100
boolean bringtotop = true
string btnname = "출력보기"
end type

event clicked;call super::clicked;
	cb_1.visible = false
	cb_2.visible = true
	dw_print.visible = true
//	wf_setMenu('PRINT',TRUE)

end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

