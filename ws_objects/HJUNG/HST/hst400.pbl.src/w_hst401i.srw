$PBExportHeader$w_hst401i.srw
$PBExportComments$비품 이동 신청
forward
global type w_hst401i from w_tabsheet
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type dw_head2 from datawindow within tabpage_sheet01
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type dw_list from uo_dwgrid within tabpage_sheet01
end type
type cb_1 from uo_imgbtn within tabpage_sheet01
end type
type cb_select from uo_imgbtn within tabpage_sheet01
end type
type tab_sheet_2 from userobject within tab_sheet
end type
type dw_print from cuo_dwprint within tab_sheet_2
end type
type tab_sheet_2 from userobject within tab_sheet
dw_print dw_print
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print1 dw_print1
end type
type dw_head1 from datawindow within w_hst401i
end type
type gb_5 from groupbox within w_hst401i
end type
end forward

global type w_hst401i from w_tabsheet
string title = "비품 이동 신청 "
dw_head1 dw_head1
gb_5 gb_5
end type
global w_hst401i w_hst401i

type variables

int ii_tab
datawindowchild idw_child
datawindow idw_sname, idw_name1
end variables

forward prototypes
public subroutine wf_insert ()
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_insert ();//
//long ll_row
//
//ii_tab  = tab_sheet.selectedtab
//
//CHOOSE CASE ii_tab
//		
//	CASE 1
//		
//		idw_name = tab_sheet.tabpage_sheet01.dw_update
//
//		IF idw_name.rowcount() <> 0 THEN
//			
//			IF idw_name.object.move_opt[1] = 2 THEN                // 처리 
//				idw_name.reset()           
//				tab_sheet.tabpage_sheet01.dw_update.object.datawindow.readonly = "NO" 
//			END IF	
//							
//		END IF	
//		
//	   ll_row = idw_name.insertrow(0)
//	
////	   idw_name.object.move_apply_date[1] = f_today()                // 신청 일자  
//	   idw_name.object.apply_date[1] = f_today()                // 신청 일자  
////		idw_name.object.apply_person[1] = '1'           //gstru_uid_uname.uid      // 신청인
////      idw_name.object.worker[1] = '1'             //gstru_uid_uname.uid            // 작업자 
////		idw_name.object.work_date[li_row] = f_sysdate()                 // 오늘 일자 
//	
//	   idw_name.setfocus()
//		idw_name.scrolltorow(ll_row)
//		idw_name.setrow(ll_row)
//		
//END CHOOSE
//

end subroutine

public subroutine wf_retrieve ();
int li_chk
long ll_row
string	ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_dept_code, ls_room_code, ls_date_f, ls_date_t
STring	ls_id_no_nm, ls_item_no_nm,  ls_item_name_nm, ls_item_class_nm,ls_dept_code_nm
String	ls_header, ls_room_name,ls_room_name_nm




dw_head1.accepttext()
		
ls_id_no 			= trim(dw_head1.object.c_id_no[1]) + '%'				
ls_id_no_nm 		= trim(dw_head1.object.c_id_no[1])
ls_room_name 			= trim(dw_head1.object.c_room_name[1]) + '%'				
ls_room_name_nm 		= trim(dw_head1.object.c_room_name[1])
ls_item_no 			= trim(dw_head1.object.c_item_no[1]) + '%'
ls_item_no_nm 		= trim(dw_head1.object.c_item_no[1]) 
ls_item_name 		= trim(dw_head1.object.c_item_name[1]) + '%'
ls_item_name_nm 	= trim(dw_head1.object.c_item_name[1]) 
ls_item_class 		= string(dw_head1.object.c_item_class[1]) + '%'
ls_item_class_nm 	= dw_head1.Describe("Evaluate('lookupdisplay(c_item_class)',"+String(1)+")") 
ls_date_f 			= dw_head1.object.c_date_f[1]
ls_date_t 			= dw_head1.object.c_date_t[1]
ls_dept_code 		= trim(dw_head1.object.c_dept_code[1]) + '%'
ls_dept_code_nm	= dw_head1.Describe("Evaluate('lookupdisplay(c_dept_code)',"+String(1)+")") 
li_chk 				= dw_head1.object.c_chk[1]



