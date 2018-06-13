$PBExportHeader$w_hpa103a.srw
$PBExportComments$급여항목 코드 관리/출력(관리자용) - 모두 수정 가능
forward
global type w_hpa103a from w_tabsheet
end type
type tabpage_sheet02 from userobject within tab_sheet
end type
type st_back from statictext within tabpage_sheet02
end type
type dw_print from cuo_dwprint within tabpage_sheet02
end type
type tabpage_sheet02 from userobject within tab_sheet
st_back st_back
dw_print dw_print
end type
type st_2 from statictext within w_hpa103a
end type
type st_3 from statictext within w_hpa103a
end type
end forward

global type w_hpa103a from w_tabsheet
string title = "급여항목 코드 관리/출력(관리자용)"
st_2 st_2
st_3 st_3
end type
global w_hpa103a w_hpa103a

type variables
datawindowchild	idw_child
datawindow			idw_data

statictext			ist_back

string	is_pay_opt = '1'
integer	ii_jikjong_code = 0, ii_maxcode = 0
end variables

forward prototypes
public subroutine wf_getchild ()
public function integer wf_retrieve ()
end prototypes

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

// 항목코드
idw_data.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('excepte_gbn', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('excepte_gbn', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
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

ist_back.bringtotop = true

if idw_data.retrieve(is_pay_opt) > 0 then
	idw_print.retrieve(is_pay_opt)
	ist_back.bringtotop = false
else
	idw_print.reset()
end if

return 0
end function

on w_hpa103a.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_3
end on

on w_hpa103a.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_3)
end on

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 조회한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

//f_setpointer('START')
wf_retrieve()
//f_setpointer('END')
return 1
end event

event ue_insert;call super::ue_insert;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 입력한다.                           //
// 작성일자 : 2001. 08                                     //
// 작 성 인 : 								                       //
/////////////////////////////////////////////////////////////

String s_name,s_max_no  
int    i_tab,i_newrow
long   l_max_no

integer	li_newrow

if isnull(is_pay_opt) or trim(is_pay_opt) = '' then
	f_messagebox('1', '급여항목 지급구분을 선택해 주세요.!')
	return
end if
	
//f_setpointer('START')

//idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)
idw_data.scrolltorow(li_newrow)

// 1라인에서 수당이면 01로 시작, 공제이면 51로 시작한다.
if ii_maxcode = 0 then
	select	nvl(max(code) + 1, decode(:is_pay_opt, '1', 1, 51))
	into		:ii_maxcode
	from		padb.hpa003m
	where		pay_opt	=	:is_pay_opt	;

	if sqlca.sqlcode <> 0 then	ii_maxcode = 1
else
	ii_maxcode	= integer(idw_data.describe("evaluate('max(integer(code))', 1)"))
	ii_maxcode 	++
end if

//if li_newrow = 1 then
//	if is_pay_opt = '1' then
//		idw_data.setitem(li_newrow, 'code',	'01')
//	else
//		idw_data.setitem(li_newrow, 'code',	'51')
//	end if		
//else
//	idw_data.setitem(li_newrow, 'code',	string(integer(idw_data.getitemstring(li_newrow - 1, 'code')) + 1, '00'))
//end if	

idw_data.setcolumn('code')
idw_data.setfocus()

idw_data.setitem(li_newrow, 'code',			string(ii_maxcode, '00'))
idw_data.setitem(li_newrow, 'pay_opt',		is_pay_opt)
idw_data.SetItem(li_newrow, 'use_date', 	f_today())	

idw_data.setitem(li_newrow, 'worker',	gs_empcode ) //	gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',	gs_ip )  //	gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())





//String s_name,s_max_no  
//int    i_tab,i_newrow
//long   l_max_no
//f_setpointer('START')
//i_tab  = tab_sheet.selectedtab
//choose case i_tab
//	case 1
//	tab_sheet.tabpage_sheet01.dw_list001.Selectrow(0,false)	
//	tab_sheet.tabpage_sheet01.dw_update101.Setredraw(False)			
//	tab_sheet.tabpage_sheet01.dw_update101.reset()		
//	SELECT MAX(MEMBER_NO) INTO :s_max_no FROM INDB.HINSAMASTER ;
//   IF isnull(s_max_no ) then 
//	   s_max_no  = '000001'
//	ELSE
//		l_max_no = Long(s_max_no)
//		l_max_no = l_max_no + 1
//		s_max_no = String(l_max_no,'000000')
//	END IF
//	
//	i_newrow = tab_sheet.tabpage_sheet01.dw_update101.INsertrow(0)
//   tab_sheet.tabpage_sheet01.dw_update101.SetItem(i_newrow, 'member_no', s_max_no)	
//	tab_sheet.tabpage_sheet01.dw_update101.Setredraw(true)	
//end choose	
//f_setpointer('END')
//
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
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update_tab
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//
//wf_getchild()
//
//triggerevent('ue_retrieve')
//
end event

event ue_save;call super::ue_save;/////////////////////////////////////////////////////////////
// 작성목적 : 데이타를 저장한다.		                       //
// 작성일자 : 2001. 8                                      //
// 작 성 인 : 						                             //
/////////////////////////////////////////////////////////////

datawindow	dw_name
integer	li_findrow



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

integer		li_deleterow, li_cnt
string		ls_code, ls_name


wf_setMsg('삭제중')

ls_code	=	idw_data.getitemstring(idw_data.getrow(), 'code')
ls_name	=	idw_data.getitemstring(idw_data.getrow(), 'item_name')

// 월 급여자료에 코드가 존재하면 삭제할 수 없다.
select	count(*)
into		:li_cnt
from		padb.hpa005d
where		code	=	:ls_code	;

if li_cnt > 0 then
	f_messagebox('3', '[' + ls_name + ']의 급여자료가 존재하므로 삭제할 수 없습니다.!')
		wf_setMsg('.')

		return 
end if

// 급여계산기준정보가 존재하면 Trigger로 기준정보를 삭제한다.
select	count(*)
into		:li_cnt
from		padb.hpa003d
where		code	=	:ls_code	;

if li_cnt > 0 then
	if f_messagebox('2', '[' + ls_name + ']의 급여계산기준정보가 존재합니다.~n~n급여계산기준정보를 같이 삭제하시겠습니까?') = 2 then
		wf_setMsg('.')

		return 
	end if
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
ist_back		=	tab_sheet.tabpage_sheet02.st_back

wf_getchild()

triggerevent('ue_retrieve')

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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa103a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa103a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa103a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa103a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa103a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa103a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa103a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa103a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa103a
end type

type uc_save from w_tabsheet`uc_save within w_hpa103a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa103a
end type

type uc_print from w_tabsheet`uc_print within w_hpa103a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa103a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa103a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa103a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa103a
integer y = 324
integer width = 4384
integer height = 1948
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
//	case else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
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
integer height = 1828
string text = "급여항목코드관리"
end type

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
string dataobject = "d_hpa103a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화

string	ls_month, ls_month_1
integer	li_month, i

if dwo.name = 'item_name' then
	if getitemnumber(row, 'sort') > 0 and (isnull(getitemstring(row, 'display_name')) or trim(getitemstring(row, 'display_name')) = '') then
		setitem(row, 'display_name', trim(data))
	end if
elseif dwo.name = 'month_0' then
	if data = '111111111111' then
		setitem(row, 'pay_month', data)
	else
		ls_month = ''
		for i = 1 to 12
			if getitemstring(row, 'month_' + string(i)) = '1' then
				ls_month += '1'
			else
				ls_month += '0'
			end if
		next
		setitem(row, 'pay_month', ls_month)
	end if
elseif dwo.name = 'month_1' or dwo.name = 'month_2' or dwo.name = 'month_3' or dwo.name = 'month_4' or	&
		 dwo.name = 'month_5' or dwo.name = 'month_6' or dwo.name = 'month_7' or dwo.name = 'month_8' or	&
		 dwo.name = 'month_9' then
	li_month = integer(right(dwo.name, 1))
	ls_month = getitemstring(row, 'pay_month')
	ls_month_1 = left(ls_month, li_month - 1)
	if data = '1' then
		ls_month_1 += '1'
		ls_month_1 += mid(ls_month, li_month + 1, len(ls_month))
	else
		ls_month_1 += '0'
		ls_month_1 += mid(ls_month, li_month + 1, len(ls_month))
	end if		
	setitem(row, 'pay_month', ls_month_1)
elseif dwo.name = 'month_10' or dwo.name = 'month_11' or dwo.name = 'month_12' then
	li_month = integer(right(dwo.name, 2))
	ls_month = getitemstring(row, 'pay_month')
	ls_month_1 = left(ls_month, li_month - 1)
	if data = '1' then
		ls_month_1 += '1'
		ls_month_1 += mid(ls_month, li_month + 1, len(ls_month))
	else
		ls_month_1 += '0'
		ls_month_1 += mid(ls_month, li_month + 1, len(ls_month))
	end if		
	setitem(row, 'pay_month', ls_month_1)
end if		

setitem(row, 'job_uid',		gs_empcode)
setitem(row, 'job_add',		gs_ip)
setitem(row, 'job_date',	f_sysdate())

end event

event dw_update_tab::retrieveend;call super::retrieveend;integer	i

ii_maxcode = 0

for i = 1 to rowcount
	if getitemstring(i, 'pay_month') <> '111111111111' then
		setitem(i, 'month_0', '0')
	else
		setitem(i, 'month_0', '111111111111')
	end if
	
next
end event

event dw_update_tab::updateend;call super::updateend;ii_maxcode = 0
end event

type uo_tab from w_tabsheet`uo_tab within w_hpa103a
end type

type dw_con from w_tabsheet`dw_con within w_hpa103a
string dataobject = "d_hpa103a_con"
end type

event dw_con::itemchanged;call super::itemchanged;This.accepttext()

is_pay_opt = data

parent.event ue_retrieve()
end event

event dw_con::constructor;call super::constructor;st_2.setposition(totop!)
st_3.setposition(totop!)
end event

type st_con from w_tabsheet`st_con within w_hpa103a
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1828
long backcolor = 16777215
string text = "급여항목코드내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_back st_back
dw_print dw_print
end type

on tabpage_sheet02.create
this.st_back=create st_back
this.dw_print=create dw_print
this.Control[]={this.st_back,&
this.dw_print}
end on

on tabpage_sheet02.destroy
destroy(this.st_back)
destroy(this.dw_print)
end on

type st_back from statictext within tabpage_sheet02
integer width = 3845
integer height = 2180
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 16777215
boolean border = true
long bordercolor = 16777215
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_print from cuo_dwprint within tabpage_sheet02
integer width = 4343
integer height = 1832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa103a_2"
boolean vscrollbar = true
boolean border = false
end type

type st_2 from statictext within w_hpa103a
integer x = 1449
integer y = 164
integer width = 2318
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
string text = "※ 수당코드는 01부터 시작하며, 공제코드는 51부터 시작합니다."
boolean focusrectangle = false
end type

type st_3 from statictext within w_hpa103a
integer x = 1449
integer y = 220
integer width = 2318
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
string text = "   기타수당은 41~~49 기타공제는 91~~99까지로 제한하며, 변고는 기타로 되어야 합니다."
boolean focusrectangle = false
end type

