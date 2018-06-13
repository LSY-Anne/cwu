$PBExportHeader$w_hge504a.srw
$PBExportComments$강사료 지급 기초 관리/출력
forward
global type w_hge504a from w_tabsheet
end type
type uo_3 from cuo_search_insa within tabpage_sheet01
end type
type dw_update from uo_dwfree within tabpage_sheet01
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
type dw_list003 from cuo_dwwindow within tabpage_sheet03
end type
type gb_3 from groupbox within tabpage_sheet03
end type
type gb_11 from groupbox within tabpage_sheet03
end type
type uo_str from cuo_yyhakgi within tabpage_sheet03
end type
type uo_end from cuo_yyhakgi within tabpage_sheet03
end type
type st_3 from statictext within tabpage_sheet03
end type
type st_4 from statictext within tabpage_sheet03
end type
type pb_1 from picturebutton within tabpage_sheet03
end type
type dw_list004 from cuo_dwwindow within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_list003 dw_list003
gb_3 gb_3
gb_11 gb_11
uo_str uo_str
uo_end uo_end
st_3 st_3
st_4 st_4
pb_1 pb_1
dw_list004 dw_list004
end type
type rb_1 from radiobutton within w_hge504a
end type
type rb_2 from radiobutton within w_hge504a
end type
type rb_4 from radiobutton within w_hge504a
end type
type uo_gwa from cuo_dept within w_hge504a
end type
type dw_list002 from datawindow within w_hge504a
end type
type rb_6 from radiobutton within w_hge504a
end type
type uo_yearhakgi from cuo_yearschoolterm within w_hge504a
end type
type uo_mm from cuo_mm within w_hge504a
end type
type rb_3 from radiobutton within w_hge504a
end type
end forward

global type w_hge504a from w_tabsheet
string title = "강사 지급 기초 관리/출력"
rb_1 rb_1
rb_2 rb_2
rb_4 rb_4
uo_gwa uo_gwa
dw_list002 dw_list002
rb_6 rb_6
uo_yearhakgi uo_yearhakgi
uo_mm uo_mm
rb_3 rb_3
end type
global w_hge504a w_hge504a

type variables
datawindowchild	idw_child, idw_child2, idw_child_member, idw_child_kname, idw_child_trans_member, idw_child_trans_name
datawindow			idw_list, idw_data,  idw_list_3, idw_list_4
datawindow			idw_week

statictext			ist_back

string	is_yy, is_hakgi, is_dept, is_duty
string	is_str_yy, is_end_yy
string	is_str_hakgi, is_end_hakgi
integer	ii_month

end variables

forward prototypes
public subroutine wf_getchild_bank ()
public subroutine wf_setitem (string as_colname, string as_data)
public subroutine wf_getchild ()
public subroutine wf_dwcopy ()
public subroutine wf_enabled_check (boolean ab_check)
public function integer wf_create ()
public function integer wf_retrieve ()
end prototypes

public subroutine wf_getchild_bank ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild_bank()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 이체은행계좌
idw_data.getchild('acct_no', idw_child2)
idw_child2.settransobject(sqlca)
if idw_child2.retrieve(idw_data.getitemstring(idw_data.getrow(), 'member_no'), 2) < 1 then
	idw_child2.reset()
	idw_child2.insertrow(0)
end if
end subroutine

public subroutine wf_setitem (string as_colname, string as_data);// ==========================================================================================
// 기    능 : 	datawindow setitem
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_setitem(string as_colname, string as_data)
// 인    수 :	as_colname	-	column name
//					as_data		-	data
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_type

ls_type 	= idw_data.describe(as_colname + ".coltype")

