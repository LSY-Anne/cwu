$PBExportHeader$w_hgm404i.srw
$PBExportComments$비품수리신청발주
forward
global type w_hgm404i from w_tabsheet
end type
type rb_j from radiobutton within tabpage_sheet01
end type
type rb_k from radiobutton within tabpage_sheet01
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type dw_search from datawindow within tabpage_sheet01
end type
type st_2 from statictext within tabpage_sheet01
end type
type dw_list from cuo_dwwindow_one_hin within tabpage_sheet01
end type
type sle_accept_num from singlelineedit within tabpage_sheet01
end type
type st_6 from statictext within tabpage_sheet01
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type gb_3 from groupbox within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print from cuo_dwwindow_one_hin within tabpage_1
end type
type sle_ord_no from singlelineedit within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print dw_print
sle_ord_no sle_ord_no
st_1 st_1
gb_4 gb_4
end type
end forward

global type w_hgm404i from w_tabsheet
string title = "물품 견적"
end type
global w_hgm404i w_hgm404i

type variables

int    ii_tab
s_insa_com	istr_com

String	is_KName		//성명
String	is_MemberNo	//개인번호

string is_IdNo			// 등재번호
string is_applydate	//신청일자
int	 ii_apply_num	//신청번호
int 	 ii_Itemclss		// 품목구분
boolean	is_ord_flag = false
end variables

forward prototypes
public subroutine wf_insert ()
public subroutine wf_retrieve (string as_flag)
end prototypes

public subroutine wf_insert ();//
//int    li_tab,li_row
//datawindow dw_name
//
//li_tab  = tab_sheet.selectedtab
//
//CHOOSE CASE li_tab
//	CASE 1
//		
//		dw_name   = tab_sheet.tabpage_sheet01.dw_update
//		
//		dw_name.reset()		
//		dw_name.insertrow(0)
//		
//		dw_name.object.worker[1] = gstru_uid_uname.uid      // 작업자 
//		dw_name.object.work_date[1] = f_sysdate()           // 오늘 일자 
//		
//		dw_name.setfocus()
//
//END CHOOSE
//
end subroutine

