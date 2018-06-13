$PBExportHeader$w_hgm402i.srw
$PBExportComments$비품수리견젹
forward
global type w_hgm402i from w_tabsheet
end type
type dw_list1 from cuo_dwwindow within tabpage_sheet01
end type
type st_4 from statictext within tabpage_sheet01
end type
type sle_id_no from singlelineedit within tabpage_sheet01
end type
type sle_item_nm from singlelineedit within tabpage_sheet01
end type
type st_3 from statictext within tabpage_sheet01
end type
type sle_cust_nm from singlelineedit within tabpage_sheet01
end type
type sle_cust_cd from singlelineedit within tabpage_sheet01
end type
type st_2 from statictext within tabpage_sheet01
end type
type st_1 from statictext within tabpage_sheet01
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type dw_list2 from cuo_dwwindow within tabpage_sheet01
end type
type st_5 from statictext within tabpage_sheet01
end type
type st_6 from statictext within tabpage_sheet01
end type
type dw_large_code from datawindow within tabpage_sheet01
end type
type sle_main_item from singlelineedit within tabpage_sheet01
end type
type gb_3 from groupbox within tabpage_sheet01
end type
type st_7 from statictext within tabpage_sheet01
end type
type em_date from editmask within tabpage_sheet01
end type
type cb_1 from commandbutton within tabpage_sheet01
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type sle_req_no2 from singlelineedit within tabpage_1
end type
type st_8 from statictext within tabpage_1
end type
type dw_print from cuo_dwprint within tabpage_1
end type
type gb_5 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
sle_req_no2 sle_req_no2
st_8 st_8
dw_print dw_print
gb_5 gb_5
end type
type tabpage_2 from userobject within tab_sheet
end type
type dw_print2 from cuo_dwwindow_one_hin within tabpage_2
end type
type sle_req_no3 from singlelineedit within tabpage_2
end type
type st_9 from statictext within tabpage_2
end type
type gb_4 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
dw_print2 dw_print2
sle_req_no3 sle_req_no3
st_9 st_9
gb_4 gb_4
end type
end forward

global type w_hgm402i from w_tabsheet
end type
global w_hgm402i w_hgm402i

type variables

int    ii_tab
long il_cnt_row
end variables

forward prototypes
public subroutine wf_retrieve (string as_flag)
end prototypes

public subroutine wf_retrieve (string as_flag);
int 	li_tab, li_ord_class, i, il_row_cnt
long 	ll_RowCnt
string ls_id_no, ls_item_name, ls_cust_no, ls_cust_name, ls_large_code
string ls_main_item, ls_req_no, ls_accept_date,ls_get_name[]	, ls_cust[]

li_tab = tab_sheet.selectedtab

CHOOSE CASE li_tab
		
	CASE 1      

      IF as_flag = 'I' OR as_flag = 'A' THEN    
			 
			ls_id_no = '%'
			ls_item_name = '%'
			
			ls_accept_date = trim(tab_sheet.tabpage_sheet01.em_date.text)
			
			if isnull(ls_accept_date)  or ls_accept_date = "" then
				ls_accept_date = '%'
				wf_setmsg("접수일자를 입력하세요")
				return
			Else
			End if
			
		   IF tab_sheet.tabpage_sheet01.dw_list1.retrieve( ls_id_no, ls_item_name, ls_accept_date) = 0 THEN
				tab_sheet.tabpage_sheet01.dw_update.reset()
//				wf_setMenu('I',FALSE)
			ELSE	
				tab_sheet.tabpage_sheet01.dw_list1.setfocus()
				tab_sheet.tabpage_sheet01.dw_list1.trigger event rowfocuschanged(1)
