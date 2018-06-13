$PBExportHeader$w_hst404i.srw
$PBExportComments$비품 반납 처리
forward
global type w_hst404i from w_tabsheet
end type
type dw_update3 from cuo_dwwindow_one_hin within tabpage_sheet01
end type
type gb_2 from groupbox within tabpage_sheet01
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
type tabpage_2 from userobject within tab_sheet
end type
type dw_print2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
dw_print2 dw_print2
end type
type dw_head from datawindow within w_hst404i
end type
type rb_total from radiobutton within w_hst404i
end type
type rb_dele from radiobutton within w_hst404i
end type
type gb_4 from groupbox within w_hst404i
end type
type gb_1 from groupbox within w_hst404i
end type
end forward

global type w_hst404i from w_tabsheet
string title = "비품이동처리"
dw_head dw_head
rb_total rb_total
rb_dele rb_dele
gb_4 gb_4
gb_1 gb_1
end type
global w_hst404i w_hst404i

type variables

int ii_tab
datawindow idw_sname, idw_name1
end variables

forward prototypes
public subroutine wf_save ()
public subroutine wf_save2 ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_save ();String ls_sysdate, ls_Worker, ls_IPAddr, ls_JOB_UID, ls_JOB_ADD
Long ll_rowcount, ll_maxnum, ll_maxnum2, idx, ll_row

DataWindow  dw_sname, dw_name

dw_sname = tab_sheet.tabpage_sheet01.dw_update3
dw_name  = tab_sheet.tabpage_sheet01.dw_update_tab

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
   	dw_sname.object.oper_opt      [ll_row]  = dw_name.object.oper_opt      [idx]    //운용구분            
   	dw_sname.object.purchase_opt  [ll_row]  = dw_name.object.purchase_opt  [idx]    //구매방법            
//   	dw_sname.object.in_no         [ll_row]  = dw_name.object.in_no         [idx]    //입고번호  
//		dw_sname.object.tool_class    [ll_row]  = dw_name.object.tool_class    [idx]    //입고번호

     IF  isnull(dw_sname.object.in_no[ll_row]) THEN
		   dw_sname.object.in_no[ll_row] = 0
	  END IF
      ///////////////////////////////////////////////////////////////////////////////////////
      // 3. 저장처리전 체크사항 기술
      ///////////////////////////////////////////////////////////////////////////////////////

		IF ll_row > 0 THEN
			ls_Worker     = gstru_uid_uname.uid				//등록자
			ls_IPAddr     = gstru_uid_uname.address		//등록단말기
  			ls_JOB_UID	  = gstru_uid_uname.uid	         //등록자
   		ls_JOB_ADD	  = gstru_uid_uname.address		   //등록단말기
		END IF
		////////////////////////////////////////////////////////////////////////////////////
		// 3.1 수정항목 처리
		////////////////////////////////////////////////////////////////////////////////////
		tab_sheet.tabpage_sheet01.dw_update3.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
		tab_sheet.tabpage_sheet01.dw_update3.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
//		tab_sheet.tabpage_sheet01.dw_update_tab.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
		tab_sheet.tabpage_sheet01.dw_update3.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
		tab_sheet.tabpage_sheet01.dw_update3.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
//		tab_sheet.tabpage_sheet01.dw_update_tab.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자
    
	 	///////////////////////////////////////////////////////////////////////////////////////
		// 5. 자료저장처리
		///////////////////////////////////////////////////////////////////////////////////////
		tab_sheet.tabpage_sheet01.dw_update3.update()
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
dw_sname = tab_sheet.tabpage_sheet01.dw_update3
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
   	dw_sname.object.oper_opt      [ll_row]  = dw_name.object.oper_opt      [idx]    //운용구분            
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
		tab_sheet.tabpage_sheet01.dw_update3.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
		tab_sheet.tabpage_sheet01.dw_update3.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
//		tab_sheet.tabpage_sheet01.dw_update1.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
		tab_sheet.tabpage_sheet01.dw_update3.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
		tab_sheet.tabpage_sheet01.dw_update3.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
