$PBExportHeader$w_hpa302a.srw
$PBExportComments$입력항목 금액 관리
forward
global type w_hpa302a from w_tabsheet
end type
type dw_update1_back from cuo_dwwindow within tabpage_sheet01
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type uo_3 from cuo_search_insa within tabpage_sheet01
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
type dw_list003 from uo_dwgrid within tabpage_sheet03
end type
type pb_create from uo_imgbtn within tabpage_sheet03
end type
type rb_6 from radiobutton within tabpage_sheet03
end type
type rb_5 from radiobutton within tabpage_sheet03
end type
type rb_4 from radiobutton within tabpage_sheet03
end type
type rb_3 from radiobutton within tabpage_sheet03
end type
type st_4 from statictext within tabpage_sheet03
end type
type st_3 from statictext within tabpage_sheet03
end type
type uo_member_no from cuo_padb001m_member_fromto within tabpage_sheet03
end type
type gb_6 from groupbox within tabpage_sheet03
end type
type gb_5 from groupbox within tabpage_sheet03
end type
type gb_2 from groupbox within tabpage_sheet03
end type
type gb_3 from groupbox within tabpage_sheet03
end type
type gb_7 from groupbox within tabpage_sheet03
end type
type em_amt from editmask within tabpage_sheet03
end type
type uo_4 from cuo_search_insa within tabpage_sheet03
end type
type tabpage_sheet03 from userobject within tab_sheet
dw_list003 dw_list003
pb_create pb_create
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
st_4 st_4
st_3 st_3
uo_member_no uo_member_no
gb_6 gb_6
gb_5 gb_5
gb_2 gb_2
gb_3 gb_3
gb_7 gb_7
em_amt em_amt
uo_4 uo_4
end type
type tabpage_sheet04 from userobject within tab_sheet
end type
type dw_list005 from uo_dwgrid within tabpage_sheet04
end type
type dw_list004 from uo_dwgrid within tabpage_sheet04
end type
type pb_create04 from uo_imgbtn within tabpage_sheet04
end type
type em_yearmonth04 from editmask within tabpage_sheet04
end type
type st_7 from statictext within tabpage_sheet04
end type
type st_5 from statictext within tabpage_sheet04
end type
type uo_5 from cuo_search_insa within tabpage_sheet04
end type
type uo_member_no04 from cuo_padb001m_member_fromto within tabpage_sheet04
end type
type tabpage_sheet04 from userobject within tab_sheet
dw_list005 dw_list005
dw_list004 dw_list004
pb_create04 pb_create04
em_yearmonth04 em_yearmonth04
st_7 st_7
st_5 st_5
uo_5 uo_5
uo_member_no04 uo_member_no04
end type
type uo_yearmonth from cuo_yearmonth within w_hpa302a
end type
type dw_list002 from datawindow within w_hpa302a
end type
type dw_head1 from datawindow within w_hpa302a
end type
type st_41 from statictext within w_hpa302a
end type
type rb_1 from radiobutton within w_hpa302a
end type
type rb_2 from radiobutton within w_hpa302a
end type
type dw_head2 from datawindow within w_hpa302a
end type
type st_1 from statictext within w_hpa302a
end type
type st_2 from statictext within w_hpa302a
end type
type dw_update2 from datawindow within w_hpa302a
end type
end forward

global type w_hpa302a from w_tabsheet
string title = "입력항목 금액 관리"
uo_yearmonth uo_yearmonth
dw_list002 dw_list002
dw_head1 dw_head1
st_41 st_41
rb_1 rb_1
rb_2 rb_2
dw_head2 dw_head2
st_1 st_1
st_2 st_2
dw_update2 dw_update2
end type
global w_hpa302a w_hpa302a

type variables
datawindowchild	idw_child, idw_kname_child
datawindow			idw_data,  idw_preview, idw_delete
datawindow			idw_item, idw_copy1, idw_copy2


string	is_opt	=	'3'				// 항목구분(3:입력)
string	is_pay_opt = '1', is_yearmonth, is_pay_date
string	is_code, is_name
dec{0}	idb_amt
string	is_str_member = '          ', is_end_member = 'zzzzzzzzzz'
integer	ii_excepte_gbn, ii_sort
integer	ii_str_jikjong = 0, ii_end_jikjong = 9

long		il_confirm_gbn

end variables

forward prototypes
public function integer wf_create ()
public subroutine wf_head_retrieve ()
public function integer wf_retrieve ()
public function integer wf_create2 ()
public subroutine wf_confirm_gbn ()
public subroutine wf_getchild ()
public subroutine wf_getchild2 ()
end prototypes

public function integer wf_create ();// ==========================================================================================
// 기    능 : 	입력항목금액생성
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_create()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