//				wf_setMenu('I',TRUE)
		   END IF	 		

     END IF

      IF as_flag = 'C' OR as_flag = 'A' THEN    
			
			ls_cust_no = trim(tab_sheet.tabpage_sheet01.sle_cust_cd.text) + '%'
			ls_cust_name = trim(tab_sheet.tabpage_sheet01.sle_cust_nm.text) + '%'
			tab_sheet.tabpage_sheet01.dw_large_code.accepttext()
 			ls_large_code = trim(tab_sheet.tabpage_sheet01.dw_large_code.object.code[tab_sheet.tabpage_sheet01.dw_large_code.getrow()]) + '%'
			if ls_large_code = '' or isnull(ls_large_code) then 
				ls_large_code = '%'
			end if
			
			ls_main_item = trim(tab_sheet.tabpage_sheet01.sle_main_item.text) + '%'
	      IF tab_sheet.tabpage_sheet01.dw_list2.retrieve( ls_cust_no, ls_cust_name, ls_large_code, ls_main_item ) = 0 THEN
		   END IF	  		

      END IF

	CASE 2									/** 	가격대비표 	**/
		
		ls_req_no = tab_sheet.tabpage_1.sle_req_no2.text
		
		if 	ls_req_no = "" or isnull(ls_req_no)	then
			   wf_setMsg("접수번호를 입력하세요")	
				return
		end if
		
		DECLARE		GET_CUST CURSOR		 FOR 			
					SELECT	 DISTINCT A.CUST_NO,B.CUST_NAME
					FROM  	 STDB.HST031H A, STDB.HST001M B
					WHERE 	 A.CUST_NO	=	B.CUST_NO	AND
								 A.REQ_NO	  =  :ls_req_no		;
					
			OPEN		GET_CUST;			

			FOR	i	=	1	TO	4
							FETCH	GET_CUST 
							INTO	:ls_cust_no, :ls_cust_name;

							ls_cust[i]			=	ls_cust_no							
							ls_get_name[i]		=	ls_cust_name														
			IF				SQLCA.SQLCODE	=	100	THEN
							ls_cust[i]		=	''														
							ls_get_name[i]	=	''											
							CLOSE	GET_CUST;
							
			ELSEIF		SQLCA.SQLCODE	<> 0	THEN
							ls_cust[i]		=	''							
							ls_get_name[i]	=	''										
							CLOSE	GET_CUST;							
			END IF	
		NEXT	
			
		 il_row_cnt = tab_sheet.tabpage_1.dw_print.retrieve( ls_cust[1],ls_cust[2],ls_cust[3],ls_cust[4],ls_req_no ) 		

		IF  il_cnt_row = 0 THEN
			tab_sheet.tabpage_1.dw_print.reset()
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE
			tab_sheet.tabpage_1.dw_print.object.t_1.text	=	ls_get_name[1]
			tab_sheet.tabpage_1.dw_print.object.t_2.text	=	ls_get_name[2]
			tab_sheet.tabpage_1.dw_print.object.t_6.text	=	ls_get_name[3]
			tab_sheet.tabpage_1.dw_print.object.t_3.text	=	ls_get_name[4]				
		END IF	  				
		
	CASE 3
		String  ls_req_no3
		 ls_req_no3 = tab_sheet.tabpage_2.sle_req_no3.text
		 IF isnull(ls_req_no3) OR  ls_req_no3 = '' THEN
			 messagebox('확인','접수번호를 입력하시기바랍니다..!')
		 END IF
		 
		 ll_RowCnt =  tab_sheet.tabpage_2.dw_print2.retrieve(ls_req_no3)
		 
		 IF ll_RowCnt = 0 THEN
			 wf_SetMsg('조회된 자료가없습니다..!')
//			 wf_Setmenu('R',TRUE)
		 ELSE
			 wf_SetMsg('자료가 조회되었습니다..!')
//			 wf_Setmenu('R',TRUE)
//			 wf_Setmenu('p',TRUE)
		 END IF
		 
		
END CHOOSE
end subroutine

on w_hgm402i.create
int iCurrent
call super::create
end on

on w_hgm402i.destroy
call super::destroy
end on

event ue_delete;call super::ue_delete;
int li_rowcount, li_count
long li_row
string ls_ord_no, ls_cust_no, ls_req_no


ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name = tab_sheet.tabpage_sheet01.dw_update
	   
		li_row = idw_name.getrow()
		
	   IF li_row <> 0 THEN
	      			
			dwItemStatus l_status 
			l_status = idw_name.getitemstatus(li_row, 0, Primary!)
		
			IF l_status = New! OR l_status = NewModified! THEN 
				
				idw_name.deleterow(li_row)
				
			ELSE
			
			  IF f_messagebox( '2', 'DEL' ) = 1 THEN
			
			     ls_ord_no = idw_name.object.ord_no[li_row]
				  ls_cust_no = idw_name.object.cust_no[li_row] 
			
			     SELECT COUNT(*)                           // 물품 발주 T
				  INTO :li_count
				  FROM STDB.HST031H
				  WHERE ORD_NO = :ls_ord_no  AND
				        CUST_NO = :ls_cust_no   ;
				  			
				  IF li_count <> 0 THEN		
					  messagebox("확인","삭제할수 없습니다. 발주 처리되었습니다")
					  RETURN		
				  END IF
				  
				  ls_req_no = idw_name.object.req_no[li_row]
				 
				  idw_name.deleterow(li_row)
				  
              IF idw_name.rowcount() = 0 THEN 
	    
					  UPDATE STDB.HST030H          // 견적 등록된 업체가 없으면 HST030의 STAT_CLASS컬럼을 예산통제 : 2  
					  SET 	STAT_CLASS = 2             
					  WHERE  REQ_NO = :ls_req_no  ;				  
				  
			     END IF
				  
				  IF f_update( idw_name,'D') = TRUE THEN 
					  wf_retrieve('I')
					  wf_setmsg("삭제되었습니다")
				  END IF				
			  END IF		
			END IF
		END IF
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

