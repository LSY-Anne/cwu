$PBExportHeader$cuo_bdgt_class.sru
$PBExportComments$예산차수
forward
global type cuo_bdgt_class from userobject
end type
type st_codetile000 from statictext within cuo_bdgt_class
end type
type dw_commcode from datawindow within cuo_bdgt_class
end type
end forward

global type cuo_bdgt_class from userobject
integer width = 1403
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchanged pbm_custom01
st_codetile000 st_codetile000
dw_commcode dw_commcode
end type
global cuo_bdgt_class cuo_bdgt_class

type variables

end variables

forward prototypes
public function integer uf_getcode ()
public function string uf_getfname ()
public function integer uf_settype (string as_type, string as_tile)
end prototypes

public function integer uf_getcode ();integer li_code
li_code = Integer(dw_commcode.tag)
return  li_code
end function

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

//dw_commcode.object.code.width = 750
dw_commcode.object.code.dddw.PercentWidth = 100

dw_commcode.getchild('code', ldw_child)
ldw_child.settransobject(sqlca)
if ldw_child.retrieve('bdgt_class', 1) < 1 then
	ldw_child.reset()
	ldw_child.insertrow(0)
	return	0
end if

ldw_child.scrolltorow(1)
dw_commcode.setitem(1, 'code', ldw_child.getitemstring(1, 'full_name'))

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

on cuo_bdgt_class.create
this.st_codetile000=create st_codetile000
this.dw_commcode=create dw_commcode
this.Control[]={this.st_codetile000,&
this.dw_commcode}
end on

on cuo_bdgt_class.destroy
destroy(this.st_codetile000)
destroy(this.dw_commcode)
end on

event constructor;dw_commcode.tag = string(uf_setType('acct_class', '예산차수'))
dw_commcode.SetTransObject(sqlca)



end event

type st_codetile000 from statictext within cuo_bdgt_class
integer y = 20
integer width = 334
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 80269524
string text = "예산차수"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_commcode from datawindow within cuo_bdgt_class
integer x = 379
integer y = 4
integer width = 974
integer height = 88
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

