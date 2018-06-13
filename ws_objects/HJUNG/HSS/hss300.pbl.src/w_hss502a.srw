$PBExportHeader$w_hss502a.srw
$PBExportComments$기타구입 검수관리
forward
global type w_hss502a from w_msheet
end type
type ddlb_gbn from dropdownlistbox within w_hss502a
end type
type st_10 from statictext within w_hss502a
end type
type sle_name from singlelineedit within w_hss502a
end type
type st_3 from statictext within w_hss502a
end type
type tab_1 from tab within w_hss502a
end type
type tabpage_1 from userobject within tab_1
end type
type sle_number from singlelineedit within tabpage_1
end type
type st_9 from statictext within tabpage_1
end type
type em_hdate from editmask within tabpage_1
end type
type st_8 from statictext within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type sle_name2 from singlelineedit within tabpage_1
end type
type dw_list from uo_dwgrid within tabpage_1
end type
type dw_main from uo_dwgrid within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
sle_number sle_number
st_9 st_9
em_hdate em_hdate
st_8 st_8
st_4 st_4
sle_name2 sle_name2
dw_list dw_list
dw_main dw_main
gb_2 gb_2
gb_3 gb_3
end type
type tabpage_3 from userobject within tab_1
end type
type sle_seq_num from singlelineedit within tabpage_3
end type
type st_13 from statictext within tabpage_3
end type
type st_12 from statictext within tabpage_3
end type
type sle_mid_name from singlelineedit within tabpage_3
end type
type em_in_date from editmask within tabpage_3
end type
type st_11 from statictext within tabpage_3
end type
type gb_6 from groupbox within tabpage_3
end type
type dw_print_list from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
sle_seq_num sle_seq_num
st_13 st_13
st_12 st_12
sle_mid_name sle_mid_name
em_in_date em_in_date
st_11 st_11
gb_6 gb_6
dw_print_list dw_print_list
end type
type tab_1 from tab within w_hss502a
tabpage_1 tabpage_1
tabpage_3 tabpage_3
end type
type st_2 from statictext within w_hss502a
end type
type em_to_date from editmask within w_hss502a
end type
type em_fr_date from editmask within w_hss502a
end type
type st_1 from statictext within w_hss502a
end type
type uo_1 from u_tab within w_hss502a
end type
type gb_1 from groupbox within w_hss502a
end type
end forward

global type w_hss502a from w_msheet
ddlb_gbn ddlb_gbn
st_10 st_10
sle_name sle_name
st_3 st_3
tab_1 tab_1
st_2 st_2
em_to_date em_to_date
em_fr_date em_fr_date
st_1 st_1
uo_1 uo_1
gb_1 gb_1
end type
global w_hss502a w_hss502a

type variables
LONG il_getrow
end variables

on w_hss502a.create
int iCurrent
call super::create
this.ddlb_gbn=create ddlb_gbn
this.st_10=create st_10
this.sle_name=create sle_name
this.st_3=create st_3
this.tab_1=create tab_1
this.st_2=create st_2
this.em_to_date=create em_to_date
this.em_fr_date=create em_fr_date
this.st_1=create st_1
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_gbn
this.Control[iCurrent+2]=this.st_10
this.Control[iCurrent+3]=this.sle_name
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_to_date
this.Control[iCurrent+8]=this.em_fr_date
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.gb_1
end on

on w_hss502a.destroy
call super::destroy
destroy(this.ddlb_gbn)
destroy(this.st_10)
destroy(this.sle_name)
destroy(this.st_3)
destroy(this.tab_1)
destroy(this.st_2)
destroy(this.em_to_date)
destroy(this.em_fr_date)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.gb_1)
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
tab_1.tabpage_3.dw_print_list.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_3.dw_print_list

f_childretrieven(tab_1.tabpage_1.dw_main,"gwa")

String	ls_Today
Long ll_gbn
ls_Today = String(Today(),'YYYYMMDD')
em_fr_date.Text = MID(ls_Today,1,6)+'01'
em_to_date.Text = ls_Today

ll_gbn = long(left(ddlb_gbn.text,1))
ddlb_gbn.text	=	'3'
tab_1.tabpage_3.em_in_date.text = ls_Today

