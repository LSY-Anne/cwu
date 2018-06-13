$PBExportHeader$w_hpa106a.srw
$PBExportComments$건강보험 등급 관리/출력
forward
global type w_hpa106a from w_tabsheet
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
type pb_fileupload from uo_imgbtn within w_hpa106a
end type
type st_status from statictext within w_hpa106a
end type
type st_mes1 from statictext within w_hpa106a
end type
type st_mes2 from statictext within w_hpa106a
end type
end forward

global type w_hpa106a from w_tabsheet
string title = "건강보험 등급 관리/출력"
pb_fileupload pb_fileupload
st_status st_status
st_mes1 st_mes1
st_mes2 st_mes2
end type
global w_hpa106a w_hpa106a

type variables
datawindowchild	idw_child
datawindow			idw_data

statictext			ist_back

string	is_pay_opt = '1'
string	is_code, is_name
integer	ii_jikjong_code = 0, ii_maxcode = 0

end variables

forward prototypes
public function integer wf_fileupload ()
public function integer wf_retrieve ()
end prototypes

public function integer wf_fileupload ();// ==========================================================================================
// 기    능 : 	file upload
// 작 성 인 : 	안금옥
// 작성일자 : 	2002.04
// 함수원형 : 	wf_fileupload()	return	integer
// 인    수 :
// 되 돌 림 :	sqlca.sqlcode
// 주의사항 :
// 수정사항 :
// ==========================================================================================

// Upload File Open
Integer	li_Rtn
String	ls_FullName
String	ls_FileName
String	ls_message

dw_con.accepttext()

if trim(dw_con.object.filename[1]) = '' then
	ls_fullname = f_getfileopen('TXT')
	if ls_fullname = '' then	return	100
else
	ls_fullname = trim(dw_con.object.filename[1])
end if

if FileExists(ls_fullname) = false then
	if f_messagebox('2', ls_fullname + '~n화일이 존재하지 않습니다.~n~n다시 선택하시려면 [예]를 누르세요.!') = 2 then	
		return 100
	else
		ls_fullname = f_getfileopen('TXT')
		if ls_fullname = '' then	return	100
	end if
end if

dw_con.object.filename[1] = trim(ls_FullName)

li_rtn =	messagebox('확인', ls_fullname + '~n화일의 자료를 생성하시려면 [예]를 누르시고,'	+	&
														'~n화일의 자료를 생성하지 않으시려면 [아니오]를 누르시고,'	+	&
														'~n화일을 다시 선택하시려면 [취소]를 누르세요.!', question!, yesnocancel!)

if li_rtn = 3 then
	ls_fullname = f_getfileopen('TXT')
	if ls_fullname = '' then	return	100
elseif li_rtn = 2 then
	return	100
end if

// 자료가 있는지 체크한다.
long   	ll_count

select	count(*)
into		:ll_count
from		padb.hpa006m	;

if ll_count > 0 then
	if f_messagebox('2', '이미 생성된 자료가 있습니다.~n~n다시 생성하시려면 [예]를 누르세요.!') = 2 then 
		return	100
	else
		// 이미 생성된 자료 삭제
		delete	from	padb.hpa006m	;
		
		if sqlca.sqlcode <> 0 then	return	sqlca.sqlcode
		
		idw_data.reset()
	end if
end if

// 화일 열기
Integer		li_FileOpen

li_FileOpen = FileOpen(ls_fullname, LineMode!, Read!, LockWrite!, Replace!)

if li_FileOpen = -1 then
	f_messagebox('3', '대상파일을 열지 못했습니다.!')
	return	100
end if

// 대상파일 길이체크 
Long		ll_FileLen

ll_FileLen = FileLength(ls_fullname)

if ll_filelen = -1 then
	f_messagebox('3', '대상파일 길이 체크 중 오류가 발생하였습니다.!')
	return	100
end if

SetPointer(HourGlass!)

ls_message	=	ls_fullname + '의 자료를 생성 중입니다...'

st_status.text = ls_message

st_status.visible = true
st_mes1.visible 	= false
st_mes2.visible 	= false

String	ls_FileRead, ls_col[] = {'rank', 'std_tax', 'low_value', 'high_limit', 'comp_fee', 'self_fee'}
Long		ll_FileRead, ll_row
integer	li_find, i

ll_FileLen  = 0
ll_FileRead = FileRead(li_FileOpen, ls_FileRead)
ll_row		= 0

DO UNTIL ll_FileRead = -100
	ll_FileLen = LEN(ls_FileRead)
	IF ll_FileLen = 0 THEN
		ll_FileRead = FileRead(li_FileOpen, ls_FileRead)
		continue
	END IF
	
	li_find	= 0
	ll_row	++
	
	idw_data.insertrow(0)
	for i = 1 to 6
		li_find = pos(ls_fileread, '	')
		idw_data.setitem(ll_row, ls_col[i], dec(mid(ls_fileread, 1, li_find - 1)))
		ls_fileread = mid(ls_fileread, li_find + 1, len(ls_fileread))
	next
	idw_data.setitem(ll_row, 'worker',		gs_empcode )//gstru_uid_uname.uid)
	idw_data.setitem(ll_row, 'ipaddr',		gs_ip  ) //gstru_uid_uname.address)
	idw_data.setitem(ll_row, 'work_date',	f_sysdate())
	idw_data.setitem(ll_row, 'job_uid',			gs_empcode )
	idw_data.setitem(ll_row, 'job_add',			gs_ip  ) //gstru_uid_uname.address)
	idw_data.setitem(ll_row, 'job_date',	f_sysdate())

	ll_FileRead = FileRead(li_FileOpen, ls_FileRead)
