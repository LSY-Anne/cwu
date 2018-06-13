$PBExportHeader$w_hge505a.srw
$PBExportComments$주별 지급 시수 관리/출력
forward
global type w_hge505a from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type rb_4 from radiobutton within tabpage_sheet01
end type
type rb_5 from radiobutton within tabpage_sheet01
end type
type rb_6 from radiobutton within tabpage_sheet01
end type
type uo_3 from cuo_search_insa within tabpage_sheet01
end type
type dw_update2 from uo_dwgrid within tabpage_sheet01
end type
type dw_update1 from uo_dwgrid within tabpage_sheet01
end type
type dw_list002 from uo_dwfree within tabpage_sheet01
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
dw_print dw_print
end type
type tabpage_sheet03 from userobject within tab_sheet
end type
type dw_list004 from cuo_dwwindow within tabpage_sheet03
end type
type dw_list003 from cuo_dwwindow within tabpage_sheet03
end type
type gb_11 from groupbox within tabpage_sheet03
end type
type gb_3 from groupbox within tabpage_sheet03
end type
type uo_end from cuo_yyhakgi within tabpage_sheet03
end type
type uo_str from cuo_yyhakgi within tabpage_sheet03
end type
type st_31 from statictext within tabpage_sheet03
end type
type st_4 from statictext within tabpage_sheet03
end type
type pb_1 from picturebutton within tabpage_sheet03
end type
type uo_str_month from cuo_month within tabpage_sheet03
end type
type uo_end_month from cuo_month within tabpage_sheet03
end type
type uo_str_week_cre from cuo_week within tabpage_sheet03
end type
type uo_end_week_cre from cuo_week within tabpage_sheet03
end type
type uo_str_month_cre from cuo_month within tabpage_sheet03
end type
type uo_end_month_cre from cuo_month within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_list004 dw_list004
dw_list003 dw_list003
gb_11 gb_11
gb_3 gb_3
uo_end uo_end
uo_str uo_str
st_31 st_31
st_4 st_4
pb_1 pb_1
uo_str_month uo_str_month
uo_end_month uo_end_month
uo_str_week_cre uo_str_week_cre
uo_end_week_cre uo_end_week_cre
uo_str_month_cre uo_str_month_cre
uo_end_month_cre uo_end_month_cre
end type
type uo_yearhakgi from cuo_yyhakgi within w_hge505a
end type
type uo_2 from cuo_month within w_hge505a
end type
type uo_str_week from cuo_week within w_hge505a
end type
type uo_end_week from cuo_week within w_hge505a
end type
type st_3 from statictext within w_hge505a
end type
type rb_1 from radiobutton within w_hge505a
end type
type rb_2 from radiobutton within w_hge505a
end type
type rb_3 from radiobutton within w_hge505a
end type
type uo_hakgwa from cuo_dept within w_hge505a
end type
type rb_14 from radiobutton within w_hge505a
end type
type rb_7 from radiobutton within w_hge505a
end type
end forward

global type w_hge505a from w_tabsheet
integer width = 4526
string title = "주별 지급 시수 관리/출력"
uo_yearhakgi uo_yearhakgi
uo_2 uo_2
uo_str_week uo_str_week
uo_end_week uo_end_week
st_3 st_3
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
uo_hakgwa uo_hakgwa
rb_14 rb_14
rb_7 rb_7
end type
global w_hge505a w_hge505a

type variables
datawindowchild	idw_child
datawindow			idw_list, idw_data,   idw_list_3, idw_list_4, idw_trans

statictext			ist_back

string	is_yy, is_hakgi, is_duty_code
integer	ii_str_week, ii_end_week
integer	ii_str_jikjong = 1, ii_end_jikjong = 3, ii_maxcode = 0

string	is_dept

string	is_str_yy, is_str_hakgi
string	is_end_yy, is_end_hakgi

integer	ii_str_week_cre, ii_end_week_cre
integer	ii_str_month_cre, ii_end_month_cre
integer	ii_curr_month


end variables

forward prototypes
public subroutine wf_dw_title ()
public subroutine wf_enabled_check (boolean ab_check)
public function integer wf_update ()
public function integer wf_create ()
public function integer wf_select_weekend (integer ai_week)
public function integer wf_retrieve ()
public subroutine wf_retrieve_detail (long al_row)
end prototypes

public subroutine wf_dw_title ();// ==========================================================================================
// 기    능 : 	생성에 사용되는 데이타윈도우의 타이틀을 셋팅하고 조회한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_dw_title()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

is_str_yy			=	tab_sheet.tabpage_sheet03.uo_str.uf_getyy()
is_str_hakgi		=	tab_sheet.tabpage_sheet03.uo_str.uf_gethakgi()
ii_str_month_cre	=	integer(tab_sheet.tabpage_sheet03.uo_str_month_cre.uf_getmm())

is_end_yy			=	tab_sheet.tabpage_sheet03.uo_end.uf_getyy()
is_end_hakgi		=	tab_sheet.tabpage_sheet03.uo_end.uf_gethakgi()
ii_end_month_cre	=	integer(tab_sheet.tabpage_sheet03.uo_end_month_cre.uf_getmm())

idw_list_3.title = is_str_yy + '년도 ' + is_str_hakgi + '학기 ' + string(ii_str_month_cre) + '월 시수 자료'
idw_list_3.retrieve(is_str_yy, is_str_hakgi, ii_str_month_cre)

idw_list_4.title = is_end_yy + '년도 ' + is_end_hakgi + '학기 ' + string(ii_end_month_cre) + '월 시수 자료'
idw_list_4.retrieve(is_end_yy, is_end_hakgi, ii_end_month_cre)

end subroutine

public subroutine wf_enabled_check (boolean ab_check);// ==========================================================================================
// 기    능 : 	조건의 enabled를 조정한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_enabled_check(boolean ab_check)
// 인    수 :	ab_check	-	enabled true or false
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

