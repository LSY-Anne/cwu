$PBExportHeader$w_hgm202i.srw
$PBExportComments$비품수리신청
forward
global type w_hgm202i from w_tabsheet
end type
type dw_print from datawindow within tabpage_sheet01
end type
type sle_room_nm from singlelineedit within tabpage_sheet01
end type
type sle_gwa_nm from singlelineedit within tabpage_sheet01
end type
type st_3 from statictext within tabpage_sheet01
end type
type st_2 from statictext within tabpage_sheet01
end type
type st_1 from statictext within tabpage_sheet01
end type
type st_5 from statictext within tabpage_sheet01
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type em_apply_date from editmask within tabpage_sheet01
end type
type ddlb_apply_no from dropdownlistbox within tabpage_sheet01
end type
type sle_item_nm from singlelineedit within tabpage_sheet01
end type
type st_4 from statictext within tabpage_sheet01
end type
type st_6 from statictext within tabpage_sheet01
end type
type dw_search1 from datawindow within tabpage_sheet01
end type
type dw_update from uo_dwfree within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type st_20 from statictext within tabpage_1
end type
type sle_2 from singlelineedit within tabpage_1
end type
type st_12 from statictext within tabpage_1
end type
type em_to_date from editmask within tabpage_1
end type
type st_11 from statictext within tabpage_1
end type
type em_fr_date from editmask within tabpage_1
end type
type st_10 from statictext within tabpage_1
end type
type dw_print2 from datawindow within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type st_7 from statictext within tabpage_1
end type
type dw_search from datawindow within tabpage_1
end type
type dw_acct_code from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
st_20 st_20
sle_2 sle_2
st_12 st_12
em_to_date em_to_date
st_11 st_11
em_fr_date em_fr_date
st_10 st_10
dw_print2 dw_print2
gb_2 gb_2
st_7 st_7
dw_search dw_search
dw_acct_code dw_acct_code
end type
type tabpage_2 from userobject within tab_sheet
end type
type st_13 from statictext within tabpage_2
end type
type re_to_date from editmask within tabpage_2
end type
type re_from_date from editmask within tabpage_2
end type
type st_9 from statictext within tabpage_2
end type
type st_8 from statictext within tabpage_2
end type
type dw_print3 from datawindow within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_re_dept from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
st_13 st_13
re_to_date re_to_date
re_from_date re_from_date
st_9 st_9
st_8 st_8
dw_print3 dw_print3
gb_3 gb_3
dw_re_dept dw_re_dept
end type
end forward

global type w_hgm202i from w_tabsheet
string title = "물품 신청"
end type
global w_hgm202i w_hgm202i

type variables

int ii_tab
datawindowchild idw_child
datawindow idw_sname

s_insa_com	istr_com

String	is_KName		//성명
String	is_MemberNo	//개인번호

string is_IdNo			// 등재번호
string is_applydate	//신청일자
int	 ii_apply_num	//신청번호
int 	 ii_Itemclss		// 품목구분
end variables

forward prototypes
public subroutine wf_retrieve ()
public function boolean wf_apply_no ()
end prototypes

public subroutine wf_retrieve ();//
//datawindow dw_name
//int  li_ord_class, li_page = 1, j, li_item_class
//string ls_apply_date_f, ls_apply_date_t, ls_item_middle, ls_item_name
//string ls_dept_code,ls_gwa, ls_apply_date, ls_acct_code
//string ls_large_name, ls_medium_name, ls_small_name, ls_goods_kind, ls_measure
//long	ll_apply_qty, ll_apply_price,ll_apply_amt, i, ll_cur_row, ll_cur_row2, ll_total_amt
//string ls_id_no, ls_rep_member_no, ls_remark
//
//f_setpointer('START')
//
//
//
//	tab_sheet.tabpage_1.dw_print2.reset()
////	tab_sheet.tabpage_1.dw_print3.reset()	
//	tab_sheet.tabpage_1.dw_search.accepttext()
//	ls_dept_code = tab_sheet.tabpage_1.dw_search.object.code[tab_sheet.tabpage_1.dw_search.getrow()]
//
////	FOR j	=	1	TO	2								/** 비품, 소모품 각각 출력(소모품만출력) **/
//	
//DECLARE GET_REQ_ITEM CURSOR	FOR		//조회조건의 부서가 수리신청한 물품 검색
//	
//		
//SELECT 	C.ITEM_NAME,
//		   A.ID_NO,
//		   A.ITEM_CLASS,
//		   A.APPLY_DATE,
//		   A.REP_GWA,
//		   A.REP_MEMBER_NO,
//		   A.APPLY_AMT,
//		   A.REP_NEED	    
//FROM 	   STDB.HST030H A, STDB.HST027M B, STDB.HST004M C
//WHERE	   trim(REP_GWA)= :ls_dept_code AND
//		   A.ID_NO = B.ID_NO AND
//		   A.ITEM_CLASS		 =	B.ITEM_CLASS AND
//		   B.ITEM_NO		 =	C.ITEM_NO AND
//			STAT_CLASS IN ('1','2')			;
//			
//
//		OPEN GET_REQ_ITEM;
//		
////		DO WHILE	SQLCA.SQLCODE = 0 				// 물품 신청이 있는 만큼 자료읽어 들인다.		
//		FETCH	GET_REQ_ITEM
//		INTO  :ls_item_name,:ls_id_no,:li_item_class,:ls_apply_date,:ls_gwa,:ls_rep_member_no,:ll_apply_price,:ls_remark;					
//			
//		if sqlca.sqlcode = 0 then
//			ll_cur_row = tab_sheet.tabpage_1.dw_print2.insertrow(0)
//		end if	
//		ls_apply_date = f_today()			
//
//
////			
//			tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,"apply_gwa", ls_gwa)			//	공통 타이틀 	항목 뿌려주기.
//			tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,"apply_date", ls_apply_date)		
////			tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,"jago1", 	ls_small_name		)		
//			tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,"jago2", ls_medium_name)		
//			tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,"jago3", ls_large_name)					
////			tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,"applyer", 	gs_empcode)
//			tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,"applyer", 	ls_rep_member_no)
//			if		j	=	1	then
//					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,"jago1", 	"비품신청서"	)			
//			else
//					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,"jago1", 	"소모품신청서"	)			
//			end if	
//		
//		
//		i = 1
//		DO WHILE	SQLCA.SQLCODE = 0 		
//																			
//			if i <= 11 and li_page = 1 then												/** 갑지 사용  시작 **/					
//					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,(9*i)-2, ls_item_name)																	
//					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,(9*i)-1, '비품')	
//					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,(9*i), '1')				
////					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,(9*i)+1, ls_measure)							
//					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,(9*i)+2, ll_apply_price)		
//					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,(9*i)+3, ll_apply_price)	
//					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,(9*i)+4, ls_remark)	
//					ll_total_amt += ll_apply_price
////			else																					/** 을지 사용  시작 **/
////					tab_sheet.tabpage_1.dw_print3.setitem(ll_cur_row2,(9*i)-8, ls_item_name)																	
////					tab_sheet.tabpage_1.dw_print3.setitem(ll_cur_row2,(9*i)-7, ls_goods_kind)	
////					tab_sheet.tabpage_1.dw_print3.setitem(ll_cur_row2,(9*i)-6, ll_apply_qty)				
////					tab_sheet.tabpage_1.dw_print3.setitem(ll_cur_row2,(9*i)-5, ls_measure)							
////					tab_sheet.tabpage_1.dw_print3.setitem(ll_cur_row2,(9*i)-4, ll_apply_price)		
////					tab_sheet.tabpage_1.dw_print3.setitem(ll_cur_row2,(9*i)-3, ll_apply_amt)			
////					tab_sheet.tabpage_1.dw_print3.setitem(ll_cur_row2,(9*i)-2, ls_remark)
////					ll_total_amt += ll_apply_price					
////					IF		i	= 21		THEN				/** 을지반복사용	**/
////							i	=	0
////							ll_cur_row2 = tab_sheet.tabpage_1.dw_print3.insertrow(0)
////					END IF	
//					
//			end if		
//				
//																					
//																					
//																					
//		FETCH	GET_REQ_ITEM
//		INTO  :ls_item_name,:ls_id_no,:li_item_class,:ls_apply_date,:ls_gwa,:ls_rep_member_no,:ll_apply_price,:ls_remark;					
//			
//		if sqlca.sqlcode <> 0 then
//			IF		li_page	=	1	THEN
//					I++
//					tab_sheet.tabpage_1.dw_print2.setitem(ll_cur_row,(9*i)+3, ll_total_amt)						
////			ELSE
////					I++
////					tab_sheet.tabpage_1.dw_print3.setitem(ll_cur_row2,(9*i)-3, ll_total_amt)								
//			END IF	
//			CLOSE GET_REQ_ITEM;	
//			
//			f_setpointer('END')
//			li_page = 1
//			return
//		end if	
//		
////		if i = 11 and li_page = 1 then											// "을"지 초기화 
////							i = 0
////							li_page = 2
////							ll_cur_row2 = tab_sheet.tabpage_1.dw_print3.insertrow(0)
////		end if
////			
////		i++	
//		LOOP
//
////NEXT		
//		
//		CLOSE GET_REQ_ITEM;
//		
//
//
//
//
//f_setpointer('END')
//

