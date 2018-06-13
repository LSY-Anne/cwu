$PBExportHeader$w_hgm501i_old.srw
$PBExportComments$물품 입고
forward
global type w_hgm501i_old from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type dw_update1 from cuo_dwwindow within tabpage_sheet01
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type dw_head from datawindow within tabpage_sheet01
end type
type dw_list1 from cuo_dwwindow within tabpage_sheet01
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type gb_5 from groupbox within tabpage_sheet01
end type
type gb_6 from groupbox within tabpage_sheet01
end type
type cb_1 from commandbutton within tabpage_sheet01
end type
type dw_update2 from cuo_dwwindow within tabpage_sheet01
end type
type dw_list2 from cuo_dwwindow within tabpage_sheet01
end type
type gb_3 from groupbox within tabpage_sheet01
end type
type cb_3 from commandbutton within tabpage_sheet01
end type
type cb_2 from commandbutton within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type st_6 from statictext within tabpage_1
end type
type sle_ord_numto from singlelineedit within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type dw_cust_code from datawindow within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type em_to_date from editmask within tabpage_1
end type
type em_fr_date from editmask within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type dw_print from cuo_dwwindow_one_hin within tabpage_1
end type
type dw_gwa_code from datawindow within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type sle_ord_numfr from singlelineedit within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type gb_7 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
st_6 st_6
sle_ord_numto sle_ord_numto
st_5 st_5
dw_cust_code dw_cust_code
st_4 st_4
em_to_date em_to_date
em_fr_date em_fr_date
st_3 st_3
dw_print dw_print
dw_gwa_code dw_gwa_code
st_2 st_2
sle_ord_numfr sle_ord_numfr
st_1 st_1
gb_7 gb_7
end type
end forward

global type w_hgm501i_old from w_tabsheet
string title = "물품 입고"
end type
global w_hgm501i_old w_hgm501i_old

type variables

int ii_tab
datawindowchild idw_child, idwc_stand_size

integer li_jan_qty
end variables

forward prototypes
public subroutine wf_jan_qty ()
public subroutine wf_delete ()
public function long wf_jan (string wfs_ord_no, string wfs_req_no, long wfs_item_seq)
public subroutine wf_retrieve ()
public subroutine wf_insert ()
public subroutine wf_update ()
end prototypes

public subroutine wf_jan_qty ();if tab_sheet.tabpage_sheet01.dw_update1.getrow() > 0 then
	li_jan_qty = tab_sheet.tabpage_sheet01.dw_update1.object.in_qty[tab_sheet.tabpage_sheet01.dw_update1.getrow()]
end if

end subroutine

public subroutine wf_delete ();     Long  ll_count,ll_inqty, ll_in_qty
	  String ls_gwa, ls_item_no, ls_year
	  
	  Datawindow   dw_iname
	  dw_iname = tab_sheet.tabpage_sheet01.dw_update1

	  dw_iname.accepttext()	  
	  
	  ls_gwa     = dw_iname.Object.gwa[1]
	  ls_item_no = dw_iname.Object.item_no[1]
	  ls_year    = left(dw_iname.Object.in_date[1],6)
	  ll_inqty   = dw_iname.Object.in_qty[1]
		  
		  select count(jeago_date), in_qty
		  into   :ll_count, :ll_in_qty
		  from   stdb.hst110h
		  where  jeago_date = :ls_year
		  and    gwa        = :ls_gwa
		  and    item_no    = :ls_item_no
		  group by in_qty;

		  IF ll_count = 0 THEN
			  DELETE FROM STDB.HST110H 
			  where  jeago_date = :ls_year
		     and    gwa        = :ls_gwa
		     and    item_no    = :ls_item_no;
		  ELSE
			  update  stdb.hst110h
			  set     in_qty =  :ll_in_qty - :ll_inqty
			  where  jeago_date = :ls_year
		     and    gwa        = :ls_gwa
		     and    item_no    = :ls_item_no;  
		  END IF
       
		  IF sqlca.sqlcode <> 0 THEN
			  messagebox('확인','저정에 실패 하였습니다..!')
		  END IF
end subroutine

public function long wf_jan (string wfs_ord_no, string wfs_req_no, long wfs_item_seq);
long ll_update_qty, ll_in_qty

SELECT NVL(UPDATE_QTY,0)
INTO :ll_update_qty
FROM STDB.HST105H
WHERE ORD_NO = :wfs_ord_no  AND REQ_NO = :wfs_req_no AND ITEM_SEQ = :wfs_item_seq  ;

SELECT NVL(SUM(IN_QTY),0)
INTO :ll_in_qty
FROM STDB.HST109H
WHERE ORD_NO = :wfs_ord_no  AND REQ_NO = :wfs_req_no AND ITEM_SEQ = :wfs_item_seq  ;

RETURN ll_update_qty - ll_in_qty
end function

