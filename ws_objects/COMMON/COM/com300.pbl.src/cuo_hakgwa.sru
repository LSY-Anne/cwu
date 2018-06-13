$PBExportHeader$cuo_hakgwa.sru
$PBExportComments$학과 DropDownDataWindow
forward
global type cuo_hakgwa from userobject
end type
type st_1 from statictext within cuo_hakgwa
end type
type dw_daehak from datawindow within cuo_hakgwa
end type
end forward

global type cuo_hakgwa from userobject
integer width = 1125
integer height = 108
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_itemchanged pbm_custom01
st_1 st_1
dw_daehak dw_daehak
end type
global cuo_hakgwa cuo_hakgwa

type variables

end variables

forward prototypes
public function string uf_fname ()
public function integer uf_enable (boolean ab_falg)
public function string uf_getgwa ()
public function integer uf_setgwa (string as_gwa)
end prototypes

public function string uf_fname ();String s_fname
int    i_row 
DataWindowChild sdw_dwname  //임시 데이타 원도우
dw_daehak.Getchild('gwa', sdw_dwname)
sdw_dwname.settransobject(sqlca)
i_row     = sdw_dwname.getrow()
s_fname   = sdw_dwname.GetItemString(i_row,'fname')

return s_fname
end function

public function integer uf_enable (boolean ab_falg);dw_daehak.enabled = ab_falg

if ab_falg then
	dw_daehak.object.gwa.background.color = rgb(255, 255, 255)
else
	dw_daehak.object.gwa.background.color = 78682240
end if	

return 1
end function

public function string uf_getgwa ();return dw_daehak.tag
end function

public function integer uf_setgwa (string as_gwa);//현재의 학과로 치환한다.
int i_err
i_err  = dw_daehak.setitem(1,'gwa',as_gwa)
dw_daehak.tag = as_gwa
return i_err
end function

event constructor;dw_daehak.SetTransObject(sqlca)
dw_daehak.insertrow(0)

dw_daehak.Setitem(1,'gwa','5201')
dw_daehak.tag = '5201'
end event

on cuo_hakgwa.create
this.st_1=create st_1
this.dw_daehak=create dw_daehak
this.Control[]={this.st_1,&
this.dw_daehak}
end on

on cuo_hakgwa.destroy
destroy(this.st_1)
destroy(this.dw_daehak)
end on

type st_1 from statictext within cuo_hakgwa
integer x = 32
integer y = 20
integer width = 178
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 80269524
string text = "학 과"
boolean focusrectangle = false
end type

type dw_daehak from datawindow within cuo_hakgwa
event itemchanged pbm_dwnitemchange
integer x = 224
integer y = 8
integer width = 809
integer height = 88
integer taborder = 1
string dataobject = "dw_hakgwa_dddw"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//현재 학과
this.tag = data
parent.triggerevent("ue_itemchanged")
end event