/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 메뉴버튼 활성화/비활성화처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('I',FALSE)	//입력버튼
//wf_setMenu('R',TRUE)		//조회버튼
//wf_Setmenu('D',FALSE)	//삭제버튼
//wf_Setmenu('S',FALSE)	//저장버튼
//wf_Setmenu('P',TRUE)	//인쇄버튼

////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_insert;call super::ue_insert;
datawindow dw_iname
int li_row, li_quot_num, li_req_no, li_item_seq
long ll_row, i, ll_ord_class, ll_item_class
string ls_cust_no, ls_req_no, ls_item_name, ls_id_no

ii_tab = tab_sheet.selectedtab
ls_cust_no	=	tab_sheet.tabpage_sheet01.dw_list2.object.cust_no[tab_sheet.tabpage_sheet01.dw_list2.getrow()]

CHOOSE CASE ii_tab
	CASE 1
		
		idw_name = tab_sheet.tabpage_sheet01.dw_update
		dw_iname = tab_sheet.tabpage_sheet01.dw_list1

         ll_ord_class = dw_iname.object.stat_class[dw_iname.getrow()]
		IF ll_ord_class = 4 THEN
			messagebox('확인','견적이 완료되었습니다..!')
	   ELSE
		   li_row      = idw_name.insertrow(0)
			ls_req_no   = 	dw_iname.object.req_no[dw_iname.getrow()]
			li_item_seq =  dw_iname.object.item_seq[dw_iname.getrow()]
			ls_item_name=  dw_iname.object.ITEM_NAME[dw_iname.getrow()]	
			ls_id_no    =  dw_iname.object.id_no[dw_iname.getrow()]	
			ll_item_class=  dw_iname.object.item_class[dw_iname.getrow()]	
			idw_name.object.req_no  [li_row]     =  ls_req_no      	 		 // 접수 번호 
			idw_name.object.cust_no [li_row]     =  ls_cust_no		 		 // 업체 번호 			
			idw_name.object.item_seq[li_row]     =  li_item_seq      	 	 // 품목 번호 			
			idw_name.object.item_name[li_row]    =  ls_item_name      	 	 // 품목 명 
			idw_name.object.id_no    [li_row]    =  ls_id_no    	 	       // 등재번호 
			idw_name.object.item_class[li_row]   =  ll_item_class     	 	 // 품목구분 
         

  	
		SELECT	nvl(max(QUOT_NUM), 0)+1
		INTO		:li_quot_num
		FROM		STDB.HST031H
		WHERE		REQ_NO = :ls_req_no AND  CUST_NO	=	:ls_cust_no	 AND ITEM_SEQ = :li_item_Seq;
	
	
		idw_name.object.quot_num[li_row] =  li_quot_num      	 	 // 견적 번호 						
	   idw_name.object.work_date[li_row] = f_sysdate()              // 작업 일자  
		idw_name.object.worker[li_row]    = gstru_uid_uname.uid      // 작업자 
		idw_name.object.ipaddr[li_row]    = gstru_uid_uname.address  //IP
		
	   idw_name.setfocus()
		idw_name.setrow(li_row)
     END IF
END CHOOSE

end event

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////
//// 	작성목적 : 비품견적
////    적 성 인 : 
////		작성일자 : 
////    변 경 인 :
////    변경일자 :
////    변경사유 :
////////////////////////////////////////////////////////////////////
//
Datawindowchild dwc_large_code	
//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)
//wf_setMenu('P',TRUE)

tab_sheet.tabpage_sheet01.dw_list1.reset()
tab_sheet.tabpage_sheet01.dw_list2.reset()
tab_sheet.tabpage_sheet01.dw_update.reset()

tab_sheet.tabpage_sheet01.dw_large_code.reset()
tab_sheet.tabpage_sheet01.dw_large_code.getchild('code', dwc_large_code)
tab_sheet.tabpage_sheet01.dw_large_code.insertrow(0)
dwc_large_code.settransobject(sqlca)
dwc_large_code.retrieve()

tab_sheet.tabpage_sheet01.em_date.text = f_today()
tab_sheet.tabpage_2.dw_print2.Object.DataWindow.Print.Preview = 'YES'
wf_retrieve('A') 

end event

event ue_retrieve;call super::ue_retrieve;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_retrieve
////	기 능 설 명: 자료조회 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
// 3. 메뉴버튼 활성화/비활성화처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('I',TRUE)		//입력버튼
//wf_setMenu('R',TRUE)		//조회버튼
//wf_Setmenu('D',TRUE)		//삭제버튼
//wf_Setmenu('S',TRUE)		//저장버튼
tab_sheet.tabpage_sheet01.dw_update.Object.DataWindow.ReadOnly = 'NO'
wf_retrieve('A')
return 1
end event

