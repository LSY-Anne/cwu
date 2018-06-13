$PBExportHeader$w_post.srw
$PBExportComments$우편번호를 조회한다.
forward
global type w_post from w_response
end type
type dw_responst1 from cuo_dwwindow within w_post
end type
type st_1 from statictext within w_post
end type
type pb_retrieve from picturebutton within w_post
end type
type st_2 from statictext within w_post
end type
type sle_juso from singlelineedit within w_post
end type
end forward

global type w_post from w_response
integer height = 1472
string title = "우편번호조회"
dw_responst1 dw_responst1
st_1 st_1
pb_retrieve pb_retrieve
st_2 st_2
sle_juso sle_juso
end type
global w_post w_post

forward prototypes
public function string wf_ok (long ai_row)
end prototypes

public function string wf_ok (long ai_row);String  s_return,s_post,s_postfname,s_sidoname
int     i_sidocode
long    i_postcode
String  ls_juso1, ls_juso2, ls_juso3
//i_postcode   = dw_responst1.getItemNumber(ai_row,'seq')    //관리번호 코드
s_post       = dw_responst1.getItemString(ai_row,'post')   //동코드

ls_juso1  = dw_responst1.getItemString(ai_row,'juso1')   //동코드
ls_juso2  = dw_responst1.getItemString(ai_row,'juso2')   //동코드
ls_juso3  = dw_responst1.getItemString(ai_row,'juso3')   //동코드

s_postfname = Trim(ls_juso1) + ' ' + Trim(ls_juso2) + ' ' + Trim(ls_juso3)

//IF isnull(i_sidocode) then i_sidocode = 0
//IF isnull(s_sidoname) then s_sidoname = ''
S_return = string(i_postcode) + '|' + Trim(s_post) + '|' + trim(s_postfname) + '|'
return S_return
end function

on w_post.create
int iCurrent
call super::create
this.dw_responst1=create dw_responst1
this.st_1=create st_1
this.pb_retrieve=create pb_retrieve
this.st_2=create st_2
this.sle_juso=create sle_juso
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_responst1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.pb_retrieve
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_juso
end on

on w_post.destroy
call super::destroy
destroy(this.dw_responst1)
destroy(this.st_1)
destroy(this.pb_retrieve)
destroy(this.st_2)
destroy(this.sle_juso)
end on

event ue_open;String s_message
s_message = trim(Message.StringParm)
If isnull(s_message) Or len(s_message) < 1 Then
	sle_juso.Text = ''
	sle_juso.Setfocus()
Else
	sle_juso.Text = s_message
	pb_retrieve.TriggerEvent('Clicked')
End if
end event

type pb_cancel from w_response`pb_cancel within w_post
integer x = 2409
integer y = 1208
integer width = 347
integer height = 104
boolean originalsize = true
end type

event pb_cancel::clicked;ClosewithReturn(Parent,'0')
end event

type pb_ok from w_response`pb_ok within w_post
integer x = 2057
integer y = 1208
integer width = 347
integer height = 104
end type

event pb_ok::clicked;long  l_row 
String s_uid
int li_postcode
l_row = dw_responst1.Getselectedrow(0)
IF l_row > 0 then
	s_uid = wf_ok(l_row)
   ClosewithReturn(Parent,s_uid)
else
	MessageBox('학인','우편번호를 선택하여 주십시요')
end IF	
end event

type st_sttitle00001 from w_response`st_sttitle00001 within w_post
integer y = 1208
integer width = 2053
integer height = 104
end type

type dw_responst from w_response`dw_responst within w_post
boolean visible = false
integer x = 613
integer y = 0
string dataobject = "d_post_fnamelike"
end type

event dw_responst::retrieveend;call super::retrieveend;IF rowcount > 0 then
	this.setrow(1)
//	this.Uf_selectrow(1)
end IF
end event

event dw_responst::doubleclicked;String s_uid
IF row > 0 then
   s_uid = wf_ok(row)
   ClosewithReturn(Parent,s_uid)
end IF	
end event

type dw_responst1 from cuo_dwwindow within w_post
integer y = 124
integer width = 2757
integer height = 1072
integer taborder = 11
string dataobject = "d_post_fnamelike"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;this.uf_setKey(true)
end event

event doubleclicked;String s_uid
IF row > 0 then
   s_uid = wf_ok(row)
   ClosewithReturn(Parent,s_uid)
end IF
end event

event key_enterpress;long  l_row 
String s_uid
int li_postcode

l_row = this.Getselectedrow(0)
IF l_row > 0 then
   s_uid = wf_ok(l_row)
   ClosewithReturn(Parent,s_uid)
end IF	
end event

event retrieveend;call super::retrieveend;IF rowcount > 0 then
	this.setrow(1)
	this.Uf_selectrow(1)
end IF
end event

event ue_nextpage;ScrollNextPage()

end event

event ue_priorpage;ScrollPriorPage()
end event

type st_1 from statictext within w_post
integer width = 2757
integer height = 132
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_retrieve from picturebutton within w_post
integer x = 2391
integer y = 12
integer width = 347
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조 회"
boolean originalsize = true
string picturename = "C:\SEWC\BMP\QUERY_E.BMP"
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;String ls_juso

ls_juso = sle_juso.Text

If isnull(ls_juso) or len(ls_juso) < 1 Then
	ls_juso = '%'
Else
	ls_juso = '%' + ls_juso + '%'
End if

f_setPointer('S')
dw_responst1.reset()
dw_responst1.Retrieve(ls_juso)
f_setPointer('E')
end event

type st_2 from statictext within w_post
integer x = 23
integer y = 32
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "주소"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_juso from singlelineedit within w_post
event ue_keydown pbm_keydown
integer x = 352
integer y = 16
integer width = 2030
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;If key = keyenter! Then
	pb_retrieve.TriggerEvent('Clicked')
End if
end event