IF 	ISNULL(ls_id_no) THEN 
		ls_id_no = '%'
ELSE		
		ls_header	+=	"  등재번호 : "+ls_id_no_nm
END IF		
IF 	ISNULL(ls_room_name) THEN 
		ls_room_name = '%'
ELSE		
		ls_room_name += '%'
		ls_header	+=	"  장소 : "+ls_room_name_nm
END IF		
	
IF 	ISNULL(ls_item_no) THEN 
		ls_item_no = '%'
ELSE		
	ls_header	+=	"  품목코드 : "+ls_item_no_nm
END IF	
IF 	ISNULL(ls_item_name) THEN 
		ls_item_name = '%'
ELSE		
		ls_header	+=	"  품목명 : "+ls_item_name_nm
END IF	
IF 	ISNULL(ls_item_class) THEN 
		ls_item_class = '%'
ELSE		
		ls_header	+=	"  물품구분 :"+ls_item_class_nm
END IF	
IF 	ISNULL(ls_dept_code) THEN 
		ls_dept_code = '%'
ELSE
		ls_header	+=	"  부서 :"+ls_dept_code_nm
		
END IF	
		
IF 	ISNULL(ls_date_f) OR ls_date_f = "" OR ISNULL(ls_date_t) OR ls_date_t = ""THEN 
		
ELSE
		ls_header	+=	"  신청일자 : "+ string(ls_date_f,'@@@@/@@/@@')+"-"+string(ls_date_t,'@@@@/@@/@@')
END IF			

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
			
		IF tab_sheet.tabpage_sheet01.dw_update_tab.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code, li_chk , ls_room_name) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
		ELSE
			wf_SetMsg('자료가 조회되었습니다.')			
			IF li_chk = 1 THEN
				tab_sheet.tabpage_sheet01.dw_update_tab.object.datawindow.readonly = "NO"		
			ELSE
				tab_sheet.tabpage_sheet01.dw_update_tab.object.datawindow.readonly = "YES"				
			END IF	
			
			tab_sheet.tabpage_sheet01.dw_update_tab.setfocus()
			
		END IF	 

  CASE 2
				
		IF tab_sheet.tab_sheet_2.dw_print.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code, li_chk , ls_room_name) = 0 THEN
			wf_setMsg("조회된 데이타가 없습니다")	
			tab_sheet.tab_sheet_2.dw_print.object.t_10.text	=	""			
		ELSE	
			wf_SetMsg('자료가 조회되었습니다.')		
			IF		li_chk = 1	THEN
					tab_sheet.tab_sheet_2.dw_print.object.t_1.text = " 비품 이동 신청내역 "
			ELSE		
					tab_sheet.tab_sheet_2.dw_print.object.t_1.text = " 비품 이동 처리내역 "
			END IF	
			tab_sheet.tab_sheet_2.dw_print.object.t_10.text	=	ls_header
         //wf_setmenu('P',TRUE)
		END IF	
		
   CASE 3
			
			int idx
			Long ll_RowCnt
		
			ll_RowCnt = tab_sheet.tabpage_1.dw_print1.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_date_f, ls_date_t, ls_dept_code, li_chk , ls_room_name)
		   IF ll_RowCnt = 0 THEN
			    wf_setMsg("조회된 데이타가 없습니다")	
			     for idx = 1 to 16
				   tab_sheet.tabpage_1.dw_print1.insertrow(0)
			     next
			
		   ELSE	
			    wf_SetMsg('자료가 조회되었습니다.')		
              for idx = ll_RowCnt to 16
				    tab_sheet.tabpage_1.dw_print1.insertrow(0)
			     next
			
              //wf_setmenu('P',TRUE)
		   END IF	
//		   DateTime	ldt_SysDateTime
//         ldt_SysDateTime = f_sysdate()	//시스템일자
//         tab_sheet.tabpage_1.dw_print1.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY"년"MM"월"DD"일"')
 
END CHOOSE		



end subroutine

