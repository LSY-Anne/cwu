$PBExportHeader$w_hfn111a_help.srw
$PBExportComments$유가증권 일괄생성
forward
global type w_hfn111a_help from window
end type
type sle_remark from singlelineedit within w_hfn111a_help
end type
type st_10 from statictext within w_hfn111a_help
end type
type em_close_amt from editmask within w_hfn111a_help
end type
type st_9 from statictext within w_hfn111a_help
end type
type em_close_date from editmask within w_hfn111a_help
end type
type st_8 from statictext within w_hfn111a_help
end type
type em_face_amt from editmask within w_hfn111a_help
end type
type st_7 from statictext within w_hfn111a_help
end type
type st_6 from statictext within w_hfn111a_help
end type
type st_5 from statictext within w_hfn111a_help
end type
type sle_sec_name from singlelineedit within w_hfn111a_help
end type
type st_4 from statictext within w_hfn111a_help
end type
type sle_draw_customer from singlelineedit within w_hfn111a_help
end type
type cb_1 from commandbutton within w_hfn111a_help
end type
type em_open_date from editmask within w_hfn111a_help
end type
type dw_sec_opt from datawindow within w_hfn111a_help
end type
type st_3 from statictext within w_hfn111a_help
end type
type st_2 from statictext within w_hfn111a_help
end type
type sle_to_no from singlelineedit within w_hfn111a_help
end type
type sle_from_no from singlelineedit within w_hfn111a_help
end type
type sle_han from singlelineedit within w_hfn111a_help
end type
type st_1 from statictext within w_hfn111a_help
end type
type gb_2 from groupbox within w_hfn111a_help
end type
type gb_1 from groupbox within w_hfn111a_help
end type
end forward

global type w_hfn111a_help from window
integer width = 2098
integer height = 1484
boolean titlebar = true
string title = "유가증권 일괄생성"
boolean controlmenu = true
windowtype windowtype = response!
sle_remark sle_remark
st_10 st_10
em_close_amt em_close_amt
st_9 st_9
em_close_date em_close_date
st_8 st_8
em_face_amt em_face_amt
st_7 st_7
st_6 st_6
st_5 st_5
sle_sec_name sle_sec_name
st_4 st_4
sle_draw_customer sle_draw_customer
cb_1 cb_1
em_open_date em_open_date
dw_sec_opt dw_sec_opt
st_3 st_3
st_2 st_2
sle_to_no sle_to_no
sle_from_no sle_from_no
sle_han sle_han
st_1 st_1
gb_2 gb_2
gb_1 gb_1
end type
global w_hfn111a_help w_hfn111a_help

on w_hfn111a_help.create
this.sle_remark=create sle_remark
this.st_10=create st_10
this.em_close_amt=create em_close_amt
this.st_9=create st_9
this.em_close_date=create em_close_date
this.st_8=create st_8
this.em_face_amt=create em_face_amt
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.sle_sec_name=create sle_sec_name
this.st_4=create st_4
this.sle_draw_customer=create sle_draw_customer
this.cb_1=create cb_1
this.em_open_date=create em_open_date
this.dw_sec_opt=create dw_sec_opt
this.st_3=create st_3
this.st_2=create st_2
this.sle_to_no=create sle_to_no
this.sle_from_no=create sle_from_no
this.sle_han=create sle_han
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.sle_remark,&
this.st_10,&
this.em_close_amt,&
this.st_9,&
this.em_close_date,&
this.st_8,&
this.em_face_amt,&
this.st_7,&
this.st_6,&
this.st_5,&
this.sle_sec_name,&
this.st_4,&
this.sle_draw_customer,&
this.cb_1,&
this.em_open_date,&
this.dw_sec_opt,&
this.st_3,&
this.st_2,&
this.sle_to_no,&
this.sle_from_no,&
this.sle_han,&
this.st_1,&
this.gb_2,&
this.gb_1}
end on

