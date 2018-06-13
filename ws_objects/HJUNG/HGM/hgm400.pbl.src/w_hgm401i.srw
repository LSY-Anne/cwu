$PBExportHeader$w_hgm401i.srw
$PBExportComments$물품 견적
forward
global type w_hgm401i from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type gb_9 from groupbox within tabpage_sheet01
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type sle_cust_name from singlelineedit within tabpage_sheet01
end type
type dw_large_code from datawindow within tabpage_sheet01
end type
type st_3 from statictext within tabpage_sheet01
end type
type st_5 from statictext within tabpage_sheet01
end type
type st_6 from statictext within tabpage_sheet01
end type
type em_from_dt from editmask within tabpage_sheet01
end type
type dw_gwa from datawindow within tabpage_sheet01
end type
type st_4 from statictext within tabpage_sheet01
end type
type st_2 from statictext within tabpage_sheet01
end type
type em_fromdt from editmask within tabpage_sheet01
end type
type em_todt from editmask within tabpage_sheet01
end type
type st_7 from statictext within tabpage_sheet01
end type
type em_to_dt from editmask within tabpage_sheet01
end type
type st_9 from statictext within tabpage_sheet01
end type
type dw_dept from datawindow within tabpage_sheet01
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type cb_1 from uo_imgbtn within tabpage_sheet01
end type
type dw_list1 from uo_dwgrid within tabpage_sheet01
end type
type cb_2 from uo_imgbtn within tabpage_sheet01
end type
type cb_select from uo_imgbtn within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print2 from cuo_dwprint within tabpage_1
end type
type gb_5 from groupbox within tabpage_1
end type
type st_8 from statictext within tabpage_1
end type
type sle_req_no2 from singlelineedit within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print2 dw_print2
gb_5 gb_5
st_8 st_8
sle_req_no2 sle_req_no2
end type
type tabpage_2 from userobject within tab_sheet
end type
type dw_print3 from datawindow within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type sle_req_no5 from singlelineedit within tabpage_2
end type
type gb_6 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
dw_print3 dw_print3
st_1 st_1
sle_req_no5 sle_req_no5
gb_6 gb_6
end type
type gb_7 from groupbox within w_hgm401i
end type
type gb_3 from groupbox within w_hgm401i
end type
type gb_8 from groupbox within w_hgm401i
end type
end forward

global type w_hgm401i from w_tabsheet
string title = "물품 발주"
gb_7 gb_7
gb_3 gb_3
gb_8 gb_8
end type
global w_hgm401i w_hgm401i

type variables

int    ii_tab
long   il_row_cnt
string is_gwa							// 부서
datawindow idw_name1
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

public subroutine wf_retrieve (string as_flag);int 	 li_tab, li_ord_class, i
string ls_item_middle, ls_midd_name, ls_cust_no, ls_cust_name, ls_large_code
string ls_main_item, ls_req_no,  ls_cust[],ls_get_cust, ls_get_name[]
long 	 ll_rowcnt
string	ls_gwa_code, ls_accept_fr_date,ls_accept_to_date
//f_setpointer('START')

li_tab = tab_sheet.selectedtab

CHOOSE CASE li_tab
		
	CASE 1

      IF as_flag = 'I' OR as_flag = 'A' THEN    
			ls_item_middle = '%'
			ls_midd_name = '%'
			
//			ls_accept_fr_date = trim(tab_sheet.tabpage_sheet01.em_from_dt.text)
//			ls_accept_to_date = trim(tab_sheet.tabpage_sheet01.em_to_dt.text)
		ls_accept_fr_date = mid(tab_sheet.tabpage_sheet01.em_from_dt.text,1,4) + mid(tab_sheet.tabpage_sheet01.em_from_dt.text,6,2) + &
	          		 mid(tab_sheet.tabpage_sheet01.em_from_dt.text,9,2)
		ls_accept_to_date = mid(tab_sheet.tabpage_sheet01.em_to_dt.text,1,4) + mid(tab_sheet.tabpage_sheet01.em_to_dt.text,6,2) + &
	         		 mid(tab_sheet.tabpage_sheet01.em_to_dt.text,9,2)
			
			if isnull(ls_accept_fr_date)  or ls_accept_fr_date = "" then
				wf_setmsg("접수일자를 입력하세요")
				return
			Else
			End if
			
			ls_gwa_code = trim(tab_sheet.tabpage_sheet01.dw_gwa.object.code[1])
			
			IF isnull(ls_gwa_code) or	ls_gwa_code = ''	 THEN
//			messagebox("확인","부서/학과를 선택하세요")
			ELSE
				ls_gwa_code = tab_sheet.tabpage_sheet01.dw_gwa.object.code[tab_sheet.tabpage_sheet01.dw_gwa.getrow()]
			END IF	
//		   messagebox('',ls_accept_fr_date+':'+ls_accept_to_date+':'+ls_gwa_code)
			
			IF tab_sheet.tabpage_sheet01.dw_update.retrieve( ls_accept_fr_date, ls_accept_to_date, ls_gwa_code) = 0 THEN
				tab_sheet.tabpage_sheet01.dw_update.reset()
//				wf_setMenu('I',FALSE)
			   wf_setMsg("조회된 데이타가 없습니다")
			ELSE
				wf_SetMsg('자료가 조회되었습니다.')	
				tab_sheet.tabpage_sheet01.dw_list1.setfocus()
				tab_sheet.tabpage_sheet01.dw_list1.trigger event rowfocuschanged(1)
		   END IF
			
      END IF

      IF		 as_flag = 'C' OR as_flag = 'A' THEN
			
				ls_cust_name = trim(tab_sheet.tabpage_sheet01.sle_cust_name.text) + '%'

	      IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( '%', ls_cust_name, '%', '%' ) = 0 THEN
			   wf_setMsg("조회된 데이타가 없습니다")
		   END IF

      END IF
//      wf_setMenu('I',TRUE)

