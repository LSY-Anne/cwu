$PBExportHeader$w_hgm201i.srw
$PBExportComments$물품 신청
forward
global type w_hgm201i from w_tabsheet
end type
type gb_4 from groupbox within tabpage_sheet01
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type dw_head from datawindow within tabpage_sheet01
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type dw_update from cuo_dwwindow within tabpage_sheet01
end type
type cb_1 from uo_imgbtn within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_print2 from datawindow within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type em_to_date from editmask within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type sle_2 from singlelineedit within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type em_fr_date from editmask within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type dw_acct_code from datawindow within tabpage_1
end type
type dw_search from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_print2 dw_print2
st_5 st_5
em_to_date em_to_date
st_4 st_4
sle_2 sle_2
st_3 st_3
st_2 st_2
st_1 st_1
em_fr_date em_fr_date
gb_3 gb_3
dw_acct_code dw_acct_code
dw_search dw_search
end type
type tabpage_2 from userobject within tab_sheet
end type
type st_11 from statictext within tabpage_2
end type
type st_10 from statictext within tabpage_2
end type
type st_9 from statictext within tabpage_2
end type
type em_to_dt from editmask within tabpage_2
end type
type em_fr_dt from editmask within tabpage_2
end type
type st_8 from statictext within tabpage_2
end type
type st_7 from statictext within tabpage_2
end type
type sle_gian_no from singlelineedit within tabpage_2
end type
type st_6 from statictext within tabpage_2
end type
type dw_1 from datawindow within tabpage_2
end type
type gb_6 from groupbox within tabpage_2
end type
type dw_gwa from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
st_11 st_11
st_10 st_10
st_9 st_9
em_to_dt em_to_dt
em_fr_dt em_fr_dt
st_8 st_8
st_7 st_7
sle_gian_no sle_gian_no
st_6 st_6
dw_1 dw_1
gb_6 gb_6
dw_gwa dw_gwa
end type
type gb_5 from groupbox within w_hgm201i
end type
end forward

global type w_hgm201i from w_tabsheet
string title = "물품 신청"
gb_5 gb_5
end type
global w_hgm201i w_hgm201i

type variables

int ii_tab 
datawindowchild idw_child
datawindow 		idw_sname
Long li_RowCnt, li_GetRow = 1

string is_gwa, is_apply_member

integer ii_gian_no
string  is_apply_date, is_item_gwa, is_gian_no
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();
datawindow dw_name, dw_name2, dw_name3
int  li_ord_class, li_page = 1, j,ll_apply_qty
string ls_apply_date_f, ls_apply_date_t, ls_item_middle, ls_item_name
string ls_dept_code, ls_apply_date, ls_acct_code, LS_APPLY_DATE1, ls_id
string ls_large_name, ls_medium_name, ls_small_name, ls_goods_kind, ls_measure, ls_model
long	 ll_apply_price,ll_apply_amt, i, ll_cur_row, ll_cur_row2, ll_total_amt, ll_gian_num
Long   ll_RowCnt, ll_Row_Cnt, idx, ll_getrow, ll_ins_row
//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
      ls_id	=	gs_empcode   
		dw_name = tab_sheet.tabpage_sheet01.dw_head
		dw_name2 = tab_sheet.tabpage_sheet01.dw_update
		dw_name.accepttext()

		ls_apply_date_f = dw_name.object.c_apply_date_f[1]
		ls_apply_date_t = dw_name.object.c_apply_date_t[1]
		ls_item_middle  = trim(dw_name.object.c_item_middle[1]) + '%'
		ls_item_name 	 = '%' + trim(dw_name.object.c_item_name[1]) + '%'
		ls_dept_code	 =	trim(dw_name.object.c_dept_code[1]) + '%'
		li_ord_class 	 = dw_name.object.c_ord_class[1] 
	
		IF ISNULL(ls_item_middle)  THEN ls_item_middle = '%'
		IF ISNULL(ls_item_name) 	THEN ls_item_name   = '%'
		IF ISNULL(ls_dept_code) 	THEN ls_dept_code   = '%'

	  li_RowCnt = tab_sheet.tabpage_sheet01.dw_update.retrieve( ls_apply_date_f, ls_apply_date_t, ls_item_middle,&
		                                                         ls_item_name, li_ord_class, ls_dept_code, ls_id) 
																				
   
	
		IF ll_RowCnt = 0 THEN
				wf_setMsg("조회된 데이타가 없습니다")

		ELSE
		      wf_setMsg("자료가 조회되었습니다..!")
				
	   END IF
