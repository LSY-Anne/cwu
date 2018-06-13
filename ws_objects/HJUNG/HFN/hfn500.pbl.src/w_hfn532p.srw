$PBExportHeader$w_hfn532p.srw
$PBExportComments$일계표
forward
global type w_hfn532p from w_hfn_print_form5
end type
type st_3 from statictext within w_hfn532p
end type
type em_fr_date from editmask within w_hfn532p
end type
type st_1 from statictext within w_hfn532p
end type
type em_to_date from editmask within w_hfn532p
end type
type st_4 from statictext within w_hfn532p
end type
end forward

global type w_hfn532p from w_hfn_print_form5
st_3 st_3
em_fr_date em_fr_date
st_1 st_1
em_to_date em_to_date
st_4 st_4
end type
global w_hfn532p w_hfn532p

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();DateTime	ldt_SysDateTime
  string ls_strdate
    date ld_date
	 long ll_cnt

dw_print.Reset()

em_fr_date.getdata(ld_date)
is_str_date = string(ld_date, 'yyyymmdd')
em_to_date.getdata(ld_date)
is_end_date = string(ld_date, 'yyyymmdd')

if is_str_date > is_end_date then
	f_messagebox('1', '회계일자의 범위가 올바르지 않습니다.')
	em_to_date.setfocus()
	return
end if

// 요구기간 설정
select count(*) into :Ll_cnt from acdb.hac003m
 where (:is_str_date between from_date and to_date
        and bdgt_class = 0
	     and stat_class = 0)
	and (:is_end_date between from_date and to_date
        and bdgt_class = 0
	     and stat_class = 0);
 
if ll_cnt < 1 then
	f_messagebox('1', '요구기간에 해당하는 일자가 아닙니다.~r~r' + &
	                  '확인 후 조회하시기 바랍니다.')
	em_to_date.setfocus()
	return
end if

// 회계년도 시작일자
select from_date into :ls_strdate from acdb.hac003m
 where :is_str_date between from_date and to_date
   and bdgt_class = 0
	and stat_class = 0 ;

wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(ii_acct_class, ls_strdate, is_str_date, is_end_date)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true
end if

wf_setMsg('')

end subroutine

on w_hfn532p.create
int iCurrent
call super::create
this.st_3=create st_3
this.em_fr_date=create em_fr_date
this.st_1=create st_1
this.em_to_date=create em_to_date
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.em_fr_date
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_to_date
this.Control[iCurrent+5]=this.st_4
end on

on w_hfn532p.destroy
call super::destroy
destroy(this.st_3)
destroy(this.em_fr_date)
destroy(this.st_1)
destroy(this.em_to_date)
destroy(this.st_4)
end on

event ue_open;call super::ue_open;//string  ls_sys_date
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ls_sys_date = f_today()
//
//em_fr_date.text = string(ls_sys_date,'@@@@/@@/@@')
//em_to_date.text = string(ls_sys_date,'@@@@/@@/@@')
//
//em_fr_date.SetFocus()
end event

event ue_postopen;call super::ue_postopen;string  ls_sys_date

uo_acct_class.dw_commcode.setitem(1, 'code', '1')
ii_acct_class = 1

ls_sys_date = f_today()

em_fr_date.text = string(ls_sys_date,'@@@@/@@/@@')
em_to_date.text = string(ls_sys_date,'@@@@/@@/@@')

em_fr_date.SetFocus()
idw_print = dw_print
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
avc_data.SetProperty('title', "일계표")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn532p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn532p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn532p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn532p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn532p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn532p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn532p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn532p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn532p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn532p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn532p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn532p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn532p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn532p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn532p
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn532p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn532p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn532p
integer x = 1573
integer y = 200
integer height = 56
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 31112622
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn532p
boolean visible = false
integer x = 2190
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn532p
integer taborder = 20
string dataobject = "d_hfn532p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn532p
boolean visible = false
end type

type st_3 from statictext within w_hfn532p
integer x = 78
integer y = 196
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
string text = "회계일자"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fr_date from editmask within w_hfn532p
integer x = 357
integer y = 184
integer width = 466
integer height = 76
integer taborder = 20
boolean bringtotop = true
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
boolean autoskip = true
boolean spin = true
end type

type st_1 from statictext within w_hfn532p
integer x = 823
integer y = 192
integer width = 91
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 31112622
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_to_date from editmask within w_hfn532p
integer x = 914
integer y = 184
integer width = 466
integer height = 76
integer taborder = 30
boolean bringtotop = true
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
boolean autoskip = true
boolean spin = true
end type

type st_4 from statictext within w_hfn532p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 31112622
long backcolor = 31112622
alignment alignment = center!
boolean focusrectangle = false
end type

