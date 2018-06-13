$PBExportHeader$w_hst301i.srw
$PBExportComments$실사물품예외관리
forward
global type w_hst301i from w_msheet
end type
type dw_head from datawindow within w_hst301i
end type
type tab_1 from tab within w_hst301i
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
type tab_1 from tab within w_hst301i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from u_tab within w_hst301i
end type
type gb_1 from groupbox within w_hst301i
end type
end forward

global type w_hst301i from w_msheet
dw_head dw_head
tab_1 tab_1
uo_1 uo_1
gb_1 gb_1
end type
global w_hst301i w_hst301i

type variables
//LONG il_getrow
end variables

on w_hst301i.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.tab_1=create tab_1
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_hst301i.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.tab_1)
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
f_childretrieven(dw_head,"c_dept_code")							//부서
f_childretrieve(dw_head,"c_item_class","item_class")			//물품구분
f_childretrieve(dw_head,"c_revenue_opt","asset_opt")			//구입재원
f_childretrieve(dw_head,"c_oper_opt","oper_opt")				//운용구분
f_childretrieve(dw_head,"c_purchase_opt","purchase_opt")	//구매방법


f_childretrieve(tab_1.tabpage_1.dw_main,"item_class","item_class")			//물품구분
f_childretrieve(tab_1.tabpage_1.dw_main,"revenue_opt","asset_opt")			//구입재원
f_childretrieve(tab_1.tabpage_1.dw_main,"oper_opt","oper_opt")				//운용구분
f_childretrieve(tab_1.tabpage_1.dw_main,"purchase_opt","purchase_opt")	//구매방법

f_childretrieve(tab_1.tabpage_2.dw_print,"hst027m_item_class","item_class")			//물품구분

dw_head.Reset()
dw_head.InsertRow(0)

dw_head.object.c_date_f[1] = Left(f_today(),6) + '01'
dw_head.object.c_date_t[1] = f_today()


tab_1.tabpage_2.dw_print.Object.DataWindow.zoom = 100
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print
//////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_init;call super::ue_init;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_init
////	기 능 설 명: 초기화 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_main.Reset()
tab_1.tabpage_2.dw_print.Reset()

////wf_setmenu('I',TRUE)//입력버튼 활성화
////wf_setmenu('S',TRUE)//저장버튼 활성화
////wf_setmenu('D',TRUE)//삭제버튼 활성화
//wf_setmenu('R',TRUE)//저장버튼 활성화

////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////

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
//Long	ll_GetRow, ll_rowcount, ll_row
//long  ll_fr_date, li_idx
//ll_GetRow = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_new()
//IF ll_GetRow = 0 THEN 
//	RETURN
//ELSE
//	ll_rowcount = tab_1.tabpage_1.dw_main.rowcount()
//	
//   FOR ll_row = ll_getrow TO ll_rowcount
//	    tab_1.tabpage_1.dw_main.Object.seq_no[ll_row] = ll_row
//	NEXT
//      
//END IF 
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 디폴티값 셋팅
/////////////////////////////////////////////////////////////////////////////////////////
//tab_1.tabpage_1.dw_main.Object.gubun[ll_GetRow] = '1'
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
////wf_setmenu('I',TRUE)
////wf_setmenu('D',TRUE)
////wf_setmenu('S',TRUE)
//////wf_setmenu('R',TRUE)
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
///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row				//변경된 행
DateTime	ldt_WorkDate		//등록일자
String	ls_Worker			//등록자
String	ls_IPAddr			//등록단말기
DateTime	ldt_JOB_Date		//등록일자
String	ls_JOB_UID		   //등록자
String	ls_JOB_ADD			//등록단말기

ll_Row = tab_1.tabpage_1.dw_main.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate  = f_sysdate()						//등록일자
	ls_Worker     = gstru_uid_uname.uid				//등록자
	ls_IPAddr     = gstru_uid_uname.address		//등록단말기
	ldt_JOB_Date  = f_sysdatE()                  //등록일자
   ls_JOB_UID	  = gstru_uid_uname.uid	         //등록자
   ls_JOB_ADD	  = gstru_uid_uname.address		//등록단말기
