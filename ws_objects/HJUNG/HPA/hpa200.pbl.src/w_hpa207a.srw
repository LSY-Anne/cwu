$PBExportHeader$w_hpa207a.srw
$PBExportComments$급여 대상자 기초자료 관리
forward
global type w_hpa207a from w_tabsheet
end type
type dw_update_back from cuo_dwwindow within tabpage_sheet01
end type
type gb_4 from groupbox within tabpage_sheet01
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
type uo_dept_code from cuo_dept within w_hpa207a
end type
type uo_yearmonth from cuo_yearmonth within w_hpa207a
end type
type st_2 from statictext within w_hpa207a
end type
type em_pay_date from editmask within w_hpa207a
end type
type rb_7 from radiobutton within w_hpa207a
end type
type rb_6 from radiobutton within w_hpa207a
end type
type rb_5 from radiobutton within w_hpa207a
end type
type rb_all from radiobutton within w_hpa207a
end type
end forward

global type w_hpa207a from w_tabsheet
integer height = 2660
string title = "급여기초자료 관리"
uo_dept_code uo_dept_code
uo_yearmonth uo_yearmonth
st_2 st_2
em_pay_date em_pay_date
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
rb_all rb_all
end type
global w_hpa207a w_hpa207a

type variables
datawindowchild	idw_child, idw_child2
datawindow			idw_list, idw_data, idw_list_3, idw_list_4

statictext			ist_back

string	is_yearmonth, is_dept_code, is_today, is_DutyCode

long		il_confirm_gbn		//	급여확정상태(9:확정)



end variables

forward prototypes
public function decimal wf_getsalamt ()
public subroutine wf_setitem (string as_colname, string as_data)
public subroutine wf_dwcopy ()
public subroutine wf_getchild ()
public subroutine wf_getchild_member ()
public subroutine wf_confirm_gbn ()
public function integer wf_retrieve ()
end prototypes

public function decimal wf_getsalamt ();// ==========================================================================================
// 기    능 : 	호봉에 의해 본봉을 구한다.
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getsalamt()	return	decimal
// 인    수 :
// 되 돌 림 :	본봉
// 주의사항 :
// 수정사항 :
// ==========================================================================================

dec{0}	ld_sal_amt = 0
string	ls_duty_code, ls_sal_class

ls_duty_code	=	idw_data.getitemstring(idw_data.getrow(), 'duty_code')
ls_sal_class		=	idw_data.getitemstring(idw_data.getrow(), 'sal_class')

select	nvl(sal_amt, 0)
into		:ld_sal_amt
from		indb.hin004m
where		duty_code	=	:ls_duty_code
and		sal_class	=	:ls_sal_class	;

return	ld_sal_amt
end function

public subroutine wf_setitem (string as_colname, string as_data);// ==========================================================================================
// 기    능 : 	datawindow setitem
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_setitem(string	as_colname, string as_data)
// 인    수 :	as_colname	-	colnumn name
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

public subroutine wf_dwcopy ();// ==========================================================================================
// 기    능 : 	datawindw copy
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

//wf_getchild_bank()
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