tab_1.tabpage_3.dw_print_list.settransobject(sqlca)
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
tab_1.tabpage_1.dw_list.Reset()

//wf_setMenu('I',TRUE)//입력버튼 활성화
//wf_setMenu('S',TRUE)//저장버튼 활성화
//wf_setMenu('D',TRUE)//삭제버튼 활성화
//wf_setMenu('R',TRUE)//저장버튼 활성화

//triggerevent('ue_retrieve')

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////


end event

event ue_insert;call super::ue_insert;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_insert
////	기 능 설 명: 자료추가 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 입력조건체크
/////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료추가
/////////////////////////////////////////////////////////////////////////////////////////
//Long	ll_GetRow, ll_rowcount, ll_row, ll_number
//long  ll_fr_date, li_idx, ll_apply_seq,  ll_cnt
//DataWindow  dw_name
//dw_name = tab_1.tabpage_1.dw_main
//
//dw_name.Reset()
//
//ll_GetRow = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_new()
//tab_1.tabpage_1.em_hdate.enabled = TRUE
//tab_1.tabpage_1.em_hdate.text = f_today()
//tab_1.tabpage_1.sle_name2.enabled = TRUE
//tab_1.tabpage_1.sle_name2.text = ''
//
///////////////////////////////////////////////////////////////////////////////////////////
////// 3. 디폴티값 셋팅
///////////////////////////////////////////////////////////////////////////////////////////
// tab_1.tabpage_1.dw_main.object.apply_date[tab_1.tabpage_1.dw_main.getrow()] = left(tab_1.tabpage_1.em_hdate.text,4) + mid(tab_1.tabpage_1.em_hdate.text,6,2) + right(tab_1.tabpage_1.em_hdate.text,2)
// tab_1.tabpage_1.dw_main.object.apply_seq [tab_1.tabpage_1.dw_main.getrow()] = long(tab_1.tabpage_1.sle_number.text)
// tab_1.tabpage_1.dw_main.object.mid_name  [tab_1.tabpage_1.dw_main.getrow()] = tab_1.tabpage_1.sle_name2.text
// tab_1.tabpage_1.dw_main.object.item_gbn  [tab_1.tabpage_1.dw_main.getrow()] = 1
//  
/////////////////////////////////////////////////////////////////////////////////////////
//// 4. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
////			사용하지 안을경우는 커맨트 처리
/////////////////////////////////////////////////////////////////////////////////////////
//tab_1.tabpage_1.dw_main.SetItemStatus(ll_GetRow,0,Primary!,NotModified!)
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 5. 메세지처리, 고정버튼 활성화/비활성화, 데이타원도우로 포커스이동 처리
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMsg('자료가 추가되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
////wf_SetMenu('R',TRUE)
//tab_1.tabpage_1.dw_main.Setfocus()
////tab_1.tabpage_1.dw_main.setcolumn('sorc_rvn')
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////
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

Long ll_rowcount, ll_row
ll_rowcount = tab_1.tabpage_1.dw_main.rowcount()
	
   FOR ll_row = 1 TO ll_rowcount
	    tab_1.tabpage_1.dw_main.object.apply_date[ll_row] = left(tab_1.tabpage_1.em_hdate.text,4) + mid(tab_1.tabpage_1.em_hdate.text,6,2) + right(tab_1.tabpage_1.em_hdate.text,2)
		 IF isnull(long(tab_1.tabpage_1.sle_number.text)) OR long(tab_1.tabpage_1.sle_number.text) = 0 THEN
			 tab_1.tabpage_1.dw_main.object.apply_seq [ll_row] = 1
		 ELSE
			 tab_1.tabpage_1.dw_main.object.apply_seq [ll_row] = long(tab_1.tabpage_1.sle_number.text)
		 END IF
       tab_1.tabpage_1.dw_main.object.mid_name  [ll_row] = trim(tab_1.tabpage_1.sle_name2.text)
		 tab_1.tabpage_1.dw_main.object.ITEM_MEMBER_NO[ll_row] =  gstru_uid_uname.uid
		 tab_1.tabpage_1.dw_main.object.item_gbn  [ll_row] = 7
 	NEXT

/////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'apply_date/신청일자'
ls_NotNullCol[2] = 'item_seq/순번'
ls_NotNullCol[3] = 'mid_name/건명'
ls_NotNullCol[4] = 'item_name/품명'
ls_NotNullCol[5] = 'acct_code/계정과목'
IF f_chk_null(tab_1.tabpage_1.dw_main,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//2_1.날자체크 
///////////////////////////////////////////////////////////////////////////////////////////////////////////
integer li_check
string ls_check_date
ls_check_date = left(tab_1.tabpage_1.em_hdate.text,4) + mid(tab_1.tabpage_1.em_hdate.text,6,2) + right(tab_1.tabpage_1.em_hdate.text,2)
If isnull(ls_check_date) or ls_check_date = '' then
 else
   if not f_isdate(ls_check_date) then
	   MessageBox('확인','신청일자가 잘못 되었습니다.~r' +ls_check_date+ '의 일자를 확인 하여 주십시요.')
	   return -1
   end IF
end IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
//Long		ll_Row				//변경된 행
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
	ldt_JOB_Date  = f_sysdatE()                   //등록일자
   ls_JOB_UID	  = gstru_uid_uname.uid	         //등록자
   ls_JOB_ADD	  = gstru_uid_uname.address		   //등록단말기
END IF
DO WHILE ll_Row > 0
   ////////////////////////////////////////////////////////////////////////////////////
	// 3.1 수정항목 처리
	////////////////////////////////////////////////////////////////////////////////////
	tab_1.tabpage_1.dw_main.Object.Worker   [ll_Row]  = ls_Worker   //등록자                                                                                                                                     
	tab_1.tabpage_1.dw_main.Object.IpAddr   [ll_Row]  = ls_IpAddr   //등록단말기                                                                                                                                 
	tab_1.tabpage_1.dw_main.Object.Work_Date[ll_Row]  = ldt_WorkDate//등록일자                                                                                                                                    
	tab_1.tabpage_1.dw_main.Object.job_uid  [ll_Row]  = ls_JOB_UID	//작업자                                                                                                                                           
	tab_1.tabpage_1.dw_main.Object.job_add  [ll_Row]  = ls_JOB_ADD//작업단말기
	tab_1.tabpage_1.dw_main.Object.job_date [ll_Row]  = ldt_JOB_Date//작업일자
	
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
RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;call super::ue_delete;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_delete
////	기 능 설 명: 자료삭제 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 삭제할 데이타원도우의 선택여부 체크.
/////////////////////////////////////////////////////////////////////////////////////////
//Long		ll_GetRow
//DataWindow  dw_name
//dw_name = tab_1.tabpage_1.dw_main
//
//IF tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
//			ll_GetRow = tab_1.tabpage_1.dw_main.GetRow()
//	IF NOT tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
//			ll_GetRow = tab_1.tabpage_1.dw_main.GetSelectedRow(0)
//IF ll_GetRow = 0 THEN RETURN
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 삭제메세지 처리.
////		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
/////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 삭제처리.
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_Msg, ls_date
//Long		ll_DeleteCnt, ll_rowcount, ll_row, ll_deleterow
//
//ll_DeleteCnt = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_delete(ls_Msg)
//
//	ll_deleterow =tab_1.tabpage_1.dw_main.getrow()
//	ll_rowcount = tab_1.tabpage_1.dw_main.rowcount()
//
//   FOR ll_row = ll_deleterow  TO ll_rowcount 
//		 IF ll_row = 0 THEN
//			EXIT
//		END IF
//		 dw_name.Object.item_seq[ll_row] =  ll_row 
//	NEXT
//      
//IF ll_DeleteCnt > 0 THEN
//	wf_SetMsg('자료가 삭제되었습니다.')
//	IF tab_1.tabpage_1.dw_main.rowcount() > 0 THEN
//		wf_SetMenu('R',TRUE)
//		wf_SetMenu('I',TRUE)
//		wf_SetMenu('D',TRUE)
//		wf_SetMenu('S',TRUE)
//	ELSE
//		wf_SetMenu('R',FALSE)
//		wf_SetMenu('I',TRUE)
//		wf_SetMenu('D',FALSE)
//		wf_SetMenu('S',TRUE)
//	END IF
//END IF
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
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
	messagebox("알림",'기간을 입력하시기 바랍니다.')
	em_fr_date.SetFocus()
	RETURN -1
END IF
	lsc_fr_Date = String(ls_fr_Date,'@@@@/@@/@@')

String	ls_to_Date,lsc_to_Date

em_to_date.GetData(ls_to_Date)
ls_to_Date = TRIM(ls_to_Date)

IF isNull(ls_to_Date) OR LEN(ls_to_Date) = 0 THEN
	messagebox("알림",'기간을 입력하시기 바랍니다.')
	em_to_date.SetFocus()
	RETURN -1
END IF

lsc_to_Date = String(ls_to_Date,'@@@@/@@/@@')

STring  ls_date
ls_date = lsc_fr_Date + " - " + lsc_to_Date

IF ls_fr_Date > ls_to_Date THEN
	messagebox("알림",'기간 입력오류입니다.')
	em_fr_date.SetFocus()
	RETURN -1
END IF

String ls_mid_name
ls_mid_name = sle_name.text
IF isnull(ls_mid_name) OR ls_mid_name = '' THEN
	ls_mid_name = '%'
END IF

Long ll_gbn
ll_gbn = long(left(ddlb_gbn.text,1))
IF isnull(ll_gbn) THEN
	ll_gbn = 0
END IF
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Integer ii_tab
Long	ll_RowCnt, ll_apply_seq, ll_in_apply_seq
String ls_apply_date, ls_apply_date2, ls_mid_name2
String ls_in_date, ls_in_date2, ls_in_mid_name2 

 ii_tab = tab_1.selectedtab
CHOOSE CASE ii_tab	
	CASE 1
       tab_1.tabpage_1.dw_list.SetReDraw(FALSE)
       ll_RowCnt = tab_1.tabpage_1.dw_list.Retrieve(ls_fr_date, ls_to_date, ls_mid_name, ll_gbn)
       tab_1.tabpage_1.dw_list.SetReDraw(TRUE)
   
	CASE 2
			
		ls_in_date  = tab_1.tabpage_3.em_in_date.text
	   ls_in_date2 = left(ls_in_date,4) + mid(ls_in_date,6,2) + right(ls_in_date,2)
      
		IF isnull(ls_in_date) OR ls_in_date2 ='' THEN
	      messagebox('확인','신청일자를 입력하시기 바랍니다..!')
      END IF
      
		ls_in_mid_name2 = trim(tab_1.tabpage_3.sle_mid_name.text)
      
		IF isnull(ls_in_mid_name2) OR ls_in_mid_name2 ='' THEN
	      ls_in_mid_name2 = '%'
      END IF
      
		ll_in_apply_seq = long(tab_1.tabpage_3.sle_seq_num.text)
      		
		IF isnull(ll_in_apply_seq) OR ll_in_apply_seq = 0 THEN
	      ll_in_apply_seq = 0
      END IF
//		messagebox('신청일자와건명',ls_in_date2+':'+ls_in_mid_name2)
//		messagebox('신청번호',ll_in_apply_seq)
       tab_1.tabpage_3.dw_print_list.SetReDraw(FALSE)
       ll_RowCnt = tab_1.tabpage_3.dw_print_list.Retrieve(ls_in_date2, ls_in_mid_name2, ll_in_apply_seq)
       tab_1.tabpage_3.dw_print_list.SetReDraw(TRUE)

END CHOOSE
///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',true)
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;
//f_print(tab_1.tabpage_3.dw_print_list)

end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "기타구입 검수조서")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hss502a
end type

type ln_tempright from w_msheet`ln_tempright within w_hss502a
end type

type ln_temptop from w_msheet`ln_temptop within w_hss502a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hss502a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hss502a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hss502a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hss502a
end type

type uc_insert from w_msheet`uc_insert within w_hss502a
end type

type uc_delete from w_msheet`uc_delete within w_hss502a
end type

type uc_save from w_msheet`uc_save within w_hss502a
end type

type uc_excel from w_msheet`uc_excel within w_hss502a
end type

type uc_print from w_msheet`uc_print within w_hss502a
end type

type st_line1 from w_msheet`st_line1 within w_hss502a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hss502a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hss502a
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hss502a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hss502a
end type

type ddlb_gbn from dropdownlistbox within w_hss502a
integer x = 3255
integer y = 212
integer width = 407
integer height = 324
integer taborder = 21
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
string item[] = {"1.물품신청","3.예산승인","7.입고"}
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within w_hss502a
integer x = 2990
integer y = 224
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "물품상태"
boolean focusrectangle = false
end type

type sle_name from singlelineedit within w_hss502a
integer x = 1545
integer y = 196
integer width = 1339
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_hss502a
integer x = 1376
integer y = 224
integer width = 169
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "건 명"
boolean focusrectangle = false
end type

type tab_1 from tab within w_hss502a
event create ( )
event destroy ( )
integer x = 50
integer y = 400
integer width = 4384
integer height = 1880
integer taborder = 50
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
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1760
string text = "기타구입 입고"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
sle_number sle_number
st_9 st_9
em_hdate em_hdate
st_8 st_8
st_4 st_4
sle_name2 sle_name2
dw_list dw_list
dw_main dw_main
gb_2 gb_2
gb_3 gb_3
end type

on tabpage_1.create
this.sle_number=create sle_number
this.st_9=create st_9
this.em_hdate=create em_hdate
this.st_8=create st_8
this.st_4=create st_4
this.sle_name2=create sle_name2
this.dw_list=create dw_list
this.dw_main=create dw_main
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.sle_number,&
this.st_9,&
this.em_hdate,&
this.st_8,&
this.st_4,&
this.sle_name2,&
this.dw_list,&
this.dw_main,&
this.gb_2,&
this.gb_3}
end on