END IF
DO WHILE ll_Row > 0
   ////////////////////////////////////////////////////////////////////////////////////
	// 3.1 수정항목 처리
	////////////////////////////////////////////////////////////////////////////////////
	tab_1.tabpage_1.dw_main.Object.hst027m_Worker   [ll_Row] =ls_Worker    //등록자                                                                                                                                     
	tab_1.tabpage_1.dw_main.Object.hst027m_IpAddr   [ll_Row] =ls_IpAddr    //등록단말기                                                                                                                                 
	tab_1.tabpage_1.dw_main.Object.hst027m_Work_Date[ll_Row] =ldt_WorkDate //등록일자                                                                                                                                    
	tab_1.tabpage_1.dw_main.Object.hst027m_job_uid [ll_Row]  =ls_JOB_UID	  //작업자                                                                                                                                           
	tab_1.tabpage_1.dw_main.Object.hst027m_job_add [ll_Row]  =ls_JOB_ADD   //작업단말기
	tab_1.tabpage_1.dw_main.Object.hst027m_job_date[ll_Row]  =ldt_JOB_Date //작업일자
	
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
//wf_setmenu('I',FALSE)
//wf_setmenu('D',FALSE)
//wf_setmenu('S',TRUE)
//wf_setmenu('R',TRUE)
tab_1.tabpage_1.dw_main.SetFocus()
RETURN 1
///////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////////
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
//String	ls_Msg
//Long		ll_DeleteCnt, ll_rowcount, ll_row, ll_deleterow
//ll_DeleteCnt = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_delete(ls_Msg)
//
//	ll_deleterow =tab_1.tabpage_1.dw_main.getrow()
//	ll_rowcount = tab_1.tabpage_1.dw_main.rowcount()
//
//   FOR ll_row = ll_deleterow  TO ll_rowcount 
//		tab_1.tabpage_1.dw_main.Object.seq_no[ll_row] = ll_row	 
//	NEXT
//      
//IF ll_DeleteCnt > 0 THEN
//	wf_SetMsg('자료가 삭제되었습니다.')
//	IF tab_1.tabpage_1.dw_main.rowcount() > 0 THEN
//		//wf_setmenu('R',FALSE)
//		//wf_setmenu('I',TRUE)
//		//wf_setmenu('D',TRUE)
//		//wf_setmenu('S',TRUE)
//	ELSE
//		//wf_setmenu('R',FALSE)
//		//wf_setmenu('I',TRUE)
//		//wf_setmenu('D',FALSE)
//		//wf_setmenu('S',TRUE)
//	END IF
//END IF
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_db_retrieve
////	기 능 설 명: 자료조회 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////////
datawindow dw_name, dw_update
string ls_id_no, ls_item_name, ls_dept_code, ls_chk, ls_dept_name, ls_header, ls_use_gwa_name
string 	ls_date_f, ls_date_t, ls_statement , ls_new,ls_date_f1, ls_date_t1, ls_use_gwa
String	ls_text1, ls_inve_date

String	ls_IdNo	,ls_IdNo1			//등재번호
String	ls_ItemNo,ls_ItemNo1			//품목코드
String	ls_ItemNm,ls_ItemNm1			//품목명
String	ls_Gwa	,ls_Gwa1			//부서
Date		ld_DateFr,ld_DateFr1			//구입일자(From)
Date		ld_DateTo,ld_DateTo1			//구입일자(To)
String	ls_RoomCd,ls_RoomCd1			//사용장소
String	ls_ItemClss	,ls_ItemClss1		//물품구분
String	ls_RevenueOpt,ls_RevenueOpt1		//구입재원
String	ls_OperOpt,ls_OperOpt1			//운용구분
String	ls_PurchaseOpt	,ls_PurchaseOpt1	//구매방법
String	ls_UsefuL,ls_Useful1			//구분
string   ls_datefr,ls_datefr1, ls_dateto,ls_dateto1

ls_IdNo        = TRIM(dw_head.object.c_id_no    [1]) + '%'			//등재번호
ls_ItemNo      = TRIM(dw_head.object.c_item_no  [1]) + '%'			//품목코드
ls_ItemNm      = TRIM(dw_head.object.c_item_name[1]) + '%'			//품목명
ls_Gwa         = TRIM(dw_head.object.c_dept_code[1]) + '%'			//부서
ls_DateFr      = dw_head.object.c_date_f[1]								//구입일자(From)
ls_DateTo      = dw_head.object.c_date_t[1]								//구입일자(To)
ls_RoomCd      = TRIM(dw_head.object.c_room_code     [1]) + '%'	//사용장소
ls_ItemClss    = String(dw_head.object.c_item_class  [1]) + '%'	//물품구분
ls_RevenueOpt  = String(dw_head.object.c_revenue_opt [1]) + '%'	//구입재원
ls_OperOpt     = String(dw_head.object.c_oper_opt    [1]) + '%'	//운용구분
ls_PurchaseOpt = String(dw_head.object.c_purchase_opt[1]) + '%'	//구매방법
ls_Useful      = String(dw_head.object.useful        [1]) + '%'	//구분

