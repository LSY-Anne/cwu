$PBExportHeader$w_hst102i.srw
$PBExportComments$품목코드관리
forward
global type w_hst102i from w_msheet
end type
type sle_code1 from singlelineedit within w_hst102i
end type
type st_4 from statictext within w_hst102i
end type
type sle_name2 from singlelineedit within w_hst102i
end type
type st_3 from statictext within w_hst102i
end type
type sle_name from singlelineedit within w_hst102i
end type
type st_2 from statictext within w_hst102i
end type
type sle_code from singlelineedit within w_hst102i
end type
type st_1 from statictext within w_hst102i
end type
type tab_1 from tab within w_hst102i
end type
type tabpage_1 from userobject within tab_1
end type
type dw_list from uo_dwgrid within tabpage_1
end type
type dw_list2 from uo_dwgrid within tabpage_1
end type
type dw_main from uo_dwfree within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_list dw_list
dw_list2 dw_list2
dw_main dw_main
gb_2 gb_2
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tabpage_3 from userobject within tab_1
end type
type dw_print2 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_print2 dw_print2
end type
type tab_1 from tab within w_hst102i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_1 from u_tab within w_hst102i
end type
type gb_1 from groupbox within w_hst102i
end type
type gb_3 from groupbox within w_hst102i
end type
type rb_2 from radiobutton within w_hst102i
end type
type rb_1 from radiobutton within w_hst102i
end type
end forward

global type w_hst102i from w_msheet
integer height = 2616
sle_code1 sle_code1
st_4 st_4
sle_name2 sle_name2
st_3 st_3
sle_name sle_name
st_2 st_2
sle_code sle_code
st_1 st_1
tab_1 tab_1
uo_1 uo_1
gb_1 gb_1
gb_3 gb_3
rb_2 rb_2
rb_1 rb_1
end type
global w_hst102i w_hst102i

type variables
int ii_tab
datawindowchild idw_child
end variables

on w_hst102i.create
int iCurrent
call super::create
this.sle_code1=create sle_code1
this.st_4=create st_4
this.sle_name2=create sle_name2
this.st_3=create st_3
this.sle_name=create sle_name
this.st_2=create st_2
this.sle_code=create sle_code
this.st_1=create st_1
this.tab_1=create tab_1
this.uo_1=create uo_1
this.gb_1=create gb_1
this.gb_3=create gb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_code1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.sle_name2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.sle_name
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_code
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.tab_1
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.rb_2
this.Control[iCurrent+14]=this.rb_1
end on

on w_hst102i.destroy
call super::destroy
destroy(this.sle_code1)
destroy(this.st_4)
destroy(this.sle_name2)
destroy(this.st_3)
destroy(this.sle_name)
destroy(this.st_2)
destroy(this.sle_code)
destroy(this.st_1)
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.rb_2)
destroy(this.rb_1)
end on

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
string ls_item_code, ls_item_name, ls_item_name2, ls_item_no
ls_item_code = trim(sle_code.text) + '%'
ls_item_name = trim(sle_name.text) + '%'
ls_item_name2 = trim(sle_name2.text) + '%'
ls_item_no    = trim(sle_code1.text) + '%'
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt, ll_tab
ll_tab = tab_1.selectedtab

CHOOSE CASE ll_tab
	CASE 1	
        tab_1.tabpage_1.dw_list.SetReDraw(FALSE)
        ll_RowCnt = tab_1.tabpage_1.dw_list.retrieve( ls_item_code, ls_item_name, '%')
        tab_1.tabpage_1.dw_list.SetReDraw(TRUE)

        IF ls_item_name2 <> '%' THEN
           tab_1.tabpage_1.dw_list2.SetReDraw(FALSE)
           ll_RowCnt = tab_1.tabpage_1.dw_list2.retrieve('%',ls_item_name2)
           tab_1.tabpage_1.dw_list2.SetReDraw(TRUE)
        END IF
   CASE 2
        tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
        ll_RowCnt = tab_1.tabpage_2.dw_print.retrieve(ls_item_code, ls_item_name)
        tab_1.tabpage_2.dw_print.SetReDraw(TRUE)
	CASE 3
        tab_1.tabpage_3.dw_print2.SetReDraw(FALSE)
        ll_RowCnt = tab_1.tabpage_3.dw_print2.retrieve(ls_item_no, ls_item_name2)
        tab_1.tabpage_3.dw_print2.SetReDraw(TRUE)

