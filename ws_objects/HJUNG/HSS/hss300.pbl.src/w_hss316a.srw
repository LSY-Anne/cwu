$PBExportHeader$w_hss316a.srw
$PBExportComments$피난설비관리
forward
global type w_hss316a from w_msheet
end type
type gb_2 from groupbox within w_hss316a
end type
type tab_1 from tab within w_hss316a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_main from uo_dwgrid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_main dw_main
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hss316a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_2 from statictext within w_hss316a
end type
type em_to_date from editmask within w_hss316a
end type
type em_fr_date from editmask within w_hss316a
end type
type st_1 from statictext within w_hss316a
end type
type gb_1 from groupbox within w_hss316a
end type
type em_set_date from editmask within w_hss316a
end type
type st_3 from statictext within w_hss316a
end type
type uo_1 from u_tab within w_hss316a
end type
type cb_1 from uo_imgbtn within w_hss316a
end type
end forward

global type w_hss316a from w_msheet
integer height = 2616
gb_2 gb_2
tab_1 tab_1
st_2 st_2
em_to_date em_to_date
em_fr_date em_fr_date
st_1 st_1
gb_1 gb_1
em_set_date em_set_date
st_3 st_3
uo_1 uo_1
cb_1 cb_1
end type
global w_hss316a w_hss316a

type variables
LONG il_getrow
end variables

on w_hss316a.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.tab_1=create tab_1
this.st_2=create st_2
this.em_to_date=create em_to_date
this.em_fr_date=create em_fr_date
this.st_1=create st_1
this.gb_1=create gb_1
this.em_set_date=create em_set_date
this.st_3=create st_3
this.uo_1=create uo_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_to_date
this.Control[iCurrent+5]=this.em_fr_date
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.em_set_date
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.cb_1
end on

on w_hss316a.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.tab_1)
destroy(this.st_2)
destroy(this.em_to_date)
destroy(this.em_fr_date)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.em_set_date)
destroy(this.st_3)
destroy(this.uo_1)
destroy(this.cb_1)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건의 초기화 처리.
////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_main.Reset()
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print


String	ls_Today
ls_Today = String(Today(),'YYYYMMDD')
em_fr_date.Text = MID(ls_Today,1,6)+'01'
em_to_date.Text = ls_Today

em_set_date.text = ls_today
//////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_main.Reset()

//wf_setMenu('I',TRUE)//입력버튼 활성화
//wf_setMenu('S',TRUE)//저장버튼 활성화
//wf_setMenu('D',TRUE)//삭제버튼 활성화
//wf_setMenu('R',TRUE)//저장버튼 활성화


triggerevent('ue_retrieve')

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////


end event

event ue_insert;call super::ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 입력조건체크
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long	ll_GetRow, ll_rowcount, ll_row
long  ll_fr_date, li_idx

//ll_GetRow = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_new()
	tab_1.tabpage_1.dw_main.Reset()
	ll_GetRow = tab_1.tabpage_1.dw_main.InsertRow(0)
	tab_1.tabpage_1.dw_main.ScrollToRow(ll_GetRow)
	tab_1.tabpage_1.dw_main.SetRow(ll_GetRow)
	tab_1.tabpage_1.dw_main.SetFocus()

IF ll_GetRow = 0 THEN 
	RETURN
ELSE
	ll_rowcount = tab_1.tabpage_1.dw_main.rowcount()
	
   FOR ll_row = ll_getrow TO ll_rowcount
	    tab_1.tabpage_1.dw_main.Object.seq_no[ll_row] = ll_row	 
	NEXT
      
END IF 

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값 셋팅
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_main.object.check_date[tab_1.tabpage_1.dw_main.getrow()] = f_today()
///////////////////////////////////////////////////////////////////////////////////////
// 4. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_main.SetItemStatus(ll_GetRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지처리, 고정버튼 활성화/비활성화, 데이타원도우로 포커스이동 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 추가되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
////wf_SetMenu('R',TRUE)
tab_1.tabpage_1.dw_main.Setfocus()
//tab_1.tabpage_1.dw_main.setcolumn('sorc_rvn')

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
IF tab_1.tabpage_1.dw_main.AcceptText() = -1 THEN
	tab_1.tabpage_1.dw_main.SetFocus()
	RETURN -1
END IF
IF tab_1.tabpage_1.dw_main.ModifiedCount() + &
	tab_1.tabpage_1.dw_main.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN -1
