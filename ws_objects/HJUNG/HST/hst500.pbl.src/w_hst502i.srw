$PBExportHeader$w_hst502i.srw
$PBExportComments$자산폐기처리
forward
global type w_hst502i from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type gb_5 from groupbox within tabpage_sheet01
end type
type dw_head2 from datawindow within tabpage_sheet01
end type
type dw_update1 from uo_dwgrid within tabpage_sheet01
end type
type cb_1 from uo_imgbtn within tabpage_sheet01
end type
type cb_2 from uo_imgbtn within tabpage_sheet01
end type
type tab_sheet_2 from userobject within tab_sheet
end type
type gb_3 from groupbox within tab_sheet_2
end type
type dw_update2 from uo_dwgrid within tab_sheet_2
end type
type tab_sheet_2 from userobject within tab_sheet
gb_3 gb_3
dw_update2 dw_update2
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print2 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print2 dw_print2
end type
type tabpage_2 from userobject within tab_sheet
end type
type dw_print1 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
dw_print1 dw_print1
end type
type dw_head from datawindow within w_hst502i
end type
type rb_total from radiobutton within w_hst502i
end type
type rb_dele from radiobutton within w_hst502i
end type
type dw_update3 from cuo_dwwindow_one_hin within w_hst502i
end type
type gb_4 from groupbox within w_hst502i
end type
type gb_1 from groupbox within w_hst502i
end type
end forward

global type w_hst502i from w_tabsheet
string title = "자산폐기처리"
dw_head dw_head
rb_total rb_total
rb_dele rb_dele
dw_update3 dw_update3
gb_4 gb_4
gb_1 gb_1
end type
global w_hst502i w_hst502i

type variables

int ii_tab
datawindow idw_sname,idw_list, idw_name1
end variables

forward prototypes
public subroutine wf_save ()
public subroutine wf_save2 ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_save ();String ls_sysdate, ls_Worker, ls_IPAddr, ls_JOB_UID, ls_JOB_ADD
Long ll_rowcount, ll_maxnum, ll_maxnum2, idx, ll_row
DataWindow  dw_sname, dw_name
dw_sname = dw_update3
dw_name  = tab_sheet.tabpage_sheet01.dw_update1
ls_sysdate = string(f_sysdate())
ll_rowcount = dw_name.rowcount()

select max(seq)
into   :ll_maxnum 
from   stdb.hst037m;
IF isnull(ll_maxnum) THEN
	ll_maxnum = 0
END IF 

ll_maxnum2 = ll_maxnum + 1
FOR idx = 1 TO ll_rowcount
    DwItemStatus	lds_Status01
    lds_Status01 = dw_name.getitemstatus(idx,0,Primary!)

	 IF lds_Status01 = NotModified! THEN 
		 RETURN
	 END IF

        ll_row = dw_sname.insertrow(0)
			
  	   dw_sname.object.id_no         [ll_row]  = dw_name.object.id_no         [idx]    //등재번호  
   	dw_sname.object.item_class    [ll_row]  = dw_name.object.item_class    [idx]    //품목구분              
   	dw_sname.object.seq           [ll_row]  = ll_maxnum2                            //이력번호           
   	dw_sname.object.revenue_opt   [ll_row]  = dw_name.object.revenue_opt   [idx]    //구입재원            
   	dw_sname.object.purchase_price[ll_row]  = dw_name.object.purchase_price[idx]    //구입단가            
   	dw_sname.object.purchase_amt  [ll_row]  = dw_name.object.purchase_amt  [idx]    //구입금액            
   	dw_sname.object.nation_amt    [ll_row]  = dw_name.object.nation_amt    [idx]    //국고사용금액        
   	dw_sname.object.replace_amt   [ll_row]  = dw_name.object.replace_amt   [idx]    //국고대응금액        
   	dw_sname.object.school_amt    [ll_row]  = dw_name.object.school_amt    [idx]    //교비사용금액        
   	dw_sname.object.prepare_amt   [ll_row]  = dw_name.object.prepare_amt   [idx]    //기성회비사용금액    
   	dw_sname.object.gwa           [ll_row]  = dw_name.object.gwa           [idx]    //사용부서            
   	dw_sname.object.room_code     [ll_row]  = dw_name.object.room_code     [idx]    //사용장소            
   	dw_sname.object.oper_opt      [ll_row]  = dw_name.object.loss_class    [idx]    //운용구분            
   	dw_sname.object.purchase_opt  [ll_row]  = dw_name.object.purchase_opt  [idx]    //구매방법            
   	dw_sname.object.in_no         [ll_row]  = dw_name.object.in_no         [idx]    //입고번호  
		dw_sname.object.tool_class    [ll_row]  = dw_name.object.tool_class    [idx]    //입고번호
     

     IF  isnull(dw_sname.object.in_no[ll_row]) THEN
		   dw_sname.object.in_no[ll_row] = 0
	  END IF
      ///////////////////////////////////////////////////////////////////////////////////////
      // 3. 저장처리전 체크사항 기술
      ///////////////////////////////////////////////////////////////////////////////////////

		IF ll_row > 0 THEN
			ls_Worker     = gstru_uid_uname.uid				//등록자
			ls_IPAddr     = gstru_uid_uname.address		//등록단말기
  			ls_JOB_UID	  =gstru_uid_uname.uid	         //등록자
   		ls_JOB_ADD	  =gstru_uid_uname.address		   //등록단말기
		END IF
		////////////////////////////////////////////////////////////////////////////////////
		// 3.1 수정항목 처리
		////////////////////////////////////////////////////////////////////////////////////
		dw_update3.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
		dw_update3.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
