$PBExportHeader$w_hst303i.srw
$PBExportComments$재물조사결과관리
forward
global type w_hst303i from w_msheet
end type
type tab_1 from tab within w_hst303i
end type
type tabpage_1 from userobject within tab_1
end type
type cb_2 from uo_imgbtn within tabpage_1
end type
type cb_1 from uo_imgbtn within tabpage_1
end type
type cb_3 from uo_imgbtn within tabpage_1
end type
type dw_head2 from datawindow within tabpage_1
end type
type rb_2 from radiobutton within tabpage_1
end type
type rb_1 from radiobutton within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type dw_head from datawindow within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type dw_fileimport from cuo_dwwindow_one_hin within tabpage_1
end type
type dw_list from uo_dwgrid within tabpage_1
end type
type dw_main from uo_dwgrid within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
dw_head2 dw_head2
rb_2 rb_2
rb_1 rb_1
gb_2 gb_2
dw_head dw_head
gb_1 gb_1
gb_4 gb_4
dw_fileimport dw_fileimport
dw_list dw_list
dw_main dw_main
gb_3 gb_3
end type
type tabpage_3 from userobject within tab_1
end type
type dw_print1 from datawindow within tabpage_3
end type
type dw_head3 from datawindow within tabpage_3
end type
type gb_5 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_print1 dw_print1
dw_head3 dw_head3
gb_5 gb_5
end type
type tabpage_4 from userobject within tab_1
end type
type dw_head4 from datawindow within tabpage_4
end type
type gb_6 from groupbox within tabpage_4
end type
type dw_print2 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_head4 dw_head4
gb_6 gb_6
dw_print2 dw_print2
end type
type tab_1 from tab within w_hst303i
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type uo_1 from u_tab within w_hst303i
end type
end forward

global type w_hst303i from w_msheet
tab_1 tab_1
uo_1 uo_1
end type
global w_hst303i w_hst303i

on w_hst303i.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_1
end on

on w_hst303i.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_open;call super::ue_open; //////////////////////////////////////////////////////////////////////////////////////////
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
tab_1.tabpage_1.dw_head.Reset()
tab_1.tabpage_1.dw_head.InsertRow(0)
f_childretrieven(tab_1.tabpage_1.dw_head,"c_dept_code")	                     // 사용 부서
tab_1.tabpage_1.dw_head.object.c_date_f[1] = Left(f_today(),6) + '01'
tab_1.tabpage_1.dw_head.object.c_date_t[1] = f_today()

f_childretrieve(tab_1.tabpage_1.dw_main,"item_class","item_class")	         //물품구분    
f_childretrieve(tab_1.tabpage_1.dw_main,"inve_status","inve_status")	         // 자산 상태
f_childretrieve(tab_1.tabpage_1.dw_main,"inve_detail","inve_detail")	         // 실사 결과

tab_1.tabpage_1.dw_head2.reset()
tab_1.tabpage_1.dw_head2.insertrow(0)

f_childretrieven(tab_1.tabpage_1.dw_head2,"c_dept_code")	                          // 부 서 
f_childretrieven(tab_1.tabpage_1.dw_head2,"c_room_code")	                          // 사용 장소 
f_childretrieve(tab_1.tabpage_1.dw_head2,"c_item_class","item_class")              // 물품구분 
f_childretrieve(tab_1.tabpage_1.dw_head2,"c_revenue_opt","asset_opt")              // 구입 재원
f_childretrieve(tab_1.tabpage_1.dw_head2,"c_oper_opt","oper_opt")                  //운용방법

f_childretrieve(tab_1.tabpage_1.dw_list,"item_class","item_class")              // 물품구분 

tab_1.tabpage_3.dw_head3.Reset()
tab_1.tabpage_3.dw_head3.InsertRow(0)
f_childretrieven(tab_1.tabpage_3.dw_head3,"c_dept_code")	                     // 사용 부서
tab_1.tabpage_3.dw_head3.object.c_date_f[1] = Left(f_today(),6) + '01'
tab_1.tabpage_3.dw_head3.object.c_date_t[1] = f_today()

f_childretrieve(tab_1.tabpage_3.dw_print1,"hst033h_item_class","item_class")	         //물품구분    
f_childretrieve(tab_1.tabpage_3.dw_print1,"hst033h_inve_status","inve_status")	         // 자산 상태
f_childretrieve(tab_1.tabpage_3.dw_print1,"hst033h_inve_detail","inve_detail")	         // 실사 결과 

tab_1.tabpage_4.dw_head4.Reset()
tab_1.tabpage_4.dw_head4.InsertRow(0)
f_childretrieven(tab_1.tabpage_4.dw_head4,"c_dept_code")	                     // 사용 부서
tab_1.tabpage_4.dw_head4.object.c_date_f[1] = Left(f_today(),6) + '01'
tab_1.tabpage_4.dw_head4.object.c_date_t[1] = f_today()