LOOP

FileClose(li_FileOpen)

f_messagebox('1', string(ll_row) + '건의 자료를 생성했습니다.!')

return	0

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

ist_back.bringtotop = true

if idw_data.retrieve() > 0 then
	idw_print.retrieve()
	ist_back.bringtotop = false
else
	idw_print.reset()
end if

return 0
end function

on w_hpa106a.create
int iCurrent
call super::create
this.pb_fileupload=create pb_fileupload
this.st_status=create st_status
this.st_mes1=create st_mes1
this.st_mes2=create st_mes2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_fileupload
this.Control[iCurrent+2]=this.st_status
this.Control[iCurrent+3]=this.st_mes1
this.Control[iCurrent+4]=this.st_mes2
end on

on w_hpa106a.destroy
call super::destroy
destroy(this.pb_fileupload)
destroy(this.st_status)
destroy(this.st_mes1)
destroy(this.st_mes2)
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

integer	li_newrow, li_rank



//idw_data.Selectrow(0, false)	

li_newrow	=	idw_data.getrow() + 1
idw_data.insertrow(li_newrow)

idw_data.setrow(li_newrow)
idw_data.scrolltorow(li_newrow)

li_rank	= integer(idw_data.describe("evaluate('max(rank)', 1)"))
li_rank ++

idw_data.setitem(li_newrow, 'rank',			li_rank)
idw_data.setitem(li_newrow, 'worker',		gs_empcode )// gstru_uid_uname.uid)
idw_data.setitem(li_newrow, 'ipaddr',		gs_ip )  //gstru_uid_uname.address)
idw_data.setitem(li_newrow, 'work_date',	f_sysdate())

idw_data.setcolumn('rank')
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
//idw_data		=	tab_sheet.tabpage_sheet01.dw_update
//idw_print	=	tab_sheet.tabpage_sheet02.dw_print
//ist_back		=	tab_sheet.tabpage_sheet02.st_back
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
long		ll_currentrow



dw_name   = idw_data  	                 		//저장하고자하는 데이타 원도우

//li_findrow = dw_name.GetSelectedrow(0) 	  	//현재 저장하고자하는 행번호
IF dw_name.Update(true) = 1 THEN
	COMMIT;
//	triggerevent('ue_retrieve')
ELSE
	MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
							'하단의 장애번호와 장애내역을~r~n' + &
							'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							'장애내역 : ' + SQLCA.SqlErrText + '~r~n')
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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa106a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa106a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa106a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa106a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa106a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa106a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa106a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa106a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa106a
end type

type uc_save from w_tabsheet`uc_save within w_hpa106a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa106a
end type

type uc_print from w_tabsheet`uc_print within w_hpa106a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa106a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa106a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa106a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa106a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa106a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa106a
integer y = 320
integer width = 4384
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
integer height = 1832
string text = "건강보험등급관리"
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
string dataobject = "d_hpa106a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode) //gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip )  //gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

type uo_tab from w_tabsheet`uo_tab within w_hpa106a
end type

type dw_con from w_tabsheet`dw_con within w_hpa106a
string dataobject = "d_hpa106a_con"
end type

event dw_con::constructor;call super::constructor;This.settransobject(sqlca)

st_status.setposition(totop!)
st_mes1.setposition(totop!)
st_mes2.setposition(totop!)

end event

type st_con from w_tabsheet`st_con within w_hpa106a
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer y = 136
integer width = 101
integer height = 100
integer taborder = 20
string dataobject = "d_hpa106a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event losefocus;call super::losefocus;accepttext()
end event

event itemchanged;call super::itemchanged;setitem(row, 'job_uid',		gs_empcode) //gstru_uid_uname.uid)
setitem(row, 'job_add',		gs_ip )  //gstru_uid_uname.address)
setitem(row, 'job_date',	f_sysdate())
end event

type tabpage_sheet02 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1832
long backcolor = 16777215
string text = "건강보험등급내역"
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
integer y = 4
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
integer y = 4
integer width = 4347
integer height = 1832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hpa106a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type pb_fileupload from uo_imgbtn within w_hpa106a
event destroy ( )
integer x = 55
integer y = 36
integer taborder = 51
boolean bringtotop = true
string btnname = "화일업로드"
end type

on pb_fileupload.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;// 자료를 생성한다.

integer	li_rtn

li_rtn = wf_fileupload()

if li_rtn < 0 then
	f_messagebox('3', sqlca.sqlerrtext)
	rollback	;
elseif li_rtn = 0 then
	commit	;
	parent.triggerevent('ue_save')
	
	parent.triggerevent('ue_retrieve')
end if

st_status.visible = false
st_mes1.visible 	= true
st_mes2.visible 	= true

end event

type st_status from statictext within w_hpa106a
boolean visible = false
integer x = 2606
integer y = 196
integer width = 1289
integer height = 48
boolean bringtotop = true
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

type st_mes1 from statictext within w_hpa106a
integer x = 2606
integer y = 168
integer width = 1239
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 건강보험등급 파일은 Text파일이어야 하며,"
boolean focusrectangle = false
end type

type st_mes2 from statictext within w_hpa106a
integer x = 2606
integer y = 224
integer width = 1129
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "   각 항목은 탭으로 구분되어야 합니다."
boolean focusrectangle = false
end type

