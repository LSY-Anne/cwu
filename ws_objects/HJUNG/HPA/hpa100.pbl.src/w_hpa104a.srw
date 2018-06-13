$PBExportHeader$w_hpa104a.srw
$PBExportComments$급여계산 기준코드 관리/출력(관리자용) - 무두 수정 가능
forward
global type w_hpa104a from w_tabsheet
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
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
type cbx_1 from checkbox within w_hpa104a
end type
end forward

global type w_hpa104a from w_tabsheet
string title = "급여계산 기준코드 관리/출력(관리자용)"
cbx_1 cbx_1
end type
global w_hpa104a w_hpa104a

type variables
datawindowchild	idw_child
datawindow			idw_data//, idw_print

statictext			ist_back

string	is_pay_opt = '1'
string	is_code, is_name
integer	ii_jikjong_code = 0, ii_maxcode = 0

end variables

forward prototypes
public subroutine wf_getchild ()
public subroutine wf_head_retrieve ()
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

// 직종코드
idw_data.getchild('jikjong_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikjong_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
else
	idw_child.insertrow(1)
	idw_child.setitem(1, 'code',	0)
	idw_child.setitem(1, 'fname',	'구분없음')
end if

idw_print.getchild('jikjong_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('jikjong_code', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
else
	idw_child.insertrow(1)
	idw_child.setitem(1, 'code',	0)
	idw_child.setitem(1, 'fname',	'구분없음')
end if

// 직급코드
idw_data.getchild('duty_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('', 0) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('duty_code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('', 0) < 1 then
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
	
end subroutine

public subroutine wf_head_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_head_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================

//dw_head.reset()
//dw_head.insertrow(0)

dw_con.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(is_pay_opt, '1', '4') < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

idw_print.getchild('code', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(is_pay_opt, '1', '4') < 1 then
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

if cbx_1.checked then
	if idw_print.retrieve(is_pay_opt, '') > 0 then
		ist_back.bringtotop = false
	else
		ist_back.bringtotop = true
		idw_print.reset()
	end if		
else
	if idw_data.retrieve(is_code) > 0 then
		idw_print.retrieve(is_pay_opt, is_code)
		ist_back.bringtotop = false
	else
		ist_back.bringtotop = true
		idw_print.reset()
	end if
end if

return 0
end function

on w_hpa104a.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_hpa104a.destroy
call super::destroy
destroy(this.cbx_1)
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

String s_name,s_max_no  
int    i_tab,i_newrow, li_befrow
long   l_max_no

integer	li_newrow

if isnull(is_pay_opt) or trim(is_pay_opt) = '' then
	f_messagebox('1', '급여항목 지급구분을 선택해 주세요.!')
	return
end if
	
if isnull(is_code) or trim(is_code) = '' then
	f_messagebox('1', '급여항목을 선택해 주세요.!')
	dw_con.setfocus()
	dw_con.setcolumn('code')
	return
end if



//idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)
idw_data.scrolltorow(li_newrow)

if ii_maxcode = 0 then
	select	nvl(max(calc_code) + 1, 1)
	into		:ii_maxcode
	from		padb.hpa003d
	where		code		=	:is_code	;

	if sqlca.sqlcode <> 0 then	ii_maxcode = 1
else
	ii_maxcode	= integer(idw_data.describe("evaluate('max(integer(calc_code))', 1)"))
	ii_maxcode ++
end if

if li_newrow > 1 then
	li_befrow	=	li_newrow - 1
	idw_data.setitem(li_newrow, 'jikjong_code', 	idw_data.getitemnumber(li_befrow, 'jikjong_code'))
	idw_data.setitem(li_newrow, 'calc_gbn',		idw_data.getitemstring(li_befrow, 'calc_gbn'))
	idw_data.setitem(li_newrow, 'gubun_chk',		idw_data.getitemstring(li_befrow, 'gubun_chk'))
end if
idw_data.setitem(li_newrow, 'calc_code',	string(ii_maxcode, '00'))

idw_data.setcolumn('calc_code')
idw_data.setfocus()

idw_data.setitem(li_newrow, 'code',			is_code)
idw_data.setitem(li_newrow, 'calc_name',			is_name)
idw_data.setitem(li_newrow, 'pay_opt',		is_pay_opt)

idw_data.setitem(li_newrow, 'worker',		gs_empcode )//gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip  ) //gstru_uid_uname.address)
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
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
//
//wf_head_retrieve()
//
//wf_getchild()
//
//dw_head.setfocus()
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


wf_setMsg('삭제중')

li_deleterow	=	idw_data.deleterow(0)

//IF idw_data.Update(true) = 1 THEN
//  COMMIT		;
////  wf_setMenu('D', false)       //삭제버튼 사용금지
//ELSE
//  ROLLBACK	;
//END IF

wf_setMsg('.')

return 



///////////////////////////////////////////////////////////////
//// 작성목적 : 데이타삭제 사용한다.                       //
//// 작성일자 : 2000. 9                                      //
//// 작 성 인 : 제일정보(서재범)                             //
///////////////////////////////////////////////////////////////
//
//int          i_tab,  i_findrow,i_code,i_row = 1,i_deleterow
//String       s_type, s_fname,s_sname,s_ename,s_process_gbn,s_user
//
//f_setpointer('START')
//wf_setMsg('삭제중')
//i_tab  = tab_sheet.selectedtab
//choose case i_tab
//	case 1
//		  i_findrow     = tab_sheet.tabpage_sheet01.dw_list001.GetSelectedrow(0) //현재 저장하고자하는 행번호
//  		  i_deleterow   = tab_sheet.tabpage_sheet01.dw_update101.deleterow(0)
//   	  IF tab_sheet.tabpage_sheet01.dw_update101.Update(true) = 1 THEN
//	   	  COMMIT;
//		     IF i_findrow > 0 THEN
//			     i_findrow  = tab_sheet.tabpage_sheet01.dw_list001.DELETEROW(0)
//  			  END IF
//			  wf_setMenu('D',false)       //삭제버튼 사용금지
//   	  ELSE
//           tab_sheet.tabpage_sheet01.dw_update101.rowscopy(i_deleterow,i_deleterow,Delete!,tab_sheet.tabpage_sheet01.dw_update101,1,Primary!)				
//	   	  ROLLBACK;
//  		  END IF
//
//
//END CHOOSE		
//
//wf_setMsg('.')
//
//
//f_setpointer('END')
//return 0
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



wf_head_retrieve()

wf_getchild()

dw_con.setfocus()
dw_con.setcolumn('code')

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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa104a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa104a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa104a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa104a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa104a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa104a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa104a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa104a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa104a
end type

type uc_save from w_tabsheet`uc_save within w_hpa104a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa104a
end type

type uc_print from w_tabsheet`uc_print within w_hpa104a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa104a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa104a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa104a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa104a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa104a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa104a
integer y = 324
integer height = 1940
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_sheet02 tabpage_sheet02
end type

event tab_sheet::selectionchanged;call super::selectionchanged;choose case newindex
	case 1
//		wf_setMenu('INSERT',		TRUE)
//		wf_setMenu('DELETE',		TRUE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		TRUE)
//		wf_setMenu('PRINT',		fALSE)
		cbx_1.visible 		= false
		dw_con.object.code.protect = 0 //.enabled	= true
	case else
//		wf_setMenu('INSERT',		fALSE)
//		wf_setMenu('DELETE',		fALSE)
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('UPDATE',		fALSE)
//		wf_setMenu('PRINT',		TRUE)
		cbx_1.visible		= true
		if cbx_1.checked then
			dw_con.object.code.protect = 1 // dw_head.enabled = false
		else
			dw_con.object.code.protect = 0 //dw_head.enabled = true
		end if
end choose
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
integer height = 1820
string text = "급여계산기준코드관리"
dw_update dw_update
end type

on tabpage_sheet01.create
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_update)
end on

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
integer height = 1824
string dataobject = "d_hpa104a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
setitem(row, 'job_uid',		gs_empcode )//gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip )  //gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())	

end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

event dw_update_tab::retrieveend;call super::retrieveend;ii_maxcode = 0

if rowcount < 1 then
	dw_con.setfocus()
	dw_con.setcolumn('code')
else
	setfocus()
end if
end event

event dw_update_tab::updateend;call super::updateend;ii_maxcode = 0
end event

type uo_tab from w_tabsheet`uo_tab within w_hpa104a
end type

type dw_con from w_tabsheet`dw_con within w_hpa104a
string dataobject = "d_hpa104a_con"
end type

event dw_con::itemchanged;call super::itemchanged;This.accepttext()

Choose Case dwo.name
	case 'pay_opt'
		is_pay_opt = data
		wf_head_retrieve()
		
		is_code	= ''
		is_name	= ''
		
		parent.triggerevent('ue_retrieve')
	case 'code'
		if isnull(data) then	
			is_code	= ''
			is_name	= ''
			return -1
		end if

		
		is_code	=	string(data)
		is_name	=	 dw_con.describe("Evaluate ('LookUpDisplay (code)', " + string(row) + ")")//getitemstring(row, 'code_name')
		is_name	=	mid(is_name, 6, len(is_name))
		
		parent.triggerevent('ue_retrieve')
End Choose
end event

event dw_con::itemfocuschanged;call super::itemfocuschanged;//triggerevent(itemchanged!)
end event

event dw_con::constructor;call super::constructor;cbx_1.setposition(totop!)

end event

type st_con from w_tabsheet`st_con within w_hpa104a
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer x = 334
integer y = 128
integer width = 3845
integer height = 2180
integer taborder = 20
string dataobject = "d_hpa104a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
setitem(row, 'job_uid',		gs_empcode )//gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip )  //gstru_uid_uname.address)
SetItem(row, 'job_date', 	f_sysdate())	

end event

event updateend;call super::updateend;ii_maxcode = 0
end event

event retrieveend;call super::retrieveend;ii_maxcode = 0

if rowcount < 1 then
	dw_con.setfocus()
	dw_con.setcolumn('code')
else
	setfocus()
end if
end event

event losefocus;call super::losefocus;accepttext()
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4338
integer height = 1820
long backcolor = 16777215
string text = "급여계산기준코드내역"
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
integer y = 12
integer width = 3845
integer height = 2296
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_print from cuo_dwprint within tabpage_sheet02
integer y = 12
integer width = 4329
integer height = 1800
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa104a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type cbx_1 from checkbox within w_hpa104a
integer x = 2391
integer y = 184
integer width = 270
integer height = 64
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

event clicked;if cbx_1.checked then
	dw_con.object.code.protect = 1 // dw_head.enabled = false
	dw_con.object.code.background.color = 78682240
	idw_print.retrieve(is_pay_opt, '')
else
	dw_con.object.code.protect = 0 // dw_head.enabled = true
	dw_con.object.code.background.color = rgb(255, 255, 255)
	idw_print.retrieve(is_pay_opt, is_code)
end if

if idw_print.rowcount() > 0 then
	ist_back.bringtotop = false
else
	ist_back.bringtotop = true
	idw_print.reset()
end if		

end event

event constructor;setposition(totop!)
end event

