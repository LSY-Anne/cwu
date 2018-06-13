$PBExportHeader$cuo_dept.sru
$PBExportComments$행정부서/학과 조회
forward
global type cuo_dept from userobject
end type
type dw_dept from datawindow within cuo_dept
end type
type st_title from statictext within cuo_dept
end type
end forward

global type cuo_dept from userobject
integer width = 1157
integer height = 100
boolean border = true
long backcolor = 31112622
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchange pbm_custom01
dw_dept dw_dept
st_title st_title
end type
global cuo_dept cuo_dept

type variables

end variables

forward prototypes
public function string uf_getcode ()
public function string uf_getfname ()
public function integer uf_setdept (string as_gwa_gubun, string as_title)
public subroutine uf_enabled_check (boolean ab_check)
end prototypes

public function string uf_getcode ();return	dw_dept.tag

end function

public function string uf_getfname ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_getfname
// Function 설명	:	행정부서/학과 명칭을 가져온다.
// Argument			:
// Return			:	string(명칭)
// ------------------------------------------------------------------------------------------

string	ls_fname = ''
integer	li_row

li_row = dw_dept.getrow()

if li_row < 1 then	return	ls_fname

ls_fname = dw_dept.getitemstring(li_row, 'code_name')

if isnull(ls_fname) then ls_fname = ''

return	ls_fname	

end function

public function integer uf_setdept (string as_gwa_gubun, string as_title);// ------------------------------------------------------------------------------------------
// Function Name	:	uf_setdept
// Function 설명	:	과구분에 의해 행정부서 또는 학과를 보여준다.
// Argument			:	as_gwa_gubun(string)	:	과구분(%:전체 9:행정부서 1:학과)
//							as_title(string)		:	타이틀
// Return			:	integer(조회한 행의 수)
// ------------------------------------------------------------------------------------------

integer	li_cnt = 0
datawindowchild	ldw_child
string	ls_data

st_title.text = as_title

dw_dept.Getchild('code', ldw_child)
ldw_child.settransobject(sqlca)
li_cnt  = ldw_child.retrieve(as_gwa_gubun) 

if li_cnt  < 1 then 
	ldw_child.reset()
	ldw_child.insertrow(0)
else
	ldw_child.insertrow(1)
	ldw_child.setitem(1, 'gwa', '%')
	ldw_child.setitem(1, 'fname', '전체')
end If

dw_dept.reset()
dw_dept.Insertrow(0)

return  li_cnt
end function

public subroutine uf_enabled_check (boolean ab_check);// ------------------------------------------------------------------------------------------
// Function Name	:	uf_enabled_check
// Function 설명	:	Datawindow Enabled Check
// Argument			:	ab_check(Boolean)
// Return			:
// ------------------------------------------------------------------------------------------

dw_dept.enabled	=	ab_check
if ab_check then
	dw_dept.object.code.background.color = rgb(255, 255, 255)
else
	dw_dept.object.code.background.color = 78682240
end if

end subroutine

on cuo_dept.create
this.dw_dept=create dw_dept
this.st_title=create st_title
this.Control[]={this.dw_dept,&
this.st_title}
end on

on cuo_dept.destroy
destroy(this.dw_dept)
destroy(this.st_title)
end on

event constructor;dw_dept.SetTransObject(sqlca)
dw_dept.tag = '%'
end event

type dw_dept from datawindow within cuo_dept
integer x = 238
integer width = 896
integer height = 84
integer taborder = 20
string title = "none"
string dataobject = "ddw_dept_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//ItemChange 가 된 부분을 tag에 데이타를 변경한다.
this.tag	=	data //Item이 변경된 데이타.

Parent.Triggerevent('ue_itemChange')

end event

type st_title from statictext within cuo_dept
integer x = 9
integer y = 12
integer width = 206
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
boolean enabled = false
string text = "학과명"
alignment alignment = center!
boolean focusrectangle = false
end type