//		dw_update1.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
		dw_update3.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
		dw_update3.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
//		dw_update1.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자

	 	///////////////////////////////////////////////////////////////////////////////////////
		// 5. 자료저장처리
		///////////////////////////////////////////////////////////////////////////////////////
		dw_update3.update()
		commit;

	NEXT
					  
	 			if sqlca.sqlcode <> 0 then
					wf_setmsg("저장실패")
					return
				end if

end subroutine

public subroutine wf_save2 ();String ls_sysdate, ls_Worker, ls_IPAddr, ls_JOB_UID, ls_JOB_ADD
Long ll_rowcount, ll_maxnum, ll_maxnum2, idx, ll_row
DataWindow  dw_sname, dw_name
dw_sname = dw_update3
dw_name  = tab_sheet.tab_sheet_2.dw_update2
ls_sysdate = string(f_sysdate())
ll_rowcount = dw_name.rowcount()

select max(seq)
into   :ll_maxnum 
from   stdb.hst037m;
IF isnull(ll_maxnum) THEN
	ll_maxnum = 0
END IF 

ll_maxnum2 = ll_maxnum + 1
FOR idx = 1 TO ll_rowcount
    DwItemStatus	lds_Status01
    lds_Status01 = dw_name.getitemstatus(idx,0,Primary!)

	 IF lds_Status01 = NotModified! THEN 
		 RETURN
	 END IF

        ll_row = dw_sname.insertrow(0)
			
  	   dw_sname.object.id_no         [ll_row]  = dw_name.object.id_no         [idx]    //등재번호  
   	dw_sname.object.item_class    [ll_row]  = dw_name.object.item_class    [idx]    //품목구분              
   	dw_sname.object.seq           [ll_row]  = ll_maxnum2                            //이력번호           
   	dw_sname.object.revenue_opt   [ll_row]  = dw_name.object.revenue_opt   [idx]    //구입재원            
   	dw_sname.object.purchase_price[ll_row]  = dw_name.object.purchase_price[idx]    //구입단가            
   	dw_sname.object.purchase_amt  [ll_row]  = dw_name.object.purchase_amt  [idx]    //구입금액            
   	dw_sname.object.nation_amt    [ll_row]  = dw_name.object.nation_amt    [idx]    //국고사용금액        
   	dw_sname.object.replace_amt   [ll_row]  = dw_name.object.replace_amt   [idx]    //국고대응금액        
   	dw_sname.object.school_amt    [ll_row]  = dw_name.object.school_amt    [idx]    //교비사용금액        
   	dw_sname.object.prepare_amt   [ll_row]  = dw_name.object.prepare_amt   [idx]    //기성회비사용금액    
   	dw_sname.object.gwa           [ll_row]  = dw_name.object.gwa           [idx]    //사용부서            
   	dw_sname.object.room_code     [ll_row]  = dw_name.object.room_code     [idx]    //사용장소            
	   dw_sname.object.oper_opt      [ll_row]  = dw_name.object.loss_class    [idx]    //운용구분            
   	dw_sname.object.purchase_opt  [ll_row]  = dw_name.object.purchase_opt  [idx]    //구매방법            
   	dw_sname.object.in_no         [ll_row]  = dw_name.object.in_no         [idx]    //입고번호  
		dw_sname.object.tool_class    [ll_row]  = dw_name.object.tool_class    [idx]    //입고번호

     IF  isnull(dw_sname.object.in_no[ll_row]) THEN
		   dw_sname.object.in_no[ll_row] = 0
	  END IF
      ///////////////////////////////////////////////////////////////////////////////////////
      // 3. 저장처리전 체크사항 기술
      ///////////////////////////////////////////////////////////////////////////////////////

		IF ll_row > 0 THEN
			ls_Worker     = gstru_uid_uname.uid				//등록자
			ls_IPAddr     = gstru_uid_uname.address		//등록단말기
  			ls_JOB_UID	  =gstru_uid_uname.uid	         //등록자
   		ls_JOB_ADD	  =gstru_uid_uname.address		   //등록단말기
		END IF
		////////////////////////////////////////////////////////////////////////////////////
		// 3.1 수정항목 처리
		////////////////////////////////////////////////////////////////////////////////////
		dw_update3.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
		dw_update3.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