public subroutine wf_retrieve ();
datawindow dw_sname
int 		li_chk, idx
string 	ls_ord_no, ls_item_middle, ls_item_name, ls_cust_name, ls_dept_code, ls_item_no
String   ls_ord_numfr, ls_ord_numto , ls_gwa_code, ls_fr_date, ls_to_date
string	ls_fr, ls_to, ls_dept, ls_acct, ls_cust_no
Long  ll_RowCnt
ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

		dw_sname = tab_sheet.tabpage_sheet01.dw_head
 		dw_sname.accepttext()
		tab_sheet.tabpage_sheet01.dw_update1.accepttext() 
      
		ls_ord_no = trim(dw_sname.object.c_ord_no[1]) + '%'
		ls_item_middle = trim(dw_sname.object.c_item_middle[1]) + '%'
		ls_item_name = trim(dw_sname.object.c_item_name[1]) + '%'
		ls_cust_name = trim(dw_sname.object.c_cust_name[1]) + '%'
		ls_dept_code = trim(dw_sname.object.c_dept_code[1]) + '%'
		li_chk = dw_sname.object.c_chk[1]
		
		IF ISNULL(ls_ord_no) THEN ls_ord_no = '%'
		IF ISNULL(ls_item_middle) THEN ls_item_middle = '%'
      IF ISNULL(ls_item_name) THEN ls_item_name = '%'
		IF ISNULL(ls_cust_name) THEN ls_cust_name = '%'
      IF ISNULL(ls_dept_code) THEN ls_dept_code = '%'

		IF tab_sheet.tabpage_sheet01.dw_list1.retrieve(ls_ord_no, ls_item_middle, ls_item_name, ls_cust_name, ls_dept_code, li_chk ) <> 0 THEN
			tab_sheet.tabpage_sheet01.dw_list1.trigger event rowfocuschanged(1)			
		ELSE
			tab_sheet.tabpage_sheet01.dw_update1.reset()

			ls_item_no = '%'
			tab_sheet.tabpage_sheet01.dw_update1.getChild("item_size", idwc_stand_size)
			idwc_stand_size.settransobject(sqlca)
			idwc_stand_size.retrieve(ls_item_no)

			tab_sheet.tabpage_sheet01.dw_update1.insertrow(0)
			tab_sheet.tabpage_sheet01.dw_update2.reset()			
		END IF	
	CASE 2
		dw_sname = tab_sheet.tabpage_1.dw_print
		dw_sname.accepttext()

		 ls_ord_numfr  = tab_sheet.tabpage_1.sle_ord_numfr.text 
		 ls_ord_numto  = tab_sheet.tabpage_1.sle_ord_numto.text 
		 
		 IF ISNULL(ls_ord_numfr) OR ls_ord_numfr= ''THEN ls_ord_numfr = '0000000000'
		 IF ISNULL(ls_ord_numto) OR ls_ord_numto= ''THEN ls_ord_numto = '9999999999'
		 
		 ls_gwa_code = trim(tab_sheet.tabpage_1.dw_gwa_code.Object.code[1]) 
		 ls_cust_no  = trim(tab_sheet.tabpage_1.dw_cust_code.Object.code[1])
	
		 ls_fr_date  = left(tab_sheet.tabpage_1.em_fr_date.text,4)+mid(tab_sheet.tabpage_1.em_fr_date.text,6,2)+ &
		               right(tab_sheet.tabpage_1.em_fr_date.text,2)

		 ls_to_date  = left(tab_sheet.tabpage_1.em_to_date.text,4)+mid(tab_sheet.tabpage_1.em_to_date.text,6,2)+ &
		               right(tab_sheet.tabpage_1.em_to_date.text,2)
		
		 IF isnull(ls_gwa_code) OR ls_gwa_code = '' OR  ls_gwa_code = '0000' THEN
			 ls_gwa_code = '%'
		 ELSE
			 ls_gwa_code = trim(tab_sheet.tabpage_1.dw_gwa_code.Object.code[1]) 
		 END IF 
//		 messagebox('',ls_ord_numfr+':'+ ls_ord_numto )
		 ll_RowCnt = tab_sheet.tabpage_1.dw_print.retrieve(ls_ord_numfr, ls_ord_numto, ls_fr_date, ls_to_Date, ls_gwa_code,ls_cust_no)

     IF ll_RowCnt <> 0 THEN
      String ls_gwa, ls_member_no
		int    i
       for  i =1 to tab_sheet.tabpage_1.dw_print.rowcount()
       
		    ls_member_no = tab_sheet.tabpage_1.dw_print.object.hst108h_audit_member_no[i]
            select gwa
		      into  :ls_gwa
		      from  indb.hin001m
		      where member_no = :ls_member_no;
	  
		    tab_sheet.tabpage_1.dw_print.object.hst106h_gwa[i] = ls_gwa
	    next
	  END IF 
	  
		 IF ll_RowCnt = 0 THEN
			 wf_SetMsg('조회된 자료가없습니다..!')
//			 wf_Setmenu('R',TRUE)
		 ELSE
			 wf_SetMsg('자료가 조회되었습니다..!')
//			 wf_Setmenu('R',TRUE)
//			 wf_Setmenu('p',TRUE)
		 END IF
//	CASE 3
//		 ls_fr = left(tab_sheet.tabpage_2.em_fr.text,4)+mid(tab_sheet.tabpage_2.em_fr.text,6,2)+ &
//		         right(tab_sheet.tabpage_2.em_fr.text,2)
//
//		 ls_to = left(tab_sheet.tabpage_2.em_to.text,4)+mid(tab_sheet.tabpage_2.em_to.text,6,2)+ &
//		         right(tab_sheet.tabpage_2.em_to.text,2)
//	
//		 tab_sheet.tabpage_2.dw_gwa.accepttext()
//		 ls_dept = tab_sheet.tabpage_2.dw_gwa.Object.code[1] 
//
//		 IF isnull(ls_dept) OR ls_dept = '' OR  ls_dept = '0000' THEN
//			 ls_dept = '%'
//		 ELSE
//			 ls_dept = trim(tab_sheet.tabpage_2.dw_gwa.Object.code[1]) 
//		 END IF 
//		 
//		 tab_sheet.tabpage_2.dw_acct.accepttext()
//		 ls_acct = tab_sheet.tabpage_2.dw_acct.Object.code[1] 
//		 
//		 IF isnull(ls_acct) OR ls_acct = '' THEN
//			 ls_acct = '%'
//		 ELSE
//				 ls_acct = trim(tab_sheet.tabpage_2.dw_acct.Object.code[1]) 
//		 END IF 
//		 
//		 ll_RowCnt = tab_sheet.tabpage_2.dw_print_list.retrieve(ls_fr, ls_to, ls_dept, ls_acct)
//		 IF ll_RowCnt <> 0 THEN
//			 for  i =1 to tab_sheet.tabpage_1.dw_print.rowcount()
//			 
//				 ls_member_no = tab_sheet.tabpage_1.dw_print.object.hst108h_audit_member_no[i]
//					select gwa
//					into  :ls_dept
//					from  indb.hin001m
//					where member_no = :ls_member_no;
//		  
//				 tab_sheet.tabpage_1.dw_print.object.hst106h_gwa[i] = ls_dept
//			 next
//			 IF ll_RowCnt = 0 THEN
//				 wf_SetMsg('조회된 자료가없습니다..!')
//				 wf_Setmenu('R',TRUE)
//			 ELSE
//				 wf_SetMsg('자료가 조회되었습니다..!')
//				 wf_Setmenu('R',TRUE)
//				 wf_Setmenu('p',TRUE)
//			 END IF
//		 END IF
END CHOOSE		
  
