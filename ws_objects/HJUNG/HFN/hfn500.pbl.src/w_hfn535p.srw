$PBExportHeader$w_hfn535p.srw
$PBExportComments$지출세부리스트
forward
global type w_hfn535p from w_hfn_print_form5
end type
type st_3 from statictext within w_hfn535p
end type
type em_fr_date from editmask within w_hfn535p
end type
type em_to_date from editmask within w_hfn535p
end type
type st_1 from statictext within w_hfn535p
end type
end forward

global type w_hfn535p from w_hfn_print_form5
st_3 st_3
em_fr_date em_fr_date
em_to_date em_to_date
st_1 st_1
end type
global w_hfn535p w_hfn535p

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_transfer_proc (string as_acct_code)
end prototypes

public subroutine wf_retrieve ();DateTime	ldt_SysDateTime
    date ld_date
	 long Ll_cnt
string ls_bdgt_year, ls_str_date, ls_end_date
dw_con.accepttext()
ls_str_date = String(dw_con.object.fr_date[1], 'yyyymmdd')
ls_end_date = String(dw_con.object.to_date[1], 'yyyymmdd')

dw_print.Reset()


if ls_str_date > ls_end_date then
	f_messagebox('1', '회계일자의 범위가 올바르지 않습니다.')
	em_to_date.setfocus()
	return
end if

// 요구기간 설정
select count(*) into :Ll_cnt from acdb.hac003m
 where (:ls_str_date between from_date and to_date
        and bdgt_class = 0
	     and stat_class = 0)
	and (:ls_end_date between from_date and to_date
        and bdgt_class = 0
	     and stat_class = 0);
 
if ll_cnt < 1 then
	f_messagebox('1', '요구기간에 해당하는 일자가 아닙니다.~r~r' + &
	                  '확인 후 조회하시기 바랍니다.')
	em_to_date.setfocus()
	return
end if

// 예산년도
ls_bdgt_year = f_getbdgtyear_byft(ls_str_date, ls_end_date)

wf_setMsg('조회중')

dw_print.SetRedraw(False)
dw_print.retrieve(gi_acct_class, ls_str_date, ls_end_date)
dw_print.SetRedraw(True)

if dw_print.rowcount() > 0 then
	dw_print.bringtotop = true

	//건물매입비에서 건설가계정 금액 감산...
	wf_transfer_proc('1312')
	//차량운반구에서 건설가계정 금액 감산...(2005.07.12)
	wf_transfer_proc('1316')

	//기계기구,집기비품 계정을 건물로 대체한 전표가 있음. (물품관리전환 건물대체)(2005.07.12)
	wf_transfer_proc('1314')
	wf_transfer_proc('1315')

//   dw_print.Object.t_slip_date.Text = em_fr_date.Text + ' ∼ ' + em_to_date.Text

	dw_print.setfilter("com_acct_amt <> 0")
	dw_print.filter()
	dw_print.sort()
	dw_print.groupcalc()
end if

wf_setMsg('')

end subroutine

public subroutine wf_transfer_proc (string as_acct_code);/*
	기계기구(1314),집기비품(1315),건물(1312),차량운반구(1316)

	대체전표 처리 : 2005.07.12
	대체전표에 대한 자금계산서 계정별 처리

	1. 
		건설가계정 계정 관련...
		건물 건축 완료후 본계정 대체 시...
		자금계산서 지출 중 건물매입비 금액에서 건설가계정 금액을 차감하여 계산...
	2.
		기계기구, 집기비품 매각대 계정 추가 작업...(2005.07.12)
			ㄱ.기계기구,집기비품 계정을 건물로 대체한 전표가 있음. (물품관리전환 건물대체)
			ㄴ.수입일 경우 : 기계기구,집기비품 - 건물 대체금액.
			ㄷ.지출일 경우 : 건물매입비 - 기계기구,집기비품 대체금액 계산함.
	3.
		차량운반구 계정 관련...(2005.07.12)
		차량 제작 완료후 본계정 대체 시...
		자금계산서 지출 중 차량운반구 금액에서 건설가계정 금액을 차감하여 계산...
*/

dec{0}				ldc_acct_amt
long					ll_row, ll_end, ll_find, ll_acct_no, ll_cnt, ll_slip_class
string 				ls_acct_code, ls_acct_date

ll_end  = dw_print.rowcount()
ll_find = dw_print.find("left(com_acct_cd, 4) = '"+as_acct_code+"'", 1, ll_end)

