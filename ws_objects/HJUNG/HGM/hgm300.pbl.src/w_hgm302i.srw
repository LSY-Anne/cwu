$PBExportHeader$w_hgm302i.srw
$PBExportComments$비품수리신청접수
forward
global type w_hgm302i from w_tabsheet
end type
type gb_2 from groupbox within tabpage_sheet01
end type
type dw_list_back from cuo_dwwindow_one_hin within tabpage_sheet01
end type
type sle_accept_num from singlelineedit within tabpage_sheet01
end type
type rb_1 from radiobutton within tabpage_sheet01
end type
type rb_2 from radiobutton within tabpage_sheet01
end type
type gb_1 from groupbox within tabpage_sheet01
end type
type dw_search1 from datawindow within tabpage_sheet01
end type
type tabpage_1 from userobject within tab_sheet
end type
type dw_list1 from uo_dwgrid within tabpage_1
end type
type rb_4 from radiobutton within tabpage_1
end type
type rb_3 from radiobutton within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type gb_7 from groupbox within tabpage_1
end type
type dw_search2 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_sheet
dw_list1 dw_list1
rb_4 rb_4
rb_3 rb_3
gb_4 gb_4
gb_7 gb_7
dw_search2 dw_search2
end type
type tabpage_2 from userobject within tab_sheet
end type
type dw_print from datawindow within tabpage_2
end type
type sle_id_no from singlelineedit within tabpage_2
end type
type st_id_no from statictext within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_sheet
dw_print dw_print
sle_id_no sle_id_no
st_id_no st_id_no
gb_3 gb_3
end type
end forward

global type w_hgm302i from w_tabsheet
integer width = 4503
event key_enter pbm_dwnprocessenter
end type
global w_hgm302i w_hgm302i

type variables

int ii_tab
datawindowchild idw_child
datawindow idw_sname
end variables

on w_hgm302i.create
int iCurrent
call super::create
end on

on w_hgm302i.destroy
call super::destroy
end on

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
//// 3. 메뉴버튼 활성화/비활성화처리, 포커스이동
/////////////////////////////////////////////////////////////////////////////////////////
//wf_setMenu('I',FALSE)	//입력버튼
//wf_setMenu('R',TRUE)		//조회버튼
//wf_Setmenu('D',FALSE)	//삭제버튼
//wf_Setmenu('S',FALSE)	//저장버튼
//wf_Setmenu('P',FALSE)	//인쇄버튼


tab_sheet.tabpage_sheet01.dw_search1.Reset()
tab_sheet.tabpage_sheet01.dw_search1.InsertRow(0)
tab_sheet.tabpage_1.dw_search2.Reset()
tab_sheet.tabpage_1.dw_search2.InsertRow(0)
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_open;call super::ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_open
////	기 능 설 명: 초기화 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
//// 1.1 등록용 - 품목구분 DDDW초기화
///////////////////////////////////////////////////////////////////////////////////
STRING	ls_req_no

 f_childretrieven(tab_sheet.tabpage_sheet01.dw_search1,"dept")	
 f_childretrieven(tab_sheet.tabpage_1.dw_search2,"dept")	
//********************** 접수번호 초기화	************************//
//f_childretrieve(idw_sname,"c_ord_class","ord_class")         // 물품상태(조회조건)

