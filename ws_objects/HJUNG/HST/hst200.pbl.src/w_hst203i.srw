$PBExportHeader$w_hst203i.srw
$PBExportComments$관리전환
forward
global type w_hst203i from w_tabsheet
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type gb_3 from groupbox within tabpage_sheet01
end type
type dw_head1 from datawindow within tabpage_sheet01
end type
type dw_head2 from datawindow within tabpage_sheet01
end type
type dw_copy from datawindow within tabpage_sheet01
end type
type dw_update1 from cuo_dwwindow_one_hin within tabpage_sheet01
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print from datawindow within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type sle_idno from singlelineedit within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type em_todate from editmask within tabpage_1
end type
type em_frdate from editmask within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type dw_gwa from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print dw_print
st_4 st_4
sle_idno sle_idno
st_3 st_3
st_2 st_2
em_todate em_todate
em_frdate em_frdate
st_1 st_1
gb_2 gb_2
dw_gwa dw_gwa
end type
end forward

global type w_hst203i from w_tabsheet
integer height = 2616
string title = "관리전환"
end type
global w_hst203i w_hst203i

type variables

int ii_tab
datawindowchild idw_child
datawindow idw_sname, idw_name1
end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_change (long al_row)
public subroutine wf_save ()
end prototypes

public subroutine wf_retrieve ();//////////////////////////////////////////////////////////////////////////////////////////
// 기    능 : 조회처리
// 작 성 자 : 
// 작 성 일 : 
// 함수원형 : wf_retrieve() RETURN NONE
// 인    수 : 
// 되 돌 림 : 
//	주의사항 : 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_DateFr
String	ls_DateTo
String	ls_id_no
String	ls_item_no
String	ls_item_name
String	ls_dept_code
String	ls_item_class
String	ls_room_code
String	ls_revenue_opt
String	ls_oper_opt
String	ls_purchase_opt



ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

		idw_sname = tab_sheet.tabpage_sheet01.dw_head1
		
      idw_sname.accepttext()

		ls_id_no = trim(idw_sname.object.c_id_no[1]) + '%'                      // 등재 번호 
		ls_item_no = trim(idw_sname.object.c_item_no[1]) + '%'              // 품목 코드 
		ls_item_name = trim(idw_sname.object.c_item_name[1]) + '%'              // 품목명 
		ls_dept_code = trim(idw_sname.object.c_dept_code[1]) + '%'              // 부 서 
		ls_DateFr = idw_sname.object.c_date_f[1]                                // 구입 일자 from 
		ls_DateTo = idw_sname.object.c_date_t[1]                                // 구입 일자 to
		ls_room_code = trim(idw_sname.object.c_room_code[1]) + '%'              // 사용 장소 
		ls_item_class = string(idw_sname.object.c_item_class[1]) + '%'          // 물품 구분 
		ls_revenue_opt = string(idw_sname.object.c_revenue_opt[1]) + '%'        // 구입 재원 
		ls_oper_opt = string(idw_sname.object.c_oper_opt[1]) + '%'              // 운용 구분 
		ls_purchase_opt = string(idw_sname.object.c_purchase_opt[1]) + '%'      // 구매 방법 
				
		IF ISNULL(ls_id_no) THEN ls_id_no = '%'
		IF ISNULL(ls_item_no) THEN ls_item_no = '%'
		IF ISNULL(ls_item_name) THEN ls_item_name = '%'
		IF ISNULL(ls_dept_code) THEN ls_dept_code = '%'
		IF ISNULL(ls_room_code) THEN ls_room_code = '%'
		IF ISNULL(ls_item_class) THEN ls_item_class = '%'
		IF ISNULL(ls_revenue_opt) THEN ls_revenue_opt = '%'
		IF ISNULL(ls_oper_opt) THEN ls_oper_opt = '%'
		IF ISNULL(ls_purchase_opt) THEN ls_purchase_opt = '%' 
				
		IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( ls_id_no, ls_item_no, ls_item_name, &
		                                                 ls_dept_code, ls_DateFr, ls_DateTo, &
																		 ls_room_code, ls_item_class, ls_revenue_opt, &
																		 ls_oper_opt, ls_purchase_opt ) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
	   ELSE
			
		END IF	 
		
		tab_sheet.tabpage_sheet01.dw_head2.reset()
		tab_sheet.tabpage_sheet01.dw_head2.insertrow(0)
	CASE 2
		
		String ls_fr_date, ls_to_date, ls_idno, ls_gwa
		ls_fr_date = left(tab_sheet.tabpage_1.em_frdate.text,4) + mid(tab_sheet.tabpage_1.em_frdate.text,6,2) + &
		             right(tab_sheet.tabpage_1.em_frdate.text,2)
		IF isnull(ls_fr_date) OR ls_fr_date = '' THEN
			messagebox('확인','시작날자를 입려하시기 바랍니다..!')
	   END IF

		ls_to_date = left(tab_sheet.tabpage_1.em_todate.text,4) + mid(tab_sheet.tabpage_1.em_todate.text,6,2) + &
		             right(tab_sheet.tabpage_1.em_todate.text,2)
		IF isnull(ls_to_date) OR ls_to_date = '' THEN
		   messagebox('확인','종료날자를 입려하시기 바랍니다..!')
	   END IF
	
	   IF ls_fr_date > ls_to_date THEN
			messagebox('확인','날자입력 오류입니다..!')
		END IF
		
		ls_gwa = tab_sheet.tabpage_1.dw_gwa.object.code[1]
		IF isnull(ls_gwa) OR ls_gwa = '' OR ls_gwa = '0000' THEN
		   ls_gwa = '%'
	   END IF
		
		ls_idno = tab_sheet.tabpage_1.sle_idno.text
		IF isnull(ls_idno) OR ls_idno = '' THEN
			ls_idno = '%'
	   END IF
		
		//자료 조회
		IF tab_sheet.tabpage_1.dw_print.retrieve(ls_fr_date, ls_to_date, ls_gwa, ls_idno) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")				
		END IF	 
      //데이타원도우에 출력조건 및 시스템일자 처리
