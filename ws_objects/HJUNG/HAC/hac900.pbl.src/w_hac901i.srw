$PBExportHeader$w_hac901i.srw
$PBExportComments$DM관리
forward
global type w_hac901i from w_msheet
end type
type cb_1 from commandbutton within w_hac901i
end type
type dw_con from uo_dwfree within w_hac901i
end type
type dw_sheet from uo_dwgrid within w_hac901i
end type
end forward

global type w_hac901i from w_msheet
cb_1 cb_1
dw_con dw_con
dw_sheet dw_sheet
end type
global w_hac901i w_hac901i

type variables
string is_cnt

end variables

on w_hac901i.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_con=create dw_con
this.dw_sheet=create dw_sheet
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_sheet
end on

on w_hac901i.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_con)
destroy(this.dw_sheet)
end on

event ue_insert;call super::ue_insert;long		ll_row

if isnull(is_cnt) then
	is_cnt = '0'
else
	is_cnt = string(long(is_cnt) + 1)
end if

ll_row = dw_sheet.getrow()
ll_row = dw_sheet.insertrow(ll_row + 1)

dw_sheet.scrolltorow(ll_row)
dw_sheet.setrow(ll_row)
dw_sheet.setitem(ll_row, 'pno' , 		is_cnt)
dw_sheet.setitem(ll_row, 'worker' , 	gs_empcode)
dw_sheet.setitem(ll_row, 'ipaddr' , 	gs_ip)
dw_sheet.setitem(ll_row, 'work_date' , f_sysdate())

end event

event ue_open;call super::ue_open;//string ls_emp
//
//dw_head.SetTransObject(sqlca)
//dw_sheet.SetTransObject(sqlca)
//dw_head.InsertRow(0)
//
//dw_head.setcolumn('zip')
//
//// is_cnt 입력시 자동체번
//select	max(to_number(a.pno))
//into		:is_cnt
//from		acdb.hac901h a	;
//
//wf_setMenu('INSERT',		TRUE)
//wf_setMenu('DELETE',		TRUE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		TRUE)
//wf_setMenu('PRINT',		TRUE)
//
end event

event ue_retrieve;call super::ue_retrieve;string   ls_zip, ls_section, ls_name




dw_con.AcceptText()

ls_zip     = trim(string(dw_con.Object.zip[1], '' )) + '%'
ls_section = trim(string(dw_con.Object.dm_section[1], '')) + '%'
ls_name    = trim(string(dw_con.Object.reci_name[1], '' )) +  '%'

dw_sheet.Retrieve(ls_zip,  ls_section, ls_name) 

return  1

end event

event ue_save;call super::ue_save;datetime ld_update, ld_start, ld_end
string   ls_prog, ls_reci_name,  ls_zip, ls_dm_section
long     i, modcount, rtn, ll_modrow 

dw_sheet.accepttext()

modcount  = dw_sheet.ModifiedCount() + dw_sheet.deletedcount()

if modcount < 1 then
	wf_setmsg('변경된 자료가 없습니다.')
	return -1
end if

modcount = dw_sheet.ModifiedCount()

FOR i = 1 to modcount
	 ll_modrow = dw_sheet.GetNextModified(ll_modrow,primary!)	
	 IF ll_modrow = 0 THEN EXIT  

	 ls_reci_name = String(dw_sheet.Object.reci_name[ll_modrow])
	 IF Trim(ls_reci_name) = ""  OR IsNull(ls_reci_name) THEN
		 MessageBox("확인", "소속입력은 필수입력항목입니다...")
		 dw_sheet.SetColumn('reci_name')
		 dw_sheet.SetFocus()
		 RETURN -1
	 END IF		
	
	 ls_zip = String(dw_sheet.Object.zip[ll_modrow])
	 IF Trim(ls_zip) = ""  OR IsNull(ls_zip) THEN
		 MessageBox("확인", "소속입력은 필수입력항목입니다...")
		 dw_sheet.SetColumn('zip')
		 dw_sheet.SetFocus()
		 RETURN  -1
	 END IF	
	
	 ls_dm_section = String(dw_sheet.Object.dm_section[ll_modrow])
	 IF Trim(ls_dm_section) = ""  OR IsNull(ls_dm_section) THEN
		 MessageBox("확인", "소속입력은 필수입력항목입니다...")
		 dw_sheet.SetColumn('dm_section')
		 dw_sheet.SetFocus()
		 RETURN -1
	 END IF
NEXT

IF dw_sheet.Update(true) = 1 THEN
	COMMIT;
	triggerevent('ue_retrieve')
ELSE
  ROLLBACK;
END IF

// is_cnt 입력시 자동체번
select	max(to_number(pno))
into		:is_cnt
from		acdb.hac901h	;

end event

event ue_delete;call super::ue_delete;integer	li_deleterow