on tabpage_1.destroy
destroy(this.sle_number)
destroy(this.st_9)
destroy(this.em_hdate)
destroy(this.st_8)
destroy(this.st_4)
destroy(this.sle_name2)
destroy(this.dw_list)
destroy(this.dw_main)
destroy(this.gb_2)
destroy(this.gb_3)
end on

type sle_number from singlelineedit within tabpage_1
integer x = 1010
integer y = 1016
integer width = 297
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within tabpage_1
integer x = 754
integer y = 1040
integer width = 279
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청번호"
boolean focusrectangle = false
end type

type em_hdate from editmask within tabpage_1
integer x = 343
integer y = 1016
integer width = 370
integer height = 92
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_8 from statictext within tabpage_1
integer x = 82
integer y = 1040
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청일자"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_1
integer x = 1344
integer y = 1040
integer width = 165
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "건 명"
boolean focusrectangle = false
end type

type sle_name2 from singlelineedit within tabpage_1
integer x = 1522
integer y = 1016
integer width = 1655
integer height = 92
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
integer limit = 100
borderstyle borderstyle = stylelowered!
end type

type dw_list from uo_dwgrid within tabpage_1
integer x = 64
integer y = 92
integer width = 4251
integer height = 796
integer taborder = 50
string dataobject = "d_hss502a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event rowfocuschanging;call super::rowfocuschanging;Long	ll_RowCnt, ll_apply_seq, ll_getrow,ll_rowcount, ll_row
String  ls_apply_date, ls_mid_name