//      DateTime	ldt_SysDateTime
//      ldt_SysDateTime = f_sysdate()	//시스템일자
//      tab_sheet.tabpage_1.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//      tab_sheet.tabpage_1.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')
//
END CHOOSE		


//////////////////////////////////////////////////////////////////////////////////////////
// END OF FUNCTION
//////////////////////////////////////////////////////////////////////////////////////////
end subroutine

public subroutine wf_change (long al_row);int li_item_class_old, li_item_class, li_rtn, li_revenue_opt, li_oper_opt, li_purchase_opt, li_tool_class 
long ll_seq
string ls_id_no, ls_Gwa, ls_room_code

idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
	  
idw_name1.accepttext()	

//------ 물품 구분이 변경시 자산 등재 번호를 따서 자산 등재 테이블에 insert 한다 ------//

li_item_class_old = idw_name1.getitemnumber(al_row,"item_class",Primary!, TRUE)
li_item_class = idw_name1.object.item_class[al_row]	

IF li_item_class <> li_item_class_old THEN                  // 물품 구분이 바뀌었을 때 등재 번호를 새로 부여 

	SELECT NVL(MAX(ID_NO),'00000000000') 
	INTO :ls_id_no
	FROM STDB.HST027M  
	WHERE ITEM_CLASS = :li_item_class  ;

   tab_sheet.tabpage_sheet01.dw_copy.reset()

   ls_id_no = string(long(ls_id_no) + 1)
  				  
   li_rtn = idw_name1.rowscopy(al_row,al_row, Primary!, tab_sheet.tabpage_sheet01.dw_copy, 1, Primary!)
		  
   IF li_rtn = 1 THEN 
		
		tab_sheet.tabpage_sheet01.dw_copy.object.id_no[1] = ls_id_no
		tab_sheet.tabpage_sheet01.dw_copy.object.oper_opt[1] = 1          // 운용구분을 '사용중'으로 바꾼다 
		
  		tab_sheet.tabpage_sheet01.dw_copy.update() 		  
   END IF

   idw_name1.object.oper_opt[al_row] = 2                 // 운용 구분을 '종전환' - 2
  
END IF	