event ue_save;call super::ue_save;
int li_row, i, li_quot_num
string ls_cust_no, ls_ord_no, ls_id_no, ls_cur_req_no, ls_cur_cust_no
string 	ls_new_ord_no, ls_apply_date
long ll_item_class, ll_apply_no, ll_new_ord_no,ll_item_seq
DwItemStatus ldis_Status			

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
     
	  idw_name = tab_sheet.tabpage_sheet01.dw_update
	  	  
	  idw_name.accepttext()	  
	  
  	  IF f_chk_modified(idw_name) = FALSE THEN RETURN -1
	  
	  li_row = idw_name.rowcount()

	  
	  IF li_row <> 0 THEN

			  FOR i = 1 TO li_row
					ldis_Status = idw_name.GetItemStatus(i,0,Primary!)	
					ls_cur_req_no	= idw_name.object.req_no[i]
					ls_cur_cust_no	=	idw_name.object.cust_no[i]
					ll_item_seq	=	idw_name.object.item_seq[i]
					
					IF ldis_Status = New! OR ldis_Status = NewModified! THEN					
					
	
						  idw_name.object.job_uid[i] = gstru_uid_uname.uid			//수정자
						  idw_name.object.job_date[i] = f_sysdate()            	// 오늘 일자 
						  idw_name.object.job_add[i] = gstru_uid_uname.address 	//IP
				  
						  UPDATE STDB.HST030H                  // 견적 등록 : 5  
						  SET STAT_CLASS = 4             
						  WHERE REQ_NO = :ls_cur_req_no AND ITEM_SEQ = :ll_item_seq ;
			  
						  if sqlca.sqlcode <0 then
							  wf_setmsg("저장중 오류가 발생하였습니다.")			
								rollback;
								return -1
						  end if		  
					END IF
			  NEXT
	  END IF

		  string ls_colarry[] = {'id_no/등재 번호', 'cust_no/거래처'}
		
		  IF f_chk_null( idw_name, ls_colarry ) = 1 THEN 
	
			  IF f_update( idw_name,'U') THEN 
				  wf_retrieve('I')
				  wf_setmsg("저장되었습니다")
				  idw_name.RESET()
			  END IF
		  END IF	

END CHOOSE




end event

event ue_print;call super::ue_print;int	li_tab

li_tab = tab_sheet.selectedtab

CHOOSE CASE li_tab
		

	CASE	2
		if tab_sheet.tabpage_1.dw_print.rowcount() > 0 then f_print(tab_sheet.tabpage_1.dw_print)
	CASE	3
		if tab_sheet.tabpage_2.dw_print2.rowcount() > 0 then f_print(tab_sheet.tabpage_2.dw_print2)
END CHOOSE		


end event

type ln_templeft from w_tabsheet`ln_templeft within w_hgm402i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hgm402i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hgm402i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hgm402i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hgm402i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hgm402i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hgm402i
end type

type uc_insert from w_tabsheet`uc_insert within w_hgm402i
end type

type uc_delete from w_tabsheet`uc_delete within w_hgm402i
end type

type uc_save from w_tabsheet`uc_save within w_hgm402i
end type

type uc_excel from w_tabsheet`uc_excel within w_hgm402i
end type

type uc_print from w_tabsheet`uc_print within w_hgm402i
end type

type st_line1 from w_tabsheet`st_line1 within w_hgm402i
end type

type st_line2 from w_tabsheet`st_line2 within w_hgm402i
end type

