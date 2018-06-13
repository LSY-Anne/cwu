$PBExportHeader$w_hfn522p.srw
$PBExportComments$고정자산명세서
forward
global type w_hfn522p from w_hfn_print_form5
end type
type st_3 from statictext within w_hfn522p
end type
type em_bdgt_year from editmask within w_hfn522p
end type
end forward

global type w_hfn522p from w_hfn_print_form5
st_3 st_3
em_bdgt_year em_bdgt_year
end type
global w_hfn522p w_hfn522p

type variables

end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();DateTime Ldt_SysDateTime
string	ls_date
date		ld_date

dw_print.Reset()

em_bdgt_year.getdata(ld_date)
ls_date = string(ld_date,'yyyymm') + '01'

// 회계년도에 대한 기간 구하기
is_str_date = ''
is_end_date = mid(ls_date,1,6) + '31'

Select From_Date Into :is_str_date
  From acdb.hac003m
 Where :ls_date between from_date and to_date
   And bdgt_class = 0
	And stat_class = 0 ;
	
if sqlca.sqlcode <> 0 then
	messagebox('확인', '회계년월의 설정이 올바르지 않습니다.')
	return
end if

wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(ii_acct_class, is_str_date, is_end_date)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true

	dw_print.Object.t_slip_date.Text = mid(is_str_date,1,4) + '년(' + em_bdgt_year.text + ')'
end if

wf_setMsg('')

end subroutine

on w_hfn522p.create
int iCurrent
call super::create
this.st_3=create st_3
this.em_bdgt_year=create em_bdgt_year
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.em_bdgt_year
end on

on w_hfn522p.destroy
call super::destroy
destroy(this.st_3)
destroy(this.em_bdgt_year)
end on

event ue_open;call super::ue_open;string  ls_sys_date

uo_acct_class.dw_commcode.setitem(1, 'code', '1')
ii_acct_class = 1

ls_sys_date = f_today()

em_bdgt_year.text = left(ls_sys_date,4) + '/' + mid(ls_sys_date,5,2)

em_bdgt_year.SetFocus()

end event

type st_2 from w_hfn_print_form5`st_2 within w_hfn522p
integer x = 832
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn522p
boolean visible = false
integer x = 2190
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn522p
integer taborder = 20
string dataobject = "d_hfn522p_1"
end type

type st_3 from statictext within w_hfn522p
integer x = 46
integer y = 100
integer width = 274
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "회계년월"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_bdgt_year from editmask within w_hfn522p
integer x = 325
integer y = 88
integer width = 398
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm"
boolean autoskip = true
boolean spin = true
end type