//-------- 자산 이력 테이블에 이력을 저장한다 ------------//
//
//ls_id_no = idw_name1.object.id_no[al_row]
//
//SELECT NVL(MAX(SEQ),0) 
//INTO :ll_seq
//FROM STDB.HST045H  
//WHERE ID_NO = :ls_id_no  AND
//      ITEM_CLASS = :li_item_class  ;
//
//ll_seq = ll_seq + 1
//
//li_revenue_opt = idw_name1.object.revenue_opt[al_row]
//ls_Gwa = idw_name1.object.gwa[al_row]
//ls_room_code = idw_name1.object.room_code[al_row]
//li_oper_opt = idw_name1.object.oper_opt[al_row]
//li_purchase_opt = idw_name1.object.purchase_opt[al_row]
//li_tool_class = idw_name1.object.tool_class[al_row]
//
//INSERT INTO STDB.HST045H  
//         ( ID_NO, ITEM_CLASS, SEQ, REVENUE_OPT, DEPT_CODE, ROOM_CODE, OPER_OPT, PURCHASE_OPT, TOOL_CLASS ) 
//VALUES ( :ls_id_no, :li_item_class, :ll_seq, :li_revenue_opt, :ls_Gwa, :ls_room_code, :li_oper_opt,
//         :li_purchase_opt, :li_tool_class )  ;
//			
//COMMIT USING SQLCA;			

end subroutine

public subroutine wf_save ();String ls_sysdate, ls_Worker, ls_IPAddr, ls_JOB_UID, ls_JOB_ADD
Long ll_rowcount, ll_maxnum, ll_maxnum2, idx, ll_row
DataWindow  dw_sname, dw_name
dw_sname = tab_sheet.tabpage_sheet01.dw_update1
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
		tab_sheet.tabpage_sheet01.dw_update1.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
		tab_sheet.tabpage_sheet01.dw_update1.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
//		tab_sheet.tabpage_sheet01.dw_update1.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
		tab_sheet.tabpage_sheet01.dw_update1.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
		tab_sheet.tabpage_sheet01.dw_update1.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
//		tab_sheet.tabpage_sheet01.dw_update1.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자
    
	 	///////////////////////////////////////////////////////////////////////////////////////
		// 5. 자료저장처리
		///////////////////////////////////////////////////////////////////////////////////////
		tab_sheet.tabpage_sheet01.dw_update1.update()
		commit;

	NEXT
					  
	 			if sqlca.sqlcode <> 0 then
					wf_setmsg("저장실패")
					return
				end if

end subroutine

on w_hst203i.create
int iCurrent
call super::create
end on

on w_hst203i.destroy
call super::destroy
end on

event ue_retrieve;///////////////////////////////////////////////////////////////////////////////////
// 이 벤 트 명: ue_retrieve
// 기 능 설 명: 자료조회
// 작성/수정자:
// 작성/수정일:
// 주 의 사 항:
///////////////////////////////////////////////////////////////////////////////////
wf_retrieve()
return 1
///////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
end event

event ue_open;call super::ue_open;///////////////////////////////////////////////////////////////////////////////////
// 작성목적: 자산의 속성을 한꺼번에 변경하는 프로그램(물품구분,사용장소 등등...)
// 작 성 인: 윤하영
// 작성일자: 2002.03.01
// 변 경 인:
// 변경일자:
// 변경사유:
///////////////////////////////////////////////////////////////////////////////////
//wf_setmenu('R',TRUE)
//wf_setmenu('U',TRUE)

//----- 자산 조회 조건 -------------//  

f_childretrieven(tab_sheet.tabpage_sheet01.dw_head1,"c_dept_code")						//부서 				
f_childretrieve(tab_sheet.tabpage_sheet01.dw_head1,"c_item_class","item_class")		//물품구분				
f_childretrieve(tab_sheet.tabpage_sheet01.dw_head1,"c_revenue_opt","asset_opt")		//구입재원 			
f_childretrieve(tab_sheet.tabpage_sheet01.dw_head1,"c_oper_opt","oper_opt")			//운용구분  			
f_childretrieve(tab_sheet.tabpage_sheet01.dw_head1,"c_purchase_opt","purchase_opt")	//구매방법  		

tab_sheet.tabpage_sheet01.dw_head1.reset()
tab_sheet.tabpage_sheet01.dw_head1.insertrow(0)

tab_sheet.tabpage_sheet01.dw_head1.object.c_date_f[1] = left(f_today(),6) + '01'
tab_sheet.tabpage_sheet01.dw_head1.object.c_date_t[1] = f_today()

//------ 다량 전환 -------//

