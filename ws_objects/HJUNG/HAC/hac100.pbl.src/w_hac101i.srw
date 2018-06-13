$PBExportHeader$w_hac101i.srw
$PBExportComments$캠퍼스 관리
forward
global type w_hac101i from w_tabsheet
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type st_1 from statictext within w_hac101i
end type
type dw_head from datawindow within w_hac101i
end type
type gb_1 from groupbox within w_hac101i
end type
end forward

global type w_hac101i from w_tabsheet
integer height = 2616
string title = "캠퍼스 관리"
st_1 st_1
dw_head dw_head
gb_1 gb_1
end type
global w_hac101i w_hac101i

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

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 캠퍼스명
dw_head.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

dw_head.reset()
dw_head.insertrow(0)
idw_child.scrolltorow(1)

end subroutine

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 :	retrieve
// 작 성 인 :	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

if isnull(is_campus_code) or trim(is_campus_code) = '' then	
	dw_head.setitem(1, 'code', idw_child.getitemstring(1, 'full_name'))
	
	is_campus_code = idw_child.getitemstring(1, 'code')
	idw_data.reset()
end if

idw_data.retrieve(is_campus_code)

return 0
end function

on w_hac101i.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_head=create dw_head
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_head
this.Control[iCurrent+3]=this.gb_1
end on

on w_hac101i.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_head)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;// ==========================================================================================
// 작성목정 : data retrieve
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================


wf_retrieve()
return 1
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



//idw_data.Selectrow(0, false)	

idw_data.reset()
li_newrow	= 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

select	nvl(max(campus_code) + 1, '1')
into		:ls_max_code
from		acdb.campus	;

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

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 : window open
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

// 화면 상단의 DataWindow 표현
idw_data		=	tab_sheet.tabpage_sheet01.dw_update

wf_getchild()

triggerevent('ue_retrieve')

end event

event ue_save;call super::ue_save;// ==========================================================================================
// 작성목정 : data save
// 작 성 인 : 이현수
// 작성일자 : 2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

cuo_dwwindow	dw_name
integer	li_findrow



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

IF dw_name.Update(true) = 1 THEN
	COMMIT;
	wf_getchild()
	triggerevent('ue_retrieve')
ELSE
  ROLLBACK;
END IF


return 1

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

type ln_templeft from w_tabsheet`ln_templeft within w_hac101i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hac101i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hac101i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hac101i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hac101i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hac101i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hac101i
end type

type uc_insert from w_tabsheet`uc_insert within w_hac101i
end type

type uc_delete from w_tabsheet`uc_delete within w_hac101i
end type

type uc_save from w_tabsheet`uc_save within w_hac101i
end type

type uc_excel from w_tabsheet`uc_excel within w_hac101i
end type

type uc_print from w_tabsheet`uc_print within w_hac101i
end type

type st_line1 from w_tabsheet`st_line1 within w_hac101i
end type

type st_line2 from w_tabsheet`st_line2 within w_hac101i
end type

type st_line3 from w_tabsheet`st_line3 within w_hac101i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hac101i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hac101i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hac101i
integer y = 224
integer width = 3881
integer height = 2244
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
end event

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer width = 3845
integer height = 2128
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
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
end type

type uo_tab from w_tabsheet`uo_tab within w_hac101i
end type

type dw_con from w_tabsheet`dw_con within w_hac101i
end type

type st_con from w_tabsheet`st_con within w_hac101i
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
integer y = 12
integer width = 3845
integer height = 2112
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hac101i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화

string	ls_juso

accepttext()

if dwo.name = 'zip' and len(trim(data)) = 6 then
	select	trim(fjuso)
	into		:ls_juso
	from		cddb.kch005m
	where		post	=	:data	;
	
	if sqlca.sqlcode <> 0 then return
	
	setitem(row, 'addr1', ls_juso)
	setitem(row, 'address',	ls_juso + ' ' + trim(getitemstring(row, 'addr2')))
elseif dwo.name = 'addr1' or dwo.name = 'addr2' then
	setitem(row, 'address',	trim(getitemstring(row, 'addr1')) + ' ' + trim(getitemstring(row, 'addr2')))
end if

idw_data.setitem(row, 'job_uid',		gstru_uid_uname.uid)
idw_data.setitem(row, 'job_add',		gstru_uid_uname.address)
idw_data.setitem(row, 'job_date',	f_sysdate())


end event

event retrieveend;call super::retrieveend;if rowcount < 1 then
	dw_head.setfocus()
else
	setfocus()
end if
end event

event losefocus;call super::losefocus;accepttext()
end event

event buttonclicked;call super::buttonclicked;integer	i
string	ls_addr
string	ls_data[]
Vector	lvc_data
accepttext()

if dwo.name = 'b_post' then
	
	lvc_data = Create Vector
	ls_addr = trim(getitemstring(row, 'addr1'))
	if isnull(ls_addr) then	
		ls_addr = ''
		lvc_data.SetProperty('parm_cnt', '0')
	Else
		lvc_data.SetProperty('parm_cnt', '1')
	End If
	
  lvc_data.SetProperty('parm_str01', ls_addr)
  
  If  OpenWithParm(w_post_pop, lvc_data) = 1 Then
   lvc_data = Message.PowerObjectParm
   If isvalid(lvc_data) Then
    This.Object.postno[row]  = lvc_data.GetProperty("parm_str01")
    This.Object.addr1[row]    = lvc_data.GetProperty("parm_str03")
	
		
	setitem(row, 'zip', 		lvc_data.GetProperty("parm_str01"))
	setitem(row, 'addr1',	lvc_data.GetProperty("parm_str03"))
	setitem(row, 'address',	lvc_data.GetProperty("parm_str03") + ' ' + getitemstring(row, 'addr2'))
	
	setcolumn('addr2')
End If
End If
	destroy lvc_data
end if
end event

type st_1 from statictext within w_hac101i
integer x = 133
integer y = 108
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "캠퍼스명"
boolean focusrectangle = false
end type

type dw_head from datawindow within w_hac101i
integer x = 439
integer y = 88
integer width = 1157
integer height = 104
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_campus"
boolean border = false
boolean livescroll = true
end type

event itemfocuschanged;triggerevent(itemchanged!)

end event

event itemchanged;if isnull(data) then	
	is_campus_code	= ''
	return
end if

is_campus_code = trim(data)

//parent.triggerevent('ue_retrieve')
//idw_data.retrieve(is_campus_code)

end event

type gb_1 from groupbox within w_hac101i
integer y = 20
integer width = 3881
integer height = 200
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회 조건"
end type

