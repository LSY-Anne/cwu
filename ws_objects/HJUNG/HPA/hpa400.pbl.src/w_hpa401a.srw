$PBExportHeader$w_hpa401a.srw
$PBExportComments$연말정산 기초자료 등록 일자관리
forward
global type w_hpa401a from w_msheet
end type
type dw_con from uo_dwfree within w_hpa401a
end type
type dw_update from uo_dwgrid within w_hpa401a
end type
end forward

global type w_hpa401a from w_msheet
dw_con dw_con
dw_update dw_update
end type
global w_hpa401a w_hpa401a

type variables
//integer ib_RowSelect, ib_RowSingle, ib_SortGubn, ib_EnterChk 
end variables

on w_hpa401a.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_update=create dw_update
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_update
end on

on w_hpa401a.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_update)
end on

event ue_open;call super::ue_open;//wf_setMenu('INSERT',		TRUE)
//wf_setMenu('DELETE',		TRUE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		TRUE)
//wf_setMenu('PRINT',		fALSE)
//
//
//String	ls_SalYear, ls_from_date, ls_to_date
//long     ll_row
//uo_year.st_title.text = '연말정산년도'
//ls_SalYear = uo_year.em_year.text
//
//if dw_update.retrieve(ls_salyear) = 0 then
//	
//	ls_from_date = ls_salyear +'1210'
//	ls_to_date   = ls_salyear +'1230'
//	
//	ll_row = dw_update.insertrow(0)
//	dw_update.setitem(ll_row,'year',ls_salyear)
//	dw_update.setitem(ll_row,'from_date',ls_from_date)
//	dw_update.setitem(ll_row,'to_date',ls_to_date)
//	
//	
//end if
end event

event ue_save;call super::ue_save;SetPointer(HourGlass!)

wf_SetMsg('변경된 자료를 저장 중 입니다...')

if dw_update.update() <> 1 then
	messagebox('','UPDATE시 ERROR 발생')
	return -1
end if


wf_SetMsg('자료가 저장되었습니다.')

end event

event ue_retrieve;call super::ue_retrieve;String	ls_SalYear, ls_from_date, ls_to_date
long     ll_row

dw_con.accepttext()
ls_SalYear = String(dw_con.object.year[1], 'yyyy')

IF ls_SalYear = '' OR ISNULL(ls_SalYear) OR ls_SalYear = '0000' THEN ls_SalYear = '%'

if dw_update.retrieve(ls_salyear) = 0 then
	
	messagebox('','조회된로우가 없습니다.')
	dw_con.setfocus()
	dw_con.setcolumn('year')
	
end if

IF ll_Row = 0 THEN 
//   wf_setMenu('INSERT',		TRUE)
//	wf_setMenu('RETRIEVE',	TRUE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//   wf_setMenu('INSERT',		TRUE)
//   wf_setMenu('DELETE',		TRUE)
//   wf_setMenu('RETRIEVE',	TRUE)
//   wf_setMenu('UPDATE',		TRUE)
   wf_SetMsg('자료가 조회되었습니다.')
END IF

return 1
end event

event ue_insert;call super::ue_insert;String	ls_SalYear, ls_from_date, ls_to_date
long     ll_row

dw_con.accepttext()

ls_SalYear = String(dw_con.object.year[1], 'yyyy')
ls_from_date = ls_salyear +'12'
ls_to_date   = ls_salyear +'12'
dw_update.reset()
ll_row = dw_update.insertrow(1)
dw_update.setitem(ll_row,'year',ls_salyear)
dw_update.setitem(ll_row,'from_date',ls_from_date)
dw_update.setitem(ll_row,'to_date',ls_to_date)
	
	

end event

event ue_delete;call super::ue_delete;//wf_setMenu('INSERT',		TRUE)
//wf_setMenu('DELETE',		TRUE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		TRUE)
//wf_setMenu('PRINT',		fALSE)
//

String	ls_SalYear, ls_from_date, ls_to_date
long     ll_row

dw_con.accepttext()

ls_SalYear = string(dw_con.object.year[1], 'yyyy')

dw_update.deleterow(1)
	

end event

event ue_postopen;call super::ue_postopen;//wf_setMenu('INSERT',		TRUE)
//wf_setMenu('DELETE',		TRUE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		TRUE)
//wf_setMenu('PRINT',		fALSE)
//

String	ls_SalYear, ls_from_date, ls_to_date
long     ll_row

ls_SalYear =  left(f_today(), 4)
dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))

if dw_update.retrieve(ls_salyear) = 0 then
	
	ls_from_date = ls_salyear +'1210'
	ls_to_date   = ls_salyear +'1230'
	
	ll_row = dw_update.insertrow(0)
	dw_update.setitem(ll_row,'year',ls_salyear)
	dw_update.setitem(ll_row,'from_date',ls_from_date)
	dw_update.setitem(ll_row,'to_date',ls_to_date)
	
	
end if
end event

type ln_templeft from w_msheet`ln_templeft within w_hpa401a
end type

type ln_tempright from w_msheet`ln_tempright within w_hpa401a
end type

type ln_temptop from w_msheet`ln_temptop within w_hpa401a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hpa401a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hpa401a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hpa401a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hpa401a
end type

type uc_insert from w_msheet`uc_insert within w_hpa401a
end type

type uc_delete from w_msheet`uc_delete within w_hpa401a
end type

type uc_save from w_msheet`uc_save within w_hpa401a
end type

type uc_excel from w_msheet`uc_excel within w_hpa401a
end type

type uc_print from w_msheet`uc_print within w_hpa401a
end type

type st_line1 from w_msheet`st_line1 within w_hpa401a
end type

type st_line2 from w_msheet`st_line2 within w_hpa401a
end type

type st_line3 from w_msheet`st_line3 within w_hpa401a
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hpa401a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hpa401a
end type

type dw_con from uo_dwfree within w_hpa401a
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hpa325p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)

This.object.year_t.text = '연말정산년도'
This.object.t_1.visible = false
end event

type dw_update from uo_dwgrid within w_hpa401a
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hpa401a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