//idw_data		=	tab_sheet.tabpage_sheet01.dw_update1
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//idw_preview	=	tab_sheet.tabpage_sheet03.dw_list003
//idw_item		=	dw_list002
//idw_delete	=	dw_update2
//
long		ll_count, ll_judge
string   ls_member_no, ls_chasu
decimal  ldb_pay_amt


	if is_code = '28' then
	   ls_chasu = '4'
	else 
		ls_chasu = '5'
	end if
   
	select count(*)
	  into :ll_judge
	  from padb.hpa021m 
	 where confirm_gbn = 9
		and year_month = :is_yearmonth
		and chasu      = :ls_chasu;
	
	if sqlca.sqlcode <> 0 then return sqlca.sqlcode
   
	if ll_judge <> 0 then
	   messagebox('','이미 확정처리가 되었습니다.')
	   return 100
   end if

if isnull(is_code) or trim(is_code) = '' then
	f_messagebox('1', '급여항목을 선택해 주세요.!')
	dw_head2.setfocus()
	return	100
end if

if idb_amt = 0 then	
	f_messagebox('1', '생성금액을 입력해 주시기 바랍니다.')
	tab_sheet.tabpage_sheet03.em_amt.setfocus()
	return	100
end if

select	count(*)
into		:ll_count
from		padb.hpa005d
where		year_month	=	:is_yearmonth
and		code			=	:is_code
and		member_no	in	(	select	member_no
									from		padb.hpa001m
									where		jikjong_code	>=	:ii_str_jikjong
									and		jikjong_code	<=	:ii_end_jikjong
									and		member_no		>=	:is_str_member
									and		member_no		<=	:is_end_member	)	;

if ll_count > 0 then
	if f_messagebox('2', is_name + ' 항목이 이미 존재합니다.~n~n삭제 후 다시 생성하시겠습니까?') = 1 then	
		delete	from		padb.hpa005d
		where		year_month	=	:is_yearmonth
		and		code			=	:is_code	
		and		member_no	in	(	select	member_no
											from		padb.hpa001m
											where		jikjong_code	>=	:ii_str_jikjong
											and		jikjong_code	<=	:ii_end_jikjong
											and		member_no		>=	:is_str_member
											and		member_no		<=	:is_end_member	)	;
				
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
	else
		return	100
	end if
end if


long	ll_rowcount, ll_row, ll_insertrow

ll_rowcount = idw_item.retrieve(is_yearmonth, is_code, ii_str_jikjong, ii_end_jikjong, is_str_member, is_end_member)

if ll_rowcount < 1 then	
	f_messagebox('1', '생성할 자료가 존재하지 않습니다.!')
	return	100
end if

idw_preview.reset()

for	ll_row = 1 to ll_rowcount
	ll_insertrow	=	idw_preview.insertrow(0)
	idw_preview.scrolltorow(ll_insertrow)
	ls_member_no = idw_item.getitemstring(ll_row, 'hpa001m_member_no')
	idw_preview.setitem(ll_insertrow, 'member_no',		idw_item.getitemstring(ll_row, 'hpa001m_member_no'))
	idw_preview.setitem(ll_insertrow, 'year_month',		is_yearmonth)
	
	if is_code = '28' then
	   idw_preview.setitem(ll_insertrow, 'chasu', '4')
	else 
		idw_preview.setitem(ll_insertrow, 'chasu', '5')
	end if
   idw_preview.setitem(ll_insertrow, 'code',				is_code)
	idw_preview.setitem(ll_insertrow, 'item_name',		idw_item.getitemstring(ll_row, 'hpa003m_item_name'))
	idw_preview.setitem(ll_insertrow, 'pay_date',		is_yearmonth + '25')
	
	if tab_sheet.tabpage_sheet03.rb_4.checked = true then
		idw_preview.setitem(ll_insertrow, 'pay_amt', idb_amt)
	elseif tab_sheet.tabpage_sheet03.rb_3.checked = true then
		     if tab_sheet.tabpage_sheet03.rb_5.checked = true then
              
				  select sum(pay_amt)
				    into :ldb_pay_amt
					 from padb.hpa005d
					where member_no  =:ls_member_no
					  and year_month =:is_yearmonth
					  and code < 50;
					
					if sqlca.sqlcode <> 0 then
						messagebox('','total_pay is not pound')
						return -1
					end if
				else
					 select sum(pay_amt)
				    into :ldb_pay_amt
					 from padb.hpa005d
					where member_no  =:ls_member_no
					  and year_month =:is_yearmonth
					  and code = '00';
					
					if sqlca.sqlcode <> 0 then
						messagebox('','base_pay is not pound')
						return -1
					end if
	         end if
		ldb_pay_amt = ldb_pay_amt * (idb_amt/100)
		idw_preview.setitem(ll_insertrow, 'pay_amt', ldb_pay_amt)			  
   end if
	idw_preview.setitem(ll_insertrow, 'excepte_gbn',	idw_item.getitemnumber(ll_row, 'hpa003m_excepte_gbn'))
	idw_preview.setitem(ll_insertrow, 'sort',				idw_item.getitemnumber(ll_row, 'hpa003m_sort'))
	idw_preview.setitem(ll_insertrow, 'worker',			gs_empcode)  // gstru_uid_uname.uid)
	idw_preview.setitem(ll_insertrow, 'ipaddr',			gs_ip)   // gstru_uid_uname.address)
	idw_preview.setitem(ll_insertrow, 'job_uid',			gs_empcode)  // gstru_uid_uname.uid)
	idw_preview.setitem(ll_insertrow, 'job_add',			gs_ip)   // gstru_uid_uname.address)