end subroutine

public function boolean wf_apply_no ();////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 기    능 : 조회조건체크
//// 2. 작 성 자 : 김지훈
//// 3. 작 성 일 : 2002.05.04
//// 4. 함수원형 : wf_apply_no RETURN BOOLEAN
//// 5. 인    수 : 
//// 6. 되 돌 림 : TRUE  - 정상
////			   	  FALSE - 오류
////////////////////////////////////////////////////////////////////////////////////////////
//Integer	li_Null
//SetNull(li_Null)
//
//Long		ll_GetRow
//ll_GetRow = tab_sheet.tabpage_sheet01.dw_list.GetSelectedRow(0)
//IF ll_GetRow = 0 THEN RETURN FALSE
//////////////////////////////////////////////////////////////////////////////////
//// 1. 등재번호 체크
//////////////////////////////////////////////////////////////////////////////////
////String	ls_IdNo
//is_IdNo = tab_sheet.tabpage_sheet01.dw_list.Object.id_no[ll_GetRow]
//IF isNull(is_IdNo) OR LEN(is_IdNo) = 0 THEN
//	tab_sheet.tabpage_sheet01.dw_list.SetFocus()
//	RETURN FALSE
//END IF
//////////////////////////////////////////////////////////////////////////////////
//// 2. 품목구분 체크
//////////////////////////////////////////////////////////////////////////////////
////Long		ll_ItemClss
//ii_ItemClss = tab_sheet.tabpage_sheet01.dw_list.Object.item_class[ll_GetRow]
//IF isNull(String(ii_ItemClss)) OR ii_ItemClss = 0 THEN
//	tab_sheet.tabpage_sheet01.dw_list.SetFocus()
//	RETURN FALSE
//END IF
//////////////////////////////////////////////////////////////////////////////////
//// 3. 신청일자 체크
//////////////////////////////////////////////////////////////////////////////////
//
//tab_sheet.tabpage_sheet01.em_apply_date.GetData(is_applydate)
//IF NOT f_chk_date(is_applydate,'YMD') THEN
//	tab_sheet.tabpage_sheet01.em_apply_date.SetFocus()
//	RETURN FALSE
//END IF
//////////////////////////////////////////////////////////////////////////////////
//// 4. 전표번호 체크
//////////////////////////////////////////////////////////////////////////////////
//tab_sheet.tabpage_sheet01.ddlb_apply_no.Reset()
//
//
//
//DECLARE	CUR_SOR	CURSOR FOR
//
//SELECT	NVL(A.APPLY_NO,0), A.APPLY_DATE
//FROM		STDB.HST030H	A
//WHERE		A.ID_NO	=	:is_IdNo
//AND		A.ITEM_CLASS = :ii_ItemClss
//AND		A.APPLY_DATE = :is_applydate
//AND		A.STAT_CLASS	=	1
//ORDER	BY	A.APPLY_NO
//USING		SQLCA;
//
//OPEN CUR_SOR;
//
//FETCH	CUR_SOR	INTO :ii_Apply_Num,:IS_APPLYDATE;
//		
//		IF SQLCA.SQLCODE <> 0 THEN
//			tab_sheet.tabpage_sheet01.dw_update.Object.DataWindow.ReadOnly = 'YES'				
//			ii_apply_num	=	0
//		ELSE
//			DO WHILE SQLCA.SQLCODE = 0
//				
//				tab_sheet.tabpage_sheet01.ddlb_apply_no.AddItem(String(ii_Apply_Num,'0000'))
//				
//				FETCH	CUR_SOR	INTO :ii_Apply_Num,:IS_APPLYDATE;
//			LOOP
//			tab_sheet.tabpage_sheet01.dw_update.Object.DataWindow.ReadOnly = 'NO'		
//		END IF	
//		
//
//CLOSE CUR_SOR;
//
//Long	ll_i
//ll_i = tab_sheet.tabpage_sheet01.ddlb_apply_no.TotalItems()
//tab_sheet.tabpage_sheet01.ddlb_apply_no.SelectItem(ll_i)

RETURN TRUE
//////////////////////////////////////////////////////////////////////////////////
//// END OF GLOBAL FUNCITON
//////////////////////////////////////////////////////////////////////////////////
end function

on w_hgm202i.create
int iCurrent
call super::create
end on

on w_hgm202i.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked;;cb_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////
tab_sheet.tabpage_sheet01.dw_search1.accepttext()

String	ls_GwaNm		//사용부서명
ls_GwaNm = TRIM(tab_sheet.tabpage_sheet01.dw_search1.object.dept[1])
IF isNull(ls_GwaNm) OR LEN(ls_GwaNm) = 0 THEN ls_GwaNm = '%'

String	ls_re_GwaNm		//사용부서명
ls_re_GwaNm = TRIM(tab_sheet.tabpage_2.dw_re_dept.object.code[1])
IF isNull(ls_re_GwaNm) OR LEN(ls_re_GwaNm) = 0 THEN ls_re_GwaNm = '%'

String	ls_RoomNm	//사용장소명
ls_RoomNm = TRIM(tab_sheet.tabpage_sheet01.dw_search1.object.room[1])
IF isNull(ls_RoomNm) OR LEN(ls_RoomNm) = 0 THEN ls_RoomNm = '%'

String	ls_ItemNm	//품목명
ls_ItemNm = TRIM(tab_sheet.tabpage_sheet01.dw_search1.object.item[1])
IF isNull(ls_ItemNm) OR LEN(ls_ItemNm) = 0 THEN ls_ItemNm = '%'

String	ls_id_no	//자산등재번호
ls_id_no = TRIM(tab_sheet.tabpage_sheet01.dw_search1.object.id_no[1])
IF isNull(ls_id_no) OR LEN(ls_id_no) = 0 THEN ls_id_no = '%'

long ll_row

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
      SetPointer(HourGlass!)
      ///////////////////////////////////////////////////////////////////////////////////////
      // 2. 자료조회
      ///////////////////////////////////////////////////////////////////////////////////////
       wf_SetMsg('조회 처리 중입니다...')
      Long		ll_RowCnt
      tab_sheet.tabpage_sheet01.dw_update_tab.SetReDraw(TRUE)
      tab_sheet.tabpage_sheet01.dw_update_tab.reset()
      ll_RowCnt = tab_sheet.tabpage_sheet01.dw_update_tab.Retrieve(ls_GwaNm,ls_RoomNm,ls_ItemNm,ls_id_no)
      tab_sheet.tabpage_sheet01.dw_update_tab.SetReDraw(TRUE)

      ///////////////////////////////////////////////////////////////////////////////////////
      // 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
      ///////////////////////////////////////////////////////////////////////////////////////
      IF ll_RowCnt = 0 THEN 
