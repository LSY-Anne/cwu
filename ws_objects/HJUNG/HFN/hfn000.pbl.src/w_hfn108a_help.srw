$PBExportHeader$w_hfn108a_help.srw
$PBExportComments$수표어음 일괄생성
forward
global type w_hfn108a_help from window
end type
type cb_1 from uo_imgbtn within w_hfn108a_help
end type
type em_su_date from editmask within w_hfn108a_help
end type
type st_5 from statictext within w_hfn108a_help
end type
type dw_bal_bank_code from datawindow within w_hfn108a_help
end type
type st_4 from statictext within w_hfn108a_help
end type
type dw_notes_class from datawindow within w_hfn108a_help
end type
type st_3 from statictext within w_hfn108a_help
end type
type st_2 from statictext within w_hfn108a_help
end type
type sle_to_no from singlelineedit within w_hfn108a_help
end type
type sle_from_no from singlelineedit within w_hfn108a_help
end type
type sle_han from singlelineedit within w_hfn108a_help
end type
type st_1 from statictext within w_hfn108a_help
end type
type gb_2 from groupbox within w_hfn108a_help
end type
type gb_1 from groupbox within w_hfn108a_help
end type
end forward

global type w_hfn108a_help from window
integer width = 2098
integer height = 908
boolean titlebar = true
string title = "수표어음 일괄생성"
boolean controlmenu = true
windowtype windowtype = response!
cb_1 cb_1
em_su_date em_su_date
st_5 st_5
dw_bal_bank_code dw_bal_bank_code
st_4 st_4
dw_notes_class dw_notes_class
st_3 st_3
st_2 st_2
sle_to_no sle_to_no
sle_from_no sle_from_no
sle_han sle_han
st_1 st_1
gb_2 gb_2
gb_1 gb_1
end type
global w_hfn108a_help w_hfn108a_help

on w_hfn108a_help.create
this.cb_1=create cb_1
this.em_su_date=create em_su_date
this.st_5=create st_5
this.dw_bal_bank_code=create dw_bal_bank_code
this.st_4=create st_4
this.dw_notes_class=create dw_notes_class
this.st_3=create st_3
this.st_2=create st_2
this.sle_to_no=create sle_to_no
this.sle_from_no=create sle_from_no
this.sle_han=create sle_han
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.em_su_date,&
this.st_5,&
this.dw_bal_bank_code,&
this.st_4,&
this.dw_notes_class,&
this.st_3,&
this.st_2,&
this.sle_to_no,&
this.sle_from_no,&
this.sle_han,&
this.st_1,&
this.gb_2,&
this.gb_1}
end on

on w_hfn108a_help.destroy
destroy(this.cb_1)
destroy(this.em_su_date)
destroy(this.st_5)
destroy(this.dw_bal_bank_code)
destroy(this.st_4)
destroy(this.dw_notes_class)
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

f_getdwcommon(dw_notes_class, 'notes_class', 0, 750)
f_getdwcommon(dw_bal_bank_code, 'bank_code', 0, 750)

ls_sysdate = f_today()

em_su_date.text = mid(ls_sysdate,1,4) + '/' + mid(ls_sysdate,5,2) + '/' + mid(ls_sysdate,7,2)

end event

type cb_1 from uo_imgbtn within w_hfn108a_help
integer x = 718
integer y = 604
integer taborder = 80
string btnname = "수표어음일괄생성"
end type

event clicked;call super::clicked;string	ls_han, ls_format, ls_from_no, ls_to_no, ls_notes_no
datetime	ldt_su_date, ldt_sysdate
date		ld_date
time		lt_time
long		ll_len, ll_cnt, ll_tot_cnt
integer	li_notes_class, li_bank_code

ls_han = trim(sle_han.text)

// 어음번호 확인
ls_from_no = trim(sle_from_no.text)
ls_to_no   = trim(sle_to_no.text)

if isnull(ls_from_no) or trim(ls_from_no) = '' then
	messagebox('확인', '수표어음번호의 시작번호를 입력하시기 바랍니다.')
	sle_from_no.setfocus()
	return
end if

if isnull(ls_to_no) or trim(ls_to_no) = '' then
	messagebox('확인', '수표어음번호의 마지막번호를 입력하시기 바랍니다.')
	sle_to_no.setfocus()
	return
end if

