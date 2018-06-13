$PBExportHeader$w_hss309a.srw
$PBExportComments$정화조설비 관리
forward
global type w_hss309a from w_msheet
end type
type tab_1 from tab within w_hss309a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_main from uo_dwgrid within tabpage_1
end type
type dw_list from uo_dwgrid within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_main dw_main
dw_list dw_list
gb_1 gb_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hss309a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_hss309a
end type
end forward

global type w_hss309a from w_msheet
integer height = 2616
tab_1 tab_1
uo_1 uo_1
end type
global w_hss309a w_hss309a

type variables

int ii_tab
long il_getrow = 1
datawindowchild idw_child
string	is_buil_no, is_build_no 
DataWindowchild	idwc_Gwa
end variables

on w_hss309a.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_hss309a.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
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
tab_1.tabpage_1.dw_list.Reset()
tab_1.tabpage_1.dw_main.Reset()
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print
IF tab_1.tabpage_1.dw_list.retrieve() = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			
ELSE	
   tab_1.tabpage_1.dw_list.setfocus()
   tab_1.tabpage_1.dw_list.trigger event rowfocuschanged(il_getrow)
END IF	 


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
//tab_1.tabpage_1.dw_main.Reset()

//wf_setMenu('I',TRUE)//입력버튼 활성화
//wf_setMenu('D',TRUE)//삭제버튼 활성화
//wf_setMenu('R',TRUE)//저장버튼 활성화
//wf_setMenu('S',TRUE)//저장버튼 활성화

//triggerevent('ue_retrieve')

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
Long	ll_GetRow
long  ll_fr_date, li_idx
//ll_GetRow = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_new()
 tab_1.tabpage_1.dw_main.Reset()
	ll_GetRow =  tab_1.tabpage_1.dw_main.InsertRow(0)
	 tab_1.tabpage_1.dw_main.ScrollToRow(ll_GetRow)
	 tab_1.tabpage_1.dw_main.SetRow(ll_GetRow)
	 tab_1.tabpage_1.dw_main.SetFocus()

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값 셋팅
///////////////////////////////////////////////////////////////////////////////////////
String ls_buil_no, ls_buil_name

ls_buil_no	=	tab_1.tabpage_1.dw_list.object.buil_no[tab_1.tabpage_1.dw_list.getrow()]		
ls_buil_name = tab_1.tabpage_1.dw_list.object.buil_name[tab_1.tabpage_1.dw_list.getrow()]	

tab_1.tabpage_1.dw_main.object.buil_no[tab_1.tabpage_1.dw_main.getrow()] = ls_buil_no
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

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_NotNullCol[]

ls_NotNullCol[1] = 'buil_no/건물번호'
ls_NotNullCol[2] = 'pum_name/품명'
//ls_NotNullCol[3] = 'to_date/종료일자'
//ls_NotNullCol[4] = 'use_yn/사용유무'
IF f_chk_null(tab_1.tabpage_1.dw_main,ls_NotNullCol) = -1 THEN RETURN -1

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

IF tab_1.tabpage_1.dw_main.UPDATE() = 1 THEN
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

//tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
//tab_1.tabpage_2.dw_print.Retrieve(ls_fr_date, ls_to_date)
//tab_1.tabpage_2.dw_print.SetReDraw(TRUE)

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
String	ls_Msg
Long		ll_DeleteCnt
///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
//ll_DeleteCnt = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_delete(ls_Msg)
IF  tab_1.tabpage_1.dw_main.GetItemStatus(ll_GetRow,0,Primary!) <> New! THEN
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
	ll_DeleteCnt =  1

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
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt

