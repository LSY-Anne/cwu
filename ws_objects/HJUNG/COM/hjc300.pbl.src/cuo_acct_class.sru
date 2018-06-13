$PBExportHeader$cuo_acct_class.sru
$PBExportComments$회계단위
forward
global type cuo_acct_class from userobject
end type
type st_codetile000 from statictext within cuo_acct_class
end type
type dw_commcode from datawindow within cuo_acct_class
end type
end forward

global type cuo_acct_class from userobject
integer width = 1125
integer height = 84
long backcolor = 31112622
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchanged pbm_custom01
st_codetile000 st_codetile000
dw_commcode dw_commcode
end type
global cuo_acct_class cuo_acct_class

forward prototypes
public function string uf_getfname ()
public function integer uf_getcode ()
public subroutine uf_enabled (boolean ab_enabled)
public function integer uf_settype (string as_type, string as_tile)
end prototypes

public function string uf_getfname ();//////////////////////////////////////////////////////////////////
// 	작성목적 : 데이타의 명칭을 조회한다 .
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

string  ls_fname = ''
integer li_err,li_row
DataWindowChild dwc
li_err = dw_commcode.Getchild('code',dwc)
IF li_err > -1 then
	dwc.settransobject(sqlca)
	li_row = dwc.Getrow()
	IF li_row  > 0 then
		ls_fname = dwc.GetItemString(li_row,'fname') //명칭
	end IF	
end IF	

return ls_fname
end function

public function integer uf_getcode ();integer li_code
//li_code = Integer(dw_commcode.tag)
li_code = integer(dw_commcode.getitemstring(1, 'code'))
return  li_code
end function

public subroutine uf_enabled (boolean ab_enabled);dw_commcode.enabled	=	ab_enabled
if ab_enabled then
	dw_commcode.object.code.background.color = rgb(255, 255, 255)
else
	dw_commcode.object.code.background.color = 78682240
end if	

end subroutine

public function integer uf_settype (string as_type, string as_tile);//////////////////////////////////////////////////////////////////
// 	작성목적 : 드롭다운 에이타 원도우의 type별 데이타를 조회한다.
//    적 성 인 : 이현수
//		작성일자 : 2002.10
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//    as_type  : kch001m의 타입 코드
//    as_tile  : text 의 명칭
//    return   : 조회한 행의수
//////////////////////////////////////////////////////////////////
datawindowchild	ldw_child

st_codetile000.text = as_tile

// 화면 상단의 DataWindow 표현
//f_getdwcommon(dw_commcode, as_type, 1, 750)

dw_commcode.reset()
dw_commcode.insertrow(0)

dw_commcode.object.code.width = 750

dw_commcode.getchild('code', ldw_child)
ldw_child.settransobject(sqlca)
if ldw_child.retrieve('acct_class', 0) < 1 then
	ldw_child.reset()
	ldw_child.insertrow(0)
	return	0
end if

//ldw_child.scrolltorow(1)
//dw_commcode.setitem(1, 'code', ldw_child.getitemstring(1, 'full_name'))
dw_commcode.setitem(1, 'code', '1')

return	ldw_child.getitemnumber(1, 'code')


//dw_commcode.reset()
//dw_commcode.Getchild('code',dwc)
//dwc.settransobject(sqlca)
//li_cnt  = dwc.retrieve(as_type) 
//if li_cnt  < 1 then 
//	dwc.insertrow(0)
//end If
//dw_commcode.Insertrow(0)
//
//return  li_cnt 
end function

on cuo_acct_class.create
this.st_codetile000=create st_codetile000
this.dw_commcode=create dw_commcode
this.Control[]={this.st_codetile000,&
this.dw_commcode}
end on

on cuo_acct_class.destroy
destroy(this.st_codetile000)
destroy(this.dw_commcode)
end on

event constructor;dw_commcode.tag = string(uf_setType('acct_class', '회계단위'))
dw_commcode.SetTransObject(sqlca)



end event

type st_codetile000 from statictext within cuo_acct_class
integer x = 5
integer y = 16
integer width = 256
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "회계단위"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_commcode from datawindow within cuo_acct_class
integer x = 261
integer width = 686
integer height = 80
integer taborder = 10
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//ItemChange 가 된 부분을 tag에 데이타를 변경한다.
this.tag           =  data //Item이 변경된 데이타.
Parent.Triggerevent('ue_itemChanged')
end event