f_childretrieve(tab_1.tabpage_4.dw_print2,"hst033h_item_class","item_class")	         //물품구분    

tab_1.tabpage_3.dw_print1.Object.DataWindow.zoom = 100
tab_1.tabpage_3.dw_print1.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_3.dw_print1


tab_1.tabpage_4.dw_print2.Object.DataWindow.zoom = 100
tab_1.tabpage_4.dw_print2.Object.DataWindow.Print.Preview = 'YES'

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
//tab_1.tabpage_2.dw_print.Reset()

////wf_setmenu('I',TRUE)//입력버튼 활성화
////wf_setmenu('S',TRUE)//저장버튼 활성화
////wf_setmenu('D',TRUE)//삭제버튼 활성화
//wf_setmenu('R',TRUE)//저장버튼 활성화

////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////

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
//string ls_id_no, ls_item_name, ls_dept_code, ls_chk, ls_dept_name, ls_header, ls_use_gwa_name
//string 	ls_date_f, ls_date_t, ls_statement , ls_new,ls_date_f1, ls_date_t1, ls_use_gwa
//String	ls_text1, ls_inve_date

String	ls_IdNo				//등재번호
//String	ls_ItemNo			//품목코드
String	ls_ItemNm			//품목명
String	ls_Gwa				//부서
String	ls_DateFr			//구입일자(From)
String	ls_DateTo		  //구입일자(To)
//String	ls_RoomCd			//사용장소
//String	ls_ItemClss			//물품구분
//String	ls_RevenueOpt		//구입재원
//String	ls_OperOpt			//운용구분
//String	ls_PurchaseOpt		//구매방법
//String	ls_UsefuL		  //구분


ls_IdNo        = TRIM(tab_1.tabpage_1.dw_head.object.c_id_no [1])    + '%'			   //등재번호
//ls_ItemNo    = TRIM(dw_head.object.c_item_no  [1]) + '%'			//품목코드
ls_ItemNm      = TRIM(tab_1.tabpage_1.dw_head.object.c_item_name[1]) + '%'			//품목명
ls_Gwa         = TRIM(tab_1.tabpage_1.dw_head.object.c_dept_code[1]) + '%'			//부서
ls_DateFr      = tab_1.tabpage_1.dw_head.object.c_date_f[1]								//실사일자(From)
ls_DateTo      = tab_1.tabpage_1.dw_head.object.c_date_t[1]								//실사일자(To)

IF isnull(ls_IdNo) THEN
	ls_idno = '%'
END IF
IF isnull(ls_ItemNm) THEN
	ls_ItemNm = '%'
END IF
IF isnull(ls_Gwa) THEN
	ls_Gwa = '%'
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
       ll_RowCnt = tab_1.tabpage_1.dw_main.Retrieve(ls_IdNo, ls_ItemNm, ls_Gwa, ls_DateFr, ls_DateTo ) 
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
      	//wf_setmenu('D',TRUE)
	      //wf_setmenu('S',TRUE)
      	//wf_setmenu('P',TRUE)
	      wf_SetMsg('자료가 조회되었습니다.')
      END IF
		
	CASE 2
		ls_IdNo        = TRIM(tab_1.tabpage_3.dw_head3.object.c_id_no [1])    + '%'			   //등재번호
      //ls_ItemNo    = TRIM(dw_head.object.c_item_no  [1]) + '%'			//품목코드
      ls_ItemNm      = TRIM(tab_1.tabpage_3.dw_head3.object.c_item_name[1]) + '%'			//품목명
      ls_Gwa         = TRIM(tab_1.tabpage_3.dw_head3.object.c_dept_code[1]) + '%'			//부서
      ls_DateFr      = tab_1.tabpage_3.dw_head3.object.c_date_f[1]								//실사일자(From)
      ls_DateTo      = tab_1.tabpage_3.dw_head3.object.c_date_t[1]								//실사일자(To)

      IF isnull(ls_IdNo) THEN
	      ls_idno = '%'
      END IF
      IF isnull(ls_ItemNm) THEN
	      ls_ItemNm = '%'
      END IF
      IF isnull(ls_Gwa) THEN
	      ls_Gwa = '%'
      END IF
       tab_1.tabpage_3.dw_print1.SetReDraw(FALSE)
       ll_Rowcount = tab_1.tabpage_3.dw_print1.Retrieve( ls_IdNo, ls_ItemNm, ls_Gwa, ls_DateFr, ls_DateTo ) 
       tab_1.tabpage_3.dw_print1.SetReDraw(TRUE)
       /////////////////////////////////////////////////////////////////////////////////////////
       //// 3. 데이타원도우에 출력조건 및 시스템일자 처리
       /////////////////////////////////////////////////////////////////////////////////////////