on w_hfn111a_help.destroy
destroy(this.sle_remark)
destroy(this.st_10)
destroy(this.em_close_amt)
destroy(this.st_9)
destroy(this.em_close_date)
destroy(this.st_8)
destroy(this.em_face_amt)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.sle_sec_name)
destroy(this.st_4)
destroy(this.sle_draw_customer)
destroy(this.cb_1)
destroy(this.em_open_date)
destroy(this.dw_sec_opt)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_to_no)
destroy(this.sle_from_no)
destroy(this.sle_han)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;string	ls_sysdate

f_centerme(this)

f_getdwcommon(dw_sec_opt, 'sec_opt', 0, 750)
 
ls_sysdate = f_today()

em_open_date.text  = mid(ls_sysdate,1,4) + '/' + mid(ls_sysdate,5,2) + '/' + mid(ls_sysdate,7,2)
em_close_date.text = mid(ls_sysdate,1,4) + '/' + mid(ls_sysdate,5,2) + '/' + mid(ls_sysdate,7,2)

end event

type sle_remark from singlelineedit within w_hfn111a_help
integer x = 494
integer y = 996
integer width = 1490
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within w_hfn111a_help
integer x = 32
integer y = 1012
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "내        역"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_close_amt from editmask within w_hfn111a_help
integer x = 494
integer y = 884
integer width = 649
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###,###"
boolean autoskip = true
end type

type st_9 from statictext within w_hfn111a_help
integer x = 32
integer y = 896
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "만 기  금 액"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_close_date from editmask within w_hfn111a_help
integer x = 494
integer y = 768
integer width = 512
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
boolean spin = true
end type

type st_8 from statictext within w_hfn111a_help
integer x = 32
integer y = 780
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "만 기  일 자"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_face_amt from editmask within w_hfn111a_help
integer x = 494
integer y = 648
integer width = 649
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###,###"
boolean autoskip = true
end type

type st_7 from statictext within w_hfn111a_help
integer x = 32
integer y = 664
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "액 면  금 액"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_hfn111a_help
integer x = 32
integer y = 548
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "구 입  일 자"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_hfn111a_help
integer x = 32
integer y = 432
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "발   행   처"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_sec_name from singlelineedit within w_hfn111a_help
integer x = 494
integer y = 300
integer width = 997
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_hfn111a_help
integer x = 32
integer y = 316
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "유가 증권 명"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_draw_customer from singlelineedit within w_hfn111a_help
integer x = 494
integer y = 420
integer width = 997
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_hfn111a_help
integer x = 727
integer y = 1176
integer width = 576
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "유가증권일괄생성"
end type

event clicked;string	ls_han, ls_format, ls_from_no, ls_to_no, ls_sec_no
string	ls_open_date, ls_close_date, ls_sec_name, ls_draw_customer, ls_remark
datetime	ldt_sysdate
date		ld_date
long		ll_len, ll_cnt, ll_tot_cnt
long		ll_face_amt, ll_close_amt
integer	li_sec_opt

ls_han = trim(sle_han.text)

// 어음번호 확인
ls_from_no = trim(sle_from_no.text)
ls_to_no   = trim(sle_to_no.text)

if isnull(ls_from_no) or trim(ls_from_no) = '' then
	messagebox('확인', '유가증권번호의 시작번호를 입력하시기 바랍니다.')
	sle_from_no.setfocus()
	return
end if

if isnull(ls_to_no) or trim(ls_to_no) = '' then
	messagebox('확인', '유가증권번호의 마지막번호를 입력하시기 바랍니다.')
	sle_to_no.setfocus()
	return
end if

if len(ls_from_no) <> len(ls_to_no) then
	messagebox('확인', '유가증권번호의 자릿수가 일치하지 않습니다.')
	sle_to_no.setfocus()
	return
end if

if ls_from_no > ls_to_no then
	messagebox('확인', '유가증권번호의 범위가 올바르지 않습니다.')
	sle_to_no.setfocus()
	return
end if

// 유가증권종류 확인
li_sec_opt = integer(dw_sec_opt.getitemstring(1, 'code'))

if isnull(li_sec_opt) or li_sec_opt = 0 then
	messagebox('확인', '유가증권종류를 올바르게 선택하시기 바랍니다.')
	dw_sec_opt.setfocus()
	return
end if

ls_sec_name = trim(sle_sec_name.text)

