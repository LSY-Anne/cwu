$PBExportHeader$w_kch104i.srw
$PBExportComments$캠퍼스 관리
forward
global type w_kch104i from w_tabsheet
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
end forward

global type w_kch104i from w_tabsheet
integer height = 2616
string title = "캠퍼스 관리"
end type
global w_kch104i w_kch104i

type variables
datawindowchild	idw_child
datawindow			idw_data

statictext			ist_back

string	is_campus_code = ''
end variables
forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_getchild ();
end subroutine

public function integer wf_retrieve ();Return 1
end function

on w_kch104i.create
int iCurrent
call super::create
end on

on w_kch104i.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;String ls_code

dw_con.AcceptText()

idw_data.Reset()

ls_code = dw_con.Object.code[1]

If ls_code = '' Or Isnull(ls_code) Then
	Messagebox("확인", "캠퍼스명을 선택하세요!")
	dw_con.SetFocus()
	dw_con.SetColumn("code")
	Return -1
End If

idw_data.Retrieve(ls_code)

Return 1
end event

event ue_insert;call super::ue_insert;// ==========================================================================================
// 작성목정 : data insert
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

integer	li_newrow
string	ls_max_code

idw_data.reset()
li_newrow	= 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

select	nvl(max(campus_code) + 1, '1')
into		:ls_max_code
from		cddb.kch000m
using sqlca;

idw_data.setitem(li_newrow, 'campus_code', ls_max_code)
idw_data.setitem(li_newrow, 'zip',			'')
idw_data.setitem(li_newrow, 'addr1',		'')
idw_data.setitem(li_newrow, 'addr2',		'')
idw_data.setitem(li_newrow, 'address',		'')
idw_data.setitem(li_newrow, 'worker',		gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setcolumn('campus_code')
idw_data.setfocus()



end event

event ue_delete;call super::ue_delete;// ==========================================================================================
// 작성목정 : data delete
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

integer		li_deleterow

wf_setMsg('삭제중')

li_deleterow	=	idw_data.deleterow(0)

wf_setMsg('.')
return 

end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 : window open
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================



// 화면 상단의 DataWindow 표현
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_update[1] =	tab_sheet.tabpage_sheet01.dw_update

idw_data	.insertrow(0)
func.of_design_dw(idw_data)





end event

type ln_templeft from w_tabsheet`ln_templeft within w_kch104i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_kch104i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_kch104i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_kch104i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_kch104i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_kch104i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_kch104i
end type

type uc_insert from w_tabsheet`uc_insert within w_kch104i
end type

type uc_delete from w_tabsheet`uc_delete within w_kch104i
end type

type uc_save from w_tabsheet`uc_save within w_kch104i
end type

type uc_excel from w_tabsheet`uc_excel within w_kch104i
end type

type uc_print from w_tabsheet`uc_print within w_kch104i
end type

type st_line1 from w_tabsheet`st_line1 within w_kch104i
end type

type st_line2 from w_tabsheet`st_line2 within w_kch104i
end type

type st_line3 from w_tabsheet`st_line3 within w_kch104i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_kch104i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_kch104i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_kch104i
integer y = 348
integer width = 4370
integer height = 1912
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4334
integer height = 1792
string text = "캠퍼스관리"
dw_update dw_update
end type

on tabpage_sheet01.create
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 1184
integer width = 549
integer height = 608
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
boolean visible = false
integer width = 270
integer height = 212
end type

type uo_tab from w_tabsheet`uo_tab within w_kch104i
end type

type dw_con from w_tabsheet`dw_con within w_kch104i
string dataobject = "d_kch104i_c1"
end type

event dw_con::constructor;dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)
end event

type st_con from w_tabsheet`st_con within w_kch104i
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
integer y = 16
integer width = 4325
integer height = 1772
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_kch104i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event buttonclicked;call super::buttonclicked;string	ls_addr

if dwo.name = 'b_post' then
	open(w_zipcode)
	
	ls_addr	=	message.stringparm
	
	if isnull(ls_addr) or trim(ls_addr) = '' then return
	ls_addr = trim(ls_addr)
	
	setitem(row, 'zip', 		left(ls_addr,6))
	setitem(row, 'addr1',	mid(ls_addr,7))
	setitem(row, 'address',	mid(ls_addr,7) + ' ' + getitemstring(row, 'addr2'))
	
	setcolumn('addr2')
end if
end event

event itemchanged;call super::itemchanged;String  ls_addr1, ls_addr

Choose case dwo.name
	case 'addr2'

		ls_addr1 = This.Object.addr1[row]
		
		ls_addr = ls_addr1 + ' ' + data
		
		This.setitem(row, "address", ls_addr )
End Choose
end event