//       DateTime	ldt_SysDateTime
//       ldt_SysDateTime = f_sysdate()	//시스템일자
//       tab_1.tabpage_3.dw_print1.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//       tab_1.tabpage_3.dw_print1.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
       ////////////////////////////////////////////////////////////////////////////////////
       // 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
       ///////////////////////////////////////////////////////////////////////////////////////
       IF ll_Rowcount = 0 THEN
	       wf_SetMsg('해당자료가 존재하지 않습니다.')
       ELSE 
	       //wf_setmenu('P',TRUE)
	       wf_SetMsg('자료가 조회되었습니다.')
       END IF
	CASE 3
		 ls_IdNo        = TRIM(tab_1.tabpage_4.dw_head4.object.c_id_no [1])    + '%'			   //등재번호
      //ls_ItemNo    = TRIM(dw_head.object.c_item_no  [1]) + '%'			//품목코드
      ls_ItemNm      = TRIM(tab_1.tabpage_4.dw_head4.object.c_item_name[1]) + '%'			//품목명
      ls_Gwa         = TRIM(tab_1.tabpage_4.dw_head4.object.c_dept_code[1]) + '%'			//부서
      ls_DateFr      = tab_1.tabpage_4.dw_head4.object.c_date_f[1]								//실사일자(From)
      ls_DateTo      = tab_1.tabpage_4.dw_head4.object.c_date_t[1]								//실사일자(To)

      IF isnull(ls_IdNo) THEN
	      ls_idno = '%'
      END IF
      IF isnull(ls_ItemNm) THEN
	      ls_ItemNm = '%'
      END IF
      IF isnull(ls_Gwa) THEN
	      ls_Gwa = '%'
      END IF
       tab_1.tabpage_4.dw_print2.SetReDraw(FALSE)
       ll_Rowcount = tab_1.tabpage_4.dw_print2.Retrieve( ls_IdNo, ls_ItemNm, ls_Gwa, ls_DateFr, ls_DateTo ) 
       tab_1.tabpage_4.dw_print2.SetReDraw(TRUE)
       /////////////////////////////////////////////////////////////////////////////////////////
       //// 3. 데이타원도우에 출력조건 및 시스템일자 처리
       /////////////////////////////////////////////////////////////////////////////////////////
//       ldt_SysDateTime = f_sysdate()	//시스템일자
//       tab_1.tabpage_4.dw_print2.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//       tab_1.tabpage_4.dw_print2.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
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

Int    li_tab, ll_cnt
String ls_cust_no, ls_idno, ls_describe

li_tab = tab_1.selectedtab

CHOOSE CASE li_tab
		
	CASE 1
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

      ls_NotNullCol[1] = 'id_no/등재번호'
//      ls_NotNullCol[2] = 'item_class/품목구분'
		ls_NotNullCol[3] = 'inve_date/실사일자'
		ls_NotNullCol[4] = 'item_no/품목코드'
		ls_NotNullCol[4] = 'gwa/사용부서'
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
		String	ls_JOB_UID			//등록자
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
			ls_idno = tab_1.tabpage_1.dw_main.object.id_no[ll_Row]

			ls_describe = tab_1.tabpage_1.dw_main.Describe("evaluate('if(isRowNew(),1,0)',"+string(ll_Row)+")")
			if ls_describe = '1' then		//자료올리기 후 추가된 자료...
				
				SELECT count(*)
				INTO 	 :ll_cnt
				FROM   STDB.HST033H  
				WHERE  ID_NO = :ls_idno   ;
	
				if ll_cnt > 0 then
					messagebox('이미 재물조사된 자료입니다',  ' 올리기 한 자료를 삭제하십시요.~r~n~r~n'+&
									'자산번호 :' +ls_idno)
					return -1
				end if
			end if
			
			
			////////////////////////////////////////////////////////////////////////////////////
			// 3.1 수정항목 처리
			////////////////////////////////////////////////////////////////////////////////////
			tab_1.tabpage_1.dw_main.Object.Worker   [ll_Row] =ls_Worker   	//등록자                                                                                                                                     
			tab_1.tabpage_1.dw_main.Object.IpAddr   [ll_Row] =ls_IpAddr   	//등록단말기                                                                                                                                 
			tab_1.tabpage_1.dw_main.Object.Work_Date[ll_Row] =ldt_WorkDate	//등록일자                                                                                                                                    
			tab_1.tabpage_1.dw_main.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
			tab_1.tabpage_1.dw_main.Object.job_add [ll_Row]  =ls_JOB_ADD	//작업단말기
			tab_1.tabpage_1.dw_main.Object.job_date[ll_Row]  =ldt_JOB_Date	//작업일자
		
			ll_Row = tab_1.tabpage_1.dw_main.GetNextModified(ll_Row,primary!)
		LOOP

		///////////////////////////////////////////////////////////////////////////////////////
		// 5. 자료저장처리
		///////////////////////////////////////////////////////////////////////////////////////
