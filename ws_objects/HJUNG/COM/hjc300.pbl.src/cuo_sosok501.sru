$PBExportHeader$cuo_sosok501.sru
$PBExportComments$전체 또는 로긴사용자의 조직을 구한다.('%' OR 사용자ID)
forward
global type cuo_sosok501 from userobject
end type
type st_codetile000 from statictext within cuo_sosok501
end type
type dw_dept from datawindow within cuo_sosok501
end type
end forward

global type cuo_sosok501 from userobject
integer width = 1714
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchanged pbm_custom01
st_codetile000 st_codetile000
dw_dept dw_dept
end type
global cuo_sosok501 cuo_sosok501

forward prototypes
public function string uf_getfname ()
public function string uf_getcode ()
public function integer uf_setid (string as_id)
end prototypes

public function string uf_getfname ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_getfname
// Function 설명	:	조직명칭을 가져온다.
// Argument			:
// Return			:	string(조직명칭)
// ------------------------------------------------------------------------------------------

string	ls_fname = ''
integer	li_row

li_row = dw_dept.getrow()

ls_fname = dw_dept.getitemstring(li_row, 'code_name')

if isnull(ls_fname) then ls_fname = ''

return	ls_fname	

//string	ls_fname = ''
//integer	li_err, li_row
//
//DataWindowChild	ldw_child
//
//li_err = dw_dept.Getchild('dept_code', ldw_child)
//
//IF li_err > -1 then
//	ldw_child.settransobject(sqlca)
//	li_row = ldw_child.Getrow()
//	IF li_row  > 0 then
//		ls_fname = ldw_child.GetItemString(li_row, 'dept_name')
//	end IF	
//end IF	
//
//return	ls_fname
end function

public function string uf_getcode ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_getcode
// Function 설명	:	조직코드를 가져온다.
// Argument			:
// Return			:	string(조직코드)
// ------------------------------------------------------------------------------------------

string	ls_code

ls_code = dw_dept.tag

return  ls_code
end function

public function integer uf_setid (string as_id);// ------------------------------------------------------------------------------------------
// Function Name	:	uf_setid
// Function 설명	:	전체조직 또는 로긴한 사용자의 조직코드와 명칭을 구한다.
// Argument			:	as_id(string) = 구분(%:전체, gstru_uid_uname.uid:로긴한 부서)
// Return			:	integer(조회한 행의 수)
// ------------------------------------------------------------------------------------------

integer	li_cnt = 0
datawindowchild	ldw_child
string	ls_data

choose case as_id
	case	'%'
		st_codetile000.text = '전체조직'
		
		dw_dept.dataobject = 'ddw_sosok501'
		dw_dept.Getchild('code', ldw_child)

		ldw_child.settransobject(sqlca)
		li_cnt  = ldw_child.retrieve() 
		
		dw_dept.modify("code.background.color = rgb(255, 255, 255)")
		dw_dept.enabled = true
	case else
		st_codetile000.text = '조직코드'

		dw_dept.dataobject = 'ddw_sosok501_login'
		dw_dept.Getchild('code', ldw_child)

		ldw_child.settransobject(sqlca)
		li_cnt  = ldw_child.retrieve(as_id)
		dw_dept.modify("code.background.color = 78682240")
		dw_dept.enabled = false
end choose

if li_cnt  < 1 then 
	ldw_child.reset()
	ldw_child.insertrow(0)
end If

dw_dept.reset()
dw_dept.Insertrow(0)

return  li_cnt 
end function

on cuo_sosok501.create
this.st_codetile000=create st_codetile000
this.dw_dept=create dw_dept
this.Control[]={this.st_codetile000,&
this.dw_dept}
end on

on cuo_sosok501.destroy
destroy(this.st_codetile000)
destroy(this.dw_dept)
end on

event constructor;dw_dept.SetTransObject(sqlca)
//this.uf_setType('')
end event

type st_codetile000 from statictext within cuo_sosok501
integer y = 24
integer width = 375
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 80269524
string text = "조직코드"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_dept from datawindow within cuo_sosok501
integer x = 434
integer y = 4
integer width = 1257
integer height = 92
integer taborder = 10
string title = "none"
string dataobject = "ddw_sosok501"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//ItemChange 가 된 부분을 tag에 데이타를 변경한다.
this.tag	=	data //Item이 변경된 데이타.

Parent.Triggerevent('ue_itemChanged')

end event