type st_line3 from w_tabsheet`st_line3 within w_hgm402i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hgm402i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hgm402i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hgm402i
integer height = 2508
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

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

event tab_sheet::selectionchanged;call super::selectionchanged;
//IF 	oldindex	=	1	THEN
//		tab_sheet.tabpage_1.sle_req_no2.text=	tab_sheet.tabpage_sheet01.sle_accept_num.text
//END IF	
end event

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
integer height = 2392
string text = "비품수리견적"
dw_list1 dw_list1
st_4 st_4
sle_id_no sle_id_no
sle_item_nm sle_item_nm
st_3 st_3
sle_cust_nm sle_cust_nm
sle_cust_cd sle_cust_cd
st_2 st_2
st_1 st_1
dw_update dw_update
dw_list2 dw_list2
st_5 st_5
st_6 st_6
dw_large_code dw_large_code
sle_main_item sle_main_item
gb_3 gb_3
st_7 st_7
em_date em_date
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
end type

on tabpage_sheet01.create
this.dw_list1=create dw_list1
this.st_4=create st_4
this.sle_id_no=create sle_id_no
this.sle_item_nm=create sle_item_nm
this.st_3=create st_3
this.sle_cust_nm=create sle_cust_nm
this.sle_cust_cd=create sle_cust_cd
this.st_2=create st_2
this.st_1=create st_1
this.dw_update=create dw_update
this.dw_list2=create dw_list2
this.st_5=create st_5
this.st_6=create st_6
this.dw_large_code=create dw_large_code
this.sle_main_item=create sle_main_item
this.gb_3=create gb_3
this.st_7=create st_7
this.em_date=create em_date
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.sle_id_no
this.Control[iCurrent+4]=this.sle_item_nm
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.sle_cust_nm
this.Control[iCurrent+7]=this.sle_cust_cd
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.dw_update
this.Control[iCurrent+11]=this.dw_list2
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.dw_large_code
this.Control[iCurrent+15]=this.sle_main_item
this.Control[iCurrent+16]=this.gb_3
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.em_date
this.Control[iCurrent+19]=this.cb_1
this.Control[iCurrent+20]=this.gb_1
this.Control[iCurrent+21]=this.gb_2
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_list1)
destroy(this.st_4)
destroy(this.sle_id_no)
destroy(this.sle_item_nm)
destroy(this.st_3)
destroy(this.sle_cust_nm)
destroy(this.sle_cust_cd)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_update)
destroy(this.dw_list2)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.dw_large_code)
destroy(this.sle_main_item)
destroy(this.gb_3)
destroy(this.st_7)
destroy(this.em_date)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 658
integer width = 3195
integer height = 1476
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
end type

type uo_tab from w_tabsheet`uo_tab within w_hgm402i
end type

type dw_con from w_tabsheet`dw_con within w_hgm402i
end type

type st_con from w_tabsheet`st_con within w_hgm402i
end type

type dw_list1 from cuo_dwwindow within tabpage_sheet01
integer x = 41
integer y = 328
integer width = 3081
integer height = 1200
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "신청 내역"
string dataobject = "d_hgm402i_2"
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;call super::rowfocuschanged;
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

string ls_id_no, ls_apply_date,ls_req_no
long	ll_item_class, ll_apply_no


dw_update.reset()

IF currentrow <> 0 THEN
   tab_sheet.tabpage_sheet01.dw_list1.setfocus()
	ls_req_no = trim(tab_sheet.tabpage_sheet01.dw_list1.object.req_no[tab_sheet.tabpage_sheet01.dw_list1.getrow()])
	tab_sheet.tabpage_sheet01.dw_update.retrieve(ls_req_no)	
END IF

end event

type st_4 from statictext within tabpage_sheet01
boolean visible = false
integer x = 123
integer y = 144
integer width = 256
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
string text = "등재번호"
boolean focusrectangle = false
end type

type sle_id_no from singlelineedit within tabpage_sheet01
boolean visible = false
integer x = 411
integer y = 116
integer width = 517
integer height = 80
integer taborder = 80
boolean bringtotop = true
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

type sle_item_nm from singlelineedit within tabpage_sheet01
boolean visible = false
integer x = 1317
integer y = 116
integer width = 622
integer height = 80
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "IBeam!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_sheet01
boolean visible = false
integer x = 1088
integer y = 144
integer width = 233
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
string text = "품목명"
boolean focusrectangle = false
end type

type sle_cust_nm from singlelineedit within tabpage_sheet01
integer x = 2487
integer y = 204
integer width = 457
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "IBeam!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event constructor;f_pro_toggle('k',handle(parent))
end event

event modified;wf_retrieve('C')
end event

type sle_cust_cd from singlelineedit within tabpage_sheet01
integer x = 2487
integer y = 116
integer width = 375
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "IBeam!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within tabpage_sheet01
integer x = 2217
integer y = 232
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
string text = "거래처명"
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_sheet01
integer x = 2135
integer y = 144
integer width = 329
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
string text = "거래처코드"
boolean focusrectangle = false
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
integer x = 69
integer y = 1604
integer width = 3739
integer height = 740
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hgm402i_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;//this.uf_setClick(False)
end event

event rowfocuschanged;call super::rowfocuschanged;
//THIS.selectrow(0,False)
//THIS.selectrow(currentrow, TRUE)
end event

type dw_list2 from cuo_dwwindow within tabpage_sheet01
integer x = 3131
integer y = 324
integer width = 704
integer height = 1200
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "거래처 조회 내역"
string dataobject = "d_hgm101i_1"
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;call super::doubleclicked;//
//int li_row
//datawindow dw_name
//
//IF row = 0 THEN RETURN
//		
//dw_name = dw_update
//
//li_row = dw_name.getrow()
//
//dwItemStatus l_status 
//l_status = dw_name.getitemstatus(li_row, 0, Primary!)
//	
//IF l_status = New! OR l_status = NewModified! THEN 
//
//   dw_name.object.cust_no[li_row] = this.object.cust_no[row]
// 
//END IF
//