wf_setMsg('삭제중')

li_deleterow	=	dw_sheet.deleterow(0)

wf_setMsg('삭제되었습니다. 저장작업으로 완료하시기 바랍니다.')



end event

event ue_print;call super::ue_print;//IF dw_sheet.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, dw_sheet)
//
end event

event ue_postopen;call super::ue_postopen;string ls_emp





// is_cnt 입력시 자동체번
select	max(to_number(a.pno))
into		:is_cnt
from		acdb.hac901h a	;

//wf_setMenu('INSERT',		TRUE)
//wf_setMenu('DELETE',		TRUE)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		TRUE)
//wf_setMenu('PRINT',		TRUE)
idw_print = dw_sheet

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

type ln_templeft from w_msheet`ln_templeft within w_hac901i
end type

type ln_tempright from w_msheet`ln_tempright within w_hac901i
end type

type ln_temptop from w_msheet`ln_temptop within w_hac901i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hac901i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hac901i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hac901i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hac901i
end type

type uc_insert from w_msheet`uc_insert within w_hac901i
end type

type uc_delete from w_msheet`uc_delete within w_hac901i
end type

type uc_save from w_msheet`uc_save within w_hac901i
end type

type uc_excel from w_msheet`uc_excel within w_hac901i
end type

type uc_print from w_msheet`uc_print within w_hac901i
end type

type st_line1 from w_msheet`st_line1 within w_hac901i
end type

type st_line2 from w_msheet`st_line2 within w_hac901i
end type

type st_line3 from w_msheet`st_line3 within w_hac901i
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hac901i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hac901i
end type

type cb_1 from commandbutton within w_hac901i
integer x = 1810
integer y = 20
integer width = 457
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Excel"
end type

event clicked;OleObject myOleObject 

int 		i_Result, li_ans, li_file
string	ls_FileName, ls_path_file
long 		ll_row_count, ll_row

ll_row_count = dw_sheet.RowCount()

if ll_row_count > 0 then
	myOleObject = Create OleObject 
	
	i_Result = myOleObject.ConnectToNewObject( "excel.application" )
	
	If i_Result <> 0 Then
		Messagebox("!", "실패")
		Destroy myoleobject
		Return
	End If
		
	li_ans = GetFileSaveName ("저장할 파일선택", ls_path_file, ls_FileName, "xls", "Excel Files (*.xls), *.xls")
	
	if li_ans <> 1 then
		Messagebox("확인", "화일이 잘못 되었어요!", Information!, Ok!)
		return
	end if
	
	dw_sheet.SaveAsAscii(ls_path_file + ".txt" )
	myOleObject.WorkBooks.Open(ls_path_file + ".txt")
	
	// -4143은 엑셀 통합문서 Format입니다.
	myOleObject.Application.workbooks(1).saveas(ls_path_file, -4143)	// + ".xls", -4143)
	myOleObject.Application.Quit
	myoleobject.DisConnectObject()
	Destroy myoleobject
	
	messagebox("알림", "Excel File로 저장되었습니다. 경로는 " + ls_path_file + ".xls 입니다")
else
	messagebox("알림", "저장할 자료가 없습니다.")
end if

end event

event constructor;if gs_empcode = 'F0092' then
	this.visible = true
else
	this.visible = false
end if

end event

type dw_con from uo_dwfree within w_hac901i
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_hac901i_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_con(dw_con)
This.settransobject(sqlca)
This.insertrow(0)
this.setcolumn('zip')
end event

event itemchanged;call super::itemchanged;parent.triggerEvent("ue_retrieve")
end event

event itemfocuschanged;call super::itemfocuschanged;// 한영변환
CHOOSE CASE	dwo.name
	CASE 'reci_name'
		f_pro_toggle('K', handle(parent))
	CASE ELSE
		f_pro_toggle('E', handle(parent))
END CHOOSE

end event

type dw_sheet from uo_dwgrid within w_hac901i
integer x = 50
integer y = 292
integer width = 4384
integer height = 1976
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hac901i"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event doubleclicked;call super::doubleclicked;string	ls_addr

if row < 1 then return

if dwo.name = 'zip' then
	open(w_zipcode)
	
	ls_addr	=	message.stringparm
	
	if isnull(ls_addr) or trim(ls_addr) = '' then return

	ls_addr = trim(ls_addr)
	
	setitem(row, 'zip', 		left(ls_addr,6))
	setitem(row, 'addr',		mid(ls_addr,7))
	
	setcolumn('addr1')
end if

end event

event itemfocuschanged;call super::itemfocuschanged;// 한영변환
CHOOSE CASE	dwo.name
	CASE 'rmk','posit','reci_name','schl_name','addr1'
		f_pro_toggle('K', handle(parent))
	CASE ELSE
		f_pro_toggle('E', handle(parent))
END CHOOSE

end event