do while	ll_find > 0
	ls_acct_code   = dw_print.getitemstring(ll_find, 'com_acct_cd')
	ls_acct_date   = dw_print.getitemstring(ll_find, 'slip_date')
	ll_acct_no   	= dw_print.getitemnumber(ll_find, 'slip_no')
	ll_slip_class  = dw_print.getitemnumber(ll_find, 'slip_class')
	
	if ll_slip_class = 3 then dw_print.setitem(ll_find, 'com_acct_amt', 0)

	ll_find ++
	if ll_find > ll_end then exit
	ll_find = dw_print.find("left(com_acct_cd, 4) = '"+as_acct_code+"'", ll_find, ll_end)
loop

end subroutine

on w_hfn535p.create
int iCurrent
call super::create
this.st_3=create st_3
this.em_fr_date=create em_fr_date
this.em_to_date=create em_to_date
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.em_fr_date
this.Control[iCurrent+3]=this.em_to_date
this.Control[iCurrent+4]=this.st_1
end on

on w_hfn535p.destroy
call super::destroy
destroy(this.st_3)
destroy(this.em_fr_date)
destroy(this.em_to_date)
destroy(this.st_1)
end on

event ue_open;call super::ue_open;//string  ls_sys_date
//
//uo_acct_class.dw_commcode.setitem(1, 'code', '1')
//ii_acct_class = 1
//
//ls_sys_date = f_today()
//
//em_fr_date.text = string(ls_sys_date, '@@@@/@@/@@')
//em_to_date.text = string(ls_sys_date, '@@@@/@@/@@')
//
//em_fr_date.SetFocus()
end event

event ue_postopen;call super::ue_postopen;dw_con.object.fr_date[1] = date(string(f_today(), '@@@@/@@/@@'))
dw_con.object.to_date[1] = date(string(f_today(), '@@@@/@@/@@'))

dw_con.SetFocus()
dw_con.setcolumn('to_date')
idw_print = dw_print
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_hfn_print_form5`ln_templeft within w_hfn535p
end type

type ln_tempright from w_hfn_print_form5`ln_tempright within w_hfn535p
end type

type ln_temptop from w_hfn_print_form5`ln_temptop within w_hfn535p
end type

type ln_tempbuttom from w_hfn_print_form5`ln_tempbuttom within w_hfn535p
end type

type ln_tempbutton from w_hfn_print_form5`ln_tempbutton within w_hfn535p
end type

type ln_tempstart from w_hfn_print_form5`ln_tempstart within w_hfn535p
end type

type uc_retrieve from w_hfn_print_form5`uc_retrieve within w_hfn535p
end type

type uc_insert from w_hfn_print_form5`uc_insert within w_hfn535p
end type

type uc_delete from w_hfn_print_form5`uc_delete within w_hfn535p
end type

type uc_save from w_hfn_print_form5`uc_save within w_hfn535p
end type

type uc_excel from w_hfn_print_form5`uc_excel within w_hfn535p
end type

type uc_print from w_hfn_print_form5`uc_print within w_hfn535p
end type

type st_line1 from w_hfn_print_form5`st_line1 within w_hfn535p
end type

type st_line2 from w_hfn_print_form5`st_line2 within w_hfn535p
end type

type st_line3 from w_hfn_print_form5`st_line3 within w_hfn535p
end type

type uc_excelroad from w_hfn_print_form5`uc_excelroad within w_hfn535p
end type

type ln_dwcon from w_hfn_print_form5`ln_dwcon within w_hfn535p
end type

type st_2 from w_hfn_print_form5`st_2 within w_hfn535p
boolean visible = false
integer x = 1376
integer y = 100
end type

type uo_acct_class from w_hfn_print_form5`uo_acct_class within w_hfn535p
boolean visible = false
integer x = 2523
integer taborder = 0
end type

type dw_print from w_hfn_print_form5`dw_print within w_hfn535p
integer taborder = 30
string dataobject = "d_hfn535p_1"
end type

type dw_con from w_hfn_print_form5`dw_con within w_hfn535p
string dataobject = "d_hfn306q_con"
end type

event dw_con::constructor;call super::constructor;This.object.fr_date_t.text = '회계일자'
end event

type st_3 from statictext within w_hfn535p
boolean visible = false
integer x = 41
integer y = 100
integer width = 270
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
string text = "회계일자"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fr_date from editmask within w_hfn535p
boolean visible = false
integer x = 320
integer y = 88
integer width = 466
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
string mask = "yyyy/mm/dd"
boolean autoskip = true
boolean spin = true
end type

type em_to_date from editmask within w_hfn535p
boolean visible = false
integer x = 878
integer y = 88
integer width = 466
integer height = 76
integer taborder = 20
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
string mask = "yyyy/mm/dd"
boolean autoskip = true
boolean spin = true
end type

type st_1 from statictext within w_hfn535p
boolean visible = false
integer x = 786
integer y = 96
integer width = 91
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
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