////CASE 2									/** 	가격대비표 	**/
////		
////				ls_req_no = tab_sheet.tabpage_1.sle_req_no2.text
////		if 	ls_req_no = "" or isnull(ls_req_no)	then
////			   wf_setMsg("접수번호를 입력하세요")
////				return
////		end if
////		
////		
////			DECLARE		GET_CUST CURSOR		 FOR
////					SELECT	 DISTINCT A.CUST_NO,B.CUST_NAME
////					FROM  	 STDB.HST107H A, STDB.HST001M B
////					WHERE 	 A.CUST_NO	=	B.CUST_NO	AND
////								 A.REQ_NO	  =  :ls_req_no		;
////					
////			OPEN		GET_CUST;			
////
////			FOR	i	=	1	TO	4
////							FETCH	GET_CUST
////							INTO	:ls_cust_no, :ls_cust_name;
////							ls_cust[i]			=	ls_cust_no							
////							ls_get_name[i]		=	ls_cust_name														
////			IF				SQLCA.SQLCODE	=	100	THEN
////							wf_setmsg("조회된자료가 없습니다.")
////							ls_cust[i]		=	''														
////							ls_get_name[i]	=	''											
////							CLOSE	GET_CUST;
////							
////			ELSEIF		SQLCA.SQLCODE	<> 0	THEN
////
////							ls_cust[i]		=	''							
////							ls_get_name[i]	=	''										
////							CLOSE	GET_CUST;							
////			END IF	
////			NEXT	
////			
////			
////			 il_row_cnt = tab_sheet.tabpage_1.dw_print2.retrieve( ls_cust[1],ls_cust[2],ls_cust[3],ls_cust[4],ls_req_no ) 
////		IF  il_row_cnt = 0 THEN
////			 tab_sheet.tabpage_1.dw_print2.reset()
////			 wf_setMsg("조회된 데이타가 없습니다")	
////		ELSE
//////			tab_sheet.tabpage_1.dw_print2.object.t_1.text	=	ls_get_name[1]
//////			tab_sheet.tabpage_1.dw_print2.object.t_2.text	=	ls_get_name[2]
//////			tab_sheet.tabpage_1.dw_print2.object.t_6.text	=	ls_get_name[3]
//////			tab_sheet.tabpage_1.dw_print2.object.t_3.text	=	ls_get_name[4]			
////		END IF	  		
////	
////  CASE 3                                    
////	   int idx
////      ls_req_no = trim(tab_sheet.tabpage_2.sle_req_no5.text)
////      IF isnull(ls_req_no) OR ls_req_no = '' THEN
////	      messagebox('확인','접수번호를 입력하시기 바랍니다..!')
////      END IF
////
////      ll_RowCnt =  tab_sheet.tabpage_2.dw_print3.retrieve(ls_req_no)
////      IF ll_RowCnt = 0 THEN
////	      wf_setmsg('조회된 자료가 없습니다..!')
////	      wf_setMenu('R',TRUE)
////	      wf_setMenu('I',TRUE)
////      ELSE
////      	wf_setmsg('자료가 조회되었습니다..!')
////	      wf_setMenu('S',TRUE)
////	      wf_setMenu('D',TRUE)
////	      wf_setMenu('P',TRUE)
////      END IF
////		
END CHOOSE
end subroutine

on w_hgm401i.create
int iCurrent
call super::create
this.gb_7=create gb_7
this.gb_3=create gb_3
this.gb_8=create gb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_7
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_8
end on

on w_hgm401i.destroy
call super::destroy
destroy(this.gb_7)
destroy(this.gb_3)
destroy(this.gb_8)
end on

event ue_retrieve;call super::ue_retrieve;wf_retrieve("A")
return 1


end event

event ue_insert;
datawindow dw_iname
int li_row, li_quot_num, li_req_no, li_item_seq
long ll_row, i, ll_ord_class
string ls_cust_no, ls_req_no, ls_item_name
string	ls_model, ls_item_stand_size, ls_apply_gwa

ii_tab = tab_sheet.selectedtab
ls_cust_no	=	tab_sheet.tabpage_sheet01.dw_update_tab.object.cust_no[tab_sheet.tabpage_sheet01.dw_update_tab.getrow()]

CHOOSE CASE ii_tab
	CASE 1
		
		idw_name1 = tab_sheet.tabpage_sheet01.dw_update
		dw_iname = tab_sheet.tabpage_sheet01.dw_list1
		   li_row = idw_name1.insertrow(0)
			
			ls_req_no 			= 	dw_iname.object.req_no[dw_iname.getrow()]
			li_item_seq 		=  dw_iname.object.item_seq[dw_iname.getrow()]
			ls_item_name		=  dw_iname.object.item_name[dw_iname.getrow()]
			ls_model 			=  dw_iname.object.model[dw_iname.getrow()]
			ls_item_stand_size = dw_iname.object.item_stand_size[dw_iname.getrow()]
			ls_apply_gwa		= dw_iname.object.apply_gwa[dw_iname.getrow()]
			idw_name1.object.req_no[li_row] 		=  ls_req_no      	 		 	// 접수 번호
			idw_name1.object.cust_no[li_row] 		=  ls_cust_no		 		 		// 업체 번호
			idw_name1.object.item_seq[li_row] 	=  li_item_seq      	 	 		// 품목 번호
			idw_name1.object.item_name[li_row] 	=  ls_item_name    	 	 		// 품목 명
			idw_name1.object.model[li_row]		 	=  ls_model    	 	 			// 모델
			idw_name1.object.item_stand_size[li_row] =  ls_item_stand_size    	// 규격
			idw_name1.object.apply_gwa[li_row] =  ls_apply_gwa						//신청부서
	
  	
		SELECT	nvl(max(QUOT_NUM), 0)+1
		INTO		:li_quot_num
		FROM		STDB.HST107H
		WHERE		REQ_NO = :ls_req_no AND  CUST_NO	=	:ls_cust_no	 AND ITEM_SEQ = :li_item_Seq;
	
	
		idw_name1.object.quot_num[li_row]   =  li_quot_num      	 	 // 견적 번호 						
		idw_name1.object.midd    [li_row]    = dw_iname.object.item_no[dw_iname.getrow()]      // 품목 번호 
		idw_name1.object.update_qty[li_row] = dw_iname.object.update_qty[dw_iname.getrow()]        // 수 량 
	   idw_name1.object.work_date[li_row] = f_sysdate()              // 작업 일자  
		idw_name1.object.worker[li_row]    = gstru_uid_uname.uid      // 작업자 
		idw_name1.object.ipaddr[li_row]    = gstru_uid_uname.address  //IP
		
	   idw_name1.setfocus()
		idw_name1.setrow(li_row)