//		dw_update1.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
		dw_update3.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
		dw_update3.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
//		dw_update1.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자
    
	 	///////////////////////////////////////////////////////////////////////////////////////
		// 5. 자료저장처리
		///////////////////////////////////////////////////////////////////////////////////////
		dw_update3.update()
		commit;

	NEXT
					  
	 			if sqlca.sqlcode <> 0 then
					wf_setmsg("저장실패")
					return
				end if

end subroutine

public subroutine wf_retrieve ();
INT	I
long ll_row
string ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_dept_code, ls_room_code, ls_date_f, ls_date_t



dw_head.accepttext()
		
ls_id_no = trim(dw_head.object.c_id_no[1]) + '%'				
ls_item_no = trim(dw_head.object.c_item_no[1]) + '%'
ls_item_name = trim(dw_head.object.c_item_name[1]) + '%'
ls_item_class = string(dw_head.object.c_item_class[1]) + '%'
ls_date_f = dw_head.object.c_date_f[1]
ls_date_t = dw_head.object.c_date_t[1]
ls_dept_code = trim(dw_head.object.c_dept_code[1]) + '%'

IF ISNULL(ls_id_no) THEN ls_id_no = '%'
IF ISNULL(ls_item_no) THEN ls_item_no = '%'
IF ISNULL(ls_item_name) THEN ls_item_name = '%'
IF ISNULL(ls_item_class) THEN ls_item_class = '%'
IF ISNULL(ls_dept_code) THEN ls_dept_code = '%'

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
			
		IF tab_sheet.tabpage_sheet01.dw_update1.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE	
			tab_sheet.tabpage_sheet01.dw_update1.setfocus()		
			FOR	i = 1		TO	tab_sheet.tabpage_sheet01.dw_update1.ROWCOUNT()
						tab_sheet.tabpage_sheet01.dw_update1.OBJECT.loss_use_opt[i] = 2
					
			NEXT	
		END IF	 

  CASE 2
				
		IF tab_sheet.tab_sheet_2.dw_update2.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE	
         tab_sheet.tab_sheet_2.dw_update2.setfocus()
		END IF	 

  CASE 3
				
		IF tab_sheet.tabpage_1.dw_print2.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE	
         tab_sheet.tabpage_1.dw_print2.setfocus()
			//wf_setmenu('P', TRUE)
		END IF	 

  CASE 4
				
		IF tab_sheet.tabpage_2.dw_print1.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE	
         tab_sheet.tabpage_2.dw_print1.setfocus()
			//wf_setmenu('P', TRUE)
		END IF	 

END CHOOSE		



end subroutine

on w_hst502i.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.rb_total=create rb_total
this.rb_dele=create rb_dele
this.dw_update3=create dw_update3
this.gb_4=create gb_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.rb_total
this.Control[iCurrent+3]=this.rb_dele
this.Control[iCurrent+4]=this.dw_update3
this.Control[iCurrent+5]=this.gb_4
this.Control[iCurrent+6]=this.gb_1
end on

on w_hst502i.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.rb_total)
destroy(this.rb_dele)
destroy(this.dw_update3)
destroy(this.gb_4)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;		
wf_retrieve()

return 1



end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 비품폐기 처리 및 취소
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

////wf_setmenu('I',TRUE)
//wf_setmenu('R',TRUE)
//wf_setmenu('D',TRUE)
//wf_setmenu('U',TRUE)

f_childretrieve(dw_head,"c_item_class","item_class")         // 물품구분(조회조건) 
f_childretrieven(dw_head,"c_dept_code")                      // 부 서(조회조건) 

dw_head.reset()
dw_head.insertrow(0)

dw_head.object.c_date_f[1] = left(f_today(),6) + '01'
dw_head.object.c_date_t[1] = f_today()

f_childretrieve(tab_sheet.tabpage_sheet01.dw_update1,"item_class","item_class")              // 물품구분(저장)
f_childretrieve(tab_sheet.tabpage_sheet01.dw_update1,"loss_use_opt","loss_use_opt")          // 폐기용도구분(저장)

f_childretrieve(tab_sheet.tab_sheet_2.dw_update2,"item_class","item_class")              // 물품구분(저장)
f_childretrieve(tab_sheet.tab_sheet_2.dw_update2,"loss_use_opt","loss_use_opt")          // 폐기용도구분(저장)

//this.postevent("ue_retrieve")

//---------- 자산 조회 조건 ---------------//

