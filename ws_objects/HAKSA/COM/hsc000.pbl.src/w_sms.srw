$PBExportHeader$w_sms.srw
forward
global type w_sms from w_no_condition_window
end type
type dw_char from uo_dwfree within w_sms
end type
type p_1 from picture within w_sms
end type
type st_1 from statictext within w_sms
end type
type sle_1 from singlelineedit within w_sms
end type
type dw_send from uo_dwfree within w_sms
end type
type st_2 from statictext within w_sms
end type
type st_3 from statictext within w_sms
end type
type sle_sendno from singlelineedit within w_sms
end type
type st_byte from statictext within w_sms
end type
type uo_send from uo_imgbtn within w_sms
end type
type uo_reset from uo_imgbtn within w_sms
end type
type mle_screen from multilineedit within w_sms
end type
end forward

global type w_sms from w_no_condition_window
string title = "SMS 발송"
dw_char dw_char
p_1 p_1
st_1 st_1
sle_1 sle_1
dw_send dw_send
st_2 st_2
st_3 st_3
sle_sendno sle_sendno
st_byte st_byte
uo_send uo_send
uo_reset uo_reset
mle_screen mle_screen
end type
global w_sms w_sms

type variables
long		TYPE_VALUE = 1
end variables

on w_sms.create
int iCurrent
call super::create
this.dw_char=create dw_char
this.p_1=create p_1
this.st_1=create st_1
this.sle_1=create sle_1
this.dw_send=create dw_send
this.st_2=create st_2
this.st_3=create st_3
this.sle_sendno=create sle_sendno
this.st_byte=create st_byte
this.uo_send=create uo_send
this.uo_reset=create uo_reset
this.mle_screen=create mle_screen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_char
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.dw_send
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.sle_sendno
this.Control[iCurrent+9]=this.st_byte
this.Control[iCurrent+10]=this.uo_send
this.Control[iCurrent+11]=this.uo_reset
this.Control[iCurrent+12]=this.mle_screen
end on

on w_sms.destroy
call super::destroy
destroy(this.dw_char)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.dw_send)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_sendno)
destroy(this.st_byte)
destroy(this.uo_send)
destroy(this.uo_reset)
destroy(this.mle_screen)
end on

type ln_templeft from w_no_condition_window`ln_templeft within w_sms
end type

type ln_tempright from w_no_condition_window`ln_tempright within w_sms
end type

type ln_temptop from w_no_condition_window`ln_temptop within w_sms
end type

type ln_tempbuttom from w_no_condition_window`ln_tempbuttom within w_sms
end type

type ln_tempbutton from w_no_condition_window`ln_tempbutton within w_sms
end type

type ln_tempstart from w_no_condition_window`ln_tempstart within w_sms
end type

type uc_retrieve from w_no_condition_window`uc_retrieve within w_sms
end type

type uc_insert from w_no_condition_window`uc_insert within w_sms
end type

type uc_delete from w_no_condition_window`uc_delete within w_sms
end type

type uc_save from w_no_condition_window`uc_save within w_sms
end type

type uc_excel from w_no_condition_window`uc_excel within w_sms
end type

type uc_print from w_no_condition_window`uc_print within w_sms
end type

type st_line1 from w_no_condition_window`st_line1 within w_sms
end type

type st_line2 from w_no_condition_window`st_line2 within w_sms
end type

type st_line3 from w_no_condition_window`st_line3 within w_sms
end type

type uc_excelroad from w_no_condition_window`uc_excelroad within w_sms
end type

type ln_dwcon from w_no_condition_window`ln_dwcon within w_sms
end type

type gb_1 from w_no_condition_window`gb_1 within w_sms
integer x = 370
integer y = 424
end type

type dw_char from uo_dwfree within w_sms
integer x = 1623
integer y = 316
integer width = 1083
integer height = 1220
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sms_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If row <= 0 Then Return

String ls_get_col, ls_col, ls_state
long   ll_rtn

ls_col = dwo.Name
If ls_col = 'datawindow' Then Return

ls_get_col = GetItemString(row, ls_col)

ll_rtn = mle_screen.position()


mle_screen.Text = mid(mle_screen.Text,1,ll_rtn - 1) +" "+ ls_get_col +" "+mid(mle_screen.Text,ll_rtn, len(mle_screen.Text))
mle_screen.SetFocus()
RETURN
end event

event constructor;call super::constructor;This.SetTransObject(Sqlca)
This.Retrieve()
end event

type p_1 from picture within w_sms
integer x = 306
integer y = 180
integer width = 1207
integer height = 1888
boolean bringtotop = true
string picturename = "..\img\hp.jpg"
boolean focusrectangle = false
end type

type st_1 from statictext within w_sms
integer x = 599
integer y = 1344
integer width = 210
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
long backcolor = 15780518
string text = "받는분"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_sms
integer x = 850
integer y = 1332
integer width = 498
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;String	ls_no
Long		ll_row, ll_find, li_nocall_cnt

ls_no = This.Text

CHOOSE CASE Mid(ls_no,1,3)
	CASE '010','011','016','017','018','019'
		ll_find = dw_send.Find( "s_phone = '" + ls_no + "'", 1, dw_send.Rowcount())
		If ll_find > 0 Then
			Messagebox('확인',  '해당전화번호는 등록되어 있습니다.')
			RETURN
		End if
		
		ll_row = dw_send.InsertRow(0)
		dw_send.ScrollToRow(ll_row)
		dw_send.SetItem(ll_row, 's_gb'   , 'Y')
		dw_send.SetItem(ll_row, 's_phone', ls_no)
		This.Text = ''
		This.SetFocus()
	CASE ELSE
		Messagebox('확인',  '핸드폰번호가 아니거나 잘못된 전화번호입니다.~r~n확인 바랍니다.')