f_childretrieven(tab_sheet.tabpage_sheet01.dw_head2,"c_dept_code")						//부서 				
f_childretrieve(tab_sheet.tabpage_sheet01.dw_head2,"c_item_class","item_class")		//물품구분				
f_childretrieve(tab_sheet.tabpage_sheet01.dw_head2,"c_revenue_opt","asset_opt")		//구입재원 			
f_childretrieve(tab_sheet.tabpage_sheet01.dw_head2,"c_oper_opt","oper_opt")			//운용구분  			
f_childretrieve(tab_sheet.tabpage_sheet01.dw_head2,"c_purchase_opt","purchase_opt")	//구매방법  		
f_childretrieve(tab_sheet.tabpage_sheet01.dw_head2,"c_tool_class","tool_class")		//다량전환 

tab_sheet.tabpage_sheet01.dw_head2.reset()
tab_sheet.tabpage_sheet01.dw_head2.insertrow(0)
	
idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab

//------ 자산 저장 -------//  

f_childretrieven(idw_name1,"gwa")									//부서 				
f_childretrieve(idw_name1,"item_class","item_class")		//물품구분				
f_childretrieve(idw_name1,"revenue_opt","revenue_opt")		//구입재원 			
f_childretrieve(idw_name1,"oper_opt","oper_opt")				//운용구분  			
f_childretrieve(idw_name1,"purchase_opt","purchase_opt")	//구매방법  		
f_childretrieve(idw_name1,"tool_class","tool_class")		//기자재구분 

//출력
Long ll_InsRow
DataWindow  dw_name
dw_name = tab_sheet.tabpage_1.dw_print	
idw_print = tab_sheet.tabpage_1.dw_print

tab_sheet.tabpage_1.dw_gwa.insertrow(0)
DataWindowChild	ldwc_Temp
tab_sheet.tabpage_1.dw_gwa.GetChild('code',ldwc_Temp)
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
tab_sheet.tabpage_1.em_frdate.text = left(f_today(),6) + '01'
tab_sheet.tabpage_1.em_todate.text = f_today()

f_childretrieve(dw_name,"hst037m_item_class","item_class")		   //물품구분				
f_childretrieve(dw_name,"hst037m_revenue_opt","revenue_opt")		//구입재원 			
f_childretrieve(dw_name,"hst037m_oper_opt","oper_opt")				//운용구분  			
f_childretrieve(dw_name,"hst037m_purchase_opt","purchase_opt")	   //구매방법  		
f_childretrieve(dw_name,"hst037m_tool_class","tool_class")		   //기자재구분 
							
idw_name1.Reset()
///////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;///////////////////////////////////////////////////////////////////////////////////
// 이 벤 트 명: ue_save
// 기 능 설 명: 자료저장
// 작성/수정자:
// 작성/수정일:
// 주 의 사 항:
///////////////////////////////////////////////////////////////////////////////////
Integer	li_ItemClssOld
Integer	li_ItemClss
Integer	li_Rtn
Long		ll_RowCnt
Long		idx
Long		j = 0
String	ls_IdNo
String	ls_Gwa
String	ls_GwaOld

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
     
	  idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
	  
	  idw_name1.AcceptText()	  

     ll_RowCnt = idw_name1.RowCount()

	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN -1

     IF ll_RowCnt <> 0 THEN

        FOR idx = 1 TO ll_RowCnt

           dwitemstatus	l_status 
			  l_status = idw_name1.getitemstatus(idx, 0, Primary!)
				
			  IF l_status = DataModified! THEN wf_change(idx)           // 수정을 할때 
			  
		  NEXT
        wf_save() // 이력 테이블 저장 
        IF f_update( idw_name1,'U') = TRUE THEN wf_setmsg("저장되었습니다")
		  
	  END IF

END CHOOSE		
///////////////////////////////////////////////////////////////////////////////////
// END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
return 1
end event

event ue_print;call super::ue_print;//f_print(tab_sheet.tabpage_1.dw_print)
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "관리전환 이력 리스트")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_tabsheet`ln_templeft within w_hst203i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hst203i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hst203i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hst203i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hst203i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hst203i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hst203i
end type

type uc_insert from w_tabsheet`uc_insert within w_hst203i
end type

type uc_delete from w_tabsheet`uc_delete within w_hst203i
end type

type uc_save from w_tabsheet`uc_save within w_hst203i
end type