next

if idw_preview.update() = 1 then	
	return	0
else
	return	-1
end if

return	sqlca.sqlcode			

end function

public subroutine wf_head_retrieve ();// ==========================================================================================
// 기    능 : 	급여항목을 지급구분(수당/공제)에 따라서 Retrieve 한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_head_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

dw_head2.reset()
dw_head2.insertrow(0)

dw_head2.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(is_pay_opt, is_opt, is_opt) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

tab_sheet.tabpage_sheet03.em_amt.text = ''
idb_amt = 0

wf_getchild()


end subroutine

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


idw_delete.reset()

if idw_data.retrieve(is_yearmonth, is_code, ii_str_jikjong, ii_end_jikjong) > 0 then
	idw_preview.retrieve(is_yearmonth, is_code, ii_str_jikjong, ii_end_jikjong, is_str_member, is_end_member)
	idw_print.retrieve(is_yearmonth, is_code, ii_str_jikjong, ii_end_jikjong)
	idw_copy1.retrieve(is_yearmonth, is_code, ii_str_jikjong, ii_end_jikjong, is_str_member, is_end_member)
	//idw_input2.retrieve(is_yearmonth, is_code, ii_str_jikjong, ii_end_jikjong, is_str_member, is_end_member)
	

else
	idw_preview.reset()
	idw_print.reset()
end if

return 0
end function

public function integer wf_create2 ();// ==========================================================================================
// 기    능 : 	입력항목금액복사
// 작 성 인 : 	길효만
// 작성일자 : 	2003.02
// 함수원형 : 	wf_create2()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

//idw_data		=	tab_sheet.tabpage_sheet01.dw_update1
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//idw_preview	=	tab_sheet.tabpage_sheet03.dw_list003
//idw_item		=	dw_list002
//idw_delete	=	dw_update2
//idw_copy1    =  dw_list004
//idw_copy2    =  dw_list005
long		ll_count, li_rtn
string   ls_member_no, ls_yearmonth
decimal  ldb_pay_amt
long	ll_rowcount, ll_row, ll_insertrow

li_rtn = f_getconfirm('%',is_yearmonth,'Y')
if li_rtn < 1 then 
	f_messagebox('1','급여확정작업을 해야 사용가능합니다.')
	return 100
end if

ls_yearmonth = mid(tab_sheet.tabpage_sheet04.em_yearmonth04.text,1,4) + mid(tab_sheet.tabpage_sheet04.em_yearmonth04.text,6,2)
//messagebox('',ls_yearmonth)
//if il_confirm_gbn	>	0	then	return	100

if isnull(is_code) or trim(is_code) = '' then
	f_messagebox('1', '급여항목을 선택해 주세요.!')
	dw_head2.setfocus()
	return	100
end if
messagebox('',is_yearmonth)
ll_rowcount = idw_copy1.retrieve(is_yearmonth, is_code, ii_str_jikjong, ii_end_jikjong, is_str_member, is_end_member)
if is_yearmonth = ls_yearmonth then
	messagebox('','생성년월을 확인하여 주시기바랍니다.')
	return 100
end if
if ll_rowcount < 1 then	
	f_messagebox('1', '생성할 자료가 존재하지 않습니다.!')
	return	100
end if

idw_copy2.reset()