uo_yearhakgi.em_yy.enabled				=	ab_check
uo_yearhakgi.em_hakgi.enabled			=	ab_check
uo_str_week.em_week.enabled	=	ab_check
uo_end_week.em_week.enabled	=	ab_check
uo_hakgwa.uf_enabled_check(ab_check)
rb_1.enabled						=	ab_check
rb_2.enabled						=	ab_check
rb_3.enabled						=	ab_check
rb_7.enabled						=	ab_check

end subroutine

public function integer wf_update ();// ==========================================================================================
// 기    능 : 	delete or update
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_update()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 필요없는 자료는 삭제한다.
delete	from	padb.hpa116t a
where		year		=	:is_yy
and		hakgi	=	:is_hakgi
and		month	not in (	select	month
								from		padb.hpa112t
								where		year				=	a.year
								and		hakgi			=	a.hakgi
								and		member_no	=	a.member_no
								group by month	)	;
								
if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode


delete	from	padb.hpa113t a
where		year		=	:is_yy
and		hakgi	=	:is_hakgi
and		month	not in (	select	month
								from		padb.hpa112t
								where		year				=	a.year
								and		hakgi			=	a.hakgi
								and		member_no	=	a.member_no
								group by month	)	;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

return	sqlca.sqlcode

end function

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	자료를 생성한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcdoe
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_bgn_weekend, li_end_weekend, li_weekend
integer	li_bgn_weekend2, li_end_weekend2, li_weekend2

// 조회를 한다.
wf_dw_title()

// 기존의 자료 체크
if idw_list_3.rowcount() < 1 then
	f_messagebox('1', is_str_yy + '년도 ' + is_str_hakgi + '학기 ' + string(ii_str_month_cre) + '월의 자료가 존재하지 않습니다.!')
	return	100
end if

// 기존의 월 체크
select	from_weekend, to_weekend
into		:li_bgn_weekend, :li_end_weekend
from		padb.hpa101m
where		year				=	:is_str_yy
and		hakgi			=	:is_str_hakgi
and		month			=	:ii_str_month_cre	;

if sqlca.sqlcode <> 0 then
	f_messagebox('3', is_str_yy + '년도 ' + is_str_hakgi + '학기 ' + string(ii_str_month_cre) + '월의 주가 존재하지 않습니다.!')
	return	100
end if

// 생성할 월 체크
select	from_weekend, to_weekend
into		:li_bgn_weekend2, :li_end_weekend2
from		padb.hpa101m
where		year				=	:is_end_yy
and		hakgi			=	:is_end_hakgi
and		month			=	:ii_end_month_cre	;

if sqlca.sqlcode <> 0 then
	f_messagebox('3', is_end_yy + '년도 ' + is_end_hakgi + '학기 ' + string(ii_end_month_cre) + '월의 주가 존재하지 않습니다.!')
	return	100
end if

// 기존의 주차와 생성할 주차를 비교한다.
if (li_end_weekend - li_bgn_weekend) <> (li_end_weekend2 - li_bgn_weekend2)	then
	f_messagebox('1', is_str_yy + '년도 ' + is_str_hakgi + '학기 ' + string(ii_str_month_cre) + '월의 주차[' + string(li_end_weekend - li_bgn_weekend + 1) + '] 와~n'	+	&
							is_end_yy + '년도 ' + is_end_hakgi + '학기 ' + string(ii_end_month_cre) + '월의 주차[' + string(li_end_weekend2 - li_bgn_weekend2 + 1) + '] 가 맞지 않습니다.~n~n'	+	&
							'확인 후 다시 생성해 주시기 바랍니다.!')
	return	100
end if

// 생성할 자료 체크
if idw_list_4.rowcount() > 0 then
	if f_messagebox('2', is_end_yy + '년도 ' + is_end_hakgi + '학기 ' + string(ii_end_month_cre) + '월의 자료가 이미 존재합니다.~n'			+	&
								'재생성시 주별시수자료와 ' + string(ii_end_month_cre) + '월에 해당하는 지급강사료자료도 모두 삭제됩니다.~n~n'	+	&
								'삭제후 다시 생성하시겠습니까?') = 1 then
		
		delete	from	padb.hpa116t
		where		year		=	:is_end_yy
		and		hakgi	=	:is_end_hakgi	
		and		month	=	:ii_end_month_cre	;
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

		delete	from	padb.hpa113t
		where		year		=	:is_end_yy
		and		hakgi	=	:is_end_hakgi	
		and		month	=	:ii_end_month_cre	;
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

		delete	from	padb.hpa112t
		where		year		=	:is_end_yy
		and		hakgi	=	:is_end_hakgi	
		and		month	=	:ii_end_month_cre	;
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	else
		return	100
	end if
else
	if f_messagebox('2', is_str_yy + '년도 ' + is_str_hakgi + '학기 ' + string(ii_str_month_cre) + '월의 자료를~n~n' +	&
								is_end_yy + '년도 ' + is_end_hakgi + '학기 ' + string(ii_end_month_cre) + '월의 자료를 생성하시겠습니까?') <> 1 then	return	100
end if

idw_list_4.reset()

li_weekend2	=	li_bgn_weekend2