type uc_excel from w_tabsheet`uc_excel within w_hst203i
end type

type uc_print from w_tabsheet`uc_print within w_hst203i
end type

type st_line1 from w_tabsheet`st_line1 within w_hst203i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_tabsheet`st_line2 within w_hst203i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_tabsheet`st_line3 within w_hst203i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hst203i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hst203i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hst203i
integer y = 176
integer width = 4384
integer height = 2108
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
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
integer y = 104
integer width = 4347
integer height = 1988
long backcolor = 1073741824
string text = "관리전환"
gb_1 gb_1
gb_3 gb_3
dw_head1 dw_head1
dw_head2 dw_head2
dw_copy dw_copy
dw_update1 dw_update1
gb_4 gb_4
end type

on tabpage_sheet01.create
this.gb_1=create gb_1
this.gb_3=create gb_3
this.dw_head1=create dw_head1
this.dw_head2=create dw_head2
this.dw_copy=create dw_copy
this.dw_update1=create dw_update1
this.gb_4=create gb_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.dw_head1
this.Control[iCurrent+4]=this.dw_head2
this.Control[iCurrent+5]=this.dw_copy
this.Control[iCurrent+6]=this.dw_update1
this.Control[iCurrent+7]=this.gb_4
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.dw_head1)
destroy(this.dw_head2)
destroy(this.dw_copy)
destroy(this.dw_update1)
destroy(this.gb_4)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 3346
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
event key_enter pbm_dwnprocessenter
integer x = 50
integer y = 832
integer width = 4256
integer height = 1120
string dataobject = "d_hst203i_2"
end type

event dw_update_tab::key_enter;
long ll_getrow
string ls_room_code

this.accepttext()

IF this.getcolumnname() = 'room_code' THEN                         // 장소 코드  

   ll_getrow = this.getrow()	

	ls_room_code = this.object.room_code[ll_getrow]
		
	openwithparm(w_hgm100h,'')
			
	IF message.stringparm <> '' THEN
	
		this.object.room_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.room_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
   END IF

END IF	

end event

event dw_update_tab::dberror;call super::dberror;IF sqldbcode = 1 THEN
	messagebox("확인",'중복된 값이 있습니다.')
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

event dw_update_tab::doubleclicked;call super::doubleclicked;
long ll_getrow
string ls_room_code

this.accepttext()

IF dwo.name = 'room_code' THEN                         // 장소 코드  

   ll_getrow = this.getrow()	

	ls_room_code = this.object.room_code[ll_getrow]
		
	openwithparm(w_hgm100h,'')
			
	IF message.stringparm <> '' THEN
	
		this.object.room_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.room_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
   END IF

END IF	

end event

type uo_tab from w_tabsheet`uo_tab within w_hst203i
integer x = 1317
integer y = 124
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hst203i
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hst203i
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 14
integer y = 444
integer width = 4325
integer height = 284
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "다량 전환"
end type

type gb_3 from groupbox within tabpage_sheet01
integer x = 14
integer y = 52
integer width = 4325
integer height = 368
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "자산 조회 조건"
end type

type dw_head1 from datawindow within tabpage_sheet01
event ue_keydown pbm_dwnkey
integer x = 32
integer y = 116
integer width = 3726
integer height = 268
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst201a_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
string ls_room_name
s_uid_uname	ls_middle

this.accepttext()

IF key = keyenter! THEN 
		
	IF this.getcolumnname() = 'c_room_name' THEN                       // 사용장소
	 
		ls_room_name = this.object.c_room_name[1]
	
		openwithparm(w_hgm100h,ls_room_name)
			
		IF message.stringparm <> '' THEN
	
			this.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
			this.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
	
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
	
	   wf_retrieve()
	
	END IF			
	
END IF
end event

event dberror;return 1
end event

event doubleclicked;
string ls_room_name
s_uid_uname	ls_middle

this.accepttext()
		
	IF dwo.name = 'c_room_name' THEN                       // 사용장소
	 
		ls_room_name = this.object.c_room_name[1]
	
		openwithparm(w_hgm100h,ls_room_name)
			
		IF message.stringparm <> '' THEN
	
			this.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
			this.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	   
	
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
	
	   wf_retrieve()
	
	END IF			
	
end event