END CHOOSE

end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 물품견적
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

String ls_req_no

Datawindowchild dwc_large_code	
//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)
//wf_setMenu('P',TRUE)

tab_sheet.tabpage_sheet01.dw_list1.reset()
tab_sheet.tabpage_sheet01.dw_update_tab.reset()
tab_sheet.tabpage_sheet01.dw_update.reset()
tab_sheet.tabpage_sheet01.dw_large_code.reset()
tab_sheet.tabpage_sheet01.dw_large_code.getchild('code', dwc_large_code)
tab_sheet.tabpage_sheet01.dw_large_code.insertrow(0)
dwc_large_code.settransobject(sqlca)
dwc_large_code.retrieve()

DataWindowChild	ldwc_Temp
tab_sheet.tabpage_sheet01.dw_gwa.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	Long	ll_InsRow
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
//	ldwc_Temp.SetSort('gwa ASC')
//	ldwc_Temp.Sort()
END IF
tab_sheet.tabpage_sheet01.dw_gwa.InsertRow(0)

tab_sheet.tabpage_sheet01.dw_dept.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
//	ldwc_Temp.SetSort('gwa ASC')
//	ldwc_Temp.Sort()
END IF

tab_sheet.tabpage_sheet01.dw_dept.InsertRow(0)


tab_sheet.tabpage_1.dw_print2.Object.DataWindow.Print.Preview = 'YES'
tab_sheet.tabpage_2.dw_print3.Object.DataWindow.Print.Preview = 'YES'

tab_sheet.tabpage_sheet01.em_from_dt.text = f_today()
tab_sheet.tabpage_sheet01.em_to_dt.text = f_today()

tab_sheet.tabpage_sheet01.em_fromdt.text = f_today()
tab_sheet.tabpage_sheet01.em_todt.text = f_today()
wf_retrieve('A')              // 물품 접수 내역과 거래처 조회 내역 모두 조회 

idw_print = tab_sheet.tabpage_1.dw_print2
end event

event ue_save;call super::ue_save;
int 	 li_row, i, li_quot_num
string ls_cust_no, ls_req_no, ls_apply_gwa, ls_apply_date, ls_item_no
string ls_cur_req_no, ls_cur_cust_no
long	 ll_item_seq,ll_Row

string	ls_gwa, ls_ord_day, ls_devilery_dt, ls_sign, ls_remark, ls_acct_code, ls_jumun_dt
long		ll_vat_amt, ll_ord_amt, ll_vat
string 	ls_dt_cur, ls_ord_no
string	ls_item_size, ls_model
long  ll_quot_num, ll_confirm_opt, ll_ord_no, ll_cnt,ll_COUNT, ls_quot_qty

datetime	ldt_WorkDate	//수정일자
date		ldt1_WorkDate
String	ls_Worker		//수정자
String	ls_IpAddr		//수정IP

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab

	CASE 1

	  idw_name1 = tab_sheet.tabpage_sheet01.dw_update

	  idw_name1.accepttext()	  

  	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN -1

		 SELECT	TO_char(SYSDATE,'YYYYMM')||trim(to_char(nvl(substr(max(ord_NO),7,4)+1,'0001'),'0000'))
		 INTO		:ll_ord_no
		 FROM		STDB.HST106H
		 WHERE 	ord_NO LIKE	TO_char(SYSDATE,'YYYYMM') ||'%' ;

	  li_row = idw_name1.rowcount()

	  IF li_row <> 0 THEN
			
			FOR i = 1 TO li_row
			 	 	idw_name1.object.job_uid[i]	= gstru_uid_uname.uid		  //수정자
					idw_name1.object.job_date[i] = f_sysdate()             // 오늘 일자 
					idw_name1.object.job_add[i] 	= gstru_uid_uname.address  //IP
				
					ldt_WorkDate = f_sysdate()					//등록일자
					ls_Worker    = gstru_uid_uname.uid		//등록자
					ls_IPAddr    = gstru_uid_uname.address	//등록IP
					ldt1_WorkDate = date(ldt_WorkDate )

					ls_req_no		=	idw_name1.object.req_no[i]

					SELECT 	COUNT(*)
					INTO		:ll_cnt
					FROM		STDB.HST106H
					WHERE		REQ_NO = :ls_req_no	;

					if ll_cnt = 0 then
						idw_name1.object.ord_no[i] 		= string( ll_ord_no)	      //발주번호
						ll_ord_no ++
					end if
					ls_ord_no		=	idw_name1.object.ord_no[i]  
					ll_item_seq 	=  idw_name1.object.item_seq[i]
					ls_cust_no		=	idw_name1.object.cust_no[i]
					ls_item_size	=	idw_name1.object.item_stand_size[i]
					ls_model			=	idw_name1.object.model[i]
					ls_gwa			=	idw_name1.object.apply_gwa[i]
					ls_acct_code	=	idw_name1.object.acct_code[i]
					ll_ORD_AMT		=	idw_name1.object.compute_1[i]
					ls_quot_qty		=	idw_name1.object.quot_qty[i]
					ls_devilery_dt	=	f_today()
					ls_jumun_dt		=	f_today()

			  		if ll_cnt = 0 then

						INSERT INTO STDB.HST106H						/*	발주 테이블 UPDATE STDB.HST106H */
										( ORD_NO, 			 REQ_NO, 	ITEM_SEQ, 	  CUST_NO, 			GWA, 	
										  ACCT_CODE,   	 ORD_AMT,  	TAX_AMT,  	  JUMUN_DATE, 	   DEVILERY_DATE,
										  SIGN_CONDITION,  REMARK, 	ORD_CLASS, 	  JOB_UID, 			JOB_ADD,
										  JOB_DATE)
						VALUES		(:ls_ord_no, 	 :ls_req_no, 	:ll_item_seq, :ls_cust_no,  	:ls_gwa, 
										 :ls_acct_code, :ll_ORD_AMT,	:ll_vat, 	  :ls_jumun_dt,	:ls_devilery_dt,
										 1,		 		 '',				6,				  :ls_Worker,		:ls_IPAddr,	
										 :ldt_WorkDate);

						UPDATE STDB.HST105H                                   // 발주 : 6
						SET ORD_CLASS = 6, ORD_NO =:ls_ord_no, item_stand_size = :ls_item_size, model = :ls_model, update_qty = :ls_quot_qty
						WHERE REQ_NO = :ls_req_no AND ITEM_SEQ = :ll_item_seq ;
				 	else
						UPDATE STDB.HST106H
						SET  ORD_AMT =:ll_ORD_AMT, CUST_NO = :ls_cust_no
						WHERE REQ_NO = :ls_req_no AND ITEM_SEQ = :ll_item_seq ;
				  	end if	

					if 		sqlca.sqlcode <> 0  		then
											MessageBox('오류','저장시 전산장애가 발생되었습니다.~r~n' + &
												'하단의 장애번호와 장애내역을~r~n' + &
												'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
												'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
												'장애내역 : ' + SQLCA.SqlErrText )
											rollback;
											return -1
					end if	
					if sqlca.sqlcode <0 then
					  wf_setmsg("저장중 오류가 발생하였습니다.")
						rollback;
						return -1
					end if
			  NEXT

		  string ls_colarry[] = {'req_no/접수 번호', 'cust_no/거래처','item_middle/품목코드'}

		  IF f_chk_null( idw_name1, ls_colarry ) = 1 THEN

			  IF f_update( idw_name1,'U') THEN
				  wf_retrieve('I')
				  wf_setmsg("저장되었습니다")
			  END IF
		  END IF	
	END IF