for	ll_row = 1 to ll_rowcount
	ll_insertrow	=	idw_copy2.insertrow(0)
	idw_copy2.scrolltorow(ll_insertrow)
	idw_copy2.setitem(ll_insertrow,'member_no', idw_copy1.getitemstring(ll_row, 'member_no'))
	idw_copy2.setitem(ll_insertrow,'name', idw_copy1.getitemstring(ll_row, 'name'))
	idw_copy2.setitem(ll_insertrow, 'year_month', ls_yearmonth)
	
	if is_code = '28' then
	   idw_copy2.setitem(ll_insertrow, 'chasu', '4')
	else 
		idw_copy2.setitem(ll_insertrow, 'chasu', '5')
	end if

   idw_copy2.setitem(ll_insertrow, 'code',			is_code)
	idw_copy2.setitem(ll_insertrow, 'item_name',		idw_copy1.getitemstring(ll_row, 'item_name'))
	idw_copy2.setitem(ll_insertrow, 'pay_date',		ls_yearmonth + '25')
	idw_copy2.setitem(ll_insertrow, 'pay_amt',      idw_copy1.getitemnumber(ll_row, 'pay_amt'))
	idw_copy2.setitem(ll_insertrow, 'excepte_gbn',	idw_copy1.getitemnumber(ll_row, 'excepte_gbn'))
	idw_copy2.setitem(ll_insertrow, 'sort',			idw_copy1.getitemnumber(ll_row, 'sort'))
	idw_copy2.setitem(ll_insertrow, 'worker',			gs_empcode)  // gstru_uid_uname.uid)
	idw_copy2.setitem(ll_insertrow, 'ipaddr',			gs_ip)   // gstru_uid_uname.address)
	idw_copy2.setitem(ll_insertrow, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
	idw_copy2.setitem(ll_insertrow, 'job_add',		gs_ip)   // gstru_uid_uname.address)
next

delete from padb.hpa005d
      where year_month =:ls_yearmonth
		  and code =:is_code ;

if idw_copy2.update() = 1 then	
	return	0
else
	return	-1
end if


end function

public subroutine wf_confirm_gbn ();// 급여의 확정상태를 확인한다.
// 확정된 상태이면 자료를 입력, 수정, 삭제할 수 없다.
il_confirm_gbn	=	f_getconfirm('%',is_yearmonth, 'N')

//if il_confirm_gbn	=	0	then
//	wf_setMenu('INSERT',		TRUE)
//	wf_setMenu('DELETE',		TRUE)
//	wf_setMenu('UPDATE',		TRUE)
//else
//	wf_setMenu('INSERT',		FALSE)
//	wf_setMenu('DELETE',		FALSE)
//	wf_setMenu('UPDATE',		FALSE)
//end if			
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

// 항목구분
idw_data.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_preview.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)

if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_copy1.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_copy2.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

wf_getchild2()

end subroutine

public subroutine wf_getchild2 ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild2()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

//// 개인번호
//idw_preview.getchild('member_no', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if

idw_data.getchild('member_no', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_data.getchild('name', idw_kname_child)
idw_kname_child.settransobject(sqlca)
if idw_kname_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
	idw_kname_child.reset()
	idw_kname_child.insertrow(0)
end if

tab_sheet.tabpage_sheet03.uo_member_no.uf_getchild(is_yearmonth, ii_str_jikjong, ii_end_jikjong, '')
tab_sheet.tabpage_sheet04.uo_member_no04.uf_getchild(is_yearmonth, ii_str_jikjong, ii_end_jikjong, '')

end subroutine

on w_hpa302a.create
int iCurrent
call super::create
this.uo_yearmonth=create uo_yearmonth
this.dw_list002=create dw_list002
this.dw_head1=create dw_head1
this.st_41=create st_41
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_head2=create dw_head2
this.st_1=create st_1
this.st_2=create st_2
this.dw_update2=create dw_update2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_yearmonth
this.Control[iCurrent+2]=this.dw_list002
this.Control[iCurrent+3]=this.dw_head1
this.Control[iCurrent+4]=this.st_41
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.dw_head2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_update2
end on

on w_hpa302a.destroy
call super::destroy
destroy(this.uo_yearmonth)
destroy(this.dw_list002)
destroy(this.dw_head1)
destroy(this.st_41)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_head2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_update2)
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

integer	li_newrow, li_sort, li_excepte_gbn

if isnull(is_pay_opt) or trim(is_pay_opt) = '' then
	f_messagebox('1', '급여항목 지급구분을 선택해 주세요.!')
	return
end if
	
if isnull(is_code) or trim(is_code) = '' then
	f_messagebox('1', '급여항목을 선택해 주세요.!')
	dw_head2.setfocus()
	return
end if



idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)
idw_data.scrolltorow(li_newrow)

is_pay_date = is_yearmonth + '25'

idw_data.setitem(li_newrow, 'year_month', is_yearmonth)
idw_data.setitem(li_newrow, 'pay_date', 	is_pay_date)
idw_data.setitem(li_newrow, 'code', 		is_code)
//////////////////////////////////////////////////////////////
//		유사급여의 항목코드이면 차수는 4, 아니면 5차수이다.
//		특별상여일 경우에는 명절휴가비일 경우에 처리한다.
//////////////////////////////////////////////////////////////
if is_code <> '28' then		
   idw_data.setitem(li_newrow, 'chasu',  '5')
else 
	idw_data.setitem(li_newrow, 'chasu',  '4')
end if

select	sort, excepte_gbn
into		:li_sort, :li_excepte_gbn
from		padb.hpa003m
where		code	=	:is_code	;

idw_data.setitem(li_newrow, 'item_name',		is_name)
idw_data.setitem(li_newrow, 'excepte_gbn',	li_excepte_gbn)
idw_data.setitem(li_newrow, 'sort', 			li_sort)

idw_data.setitem(li_newrow, 'worker',		gs_empcode)  // gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip)   // gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setcolumn('pay_date')
idw_data.setfocus()