END IF

/////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_NotNullCol[]

ls_NotNullCol[1] = 'check_date/시작일자'
ls_NotNullCol[2] = 'seq_no/순번'
//ls_NotNullCol[3] = 'to_date/종료일자'
//ls_NotNullCol[4] = 'use_yn/사용유무'
IF f_chk_null(tab_1.tabpage_1.dw_main,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//2_1.날자체크 
///////////////////////////////////////////////////////////////////////////////////////////////////////////
integer li_check
string ls_check_date
li_check = tab_1.tabpage_1.dw_main.getnextmodified(0, Primary!)

IF li_check <> 0 THEN ls_check_date = trim(tab_1.tabpage_1.dw_main.object.check_date[li_check])
If isnull(ls_check_date) or ls_check_date = '' then
 else
   if isdate(String(ls_check_date,'@@@@/@@/@@')) then
    else
	   MessageBox('확인','점검일자가 잘못 되었습니다.~r' +ls_check_date+ '의 일자를 확인 하여 주십시요.')
	   return -1
   end IF
end IF


///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row				//변경된 행
DateTime	ldt_WorkDate		//등록일자
String	ls_Worker			//등록자
String	ls_IPAddr			//등록단말기
DateTime	ldt_JOB_Date		//등록일자
String	ls_JOB_UID		//등록자
String	ls_JOB_ADD			//등록단말기

ll_Row = tab_1.tabpage_1.dw_main.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate  = f_sysdate()						//등록일자
	ls_Worker     = gstru_uid_uname.uid				//등록자
	ls_IPAddr     = gstru_uid_uname.address		//등록단말기
	ldt_JOB_Date  =f_sysdatE()                   //등록일자
   ls_JOB_UID	  =gstru_uid_uname.uid	         //등록자
   ls_JOB_ADD	  =gstru_uid_uname.address		   //등록단말기
END IF
DO WHILE ll_Row > 0
   ////////////////////////////////////////////////////////////////////////////////////
	// 3.1 수정항목 처리
	////////////////////////////////////////////////////////////////////////////////////
	tab_1.tabpage_1.dw_main.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
	tab_1.tabpage_1.dw_main.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
	tab_1.tabpage_1.dw_main.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
	tab_1.tabpage_1.dw_main.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
	tab_1.tabpage_1.dw_main.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
	tab_1.tabpage_1.dw_main.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자
	
	ll_Row = tab_1.tabpage_1.dw_main.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 5. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
//IF NOT tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_save() THEN RETURN -1
IF  tab_1.tabpage_1.dw_main.UPDATE() = 1 THEN
	COMMIT USING SQLCA;
//	RETURN 1
ELSE
	ROLLBACK USING SQLCA;
	RETURN -1
END IF


///////////////////////////////////////////////////////////////////////////////////////
// 5_1. 자료저장후 리스트 출력
///////////////////////////////////////////////////////////////////////////////////////
triggerevent('ue_retrieve')

///////////////////////////////////////////////////////////////////////////////////////
// 6. 메세지 처리, 고정버튼 활성화/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
tab_1.tabpage_1.dw_main.SetFocus()
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;call super::ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow

//IF tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
			ll_GetRow = tab_1.tabpage_1.dw_main.GetRow()
//	IF NOT tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
//			ll_GetRow = tab_1.tabpage_1.dw_main.GetSelectedRow(0)
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Long		ll_DeleteCnt, ll_rowcount, ll_row, ll_deleterow

//ll_DeleteCnt = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_delete(ls_Msg)
IF tab_1.tabpage_1.dw_main.GetItemStatus(ll_GetRow,0,Primary!) <> New! THEN
		IF MessageBox('확인','자료를 삭제하시겠습니까?~r~n'+ls_Msg,&
									Question!,YesNo!,2) = 2 THEN
			RETURN 
		END IF
	END IF
	
//	THIS.SelectRow(0,FALSE)
//	ll_NextSelectRow = ll_GetRow + 1
//	THIS.ScrollToRow(ll_NextSelectRow)
//	THIS.SetRedraw(TRUE)

	tab_1.tabpage_1.dw_main.DeleteRow(ll_GetRow)
	ll_DeleteCnt = 1


	ll_deleterow =tab_1.tabpage_1.dw_main.getrow()
	ll_rowcount = tab_1.tabpage_1.dw_main.rowcount()

   FOR ll_row = ll_deleterow  TO ll_rowcount 
		 IF ll_Row = 0 THEN
			EXIT
		 END IF
		tab_1.tabpage_1.dw_main.Object.seq_no[ll_row] = ll_row
	NEXT
      
IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	IF tab_1.tabpage_1.dw_main.rowcount() > 0 THEN
//		wf_SetMenu('R',FALSE)
//		wf_SetMenu('I',TRUE)
//		wf_SetMenu('D',TRUE)
//		wf_SetMenu('S',TRUE)
	ELSE
//		wf_SetMenu('R',FALSE)
//		wf_SetMenu('I',TRUE)
//		wf_SetMenu('D',FALSE)
//		wf_SetMenu('S',TRUE)
	END IF
END IF

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
String	ls_fr_Date, lsc_fr_Date
em_fr_date.GetData(ls_fr_Date)
ls_fr_Date = TRIM(ls_fr_Date)
IF isNull(ls_fr_Date) OR LEN(ls_fr_Date) = 0 THEN
	messagebox("알림",'점검일자를 입력하시기 바랍니다.')
	em_fr_date.SetFocus()
	RETURN -1
END IF
lsc_fr_Date = String(ls_fr_Date,'@@@@/@@/@@')


String	ls_to_Date,lsc_to_Date
em_to_date.GetData(ls_to_Date)
ls_to_Date = TRIM(ls_to_Date)
IF isNull(ls_to_Date) OR LEN(ls_to_Date) = 0 THEN
	messagebox("알림",'점검일자를 입력하시기 바랍니다.')
	em_to_date.SetFocus()
	RETURN -1
END IF
lsc_to_Date = String(ls_to_Date,'@@@@/@@/@@')
STring  ls_date
ls_date = lsc_fr_Date + " - " + lsc_to_Date

IF ls_fr_Date > ls_to_Date THEN
	messagebox("알림",'점검일자 입력오류입니다.')
	em_fr_date.SetFocus()
	RETURN -1
END IF

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
tab_1.tabpage_1.dw_main.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_main.Retrieve(ls_fr_date, ls_to_date)
tab_1.tabpage_1.dw_main.SetReDraw(TRUE)

tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_2.dw_print.Retrieve(ls_fr_date, ls_to_date)
tab_1.tabpage_2.dw_print.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	
//	IF tab_1.tabpage_1.dw_main.modifiedcount() + tab_1.tabpage_1.dw_main.deletedcount() <> 0 THEN 
//		event trigger ue_save(0,0)
//	END IF 
//	tab_1.tabpage_1.dw_main.SetFocus()
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event closequery;call super::closequery;//integer li_rc
//
//tab_1.tabpage_1.dw_main.AcceptText()
//
//IF tab_1.tabpage_1.dw_main.DeletedCount() +& 
//   tab_1.tabpage_1.dw_main.ModifiedCount() > 0 THEN
//   li_rc = MessageBox("확인", "변경된 내용이 있습니다..! 종료하시겠습니까?", Question!, YesNo!, 2)
//	IF li_rc = 1 THEN // Yes 선택
//		RETURN 0
//	ELSEIF li_rc = 2 THEN // No 선택
//		RETURN 1
//	END IF
//ELSE
//	RETURN 0
//END IF
end event

event ue_print;call super::ue_print;//f_print(tab_1.tabpage_2.dw_print)
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "피난설비 리스트")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hss316a
end type