END CHOOSE
///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('I',TRUE)
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('I',TRUE)
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF
return 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 거래처관리.
//	작 성 인 : 
//	작성일자 : 2002.03
//	변 경 인 : 
//	변경일자 : 
// 변경사유 : 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
/////////////////////////////////////////////////////////////////////////////////////////
DataWindow	idw_name
idw_name = tab_1.tabpage_1.dw_main

datawindowchild ldw_child
f_childretrieve(idw_name,"item_class","item_class")           // 품목구분 
//f_childretrieve(idw_name,"nation_code","kukjuk_code")         // 국가코드

idw_name.getchild("nation_code", ldw_child)
ldw_child.settransobject(sqlca)
ldw_child.setsort("fname")
ldw_child.retrieve("kukjuk_code")

func.of_design_dw(idw_name)
idw_name.settransobject(sqlca)
idw_name.insertrow(0)

f_childretrieve(tab_1.tabpage_2.dw_print,"item_class","item_class")      //물품구분
/////////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화
/////////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()
/////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_print;call super::ue_print;// //////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 자료출력
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//ii_tab = tab_1.SelectedTab
//
//CHOOSE CASE ii_tab
//	CASE 2
//		IF tab_1.tabpage_2.dw_print.rowcount() <> 0 THEN
//			f_print(tab_1.tabpage_2.dw_print)
//		END IF
//	CASE 3
//		IF tab_1.tabpage_3.dw_print2.rowcount() <> 0 THEN
//			f_print(tab_1.tabpage_3.dw_print2)
//		END IF
//END CHOOSE
//
////////////////////////////////////////////////////////////////////////////////////////////
//// END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
//
end event

event ue_insert;call super::ue_insert;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_insert
//	기 능 설 명: 자료추가 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 입력조건체크
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료추가
///////////////////////////////////////////////////////////////////////////////////////
Long	ll_GetRow
long  ll_fr_date, li_idx
//ll_GetRow = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_new()
 tab_1.tabpage_1.dw_main.Reset()
	ll_GetRow =  tab_1.tabpage_1.dw_main.InsertRow(0)
	 tab_1.tabpage_1.dw_main.ScrollToRow(ll_GetRow)
	 tab_1.tabpage_1.dw_main.SetRow(ll_GetRow)
	 tab_1.tabpage_1.dw_main.SetFocus()


///////////////////////////////////////////////////////////////////////////////////////
// 3. 디폴티값 셋팅
///////////////////////////////////////////////////////////////////////////////////////

string ls_item_middle, ls_item_no = ''
Long  ll_item_no
DataWindow  dw_name, dw_middname 
dw_name = tab_1.tabpage_1.dw_main
dw_middname = tab_1.tabpage_1.dw_list2

IF dw_middname.rowcount() = 0 THEN
   dw_name.object.item_middle[tab_1.tabpage_1.dw_main.getrow()] = tab_1.tabpage_1.dw_list.object.item_middle[tab_1.tabpage_1.dw_list.getrow()]
	dw_name.object.item_small[tab_1.tabpage_1.dw_main.getrow()] = '001'
	
	tab_1.tabpage_1.dw_main.object.item_no[tab_1.tabpage_1.dw_main.getrow()] = dw_name.object.item_middle[tab_1.tabpage_1.dw_main.getrow()] + '001'