datawindow dw_iname
int li_row, li_quot_num, li_req_no, li_item_seq
long ll_row, i, ll_ord_class, ll_item_class
string ls_cust_no, ls_req_no, ls_item_name, ls_id_no

ii_tab = tab_sheet.selectedtab
ls_cust_no	=	tab_sheet.tabpage_sheet01.dw_list2.object.cust_no[tab_sheet.tabpage_sheet01.dw_list2.getrow()]

CHOOSE CASE ii_tab
	CASE 1
		
		idw_name = tab_sheet.tabpage_sheet01.dw_update
		dw_iname = tab_sheet.tabpage_sheet01.dw_list1
	
         ll_ord_class = dw_iname.object.stat_class[dw_iname.getrow()]
		IF ll_ord_class = 5 THEN
			messagebox('확인','견적이 완료되었습니다..!')
	   ELSE
		   li_row      = idw_name.insertrow(0)
			ls_req_no   = 	dw_iname.object.req_no[dw_iname.getrow()]
			li_item_seq =  dw_iname.object.item_seq[dw_iname.getrow()]
			ls_item_name=  dw_iname.object.ITEM_NAME[dw_iname.getrow()]	
			ls_id_no    =  dw_iname.object.id_no[dw_iname.getrow()]	
			ll_item_class=  dw_iname.object.item_class[dw_iname.getrow()]	
			idw_name.object.req_no  [li_row]     =  ls_req_no      	 		 // 접수 번호 
			idw_name.object.cust_no [li_row]     =  ls_cust_no		 		    // 업체 번호 			
			idw_name.object.item_seq[li_row]     =  li_item_seq      	 	 // 품목 번호 			
			idw_name.object.item_name[li_row]    =  ls_item_name      	 	 // 품목 명 
			idw_name.object.id_no    [li_row]    =  ls_id_no    	 	       // 등재번호 
			idw_name.object.item_class[li_row]   =  ll_item_class     	 	 // 품목구분 
         

  	
		SELECT	nvl(max(QUOT_NUM), 0)+1
		INTO		:li_quot_num
		FROM		STDB.HST031H
		WHERE		REQ_NO = :ls_req_no AND  CUST_NO	=	:ls_cust_no	 AND ITEM_SEQ = :li_item_Seq;
	
	
			idw_name.object.quot_num[li_row] =  li_quot_num      	 	 // 견적 번호 						
	 
//	   END IF
	
	   idw_name.object.work_date[li_row] = f_sysdate()              // 작업 일자  
		idw_name.object.worker[li_row]    = gstru_uid_uname.uid      // 작업자 
		idw_name.object.ipaddr[li_row]    = gstru_uid_uname.address  //IP
		
	   idw_name.setfocus()
		idw_name.setrow(li_row)
//	next
     END IF
END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;//this.selectrow( 0, false )
//this.selectrow( currentrow, true )
//

end event

type st_5 from statictext within tabpage_sheet01
boolean visible = false
integer x = 2944
integer y = 120
integer width = 457
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "대분류"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_sheet01
integer x = 2953
integer y = 208
integer width = 457
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
string text = "주종목"
boolean focusrectangle = false
end type

type dw_large_code from datawindow within tabpage_sheet01
boolean visible = false
integer x = 3150
integer y = 96
integer width = 649
integer height = 96
integer taborder = 55
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

type sle_main_item from singlelineedit within tabpage_sheet01
integer x = 3150
integer y = 204
integer width = 645
integer height = 88
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;wf_retrieve('C')
end event

event constructor;f_pro_toggle('k',handle(parent))
end event

type gb_3 from groupbox within tabpage_sheet01
integer x = 27
integer y = 1544
integer width = 3822
integer height = 836
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 67108864
string text = "견적내역"
end type

type st_7 from statictext within tabpage_sheet01
integer x = 265
integer y = 184
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "신청일자"
boolean focusrectangle = false
end type

type em_date from editmask within tabpage_sheet01
integer x = 539
integer y = 164
integer width = 366
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
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type cb_1 from commandbutton within tabpage_sheet01
integer x = 3150
integer y = 100
integer width = 457
integer height = 92
integer taborder = 65
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회"
end type

event clicked;String  ls_cust_no,  ls_cust_name, ls_main_item

ls_cust_no   = tab_sheet.tabpage_sheet01.sle_cust_cd.text + '%'
ls_cust_name = tab_sheet.tabpage_sheet01.sle_cust_nm.text + '%'
ls_main_item = tab_sheet.tabpage_sheet01.sle_main_item.text + '%'