ll_getrow = newrow
Datawindow   idw_name
idw_name = tab_1.tabpage_1.dw_list
IF   idw_name.rowcount() = 0 THEN
    RETURN
ELSE
   ls_apply_date = idw_name.object.apply_date[ll_getrow]
   ll_apply_seq  = idw_name.object.apply_seq [ll_getrow]
   ls_mid_name   = idw_name.object.mid_name  [ll_getrow]

   tab_1.tabpage_1.sle_name2.text  = ls_mid_name
   tab_1.tabpage_1.em_hdate.text   = ls_apply_date
   tab_1.tabpage_1.sle_number.text = string(ll_apply_seq)
	
   tab_1.tabpage_1.dw_main.SetReDraw(FALSE)
   ll_RowCnt = tab_1.tabpage_1.dw_main.Retrieve(ls_apply_date, ll_apply_seq, ls_mid_name)
	
	ll_rowcount = tab_1.tabpage_1.dw_main.rowcount()
	
   FOR ll_row = 1 TO ll_rowcount
	  	tab_1.tabpage_1.dw_main.object.in_date[ll_row] = f_today()
		tab_1.tabpage_1.dw_main.object.gwa[ll_row] = '1301'
		tab_1.tabpage_1.dw_main.object.audit_member_no[ll_row] = 'F0005'
		tab_1.tabpage_1.dw_main.object.audit_position[ll_row] = '사무과장'
	NEXT
   tab_1.tabpage_1.dw_main.SetReDraw(TRUE)
	IF ll_RowCnt <> 0 THEN
      tab_1.tabpage_1.em_hdate.enabled  = FALSE
      tab_1.tabpage_1.sle_name2.enabled = TRUE
   END IF