// 기존의 주 Loop
for	li_weekend	=	li_bgn_weekend	to	li_end_weekend
	
	// 주별 Insert
	insert	into	padb.hpa112t
			(	year, hakgi, member_no, week_weekend, month, num_of_time,
				num_of_general, num_of_middle, num_of_large, num_of_etc1,
				num_of_nigeneral, num_of_nimiddle, num_of_nilarge, num_of_nietc1,
				limit_time, time_of_pause1, time_of_pause2, time_of_pause3, time_of_pause4, 
				bogang_sisu_1, bogang_sisu_2, bogang_sisu_3, bogang_sisu_4, 
				num_of_overtime1, num_of_overtime2, num_of_overtime3, num_of_overtime4, 
				misan_sisu_1, misan_sisu_2, misan_sisu_3, misan_sisu_4, 
				worker, ipaddr, work_date, work_gbn,
				job_uid, job_add, job_date	)
	select	:is_end_yy, :is_end_hakgi, member_no, :li_weekend2, :ii_end_month_cre, num_of_time,
				num_of_general, num_of_middle, num_of_large, num_of_etc1,
				num_of_nigeneral, num_of_nimiddle, num_of_nilarge, num_of_nietc1,
				limit_time, time_of_pause1, time_of_pause2, time_of_pause3, time_of_pause4, 
				bogang_sisu_1, bogang_sisu_2, bogang_sisu_3, bogang_sisu_4, 
				num_of_overtime1, num_of_overtime2, num_of_overtime3, num_of_overtime4, 
				misan_sisu_1, misan_sisu_2, misan_sisu_3, misan_sisu_4, 
				:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate, 'C',
				:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate
	from		padb.hpa112t a
	where		year					=	:is_str_yy
	and		hakgi				=	:is_str_hakgi
	and		week_weekend	=	:li_weekend	;
	
	if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	
	li_weekend2 = li_weekend2 + 1
next

return	sqlca.sqlcode

end function

public function integer wf_select_weekend (integer ai_week);// ==========================================================================================
// 기    능 : 	년/학기/주별 월을 구한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_select_weekend(integer	ai_week)	return	integer
// 인    수 :	ai_week	-	week
// 되 돌 림 :	month
// 주의사항 :
// 수정사항 :
// ==========================================================================================

integer	li_str_week, li_end_week, li_month

select	month, from_weekend, to_weekend
into		:li_month, :li_str_week, :li_end_week
from		padb.hpa101m
where		year				=	:is_yy
and		hakgi			=	:is_hakgi
and		from_weekend	<=	:ai_week
and		to_weekend	>=	:ai_week	;

if sqlca.sqlcode <> 0 then
	f_messagebox('1', string(ai_week) + '주차가 존재하지 않습니다. 확인하시기 바랍니다.!')
	return	0
end if

return	li_month

end function

public function integer wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve()	return	integer
// 인    수 :
// 되 돌 림 :	0	-	정상
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_name
integer	li_tab

li_tab  = tab_sheet.selectedtab

idw_list.setfilter("")
idw_list.filter()

idw_list.setredraw(false)
idw_data.setredraw(false)
idw_update[1].setredraw(false)

if idw_list.retrieve(is_yy, is_hakgi, ii_str_week, ii_end_week, ii_str_jikjong, ii_end_jikjong, is_dept, is_duty_code) > 0 then
	if tab_sheet.tabpage_sheet01.rb_4.checked = true then
		idw_list.setfilter("")
		idw_list.filter()
	elseif tab_sheet.tabpage_sheet01.rb_5.checked then
		idw_list.setfilter("gubun = '1'")
		idw_list.filter()
	else
		idw_list.setfilter("gubun = '2'")
		idw_list.filter()
	end if	
//	idw_list.selectrow(0, false)
//	idw_list.selectrow(idw_list.getrow(), true)
	
	wf_retrieve_detail(idw_list.getrow())
	
	idw_print.retrieve(is_yy, is_hakgi, ii_str_week, ii_end_week, ii_str_jikjong, ii_end_jikjong, is_dept, is_duty_code)
else
	idw_print.reset()
end if

idw_update[1].setredraw(true)
idw_data.setredraw(true)
idw_list.setredraw(true)

return 0
end function

public subroutine wf_retrieve_detail (long al_row);// ==========================================================================================
// 기    능 : 	retrieve detail
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_retrieve_detail(long	al_row)
// 인    수 :	al_row	-	row
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

String	ls_member_no

al_row = idw_list.getrow()

if al_row < 1 then 
	idw_data.reset()
	idw_update[1].reset()
	idw_trans.reset()
	return
end if

ls_member_no 	=	idw_list.getitemstring(al_row, 'member_no')

idw_data.retrieve(is_yy, is_hakgi, ii_str_week, ii_end_week, ls_member_no)
idw_trans.retrieve(is_yy, is_hakgi, ls_member_no)

end subroutine

on w_hge505a.create
int iCurrent
call super::create
this.uo_yearhakgi=create uo_yearhakgi
this.uo_2=create uo_2
this.uo_str_week=create uo_str_week
this.uo_end_week=create uo_end_week
this.st_3=create st_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.uo_hakgwa=create uo_hakgwa
this.rb_14=create rb_14
this.rb_7=create rb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yearhakgi
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.uo_str_week
this.Control[iCurrent+4]=this.uo_end_week
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.rb_3
this.Control[iCurrent+9]=this.uo_hakgwa
this.Control[iCurrent+10]=this.rb_14
this.Control[iCurrent+11]=this.rb_7
end on

on w_hge505a.destroy
call super::destroy
destroy(this.uo_yearhakgi)
destroy(this.uo_2)
destroy(this.uo_str_week)
destroy(this.uo_end_week)
destroy(this.st_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.uo_hakgwa)
destroy(this.rb_14)
destroy(this.rb_7)
end on

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

integer	li_newrow, li_week, li_rtn_week, li_month
string	ls_member_no
integer	li_num_of_time, li_num_of_general, li_num_of_middle, li_num_of_large, li_limit_time

if isnull(is_yy) or trim(is_yy) = '' then
	f_messagebox('1', '년도를 선택해 주세요.!')
	uo_yearhakgi.em_yy.selecttext(1, len(uo_yearhakgi.em_yy.text))
	uo_yearhakgi.em_yy.setfocus()
	return
end if

if isnull(is_hakgi) or trim(is_hakgi) = '' then
	f_messagebox('1', '학기를 선택해 주세요.!')
	uo_yearhakgi.em_hakgi.selecttext(1, len(uo_yearhakgi.em_hakgi.text))
	uo_yearhakgi.em_hakgi.setfocus()
	return
end if

