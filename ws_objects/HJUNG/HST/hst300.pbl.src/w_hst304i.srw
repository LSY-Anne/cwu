$PBExportHeader$w_hst304i.srw
$PBExportComments$재물조사결과 정리
forward
global type w_hst304i from w_msheet
end type
type tab_1 from tab within w_hst304i
end type
type tabpage_1 from userobject within tab_1
end type
type dw_main from cuo_dwwindow_one_hin within tabpage_1
end type
type dw_head from datawindow within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_main dw_main
dw_head dw_head
gb_1 gb_1
gb_3 gb_3
end type
type tab_1 from tab within w_hst304i
tabpage_1 tabpage_1
end type
end forward

global type w_hst304i from w_msheet
integer height = 2616
tab_1 tab_1
end type
global w_hst304i w_hst304i

on w_hst304i.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_hst304i.destroy
call super::destroy
destroy(this.tab_1)
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

//tab_1.tabpage_1.dw_head2.reset()
//tab_1.tabpage_1.dw_head2.insertrow(0)
//
//f_childretrieven(tab_1.tabpage_1.dw_head2,"c_dept_code")	                          // 부 서 
//f_childretrieven(tab_1.tabpage_1.dw_head2,"c_room_code")	                          // 사용 장소 
//f_childretrieve(tab_1.tabpage_1.dw_head2,"c_item_class","item_class")              // 물품구분 
//f_childretrieve(tab_1.tabpage_1.dw_head2,"c_revenue_opt","asset_opt")              // 구입 재원
//f_childretrieve(tab_1.tabpage_1.dw_head2,"c_oper_opt","oper_opt")                  //운용방법
//
//f_childretrieve(tab_1.tabpage_1.dw_list,"item_class","item_class")              // 물품구분 
//
//tab_1.tabpage_3.dw_head3.Reset()
//tab_1.tabpage_3.dw_head3.InsertRow(0)
//f_childretrieven(tab_1.tabpage_3.dw_head3,"c_dept_code")	                     // 사용 부서
//tab_1.tabpage_3.dw_head3.object.c_date_f[1] = Left(f_today(),6) + '01'
//tab_1.tabpage_3.dw_head3.object.c_date_t[1] = f_today()
//
//f_childretrieve(tab_1.tabpage_3.dw_print1,"hst033h_item_class","item_class")	         //물품구분    
//f_childretrieve(tab_1.tabpage_3.dw_print1,"hst033h_inve_status","inve_status")	         // 자산 상태
//f_childretrieve(tab_1.tabpage_3.dw_print1,"hst033h_inve_detail","inve_detail")	         // 실사 결과 
//
//tab_1.tabpage_4.dw_head4.Reset()
//tab_1.tabpage_4.dw_head4.InsertRow(0)
//f_childretrieven(tab_1.tabpage_4.dw_head4,"c_dept_code")	                     // 사용 부서
//tab_1.tabpage_4.dw_head4.object.c_date_f[1] = Left(f_today(),6) + '01'
//tab_1.tabpage_4.dw_head4.object.c_date_t[1] = f_today()
//
//f_childretrieve(tab_1.tabpage_4.dw_print2,"hst033h_item_class","item_class")	         //물품구분    
//
//tab_1.tabpage_3.dw_print1.Object.DataWindow.zoom = 100
//tab_1.tabpage_3.dw_print1.Object.DataWindow.Print.Preview = 'YES'
//
//tab_1.tabpage_4.dw_print2.Object.DataWindow.zoom = 100
//tab_1.tabpage_4.dw_print2.Object.DataWindow.Print.Preview = 'YES'
//
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
		
//	CASE 2
//       tab_1.tabpage_3.dw_print1.SetReDraw(FALSE)
//       ll_Rowcount = tab_1.tabpage_3.dw_print1.Retrieve( ls_IdNo, ls_ItemNm, ls_Gwa, ls_DateFr, ls_DateTo ) 
//       tab_1.tabpage_3.dw_print1.SetReDraw(TRUE)
//       /////////////////////////////////////////////////////////////////////////////////////////
//       //// 3. 데이타원도우에 출력조건 및 시스템일자 처리
//       /////////////////////////////////////////////////////////////////////////////////////////
//       DateTime	ldt_SysDateTime
//       ldt_SysDateTime = f_sysdate()	//시스템일자
//       tab_1.tabpage_3.dw_print1.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//       tab_1.tabpage_3.dw_print1.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
//       ////////////////////////////////////////////////////////////////////////////////////
//       // 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
//       ///////////////////////////////////////////////////////////////////////////////////////
//       IF ll_Rowcount = 0 THEN
//	       wf_SetMsg('해당자료가 존재하지 않습니다.')
//       ELSE 
//	       //wf_setmenu('P',TRUE)
//	       wf_SetMsg('자료가 조회되었습니다.')
//       END IF
//	CASE 3
//       tab_1.tabpage_4.dw_print2.SetReDraw(FALSE)
//       ll_Rowcount = tab_1.tabpage_4.dw_print2.Retrieve( ls_IdNo, ls_ItemNm, ls_Gwa, ls_DateFr, ls_DateTo ) 
//       tab_1.tabpage_4.dw_print2.SetReDraw(TRUE)
//       /////////////////////////////////////////////////////////////////////////////////////////
//       //// 3. 데이타원도우에 출력조건 및 시스템일자 처리
//       /////////////////////////////////////////////////////////////////////////////////////////
//       ldt_SysDateTime = f_sysdate()	//시스템일자
//       tab_1.tabpage_4.dw_print2.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//       tab_1.tabpage_4.dw_print2.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
//       ////////////////////////////////////////////////////////////////////////////////////
//       // 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
//       ///////////////////////////////////////////////////////////////////////////////////////
//       IF ll_Rowcount = 0 THEN
//	       wf_SetMsg('해당자료가 존재하지 않습니다.')
//       ELSE 
//	       //wf_setmenu('P',TRUE)
//	       wf_SetMsg('자료가 조회되었습니다.')
//       END IF
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
// 1. 자산등재 테이블에 저장
///////////////////////////////////////////////////////////////////////////////////////
string ls_id_no, ls_silsa_gty
long  ll_RowCount, idx, ll_item_class
ll_RowCount = tab_1.tabpage_1.dw_main.RowCount()
IF  ll_RowCount = 0 THEN
    messagebox('확인','UPDATE할 자료가 존재 하지 않습니다..!')
	 RETURN -1
