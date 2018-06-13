$PBExportHeader$w_hfn201a_tax.srw
$PBExportComments$결의서등록(부서용) 부가세 관리
forward
global type w_hfn201a_tax from window
end type
type cb_del from uo_imgbtn within w_hfn201a_tax
end type
type cb_ins from uo_imgbtn within w_hfn201a_tax
end type
type cb_cancel from uo_imgbtn within w_hfn201a_tax
end type
type cb_ok from uo_imgbtn within w_hfn201a_tax
end type
type cbx_1 from checkbox within w_hfn201a_tax
end type
type st_3 from statictext within w_hfn201a_tax
end type
type em_year from editmask within w_hfn201a_tax
end type
type st_2 from statictext within w_hfn201a_tax
end type
type st_1 from statictext within w_hfn201a_tax
end type
type ddlb_tax_gubun from dropdownlistbox within w_hfn201a_tax
end type
type ddlb_tax_type from dropdownlistbox within w_hfn201a_tax
end type
type dw_main from datawindow within w_hfn201a_tax
end type
end forward

global type w_hfn201a_tax from window
integer width = 3214
integer height = 1824
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
string icon = "AppIcon!"
boolean center = true
cb_del cb_del
cb_ins cb_ins
cb_cancel cb_cancel
cb_ok cb_ok
cbx_1 cbx_1
st_3 st_3
em_year em_year
st_2 st_2
st_1 st_1
ddlb_tax_gubun ddlb_tax_gubun
ddlb_tax_type ddlb_tax_type
dw_main dw_main
end type
global w_hfn201a_tax w_hfn201a_tax

type variables
string 		is_tax_type, is_tax_gubun, is_resol_no
integer		ii_resol_seq, ii_close_type = 0

end variables

forward prototypes
public function long wf_retrieve ()
public function integer wf_insert (long a_ins_row)
end prototypes

public function long wf_retrieve ();long ll_row



ll_row = dw_main.retrieve(1, is_tax_type, is_tax_gubun, is_resol_no, ii_resol_seq)



return ll_row

end function

public function integer wf_insert (long a_ins_row);long ll_row

for ll_row = a_ins_row to dw_main.rowcount()
	dw_main.object.com_row[ll_row] = dw_main.object.com_getrow[ll_row]
next

dw_main.object.tax_type[a_ins_row] 		= is_tax_type
dw_main.object.tax_gubun[a_ins_row] 	= is_tax_gubun
dw_main.object.resol_no[a_ins_row] 		= is_resol_no
dw_main.object.resol_seq[a_ins_row] 	= ii_resol_seq

dw_main.object.del[a_ins_row] 			= 'N'

dw_main.setFocus()
dw_main.setColumn("tax_date")

return 0

end function

on w_hfn201a_tax.create
this.cb_del=create cb_del
this.cb_ins=create cb_ins
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cbx_1=create cbx_1
this.st_3=create st_3
this.em_year=create em_year
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_tax_gubun=create ddlb_tax_gubun
this.ddlb_tax_type=create ddlb_tax_type
this.dw_main=create dw_main
this.Control[]={this.cb_del,&
this.cb_ins,&
this.cb_cancel,&
this.cb_ok,&
this.cbx_1,&
this.st_3,&
this.em_year,&
this.st_2,&
this.st_1,&
this.ddlb_tax_gubun,&
this.ddlb_tax_type,&
this.dw_main}
end on

on w_hfn201a_tax.destroy
destroy(this.cb_del)
destroy(this.cb_ins)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cbx_1)
destroy(this.st_3)
destroy(this.em_year)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_tax_gubun)
destroy(this.ddlb_tax_type)
destroy(this.dw_main)
end on

event open;s_tax			str_tax
Long			ll_row

str_tax = Message.PowerObjectParm

is_tax_type 	= str_tax.tax_type
is_tax_gubun 	= str_tax.tax_gubun
is_resol_no		= str_tax.resol_no
ii_resol_seq	= str_tax.resol_seq

if is_tax_type = '1' then
	this.title = '계산서 내용 입력'
elseif is_tax_type = '2' then
	this.title = '세금계산서 내용 입력'
end if

if is_tax_gubun = '1' then
	this.title += ' : 매입'
elseif is_tax_gubun = '2' then
	this.title += ' : 매출'
end if

em_year.text = left(f_today(),4)

ddlb_tax_type.selectitem(integer(is_tax_type))
ddlb_tax_gubun.selectitem(integer(is_tax_gubun))

//em_year.enabled = false
ddlb_tax_type.enabled 	= false
ddlb_tax_gubun.enabled 	= false

if isValid(str_tax.dw_tax) then  //입력할 경우
 str_tax.dw_tax.RowsCopy(1, str_tax.dw_tax.RowCount(), Primary!, dw_main, 1, Primary!)
 cb_ins.of_enable( true)
 cb_del.of_enable( true)
 cb_cancel.of_enable( true)
else  //조회할 경우
 em_year.enabled  = false
 cbx_1.enabled   = false
 cb_ins.of_enable( false)
 cb_del.of_enable( false)
 cb_cancel.of_enable( false)