IF tab_sheet.tabpage_sheet01.dw_list2.retrieve( ls_cust_no, ls_cust_name, '%' , ls_main_item ) = 0 THEN
   wf_setMsg("조회된 데이타가 없습니다")	
END IF	  	



end event

type gb_1 from groupbox within tabpage_sheet01
integer x = 23
integer y = 44
integer width = 2053
integer height = 260
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "비품수리조회"
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 2126
integer y = 56
integer width = 1733
integer height = 260
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "거래처 조회조건"
end type

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 4338
integer height = 2392
long backcolor = 79741120
string text = "가격대비표"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
sle_req_no2 sle_req_no2
st_8 st_8
dw_print dw_print
gb_5 gb_5
end type

on tabpage_1.create
this.sle_req_no2=create sle_req_no2
this.st_8=create st_8
this.dw_print=create dw_print
this.gb_5=create gb_5
this.Control[]={this.sle_req_no2,&
this.st_8,&
this.dw_print,&
this.gb_5}
end on

on tabpage_1.destroy
destroy(this.sle_req_no2)
destroy(this.st_8)
destroy(this.dw_print)
destroy(this.gb_5)
end on

type sle_req_no2 from singlelineedit within tabpage_1
integer x = 448
integer y = 132
integer width = 585
integer height = 92
integer taborder = 40
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

type st_8 from statictext within tabpage_1
integer x = 101
integer y = 156
integer width = 297
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "접수번호"
boolean focusrectangle = false
end type

type dw_print from cuo_dwprint within tabpage_1
integer x = 37
integer y = 300
integer width = 3758
integer height = 2056
integer taborder = 11
string dataobject = "d_hgm402i_3-1"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;call super::retrieveend;
long	ll_price, ll_row_cnt
string ls_cust_name, as_req_no


as_req_no	=	tab_sheet.tabpage_1.sle_req_no2.text

if rowcount <  1  then   return -1
//ll_price = this.object.grand_sum_sheet_price[1]
//ls_cust_name = this.object.cust_name[1]

									
									/**  최소값을 갖는 업체와 가격 구하기 **/

select  cc.cust_name, cc.total 
into 	  :ls_cust_name, :ll_price
from   (
		select 	aa.cust_name,sum(sheet_price) total
		from  	(
				select 	ITM_NM, c.cust_name, a.req_no, a.item_seq, a.cust_no CUST_NO, a.quot_num,a.sheet_price
				from 	stdb.hst031h a, stdb.hst030h b, stdb.hst001m c, 
				     	(
						  select  kk.item_name ITM_NM ,cc.cust_name XX, aa.req_no YY, aa.cust_no MM, aa.item_seq ZZ,  MAX(aa.quot_num) DD
					      from stdb.hst031h aa, stdb.hst030h bb, stdb.hst001m cc,stdb.hst004m kk, stdb.hst027m	  jj
					      where TRIM(aa.req_no) = TRIM(bb.req_no)
						  and 	trim(aa.req_no) =	:as_req_no
						  and	  bb.id_no		 =	jj.id_no
						  and	  bb.item_class	 =	jj.item_class
						  and	  jj.item_no	 =	kk.item_no		
						  and   aa.item_seq = bb.item_seq
					      and   aa.cust_no = cc.cust_no
					      group by  kk.item_name, cc.cust_name, aa.req_no, aa.cust_no, aa.item_seq
					     )
				where 	 TRIM(a.req_no) = TRIM(b.req_no)
							and   trim(a.req_no) =	:as_req_no
							and	  a.item_seq =		ZZ
							and   a.cust_no = c.cust_no
							and   c.cust_name = XX
							and   TRIM(a.req_no) = TRIM(YY)
							and   a.cust_no = MM
							and   a.quot_num = DD
				group by  ITM_NM,c.cust_name, a.req_no, a.ITEM_SEQ,  a.cust_no, a.quot_num, a.sheet_price
				order by a.cust_no asc
				)AA
		group by AA.cust_name,AA.cust_no
		)CC,	
		(
		select 	min(sum(sheet_price)) min_total
		from  	(
				select 	ITM_NM, c.cust_name, a.req_no, a.item_seq, a.cust_no CUST_NO, a.quot_num,a.sheet_price
				from 	stdb.hst031h a, stdb.hst030h b, stdb.hst001m c, 
				     	(
						  select  kk.item_name ITM_NM ,cc.cust_name XX, aa.req_no YY, aa.cust_no MM, aa.item_seq ZZ,  MAX(aa.quot_num) DD
					      from stdb.hst031h aa, stdb.hst030h bb, stdb.hst001m cc,stdb.hst004m kk, stdb.hst027m	  jj
					      where TRIM(aa.req_no) = TRIM(bb.req_no)
						  and 	trim(aa.req_no) =	:as_req_no
						  and	  bb.id_no		 =	jj.id_no
						  and	  bb.item_class	 =	jj.item_class
						  and	  jj.item_no	 =	kk.item_no		
						  and   aa.item_seq = bb.item_seq
					      and   aa.cust_no = cc.cust_no
					      group by  kk.item_name, cc.cust_name, aa.req_no, aa.cust_no, aa.item_seq
					     )
				where 	 TRIM(a.req_no) = TRIM(b.req_no)
							and   trim(a.req_no) =	:as_req_no
							and	  a.item_seq =		ZZ
							and   a.cust_no = c.cust_no
							and   c.cust_name = XX
							and   TRIM(a.req_no) = TRIM(YY)
							and   a.cust_no = MM
							and   a.quot_num = DD
				group by  ITM_NM,c.cust_name, a.req_no, a.ITEM_SEQ,  a.cust_no, a.quot_num, a.sheet_price
				order by a.cust_no asc
				)AA
		group by AA.cust_name,AA.cust_no
		)DD