END CHOOSE		




end event

event ue_delete;call super::ue_delete;
int li_rowcount, li_count
long li_row
string ls_req_no, ls_cust_no, ls_ord_no

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name1 = tab_sheet.tabpage_sheet01.dw_update
	   
		li_row = idw_name1.getrow()
		
	   IF li_row <> 0 THEN
	      			
			dwItemStatus l_status 
			l_status = idw_name1.getitemstatus(li_row, 0, Primary!)

			IF l_status = New! OR l_status = NewModified! THEN 
				
				idw_name1.deleterow(li_row)
			ELSE
			
			  IF f_messagebox( '2', 'DEL' ) = 1 THEN
					messagebox("확인","정말삭제하시겠습니까?.")
					
			     ls_req_no = idw_name1.object.req_no[li_row]
				  ls_ord_no = idw_name1.object.ord_no[li_row]
				  ls_cust_no = idw_name1.object.cust_no[li_row]
				  
					  UPDATE STDB.HST105H
					  SET ORD_CLASS = 2, ORD_NO = ''
					  WHERE req_NO = :ls_req_no  ;
					  
					  IF SQLCA.SQLCODE <> 0 THEN
								wf_SetMsg('저장중 오류가 발생하였습니다.')
								ROLLBACK;
								RETURN
					  END IF	
					  
					  DELETE FROM STDB.HST106H 
					  WHERE req_NO = :ls_req_no 
					  AND   ORD_NO = :ls_ord_no ;    // 106h 테이블을 DELETE한다
					  commit;
				  idw_name1.deleterow(li_row)

              IF idw_name1.rowcount() = 0 THEN
					
	    //신청테이블에 물품접수 단계로 변경
	
					  UPDATE STDB.HST105H
					  SET ORD_CLASS = 2
					  WHERE req_NO = :ls_req_no  ;
					  
					  IF		SQLCA.SQLCODE <> 0 	THEN
								wf_SetMsg('저장중 오류가 발생하였습니다.')
								ROLLBACK;
								RETURN
					  END IF	
					  
					  DELETE FROM STDB.HST106H 
					  WHERE req_NO = :ls_req_no 
					  AND   ORD_NO = :ls_ord_no ;    // 106h 테이블을 DELETE한다
					  commit;
				END IF

				  IF f_update( idw_name1,'D') = TRUE THEN
					  wf_retrieve('I')
					  wf_setmsg("삭제되었습니다")
				  END IF
			  END IF
			END IF
		END IF
END CHOOSE



end event

event ue_print;call super::ue_print;//int	li_tab
//
//li_tab = tab_sheet.selectedtab
//
//CHOOSE CASE li_tab
//		
//	CASE 2     
//		if tab_sheet.tabpage_1.dw_print2.rowcount() > 0 then f_print(tab_sheet.tabpage_1.dw_print2)
//	CASE	3
//		if tab_sheet.tabpage_2.dw_print3.rowcount() > 0 then f_print(tab_sheet.tabpage_2.dw_print3)
//END CHOOSE		
//
//
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
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

event ue_button_set;call super::ue_button_set;tab_sheet.tabpage_sheet01.cb_select.x = tab_sheet.tabpage_sheet01.cb_2.x + tab_sheet.tabpage_sheet01.cb_2.width + 16
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hgm401i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hgm401i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hgm401i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hgm401i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hgm401i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hgm401i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hgm401i
end type

type uc_insert from w_tabsheet`uc_insert within w_hgm401i
end type

type uc_delete from w_tabsheet`uc_delete within w_hgm401i
end type

type uc_save from w_tabsheet`uc_save within w_hgm401i
end type

type uc_excel from w_tabsheet`uc_excel within w_hgm401i
end type

type uc_print from w_tabsheet`uc_print within w_hgm401i
end type

type st_line1 from w_tabsheet`st_line1 within w_hgm401i
end type

type st_line2 from w_tabsheet`st_line2 within w_hgm401i
end type

type st_line3 from w_tabsheet`st_line3 within w_hgm401i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hgm401i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hgm401i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hgm401i
integer y = 172
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

event tab_sheet::selectionchanged;call super::selectionchanged;choose case newindex
	case 1,2
		idw_print = tab_sheet.tabpage_1.dw_print2
	Case 3
		idw_print = tab_sheet.tabpage_2.dw_print3