public subroutine wf_retrieve (string as_flag);//
//int li_tab, li_ord_class
//string ls_item_middle, ls_midd_name, ls_cust_no, ls_cust_name, ls_large_code
//string ls_main_item, ls_req_no, ls_accept_num
////f_setpointer('START')
//
//li_tab = tab_sheet.selectedtab
//
//CHOOSE CASE li_tab
//		
//	CASE 1      
//
//      IF as_flag = 'I' OR as_flag = 'A' THEN    
//			 
//		   ls_item_middle = trim(tab_sheet.tabpage_sheet01.sle_item_middle.text)
//			if isnull(ls_item_middle) then
//				ls_item_middle = '%'
//			Else
//				ls_item_middle = ls_item_middle + '%'
//			End if
//			ls_midd_name = trim(tab_sheet.tabpage_sheet01.sle_midd_name.text)
//			if isnull(ls_midd_name) then
//				ls_midd_name = '%'
//			Else
//				ls_midd_name = ls_midd_name + '%'
//			End if
//			
//			ls_accept_num = trim(tab_sheet.tabpage_sheet01.sle_accept_num.text)
//			if isnull(ls_accept_num) then
//				ls_accept_num = '%'
//			Else
//				ls_accept_num = ls_accept_num + '%'
//			End if
//			
//			IF tab_sheet.tabpage_sheet01.rb_j.checked THEN
//            li_ord_class = 3                         // '통제' 선택시  
//			ELSE
//				li_ord_class = 4                         // '견적' 선택시  
//			END IF	
//				tab_sheet.tabpage_sheet01.dw_print.reset()
//		   IF tab_sheet.tabpage_sheet01.dw_list1.retrieve( ls_item_middle, ls_midd_name, ls_accept_num) = 0 THEN
//				tab_sheet.tabpage_sheet01.dw_update.reset()
//				wf_setMenu('I',FALSE)
//			   wf_setMsg("조회된 데이타가 없습니다")	
//			ELSE	
//				tab_sheet.tabpage_sheet01.dw_list1.setfocus()
//				tab_sheet.tabpage_sheet01.dw_list1.trigger event rowfocuschanged(1)				
//				wf_setMenu('I',TRUE)
//		   END IF	 		
//			
//      END IF
//
//      IF as_flag = 'C' OR as_flag = 'A' THEN    
//			
//			ls_cust_no = trim(tab_sheet.tabpage_sheet01.sle_cust_no.text) + '%'
//			ls_cust_name = trim(tab_sheet.tabpage_sheet01.sle_cust_name.text) + '%'
//			tab_sheet.tabpage_sheet01.dw_large_code.accepttext()
// 			ls_large_code = trim(tab_sheet.tabpage_sheet01.dw_large_code.object.code[tab_sheet.tabpage_sheet01.dw_large_code.getrow()]) + '%'
//			if ls_large_code = '' or isnull(ls_large_code) then 
//				ls_large_code = '%'
//			end if
//			
//			ls_main_item = trim(tab_sheet.tabpage_sheet01.sle_main_item.text) + '%'
//	      IF tab_sheet.tabpage_sheet01.dw_list2.retrieve( ls_cust_no, ls_cust_name, ls_large_code, ls_main_item ) = 0 THEN
//				tab_sheet.tabpage_sheet01.dw_update.reset()
//			   wf_setMsg("조회된 데이타가 없습니다")	
//		   END IF	  		
//
//      END IF
//		
//	CASE 2									/** 	가격대비표 	**/
//		
//		ls_req_no = tab_sheet.tabpage_1.sle_req_no2.text
//		
//		if 	ls_req_no = "" or isnull(ls_req_no)	then
//			   wf_setMsg("접수번호를 입력하세요")	
//				return
//		end if
//		
//		IF tab_sheet.tabpage_1.dw_print2.retrieve( ls_req_no ) = 0 THEN
//			tab_sheet.tabpage_1.dw_print2.reset()
//			wf_setMsg("조회된 데이타가 없습니다")	
//		END IF	  		
//		
//		
//		
//END CHOOSE		
//  
////f_setpointer('END')
//
end subroutine

on w_hgm404i.create
int iCurrent
call super::create
end on

on w_hgm404i.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked;;cb_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
///////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////


String	ls_req_num		//사용부서명
string	ls_ord_no, ls_req_no, ls_cust_no
long		ll_row_count, ll_total_amt, ll_cur_row, ll_total

string	ls_cust_name,ls_phone,ls_fax  ,ls_charge_member,ls_gwa,ls_item_name,ls_model
String	ls_purchase_qty,ls_apply_gwa,ls_devilery_date,ls_remark
Int		i
Datawindow	dw_name2


ii_tab = tab_sheet.selectedtab


CHOOSE CASE ii_tab
		
	CASE 1
		ls_req_num = TRIM(tab_sheet.tabpage_sheet01.sle_accept_num.Text)
		IF 	isNull(ls_req_num) OR LEN(ls_req_num) = 0 THEN 
				wf_SetMsg('접수번호를 입력하세요.')	
				return -1
		end if

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

tab_sheet.tabpage_sheet01.dw_update.reset()
tab_sheet.tabpage_sheet01.dw_update.insertrow(0)
Long		ll_RowCnt,ll_RowCnt2, ll_item_seq 
tab_sheet.tabpage_sheet01.dw_list.SetReDraw(false)
tab_sheet.tabpage_sheet01.dw_update.SetReDraw(false)
tab_sheet.tabpage_sheet01.dw_list.reset()
ls_req_no	=	trim(tab_sheet.tabpage_sheet01.sle_accept_num.text)
SELECT	DISTINCT trim(ORD_NO)
INTO	:ls_ord_no
FROM 	STDB.HST031H
WHERE	REQ_NO = :lS_REQ_NO;