if idw_list.rowcount() < 1 then
	f_messagebox('1', '입력할 개인이 존재하지 않습니다.~n~n조회 후 다시 입력해 주시기 바랍니다.!')
	uo_yearhakgi.em_yy.selecttext(1, len(uo_yearhakgi.em_yy.text))
	uo_yearhakgi.em_yy.setfocus()
	return
end if



ls_member_no	=	idw_list.getitemstring(idw_list.getrow(), 'member_no')

li_newrow	=	idw_data.rowcount() + 1
idw_data.insertrow(li_newrow)

idw_data.groupcalc()
idw_data.setrow(li_newrow)

idw_data.setcolumn('week_weekend')
idw_data.setfocus()

idw_data.setitem(li_newrow, 'year',				is_yy)
idw_data.setitem(li_newrow, 'hakgi',			is_hakgi)
idw_data.setitem(li_newrow, 'member_no',		ls_member_no)

if li_newrow > 1 then
	li_week	=	idw_data.getitemnumber(li_newrow - 1, 'week_weekend') + 1
	idw_data.setitem(li_newrow, 'month',				wf_select_weekend(li_week))
	idw_data.setitem(li_newrow - 1, 'month',				wf_select_weekend(li_week))
	idw_data.setitem(li_newrow, 'week_weekend',		li_week)
	idw_data.setitem(li_newrow, 'limit_time',		   idw_data.getitemnumber(li_newrow - 1, 'limit_time'))
	idw_data.setitem(li_newrow, 'num_of_time',		idw_data.getitemnumber(li_newrow - 1, 'num_of_time'))
	idw_data.setitem(li_newrow, 'num_of_general',	idw_data.getitemnumber(li_newrow - 1, 'num_of_general'))
	idw_data.setitem(li_newrow, 'num_of_middle',		idw_data.getitemnumber(li_newrow - 1, 'num_of_middle'))
	idw_data.setitem(li_newrow, 'num_of_large',		idw_data.getitemnumber(li_newrow - 1, 'num_of_large'))
	idw_data.setitem(li_newrow, 'time_of_pause1',	idw_data.getitemnumber(li_newrow - 1, 'time_of_pause1'))
	idw_data.setitem(li_newrow, 'time_of_pause2',	idw_data.getitemnumber(li_newrow - 1, 'time_of_pause2'))
	idw_data.setitem(li_newrow, 'time_of_pause3',	idw_data.getitemnumber(li_newrow - 1, 'time_of_pause3'))
	idw_data.setitem(li_newrow, 'bogang_sisu_1',		idw_data.getitemnumber(li_newrow - 1, 'bogang_sisu_1'))
	idw_data.setitem(li_newrow, 'bogang_sisu_2',		idw_data.getitemnumber(li_newrow - 1, 'bogang_sisu_2'))
	idw_data.setitem(li_newrow, 'bogang_sisu_3',		idw_data.getitemnumber(li_newrow - 1, 'bogang_sisu_3'))
	idw_data.setitem(li_newrow, 'num_of_overtime1',	idw_data.getitemnumber(li_newrow - 1, 'num_of_overtime1'))
	idw_data.setitem(li_newrow, 'num_of_overtime2',	idw_data.getitemnumber(li_newrow - 1, 'num_of_overtime2'))
	idw_data.setitem(li_newrow, 'num_of_overtime3',	idw_data.getitemnumber(li_newrow - 1, 'num_of_overtime3'))
else
	li_num_of_time		=	idw_list.getitemnumber(idw_list.getrow(), 'num_of_time')
	li_num_of_general	=	idw_list.getitemnumber(idw_list.getrow(), 'num_of_general')
	li_num_of_middle	=	idw_list.getitemnumber(idw_list.getrow(), 'num_of_middle')
	li_num_of_large	=	idw_list.getitemnumber(idw_list.getrow(), 'num_of_large')
	li_limit_time    =   idw_list.getitemnumber(idw_list.getrow(), 'limit_time')
	idw_data.setitem(li_newrow, 'num_of_time',		li_num_of_time)
	idw_data.setitem(li_newrow, 'num_of_general',	li_num_of_general)
	idw_data.setitem(li_newrow, 'num_of_middle',		li_num_of_middle)
	idw_data.setitem(li_newrow, 'num_of_large',		li_num_of_large)
	idw_data.setitem(li_newrow, 'limit_time',		   li_limit_time)
	if li_num_of_general - li_num_of_time > 0 then	idw_data.setitem(li_newrow, 'num_of_overtime1',	li_num_of_general - li_num_of_time)
	if li_num_of_middle	- li_num_of_time > 0 then	idw_data.setitem(li_newrow, 'num_of_overtime2',	li_num_of_middle - li_num_of_time)
	if li_num_of_large	- li_num_of_time > 0 then	idw_data.setitem(li_newrow, 'num_of_overtime3',	li_num_of_large - li_num_of_time)
 end if

idw_data.setitem(li_newrow, 'worker',		gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())



end event

event ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
IF dw_name.Update(true) = 1 and idw_update[1].update() = 1 THEN
	if wf_update()	<> 0 then
		f_messagebox('3', sqlca.sqlerrtext)
		rollback	;

		return	1
	end if
	
	COMMIT;
	if idw_data.rowcount() < 1 then
		idw_list.setitem(idw_list.getrow(), 'gubun', '2')
	else		
		idw_list.setitem(idw_list.getrow(), 'gubun', '1')
	end if
	
//	triggerevent('ue_retrieve')
ELSE
  ROLLBACK;
END IF


return 1
end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer	li_deleterow, li_month
string	ls_member_no

wf_setMsg('삭제중')

ls_member_no	=	idw_data.getitemstring(idw_data.getrow(), 'member_no')
li_month			=	idw_data.getitemnumber(idw_data.getrow(), 'month')

if idw_update[1].rowcount() > 0 then
	if f_messagebox('2', '생성된 강사료가 존재합니다. 삭제후에는 다시 생성하셔야 합니다.!~n~n삭제하시겠습니까?') = 2 then return
end if

li_deleterow	=	idw_data.deleterow(0)


wf_setMsg('.')