DataWindowChild	ldwc_Temp
tab_sheet.tabpage_sheet01.dw_search1.GetChild('c_ord_class',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve("ord_class") = 0 THEN
	wf_setmsg('공통코드[물품상태]를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	long ll_InsRow
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code','0')
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF

											// 접수번호 	초기화
SELECT	TO_char(SYSDATE,'YYYYMM')||trim(to_char(nvl(substr(max(REQ_NO),7,4)+1,'0001'),'0000'))
INTO		:ls_req_no
FROM		STDB.HST030H
WHERE 	REQ_NO LIKE	TO_char(SYSDATE,'YYYYMM') ||'%' ;

tab_sheet.tabpage_sheet01.sle_accept_num.text = ls_req_no

DataWindow  dw_sname
dw_sname = tab_sheet.tabpage_2.dw_print
f_childretrieve(dw_sname,"hst027m_item_class","item_class")		//물품구분

tab_sheet.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print =  tab_sheet.tabpage_2.dw_print
/////////////////////////////////////////////////////////////////////////////////////////
//// 2.  초기화 이벤트 호출
/////////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: clicked;;cb_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
///////////////////////////////////////////////////////////////////////////////////////

long ll_row

//f_setpointer('START')

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 1

        tab_sheet.tabpage_sheet01.dw_search1.accepttext()

        String	ls_GwaNm		//사용부서명
        ls_GwaNm = TRIM(tab_sheet.tabpage_sheet01.dw_search1.object.dept[1])
        IF isNull(ls_GwaNm) OR LEN(ls_GwaNm) = 0 THEN ls_GwaNm = '%'

        String	ls_RoomNm	//사용장소명
        ls_RoomNm = TRIM(tab_sheet.tabpage_sheet01.dw_search1.object.room[1])
        IF isNull(ls_RoomNm) OR LEN(ls_RoomNm) = 0 THEN ls_RoomNm = '%'

        String	ls_ItemNm	//품목명
        ls_ItemNm = TRIM(tab_sheet.tabpage_sheet01.dw_search1.object.item[1])
        IF isNull(ls_ItemNm) OR LEN(ls_ItemNm) = 0 THEN ls_ItemNm = '%'

        Long	ll_ord_class //물품상태
        ll_ord_class = tab_sheet.tabpage_sheet01.dw_search1.object.c_ord_class[1]
   

        SetPointer(HourGlass!)
        /////////////////////////////////////////////////////////////////////////////////////
        // 2. 자료조회
        /////////////////////////////////////////////////////////////////////////////////////

        STring	ls_req_no
					// 접수번호 	초기화
        SELECT	TO_char(SYSDATE,'YYYY')||trim(to_char(nvl(substr(max(REQ_NO),5,4)+1,'0001'),'0000'))
        INTO		:ls_req_no
        FROM		STDB.HST030H
        WHERE 	REQ_NO LIKE	TO_char(SYSDATE,'YYYY') ||'%' ;

        tab_sheet.tabpage_sheet01.sle_accept_num.text = ls_req_no

        wf_SetMsg('조회 처리 중입니다...')
        Long		ll_RowCnt
        tab_sheet.tabpage_sheet01.dw_update_tab.SetReDraw(FALSE)
        ll_RowCnt = tab_sheet.tabpage_sheet01.dw_update_tab.Retrieve(ls_GwaNm,ls_RoomNm,ls_ItemNm,ll_ord_class )
        tab_sheet.tabpage_sheet01.dw_update_tab.SetReDraw(TRUE)

        /////////////////////////////////////////////////////////////////////////////////////
        // 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
        /////////////////////////////////////////////////////////////////////////////////////
        IF ll_RowCnt = 0 THEN 
//           wf_SetMenu('I',FALSE)
//	        wf_SetMenu('D',FALSE)
//	        wf_SetMenu('S',FALSE)
//	        wf_SetMenu('R',TRUE)
//	        f_dis_msg(3,'비품수리신청 자료가 존재하지 않습니다.~r~n' + &
//					        '비품수리신청 후 사용하시기 바랍니다.','')
        ELSE
//           wf_SetMenu('I',FALSE)
//	        wf_SetMenu('D',TRUE)
//	        wf_SetMenu('S',TRUE)
//	        wf_SetMenu('R',TRUE)
         	wf_SetMsg('자료가 조회되었습니다.')
        END IF

CASE	2
	
     tab_sheet.tabpage_1.dw_search2.accepttext()


     ls_GwaNm = TRIM(tab_sheet.tabpage_1.dw_search2.object.dept[1])
     IF isNull(ls_GwaNm) OR LEN(ls_GwaNm) = 0 THEN ls_GwaNm = '%'


     ls_RoomNm = TRIM(tab_sheet.tabpage_1.dw_search2.object.room[1])
     IF isNull(ls_RoomNm) OR LEN(ls_RoomNm) = 0 THEN ls_RoomNm = '%'


     ls_ItemNm = TRIM(tab_sheet.tabpage_1.dw_search2.object.item[1])
     IF isNull(ls_ItemNm) OR LEN(ls_ItemNm) = 0 THEN ls_ItemNm = '%'


      SetPointer(HourGlass!)
     /////////////////////////////////////////////////////////////////////////////////////
     // 2. 자료조회
     /////////////////////////////////////////////////////////////////////////////////////
     wf_SetMsg('조회 처리 중입니다...')

     tab_sheet.tabpage_1.dw_list1.SetReDraw(FALSE)
     ll_RowCnt = tab_sheet.tabpage_1.dw_list1.Retrieve(ls_GwaNm,ls_RoomNm,ls_ItemNm)
     tab_sheet.tabpage_1.dw_list1.SetReDraw(TRUE)

     /////////////////////////////////////////////////////////////////////////////////////
     // 3. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
     /////////////////////////////////////////////////////////////////////////////////////
     IF ll_RowCnt = 0 THEN 
//     	  wf_SetMenu('I',FALSE)
//	     wf_SetMenu('D',FALSE)
//	     wf_SetMenu('S',FALSE)
//	     wf_SetMenu('R',TRUE)
//	     f_dis_msg(3,'비품수리신청 자료가 존재하지 않습니다.~r~n' + &
//					     '비품수리신청 후 사용하시기 바랍니다.','')
     ELSE
//	     wf_SetMenu('I',FALSE)
//	     wf_SetMenu('D',TRUE)
//	     wf_SetMenu('S',TRUE)
//	     wf_SetMenu('R',TRUE)
	     wf_SetMsg('자료가 조회되었습니다.')
     END IF
 CASE 3
	  String   ls_id_no
	  ls_id_no = tab_sheet.tabpage_2.sle_id_no.text
	  IF tab_sheet.tabpage_2.dw_print.Retrieve(ls_id_no) = 0 THEN
	     messagebox('확인','수리내역이 존재하지 않습니다..!')
	  ELSE
//		  wf_SetMenu('p',TRUE)
	     wf_SetMsg('자료가 조회되었습니다.')
	  END IF
END CHOOSE
return 1
////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;
long ll_row, i, ll_seq, ll_seq_no, ll_req_no
string ls_req_no

ii_tab = tab_sheet.selectedtab
ls_req_no	=	tab_sheet.tabpage_sheet01.sle_accept_num.text
CHOOSE CASE ii_tab
	CASE 1
	  IF f_chk_modified(tab_sheet.tabpage_sheet01.dw_update_tab) = FALSE THEN RETURN -1

	  tab_sheet.tabpage_sheet01.dw_update_tab.accepttext()	  

	  ll_row = tab_sheet.tabpage_sheet01.dw_update_tab.rowcount()

	  IF tab_sheet.tabpage_sheet01.dw_update_tab.rowcount() <> 0 THEN

		  FOR i = 1 TO ll_row
//--- 물품 상태가 '접수' 이고 발주(견적) 번호가 '0000000000'인것 			 
			   IF tab_sheet.tabpage_sheet01.dw_update_tab.object.stat_class[i] = 2  THEN  
			       SELECT	TO_char(SYSDATE,'YYYYMM')||trim(to_char(nvl(substr(max(REQ_NO),7,4)+1,'0001'),'0000'))
                INTO		:ll_req_no
                FROM		STDB.HST030H
					 WHERE 	REQ_NO LIKE	TO_char(SYSDATE,'YYYYMM') ||'%';

//			      IF ISNULL(tab_sheet.tabpage_sheet01.dw_update_tab.object.acct_code[i]) THEN
//						messagebox("확인","계정과목을 입력하세요")
//					   tab_sheet.tabpage_sheet01.dw_update_tab.setfocus()
//						tab_sheet.tabpage_sheet01.dw_update_tab.setcolumn("acct_code")
//						RETURN
//					END IF

					tab_sheet.tabpage_sheet01.dw_update_tab.object.REQ_NO[i] 	= string(ll_req_no)		    //접수번호
					tab_sheet.tabpage_sheet01.dw_update_tab.object.item_seq[i] 	= i		                   //품목번호					
					tab_sheet.tabpage_sheet01.dw_update_tab.object.job_uid[i] 	= gs_empcode		 //수정자
		  			tab_sheet.tabpage_sheet01.dw_update_tab.object.job_date[i] 	= f_sysdate()             	 // 오늘 일자 
		  			tab_sheet.tabpage_sheet01.dw_update_tab.object.job_add[i] 	= gs_ip   //IP
			   END IF
	     NEXT

		  IF f_update( tab_sheet.tabpage_sheet01.dw_update_tab,'U') = TRUE THEN
			  wf_setmsg("저장되었습니다")
			  THIS.TRIGGER EVENT ue_retrieve()
		  END IF
	  END IF

   CASE 2

     ll_row = tab_sheet.tabpage_1.dw_list1.rowcount()

	  FOR i = 1 TO ll_row
			 tab_sheet.tabpage_1.dw_list1.object.req_no[i] 		= ''								//접수번호
	       tab_sheet.tabpage_1.dw_list1.object.item_seq[i] 	= 0								//품목번호
			 tab_sheet.tabpage_1.dw_list1.object.job_uid[i] 	= gs_empcode		//수정자
			 tab_sheet.tabpage_1.dw_list1.object.job_date[i] 	= f_sysdate()             //오늘 일자 
			 tab_sheet.tabpage_1.dw_list1.object.job_add[i] 	= gs_ip  //IP
	  NEXT

	  IF f_chk_modified(tab_sheet.tabpage_1.dw_list1) = FALSE THEN RETURN -1

	  IF f_update( tab_sheet.tabpage_1.dw_list1,'U') = TRUE THEN
		  wf_setmsg("저장되었습니다")
		  THIS.TRIGGER EVENT ue_retrieve()
END IF
END CHOOSE



end event

event ue_print;call super::ue_print;//f_print(tab_sheet.tabpage_2.dw_print)
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

type ln_templeft from w_tabsheet`ln_templeft within w_hgm302i
end type

type ln_tempright from w_tabsheet`ln_tempright within w_hgm302i
end type

type ln_temptop from w_tabsheet`ln_temptop within w_hgm302i
end type

type ln_tempbuttom from w_tabsheet`ln_tempbuttom within w_hgm302i
end type

type ln_tempbutton from w_tabsheet`ln_tempbutton within w_hgm302i
end type

type ln_tempstart from w_tabsheet`ln_tempstart within w_hgm302i
end type

type uc_retrieve from w_tabsheet`uc_retrieve within w_hgm302i
end type

type uc_insert from w_tabsheet`uc_insert within w_hgm302i
end type

type uc_delete from w_tabsheet`uc_delete within w_hgm302i
end type

type uc_save from w_tabsheet`uc_save within w_hgm302i
end type

type uc_excel from w_tabsheet`uc_excel within w_hgm302i
end type

type uc_print from w_tabsheet`uc_print within w_hgm302i
end type

type st_line1 from w_tabsheet`st_line1 within w_hgm302i
end type

type st_line2 from w_tabsheet`st_line2 within w_hgm302i
end type

type st_line3 from w_tabsheet`st_line3 within w_hgm302i
end type

type uc_excelroad from w_tabsheet`uc_excelroad within w_hgm302i
end type

type ln_dwcon from w_tabsheet`ln_dwcon within w_hgm302i
end type

type tab_sheet from w_tabsheet`tab_sheet within w_hgm302i
integer x = 55
integer y = 184
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
integer y = 104
integer height = 1992
long backcolor = 1073741824
string text = "비품수리접수"
gb_2 gb_2
dw_list_back dw_list_back
sle_accept_num sle_accept_num
rb_1 rb_1
rb_2 rb_2
gb_1 gb_1
dw_search1 dw_search1
end type

on tabpage_sheet01.create
this.gb_2=create gb_2
this.dw_list_back=create dw_list_back
this.sle_accept_num=create sle_accept_num
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1=create gb_1
this.dw_search1=create dw_search1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_list_back
this.Control[iCurrent+3]=this.sle_accept_num
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.dw_search1
end on

on tabpage_sheet01.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.dw_list_back)
destroy(this.sle_accept_num)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.dw_search1)
end on