end choose

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
string text = "물품 발주"
gb_2 gb_2
gb_9 gb_9
gb_1 gb_1
dw_update dw_update
sle_cust_name sle_cust_name
dw_large_code dw_large_code
st_3 st_3
st_5 st_5
st_6 st_6
em_from_dt em_from_dt
dw_gwa dw_gwa
st_4 st_4
st_2 st_2
em_fromdt em_fromdt
em_todt em_todt
st_7 st_7
em_to_dt em_to_dt
st_9 st_9
dw_dept dw_dept
gb_4 gb_4
cb_1 cb_1
dw_list1 dw_list1
cb_2 cb_2
cb_select cb_select
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.gb_9=create gb_9
this.gb_1=create gb_1
this.dw_update=create dw_update
this.sle_cust_name=create sle_cust_name
this.dw_large_code=create dw_large_code
this.st_3=create st_3
this.st_5=create st_5
this.st_6=create st_6
this.em_from_dt=create em_from_dt
this.dw_gwa=create dw_gwa
this.st_4=create st_4
this.st_2=create st_2
this.em_fromdt=create em_fromdt
this.em_todt=create em_todt
this.st_7=create st_7
this.em_to_dt=create em_to_dt
this.st_9=create st_9
this.dw_dept=create dw_dept
this.gb_4=create gb_4
this.cb_1=create cb_1
this.dw_list1=create dw_list1
this.cb_2=create cb_2
this.cb_select=create cb_select
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_9
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_update
this.Control[iCurrent+5]=this.sle_cust_name
this.Control[iCurrent+6]=this.dw_large_code
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.em_from_dt
this.Control[iCurrent+11]=this.dw_gwa
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.em_fromdt
this.Control[iCurrent+15]=this.em_todt
this.Control[iCurrent+16]=this.st_7
this.Control[iCurrent+17]=this.em_to_dt
this.Control[iCurrent+18]=this.st_9
this.Control[iCurrent+19]=this.dw_dept
this.Control[iCurrent+20]=this.gb_4
this.Control[iCurrent+21]=this.cb_1
this.Control[iCurrent+22]=this.dw_list1
this.Control[iCurrent+23]=this.cb_2
this.Control[iCurrent+24]=this.cb_select
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_9)
destroy(this.gb_1)
destroy(this.dw_update)
destroy(this.sle_cust_name)
destroy(this.dw_large_code)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.em_from_dt)
destroy(this.dw_gwa)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.em_fromdt)
destroy(this.em_todt)
destroy(this.st_7)
destroy(this.em_to_dt)
destroy(this.st_9)
destroy(this.dw_dept)
destroy(this.gb_4)
destroy(this.cb_1)
destroy(this.dw_list1)
destroy(this.cb_2)
destroy(this.cb_select)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 2016
integer y = 336
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
integer x = 2889
integer y = 256
integer width = 1426
integer height = 892
boolean titlebar = true
string title = "거래처"
string dataobject = "d_hgm401i_4"
end type

event dw_update_tab::doubleclicked;call super::doubleclicked;
datawindow dw_iname
int li_row, li_quot_num, li_req_no, li_item_seq
long ll_row, i, ll_ord_class, ll_qty
string ls_cust_no, ls_req_no, ls_item_name
string	ls_model, ls_item_stand_size, ls_apply_gwa

ii_tab = tab_sheet.selectedtab
ls_cust_no	=	tab_sheet.tabpage_sheet01.dw_update_tab.object.cust_no[tab_sheet.tabpage_sheet01.dw_update_tab.getrow()]
CHOOSE CASE ii_tab
	CASE 1
		
		idw_name1 = tab_sheet.tabpage_sheet01.dw_update
		dw_iname = tab_sheet.tabpage_sheet01.dw_list1
		 If dw_iname.rowcount() = 0 Then RETURN  -1
		   li_row = idw_name1.insertrow(0)
		  
			
			ls_req_no 				= 	dw_iname.object.req_no[dw_iname.getrow()]
			li_item_seq 			=  dw_iname.object.item_seq[dw_iname.getrow()]
			ls_item_name 			=  dw_iname.object.item_name[dw_iname.getrow()]
			ls_model 				=  dw_iname.object.model[dw_iname.getrow()]
			ls_item_stand_size 	= dw_iname.object.item_stand_size[dw_iname.getrow()]
			ls_apply_gwa			= dw_iname.object.apply_gwa[dw_iname.getrow()]
			ll_qty					= dw_iname.object.update_qty[dw_iname.getrow()]
			idw_name1.object.req_no[li_row] 		=  ls_req_no      	 		 // 접수 번호
			idw_name1.object.cust_no[li_row] 		=  ls_cust_no		 		 	// 업체 번호
			idw_name1.object.item_seq[li_row] 	=  li_item_seq      	 	 	// 품목 번호
			idw_name1.object.item_name[li_row] 	=  ls_item_name    	 		// 품목 명
			idw_name1.object.model[li_row]		 	=  ls_model    	 	 		// 모델
			idw_name1.object.item_stand_size[li_row] =  ls_item_stand_size  // 규격
			idw_name1.object.apply_gwa[li_row]   =  ls_apply_gwa					//신청부서
			idw_name1.object.quot_qty[li_row]    =  ll_qty							//수량

		SELECT	nvl(max(QUOT_NUM), 0)+1
		INTO		:li_quot_num
		FROM		STDB.HST107H
		WHERE		REQ_NO = :ls_req_no AND  CUST_NO	=	:ls_cust_no	 AND ITEM_SEQ = :li_item_Seq;


			idw_name1.object.quot_num[li_row]   =  li_quot_num      	 	 								  // 견적 번호
			idw_name1.object.midd    [li_row]    = dw_iname.object.item_no[dw_iname.getrow()]      // 품목 번호
			idw_name1.object.update_qty[li_row] = dw_iname.object.update_qty[dw_iname.getrow()]    // 수 량
	
	   idw_name1.object.work_date[li_row] = f_sysdate()              // 작업 일자
		idw_name1.object.worker[li_row]    = gstru_uid_uname.uid      // 작업자
		idw_name1.object.ipaddr[li_row]    = gstru_uid_uname.address  //IP
		
	   idw_name1.setfocus()
		idw_name1.setrow(li_row)
END CHOOSE
end event