//      	wf_SetMenu('I',FALSE)
//      	wf_SetMenu('D',FALSE)
//	      wf_SetMenu('S',FALSE)
//	      wf_SetMenu('R',TRUE)
	      Messagebox('알림','자산등재 자료가 존재하지 않습니다.~r~n' + &
					      '자산등재 후 사용하시기 바랍니다.')
      ELSE
//	      wf_SetMenu('I',TRUE)
//	      wf_SetMenu('D',TRUE)
//	      wf_SetMenu('S',TRUE)
//	      wf_SetMenu('R',TRUE)
	      wf_SetMsg('자료가 조회되었습니다.')
      END IF


   CASE	2
		//////////////////////////////////////////////////////////////////////////////////////////////
		//2.1.조회조건 체크
		//////////////////////////////////////////////////////////////////////////////////////////////
		String  ls_dept_code
		ls_dept_code = trim(tab_sheet.tabpage_1.dw_search.object.code[1])
		IF isnull(ls_dept_code) or	ls_dept_code = ''	 THEN
   		ls_dept_code = '%'
		ELSE
			ls_dept_code = tab_sheet.tabpage_1.dw_search.object.code[tab_sheet.tabpage_1.dw_search.getrow()]
		END IF	

		String  ls_fr_date, ls_to_date
		ls_fr_date = mid(tab_sheet.tabpage_1.em_fr_date.text,1,4) + mid(tab_sheet.tabpage_1.em_fr_date.text,6,2) + &
	          		 mid(tab_sheet.tabpage_1.em_fr_date.text,9,2)
		ls_to_date = mid(tab_sheet.tabpage_1.em_to_date.text,1,4) + mid(tab_sheet.tabpage_1.em_to_date.text,6,2) + &
	         		 mid(tab_sheet.tabpage_1.em_to_date.text,9,2)

		IF ls_fr_date = '' or isnull(ls_fr_date) then
			wf_setmsg("기간from를 입력하시기바랍니다..!")
			 return -1
		END IF

		IF ls_to_date = '' or isnull(ls_to_date) then
			wf_setmsg("기간to를 입력하시기바랍니다..!")
			 return -1
		END IF
	   
		String	ls_acct_code	//계정과목
      ls_acct_code = TRIM(tab_sheet.tabpage_1.dw_acct_code.object.code[1])
      IF isNull(ls_acct_code) OR LEN(ls_acct_code) = 0 THEN  
 	      messagebox('확인','계정과목을 입력하시기 바랍니다..!')
      END IF 

		String ls_apply_no
		ls_apply_no  = tab_sheet.tabpage_1.sle_2.text
		IF isnull(ls_apply_no) or	ls_apply_no	 = ''	THEN
		ls_apply_no	 = '%'
		END IF	

		SetPointer(HourGlass!)
      ///////////////////////////////////////////////////////////////////////////////////////
      // 2.2. 자료조회
      ///////////////////////////////////////////////////////////////////////////////////////
      wf_SetMsg('조회 처리 중입니다...')
      tab_sheet.tabpage_1.dw_print2.SetReDraw(TRUE)
      tab_sheet.tabpage_1.dw_print2.reset()
      ll_RowCnt = tab_sheet.tabpage_1.dw_print2.Retrieve(ls_dept_code,ls_fr_date,ls_to_date, ls_acct_code, ls_apply_no)
      tab_sheet.tabpage_1.dw_print2.SetReDraw(TRUE)

      ///////////////////////////////////////////////////////////////////////////////////////
      // 2.3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
      ///////////////////////////////////////////////////////////////////////////////////////
      IF ll_RowCnt = 0 THEN 
//      	wf_SetMenu('I',FALSE)
//      	wf_SetMenu('D',FALSE)
//	      wf_SetMenu('S',FALSE)
//	      wf_SetMenu('R',TRUE)

	      Messagebox('알림','수리신청 자료가 존재하지 않습니다.~r~n' + &
					      '수리신청 후 사용하시기 바랍니다.')
      ELSE
//	      wf_SetMenu('I',FALSE)
//	      wf_SetMenu('D',FALSE)
//	      wf_SetMenu('S',FALSE)
//	      wf_SetMenu('R',TRUE)
//			wf_SetMenu('p',TRUE)
	      wf_SetMsg('자료가 조회되었습니다.')
      END IF
	CASE	3
		string ls_re_from_date, ls_re_to_date
		string ls_re_dept_code
		
		ls_re_from_date = mid(tab_sheet.tabpage_2.re_from_date.text,1,4) + mid(tab_sheet.tabpage_2.re_from_date.text,6,2) + &
	          		 		mid(tab_sheet.tabpage_2.re_from_date.text,9,2)
		ls_re_to_date	 = mid(tab_sheet.tabpage_2.re_to_date.text,1,4) + mid(tab_sheet.tabpage_2.re_to_date.text,6,2) + &
	         			 	mid(tab_sheet.tabpage_2.re_to_date.text,9,2)
		
		tab_sheet.tabpage_2.dw_re_dept.accepttext()
		ls_re_dept_code = trim(tab_sheet.tabpage_2.dw_re_dept.object.code[1])
	
		IF isnull(ls_re_dept_code) or	ls_re_dept_code = ''	 THEN
   		ls_re_dept_code = '%'
		ELSE
			ls_re_dept_code = tab_sheet.tabpage_2.dw_re_dept.object.code[tab_sheet.tabpage_2.dw_re_dept.getrow()]
		END IF
		
		IF ls_re_from_date = '' or isnull(ls_re_from_date) then
			wf_setmsg("기간from를 입력하시기바랍니다..!")
			 return -1
		END IF

		IF ls_re_to_date = '' or isnull(ls_re_to_date) then
			wf_setmsg("기간to를 입력하시기바랍니다..!")
			 return -1
		END IF
		
		///////////////////////////////////////////////////////////////////////////////////////
      // 3.1. 자료조회
      ///////////////////////////////////////////////////////////////////////////////////////
      wf_SetMsg('조회 처리 중입니다...')
      tab_sheet.tabpage_2.dw_print3.SetReDraw(TRUE)
      tab_sheet.tabpage_2.dw_print3.reset()

//		messagebox('', ls_re_dept_code+':'+ls_re_from_date+':'+ls_re_to_date)
      
		ll_RowCnt = tab_sheet.tabpage_2.dw_print3.Retrieve(ls_re_dept_code,ls_re_from_date,ls_re_to_date)
		tab_sheet.tabpage_2.dw_print3.SetReDraw(TRUE)
		      
END CHOOSE
return 1
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
// 1. 자료추가전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
long 		ll_max_ddlb
long ll_row



ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
	   ll_row = tab_sheet.tabpage_sheet01.dw_update_tab.getrow()
	
	   IF ll_row <> 0 THEN


ll_GetRow = tab_sheet.tabpage_sheet01.dw_update_tab.getrow()
IF ll_GetRow = 0 THEN
	Messagebox('알림','품목을 선택한 후 사용하시기 바랍니다.')
	RETURN
END IF

String	ls_ApplyDate	//신청일자
tab_sheet.tabpage_sheet01.em_apply_date.GetData(ls_ApplyDate)
IF isNull(ls_ApplyDate) OR LEN(ls_ApplyDate) = 0 THEN
	Messagebox('알림','신청일자를 입력 후 사용하시기 바랍니다.')
	RETURN
END IF
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long	 ll_InsRow
//ll_InsRow = tab_sheet.tabpage_sheet01.dw_update.TRIGGER EVENT ue_db_append()

//IF ib_RowSingle THEN
//	IF f_chk_update(THIS,'') = 3 THEN RETURN 0
	 tab_sheet.tabpage_sheet01.dw_update.Reset()
//END IF


ll_InsRow =  tab_sheet.tabpage_sheet01.dw_update.InsertRow(0)

 tab_sheet.tabpage_sheet01.dw_update.SetRow(ll_InsRow)
 tab_sheet.tabpage_sheet01.dw_update.ScrollToRow(ll_InsRow)
 tab_sheet.tabpage_sheet01.dw_update.SetFocus()
//IF ib_RowSelect THEN
//	 tab_sheet.tabpage_sheet01.dw_update.SelectRow(0,FALSE)
//	 tab_sheet.tabpage_sheet01.dw_update.SelectRow(ll_InsRow,TRUE)
//ELSE
//	THIS.Object.DataWindow.HorizontalScrollPosition = 0
//END IF