// 급여지급구분
idw_data.getchild('ann_opt', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('ann_opt', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('ann_opt', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('ann_opt', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 조직코드
idw_data.getchild('gwa', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 직종코드
idw_data.getchild('jikjong_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikjong_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 직급코드
idw_data.getchild('duty_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve() < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 직위코드
idw_data.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('jikwi_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikwi_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 직무코드
idw_data.getchild('jikmu_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikmu_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('jikmu_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikmu_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

// 보직코드
idw_data.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('bojik_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

wf_getchild_member()

end subroutine

public subroutine wf_getchild_member ();// ==========================================================================================
// 기    능 : 	getchild
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_getchild_member()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// 개인번호
idw_data.getchild('member_no', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0, 9, is_dept_code, is_yearmonth) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if
idw_data.getchild('name', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(0, 9, is_dept_code, is_yearmonth) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

end subroutine

public subroutine wf_confirm_gbn ();// 급여의 확정상태를 확인한다.
// 확정된 상태이면 자료를 입력, 수정, 삭제할 수 없다.
il_confirm_gbn	=	f_getconfirm('%',is_yearmonth, 'N')

if il_confirm_gbn	=	0	then
	wf_setMenu('INSERT',		TRUE)
	wf_setMenu('DELETE',		TRUE)
	wf_setMenu('UPDATE',		TRUE)
else
	wf_setMenu('INSERT',		FALSE)
	wf_setMenu('DELETE',		FALSE)
	wf_setMenu('UPDATE',		FALSE)
end if			
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

String	ls_name
integer	li_tab

li_tab  = tab_sheet.selectedtab
wf_getchild_member()

if idw_list.retrieve (is_yearmonth, is_dept_code, is_DutyCode)  < 1 then   return 2
if idw_print.retrieve(is_yearmonth, is_dept_code, is_DutyCode, '')  < 1 then	return 2

return 0
end function

on w_hpa207a.create
int iCurrent
call super::create
this.uo_dept_code=create uo_dept_code
this.uo_yearmonth=create uo_yearmonth
this.st_2=create st_2
this.em_pay_date=create em_pay_date
this.rb_7=create rb_7
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_all=create rb_all
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_dept_code
this.Control[iCurrent+2]=this.uo_yearmonth
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_pay_date
this.Control[iCurrent+5]=this.rb_7
this.Control[iCurrent+6]=this.rb_6
this.Control[iCurrent+7]=this.rb_5
this.Control[iCurrent+8]=this.rb_all
end on

on w_hpa207a.destroy
call super::destroy
destroy(this.uo_dept_code)
destroy(this.uo_yearmonth)
destroy(this.st_2)
destroy(this.em_pay_date)
destroy(this.rb_7)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_all)
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



idw_data.Selectrow(0, false)	

idw_data.reset()
li_newrow	=	1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)

li_newrow2 	=	idw_list.getrow() + 1
idw_list.insertrow(li_newrow2)
idw_list.setrow(li_newrow2)

idw_data.setcolumn(1)
idw_data.setfocus()

wf_setitem('year_month', is_yearmonth)

//idw_data.setitem(li_newrow, 'year_month',	is_yearmonth)

//idw_list.setitem(li_newrow2, 'year_month',	is_yearmonth)

idw_list.setitem(li_newrow2, 'worker',		gs_empcode)  // gstru_uid_uname.uid)
idw_list.setitem(li_newrow2, 'ipaddr',		gs_ip)   // gstru_uid_uname.address)
idw_list.setitem(li_newrow2, 'work_date',	f_sysdate())

idw_data.modify("t_dept_name.text = ''	")
idw_data.modify("t_jikjong_name.text = ''	")
idw_data.modify("t_duty_name.text = ''	")



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
//idw_list		=	tab_sheet.tabpage_sheet01.dw_list001
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//
//wf_getchild()
//
//uo_yearmonth.uf_settitle('지급년월')
//is_yearmonth	=	uo_yearmonth.uf_getyearmonth()
//
//uo_dept_code.uf_setdept('', '학과명')
//is_dept_code	=	uo_dept_code.uf_getcode()
//
//tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'member_no', 'name')
//
//is_today = string(relativedate(date(string(is_yearmonth, '@@@@/@@/' + '01')), -1), 'yyyymmdd')
//em_pay_date.text = string(is_today, '@@@@/@@/@@')
//
//// 급여의 확정상태를 확인한다.
//// 확정된 상태이면 자료를 입력, 수정, 삭제할 수 없다.
//wf_confirm_gbn()
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



dw_name   = idw_list  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
IF dw_name.Update(true) = 1 THEN
 	COMMIT;
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText + '~r~n')
  ROLLBACK;
END IF


return 1







///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타를 저장한다.		                       //
//// 작성일자 : 2001. 8                                      //
//// 작 성 인 : 						                             //
///////////////////////////////////////////////////////////////
//
//int    i_tab,i_findrow,i_code,i_row = 1,i_rowcount,i,i_process,i_oldprocess,i_gbn
//String s_type,s_fname,s_sname,s_ename,s_processID,s_uid,s_programuser,s_address,s_biscode
//String s_member_no, s_k_name
//cuo_dwwindow dw_name
//
//f_setpointer('START')
//i_tab     = tab_sheet.Selectedtab
//s_uid     = gstru_uid_uname.uid         //사용자 명
//s_address = gstru_uid_uname.address     //사용자 IP
//
//
//choose case i_tab
//	case 1
//
//		  dw_name   = tab_sheet.tabpage_sheet01.dw_update101                   //저장하고자하는 데이타 원도우
//		  i_findrow = tab_sheet.tabpage_sheet01.dw_list001.GetSelectedrow(0)   //현재 저장하고자하는 행번호
//		  IF dw_name.Update(true) = 1 THEN
//			  COMMIT;
//			  s_k_name     = dw_name.GetItemString(i_row,'name')			  
//			  IF i_findrow < 1 then
//			  	  s_member_no  = dw_name.GetItemString(i_row,'member_no')
//				  i_findrow    = tab_sheet.tabpage_sheet01.dw_list001.Insertrow(0)
//				  tab_sheet.tabpage_sheet01.dw_list001.uf_selectrow(i_findrow)
//				  tab_sheet.tabpage_sheet01.dw_list001.SetItem(i_findrow,'member_no',s_member_no) //관리번호
//			  END IF
//           tab_sheet.tabpage_sheet01.dw_list001.SetItem(i_findrow,'name',s_k_name) //성명
//		  ELSE
//			  ROLLBACK;
//		  END IF
//
//END CHOOSE		
//
//f_setpointer('END')
//return 1
end event

event ue_delete;call super::ue_delete;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 삭제한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

integer		li_deleterow
LONG LL_JUDGE

SELECT COUNT(*)
  INTO :LL_JUDGE
  FROM PADB.HPA021M
 WHERE YEAR_MONTH = :is_yearmonth
   AND CONFIRM_GBN = 9;

IF SQLCA.SQLCODE <> 0 THEN 
   RETURN 
   //sqlca.sqlcode 
END IF 

IF LL_JUDGE < 0 THEN
	MESSAGEBOX('','급여 확정 처리가 되었습니다.')
	RETURN  //100
END IF


wf_setMsg('삭제중')

li_deleterow	=	idw_list.deleterow(0)
wf_dwcopy()

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

idw_list		=	tab_sheet.tabpage_sheet01.dw_update_tab
idw_data		=	tab_sheet.tabpage_sheet01.dw_update
idw_print	=	tab_sheet.tabpage_sheet02.dw_print

wf_getchild()

uo_yearmonth.uf_settitle('지급년월')
is_yearmonth	=	uo_yearmonth.uf_getyearmonth()

uo_dept_code.uf_setdept('', '학과명')
is_dept_code	=	uo_dept_code.uf_getcode()

tab_sheet.tabpage_sheet01.uo_3.uf_reset(idw_list, 'member_no', 'name')

is_today = string(relativedate(date(string(is_yearmonth, '@@@@/@@/' + '01')), -1), 'yyyymmdd')
em_pay_date.text = string(is_today, '@@@@/@@/@@')

// 급여의 확정상태를 확인한다.
// 확정된 상태이면 자료를 입력, 수정, 삭제할 수 없다.
wf_confirm_gbn()

idw_data.settransobject(sqlca)
func.of_design_dw(idw_data)


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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa207a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa207a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa207a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa207a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa207a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa207a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa207a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa207a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa207a
end type

type uc_save from w_tabsheet`uc_save within w_hpa207a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa207a
end type

type uc_print from w_tabsheet`uc_print within w_hpa207a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa207a
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa207a
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa207a
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa207a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa207a
integer beginy = 348
integer endy = 348
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa207a
integer y = 384
integer width = 4384
integer height = 2168
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;////if oldindex	< 0 or newindex < 0	then	return
//
//choose case newindex
//	case	1
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
//	case	else
//		wf_setMenu('INSERT',		FALSE)
//		wf_setMenu('DELETE',		FALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		FALSE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
end event

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
integer width = 4347
integer height = 2048
string text = "급여대상자기초자료관리"
dw_update_back dw_update_back
gb_4 gb_4
uo_3 uo_3
dw_update dw_update
end type

on tabpage_sheet01.create
this.dw_update_back=create dw_update_back
this.gb_4=create gb_4
this.uo_3=create uo_3
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update_back
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.uo_3
this.Control[iCurrent+4]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_update_back)
destroy(this.gb_4)
destroy(this.uo_3)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer y = 176
integer width = 9
integer height = 12
string dataobject = "d_hpa207a_1"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;selectrow(0, false)
selectrow(currentrow, true)

wf_dwcopy()


end event

event dw_list001::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_list001::constructor;call super::constructor;this.uf_setClick(false)
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 176
integer width = 1938
integer height = 1872
string dataobject = "d_hpa207a_1"
end type

event dw_update_tab::retrieveend;call super::retrieveend;if rowcount < 1 then 
	idw_data.reset()
	return
end if

trigger event rowfocuschanged(getrow())

end event

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;//selectrow(0, false)
//selectrow(currentrow, true)
//
wf_dwcopy()


end event

type uo_tab from w_tabsheet`uo_tab within w_hpa207a
integer x = 1595
integer y = 368
end type

type dw_con from w_tabsheet`dw_con within w_hpa207a
boolean visible = false
integer width = 0
integer height = 0
end type

type st_con from w_tabsheet`st_con within w_hpa207a
integer height = 184
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_update_back from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 1509
integer y = 176
integer width = 9
integer height = 12
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa207a_2"
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
string	ls_col, ls_type
string	ls_bef_member
integer	li_sec_code, li_rtncnt
long		ll_row, ll_childrow
dec{0}	ld_rtnamt
dec		ldb_work_year

integer	li_jaejik_opt			// 재직구분
integer	li_num_of_paywork		// 급여근무일수
string	ls_first_date			// 최초임용일자
string	ls_retire_date			// 퇴직일자
string	ls_lastdate
integer	li_annOpt
string	ls_dutyCode

integer	li_handicap_opt		// 장애인구분

ls_col 	= dwo.name
ls_type 	= describe(ls_col + ".coltype")

ll_row	=	idw_list.getrow()

ls_first_date	=	getitemstring(row, 'first_date')
ls_retire_date	=	getitemstring(row, 'retire_date')

if ls_col = 'member_no' then
	if idw_child.find("member_no = '" + data + "'	", 1, idw_child.rowcount()) < 1 or trim(data) = '' then	
		ls_bef_member = getitemstring(row, 'member_no')
		setitem(row, 'member_no', ls_bef_member)
		f_messagebox('3', '개인번호를 정확히 입력해 주세요.!')
		return 1
	end if
	
	ll_childrow = idw_child.getrow()
	
	li_jaejik_opt	=	idw_child.getitemnumber(ll_childrow, 		'jaejik_opt')
	ls_first_date	=	trim(idw_child.getitemstring(ll_childrow, 'firsthire_date'))
	ls_retire_date	=	trim(idw_child.getitemstring(ll_childrow, 'retire_date'))
	
	wf_setitem('name', 			idw_child.getitemstring(ll_childrow, 'name'))
	wf_setitem('jumin_no', 		idw_child.getitemstring(ll_childrow, 'jumin_no'))
	wf_setitem('gwa', 			idw_child.getitemstring(ll_childrow, 'gwa'))
	wf_setitem('sal_class', 	idw_child.getitemstring(ll_childrow, 'sal_class'))
	wf_setitem('duty_code', 	idw_child.getitemstring(ll_childrow, 'duty_code'))
	wf_setitem('bojik_code',	idw_child.getitemstring(ll_childrow, 'bojik_code1'))
	wf_setitem('jikjong_code', string(idw_child.getitemnumber(ll_childrow, 'jikjong_code')))
	wf_setitem('jikwi_code', 	string(idw_child.getitemnumber(ll_childrow, 'jikwi_code')))
	wf_setitem('jikmu_code',	string(idw_child.getitemnumber(ll_childrow, 'jikmu_code')))
	wf_setitem('jaejik_opt',	string(li_jaejik_opt))
	li_annOpt	=	idw_child.getitemnumber(ll_childrow, 'ann_opt')
	wf_setitem('ann_opt',		string(idw_child.getitemnumber(ll_childrow, 'ann_opt')))
	wf_setitem('first_date',	ls_first_date)
	wf_setitem('retire_date',	ls_retire_date)
	
	this.modify("t_dept_name.text = '" +	 trim(idw_child.getitemstring(ll_childrow, 'dept_name')) + "'	")
	this.modify("t_jikjong_name.text = '" + trim(idw_child.getitemstring(ll_childrow, 'jikjong_fname')) + "'	")
	this.modify("t_duty_name.text = '" + 	 trim(idw_child.getitemstring(ll_childrow, 'duty_name')) + "'	")
	
	accepttext()
	
	// 급여근무일수를 구한다.
	li_num_of_paywork = f_getpayday(data, is_yearmonth, ls_first_date, ls_retire_date)
	wf_setitem('num_of_paywork', string(li_num_of_paywork))
	
	// 본봉을 구한다.
	ls_DutyCode	=	idw_child.getitemstring(ll_childrow, 'duty_code')
	if left(ls_DutyCode,2)	=	'10'	then ls_DutyCode	=	'100'
	if li_annOpt	=	2					then ls_DutyCode	=	'801'
	ld_rtnamt = f_getsalamt(ls_DutyCode, idw_child.getitemstring(ll_childrow, 'sal_class'), getitemnumber(row, 'ann_opt'))
	wf_setitem('salary',	string(ld_rtnamt))
	
	// 근무년수를 구한다.
	ldb_work_year = f_getworkyear(data, is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('work_year',	string(ldb_work_year))
	
	// 상여근무월수를 구한다.
	li_rtncnt = f_getsangyeomonth(data, is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('num_of_bonwork',	string(li_rtncnt))
	
	// 배우자를 구한다.
	li_rtncnt = f_getwifecnt(data)
	wf_setitem('wife_num',	string(li_rtncnt))

	// 가족수를 구한다.
	li_rtncnt = f_getfamilycnt(data, 1)
	wf_setitem('family_num',	string(li_rtncnt))

	// 부양자20세를 구한다.
	li_rtncnt = f_getfamilycnt(data, 2)
	wf_setitem('support_20',	string(li_rtncnt))

	// 부양자60세를 구한다.
	li_rtncnt = f_getfamilycnt(data, 3)
	wf_setitem('support_60',	string(li_rtncnt))
	
	// 경로우대자를 구한다.
	li_rtncnt = f_getfamilycnt(data, 4)
	wf_setitem('old_num',	string(li_rtncnt))

//	// 기부금공제를 구한다.
//	ld_rtnamt = f_getcontribution(data, is_yearmonth)
//	wf_setitem('contribution',	string(ld_rtnamt))

	// 장애인구분을 구한다.
	select	nvl(decode(handicap_opt, 0, 0, 9), 0)
	into		:li_handicap_opt
	from		indb.hin011m
	where		member_no	=	:data	;
	
	if sqlca.sqlcode <> 0 then	li_handicap_opt	=	0
	
	wf_setitem('handycap',	string(li_handicap_opt))
elseif ls_col = 'name' then
	
	ll_childrow = idw_child.getrow()
	
	li_jaejik_opt	=	idw_child.getitemnumber(ll_childrow, 		'jaejik_opt')
	ls_first_date	=	trim(idw_child.getitemstring(ll_childrow, 'firsthire_date'))
	ls_retire_date	=	trim(idw_child.getitemstring(ll_childrow, 'retire_date'))
	
	wf_setitem('member_no', 	idw_child.getitemstring(ll_childrow, 'member_no'))
	wf_setitem('jumin_no', 		idw_child.getitemstring(ll_childrow, 'jumin_no'))
	wf_setitem('gwa', 			idw_child.getitemstring(ll_childrow, 'gwa'))
	wf_setitem('sal_class', 	idw_child.getitemstring(ll_childrow, 'sal_class'))
	wf_setitem('duty_code', 	idw_child.getitemstring(ll_childrow, 'duty_code'))
	wf_setitem('bojik_code',	idw_child.getitemstring(ll_childrow, 'bojik_code1'))
	wf_setitem('jikjong_code', string(idw_child.getitemnumber(ll_childrow, 'jikjong_code')))
	wf_setitem('jikwi_code', 	string(idw_child.getitemnumber(ll_childrow, 'jikwi_code')))
	wf_setitem('jikmu_code',	string(idw_child.getitemnumber(ll_childrow, 'jikmu_code')))
	li_annOpt	=	idw_child.getitemnumber(ll_childrow, 'ann_opt')
	wf_setitem('ann_opt',		string(idw_child.getitemnumber(ll_childrow, 'ann_opt')))
	wf_setitem('jaejik_opt',	string(li_jaejik_opt))
	wf_setitem('first_date',	ls_first_date)
	wf_setitem('retire_date',	ls_retire_date)
	
	this.modify("t_dept_name.text = '" +	 trim(idw_child.getitemstring(ll_childrow, 'dept_name')) + "'	")
	this.modify("t_jikjong_name.text = '" + trim(idw_child.getitemstring(ll_childrow, 'jikjong_fname')) + "'	")
	this.modify("t_duty_name.text = '" + 	 trim(idw_child.getitemstring(ll_childrow, 'duty_name')) + "'	")
	
	accepttext()
	
	// 급여근무일수를 구한다.
	li_num_of_paywork = f_getpayday(data, is_yearmonth, ls_first_date, ls_retire_date)
	wf_setitem('num_of_paywork', string(li_num_of_paywork))
	
	// 본봉을 구한다.
	ls_DutyCode	=	idw_child.getitemstring(ll_childrow, 'duty_code')
	if left(ls_DutyCode,2)	=	'10'	then ls_DutyCode	=	'100'
	if li_annOpt	=	2	then	ls_DutyCode	=	'801'
	ld_rtnamt = f_getsalamt(ls_DutyCode, idw_child.getitemstring(ll_childrow, 'sal_class'), getitemnumber(row, 'ann_opt'))
	wf_setitem('salary',	string(ld_rtnamt))
	
	// 근무년수를 구한다.
	ldb_work_year = f_getworkyear(data, is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('work_year',	string(ldb_work_year))
	
	// 상여근무월수를 구한다.
	li_rtncnt = f_getsangyeomonth(data, is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('num_of_bonwork',	string(li_rtncnt))
	
	// 배우자를 구한다.
	li_rtncnt = f_getwifecnt(data)
	wf_setitem('wife_num',	string(li_rtncnt))

	// 가족수를 구한다.
	li_rtncnt = f_getfamilycnt(data, 1)
	wf_setitem('family_num',	string(li_rtncnt))

	// 부양자20세를 구한다.
	li_rtncnt = f_getfamilycnt(data, 2)
	wf_setitem('support_20',	string(li_rtncnt))

	// 부양자60세를 구한다.
	li_rtncnt = f_getfamilycnt(data, 3)
	wf_setitem('support_60',	string(li_rtncnt))
	
	// 경로우대자를 구한다.
	li_rtncnt = f_getfamilycnt(data, 4)
	wf_setitem('old_num',	string(li_rtncnt))

//	// 기부금공제를 구한다.
//	ld_rtnamt = f_getcontribution(data, is_yearmonth)
//	wf_setitem('contribution',	string(ld_rtnamt))

	// 장애인구분을 구한다.
	select	nvl(decode(handicap_opt, 0, 0, 9), 0)
	into		:li_handicap_opt
	from		indb.hin011m
	where		member_no	=	:data	;
	
	if sqlca.sqlcode <> 0 then	li_handicap_opt	=	0
	
	wf_setitem('handycap',	string(li_handicap_opt))
	
elseif ls_col = 'sal_class' then
	accepttext()
	
	// 본봉을 구한다.
	ld_rtnamt = f_getsalamt(getitemstring(row, 'duty_code'), getitemstring(row, 'sal_class'), getitemnumber(row, 'ann_opt'))
	wf_setitem('salary',	string(ld_rtnamt))

elseif ls_col = 'year_month' then
	accepttext()
	
//	// 기부금공제를 구한다.
//	ld_rtnamt = f_getcontribution(getitemstring(row, 'member_no'), is_yearmonth)
//	wf_setitem('contribution',	string(ld_rtnamt))
elseif ls_col = 'hakbi3_yn' then
	if data = '0' then
		wf_setitem('iphak_amt',	string(0))
		wf_setitem('hakgy_amt',	string(0))
		wf_setitem('gisung_amt',	string(0))
	end if
	
elseif ls_col = 'first_date' then
	ls_first_date	=	data

	// 급여근무일수를 구한다.
	li_num_of_paywork = f_getpayday(data, is_yearmonth, ls_first_date, ls_retire_date)
	wf_setitem('num_of_paywork', string(li_num_of_paywork))
	
	// 근무년수를 구한다.
	ldb_work_year = f_getworkyear(getitemstring(row, 'member_no'), is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('work_year',	string(ldb_work_year))
	
	// 상여근무월수를 구한다.
	li_rtncnt = f_getsangyeomonth(getitemstring(row, 'member_no'), is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('num_of_bonwork',	string(li_rtncnt))
elseif ls_col = 'retire_date' then
	ls_retire_date	=	data
	
	// 급여근무일수를 구한다.
	li_num_of_paywork = f_getpayday(data, is_yearmonth, ls_first_date, ls_retire_date)
	wf_setitem('num_of_paywork', string(li_num_of_paywork))
	
	// 근무년수를 구한다.
	ldb_work_year = f_getworkyear(getitemstring(row, 'member_no'), is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('work_year',	string(ldb_work_year))
	
	// 상여근무월수를 구한다.
	li_rtncnt = f_getsangyeomonth(getitemstring(row, 'member_no'), is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('num_of_bonwork',	string(li_rtncnt))
end if

accepttext()

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(ll_row, ls_col, dec(data))
elseif ls_type = 'date' then
	idw_list.setitem(ll_row, ls_col, date(data))
else	
	idw_list.setitem(ll_row, ls_col, data)
end if

idw_list.setitem(ll_row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
idw_list.setitem(ll_row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
idw_list.setitem(ll_row, 'job_date',	f_sysdate())



end event

event losefocus;call super::losefocus;accepttext()
end event

type gb_4 from groupbox within tabpage_sheet01
integer y = -20
integer width = 4347
integer height = 184
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
integer taborder = 50
boolean bringtotop = true
end type

on uo_3.destroy
call cuo_search_insa::destroy
end on

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 1957
integer y = 176
integer width = 2391
integer height = 1872
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hpa207a_2"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
string	ls_col, ls_type
string	ls_bef_member
integer	li_sec_code, li_rtncnt
long		ll_row, ll_childrow
dec{0}	ld_rtnamt
dec		ldb_work_year

integer	li_jaejik_opt			// 재직구분
integer	li_num_of_paywork		// 급여근무일수
string	ls_first_date			// 최초임용일자
string	ls_retire_date			// 퇴직일자
string	ls_lastdate
integer	li_annOpt
string	ls_dutyCode

integer	li_handicap_opt		// 장애인구분

ls_col 	= dwo.name
ls_type 	= describe(ls_col + ".coltype")

ll_row	=	idw_list.getrow()

ls_first_date	=	getitemstring(row, 'first_date')
ls_retire_date	=	getitemstring(row, 'retire_date')

if ls_col = 'member_no' then
	if idw_child.find("member_no = '" + data + "'	", 1, idw_child.rowcount()) < 1 or trim(data) = '' then	
		ls_bef_member = getitemstring(row, 'member_no')
		setitem(row, 'member_no', ls_bef_member)
		f_messagebox('3', '개인번호를 정확히 입력해 주세요.!')
		return 1
	end if
	
	ll_childrow = idw_child.getrow()
	
	li_jaejik_opt	=	idw_child.getitemnumber(ll_childrow, 		'jaejik_opt')
	ls_first_date	=	trim(idw_child.getitemstring(ll_childrow, 'firsthire_date'))
	ls_retire_date	=	trim(idw_child.getitemstring(ll_childrow, 'retire_date'))
	
	wf_setitem('name', 			idw_child.getitemstring(ll_childrow, 'name'))
	wf_setitem('jumin_no', 		idw_child.getitemstring(ll_childrow, 'jumin_no'))
	wf_setitem('gwa', 			idw_child.getitemstring(ll_childrow, 'gwa'))
	wf_setitem('sal_class', 	idw_child.getitemstring(ll_childrow, 'sal_class'))
	wf_setitem('duty_code', 	idw_child.getitemstring(ll_childrow, 'duty_code'))
	wf_setitem('bojik_code',	idw_child.getitemstring(ll_childrow, 'bojik_code1'))
	wf_setitem('jikjong_code', string(idw_child.getitemnumber(ll_childrow, 'jikjong_code')))
	wf_setitem('jikwi_code', 	string(idw_child.getitemnumber(ll_childrow, 'jikwi_code')))
	wf_setitem('jikmu_code',	string(idw_child.getitemnumber(ll_childrow, 'jikmu_code')))
	wf_setitem('jaejik_opt',	string(li_jaejik_opt))
	li_annOpt	=	idw_child.getitemnumber(ll_childrow, 'ann_opt')
	wf_setitem('ann_opt',		string(idw_child.getitemnumber(ll_childrow, 'ann_opt')))
	wf_setitem('first_date',	ls_first_date)
	wf_setitem('retire_date',	ls_retire_date)
	
	this.modify("t_dept_name.text = '" +	 trim(idw_child.getitemstring(ll_childrow, 'dept_name')) + "'	")
	this.modify("t_jikjong_name.text = '" + trim(idw_child.getitemstring(ll_childrow, 'jikjong_fname')) + "'	")
	this.modify("t_duty_name.text = '" + 	 trim(idw_child.getitemstring(ll_childrow, 'duty_name')) + "'	")
	
	accepttext()
	
	// 급여근무일수를 구한다.
	li_num_of_paywork = f_getpayday(data, is_yearmonth, ls_first_date, ls_retire_date)
	wf_setitem('num_of_paywork', string(li_num_of_paywork))
	
	// 본봉을 구한다.
	ls_DutyCode	=	idw_child.getitemstring(ll_childrow, 'duty_code')
	if left(ls_DutyCode,2)	=	'10'	then ls_DutyCode	=	'100'
	if li_annOpt	=	2					then ls_DutyCode	=	'801'
	ld_rtnamt = f_getsalamt(ls_DutyCode, idw_child.getitemstring(ll_childrow, 'sal_class'), getitemnumber(row, 'ann_opt'))
	wf_setitem('salary',	string(ld_rtnamt))
	
	// 근무년수를 구한다.
	ldb_work_year = f_getworkyear(data, is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('work_year',	string(ldb_work_year))
	
	// 상여근무월수를 구한다.
	li_rtncnt = f_getsangyeomonth(data, is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('num_of_bonwork',	string(li_rtncnt))
	
	// 배우자를 구한다.
	li_rtncnt = f_getwifecnt(data)
	wf_setitem('wife_num',	string(li_rtncnt))

	// 가족수를 구한다.
	li_rtncnt = f_getfamilycnt(data, 1)
	wf_setitem('family_num',	string(li_rtncnt))

	// 부양자20세를 구한다.
	li_rtncnt = f_getfamilycnt(data, 2)
	wf_setitem('support_20',	string(li_rtncnt))

	// 부양자60세를 구한다.
	li_rtncnt = f_getfamilycnt(data, 3)
	wf_setitem('support_60',	string(li_rtncnt))
	
	// 경로우대자를 구한다.
	li_rtncnt = f_getfamilycnt(data, 4)
	wf_setitem('old_num',	string(li_rtncnt))

//	// 기부금공제를 구한다.
//	ld_rtnamt = f_getcontribution(data, is_yearmonth)
//	wf_setitem('contribution',	string(ld_rtnamt))

	// 장애인구분을 구한다.
	select	nvl(decode(handicap_opt, 0, 0, 9), 0)
	into		:li_handicap_opt
	from		indb.hin011m
	where		member_no	=	:data	;
	
	if sqlca.sqlcode <> 0 then	li_handicap_opt	=	0
	
	wf_setitem('handycap',	string(li_handicap_opt))
elseif ls_col = 'name' then
	
	ll_childrow = idw_child.getrow()
	
	li_jaejik_opt	=	idw_child.getitemnumber(ll_childrow, 		'jaejik_opt')
	ls_first_date	=	trim(idw_child.getitemstring(ll_childrow, 'firsthire_date'))
	ls_retire_date	=	trim(idw_child.getitemstring(ll_childrow, 'retire_date'))
	
	wf_setitem('member_no', 	idw_child.getitemstring(ll_childrow, 'member_no'))
	wf_setitem('jumin_no', 		idw_child.getitemstring(ll_childrow, 'jumin_no'))
	wf_setitem('gwa', 			idw_child.getitemstring(ll_childrow, 'gwa'))
	wf_setitem('sal_class', 	idw_child.getitemstring(ll_childrow, 'sal_class'))
	wf_setitem('duty_code', 	idw_child.getitemstring(ll_childrow, 'duty_code'))
	wf_setitem('bojik_code',	idw_child.getitemstring(ll_childrow, 'bojik_code1'))
	wf_setitem('jikjong_code', string(idw_child.getitemnumber(ll_childrow, 'jikjong_code')))
	wf_setitem('jikwi_code', 	string(idw_child.getitemnumber(ll_childrow, 'jikwi_code')))
	wf_setitem('jikmu_code',	string(idw_child.getitemnumber(ll_childrow, 'jikmu_code')))
	li_annOpt	=	idw_child.getitemnumber(ll_childrow, 'ann_opt')
	wf_setitem('ann_opt',		string(idw_child.getitemnumber(ll_childrow, 'ann_opt')))
	wf_setitem('jaejik_opt',	string(li_jaejik_opt))
	wf_setitem('first_date',	ls_first_date)
	wf_setitem('retire_date',	ls_retire_date)
	
	this.modify("t_dept_name.text = '" +	 trim(idw_child.getitemstring(ll_childrow, 'dept_name')) + "'	")
	this.modify("t_jikjong_name.text = '" + trim(idw_child.getitemstring(ll_childrow, 'jikjong_fname')) + "'	")
	this.modify("t_duty_name.text = '" + 	 trim(idw_child.getitemstring(ll_childrow, 'duty_name')) + "'	")
	
	accepttext()
	
	// 급여근무일수를 구한다.
	li_num_of_paywork = f_getpayday(data, is_yearmonth, ls_first_date, ls_retire_date)
	wf_setitem('num_of_paywork', string(li_num_of_paywork))
	
	// 본봉을 구한다.
	ls_DutyCode	=	idw_child.getitemstring(ll_childrow, 'duty_code')
	if left(ls_DutyCode,2)	=	'10'	then ls_DutyCode	=	'100'
	if li_annOpt	=	2	then	ls_DutyCode	=	'801'
	ld_rtnamt = f_getsalamt(ls_DutyCode, idw_child.getitemstring(ll_childrow, 'sal_class'), getitemnumber(row, 'ann_opt'))
	wf_setitem('salary',	string(ld_rtnamt))
	
	// 근무년수를 구한다.
	ldb_work_year = f_getworkyear(data, is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('work_year',	string(ldb_work_year))
	
	// 상여근무월수를 구한다.
	li_rtncnt = f_getsangyeomonth(data, is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('num_of_bonwork',	string(li_rtncnt))
	
	// 배우자를 구한다.
	li_rtncnt = f_getwifecnt(data)
	wf_setitem('wife_num',	string(li_rtncnt))

	// 가족수를 구한다.
	li_rtncnt = f_getfamilycnt(data, 1)
	wf_setitem('family_num',	string(li_rtncnt))

	// 부양자20세를 구한다.
	li_rtncnt = f_getfamilycnt(data, 2)
	wf_setitem('support_20',	string(li_rtncnt))

	// 부양자60세를 구한다.
	li_rtncnt = f_getfamilycnt(data, 3)
	wf_setitem('support_60',	string(li_rtncnt))
	
	// 경로우대자를 구한다.
	li_rtncnt = f_getfamilycnt(data, 4)
	wf_setitem('old_num',	string(li_rtncnt))

//	// 기부금공제를 구한다.
//	ld_rtnamt = f_getcontribution(data, is_yearmonth)
//	wf_setitem('contribution',	string(ld_rtnamt))

	// 장애인구분을 구한다.
	select	nvl(decode(handicap_opt, 0, 0, 9), 0)
	into		:li_handicap_opt
	from		indb.hin011m
	where		member_no	=	:data	;
	
	if sqlca.sqlcode <> 0 then	li_handicap_opt	=	0
	
	wf_setitem('handycap',	string(li_handicap_opt))
	
elseif ls_col = 'sal_class' then
	accepttext()
	
	// 본봉을 구한다.
	ld_rtnamt = f_getsalamt(getitemstring(row, 'duty_code'), getitemstring(row, 'sal_class'), getitemnumber(row, 'ann_opt'))
	wf_setitem('salary',	string(ld_rtnamt))

elseif ls_col = 'year_month' then
	accepttext()
	
//	// 기부금공제를 구한다.
//	ld_rtnamt = f_getcontribution(getitemstring(row, 'member_no'), is_yearmonth)
//	wf_setitem('contribution',	string(ld_rtnamt))
elseif ls_col = 'hakbi3_yn' then
	if data = '0' then
		wf_setitem('iphak_amt',	string(0))
		wf_setitem('hakgy_amt',	string(0))
		wf_setitem('gisung_amt',	string(0))
	end if
	
elseif ls_col = 'first_date' then
	ls_first_date	=	data

	// 급여근무일수를 구한다.
	li_num_of_paywork = f_getpayday(data, is_yearmonth, ls_first_date, ls_retire_date)
	wf_setitem('num_of_paywork', string(li_num_of_paywork))
	
	// 근무년수를 구한다.
	ldb_work_year = f_getworkyear(getitemstring(row, 'member_no'), is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('work_year',	string(ldb_work_year))
	
	// 상여근무월수를 구한다.
	li_rtncnt = f_getsangyeomonth(getitemstring(row, 'member_no'), is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('num_of_bonwork',	string(li_rtncnt))
elseif ls_col = 'retire_date' then
	ls_retire_date	=	data
	
	// 급여근무일수를 구한다.
	li_num_of_paywork = f_getpayday(data, is_yearmonth, ls_first_date, ls_retire_date)
	wf_setitem('num_of_paywork', string(li_num_of_paywork))
	
	// 근무년수를 구한다.
	ldb_work_year = f_getworkyear(getitemstring(row, 'member_no'), is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('work_year',	string(ldb_work_year))
	
	// 상여근무월수를 구한다.
	li_rtncnt = f_getsangyeomonth(getitemstring(row, 'member_no'), is_yearmonth, ls_first_date, ls_retire_date, is_today)
	wf_setitem('num_of_bonwork',	string(li_rtncnt))
end if

accepttext()

if left(ls_type, 6) = 'number' or left(ls_type, 7) = 'decimal' then
	idw_list.setitem(ll_row, ls_col, dec(data))
elseif ls_type = 'date' then
	idw_list.setitem(ll_row, ls_col, date(data))
else	
	idw_list.setitem(ll_row, ls_col, data)
end if

idw_list.setitem(ll_row, 'job_uid',		gs_empcode)  // gstru_uid_uname.uid)
idw_list.setitem(ll_row, 'job_add',		gs_ip)   // gstru_uid_uname.address)
idw_list.setitem(ll_row, 'job_date',	f_sysdate())



end event

event losefocus;call super::losefocus;accepttext()
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2048
long backcolor = 16777215
string text = "급여대상자기초자료내역"
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
integer width = 4352
integer height = 2048
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa207a_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type uo_dept_code from cuo_dept within w_hpa207a
event destroy ( )
integer x = 1010
integer y = 172
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

on uo_dept_code.destroy
call cuo_dept::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_dept_code = uf_getcode()


end event

type uo_yearmonth from cuo_yearmonth within w_hpa207a
integer x = 119
integer y = 176
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_yearmonth.destroy
call cuo_yearmonth::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_yearmonth	=	uf_getyearmonth()

is_today = string(relativedate(date(string(is_yearmonth, '@@@@/@@/' + '01')), -1), 'yyyymmdd')
em_pay_date.text = string(is_today, '@@@@/@@/@@')

wf_confirm_gbn()


end event

type st_2 from statictext within w_hpa207a
integer x = 2350
integer y = 192
integer width = 686
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
string text = "근무년수계산기준일자"
boolean focusrectangle = false
end type

type em_pay_date from editmask within w_hpa207a
integer x = 3045
integer y = 176
integer width = 489
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "19000101~~29991231"
end type

event modified;date		ldt_pay_date
string	ls_bef_date

ls_bef_date	=	 this.text

if getdata(ldt_pay_date) < 0 then
	f_messagebox('1', st_2.text + '를 정확히 입력해 주시기 바랍니다.!')
	this.text = ls_bef_date
	is_today = ''
end if

is_today	=	string(ldt_pay_date, 'yyyymmdd')

end event

type rb_7 from radiobutton within w_hpa207a
integer x = 1874
integer y = 272
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "직원"
end type

event clicked;is_DutyCode = '3'
end event

type rb_6 from radiobutton within w_hpa207a
integer x = 1531
integer y = 272
integer width = 274
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "조교"
end type

event clicked;is_DutyCode = '2'
end event

type rb_5 from radiobutton within w_hpa207a
integer x = 1184
integer y = 272
integer width = 242
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "교원"
end type

event clicked;is_DutyCode = '1'
end event

type rb_all from radiobutton within w_hpa207a
integer x = 846
integer y = 272
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "전체"
end type

event clicked;is_DutyCode = '0'
end event

