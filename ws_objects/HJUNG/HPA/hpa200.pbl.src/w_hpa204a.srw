$PBExportHeader$w_hpa204a.srw
$PBExportComments$고용보험 관리
forward
global type w_hpa204a from w_tabsheet
end type
type dw_list from datawindow within tabpage_sheet01
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print from cuo_dwwindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print dw_print
end type
type tabpage_2 from userobject within tab_sheet
end type
type dw_1 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
dw_1 dw_1
end type
type sle_biyul from singlelineedit within w_hpa204a
end type
type st_3 from statictext within w_hpa204a
end type
type uo_yearhakgi from cuo_yyhakgi within w_hpa204a
end type
type uo_month from cuo_month within w_hpa204a
end type
type cb_1 from uo_imgbtn within w_hpa204a
end type
end forward

global type w_hpa204a from w_tabsheet
sle_biyul sle_biyul
st_3 st_3
uo_yearhakgi uo_yearhakgi
uo_month uo_month
cb_1 cb_1
end type
global w_hpa204a w_hpa204a

type variables

integer ii_tab
integer ii_str_jikjong = 0, ii_end_jikjong = 9
long il_getrow = 1

datawindowchild idw_child, idw_kname_child, ldwc_Temp
datawindow idw_sname

DataWindow	dw_update
DataWindow	dw_list

string	is_year, is_hakgi
integer	ii_month
DataWindowchild	idwc_Gwa

end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_insert ()
end prototypes

public subroutine wf_retrieve ();//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: 
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

ii_tab = tab_sheet.selectedtab
CHOOSE CASE ii_tab	
	CASE 1
		///////////////////////////////////////////////////////////////////////////////////////
		// 2. 자료조회
		///////////////////////////////////////////////////////////////////////////////////////
		wf_SetMsg('조회 처리 중입니다...')
		
		Long	ll_RowCnt, ll_RowCnt_print
		
		ll_RowCnt = tab_sheet.tabpage_sheet01.dw_update_tab.Retrieve(is_year, is_hakgi, ii_month)
		
	CASE 2
		ll_RowCnt_print = tab_sheet.tabpage_1.dw_print.Retrieve(is_year, is_hakgi, ii_month)
	CASE 3
		ll_RowCnt_print = tab_sheet.tabpage_2.dw_1.Retrieve(is_year, is_hakgi, ii_month)
END CHOOSE
///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_sheet.tabpage_1.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_sheet.tabpage_1.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//tab_sheet.tabpage_2.dw_1.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_sheet.tabpage_2.dw_1.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN
//	wf_SetMenuBtn('ISDRP')
	wf_SetMsg('해당자료가 존재하지 않습니다.')
	uo_month.SetFocus()
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end subroutine

public subroutine wf_insert ();//STRING	ls_member_no,ls_name,ls_newrow
//integer	li_newrow, li_month_amt,li_GetRow
//long ll_list_row
//
//
//ii_tab  = tab_sheet.selectedtab
//idw_name = tab_sheet.tabpage_sheet01.dw_update
//
//CHOOSE CASE ii_tab
//	CASE 1
//      idw_name.Selectrow(0, false)	
//		
//		li_newrow	=	idw_name.getrow() + 1
//		idw_name.insertrow(li_newrow)
//		
//		idw_name.setrow(li_newrow)
//		idw_name.scrolltorow(li_newrow)
//		
//		//idw_name.setitem(li_newrow, 'year_month', is_yearmonth)
//	
//END CHOOSE
//
end subroutine

on w_hpa204a.create
int iCurrent
call super::create
this.sle_biyul=create sle_biyul
this.st_3=create st_3
this.uo_yearhakgi=create uo_yearhakgi
this.uo_month=create uo_month
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_biyul
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.uo_yearhakgi
this.Control[iCurrent+4]=this.uo_month
this.Control[iCurrent+5]=this.cb_1
end on

on w_hpa204a.destroy
call super::destroy
destroy(this.sle_biyul)
destroy(this.st_3)
destroy(this.uo_yearhakgi)
destroy(this.uo_month)
destroy(this.cb_1)
end on