type dw_head2 from datawindow within tabpage_sheet01
event ue_keydown pbm_dwnkey
integer x = 55
integer y = 516
integer width = 3675
integer height = 188
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst203i_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
long ll_rowcount, i
string ls_room_name, ls_item_name
s_uid_uname	ls_middle

this.accepttext()

IF key = keyenter! THEN 
		
	IF this.getcolumnname() = 'c_room_name' THEN                       // 사용장소
		
	 
		ls_room_name = this.object.c_room_name[1]
	
		openwithparm(w_hgm100h,ls_room_name)
			
		IF message.stringparm <> '' THEN
	
			this.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
			this.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	  
			
			idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
			
			ll_rowcount = idw_name1.rowcount()
			
			FOR i = 1 TO ll_rowcount
				
				idw_name1.object.room_code[i] = gstru_uid_uname.s_parm[1]
				idw_name1.object.room_name[i] = gstru_uid_uname.s_parm[2]
				
			NEXT	
	
		END IF
		
	END IF			
	
//	IF this.getcolumnname() = 'c_item_name' THEN                       // 품목명 
//	 	ls_middle.uid = 'c_item_name'
//		ls_middle.uname =  this.object.c_item_name[1]
////		ls_item_name = this.object.c_item_name[1]
//	
////		openwithparm(w_kch102h,ls_item_name)
//		openwithparm(w_hgm001h,ls_middle)
//			
//		IF message.stringparm <> '' THEN
//	
//			this.object.c_item_no[1] = gstru_uid_uname.s_parm[1]
//			this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
//			
//			idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
//			
//			ll_rowcount = idw_name1.rowcount()
//			
//			FOR i = 1 TO ll_rowcount
//				
//				idw_name1.object.item_no[i] = gstru_uid_uname.s_parm[1]
//				idw_name1.object.item_name[i] = gstru_uid_uname.s_parm[2]
//				
//			NEXT	
//	
//		END IF
		
//	END IF			
	
END IF
end event

event itemchanged;
long ll_rowcount, i

this.accepttext()

idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab

ll_rowcount = idw_name1.rowcount()

IF ll_rowcount <> 0 THEN

	IF dwo.name = 'c_item_class' THEN                    // 물품 구분 
		
		FOR i = 1 TO ll_rowcount		
		     idw_name1.object.item_class[i] = long(data)		
	   NEXT
		
	END IF
	
	IF dwo.name = 'c_revenue_opt' THEN                    // 구입 재원 
		
		FOR i = 1 TO ll_rowcount		
		     idw_name1.object.revenue_opt[i] = long(data)		
	   NEXT
		
	END IF
	
	IF dwo.name = 'c_oper_opt' THEN                    // 운용 구분 
		
		FOR i = 1 TO ll_rowcount		
		     idw_name1.object.oper_opt[i] = long(data)		
	   NEXT
		
	END IF
	
	IF dwo.name = 'c_purchase_opt' THEN                    // 구매방법
		
		FOR i = 1 TO ll_rowcount		
		     idw_name1.object.purchase_opt[i] = long(data)		
	   NEXT
		
	END IF
	
	IF dwo.name = 'c_dept_code' THEN                    // 부 서 
		
		FOR i = 1 TO ll_rowcount		
		     idw_name1.object.gwa[i] = data		
	   NEXT
		
	END IF
	
	IF dwo.name = 'c_tool_class' THEN                    // 기자재 구분 
		
		FOR i = 1 TO ll_rowcount		
		     idw_name1.object.tool_class[i] = long(data)		
	   NEXT
		
	END IF
	
END IF	

IF dwo.name = 'c_room_name' THEN this.object.c_room_code[1] = ''
IF dwo.name = 'c_item_name' THEN this.object.c_item_no[1] = ''


end event

event doubleclicked;
long ll_rowcount, i
string ls_room_name, ls_item_name
s_uid_uname	ls_middle

this.accepttext()
	
	IF dwo.name = 'c_room_name' THEN                       // 사용장소
		
	 
		ls_room_name = this.object.c_room_name[1]
	
		openwithparm(w_hgm100h,ls_room_name)
			
		IF message.stringparm <> '' THEN
	
			this.object.c_room_code[1] = gstru_uid_uname.s_parm[1]
			this.object.c_room_name[1] = gstru_uid_uname.s_parm[2]	  
			
			idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
			
			ll_rowcount = idw_name1.rowcount()
			
			FOR i = 1 TO ll_rowcount
				
				idw_name1.object.room_code[i] = gstru_uid_uname.s_parm[1]
				idw_name1.object.room_name[i] = gstru_uid_uname.s_parm[2]
				
			NEXT	
	
		END IF
		
	END IF			
	