//		IF NOT tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_save() THEN RETURN -1
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
		f_childretrieven(tab_1.tabpage_4.dw_head4,"c_dept_code")	                     // 사용 부서 
		triggerevent('ue_retrieve')

		///////////////////////////////////////////////////////////////////////////////////////
		// 6. 메세지 처리, 고정버튼 활성화/비활성화 처리
		///////////////////////////////////////////////////////////////////////////////////////
		wf_SetMsg('자료가 저장되었습니다.')
		//wf_setmenu('I',FALSE)
		//wf_setmenu('D',TRUE)
		//wf_setmenu('S',TRUE)
		//wf_setmenu('R',TRUE)
		tab_1.tabpage_1.dw_main.SetFocus()
END CHOOSE
//		tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
//		tab_1.tabpage_2.dw_print.Retrieve(ls_fr_date, ls_to_date)
//		tab_1.tabpage_2.dw_print.SetReDraw(TRUE)
//
//		RETURN 1
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
long ll_row , ll_tab
ll_tab = tab_1.selectedtab

CHOOSE CASE ll_tab
		CASE 1
//         IF tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
			   ll_GetRow = tab_1.tabpage_1.dw_main.GetRow()
//	      IF NOT tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
//			   ll_GetRow = tab_1.tabpage_1.dw_main.GetSelectedRow(0)
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
//			ll_DeleteCnt = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_delete(ls_Msg)
			
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
			
	
			IF ll_DeleteCnt > 0 THEN
			wf_SetMsg('자료가 삭제되었습니다.')
			  IF tab_1.tabpage_1.dw_main.rowcount() > 0 THEN
				  //wf_setmenu('R',FALSE)
				  //wf_setmenu('I',TRUE)
				  //wf_setmenu('D',TRUE)
				  //wf_setmenu('S',TRUE)
			  ELSE
				  //wf_setmenu('R',FALSE)
				  //wf_setmenu('I',TRUE)
				  //wf_setmenu('D',FALSE)
				  //wf_setmenu('S',TRUE)
			  END IF
         END IF
END CHOOSE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;//integer ii_tab
//ii_tab = tab_1.selectedtab
//
//CHOOSE CASE ii_tab
//		
//	CASE 2
//		f_print(tab_1.tabpage_3.dw_print1)
//	CASE 3
//		f_print(tab_1.tabpage_4.dw_print2)
//END CHOOSE
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
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

event ue_button_set;call super::ue_button_set;tab_1.tabpage_1.cb_3.x = tab_1.tabpage_1.gb_2.x - 16 - tab_1.tabpage_1.cb_3.width

tab_1.tabpage_1.cb_1.x = tab_1.tabpage_1.gb_4.x + tab_1.tabpage_1.gb_4.width - 16 - tab_1.tabpage_1.cb_1.width
tab_1.tabpage_1.cb_2.x = tab_1.tabpage_1.cb_1.x  - 16 - tab_1.tabpage_1.cb_2.width

end event

type ln_templeft from w_msheet`ln_templeft within w_hst303i
end type

type ln_tempright from w_msheet`ln_tempright within w_hst303i
end type

type ln_temptop from w_msheet`ln_temptop within w_hst303i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst303i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst303i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst303i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst303i
end type

type uc_insert from w_msheet`uc_insert within w_hst303i
end type

type uc_delete from w_msheet`uc_delete within w_hst303i
end type

type uc_save from w_msheet`uc_save within w_hst303i
end type

type uc_excel from w_msheet`uc_excel within w_hst303i
end type

type uc_print from w_msheet`uc_print within w_hst303i
end type