end event

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	안금옥
//// 작성일자 : 	2002.04
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update1
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//idw_preview	=	tab_sheet.tabpage_sheet03.dw_list003
//idw_item		=	dw_list002
//idw_delete	=	dw_update2
//idw_copy1	=	tab_sheet.tabpage_sheet04.dw_list004
//idw_copy2	=	tab_sheet.tabpage_sheet04.dw_list005
//
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//
//
//
//f_getdwcommon(dw_head1, 'jikjong_code', 0, 750)
//
//ii_str_jikjong	=	0
//ii_end_jikjong	=	9
//
//uo_yearmonth.uf_settitle('지급년월')
//is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
//
//tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_data,		'member_no', 'hpa001m_name')
//tab_sheet.tabpage_sheet03.uo_4.uf_reset(idw_preview,	'member_no', 'hpa001m_name')
//tab_sheet.tabpage_sheet04.uo_5.uf_reset(idw_preview,	'member_no', 'hpa001m_name')
//
//wf_confirm_gbn()
//
//wf_head_retrieve()
//
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow
long		ll_row, ll_rowcount
string	ls_member_no



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호


IF dw_name.Update(true) = 1 THEN 	
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

long		ll_deleterow


wf_setMsg('삭제중')

ll_deleterow	=	idw_data.getrow()

idw_data.rowscopy(ll_deleterow, ll_deleterow, primary!, idw_delete, 1, primary!) 
idw_delete.setitem(ll_deleterow, 'pay_amt', 			0)
idw_delete.setitem(ll_deleterow, 'nontax_amt', 	0)

ll_deleterow	=	idw_data.deleterow(0)

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

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================

idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_print	=	tab_sheet.tabpage_sheet02.dw_print
idw_preview	=	tab_sheet.tabpage_sheet03.dw_list003
idw_item		=	dw_list002
idw_delete	=	dw_update2
idw_copy1	=	tab_sheet.tabpage_sheet04.dw_list004
idw_copy2	=	tab_sheet.tabpage_sheet04.dw_list005




//f_getdwcommon(dw_head1, 'jikjong_code', 0, 750)
dw_head1.reset()
dw_head1.insertrow(0)

dw_head1.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikjong_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
dw_head1.object.code[1] = '0'


ii_str_jikjong	=	0
ii_end_jikjong	=	9

uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_data,		'member_no', 'hpa001m_name')
tab_sheet.tabpage_sheet03.uo_4.uf_reset(idw_preview,	'member_no', 'hpa001m_name')
tab_sheet.tabpage_sheet04.uo_5.uf_reset(idw_preview,	'member_no', 'hpa001m_name')

wf_confirm_gbn()

wf_head_retrieve()


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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa302a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa302a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa302a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa302a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa302a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa302a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa302a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa302a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa302a
end type

type uc_save from w_tabsheet`uc_save within w_hpa302a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa302a
end type

type uc_print from w_tabsheet`uc_print within w_hpa302a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa302a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa302a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa302a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa302a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa302a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa302a
event create ( )
event destroy ( )
integer y = 328
integer width = 4379
integer height = 1968
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
tabpage_sheet03 tabpage_sheet03
tabpage_sheet04 tabpage_sheet04
end type

on tab_sheet.create
this.tabpage_sheet02=create tabpage_sheet02
this.tabpage_sheet03=create tabpage_sheet03
this.tabpage_sheet04=create tabpage_sheet04
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_sheet02
this.Control[iCurrent+2]=this.tabpage_sheet03
this.Control[iCurrent+3]=this.tabpage_sheet04
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_sheet02)
destroy(this.tabpage_sheet03)
destroy(this.tabpage_sheet04)
end on

event tab_sheet::selectionchanged;call super::selectionchanged;date ld_date
string ls_date
choose case newindex
	case	1
//		if il_confirm_gbn	=	0	then
//			wf_setMenu('INSERT',		TRUE)
//			wf_setMenu('DELETE',		TRUE)
//			wf_setMenu('UPDATE',		TRUE)
//		else
//			wf_setMenu('INSERT',		FALSE)
//			wf_setMenu('DELETE',		FALSE)
//			wf_setMenu('UPDATE',		FALSE)
//		end if		
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('PRINT',		FALSE)
	
	case	2
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)

	case	3
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		FALSE)
		tab_sheet.tabpage_sheet03.rb_5.enabled = false
		tab_sheet.tabpage_sheet03.rb_3.checked = true
		tab_sheet.tabpage_sheet03.rb_6.checked = true
	case else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		FALSE)
		
end choose
end event

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4343
integer height = 1848
string text = "입력항목금액관리"
dw_update1_back dw_update1_back
gb_4 gb_4
uo_3 uo_3
end type

on tabpage_sheet01.create
this.dw_update1_back=create dw_update1_back
this.gb_4=create gb_4
this.uo_3=create uo_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update1_back
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.uo_3
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_update1_back)
destroy(this.gb_4)
destroy(this.uo_3)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 376
integer width = 3995
integer height = 2268
borderstyle borderstyle = stylelowered!
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 168
integer height = 1680
string dataobject = "d_hpa302a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
long		ll_row