//ls_IdNo1       = TRIM(dw_head.object.c_id_no    [1]) 			//등재번호
//ls_ItemNo1      = TRIM(dw_head.object.c_item_no  [1]) 			//품목코드
//ls_ItemNm1      = TRIM(dw_head.object.c_item_name[1]) 			//품목명
//ls_Gwa1         = TRIM(dw_head.object.c_dept_code[1]) 			//부서
//ld_DateFr1      = dw_head.object.c_date_f[1]								//구입일자(From)
//ld_DateTo1      = dw_head.object.c_date_t[1]								//구입일자(To)
//ls_RoomCd1      = TRIM(dw_head.object.c_room_code     [1]) 	//사용장소
//ls_ItemClss1    = String(dw_head.object.c_item_class  [1]) 	//물품구분
//ls_RevenueOpt1  = String(dw_head.object.c_revenue_opt [1]) 	//구입재원
//ls_OperOpt1     = String(dw_head.object.c_oper_opt    [1]) 	//운용구분
//ls_PurchaseOpt1 = String(dw_head.object.c_purchase_opt[1]) 	//구매방법
//ls_Useful1      = String(dw_head.object.useful        [1]) 	//구분

IF isNull(ls_IdNo)   THEN 
	ls_IdNo   = '%' 
ELSE
	ls_header += "등재번호 : "+ls_IdNo1
END IF
IF isNull(ls_ItemNo) THEN 
	ls_ItemNo = '%'
ELSE
	ls_header += "  품목코드 : "+ls_ItemNo1
END IF	
IF isNull(ls_ItemNm) THEN 
	ls_ItemNm = '%'
ELSE
	ls_header += "  품목명 : "+ls_ItemNm1	
END IF	
IF isNull(ls_Gwa)    THEN 
	ls_Gwa    = '%'
ELSE
	ls_header += "  부서 : "+ls_Gwa1		
END IF		
IF isNull(ls_RoomCd) THEN 
	ls_RoomCd = '%'
ELSE
	ls_header += "   사용장소 : "+ls_RoomCd1		
END IF		
IF isNull(ls_ItemClss)   OR ls_ItemClss   = '0%' THEN 
	ls_ItemClss   = '%'
ELSE
	ls_header += "   물품구분 : "+ls_ItemClss1
END IF		
IF isNull(ls_RevenueOpt) OR ls_RevenueOpt = '0%' THEN 
	ls_RevenueOpt = '%'
ELSE
	ls_text1 = dw_head.Describe("Evaluate('LookUpDisplay(c_revenue_opt) ', 1)")	
	ls_header += "   구입재원 : "+ls_text1	
END IF		
IF isNull(ls_OperOpt)    OR ls_OperOpt    = '0%' THEN 
	ls_OperOpt    = '%'
ELSE
	ls_text1 = dw_head.Describe("Evaluate('LookUpDisplay(c_oper_opt) ', 1)")		
	ls_header += "   운용구분 : "+ls_text1		
END IF		
IF isNull(ls_PurchaseOpt) THEN 
	ls_PurchaseOpt = '%'
ELSE
	ls_text1 = dw_head.Describe("Evaluate('LookUpDisplay(c_purchase_opt) ', 1)")		
	ls_header += "   구매방법 : "+ls_text1			
END IF		
IF isNull(ls_Useful) OR ls_Useful = '0%' THEN 
	ls_Useful = '%'
ELSE
	ls_text1 = dw_head.Describe("Evaluate('LookUpDisplay(useful) ', 1)")		
	ls_header += "   구분 : "+ls_text1				
END IF		

/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt, ll_Rowcount, ll_tab
ll_tab = tab_1.selectedtab
CHOOSE CASE  ll_tab
	CASE 1
       tab_1.tabpage_1.dw_main.SetReDraw(FALSE)
       ll_RowCnt = tab_1.tabpage_1.dw_main.Retrieve( ls_IdNo, ls_ItemNo, ls_ItemNm, ls_Gwa, &
															        ls_RoomCd, ls_ItemClss, ls_RevenueOpt, &
															        ls_OperOpt, ls_PurchaseOpt, ls_Useful, &
															        ls_DateFr, ls_DateTo ) 
       tab_1.tabpage_1.dw_main.SetReDraw(TRUE)
      ///////////////////////////////////////////////////////////////////////////////////////
      // 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
      ///////////////////////////////////////////////////////////////////////////////////////
      IF ll_RowCnt = 0 THEN 
       	//wf_setmenu('D',FALSE)
      	//wf_setmenu('S',FALSE)
	      //wf_setmenu('P',FALSE)
	      wf_SetMsg('해당자료가 존재하지 않습니다.')
      ELSE
      	//wf_setmenu('D',FALSE)
	      //wf_setmenu('S',TRUE)
      	//wf_setmenu('P',TRUE)
	      wf_SetMsg('자료가 조회되었습니다.')
      END IF
		
	CASE 2
       tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
       ll_Rowcount = tab_1.tabpage_2.dw_print.Retrieve( ls_IdNo, ls_ItemNo, ls_ItemNm, ls_Gwa, &
															           ls_RoomCd, ls_ItemClss, ls_RevenueOpt, &
															           ls_OperOpt, ls_PurchaseOpt, ls_Useful, &
															           ls_DateFr, ls_DateTo ) 
       tab_1.tabpage_2.dw_print.SetReDraw(TRUE)
       /////////////////////////////////////////////////////////////////////////////////////////
       //// 3. 데이타원도우에 출력조건 및 시스템일자 처리
       /////////////////////////////////////////////////////////////////////////////////////////