idw_sname = tab_sheet.tabpage_sheet01.dw_head2

f_childretrieve(idw_sname,"c_item_class","item_class")        //  물품구분
f_childretrieven(idw_sname,"c_dept_code")                     //  부서
idw_sname.reset()
idw_sname.insertrow(0)
idw_sname.object.c_fr_date[1] = left(f_today(),6) + '01'
idw_sname.object.c_to_date[1] = f_today()

f_childretrieve(tab_sheet.tabpage_sheet01.dw_update_tab,"item_class","item_class")        //  물품구분

f_childretrieve(tab_sheet.tabpage_1.dw_print2,"item_class","item_class")        //  물품구분
f_childretrieve(tab_sheet.tabpage_2.dw_print1,"item_class","item_class")        //  물품구분
f_childretrieve(tab_sheet.tabpage_1.dw_print2,"loss_use_opt","loss_use_opt")          // 폐기용도구분(저장)
f_childretrieve(tab_sheet.tabpage_2.dw_print1,"loss_use_opt","loss_use_opt")          // 폐기용도구분(저장)


tab_sheet.tabpage_1.dw_print2.object.DataWindow.zoom = 100
tab_sheet.tabpage_1.dw_print2.object.DataWindow.print.preview = 'YES'

tab_sheet.tabpage_2.dw_print1.object.DataWindow.zoom = 100
tab_sheet.tabpage_2.dw_print1.object.DataWindow.print.preview = 'YES'
idw_print = tab_sheet.tabpage_1.dw_print2
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;
int li_loss_use_opt, li_oper_opt, li_item_class
long i, ll_rowcount, ll_RowCnt
string ls_id_no, ls_loss_date, ls_move_room, ls_room
integer li_rc

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	  idw_name1 = tab_sheet.tabpage_sheet01.dw_update1

	 	  
	  idw_name1.accepttext()
  
    IF f_chk_modified(idw_name1) = FALSE THEN RETURN  -1
	 
	  ll_rowcount = idw_name1.rowcount()

     FOR i = 1 TO ll_rowcount

	     IF idw_name1.object.loss_class[i] = 2 THEN              // 처리 이면 
			
			  ls_id_no 			= idw_name1.object.id_no[i]
			  li_item_class 	= idw_name1.object.item_class[i]
			  li_loss_use_opt = idw_name1.object.loss_use_opt[i]
			  ls_loss_date 	= idw_name1.object.loss_date[i]

			SELECT MOVE_ROOM 
			INTO  :ls_move_room
			FROM STDB.HST034h
			WHERE ID_NO = :ls_id_no   AND
				 	ITEM_CLASS = :li_item_class AND
				 	MOVE_OPT = 8;	

			  
			  IF li_loss_use_opt = 2 THEN                       // 폐기 
				  li_oper_opt = 3
			  ELSEIF li_loss_use_opt = 3 THEN                   // 매각
				  li_oper_opt = 4
			  ELSEIF li_loss_use_opt = 4 THEN	                // 기증   
				  li_oper_opt = 5
			  END IF	
	
			  UPDATE STDB.HST027M
			  SET OPER_OPT 	= :li_oper_opt,
			  		loss_date 	= :ls_loss_date,
					ROOM_CODE	= :ls_move_room  
			  WHERE ID_NO 		= :ls_id_no   AND
			        ITEM_CLASS = :li_item_class   ;
			  
			  UPDATE STDB.HST034H
			  SET   MOVE_OPT = 9
			  WHERE ID_NO = :ls_id_no   AND
			        ITEM_CLASS = :li_item_class   ;
			 
		  END IF	
		  IF sqlca.sqlcode <> 0  THEN
	           MessageBox('오류',&
										 '자산 폐기시 전산장애가 발생되었습니다.~r~n' + &
										 '하단의 장애번호와 장애내역을~r~n' + &
										 '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
										 '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
										 '장애내역 : ' + SQLCA.SqlErrText)
			 return -1
		   END IF
     NEXT
	   wf_save()	 
	  IF f_update( idw_name1,'U') = TRUE THEN 
		  wf_retrieve()
		  wf_setmsg("저장되었습니다")
	  END IF		  

   CASE 2
     
	  idw_name1 = tab_sheet.tab_sheet_2.dw_update2
     idw_list = tab_sheet.tabpage_sheet01.dw_update_tab
     idw_name1.accepttext()

     ll_rowcount = idw_name1.rowcount()

     FOR i = 1 TO ll_rowcount
		
		  IF idw_name1.object.loss_class[i] = 1 THEN 
			
			  idw_name1.object.loss_date[i] = '00000000'
			  
			  ls_id_no = idw_name1.object.id_no[i]
			  li_item_class = idw_name1.object.item_class[i]
			  
			  SELECT ROOM_CODE 
				INTO  :ls_room
				FROM STDB.HST034h
				WHERE ID_NO = :ls_id_no   AND
						ITEM_CLASS = :li_item_class AND
						MOVE_OPT = 9;	
			  
			  UPDATE STDB.HST027M
			  SET    OPER_OPT = 1,
			  			LOSS_DATE = '',
						ROOM_CODE	= :ls_room
			  WHERE  ID_NO = :ls_id_no   AND
			         ITEM_CLASS = :li_item_class   ;
					  
			  UPDATE STDB.HST034h
			  SET    MOVE_OPT = 8
			  WHERE ID_NO = :ls_id_no   AND
			        ITEM_CLASS = :li_item_class   ;
					  
			  UPDATE STDB.HST029h
			  SET    LOSS_USE_OPT = 1
			  WHERE  ID_NO = :ls_id_no   AND
			         ITEM_CLASS = :li_item_class   ;
		  END IF		
		  IF sqlca.sqlcode <> 0  THEN
	           MessageBox('오류',&
										 '자산 폐기시 전산장애가 발생되었습니다.~r~n' + &
										 '하단의 장애번호와 장애내역을~r~n' + &
										 '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
										 '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
										 '장애내역 : ' + SQLCA.SqlErrText)
			 return -1
		   END IF
		
     NEXT	
  
	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN -1	
	  
	   wf_save2()
	  IF f_update( idw_name1,'U') = TRUE THEN 
		  wf_retrieve()
		  wf_setmsg("저장되었습니다")
	  END IF		  
	  