on w_hst401i.create
int iCurrent
call super::create
this.dw_head1=create dw_head1
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head1
this.Control[iCurrent+2]=this.gb_5
end on

on w_hst401i.destroy
call super::destroy
destroy(this.dw_head1)
destroy(this.gb_5)
end on

event ue_retrieve;call super::ue_retrieve;
wf_retrieve()

return 1



end event

event ue_insert;call super::ue_insert;
wf_insert()

//int li_row
//
//ii_tab  = tab_sheet.selectedtab
//
//CHOOSE CASE ii_tab
//	CASE 1
//		
//		idw_name = tab_sheet.tabpage_sheet01.dw_update
//		
//	   li_row = idw_name.insertrow(0)
//	
//	   gstru_uid_uname.uid = '1'      // 추후에 삭제한다 
//	
//	   idw_name.object.apply_date[li_row] = f_today()                  // 신청 일자  
//		idw_name.object.apply_person[li_row] = gstru_uid_uname.uid      // 신청인
//      idw_name.object.worker[li_row] = gstru_uid_uname.uid            // 작업자 
//		idw_name.object.work_date[li_row] = f_sysdate()                 // 오늘 일자 
//	
//	   idw_name.setfocus()
//		idw_name.setrow(li_row)
//		
//END CHOOSE
//
end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 비품이동 신청 입력 및 출력
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////

//wf_setmenu('I',FALSE)
//wf_setmenu('R',TRUE)
//wf_setmenu('D',TRUE)
//wf_setmenu('U',TRUE)

if gstru_uid_uname.uid = 'F0048'or gstru_uid_uname.uid = 'F0008'or gstru_uid_uname.uid = 'F0057'  then
   dw_head1.Object.c_dept_code.protect = 0
	tab_sheet.tabpage_sheet01.dw_head2.Object.c_dept_code.protect = 0
else
	dw_head1.Object.c_dept_code.protect = 1
	tab_sheet.tabpage_sheet01.dw_head2.Object.c_dept_code.protect = 1
end if



////----- 조회 조건 -------//

f_childretrieve(dw_head1,"c_item_class","item_class")         // 물품구분(조회조건) 
f_childretrieven(dw_head1,"c_dept_code")                      // 부 서(조회조건) 

dw_head1.reset()
dw_head1.insertrow(0)

dw_head1.object.c_date_f[1] = left(f_today(),6) + '01'
dw_head1.object.c_date_t[1] = f_today()

//----------- 비품이동신청내역 -------------//

idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab

f_childretrieve(idw_name1,"item_class","item_class")            // 물품구분(저장)
f_childretrieven(idw_name1,"gwa")                     			   // 이동부서(저장) 
//f_childretrieven(idw_name1,"move_bef_gwa")                    // 이동전부서(저장) 
//f_childretrieven(idw_name1,"move_bef_room")                   // 이동전호실(저장) 

//---------- 자산 조회 조건 ---------------//

idw_sname = tab_sheet.tabpage_sheet01.dw_head2

f_childretrieve(idw_sname,"c_item_class","item_class")        //  물품구분
f_childretrieven(idw_sname,"c_dept_code")                     //  부서

idw_sname.reset()
idw_sname.insertrow(0)

//---------- 자산 조회 ---------------//

f_childretrieve(tab_sheet.tabpage_sheet01.dw_list,"item_class","item_class")            // 물품구분(조회) 

//---------- 비품이동신청내역 ---------------//

f_childretrieve(tab_sheet.tab_sheet_2.dw_print,"item_class","item_class")            // 물품구분(조회) 
idw_print = tab_sheet.tab_sheet_2.dw_print

tab_sheet.tabpage_1.dw_print1.object.DataWindow.zoom = 100
tab_sheet.tabpage_1.dw_print1.object.DataWindow.print.preview = 'YES'

dw_head1.object.c_dept_code[1]	=	gstru_uid_uname.dept_code
tab_sheet.tabpage_sheet01.dw_head2.object.c_dept_code[1]	=	gstru_uid_uname.dept_code

end event