if dwo.name = 'member_no' then
	ll_row	=	idw_child.find("member_no = '" + data + "'	", 1, idw_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'name', idw_child.getitemstring(idw_child.getrow(), 'name'))
		setitem(row, 'duty_name',idw_child.getitemstring(idw_child.getrow(),'duty_name'))
		setitem(row, 'item_name',is_name)
	else
		setitem(row, 'name', '')
	end if
elseif dwo.name = 'name' then
	ll_row	=	idw_kname_child.find("name = '" + data + "'	", 1, idw_kname_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'member_no',	idw_child.getitemstring(idw_kname_child.getrow(), 'member_no'))
	   setitem(row, 'duty_name',idw_child.getitemstring(idw_kname_child.getrow(),'duty_name'))
		setitem(row, 'item_name',is_name)
		
	else
		setitem(row, 'member_no',	'')
	end if
end if

setitem(row, 'isrowmodified',	1)

setitem(row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())	

end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then
	dw_head2.setfocus()
else
	setfocus()
end if
end event

type uo_tab from w_tabsheet`uo_tab within w_hpa302a
integer x = 1824
end type

type dw_con from w_tabsheet`dw_con within w_hpa302a
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hpa302a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_update1_back from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 3890
integer y = 1224
integer width = 274
integer height = 424
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa302a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
long		ll_row


if dwo.name = 'member_no' then
	ll_row	=	idw_child.find("member_no = '" + data + "'	", 1, idw_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'name', idw_child.getitemstring(idw_child.getrow(), 'name'))
		setitem(row, 'duty_name',idw_child.getitemstring(idw_child.getrow(),'duty_name'))
		setitem(row, 'item_name',is_name)
	else
		setitem(row, 'name', '')
	end if
elseif dwo.name = 'name' then
	ll_row	=	idw_kname_child.find("name = '" + data + "'	", 1, idw_kname_child.rowcount())
	if ll_row > 0 then
		setitem(row, 'member_no',	idw_child.getitemstring(idw_kname_child.getrow(), 'member_no'))
	   setitem(row, 'duty_name',idw_child.getitemstring(idw_kname_child.getrow(),'duty_name'))
		setitem(row, 'item_name',is_name)
		
	else
		setitem(row, 'member_no',	'')
	end if
end if

setitem(row, 'isrowmodified',	1)

setitem(row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())	

end event

event retrieveend;call super::retrieveend;if rowcount < 1 then
	dw_head2.setfocus()
else
	setfocus()
end if
end event

event losefocus;call super::losefocus;accepttext()
end event

type gb_4 from groupbox within tabpage_sheet01
integer x = 5
integer width = 4338
integer height = 164
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type uo_3 from cuo_search_insa within tabpage_sheet01
integer x = 114
integer y = 40
integer width = 3566
integer taborder = 60
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type tabpage_sheet02 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4343
integer height = 1848
long backcolor = 16777215
string text = "입력항목금액내역"
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
integer width = 4347
integer height = 1836
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa302a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type tabpage_sheet03 from userobject within tab_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4343
integer height = 1848
long backcolor = 16777215
string text = "입력항목금액생성"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list003 dw_list003
pb_create pb_create
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
st_4 st_4
st_3 st_3
uo_member_no uo_member_no
gb_6 gb_6
gb_5 gb_5
gb_2 gb_2
gb_3 gb_3
gb_7 gb_7
em_amt em_amt
uo_4 uo_4
end type

on tabpage_sheet03.create
this.dw_list003=create dw_list003
this.pb_create=create pb_create
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.st_4=create st_4
this.st_3=create st_3
this.uo_member_no=create uo_member_no
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_7=create gb_7
this.em_amt=create em_amt
this.uo_4=create uo_4
this.Control[]={this.dw_list003,&
this.pb_create,&
this.rb_6,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.st_4,&
this.st_3,&
this.uo_member_no,&
this.gb_6,&
this.gb_5,&
this.gb_2,&
this.gb_3,&
this.gb_7,&
this.em_amt,&
this.uo_4}
end on

on tabpage_sheet03.destroy
destroy(this.dw_list003)
destroy(this.pb_create)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.uo_member_no)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_7)
destroy(this.em_amt)
destroy(this.uo_4)
end on

type dw_list003 from uo_dwgrid within tabpage_sheet03
integer x = 5
integer y = 312
integer width = 4338
integer height = 1536
integer taborder = 20
string dataobject = "d_hpa302a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type pb_create from uo_imgbtn within tabpage_sheet03
integer x = 3410
integer y = 52
integer taborder = 90
string btnname = " 일괄생성"
end type

event clicked;call super::clicked;// 금액을 일괄생성한다.
integer	li_rtn

setpointer(hourglass!)

li_rtn	=	wf_create()

setpointer(arrow!)