//       DateTime	ldt_SysDateTime
//       ldt_SysDateTime = f_sysdate()	//시스템일자
//       tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//       tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

       ////////////////////////////////////////////////////////////////////////////////////
       // 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
       ///////////////////////////////////////////////////////////////////////////////////////
       IF ll_Rowcount = 0 THEN
	       wf_SetMsg('해당자료가 존재하지 않습니다.')
       ELSE 
	       //wf_setmenu('P',TRUE)
	       wf_SetMsg('자료가 조회되었습니다.')
       END IF
END CHOOSE
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
avc_data.SetProperty('title', "실사예외품내역")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hst301i
end type

type ln_tempright from w_msheet`ln_tempright within w_hst301i
end type

type ln_temptop from w_msheet`ln_temptop within w_hst301i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst301i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst301i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst301i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst301i
end type

type uc_insert from w_msheet`uc_insert within w_hst301i
end type

type uc_delete from w_msheet`uc_delete within w_hst301i
end type

type uc_save from w_msheet`uc_save within w_hst301i
end type

type uc_excel from w_msheet`uc_excel within w_hst301i
end type

type uc_print from w_msheet`uc_print within w_hst301i
end type

type st_line1 from w_msheet`st_line1 within w_hst301i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hst301i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hst301i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst301i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst301i
end type

type dw_head from datawindow within w_hst301i
event ue_keydown pbm_dwnkey
integer x = 87
integer y = 176
integer width = 3749
integer height = 284
integer taborder = 50
string title = "none"
string dataobject = "d_hst301i_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;String	ls_room_name
s_uid_uname	ls_middle

THIS.AcceptText()

IF key = KeyEnter! THEN 
	IF THIS.GetColumnName() = 'c_room_name' THEN		// 사용장소
		ls_room_name = THIS.object.c_room_name[1]
		OpenWithParm(w_hgm100h,ls_room_name)
		IF message.stringparm <> '' THEN
			THIS.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
			THIS.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
		END IF
		 ELSEIF THIS.GetColumnName() = 'c_item_name' THEN		// 품목명
			ls_middle.uname = this.object.c_item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
   ELSE
       TRIGGER EVENT ue_retrieve()
	END IF
END IF
end event

event itemchanged;IF dwo.name = 'c_room_name' THEN
	THIS.object.c_room_code[1] = ''
ELSEIF dwo.name = 'c_dept_code' THEN
	Long	li_cnt 
	SELECT	COUNT(*)
	INTO		:li_cnt
	FROM		CDDB.KCH003M
	WHERE		gwa = :data;
	IF li_cnt = 0 OR isnull(li_cnt) THEN
		RETURN -1
	END IF
END IF

end event

event dberror;return 1
end event

event doubleclicked;String	ls_room_name
s_uid_uname	ls_middle

THIS.AcceptText()

	IF dwo.name = 'c_room_name' THEN		// 사용장소
		ls_room_name = THIS.object.c_room_name[1]
		OpenWithParm(w_hgm100h,ls_room_name)
		IF message.stringparm <> '' THEN
			THIS.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
			THIS.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
		END IF
		 ELSEIF dwo.name = 'c_item_name' THEN		// 품목명
			ls_middle.uname = this.object.c_item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
   ELSE
       TRIGGER EVENT ue_retrieve()
	END IF
end event

type tab_1 from tab within w_hst301i
event create ( )
event destroy ( )
integer x = 50
integer y = 524
integer width = 4384
integer height = 1764
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
integer height = 1644
string text = "실사예외물품관리"
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
integer y = 4
integer width = 4352
integer height = 1644
integer taborder = 50
string dataobject = "d_hst301i_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1644
string text = "실사예외물품내역"
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
integer height = 1644
integer taborder = 60
string title = "none"
string dataobject = "d_hst301i_9"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type uo_1 from u_tab within w_hst301i
event destroy ( )
integer x = 1262
integer y = 520
integer height = 148
integer taborder = 40
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type gb_1 from groupbox within w_hst301i
integer x = 50
integer y = 116
integer width = 4389
integer height = 368
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

