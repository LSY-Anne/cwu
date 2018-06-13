$PBExportHeader$w_hpa309b.srw
$PBExportComments$월 지급급여 확정
forward
global type w_hpa309b from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type rb_1 from radiobutton within w_hpa309b
end type
type hpb_1 from hprogressbar within w_hpa309b
end type
type st_status from statictext within w_hpa309b
end type
type cb_1 from commandbutton within w_hpa309b
end type
type gb_4 from groupbox within w_hpa309b
end type
type uo_yearmonth from cuo_yearmonth within w_hpa309b
end type
type cbx_1 from checkbox within w_hpa309b
end type
type rb_2 from radiobutton within w_hpa309b
end type
type rb_3 from radiobutton within w_hpa309b
end type
type rb_4 from radiobutton within w_hpa309b
end type
type rb_5 from radiobutton within w_hpa309b
end type
type pb_1 from uo_imgbtn within w_hpa309b
end type
type pb_2 from uo_imgbtn within w_hpa309b
end type
type dw_update from uo_dwgrid within w_hpa309b
end type
type gb_3 from groupbox within w_hpa309b
end type
end forward

global type w_hpa309b from w_tabsheet
integer height = 2724
string title = "월 지급급여 확정"
rb_1 rb_1
hpb_1 hpb_1
st_status st_status
cb_1 cb_1
gb_4 gb_4
uo_yearmonth uo_yearmonth
cbx_1 cbx_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
pb_1 pb_1
pb_2 pb_2
dw_update dw_update
gb_3 gb_3
end type
global w_hpa309b w_hpa309b

type variables
datawindowchild	idw_child
//datawindow			dw_update

string	is_yearmonth
string	is_dept_code
string	is_item1	=	'51'				// 소득세 코드
string	is_item2 =	'52'				// 주민세 코드
string	is_item3 =	'54'				// 의료보험료


string	is_pay_date
string	is_date_gbn						// 명절구분(1=평월, 2=명절)

string	is_member_no, is_code, is_name, is_today
integer	ii_excepte_gbn, ii_sort
dec{0}	idb_amt, idb_nontax_amt

integer	ii_str_jikjong, ii_end_jikjong
end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
public function integer wf_delete ()
public function integer wf_create ()
end prototypes

public subroutine wf_getchild ();// ---------------------------------------------------------------------------------
// Function Name	:	wf_getchild
// Function 설명	:	데이타윈도우에 getchild 설정
//	Argument			:
//	Return			:
// ---------------------------------------------------------------------------------

// 직위명
dw_update.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 보직명
dw_update.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if


end subroutine

public function integer wf_retrieve ();string ls_chasu
long   ll_pandan

if rb_2.checked = true then
	ls_chasu = '2'
elseif rb_3.checked = true then
	ls_chasu = '3'
elseif rb_4.checked = true then
	ls_chasu = '4'
elseif rb_5.checked = true then
	ls_chasu = '5'
end if 

select count(*)
  into :ll_pandan
  from padb.hpa005d
 where year_month = :is_yearmonth
	and chasu      = :ls_chasu;
	
if sqlca.sqlcode <> 0 then return sqlca.sqlcode