event ue_retrieve;call super::ue_retrieve;
wf_retrieve()


return 1

end event

event ue_insert;call super::ue_insert;
wf_insert()


end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////
//// 작성목적 : 의료비 관리
//// 적 성 인 : 이인갑
////	작성일자 : 2005.01.06
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)
//wf_SetMenu('I', TRUE)
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//is_year 	= uo_yearhakgi.uf_getyy()
//is_hakgi	= uo_yearhakgi.uf_gethakgi()
//ii_month	= integer(uo_month.uf_getmm())
//sle_biyul.text = '0.0045'
//
//IF ii_month < 8 then
//	is_hakgi = '1'
//	uo_yearhakgi.em_hakgi.text ='1'
//else 
//	is_hakgi ='2'
//	uo_yearhakgi.em_hakgi.text ='2'
//end if
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.2 개인번호 DDDW초기화
//////////////////////////////////////////////////////////////////////////////////////
//tab_sheet.tabpage_sheet01.dw_update.getchild('member_no', idw_child)
//idw_child.settransobject(sqlca)
//if idw_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
//	idw_child.reset()
//	idw_child.insertrow(0)
//end if
//
//tab_sheet.tabpage_sheet01.dw_update.getchild('name', idw_kname_child)
//idw_kname_child.settransobject(sqlca)
//if idw_kname_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
//	idw_kname_child.reset()
//	idw_kname_child.insertrow(0)
//end if
//
//tab_sheet.tabpage_sheet01.dw_update.getchild('gwa', ldwc_Temp)
//ldwc_Temp.settransobject(sqlca)
//if ldwc_Temp.retrieve('%') < 1 then
//	ldwc_Temp.reset()
//	ldwc_Temp.insertrow(0)
//end if
//tab_sheet.tabpage_2.dw_1.settransobject(sqlca)
//tab_sheet.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
//tab_sheet.tabpage_1.dw_print.Object.DataWindow.Zoom = 100
//tab_sheet.tabpage_2.dw_1.Object.DataWindow.Print.Preview = 'YES'
//tab_sheet.tabpage_2.dw_1.Object.DataWindow.Zoom = 100
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기화 이벤트 호출
/////////////////////////////////////////////////////////////////////////////////////////
//
////uo_yearmonth.em_yearmonth.SetFocus()
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
end event

event ue_save;call super::ue_save;		
//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////

//idw_name
dw_update = tab_sheet.tabpage_sheet01.dw_update_tab
///////////////////////////////////////////////////////////////////////////////////////
// 2. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
IF dw_update.AcceptText() = -1 THEN
	dw_update.SetFocus()
	RETURN -1
END IF
IF dw_update.ModifiedCount() + &
	dw_update.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'member_no/개인번호'