ll_RowCnt = tab_sheet.tabpage_sheet01.dw_list.Retrieve(ls_req_num)
IF ll_RowCnt = 0 THEN
	messagebox('확인','수리견적 신청된 자료가 없습니다..!')
	RETURN -1
END IF
ls_cust_no  =  tab_sheet.tabpage_sheet01.dw_list.object.cust_no[tab_sheet.tabpage_sheet01.dw_list.getrow()]
   ll_RowCnt2 = tab_sheet.tabpage_sheet01.dw_update.Retrieve(ls_ord_no, ls_cust_no)
   ///////////////////////////////////////////////////////////////////////
   tab_sheet.tabpage_sheet01.dw_list.SetReDraw(TRUE)
   tab_sheet.tabpage_sheet01.dw_update.SetReDraw(TRUE)
   if ll_rowcnt2 < 1 then
	   is_ord_flag = false
	   tab_sheet.tabpage_sheet01.dw_update.insertrow(0)
   else
	   is_ord_flag = true
   end if	
///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('I',FALSE)
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
//	wf_SetMenu('R',TRUE)
	f_dis_msg(3,'비품수리견적 자료가 존재하지 않습니다.~r~n' + &
					'비품수리견적 신청 후 사용하시기 바랍니다.','')
ELSE
	