ls_draw_customer = trim(sle_draw_customer.text)

// 구입일자 확인
if not isdate(em_open_date.text) then
	messagebox('확인', '구입일자를 올바르게 입력하시기 바랍니다.')
	em_open_date.setfocus()
	return
end if

ll_face_amt = long(em_face_amt.text)

// 액면금액 확인
if isnull(ll_face_amt) or ll_face_amt = 0 then
	messagebox('확인', '액면금액을 입력하시기 바랍니다.')
	em_face_amt.setfocus()
	return
end if

// 만기일자 확인
if not isdate(em_close_date.text) then
	messagebox('확인', '만기일자를 올바르게 입력하시기 바랍니다.')
	em_close_date.setfocus()
	return
end if

ll_close_amt = long(em_close_amt.text)

// 만기금액 확인
if isnull(ll_close_amt) or ll_close_amt = 0 then
	messagebox('확인', '액면금액을 입력하시기 바랍니다.')
	em_face_amt.setfocus()
	return
end if

if em_open_date.text > em_close_date.text then
	messagebox('확인', '구입일자와 만기일자의 범위가 올바르지 않습니다.')
	em_close_date.setfocus()
	return
end if

em_open_date.getdata(ld_date)
ls_open_date = string(ld_date,'yyyymmdd')
em_close_date.getdata(ld_date)
ls_close_date = string(ld_date,'yyyymmdd')

ls_remark = trim(sle_remark.text)

ldt_sysdate = f_sysdate()



ll_len = len(ls_from_no)

for ll_cnt = 1 to ll_len
	ls_format = ls_format + '0'
next

ll_tot_cnt = long(ls_to_no) - long(ls_from_no) + 1

for ll_cnt = 1 to ll_tot_cnt
	if ll_cnt = 1 then
		ls_sec_no = ls_from_no
	else
		ls_sec_no = string(long(ls_sec_no) + 1, ls_format)
	end if
	
	insert into fndb.hfn006m (sec_no, acct_class, sec_name, sec_opt, draw_customer,
	                          face_amt, close_amt, open_date, close_date, stat_class, remark,
	                          worker, ipaddr, work_date, job_uid, job_add, job_date)
							values (:ls_han||:ls_sec_no, 1, :ls_sec_name, :li_sec_opt, :ls_draw_customer,
							        :ll_face_amt, :ll_close_amt, :ls_open_date, :ls_close_date, 'Y', :ls_remark,
							        :gs_empcode, :gs_ip, :ldt_sysdate, :gs_empcode, :gs_ip, :ldt_sysdate) ;
   
	if sqlca.sqlcode <> 0 then
		rollback ;
		messagebox('확인', '일괄생성시 에러가 발생하였습니다.~r~r' + &
		                   sqlca.sqlerrtext, stopsign!)

		return
	end if
next

commit ;


messagebox('확인', '유가증권 일괄생성이 정상적으로 수행되었습니다.')

end event

type em_open_date from editmask within w_hfn111a_help
integer x = 494
integer y = 536
integer width = 512
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
boolean spin = true
end type

type dw_sec_opt from datawindow within w_hfn111a_help
integer x = 494
integer y = 180
integer width = 1248
integer height = 104
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type st_3 from statictext within w_hfn111a_help
integer x = 32
integer y = 200
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "유가증권종류"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_hfn111a_help
integer x = 1243
integer y = 84
integer width = 91
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "∼"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_to_no from singlelineedit within w_hfn111a_help
integer x = 1335
integer y = 72
integer width = 562
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 16
borderstyle borderstyle = stylelowered!
end type

type sle_from_no from singlelineedit within w_hfn111a_help
integer x = 672
integer y = 72
integer width = 562
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 16
borderstyle borderstyle = stylelowered!
end type

type sle_han from singlelineedit within w_hfn111a_help
integer x = 494
integer y = 72
integer width = 178
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_hfn111a_help
integer x = 32
integer y = 84
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "유가증권번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_hfn111a_help
integer x = 27
integer width = 2021
integer height = 1120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_1 from groupbox within w_hfn111a_help
integer x = 27
integer y = 1096
integer width = 2021
integer height = 244
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