END CHOOSE		

//f_setpointer('END')

end event

event ue_print;call super::ue_print;//
//ii_tab = tab_sheet.selectedtab
//
//CHOOSE CASE ii_tab
//		
//	CASE 3
//		f_print(tab_sheet.tabpage_1.dw_print2)
//	CASE 4
//		f_print(tab_sheet.tabpage_2.dw_print1)
//END CHOOSE
end event

event ue_delete;call super::ue_delete;
long ll_row, ll_DeleteCnt, ll_DeleteRow, ll_DeleteRowCnt

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name1 = tab_sheet.tabpage_sheet01.dw_update1

     	ll_row = idw_name1.getrow()		
				  
		dwItemStatus l_status 
		l_status = idw_name1.getitemstatus(ll_row, 0, Primary!)
		
		IF l_status = New! OR l_status = NewModified! THEN 
				
			ll_DeleteCnt = idw_name1.deleterow(ll_row)
	
		ELSE
			
		  IF f_messagebox( '2', 'DEL' ) = 1 THEN
			
			  IF idw_name1.object.LOSS_CLASS[1] = 2 THEN		
				  messagebox("확인","삭제할수 없습니다. 자산 폐기처리된 데이타는 삭제할수없습니다.")
				  RETURN		
			  END IF
				   
			  ll_DeleteCnt = idw_name1.deleterow(ll_row)
			
           ll_DeleteRow = idw_name1.GetRow()
           ll_DeleteRowCnt = idw_name1.RowCount()
       
				     FOR  ll_row = ll_DeleteRow  TO ll_DeleteRowCnt
							 IF ll_row = 0 THEN
							    EXIT
//							 ELSE
//	                      idw_name1.object.seq_no[ll_Row] = ll_row
						    END IF
                  NEXT
						
						IF ll_DeleteRowCnt = 0 THEN
						  IF f_update( idw_name1,'D') = TRUE THEN wf_setmsg("삭제되었습니다")
					   ELSE
					    THIS.TRIGGER EVENT ue_save()
					   END IF
			  END IF		
		  END IF
		
END CHOOSE		

//f_setpointer('END')

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

event ue_button_set;call super::ue_button_set;tab_sheet.tabpage_sheet01.cb_2.x = tab_sheet.tabpage_sheet01.cb_1.x + tab_sheet.tabpage_sheet01.cb_1.width + 16
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hst502i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hst502i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hst502i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hst502i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hst502i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hst502i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hst502i
end type

type uc_insert from w_tabsheet`uc_insert within w_hst502i
end type

type uc_delete from w_tabsheet`uc_delete within w_hst502i
end type

type uc_save from w_tabsheet`uc_save within w_hst502i
end type

type uc_excel from w_tabsheet`uc_excel within w_hst502i
end type

type uc_print from w_tabsheet`uc_print within w_hst502i
end type

type st_line1 from w_tabsheet`st_line1 within w_hst502i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hst502i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hst502i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hst502i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hst502i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hst502i
integer y = 472
integer width = 4384
integer height = 1820
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tab_sheet_2 tab_sheet_2
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		f_setpointer('START')
//      wf_retrieve()
//		f_setpointer('END')		
//end choose
rb_total.checked = FALSE