type ln_tempright from w_msheet`ln_tempright within w_hss316a
end type

type ln_temptop from w_msheet`ln_temptop within w_hss316a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hss316a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hss316a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hss316a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hss316a
end type

type uc_insert from w_msheet`uc_insert within w_hss316a
end type

type uc_delete from w_msheet`uc_delete within w_hss316a
end type

type uc_save from w_msheet`uc_save within w_hss316a
end type

type uc_excel from w_msheet`uc_excel within w_hss316a
end type

type uc_print from w_msheet`uc_print within w_hss316a
end type

type st_line1 from w_msheet`st_line1 within w_hss316a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hss316a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hss316a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hss316a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hss316a
end type

type gb_2 from groupbox within w_hss316a
integer x = 3397
integer y = 148
integer width = 1015
integer height = 184
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전월자료  입력"
end type

type tab_1 from tab within w_hss316a
event create ( )
event destroy ( )
integer x = 50
integer y = 388
integer width = 4384
integer height = 1908
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1788
string text = "피난설비관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_main dw_main
end type

on tabpage_1.create
this.dw_main=create dw_main
this.Control[]={this.dw_main}
end on

on tabpage_1.destroy
destroy(this.dw_main)
end on

type dw_main from uo_dwgrid within tabpage_1
integer width = 4347
integer height = 1760
integer taborder = 10
string dataobject = "d_hss316a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
f_pro_toggle('K',Handle(PARENT))
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1788
string text = "피난설비 출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from datawindow within tabpage_2
integer width = 4347
integer height = 1764
integer taborder = 10
string title = "none"
string dataobject = "d_hss316a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type st_2 from statictext within w_hss316a
integer x = 837
integer y = 188
integer width = 73
integer height = 96
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "~~"
boolean focusrectangle = false
end type

