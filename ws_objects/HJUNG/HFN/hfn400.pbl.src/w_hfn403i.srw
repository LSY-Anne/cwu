$PBExportHeader$w_hfn403i.srw
$PBExportComments$결산마감확정
forward
global type w_hfn403i from w_msheet
end type
type st_2 from statictext within w_hfn403i
end type
type st_1 from statictext within w_hfn403i
end type
type dw_update from uo_dwgrid within w_hfn403i
end type
type st_3 from statictext within w_hfn403i
end type
end forward

global type w_hfn403i from w_msheet
st_2 st_2
st_1 st_1
dw_update dw_update
st_3 st_3
end type
global w_hfn403i w_hfn403i

on w_hfn403i.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.dw_update=create dw_update
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_update
this.Control[iCurrent+4]=this.st_3
end on

on w_hfn403i.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_update)
destroy(this.st_3)
end on

event ue_open;call super::ue_open;triggerevent('ue_retrieve')

//wf_setmenu('R', true)
//wf_setmenu('U', true)

end event

event ue_retrieve;call super::ue_retrieve;
dw_update.retrieve()
return 1

end event

event ue_save;call super::ue_save;datetime	ldt_workdate
long		ll_row

dw_update.accepttext()

if dw_update.modifiedcount() < 1 then
	wf_setmsg('저장하기 위해 변경된 자료가 없습니다.')
	return  -1
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

type ln_templeft from w_msheet`ln_templeft within w_hfn403i
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn403i
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn403i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn403i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn403i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn403i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn403i
end type

type uc_insert from w_msheet`uc_insert within w_hfn403i
end type

type uc_delete from w_msheet`uc_delete within w_hfn403i
end type

type uc_save from w_msheet`uc_save within w_hfn403i
end type

type uc_excel from w_msheet`uc_excel within w_hfn403i
end type

type uc_print from w_msheet`uc_print within w_hfn403i
end type

type st_line1 from w_msheet`st_line1 within w_hfn403i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn403i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn403i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn403i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn403i
end type

type st_2 from statictext within w_hfn403i
integer x = 64
integer y = 220
integer width = 2318
integer height = 52
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

type st_1 from statictext within w_hfn403i
integer x = 64
integer y = 164
integer width = 2414
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 결산마감년도의 마감을 확정하면 회계의 모든 자료를 수정할 수 없게 됩니다."
boolean focusrectangle = false
end type

type dw_update from uo_dwgrid within w_hfn403i
integer x = 50
integer y = 292
integer width = 4384
integer height = 1976
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hfn403i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;long		ll_cnt
string	ls_begin_date, ls_end_date

if dwo.name = 'base_year' then
	// 이월 자료의 처리여부
	SELECT	COUNT(*)	INTO	:LL_CNT	FROM	FNDB.HFN005M
	WHERE		BDGT_YEAR = :DATA
	AND		CLOSE_OPT = '2' ;
	
	if ll_cnt < 1 then
		messagebox('확인', data + ' 회계년도의 년마감처리가 되어 있지 않습니다.~r~r' + &
		                          '년마감 처리 후 이상이 없을 경우 다시 확정하시기 바랍니다.')
		setitem(row, dwo.name, '')
		return 1
	end if
	
	// 중복 자료의 여부 확인
	if	find("base_year = '" + data + "'", 1, row - 1) > 0 then
		messagebox('확인', '이미 확정된 회계년도 입니다.')
		setitem(row, dwo.name, '')
		setitem(row, 'begin_date', '')
		setitem(row, 'end_date', '')
		return 1
	end if

	if	find("base_year = '" + data + "'", row + 1, rowcount()) > 0 then
		messagebox('확인', '이미 확정된 회계년도 입니다.')
		setitem(row, dwo.name, '')
		setitem(row, 'begin_date', '')
		setitem(row, 'end_date', '')
		return 1
	end if
	
	// 회계기간 처리
	SELECT	FROM_DATE, TO_DATE	INTO	:LS_BEGIN_DATE, :LS_END_DATE
	FROM		ACDB.HAC003M
	WHERE		BDGT_YEAR	=	:DATA
	AND		BDGT_CLASS	=	0
	AND		STAT_CLASS	=	0 ;
	
	if sqlca.sqlcode <> 0 then
		messagebox('확인', '회계년도의 요구기간 설정이 되어 있지 않습니다.')
		setitem(row, dwo.name, '')
		setitem(row, 'begin_date', '')
		setitem(row, 'end_date', '')
		return 1
	end if
	
	setitem(row, 'begin_date', ls_begin_date)
	setitem(row, 'end_date', ls_end_date)
end if
end event

event itemerror;call super::itemerror;return 1
end event

type st_3 from statictext within w_hfn403i
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
long textcolor = 18751006
long backcolor = 31112622
boolean focusrectangle = false
end type