//		tab_sheet.tabpage_sheet01.dw_update1.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자
    
	 	///////////////////////////////////////////////////////////////////////////////////////
		// 5. 자료저장처리
		///////////////////////////////////////////////////////////////////////////////////////
		tab_sheet.tabpage_sheet01.dw_update3.update()
		commit;

	NEXT
					  
	 			if sqlca.sqlcode <> 0 then
					wf_setmsg("저장실패")
					return
				end if

end subroutine

public subroutine wf_retrieve ();
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
IF ISNULL(ls_item_class) or ls_item_class = '0%' THEN 
	ls_item_class = '%'
end if
IF ISNULL(ls_dept_code) THEN ls_dept_code = '%'

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
			
		IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE	
			wf_SetMsg('자료가 조회되었습니다.')			
			tab_sheet.tabpage_sheet01.dw_update_tab.setfocus()			
		END IF	 

  CASE 2
				
		IF tab_sheet.tab_sheet_2.dw_update2.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE	
			wf_SetMsg('자료가 조회되었습니다.')			
         tab_sheet.tab_sheet_2.dw_update2.setfocus()
		END IF	 
  CASE 3
	   IF tab_sheet.tabpage_2.dw_print2.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE	
			wf_SetMsg('자료가 조회되었습니다.')			
         tab_sheet.tabpage_2.dw_print2.setfocus()
			//wf_setmenu('P', TRUE)
		END IF

END CHOOSE		



end subroutine

on w_hst404i.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.rb_total=create rb_total
this.rb_dele=create rb_dele
this.gb_4=create gb_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.rb_total
this.Control[iCurrent+3]=this.rb_dele
this.Control[iCurrent+4]=this.gb_4
this.Control[iCurrent+5]=this.gb_1
end on

on w_hst404i.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.rb_total)
destroy(this.rb_dele)
destroy(this.gb_4)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;		
wf_retrieve()


return 1


end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 비품이동 처리 및 취소
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

////wf_setmenu('I',TRUE)
//wf_setmenu('R',TRUE)
////wf_setmenu('D',TRUE)
//wf_setmenu('U',TRUE)

f_childretrieve(dw_head,"c_item_class","item_class")         // 물품구분(조회조건) 
f_childretrieven(dw_head,"c_dept_code")                      // 부 서(조회조건) 

dw_head.reset()
dw_head.insertrow(0)

dw_head.object.c_date_f[1] = left(f_today(),6) + '01'
dw_head.object.c_date_t[1] = f_today()

f_childretrieve(tab_sheet.tabpage_sheet01.dw_update_tab,"item_class","item_class")     // 물품구분(저장)

f_childretrieve(tab_sheet.tab_sheet_2.dw_update2,"item_class","item_class")        // 물품구분(저장)

f_childretrieve(tab_sheet.tabpage_2.dw_print2,"item_class","item_class")        // 물품구분(저장)


tab_sheet.tabpage_2.dw_print2.object.DataWindow.zoom = 100
tab_sheet.tabpage_2.dw_print2.object.DataWindow.print.preview = 'YES'
idw_print = tab_sheet.tabpage_2.dw_print2
end event

event ue_save;long i, ll_rowcount, ll_row, ll_item_class, ll_seq_no
string ls_id_no, ls_dept, ls_room

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
     
	  idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
	  idw_name1.accepttext()
	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN -1
	  
	  for i = 1 to idw_name1.rowcount()
			if idw_name1.object.return_opt[i] = 2 then
			   ll_seq_no     = idw_name1.object.seq_no[i]	
				ls_id_no      = trim(idw_name1.object.id_no[i])
				ll_item_class = idw_name1.object.item_class[i]
				ls_dept       = trim(idw_name1.object.gwa[i])
				ls_room       = trim(idw_name1.object.room_code[i])
				
				update stdb.hst027m
				set gwa = :ls_dept,
					 room_code = :ls_room,
					 OPER_OPT = 2
				where id_no = :ls_id_no
				and	item_class = :ll_item_class ;
				
				if sqlca.sqlcode <> 0 then
					wf_setmsg("저장실패")
					return -1
				end if
			end if
		next
		wf_save() //이력테이블 저장
	  IF f_update( idw_name1,'U') = TRUE THEN 	  
		  wf_retrieve()
		  wf_setmsg("저장되었습니다")
	  END IF		  
	  
   CASE 2
     
	  idw_name1 = tab_sheet.tab_sheet_2.dw_update2

     ll_rowcount = idw_name1.rowcount()
	  
	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN	 -1
	  
     FOR i = 1 TO ll_rowcount
		
		  IF idw_name1.object.return_opt[i] = 1 THEN 
				idw_name1.object.return_proc_date[i] = '00000000'
				ll_seq_no     = idw_name1.object.seq_no[i]	
				ls_id_no      = trim(idw_name1.object.id_no[i])
				ll_item_class = idw_name1.object.item_class[i]
				ls_dept       = trim(idw_name1.object.return_bef_gwa[i])
				ls_room       = trim(idw_name1.object.return_bef_room[i])
				
				update stdb.hst027m
				set gwa = :ls_dept,
					 room_code = :ls_room,
					 OPER_OPT = 1
				where id_no = :ls_id_no
				and	item_class = :ll_item_class ;
				
				if sqlca.sqlcode <> 0 then
					wf_setmsg("저장실패")
					return -1
				end if
			end if
		next
		wf_save2()	//이력 테이블 저장
	  IF f_update( idw_name1,'U') = TRUE THEN 
		  wf_retrieve()
		  wf_setmsg("저장되었습니다")
	  END IF		  
	  