ELSE
	dw_name.object.item_middle[tab_1.tabpage_1.dw_main.getrow()] = tab_1.tabpage_1.dw_list2.object.item_middle[tab_1.tabpage_1.dw_list2.getrow()]	
	ls_item_middle = tab_1.tabpage_1.dw_list2.object.item_middle[tab_1.tabpage_1.dw_list2.getrow()]				
		SELECT NVL(MAX(ITEM_NO),'0')
		INTO :ls_item_no
		FROM STDB.HST004M
		WHERE SUBSTR(ITEM_NO,1,4) = :ls_item_middle   ;
		
		   IF ls_item_no = '0' THEN 
				ls_item_no  = ls_item_middle + '001'				   
			ELSE
				ls_item_no  = ls_item_middle + string(long(right(ls_item_no,3)) + 1,'000')
			END IF							
				
    dw_name.object.item_no[1] = ls_item_no
	 dw_name.object.item_middle[1] = left(ls_item_no,4)
	 dw_name.object.item_small[1] = right(ls_item_no,3)
				
END IF	
///////////////////////////////////////////////////////////////////////////////////////
// 4. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
//			사용하지 안을경우는 커맨트 처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_main.SetItemStatus(ll_GetRow,0,Primary!,NotModified!)

///////////////////////////////////////////////////////////////////////////////////////
// 5. 메세지처리, 고정버튼 활성화/비활성화, 데이타원도우로 포커스이동 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 추가되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
tab_1.tabpage_1.dw_main.Setfocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////


end event

event ue_save;call super::ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////

IF tab_1.tabpage_1.dw_main.AcceptText() = -1 THEN
	tab_1.tabpage_1.dw_main.SetFocus()
	RETURN -1
END IF
IF tab_1.tabpage_1.dw_main.ModifiedCount() + &
	tab_1.tabpage_1.dw_main.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_NotNullCol[]

ls_NotNullCol[1] = 'item_no/품목코드'
ls_NotNullCol[2] = 'item_class/품목구분'
ls_NotNullCol[3] = 'item_small/소분류'
ls_NotNullCol[4] = 'item_name/품목명'
IF f_chk_null(tab_1.tabpage_1.dw_main,ls_NotNullCol) = -1 THEN RETURN -1

///////////////////////////////////////////////////////////////////////////////////////
// 3. 저장처리전 체크사항 기술
///////////////////////////////////////////////////////////////////////////////////////
DwItemStatus ldis_Status
Long		ll_Row				//변경된 행
DateTime	ldt_WorkDate		//등록일자
String	ls_Worker			//등록자
String	ls_IPAddr			//등록단말기
DateTime	ldt_JOB_Date		//등록일자
String	ls_JOB_UID		//등록자
String	ls_JOB_ADD			//등록단말기

ll_Row = tab_1.tabpage_1.dw_main.GetNextModified(0,primary!)
IF ll_Row > 0 THEN
	ldt_WorkDate  = f_sysdate()						//등록일자
	ls_Worker     = gstru_uid_uname.uid				//등록자
	ls_IPAddr     = gstru_uid_uname.address		//등록단말기
	ldt_JOB_Date  =f_sysdatE()                   //등록일자
   ls_JOB_UID	  =gstru_uid_uname.uid	         //등록자
   ls_JOB_ADD	  =gstru_uid_uname.address		   //등록단말기
END IF
DO WHILE ll_Row > 0
	////////////////////////////////////////////////////////////////////////////////////
	// 3.1 수정항목 처리
	////////////////////////////////////////////////////////////////////////////////////
	tab_1.tabpage_1.dw_main.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
	tab_1.tabpage_1.dw_main.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
	tab_1.tabpage_1.dw_main.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
	tab_1.tabpage_1.dw_main.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
	tab_1.tabpage_1.dw_main.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
	tab_1.tabpage_1.dw_main.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자
	
	ll_Row = tab_1.tabpage_1.dw_main.GetNextModified(ll_Row,primary!)
LOOP

///////////////////////////////////////////////////////////////////////////////////////
// 5. 자료저장처리
///////////////////////////////////////////////////////////////////////////////////////
//IF NOT tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_save() THEN RETURN -1
IF tab_1.tabpage_1.dw_main.UPDATE() = 1 THEN
	COMMIT USING SQLCA;
//	RETURN 1
ELSE
	ROLLBACK USING SQLCA;
	RETURN -1
END IF



///////////////////////////////////////////////////////////////////////////////////////
// 5_1. 자료저장후 리스트 출력
///////////////////////////////////////////////////////////////////////////////////////
triggerevent('ue_retrieve')

