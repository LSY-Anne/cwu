$PBExportHeader$cuo_campus.sru
$PBExportComments$캠퍼스를 구한다.('%' OR 사용자ID)
forward
global type cuo_campus from userobject
end type
type st_title from statictext within cuo_campus
end type
type dw_code from datawindow within cuo_campus
end type
end forward

global type cuo_campus from userobject
integer width = 1280
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchanged pbm_custom01
st_title st_title
dw_code dw_code
end type
global cuo_campus cuo_campus

forward prototypes
public function string uf_getfname ()
public function integer uf_setcampus ()
public function string uf_getcode ()
end prototypes

public function string uf_getfname ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_getfname
// Function 설명	:	명칭을 가져온다.
// Argument			:
// Return			:	string(명칭)
// ------------------------------------------------------------------------------------------

string	ls_fname = ''
integer	li_row

li_row = dw_code.getrow()

ls_fname = dw_code.getitemstring(li_row, 'name')

if isnull(ls_fname) then ls_fname = ''

return	ls_fname	
end function

public function integer uf_setcampus ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_setcampus
// Function 설명	:	전체 캠퍼스를 구한다.
// Argument			:	
// Return			:	integer(조회한 행의 수)
// ------------------------------------------------------------------------------------------

integer	li_cnt = 0
datawindowchild	ldw_child
string	ls_data

dw_code.Getchild('code', ldw_child)
ldw_child.settransobject(sqlca)
li_cnt  = ldw_child.retrieve() 

if li_cnt  < 1 then 
	ldw_child.reset()
	ldw_child.insertrow(0)
end If

dw_code.reset()
dw_code.Insertrow(0)

return  li_cnt 
end function

public function string uf_getcode ();// ------------------------------------------------------------------------------------------
// Function Name	:	uf_getcode
// Function 설명	:	조직코드를 가져온다.
// Argument			:
// Return			:	string(조직코드)
// ------------------------------------------------------------------------------------------

string	ls_code

ls_code = dw_code.tag

return  ls_code
end function

on cuo_campus.create
this.st_title=create st_title
this.dw_code=create dw_code
this.Control[]={this.st_title,&
this.dw_code}
end on

on cuo_campus.destroy
destroy(this.st_title)
destroy(this.dw_code)
end on

event constructor;dw_code.SetTransObject(sqlca)
this.uf_setcampus()
end event

type st_title from statictext within cuo_campus
integer x = 18
integer y = 24
integer width = 293
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
string text = "캠퍼스"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_code from datawindow within cuo_campus
integer x = 325
integer y = 4
integer width = 965
integer height = 92
integer taborder = 10
string title = "none"
string dataobject = "ddw_campus"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//ItemChange 가 된 부분을 tag에 데이타를 변경한다.
this.tag	=	data //Item이 변경된 데이타.

Parent.Triggerevent('ue_itemChanged')

end event