END CHOOSE



end event

type dw_send from uo_dwfree within w_sms
integer x = 457
integer y = 1408
integer width = 896
integer height = 364
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sms_02"
boolean vscrollbar = true
end type

event rbuttondown;call super::rbuttondown;If row < 1 Or This.Rowcount() < row Then Return

This.Deleterow(row)
end event

type st_2 from statictext within w_sms
integer x = 1632
integer y = 220
integer width = 274
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
string text = "특수문자"
boolean focusrectangle = false
end type

type st_3 from statictext within w_sms
integer x = 521
integer y = 1784
integer width = 251
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
long backcolor = 32500968
string text = "보내는분"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_sendno from singlelineedit within w_sms
integer x = 786
integer y = 1772
integer width = 553
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_byte from statictext within w_sms
integer x = 663
integer y = 1252
integer width = 443
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
long backcolor = 12632256
string text = "0 / 80 byte"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_send from uo_imgbtn within w_sms
event destroy ( )
integer x = 919
integer y = 1880
integer taborder = 30
boolean bringtotop = true
string btnname = "보내기"
end type

on uo_send.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;String			ls_gb,  ls_cell_tel_no,  ls_count, ls_sms_msg, ls_dest_info
Long			ll_row, ll_count, ll_rtn, ll_chk_cnt

ls_sms_msg   = mle_screen.text
ls_cell_tel_no = sle_sendno.text
ll_chk_cnt      = dw_send.Object.tot_cnt[1]

If ll_chk_cnt < 1 Then
	gf_message(parentwin, 2, '9999', 'INFOMATION', '체크된 받는분이 없습니다.~r~n확인 바랍니다.')
	Return
End If

If Trim(ls_sms_msg) = '' Or IsNull(ls_sms_msg) Then
	gf_message(parentwin, 2, '9999', 'INFOMATION', 'SMS 메시지가 없습니다.~r~n확인 바랍니다.')
	Return
End if
If Trim(ls_cell_tel_no) = '' Or IsNull(ls_cell_tel_no) Then
	gf_message(parentwin, 2, '9999', 'INFOMATION', '보내는분 전화번호가 없습니다.~r~n확인 바랍니다.')
	Return
End if

ll_rtn = messagebox('확인', '선택하신 HP 번호로 SMS 를 보내시겠습니까?', EXCLAMATION!, OKCANCEL!, 2)

IF ll_rtn = 2 THEN	RETURN ;

ll_count =  dw_send.rowcount()
ls_count = String(dw_send.Object.tot_cnt[1])

FOR ll_row = 1 TO ll_count
	ls_gb = dw_send.Object.s_gb[ll_row]
	
	If ls_gb = 'Y' Then
		ls_dest_info = func.of_nvl( dw_send.Object.s_name[ll_row], ' ') + "^" + func.of_nvl( dw_send.Object.s_phone[ll_row], ' ')
		
		ls_dest_info =  ls_dest_info + "|"
	End If
	
NEXT

SELECT REPLACE(:ls_dest_info, '-', '')
    INTO :ls_dest_info
   FROM DUAL
  USING SQLCA ;

// SMS 보내기.
String 		ls_msg

parameters	param

param.serverurl = "http://sms.chungwoon.ac.kr/smssend.jsp"

param.parameter[1].param = "USER_ID"
param.parameter[1].param_type = TYPE_VALUE
param.parameter[1].data = "cwuhrd"

// 보내는이
param.parameter[2].param = "CALLBACK"
param.parameter[2].param_type = TYPE_VALUE
param.parameter[2].data = ls_cell_tel_no

// 메세지 보낼 전화번호 갯수
param.parameter[3].param = "DEST_COUNT"
param.parameter[3].param_type = TYPE_VALUE
param.parameter[3].data = ls_count

// 받는이
param.parameter[4].param = "DEST_INFO"
param.parameter[4].param_type = TYPE_VALUE
param.parameter[4].data = ls_dest_info  // 박구석^01093713219|이주연^0173909690

// 메시지
param.parameter[5].param = "SMS_MSG"
param.parameter[5].param_type = TYPE_VALUE
param.parameter[5].data = ls_sms_msg

postsendurl(param, ls_msg)

dw_send.Reset()
mle_screen.text = ''

f_set_message("[전송] " + '성공적으로 전송되었습니다.', '', parentwin)



end event

type uo_reset from uo_imgbtn within w_sms
event destroy ( )
integer x = 608
integer y = 1880
integer taborder = 40
boolean bringtotop = true
string btnname = "초기화"
end type

on uo_reset.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;mle_screen.text = ''
dw_send.Reset()
sle_1.text = ''
end event

type mle_screen from multilineedit within w_sms
event ue_keydown pbm_keydown
integer x = 512
integer y = 432
integer width = 795
integer height = 756
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;st_byte.Text = String(LenA(This.Text)) + ' / 80 byte'
IF LenA(This.Text) > 80 THEN
	MESSAGEBOX('주의','허용된 문자수를 초과했습니다.')
	RETURN
END IF
end event

event modified;st_byte.Text = String(LenA(This.Text)) + ' / 80 byte'
IF LenA(This.Text) > 80 THEN
	MESSAGEBOX('주의','허용된 문자수를 초과했습니다.')
	RETURN
END IF
end event