//	wf_SetMenu('I',TRUE)
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('R',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF

CASE	2
	
	dw_name2 = tab_sheet.tabpage_1.dw_print
	dw_name2.reset()

	ls_ord_no	=	tab_sheet.tabpage_1.sle_ord_no.text
	IF isnull(ls_ord_no) OR  ls_ord_no ='' THEN
		messagebox('확인','발주번호를 입력하시기 바랍니다..!')
	END IF
	ll_row_count = tab_sheet.tabpage_1.dw_print.retrieve(ls_ord_no)
	IF ll_row_count = 0 THEN
		wf_SetMsg('조회된 자료가없습니다..!')
//		wf_setMenu('R',TRUE)
	ELSE
		wf_SetMsg('자료가 조회되었습니다..!')
//		wf_setMenu('R',TRUE)
//		wf_setMenu('P',TRUE)
	END IF
END CHOOSE	

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_insert;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_insert
////	기 능 설 명: 자료추가 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 자료추가전 체크사항 기술
/////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 등록용 - 품목구분 DDDW초기화
/////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
//dw_update.GetChild('item_class',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('item_class',0) = 0 THEN
	wf_setmsg('공통코드[품목구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
/////////////////////////////////////////////////////////////////////////////////
// 1.2 등록용 - 요구부서 DDDW초기화
/////////////////////////////////////////////////////////////////////////////////
//dw_update.GetChild('rep_gwa',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
/////////////////////////////////////////////////////////////////////////////////
// 1.3 등록용 - 접수부서 DDDW초기화
/////////////////////////////////////////////////////////////////////////////////
//dw_update.GetChild('accept_gwa',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
/////////////////////////////////////////////////////////////////////////////////
// 1.4 등록용 - 계정과목 DDDW초기화
/////////////////////////////////////////////////////////////////////////////////
//dw_update.GetChild('acct_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('계정과목을 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
/////////////////////////////////////////////////////////////////////////////////
// 1.5 등록용 - 상태구분 DDDW초기화
/////////////////////////////////////////////////////////////////////////////////
//dw_update.GetChild('stat_class',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('ord_class',0) = 0 THEN
	wf_setmsg('공통코드[상태구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
/////////////////////////////////////////////////////////////////////////////////
// 1.6 신청일자 초기화
/////////////////////////////////////////////////////////////////////////////////
String	ls_Today
ls_Today = String(Today(),'YYYYMMDD')

f_childretrieven(tab_sheet.tabpage_sheet01.dw_update,"apply_gwa")         // 신청부서
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update,"sign_condition","payment_class")         // 물품구분(조회조건) 

tab_sheet.tabpage_sheet01.dw_update.Reset()
tab_sheet.tabpage_sheet01.dw_update.InsertRow(0)

tab_sheet.tabpage_1.dw_print.Object.DataWindow.print.preview = 'YES'
///////////////////////////////////////////////////////////////////////////////////////
// 2.  초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////


SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
	IF 	is_ord_flag = TRUE	THEN
			wf_SetMsg('이미 발주된 품목입니다. 수정할수 없습니다.')	
			RETURN -1
	END IF


IF tab_sheet.tabpage_sheet01.dw_update.AcceptText() = -1 THEN
	tab_sheet.tabpage_sheet01.dw_update.SetFocus()
	RETURN -1
END IF
IF tab_sheet.tabpage_sheet01.dw_update.ModifiedCount() + tab_sheet.tabpage_sheet01.dw_update.DeletedCount() = 0 THEN 
	wf_SetMsg('발주내역을 입력 후 저장하시기 바랍니다')
	RETURN 0
END IF

/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 필수입력항목 체크
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[], ls_ord_dt
Date     ld_devilery_dt,ld_jumun_dt
ls_NotNullCol[1] = 'ord_amt/금액'
//ls_NotNullCol[2] = 'vat_amt/부가세'
ls_NotNullCol[1] = 'ord_no/발주번호'
ls_NotNullCol[2] = 'cust_no/거래처명'
ls_NotNullCol[3] = 'dept_code/신청부서'
//ls_NotNullCol[4] = 'ord_class/상태구분'
IF f_chk_null(tab_sheet.tabpage_sheet01.dw_update,ls_NotNullCol) = -1 THEN RETURN -1
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 저장처리전 체크사항 기술
/////////////////////////////////////////////////////////////////////////////////////////
//DwItemStatus ldis_Status
//
Long		ll_Row			//변경된 행
long ll_item_seq, ll_quot_num, ll_confirm_opt
int		i
string	ls_req_no, ls_cust_no, ls_ord_no
DateTime	ldt_WorkDate	//수정일자
String	ls_Worker		//수정자
String	ls_IpAddr		//수정IP


	ldt_WorkDate = f_sysdate()					//수정일자
	ls_Worker    = gstru_uid_uname.uid		//수정자
	ls_IPAddr    = gstru_uid_uname.address	//수정IP

//	/////////////////////////////////////////////////////////////////////////////////
//	// 3.2 수정항목 처리
//	/////////////////////////////////////////////////////////////////////////////////
	tab_sheet.tabpage_sheet01.dw_update.Object.job_uid [1] = ls_Worker		//수정자
	tab_sheet.tabpage_sheet01.dw_update.Object.job_add [1] = ls_IPAddr		//수정IP
	tab_sheet.tabpage_sheet01.dw_update.Object.job_date[1] = ldt_WorkDate	//수정일자
	

/////////////////////////////////////////////////////////////////////////////////////////
//// 4. 자료저장처리
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
IF  tab_sheet.tabpage_sheet01.dw_update.update() <> 1 THEN RETURN -1
		tab_sheet.tabpage_sheet01.dw_update.accepttext()
FOR		i=1	TO tab_sheet.tabpage_sheet01.dw_list.rowcount()
			ll_confirm_opt = tab_sheet.tabpage_sheet01.dw_list.object.confirm_opt[i]
			ls_req_no 		= tab_sheet.tabpage_sheet01.dw_list.object.req_no[i]			
			ll_item_seq 	= tab_sheet.tabpage_sheet01.dw_list.object.item_seq[i]						
			ld_devilery_dt = date(tab_sheet.tabpage_sheet01.dw_update.object.devilery_dt[1])						
			ld_jumun_dt 	= date(tab_sheet.tabpage_sheet01.dw_update.object.ord_date[1])									
			ll_quot_num 	= tab_sheet.tabpage_sheet01.dw_list.object.quot_num[i]									
			ls_cust_no 		= tab_sheet.tabpage_sheet01.dw_list.object.cust_no[i]												
			ls_ord_no 		= tab_sheet.tabpage_sheet01.dw_update.object.ord_no[1]	
			
			IF	ld_devilery_dt < ld_jumun_dt	 THEN
				wf_setmsg("발주일자가 입고예정일보다 큽니다.")
				RETURN -1
			END IF		
			
			if	 		ll_confirm_opt = 1	then
												
						UPDATE	STDB.HST031H								/* 견젹테이블  UPDATE */
						SET		ORD_NO = :ls_ord_no, CONFIRM_OPT = 1
						WHERE		trim(REQ_NO) = trim(:ls_req_no)	AND 	ITEM_SEQ = :ll_item_seq	
									AND		CUST_NO = :ls_cust_no	AND	QUOT_NUM = :ll_quot_num;
						
						if 		sqlca.sqlcode <>  0 		then
									wf_SetMsg('저장중 오류가 발생하였습니다..')
									rollback;
									return -1
						end if	
						
						UPDATE	STDB.HST030H				/* 신청테이블  UPDATE */
						SET		 STAT_CLASS = 6,ORD_NO = :ls_ord_no
						WHERE		trim(REQ_NO)=TRIM(:ls_req_no)	AND 	ITEM_SEQ=:ll_item_seq	;

						if 		sqlca.sqlcode <>  0 		then
									wf_SetMsg('저장중 오류가 발생하였습니다..')
									rollback;
									return -1
						end if	
						COMMIT;						
			end if	
	
	
NEXT	

/////////////////////////////////////////////////////////////////////////////////////////
//// 5. 메세지, 메뉴버튼 활성/비활성화 처리
/////////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')


////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;call super::ue_delete;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_delete
//	기 능 설 명: 자료삭제 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
///////////////////////////////////////////////////////////////////////////////////////
// 1. 삭제할 데이타원도우의 선택여부 체크.
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
Long		ll_DeleteCnt, ll_ord_class

	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
	String	ls_req_no			//등재번호
	String	ls_ord_no		//품목구분
	String	ls_apply_gwa	//신청일자
	String	ls_RepGwa		//요구부서
	String	ls_RepMember	//요구자
	String	ls_AcceptGwa	//접수부서
	String	ls_ApplyAmt		//예상금액

	if		tab_sheet.tabpage_sheet01.dw_list.rowcount() < 1 or is_ord_flag = false then				
			return 
	end if	

	ls_ord_no  		= tab_sheet.tabpage_sheet01.dw_update.Object.ord_no[1]
	ls_req_no  		= tab_sheet.tabpage_sheet01.dw_list.Object.req_no[1]	
	ls_apply_gwa = tab_sheet.tabpage_sheet01.dw_update.Object.dept_code[1]
	ls_ApplyAmt  = String(tab_sheet.tabpage_sheet01.dw_update.Object.ord_amt[1])
	ll_ord_class = tab_sheet.tabpage_sheet01.dw_update.Object.ord_class[1]


///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
//ll_DeleteCnt = dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)
IF messagebox( "알림","현재 발주된 항목을 발주를 취소하고 견적 단계로 되돌립니다.~r~n" +&
					"계속하시겠습니까?",Exclamation!, YESNO! 	) = 1 THEN
					
IF ll_ord_class = 7 THEN
   messagebox('확인','입고처리되어 삭제 할수 없습니다..!')
   RETURN
END IF					
						
ll_DeleteCnt = tab_sheet.tabpage_sheet01.dw_update.deleterow(1)
IF ll_DeleteCnt > 0 THEN
	tab_sheet.tabpage_sheet01.dw_update.UPDATE()
	
		
			UPDATE	STDB.HST031H
			SET		CONFIRM_OPT = NULL , ORD_NO = ''
			WHERE		TRIM(ORD_NO) = TRIM(:ls_req_no);
	
	IF		SQLCA.SQLCODE <> 0 	THEN
			wf_SetMsg('저장중 오류가 발생하였습니다.')
			ROLLBACK;
			RETURN
	END IF			
	
	
			UPDATE	STDB.HST030H
			SET		STAT_CLASS = 4, ORD_NO = ''
			WHERE		TRIM(REQ_NO) = TRIM(:ls_req_no);
	
	IF		SQLCA.SQLCODE <> 0 	THEN
			wf_SetMsg('저장중 오류가 발생하였습니다.')
			ROLLBACK;
			RETURN
	END IF			
	commit;
	wf_SetMsg('자료가 삭제되었습니다.')
	
	THIS.TRIGGER EVENT UE_RETRIEVE()
END IF
	

END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;int	li_tab

li_tab = tab_sheet.selectedtab

CHOOSE CASE li_tab
		
	CASE	2
		if tab_sheet.tabpage_1.dw_print.rowcount() > 0 then f_print(tab_sheet.tabpage_1.dw_print)
END CHOOSE		


end event

event ue_init;call super::ue_init;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_init
////	기 능 설 명: 초기화 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 변경사항체크
/////////////////////////////////////////////////////////////////////////////////////////

//
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 메뉴버튼 활성화/비활성화처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('I',false)		//입력버튼
//wf_setMenu('R',TRUE)		//조회버튼
//wf_Setmenu('D',FALSE)	//삭제버튼
//wf_Setmenu('S',FALSE)	//저장버튼
//wf_Setmenu('P',TRUE)	//인쇄버튼


datawindowchild dwc, sdw_dwname
int li_cnt 
string ls_data
tab_sheet.tabpage_sheet01.dw_search.settransobject(sqlca)
tab_sheet.tabpage_sheet01.dw_search.Getchild("code",dwc)

dwc.settransobject(sqlca)
if dwc.retrieve("19990000") < 1 then 
	li_cnt = 0
	dwc.insertrow(0)
else
	li_cnt = 1
end If
tab_sheet.tabpage_sheet01.dw_search.insertrow(0)

tab_sheet.tabpage_sheet01.DW_LIST.Object.DataWindow.ReadOnly = 'no'	 

////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hgm404i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hgm404i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hgm404i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hgm404i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hgm404i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hgm404i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hgm404i
end type

type uc_insert from w_tabsheet`uc_insert within w_hgm404i
end type

type uc_delete from w_tabsheet`uc_delete within w_hgm404i
end type

type uc_save from w_tabsheet`uc_save within w_hgm404i
end type

type uc_excel from w_tabsheet`uc_excel within w_hgm404i
end type

type uc_print from w_tabsheet`uc_print within w_hgm404i
end type

type st_line1 from w_tabsheet`st_line1 within w_hgm404i
end type

type st_line2 from w_tabsheet`st_line2 within w_hgm404i
end type

type st_line3 from w_tabsheet`st_line3 within w_hgm404i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hgm404i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hgm404i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hgm404i
integer x = 18
integer y = 12
integer width = 3835
integer height = 2484
tabpage_1 tabpage_1
end type

event tab_sheet::selectionchanged;call super::selectionchanged;
IF 	oldindex	=	1	and newindex = 2 THEN
		tab_sheet.tabpage_1.sle_ord_no.text=	trim(tab_sheet.tabpage_sheet01.dw_update.object.ord_no[1])
END IF	
end event

on tab_sheet.create
this.tabpage_1=create tabpage_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tabpage_1)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer width = 3799
integer height = 2368
string text = "업체선정"
rb_j rb_j
rb_k rb_k
dw_update dw_update
dw_search dw_search
st_2 st_2
dw_list dw_list
sle_accept_num sle_accept_num
st_6 st_6
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type

on tabpage_sheet01.create
this.rb_j=create rb_j
this.rb_k=create rb_k
this.dw_update=create dw_update
this.dw_search=create dw_search
this.st_2=create st_2
this.dw_list=create dw_list
this.sle_accept_num=create sle_accept_num
this.st_6=create st_6
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_j
this.Control[iCurrent+2]=this.rb_k
this.Control[iCurrent+3]=this.dw_update
this.Control[iCurrent+4]=this.dw_search
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_list
this.Control[iCurrent+7]=this.sle_accept_num
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.rb_j)
destroy(this.rb_k)
destroy(this.dw_update)
destroy(this.dw_search)
destroy(this.st_2)
destroy(this.dw_list)
destroy(this.sle_accept_num)
destroy(this.st_6)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 1376
integer y = 316
integer width = 672
integer height = 240
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
end type