event ue_save;call super::ue_save;
Int		idx
String	ls_id_no, ls_gwa, ls_room
String	ls_item_name, ls_apply_date, ls_bef_gwa, ls_bef_room, ls_in_item_name
Long		ll_item_class, ll_move_cnt, ll_seq_no, ll_seq_no2

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
     
	  idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
	  
	  idw_name1.accepttext()	  

	  IF f_chk_modified(idw_name1) = FALSE THEN RETURN -1
			
			For		idx	=	1		To	 tab_sheet.tabpage_sheet01.dw_update_tab.rowcount()
				
						ls_id_no			=	tab_sheet.tabpage_sheet01.dw_update_tab.object.id_no			[idx]
						ll_item_class	=	tab_sheet.tabpage_sheet01.dw_update_tab.object.item_class		[idx]
						ls_gwa			=	TRIM(tab_sheet.tabpage_sheet01.dw_update_tab.object.gwa		[idx])
						ls_room			=	TRIM(tab_sheet.tabpage_sheet01.dw_update_tab.object.room_code[idx])
						ls_item_name	=	tab_sheet.tabpage_sheet01.dw_update_tab.object.item_name	   [idx]
						ls_apply_date	=	tab_sheet.tabpage_sheet01.dw_update_tab.object.apply_date	   [idx]
						ls_bef_gwa		=	trim(tab_sheet.tabpage_sheet01.dw_update_tab.object.move_bef_gwa[idx])
						ls_bef_room		=	tab_sheet.tabpage_sheet01.dw_update_tab.object.move_bef_room	[idx]
						ls_in_item_name=	tab_sheet.tabpage_sheet01.dw_update_tab.object.in_item_name	[idx]
						
//********** 2004-01-28		*********************************//	
//						UPDATE	STDB.HST027M
//						SET		GWA	= :ls_gwa	, ROOM_CODE = :ls_room	
//						WHERE		ID_NO	= :ls_id_no	AND	ITEM_CLASS	= : ll_item_class	;
						
						IF		SQLCA.SQLCODE <>	0		THEN
								wf_setmsg("저장중 오류가 발생하였습니다")
								ROLLBACK;
								RETURN -1							
						END IF
		


 	  string ls_colarry[] = {'id_no/등재번호', 'item_class/품목구분','apply_date/신청일자', & 
		                      'apply_member_no/신청자', 'move_proc_date/이동처리 일자'}
	  IF f_chk_null( idw_name1, ls_colarry ) = 1 THEN 
	  END IF
	
	     IF f_update( idw_name1,'U') = TRUE THEN wf_setmsg("저장되었습니다")
	NEXT
	  
END CHOOSE		
end event

event ue_delete;call super::ue_delete;
long ll_row, ll_DeleteCnt, ll_DeleteRow, ll_DeleteRowCnt

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab

     	ll_row = idw_name1.getrow()		

	   IF ll_row <> 0 THEN		  
				  
				dwItemStatus l_status 
				l_status = idw_name1.getitemstatus(ll_row, 0, Primary!)
				
				IF l_status = New! OR l_status = NewModified! THEN 
						
					ll_DeleteCnt = idw_name1.deleterow(ll_row)

						
				ELSE
					
				  IF f_messagebox( '2', 'DEL' ) = 1 THEN
					
					  IF idw_name1.object.move_opt[1] <> 1 THEN		
						  messagebox("확인","삭제할수 없습니다. 비품 이동 신청된 데이타가 이동되었습니다")
						  RETURN		
					  END IF
						
					  int  idx
					  ll_DeleteCnt = idw_name1.deleterow(ll_row)
					  
                 ll_DeleteRow = idw_name1.GetRow()
                 ll_DeleteRowCnt = idw_name1.RowCount()
					
                  FOR  ll_row = ll_DeleteRow  TO ll_DeleteRowCnt
							 IF ll_row = 0 THEN
							    EXIT
							 ELSE
	                      idw_name1.object.seq_no[ll_Row] = ll_row
						    END IF
                  NEXT
						
						IF ll_DeleteRowCnt = 0 THEN
						  IF f_update( idw_name1,'D') = TRUE THEN wf_setmsg("삭제되었습니다")
					   ELSE
					    THIS.TRIGGER EVENT ue_save()
					   END IF
					  END IF		
				  END IF
			end if		  
		