wf_jan_qty()

end subroutine

public subroutine wf_insert ();
ii_tab  = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		
		idw_name = tab_sheet.tabpage_sheet01.dw_update1
		
		idw_name.reset()
		
		idw_name.getChild("item_size", idwc_stand_size)
		idwc_stand_size.settransobject(sqlca)
		idwc_stand_size.retrieve('0000000')
		idwc_stand_size.insertrow(0)
				
	   idw_name.insertrow(0)
	   idw_name.object.in_date[1] = f_today()  
	   idw_name.object.work_date[1] = f_sysdate()  
		idw_name.object.worker[1] = gstru_uid_uname.uid     
		idw_name.object.ipaddr[1] = gstru_uid_uname.address  //IP
		
	   idw_name.setfocus()
		
		tab_sheet.tabpage_sheet01.dw_update2.reset()
		
END CHOOSE


end subroutine

public subroutine wf_update ();     Long  ll_count,ll_inqty, ll_in_qty
	  String ls_gwa, ls_item_no, ls_year
	  
	  Datawindow   dw_iname
	  dw_iname = tab_sheet.tabpage_sheet01.dw_update1

	  dw_iname.accepttext()	  
	  
	  ls_gwa     = dw_iname.Object.gwa[1]
	  ls_item_no = dw_iname.Object.item_no[1]
	  ls_year    = left(dw_iname.Object.in_date[1],6)
	  ll_inqty   = dw_iname.Object.in_qty[1]
		  
		  select count(jeago_date), in_qty
		  into   :ll_count, :ll_in_qty
		  from   stdb.hst110h
		  where  jeago_date = :ls_year
		  and    gwa        = :ls_gwa
		  and    item_no    = :ls_item_no
		  group by in_qty;
  
		
		  IF ll_count = 0 THEN
			  insert into stdb.hst110h(jeago_date, item_no, gwa, in_qty, out_qty)
			  values (:ls_year, :ls_item_no, :ls_gwa, :ll_inqty, 0 );
		  ELSE
			  update  stdb.hst110h
			  set     in_qty = :ll_inqty + :ll_in_qty
			  where  jeago_date = :ls_year
		     and    gwa        = :ls_gwa
		     and    item_no    = :ls_item_no;  
		  END IF
		  IF sqlca.sqlcode <> 0 THEN
			  messagebox('확인','저정에 실패 하였습니다..!')
		  END IF
		  
end subroutine

on w_hgm501i_old.create
int iCurrent
call super::create
end on

on w_hgm501i_old.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;
wf_retrieve()

return 1



end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 물품입고등록
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)

tab_sheet.tabpage_sheet01.dw_head.reset()
tab_sheet.tabpage_sheet01.dw_head.insertrow(0)
tab_sheet.tabpage_sheet01.dw_list1.reset()
tab_sheet.tabpage_sheet01.dw_list2.reset()
tab_sheet.tabpage_sheet01.dw_update2.reset()
tab_sheet.tabpage_1.dw_gwa_code.insertrow(0)
tab_sheet.tabpage_1.dw_cust_code.insertrow(0)

idw_name = tab_sheet.tabpage_sheet01.dw_update1

f_childretrieve(idw_name,"item_class","item_class")             // 품목구분 
f_childretrieve(idw_name,"purchase_opt","purchase_opt")         // 구매방법
f_childretrieve(idw_name,"revenue_opt","revenue_opt")           // 구입재원
f_childretrieve(idw_name,"nation_code","kukjuk_code")           // 제조국가
f_childretrieve(idw_name,"proof_gubun","proof_gubun")           // 증빙구분

idw_name.getChild("item_size", idwc_stand_size)
idwc_stand_size.settransobject(sqlca)
idwc_stand_size.retrieve('0000000')
idwc_stand_size.insertrow(0)

f_childretrieve(tab_sheet.tabpage_1.dw_print,"hst109h_proof_gubun","proof_gubun")     // 증빙구분

wf_insert()

f_childretrieve(tab_sheet.tabpage_sheet01.dw_update2,"audit_opt","audit_opt")         // 검수자 구분 

f_childretrieven(tab_sheet.tabpage_sheet01.dw_head,"c_dept_code")            			  // 부 서

tab_sheet.tabpage_1.em_fr_date.text  = f_today()
tab_sheet.tabpage_1.em_to_date.text  = f_today()


Long ll_InsRow
DataWindowChild	ldwc_Temp
tab_sheet.tabpage_1.dw_gwa_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa','0000')
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
	ldwc_Temp.SetSort('gwa ASC')
	ldwc_Temp.Sort()
END IF