idw_data.accepttext()

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(idw_list.getrow(), as_colname, dec(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, dec(as_data))
elseif ls_type = 'date' then
	idw_list.setitem(idw_list.getrow(), as_colname, date(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, date(as_data))
elseif ls_type = 'datetime' then
	idw_list.setitem(idw_list.getrow(), as_colname, datetime(date(left(as_data, 10)), time(right(as_data, 8))))
	idw_data.setitem(idw_data.getrow(), as_colname, datetime(date(left(as_data, 10)), time(right(as_data, 8))))
else	
	idw_list.setitem(idw_list.getrow(), as_colname, trim(as_data))
	idw_data.setitem(idw_data.getrow(), as_colname, trim(as_data))
end if

end subroutine

public subroutine wf_getchild ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 강사료구분
idw_data.getchild('sec_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('sec_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 은행코드
idw_data.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('bank_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bank_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_data.getchild('acct_no', idw_child2)
idw_child2.settransobject(sqlca)
idw_child2.reset()
idw_child2.insertrow(0)

// 개인번호
idw_data.getchild('member_no', idw_child_member)
idw_child_member.settransobject(sqlca)
if idw_child_member.retrieve(0, 3, '') < 1 then
	idw_child_member.reset()
	idw_child_member.insertrow(0)
end if

idw_data.getchild('name', idw_child_kname)
idw_child_kname.settransobject(sqlca)
if idw_child_kname.retrieve(0, 3, '') < 1 then
	idw_child_kname.reset()
	idw_child_kname.insertrow(0)
end if

// 대체자개인번호
idw_data.getchild('hpa111m_trans_member_no', idw_child_trans_member)
idw_child_trans_member.settransobject(sqlca)
if idw_child_trans_member.retrieve(0, 3, '') < 1 then
	idw_child_trans_member.reset()
	idw_child_trans_member.insertrow(0)
end if

idw_data.getchild('hpa111m_trans_name', idw_child_trans_name)
idw_child_trans_name.settransobject(sqlca)
if idw_child_trans_name.retrieve(0, 3, '') < 1 then
	idw_child_trans_name.reset()
	idw_child_trans_name.insertrow(0)
end if



end subroutine

public subroutine wf_dwcopy ();// ==========================================================================================
// 기    능 : 	datawindow copy
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_dwcopy()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

string	ls_val[]
long		ll_row

ll_row	=	idw_list.getrow()

idw_data.reset()

if ll_row < 1 then	return

idw_list.rowscopy(ll_row, ll_row, primary!, idw_data, 1, primary!) 

ls_val[1] = idw_list.getitemstring(ll_row, 'dept_name')
ls_val[2] = idw_list.getitemstring(ll_row, 'jikjong_fname')
ls_val[3] = idw_list.getitemstring(ll_row, 'duty_name')

idw_data.modify("t_dept_name.text = '" +		ls_val[1] + "'	")
idw_data.modify("t_jikjong_name.text = '" + 	ls_val[2] + "'	")
idw_data.modify("t_duty_name.text = '" + 	 	ls_val[3] + "'	")

wf_getchild_bank()
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

uo_yearhakgi.em_year.enabled				=	ab_check
uo_yearhakgi.em_term.enabled			=	ab_check
uo_gwa.uf_enabled_check(ab_check)
rb_1.enabled						=	ab_check
rb_2.enabled						=	ab_check
rb_6.enabled						=	ab_check
rb_4.enabled						=	ab_check
rb_3.enabled						=	ab_check

end subroutine

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	자료를 생성한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 기존의 자료 체크
tab_sheet.tabpage_sheet03.uo_str.triggerevent('ue_itemchange')
tab_sheet.tabpage_sheet03.uo_end.triggerevent('ue_itemchange')

if idw_list_3.rowcount() < 1 then
	f_messagebox('1', is_str_yy + '년도 ' + is_str_hakgi + '학기의 자료가 존재하지 않습니다.!')
	return	100
end if

// 생성할 자료 체크
if idw_list_4.rowcount() > 0 then
	if f_messagebox('2', is_end_yy + '년도 ' + is_end_hakgi + '학기의 자료가 이미 존재합니다.~n'								+	&
								'재생성시 ' + is_end_hakgi + '학기의 주별시수자료와 지급강사료자료도 모두 삭제됩니다.~n~n'	+	&
								'삭제후 다시 생성하시겠습니까?') = 1 then
		delete	from	padb.hpa116t
		where		year		=	:is_end_yy
		and		hakgi	=	:is_end_hakgi	;

		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
		
		delete	from	padb.hpa113t
		where		year		=	:is_end_yy
		and		hakgi	=	:is_end_hakgi	;

		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

		delete	from	padb.hpa112t
		where		year		=	:is_end_yy
		and		hakgi	=	:is_end_hakgi	;

		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

		delete	from	padb.hpa111m
		where		year		=	:is_end_yy
		and		hakgi	=	:is_end_hakgi	;
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	else
		return	100
	end if
else
	if f_messagebox('2', is_end_yy + '년도 ' + is_end_hakgi + '학기의 자료를 생성하시겠습니까?') <> 1 then	return	100
end if

idw_list_4.reset()

// Insert
insert	into	padb.hpa111m	
		(	year, hakgi, member_no, name, gwa, jikjong_code, 
			duty_code, sec_code, sal_class, bank_code, acct_no, 
			trans_member_no, trans_name, trans_remark,
			num_of_time, 
			num_of_general, num_of_middle, num_of_large, num_of_etc1,
			num_of_nigeneral, num_of_nimiddle, num_of_nilarge, num_of_nietc1,
			limit_time, holiday_opt, 
			worker, ipaddr, work_date,
			job_uid, job_add, job_date	)
select	:is_end_yy, :is_end_hakgi, member_no, name, gwa, jikjong_code,
			duty_code, sec_code, sal_class, bank_code, acct_no,
			trans_member_no, trans_name, trans_remark,
			num_of_time, 
			num_of_general, num_of_middle, num_of_large, num_of_etc1,
			num_of_nigeneral, num_of_nimiddle, num_of_nilarge, num_of_nietc1,
			limit_time, holiday_opt, 
			:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate,
			:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate
from		padb.hpa111m
where		year	=	:is_str_yy
and		hakgi	=	:is_str_hakgi	;

if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode

return	sqlca.sqlcode



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

li_tab   = tab_sheet.selectedtab
ii_month	= integer(uo_mm.uf_getmm())
is_yy		= uo_yearhakgi.em_year.Text
is_hakgi = uo_yearhakgi.em_term.Text
is_dept  = uo_gwa.uf_getcode()
if	rb_1.checked then
	is_duty	=	''
elseif rb_2.checked then
	is_duty  =  '10'
elseif rb_6.checked then
	is_duty  =  '115' 
elseif rb_4.checked then
	is_duty  =  '301'
elseif rb_3.checked then
	is_duty  =  '111'
end if
if idw_list.retrieve(is_yy, is_hakgi, is_dept, is_duty) > 0 then
	idw_print.retrieve(is_yy, is_hakgi, is_dept, is_duty)
else
	idw_print.reset()
end if

tab_sheet.tabpage_sheet03.uo_str.triggerevent('ue_itemchange')
tab_sheet.tabpage_sheet03.uo_end.triggerevent('ue_itemchange')

return 0
end function

on w_hge504a.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_4=create rb_4
this.uo_gwa=create uo_gwa
this.dw_list002=create dw_list002
this.rb_6=create rb_6
this.uo_yearhakgi=create uo_yearhakgi
this.uo_mm=create uo_mm
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_4
this.Control[iCurrent+4]=this.uo_gwa
this.Control[iCurrent+5]=this.dw_list002
this.Control[iCurrent+6]=this.rb_6
this.Control[iCurrent+7]=this.uo_yearhakgi
this.Control[iCurrent+8]=this.uo_mm
this.Control[iCurrent+9]=this.rb_3
end on

on w_hge504a.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_4)
destroy(this.uo_gwa)
destroy(this.dw_list002)
destroy(this.rb_6)
destroy(this.uo_yearhakgi)
destroy(this.uo_mm)
destroy(this.rb_3)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

wf_retrieve()
return 1
end event

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

integer	li_newrow, li_newrow2

if isnull(is_yy) or trim(is_yy) = '' then
	f_messagebox('1', '년도를 선택해 주세요.!')
	uo_yearhakgi.em_year.selecttext(1, len(uo_yearhakgi.em_year.text))
	uo_yearhakgi.em_year.setfocus()
	return
end if

if isnull(is_hakgi) or trim(is_hakgi) = '' then
	f_messagebox('1', '학기를 선택해 주세요.!')
	uo_yearhakgi.em_term.selecttext(1, len(uo_yearhakgi.em_term.text))
	uo_yearhakgi.em_term.setfocus()
	return
end if



//idw_data.Selectrow(0, false)	

idw_data.reset()
li_newrow	=	1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

li_newrow2 	=	idw_list.getrow() + 1
idw_list.insertrow(li_newrow2)
idw_list.setrow(li_newrow2)

idw_data.setcolumn('member_no')
idw_data.setfocus()

idw_data.setitem(li_newrow, 'year',			is_yy)
idw_data.setitem(li_newrow, 'hakgi',		is_hakgi)
idw_data.setitem(li_newrow, 'sal_class',	'0')

idw_list.setitem(li_newrow2, 'year',			is_yy)
idw_list.setitem(li_newrow2, 'hakgi',		is_hakgi)
idw_list.setitem(li_newrow2, 'sal_class',	'0')

idw_data.modify("t_dept_name.text = ''	")
idw_data.modify("t_jikjong_name.text = ''	")
idw_data.modify("t_duty_name.text = ''	")

idw_list.setitem(li_newrow2, 'worker',		gstru_uid_uname.uid)
idw_list.setitem(li_newrow2, 'ipaddr',		gstru_uid_uname.address)
idw_list.setitem(li_newrow2, 'work_date',	f_sysdate())



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
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_print	=	tab_sheet.tabpage_sheet02.dw_print
idw_list_3	=	tab_sheet.tabpage_sheet03.dw_list003
idw_list_4	=	tab_sheet.tabpage_sheet03.dw_list004

idw_week		=	dw_list002

idw_data.settransobject(sqlca)

tab_sheet.tabpage_sheet01.uo_3.sle_name.text = ''


wf_getchild()

is_yy 	=	uo_yearhakgi.uf_getyy()
is_hakgi	=	uo_yearhakgi.uf_gethakgi()

//uo_gwa.uf_setdept('1', '학과명')
//is_dept	=	uo_gwa.uf_getcode()
//is_duty	=	''
//
tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'member_no', 'name')
tab_sheet.tabpage_sheet03.uo_str.triggerevent('ue_itemchange')
tab_sheet.tabpage_sheet03.uo_end.triggerevent('ue_itemchange')

tab_sheet.selectedtab = 1

end event

event ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow
double ld_num_of_nigeneral

integer	li_month, li_str_week, li_end_week, li_week_count, li_week
integer	li_sisu1, li_sisu2, li_sisu3, li_sisu4, i
long		ll_time, ll_rowcount, ll_row, ll_updaterow[], ll_row2, ll_limit_time
string	ls_member_no

string	ls_name, ls_bojik_code, ls_gwa, ls_duty_code, ls_sal_class, ls_acct_no
integer	li_jikjong_code, li_sec_code, li_bank_code



dw_name   = idw_list  	                 		//저장하고자하는 데이타 원도우

dw_name.accepttext()

ll_rowcount	=	dw_name.rowcount()
ll_row2		=	0
for	ll_row	=	1	to ll_rowcount
	if dw_name.describe("evaluate('isRowNew()', " + string(ll_row) + ")"	)	=	'true' then
		ll_row2	++
		ll_updaterow[ll_row2] = ll_row
	end if
next

IF dw_name.Update(true) = 1 THEN
	ll_rowcount	=	upperbound(ll_updaterow)
	
	for	ll_row	=	1	to	ll_rowcount
		idw_week.retrieve(is_yy, is_hakgi)
		li_week_count 	= 	idw_week.rowcount()
		
		ls_member_no		=	dw_name.getitemstring(ll_updaterow[ll_row], 'member_no')
		ls_name				=	dw_name.getitemstring(ll_updaterow[ll_row], 'name')
		ls_bojik_code		=	dw_name.getitemstring(ll_updaterow[ll_row], 'bojik_code')
		ls_gwa				=	dw_name.getitemstring(ll_updaterow[ll_row], 'gwa')
		li_jikjong_code	=	dw_name.getitemnumber(ll_updaterow[ll_row], 'jikjong_code')
		ls_duty_code		=	dw_name.getitemstring(ll_updaterow[ll_row], 'duty_code')
		li_sec_code			=	dw_name.getitemnumber(ll_updaterow[ll_row], 'sec_code')
		ls_sal_class		=	dw_name.getitemstring(ll_updaterow[ll_row], 'sal_class')
		li_bank_code		=	dw_name.getitemnumber(ll_updaterow[ll_row], 'bank_code')
		ls_acct_no			=	dw_name.getitemstring(ll_updaterow[ll_row], 'acct_no')
	   ll_time			   = 	dw_name.getitemnumber(ll_updaterow[ll_row], 'num_of_time')
		li_sisu1			   =	dw_name.getitemnumber(ll_updaterow[ll_row], 'num_of_general')
		li_sisu2			   =	dw_name.getitemnumber(ll_updaterow[ll_row], 'num_of_middle')
		li_sisu3			   =	dw_name.getitemnumber(ll_updaterow[ll_row], 'num_of_large')
		decimal ld_num_of_nietc1
		ld_num_of_nietc1 =	dw_name.getitemdecimal(ll_updaterow[ll_row], 'num_of_nietc1')
		ll_limit_time	   =	dw_name.getitemnumber(ll_updaterow[ll_row], 'limit_time')

		for	i	=	1 to	li_week_count
			li_month		=	idw_week.getitemnumber(i, 'month')
			li_str_week	=	idw_week.getitemnumber(i, 'from_weekend')
			li_end_week	=	idw_week.getitemnumber(i, 'to_weekend')
			INSERT INTO "PADB"."HPA111H"  
						 ( "YEAR",             	"HAKGI",          	"MONTH",	"MEMBER_NO",   	"NAME",   "BOJIK_CODE",
							"GWA",        			"JIKJONG_CODE",   	"DUTY_CODE",    	"SEC_CODE",   
							"SAL_CLASS",        	"BANK_CODE",      	"ACCT_NO",      	"NUM_OF_TIME",   
							"NUM_OF_GENERAL",   	"NUM_OF_MIDDLE",  	"NUM_OF_LARGE", 	"NUM_OF_ETC1", 
							"NUM_OF_NIGENERAL", 	"NUM_OF_NIMIDDLE",	"NUM_OF_NILARGE", "NUM_OF_NIETC1", 
							"LIMIT_TIME",   		"HOLIDAY_OPT",   		
							"WORKER",          	"IPADDR",         "WORK_DATE",   
							"JOB_UID",          	"JOB_ADD",        "JOB_DATE" )  
				VALUES ( :is_yy,            :is_hakgi,        :li_month, :ls_member_no,  :ls_name,		:ls_bojik_code,
							:ls_gwa,           :li_jikjong_code, :ls_duty_code,    :li_sec_code,
							:ls_sal_class,     :li_bank_code,    :ls_acct_no,      :ll_time,
							:li_sisu1,         :li_sisu2,        :li_sisu3,        0,
							0,                 0,                0,                :ld_num_of_nietc1,	
							:ll_limit_time,	'0',					
							:gstru_uid_uname.uid,:gstru_uid_uname.address,sysdate,
							:gstru_uid_uname.uid,:gstru_uid_uname.address,sysdate)	;
							
				if sqlca.sqlcode <> 0 then	
//					f_messagebox('3', sqlca.sqlerrtext)
//					rollback	;
					UPDATE	PADB.HPA111H
					   SET	NUM_OF_GENERAL = :li_sisu1,
								SEC_CODE       = :li_sec_code,
								BANK_CODE		= :li_bank_code,
								ACCT_NO			= :ls_acct_no,
								NUM_OF_NIETC1	= :ld_num_of_nietc1		
					 WHERE	YEAR		=	:is_yy
					   AND	HAKGI		=	:is_hakgi
						AND	MONTH		=	:li_month
						AND	MEMBER_NO	=	:ls_member_no;
				end if
				commit ;
			
			for	li_week	=	li_str_week	to	li_end_week
				// 주별시수산출내역 생성
				insert	into	padb.hpa112t	
					(	year, hakgi, member_no, week_weekend, month, limit_time,
						num_of_time, num_of_general, num_of_middle, num_of_large, num_of_etc1, 
						num_of_overtime1, num_of_overtime2, num_of_overtime3, num_of_overtime4, 
						worker, ipaddr, work_date, work_gbn,
						job_uid, job_add, job_date	)
						values	
					(	:is_yy, :is_hakgi, :ls_member_no, :li_week, :li_month, :ll_limit_time,
						:ll_time, :li_sisu1, :li_sisu2, :li_sisu3, 0,
						case
							when		:ll_time <=	(:li_sisu1 + :li_sisu2 + :li_sisu3 )
								then	case
											when		:li_sisu1 = 0 or :ll_time > :li_sisu1
												then	0
											when		(:li_sisu1 + :li_sisu3 > :ll_limit_time) and (:li_sisu1 - :ll_time) - (:li_sisu1 + :li_sisu3 - :ll_limit_time) <= 0
												then	0
											when		(:li_sisu1 + :li_sisu3 > :ll_limit_time) and (:li_sisu1 - :ll_time) - (:li_sisu1 + :li_sisu3 - :ll_limit_time) > 0
												then	(:li_sisu1 - :ll_time) - (:li_sisu1 + :li_sisu3 - :ll_limit_time)
											else		:li_sisu1 - :ll_time
										end
							else		0
						end,
						case
							when		:ll_time <=	(:li_sisu1 + :li_sisu2 + :li_sisu3 )
								then	:li_sisu2
							else		0
						end,
						case
							when		:ll_time <=	(:li_sisu1 + :li_sisu2 + :li_sisu3 )
								then	case
											when		:li_sisu3 = 0
												then	0
											when		(:ll_limit_time - :ll_time) <= :li_sisu3
												then	:ll_limit_time - :ll_time
											else		:li_sisu3
										end
							else		0
						end,
						0,
						:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate, 'I',
						:gstru_uid_uname.uid, :gstru_uid_uname.address, sysdate	)	;
				
						if sqlca.sqlcode <> 0 then	
							UPDATE	PADB.HPA112T
								SET	limit_time			=	:ll_limit_time
									,	num_of_time 		=	:ll_time
									,	num_of_general 	=	:li_sisu1
									,	num_of_etc1 		=	0
									,	num_of_overtime1  =	:li_sisu1 - :ll_time
							WHERE 	YEAR			=	:is_yy
							  AND		HAKGI			=	:is_hakgi
							  AND		MONTH			=	:li_month
							  AND		WEEK_WEEKEND	=	:li_week
							  AND		MEMBER_NO	=	:ls_member_no;
						end if
			next
		next
	next

 	COMMIT;
	triggerevent('ue_retrieve')
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText + '~r~n' )
  ROLLBACK;
END IF


return 1

end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow
string		ls_member_no

integer	li_week_count, i, li_month, li_str_week, li_end_week


wf_setMsg('삭제중')

ls_member_no	=	idw_list.getitemstring(idw_list.getrow(), 'member_no')

li_deleterow	=	idw_list.deleterow(0)

idw_week.retrieve(is_yy, is_hakgi)
li_week_count 	= 	idw_week.rowcount()

for	i	=	1 to	li_week_count
	li_month		=	idw_week.getitemnumber(i, 'month')
	li_str_week	=	idw_week.getitemnumber(i, 'from_weekend')
	li_end_week	=	idw_week.getitemnumber(i, 'to_weekend')

	// 주별시수내역 Delete
	delete	from	padb.hpa112t
	where		year				=	:is_yy
	and		hakgi				=	:is_hakgi
	and		member_no		=	:ls_member_no	
	and		week_weekend	>=	:li_str_week
	and		week_weekend	<=	:li_end_week	;
	
	if sqlca.sqlcode	<>	0	then
		messagebox('HPA112T DELETE ERROR', '전산실에 문의하세요!~n~n' + sqlca.sqlerrtext)
		rollback	;
	end if

	// 월별 마스타 자료 삭제
	delete	from	padb.hpa111h
	where		year			=	:is_yy
	and		hakgi			=	:is_hakgi
	and		member_no	=	:ls_member_no	
	and		month			=	:li_month	;
	
	if sqlca.sqlcode	<>	0	then
		messagebox('HPA111H DELETE ERROR', '전산실에 문의하세요!~n~n' + sqlca.sqlerrtext)
		rollback	;
	end if
next

if li_deleterow - 1 > 0 then
	idw_list.scrolltorow(li_deleterow - 1)
	wf_dwcopy()
else
	idw_data.reset()
end if

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

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hge504a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hge504a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hge504a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hge504a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hge504a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hge504a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hge504a
end type

type uc_insert from w_tabsheet`uc_insert within w_hge504a
end type

type uc_delete from w_tabsheet`uc_delete within w_hge504a
end type

type uc_save from w_tabsheet`uc_save within w_hge504a
end type

type uc_excel from w_tabsheet`uc_excel within w_hge504a
end type

type uc_print from w_tabsheet`uc_print within w_hge504a
end type

type st_line1 from w_tabsheet`st_line1 within w_hge504a
end type

type st_line2 from w_tabsheet`st_line2 within w_hge504a
end type

type st_line3 from w_tabsheet`st_line3 within w_hge504a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hge504a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hge504a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hge504a
integer y = 308
integer width = 4379
integer height = 1988
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
end type

event tab_sheet::selectionchanged;call super::selectionchanged;if oldindex	< 0 or newindex < 0	then	return

//choose case newindex
//	case	1
//		wf_setMenu('INSERT',		true)
//		wf_setMenu('DELETE',		true)
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
//		wf_enabled_check(TRUE)
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
integer width = 4343
integer height = 1868
long backcolor = 1073741824
string text = "강사료지급기초관리"
uo_3 uo_3
dw_update dw_update
end type

on tabpage_sheet01.create
this.uo_3=create uo_3
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3
this.Control[iCurrent+2]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.uo_3)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 168
integer width = 1751
integer height = 2012
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