END IF

end event

type dw_main from uo_dwgrid within tabpage_1
integer x = 64
integer y = 1120
integer width = 4251
integer height = 632
integer taborder = 31
string dataobject = "d_hss502a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemfocuschanged;call super::itemfocuschanged;LONG  ll_qty, ll_price, ll_amt
 ll_qty   = this.object.item_qty[this.getrow()]
 ll_price = this.object.item_price[this.getrow()]
 ll_amt   = ll_qty * ll_price
 
 this.object.item_amt[this.getrow()] = ll_amt
end event

type gb_2 from groupbox within tabpage_1
integer x = 23
integer y = 28
integer width = 4311
integer height = 904
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "기타 구입신청내역"
end type

type gb_3 from groupbox within tabpage_1
integer x = 23
integer y = 948
integer width = 4311
integer height = 1152
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "기타 구입신청 상세내역"
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1760
string text = "기타구입검수조서"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
sle_seq_num sle_seq_num
st_13 st_13
st_12 st_12
sle_mid_name sle_mid_name
em_in_date em_in_date
st_11 st_11
gb_6 gb_6
dw_print_list dw_print_list
end type

on tabpage_3.create
this.sle_seq_num=create sle_seq_num
this.st_13=create st_13
this.st_12=create st_12
this.sle_mid_name=create sle_mid_name
this.em_in_date=create em_in_date
this.st_11=create st_11
this.gb_6=create gb_6
this.dw_print_list=create dw_print_list
this.Control[]={this.sle_seq_num,&
this.st_13,&
this.st_12,&
this.sle_mid_name,&
this.em_in_date,&
this.st_11,&
this.gb_6,&
this.dw_print_list}
end on