CHOOSE CASE newindex
		
	CASE 1, 2, 3
		idw_print = tab_sheet.tabpage_1.dw_print2
	CASE 4
		idw_print = tab_sheet.tabpage_2.dw_print1
END CHOOSE
end event

on tab_sheet.create
this.tab_sheet_2=create tab_sheet_2
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_sheet_2
this.Control[iCurrent+2]=this.tabpage_1
this.Control[iCurrent+3]=this.tabpage_2
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tab_sheet_2)
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 1700
long backcolor = 1073741824
string text = "자산 폐기 신청 -> 처리"
gb_2 gb_2
gb_5 gb_5
dw_head2 dw_head2
dw_update1 dw_update1
cb_1 cb_1
cb_2 cb_2
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.gb_5=create gb_5
this.dw_head2=create dw_head2
this.dw_update1=create dw_update1
this.cb_1=create cb_1
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_5
this.Control[iCurrent+3]=this.dw_head2
this.Control[iCurrent+4]=this.dw_update1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_5)
destroy(this.dw_head2)
destroy(this.dw_update1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 2670
integer y = 216
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
integer x = 18
integer y = 1152
integer width = 4311
integer height = 544
string dataobject = "d_hst502i_3"
boolean hsplitscroll = true
end type

type uo_tab from w_tabsheet`uo_tab within w_hst502i
integer x = 1810
integer y = 440
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hst502i
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hst502i
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 23
integer y = 4
integer width = 4311
integer height = 808
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "자산 폐기 처리 내역"
end type

type gb_5 from groupbox within tabpage_sheet01
integer x = 18
integer y = 840
integer width = 2985
integer height = 296
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "자산 폐기 신청 내역 조회조건"
end type

type dw_head2 from datawindow within tabpage_sheet01
event ue_keydown pbm_dwnkey
integer x = 87
integer y = 908
integer width = 2839
integer height = 200
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst502i_4"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;String	ls_room_name
s_uid_uname	ls_middle


THIS.AcceptText()

IF key = KeyEnter! THEN 
	IF THIS.GetColumnName() = 'c_room_name' THEN				// 사용장소
		ls_room_name = THIS.object.c_room_name[1]
		OpenWithParm(w_hgm100h,ls_room_name)
		IF message.stringparm <> '' THEN
			THIS.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
			THIS.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
		END IF
   ELSEIF THIS.GetColumnName() = 'c_item_name' THEN		// 품목명
			ls_middle.uname = this.object.c_item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm100h,ls_middle)
		
			IF message.stringparm <> '' THEN

//				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
	   wf_retrieve()
	END IF
END IF
end event

event itemchanged;IF dwo.name = 'c_room_name' THEN this.object.c_room_code[1] = ''
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

//				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
   ELSE
       TRIGGER EVENT ue_retrieve()
	END IF
end event

type dw_update1 from uo_dwgrid within tabpage_sheet01
event key_enter pbm_dwnprocessenter
integer x = 55
integer y = 76
integer width = 4247
integer height = 716
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_hst502i_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event key_enter;
long ll_getrow
string ls_acct_code

this.accepttext()	
	
ll_getrow = this.getrow()

IF this.getcolumnname() = 'acct_code' THEN                         // 계정과목 

	ls_acct_code = this.object.acct_code[ll_getrow]
	
	openwithparm(w_hgm300h,ls_acct_code)
			
	IF message.stringparm <> '' THEN
	
		this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
	END IF

END IF
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

event dberror;call super::dberror;//IF sqldbcode = 1 THEN
//	messagebox("확인",'중복된 값이 있습니다.')
//	setcolumn(1)
//	setfocus()
//END IF
//
//RETURN 1
end event

event doubleclicked;call super::doubleclicked;//
//IF dwo.name = 'item_middle' THEN
//	
//	open(w_kch101h)
//	   	
//	IF message.stringparm <> '' THEN
//	
//	   this.object.item_middle[row] = gstru_uid_uname.s_parm[1]
//		this.object.midd_name[row] = gstru_uid_uname.s_parm[2]	   
//	
//   END IF
//	
//END IF
end event

event itemchanged;call super::itemchanged;long i

this.accepttext()

i = this.getrow()

IF dwo.name = 'loss_class' THEN   

   IF data = '2' THEN	             // 처 리
	
		this.object.loss_date[row] = f_today()
		this.object.loss_amt[row] = this.object.PURCHASE_AMT[i]

	ELSE			
		
	   this.object.loss_date[row] = ('00000000')
		
	END IF
	
END IF


end event

event itemerror;call super::itemerror;//RETURN 1
end event

type cb_1 from uo_imgbtn within tabpage_sheet01
integer x = 3067
integer y = 1004
integer taborder = 110
boolean bringtotop = true
string btnname = "조 회"
end type

event clicked;call super::clicked;
long ll_row
string ls_id_no, ls_item_name, ls_item_class,ls_fr_date, ls_to_date, ls_dept_code, ls_room_name



idw_sname.accepttext()
		
idw_sname = tab_sheet.tabpage_sheet01.dw_head2
		
ls_id_no = trim(idw_sname.object.c_id_no[1]) + '%'				
ls_item_name = trim(idw_sname.object.c_item_name[1]) + '%'
ls_item_class = string(idw_sname.object.c_item_class[1]) + '%'
ls_fr_date   = trim(idw_sname.object.c_fr_date[1]) + '%'
ls_to_date   = trim(idw_sname.object.c_to_date[1]) + '%'
ls_dept_code = trim(idw_sname.object.c_dept_code[1]) + '%'
ls_room_name = trim(idw_sname.object.c_room_name[1]) + '%'


IF ISNULL(ls_id_no) THEN ls_id_no = '%'
IF ISNULL(ls_item_name) THEN ls_item_name = '%'
IF ISNULL(ls_item_class) THEN ls_item_class = '%'
IF ISNULL(ls_fr_date) OR ls_fr_date = ''  THEN ls_fr_date = '00000000'
IF ISNULL(ls_to_date) OR ls_fr_date = ''  THEN ls_to_date = '99999999'
IF ISNULL(ls_dept_code) THEN ls_dept_code = '%'
IF ISNULL(ls_room_name) THEN ls_room_name = '%'
			
IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( ls_id_no, ls_item_name, ls_item_class, ls_fr_date, &
                                               ls_to_date, ls_dept_code, ls_room_name ) = 0 THEN
	wf_setMsg("조회된 데이타가 없습니다")	
END IF	 



end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type cb_2 from uo_imgbtn within tabpage_sheet01
integer x = 3369
integer y = 1004
integer taborder = 120
boolean bringtotop = true
string btnname = "선 택"
end type

event clicked;call super::clicked;long i, ll_row, ll_DeleteCnt
Long		ll_DeleteRow[]

idw_sname = tab_sheet.tabpage_sheet01.dw_update_tab
i = idw_sname.getrow()

IF i = 0 THEN
	wf_setMsg("먼저 선택하여 주십시요.")	
	RETURN
ELSE
	idw_name1 = tab_sheet.tabpage_sheet01.dw_update1
	
	DO WHILE i <> 0
		ll_row = idw_name1.InsertRow(0)
		
		idw_name1.SetRow(ll_row)
		idw_name1.ScrollToRow(ll_row)
		idw_name1.SetFocus()
//		idw_name1.SelectRow(0,FALSE)
//		idw_name1.SelectRow(ll_row,TRUE)
		
//		int  idx 
//		long  ll_RowCnt, ll_GetRow
//		IF ll_Row = 0 THEN 
//	      RETURN
//      ELSE
//	      ll_RowCnt = idw_name1.RowCount()
//      FOR idx = ll_GetRow TO ll_RowCnt
//		    idw_name1.object.seq_no[ll_row] = ll_Row
//         NEXT
//      END IF 
//		
		idw_name1.object.id_no[ll_row] = idw_sname.object.id_no[i]
		idw_name1.object.item_no[ll_row] = idw_sname.object.item_no[i]
		idw_name1.object.item_name[ll_row] = idw_sname.object.item_name[i]
		idw_name1.object.item_class[ll_row] = idw_sname.object.item_class[i]
		idw_name1.object.req_gwa[ll_row] = idw_sname.object.gwa[i]
		idw_name1.object.loss_apply_date[ll_row] = idw_sname.object.apply_date[i]
		idw_name1.object.purchase_qty[ll_row] = idw_sname.object.purchase_qty[i]
		idw_name1.object.purchase_amt[ll_row] = idw_sname.object.purchase_amt[i]
		idw_name1.object.item_remark[ll_row] = idw_sname.object.remark[i]
//		idw_name1.object.loss_remark[ll_row] = idw_sname.object.loss_remark[i]
//		idw_name1.object.loss_date[ll_row] = f_today()
		idw_name1.object.LOSS_AMT[ll_row] = idw_sname.object.PURCHASE_AMT[i]		
		
		ll_DeleteCnt++
		ll_DeleteRow[ll_DeleteCnt] = i
		i = idw_sname.Getrow()

   LOOP
END IF

Long	ll_idx
FOR ll_idx = UpperBound(ll_DeleteRow) TO 1 STEP -1
	idw_sname.DeleteRow(ll_DeleteRow[ll_idx])
NEXT


end event

on cb_2.destroy
call uo_imgbtn::destroy
end on

type tab_sheet_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1700
string text = "자산 폐기 처리 취소"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_3 gb_3
dw_update2 dw_update2
end type

on tab_sheet_2.create
this.gb_3=create gb_3
this.dw_update2=create dw_update2
this.Control[]={this.gb_3,&
this.dw_update2}
end on

on tab_sheet_2.destroy
destroy(this.gb_3)
destroy(this.dw_update2)
end on

type gb_3 from groupbox within tab_sheet_2
integer x = 27
integer y = 24
integer width = 4306
integer height = 1676
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "자산 폐기 처리 내역"
end type

type dw_update2 from uo_dwgrid within tab_sheet_2
integer x = 59
integer y = 108
integer width = 4242
integer height = 1568
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_hst502i_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1700
string text = "자산폐기 신청내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print2 dw_print2
end type

on tabpage_1.create
this.dw_print2=create dw_print2
this.Control[]={this.dw_print2}
end on

on tabpage_1.destroy
destroy(this.dw_print2)
end on

type dw_print2 from datawindow within tabpage_1
integer width = 4352
integer height = 1700
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst502i_10"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1700
string text = "자산폐기 처리내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print1 dw_print1
end type

on tabpage_2.create
this.dw_print1=create dw_print1
this.Control[]={this.dw_print1}
end on

on tabpage_2.destroy
destroy(this.dw_print1)
end on

type dw_print1 from datawindow within tabpage_2
integer width = 4352
integer height = 1700
integer taborder = 10
string title = "none"
string dataobject = "d_hst502p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_head from datawindow within w_hst502i
event ue_keydown pbm_dwnkey
integer x = 82
integer y = 216
integer width = 3291
integer height = 192
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst402i_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
String	ls_room_name
s_uid_uname	ls_middle


THIS.AcceptText()

IF key = KeyEnter! THEN 
	IF THIS.GetColumnName() = 'c_item_name' THEN		// 품목명
			ls_middle.uname = this.object.c_item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
	   wf_retrieve()
	END IF
END IF
end event

event dberror;return 1
end event

event doubleclicked;
String	ls_room_name
s_uid_uname	ls_middle


THIS.AcceptText()

	IF dwo.name = 'c_item_name' THEN		// 품목명
			ls_middle.uname = this.object.c_item_name[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
	   wf_retrieve()
	END IF

end event

type rb_total from radiobutton within w_hst502i
integer x = 3973
integer y = 212
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "전체선택"
end type

event clicked;
long ll_rowcount, idx, i

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1 
 
		ll_rowcount = tab_sheet.tabpage_sheet01.dw_update1.rowcount()
		idw_name1 = tab_sheet.tabpage_sheet01.dw_update1
		FOR idx = 1 TO ll_rowcount
			
			idw_name1.object.loss_date[idx] = f_today()
			idw_name1.object.loss_class[idx] = 2		           // 처리
			
		NEXT
	
	CASE 2 
		
		ll_rowcount = tab_sheet.tab_sheet_2.dw_update2.rowcount()
		
		FOR idx = 1 TO ll_rowcount

         tab_sheet.tab_sheet_2.dw_update2.object.loss_date[idx] = '00000000'
			tab_sheet.tab_sheet_2.dw_update2.object.loss_class[idx] = 1		           // 신청
			
		NEXT
		
END CHOOSE				

end event

type rb_dele from radiobutton within w_hst502i
integer x = 3973
integer y = 308
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "전체취소"
boolean checked = true
end type

event clicked;
long ll_rowcount, idx

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1 
 
		ll_rowcount = tab_sheet.tabpage_sheet01.dw_update1.rowcount()
		
		FOR idx = 1 TO ll_rowcount
			
			tab_sheet.tabpage_sheet01.dw_update1.object.loss_date[idx] = f_today()
			tab_sheet.tabpage_sheet01.dw_update1.object.loss_class[idx] = 1		           // 처리
			
		NEXT
	
	CASE 2 
		
		ll_rowcount = tab_sheet.tab_sheet_2.dw_update2.rowcount()
		
		FOR idx = 1 TO ll_rowcount

         tab_sheet.tab_sheet_2.dw_update2.object.loss_date[idx] = '00000000'
			tab_sheet.tab_sheet_2.dw_update2.object.loss_class[idx] = 2	              // 신청
			
		NEXT
		
END CHOOSE				

end event

type dw_update3 from cuo_dwwindow_one_hin within w_hst502i
boolean visible = false
integer x = 562
integer y = 1168
integer height = 84
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_hst201i_55"
end type

type gb_4 from groupbox within w_hst502i
integer x = 50
integer y = 136
integer width = 3785
integer height = 300
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회 조건"
end type

type gb_1 from groupbox within w_hst502i
integer x = 3835
integer y = 132
integer width = 599
integer height = 300
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
borderstyle borderstyle = styleraised!
end type