END CHOOSE		

end event

event ue_init;call super::ue_init;//wf_setmenu('R',TRUE)
//wf_setmenu('U',TRUE)

f_childretrieve(dw_head,"c_item_class","item_class")         // 물품구분(조회조건) 
f_childretrieven(dw_head,"c_dept_code")                      // 부 서(조회조건) 
dw_head.setredraw(false)
dw_head.reset()
tab_sheet.tabpage_sheet01.dw_update_tab.reset()
tab_sheet.tab_sheet_2.dw_update2.reset()

dw_head.insertrow(0)
dw_head.setredraw(true)
dw_head.object.c_date_f[1] = left(f_today(),6) + '01'
dw_head.object.c_date_t[1] = f_today()

f_childretrieve(tab_sheet.tabpage_sheet01.dw_update_tab,"item_class","item_class")            // 물품구분(저장)

f_childretrieve(tab_sheet.tab_sheet_2.dw_update2,"item_class","item_class")              // 물품구분(저장)
end event

event ue_print;call super::ue_print;
//f_print(tab_sheet.tabpage_2.dw_print2)
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "비품 반납 처리내역")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hst404i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hst404i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hst404i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hst404i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hst404i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hst404i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hst404i
end type

type uc_insert from w_tabsheet`uc_insert within w_hst404i
end type

type uc_delete from w_tabsheet`uc_delete within w_hst404i
end type

type uc_save from w_tabsheet`uc_save within w_hst404i
end type

type uc_excel from w_tabsheet`uc_excel within w_hst404i
end type

type uc_print from w_tabsheet`uc_print within w_hst404i
end type

type st_line1 from w_tabsheet`st_line1 within w_hst404i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hst404i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hst404i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hst404i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hst404i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hst404i
integer y = 476
integer width = 4384
integer height = 1832
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tab_sheet_2 tab_sheet_2
tabpage_2 tabpage_2
end type

event tab_sheet::selectionchanged;call super::selectionchanged;//choose case newindex
//	case 1
//		f_setpointer('START')
//      wf_retrieve()
//		f_setpointer('END')		
//end choose
rb_total.checked = FALSE
end event

on tab_sheet.create
this.tab_sheet_2=create tab_sheet_2
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_sheet_2
this.Control[iCurrent+2]=this.tabpage_2
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tab_sheet_2)
destroy(this.tabpage_2)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 1712
long backcolor = 1073741824
string text = "반납 신청 -> 처리"
dw_update3 dw_update3
gb_2 gb_2
end type

on tabpage_sheet01.create
this.dw_update3=create dw_update3
this.gb_2=create gb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_update3
this.Control[iCurrent+2]=this.gb_2
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.dw_update3)
destroy(this.gb_2)
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
event key_enter pbm_dwnprocessenter
integer x = 50
integer y = 104
integer width = 4256
integer height = 1588
string dataobject = "d_hst404i_2"
boolean hsplitscroll = true
end type

event dw_update_tab::key_enter;long ll_getrow
string ls_room_name

this.accepttext()