ELSE
   FOR idx = 1  TO  ll_RowCount
    ls_id_no        = tab_1.tabpage_1.dw_main.object.id_no[tab_1.tabpage_1.dw_main.getrow()]
    ll_item_class   = tab_1.tabpage_1.dw_main.object.item_class[tab_1.tabpage_1.dw_main.getrow()]
    ls_silsa_gty    = tab_1.tabpage_1.dw_main.object.silsa_gty[tab_1.tabpage_1.dw_main.getrow()]
    
	 
	  messagebox('확인','확정됀 사항이 아닙니다..!')
	  RETURN -1
       update  stdb.hst027m
       set     purchase_qty = :ls_silsa_gty
       where  id_no       = :ls_id_no
		 and    item_class  = :ll_item_class;
		 
		 IF  SQLCA.SQLCODE <>	0		THEN
		     wf_setmsg("저장중 오류가 발생하였습니다")
			  ROLLBACK;
			RETURN	 -1						
		 END IF
	NEXT
END IF 
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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
//long ll_row , ll_tab
//ll_tab = tab_1.selectedtab
//
//CHOOSE CASE ll_tab
//		CASE 1
//         IF tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
//			   ll_GetRow = tab_1.tabpage_1.dw_main.GetRow()
//	      IF NOT tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
//			   ll_GetRow = tab_1.tabpage_1.dw_main.GetSelectedRow(0)
//         IF ll_GetRow = 0 THEN RETURN
//
//			///////////////////////////////////////////////////////////////////////////////////////
//			// 2. 삭제메세지 처리.
//			//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
//			///////////////////////////////////////////////////////////////////////////////////////
//			String	ls_Msg
//			Long		ll_DeleteCnt
//			///////////////////////////////////////////////////////////////////////////////////////
//			// 3. 삭제처리.
//			///////////////////////////////////////////////////////////////////////////////////////
//			ll_DeleteCnt = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_delete(ls_Msg)
//	
//			IF ll_DeleteCnt > 0 THEN
//			wf_SetMsg('자료가 삭제되었습니다.')
//			  IF tab_1.tabpage_1.dw_main.rowcount() > 0 THEN
//				  //wf_setmenu('R',FALSE)
//				  //wf_setmenu('I',TRUE)
//				  //wf_setmenu('D',TRUE)
//				  //wf_setmenu('S',TRUE)
//			  ELSE
//				  //wf_setmenu('R',FALSE)
//				  //wf_setmenu('I',TRUE)
//				  //wf_setmenu('D',FALSE)
//				  //wf_setmenu('S',TRUE)
//			  END IF
//         END IF
//END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

type tab_1 from tab within w_hst304i
integer x = 23
integer y = 20
integer width = 3831
integer height = 2472
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 80269524
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3794
integer height = 2356
long backcolor = 80269524
string text = "재물조사 결과"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_main dw_main
dw_head dw_head
gb_1 gb_1
gb_3 gb_3
end type

on tabpage_1.create
this.dw_main=create dw_main
this.dw_head=create dw_head
this.gb_1=create gb_1
this.gb_3=create gb_3
this.Control[]={this.dw_main,&
this.dw_head,&
this.gb_1,&
this.gb_3}
end on

on tabpage_1.destroy
destroy(this.dw_main)
destroy(this.dw_head)
destroy(this.gb_1)
destroy(this.gb_3)
end on

type dw_main from cuo_dwwindow_one_hin within tabpage_1
event key_enter pbm_dwnprocessenter
integer x = 55
integer y = 372
integer width = 3685
integer height = 1932
integer taborder = 30
string dataobject = "d_hst303i_1"
boolean ib_rowselect = true
end type

event dberror;call super::dberror;IF sqldbcode = 1 THEN
	messagebox("확인",'중복된 값이 있습니다.')
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

type dw_head from datawindow within tabpage_1
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

event dberror;return 1
end event

type gb_1 from groupbox within tabpage_1
integer x = 18
integer y = 12
integer width = 3762
integer height = 292
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "재물조사 조회조건"
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within tabpage_1
integer x = 18
integer y = 308
integer width = 3762
integer height = 2028
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 67108864
string text = "재물조사 내역 정리"
borderstyle borderstyle = stylelowered!
end type