on tabpage_3.destroy
destroy(this.sle_seq_num)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.sle_mid_name)
destroy(this.em_in_date)
destroy(this.st_11)
destroy(this.gb_6)
destroy(this.dw_print_list)
end on

type sle_seq_num from singlelineedit within tabpage_3
integer x = 2715
integer y = 80
integer width = 457
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_13 from statictext within tabpage_3
integer x = 2459
integer y = 100
integer width = 274
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청번호"
boolean focusrectangle = false
end type

type st_12 from statictext within tabpage_3
integer x = 837
integer y = 100
integer width = 187
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "건 명"
boolean focusrectangle = false
end type

type sle_mid_name from singlelineedit within tabpage_3
integer x = 1029
integer y = 80
integer width = 1381
integer height = 92
integer taborder = 31
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type em_in_date from editmask within tabpage_3
integer x = 361
integer y = 80
integer width = 357
integer height = 92
integer taborder = 31
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

type st_11 from statictext within tabpage_3
integer x = 91
integer y = 100
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청일자"
boolean focusrectangle = false
end type

type gb_6 from groupbox within tabpage_3
integer x = 9
integer y = 20
integer width = 4338
integer height = 188
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type dw_print_list from datawindow within tabpage_3
integer x = 18
integer y = 216
integer width = 4347
integer height = 1544
integer taborder = 20
string title = "none"
string dataobject = "d_hss501a_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type st_2 from statictext within w_hss502a
integer x = 837
integer y = 196
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

type em_to_date from editmask within w_hss502a
integer x = 905
integer y = 196
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

type em_fr_date from editmask within w_hss502a
integer x = 462
integer y = 196
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

type st_1 from statictext within w_hss502a
integer x = 279
integer y = 224
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

type uo_1 from u_tab within w_hss502a
event destroy ( )
integer x = 1641
integer y = 364
integer height = 148
integer taborder = 200
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type gb_1 from groupbox within w_hss502a
integer x = 50
integer y = 120
integer width = 4389
integer height = 236
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