IF this.getcolumnname() = 'room_name' THEN                       // 호실명
 
   ll_getrow = this.getrow()
 
	ls_room_name = this.object.room_name[ll_getrow]

	openwithparm(w_hgm100h,ls_room_name)
		
	IF message.stringparm <> '' THEN

		this.object.return_room_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.room_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   

	END IF

END IF	
end event

event dw_update_tab::itemchanged;call super::itemchanged;
this.accepttext()

IF dwo.name = 'return_opt' THEN   

   IF data = '2' THEN	             // 처 리
	
		this.object.return_proc_date[row] = f_today()
		this.object.return_proc_member_no[row] = gstru_uid_uname.uid

	ELSE
		
	   this.object.return_proc_date[row] = '00000000'
		this.object.return_proc_member_no[row] = ''
		
	END IF
	
END IF


end event

type uo_tab from w_tabsheet`uo_tab within w_hst404i
integer x = 1445
integer y = 444
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hst404i
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hst404i
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type dw_update3 from cuo_dwwindow_one_hin within tabpage_sheet01
boolean visible = false
integer x = 1344
integer y = 384
integer width = 1664
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_hst201i_55"
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 23
integer y = 36
integer width = 4311
integer height = 1672
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "반납 처리 내역"
end type

type tab_sheet_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1712
string text = "반납 처리 취소"
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
integer width = 4311
integer height = 1688
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "반납 처리 내역"
end type

type dw_update2 from uo_dwgrid within tab_sheet_2
integer x = 55
integer y = 100
integer width = 4251
integer height = 1592
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_hst404i_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1712
string text = "반납 처리내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print2 dw_print2
end type

on tabpage_2.create
this.dw_print2=create dw_print2
this.Control[]={this.dw_print2}
end on

on tabpage_2.destroy
destroy(this.dw_print2)
end on

type dw_print2 from datawindow within tabpage_2
integer width = 4347
integer height = 1712
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst404i_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)

end event

type dw_head from datawindow within w_hst404i
event ue_keydown pbm_dwnkey
integer x = 82
integer y = 220
integer width = 3278
integer height = 192
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst404i_1"
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
			openwithparm(w_hgm100h,ls_middle)
		
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

event doubleclicked;String	ls_room_name
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
       TRIGGER EVENT ue_retrieve()
	END IF
end event

type rb_total from radiobutton within w_hst404i
integer x = 3950
integer y = 212
integer width = 393
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
long ll_rowcount, i

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1 
 
		ll_rowcount = tab_sheet.tabpage_sheet01.dw_update_tab.rowcount()
		
		FOR i = 1 TO ll_rowcount
			
			tab_sheet.tabpage_sheet01.dw_update_tab.object.move_proc_date[i] = f_today()
			tab_sheet.tabpage_sheet01.dw_update_tab.object.move_opt[i] = 2		           // 처리
			
		NEXT
	
	CASE 2 
		
		ll_rowcount = tab_sheet.tab_sheet_2.dw_update2.rowcount()
		
		FOR i = 1 TO ll_rowcount

			tab_sheet.tab_sheet_2.dw_update2.object.move_opt[i] = 1		           // 신청
			
		NEXT
		
END CHOOSE				

end event

type rb_dele from radiobutton within w_hst404i
integer x = 3950
integer y = 308
integer width = 393
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "전체취소"
end type

event clicked;
long ll_rowcount, i

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1 
 
		ll_rowcount = tab_sheet.tabpage_sheet01.dw_update_tab.rowcount()
		
		FOR i = 1 TO ll_rowcount
			
			tab_sheet.tabpage_sheet01.dw_update_tab.object.move_proc_date[i] = f_today()
			tab_sheet.tabpage_sheet01.dw_update_tab.object.move_opt[i] = 1		           // 처리
			
		NEXT
	
	CASE 2 
		
		ll_rowcount = tab_sheet.tab_sheet_2.dw_update2.rowcount()
		
		FOR i = 1 TO ll_rowcount

			tab_sheet.tab_sheet_2.dw_update2.object.move_opt[i] = 2		           // 신청
			
		NEXT
		
END CHOOSE				

end event

type gb_4 from groupbox within w_hst404i
integer x = 50
integer y = 140
integer width = 3781
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

type gb_1 from groupbox within w_hst404i
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