type em_to_date from editmask within w_hss316a
integer x = 905
integer y = 188
integer width = 361
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type em_fr_date from editmask within w_hss316a
integer x = 462
integer y = 188
integer width = 361
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_1 from statictext within w_hss316a
integer x = 279
integer y = 216
integer width = 169
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "기간"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_hss316a
integer x = 50
integer y = 112
integer width = 4384
integer height = 236
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type em_set_date from editmask within w_hss316a
integer x = 3675
integer y = 216
integer width = 361
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_3 from statictext within w_hss316a
integer x = 3415
integer y = 236
integer width = 256
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "점검일자"
boolean focusrectangle = false
end type

type uo_1 from u_tab within w_hss316a
event destroy ( )
integer x = 1563
integer y = 388
integer height = 148
integer taborder = 160
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type cb_1 from uo_imgbtn within w_hss316a
integer x = 4046
integer y = 216
integer taborder = 50
boolean bringtotop = true
string btnname = "입력"
end type

event clicked;call super::clicked;String  ls_check_date, ls_check_remark, ls_check_result, ls_remark
String  ls_set_date, ls_max_date , ls_set_date2, ls_date
Long    ll_count, ll_seq_no
Integer li_CurrentRow

DataWinDow  dw_name
dw_name = tab_1.tabpage_1.dw_main

dw_name.reset()
//////////전월 찾기
ls_set_date = left(em_set_date.text,4) + mid(em_set_date.text,6,2) + mid(em_set_date.text,9,10)
select  max(check_date)
into    :ls_max_date
from    stdb.hst314h ;

IF left(ls_max_date,4) = left(ls_set_date,4) THEN
   ls_set_date2 = string(long(left(ls_set_date,6)) - 1)+'%'
ELSE 
	ls_set_date2 = left(ls_max_date,6)+'%'
END IF

ls_date = ls_set_date2 + '%'
select count(check_date)
into   :ll_count
from   stdb.hst314h
where  check_date like :ls_date;

long ll_seq_not
ll_seq_not = 1
/////////////전월 데이터 가져오기
IF ll_count > 0 THEN 

   DECLARE sel_cur CURSOR FOR
     select check_date,
	         seq_no,
				check_remark,
				check_result,
				remark
     from   stdb.hst314h
     where  check_date like :ls_set_date2;

	 if SQLCA.sqlcode < 0 then 
	       return
     elseif SQLCA.sqlcode = 100 then 
	       return
    end if

    OPEN sel_cur;
    if SQLCA.sqlcode < 0 then 
	       return
    end if

    DO WHILE TRUE
	    FETCH sel_cur INTO :ls_check_date,:ll_seq_no,:ls_check_remark,:ls_check_result,:ls_remark;
			if sqlca.sqlcode <> 0  then  
				 close sel_cur;				
   			return
			End If
		   li_CurrentRow = dw_name.insertrow(0)
			dw_name.object.check_date[li_CurrentRow]   = ls_set_date
			dw_name.object.seq_no[li_CurrentRow]       = ll_seq_not
			dw_name.object.check_remark[li_CurrentRow] = ls_check_remark
			dw_name.object.check_result[li_CurrentRow] = ls_check_result
			dw_name.object.remark[li_CurrentRow]       = ls_remark
			
			ll_seq_not = ll_seq_not + 1
    loop

    close sel_cur;

	END IF	
		
//		  wf_setmenu('S',true)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