if	li_rtn = 0 then
	commit	;
	

	wf_retrieve()
	
	f_messagebox('1', string(idw_preview.rowcount()) + '건의 자료를 생성했습니다.!')
elseif li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
//	parent.triggerevent('ue_retrieve')
	wf_retrieve()
end if


end event

on pb_create.destroy
call uo_imgbtn::destroy
end on

type rb_6 from radiobutton within tabpage_sheet03
integer x = 2853
integer y = 208
integer width = 242
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "본봉"
end type

type rb_5 from radiobutton within tabpage_sheet03
integer x = 2309
integer y = 208
integer width = 361
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "지급총액"
end type

type rb_4 from radiobutton within tabpage_sheet03
integer x = 3040
integer y = 56
integer width = 261
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "금액"
end type

event clicked;tab_sheet.tabpage_sheet03.rb_5.enabled = false
tab_sheet.tabpage_sheet03.rb_6.enabled = false
tab_sheet.tabpage_sheet03.st_3.text = '생성금액'
end event

type rb_3 from radiobutton within tabpage_sheet03
integer x = 2715
integer y = 56
integer width = 261
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "비율"
end type

event clicked;tab_sheet.tabpage_sheet03.st_3.text = '생성비율'
if tab_sheet.tabpage_sheet03.rb_6.checked = true then
	tab_sheet.tabpage_sheet03.rb_5.enabled = true
	tab_sheet.tabpage_sheet03.rb_6.enabled = true
else 
	tab_sheet.tabpage_sheet03.rb_5.enabled = false
	tab_sheet.tabpage_sheet03.rb_6.checked = true
end if
end event

type st_4 from statictext within tabpage_sheet03
integer x = 114
integer y = 60
integer width = 274
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "개인번호"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_sheet03
integer x = 3424
integer y = 216
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "생성비율"
boolean focusrectangle = false
end type

type uo_member_no from cuo_padb001m_member_fromto within tabpage_sheet03
integer x = 393
integer y = 40
integer taborder = 70
boolean bringtotop = true
end type

event ue_itemchanged();call super::ue_itemchanged;is_str_member	=	uf_str_member()
is_end_member	=	uf_end_member()

end event

on uo_member_no.destroy
call cuo_padb001m_member_fromto::destroy
end on

type gb_6 from groupbox within tabpage_sheet03
integer x = 2162
integer y = 152
integer width = 1061
integer height = 156
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
end type

type gb_5 from groupbox within tabpage_sheet03
boolean visible = false
integer x = 18
integer y = 152
integer width = 2135
integer height = 156
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
end type

type gb_2 from groupbox within tabpage_sheet03
boolean visible = false
integer x = 18
integer width = 2569
integer height = 156
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
end type

type gb_3 from groupbox within tabpage_sheet03
integer x = 2624
integer width = 745
integer height = 156
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
end type

type gb_7 from groupbox within tabpage_sheet03
integer x = 3232
integer y = 152
integer width = 1111
integer height = 156
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
end type

type em_amt from editmask within tabpage_sheet03
integer x = 3717
integer y = 200
integer width = 457
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,###,###,##0"
end type

event modified;getdata(idb_amt)
end event

event getfocus;selecttext(1, len(this.text))
end event

type uo_4 from cuo_search_insa within tabpage_sheet03
integer x = 261
integer y = 192
integer width = 1682
integer taborder = 60
boolean bringtotop = true
end type

on uo_4.destroy
call cuo_search_insa::destroy
end on

type tabpage_sheet04 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4343
integer height = 1848
long backcolor = 16777215
string text = "입력항목금액복사"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list005 dw_list005
dw_list004 dw_list004
pb_create04 pb_create04
em_yearmonth04 em_yearmonth04
st_7 st_7
st_5 st_5
uo_5 uo_5
uo_member_no04 uo_member_no04
end type

on tabpage_sheet04.create
this.dw_list005=create dw_list005
this.dw_list004=create dw_list004
this.pb_create04=create pb_create04
this.em_yearmonth04=create em_yearmonth04
this.st_7=create st_7
this.st_5=create st_5
this.uo_5=create uo_5
this.uo_member_no04=create uo_member_no04
this.Control[]={this.dw_list005,&
this.dw_list004,&
this.pb_create04,&
this.em_yearmonth04,&
this.st_7,&
this.st_5,&
this.uo_5,&
this.uo_member_no04}
end on

on tabpage_sheet04.destroy
destroy(this.dw_list005)
destroy(this.dw_list004)
destroy(this.pb_create04)
destroy(this.em_yearmonth04)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.uo_5)
destroy(this.uo_member_no04)
end on

type dw_list005 from uo_dwgrid within tabpage_sheet04
integer y = 1224
integer width = 4343
integer height = 624
integer taborder = 60
string dataobject = "d_hpa302a_42"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_list004 from uo_dwgrid within tabpage_sheet04
integer y = 308
integer width = 4343
integer height = 912
integer taborder = 20
string dataobject = "d_hpa302a_42"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type pb_create04 from uo_imgbtn within tabpage_sheet04
integer x = 3410
integer y = 52
integer taborder = 100
string btnname = "일괄복사"
end type