ls_NotNullCol[2] = 'year/년도'
ls_NotNullCol[2] = 'hakgi/학기'
ls_NotNullCol[2] = 'month/월'
IF f_chk_null(dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 4. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row			//변경된 행
DateTime	ldt_WorkDate	//등록일자
String	ls_Worker		//등록자
String	ls_IPAddr		//등록단말기
Boolean	lb_Start  = TRUE

String	ls_MEMBER_NO		//개인번호


ll_Row = dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()						//등록일자
	ls_Worker    = gs_empcode //gstru_uid_uname.uid			//등록자
	ls_IPAddr    = gs_ip   //gstru_uid_uname.address		//등록단말기
END IF
DO WHILE ll_Row > 0
	ldis_Status = dw_update.GetItemStatus(ll_Row,0,Primary!)
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 저장처리전 체크사항 기술
	/////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		dw_update.Object.worker   [ll_Row] = ls_Worker		//등록일자
		dw_update.Object.work_date[ll_Row] = ldt_WorkDate	//등록자
		dw_update.Object.ipaddr   [ll_Row] = ls_IPAddr		//등록단말기
	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	dw_update.Object.job_uid  [ll_Row] = ls_Worker		//등록자
	dw_update.Object.job_add  [ll_Row] = ls_IpAddr		//등록단말기
	dw_update.Object.job_date [ll_Row] = ldt_WorkDate	//등록일자
	
	ll_Row = dw_update.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 5. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF f_update(dw_update,'U') = TRUE THEN 
			  wf_setmsg("저장되었습니다")
			  wf_retrieve()
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 6. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenuBtn('IDSRP')
dw_update.SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;call super::ue_delete;//////////////////////////////////////////////////////////////////////////////////////////////
//////	이 벤 트 명: ue_delete
//////	기 능 설 명: 자료삭제 처리
//////	작성/수정자: 
//////	작성/수정일: 
//////	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////////
ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	//   idw_name 
	dw_update = tab_sheet.tabpage_sheet01.dw_update
      dwItemStatus l_status 
		l_status = dw_update.getitemstatus(1, 0, Primary!)
	
			IF f_messagebox( '2', 'DEL' ) = 1 THEN
	
				dw_update.deleterow(0)
				IF f_update2( tab_sheet.tabpage_sheet01.dw_update, dw_update,'D') = TRUE THEN 
					wf_setmsg("삭제되었습니다")
					wf_retrieve()
				END IF	
       
	       END IF
		
END CHOOSE		

//////////////////////////////////////////////////////////////////////////////////////////////
//////	이 벤 트 명: ue_delete
//////	기 능 설 명: 자료삭제 처리
//////	작성/수정자: 
//////	작성/수정일: 
//////	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////////
////// 1. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////////
//Long		ll_GetRow
//IF tab_sheet.tabpage_sheet01.dw_update.ib_RowSingle THEN &
//	ll_GetRow = tab_sheet.tabpage_sheet01.dw_update.GetRow()
//IF NOT tab_sheet.tabpage_sheet01.dw_update.ib_RowSingle THEN &
//	ll_GetRow = tab_sheet.tabpage_sheet01.dw_update.GetSelectedRow(0)
//IF ll_GetRow = 0 THEN RETURN
//
///////////////////////////////////////////////////////////////////////////////////////////
////// 2. 삭제메세지 처리.
//////		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////////
//String	ls_Msg
//Integer	li_Rtn
//Long		ll_DeleteCnt
//
//IF tab_sheet.tabpage_sheet01.dw_update.ib_RowSingle OR &
//	tab_sheet.tabpage_sheet01.dw_update.GetSelectedRow(ll_GetRow) = 0 THEN
//	/////////////////////////////////////////////////////////////////////////////////
//	// 2.1 삭제전 체크사항 기술
//	/////////////////////////////////////////////////////////////////////////////////
//	
//	/////////////////////////////////////////////////////////////////////////////////
//	// 2.2 삭제메세지 처리부분
//	/////////////////////////////////////////////////////////////////////////////////
//	String	ls_MemberNo		//직번
//	String	ls_Nm				//성명
//	Integer	li_Seq_no		//항번
//	
//	
//	ls_MemberNo   = tab_sheet.tabpage_sheet01.dw_update.Object.member_no[ll_GetRow]	//직번
//	ls_Nm   			= tab_sheet.tabpage_sheet01.dw_update.Object.name     [ll_GetRow]			//성명
//	li_Seq_no      = tab_sheet.tabpage_sheet01.dw_update.Object.seq_no    [ll_GetRow]	//항번
//	ls_Msg = '~r~n~r~n' + &
//				'직번 : ' + ls_MemberNo + '~r~n' + &
//				'성명 : ' + ls_Nm + '~r~n' + &
//				'항번 : ' + String(li_Seq_no)
//ELSE
//	SetNull(ls_Msg)
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 삭제처리.
/////////////////////////////////////////////////////////////////////////////////////////
//ll_DeleteCnt = tab_sheet.tabpage_sheet01.dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
//IF ll_DeleteCnt > 0 THEN
//	wf_SetMsg('자료가 삭제되었습니다.')
//	IF tab_sheet.tabpage_sheet01.dw_update.ib_RowSingle THEN
//		/////////////////////////////////////////////////////////////////////////////
//		// 3.1 Single 처리인 경우.
//		//			3.1.1 저장처리.
//		//			3.1.2 한로우를 다시 추가.
//		//			3.1.3 데이타원도우를 읽기모드로 수정.
//		/////////////////////////////////////////////////////////////////////////////
//		IF tab_sheet.tabpage_sheet01.dw_update.TRIGGER EVENT ue_db_save() THEN
//			tab_sheet.tabpage_sheet01.dw_update.TRIGGER EVENT ue_db_append()
//			tab_sheet.tabpage_sheet01.dw_update.Object.DataWindow.ReadOnly = 'YES'
//			wf_SetMenuBtn('RIDS')
//		END IF
//	ELSE
//		/////////////////////////////////////////////////////////////////////////////
//		//	3.2 Multi 처리인 경우.
//		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
//		/////////////////////////////////////////////////////////////////////////////
//		IF tab_sheet.tabpage_sheet01.dw_update.RowCount() > 0 THEN
//			wf_SetMenuBtn('RIDS')
//		ELSE
//			wf_SetMenuBtn('RIS')
//		END IF
//	END IF
//ELSE
//END IF
//////////////////////////////////////////////////////////////////////////////////////////////
//////	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;//
//
//ii_tab = tab_sheet.SelectedTab
//
//CHOOSE CASE ii_tab
//	CASE 2
//		if tab_sheet.tabpage_1.dw_print.rowcount() > 1		then
//				f_print(tab_sheet.tabpage_1.dw_print)
//		end if
//	CASE 3
//		if tab_sheet.tabpage_2.dw_1.rowcount() >= 1 then
//			f_print(tab_sheet.tabpage_2.dw_1)
//		end if	
//END CHOOSE
//
//
end event

event ue_postopen;call super::ue_postopen;////////////////////////////////////////////////////////////////////
// 작성목적 : 의료비 관리
// 적 성 인 : 이인갑
//	작성일자 : 2005.01.06
// 변 경 인 :
// 변경일자 :
// 변경사유 :
////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)
//wf_SetMenu('I', TRUE)
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
is_year 	= uo_yearhakgi.uf_getyy()
is_hakgi	= uo_yearhakgi.uf_gethakgi()
ii_month	= integer(uo_month.uf_getmm())
sle_biyul.text = '0.0045'

IF ii_month < 8 then
	is_hakgi = '1'
	uo_yearhakgi.em_hakgi.text ='1'
else 
	is_hakgi ='2'
	uo_yearhakgi.em_hakgi.text ='2'
end if

///////////////////////////////////////////////////////////////////////////////////////
// 1.2 개인번호 DDDW초기화
////////////////////////////////////////////////////////////////////////////////////
tab_sheet.tabpage_sheet01.dw_update_tab.getchild('member_no', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
end if

tab_sheet.tabpage_sheet01.dw_update_tab.getchild('name', idw_kname_child)
idw_kname_child.settransobject(sqlca)
if idw_kname_child.retrieve(ii_str_jikjong, ii_end_jikjong, '') < 1 then
	idw_kname_child.reset()
	idw_kname_child.insertrow(0)
end if

tab_sheet.tabpage_sheet01.dw_update_tab.getchild('gwa', ldwc_Temp)
ldwc_Temp.settransobject(sqlca)
if ldwc_Temp.retrieve('%') < 1 then
	ldwc_Temp.reset()
	ldwc_Temp.insertrow(0)
end if
tab_sheet.tabpage_2.dw_1.settransobject(sqlca)
tab_sheet.tabpage_1.dw_print.Object.DataWindow.Print.Preview = 'YES'
tab_sheet.tabpage_1.dw_print.Object.DataWindow.Zoom = 100
idw_print = tab_sheet.tabpage_1.dw_print

tab_sheet.tabpage_2.dw_1.Object.DataWindow.Print.Preview = 'YES'
tab_sheet.tabpage_2.dw_1.Object.DataWindow.Zoom = 100

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////

//uo_yearmonth.em_yearmonth.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////




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

type ln_templeft from w_tabsheet`ln_templeft within w_hpa204a
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hpa204a
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hpa204a
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hpa204a
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hpa204a
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hpa204a
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hpa204a
end type

type uc_insert from w_tabsheet`uc_insert within w_hpa204a
end type

type uc_delete from w_tabsheet`uc_delete within w_hpa204a
end type

type uc_save from w_tabsheet`uc_save within w_hpa204a
end type

type uc_excel from w_tabsheet`uc_excel within w_hpa204a
end type

type uc_print from w_tabsheet`uc_print within w_hpa204a
end type

type st_line1 from w_tabsheet`st_line1 within w_hpa204a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line2 from w_tabsheet`st_line2 within w_hpa204a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type st_line3 from w_tabsheet`st_line3 within w_hpa204a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hpa204a
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hpa204a
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hpa204a
integer y = 320
integer width = 4384
integer height = 1956
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event tab_sheet::selectionchanged;call super::selectionchanged;
CHOOSE CASE newindex
	CASE 1, 2
		idw_print  = tab_sheet.tabpage_1.dw_print

	CASE 3
		idw_print = tab_sheet.tabpage_2.dw_1
END CHOOSE


end event

on tab_sheet.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
string text = "고용보험관리"
dw_list dw_list
dw_update dw_update
end type

on tabpage_sheet01.create
this.dw_list=create dw_list
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 2478
integer y = 32
integer width = 238
integer height = 168
integer taborder = 50
boolean titlebar = true
string title = "조회 내용"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_list001::rowfocuschanged;call super::rowfocuschanged;
//wf_chrow()
end event

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
integer x = 0
integer y = 8
integer width = 4347
integer height = 1832
boolean titlebar = true
string title = "고용보험 내역"
string dataobject = "d_hpa204a_1"
end type

event dw_update_tab::itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
//long		ll_row
//Long   ll_pay_amt, ll_gongie_amt
//
//if dwo.name = 'member_no' then
//	ll_row	=	idw_child.find("member_no = '" + data + "'	", 1, idw_child.rowcount())
//	if ll_row > 0 then
//		setitem(row, 'name', idw_child.getitemstring(idw_child.getrow(), 'name'))
//		setitem(row, 'fname', idw_child.getitemstring(idw_child.getrow(), 'fname'))
//	else
//		setitem(row, 'name', '')
//		setitem(row, 'fname', '')
//	end if
//elseif dwo.name = 'name' then
//	ll_row	=	idw_kname_child.find("name = '" + data + "'	", 1, idw_kname_child.rowcount())
//	if ll_row > 0 then
//		setitem(row, 'member_no',	idw_child.getitemstring(idw_kname_child.getrow(), 'member_no'))
//		setitem(row, 'gwa',	idw_child.getitemstring(idw_kname_child.getrow(), 'gwa'))
//	else
//		setitem(row, 'member_no', '')
//		setitem(row, 'gwa', '')
//	end if
//elseif dwo.name = 'pay_amt' then
//setitem(row, 'gongie_amt',  truncate(dec(data) * 0.0045/10,0) * 10)
//end if
//
//
//
//setitem(row, 'job_uid',		gstru_uid_uname.uid)
//setitem(row, 'job_add',		gstru_uid_uname.address)
//SetItem(row, 'job_date', 	f_sysdate())	
//
end event

event dw_update_tab::losefocus;call super::losefocus;accepttext()
end event

type uo_tab from w_tabsheet`uo_tab within w_hpa204a
integer x = 1321
integer y = 312
end type

type dw_con from w_tabsheet`dw_con within w_hpa204a
boolean visible = false
integer width = 0
integer height = 0
end type

type st_con from w_tabsheet`st_con within w_hpa204a
end type

type dw_list from datawindow within tabpage_sheet01
boolean visible = false
integer x = 224
integer y = 596
integer width = 2624
integer height = 368
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hpa204a_3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
boolean visible = false
integer y = 8
integer width = 0
integer height = 0
integer taborder = 11
boolean titlebar = true
string title = "고용보험 내역"
string dataobject = "d_hpa204a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event itemerror;call super::itemerror;//return 1
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE', true) //정장버튼 활성화
//long		ll_row
//Long   ll_pay_amt, ll_gongie_amt
//
//if dwo.name = 'member_no' then
//	ll_row	=	idw_child.find("member_no = '" + data + "'	", 1, idw_child.rowcount())
//	if ll_row > 0 then
//		setitem(row, 'name', idw_child.getitemstring(idw_child.getrow(), 'name'))
//		setitem(row, 'fname', idw_child.getitemstring(idw_child.getrow(), 'fname'))
//	else
//		setitem(row, 'name', '')
//		setitem(row, 'fname', '')
//	end if
//elseif dwo.name = 'name' then
//	ll_row	=	idw_kname_child.find("name = '" + data + "'	", 1, idw_kname_child.rowcount())
//	if ll_row > 0 then
//		setitem(row, 'member_no',	idw_child.getitemstring(idw_kname_child.getrow(), 'member_no'))
//		setitem(row, 'gwa',	idw_child.getitemstring(idw_kname_child.getrow(), 'gwa'))
//	else
//		setitem(row, 'member_no', '')
//		setitem(row, 'gwa', '')
//	end if
//elseif dwo.name = 'pay_amt' then
//setitem(row, 'gongie_amt',  truncate(dec(data) * 0.0045/10,0) * 10)
//end if
//
//
//
//setitem(row, 'job_uid',		gstru_uid_uname.uid)
//setitem(row, 'job_add',		gstru_uid_uname.address)
//SetItem(row, 'job_date', 	f_sysdate())	
//
end event

event constructor;call super::constructor;this.uf_setClick(False)

end event

event losefocus;call super::losefocus;accepttext()
end event

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1836
long backcolor = 16777215
string text = "고용보험 출력"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_1.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_1.destroy
destroy(this.dw_print)
end on

type dw_print from cuo_dwwindow within tabpage_1
integer y = 12
integer width = 4343
integer height = 1824
integer taborder = 11
boolean titlebar = true
string dataobject = "d_hpa204a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1836
long backcolor = 16777215
string text = "미가입자 명단"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_2.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_2.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_2
integer x = 9
integer y = 20
integer width = 4329
integer height = 1816
integer taborder = 60
string title = "none"
string dataobject = "d_hpa204a_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type sle_biyul from singlelineedit within w_hpa204a
integer x = 1929
integer y = 176
integer width = 402
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
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_hpa204a
integer x = 1664
integer y = 188
integer width = 265
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "공제비율"
boolean focusrectangle = false
end type

type uo_yearhakgi from cuo_yyhakgi within w_hpa204a
event destroy ( )
integer x = 87
integer y = 172
integer width = 1047
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

on uo_yearhakgi.destroy
call cuo_yyhakgi::destroy
end on

event ue_itemchange;call super::ue_itemchange;is_year 	= uf_getyy()
is_hakgi	= uf_gethakgi()

end event

type uo_month from cuo_month within w_hpa204a
event destroy ( )
integer x = 1134
integer y = 172
integer taborder = 60
boolean bringtotop = true
boolean border = false
end type

on uo_month.destroy
call cuo_month::destroy
end on

event ue_itemchange;call super::ue_itemchange;ii_month	= integer(uf_getmm())

end event

type cb_1 from uo_imgbtn within w_hpa204a
event destroy ( )
integer x = 50
integer y = 36
integer taborder = 91
boolean bringtotop = true
string btnname = "고용보험생성"
end type

on cb_1.destroy
call uo_imgbtn::destroy
end on

event clicked;call super::clicked;
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회여부 체크
///////////////////////////////////////////////////////////////////////////////////////
dw_update  = tab_sheet.tabpage_sheet01.dw_update
dw_list 	  = tab_sheet.tabpage_sheet01.dw_list
///////////////////////////////////////////////////////////////////////////////////////
// 2. 생성용데이타원도우 변경처리
///////////////////////////////////////////////////////////////////////////////////////
dw_list.SetTransObject(SQLCA)
dw_update.Reset()
///////////////////////////////////////////////////////////////////////////////////////
// 3. 정기승진대상자 생성
///////////////////////////////////////////////////////////////////////////////////////
Long			ll_InsRow				//추가된행
Long			ll_Row					//현재행
Long			ll_RowCnt				//총건수

String		ls_MemberNo
String		ls_name		
String		ls_gwa		
DEC			ii_pay_amt
DEC		   ii_biyul, ii_goyong_amt

////////////////////////////////////////////////////////////////////////////////////
// 3.1 대상자 생성
////////////////////////////////////////////////////////////////////////////////////
is_year 	= uo_yearhakgi.uf_getyy()
is_hakgi	= uo_yearhakgi.uf_gethakgi()
ii_month	= integer(uo_month.uf_getmm())

ii_biyul = dec(sle_biyul.text)

dw_list.SetReDraw(FALSE)
dw_list.Reset()
ll_RowCnt = dw_list.Retrieve(is_year, is_hakgi, ii_month)
dw_list.SetReDraw(TRUE)

if ll_RowCnt > 0 then
	if f_messagebox('2', '이미 생성된 자료가 있습니다.~n~n다시 생성하시려면 [예]를 누르세요.!') = 2 then 
		return	
	else
		// 이미 생성된 자료 삭제
		delete	from	padb.hpa009m
		where		year	=	:is_year
		and		hakgi	=	:is_hakgi
		and		month	=	:ii_month;
		if sqlca.sqlcode <> 0 then	return	//sqlca.sqlcode
		
	end if
end if

////////////////////////////////////////////////////////////////////////////////////
// 3.2 대상자
////////////////////////////////////////////////////////////////////////////////////
dw_update.SetReDraw(FALSE)
dw_update.Reset()
FOR ll_Row = 1 TO ll_RowCnt
	ls_MemberNo     = dw_list.Object.member_no [ll_Row]	
	is_year      	 = dw_list.Object.year      [ll_Row]	
	is_hakgi     	 = dw_list.Object.hakgi     [ll_Row]
	ii_month    	 = dw_list.Object.month     [ll_Row]
	ls_gwa	       = dw_list.Object.gwa       [ll_Row]
	ls_name      	 = dw_list.Object.name      [ll_Row]
	ii_pay_amt      = dw_list.Object.pay_amt   [ll_Row]

	/////////////////////////////////////////////////////////////////////////////////
	// 3.2.2 추가처리
	/////////////////////////////////////////////////////////////////////////////////
	ll_InsRow = dw_update.InsertRow(0)
	IF ll_InsRow = 0 THEN EXIT

	dw_update.Object.member_no[ll_InsRow] 	= ls_MemberNo
	dw_update.Object.year	  [ll_InsRow] 	= is_year
	dw_update.Object.hakgi    [ll_InsRow] 	= is_hakgi
	dw_update.Object.gwa      [ll_InsRow] 	= ls_gwa
	dw_update.Object.month    [ll_InsRow] 	= ii_month
	dw_update.Object.name     [ll_InsRow] 	= ls_name
	dw_update.Object.pay_amt  [ll_InsRow] 	= ii_pay_amt
	ii_goyong_amt = ii_pay_amt * ii_biyul
	dw_update.Object.gongie_amt  [ll_InsRow] 	= 	Round(ii_goyong_amt/10, 0) * 10   //원단위 절상
	
//	dw_update.Object.gongie_amt  [ll_InsRow] 	= ROUND(ii_pay_amt * ii_biyul)//원단위 절상

//	dw_update.Object.gongie_amt  [ll_InsRow] 	= TRUNCATE(ii_pay_amt * ii_biyul / 10, 0) *10//원단위 절사
NEXT
dw_update.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메세지처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_InsRow > 0 THEN
//	wf_SetMenuBtn('SDRP')
	wf_SetMsg('고용보험대상자가 생성되었습니다. 확인 후 자료를 저장하시기 바랍니다.')
ELSE
//	wf_SetMenuBtn('R')
	wf_SetMsg('고용보험대상자가 없습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