END CHOOSE		

//f_setpointer('END')

end event

event ue_print;call super::ue_print;//
//ii_tab = tab_sheet.selectedtab
//
//CHOOSE CASE ii_tab
//		
//	CASE 2
//
//     IF tab_sheet.tab_sheet_2.dw_print.rowcount() <> 0 THEN f_print(tab_sheet.tab_sheet_2.dw_print)
//	  
//   CASE 3
//
//     IF tab_sheet.tabpage_1.dw_print1.rowcount() <> 0 THEN f_print(tab_sheet.tabpage_1.dw_print1)
//	   
//END CHOOSE	  
//
end event

event ue_init;call super::ue_init;//wf_setmenu('R',TRUE)
//wf_setmenu('I',TRUE)
//wf_setmenu('D',FALSE)
//wf_setmenu('S',FALSE)
//wf_setmenu('P',FALSE)

dw_head1.reset()
dw_head1.insertrow(0)
dw_head1.object.c_date_f[1] = left(f_today(),6) + '01'
dw_head1.object.c_date_t[1] = f_today()

tab_sheet.tabpage_sheet01.dw_head2.reset()
tab_sheet.tabpage_sheet01.dw_head2.insertrow(0)

tab_sheet.tabpage_sheet01.dw_update_tab.reset()
tab_sheet.tabpage_sheet01.dw_list.reset()
tab_sheet.tab_sheet_2.dw_print.reset()
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

event ue_button_set;call super::ue_button_set;tab_sheet.tabpage_sheet01.cb_select.x = tab_sheet.tabpage_sheet01.cb_1.x + tab_sheet.tabpage_sheet01.cb_1.width + 16
end event

type ln_templeft from w_tabsheet`ln_templeft within w_hst401i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hst401i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hst401i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hst401i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hst401i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hst401i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hst401i
end type

type uc_insert from w_tabsheet`uc_insert within w_hst401i
end type

type uc_delete from w_tabsheet`uc_delete within w_hst401i
end type

type uc_save from w_tabsheet`uc_save within w_hst401i
end type

type uc_excel from w_tabsheet`uc_excel within w_hst401i
end type

type uc_print from w_tabsheet`uc_print within w_hst401i
end type

type st_line1 from w_tabsheet`st_line1 within w_hst401i
end type

type st_line2 from w_tabsheet`st_line2 within w_hst401i
end type

type st_line3 from w_tabsheet`st_line3 within w_hst401i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hst401i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hst401i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hst401i
integer y = 440
integer width = 4384
integer height = 1856
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tab_sheet_2 tab_sheet_2
tabpage_1 tabpage_1
end type

event tab_sheet::selectionchanged;call super::selectionchanged;
CHOOSE CASE newindex
		
	CASE 1, 2
		idw_print = tab_sheet.tab_sheet_2.dw_print
	CASE 3
		idw_print  = tab_sheet.tabpage_1.dw_print1
END CHOOSE	  

end event

on tab_sheet.create
this.tab_sheet_2=create tab_sheet_2
this.tabpage_1=create tabpage_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_sheet_2
this.Control[iCurrent+2]=this.tabpage_1
end on

on tab_sheet.destroy
call super::destroy
destroy(this.tab_sheet_2)
destroy(this.tabpage_1)
end on

type tabpage_sheet01 from w_tabsheet`tabpage_sheet01 within tab_sheet
string tag = "N"
integer y = 104
integer width = 4347
integer height = 1736
long backcolor = 1073741824
string text = "비품 이동 신청"
gb_1 gb_1
dw_head2 dw_head2
gb_2 gb_2
dw_list dw_list
cb_1 cb_1
cb_select cb_select
end type

on tabpage_sheet01.create
this.gb_1=create gb_1
this.dw_head2=create dw_head2
this.gb_2=create gb_2
this.dw_list=create dw_list
this.cb_1=create cb_1
this.cb_select=create cb_select
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_head2
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_select
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_head2)
destroy(this.gb_2)
destroy(this.dw_list)
destroy(this.cb_1)
destroy(this.cb_select)
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
event key_enter pbm_dwnprocessenter
event ue_keydown pbm_dwnkey
integer x = 73
integer y = 104
integer width = 4229
integer height = 676
string dataobject = "d_hst401i_3"
boolean hsplitscroll = true
end type