if len(ls_from_no) <> len(ls_to_no) then
	messagebox('확인', '수표어음번호의 자릿수가 일치하지 않습니다.')
	sle_to_no.setfocus()
	return
end if

if ls_from_no > ls_to_no then
	messagebox('확인', '수표어음번호의 범위가 올바르지 않습니다.')
	sle_to_no.setfocus()
	return
end if

// 수표어음구분 확인
li_notes_class = integer(dw_notes_class.getitemstring(1, 'code'))

if isnull(li_notes_class) or li_notes_class = 0 then
	messagebox('확인', '수표어음구분을 올바르게 선택하시기 바랍니다.')
	dw_notes_class.setfocus()
	return
end if

// 발행은행 확인
li_bank_code = integer(dw_bal_bank_code.getitemstring(1, 'code'))

if isnull(li_bank_code) or li_bank_code = 0 then
	messagebox('확인', '발행은행을 올바르게 선택하시기 바랍니다.')
	dw_bal_bank_code.setfocus()
	return
end if

// 수불일자 확인
ld_date = date(em_su_date.text)
lt_time = time('00:00:00')
ldt_su_date = datetime(ld_date, lt_time)
ldt_sysdate = f_sysdate()

if not isdate(em_su_date.text) then
	messagebox('확인', '수불일자를 올바르게 입력하시기 바랍니다.')
	em_su_date.setfocus()
	return
end if



ll_len = len(ls_from_no)

for ll_cnt = 1 to ll_len
	ls_format = ls_format + '0'
next

ll_tot_cnt = long(ls_to_no) - long(ls_from_no) + 1

for ll_cnt = 1 to ll_tot_cnt
	if ll_cnt = 1 then
		ls_notes_no = ls_from_no
	else
		ls_notes_no = string(long(ls_notes_no) + 1, ls_format)
	end if
	
	insert into fndb.hfn004m (notes_no, acct_class, notes_class, bal_bank_code, su_date,
	                          worker, ipaddr, work_date, job_uid, job_add, job_date)
							values (:ls_han||:ls_notes_no, 1, :li_notes_class, :li_bank_code, :ldt_su_date,
							        :gstru_uid_uname.uid, :gstru_uid_uname.address, :ldt_sysdate, :gstru_uid_uname.uid, :gstru_uid_uname.address, :ldt_sysdate) ;
   
	if sqlca.sqlcode <> 0 then
		rollback ;
		messagebox('확인', '일괄생성시 에러가 발생하였습니다.~r~r' + &
		                   sqlca.sqlerrtext, stopsign!)

		return
	end if
next

commit ;


messagebox('확인', '수표어음 일괄생성이 정상적으로 수행되었습니다.')

end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type em_su_date from editmask within w_hfn108a_help
integer x = 494
integer y = 416
integer width = 512
integer height = 76
integer taborder = 60
integer textsize = -9
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

type st_5 from statictext within w_hfn108a_help
integer x = 32
integer y = 432
integer width = 457
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "수 불  일 자"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_bal_bank_code from datawindow within w_hfn108a_help
integer x = 489
integer y = 296
integer width = 1248
integer height = 104
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type st_4 from statictext within w_hfn108a_help
integer x = 32
integer y = 316
integer width = 457
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "발 행  은 행"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_notes_class from datawindow within w_hfn108a_help
integer x = 489
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

type st_3 from statictext within w_hfn108a_help
integer x = 32
integer y = 200
integer width = 457
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "수표어음구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_hfn108a_help
integer x = 1243
integer y = 84
integer width = 91
integer height = 52
integer textsize = -9
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

type sle_to_no from singlelineedit within w_hfn108a_help
integer x = 1339
integer y = 72
integer width = 558
integer height = 76
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 16
borderstyle borderstyle = stylelowered!
end type

type sle_from_no from singlelineedit within w_hfn108a_help
integer x = 667
integer y = 72
integer width = 558
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 16
borderstyle borderstyle = stylelowered!
end type

type sle_han from singlelineedit within w_hfn108a_help
integer x = 494
integer y = 72
integer width = 174
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_hfn108a_help
integer x = 32
integer y = 84
integer width = 457
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "수표어음번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_hfn108a_help
integer x = 27
integer width = 2021
integer height = 544
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_1 from groupbox within w_hfn108a_help
integer x = 27
integer y = 520
integer width = 2021
integer height = 244
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