tab_sheet.tabpage_1.dw_cust_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('거래처코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetSort('cust_no ASC')
	ldwc_Temp.Sort()
END IF
f_childretrieve(tab_sheet.tabpage_1.dw_print,"proof_gubun","proof_gubun")           // 증빙구분
tab_sheet.tabpage_1.dw_print.Object.DataWindow.print.preview = 'YES'
end event

event ue_save;call super::ue_save;
int li_tab, i, li_jrow
datawindow dw_iname, dw_jname
long ll_in_qty, ll_jan_qty, ll_in_no, ll_item_seq, ll_in_qty2, ll_update_qty
string ls_ord_no, ls_cur_year, ls_req_no


li_tab = tab_sheet.selectedtab

CHOOSE CASE li_tab
		
	CASE 1
     
	  dw_iname = tab_sheet.tabpage_sheet01.dw_update1
	  dw_jname = tab_sheet.tabpage_sheet01.dw_update2
	  	  
	  dw_iname.accepttext()	  
  
  	  IF f_chk_modified(dw_iname) = FALSE AND f_chk_modified(dw_jname) = FALSE THEN RETURN    -1
  
     ls_ord_no     = dw_iname.object.ord_no[1]                // 발주 번호 
     ls_req_no     = dw_iname.object.req_no[1]                // 발주 번호 
     ll_item_seq   = dw_iname.object.item_seq[1]              // 발주 번호
	  ll_update_qty = dw_iname.object.update_qty[1]            // 발주 수량
	  ll_in_qty     = dw_iname.object.in_qty[1]                // 입고 수량 
	  ll_jan_qty    = dw_iname.object.jan_qty[1]               // 입고 잔량 
	  
	  ll_in_qty2 = ll_in_qty
	  dw_iname.object.in_qty[1]  =  ll_in_qty2
	 
	 
	 IF ll_in_qty = 0 THEN
		  messagebox("확인","입고 수량을 입력하세요")
		  RETURN  -1
	  END IF
 
	  IF ll_in_qty2 = ll_update_qty THEN                  // 입고 잔량과 입고 수량이 같으면   
	  
		  UPDATE STDB.HST105H                              // 물품 신청 T에 물품 상태를 '입고'로 바꾼다 
		  SET ORD_CLASS = 7            
		  WHERE REQ_NO = :ls_req_no AND ITEM_SEQ = :ll_item_seq  ;
	  
	     UPDATE STDB.HST106H                             // 발주 T에  물품 상태를 '입고'로 바꾼다 (6:발주, 7:입고)  
		  SET ORD_CLASS = 7            
		  WHERE REQ_NO = :ls_req_no AND ITEM_SEQ = :ll_item_seq  ;
	  
     END IF

	  dwItemStatus l_status 
	  l_status = dw_iname.getitemstatus(1, 0, Primary!)
	
	  IF l_status = New! OR l_status = NewModified! THEN 
	  
		  SELECT NVL(MAX(IN_NO),0)
		  INTO :ll_in_no
		  FROM STDB.HST109H    
		  WHERE ORD_NO 	= :ls_ord_no  
		  AND   REQ_NO 	= :ls_req_no 
		  AND	  ITEM_SEQ 	= :ll_item_seq  ;

		  ll_in_no = ll_in_no + 1
		  
		  dw_iname.object.in_no[1] = ll_in_no
	  
     ELSE
	  
	     ll_in_no = dw_iname.object.in_no[1]
	  
     END IF
	  
	  IF  dw_jname.rowcount() = 0 THEN
		   messagebox('확인','검수자를 입력하시기 바랍니다..!')
	    RETURN -1
     END IF
	  li_jrow = dw_jname.rowcount()
	  FOR i = 1 TO li_jrow
		
		   dw_jname.object.in_no[i]    =  ll_in_no
			dw_jname.object.job_uid[i]  =  gstru_uid_uname.uid		  //수정자
		   dw_jname.object.job_date[i] =  f_sysdate()              // 오늘 일자 
		   dw_jname.object.job_add[i]  =  gstru_uid_uname.address  //IP
	  
     NEXT 
	 	  
	   dw_jname.object.ord_no[dw_jname.getrow()]   = dw_iname.object.ord_no[1]                // 발주 번호 
	   dw_jname.object.req_no[dw_jname.getrow()]   = dw_iname.object.req_no[1]                // 접수 번호 
	   dw_jname.object.item_seq[dw_jname.getrow()] = dw_iname.object.item_seq[1]              // 품목 번호 
	   string ls_icolarry[] = {'ord_no/발주 번호','item_no/품목코드','item_class/물품구분',&
		                         'purchase_opt/구매방법','revenue_opt/재원','nation_code/제조국가',&
										 'useful_opt/구입용도', 'model/모델', 'maker/제조업체'}
	   string ls_jcolarry[] = {'audit_member_no/검수자'}
     
	  //불출처리 테이블 업데이트
		IF dw_iname.object.goods_kind[1] = '2' THEN
			wf_update()
		END IF
		
		
	  IF f_chk_null( dw_iname, ls_icolarry ) = 1 AND f_chk_null( dw_jname, ls_jcolarry ) = 1 THEN 

		  dw_iname.object.job_uid[1]  =  gstru_uid_uname.uid		  //수정자
		  dw_iname.object.job_date[1] =  f_sysdate()               // 오늘 일자 
		  dw_iname.object.job_add[1]  =  gstru_uid_uname.address   //IP

		  IF f_update2( dw_iname, dw_jname, 'U') = TRUE THEN
				commit;
		     wf_retrieve()
			  wf_setmsg("저장되었습니다")
		  else
				rollback;
		  END IF
			  
	  END IF	
	  
END CHOOSE		




end event

event ue_delete;call super::ue_delete;
int li_tab, li_rowcount
long li_row, ll_in_no
string ls_ord_no


ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name = tab_sheet.tabpage_sheet01.dw_update1
	      			
		dwItemStatus l_status 
		l_status = idw_name.getitemstatus(1, 0, Primary!)
	
		IF l_status = New! OR l_status = NewModified! THEN 

		ELSE
			
			IF messagebox("확인","입고를 취소하시겠습니까?", Question!, YesNo! ,2 ) = 1 THEN
				
					  
            ls_ord_no = idw_name.object.ord_no[1]
	    
			   UPDATE STDB.HST105H        // 물품신청 테이블에 물품 상태를 '발주'로 바꾼다 
			   SET ORD_CLASS = 6            
			   WHERE ORD_NO = :ls_ord_no  ;
		  
			   UPDATE STDB.HST106H        // 발주 테이블에 발주 상태를 '발주'로 바꾼다(1:발주,2:입고) 
			   SET ORD_CLASS = 6           
			   WHERE ORD_NO = :ls_ord_no  ;
	  			
				ll_in_no = idw_name.object.in_no[1]   
				 
				IF idw_name.object.goods_kind[1] = '2' THEN
			      wf_delete()
		      END IF
				
				DELETE FROM STDB.HST108H WHERE IN_NO = :ll_in_no AND ORD_NO = :ls_ord_no ;    // 검수자 테이블을 DELETE한다
				
				idw_name.deleterow(0)				
				
				
				IF f_update( idw_name,'D') = TRUE THEN 
					wf_retrieve()
					wf_setmsg("삭제되었습니다")
				END IF
			END IF
		END IF
END CHOOSE



end event

event ue_insert;call super::ue_insert;
wf_insert()
end event

event ue_print;call super::ue_print;		f_print(tab_sheet.tabpage_1.dw_print)
	

end event

event ue_init;call super::ue_init;tab_sheet.tabpage_1.dw_gwa_code.reset()
tab_sheet.tabpage_1.dw_gwa_code.insertrow(0)

tab_sheet.tabpage_1.dw_cust_code.reset()
tab_sheet.tabpage_1.dw_cust_code.insertrow(0)
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hgm501i_old
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hgm501i_old
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hgm501i_old
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hgm501i_old
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hgm501i_old
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hgm501i_old
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hgm501i_old
end type

type uc_insert from w_tabsheet`uc_insert within w_hgm501i_old
end type

type uc_delete from w_tabsheet`uc_delete within w_hgm501i_old
end type

type uc_save from w_tabsheet`uc_save within w_hgm501i_old
end type

type uc_excel from w_tabsheet`uc_excel within w_hgm501i_old
end type

type uc_print from w_tabsheet`uc_print within w_hgm501i_old
end type

type st_line1 from w_tabsheet`st_line1 within w_hgm501i_old
end type

type st_line2 from w_tabsheet`st_line2 within w_hgm501i_old
end type

type st_line3 from w_tabsheet`st_line3 within w_hgm501i_old
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hgm501i_old
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hgm501i_old
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hgm501i_old
integer x = 18
integer y = 12
integer width = 3835
integer height = 2484
tabpage_1 tabpage_1
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		f_setpointer('START')
//      wf_retrieve()
//		f_setpointer('END')		
//end choose
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
string text = "물품 입고 등록"
gb_2 gb_2
dw_update1 dw_update1
gb_1 gb_1
dw_head dw_head
dw_list1 dw_list1
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
cb_1 cb_1
dw_update2 dw_update2
dw_list2 dw_list2
gb_3 gb_3
cb_3 cb_3
cb_2 cb_2
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.dw_update1=create dw_update1
this.gb_1=create gb_1
this.dw_head=create dw_head
this.dw_list1=create dw_list1
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.cb_1=create cb_1
this.dw_update2=create dw_update2
this.dw_list2=create dw_list2
this.gb_3=create gb_3
this.cb_3=create cb_3
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_update1
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_head
this.Control[iCurrent+5]=this.dw_list1
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.gb_5
this.Control[iCurrent+8]=this.gb_6
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_update2
this.Control[iCurrent+11]=this.dw_list2
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.cb_3
this.Control[iCurrent+14]=this.cb_2
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.dw_update1)
destroy(this.gb_1)
destroy(this.dw_head)
destroy(this.dw_list1)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.cb_1)
destroy(this.dw_update2)
destroy(this.dw_list2)
destroy(this.gb_3)
destroy(this.cb_3)
destroy(this.cb_2)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 3369
integer y = 264
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
end type