CASE 2
	 
	 String  ls_fr_date, ls_to_date, ls_gian_num
	 String	ls_gwa, ls_apply_member
	 
	
	     ls_dept_code = trim(tab_sheet.tabpage_1.dw_search.object.code[1])

        IF isnull(ls_dept_code) or	ls_dept_code = ''	 THEN
		      ls_dept_code = '%'
		  ELSE
			  ls_dept_code = tab_sheet.tabpage_1.dw_search.object.code[tab_sheet.tabpage_1.dw_search.getrow()]
     	  END IF

	     ls_fr_date = mid(tab_sheet.tabpage_1.em_fr_date.text,1,4) + mid(tab_sheet.tabpage_1.em_fr_date.text,6,2) + &
	                  mid(tab_sheet.tabpage_1.em_fr_date.text,9,2)
	     ls_to_date = mid(tab_sheet.tabpage_1.em_to_date.text,1,4) + mid(tab_sheet.tabpage_1.em_to_date.text,6,2) + &
	                  mid(tab_sheet.tabpage_1.em_to_date.text,9,2)

	    IF ls_fr_date = '' or isnull(ls_fr_date) then
		    wf_setmsg("기간from를 입력하시기바랍니다..!")
		     return
	    END IF
	    IF ls_to_date = '' or isnull(ls_to_date) then
		    wf_setmsg("기간to를 입력하시기바랍니다..!")
		     return
	    END IF
	    
		  ls_acct_code = trim(tab_sheet.tabpage_1.dw_acct_code.object.code[1])
	

		  IF isnull(ls_acct_code) or	ls_acct_code = ''	 THEN
	
				  messagebox('확인','계정코드를 입력하시기 바랍니다..!')
		  ELSE
				  ls_acct_code = tab_sheet.tabpage_1.dw_acct_code.object.code[tab_sheet.tabpage_1.dw_acct_code.getrow()]
		  END IF
		
	    ls_gian_num  = tab_sheet.tabpage_1.sle_2.text
		 
	    IF isnull(ls_gian_num) or	ls_gian_num	 = ''	THEN
			   ls_gian_num	 = '%'
	    END IF
				
				SELECT A.APPLY_GWA,  A.APPLY_MEMBER_NO, A.APPLY_DATE
				INTO :ls_gwa, 			:ls_apply_member,  :ls_apply_date
				FROM STDB.HST105H A,  STDB.HST003M B, STDB.HST004M C,	STDB.HST242M D, STDB.HST002M E 
				WHERE  A.ITEM_NO = C.ITEM_NO 
				AND    C.ITEM_MIDDLE = B.ITEM_MIDDLE 
				AND    B.LARGE_CODE  = E.LARGE_CODE
				AND    A.ROOM_CODE = D.ROOM_CODE(+)
				AND    A.ORD_CLASS = '3'
				AND    A.APPLY_GWA like :ls_dept_code 
				AND    A.APPLY_DATE  BETWEEN  :ls_fr_date  AND :ls_to_date
				AND    A.ACCT_CODE = :ls_acct_code
				AND    A.GIAN_NUM  LIKE :ls_gian_num ;

		 ll_RowCnt = tab_sheet.tabpage_1.dw_print2.retrieve(ls_dept_code,ls_fr_date, ls_to_date,ls_acct_code, ls_gian_num)

			
	    IF ll_RowCnt = 0 THEN
				 wf_setMsg("조회된 데이타가 없습니다..!")
		 ELSE
				wf_setMsg("자료가 조회되었습니다..!")		 
			  for idx = ll_RowCnt to 10
				 ll_ins_row = tab_sheet.tabpage_1.dw_print2.insertrow(0)
			  next
		
		tab_sheet.tabpage_1.dw_print2.setitem(ll_ins_row, "apply_date", ls_apply_date)
		tab_sheet.tabpage_1.dw_print2.setitem(ll_ins_row, "hst105h_apply_gwa", ls_gwa)
		tab_sheet.tabpage_1.dw_print2.setitem(ll_ins_row, "hst105h_apply_member_no", ls_apply_member)
		
	    END IF
CASE 3
	 
	 String  ls_fr_dt, ls_to_dt
	 integer li_gian_no
	 
	 tab_sheet.tabpage_2.dw_1.settransobject(SQLCA) 
	 
		  ls_fr_dt = mid(tab_sheet.tabpage_2.em_fr_dt.text,1,4) + mid(tab_sheet.tabpage_2.em_fr_dt.text,6,2) + &
	                  mid(tab_sheet.tabpage_2.em_fr_dt.text,9,2)
	     ls_to_dt = mid(tab_sheet.tabpage_2.em_to_dt.text,1,4) + mid(tab_sheet.tabpage_2.em_to_dt.text,6,2) + &
	                  mid(tab_sheet.tabpage_2.em_to_dt.text,9,2)

	    IF ls_fr_dt = '' or isnull(ls_fr_dt) then
		    wf_setmsg("기간from를 입력하시기바랍니다..!")
		     return
	    END IF
	    IF ls_to_dt = '' or isnull(ls_to_dt) then
		    wf_setmsg("기간to를 입력하시기바랍니다..!")
		     return
	    END IF
	    tab_sheet.tabpage_2.dw_1.accepttext()
		 ls_dept_code = trim(tab_sheet.tabpage_2.dw_gwa.object.code[1])

        IF isnull(ls_dept_code) or	ls_dept_code = ''	 THEN
		      ls_dept_code = '%'
		  ELSE
			  ls_dept_code = tab_sheet.tabpage_2.dw_gwa.object.code[tab_sheet.tabpage_2.dw_gwa.getrow()]
     	  END IF
			 
		 li_gian_no  = integer(tab_sheet.tabpage_2.sle_gian_no.text)
		
//		messagebox('', ls_dept_code+':'+ls_fr_dt+':'+ls_to_dt)
//		messagebox('li_gian_no', li_gian_no)
		 
		 ll_RowCnt = tab_sheet.tabpage_2.dw_1.retrieve(ls_fr_dt, ls_to_dt, ls_dept_code, li_gian_no)

			
	    IF ll_RowCnt = 0 THEN
				 wf_setMsg("조회된 데이타가 없습니다..!")
		 ELSE
				wf_setMsg("자료가 조회되었습니다..!")		 
			  for idx = ll_RowCnt to 20
				 ll_ins_row = tab_sheet.tabpage_2.dw_1.insertrow(0)
			  next
		 END IF

END CHOOSE

//f_setpointer('END')


end subroutine

on w_hgm201i.create
int iCurrent
call super::create
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
end on

on w_hgm201i.destroy
call super::destroy
destroy(this.gb_5)
end on

event ue_retrieve;call super::ue_retrieve;  wf_retrieve()
return 1
		 
end event

event ue_insert;call super::ue_insert;string ls_apply_date
int li_row, li_GIAN_NUM
long   ll_rows, ll_i

ii_tab  = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		idw_name = tab_sheet.tabpage_sheet01.dw_update
		li_row = idw_name.insertrow(0)