IF ll_InsRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴트값 셋팅
///////////////////////////////////////////////////////////////////////////////////////
String ls_rep_gwa, ls_accept_gwa, ls_acct_code
ls_rep_gwa     = tab_sheet.tabpage_sheet01.dw_update_tab.Object.gwa    [ll_GetRow]
//ls_accept_gwa  = tab_sheet.tabpage_sheet01.dw_update_tab.Object.     [ll_GetRow]
is_IdNo        = tab_sheet.tabpage_sheet01.dw_update_tab.Object.id_no     [ll_GetRow]
ii_ItemClss    = tab_sheet.tabpage_sheet01.dw_update_tab.Object.item_class[ll_GetRow]
//ls_acct_code   = tab_sheet.tabpage_sheet01.dw_update_tab.Object.acct_code[ll_GetRow]
tab_sheet.tabpage_sheet01.dw_update.Object.id_no     [ll_InsRow] = is_IdNo		                         //등재번호
tab_sheet.tabpage_sheet01.dw_update.Object.item_class[ll_InsRow] = ii_ItemClss	                      //품목구분
tab_sheet.tabpage_sheet01.dw_update.Object.apply_date[ll_InsRow] = ls_ApplyDate	                      //신청일자
tab_sheet.tabpage_sheet01.dw_update.Object.sign_yn   [ll_InsRow] = '1'
tab_sheet.tabpage_sheet01.dw_update.Object.repair_yn [ll_InsRow] = '1'
tab_sheet.tabpage_sheet01.dw_update.Object.stat_class[ll_InsRow] =  1				                          //신청
tab_sheet.tabpage_sheet01.dw_update.Object.rep_gwa   [ll_InsRow] = ls_rep_gwa			                          //신청부서
tab_sheet.tabpage_sheet01.dw_update.Object.accept_gwa[ll_InsRow] = '1401'				  //접수부서
tab_sheet.tabpage_sheet01.dw_update.Object.acct_code [ll_InsRow] = '421202'

DateTime	ldt_WorkDate
String	ls_Worker
String	ls_IPAddr
ldt_WorkDate = f_sysdate()						//등록일자
ls_Worker    = gs_empcode			//등록자
ls_IPAddr    = gs_ip		//등록단말기
tab_sheet.tabpage_sheet01.dw_update.Object.worker   [ll_InsRow] = ls_Worker
tab_sheet.tabpage_sheet01.dw_update.Object.work_date[ll_InsRow] = ldt_WorkDate
tab_sheet.tabpage_sheet01.dw_update.Object.ipaddr   [ll_InsRow] = ls_IPAddr

///////////////////////////////////////////////////////////////////////////////////////
// 3.1 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
tab_sheet.tabpage_sheet01.dw_update.SetItemStatus(ll_InsRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성화/비활성화처리, 메세지처리, 데이타원도우호 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)



tab_sheet.tabpage_sheet01.em_apply_date.Enabled = FALSE
tab_sheet.tabpage_sheet01.ddlb_apply_no.Enabled = FALSE
wf_SetMsg('자료가 추가되었습니다.')
tab_sheet.tabpage_sheet01.dw_update.Object.DataWindow.ReadOnly = 'NO'
tab_sheet.tabpage_sheet01.dw_update.SetColumn('rep_date')

END IF
END CHOOSE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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

if gs_empcode = 'F0009' or gs_empcode = 'F0057' or gs_empcode = 'admin' then
  	tab_sheet.tabpage_sheet01.dw_search1.Object.dept.protect = 0
else
	tab_sheet.tabpage_sheet01.dw_search1.Object.dept.protect = 1
end if


if gs_empcode = 'F0009' or gs_empcode = 'F0057'  or gs_empcode = 'admin' then
	tab_sheet.tabpage_2.dw_re_dept.Object.code.Background.mode = 0
	tab_sheet.tabpage_2.dw_re_dept.enabled = true
else
	tab_sheet.tabpage_2.dw_re_dept.Object.code.Background.mode = 1
	tab_sheet.tabpage_2.dw_re_dept.enabled = false
end if

if gs_empcode = 'F0009' or gs_empcode = 'F0057'  or gs_empcode = 'admin' then
	tab_sheet.tabpage_1.dw_search.Object.code.Background.mode = 0
	tab_sheet.tabpage_1.dw_search.enabled = true
else
	tab_sheet.tabpage_1.dw_search.Object.code.Background.mode = 1
	tab_sheet.tabpage_1.dw_search.enabled = false
end if