//	IF dwo.name = 'c_item_name' THEN                       // 품목명 
//	 	ls_middle.uid = 'c_item_name'
//		ls_middle.uname =  this.object.c_item_name[1]
////		ls_item_name = this.object.c_item_name[1]
//	
////		openwithparm(w_kch102h,ls_item_name)
//		openwithparm(w_hgm001h,ls_middle)
//			
//		IF message.stringparm <> '' THEN
//	
//			this.object.c_item_no[1] = gstru_uid_uname.s_parm[1]
//			this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
//			
//			idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
//			
//			ll_rowcount = idw_name1.rowcount()
//			
//			FOR i = 1 TO ll_rowcount
//				
//				idw_name1.object.item_no[i] = gstru_uid_uname.s_parm[1]
//				idw_name1.object.item_name[i] = gstru_uid_uname.s_parm[2]
//				
//			NEXT	
//	
//		END IF
		
//	END IF			
	
end event

type dw_copy from datawindow within tabpage_sheet01
boolean visible = false
integer x = 2610
integer y = 8
integer width = 393
integer height = 60
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst202a_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.SettransObject(sqlca)
end event

type dw_update1 from cuo_dwwindow_one_hin within tabpage_sheet01
boolean visible = false
integer x = 1152
integer y = 1624
integer width = 2235
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hst201i_55"
end type

type gb_4 from groupbox within tabpage_sheet01
integer x = 14
integer y = 756
integer width = 4325
integer height = 1232
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "자산 내역"
end type

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1988
string text = "관리전환 내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
st_4 st_4
sle_idno sle_idno
st_3 st_3
st_2 st_2
em_todate em_todate
em_frdate em_frdate
st_1 st_1
gb_2 gb_2
dw_gwa dw_gwa
end type

on tabpage_1.create
this.dw_print=create dw_print
this.st_4=create st_4
this.sle_idno=create sle_idno
this.st_3=create st_3
this.st_2=create st_2
this.em_todate=create em_todate
this.em_frdate=create em_frdate
this.st_1=create st_1
this.gb_2=create gb_2
this.dw_gwa=create dw_gwa
this.Control[]={this.dw_print,&
this.st_4,&
this.sle_idno,&
this.st_3,&
this.st_2,&
this.em_todate,&
this.em_frdate,&
this.st_1,&
this.gb_2,&
this.dw_gwa}
end on

on tabpage_1.destroy
destroy(this.dw_print)
destroy(this.st_4)
destroy(this.sle_idno)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.em_todate)
destroy(this.em_frdate)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.dw_gwa)
end on

type dw_print from datawindow within tabpage_1
integer x = 9
integer y = 216
integer width = 4334
integer height = 1772
integer taborder = 120
string title = "none"
string dataobject = "d_hst203i_20"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type st_4 from statictext within tabpage_1
integer x = 1253
integer y = 100
integer width = 274
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "사용부서"
boolean focusrectangle = false
end type

type sle_idno from singlelineedit within tabpage_1
integer x = 2825
integer y = 80
integer width = 507
integer height = 84
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 11
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_1
integer x = 2542
integer y = 100
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "등재번호"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_1
integer x = 718
integer y = 80
integer width = 69
integer height = 92
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

type em_todate from editmask within tabpage_1
integer x = 791
integer y = 80
integer width = 366
integer height = 84
integer taborder = 70
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

type em_frdate from editmask within tabpage_1
integer x = 343
integer y = 80
integer width = 361
integer height = 84
integer taborder = 30
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

type st_1 from statictext within tabpage_1
integer x = 197
integer y = 100
integer width = 146
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "기간"
boolean focusrectangle = false
end type

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 12
integer width = 4334
integer height = 196
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

type dw_gwa from datawindow within tabpage_1
integer x = 1509
integer y = 72
integer width = 786
integer height = 92
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_hgm201i_7"
boolean border = false
boolean livescroll = true
end type