type st_line1 from w_msheet`st_line1 within w_hst303i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hst303i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hst303i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst303i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst303i
end type

type tab_1 from tab within w_hst303i
integer x = 50
integer y = 156
integer width = 4384
integer height = 2136
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
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;

CHOOSE CASE newindex
		
	CASE 1, 2
		idw_print = tab_1.tabpage_3.dw_print1
	CASE 3
		idw_print = tab_1.tabpage_4.dw_print2
END CHOOSE
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2016
string text = "재물조사 결과"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
dw_head2 dw_head2
rb_2 rb_2
rb_1 rb_1
gb_2 gb_2
dw_head dw_head
gb_1 gb_1
gb_4 gb_4
dw_fileimport dw_fileimport
dw_list dw_list
dw_main dw_main
gb_3 gb_3
end type

on tabpage_1.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.dw_head2=create dw_head2
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_2=create gb_2
this.dw_head=create dw_head
this.gb_1=create gb_1
this.gb_4=create gb_4
this.dw_fileimport=create dw_fileimport
this.dw_list=create dw_list
this.dw_main=create dw_main
this.gb_3=create gb_3
this.Control[]={this.cb_2,&
this.cb_1,&
this.cb_3,&
this.dw_head2,&
this.rb_2,&
this.rb_1,&
this.gb_2,&
this.dw_head,&
this.gb_1,&
this.gb_4,&
this.dw_fileimport,&
this.dw_list,&
this.dw_main,&
this.gb_3}
end on

on tabpage_1.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.dw_head2)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_2)
destroy(this.dw_head)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.dw_fileimport)
destroy(this.dw_list)
destroy(this.dw_main)
destroy(this.gb_3)
end on

type cb_2 from uo_imgbtn within tabpage_1
integer x = 3698
integer y = 1308
integer taborder = 60
string btnname = "자료올리기"
end type

event clicked;call super::clicked;long i, ll_row, ll_DeleteCnt, ll_cnt
long	ll_DeleteRow[]
string ls_idno

Datawindow  idw_name, idw_list

idw_list = tab_1.tabpage_1.dw_list
i = idw_list.getrow()


if i = 0 then
	wf_setMsg("먼저 자료를 선택하여 주십시요..")
	return
else
	idw_name = tab_1.tabpage_1.dw_main
	
	DO WHILE i <> 0
				

				ls_idno = idw_list.object.id_no[i]
				
				SELECT count(*)
    			INTO 	 :ll_cnt
    			FROM   STDB.HST033H  
   			WHERE  ID_NO = :ls_idno   ;

				if ll_cnt > 0 then
					messagebox('이미 재물조사 내역에 등록된 자료입니다', ' 자산번호를 확인하십시요.~r~n~r~n '+& 
								  '자산번호 :' +ls_idno)
				else
					ll_row = idw_name.insertrow(0)
	
					idw_name.SetRow(ll_row)
					idw_name.ScrollToRow(ll_row)
					idw_name.SetFocus()
//					idw_name.SelectRow(0,FALSE)
//					idw_name.SelectRow(ll_row,TRUE)
					
					idw_name.object.id_no[ll_row] 		 = idw_list.object.id_no[i]         //등재번호
					idw_name.object.inve_date[ll_row] 	 = f_today()			           	   //실사일자
					idw_name.object.item_no[ll_row] 		 = idw_list.object.item_no[i]       //품목번호
					idw_name.object.item_name[ll_row] 	 = idw_list.object.item_name[i]     //품목명
					idw_name.object.item_class[ll_row] 	 = idw_list.object.item_class[i]    //품목구분
					idw_name.object.gwa[ll_row] 	       = idw_list.object.gwa[i]           //사용부서
					idw_name.object.boyu_qty[ll_row] 	 = idw_list.object.purchase_qty[i]  //등재 수량
					idw_name.object.room_code[ll_row] 	 = idw_list.object.room_code[i]     //사용장소
					idw_name.object.work_gbn[ll_row] 	 = '0'     									//작업구분
	
					ll_DeleteCnt++
					ll_DeleteRow[ll_DeleteCnt] = i
				end if
			
				i = idw_list.getrow()

   LOOP
END IF


Long	ll_idx
FOR ll_idx = UpperBound(ll_DeleteRow) TO 1 STEP -1
	idw_list.DeleteRow(ll_DeleteRow[ll_idx])
NEXT

//wf_setmenu('s',true)
//wf_setmenu('d',true)
end event

on cb_2.destroy
call uo_imgbtn::destroy
end on

type cb_1 from uo_imgbtn within tabpage_1
integer x = 4009
integer y = 1308
integer taborder = 70
string btnname = "자료조회"
end type

event clicked;call super::clicked;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_db_retrieve
////	기 능 설 명: 자료조회 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////////
 datawindow dw_name
int li_item_class
string ls_id_no, ls_item_code, ls_item_name, ls_dept_code, ls_room_code, ls_item_class, ls_revenue_opt, ls_oper_opt
          
dw_name = tab_1.tabpage_1.dw_head2

dw_name.accepttext()
		
ls_id_no = trim(dw_name.object.c_id_no[1]) + '%'                       // 등재 번호
ls_item_code = trim(dw_name.object.c_item_code[1]) + '%'               // 품목 코드 
ls_item_name = trim(dw_name.object.c_item_name[1]) + '%'               // 품목명 
ls_dept_code = trim(dw_name.object.c_dept_code[1]) + '%'               // 부서 코드 
ls_room_code = trim(dw_name.object.c_room_code[1]) + '%'               // 사용 장소 
ls_item_class = string(dw_name.object.c_item_class[1]) + '%'          // 물품 구분 
ls_revenue_opt = string(dw_name.object.c_revenue_opt[1]) + '%'        // 구입 재원 
ls_oper_opt = string(dw_name.object.c_oper_opt[1]) + '%'              // 운용 구분 

IF ISNULL(ls_id_no) THEN ls_id_no = '%'
IF ISNULL(ls_item_code) THEN ls_item_code = '%'
IF ISNULL(ls_item_name) THEN ls_item_name = '%'
IF ISNULL(ls_dept_code) THEN ls_dept_code = '%'
IF ISNULL(ls_room_code) THEN ls_room_code = '%'
IF ISNULL(ls_item_class) THEN ls_item_class = '%'
IF ISNULL(ls_revenue_opt) THEN ls_revenue_opt = '%'
IF ISNULL(ls_oper_opt) THEN ls_oper_opt = '%'
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료조회
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
IF tab_1.tabpage_1.dw_list.retrieve( ls_id_no, ls_item_code, ls_item_name, ls_dept_code, ls_room_code, ls_item_class, ls_revenue_opt, ls_oper_opt ) = 0 THEN
	wf_setMsg("조회된 데이타가 없습니다")	
ELSE
	//wf_setmenu('S',TRUE)
   wf_SetMsg('자료가 조회되었습니다.')
END IF	 
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////


end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type cb_3 from uo_imgbtn within tabpage_1
integer x = 3465
integer y = 128
integer taborder = 60
string btnname = "화일 찾기"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: buttonclikced::dw_update1
//	기 능 설 명: 건물정보 이미지처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
tab_1.tabpage_1.dw_fileimport.reset()

Long ll_count, idx, ll_silsa_gty, ll_foundrow, ll_RowCnt 
String  ls_gwa, ls_idno, ls_id_no
Datawindow  dw_name, dw_sname
dw_sname = tab_1.tabpage_1.dw_main
ll_RowCnt= dw_sname.rowcount()
IF ll_RowCnt = 0 THEN
	messagebox('확인','재물조사내역이 존재 하지 않습니다..!')
	RETURN
END IF
/////////////////////////////////////////////////////////////////////////////////
// 2.데이터 불러 오기
/////////////////////////////////////////////////////////////////////////////////
	Integer	li_Rtn,li_Rtn2
	String	ls_FullName
	String	ls_FileName
	li_Rtn = GetFileOpenName("", + ls_FullName,&
									ls_FileName, "txt",&
									"txt Files (*.txt),*.txt," + &
									"ALL Files (*.*), *.*")

	integer li_FileNum
	li_Rtn2 = tab_1.tabpage_1.dw_fileimport.ImportFile(ls_FullName)
	IF li_Rtn2 = -8 THEN
		messagebox('확인','파일명을 txt형태로 바꿔어 주시기 바랍니다..!')
		RETURN
	END IF

////////////////////////////////////////////////////////////////////////////////////////////
////3.데이터 저장
////////////////////////////////////////////////////////////////////////////////////////////

dw_name  = tab_1.tabpage_1.dw_fileimport
dw_sname = tab_1.tabpage_1.dw_main

ll_count = dw_name.rowcount()
ll_RowCnt= dw_sname.rowcount()
FOR idx = 1 TO ll_count
	 ls_idno = trim(left(dw_name.object.a1[idx],11))
	 ll_foundrow = dw_sname.find("id_no = '" + ls_idno + "'",1,ll_RowCnt)
	 IF ll_foundrow > 0 THEN
		 dw_sname.object.silsa_gty[ll_foundrow] = dw_sname.object.silsa_gty[ll_foundrow] + 1
	 END IF
NEXT

////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cb_3.destroy
call uo_imgbtn::destroy
end on

type dw_head2 from datawindow within tabpage_1
event ue_keydown pbm_dwnkey
integer x = 50
integer y = 1252
integer width = 3694
integer height = 200
integer taborder = 50
string title = "none"
string dataobject = "d_hst303i_b"
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

				this.object.c_item_code[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
   ELSE
       TRIGGER EVENT ue_retrieve()
	END IF
END IF
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

				this.object.c_item_code[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
   ELSE
       TRIGGER EVENT ue_retrieve()
	END IF
end event

type rb_2 from radiobutton within tabpage_1
integer x = 3845
integer y = 108
integer width = 352
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "전체선택"
end type

event clicked;long ll_rowcount, idx, ll_tab
String	li_Chk

DataWindow   idw_name
ll_tab = tab_1.selectedtab

CHOOSE CASE ll_tab
		
	CASE 1
     
	  idw_name = tab_1.tabpage_1.dw_main
	  
	  idw_name.accepttext()	  
  
	  ll_rowcount = idw_name.rowcount()
	  
	  IF ll_rowcount <> 0 THEN
	  
	  		FOR idx = 1 TO ll_rowcount
				li_Chk = idw_name.object.work_gbn[idx] 
	 
				IF li_Chk = '0' THEN
					idw_name.Object.work_gbn[idx] = '1'
				END IF
	     NEXT
		  
	 END IF
	 
END CHOOSE

end event

type rb_1 from radiobutton within tabpage_1
integer x = 3845
integer y = 188
integer width = 352
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "선택취소"
end type

event clicked;long ll_rowcount, ll_tab, ll_Row
string	li_Chk

Datawindow  idw_name
ll_tab = tab_1.selectedtab

CHOOSE CASE ll_tab
		
	CASE 1
     
	  idw_name = tab_1.tabpage_1.dw_main

	  idw_name.accepttext()	  

	  ll_rowcount = idw_name.rowcount()

	  IF ll_rowcount <> 0 THEN

	     FOR ll_Row = 1 TO ll_rowcount

            li_Chk = idw_name.object.work_gbn[ll_Row]        
				
				IF li_Chk = '1' THEN
					idw_name.Object.work_gbn[ll_Row] = '0'
				END IF
	     NEXT

	  END IF

END CHOOSE
end event

type gb_2 from groupbox within tabpage_1
integer x = 3781
integer y = 48
integer width = 535
integer height = 224
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "선택"
end type

type dw_head from datawindow within tabpage_1
event ue_keydown pbm_dwnkey
integer x = 50
integer y = 80
integer width = 2935
integer height = 200
integer taborder = 20
string title = "none"
string dataobject = "d_hst303i_a"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;String	ls_room_name
s_uid_uname	ls_middle

THIS.AcceptText()

IF key = KeyEnter! THEN 
	IF THIS.GetColumnName() = 'c_item_name' THEN		// 품목명
	   ls_middle.uname = this.object.c_item_name[1]
	   ls_middle.uid = "c_item_name"
	   openwithparm(w_hgm001h,ls_middle)
		
		IF message.stringparm <> '' THEN

//		  this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
		  this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
	   END IF	

	END IF
END IF
end event

event dberror;return 1
end event

event doubleclicked;String	ls_room_name
s_uid_uname	ls_middle

THIS.AcceptText()

	IF dwo.name = 'c_item_name' THEN		// 품목명
	   ls_middle.uname = this.object.c_item_name[1]
	   ls_middle.uid = "c_item_name"
	   openwithparm(w_hgm001h,ls_middle)
		
		IF message.stringparm <> '' THEN

//		  this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
		  this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
	   END IF	

	END IF

end event

type gb_1 from groupbox within tabpage_1
integer x = 18
integer y = 12
integer width = 4325
integer height = 292
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "재물조사 조회조건"
end type

type gb_4 from groupbox within tabpage_1
integer x = 18
integer y = 1192
integer width = 4325
integer height = 292
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "자산등재 조회조건"
end type

type dw_fileimport from cuo_dwwindow_one_hin within tabpage_1
boolean visible = false
integer x = 1166
integer y = 644
integer width = 1385
integer height = 476
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hst303i_f"
end type

type dw_list from uo_dwgrid within tabpage_1
integer x = 9
integer y = 1492
integer width = 4334
integer height = 520
integer taborder = 70
boolean titlebar = true
string title = "자산등재 내역"
string dataobject = "d_hst303i_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event doubleclicked;call super::doubleclicked;//int li_row
//
//IF row = 0 THEN RETURN
//Datawindow  idw_name
//idw_name = tab_1.tabpage_1.dw_main
//
//li_row = idw_name.insertrow(0)
//
//idw_name.object.id_no[li_row] 		 = this.object.id_no[row]         //등재번호
//idw_name.object.inve_date[li_row] 	 = mid(f_today(),1,8)             //실사일자
//idw_name.object.item_no[li_row] 		 = this.object.item_no[row]       //품목번호
//idw_name.object.item_name[li_row] 	 = this.object.item_name[row]     //품목명
//idw_name.object.item_class[li_row] 	 = this.object.item_class[row]    //품목구분
//idw_name.object.gwa[li_row] 	       = this.object.gwa[row]           //부서
//idw_name.object.boyu_qty[li_row] 	 = this.object.purchase_qty[row]  //등재 수량
//idw_name.object.room_code[li_row] 	 = this.object.room_code[row]     //사용장소
//
////wf_setmenu('s',true)
////wf_setmenu('d',true)
end event

type dw_main from uo_dwgrid within tabpage_1
integer x = 46
integer y = 368
integer width = 4265
integer height = 780
integer taborder = 40
boolean enabled = false
string dataobject = "d_hst303i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event dberror;call super::dberror;IF sqldbcode = 1 THEN
	messagebox("확인",'중복된 값이 있습니다.')
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_3 from groupbox within tabpage_1
integer x = 18
integer y = 308
integer width = 4320
integer height = 864
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "재물조사 내역"
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2016
string text = "재물조사결과표"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print1 dw_print1
dw_head3 dw_head3
gb_5 gb_5
end type

on tabpage_3.create
this.dw_print1=create dw_print1
this.dw_head3=create dw_head3
this.gb_5=create gb_5
this.Control[]={this.dw_print1,&
this.dw_head3,&
this.gb_5}
end on

on tabpage_3.destroy
destroy(this.dw_print1)
destroy(this.dw_head3)
destroy(this.gb_5)
end on

type dw_print1 from datawindow within tabpage_3
integer x = 18
integer y = 308
integer width = 4325
integer height = 1700
integer taborder = 50
string title = "none"
string dataobject = "d_hst303i_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_head3 from datawindow within tabpage_3
event ue_keydown pbm_dwnkey
integer x = 105
integer y = 84
integer width = 3269
integer height = 184
integer taborder = 30
string title = "none"
string dataobject = "d_hst303i_a"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;String	ls_room_name
s_uid_uname	ls_middle

THIS.AcceptText()

IF key = KeyEnter! THEN 
	IF THIS.GetColumnName() = 'c_item_name' THEN		// 품목명
	   ls_middle.uname = this.object.c_item_name[1]
	   ls_middle.uid = "c_item_name"
	   openwithparm(w_hgm001h,ls_middle)
		
		IF message.stringparm <> '' THEN

//		  this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
		  this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
	   END IF	

	END IF
END IF
end event

event dberror;return 1
end event

event doubleclicked;String	ls_room_name
s_uid_uname	ls_middle

THIS.AcceptText()

	IF dwo.name = 'c_item_name' THEN		// 품목명
	   ls_middle.uname = this.object.c_item_name[1]
	   ls_middle.uid = "c_item_name"
	   openwithparm(w_hgm001h,ls_middle)
		
		IF message.stringparm <> '' THEN

//		  this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
		  this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
	   END IF	

	END IF

end event

type gb_5 from groupbox within tabpage_3
integer x = 18
integer y = 20
integer width = 4325
integer height = 284
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

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 2016
string text = "재물조사 누락 물품내역"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_head4 dw_head4
gb_6 gb_6
dw_print2 dw_print2
end type

on tabpage_4.create
this.dw_head4=create dw_head4
this.gb_6=create gb_6
this.dw_print2=create dw_print2
this.Control[]={this.dw_head4,&
this.gb_6,&
this.dw_print2}
end on

on tabpage_4.destroy
destroy(this.dw_head4)
destroy(this.gb_6)
destroy(this.dw_print2)
end on

type dw_head4 from datawindow within tabpage_4
event ue_keydown pbm_dwnkey
integer x = 105
integer y = 88
integer width = 3387
integer height = 212
integer taborder = 40
string title = "none"
string dataobject = "d_hst303i_c"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;String	ls_room_name
s_uid_uname	ls_middle

THIS.AcceptText()

IF key = KeyEnter! THEN 
	IF THIS.GetColumnName() = 'c_item_name' THEN		// 품목명
	   ls_middle.uname = this.object.c_item_name[1]
	   ls_middle.uid = "c_item_name"
	   openwithparm(w_hgm001h,ls_middle)
		
		IF message.stringparm <> '' THEN

//		  this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
		  this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
	   END IF	

	END IF
END IF
end event

event dberror;return 1
end event

event doubleclicked;String	ls_room_name
s_uid_uname	ls_middle

THIS.AcceptText()

	IF dwo.name = 'c_item_name' THEN		// 품목명
	   ls_middle.uname = this.object.c_item_name[1]
	   ls_middle.uid = "c_item_name"
	   openwithparm(w_hgm001h,ls_middle)
		
		IF message.stringparm <> '' THEN

//		  this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
		  this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
	   END IF	

	END IF

end event

type gb_6 from groupbox within tabpage_4
integer x = 18
integer y = 12
integer width = 4320
integer height = 312
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

type dw_print2 from datawindow within tabpage_4
integer x = 18
integer y = 332
integer width = 4320
integer height = 1676
integer taborder = 40
string title = "none"
string dataobject = "d_hst303i_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type uo_1 from u_tab within w_hst303i
event destroy ( )
integer x = 1614
integer y = 124
integer height = 148
integer taborder = 50
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