tab_sheet.tabpage_sheet01.dw_search1.GetChild('dept',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('공통코드[부서]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
else
END IF

tab_sheet.tabpage_sheet01.dw_update.GetChild('item_class',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('item_class',0) = 0 THEN
	wf_setmsg('공통코드[품목구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

/////////////////////////////////////////////////////////////////////////////////
// 1.2 등록용 - 요구부서 DDDW초기화
/////////////////////////////////////////////////////////////////////////////////
tab_sheet.tabpage_sheet01.dw_update.GetChild('rep_gwa',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

/////////////////////////////////////////////////////////////////////////////////
// 1.3 등록용 - 접수부서 DDDW초기화
/////////////////////////////////////////////////////////////////////////////////
tab_sheet.tabpage_sheet01.dw_update.GetChild('accept_gwa',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

/////////////////////////////////////////////////////////////////////////////////
// 1.4 등록용 - 계정과목 DDDW초기화
/////////////////////////////////////////////////////////////////////////////////
tab_sheet.tabpage_sheet01.dw_update.GetChild('acct_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('계정과목을 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF

/////////////////////////////////////////////////////////////////////////////////
// 1.5 등록용 - 상태구분 DDDW초기화
/////////////////////////////////////////////////////////////////////////////////
tab_sheet.tabpage_sheet01.dw_update.GetChild('stat_class',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('ord_class',0) = 0 THEN
	wf_setmsg('공통코드[상태구분]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
END IF
 ldwc_Temp.SetSort('code ASC')
 ldwc_Temp.Sort()
 
 
tab_sheet.tabpage_sheet01.dw_update.settransobject(sqlca)
func.of_design_dw(tab_sheet.tabpage_sheet01.dw_update)
 
/////////////////////////////////////////////////////////////////////////////////
// 1.6 신청일자 초기화
/////////////////////////////////////////////////////////////////////////////////
String	ls_Today
ls_Today = String(Today(),'YYYYMMDD')
tab_sheet.tabpage_sheet01.em_apply_date.Text = ls_Today

/////////////// 출력물 tabpage 초기화	//////////////////////
                        
tab_sheet.tabpage_1.dw_print2.settransobject(SQLCA) 
tab_sheet.tabpage_1.dw_search.object.code[1]		=	gs_DeptCode
tab_sheet.tabpage_2.dw_re_dept.object.code[1]	=	gs_DeptCode

///////////////////////////////////////////////////////////////////////////////////////
// 1.1 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('R',TRUE)
//wf_setMenu('I',FALSE)
//wf_setMenu('P',TRUE)

tab_sheet.tabpage_1.dw_print2.Object.DataWindow.Zoom = 100
tab_sheet.tabpage_1.dw_print2.Object.DataWindow.Print.Preview = 'YES'

tab_sheet.tabpage_1.dw_search.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('공통코드[부서]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
else
END IF

tab_sheet.tabpage_2.dw_re_dept.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('공통코드[부서]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
else
END IF
//tab_sheet.tabpage_sheet01.dw_search1.InsertRow(0)
//tab_sheet.tabpage_sheet01.dw_search1.settransobject(sqlca)

tab_sheet.tabpage_1.dw_search.InsertRow(0)
tab_sheet.tabpage_1.dw_search.Object.code.dddw.PercentWidth = 100
tab_sheet.tabpage_1.dw_search.settransobject(sqlca)

tab_sheet.tabpage_1.em_fr_date.text = left(f_today(),6) + '01'
tab_sheet.tabpage_1.em_to_date.text = f_today()

tab_sheet.tabpage_2.re_from_date.text = left(f_today(),6) + '01'
tab_sheet.tabpage_2.re_to_date.text = f_today()


//tab_sheet.tabpage_sheet01.dw_search1.Reset()

tab_sheet.tabpage_sheet01.dw_search1.InsertRow(0)
tab_sheet.tabpage_sheet01.dw_search1.object.dept[1]	=	gs_DeptCode

/////계정코드
tab_sheet.tabpage_1.dw_acct_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('계정코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
else
END IF
tab_sheet.tabpage_1.dw_acct_code.InsertRow(0)
tab_sheet.tabpage_1.dw_acct_code.Object.code.dddw.PercentWidth = 150
ldwc_Temp.SetSort('code ASC')
ldwc_Temp.Sort()
//tab_sheet.tabpage_1.dw_acct_code.settransobject(sqlca)//

tab_sheet.tabpage_2.dw_print3.settransobject(sqlca)
idw_print  = tab_sheet.tabpage_1.dw_print2

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 2.  초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;
 //////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
long ll_row

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
///////////////////////////////////////////////////////////////////////////////////////
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
IF tab_sheet.tabpage_sheet01.dw_update.AcceptText() = -1 THEN
	tab_sheet.tabpage_sheet01.dw_update.SetFocus()
	RETURN -1
END IF
IF tab_sheet.tabpage_sheet01.dw_update.ModifiedCount() + tab_sheet.tabpage_sheet01.dw_update.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN 0
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('필수입력항목 체크 중입니다.')
String	ls_NotNullCol[]
ls_NotNullCol[1] = 'rep_gwa/요구부서'
ls_NotNullCol[2] = 'rep_member_no/요구자'
ls_NotNullCol[3] = 'accept_gwa/접수부서'
ls_NotNullCol[4] = 'apply_amt/예산금액'
ls_NotNullCol[7] = 'stat_class/상태구분'
ls_NotNullCol[9] = 'rep_remark/수리내역'

IF f_chk_null(tab_sheet.tabpage_sheet01.dw_update,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status


Long		ll_GetRow

String	ls_IdNo			//등재번호
Long		ll_ItemClss		//품목구분
String	ls_ApplyDate	//신청일자
Long		ll_ApplyNo		//신청번호

DateTime	ldt_WorkDate	//수정일자
String	ls_Worker		//수정자
String	ls_IpAddr		//수정IP

ll_Row = tab_sheet.tabpage_sheet01.dw_update.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate = f_sysdate()					//수정일자
	ls_Worker    = gs_empcode		//수정자
	ls_IPAddr    = gs_ip	//수정IP
END IF
DO WHILE ll_Row > 0
	ldis_Status = tab_sheet.tabpage_sheet01.dw_update.GetItemStatus(ll_Row,0,Primary!)
	
	ls_IdNo      = tab_sheet.tabpage_sheet01.dw_update.Object.id_no     [ll_Row]		//등재번호
	ll_ItemClss  = tab_sheet.tabpage_sheet01.dw_update.Object.item_class[ll_Row]		//품목구분
	ls_ApplyDate = tab_sheet.tabpage_sheet01.dw_update.Object.apply_date[ll_Row]	
//신청일자
	/////////////////////////////////////////////////////////////////////////////////
	// 3.1 Max값 세팅
	/////////////////////////////////////////////////////////////////////////////////
	IF ldis_Status = New! OR ldis_Status = NewModified! THEN
		////////////////////////////////////////////////////////////////////////////
		// 3.1.1 신청번호 셋팅
		////////////////////////////////////////////////////////////////////////////
		SELECT	NVL(MAX(A.APPLY_NO),0) + 1
		INTO		:ll_ApplyNo
		FROM		STDB.HST030H	A
		WHERE		A.ID_NO = :ls_IdNo
		AND		A.APPLY_DATE = :ls_ApplyDate
		AND		A.ITEM_CLASS = :ll_ItemClss
		;
		CHOOSE CASE SQLCA.SQLCODE
			CASE 0
			CASE 100
				ll_ApplyNo = 1
			CASE ELSE
				MessageBox('오류','[신청번호]생성시 전산장애가 발생되었습니다.~r~n' + &
										'하단의 장애번호와 장애내역을~r~n' + &
										'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
										'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
										'장애내역 : ' + SQLCA.SqlErrText + '~r~n' + &
										'해당로우 : ' + String(ll_Row))
				RETURN -1
		END CHOOSE
		tab_sheet.tabpage_sheet01.dw_update.Object.apply_no[ll_Row] = ll_ApplyNo
		tab_sheet.tabpage_sheet01.ddlb_apply_no.AddItem(String(ll_ApplyNo,'0000'))
		tab_sheet.tabpage_sheet01.ddlb_apply_no.SelectItem(tab_sheet.tabpage_sheet01.ddlb_apply_no.TotalItems())

	END IF
	/////////////////////////////////////////////////////////////////////////////////
	// 3.2 수정항목 처리
	/////////////////////////////////////////////////////////////////////////////////
	tab_sheet.tabpage_sheet01.dw_update.Object.job_uid [ll_Row] = ls_Worker		//수정자
	tab_sheet.tabpage_sheet01.dw_update.Object.job_add [ll_Row] = ls_IPAddr		//수정IP
	tab_sheet.tabpage_sheet01.dw_update.Object.job_date[ll_Row] = ldt_WorkDate	//수정일자
	
	ll_Row = tab_sheet.tabpage_sheet01.dw_update.GetNextModified(ll_Row,primary!)
LOOP
///////////////////////////////////////////////////////////////////////////////////////
// 4. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('변경된 자료를 저장 중 입니다...')
//IF NOT tab_sheet.tabpage_sheet01.dw_update.TRIGGER EVENT ue_db_save() THEN RETURN -1

IF  tab_sheet.tabpage_sheet01.dw_update.UPDATE() = 1 THEN
	COMMIT USING SQLCA;
	//RETURN 1
ELSE
	ROLLBACK USING SQLCA;
	RETURN -1
END IF


///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지, 메뉴버튼 활성/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
tab_sheet.tabpage_sheet01.em_apply_date.Enabled = FALSE
tab_sheet.tabpage_sheet01.ddlb_apply_no.Enabled = FALSE
tab_sheet.tabpage_sheet01.dw_update.SetFocus()
RETURN 1
END CHOOSE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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
Long		ll_GetRow, LL_ROW

ii_tab = tab_sheet.selectedtab



CHOOSE CASE ii_tab
		
	CASE 1	
	 
		
//IF tab_sheet.tabpage_sheet01.dw_update.ib_RowSingle THEN 
	ll_GetRow = tab_sheet.tabpage_sheet01.dw_update.GetRow()
//IF NOT tab_sheet.tabpage_sheet01.dw_update.ib_RowSingle THEN ll_GetRow = tab_sheet.tabpage_sheet01.dw_update.GetSelectedRow(0)
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Integer	li_Rtn
Long		ll_DeleteCnt
//IF tab_sheet.tabpage_sheet01.dw_update.ib_RowSingle OR tab_sheet.tabpage_sheet01.dw_update.GetSelectedRow(ll_GetRow) = 0 THEN
	
	/////////////////////////////////////////////////////////////////////////////////
	// 2.2 삭제메세지 처리부분
	/////////////////////////////////////////////////////////////////////////////////
	String	ls_IdNo			//등재번호
	String	ls_ItemClss		//품목구분
	String	ls_ApplyDate	//신청일자
	String	ls_RepGwa		//요구부서
	String	ls_RepMember	//요구자
	String	ls_AcceptGwa	//접수부서
	String	ls_ApplyAmt		//예상금액

	ls_IdNo      = tab_sheet.tabpage_sheet01.dw_update.Object.id_no[ll_GetRow]
	ls_ItemClss  = tab_sheet.tabpage_sheet01.dw_update.Describe("Evaluate('lookupdisplay(item_class)',"+String(ll_GetRow)+")")
	ls_ApplyDate = tab_sheet.tabpage_sheet01.dw_update.Object.apply_date[ll_GetRow]
	ls_RepGwa    = tab_sheet.tabpage_sheet01.dw_update.Describe("Evaluate('lookupdisplay(rep_gwa)',"+String(ll_GetRow)+")")
	ls_RepMember = tab_sheet.tabpage_sheet01.dw_update.Object.com_rep_name[ll_GetRow]
	ls_AcceptGwa = tab_sheet.tabpage_sheet01.dw_update.Describe("Evaluate('lookupdisplay(accept_gwa)',"+String(ll_GetRow)+")")
	ls_ApplyAmt  = String(tab_sheet.tabpage_sheet01.dw_update.Object.apply_amt[ll_GetRow])
	
	IF isNull(ls_IdNo)      OR LEN(ls_IdNo)      = 0 THEN ls_IdNo = ''
	IF isNull(ls_ItemClss)  OR LEN(ls_ItemClss)  = 0 THEN ls_ItemClss = ''
	IF isNull(ls_ApplyDate) OR LEN(ls_ApplyDate) = 0 THEN ls_ApplyDate = ''
	IF isNull(ls_RepGwa)    OR LEN(ls_RepGwa)    = 0 THEN ls_RepGwa = ''
	IF isNull(ls_RepMember) OR LEN(ls_RepMember) = 0 THEN ls_RepMember = ''
	IF isNull(ls_AcceptGwa) OR LEN(ls_AcceptGwa) = 0 THEN ls_AcceptGwa = ''
	IF isNull(ls_ApplyAmt)  OR LEN(ls_ApplyAmt)  = 0 THEN ls_ApplyAmt = ''
	
	ls_Msg = '자료를 삭제하시겠습니까?~r~n~r~n' + &
				'등재번호 : ' + ls_IdNo + '~r~n' + &
				'품목구분 : ' + ls_ItemClss + '~r~n' + &
				'신청일자 : ' + ls_ApplyDate + '~r~n' + &
				'요구부서 : ' + ls_RepGwa + '~r~n' + &
				'요 구 자 : ' + ls_RepMember + '~r~n' + &
				'접수부서 : ' + ls_AcceptGwa + '~r~n' + &
				'예상금액 : ' + ls_ApplyAmt
//ELSE
//
//END IF

///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
//ll_DeleteCnt = tab_sheet.tabpage_sheet01.dw_update.TRIGGER EVENT ue_db_delete(ls_Msg)

IF  tab_sheet.tabpage_sheet01.dw_update.GetItemStatus(ll_GetRow,0,Primary!) <> New! THEN
		IF MessageBox('확인','자료를 삭제하시겠습니까?~r~n'+ls_Msg,&
									Question!,YesNo!,2) = 2 THEN
			RETURN 
		END IF
	END IF
	
//	THIS.SelectRow(0,FALSE)
//	ll_NextSelectRow = ll_GetRow + 1
//	THIS.ScrollToRow(ll_NextSelectRow)
//	THIS.SetRedraw(TRUE)

	 tab_sheet.tabpage_sheet01.dw_update.DeleteRow(ll_GetRow)
	 ll_deletecnt = 1

IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	//IF tab_sheet.tabpage_sheet01.dw_update.ib_RowSingle THEN
		/////////////////////////////////////////////////////////////////////////////
		// 3.1 Single 처리인 경우.
		//			3.1.1 저장처리.
		//			3.1.2 한로우를 다시 추가.
		//			3.1.3 데이타원도우를 읽기모드로 수정.
		/////////////////////////////////////////////////////////////////////////////
		//IF tab_sheet.tabpage_sheet01.dw_update.TRIGGER EVENT ue_db_save() THEN
			
			IF tab_sheet.tabpage_sheet01.dw_update.UPDATE() = 1 THEN
				COMMIT USING SQLCA;
				//RETURN 1
			ELSE
				ROLLBACK USING SQLCA;
				RETURN 
			END IF
			
//			tab_sheet.tabpage_sheet01.dw_update.TRIGGER EVENT ue_db_append()
			
//			IF ib_RowSingle THEN
			//	IF f_chk_update(THIS,'') = 3 THEN RETURN 0
				tab_sheet.tabpage_sheet01.dw_update.Reset()
//			END IF
			
			Long	ll_InsertRow
			ll_InsertRow = tab_sheet.tabpage_sheet01.dw_update.InsertRow(0)
			
			tab_sheet.tabpage_sheet01.dw_update.SetRow(ll_InsertRow)
			tab_sheet.tabpage_sheet01.dw_update.ScrollToRow(ll_InsertRow)
			tab_sheet.tabpage_sheet01.dw_update.SetFocus()
			//IF ib_RowSelect THEN
//				tab_sheet.tabpage_sheet01.dw_update.SelectRow(0,FALSE)
//				tab_sheet.tabpage_sheet01.dw_update.SelectRow(ll_InsertRow,TRUE)
//			ELSE
//				THIS.Object.DataWindow.HorizontalScrollPosition = 0
//			END IF
			
			//RETURN ll_InsertRow
			
			tab_sheet.tabpage_sheet01.dw_update.Object.DataWindow.ReadOnly = 'YES'
//			wf_SetMenu('R',TRUE)
//			wf_SetMenu('I',TRUE)
//			wf_SetMenu('D',TRUE)
//			wf_SetMenu('S',TRUE)
			tab_sheet.tabpage_sheet01.em_apply_date.Enabled = FALSE
			tab_sheet.tabpage_sheet01.ddlb_apply_no.Enabled = FALSE
	//	END IF
//	ELSE
//		/////////////////////////////////////////////////////////////////////////////
//		//	3.2 Multi 처리인 경우.
//		//			3.2.1 더이상 삭제할 로우가 있는지를 체크하여 활성/비활성화 처리한다.
//		/////////////////////////////////////////////////////////////////////////////
//		IF tab_sheet.tabpage_sheet01.dw_update.RowCount() > 0 THEN
//			wf_SetMenu('R',TRUE)
//			wf_SetMenu('I',TRUE)
//			wf_SetMenu('D',TRUE)
//			wf_SetMenu('S',TRUE)
//		ELSE
//			wf_SetMenu('R',TRUE)
//			wf_SetMenu('I',TRUE)
//			wf_SetMenu('D',FALSE)
//			wf_SetMenu('S',TRUE)
//		END IF
//	END IF
ELSE
END IF

END CHOOSE
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
// 1. 변경사항체크
///////////////////////////////////////////////////////////////////////////////////////
//Integer	li_Rtn
//
//ii_tab = tab_sheet.selectedtab
//
//CHOOSE CASE ii_tab
//		
//	CASE 1
//		
//IF tab_sheet.tabpage_sheet01.dw_update.AcceptText() = -1 THEN RETURN
//IF tab_sheet.tabpage_sheet01.dw_update.DeletedCount() > 0 OR tab_sheet.tabpage_sheet01.dw_update.ModifiedCount() > 0 THEN
//	li_Rtn = MessageBox('확인','변경된 자료가 있지만 아직 저장하지 않았습니다.~r~n' + &
//										'저장하지 않고 다른 작업을 하시려면 [예]를 누르십시오.',Question!,YesNo!,2)
//	
//	CHOOSE CASE	li_Rtn
//		CASE 1
//		CASE 2
//			tab_sheet.tabpage_sheet01.dw_update.SetFocus()
//			RETURN
//		CASE ELSE
//			
//	END CHOOSE
//END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
tab_sheet.tabpage_sheet01.dw_update.Reset()
tab_sheet.tabpage_sheet01.dw_update.InsertRow(0)
tab_sheet.tabpage_sheet01.dw_update.Object.DataWindow.ReadOnly = 'NO'

tab_sheet.tabpage_sheet01.dw_update_tab.Reset()

///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성화/비활성화처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('I',TRUE)		//입력버튼
//wf_setMenu('R',TRUE)		//조회버튼
//wf_Setmenu('D',FALSE)	//삭제버튼
//wf_Setmenu('S',FALSE)	//저장버튼
//wf_Setmenu('P',TRUE)		//인쇄버튼
tab_sheet.tabpage_sheet01.em_apply_date.Enabled = TRUE
tab_sheet.tabpage_sheet01.ddlb_apply_no.Enabled = TRUE
//END CHOOSE
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
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

type ln_templeft from w_tabsheet`ln_templeft within w_hgm202i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hgm202i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hgm202i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hgm202i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hgm202i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hgm202i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hgm202i
end type

type uc_insert from w_tabsheet`uc_insert within w_hgm202i
end type

type uc_delete from w_tabsheet`uc_delete within w_hgm202i
end type

type uc_save from w_tabsheet`uc_save within w_hgm202i
end type

type uc_excel from w_tabsheet`uc_excel within w_hgm202i
end type

type uc_print from w_tabsheet`uc_print within w_hgm202i
end type

type st_line1 from w_tabsheet`st_line1 within w_hgm202i
end type

type st_line2 from w_tabsheet`st_line2 within w_hgm202i
end type

type st_line3 from w_tabsheet`st_line3 within w_hgm202i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hgm202i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hgm202i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hgm202i
integer y = 168
integer width = 4384
integer height = 2112
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		f_setpointer('START')
//      wf_retrieve()
//		f_setpointer('END')		
//end choose

choose case newindex 
	Case 1, 2
		idw_print  = tab_sheet.tabpage_1.dw_print2
	Case 3
		idw_print  =tab_sheet.tabpage_2.dw_print3		

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
integer height = 1992
long backcolor = 1073741824
string text = "비품수리 신청"
dw_print dw_print
sle_room_nm sle_room_nm
sle_gwa_nm sle_gwa_nm
st_3 st_3
st_2 st_2
st_1 st_1
st_5 st_5
gb_1 gb_1
em_apply_date em_apply_date
ddlb_apply_no ddlb_apply_no
sle_item_nm sle_item_nm
st_4 st_4
st_6 st_6
dw_search1 dw_search1
dw_update dw_update
end type

on tabpage_sheet01.create
this.dw_print=create dw_print
this.sle_room_nm=create sle_room_nm
this.sle_gwa_nm=create sle_gwa_nm
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_5=create st_5
this.gb_1=create gb_1
this.em_apply_date=create em_apply_date
this.ddlb_apply_no=create ddlb_apply_no
this.sle_item_nm=create sle_item_nm
this.st_4=create st_4
this.st_6=create st_6
this.dw_search1=create dw_search1
this.dw_update=create dw_update
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.sle_room_nm
this.Control[iCurrent+3]=this.sle_gwa_nm
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.em_apply_date
this.Control[iCurrent+10]=this.ddlb_apply_no
this.Control[iCurrent+11]=this.sle_item_nm
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.dw_search1
this.Control[iCurrent+15]=this.dw_update
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.sle_room_nm)
destroy(this.sle_gwa_nm)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_5)
destroy(this.gb_1)
destroy(this.em_apply_date)
destroy(this.ddlb_apply_no)
destroy(this.sle_item_nm)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.dw_search1)
destroy(this.dw_update)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 3351
integer y = 12
integer width = 238
integer height = 92
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
integer y = 252
integer height = 892
string dataobject = "d_hgm202i_2"
end type

event dw_update_tab::rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: rowfocuschanged
//	기 능 설 명: 품목선택시 수리신청내역 Display
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////

IF currentrow = 0 OR isnull(currentrow) THEN
	RETURN	
END IF

String  ls_id_no
Long    ll_item_class, ll_row

Datawindow   dw_name
dw_name  = tab_sheet.tabpage_sheet01.dw_update_tab
ls_id_no = dw_name.object.id_no[currentrow]
ll_item_class = dw_name.object.item_class[currentrow]

ll_row = tab_sheet.tabpage_sheet01.dw_update.retrieve(ls_id_no, ll_item_class)
IF ll_row = 0 THEN
	tab_sheet.tabpage_sheet01.dw_update.insertrow(0)
END IF

///////////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////////
end event

type uo_tab from w_tabsheet`uo_tab within w_hgm202i
integer x = 1509
integer y = 156
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hgm202i
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hgm202i
boolean visible = false
end type

type dw_print from datawindow within tabpage_sheet01
boolean visible = false
integer x = 2373
integer y = 16
integer width = 411
integer height = 432
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst104i_5"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;
this.settransobject(sqlca)
end event

type sle_room_nm from singlelineedit within tabpage_sheet01
integer x = 1385
integer y = 116
integer width = 599
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "IBeam!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_gwa_nm from singlelineedit within tabpage_sheet01
integer x = 434
integer y = 116
integer width = 599
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "IBeam!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_sheet01
integer x = 1088
integer y = 128
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "사용장소"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_sheet01
integer x = 2053
integer y = 128
integer width = 201
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "품목명"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_sheet01
integer x = 155
integer y = 128
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "사용부서"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_sheet01
integer x = 9
integer y = 1160
integer width = 4334
integer height = 156
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 9
integer y = 20
integer width = 4338
integer height = 228
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type em_apply_date from editmask within tabpage_sheet01
integer x = 439
integer y = 1200
integer width = 370
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "IBeam!"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

event modified;//////////////////////////////////////////////////////////////////////////////////////////// 
////	이 벤 트 명: Modified::em_apply_date
////	기 능 설 명: 입고일자 변경시 날짜 체크
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 신청일자 입력오류체크
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_Date
//THIS.GetData(ls_Date)
//IF NOT f_chk_date(ls_Date,'YMD') THEN
//	f_dis_msg(3,'신청일자 입력오류입니다.','')
//	THIS.SetFocus()
//	RETURN
//END IF
//
///////////////////////////////////////////////////////////////////////////////////////////
////	2. 신청번호 셋팅
/////////////////////////////////////////////////////////////////////////////////////////
//wf_apply_no()
//
//IF ii_apply_num = 0  or isnull(ii_apply_num) THEN
//	dw_update.setredraw(FALSE)
//	dw_update.reset()
//	dw_update.insertrow(0)
//	dw_update.setredraw(TRUE)
//ELSE	
//	ddlb_apply_no.TRIGGER EVENT SELECTIONCHANGED(ddlb_apply_no.TOTALITEMS())
//END IF	
//////////////////////////////////////////////////////////////////////////////////////////// 
//// END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

type ddlb_apply_no from dropdownlistbox within tabpage_sheet01
integer x = 1152
integer y = 1200
integer width = 279
integer height = 544
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 33554432
string text = "none"
string item[] = {"","","","",""}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//
//ii_apply_num	=	Integer(THIS.text(index))
//em_apply_date.GetData(is_applydate)
//dw_update.setredraw(false)
//dw_update.retrieve(is_IdNo,ii_ItemClss, is_applydate, ii_apply_num )
//dw_update.setredraw(true)
//
//
end event

type sle_item_nm from singlelineedit within tabpage_sheet01
integer x = 2281
integer y = 116
integer width = 635
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "IBeam!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within tabpage_sheet01
integer x = 155
integer y = 1212
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청일자"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_sheet01
integer x = 878
integer y = 1212
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_search1 from datawindow within tabpage_sheet01
event dn_key pbm_dwnkey
integer x = 37
integer y = 96
integer width = 3735
integer height = 128
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm202i_3"
boolean border = false
boolean livescroll = true
end type

event dn_key;
String	ls_room_name
s_uid_uname	ls_middle


THIS.AcceptText()

IF key = KeyEnter! THEN 
	IF THIS.GetColumnName() = 'room' THEN				// 사용장소
		ls_room_name = THIS.object.room[1]
		OpenWithParm(w_hgm100h,ls_room_name)
		IF message.stringparm <> '' THEN
//			THIS.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
//			THIS.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
			THIS.object.room[1] = gstru_uid_uname.s_parm[2]	   
		END IF
   ELSEIF THIS.GetColumnName() = 'item' THEN		// 품목명
			ls_middle.uname = this.object.item[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

//				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
//				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
				this.object.item[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
	   wf_retrieve()
	END IF
END IF
end event

event constructor;//f_pro_toggle('k',handle(parent))
end event

event doubleclicked;
String	ls_room_name
s_uid_uname	ls_middle


THIS.AcceptText()

	IF dwo.name = 'room' THEN				// 사용장소
		ls_room_name = THIS.object.room[1]
		OpenWithParm(w_hgm100h,ls_room_name)
		IF message.stringparm <> '' THEN
//			THIS.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
//			THIS.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
			THIS.object.room[1] = gstru_uid_uname.s_parm[2]	   
		END IF
   ELSEIF dwo.name = 'item' THEN		// 품목명
			ls_middle.uname = this.object.item[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

//				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
//				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
				this.object.item[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
	   wf_retrieve()
	END IF
end event

type dw_update from uo_dwfree within tabpage_sheet01
integer x = 9
integer y = 1332
integer width = 4334
integer height = 652
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_hgm202i_1"
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: buttonclikced::dw_update
//	기 능 설 명: 데이타윈도우 버튼 클릭시 처리사항
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 상태바 CLEAR
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('')
IF row = 0 THEN RETURN
IF UPPER(THIS.Object.DataWindow.ReadOnly) = 'YES' THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
///////////////////////////////////////////////////////////////////////////////////////
String	ls_ColName 
String	ls_ColData
ls_ColName = STRING(dwo.name)

CHOOSE CASE ls_ColName
	CASE 'btn_rep_member','btn_audit_member'
		/////////////////////////////////////////////////////////////////////////////////
		// 2.1 연구책임자 입력여부 체크
		/////////////////////////////////////////////////////////////////////////////////
		THIS.AcceptText()
		
		s_insa_com	lstr_com
		String	ls_Name
		
		IF ls_ColName = 'btn_rep_member' THEN
			ls_Name = TRIM(THIS.Object.com_rep_name[row])
		ELSE
			ls_Name = TRIM(THIS.Object.com_audit_name[row])
		END IF
		
		lstr_com.ls_item[1] = ls_Name		//성명
		lstr_com.ls_item[2] = ''			//개인번호
		lstr_com.ls_item[3] = ''			//개인번호		
		/////////////////////////////////////////////////////////////////////////////////
		// 2.2 교직원 도움말 오픈
		/////////////////////////////////////////////////////////////////////////////////
		OpenWithParm(w_hgm201H,lstr_com)
		
		istr_com = Message.PowerObjectParm
		IF NOT isValid(istr_com) THEN
			THIS.SetFocus()
			RETURN
		END IF
		
		is_KName    = istr_com.ls_item[01]	//성명
		is_MemberNo = istr_com.ls_item[02]	//개인번호
		IF ls_ColName = 'btn_rep_member' THEN
			THIS.Object.com_rep_name [row] = is_KName			//성명
			THIS.Object.rep_member_no[row] = is_MemberNo		//개인번호
		ELSE
			THIS.Object.com_audit_name [row] = is_KName		//성명
			THIS.Object.audit_member_no[row] = is_MemberNo	//개인번호
		END IF
		THIS.SetFocus()
	CASE ELSE
END CHOOSE

////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1992
string text = "비품수리 신청서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_20 st_20
sle_2 sle_2
st_12 st_12
em_to_date em_to_date
st_11 st_11
em_fr_date em_fr_date
st_10 st_10
dw_print2 dw_print2
gb_2 gb_2
st_7 st_7
dw_search dw_search
dw_acct_code dw_acct_code
end type

on tabpage_1.create
this.st_20=create st_20
this.sle_2=create sle_2
this.st_12=create st_12
this.em_to_date=create em_to_date
this.st_11=create st_11
this.em_fr_date=create em_fr_date
this.st_10=create st_10
this.dw_print2=create dw_print2
this.gb_2=create gb_2
this.st_7=create st_7
this.dw_search=create dw_search
this.dw_acct_code=create dw_acct_code
this.Control[]={this.st_20,&
this.sle_2,&
this.st_12,&
this.em_to_date,&
this.st_11,&
this.em_fr_date,&
this.st_10,&
this.dw_print2,&
this.gb_2,&
this.st_7,&
this.dw_search,&
this.dw_acct_code}
end on

on tabpage_1.destroy
destroy(this.st_20)
destroy(this.sle_2)
destroy(this.st_12)
destroy(this.em_to_date)
destroy(this.st_11)
destroy(this.em_fr_date)
destroy(this.st_10)
destroy(this.dw_print2)
destroy(this.gb_2)
destroy(this.st_7)
destroy(this.dw_search)
destroy(this.dw_acct_code)
end on

type st_20 from statictext within tabpage_1
integer x = 2258
integer y = 116
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "계정과목"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within tabpage_1
integer x = 3438
integer y = 92
integer width = 329
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_12 from statictext within tabpage_1
integer x = 3173
integer y = 112
integer width = 265
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

type em_to_date from editmask within tabpage_1
integer x = 1810
integer y = 92
integer width = 407
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_11 from statictext within tabpage_1
integer x = 1751
integer y = 92
integer width = 59
integer height = 76
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

type em_fr_date from editmask within tabpage_1
integer x = 1339
integer y = 92
integer width = 407
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_10 from statictext within tabpage_1
integer x = 1074
integer y = 112
integer width = 279
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

type dw_print2 from datawindow within tabpage_1
string tag = "입찰공고조회"
integer x = 14
integer y = 260
integer width = 4329
integer height = 1732
integer taborder = 60
string title = "none"
string dataobject = "d_hgm202i_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 8
integer width = 4329
integer height = 228
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type st_7 from statictext within tabpage_1
integer x = 32
integer y = 108
integer width = 261
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청부서"
boolean focusrectangle = false
end type

type dw_search from datawindow within tabpage_1
integer x = 293
integer y = 92
integer width = 768
integer height = 84
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_gwa_code"
boolean border = false
boolean livescroll = true
end type

type dw_acct_code from datawindow within tabpage_1
integer x = 2519
integer y = 92
integer width = 608
integer height = 92
integer taborder = 90
boolean bringtotop = true
string dataobject = "ddw_acct_code_hgm"
boolean border = false
boolean livescroll = true
end type

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1992
string text = "비품수리신청리스트"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_13 st_13
re_to_date re_to_date
re_from_date re_from_date
st_9 st_9
st_8 st_8
dw_print3 dw_print3
gb_3 gb_3
dw_re_dept dw_re_dept
end type

on tabpage_2.create
this.st_13=create st_13
this.re_to_date=create re_to_date
this.re_from_date=create re_from_date
this.st_9=create st_9
this.st_8=create st_8
this.dw_print3=create dw_print3
this.gb_3=create gb_3
this.dw_re_dept=create dw_re_dept
this.Control[]={this.st_13,&
this.re_to_date,&
this.re_from_date,&
this.st_9,&
this.st_8,&
this.dw_print3,&
this.gb_3,&
this.dw_re_dept}
end on

on tabpage_2.destroy
destroy(this.st_13)
destroy(this.re_to_date)
destroy(this.re_from_date)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.dw_print3)
destroy(this.gb_3)
destroy(this.dw_re_dept)
end on

type st_13 from statictext within tabpage_2
integer x = 1865
integer y = 68
integer width = 59
integer height = 76
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

type re_to_date from editmask within tabpage_2
integer x = 1920
integer y = 80
integer width = 407
integer height = 80
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type re_from_date from editmask within tabpage_2
integer x = 1449
integer y = 80
integer width = 407
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_9 from statictext within tabpage_2
integer x = 1152
integer y = 88
integer width = 293
integer height = 60
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

type st_8 from statictext within tabpage_2
integer x = 32
integer y = 88
integer width = 293
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청부서"
boolean focusrectangle = false
end type

type dw_print3 from datawindow within tabpage_2
integer x = 9
integer y = 248
integer width = 4343
integer height = 1744
integer taborder = 70
string title = "none"
string dataobject = "d_hgm202p_7"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type gb_3 from groupbox within tabpage_2
integer y = 8
integer width = 4347
integer height = 208
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type dw_re_dept from datawindow within tabpage_2
integer x = 288
integer y = 72
integer width = 768
integer height = 84
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_gwa_code"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string  ls_re_dept_code

IF isnull(ls_re_dept_code) or	ls_re_dept_code = ''	 THEN
   ls_re_dept_code = '%'
	
END IF
end event