event dw_list001::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)
//SelectRow(currentRow,true)
wf_dwcopy()


end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 168
integer width = 2002
integer height = 1680
string dataobject = "d_hge504a_1"
boolean hsplitscroll = true
end type

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)
//SelectRow(currentRow,true)
wf_dwcopy()


end event

type uo_tab from w_tabsheet`uo_tab within w_hge504a
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hge504a
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hge504a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uo_3 from cuo_search_insa within tabpage_sheet01
event destroy ( )
integer x = 64
integer y = 36
integer taborder = 60
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 2016
integer y = 160
integer width = 2309
integer height = 1680
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_hge504a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;func.of_design_dw(dw_update)
This.insertrow(0)

end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
string	ls_col, ls_type
string	ls_bef_member, ls_duty_code, ls_bojik_code
long		ll_row, ll_time, ll_child_member_row, ll_limit_time
if		ii_month	=	0	or 	isnull(ii_month)	then
		f_messagebox('3', '월을 입력하세요!')
		return 1
end if
datawindowchild	ldw_child
ls_col 	= dwo.name
ls_type 	= describe(ls_col + ".coltype")

ll_row	=	idw_list.getrow()

if ls_col = 'member_no' or ls_col = 'name' then
	if ls_col = 'member_no' then
		ldw_child	=	idw_child_member
		if ldw_child.find("member_no = '" + data + "'	", 1, ldw_child.rowcount()) < 1 or trim(data) = '' then	
			ls_bef_member = getitemstring(row, 'member_no')
			setitem(row, 'member_no', ls_bef_member)
			f_messagebox('3', '개인번호를 정확히 입력해 주세요.!')
			return 1
		end if
	else
		ldw_child	=	idw_child_kname
		if ldw_child.find("name = '" + data + "'	", 1, ldw_child.rowcount()) < 1 or trim(data) = '' then	
			ls_bef_member = getitemstring(row, 'name')
			setitem(row, 'name', ls_bef_member)
			f_messagebox('3', '성명을 정확히 입력해 주세요.!')
			return 1
		end if
	end if		
	
	ll_child_member_row	=	ldw_child.getrow()
	
	ls_duty_code	=	trim(ldw_child.getitemstring(ll_child_member_row, 'duty_code'))
	ls_bojik_code	=	trim(ldw_child.getitemstring(ll_child_member_row, 'bojik_code1'))
	
	if ls_col = 'member_no' then
		wf_setitem('name', 		trim(ldw_child.getitemstring(ll_child_member_row, 'name')))
	else
		wf_setitem('member_no', trim(ldw_child.getitemstring(ll_child_member_row, 'member_no')))
	end if		
	wf_setitem('gwa', 			trim(ldw_child.getitemstring(ll_child_member_row, 'gwa')))
	wf_setitem('sal_class', 	trim(ldw_child.getitemstring(ll_child_member_row, 'sal_class')))
	wf_setitem('duty_code', 	ls_duty_code)
	wf_setitem('bojik_code',	ls_bojik_code)
	wf_setitem('bojik_name',	trim(ldw_child.getitemstring(ll_child_member_row, 'bojik_name')))
	wf_setitem('jikjong_code', string(ldw_child.getitemnumber(ll_child_member_row, 'jikjong_code')))

	this.modify("t_dept_name.text = '" +	 trim(ldw_child.getitemstring(ll_child_member_row, 'dept_name')) + "'	")
	this.modify("t_jikjong_name.text = '" + trim(ldw_child.getitemstring(ll_child_member_row, 'jikjong_fname')) + "'	")
	this.modify("t_duty_name.text = '" + 	 trim(ldw_child.getitemstring(ll_child_member_row, 'duty_name')) + "'	")
	
//	choose	case	ls_val[4]
//		case	'106'
//			li_sec_code = 	1
//		case	'107'
//			li_sec_code	=	2
//		case	'105'
//			li_sec_code	=	3
//		case	'301'
//			li_sec_code	=	5
//		case	else
//			li_sec_code	=	4
//	end choose

	wf_setitem('sec_code', ls_duty_code)
	
	select	respons_time, limit_time
	into		:ll_time, :ll_limit_time
	from		padb.hpa201m
	where		respons_gb	=	'1'
	and		respons_code	=	:ls_bojik_code	;
	
	if sqlca.sqlcode <> 0 then	
		ll_time			=	0
		ll_limit_time	=	0
	end if
	
	if ll_time < 1 then
		select	respons_time, limit_time
		into		:ll_time, :ll_limit_time
		from		padb.hpa201m
		where		respons_gb	=	'2'
		and		respons_code	=	:ls_duty_code	;
		
		if sqlca.sqlcode <> 0 then	
			ll_time			=	0
			ll_limit_time	=	0
		end if
	end if

	wf_setitem('num_of_time', 	string(ll_time))
	wf_setitem('limit_time',	string(ll_limit_time))
	
	accepttext()
	wf_getchild_bank()

elseif ls_col = 'acct_no' then
	setitem(row, 'bank_code', idw_child2.getitemnumber(idw_child2.getrow(), 'bank_code'))
	idw_list.setitem(ll_row, 'bank_code', idw_child2.getitemnumber(idw_child2.getrow(), 'bank_code'))

elseif ls_col = 'hpa111m_trans_member_no' then
	if trim(data)	=	''	then
		wf_setitem('hpa111m_trans_name', '')
	else
		if idw_child_trans_member.find("member_no = '" + data + "'	", 1, idw_child_trans_member.rowcount()) < 1 or trim(data) = '' then	
			ls_bef_member = getitemstring(row, 'hpa111m_trans_member_no')
			setitem(row, 'hpa111m_trans_member_no', ls_bef_member)
			f_messagebox('3', '대체자 개인번호를 정확히 입력해 주세요.!')
			return 1
		end if
		ll_child_member_row	=	idw_child_trans_member.getrow()
		wf_setitem('hpa111m_trans_name', trim(idw_child_trans_member.getitemstring(ll_child_member_row, 'name')))
	end if

elseif ls_col = 'hpa111m_trans_name' then
	if trim(data)	=	''	then
		wf_setitem('hpa111m_trans_member_no', '')
	else
		if idw_child_trans_name.find("name = '" + data + "'	", 1, idw_child_trans_name.rowcount()) < 1 or trim(data) = '' then	
			ls_bef_member = getitemstring(row, 'hpa111m_trans_name')
			setitem(row, 'hpa111m_trans_name', ls_bef_member)
			f_messagebox('3', '대체자 성명을 정확히 입력해 주세요.!')
			return 1
		end if
		ll_child_member_row	=	idw_child_trans_name.getrow()
		wf_setitem('hpa111m_trans_member_no', trim(idw_child_trans_name.getitemstring(ll_child_member_row, 'member_no')))
	end if


	
elseif ls_col = 'num_of_time' or ls_col = 'num_of_general' or ls_col = 'num_of_middle' or ls_col = 'num_of_large' or	&
		 ls_col = 'num_of_etc1' or ls_col = 'limit_time' then
	

	accepttext()
	
	string	ls_member_no, ls_today
	integer	li_num_of_dutytime, li_num_of_general, li_num_of_middle, li_num_of_large, li_num_of_etc1, li_limit_time, li_month

	ls_member_no			=	getitemstring(row, 'member_no')
	
	li_num_of_dutytime	=	getitemnumber(row, 'num_of_time')
	li_num_of_general		=	getitemnumber(row, 'num_of_general')
	li_num_of_middle		=	getitemnumber(row, 'num_of_middle')
	li_num_of_large		=	getitemnumber(row, 'num_of_large')
	
	li_limit_time			=	getitemnumber(row, 'limit_time')
	
	// 월마스타 Upate
	update	padb.hpa111h
	set		num_of_time			=	:li_num_of_dutytime,
				num_of_general		=	:li_num_of_general,
				num_of_middle		=	:li_num_of_middle,
				num_of_large		=	:li_num_of_large,
				limit_time			=	:li_limit_time
	where		year			=	:is_yy
	and		hakgi			=	:is_hakgi
	and		month			=	:ii_month
	and		member_no	=	:ls_member_no	;

	if sqlca.sqlcode <> 0	then	
		messagebox('HPA111H UPDATE ERROR', '전산실에 문의하세요!~n~n' + sqlca.sqlerrtext)
		rollback	;
	end if

	// 원로교수일경우는 초과시수는 0로 처리한다.
	if getitemstring(row, 'hin001m_old_duty_yn')	=	'9'	then
		// 주별시수 월별 Update
		update	padb.hpa112t
		set		num_of_time			=	:li_num_of_dutytime,
					num_of_general		=	:li_num_of_general,
					num_of_middle		=	:li_num_of_middle,
					num_of_large		=	:li_num_of_large,
					limit_time			=	:li_limit_time,
					num_of_overtime1	=	0,
					num_of_overtime2	=	0,
					num_of_overtime3	=	0,
					num_of_overtime4	=	0
		where		year					=	:is_yy
		and		hakgi					=	:is_hakgi
		and		month					=	:ii_month
		and		member_no			=	:ls_member_no	;
		
	// 원로교수가 아닐경우는 초과시수를 계산한다.
	else
		// 주별시수 월별 Update
		update	padb.hpa112t
		set		num_of_time			=	:li_num_of_dutytime,
					num_of_general		=	:li_num_of_general,
					num_of_middle		=	:li_num_of_middle,
					num_of_large		=	:li_num_of_large,
					limit_time			=	:li_limit_time,
					num_of_overtime1	=	:li_num_of_general - :li_num_of_dutytime
		where		year			=	:is_yy
		and		hakgi			=	:is_hakgi
		and		month			=	:ii_month
		and		member_no	=	:ls_member_no	;
	end if
	
	if sqlca.sqlcode	<>	0	then
		messagebox('HPA112T UPDATE ERROR', '전산실에 문의하세요!~n~n' + sqlca.sqlerrtext)
		rollback	;
	end if
	
end if

accepttext()

string	ls_acct_no, ls_trans_member_no, ls_trans_name, ls_trans_remark
integer	li_sec_code

ls_acct_no				=	getitemstring(row, 'acct_no')
ls_trans_member_no	=	getitemstring(row, 'hpa111m_trans_member_no')
ls_trans_name			=	getitemstring(row, 'hpa111m_trans_name')
ls_trans_remark		=	getitemstring(row, 'hpa111m_trans_remark')
li_sec_code				=	getitemnumber(row, 'sec_code')


// 월마스타 Upate
update	padb.hpa111h
set		acct_no				=	:ls_acct_no,
			trans_member_no	=	:ls_trans_member_no,
			trans_name			=	:ls_trans_name,
			trans_remark		=	:ls_trans_remark,
			sec_code				=	:li_sec_code
where		year			=	:is_yy
and		hakgi			=	:is_hakgi
and		month			=	:ii_month
and		member_no	=	:ls_member_no	;

if sqlca.sqlcode <> 0	then	
	messagebox('HPA111H UPDATE ERROR', '전산실에 문의하세요!~n~n' + sqlca.sqlerrtext)
	rollback	;
end if

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(ll_row, ls_col, dec(data))
elseif ls_type = 'date' then
	idw_list.setitem(ll_row, ls_col, date(data))
else	
	idw_list.setitem(ll_row, ls_col, data)
end if

idw_list.setitem(ll_row, 'job_uid',		gstru_uid_uname.uid)
idw_list.setitem(ll_row, 'job_add',		gstru_uid_uname.address)
idw_list.SetItem(ll_row, 'job_date', 	f_sysdate())	


end event

event losefocus;call super::losefocus;accepttext()
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4343
integer height = 1868
string text = "강사료지급기초내역"
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
integer width = 4343
integer height = 1880
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hge504a_4"
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet03 from userobject within tab_sheet
boolean visible = false
integer x = 18
integer y = 104
integer width = 4343
integer height = 1868
long backcolor = 79741120
string text = "강사료지급기초생성"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list003 dw_list003
gb_3 gb_3
gb_11 gb_11
uo_str uo_str
uo_end uo_end
st_3 st_3
st_4 st_4
pb_1 pb_1
dw_list004 dw_list004
end type

on tabpage_sheet03.create
this.dw_list003=create dw_list003
this.gb_3=create gb_3
this.gb_11=create gb_11
this.uo_str=create uo_str
this.uo_end=create uo_end
this.st_3=create st_3
this.st_4=create st_4
this.pb_1=create pb_1
this.dw_list004=create dw_list004
this.Control[]={this.dw_list003,&
this.gb_3,&
this.gb_11,&
this.uo_str,&
this.uo_end,&
this.st_3,&
this.st_4,&
this.pb_1,&
this.dw_list004}
end on

on tabpage_sheet03.destroy
destroy(this.dw_list003)
destroy(this.gb_3)
destroy(this.gb_11)
destroy(this.uo_str)
destroy(this.uo_end)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.pb_1)
destroy(this.dw_list004)
end on

type dw_list003 from cuo_dwwindow within tabpage_sheet03
integer y = 404
integer width = 3845
integer height = 888
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "강사료 지급 기초 자료"
string dataobject = "d_hge504a_3"
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_list_4, 'member_no')

//ll_row = idw_list_4.find("member_no = '" + getitemstring(currentrow, 'member_no') + "'	", 1, idw_list_4.rowcount())
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


//ll_row = idw_list_4.find("member_no = '" + getitemstring(currentrow, 'member_no') + "'	", 1, idw_list_4.rowcount())
//ll_row = find("member_no = '" + idw_list_4.getitemstring(currentrow, 'member_no') + "'	", 1, idw
//if ll_row < 1 then
//	idw_list_4.selectrow(0, false)
//else
//	idw_list_4.scrolltorow(ll_row)
//end if
end event

event constructor;call super::constructor;this.uf_setClick(false)
end event

type gb_3 from groupbox within tabpage_sheet03
integer x = 2917
integer y = 20
integer width = 928
integer height = 380
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_11 from groupbox within tabpage_sheet03
integer y = 20
integer width = 2912
integer height = 380
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "생성조건"
end type

type uo_str from cuo_yyhakgi within tabpage_sheet03
event destroy ( )
integer x = 311
integer y = 100
integer width = 1015
integer taborder = 60
boolean bringtotop = true
boolean border = false
long backcolor = 1073741824
end type

on uo_str.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;//is_str_yy		=	uf_getyy()
//is_str_hakgi	=	uf_gethakgi()
//is_dept	=	uo_gwa.uf_getcode()
//
//IF rb_1.checked = true then
//	is_duty = ''
//elseif rb_2.checked = true then
//	is_duty = '10'
//elseif rb_3.checked = true then
//	is_duty ='11'
//elseif rb_4.checked = true then
//	is_duty ='12'
//end if
//
//idw_list_3.title = is_str_yy + '년도 ' + is_str_hakgi + '학기 강사료 지급 기초 자료'
//
//idw_list_3.retrieve(is_str_yy, is_str_hakgi, is_dept, is_duty)
//
end event

type uo_end from cuo_yyhakgi within tabpage_sheet03
integer x = 311
integer y = 248
integer width = 1024
integer taborder = 20
boolean bringtotop = true
boolean border = false
long backcolor = 1073741824
end type

on uo_end.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;//is_end_yy		=	uf_getyy()
//is_end_hakgi	=	uf_gethakgi()
//is_dept	=	uo_gwa.uf_getcode()
//
//IF rb_1.checked = true then
//	is_duty = ''
//elseif rb_2.checked = true then
//	is_duty = '10'
//elseif rb_3.checked = true then
//	is_duty ='11'
//elseif rb_4.checked = true then
//	is_duty ='12'
//end if
//
//idw_list_4.title = is_end_yy + '년도 ' + is_end_hakgi + '학기 강사료 지급 기초 자료'
//
//idw_list_4.retrieve(is_end_yy, is_end_hakgi, is_dept, is_duty)
//
end event

type st_3 from statictext within tabpage_sheet03
integer x = 1367
integer y = 128
integer width = 270
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "의 자료를"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_sheet03
integer x = 1367
integer y = 276
integer width = 590
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "의 자료로 생성합니다."
boolean focusrectangle = false
end type

type pb_1 from picturebutton within tabpage_sheet03
integer x = 3163
integer y = 168
integer width = 439
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
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

if li_rtn	=	0	then
	commit	;
	f_messagebox('1', is_end_yy + '년도 ' + is_end_hakgi + '학기의 자료를~n~n성공적으로 생성했습니다.!')
	idw_list_4.retrieve(is_end_yy, is_end_hakgi, is_dept, is_duty)
elseif li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
end if



end event

type dw_list004 from cuo_dwwindow within tabpage_sheet03
integer y = 1292
integer width = 3845
integer height = 888
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "강사료 지급 기초 자료"
string dataobject = "d_hge504a_3"
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;long	ll_row

if currentrow < 1 then return

//selectrow(0, false)
//selectrow(currentrow, true)

f_dw_find(this, idw_list_3, 'member_no')

end event

event retrieveend;call super::retrieveend;long	ll_row

if rowcount < 1 then return

//selectrow(0, false)
//selectrow(1, true)

f_dw_find(idw_list_3, this, 'member_no')

end event

event constructor;call super::constructor;this.uf_setClick(false)
end event

type rb_1 from radiobutton within w_hge504a
integer x = 2711
integer y = 192
integer width = 238
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

event clicked;is_duty	=	''

rb_1.textcolor = rgb(0, 0, 255)
rb_2.textcolor = rgb(0, 0, 0)
rb_6.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_2 from radiobutton within w_hge504a
integer x = 2967
integer y = 192
integer width = 210
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

event clicked;is_duty	=	'10'

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 255)
rb_6.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type rb_4 from radiobutton within w_hge504a
integer x = 3566
integer y = 188
integer width = 320
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
string text = "외래교수"
end type

event clicked;is_duty	=	'301'

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_6.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 255)
rb_3.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type uo_gwa from cuo_dept within w_hge504a
integer x = 1550
integer y = 180
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

on uo_gwa.destroy
call cuo_dept::destroy
end on

event constructor;call super::constructor;uo_gwa.uf_setdept('1', '학과명')
is_dept	=	uo_gwa.uf_getcode()
is_duty	=	''

end event

type dw_list002 from datawindow within w_hge504a
boolean visible = false
integer x = 1495
integer y = 220
integer width = 1134
integer height = 432
integer taborder = 41
boolean bringtotop = true
string title = "none"
string dataobject = "d_hge501a_1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type rb_6 from radiobutton within w_hge504a
integer x = 3218
integer y = 192
integer width = 315
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

event clicked;is_duty	=	'115'

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_6.textcolor = rgb(0, 0, 255)
rb_4.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 0)

parent.triggerevent('ue_retrieve')

end event

type uo_yearhakgi from cuo_yearschoolterm within w_hge504a
event destroy ( )
integer x = 96
integer y = 176
integer taborder = 70
boolean bringtotop = true
end type

on uo_yearhakgi.destroy
call cuo_yearschoolterm::destroy
end on

type uo_mm from cuo_mm within w_hge504a
event destroy ( )
integer x = 1102
integer y = 172
integer taborder = 51
boolean bringtotop = true
end type

on uo_mm.destroy
call cuo_mm::destroy
end on

type rb_3 from radiobutton within w_hge504a
integer x = 3899
integer y = 188
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
string text = "겸임"
end type

event clicked;is_duty	=	'111'

rb_1.textcolor = rgb(0, 0, 0)
rb_2.textcolor = rgb(0, 0, 0)
rb_6.textcolor = rgb(0, 0, 0)
rb_4.textcolor = rgb(0, 0, 0)
rb_3.textcolor = rgb(0, 0, 255)

parent.triggerevent('ue_retrieve')

end event

