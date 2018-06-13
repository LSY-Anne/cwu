$PBExportHeader$w_hfn404i.srw
$PBExportComments$월마감확정
forward
global type w_hfn404i from w_msheet
end type
type dw_con from uo_dwfree within w_hfn404i
end type
type st_2 from statictext within w_hfn404i
end type
type st_1 from statictext within w_hfn404i
end type
type dw_update from uo_dwgrid within w_hfn404i
end type
end forward

global type w_hfn404i from w_msheet
dw_con dw_con
st_2 st_2
st_1 st_1
dw_update dw_update
end type
global w_hfn404i w_hfn404i

on w_hfn404i.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.st_2=create st_2
this.st_1=create st_1
this.dw_update=create dw_update
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_update
end on

on w_hfn404i.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_update)
end on

event ue_open;call super::ue_open;//string	ls_sys_date
//
//ls_sys_date = f_today()
//
//em_bdgt_year.text = left(ls_sys_date,4)
//
//triggerevent('ue_retrieve')
//
//wf_setmenu('I', true)
//wf_setmenu('R', true)
//wf_setmenu('U', true)
//
end event

event ue_retrieve;call super::ue_retrieve;string	ls_from_yymm, ls_to_yymm
String	ls_bdgt_year

dw_con.accepttext()
ls_bdgt_year = String(dw_con.object.bdgt_year[1], 'yyyy')

ls_from_yymm = ls_bdgt_year + '03'
ls_to_yymm   = string(integer(ls_bdgt_year) + 1, '0000') + '02'


dw_update.retrieve(ls_from_yymm, ls_to_yymm)

return 1
end event

event ue_save;call super::ue_save;datetime	ldt_workdate
long		ll_row

dw_update.accepttext()

if dw_update.modifiedcount() < 1 then
	wf_setmsg('저장하기 위해 변경된 자료가 없습니다.')
	return -1
end if

ldt_workdate = f_sysdate()



ll_row = dw_update.getnextmodified(0, primary!)
do while ll_row > 0
	dw_update.setitem(ll_row, 'job_uid', gs_empcode)
	dw_update.setitem(ll_row, 'job_add', gs_ip)
	dw_update.setitem(ll_row, 'job_date', ldt_workdate)
	ll_row = dw_update.getnextmodified(ll_row, primary!)
loop

if dw_update.update() <> 1 then
	rollback ;

	wf_SetMsg('자료 저장중 오류가 발생하였습니다.')
	MessageBox('오류', '자료저장 중 전산장애가 발생되었습니다.~r~n' + &
							 '하단의 장애번호와 장애내역을~r~n' + &
							 '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							 '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							 '장애내역 : ' + SQLCA.SqlErrText)
	return -1
end if

commit ;
wf_SetMsg('자료가 저장되었습니다.')


triggerevent('ue_retrieve')

end event

event ue_insert;call super::ue_insert;datetime	ldt_workdate
string	ls_yymm, ls_mm
long		ll_cnt, ll_row
String	ls_bdgt_year

dw_con.accepttext()
ls_bdgt_year = String(dw_con.object.bdgt_year[1], 'yyyy')

triggerevent('ue_retrieve')

if dw_update.rowcount() > 0 then
	messagebox('확인', '이미 등록된 회계년도입니다.')
	return
end if

ldt_workdate = f_sysdate()

// 회계년도의 1년의 월을 처리한다.
ls_mm = '02'
for ll_cnt = 1 to 12
	ls_mm = string(integer(ls_mm) + 1, '00')
	
	if ls_mm > '12' then
		ls_mm = '01'
	end if
	
	if ls_mm = '01' or ls_mm = '02' then
		ls_yymm = string(integer(ls_bdgt_year) + 1, '0000') + ls_mm
	else
		ls_yymm = ls_bdgt_year + ls_mm
	end if
	
	ll_row = dw_update.insertrow(0)
	
	dw_update.setitem(ll_row, 'acct_class', 1)
	dw_update.setitem(ll_row, 'acct_yymm', ls_yymm)
	dw_update.setitem(ll_row, 'begin_date', ls_yymm + '01')
	dw_update.setitem(ll_row, 'end_date', f_lastdate(ls_yymm))
	dw_update.setitem(ll_row, 'close_yn', 'N')
	dw_update.setitem(ll_row, 'worker', gs_empcode)
	dw_update.setitem(ll_row, 'ipaddr', gs_ip)
	dw_update.setitem(ll_row, 'work_date', ldt_workdate)
	dw_update.setitem(ll_row, 'job_uid', gs_empcode)
	dw_update.setitem(ll_row, 'job_add', gs_ip)
	dw_update.setitem(ll_row, 'job_date', ldt_workdate)
next
end event

event ue_postopen;call super::ue_postopen;string	ls_sys_date

ls_sys_date = f_today()

dw_con.object.bdgt_year[1] = date(string(ls_sys_date, '@@@@/@@/@@'))

triggerevent('ue_retrieve')

//wf_setmenu('I', true)
//wf_setmenu('R', true)
//wf_setmenu('U', true)

end event

type ln_templeft from w_msheet`ln_templeft within w_hfn404i
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn404i
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn404i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn404i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn404i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn404i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn404i
end type

type uc_insert from w_msheet`uc_insert within w_hfn404i
end type

type uc_delete from w_msheet`uc_delete within w_hfn404i
end type

type uc_save from w_msheet`uc_save within w_hfn404i
end type

type uc_excel from w_msheet`uc_excel within w_hfn404i
end type

type uc_print from w_msheet`uc_print within w_hfn404i
end type

type st_line1 from w_msheet`st_line1 within w_hfn404i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn404i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn404i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn404i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn404i
end type

type dw_con from uo_dwfree within w_hfn404i
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_hfn113a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)

st_1.setposition(totop!)
st_2.setposition(totop!)

end event

type st_2 from statictext within w_hfn404i
integer x = 1125
integer y = 220
integer width = 2034
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 더이상 수정할 내역이 없을 경우에만 확정 처리하시기 바랍니다."
boolean focusrectangle = false
end type

type st_1 from statictext within w_hfn404i
integer x = 1129
integer y = 168
integer width = 2030
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 월마감을 확정하면 결의서/전표/마감작업을 수행할 수 없습니다."
boolean focusrectangle = false
end type

type dw_update from uo_dwgrid within w_hfn404i
integer x = 50
integer y = 292
integer width = 4384
integer height = 1972
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hfn404i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;datetime	ldt_workdate

ldt_workdate = f_sysdate()

setitem(row, 'job_uid', gs_empcode)
setitem(row, 'job_add', gs_ip)
setitem(row, 'job_date', ldt_workdate)

end event

event itemerror;call super::itemerror;return 1
end event