end if 
cb_ok.of_enable(true)

if dw_main.rowcount() = 0 then	wf_retrieve()

dw_main.setSort("com_row A")
dw_main.sort()

//계산서 구분이 변경되었을 경우 처리
for ll_row = 1 to dw_main.rowcount()
	dw_main.setItem(ll_row, 'tax_type', is_tax_type)
	//계산서
	if is_tax_type = '1' then dw_main.setItem(ll_row, 'tax_vat', 0)
	//세금계산서
//	if is_tax_type = '2' then dw_main.setitem(ll_row, 'tax_vat', round(dw_main.getItemNumber(ll_row, 'tax_amt') * 0.1, 0))
next

long ll_pos
ll_pos = dw_main.x + dw_main.width - cb_cancel.width
cb_cancel.x = ll_pos  
ll_pos = ll_pos - 16 - cb_ok.width

cb_ok.x = ll_pos

ll_pos = cbx_1.x + cbx_1.width  + 16
cb_ins.x = ll_pos  
ll_pos = ll_pos + cb_ins.width + 16
cb_del.x = ll_pos


end event

event close;DataStore	lds_tax

lds_tax = Create DataStore    // 메모리에 할당
lds_tax.DataObject = dw_main.DataObject
lds_tax.SetTransObject(sqlca)

if ii_close_type = 1 then
	dw_main.RowsCopy(1, dw_main.RowCount(), Primary!, lds_tax, 1, Primary!)
	CloseWithReturn(this, lds_tax)
else
	setNull(lds_tax)
	CloseWithReturn(this, lds_tax)
end if

end event

type cb_del from uo_imgbtn within w_hfn201a_tax
integer x = 814
integer y = 140
integer taborder = 70
string btnname = "삭제"
end type

event clicked;call super::clicked;long ll_find

if Messagebox('확인', '선택한 자료를 지우시렵니까?', Question!, YesNo!, 2) = 2 then return

ll_find = dw_main.find("del = 'Y'", 0, dw_main.rowcount())

do while ll_find <> 0
	dw_main.deleterow(ll_find)
	
	ll_find = dw_main.find("del = 'Y'", ll_find, dw_main.rowcount())
loop

end event

on cb_del.destroy
call uo_imgbtn::destroy
end on

type cb_ins from uo_imgbtn within w_hfn201a_tax
integer x = 466
integer y = 140
integer taborder = 60
string btnname = "입력"
end type

event clicked;call super::clicked;long ll_ins_row

ll_ins_row = dw_main.insertrow(dw_main.getrow())

wf_insert(ll_ins_row)


end event

on cb_ins.destroy
call uo_imgbtn::destroy
end on

type cb_cancel from uo_imgbtn within w_hfn201a_tax
integer x = 2757
integer y = 64
integer taborder = 70
string btnname = "취소"
end type

event clicked;call super::clicked;close(parent)

end event

on cb_cancel.destroy
call uo_imgbtn::destroy
end on

type cb_ok from uo_imgbtn within w_hfn201a_tax
integer x = 2391
integer y = 64
integer taborder = 60
string btnname = "확인"
end type

event clicked;call super::clicked;string 	ls_tax_date, ls_cust_no
long		ll_tax_amt, ll_tax_vat, ll_row

dw_main.AcceptText()

for ll_row = 1 to dw_main.rowCount()
	if isNull(dw_main.getItemString(ll_row, 'tax_date')) or dw_main.getItemString(ll_row, 'tax_date') = '' then
		f_messagebox('1', '[' + string(ll_row) + ']항의 ' + ' 계산서일자를 반드시 입력해 주세요.!')
		dw_main.scrolltorow(ll_row)
		dw_main.setcolumn('tax_date')
		dw_main.setfocus()
		return
	end if
	if isNull(dw_main.getItemString(ll_row, 'tax_cust_no')) or dw_main.getItemString(ll_row, 'tax_cust_no') = '' then
		f_messagebox('1', '[' + string(ll_row) + ']항의 ' + ' 거래처를 반드시 입력해 주세요.!')
		dw_main.scrolltorow(ll_row)
		dw_main.setcolumn('tax_cust_no')
		dw_main.setfocus()
		return
	end if
	if isNull(dw_main.getItemNumber(ll_row, 'tax_amt')) or dw_main.getItemNumber(ll_row, 'tax_amt') = 0 then
		f_messagebox('1', '[' + string(ll_row) + ']항의 ' + ' 공급가액을 반드시 입력해 주세요.!')
		dw_main.scrolltorow(ll_row)
		dw_main.setcolumn('tax_amt')
		dw_main.setfocus()
		return
	end if
next

ii_close_type = 1

close(parent)

end event

on cb_ok.destroy
call uo_imgbtn::destroy
end on

type cbx_1 from checkbox within w_hfn201a_tax
integer x = 59
integer y = 148
integer width = 411
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전체선택"
end type

event clicked;long ll_find
string ls_find_gubun