type dw_list001 from w_tabsheet`dw_list001 within tabpage_sheet01
boolean visible = false
integer x = 14
integer y = 284
integer width = 3840
integer height = 2068
end type

type dw_update_tab from w_tabsheet`dw_update_tab within tabpage_sheet01
event dwn_key pbm_dwnkey
event key_down pbm_dwnprocessenter
event key_enter pbm_dwnprocessenter
integer x = 9
integer y = 272
integer width = 4334
integer height = 1712
string dataobject = "d_hgm302i_2"
end type

event dw_update_tab::dwn_key;
long ll_getrow
string ls_acct_code

this.accepttext()	
	
ll_getrow = this.getrow()

if	key = keyenter!	then

IF this.getcolumnname() = 'acct_code' THEN                         // 계정과목 

	ls_acct_code = ' '
	
	openwithparm(w_hgm300h,ls_acct_code)
			
	IF message.stringparm <> '' THEN
	
		this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
//		this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
	END IF

END IF
end if
end event

event dw_update_tab::key_down;
long ll_getrow
string ls_acct_code

this.accepttext()	
	
ll_getrow = this.getrow()

IF this.getcolumnname() = 'acct_code' THEN                         // 계정과목 

	ls_acct_code = ' '
	
	openwithparm(w_hgm300h,ls_acct_code)
			
	IF message.stringparm <> '' THEN
	
		this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
	END IF