///////////////////////////////////////////////////////////////////////////////////////
// 6. 메세지 처리, 고정버튼 활성화/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
tab_1.tabpage_1.dw_main.SetFocus()

RETURN 1
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////
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
Long		ll_GetRow

//IF tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
			ll_GetRow = tab_1.tabpage_1.dw_main.GetRow()
//	IF NOT tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
//			ll_GetRow = tab_1.tabpage_1.dw_main.GetSelectedRow(0)
IF ll_GetRow = 0 THEN RETURN

///////////////////////////////////////////////////////////////////////////////////////
// 2. 삭제메세지 처리.
//		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Msg
Long		ll_DeleteCnt
///////////////////////////////////////////////////////////////////////////////////////
// 3. 삭제처리.
///////////////////////////////////////////////////////////////////////////////////////
//ll_DeleteCnt = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_delete(ls_Msg)
IF tab_1.tabpage_1.dw_main.GetItemStatus(ll_GetRow,0,Primary!) <> New! THEN
		IF MessageBox('확인','자료를 삭제하시겠습니까?~r~n'+ls_Msg,&
									Question!,YesNo!,2) = 2 THEN
			RETURN 
		END IF
	END IF
	
//	THIS.SelectRow(0,FALSE)
//	ll_NextSelectRow = ll_GetRow + 1
//	THIS.ScrollToRow(ll_NextSelectRow)
//	THIS.SetRedraw(TRUE)

	tab_1.tabpage_1.dw_main.DeleteRow(ll_GetRow)
	ll_DeleteCnt =  1



IF ll_DeleteCnt > 0 THEN
	wf_SetMsg('자료가 삭제되었습니다.')
	IF tab_1.tabpage_1.dw_main.rowcount() > 0 THEN
//		wf_SetMenu('R',FALSE)
//		wf_SetMenu('I',TRUE)
//		wf_SetMenu('D',TRUE)
//		wf_SetMenu('S',TRUE)
	ELSE
//		wf_SetMenu('R',FALSE)
//		wf_SetMenu('I',TRUE)
//		wf_SetMenu('D',FALSE)
//		wf_SetMenu('S',TRUE)
	END IF
END IF

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
///////////////////////////////////////////////////////////////////////////////////

end event

event closequery;call super::closequery;integer li_rc

tab_1.tabpage_1.dw_main.AcceptText()

IF tab_1.tabpage_1.dw_main.DeletedCount() +& 
   tab_1.tabpage_1.dw_main.ModifiedCount() > 0 THEN
   li_rc = MessageBox("Closing", "변경된 내용이 있습니다..! 종료하시겠습니까?", Question!, YesNo!, 2)
	IF li_rc = 1 THEN // Yes 선택
		RETURN 0
	ELSEIF li_rc = 2 THEN // No 선택
		RETURN 1
	END IF
ELSE
	RETURN 0
END IF
end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_2.dw_print.Reset()

tab_1.tabpage_2.dw_print.Object.DataWindow.Zoom = 100
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print

tab_1.tabpage_3.dw_print2.Object.DataWindow.Zoom = 100
tab_1.tabpage_3.dw_print2.Object.DataWindow.Print.Preview = 'YES'
///////////////////////////////////////////////////////////////////////////////////////
// 2. 메뉴버튼 초기모드상태로 수정, 메세지처리, 포커스이동
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_retrieve()
//wf_SetMenu('R',TRUE) // 조회버튼 황성화
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

type ln_templeft from w_msheet`ln_templeft within w_hst102i
end type

type ln_tempright from w_msheet`ln_tempright within w_hst102i
end type

type ln_temptop from w_msheet`ln_temptop within w_hst102i
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hst102i
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hst102i
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hst102i
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hst102i
end type

type uc_insert from w_msheet`uc_insert within w_hst102i
end type

type uc_delete from w_msheet`uc_delete within w_hst102i
end type

type uc_save from w_msheet`uc_save within w_hst102i
end type

type uc_excel from w_msheet`uc_excel within w_hst102i
end type

type uc_print from w_msheet`uc_print within w_hst102i
end type