if ll_pandan = 0 then
	f_messagebox('1', '월 지급급여가 존재하지 않습니다.~n~n월 지급급여를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
else
   dw_update.retrieve(is_yearmonth, ls_chasu)
   return 0
end if
end function

public function integer wf_delete ();// ------------------------------------------------------------------------------------------
// Function Name	:	wf_delete
// Function 설명	:	월 지급급여 확정취소 처리
//	Argument			:
//	Return			:	integer(sqlca.sqlcode)
// ------------------------------------------------------------------------------------------

long		ll_cnt, ll_count, ll_pandan
string	ls_member_no, ls_chasu

if rb_2.checked = true then
	ls_chasu = '2'
elseif rb_3.checked = true then
	ls_chasu = '3'
elseif rb_4.checked = true then
	ls_chasu = '4'
elseif rb_5.checked = true then
	ls_chasu = '5'
end if 

st_status.text = '월 지급급여 확정취소 처리 준비중 입니다. 잠시만 기다려주시기 바랍니다!...'

select count(*)
  into :ll_pandan
  from padb.hpa005d
 where year_month = :is_yearmonth
	and chasu      = :ls_chasu;
	
if sqlca.sqlcode <> 0 then return sqlca.sqlcode

if ll_pandan = 0 then
	f_messagebox('1', '월 지급급여가 존재하지 않습니다.~n~n월 지급급여를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if


// 월지급급여가 있는지 확인한다.
if dw_update.retrieve(is_yearmonth, ls_chasu) < 1 then
	f_messagebox('1', '월 지급급여가 존재하지 않습니다.~n~n월 지급급여를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if

ll_count = dw_update.rowcount()		// 급여기초자료 Count

// Process Bar Setting
hpb_1.setrange(1, ll_count + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0

setpointer(hourglass!)

st_status.text = '월 지급급여 확정취소 처리중 입니다!...'

// 급여기초자료 Loop
for ll_cnt	= 1 to ll_count
    ls_member_no	=	dw_update.getitemstring(ll_cnt, 'member_no')	
	 
	 select count(*)
	  into :ll_pandan
	  from padb.hpa021m
	 where  member_no  = :ls_member_no
	    and year_month = :is_yearmonth
		 and chasu      = :ls_chasu;
	
	if sqlca.sqlcode <> 0 then return sqlca.sqlcode
	
	if ll_pandan = 0 then
		messagebox('','확정된 자료가 없습니다.')
		return 100
	else
		update padb.hpa021m 
			 set confirm_gbn = 0
		  where member_no  = :ls_member_no
			 and year_month = :is_yearmonth
			 and chasu      = :ls_chasu;
			
		if sqlca.sqlcode <> 0 then return sqlca.sqlcode
	
   end if
	 
	 
	// 퇴직자
	if dw_update.getitemnumber(ll_cnt, 'jaejik_opt')	=	3	then
		if long(is_yearmonth) >= long(left(dw_update.getitemstring(ll_cnt, 'retire_date'), 6))	then
			dw_update.setitem(ll_cnt, 'jaejik_opt',	2)
			
	
			
			// 인사의 재직여부를 퇴직자를 퇴직예정자로 Update
			update	indb.hin001m
			set		jaejik_opt	=	2
			where		member_no	=	:ls_member_no	;
												
			if sqlca.sqlcode <> 0 then
				f_messagebox('3', '인사의 재직여부를 수정하지 못했습니다.')
				return	-1
			end if
		end if
	end if
	
	hpb_1.position += 1
	st_status.text = string(ll_cnt, '#,##0') + ' 건 확정취소 처리중 입니다!...'
next

hpb_1.position += 1
SetPointer(Arrow!)

return	0

end function

public function integer wf_create ();// ------------------------------------------------------------------------------------------
// Function Name	:	wf_create
// Function 설명	:	월 지급급여 확정 처리
//	Argument			:
//	Return			:	integer(sqlca.sqlcode)
// ------------------------------------------------------------------------------------------

long		ll_cnt, ll_count, ll_pandan, ll_judge
string	ls_member_no, ls_chasu

if rb_2.checked = true then
	ls_chasu = '2'

elseif rb_3.checked = true then
	ls_chasu = '3'

elseif rb_4.checked = true then
	ls_chasu = '4'

elseif rb_5.checked = true then
	ls_chasu = '5'
end if

st_status.text = ls_chasu + '차수 지급급여 확정 처리 준비중 입니다. 잠시만 기다려주시기 바랍니다!...'

// 월지급급여가 있는지 확인한다.
select count(*)
  into :ll_pandan
  from padb.hpa005d
 where year_month = :is_yearmonth
	and chasu      = :ls_chasu;
	
if sqlca.sqlcode <> 0 then return sqlca.sqlcode

if ll_pandan = 0 then
	f_messagebox('1', '월 지급급여가 존재하지 않습니다.~n~n월 지급급여를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if

if dw_update.retrieve(is_yearmonth,ls_chasu) < 1 then
	f_messagebox('1', '월 지급급여가 존재하지 않습니다.~n~n월 지급급여를 먼저 생성하신 후 다시 처리하시기 바랍니다.!')
	return	100
end if

ll_count = dw_update.rowcount()		// 급여기초자료 Count

// Process Bar Setting
hpb_1.setrange(1, ll_count + 1)
hpb_1.setstep 	= 1
hpb_1.position	= 0

setpointer(hourglass!)

st_status.text = '월 지급급여 확정 처리중 입니다!...'

// 급여기초자료 Loop
for ll_cnt	= 1 to ll_count
	 ls_member_no	=	dw_update.getitemstring(ll_cnt, 'member_no')
	
	select count(*)
	  into :ll_pandan
	  from padb.hpa021m
	 where  member_no  = :ls_member_no
	    and year_month = :is_yearmonth
		 and chasu      = :ls_chasu;
	
	if sqlca.sqlcode <> 0 then return sqlca.sqlcode

	if ll_pandan = 0 then
		insert into padb.hpa021m
					( member_no, year_month, chasu, confirm_gbn)
			values( :ls_member_no, :is_yearmonth, :ls_chasu, 9);
			
		if sqlca.sqlcode <> 0 then return sqlca.sqlcode
	else
		update padb.hpa021m 
			 set confirm_gbn = 9
		  where member_no  = :ls_member_no
			 and year_month = :is_yearmonth
			 and chasu      = :ls_chasu;
			
		if sqlca.sqlcode <> 0 then return sqlca.sqlcode
	
   end if

	hpb_1.position += 1
	st_status.text = string(ll_cnt, '#,##0') + ' 건 확정 처리중 입니다!...'
next

hpb_1.position += 1
SetPointer(Arrow!)

// 인사의 재직여부를 퇴직예정자를 퇴직으로 Update
update	indb.hin001m
set		jaejik_opt	=	3
where		member_no	in	(	select	member_no
									from		padb.hpa001m
									where		year_month	=	:is_yearmonth
									and		pay_opt		=	9	
									and		jaejik_opt	=	2	)	;
									
if sqlca.sqlcode <> 0 then
	f_messagebox('3', '인사의 재직여부를 수정하지 못했습니다.')
	return	100
end if

return	0

end function

on w_hpa309b.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.hpb_1=create hpb_1
this.st_status=create st_status
this.cb_1=create cb_1
this.gb_4=create gb_4
this.uo_yearmonth=create uo_yearmonth
this.cbx_1=create cbx_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_update=create dw_update
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.hpb_1
this.Control[iCurrent+3]=this.st_status
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.gb_4
this.Control[iCurrent+6]=this.uo_yearmonth
this.Control[iCurrent+7]=this.cbx_1
this.Control[iCurrent+8]=this.rb_2
this.Control[iCurrent+9]=this.rb_3
this.Control[iCurrent+10]=this.rb_4
this.Control[iCurrent+11]=this.rb_5
this.Control[iCurrent+12]=this.pb_1
this.Control[iCurrent+13]=this.pb_2
this.Control[iCurrent+14]=this.dw_update
this.Control[iCurrent+15]=this.gb_3
end on

on w_hpa309b.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.hpb_1)
destroy(this.st_status)
destroy(this.cb_1)
destroy(this.gb_4)
destroy(this.uo_yearmonth)
destroy(this.cbx_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_update)
destroy(this.gb_3)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

event ue_open;call super::ue_open;//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		fALSE)
//
//idw_data	=	dw_update
//
//uo_yearmonth.uf_settitle('지급년월')
//is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
//
//rb_2.checked = true
//
//wf_getchild()
//
////triggerevent('ue_retrieve')
//
end event

event ue_button_set;call super::ue_button_set;Long			ll_stnd_pos

ll_stnd_pos    = pb_1.x

If pb_1.Enabled Then
	pb_1.X		= ll_stnd_pos 
	ll_stnd_pos		= ll_stnd_pos + pb_1.Width + 16
Else
	pb_1.Visible	= FALSE
End If

If pb_2.Enabled Then
	pb_2.X			= ll_stnd_pos 
	ll_stnd_pos			= ll_stnd_pos + pb_2.Width + 16
Else
	pb_2.Visible	= FALSE
End If
end event

event ue_postopen;call super::ue_postopen;//wf_setMenu('INSERT',		false)
//wf_setMenu('DELETE',		false)
//wf_setMenu('RETRIEVE',	TRUE)
//wf_setMenu('UPDATE',		false)
//wf_setMenu('PRINT',		fALSE)

//idw_data	=	dw_update

uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

rb_2.checked = true

wf_getchild()

//triggerevent('ue_retrieve')

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hpa309b
integer beginy = 28
integer endy = 2312
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa309b
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa309b
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa309b
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa309b
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa309b
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa309b
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa309b
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa309b
end type

type uc_save from w_tabsheet`uc_save within w_hpa309b
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa309b
end type

type uc_print from w_tabsheet`uc_print within w_hpa309b
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa309b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa309b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa309b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa309b
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa309b
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa309b
boolean visible = false
integer x = 78
integer y = 1904
integer width = 3881
integer height = 228
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 3845
integer height = 108
string text = "급여계산기준코드관리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

event dw_list001::clicked;call super::clicked;//String s_memberno
//IF row > 0 then
//	s_memberno = dw_list001.getItemString(row,'member_no')
//	dw_update101.retrieve(s_memberno)
//end IF
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
end type

type uo_tab from w_tabsheet`uo_tab within w_hpa309b
integer x = 1710
integer y = 1844
end type

type dw_con from w_tabsheet`dw_con within w_hpa309b
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hpa309b
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 3845
integer height = 108
long backcolor = 79741120
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type rb_1 from radiobutton within w_hpa309b
boolean visible = false
integer x = 1339
integer y = 420
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "평월"
boolean checked = true
end type

event clicked;rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)

rb_1.underline	=	true
rb_2.underline	=	false

is_date_gbn	= '1'

//dw_dept_code.enabled	=	false
//dw_dept_code.object.code.background.color = 78682240
//is_dept_code	=	''
//
//rb_1.textcolor = rgb(0, 0, 255)
//rb_2.textcolor = rgb(0, 0, 0)
//
//rb_1.underline	=	true
//rb_2.underline	=	false
//
//parent.triggerevent('ue_retrieve')
//
end event

type hpb_1 from hprogressbar within w_hpa309b
integer x = 105
integer y = 588
integer width = 4274
integer height = 92
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_status from statictext within w_hpa309b
integer x = 119
integer y = 508
integer width = 4279
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "진행 상태..."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_hpa309b
event keypress pbm_keydown
boolean visible = false
integer x = 1573
integer y = 36
integer width = 370
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "처리"
end type

event keypress;if key = keyenter! then
	this.post event clicked()
end if
end event

event clicked;//string ls_year
//long   ll_count
//

end event

type gb_4 from groupbox within w_hpa309b
integer x = 55
integer y = 428
integer width = 4379
integer height = 288
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "진행상태"
end type

type uo_yearmonth from cuo_yearmonth within w_hpa309b
event destroy ( )
integer x = 105
integer y = 176
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yearmonth	=	uf_getyearmonth()

//parent.triggerevent('ue_retrieve')

end event

type cbx_1 from checkbox within w_hpa309b
boolean visible = false
integer x = 2386
integer y = 284
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "소급금계산"
end type

type rb_2 from radiobutton within w_hpa309b
integer x = 114
integer y = 320
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "2차 연구보조비"
end type

type rb_3 from radiobutton within w_hpa309b
integer x = 658
integer y = 320
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "3차 특별상여"
end type

type rb_4 from radiobutton within w_hpa309b
integer x = 1147
integer y = 320
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "4차 유사급여"
end type

type rb_5 from radiobutton within w_hpa309b
integer x = 1632
integer y = 320
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "5차 정상급여"
end type

type pb_1 from uo_imgbtn within w_hpa309b
integer x = 2505
integer y = 312
integer taborder = 70
boolean bringtotop = true
string btnname = "확정처리"
end type

event clicked;call super::clicked;// 확정처리한다.
integer	li_rtn

setpointer(hourglass!)

li_rtn	=	wf_create()

setpointer(arrow!)

if	li_rtn = 0 then
	commit;
      parent.triggerevent('ue_retrieve')
		f_messagebox('1', string(dw_update.rowcount()) + '건의 자료를 확정 처리했습니다.!')

elseif li_rtn < 0 then

	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
	parent.triggerevent('ue_retrieve')
elseif li_rtn = 1 then
	return
end if

st_status.text = '진행 상태...'


end event

on pb_1.destroy
call uo_imgbtn::destroy
end on

type pb_2 from uo_imgbtn within w_hpa309b
integer x = 2967
integer y = 312
integer taborder = 80
boolean bringtotop = true
string btnname = "확정취소"
end type

event clicked;call super::clicked;// 확정취소처리한다.
integer	li_rtn

setpointer(hourglass!)

li_rtn	=	wf_delete()

setpointer(arrow!)

if	li_rtn = 0 then
	commit;
	parent.triggerevent('ue_retrieve')
	
	f_messagebox('1', string(dw_update.rowcount()) + '건의 자료를 확정취소 처리했습니다.!')
	
elseif li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
	parent.triggerevent('ue_retrieve')
end if

st_status.text = '진행 상태...'


end event

on pb_2.destroy
call uo_imgbtn::destroy
end on

type dw_update from uo_dwgrid within w_hpa309b
integer x = 50
integer y = 716
integer width = 4384
integer height = 1548
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "월 지급급여 확정처리/확정취소처리 대상자 기초사항"
string dataobject = "d_hpa309b_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_3 from groupbox within w_hpa309b
integer x = 55
integer y = 264
integer width = 4379
integer height = 160
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