type uo_tab from w_tabsheet`uo_tab within w_hgm401i
integer x = 1472
integer y = 144
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hgm401i
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hgm401i
boolean visible = false
end type

type gb_2 from groupbox within tabpage_sheet01
integer y = 208
integer width = 4343
integer height = 952
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "발주 내역"
end type

type gb_9 from groupbox within tabpage_sheet01
integer x = 9
integer y = 1164
integer width = 2592
integer height = 144
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "접수내역"
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 14
integer y = 16
integer width = 3095
integer height = 176
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회 조건"
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
integer x = 14
integer y = 264
integer width = 2875
integer height = 884
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgm401i_22"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event constructor;call super::constructor;this.uf_setClick(False)
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE',true) //정장버튼 활성황

end event

event dberror;call super::dberror;
IF sqldbcode = 1 THEN
	messagebox("확인",'중복된 값이 있습니다.')
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

type sle_cust_name from singlelineedit within tabpage_sheet01
integer x = 3488
integer y = 80
integer width = 457
integer height = 80
integer taborder = 40
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

event modified;wf_retrieve('C')
end event

event constructor;f_pro_toggle('k',handle(parent))
end event

type dw_large_code from datawindow within tabpage_sheet01
boolean visible = false
integer x = 3131
integer y = 96
integer width = 649
integer height = 96
integer taborder = 45
boolean bringtotop = true
string title = "none"
string dataobject = "d_large_code"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;if dwo.name = 'code' then
	wf_retrieve("C")
end if
end event

type st_3 from statictext within tabpage_sheet01
integer x = 3209
integer y = 100
integer width = 265
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "거래처명"
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_sheet01
boolean visible = false
integer x = 2889
integer y = 120
integer width = 233
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "대분류"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_sheet01
integer x = 55
integer y = 92
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "접수일자"
boolean focusrectangle = false
end type

type em_from_dt from editmask within tabpage_sheet01
integer x = 320
integer y = 76
integer width = 370
integer height = 80
integer taborder = 40
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

type dw_gwa from datawindow within tabpage_sheet01
integer x = 1655
integer y = 72
integer width = 773
integer height = 84
integer taborder = 65
boolean bringtotop = true
string title = "none"
string dataobject = "ddw_gwa_code"
boolean border = false
boolean livescroll = true
end type

type st_4 from statictext within tabpage_sheet01
integer x = 78
integer y = 1220
integer width = 265
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "접수일자"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_sheet01
integer x = 1349
integer y = 88
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "부서/학과"
boolean focusrectangle = false
end type

type em_fromdt from editmask within tabpage_sheet01
integer x = 306
integer y = 1204
integer width = 366
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type em_todt from editmask within tabpage_sheet01
integer x = 709
integer y = 1204
integer width = 370
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_7 from statictext within tabpage_sheet01
integer x = 1335
integer y = 1220
integer width = 297
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "부서/학과"
boolean focusrectangle = false
end type

type em_to_dt from editmask within tabpage_sheet01
integer x = 745
integer y = 76
integer width = 370
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_9 from statictext within tabpage_sheet01
integer x = 704
integer y = 92
integer width = 46
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "~~"
boolean focusrectangle = false
end type

type dw_dept from datawindow within tabpage_sheet01
integer x = 1600
integer y = 1200
integer width = 773
integer height = 88
integer taborder = 100
boolean bringtotop = true
string dataobject = "ddw_gwa_code"
boolean border = false
boolean livescroll = true
end type

type gb_4 from groupbox within tabpage_sheet01
integer x = 3118
integer y = 16
integer width = 1225
integer height = 176
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "거래처 조회 조건"
end type

type cb_1 from uo_imgbtn within tabpage_sheet01
integer x = 3973
integer y = 76
integer taborder = 20
boolean bringtotop = true
string btnname = "조회"
end type

event clicked;call super::clicked;String  ls_cust_no,  ls_cust_name, ls_main_item

ls_cust_name = tab_sheet.tabpage_sheet01.sle_cust_name.text + '%'

IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( '%', ls_cust_name, '%' , '%' ) = 0 THEN
   wf_setMsg("조회된 데이타가 없습니다")	
END IF	  	



end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type dw_list1 from uo_dwgrid within tabpage_sheet01
integer y = 1316
integer width = 4343
integer height = 1048
integer taborder = 30
boolean titlebar = true
string title = "물품접수내역"
string dataobject = "d_hgm401i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type cb_2 from uo_imgbtn within tabpage_sheet01
integer x = 2738
integer y = 1204
integer taborder = 90
boolean bringtotop = true
string btnname = "조 회"
end type

event clicked;call super::clicked;
string	ls_fr_date, ls_to_date
string	ls_apply_gwa

			ls_fr_date = mid(tab_sheet.tabpage_sheet01.em_fromdt.text,1,4) + mid(tab_sheet.tabpage_sheet01.em_fromdt.text,6,2) + &
	          		 mid(tab_sheet.tabpage_sheet01.em_fromdt.text,9,2)
			ls_to_date = mid(tab_sheet.tabpage_sheet01.em_todt.text,1,4) + mid(tab_sheet.tabpage_sheet01.em_todt.text,6,2) + &
	         		 mid(tab_sheet.tabpage_sheet01.em_todt.text,9,2)
			if isnull(ls_fr_date)  or ls_fr_date = "" then
				wf_setmsg("접수일자를 입력하세요")
				return
			Else
			End if
			
			if isnull(ls_to_date)  or ls_to_date = "" then
				wf_setmsg("접수일자를 입력하세요")
				return
			Else
			End if
			
			ls_apply_gwa = trim(tab_sheet.tabpage_sheet01.dw_dept.object.code[1])
			
			IF isnull(ls_apply_gwa) or	ls_apply_gwa = ''	 THEN
				ls_apply_gwa = '%'
			ELSE
				ls_apply_gwa = tab_sheet.tabpage_sheet01.dw_dept.object.code[tab_sheet.tabpage_sheet01.dw_dept.getrow()]
			END IF	
			
			IF tab_sheet.tabpage_sheet01.dw_list1.retrieve( ls_fr_date, ls_to_date, ls_apply_gwa) = 0 THEN
//				wf_setMenu('I',FALSE)
			   wf_setMsg("조회된 데이타가 없습니다")
			ELSE
				wf_SetMsg('자료가 조회되었습니다.')	
				tab_sheet.tabpage_sheet01.dw_list1.setfocus()
		   END IF
end event

on cb_2.destroy
call uo_imgbtn::destroy
end on

type cb_select from uo_imgbtn within tabpage_sheet01
integer x = 3049
integer y = 1204
integer taborder = 100
boolean bringtotop = true
string btnname = "선 택"
end type

event clicked;call super::clicked;
datawindow dw_iname, dw_cust
int li_row, li_quot_num, li_req_no, li_item_seq
long ll_row, ll_ord_class
long i, ll_DeleteCnt
Long ll_DeleteRow[]
string ls_cust_no, ls_req_no, ls_item_name
string ls_model, ls_item_stand_size, ls_apply_gwa

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		
		dw_iname = tab_sheet.tabpage_sheet01.dw_list1
		
		i = dw_iname.getrow()
		if i = 0 then
		wf_setMsg("먼저 선택하여 주십시요.")	
		return
		else
		
	idw_name1 = tab_sheet.tabpage_sheet01.dw_update
	dw_cust  = tab_sheet.tabpage_sheet01.dw_update_tab
	
	Do While i <> 0
		ll_row = idw_name1.InsertRow(0)

		idw_name1.SetRow(ll_row)
		idw_name1.ScrollToRow(ll_row)
		idw_name1.SetFocus()
//		idw_name1.SelectRow(0,FALSE)
//		idw_name1.SelectRow(ll_row,TRUE)
		
		int  idx
		long  ll_RowCnt, ll_GetRow
		IF ll_Row = 0 THEN
	      RETURN
      ELSE
	      ll_RowCnt = dw_iname.RowCount()
      FOR idx = ll_GetRow TO ll_RowCnt
      NEXT
		
      END IF
		   idw_name1.object.cust_no[ll_row]			 = dw_cust.object.cust_no[dw_cust.getrow()]
			idw_name1.object.req_no[ll_row]			 = dw_iname.object.req_no[i]
			idw_name1.object.item_seq[ll_row] 		 = dw_iname.object.item_seq[i]
			idw_name1.object.item_name[ll_row] 		 = dw_iname.object.item_name[i]
			idw_name1.object.model[ll_row]				 = dw_iname.object.model[i]
			idw_name1.object.item_stand_size[ll_row] = dw_iname.object.item_stand_size[i]
			idw_name1.object.apply_gwa[ll_row]		 = dw_iname.object.apply_gwa[i]

			idw_name1.object.quot_num[ll_row]    =  1      	 									// 견적 번호
			idw_name1.object.midd    [ll_row]    = dw_iname.object.item_no[i]      		// 품목 번호
			idw_name1.object.QUOT_QTY[ll_row]  	= dw_iname.object.update_qty[i]      	// 수 량
			idw_name1.object.work_date[ll_row]   = f_sysdate()              				// 작업 일자
			idw_name1.object.worker[ll_row]      = gstru_uid_uname.uid                  // 작업자
			idw_name1.object.ipaddr[ll_row]      = gstru_uid_uname.address              //IP
			
			idw_name1.setfocus()
			idw_name1.setrow(li_row)
			
			ll_DeleteCnt++
			ll_DeleteRow[ll_DeleteCnt] = i
			i = dw_iname.getrow()

	Loop 
end if
END CHOOSE

end event

on cb_select.destroy
call uo_imgbtn::destroy
end on

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1992
string text = "가격대비표"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print2 dw_print2
gb_5 gb_5
st_8 st_8
sle_req_no2 sle_req_no2
end type

on tabpage_1.create
this.dw_print2=create dw_print2
this.gb_5=create gb_5
this.st_8=create st_8
this.sle_req_no2=create sle_req_no2
this.Control[]={this.dw_print2,&
this.gb_5,&
this.st_8,&
this.sle_req_no2}
end on

on tabpage_1.destroy
destroy(this.dw_print2)
destroy(this.gb_5)
destroy(this.st_8)
destroy(this.sle_req_no2)
end on

type dw_print2 from cuo_dwprint within tabpage_1
integer x = 18
integer y = 284
integer width = 4315
integer height = 1708
integer taborder = 11
boolean titlebar = true
string title = "가격대비표"
string dataobject = "d_hgm401i_6-1"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;//
//long	ll_price, ll_row_cnt, ll_total, row_cnt
//string ls_cust_name, as_req_no
//
//if rowcount <  1  then   return -1
////ll_price = this.object.grand_sum_summ[1]
////ls_cust_name = this.object.cust_name[1]
//
//
//as_req_no = tab_sheet.tabpage_1.sle_req_no2.text
//
//											/**  업체별로 최소값과 업체명 구하기 **/
//select	DDD.cust_name,DDD.total
//into		:ls_cust_name, :ll_price
//FROM	(
//		select 	AAA.cust_name,sum(AAA.summ) total
//		from	(
//				select    b.item_name, b.apply_qty,c.cust_name, a.req_no, a.item_seq,a.QUOT_PRICE, a.cust_no CUST_NO, a.quot_num, b.apply_qty * a.quot_price summ 
//				from	    stdb.hst107h a, stdb.hst105h b, stdb.hst001m c,
//							      (
//								  select bb.item_name NN, cc.cust_name XX, aa.req_no YY, aa.cust_no MM, aa.item_seq ZZ, bb.apply_qty FF, MAX(aa.quot_num) DD
//							      from stdb.hst107h aa, stdb.hst105h bb, stdb.hst001m cc
//							      where aa.req_no = bb.req_no
//								  and 	trim(aa.req_no) =	:as_req_no		
//								  and   aa.item_seq = bb.item_seq
//							      and   aa.cust_no = cc.cust_no
//							      group by bb.item_name, bb.apply_qty, cc.cust_name, aa.req_no, aa.cust_no, aa.item_seq
//							     )
//				where 	a.req_no = b.req_no
//						and   trim(a.req_no) =	:as_req_no
//						and	  a.item_seq 	 =		ZZ
//						and	  b.apply_qty 	 =		FF
//						and	  b.item_name 	 = NN
//						and   a.cust_no 	 = c.cust_no
//						and   c.cust_name 	 = XX
//						and   a.req_no 		 = YY
//						and   a.cust_no 	 = MM
//						and   a.quot_num 	 = DD
//				group by b.item_name, c.cust_name, b.apply_qty, a.req_no, a.ITEM_SEQ, a.QUOT_PRICE, a.cust_no, a.quot_num
//				order by a.cust_no, a.quot_price asc
//				)AAA							
//		group by	   cust_name
//		order by	   total	asc
//		)DDD, 
//		(				
//		select 	min(sum(AAA.summ)) total
//		from	(
//				select    b.item_name, b.apply_qty,c.cust_name, a.req_no, a.item_seq,a.QUOT_PRICE, a.cust_no CUST_NO, a.quot_num, b.apply_qty * a.quot_price summ 
//				from	    stdb.hst107h a, stdb.hst105h b, stdb.hst001m c,
//							      (
//								  select bb.item_name NN, cc.cust_name XX, aa.req_no YY, aa.cust_no MM, aa.item_seq ZZ, bb.apply_qty FF, MAX(aa.quot_num) DD
//							      from stdb.hst107h aa, stdb.hst105h bb, stdb.hst001m cc
//							      where aa.req_no = bb.req_no
//								  and 	trim(aa.req_no) =	:as_req_no		
//								  and   aa.item_seq = bb.item_seq
//							      and   aa.cust_no = cc.cust_no
//							      group by bb.item_name, bb.apply_qty, cc.cust_name, aa.req_no, aa.cust_no, aa.item_seq
//							     )
//				where 	a.req_no = b.req_no
//						and   trim(a.req_no) =	:as_req_no
//						and	  a.item_seq 	 =		ZZ
//						and	  b.apply_qty 	 =		FF
//						and	  b.item_name 	 = NN
//						and   a.cust_no 	 = c.cust_no
//						and   c.cust_name 	 = XX
//						and   a.req_no 		 = YY
//						and   a.cust_no 	 = MM
//						and   a.quot_num 	 = DD
//				group by b.item_name, c.cust_name, b.apply_qty, a.req_no, a.ITEM_SEQ, a.QUOT_PRICE, a.cust_no, a.quot_num
//				order by a.cust_no, a.quot_price asc
//				)AAA							
//		group by	   cust_name
//		order by	   total	asc			
//		)EEE
//where		ddd.total = eee.total		;
//
//		
//													/** 업체 COUNT 구하기	**/
//select	count(FFF.cust_name)
//into		:row_cnt
//from	( 
//		select 	AAA.cust_name,sum(AAA.summ) total
//		from	(
//				select    b.item_name, b.apply_qty,c.cust_name, a.req_no, a.item_seq,a.QUOT_PRICE, a.cust_no CUST_NO, a.quot_num, b.apply_qty * a.quot_price summ 
//				from	    stdb.hst107h a, stdb.hst105h b, stdb.hst001m c,
//							      (
//								  select bb.item_name NN, cc.cust_name XX, aa.req_no YY, aa.cust_no MM, aa.item_seq ZZ, bb.apply_qty FF, MAX(aa.quot_num) DD
//							      from stdb.hst107h aa, stdb.hst105h bb, stdb.hst001m cc
//							      where aa.req_no = bb.req_no
//								  and 	trim(aa.req_no) =	:as_req_no		
//								  and   aa.item_seq = bb.item_seq
//							      and   aa.cust_no = cc.cust_no
//							      group by bb.item_name, bb.apply_qty, cc.cust_name, aa.req_no, aa.cust_no, aa.item_seq
//							     )
//				where 	a.req_no = b.req_no
//						and   trim(a.req_no) =	:as_req_no
//						and	  a.item_seq 	 =		ZZ
//						and	  b.apply_qty 	 =		FF
//						and	  b.item_name 	 = NN
//						and   a.cust_no 	 = c.cust_no
//						and   c.cust_name 	 = XX
//						and   a.req_no 		 = YY
//						and   a.cust_no 	 = MM
//						and   a.quot_num 	 = DD
//				group by b.item_name, c.cust_name, b.apply_qty, a.req_no, a.ITEM_SEQ, a.QUOT_PRICE, a.cust_no, a.quot_num
//				order by a.cust_no, a.quot_price asc
//				)AAA							
//		group by	   cust_name
//		order by	   total	asc
//		)FFF		;
//		
//		
//
//
//this.object.t_10.text = "[산출근거]   "+string(row_cnt) + "개기관 제시금액중 최저금액 "
//this.object.t_16.text = "업 체 명 :   "+ ls_cust_name
//this.object.t_17.text = "가      격 :   "+string(ll_price, '#,###,##0') +"        ( VAT 포함 )"
//il_row_cnt = rowcount
end event

type gb_5 from groupbox within tabpage_1
integer x = 32
integer y = 68
integer width = 4306
integer height = 196
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "조회조건"
end type

type st_8 from statictext within tabpage_1
integer x = 101
integer y = 156
integer width = 297
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "접수번호"
boolean focusrectangle = false
end type

type sle_req_no2 from singlelineedit within tabpage_1
integer x = 448
integer y = 132
integer width = 585
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
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1992
string text = "견적의뢰서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print3 dw_print3
st_1 st_1
sle_req_no5 sle_req_no5
gb_6 gb_6
end type

on tabpage_2.create
this.dw_print3=create dw_print3
this.st_1=create st_1
this.sle_req_no5=create sle_req_no5
this.gb_6=create gb_6
this.Control[]={this.dw_print3,&
this.st_1,&
this.sle_req_no5,&
this.gb_6}
end on

on tabpage_2.destroy
destroy(this.dw_print3)
destroy(this.st_1)
destroy(this.sle_req_no5)
destroy(this.gb_6)
end on

type dw_print3 from datawindow within tabpage_2
integer x = 14
integer y = 268
integer width = 4329
integer height = 1712
integer taborder = 60
boolean titlebar = true
string title = "견적의뢰서"
string dataobject = "d_hgm401i_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type st_1 from statictext within tabpage_2
integer x = 123
integer y = 148
integer width = 261
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "접수번호"
boolean focusrectangle = false
end type

type sle_req_no5 from singlelineedit within tabpage_2
integer x = 384
integer y = 124
integer width = 567
integer height = 92
integer taborder = 55
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type gb_6 from groupbox within tabpage_2
integer x = 18
integer y = 52
integer width = 4325
integer height = 208
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "조회조건"
end type

type gb_7 from groupbox within w_hgm401i
boolean visible = false
integer x = 18
integer y = 48
integer width = 2597
integer height = 196
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "예산 통제 조회 조건"
end type

type gb_3 from groupbox within w_hgm401i
boolean visible = false
integer x = 27
integer y = 36
integer width = 1975
integer height = 184
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "물품 접수 조회 조건"
end type

type gb_8 from groupbox within w_hgm401i
boolean visible = false
integer x = 18
integer y = 48
integer width = 2597
integer height = 196
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "예산 통제 조회 조건"
end type