where	   CC.total = dd.min_total	;			


															/**	업체 수 구하기		**/

select	count(*)
into		:ll_row_cnt
from  	(
		select 	aa.cust_name,sum(sheet_price) total
		from  	(
				select 	ITM_NM, c.cust_name, a.req_no, a.item_seq, a.cust_no CUST_NO, a.quot_num,a.sheet_price
				from 	stdb.hst031h a, stdb.hst030h b, stdb.hst001m c, 
				     	(
						  select  kk.item_name ITM_NM ,cc.cust_name XX, aa.req_no YY, aa.cust_no MM, aa.item_seq ZZ,  MAX(aa.quot_num) DD
					      from stdb.hst031h aa, stdb.hst030h bb, stdb.hst001m cc,stdb.hst004m kk, stdb.hst027m	  jj
					      where TRIM(aa.req_no) = TRIM(bb.req_no)
						  and 	trim(aa.req_no) =	:as_req_no
						  and	  bb.id_no		 =	jj.id_no
						  and	  bb.item_class	 =	jj.item_class
						  and	  jj.item_no	 =	kk.item_no		
						  and   aa.item_seq = bb.item_seq
					      and   aa.cust_no = cc.cust_no
					      group by  kk.item_name, cc.cust_name, aa.req_no, aa.cust_no, aa.item_seq
					     )
				where 	 TRIM(a.req_no) = TRIM(b.req_no)
							and   trim(a.req_no) =	:as_req_no
							and	  a.item_seq =		ZZ
							and   a.cust_no = c.cust_no
							and   c.cust_name = XX
							and   TRIM(a.req_no) = TRIM(YY)
							and   a.cust_no 	= MM
							and   a.quot_num 	= DD
				group by  ITM_NM,c.cust_name, a.req_no, a.ITEM_SEQ,  a.cust_no, a.quot_num, a.sheet_price
				order by a.cust_no asc
				)AA
		group by AA.cust_name,AA.cust_no
		);															



this.object.t_10.text = "[산출근거] "+string(ll_row_cnt) + " 개기관 제시금액중 최저금액 "
this.object.t_17.text = "업 체 명 : "+ ls_cust_name
this.object.t_16.text = "가      격 : "+string(ll_price,'#,###,##0') +"        ( VAT 포함 )"

il_cnt_row = rowcount
end event

type gb_5 from groupbox within tabpage_1
integer x = 32
integer y = 68
integer width = 1723
integer height = 196
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "조회조건"
end type

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 100
integer width = 4338
integer height = 2392
long backcolor = 79741120
string text = "견적의뢰서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print2 dw_print2
sle_req_no3 sle_req_no3
st_9 st_9
gb_4 gb_4
end type

on tabpage_2.create
this.dw_print2=create dw_print2
this.sle_req_no3=create sle_req_no3
this.st_9=create st_9
this.gb_4=create gb_4
this.Control[]={this.dw_print2,&
this.sle_req_no3,&
this.st_9,&
this.gb_4}
end on

on tabpage_2.destroy
destroy(this.dw_print2)
destroy(this.sle_req_no3)
destroy(this.st_9)
destroy(this.gb_4)
end on

type dw_print2 from cuo_dwwindow_one_hin within tabpage_2
integer x = 32
integer y = 276
integer width = 3785
integer height = 2084
integer taborder = 11
string dataobject = "d_hgm402i_4"
end type

type sle_req_no3 from singlelineedit within tabpage_2
integer x = 530
integer y = 120
integer width = 549
integer height = 92
integer taborder = 65
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

type st_9 from statictext within tabpage_2
integer x = 233
integer y = 144
integer width = 279
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "접수번호"
boolean focusrectangle = false
end type

type gb_4 from groupbox within tabpage_2
integer x = 37
integer y = 52
integer width = 1614
integer height = 208
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "죄회조건"
end type