event dw_update_tab::key_enter;
long ll_getrow
string ls_room_name, ls_apply_member_no

this.accepttext()

IF this.getcolumnname() = 'room_name' THEN                       // 호실명
 
   ll_getrow = this.getrow()
 
	ls_room_name = this.object.room_name[ll_getrow]

	openwithparm(w_hgm100h,ls_room_name)
		
	IF message.stringparm <> '' THEN

		this.object.move_room_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.room_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   

	END IF

END IF	   


IF this.getcolumnname() = 'apply_member_no' THEN                       //신청자
 
   ll_getrow = this.getrow()
 
	ls_apply_member_no = this.object.apply_member_no[ll_getrow]

	openwithparm(w_hgm200h,ls_apply_member_no)
		
	IF message.stringparm <> '' THEN

		this.object.apply_member_no[ll_getrow] = gstru_uid_uname.s_parm[1]
//		this.object.apply_member_no[ll_getrow] = gstru_uid_uname.s_parm[2]	   

	END IF

END IF	   

end event

event dw_update_tab::ue_keydown;//
//long ll_getrow
//string ls_item_middle, ls_room_code
//
//this.accepttext()
//
//IF key = keyenter! THEN
//	
//	ll_getrow = this.getrow()
//	
//	IF this.getcolumnname() = 'item_middle' THEN                         // 물품 코드 
//	
//	   ls_item_middle = this.object.item_middle[ll_getrow]
//	
//		openwithparm(w_kch101h,ls_item_middle)
//				
//		IF message.stringparm <> '' THEN
//		
//			this.object.item_middle[ll_getrow] = gstru_uid_uname.s_parm[1]
//			this.object.midd_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
//		
//		END IF
//	
//   END IF
//
//   IF this.getcolumnname() = 'room_code' THEN                       // 호실 코드 
//	 
//	   ls_room_code = this.object.room_code[ll_getrow]
//	
//	   openwithparm(w_kch103h,ls_room_code)
//	   	
//	   IF message.stringparm <> '' THEN
//	
//			this.object.room_code[ll_getrow] = gstru_uid_uname.s_parm[1]
//			this.object.room_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
//	
//      END IF
//	
//   END IF
//	   
//END IF	
end event

event dw_update_tab::dberror;call super::dberror;IF sqldbcode = 1 THEN
	messagebox("확인",'중복된 값이 있습니다.')
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

event dw_update_tab::doubleclicked;call super::doubleclicked;long ll_getrow
string ls_room_name, ls_apply_member_no

this.accepttext()

//IF this.getcolumnname() = 'room_name' THEN                       // 호실명
// 
//   ll_getrow = this.getrow()
// 
//	ls_room_name = this.object.room_name[ll_getrow]
//
//	openwithparm(w_hgm100h,ls_room_name)
//		
//	IF message.stringparm <> '' THEN
//
//		this.object.move_room_code[ll_getrow] = gstru_uid_uname.s_parm[1]
//		this.object.room_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
//
//	END IF
//
//END IF	   


IF dwo.name = 'apply_member_no' THEN                       //신청자
 
   ll_getrow = this.getrow()
 
	ls_apply_member_no = this.object.apply_member_no[ll_getrow]

	openwithparm(w_hgm200h,ls_apply_member_no)
		
	IF message.stringparm <> '' THEN

		this.object.apply_member_no[ll_getrow] = gstru_uid_uname.s_parm[1]
//		this.object.apply_member_no[ll_getrow] = gstru_uid_uname.s_parm[2]	   

	END IF

END IF	   

end event