END IF
end event

event dw_update_tab::key_enter;
long ll_getrow
string ls_acct_code

this.accepttext()	
	
ll_getrow = this.getrow()

IF this.getcolumnname() = 'acct_code' THEN                         // 계정과목 

	ls_acct_code = ' '
	
	openwithparm(w_hgm300h,ls_acct_code)
			
	IF message.stringparm <> '' THEN
	
		this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]
	
	END IF

END IF
end event

type uo_tab from w_tabsheet`uo_tab within w_hgm302i
integer y = 204
long backcolor = 1073741824
end type

type dw_con from w_tabsheet`dw_con within w_hgm302i
boolean visible = false
integer height = 76
end type

type st_con from w_tabsheet`st_con within w_hgm302i
boolean visible = false
integer x = 46
end type

type gb_2 from groupbox within tabpage_sheet01
integer x = 3534
integer y = 20
integer width = 805
integer height = 176
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "접수번호"
end type

type dw_list_back from cuo_dwwindow_one_hin within tabpage_sheet01
event key_enter pbm_dwnprocessenter
event dwn_key pbm_dwnkey
event key_down pbm_dwnprocessenter
boolean visible = false
integer x = 9
integer y = 272
integer width = 101
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hgm302i_2"
boolean hsplitscroll = true
end type

event key_enter;
long ll_getrow
string ls_acct_code

this.accepttext()	
	
ll_getrow = this.getrow()

IF this.getcolumnname() = 'acct_code' THEN                         // 계정과목 

	ls_acct_code = ' '
	
	openwithparm(w_hgm300h,ls_acct_code)
			
	IF message.stringparm <> '' THEN
	
		this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]
	
	END IF

END IF
end event

event dwn_key;
long ll_getrow
string ls_acct_code

this.accepttext()	
	
ll_getrow = this.getrow()

if	key = keyenter!	then

IF this.getcolumnname() = 'acct_code' THEN                         // 계정과목 

	ls_acct_code = ' '
	
	openwithparm(w_hgm300h,ls_acct_code)
			
	IF message.stringparm <> '' THEN
	
		this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
//		this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
	END IF

END IF
end if
end event

event key_down;
long ll_getrow
string ls_acct_code

this.accepttext()	
	
ll_getrow = this.getrow()

IF this.getcolumnname() = 'acct_code' THEN                         // 계정과목 

	ls_acct_code = ' '
	
	openwithparm(w_hgm300h,ls_acct_code)
			
	IF message.stringparm <> '' THEN
	
		this.object.acct_code[ll_getrow] = gstru_uid_uname.s_parm[1]
		this.object.acct_name[ll_getrow] = gstru_uid_uname.s_parm[2]	   
	
	END IF

END IF
end event

event constructor;call super::constructor;//ib_RowSelect = TRUE
ib_RowSingle = FALSE
ib_SortGubn  = TRUE
ib_EnterChk  = FALSE
end event

type sle_accept_num from singlelineedit within tabpage_sheet01
integer x = 3602
integer y = 80
integer width = 667
integer height = 92
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

type rb_1 from radiobutton within tabpage_sheet01
integer x = 3561
integer y = 196
integer width = 379
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전체 선택"
end type

event clicked;
long ll_rowcount, i

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		ll_rowcount = tab_sheet.tabpage_sheet01.dw_update_tab.rowcount()
		FOR i = 1 TO ll_rowcount
			tab_sheet.tabpage_sheet01.dw_update_tab.object.stat_class[i] = 2		           // 주관접수로 바꾼다  		
		NEXT
END CHOOSE
end event

type rb_2 from radiobutton within tabpage_sheet01
integer x = 3945
integer y = 196
integer width = 370
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전체 취소"
end type

event clicked;
long ll_rowcount, i

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
	CASE 1
		ll_rowcount = tab_sheet.tabpage_sheet01.dw_update_tab.rowcount()
		FOR i = 1 TO ll_rowcount
			 tab_sheet.tabpage_sheet01.dw_update_tab.object.stat_class[i] = 3		           // 주관접수로 바꾼다  		
		NEXT
END CHOOSE
end event

type gb_1 from groupbox within tabpage_sheet01
integer x = 9
integer y = 20
integer width = 3515
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

type dw_search1 from datawindow within tabpage_sheet01
event dn_key pbm_dwnkey
integer x = 78
integer y = 96
integer width = 2999
integer height = 96
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm302i_3"
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
   ELSEIF THIS.GetColumnName() = 'item' THEN		// 사용장소
			ls_middle.uname = this.object.item[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

//				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
//				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
				this.object.item[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
//	   wf_retrieve()
	END IF
END IF

end event

event constructor;f_pro_toggle('k',handle(parent))
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
   ELSEIF dwo.name = 'item' THEN		// 사용장소
			ls_middle.uname = this.object.item[1]
			ls_middle.uid = "c_item_name"
			openwithparm(w_hgm001h,ls_middle)
		
			IF message.stringparm <> '' THEN

//				this.object.c_item_no[1] 	= gstru_uid_uname.s_parm[1]
//				this.object.c_item_name[1] = gstru_uid_uname.s_parm[2]	  
				this.object.item[1] = gstru_uid_uname.s_parm[2]	  
			END IF	
	ELSE
//	   wf_retrieve()
	END IF

end event

type tabpage_1 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4338
integer height = 1992
string text = "접수취소"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_list1 dw_list1
rb_4 rb_4
rb_3 rb_3
gb_4 gb_4
gb_7 gb_7
dw_search2 dw_search2
end type

on tabpage_1.create
this.dw_list1=create dw_list1
this.rb_4=create rb_4
this.rb_3=create rb_3
this.gb_4=create gb_4
this.gb_7=create gb_7
this.dw_search2=create dw_search2
this.Control[]={this.dw_list1,&
this.rb_4,&
this.rb_3,&
this.gb_4,&
this.gb_7,&
this.dw_search2}
end on

on tabpage_1.destroy
destroy(this.dw_list1)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.gb_4)
destroy(this.gb_7)
destroy(this.dw_search2)
end on

type dw_list1 from uo_dwgrid within tabpage_1
integer y = 256
integer width = 4338
integer height = 1732
integer taborder = 20
string dataobject = "D_hgm302I_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type rb_4 from radiobutton within tabpage_1
integer x = 3808
integer y = 152
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전체 취소"
end type

event clicked;
long ll_rowcount, i

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 2
 
		ll_rowcount = tab_sheet.tabpage_1.dw_list1.rowcount()
		
		FOR i = 1 TO ll_rowcount
			
//			tab_sheet.tabpage_sheet01.dw_update1.object.accept_date[i] = ''
			tab_sheet.tabpage_1.dw_list1.object.stat_class[i] = 2	           // 주관접수로 바꾼다  		
			
		NEXT
		
END CHOOSE		
		
end event

type rb_3 from radiobutton within tabpage_1
integer x = 3808
integer y = 72
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "전체 선택"
end type

event clicked;
long ll_rowcount, i

ii_tab = tab_sheet.selectedtab

CHOOSE CASE ii_tab
		
	CASE 2
 
		ll_rowcount = tab_sheet.tabpage_1.dw_list1.rowcount()
		
		FOR i = 1 TO ll_rowcount
			
//			tab_sheet.tabpage_sheet01.dw_update1.object.accept_date[i] = f_today()
			tab_sheet.tabpage_1.dw_list1.object.stat_class[i] = 3		           // 주관접수로 바꾼다  		
			
		NEXT
		
END CHOOSE		
end event

type gb_4 from groupbox within tabpage_1
integer x = 3739
integer y = 20
integer width = 599
integer height = 228
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type gb_7 from groupbox within tabpage_1
integer x = 5
integer y = 20
integer width = 3730
integer height = 228
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

type dw_search2 from datawindow within tabpage_1
event dn_key pbm_dwnkey
integer x = 325
integer y = 104
integer width = 3031
integer height = 136
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm302i_3"
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
//	   wf_retrieve()
	END IF
END IF

end event

event constructor;f_pro_toggle('k',handle(parent))
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
//	   wf_retrieve()
	END IF


end event

type tabpage_2 from userobject within tab_sheet
integer x = 18
integer y = 104
integer width = 4338
integer height = 1992
string text = "비품수리내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_print dw_print
sle_id_no sle_id_no
st_id_no st_id_no
gb_3 gb_3
end type

on tabpage_2.create
this.dw_print=create dw_print
this.sle_id_no=create sle_id_no
this.st_id_no=create st_id_no
this.gb_3=create gb_3
this.Control[]={this.dw_print,&
this.sle_id_no,&
this.st_id_no,&
this.gb_3}
end on

on tabpage_2.destroy
destroy(this.dw_print)
destroy(this.sle_id_no)
destroy(this.st_id_no)
destroy(this.gb_3)
end on

type dw_print from datawindow within tabpage_2
integer x = 9
integer y = 284
integer width = 4329
integer height = 1704
integer taborder = 21
string title = "none"
string dataobject = "d_hgm302i_5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type sle_id_no from singlelineedit within tabpage_2
integer x = 430
integer y = 112
integer width = 517
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_id_no from statictext within tabpage_2
integer x = 169
integer y = 136
integer width = 279
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

type gb_3 from groupbox within tabpage_2
integer x = 18
integer y = 20
integer width = 4320
integer height = 260
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