type st_line1 from w_msheet`st_line1 within w_hst102i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hst102i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hst102i
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hst102i
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hst102i
end type

type sle_code1 from singlelineedit within w_hst102i
integer x = 2601
integer y = 212
integer width = 457
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 7
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_hst102i
integer x = 2336
integer y = 236
integer width = 265
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "품목코드"
boolean focusrectangle = false
end type

type sle_name2 from singlelineedit within w_hst102i
integer x = 3383
integer y = 212
integer width = 617
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;f_pro_toggle('k',handle(parent))
end event

type st_3 from statictext within w_hst102i
integer x = 3191
integer y = 236
integer width = 224
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "품목명"
boolean focusrectangle = false
end type

type sle_name from singlelineedit within w_hst102i
integer x = 1143
integer y = 204
integer width = 457
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event constructor;f_pro_toggle('k',handle(parent))
end event

type st_2 from statictext within w_hst102i
integer x = 882
integer y = 228
integer width = 334
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "중분류명"
boolean focusrectangle = false
end type

type sle_code from singlelineedit within w_hst102i
integer x = 329
integer y = 204
integer width = 457
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_hst102i
integer x = 133
integer y = 228
integer width = 192
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "중분류"
boolean focusrectangle = false
end type

type tab_1 from tab within w_hst102i
event create ( )
event destroy ( )
integer x = 59
integer y = 392
integer width = 4384
integer height = 1896
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;Choose case newindex
	Case 1, 2
		idw_print = tab_1.tabpage_2.dw_print
	Case 3
		idw_print = tab_1.tabpage_3.dw_print2
End Choose
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1776
string text = "품목코드관리"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list dw_list
dw_list2 dw_list2
dw_main dw_main
gb_2 gb_2
end type

on tabpage_1.create
this.dw_list=create dw_list
this.dw_list2=create dw_list2
this.dw_main=create dw_main
this.gb_2=create gb_2
this.Control[]={this.dw_list,&
this.dw_list2,&
this.dw_main,&
this.gb_2}
end on

on tabpage_1.destroy
destroy(this.dw_list)
destroy(this.dw_list2)
destroy(this.dw_main)
destroy(this.gb_2)
end on

type dw_list from uo_dwgrid within tabpage_1
integer y = 8
integer width = 2427
integer height = 1768
integer taborder = 40
boolean titlebar = true
string title = "중분류 리스트"
string dataobject = "d_hst102i_1"
end type

event rowfocuschanging;call super::rowfocuschanging;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
///////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
ll_GetRow = newrow
IF ll_GetRow = 0 THEN RETURN
ll_RowCnt = THIS.RowCount()
IF ll_RowCnt = 0 THEN
	RETURN
END IF

//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
string ls_item_middle, ls_item_name
ls_item_middle = tab_1.tabpage_1.dw_list.object.item_middle[ll_GetRow]
ls_item_name = '%'
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

tab_1.tabpage_1.dw_list2.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_list2.retrieve( ls_item_middle, ls_item_name) 
tab_1.tabpage_1.dw_list2.SetReDraw(TRUE)

//tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
//ll_RowCnt = tab_1.tabpage_2.dw_print.retrieve( ls_item_middle) 
//tab_1.tabpage_2.dw_print.SetReDraw(TRUE)
///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////

//
//this.selectrow( 0, false )
//this.selectrow( currentrow, true )
//
//long ll_row
//string ls_item_middle
//
//idw_name = tab_sheet.tabpage_sheet01.dw_list1
//
//idw_name.accepttext()
//
//IF currentrow <> 0 THEN
//
//   ls_item_middle = idw_name.object.item_middle[currentrow] + '%'
//
//	IF tab_sheet.tabpage_sheet01.dw_list2.retrieve( ls_item_middle ) <> 0 THEN 
//
//		tab_sheet.tabpage_sheet01.dw_list2.trigger event rowfocuschanged(1) 
//		
//	   //wf_insert()
//		
//		//tab_sheet.tabpage_sheet01.dw_list2.setrow(1)
//		//tab_sheet.tabpage_sheet01.dw_list2.trigger event rowfocuschanged(1) 
//		
//	END IF	
//END IF


end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_list2 from uo_dwgrid within tabpage_1
integer x = 2437
integer y = 8
integer width = 1911
integer height = 752
integer taborder = 50
boolean titlebar = true
string title = "품목조회내용"
string dataobject = "d_hst102i_2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanging;call super::rowfocuschanging;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
///////////////////////////////////////////////////////////////////////////////////////////
Long		ll_GetRow
Long		ll_RowCnt
ll_GetRow = newrow
IF ll_GetRow = 0 THEN RETURN
ll_RowCnt = THIS.RowCount()
IF ll_RowCnt = 0 THEN
	RETURN
END IF

//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
string ls_item_no, ls_item_name
ls_item_no = tab_1.tabpage_1.dw_list2.object.item_no[ll_GetRow]
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')

tab_1.tabpage_1.dw_main.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_main.retrieve( ls_item_no) 
tab_1.tabpage_1.dw_main.SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	wf_SetMenu('D',FALSE)
//	wf_SetMenu('S',FALSE)
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	wf_SetMenu('D',TRUE)
//	wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	
	ls_item_name = tab_1.tabpage_1.dw_list2.object.item_name[ll_GetRow]
	sle_name2.text = ls_item_name
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_main from uo_dwfree within tabpage_1
integer x = 2519
integer y = 824
integer width = 1733
integer height = 924
integer taborder = 21
string dataobject = "d_hst102i_3"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
IF dwo.name = "item_small" THEN
	
	IF len(data) <> 3 THEN
		messagebox("확인","소분류 코드를 3자리로 입력하세요")
		RETURN 1
	END IF
	
	this.object.item_no[1] = left(this.object.item_no[1],4) + data		
	
END IF
end event

event itemerror;call super::itemerror;RETURN 1
end event

event constructor;call super::constructor;settransobject(sqlca)
end event

type gb_2 from groupbox within tabpage_1
integer x = 2446
integer y = 764
integer width = 1906
integer height = 1012
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "품목입력 내용"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1776
string text = "품목리스트 출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from datawindow within tabpage_2
integer width = 4343
integer height = 1772
integer taborder = 60
string title = "none"
string dataobject = "d_hst102i_4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1776
string text = "품목 규격 리스트"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print2 dw_print2
end type

on tabpage_3.create
this.dw_print2=create dw_print2
this.Control[]={this.dw_print2}
end on

on tabpage_3.destroy
destroy(this.dw_print2)
end on

type dw_print2 from datawindow within tabpage_3
integer x = 9
integer y = 16
integer width = 4329
integer height = 1760
integer taborder = 60
string title = "none"
string dataobject = "d_hst102i_10"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type uo_1 from u_tab within w_hst102i
event destroy ( )
integer x = 1577
integer y = 360
integer height = 148
integer taborder = 200
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type gb_1 from groupbox within w_hst102i
integer x = 50
integer y = 128
integer width = 2167
integer height = 228
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건(중분류)"
end type

type gb_3 from groupbox within w_hst102i
integer x = 2222
integer y = 128
integer width = 2213
integer height = 228
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건(품목)"
end type

type rb_2 from radiobutton within w_hst102i
integer x = 3963
integer y = 356
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
string text = "모델리스트"
end type

event clicked;
tab_1.tabpage_3.dw_print2.dataobject = 'd_hst102i_20'                 // 사용장소별 
tab_1.tabpage_3.dw_print2.settransobject(sqlca)
tab_1.tabpage_3.dw_print2.Object.DataWindow.Print.Preview = 'YES'
end event

type rb_1 from radiobutton within w_hst102i
integer x = 3506
integer y = 356
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
string text = "규격리스트"
boolean checked = true
end type

event clicked;
tab_1.tabpage_3.dw_print2.dataobject = 'd_hst102i_10'                 // 사용장소별 
tab_1.tabpage_3.dw_print2.settransobject(sqlca)
tab_1.tabpage_3.dw_print2.Object.DataWindow.Print.Preview = 'YES'
end event