return 

end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력 처리
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//
//IF idw_print.RowCount() < 1 THEN	return
//
//OpenWithParm(w_printoption, idw_print)
//
//
end event

event ue_open;call super::ue_open;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet01.dw_update1
idw_update[1]	=	tab_sheet.tabpage_sheet01.dw_update2
idw_trans	=	tab_sheet.tabpage_sheet01.dw_list002
idw_print	=	tab_sheet.tabpage_sheet02.dw_print
idw_list_3	=	tab_sheet.tabpage_sheet03.dw_list003
idw_list_4	=	tab_sheet.tabpage_sheet03.dw_list004

is_yy 		=	uo_yearhakgi.uf_getyy()
is_hakgi		=	uo_yearhakgi.uf_gethakgi()

ii_curr_month	=	integer(mid(f_today(), 5, 2))
uo_str_week.uf_setweek(is_yy, is_hakgi, ii_curr_month, 'str')
uo_end_week.uf_setweek(is_yy, is_hakgi, ii_curr_month, 'end')

ii_str_week	=	uo_str_week.uf_getweek()
ii_end_week	=	uo_end_week.uf_getweek()

uo_hakgwa.uf_setdept('1', '학과명')
is_dept	=	uo_hakgwa.uf_getcode()

tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'member_no', 'name')
tab_sheet.tabpage_sheet03.uo_str_month_cre.triggerevent('ue_itemchange')
tab_sheet.tabpage_sheet03.uo_end_month_cre.triggerevent('ue_itemchange')
tab_sheet.selectedtab = 1

end event

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////


wf_retrieve()
return 1
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
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

type ln_templeft from w_tabsheet`ln_templeft within w_hge505a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hge505a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hge505a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hge505a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hge505a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hge505a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hge505a
end type

type uc_insert from w_tabsheet`uc_insert within w_hge505a
end type

type uc_delete from w_tabsheet`uc_delete within w_hge505a
end type

type uc_save from w_tabsheet`uc_save within w_hge505a
end type

type uc_excel from w_tabsheet`uc_excel within w_hge505a
end type

type uc_print from w_tabsheet`uc_print within w_hge505a
end type

type st_line1 from w_tabsheet`st_line1 within w_hge505a
end type

type st_line2 from w_tabsheet`st_line2 within w_hge505a
end type

type st_line3 from w_tabsheet`st_line3 within w_hge505a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hge505a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hge505a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hge505a
integer y = 340
integer width = 4384
integer height = 1944
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
end type

event tab_sheet::selectionchanged;call super::selectionchanged;if oldindex < 0 or newindex < 0 then return

//choose case newindex
//	case	1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//		wf_enabled_check(TRUE)
//	case	2
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
//		wf_enabled_check(TRUE)
//	case else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	fALSE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		fALSE)
//		wf_enabled_check(FALSE)
//end choose 
end event

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
this.tabpage_sheet03=create tabpage_sheet03
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
this.Control[iCurrent+2]=this.tabpage_sheet03
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
destroy(this.tabpage_sheet03)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 1824
string text = "주별시수관리"
gb_4 gb_4
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
uo_3 uo_3
dw_update2 dw_update2
dw_update1 dw_update1
dw_list002 dw_list002
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.uo_3=create uo_3
this.dw_update2=create dw_update2
this.dw_update1=create dw_update1
this.dw_list002=create dw_list002
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.rb_4
this.Control[iCurrent+3]=this.rb_5
this.Control[iCurrent+4]=this.rb_6
this.Control[iCurrent+5]=this.uo_3
this.Control[iCurrent+6]=this.dw_update2
this.Control[iCurrent+7]=this.dw_update1
this.Control[iCurrent+8]=this.dw_list002
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.uo_3)
destroy(this.dw_update2)
destroy(this.dw_update1)
destroy(this.dw_list002)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 1897
integer height = 1004
string dataobject = "d_hge505a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;if isnull(currentrow) or currentrow < 1 then 
	idw_data.reset()
	idw_update[1].reset()
	idw_trans.reset()
	return
end if

//selectrow(0, false)
//selectrow(currentrow, true)

wf_retrieve_detail(currentrow)
end event

event dw_list001::retrieveend;call super::retrieveend;if isnull(rowcount) or rowcount < 1 then 
	idw_data.reset()
	idw_update[1].reset()
	return
end if

trigger event rowfocuschanged(1)

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(False)
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 168
integer width = 1897
integer height = 1004
string dataobject = "d_hge505a_1"
end type

event dw_update_tab::retrieveend;call super::retrieveend;if isnull(rowcount) or rowcount < 1 then 
	idw_data.reset()
	idw_update[1].reset()
	return
end if

trigger event rowfocuschanged(1)

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;if isnull(currentrow) or currentrow < 1 then 
	idw_data.reset()
	idw_update[1].reset()
	idw_trans.reset()
	return
end if

//selectrow(0, false)
//selectrow(currentrow, true)
//
wf_retrieve_detail(currentrow)
end event

type uo_tab from w_tabsheet`uo_tab within w_hge505a
integer x = 1408
integer y = 336
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hge505a
boolean visible = false
integer width = 91
end type