if this.checked then
	this.text = '선택취소'
	ls_find_gubun = 'Y'
else
	this.text = '전체선택'
	ls_find_gubun = 'N'
end if

ll_find = dw_main.find("isnull(del) or del <> '"+ls_find_gubun+"'", 0, dw_main.rowcount())

do while ll_find <> 0
	dw_main.object.del[ll_find] = ls_find_gubun
	ll_find = dw_main.find("isnull(del) or del <> '"+ls_find_gubun+"'", ll_find, dw_main.rowcount())
loop

end event

type st_3 from statictext within w_hfn201a_tax
integer x = 64
integer y = 36
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean enabled = false
string text = "해당년도"
boolean focusrectangle = false
end type

type em_year from editmask within w_hfn201a_tax
integer x = 334
integer y = 20
integer width = 270
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
boolean autoskip = true
boolean spin = true
end type

type st_2 from statictext within w_hfn201a_tax
integer x = 1458
integer y = 36
integer width = 283
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "매입매출"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_hfn201a_tax
integer x = 635
integer y = 36
integer width = 283
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "처리구분"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_tax_gubun from dropdownlistbox within w_hfn201a_tax
integer x = 1755
integer y = 20
integer width = 297
integer height = 324
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string item[] = {"매입","매출"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_tax_type from dropdownlistbox within w_hfn201a_tax
integer x = 933
integer y = 20
integer width = 494
integer height = 324
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string item[] = {"계산서","세금계산서"}
borderstyle borderstyle = stylelowered!
end type

type dw_main from datawindow within w_hfn201a_tax
event ue_dwnkey pbm_dwnkey
integer x = 9
integer y = 252
integer width = 3173
integer height = 1480
integer taborder = 30
string title = "none"
string dataobject = "d_hfn201a_tax_2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;long ll_ins_row

if KeyDown(KeyDownArrow!) then
	if dw_main.rowcount() <> 0 and dw_main.rowcount() = dw_main.getrow() then 
		ll_ins_row = dw_main.insertrow(0)
		wf_insert(ll_ins_row)
	end if
end if


return 0

end event

event doubleclicked;s_insa_com	lstr_rtn

if row < 1 then return

if dwo.name <> 'tax_cust_no' then return

open(w_hfn_cust)

lstr_rtn = message.powerobjectparm

if not isvalid(lstr_rtn) then
	setitem(row, 'tax_cust_no', '')
	setitem(row, 'cust_name', '')
	setitem(row, 'BUSINESS_NO', '')
	return
end if

setitem(row, 'tax_cust_no', lstr_rtn.ls_item[1])
setitem(row, 'cust_name', trim(lstr_rtn.ls_item[2]))
setitem(row, 'BUSINESS_NO', trim(lstr_rtn.ls_item[6]))

end event

event itemchanged;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: itemchanged::dw_update
//	기 능 설 명: 항목 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
long	ll_cnt
string	ls_cust_name, ls_business_no, ls_yymm, ls_close_yn

choose case dwo.name
	case 'tax_date'
		if not isnull(data) and trim(data) <> '' then
			if not isdate(string(data, '@@@@/@@/@@')) then
				messagebox('확인', '계산서일자가 올바르지 않습니다.')
				setitem(row, dwo.name, '')
				return 1
			end if
			
			
			//마감여부 SELECT...
			SELECT	ACCT_YYMM, 	CLOSE_YN	
			INTO 	:ls_yymm,	:ls_close_yn
			FROM	FNDB.HFN012M
			WHERE	ACCT_CLASS 	= 		1
			AND		:data 		BETWEEN BEGIN_DATE AND END_DATE
			;
		
			if ls_close_yn = 'Y' then
				messagebox('확인', string(ls_yymm, '@@@@/@@') + ' 년월은 월마감이 확정되었습니다.~r~n' + &
						   '계산서일자('+string(data, '@@@@/@@/@@')+')를 다시 입력하세요.', exclamation!)
				return 1
			end if
		end if
	case 'tax_cust_no'
		if not isnull(data) and trim(data) <> '' then
			select	count(cust_no)	into	:ll_cnt
			from		stdb.hst001m
			where		cust_no = trim(:data)	;
			
			if ll_cnt < 1 then
				setitem(row, 'tax_cust_no', '')
				setitem(row, 'business_no', '')
				setitem(row, 'cust_name', '')
				messagebox('확인', '등록되지 않은 거래처입니다.')
				return 1
			elseif ll_cnt = 1 then
				select	business_no, cust_name	into	:ls_business_no, :ls_cust_name
				from		stdb.hst001m
				where		cust_no = trim(:data)	;
				
				setitem(row, 'business_no', trim(ls_business_no))
				setitem(row, 'cust_name', trim(ls_cust_name))
			end if
		end if
	case 'tax_amt'
		if getitemstring(row, 'tax_type') = '2' then
			setitem(row, 'tax_vat', round(dec(data) * 0.1,0))
		end if
end choose

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event constructor;settransobject(sqlca)

end event