type uo_tab from w_tabsheet`uo_tab within w_hgm404i
end type

type dw_con from w_tabsheet`dw_con within w_hgm404i
end type

type st_con from w_tabsheet`st_con within w_hgm404i
end type

type rb_j from radiobutton within tabpage_sheet01
boolean visible = false
integer x = 41
integer y = 192
integer width = 256
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "통 제"
boolean checked = true
end type

event clicked;wf_retrieve('I')
end event

type rb_k from radiobutton within tabpage_sheet01
boolean visible = false
integer x = 78
integer y = 184
integer width = 247
integer height = 64
integer taborder = 35
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "견 적"
end type

event clicked;wf_retrieve('I')
end event

type dw_update from cuo_dwwindow within tabpage_sheet01
integer x = 50
integer y = 1904
integer width = 3685
integer height = 404
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hgm404i_4"
borderstyle borderstyle = stylelowered!
end type

event clicked;//
end event

type dw_search from datawindow within tabpage_sheet01
integer x = 2231
integer y = 100
integer width = 1019
integer height = 92
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_hgm404i"
boolean border = false
boolean livescroll = true
end type

event itemchanged;int		i	
String ls_ord_no
Long	ll_total_amt

	if 	is_ord_flag = true	then
			wf_SetMsg('이미 발주된 품목입니다. 수정할수 없습니다.')	
			return
	end if
	
	FOR	I	=	1	TO	dw_list.rowcount()		//**	선정구분초기화	**//					
			dw_list.object.confirm_opt[i]	=	0	
	NEXT
	
	
	FOR	 I	=	1	to dw_list.rowcount()		//**	선택한 업체 선정	**//
			if		dw_list.object.cust_no[i] = data		then
					ll_total_amt	+=	dw_list.object.sheet_price[i]	
					dw_list.object.confirm_opt[i]	=	1
			end	if		
			dw_update.object.ord_amt[1] = ll_total_amt
			dw_update.object.vat_amt[1] = ll_total_amt/10
	NEXT
	
	
															//** 발주번호 	초기화 **//
SELECT	TO_char(SYSDATE,'YYYYMM')||trim(to_char(nvl(substr(max(ord_NO),7,4)+1,'0001'),'0000'))
INTO		:ls_ord_no
FROM		STDB.HST031H
WHERE 	ord_NO LIKE	TO_char(SYSDATE,'YYYYMM') ||'%' ;

dw_update.object.ord_no[1] = ls_ord_no
dw_update.object.cust_no[1] = data
dw_update.object.ord_date[1] = f_today()
dw_update.object.ord_day[1] = f_today()
dw_update.object.devilery_dt[1] = f_today()
dw_update.object.dept_code[1] = '1301'


end event

type st_2 from statictext within tabpage_sheet01
integer x = 1929
integer y = 128
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "선정업체"
boolean focusrectangle = false
end type

type dw_list from cuo_dwwindow_one_hin within tabpage_sheet01
integer x = 9
integer y = 256
integer width = 3771
integer height = 1568
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_hgm404i_3"
boolean hsplitscroll = true
end type

event clicked;call super::clicked;//
end event

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

event retrieveend;call super::retrieveend;
STRING LS_CUST_NAME, as_req_no
INT I

as_req_no = trim(sle_accept_num.text)
dw_search.reset()

datawindowchild dwc, sdw_dwname
int li_cnt 
string ls_data
dw_search.settransobject(sqlca)
dw_search.Getchild("code",dwc)

dwc.settransobject(sqlca)
if dwc.retrieve(as_req_no) < 1 then 
	li_cnt = 0
	dwc.insertrow(0)
else
	li_cnt = 1
end If
dw_search.insertrow(0)

end event

event rowfocuschanged;string   ls_ord_no, ls_cust_no
long    ll_rowcnt, ll_item_seq, ll_count
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

IF currentrow <> 0 THEN
   ls_ord_no  = this.object.ord_no[currentrow]
//   ll_item_seq = this.object.item_seq[currentrow]
   ls_cust_no = this.object.cust_no[currentrow]
   ll_RowCnt = tab_sheet.tabpage_sheet01.dw_update.Retrieve(ls_ord_no, ls_cust_no )
   IF ll_RowCnt = 0 THEN
	   tab_sheet.tabpage_sheet01.dw_update.insertrow(0)
   END IF
END IF

















end event

event itemchanged;call super::itemchanged;int		i	
String ls_ord_no
Long	ll_total_amt

	if 	is_ord_flag = true	then
			wf_SetMsg('이미 발주된 품목입니다. 수정할수 없습니다.')	
			return
	end if
	
	FOR	I	=	1	TO	dw_list.rowcount()		//**	선정구분초기화	**//					
			dw_list.object.confirm_opt[i]	=	0	
	NEXT
	
	
	FOR	 I	=	1	to dw_list.rowcount()		//**	선택한 업체 선정	**//
			if		dw_list.object.cust_no[i] = data		then
					ll_total_amt	+=	dw_list.object.sheet_price[i]	
					dw_list.object.confirm_opt[i]	=	1
			end	if		
			dw_update.object.ord_amt[1] = ll_total_amt
			dw_update.object.vat_amt[1] = ll_total_amt/10
	NEXT
	
	
															//** 발주번호 	초기화 **//
SELECT	TO_char(SYSDATE,'YYYYMM')||trim(to_char(nvl(substr(max(ord_NO),7,4)+1,'0001'),'0000'))
INTO		:ls_ord_no
FROM		STDB.HST031H
WHERE 	ord_NO LIKE	TO_char(SYSDATE,'YYYYMM') ||'%' ;

dw_update.object.ord_no[1] = ls_ord_no
dw_update.object.req_no[1] = dw_list.object.req_no[dw_list.getrow()]
dw_update.object.cust_no[1] = dw_list.object.cust_no[dw_list.getrow()]
dw_update.object.ord_date[1] = f_today()
dw_update.object.ord_day[1] = f_today()
dw_update.object.devilery_dt[1] = f_today()
dw_update.object.dept_code[1] = '1301'
dw_update.object.ord_amt[1] = dw_list.object.sheet_price[dw_list.getrow()] 

end event

type sle_accept_num from singlelineedit within tabpage_sheet01
integer x = 485
integer y = 120
integer width = 599
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "IBeam!"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within tabpage_sheet01
integer x = 155
integer y = 144
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "접수번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 14
integer y = 28
integer width = 1623
integer height = 216
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "접수번호"
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 1664
integer y = 28
integer width = 2080
integer height = 216
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "업체 선정"
end type

type gb_3 from groupbox within tabpage_sheet01
integer x = 14
integer y = 1844
integer width = 3767
integer height = 504
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "발주내역 "
end type

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3799
integer height = 2368
long backcolor = 79741120
string text = "발주서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
sle_ord_no sle_ord_no
st_1 st_1
gb_4 gb_4
end type

on tabpage_1.create
this.dw_print=create dw_print
this.sle_ord_no=create sle_ord_no
this.st_1=create st_1
this.gb_4=create gb_4
this.Control[]={this.dw_print,&
this.sle_ord_no,&
this.st_1,&
this.gb_4}
end on

on tabpage_1.destroy
destroy(this.dw_print)
destroy(this.sle_ord_no)
destroy(this.st_1)
destroy(this.gb_4)
end on

type dw_print from cuo_dwwindow_one_hin within tabpage_1
integer x = 27
integer y = 308
integer width = 3735
integer height = 2032
integer taborder = 11
string dataobject = "d_hgm404i_5"
end type

type sle_ord_no from singlelineedit within tabpage_1
integer x = 507
integer y = 148
integer width = 768
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within tabpage_1
integer x = 128
integer y = 164
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "발주번호"
boolean focusrectangle = false
end type

type gb_4 from groupbox within tabpage_1
integer x = 27
integer y = 68
integer width = 1623
integer height = 224
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "발주번호"
end type