//2007.01.12
			ls_apply_date  = 	f_today() //신청일자
			
			SELECT	NVL(MAX(A.GIAN_NUM),0) + 1
			INTO		:li_GIAN_NUM
			FROM		STDB.HST105H A
			WHERE		A.APPLY_DATE = :ls_apply_date
			AND		A.APPLY_GWA	 = :gs_DeptCode ;

			
			if sqlca.sqlcode <> 0 then
				rollback ;

				wf_SetMsg('기안번호 생성 중 오류가 발생하였습니다.')
				MessageBox('확인',&
							  '기안번호 생성시 전산장애가 발생되었습니다.~r~n' + &
							  '하단의 장애번호와 장애내역을~r~n' + &
							  '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
							  '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
							  '장애내역 : ' + SQLCA.SqlErrText)
				RETURN 
			end if
			
			ll_rows = tab_sheet.tabpage_sheet01.dw_update.rowcount()
		  
			FOR ll_i = 1 TO ll_rows
				DwItemStatus	lds_Status
				lds_Status = idw_name.getitemstatus(ll_i,0,Primary!)

				IF lds_Status = New! OR lds_Status = NewModified! THEN 
					idw_name.object.GIAN_NUM[ll_i] = li_GIAN_NUM 
					li_GIAN_NUM ++
				END IF
			NEXT
//			MessageBox('',li_GIAN_NUM)
		
	   idw_name.object.apply_date[li_row]		 = f_today()                  // 신청 일자  
	   idw_name.object.accept_gwa[li_row] 	 	 = '1401'                 		// 예산통제부서		
	   idw_name.object.apply_class[li_row] 	 = 1                 		   // 신청구분(1.청구로 셋팅한다)  		
		idw_name.object.apply_member_no[li_row] = gs_empcode   		// 신청인
      idw_name.object.worker[li_row]			 = gs_empcode        // 작업자 
      idw_name.object.apply_gwa[li_row] 		 = gs_DeptCode  // 신청부서 
		idw_name.object.work_date[li_row] 		 = f_sysdate()                // 오늘 일자 
		idw_name.object.ipaddr[li_row] 			 = gs_ip 	//IP
//		idw_name.object.gian_num[li_row] 		 = li_GIAN_NUM						//2007.01.12
//		idw_name.object.gian_num[li_row] 		 = Long(tab_sheet.tabpage_sheet01.sle_1.text) 	// 기안번호	/*2004-02-06*/	
		
	   idw_name.setfocus()
		idw_name.setrow(li_row)
		
END CHOOSE

end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////
// 	작성목적 : 물품신청
//    적 성 인 : 윤하영
//		작성일자 : 2002.03.01
//    변 경 인 :
//    변경일자 :
//    변경사유 :
//////////////////////////////////////////////////////////////////
Long		ll_gian_num, ll_InsRow
String	ls_id


//wf_setMenu('I',TRUE)
//wf_setMenu('R',TRUE)
//wf_setMenu('D',TRUE)
//wf_setMenu('U',TRUE)
//wf_setMenu('P',TRUE)


/*************	 신청번호 초기화	*******************/   
/*2004-02-06*/
//ls_id	=	gs_empcode													
//SELECT	 NVL(MAX(GIAN_NUM),0) +1
//INTO		 :ll_gian_num
//FROM		 STDB.HST105H	
//WHERE		 WORKER	=	:ls_id;
/*2004-02-06*/

//tab_sheet.tabpage_sheet01.sle_1.text = (string(ll_gian_num))
//////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건(dw_head) dddw 초기화
//////////////////////////////////////////////////////////////////////////////////////
if gs_empcode = 'F0009'or gs_empcode = 'F0044'or gs_empcode = 'F0057' or gs_empcode = 'admin' then
  	tab_sheet.tabpage_sheet01.dw_head.object.c_dept_code.Background.mode = 0
	tab_sheet.tabpage_sheet01.dw_head.enabled = true
else 
	tab_sheet.tabpage_sheet01.dw_head.object.c_dept_code.Background.mode = 1
	tab_sheet.tabpage_sheet01.dw_head.object.c_dept_code.protect = 1
end if
//소모품신청서 부서 권한
if gs_empcode = 'F0009'or gs_empcode = 'F0044'or gs_empcode = 'F0057'  or gs_empcode = 'admin'  then
  	tab_sheet.tabpage_2.dw_gwa.object.code.Background.mode = 0
	tab_sheet.tabpage_2.dw_gwa.enabled = true
else 
	tab_sheet.tabpage_2.dw_gwa.object.code.Background.mode = 1
	tab_sheet.tabpage_2.dw_gwa.enabled = false
end if

idw_sname = tab_sheet.tabpage_sheet01.dw_head

idw_sname.reset()
idw_sname.insertrow(0)