type uo_tab from w_tabsheet`uo_tab within w_hgm501i_old
end type

type dw_con from w_tabsheet`dw_con within w_hgm501i_old
end type

type st_con from w_tabsheet`st_con within w_hgm501i_old
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 526
integer y = 1104
integer width = 3250
integer height = 768
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "입고 내역"
end type

type dw_update1 from cuo_dwwindow within tabpage_sheet01
integer x = 535
integer y = 1152
integer width = 3214
integer height = 692
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgm501i_4"
boolean border = false
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;
string ls_item_name

this.accepttext()

IF dwo.name = 'item_no' THEN

   SELECT ITEM_NAME
	INTO :ls_item_name
	FROM STDB.HST004M
	WHERE ITEM_NO = :data   ;

   this.object.item_name[1] = ls_item_name

END IF

IF dwo.name = 'in_qty' THEN
	
	IF this.object.jan_qty[1] < this.object.in_qty[1] THEN		
		messagebox("확인","입고 수량이 입고 잔량보다 큽니다. 조정하세요.")
	   RETURN 1
	END IF
	
END IF

this.object.in_amt[1] = this.object.in_qty[1] * this.object.in_price[1]

end event

event dberror;call super::dberror;//IF sqldbcode = 1 THEN
//	messagebox("확인",'중복된 값이 있습니다.')
//	setcolumn(1)
//	setfocus()
//END IF
//
//RETURN 1
end event

event doubleclicked;call super::doubleclicked;
long ll_rowcount, i
string ls_item_no, ls_item_name, ls_item_middle
s_uid_uname	ls_middle

	
IF dwo.name = 'item_no' THEN                       // 품목 코드 
 
	ls_item_no = this.object.item_no[1]
	IF tab_sheet.tabpage_sheet01.dw_list1.ROWCOUNT() <= 0  THEN
		LS_ITEM_MIDDLE	=	" "
	ELSE	
	ls_item_middle	=	tab_sheet.tabpage_sheet01.dw_list1.object.item_middle[tab_sheet.tabpage_sheet01.dw_list1.getrow()]
	END IF
	ls_middle.uid	=	ls_item_no
	ls_middle.uname	=	ls_item_middle

	
	openwithparm(w_hgm001h,ls_middle)
		
	IF message.stringparm <> '' THEN
		
		this.object.item_no[1] = gstru_uid_uname.s_parm[1]
		this.object.item_name[1] = gstru_uid_uname.s_parm[2]
		
	END IF
	
END IF

end event

event itemerror;call super::itemerror;RETURN 1
end event

event key_enter;call super::key_enter;
long ll_rowcount, i
string ls_item_no, ls_item_name, ls_item_middle
s_uid_uname	ls_middle

	
IF this.getcolumnname() = 'item_no' THEN                       // 품목 코드 
 
	ls_item_no = this.object.item_no[1]
	IF tab_sheet.tabpage_sheet01.dw_list1.ROWCOUNT() <= 0  THEN
		LS_ITEM_MIDDLE	=	" "
	ELSE	
	ls_item_middle	=	tab_sheet.tabpage_sheet01.dw_list1.object.item_middle[tab_sheet.tabpage_sheet01.dw_list1.getrow()]
	END IF
	ls_middle.uid	=	ls_item_no
	ls_middle.uname	=	ls_item_middle

	
	openwithparm(w_hgm001h,ls_middle)
		
	IF message.stringparm <> '' THEN
		
		this.object.item_no[1] = gstru_uid_uname.s_parm[1]
		this.object.item_name[1] = gstru_uid_uname.s_parm[2]
		
	END IF
	
END IF

end event

event retrieveend;call super::retrieveend;String  ls_item_no, ls_item_size

if rowcount > 0 then
	this.accepttext()   
	ls_item_no   			= this.object.item_no[rowcount]
	ls_item_size   		= this.object.item_size[rowcount]
	
	IF isnull(ls_item_no) OR ls_item_no ='' THEN
		ls_item_no = '%'
	END IF
	IF isnull(ls_item_size) OR ls_item_size ='' THEN
		ls_item_size = '%'
	END IF

	this.getChild("item_size", idwc_stand_size)
	idwc_stand_size.settransobject(sqlca)
	idwc_stand_size.retrieve(ls_item_no)
end if


end event

event retrievestart;call super::retrievestart;this.getChild("item_size", idwc_stand_size)
idwc_stand_size.settransobject(sqlca)
idwc_stand_size.retrieve('0000000')
idwc_stand_size.insertrow(0)

end event

type gb_1 from groupbox within tabpage_sheet01
integer x = 23
integer y = 32
integer width = 3223
integer height = 264
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "물품 발주 조회 조건"
end type

type dw_head from datawindow within tabpage_sheet01
event ue_keydown pbm_dwnkey
integer x = 32
integer y = 104
integer width = 3191
integer height = 160
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm501i_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
IF key = keyenter! THEN wf_retrieve()
end event

event constructor;f_pro_toggle('k',handle(parent))
end event

type dw_list1 from cuo_dwwindow within tabpage_sheet01
integer x = 23
integer y = 312
integer width = 3753
integer height = 772
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "물품발주내역"
string dataobject = "d_hgm501i_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;call super::doubleclicked;
int li_row, li_ord_class
string ls_ord_no, ls_req_no, ls_SysDate 
long		ll_item_seq

IF row = 0 THEN RETURN
		
li_ord_class = this.getitemnumber(row, 'ord_class')

idw_name = tab_sheet.tabpage_sheet01.dw_update1

dwItemStatus l_status 
l_status = idw_name.getitemstatus(1, 0, Primary!)

//IF l_status = New! OR l_status = NewModified! THEN 
if li_ord_class <> 7 then
	idw_name.reset()
	idw_name.setredraw(false)
   
	ls_ord_no = this.object.ord_no[row]
	ls_req_no = this.object.req_no[row]
	ll_item_Seq  = this.object.item_Seq[row]
   idw_name.object.ord_no[1] = ls_ord_no
   idw_name.object.item_no[1] = this.object.item_middle[row]
	idw_name.object.item_name[1] = this.object.itm_name[row]
	idw_name.object.cust_no[1] = this.object.cust_no[row]
	idw_name.object.goods_kind[1] = this.object.goods_kind[row]
	idw_name.object.gwa[1] = this.object.apply_gwa_1[row]
	idw_name.object.req_no[1] = this.object.req_no[row]
	idw_name.object.item_seq[1] = this.object.item_seq[row]
	idw_name.object.jumun_date[1] = this.object.jumun_date[row]
	idw_name.object.update_qty[1] = this.object.update_qty[row]
	idw_name.object.in_price[1] = this.object.quot_price[row]
	idw_name.object.devilery_date[1] = this.object.devilery_date[row]
	idw_name.object.req_date[1] = this.object.apply_date[row]
	
	STring ls_date
	ls_date = idw_name.object.req_date[1]
	idw_name.object.jan_qty[1] = wf_jan( ls_ord_no , ls_req_no, ll_item_seq)
	idw_name.object.in_qty[1]  = wf_jan( ls_ord_no , ls_req_no, ll_item_seq)
	idw_name.object.in_amt[1]  = idw_name.object.in_qty[1] * idw_name.object.in_price[1]
  
	ls_SysDate = f_today()
	idw_name.object.in_date[1] = ls_SysDate
	
	string ls_item_no
	ls_item_no = idw_name.object.item_no[1]

	IF isnull(ls_item_no) OR ls_item_no = '' THEN
		ls_item_no = '%'
	END IF

	idw_name.getChild("item_size", idwc_stand_size)
	idwc_stand_size.settransobject(sqlca)
	idwc_stand_size.retrieve(ls_item_no)

	idw_name.setredraw(true)
	 
	this.trigger event rowfocuschanged(row)  

END IF

end event

event rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

string ls_ord_no, ls_req_no, ls_SysDate
long	ll_item_seq

tab_sheet.tabpage_sheet01.dw_list2.reset()
this.accepttext()

IF currentrow <> 0 THEN

	ls_ord_no 	= this.object.ord_no[currentrow] + '%'
	ls_req_no	=	this.object.req_no[currentrow]
	ll_item_Seq	=	this.object.item_seq[currentrow]
	
	IF tab_sheet.tabpage_sheet01.dw_list2.retrieve( ls_ord_no, ll_item_seq ) <> 0 THEN
	   tab_sheet.tabpage_sheet01.dw_list2.setfocus()
	   tab_sheet.tabpage_sheet01.dw_list2.trigger event rowfocuschanged(1)
	else
		tab_sheet.tabpage_sheet01.dw_update2.reset()
   END IF

END IF

end event

type gb_4 from groupbox within tabpage_sheet01
integer x = 27
integer y = 1104
integer width = 480
integer height = 768
integer taborder = 21
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within tabpage_sheet01
integer x = 32
integer y = 1896
integer width = 3378
integer height = 448
integer taborder = 41
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "검수자(필수 입력하여 주시기 바랍니다.)"
end type

type gb_6 from groupbox within tabpage_sheet01
integer x = 3433
integer y = 1920
integer width = 343
integer height = 284
integer taborder = 41
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within tabpage_sheet01
integer x = 3447
integer y = 1956
integer width = 315
integer height = 116
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입 력"
end type

event clicked;
int li_row

ii_tab  = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		
		idw_name = tab_sheet.tabpage_sheet01.dw_update2
		      
	   li_row = idw_name.insertrow(idw_name.getrow()+1)
	
	   idw_name.object.audit_date[li_row] = f_today()
		idw_name.object.work_date[li_row] = f_sysdate()  
		idw_name.object.worker[li_row] = gstru_uid_uname.uid     
		idw_name.object.ipaddr[li_row] = gstru_uid_uname.address  //IP
		
	   idw_name.setfocus()
		idw_name.setrow(li_row)
		
END CHOOSE

end event

type dw_update2 from cuo_dwwindow within tabpage_sheet01
integer x = 64
integer y = 1960
integer width = 3305
integer height = 344
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hgm501i_5"
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;call super::dberror;
IF sqldbcode = 1 THEN
	messagebox("확인","검수자에 중복된 값이 있습니다.")
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

event key_enter;call super::key_enter;
int li_getrow
string ls_audit_member_no

this.accepttext()	
	
IF this.getcolumnname() = 'audit_member_no' THEN                       // 검수자 
 
   li_getrow = this.getrow()
 
	ls_audit_member_no = this.object.audit_member_no[li_getrow]

	openwithparm(w_hgm200h,ls_audit_member_no)
		
	IF message.stringparm <> '' THEN
		
		this.object.audit_member_no[li_getrow] = gstru_uid_uname.s_parm[1]
		this.object.name[li_getrow] = gstru_uid_uname.s_parm[2]
		
	END IF
	
END IF

end event

event doubleclicked;call super::doubleclicked;
int li_getrow
string ls_audit_member_no

this.accepttext()	
	
IF dwo.name = 'audit_member_no' THEN                       // 검수자 
 
   li_getrow = this.getrow()
 
	ls_audit_member_no = this.object.audit_member_no[li_getrow]

	openwithparm(w_hgm200h,ls_audit_member_no)
		
	IF message.stringparm <> '' THEN
		
		this.object.audit_member_no[li_getrow] = gstru_uid_uname.s_parm[1]
		this.object.name[li_getrow] = gstru_uid_uname.s_parm[2]
		
	END IF
	
END IF

end event

type dw_list2 from cuo_dwwindow within tabpage_sheet01
integer x = 37
integer y = 1140
integer width = 457
integer height = 724
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "입고번호"
string dataobject = "d_hgm501i_3"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

long ll_in_no, ll_item_Seq
string ls_ord_no, ls_req_no

IF currentrow <> 0 THEN

	ll_in_no = this.object.in_no[currentrow]
	ls_ord_no = this.object.ord_no[currentrow]
	ls_req_no = this.object.req_no[currentrow]
	ll_item_seq = this.object.item_seq[currentrow]
	
	IF tab_sheet.tabpage_sheet01.dw_update1.retrieve( ll_in_no,ls_ord_no,ll_item_seq ) <> 0 THEN
      tab_sheet.tabpage_sheet01.dw_update1.object.jan_qty[1] = wf_jan( ls_ord_no, ls_req_no, ll_item_Seq )

      tab_sheet.tabpage_sheet01.dw_update2.retrieve( ll_in_no,ls_ord_no,ll_item_seq ) 
   ELSE
   
     wf_insert()
	  tab_sheet.tabpage_sheet01.dw_update2.reset()
   END IF

ELSE 
	
	wf_insert()
	tab_sheet.tabpage_sheet01.dw_update2.reset()

END IF

wf_jan_qty()
end event

type gb_3 from groupbox within tabpage_sheet01
boolean visible = false
integer x = 3273
integer y = 60
integer width = 498
integer height = 196
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type cb_3 from commandbutton within tabpage_sheet01
boolean visible = false
integer x = 3287
integer y = 96
integer width = 471
integer height = 148
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "결의서 생성"
end type

event clicked;
//open(w_hst109b)
end event

type cb_2 from commandbutton within tabpage_sheet01
integer x = 3447
integer y = 2076
integer width = 315
integer height = 116
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭 제"
end type

event clicked;
int li_rowcount, li_row
string ls_ord_no

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name = tab_sheet.tabpage_sheet01.dw_update2

	   li_row = idw_name.getrow()   			
						
		dwItemStatus l_status 
		l_status = idw_name.getitemstatus(li_row, 0, Primary!)
	
		IF l_status = New! OR l_status = NewModified! THEN 

         idw_name.deleterow(li_row) 

		ELSE
			
			IF messagebox("확인","선택한 데이타를 삭제하시겠습니까?", Question!, YesNo! ,2 ) = 1 THEN
				
				idw_name.deleterow(li_row) 
				
				IF f_update( idw_name,'D') = TRUE THEN wf_setmsg("삭제되었습니다")
				
			END IF		
		END IF
		
END CHOOSE	
end event

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 3799
integer height = 2368
long backcolor = 79741120
string text = "물품 검수조서 "
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_6 st_6
sle_ord_numto sle_ord_numto
st_5 st_5
dw_cust_code dw_cust_code
st_4 st_4
em_to_date em_to_date
em_fr_date em_fr_date
st_3 st_3
dw_print dw_print
dw_gwa_code dw_gwa_code
st_2 st_2
sle_ord_numfr sle_ord_numfr
st_1 st_1
gb_7 gb_7
end type

on tabpage_1.create
this.st_6=create st_6
this.sle_ord_numto=create sle_ord_numto
this.st_5=create st_5
this.dw_cust_code=create dw_cust_code
this.st_4=create st_4
this.em_to_date=create em_to_date
this.em_fr_date=create em_fr_date
this.st_3=create st_3
this.dw_print=create dw_print
this.dw_gwa_code=create dw_gwa_code
this.st_2=create st_2
this.sle_ord_numfr=create sle_ord_numfr
this.st_1=create st_1
this.gb_7=create gb_7
this.Control[]={this.st_6,&
this.sle_ord_numto,&
this.st_5,&
this.dw_cust_code,&
this.st_4,&
this.em_to_date,&
this.em_fr_date,&
this.st_3,&
this.dw_print,&
this.dw_gwa_code,&
this.st_2,&
this.sle_ord_numfr,&
this.st_1,&
this.gb_7}
end on

on tabpage_1.destroy
destroy(this.st_6)
destroy(this.sle_ord_numto)
destroy(this.st_5)
destroy(this.dw_cust_code)
destroy(this.st_4)
destroy(this.em_to_date)
destroy(this.em_fr_date)
destroy(this.st_3)
destroy(this.dw_print)
destroy(this.dw_gwa_code)
destroy(this.st_2)
destroy(this.sle_ord_numfr)
destroy(this.st_1)
destroy(this.gb_7)
end on

type st_6 from statictext within tabpage_1
integer x = 2944
integer y = 40
integer width = 64
integer height = 84
boolean bringtotop = true
integer textsize = -18
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "~~"
boolean focusrectangle = false
end type

type sle_ord_numto from singlelineedit within tabpage_1
integer x = 3013
integer y = 40
integer width = 480
integer height = 92
integer taborder = 50
boolean bringtotop = true
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

type st_5 from statictext within tabpage_1
integer x = 2176
integer y = 164
integer width = 274
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "거 래 처"
boolean focusrectangle = false
end type

type dw_cust_code from datawindow within tabpage_1
integer x = 2455
integer y = 152
integer width = 786
integer height = 104
integer taborder = 30
string dataobject = "d_hgm501i_8"
boolean border = false
boolean livescroll = true
end type

type st_4 from statictext within tabpage_1
integer x = 2176
integer y = 60
integer width = 283
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

type em_to_date from editmask within tabpage_1
integer x = 1243
integer y = 48
integer width = 393
integer height = 92
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type em_fr_date from editmask within tabpage_1
integer x = 763
integer y = 48
integer width = 393
integer height = 92
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_3 from statictext within tabpage_1
integer x = 1170
integer y = 44
integer width = 64
integer height = 84
integer textsize = -18
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "~~"
boolean focusrectangle = false
end type

type dw_print from cuo_dwwindow_one_hin within tabpage_1
integer x = 23
integer y = 296
integer width = 3749
integer height = 2048
integer taborder = 11
string dataobject = "d_hgm501i_6"
end type

type dw_gwa_code from datawindow within tabpage_1
integer x = 759
integer y = 156
integer width = 901
integer height = 104
integer taborder = 80
string dataobject = "d_hgm201i_7"
boolean border = false
boolean livescroll = true
end type

type st_2 from statictext within tabpage_1
integer x = 485
integer y = 176
integer width = 274
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "부    서"
boolean focusrectangle = false
end type

type sle_ord_numfr from singlelineedit within tabpage_1
integer x = 2459
integer y = 44
integer width = 480
integer height = 92
integer taborder = 70
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
integer x = 485
integer y = 64
integer width = 274
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "입고일자"
boolean focusrectangle = false
end type

type gb_7 from groupbox within tabpage_1
integer width = 3753
integer height = 276
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "조회조건"
end type