type st_con from w_tabsheet`st_con within w_hge505a
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type gb_4 from groupbox within tabpage_sheet01
integer y = -20
integer width = 4343
integer height = 184
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type rb_4 from radiobutton within tabpage_sheet01
integer x = 1966
integer y = 60
integer width = 224
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "전체"
boolean checked = true
end type

event clicked;rb_4.textcolor = rgb(0, 0, 255)
rb_5.textcolor = rgb(0, 0, 0)
rb_6.textcolor = rgb(0, 0, 0)

idw_list.setfilter("")
idw_list.filter()

//idw_list.selectrow(0, false)
//idw_list.selectrow(idw_list.getrow(), true)

wf_retrieve_detail(idw_list.getrow())

end event

type rb_5 from radiobutton within tabpage_sheet01
integer x = 2382
integer y = 60
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "생성된 자료"
end type

event clicked;rb_5.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)
rb_6.textcolor = rgb(0, 0, 0)

idw_list.setfilter("gubun = '1'")
idw_list.filter()

//idw_list.selectrow(0, false)
//idw_list.selectrow(idw_list.getrow(), true)

wf_retrieve_detail(idw_list.getrow())

end event

type rb_6 from radiobutton within tabpage_sheet01
integer x = 2907
integer y = 60
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "생성될 자료"
end type

event clicked;rb_6.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)
rb_5.textcolor = rgb(0, 0, 0)

idw_list.setfilter("gubun = '2'")
idw_list.filter()

//idw_list.selectrow(0, false)
//idw_list.selectrow(idw_list.getrow(), true)

wf_retrieve_detail(idw_list.getrow())

end event

type uo_3 from cuo_search_insa within tabpage_sheet01
integer x = 101
integer y = 40
integer width = 1678
integer taborder = 30
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type dw_update2 from uo_dwgrid within tabpage_sheet01
integer x = 1897
integer y = 168
integer width = 2446
integer height = 1004
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_hge505a_3"
boolean minbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;// 지급금액과 소급금을 수정시 합계금액을 Update 한다.
if dwo.name = 'retro_amt' or dwo.name = 'month_amt' then
	setitem(row, 'pay_amt',	getitemnumber(row, 'month_amt') + getitemnumber(row, 'retro_amt'))
end if

setitem(row, 'job_uid',		gstru_uid_uname.uid)
setitem(row, 'job_add',		gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())

end event

type dw_update1 from uo_dwgrid within tabpage_sheet01
integer x = 5
integer y = 1272
integer width = 4338
integer height = 548
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hge505a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화

integer	li_ju_time[], li_ya_time[], li_skip_time[], li_supp_time[], li_tran_time[]
integer	li_time, i, li_week, li_limit_time
integer	li_overtime[], li_bef_week
string	ls_old_duty_yn, ls_colname, ls_DutyCode, ls_MemberNo

li_bef_week = getitemnumber(row, 'week_weekend')

ls_colname = dwo.name	

accepttext()

li_limit_time		=	getitemnumber(row, 'limit_time')			//한계시수
li_time				=	getitemnumber(row, 'num_of_time')		//책임시수
li_ju_time[1]		=	getitemnumber(row, 'num_of_general')	//일반시수
li_ju_time[2]		=	getitemnumber(row, 'num_of_middle')		//분반시수
li_ju_time[3]		=	getitemnumber(row, 'num_of_large')		//합반시수
li_ju_time[4]		=	getitemnumber(row, 'num_of_etc1')		//예비
li_skip_time[1]	=	getitemnumber(row, 'time_of_pause1')		//휴일반
li_skip_time[2]	=	getitemnumber(row, 'time_of_pause2')		//휴뷴반
li_skip_time[3]	=	getitemnumber(row, 'time_of_pause3')		//휴합반
li_skip_time[4]	=	getitemnumber(row, 'time_of_pause4')		//예비
li_supp_time[1]	=	getitemnumber(row, 'bogang_sisu_1')			//보강시수
li_supp_time[2]	=	getitemnumber(row, 'bogang_sisu_2')			//보강분반
li_supp_time[3]	=	getitemnumber(row, 'bogang_sisu_3')			//보강합반
li_supp_time[4]	=	getitemnumber(row, 'bogang_sisu_4')			//예비
li_tran_time[1]	=	getitemnumber(row, 'misan_sisu_1')			//대체시수
li_tran_time[2]	=	getitemnumber(row, 'misan_sisu_2')			//대체분반
li_tran_time[3]	=	getitemnumber(row, 'misan_sisu_3')			//대체합반
li_tran_time[4]	=	getitemnumber(row, 'misan_sisu_4')			//대체
ls_MemberNo			=	getitemString(row, 'member_no')
ls_DutyCode			=	getitemString(row, 'duty_code')
 
data	=	trim(data)

li_ju_time  [5]	=	0
li_skip_time[5]	=	0
li_supp_time[5]	=	0
li_tran_time[5]	=	0
//초과시수=일반-결강-보강-책임+대체 --- 이게 각각으로 나누어질 경우에 처리한다.
//for	i	=	1 to	1
if	isnull(li_ju_time[1])   then li_ju_time[1] = 0
if	isnull(li_skip_time[1]) then li_skip_time[1] = 0
if	isnull(li_supp_time[1]) then li_supp_time[1] = 0
if	isnull(li_time) 			then li_time = 0
if	isnull(li_tran_time[1]) then li_tran_time[1] = 0

li_overtime[1]	=	li_ju_time[1]  - li_skip_time[1] + li_supp_time[1] - li_time + li_tran_time[1]
setitem(row, 'num_of_overtime1', li_overtime[1])
//next

if dwo.name = 'week_weekend' then		//주에서 입력이 일으나면
	setitem(row, 'month',	wf_select_weekend(integer(data)))
end if

setitem(row, 'job_uid',		gstru_uid_uname.uid)
setitem(row, 'job_add',		gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())


end event

event losefocus;call super::losefocus;accepttext()
end event

event retrieveend;call super::retrieveend;if isnull(rowcount) or rowcount < 1 then
	idw_update[1].reset()
	return
end if

trigger event rowfocuschanged(1)

end event

event rowfocuschanged;call super::rowfocuschanged;if isnull(currentrow) or currentrow < 1 then	
	idw_update[1].reset()
	return
end if

string	ls_member_no
integer	li_month

ls_member_no	=	idw_list.getitemstring(idw_list.getrow(), 'member_no')
li_month			=	getitemnumber(currentrow, 'month')

idw_update[1].retrieve(is_yy, is_hakgi, li_month, ls_member_no)
end event

type dw_list002 from uo_dwfree within tabpage_sheet01
integer y = 1172
integer width = 4343
integer height = 104
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hge505a_6"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1824
long backcolor = 79741120
string text = "주별시수내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_sheet02.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_sheet02.destroy
destroy(this.dw_print)
end on

type dw_print from cuo_dwprint within tabpage_sheet02
integer width = 4338
integer height = 1848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hge505a_5"
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet03 from userobject within tab_sheet
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 104
integer width = 4347
integer height = 1824
long backcolor = 79741120
string text = "주별시수생성"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list004 dw_list004
dw_list003 dw_list003
gb_11 gb_11
gb_3 gb_3
uo_end uo_end
uo_str uo_str
st_31 st_31
st_4 st_4
pb_1 pb_1
uo_str_month uo_str_month
uo_end_month uo_end_month
uo_str_week_cre uo_str_week_cre
uo_end_week_cre uo_end_week_cre
uo_str_month_cre uo_str_month_cre
uo_end_month_cre uo_end_month_cre
end type

on tabpage_sheet03.create
this.dw_list004=create dw_list004
this.dw_list003=create dw_list003
this.gb_11=create gb_11
this.gb_3=create gb_3
this.uo_end=create uo_end
this.uo_str=create uo_str
this.st_31=create st_31
this.st_4=create st_4
this.pb_1=create pb_1
this.uo_str_month=create uo_str_month
this.uo_end_month=create uo_end_month
this.uo_str_week_cre=create uo_str_week_cre
this.uo_end_week_cre=create uo_end_week_cre
this.uo_str_month_cre=create uo_str_month_cre
this.uo_end_month_cre=create uo_end_month_cre
this.Control[]={this.dw_list004,&
this.dw_list003,&
this.gb_11,&
this.gb_3,&
this.uo_end,&
this.uo_str,&
this.st_31,&
this.st_4,&
this.pb_1,&
this.uo_str_month,&
this.uo_end_month,&
this.uo_str_week_cre,&
this.uo_end_week_cre,&
this.uo_str_month_cre,&
this.uo_end_month_cre}
end on

on tabpage_sheet03.destroy
destroy(this.dw_list004)
destroy(this.dw_list003)
destroy(this.gb_11)
destroy(this.gb_3)
destroy(this.uo_end)
destroy(this.uo_str)
destroy(this.st_31)
destroy(this.st_4)
destroy(this.pb_1)
destroy(this.uo_str_month)
destroy(this.uo_end_month)
destroy(this.uo_str_week_cre)
destroy(this.uo_end_week_cre)
destroy(this.uo_str_month_cre)
destroy(this.uo_end_month_cre)
end on

type dw_list004 from cuo_dwwindow within tabpage_sheet03
integer y = 1292
integer width = 3845
integer height = 888
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "주별 시수 자료"
string dataobject = "d_hge505a_4"
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_list_3, 'member_no')

//ll_row = idw_list_4.find("member_no = '" + getitemstring(currentrow, 'member_no') + "' and getrow = " + string(getitemnumber(currentrow, 'getrow')) + "	", 1, idw_list_4.rowcount())
//if ll_row < 1 then
//	idw_list_3.selectrow(0, false)
//else
//	idw_list_3.scrolltorow(ll_row)
//end if
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_list_3, this, 'member_no')

end event

event constructor;call super::constructor;this.uf_setClick(False)
end event

type dw_list003 from cuo_dwwindow within tabpage_sheet03
integer y = 404
integer width = 3845
integer height = 888
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "주별 시수 자료"
string dataobject = "d_hge505a_4"
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_list_4, 'member_no')

//ll_row = idw_list_4.find("member_no = '" + getitemstring(currentrow, 'member_no') + "' and getrow = " + string(getitemnumber(currentrow, 'getrow')) + "	", 1, idw_list_4.rowcount())
//if ll_row < 1 then
//	idw_list_4.selectrow(0, false)
//else
//	idw_list_4.scrolltorow(ll_row)
//end if
end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_list_4, this, 'member_no')

end event

event constructor;call super::constructor;this.uf_setClick(False)
end event

type gb_11 from groupbox within tabpage_sheet03
integer y = 20
integer width = 2885
integer height = 380
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "생성조건"
end type

type gb_3 from groupbox within tabpage_sheet03
integer x = 2889
integer y = 20
integer width = 955
integer height = 380
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_end from cuo_yyhakgi within tabpage_sheet03
event destroy ( )
integer x = 238
integer y = 248
integer width = 1024
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

on uo_end.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;wf_dw_title()

end event

type uo_str from cuo_yyhakgi within tabpage_sheet03
event destroy ( )
integer x = 238
integer y = 100
integer width = 1015
integer taborder = 70
boolean bringtotop = true
boolean border = false
end type

on uo_str.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;wf_dw_title()

end event

type st_31 from statictext within tabpage_sheet03
integer x = 1824
integer y = 128
integer width = 270
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "의 자료를"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_sheet03
integer x = 1824
integer y = 276
integer width = 590
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "의 자료로 생성합니다."
boolean focusrectangle = false
end type

type pb_1 from picturebutton within tabpage_sheet03
integer x = 3154
integer y = 168
integer width = 443
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "  생성처리 "
string picturename = "..\bmp\PROCES_E.BMP"
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// 자료를 생성한다.

integer	li_rtn

li_rtn	=	wf_create()

if li_rtn = 0 then
	commit	;
	f_messagebox('1', is_end_yy + '년도 ' + is_end_hakgi + '학기 ' + string(ii_end_month_cre) + '월의 자료를~n~n성공적으로 생성했습니다.!')
	wf_dw_title()
elseif li_rtn < 0 then	
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
end if



end event

type uo_str_month from cuo_month within tabpage_sheet03
event destroy ( )
boolean visible = false
integer x = 2478
integer y = 100
integer taborder = 60
boolean bringtotop = true
boolean border = false
end type

on uo_str_month.destroy
call cuo_month::destroy
end on

event ue_itemchange;call super::ue_itemchange;//is_str_yy		=	uo_str.uf_getyy()
//is_str_hakgi	=	uo_str.uf_gethakgi()
//ii_str_month	=	integer(uf_getmm())
//
//idw_list_3.title = is_str_yy + '년도 ' + is_str_hakgi + '학기 ' + string(ii_str_month) + '월 주별 시수 자료'
//
//idw_list_3.retrieve(is_str_yy, is_str_hakgi, ii_str_month)
//
end event

type uo_end_month from cuo_month within tabpage_sheet03
event destroy ( )
boolean visible = false
integer x = 2478
integer y = 248
integer taborder = 70
boolean bringtotop = true
boolean border = false
end type

on uo_end_month.destroy
call cuo_month::destroy
end on

event ue_itemchange;call super::ue_itemchange;//is_end_yy		=	uo_end.uf_getyy()
//is_end_hakgi	=	uo_end.uf_gethakgi()
//ii_end_month	=	integer(uf_getmm())
//
//idw_list_4.title = is_end_yy + '년도 ' + is_end_hakgi + '학기 ' + string(ii_end_month) + '월 주별 시수 자료'
//
//idw_list_4.retrieve(is_end_yy, is_end_hakgi, ii_end_month)
end event

type uo_str_week_cre from cuo_week within tabpage_sheet03
integer x = 1335
integer y = 104
integer taborder = 60
boolean bringtotop = true
end type

event ue_itemchange;call super::ue_itemchange;wf_dw_title()

end event

on uo_str_week_cre.destroy
call cuo_week::destroy
end on

type uo_end_week_cre from cuo_week within tabpage_sheet03
integer x = 1335
integer y = 252
integer taborder = 70
boolean bringtotop = true
end type

on uo_end_week_cre.destroy
call cuo_week::destroy
end on

event ue_itemchange;call super::ue_itemchange;wf_dw_title()
end event

type uo_str_month_cre from cuo_month within tabpage_sheet03
integer x = 1335
integer y = 100
integer height = 116
integer taborder = 70
boolean bringtotop = true
boolean border = false
end type

on uo_str_month_cre.destroy
call cuo_month::destroy
end on

event ue_itemchange;call super::ue_itemchange;wf_dw_title()
end event

type uo_end_month_cre from cuo_month within tabpage_sheet03
integer x = 1335
integer y = 248
integer height = 116
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_end_month_cre.destroy
call cuo_month::destroy
end on

event ue_itemchange;call super::ue_itemchange;wf_dw_title()
end event

type uo_yearhakgi from cuo_yyhakgi within w_hge505a
integer x = 110
integer y = 176
integer width = 1001
integer height = 104
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_yearhakgi.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yy 	= uf_getyy()
is_hakgi	= uf_gethakgi()
if is_hakgi =' ' then
	is_hakgi ='1'
end if

end event

event constructor;call super::constructor;is_hakgi	= uf_gethakgi()
if is_hakgi =' ' then
	is_hakgi ='1'
end if
end event

type uo_2 from cuo_month within w_hge505a
boolean visible = false
integer x = 2153
integer y = 324
integer taborder = 70
boolean bringtotop = true
boolean border = false
end type

event ue_itemchange;call super::ue_itemchange;//ii_month	= integer(uf_getmm())
//
//parent.triggerevent('ue_retrieve')
end event

on uo_2.destroy
call cuo_month::destroy
end on

type uo_str_week from cuo_week within w_hge505a
integer x = 1147
integer y = 176
integer taborder = 30
boolean bringtotop = true
end type

on uo_str_week.destroy
call cuo_week::destroy
end on

event ue_itemchange;call super::ue_itemchange;ii_str_week	=	uf_getweek()

if ii_str_week = 0 then
	ii_end_week	=	0
else
	ii_end_week	=	ii_str_week + 3
end if
uo_end_week.em_week.text = string(ii_end_week)


end event

type uo_end_week from cuo_week within w_hge505a
integer x = 1495
integer y = 176
integer width = 334
integer taborder = 40
boolean bringtotop = true
end type

on uo_end_week.destroy
call cuo_week::destroy
end on

event ue_itemchange;call super::ue_itemchange;ii_end_week	=	uf_getweek()


end event

type st_3 from statictext within w_hge505a
integer x = 1458
integer y = 188
integer width = 59
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_hge505a
integer x = 2958
integer y = 192
integer width = 224
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 31112622
string text = "전체"
boolean checked = true
end type

event clicked;ii_str_jikjong = 1
ii_end_jikjong = 3
is_duty_code = '%'
rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)
rb_7.textcolor = rgb(0, 0, 0)
rb_14.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_2 from radiobutton within w_hge505a
integer x = 3159
integer y = 192
integer width = 224
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "전임"
end type

event clicked;ii_str_jikjong = 1
ii_end_jikjong = 2
is_duty_code   = '10'
rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)
rb_14.textcolor = rgb(0, 0, 0)
rb_7.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_3 from radiobutton within w_hge505a
integer x = 3675
integer y = 192
integer width = 192
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "외래"
end type

event clicked;ii_str_jikjong = 3
ii_end_jikjong = 3
is_duty_code   ='301'
rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 255)
rb_7.textcolor = rgb(0, 0, 0)
rb_14.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type uo_hakgwa from cuo_dept within w_hge505a
event destroy ( )
integer x = 1801
integer y = 180
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

on uo_hakgwa.destroy
call cuo_dept::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_dept = uf_getcode()

parent.triggerevent('ue_retrieve')
end event

type rb_14 from radiobutton within w_hge505a
integer x = 3355
integer y = 192
integer width = 302
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "강의전담"
end type

event clicked;ii_str_jikjong = 1
ii_end_jikjong = 3
is_duty_code   = '115'
rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_14.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)
rb_7.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_7 from radiobutton within w_hge505a
integer x = 3881
integer y = 192
integer width = 192
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 31112622
string text = "겸임"
end type

event clicked;ii_str_jikjong = 1
ii_end_jikjong = 1
is_duty_code   ='111'
rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)
rb_7.textcolor = rgb(0, 0, 255)
rb_14.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