idw_sname.object.c_apply_date_f[1] = left(f_today(),6) + '01'
idw_sname.object.c_apply_date_t[1] = f_today()
//////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건(dw_head) dddw 초기화  tab_sheet.tabpage_sheet01.dw_head
//////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
tab_sheet.tabpage_sheet01.dw_head.GetChild('c_ord_class',ldwc_Temp)

ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve("ord_class") = 0 THEN
	wf_setmsg('공통코드[물품상태]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF

tab_sheet.tabpage_sheet01.dw_head.object.c_dept_code[1]	=	gs_DeptCode
tab_sheet.tabpage_1.dw_search.object.code[1]	=	gs_DeptCode
tab_sheet.tabpage_2.dw_gwa.object.code[1]	=	gs_DeptCode

idw_name = tab_sheet.tabpage_sheet01.dw_update

f_childretrieve(idw_name,"ord_class","ord_class")         // 물품상태(저장) 
f_childretrieve(idw_name,"sub_opt","sub_opt")	   		//대체구분

tab_sheet.tabpage_1.dw_search.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('공통코드[부서]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
else
END IF
tab_sheet.tabpage_1.dw_search.InsertRow(0)
tab_sheet.tabpage_1.dw_search.Object.code.dddw.PercentWidth = 100
tab_sheet.tabpage_1.dw_search.settransobject(sqlca)

//소모품출력 부서 조회
tab_sheet.tabpage_2.dw_gwa.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
	ldwc_Temp.SetSort('gwa ASC')
	ldwc_Temp.Sort()
END IF
tab_sheet.tabpage_2.dw_gwa.InsertRow(0)
tab_sheet.tabpage_2.dw_gwa.Object.code.dddw.PercentWidth = 100
tab_sheet.tabpage_2.dw_gwa.settransobject(sqlca)

////////////////////////계정코드/////////////////////////////////////////////////////////////////////////
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

tab_sheet.tabpage_sheet01.dw_head.GetChild('c_dept_code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve() = 0 THEN
	wf_setmsg('공통코드[부서]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
END IF

idw_name.reset()

DataWindowChild idwc_acct_code
tab_sheet.tabpage_sheet01.dw_update.getChild("acct_code", idwc_acct_code)
idwc_acct_code.settransobject(sqlca)
idwc_acct_code.retrieve('0000', '9999')
idwc_acct_code.insertrow(0)

DataWindowChild idwc_acct_code1
tab_sheet.tabpage_sheet01.dw_update.getChild("acct_code_1", idwc_acct_code1)
idwc_acct_code.settransobject(sqlca)
idwc_acct_code.retrieve('0000', '9999')
idwc_acct_code.insertrow(0)

tab_sheet.tabpage_1.em_fr_date.text = left(f_today(),6) + '01'
tab_sheet.tabpage_1.em_to_date.text = f_today()
tab_sheet.tabpage_1.dw_print2.object.datawindow.zoom = 100
tab_sheet.tabpage_1.dw_print2.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_sheet.tabpage_1.dw_print2


tab_sheet.tabpage_2.em_fr_dt.text = left(f_today(),6) + '01'
tab_sheet.tabpage_2.em_to_dt.text = f_today()
tab_sheet.tabpage_2.dw_1.object.datawindow.zoom = 100
tab_sheet.tabpage_2.dw_1.Object.DataWindow.Print.Preview = 'YES'

//////////////////////////////////////////////////////////////////////////////////////////
//END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;
int    li_tab, li_GIAN_NUM 
string ls_cust_no, ls_apply_date, ls_chick
long   ll_ModRow  , ll_rows, ll_i
string ls_acct_code

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1
     
		idw_name = tab_sheet.tabpage_sheet01.dw_update
		idw_name.accepttext()	  
		
		IF f_chk_modified(idw_name) = FALSE THEN RETURN -1
		
		IF idw_name.rowcount() <> 0 THEN
		
			//기안번호 SELECT...
//			ls_apply_date  = idw_name.Object.apply_date[1]	//신청일자
//			
//			SELECT	NVL(MAX(A.GIAN_NUM),0) + 1
//			INTO		:li_GIAN_NUM
//			FROM		STDB.HST105H A
//			WHERE		A.APPLY_DATE = :ls_apply_date
//			AND		A.APPLY_GWA	 = :gs_DeptCode ;
//	
//			if sqlca.sqlcode <> 0 then
//				rollback ;
//				f_setpointer('END')
//				wf_SetMsg('기안번호 생성 중 오류가 발생하였습니다.')
//				MessageBox('확인',&
//							  '기안번호 생성시 전산장애가 발생되었습니다.~r~n' + &
//							  '하단의 장애번호와 장애내역을~r~n' + &
//							  '기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
//							  '장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
//							  '장애내역 : ' + SQLCA.SqlErrText)
//				RETURN -1
//			end if
//				
//			ll_rows = tab_sheet.tabpage_sheet01.dw_update.rowcount()
//			  
//			FOR ll_i = 1 TO ll_rows
//				DwItemStatus	lds_Status
//				lds_Status = idw_name.getitemstatus(ll_i,0,Primary!)
//
//				IF lds_Status = New! OR lds_Status = NewModified! THEN 
//					idw_name.object.GIAN_NUM[ll_i] = li_GIAN_NUM
//					li_GIAN_NUM ++
//				END IF
//			NEXT
////			MessageBox('',li_GIAN_NUM)
			
			idw_name.accepttext()
		
			ls_chick = idw_name.object.goods_kind[idw_name.getrow()]
			
			IF  ls_chick = '3' THEN
			
				string ls_colarry2[] = {'apply_gwa/신청부서','apply_date/신청일자', 'item_no/품목코드','acct_code/계정코드'}
				IF f_chk_null( idw_name, ls_colarry2 ) = 1 THEN 
			
					ll_ModRow = idw_name.GetNextModified(0, Primary!)
					
					Do While ll_ModRow > 0 
						idw_name.object.job_uid[ll_ModRow] = gs_empcode		//수정자
						idw_name.object.job_date[ll_ModRow] = f_sysdate()           // 오늘 일자 
						idw_name.object.job_add[ll_ModRow] = gs_ip  //IP
						
						ll_ModRow = idw_name.GetNextModified(ll_ModRow, Primary!)
					Loop
					 					 
					IF f_update( idw_name,'U') = TRUE THEN wf_setmsg("저장되었습니다")
			
				END IF	
			ELSE
				
				string ls_colarry[]
			  ls_acct_code = idw_name.Object.acct_code[idw_name.getrow()]
			  
			  if ls_acct_code ='131401'or ls_acct_code ='131402'or ls_acct_code ='131403'or ls_acct_code ='131404'or + &
				  ls_acct_code ='131405'or ls_acct_code ='131406'or ls_acct_code ='131407'or ls_acct_code ='131501'or + &
				  ls_acct_code ='131502'or ls_acct_code ='131503'or ls_acct_code ='131504'or ls_acct_code ='131505'or + &
				  ls_acct_code ='131506'or ls_acct_code ='131507' then
				  
				ls_colarry[] = {'apply_gwa/신청부서','apply_date/신청일자', 'goods_kind/비품구분','item_no/품목코드','accept_gwa/예산 통제 부서', + &
											 'acct_code/계정코드','item_name/품목명','room_code/호실코드', 'apply_price/예상단가', 'sub_opt/신규대체'}
			  else
				ls_colarry[] = {'apply_gwa/신청부서','apply_date/신청일자', 'goods_kind/비품구분','item_no/품목코드','accept_gwa/예산 통제 부서', + &
											  'acct_code/계정코드','item_name/품목명','room_code/호실코드', 'apply_price/예상단가'}
			  end if

//2007.03.10
//				string ls_colarry[] = {'apply_gwa/신청부서','apply_date/신청일자', 'goods_kind/비품구분','item_no/품목코드','accept_gwa/예산 통제 부서', + &
//											 'acct_code/계정코드','item_name/품목명','room_code/호실코드', 'apply_price/예상단가','sub_opt/신규/대체'}
				
				IF f_chk_null( idw_name, ls_colarry ) = 1 THEN
				
					ll_ModRow = idw_name.GetNextModified(0, Primary!)
					
					Do While ll_ModRow > 0 
						idw_name.object.job_uid[ll_ModRow] = gs_empcode		//수정자
						idw_name.object.job_date[ll_ModRow] = f_sysdate()           // 오늘 일자 
						idw_name.object.job_add[ll_ModRow] = gs_ip  //IP
						
						ll_ModRow = idw_name.GetNextModified(ll_ModRow, Primary!)
					Loop
					IF f_update( idw_name,'U') = TRUE THEN wf_setmsg("저장되었습니다")
				
				END IF
			END IF
		END IF
  
END CHOOSE

end event

event ue_delete;call super::ue_delete;
long     ll_row, li_row
boolean	del_boolean
string   ls_Msg,  ls_apply_gwa, ls_item_date
Integer	li_Rtn,li_gian_num



ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

	   idw_name = tab_sheet.tabpage_sheet01.dw_update
		idw_name.accepttext()
		
		li_row = idw_name.getrow()
		
		IF	idw_name.ROWCOUNT() < 1	THEN RETURN
			ls_Msg = '자료를 삭제하시겠습니까?~r~n~r~n'+&
						'삭제시 모든자료가 삭제됩니다.'
			li_Rtn = MessageBox('확인',ls_Msg,Question!,YesNo!,2)

			if li_Rtn = 2 then return
		
		FOR	ll_row = idw_name.ROWCOUNT()  TO	1 STEP -1
			IF ll_row <> 0 THEN
				STRING	L_STATUS
				l_status = idw_name.object.del_chk[ll_row]
				IF		L_STATUS	=	'1'	THEN
				del_boolean		=	true
			
			li_gian_num = idw_name.object.gian_num[ll_row]
			ls_apply_gwa = idw_name.object.apply_gwa[ll_row]
			ls_item_date = idw_name.object.apply_date[ll_row]
			
			  DELETE FROM STDB.HST105M
			  WHERE item_gian_no = :li_gian_num
			  AND   trim(gwa) 	 = trim(:ls_apply_gwa)
			  and	  item_date		 = :ls_item_date;    // 소모품 105m 테이블을 DELETE한다
			  commit;
					idw_name.deleterow(ll_row)
				END IF
			END IF
		NEXT
		
		IF		DEL_BOOLEAN		THEN
			
				IF 	f_update( idw_name,'D') = TRUE THEN wf_setmsg("삭제되었습니다")
				 
		END IF 
END CHOOSE		

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

type ln_templeft from w_tabsheet`ln_templeft within w_hgm201i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hgm201i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hgm201i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hgm201i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hgm201i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hgm201i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hgm201i
end type

type uc_insert from w_tabsheet`uc_insert within w_hgm201i
end type

type uc_delete from w_tabsheet`uc_delete within w_hgm201i
end type

type uc_save from w_tabsheet`uc_save within w_hgm201i
end type

type uc_excel from w_tabsheet`uc_excel within w_hgm201i
end type

type uc_print from w_tabsheet`uc_print within w_hgm201i
end type

type st_line1 from w_tabsheet`st_line1 within w_hgm201i
end type

type st_line2 from w_tabsheet`st_line2 within w_hgm201i
end type

type st_line3 from w_tabsheet`st_line3 within w_hgm201i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hgm201i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hgm201i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hgm201i
integer y = 152
integer width = 4384
integer height = 2136
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event tab_sheet::selectionchanged;call super::selectionchanged;

CHOOSE CASE newindex
	CASE 1,2
		idw_print =  tab_sheet.tabpage_1.dw_print2
	CASE 3
		idw_print =  tab_sheet.tabpage_2.dw_1
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
integer height = 2016
long backcolor = 1073741824
string text = "물품 신청"
gb_4 gb_4
gb_1 gb_1
dw_head dw_head
gb_2 gb_2
dw_update dw_update
cb_1 cb_1
end type

on tabpage_sheet01.create
this.gb_4=create gb_4
this.gb_1=create gb_1
this.dw_head=create dw_head
this.gb_2=create gb_2
this.dw_update=create dw_update
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_head
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.dw_update
this.Control[iCurrent+6]=this.cb_1
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.dw_head)
destroy(this.gb_2)
destroy(this.dw_update)
destroy(this.cb_1)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 3351
integer y = 448
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
boolean visible = false
integer y = 1428
integer height = 404
end type

type uo_tab from w_tabsheet`uo_tab within w_hgm201i
integer x = 1166
integer y = 148
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hgm201i
boolean visible = false
end type

type st_con from w_tabsheet`st_con within w_hgm201i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type gb_4 from groupbox within tabpage_sheet01
integer x = 3442
integer y = 40
integer width = 891
integer height = 288
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "소모품입력"
end type

type gb_1 from groupbox within tabpage_sheet01
integer x = 23
integer y = 40
integer width = 3401
integer height = 288
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회조건"
end type

type dw_head from datawindow within tabpage_sheet01
event ue_keydown pbm_dwnkey
integer x = 37
integer y = 108
integer width = 3031
integer height = 212
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm201i_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
IF key = keyenter! THEN wf_retrieve()
end event

event constructor;//f_pro_toggle('k',handle(parent))
end event

type gb_2 from groupbox within tabpage_sheet01
integer x = 23
integer y = 352
integer width = 4325
integer height = 1664
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "물품 신청 내역"
end type

type dw_update from cuo_dwwindow within tabpage_sheet01
event ue_keydown pbm_dwnkey
integer x = 55
integer y = 412
integer width = 4270
integer height = 1584
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hgm201i_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event key_enter;call super::key_enter;
long ll_getrow
string ls_item_middle, ls_item_no, ls_room_code, ls_apply_member_no

this.accepttext()

//IF key = keyenter! THEN
	
	ll_getrow = this.getrow()

   IF this.getcolumnname() = 'item_no' THEN                         // 품목코드 
	
	   ls_item_no = this.object.item_no[ll_getrow]
	
		openwithparm(w_hgm001h,ls_item_no)
				
		IF message.stringparm <> '' THEN
		   
			this.object.item_middle[ll_getrow] = gstru_uid_uname.s_parm[3]
			this.object.midd_name[ll_getrow] = gstru_uid_uname.s_parm[4]
			this.object.item_no[ll_getrow] = gstru_uid_uname.s_parm[1]
			this.object.item_name[ll_getrow] = gstru_uid_uname.s_parm[2]
			this.object.item_stand_size[ll_getrow] = gstru_uid_uname.s_parm[6]
			this.object.model[ll_getrow] = gstru_uid_uname.s_parm[7]
		
		END IF
	
   END IF
	
	
//////////////////////////////////////////////////////////////////////////////////////

	  IF this.getcolumnname() = 'room_code' THEN                       // 호실 코드 
	 
	   ls_room_code = this.object.room_code[ll_getrow]
	
	   openwithparm(w_hgm100h,ls_room_code)
	   	
	   IF message.stringparm <> '' THEN
	
			this.object.room_code[ll_getrow] = gstru_uid_uname.s_parm[1]
			this.object.room_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
      END IF
	
   END IF   
//////////////////////////////////////////////////////////////////////////////////////
//     String  ls_acct_code, ls_goods_kind
//	  ls_goods_kind = tab_sheet.tabpage_sheet01.dw_update.object.acct_code[tab_sheet.tabpage_sheet01.dw_update.getRow()]
//	  IF ls_goods_kind = '1' THEN
//	     IF this.getcolumnname() = 'acct_code' THEN                       //계정 코드 
//	       ls_acct_code = this.object.acct_code[ll_getrow]
//	   
//	       openwithparm(w_hgm300h,ls_acct_code)
//	  
//	        IF message.stringparm <> '' THEN
//			    this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
//			    this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
//	
//           END IF
//	
//       END IF  
//	  ELSE 
//		 IF this.getcolumnname() = 'acct_code' THEN                       //계정 코드 
//	       ls_acct_code = this.object.acct_code[ll_getrow]
//	   
//	       openwithparm(w_hgm400h,ls_acct_code)
//	  
//	        IF message.stringparm <> '' THEN
//			    this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
//			    this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
//	
//           END IF
//	
//       END IF  
//     END IF
end event

event clicked;call super::clicked;string ls_acct_code

IF dwo.name = 'sub_opt' THEN
	ls_acct_code = this.Object.acct_code[row]
	
	if ls_acct_code ='131401'or ls_acct_code ='131402'or ls_acct_code ='131403'or ls_acct_code ='131404'or &
	   ls_acct_code ='131405'or ls_acct_code ='131406'or ls_acct_code ='131407'or ls_acct_code ='131501'or &
	   ls_acct_code ='131502'or ls_acct_code ='131503'or ls_acct_code ='131504'or ls_acct_code ='131505'or &
	   ls_acct_code ='131506'or ls_acct_code ='131507'  then
		
		this.object.sub_opt.protect = 0
	else
		this.object.sub_opt.protect = 1
	end if
	
END IF
end event

event dberror;call super::dberror;IF sqldbcode = 1 THEN
	messagebox("확인",'중복된 값이 있습니다.')
	setcolumn(1)
	setfocus()
END IF

RETURN 1
end event

event doubleclicked;call super::doubleclicked;
long ll_getrow
string ls_item_middle, ls_item_no, ls_room_code, ls_apply_member_no

this.accepttext()

	ll_getrow = this.getrow()

   IF dwo.name = 'item_no' THEN                         // 품목코드 
	
	   ls_item_no = this.object.item_no[ll_getrow]
	
		openwithparm(w_hgm001h,ls_item_no)
				
		IF message.stringparm <> '' THEN
		   
			this.object.item_middle[ll_getrow]		= gstru_uid_uname.s_parm[3]
			this.object.midd_name[ll_getrow]			= gstru_uid_uname.s_parm[4]
			this.object.item_no[ll_getrow]			= gstru_uid_uname.s_parm[1]
			this.object.item_name[ll_getrow]			= gstru_uid_uname.s_parm[2]
			this.object.measure[ll_getrow]			= gstru_uid_uname.s_parm[8]
//2004-02-19
//			this.object.item_stand_size[ll_getrow] = gstru_uid_uname.s_parm[6]
//			this.object.model[ll_getrow] = gstru_uid_uname.s_parm[7]
		
		END IF
	
   END IF
	
	
//////////////////////////////////////////////////////////////////////////////////////

	  IF dwo.name = 'room_code' THEN                       // 호실 코드 
	 
	   ls_room_code = this.object.room_code[ll_getrow]
	
	   openwithparm(w_hgm100h,ls_room_code)
	   	
	   IF message.stringparm <> '' THEN
	
			this.object.room_code[ll_getrow] = gstru_uid_uname.s_parm[1]
			this.object.room_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
      END IF
	
   END IF  
end event

event itemchanged;call super::itemchanged;//wf_SetMenu('SAVE',true) //정장버튼 활성황

string ls_midd_name, ls_room_name, ls_acct_code
this.accepttext()

IF dwo.name = 'item_middle' THEN                    // 품목 코드 
	
	SELECT MIDD_NAME
	INTO :ls_midd_name
	FROM STDB.HST003M
	WHERE ITEM_MIDDLE = :data   ;

	this.object.midd_name[row] = ls_midd_name
	
END IF

IF dwo.name = 'room_code' THEN                       // 호 실 
	
	SELECT ROOM_NAME
	INTO :ls_room_name
	FROM STDB.HST242M         
	WHERE RTRIM(ROOM_CODE) = :data   ;

	this.object.room_name[row] = ls_room_name
	
END IF

IF dwo.name = 'acct_code' THEN
	ls_acct_code = this.Object.acct_code[row]
	
	if ls_acct_code ='131401'or ls_acct_code ='131402'or ls_acct_code ='131403'or ls_acct_code ='131404'or &
	   ls_acct_code ='131405'or ls_acct_code ='131406'or ls_acct_code ='131407'or ls_acct_code ='131501'or &
	   ls_acct_code ='131502'or ls_acct_code ='131503'or ls_acct_code ='131504'or ls_acct_code ='131505'or &
	   ls_acct_code ='131506'or ls_acct_code ='131507'  then
		
		this.object.sub_opt.protect = 0
	else
		this.object.sub_opt.protect = 1
	end if
	
END IF

 String ls_chick
 Long   ll_apply_qty, ll_apply_price, ll_apply_amt
 
 ll_apply_qty = idw_name.object.apply_qty[this.getrow()]
 ll_apply_price = idw_name.object.apply_price[this.getrow()]
 ll_apply_amt = (ll_apply_qty * ll_apply_price)

 idw_name.object.apply_amt[this.getrow()]  = ll_apply_amt

end event

event itemerror;call super::itemerror;RETURN 1
end event

event itemfocuschanged;call super::itemfocuschanged;String ls_chick
 Long   ll_apply_qty, ll_apply_price, ll_apply_amt
 
 ll_apply_qty = idw_name.object.apply_qty[this.getrow()]
 ll_apply_price = idw_name.object.apply_price[this.getrow()]
 ll_apply_amt = (ll_apply_qty * ll_apply_price)

 idw_name.object.apply_amt[this.getrow()]  = ll_apply_amt
end event

event rowfocuschanged;call super::rowfocuschanged;STring ls_apply_date, ls_apply_gwa, ls_item_middle

//this.selectrow( 0, false )
//this.selectrow( currentrow, true )

this.accepttext()
if currentrow <= 0 then
	return	
end if	
ls_apply_date	=	this.object.apply_date[currentrow]
ls_apply_gwa	=	this.object.apply_gwa[currentrow]
ls_item_middle	=	this.object.item_middle[currentrow]


end event

event updatestart;call super::updatestart;String ls_chick
Long   ll_apply_qty, ll_apply_price, ll_apply_amt

 if this.getrow() <= 0 then
	return
 end if
 ll_apply_qty = idw_name.object.apply_qty[this.getrow()]
 ll_apply_price = idw_name.object.apply_price[this.getrow()]
 ll_apply_amt = (ll_apply_qty * ll_apply_price)

 idw_name.object.apply_amt[this.getrow()]  = ll_apply_amt



end event

event constructor;call super::constructor;this.uf_setClick(False)
end event

type cb_1 from uo_imgbtn within tabpage_sheet01
integer x = 3689
integer y = 156
integer taborder = 30
boolean bringtotop = true
string btnname = "소모품입력"
end type

event clicked;call super::clicked;s_somo		lstr_com
string rownumber
long 	ll_item_tot
long 	ll_cnt
string ls_item_gwa, ls_apply_date
integer li_gian_no


idw_name = tab_sheet.tabpage_sheet01.dw_update
idw_sname = tab_sheet.tabpage_sheet01.dw_head

rownumber = string(idw_name.getrow())

if tab_sheet.tabpage_sheet01.dw_update.rowcount() < 1 then return

lstr_com.item_gian_no = idw_name.object.gian_num[idw_name.getrow()]	//번호
lstr_com.item_gwa_name = idw_name.describe("Evaluate('LookUpDisPlay(apply_gwa)'," + string(idw_name.getrow()) + ")")	//부서/학과
lstr_com.item_gwa = idw_name.object.apply_gwa[idw_name.getrow()]	//부서/학과
lstr_com.item_date = idw_name.object.apply_date[idw_name.getrow()]	//구입일자

ls_item_gwa				= lstr_com.item_gwa		//부서/학과
li_gian_no				= lstr_com.item_gian_no	//번호
ls_apply_date 			= lstr_com.item_date		//구입일자

select count(*)  
into  :ll_cnt
from 	stdb.hst105h
where apply_gwa 	= :ls_item_gwa
and	apply_date 	= :ls_apply_date
and	gian_num 	= :li_gian_no;

IF ll_cnt <= 0 THEN
  messagebox("확인","먼저 물품신청내역을 저장하시고 소모품을 입력하시기 바랍니다..")
  RETURN
END IF

OpenWithParm(w_hgm201pp, lstr_com)


ll_item_tot = long(Message.StringParm)

idw_name.object.apply_price[idw_name.getrow()] = ll_item_tot

end event

on cb_1.destroy
call uo_imgbtn::destroy
end on

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2016
string text = "물품 신청서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print2 dw_print2
st_5 st_5
em_to_date em_to_date
st_4 st_4
sle_2 sle_2
st_3 st_3
st_2 st_2
st_1 st_1
em_fr_date em_fr_date
gb_3 gb_3
dw_acct_code dw_acct_code
dw_search dw_search
end type

on tabpage_1.create
this.dw_print2=create dw_print2
this.st_5=create st_5
this.em_to_date=create em_to_date
this.st_4=create st_4
this.sle_2=create sle_2
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.em_fr_date=create em_fr_date
this.gb_3=create gb_3
this.dw_acct_code=create dw_acct_code
this.dw_search=create dw_search
this.Control[]={this.dw_print2,&
this.st_5,&
this.em_to_date,&
this.st_4,&
this.sle_2,&
this.st_3,&
this.st_2,&
this.st_1,&
this.em_fr_date,&
this.gb_3,&
this.dw_acct_code,&
this.dw_search}
end on

on tabpage_1.destroy
destroy(this.dw_print2)
destroy(this.st_5)
destroy(this.em_to_date)
destroy(this.st_4)
destroy(this.sle_2)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fr_date)
destroy(this.gb_3)
destroy(this.dw_acct_code)
destroy(this.dw_search)
end on

type dw_print2 from datawindow within tabpage_1
integer x = 14
integer y = 220
integer width = 4329
integer height = 1780
integer taborder = 31
string title = "none"
string dataobject = "d_hgm201i_53"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type st_5 from statictext within tabpage_1
integer x = 2350
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
string text = "계정과목"
boolean focusrectangle = false
end type

type em_to_date from editmask within tabpage_1
integer x = 1893
integer y = 76
integer width = 389
integer height = 92
integer taborder = 80
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

type st_4 from statictext within tabpage_1
integer x = 1829
integer y = 76
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

type sle_2 from singlelineedit within tabpage_1
integer x = 3515
integer y = 76
integer width = 201
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_1
integer x = 3264
integer y = 100
integer width = 306
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

type st_2 from statictext within tabpage_1
integer x = 1170
integer y = 100
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

type st_1 from statictext within tabpage_1
integer x = 91
integer y = 100
integer width = 320
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "요구부서명"
boolean focusrectangle = false
end type

type em_fr_date from editmask within tabpage_1
integer x = 1435
integer y = 76
integer width = 389
integer height = 92
integer taborder = 80
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

type gb_3 from groupbox within tabpage_1
integer x = 14
integer y = 16
integer width = 4329
integer height = 184
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type dw_acct_code from datawindow within tabpage_1
integer x = 2610
integer y = 76
integer width = 603
integer height = 96
integer taborder = 80
boolean bringtotop = true
string dataobject = "ddw_acct_code_hgm"
boolean border = false
boolean livescroll = true
end type

type dw_search from datawindow within tabpage_1
integer x = 411
integer y = 80
integer width = 699
integer height = 92
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm201i_6"
boolean border = false
boolean livescroll = true
end type

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4347
integer height = 2016
string text = "소모품신청서"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_11 st_11
st_10 st_10
st_9 st_9
em_to_dt em_to_dt
em_fr_dt em_fr_dt
st_8 st_8
st_7 st_7
sle_gian_no sle_gian_no
st_6 st_6
dw_1 dw_1
gb_6 gb_6
dw_gwa dw_gwa
end type

on tabpage_2.create
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.em_to_dt=create em_to_dt
this.em_fr_dt=create em_fr_dt
this.st_8=create st_8
this.st_7=create st_7
this.sle_gian_no=create sle_gian_no
this.st_6=create st_6
this.dw_1=create dw_1
this.gb_6=create gb_6
this.dw_gwa=create dw_gwa
this.Control[]={this.st_11,&
this.st_10,&
this.st_9,&
this.em_to_dt,&
this.em_fr_dt,&
this.st_8,&
this.st_7,&
this.sle_gian_no,&
this.st_6,&
this.dw_1,&
this.gb_6,&
this.dw_gwa}
end on

on tabpage_2.destroy
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.em_to_dt)
destroy(this.em_fr_dt)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.sle_gian_no)
destroy(this.st_6)
destroy(this.dw_1)
destroy(this.gb_6)
destroy(this.dw_gwa)
end on

type st_11 from statictext within tabpage_2
integer x = 3269
integer y = 132
integer width = 457
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
string text = "입력 하세요"
long bordercolor = 255
boolean focusrectangle = false
end type

type st_10 from statictext within tabpage_2
integer x = 3269
integer y = 56
integer width = 485
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
string text = "구매번호를 반드시"
long bordercolor = 255
boolean focusrectangle = false
end type

type st_9 from statictext within tabpage_2
integer x = 1957
integer y = 100
integer width = 69
integer height = 52
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

type em_to_dt from editmask within tabpage_2
integer x = 2039
integer y = 76
integer width = 457
integer height = 92
integer taborder = 70
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

type em_fr_dt from editmask within tabpage_2
integer x = 1463
integer y = 76
integer width = 457
integer height = 92
integer taborder = 31
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

type st_8 from statictext within tabpage_2
integer x = 1152
integer y = 92
integer width = 288
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "요구일자"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_2
integer x = 2542
integer y = 92
integer width = 270
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "구매번호"
boolean focusrectangle = false
end type

type sle_gian_no from singlelineedit within tabpage_2
integer x = 2839
integer y = 68
integer width = 325
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within tabpage_2
integer x = 78
integer y = 92
integer width = 274
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "요구부서"
boolean focusrectangle = false
end type

type dw_1 from datawindow within tabpage_2
integer y = 240
integer width = 4329
integer height = 1776
integer taborder = 21
string title = "none"
string dataobject = "d_hgm201p_2"
boolean vscrollbar = true
boolean border = false
end type

type gb_6 from groupbox within tabpage_2
integer y = 20
integer width = 4352
integer height = 188
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

type dw_gwa from datawindow within tabpage_2
integer x = 338
integer y = 80
integer width = 773
integer height = 88
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dddw_gwa_code"
boolean border = false
boolean livescroll = true
end type

type gb_5 from groupbox within w_hgm201i
boolean visible = false
integer x = 3145
integer y = 40
integer width = 626
integer height = 288
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "신청번호"
end type