//tab_1.tabpage_1.dw_main.SetReDraw(FALSE)
//ll_RowCnt = tab_1.tabpage_1.dw_main.Retrieve(ls_buil_code)
//tab_1.tabpage_1.dw_main.SetReDraw(TRUE)
//
tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_2.dw_print.Retrieve()
tab_1.tabpage_2.dw_print.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
/////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
//IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',FALSE)
//	wf_SetMsg('해당자료가 존재하지 않습니다.')
//ELSE
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
//	wf_SetMsg('자료가 조회되었습니다.')
//	
////	IF tab_1.tabpage_1.dw_main.modifiedcount() + tab_1.tabpage_1.dw_main.deletedcount() <> 0 THEN 
////		event trigger ue_save(0,0)
////	END IF 
////	tab_1.tabpage_1.dw_main.SetFocus()
//END IF
return 1
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
//   li_rc = MessageBox("Closing", "변경된 내용이 있습니다..! 종료하시겠습니까?", Question!, YesNo!, 2)
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
avc_data.SetProperty('title', "정화조설비 리스트")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hss309a
end type

type ln_tempright from w_msheet`ln_tempright within w_hss309a
end type

type ln_temptop from w_msheet`ln_temptop within w_hss309a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hss309a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hss309a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hss309a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hss309a
end type

type uc_insert from w_msheet`uc_insert within w_hss309a
end type

type uc_delete from w_msheet`uc_delete within w_hss309a
end type

type uc_save from w_msheet`uc_save within w_hss309a
end type

type uc_excel from w_msheet`uc_excel within w_hss309a
end type

type uc_print from w_msheet`uc_print within w_hss309a
end type

type st_line1 from w_msheet`st_line1 within w_hss309a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hss309a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hss309a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hss309a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hss309a
end type

type tab_1 from tab within w_hss309a
integer x = 50
integer y = 168
integer width = 4384
integer height = 2096
integer taborder = 10
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
integer x = 18
integer y = 104
integer width = 4347
integer height = 1976
string text = "정화조설비 관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_main dw_main
dw_list dw_list
gb_1 gb_1
end type

on tabpage_1.create
this.dw_main=create dw_main
this.dw_list=create dw_list
this.gb_1=create gb_1
this.Control[]={this.dw_main,&
this.dw_list,&
this.gb_1}
end on

on tabpage_1.destroy
destroy(this.dw_main)
destroy(this.dw_list)
destroy(this.gb_1)
end on

type dw_main from uo_dwgrid within tabpage_1
integer x = 1600
integer y = 64
integer width = 2702
integer height = 1880
integer taborder = 41
string dataobject = "d_hss309a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
f_pro_toggle('k',handle(parent))
end event

type dw_list from uo_dwgrid within tabpage_1
integer y = 28
integer width = 1550
integer height = 1944
integer taborder = 31
boolean titlebar = true
string title = "건물 리스트"
string dataobject = "d_hss304a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event rowfocuschanging;call super::rowfocuschanging;/////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
//this.selectrow( 0, false )
//this.selectrow( ll_getrow, true )
ll_GetRow = newrow
IF ll_GetRow = 0 THEN RETURN
ll_RowCnt = THIS.RowCount()
IF ll_RowCnt = 0 THEN
		RETURN
	END IF

///////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
String ls_buil_no//건물번호
IF ll_getrow <> 0 THEN
   ls_buil_no = tab_1.tabpage_1.dw_list.object.buil_no[ll_getrow]

    SetPointer(HourGlass!)
  ///////////////////////////////////////////////////////////////////////////////////////
  // 2. 자료조회
  ///////////////////////////////////////////////////////////////////////////////////////
  wf_SetMsg('조회 처리 중입니다...')

  tab_1.tabpage_1.dw_main.SetReDraw(FALSE)
  ll_RowCnt = tab_1.tabpage_1.dw_main.Retrieve(ls_buil_no)
  tab_1.tabpage_1.dw_main.SetReDraw(TRUE)
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////



end event

type gb_1 from groupbox within tabpage_1
integer x = 1573
integer width = 2766
integer height = 1972
integer taborder = 21
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "정화조 설비내역"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1976
string text = "정화조설비 출력"
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
integer height = 1976
integer taborder = 10
string title = "none"
string dataobject = "d_hss309a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type uo_1 from u_tab within w_hss309a
event destroy ( )
integer x = 1440
integer y = 128
integer height = 148
integer taborder = 110
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