event clicked;call super::clicked;// 금액을 일괄생성한다.
integer	li_rtn

setpointer(hourglass!)

li_rtn	=	wf_create2()

setpointer(arrow!)

if	li_rtn = 0 then
	commit	;
	

//wf_retrieve2()
	
	f_messagebox('1', string(idw_copy2.rowcount()) + '건의 자료를 생성했습니다.!')
elseif li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
   //wf_retrieve2()
end if


end event

on pb_create04.destroy
call uo_imgbtn::destroy
end on

type em_yearmonth04 from editmask within tabpage_sheet04
integer x = 2967
integer y = 48
integer width = 352
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm"
boolean autoskip = true
boolean spin = true
string minmax = "190001~~299901"
end type

event getfocus;selecttext(1, len(this.text))
end event

event constructor;date ld_date

select add_months(sysdate,1)
  into :ld_date
  from dual;

tab_sheet.tabpage_sheet04.em_yearmonth04.text = string(ld_date,'yyyy/mm')
//messagebox('',string(ld_date,'yyyymm'))
  
end event

type st_7 from statictext within tabpage_sheet04
integer x = 2665
integer y = 68
integer width = 288
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "생성년월"
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_sheet04
integer x = 110
integer y = 68
integer width = 457
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "개인번호"
boolean focusrectangle = false
end type

type uo_5 from cuo_search_insa within tabpage_sheet04
integer x = 110
integer y = 200
integer width = 1682
integer taborder = 70
end type

on uo_5.destroy
call cuo_search_insa::destroy
end on

type uo_member_no04 from cuo_padb001m_member_fromto within tabpage_sheet04
integer x = 393
integer y = 48
integer taborder = 70
boolean bringtotop = true
end type

event ue_itemchanged();call super::ue_itemchanged;is_str_member	=	uf_str_member()
is_end_member	=	uf_end_member()

end event

on uo_member_no04.destroy
call cuo_padb001m_member_fromto::destroy
end on

type uo_yearmonth from cuo_yearmonth within w_hpa302a
event destroy ( )
integer x = 91
integer y = 176
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yearmonth	=	uf_getyearmonth()

wf_confirm_gbn()


end event

type dw_list002 from datawindow within w_hpa302a
boolean visible = false
integer x = 2217
integer y = 936
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_hpa302a_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type dw_head1 from datawindow within w_hpa302a
integer x = 1134
integer y = 180
integer width = 686
integer height = 80
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) or trim(data) = '0' or trim(data) = '' then	
	ii_str_jikjong	=	0
	ii_end_jikjong	=	9
	idw_print.dataobject ='d_hpa302a_3a'
	idw_print.SettransObject(sqlca)
   idw_print.Modify("DataWindow.Print.Preview='yes'")
else
	idw_print.dataobject ='d_hpa302a_3'
	idw_print.SettransObject(sqlca)
   idw_print.Modify("DataWindow.Print.Preview='yes'")
	ii_str_jikjong = integer(trim(data))
	ii_end_jikjong = integer(trim(data))
end if

wf_getchild2()




end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type st_41 from statictext within w_hpa302a
integer x = 901
integer y = 192
integer width = 215
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
string text = "직종명"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_hpa302a
integer x = 1984
integer y = 184
integer width = 238
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "수당"
boolean checked = true
end type

event clicked;is_pay_opt = '1'
tab_sheet.tabpage_sheet03.rb_5.enabled = false
tab_sheet.tabpage_sheet03.rb_6.checked = true
wf_head_retrieve()


end event

type rb_2 from radiobutton within w_hpa302a
integer x = 2217
integer y = 184
integer width = 238
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "공제"
end type

event clicked;is_pay_opt = '2'
tab_sheet.tabpage_sheet03.rb_5.enabled = true
tab_sheet.tabpage_sheet03.rb_5.checked = true
wf_head_retrieve()


end event

type dw_head2 from datawindow within w_hpa302a
integer x = 2450
integer y = 172
integer width = 1115
integer height = 88
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_item_code"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) then	
	is_code	= ''
	is_name	= ''
	return
end if
accepttext()

is_code	=	string(data)
is_name	=	getitemstring(row, 'code_name')
is_name	=	mid(is_name, 6, len(is_name))


end event

event itemfocuschanged;triggerevent(itemchanged!)

end event

type st_1 from statictext within w_hpa302a
integer x = 3611
integer y = 168
integer width = 261
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
string text = "조회를"
boolean focusrectangle = false
end type

type st_2 from statictext within w_hpa302a
integer x = 3611
integer y = 224
integer width = 261
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
string text = "해주세요."
boolean focusrectangle = false
end type

type dw_update2 from datawindow within w_hpa302a
boolean visible = false
integer x = 773
integer y = 1276
integer width = 2546
integer height = 696
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_hpa302a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