type uo_tab from w_tabsheet`uo_tab within w_hst401i
integer x = 1573
integer y = 424
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hst401i
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hst401i
boolean visible = false
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 32
integer y = 848
integer width = 2793
integer height = 284
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "자산 조회 조건"
end type

type dw_head2 from datawindow within tabpage_sheet01
event ue_keydown pbm_dwnkey
integer x = 59
integer y = 920
integer width = 2734
integer height = 188
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst401i_1"
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
	
      tab_sheet.tabpage_sheet01.cb_1.triggerevent("clicked")
	
	END IF			
	
END IF


end event

event itemchanged;IF dwo.name = 'c_room_name' THEN this.object.c_room_code[1] = ''
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

				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
   ELSE
       TRIGGER EVENT ue_retrieve()
	END IF
end event

type gb_2 from groupbox within tabpage_sheet01
integer x = 41
integer y = 32
integer width = 4302
integer height = 784
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "비품 이동 신청 내역"
end type

type dw_list from uo_dwgrid within tabpage_sheet01
integer x = 27
integer y = 1160
integer width = 4311
integer height = 572
integer taborder = 21
boolean titlebar = true
string title = "자산 내역"
string dataobject = "d_hst401i_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

event doubleclicked;call super::doubleclicked;//
//long ll_row
//
//this.accepttext()
//
//idw_name = tab_sheet.tabpage_sheet01.dw_update
//
//ll_row = idw_name.getrow()
//
//IF ll_row <> 0 THEN
//
//	IF idw_name.object.move_opt[ll_row] = 1 THEN              // 신청이면 
//	
//		idw_name.object.id_no[ll_row] = this.object.id_no[row]
//		idw_name.object.item_no[ll_row] = this.object.item_no[row]
//		idw_name.object.item_name[ll_row] = this.object.item_name[row]
//		idw_name.object.item_class[ll_row] = this.object.item_class[row]
//		idw_name.object.item_stand_size[ll_row] = this.object.item_stand_size[row]
//		idw_name.object.model[ll_row] = this.object.model[row]
//		idw_name.object.move_bdept[ll_row] = this.object.dept_code[row]
//		idw_name.object.move_broom_code[ll_row] = this.object.room_code[row]
//		idw_name.object.move_dept[ll_row] = this.object.dept_code[row]
//		idw_name.object.move_room_code[ll_row] = this.object.room_code[row]
//		idw_name.object.room_name[ll_row] = this.object.room_name[row]
//
//   END IF
//
//END IF
end event

type cb_1 from uo_imgbtn within tabpage_sheet01
integer x = 2848
integer y = 1020
integer taborder = 90
boolean bringtotop = true
string btnname = "조 회"
end type

event clicked;call super::clicked;
long ll_row
string ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_dept_code, ls_room_name



idw_sname.accepttext()
		
idw_sname = tab_sheet.tabpage_sheet01.dw_head2
		
ls_id_no = trim(idw_sname.object.c_id_no[1]) + '%'				
ls_item_no = trim(idw_sname.object.c_item_no[1]) + '%'
ls_item_name = trim(idw_sname.object.c_item_name[1]) + '%'
ls_item_class = string(idw_sname.object.c_item_class[1]) + '%'
ls_dept_code = trim(idw_sname.object.c_dept_code[1]) + '%'
ls_room_name = trim(idw_sname.object.c_room_name[1]) + '%'

IF ISNULL(ls_id_no) THEN ls_id_no = '%'
IF ISNULL(ls_item_no) THEN ls_item_no = '%'
IF ISNULL(ls_item_name) THEN ls_item_name = '%'
IF ISNULL(ls_item_class) THEN ls_item_class = '%'
IF ISNULL(ls_dept_code) THEN ls_dept_code = '%'
IF ISNULL(ls_room_name) THEN ls_room_name = '%'
			
IF tab_sheet.tabpage_sheet01.dw_list.retrieve( ls_id_no, ls_item_no, ls_item_name, ls_item_class, ls_dept_code, ls_room_name ) = 0 THEN
	wf_setMsg("조회된 데이타가 없습니다")	
else
	wf_SetMsg('자료가 조회되었습니다.')
END IF	 



end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type cb_select from uo_imgbtn within tabpage_sheet01
integer x = 3150
integer y = 1020
integer taborder = 100
boolean bringtotop = true
string btnname = "선 택"
end type

event clicked;call super::clicked;long i, ll_row, ll_DeleteCnt
Long		ll_DeleteRow[]

idw_sname = tab_sheet.tabpage_sheet01.dw_list
i = idw_sname.getrow()

if i = 0 then
	wf_setMsg("먼저 선택하여 주십시요.")	
	return
else
	idw_name1 = tab_sheet.tabpage_sheet01.dw_update_tab
	
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
	      ll_RowCnt = idw_name1.RowCount()
      FOR idx = ll_GetRow TO ll_RowCnt
		    idw_name1.object.seq_no[ll_row] = ll_Row
         NEXT
      END IF 
		
		idw_name1.object.id_no[ll_row]           = idw_sname.object.id_no[i]
		idw_name1.object.item_no[ll_row]         = idw_sname.object.item_no[i]
		idw_name1.object.item_name[ll_row]       = idw_sname.object.item_name[i]
		idw_name1.object.item_class[ll_row]      = idw_sname.object.item_class[i]
		idw_name1.object.item_stand_size[ll_row] = idw_sname.object.item_stand_size[i]
		idw_name1.object.model[ll_row]           = idw_sname.object.model[i]
		idw_name1.object.move_bef_gwa[ll_row]    = idw_sname.object.gwa[i]
		idw_name1.object.move_bef_room[ll_row]   = idw_sname.object.room_code[i]
//		idw_name1.object.gwa[ll_row]             = idw_sname.object.gwa[i]
		idw_name1.object.purchase_qty[ll_row]    = idw_sname.object.purchase_qty[i]
		idw_name1.object.purchase_amt[ll_row]    = idw_sname.object.purchase_amt[i]
//		idw_name1.object.room_name[ll_row]       = idw_sname.object.room_name[i]
//		idw_name1.object.room_code[ll_row]       = idw_sname.object.room_code[i]		
		idw_name1.object.worker[ll_row]          = gstru_uid_uname.uid
		idw_name1.object.work_date[ll_row]       = f_sysdate()
		idw_name1.object.apply_date[ll_row]      = f_today()
		idw_name1.object.move_proc_date[ll_row]  = f_today()		
		idw_name1.object.apply_member_no[ll_row] = gstru_uid_uname.uid
		idw_name1.object.move_opt[ll_row]        = 1		
		
		ll_DeleteCnt++
		ll_DeleteRow[ll_DeleteCnt] = i
		i = idw_sname.getrow()

	Loop 
end if

Long	ll_idx
FOR ll_idx = UpperBound(ll_DeleteRow) TO 1 STEP -1
	idw_sname.DeleteRow(ll_DeleteRow[ll_idx])
NEXT




end event

on cb_select.destroy
call uo_imgbtn::destroy
end on

type tab_sheet_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1736
string text = "비품 이동 신청 내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tab_sheet_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tab_sheet_2.destroy
destroy(this.dw_print)
end on

type dw_print from cuo_dwprint within tab_sheet_2
integer y = 8
integer width = 4347
integer height = 1720
integer taborder = 11
boolean titlebar = true
string title = "비품 이동 신청 내역"
string dataobject = "d_hst401i_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 1736
string text = "비품 이동 신청서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print1 dw_print1
end type

on tabpage_1.create
this.dw_print1=create dw_print1
this.Control[]={this.dw_print1}
end on

on tabpage_1.destroy
destroy(this.dw_print1)
end on

type dw_print1 from datawindow within tabpage_1
integer width = 4347
integer height = 1732
integer taborder = 90
boolean titlebar = true
string title = "비품이동 신청서"
string dataobject = "d_hst401i_6"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_head1 from datawindow within w_hst401i
event dn_key pbm_dwnkey
integer x = 82
integer y = 176
integer width = 3616
integer height = 212
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_hst401i_4"
boolean border = false
boolean livescroll = true
end type

event dn_key;String	ls_room_name
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

				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
   ELSE
       TRIGGER EVENT ue_retrieve()
	END IF
end event

type gb_5 from groupbox within w_hst401i
integer x = 50
integer y = 124
integer width = 4384
integer height = 280
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회 조건"
end type

